Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB017C5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wutXa-0002Z8-L7; Fri, 14 Aug 2026 11:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wutXW-0002Yi-Ui; Fri, 14 Aug 2026 11:09:46 -0400
Received: from fhigh-a3-smtp.messagingengine.com ([103.168.172.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wutXU-0000zQ-9B; Fri, 14 Aug 2026 11:09:46 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 8BE6114000DA;
 Fri, 14 Aug 2026 11:09:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Fri, 14 Aug 2026 11:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786720181; x=1786806581; bh=BhuZxPfXMqwNoilE6VOXt5ocaXoNt3jZ
 3levfHFYTCk=; b=zIcaBI944AB9ORQ/N4G6ncYK5QGY6/Sjas9XjkdwlWNsetX0
 x4mFKK8sVxFwCCUZsYIyrGJpBy4c/h7WyaFEvzh7mSZLNdDW9693uZkjP3thjy78
 AaHU74bxjHfXZuwJ1eCn5l8pWtQjilOcE2+wDGSvc6paJUqrk1KP9J8w2cGU4QCQ
 8xdb6HeqV83FMF+QqOefivdcqHI7iAS3PB0/PthRvcJBeLQ4DVBlb1aPzoO3LrnC
 tvdyIpjpxGs+wNaHPmAkM6CDYZJzOdDZf/q9qiv6wg4oGYTowl97ApgdWtNwh/OB
 9fJE6sVo7J413yv78y28C4H9t2QgIY0P4IrJRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786720181; x=
 1786806581; bh=BhuZxPfXMqwNoilE6VOXt5ocaXoNt3jZ3levfHFYTCk=; b=m
 lS0aZ008F8im792n+EzFKa6uSRmCHK1fbGl3zekCJg4lHvoif+B1SR13bvnXmXTs
 qgf/U8QjiAt/Yd/A9E8cgaMEKDd4nEvJlkKjJ2owtravyNC8D/eRV2BIFkiK8dmG
 O6y7WT4F5994n6MPwKZ8xLw4caz31btOt9e92OBsJlWfesl6z5uFdO6CTuMwfgm4
 U57PiGXgj1WogtUwDMYEh/EEnmZynW5PoeFEB/iXdrH0kib/uHIOcZ125Ioxc3Iy
 7Zso1Ht7QRo5UQ+pIY4aLvSkHE3lCjYmFzn5cgllq4b2hBwkNfdI5tLuRaHznwDz
 8sHD2cHZ7HddzqdRA6Kmw==
X-ME-Sender: <xms:tC9_auqRitlvROXgOmB3YciP-IuqMDXKcOYPpmHXrZJdTrN9FqRACA>
 <xme:tC9_asOb7iwWrWfXHQTsrC30lyR8zOgq5dhpI52erVgpP49AailRbQ8B-7dBkwQkA
 gB9Q6EuWDeOp3fSQoDETnzNPtDthWfoHHac_sR3NkxNypulj95q>
X-ME-Received: <xmr:tC9_angXyRUcoteNUpUH6YfzyomwoWVYVRZHV4SRRYS254BbbLSfzrqrCT4dEBnA8dr0NA>
X-ME-Proxy-Cause: dmFkZTFi041px9O28KxGoIsMTDiV10DiQhDiGnZovfA+SuMgUI3gy5B7JkKsTRXO44QAjO
 LYt3HbipEpemjP0Wz3UF1NEeQG6BJ5wPUQINDnjfPMmOMmJ61ahfW2SGOHj6tye4Vu5gkD
 PTIBQrjykuQ5bctOPQwBYCIYAiTQA4Flvqmm2AZsw/1LSSULT0QaRa21YKX7szzinJiZag
 nuJrD9J2kYApEuZB7mQf2t11lNQ9/1qItkVLxiOcbJms6RHF1yDuAUsUZRg9rILm4wAkFc
 1nb/WQ8YiHtNQOuaPiUWbRA422JBLvOifmI1zNVke89Z0hEpk079qBaLeMgWe3sb5jD0PK
 c0JXu2iHFNrJNNoTN6YtlsrNtJTauDFWVT8ii4J9DBiHPJuv0iYbKnj0hAFqhJMh/0ROgJ
 EXtZ++kfbTUuJK0kYZSAqMkWA6e2kGICEy/an+fOZOqBcKkQp1R5MXYUw9f6IHEQlbByq2
 SeVtwbQR2wXOTeHCQ2ZEVy/m+DDD/hNRTU7X80Zv+J/gKyLy5hANlKARZywjsGopf4XDvS
 eWDalbbjEjn2lDMo2q2NXGyA4tQpKlOY4kT4rzPTLFxfZBGvjQfXnhUSFBsav/knqVP0Uv
 hRo7fpuZDWjMH9/oQf/TmNx2PUFQ/pVcuUE0DSoHFUG9O8iQ+V5GbWNlUM4g
X-ME-Proxy: <xmx:tC9_agZONeVtlLEgoOCfy-wqf9ramlQZyrYW9BYXejd_VyUJV8YNDA>
 <xmx:tC9_argtD-Bpos34UhV1Ou-qOIoxVHL-1Db2CCGcYcQznj6oZhVPNw>
 <xmx:tC9_aibcXkZR7frHhtN_YyY4oUhI8LzGTeiRg9l-p2-hWxT8GXAkBg>
 <xmx:tC9_ahOA_MO0LalT9Nm8ukfx4eoNyTryIyZ6UmBnEKuDnSMha0-VnA>
 <xmx:tS9_ajZQvEYALxVTCcJbIIdXZZrsU6E9wSCq9Yp888mO-21SLlXH7UMG>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 11:09:39 -0400 (EDT)
Message-ID: <8004347514ec6b8f002d9f47189e97e17f42429f.camel@alistair23.me>
Subject: Re: [PATCH v3 1/3] hw/misc/k230_iomux: add Kendryte K230 IOMUX model
From: Alistair <alistair@alistair23.me>
To: Kangjie Huang <flamboyant.h.01@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Chao Liu <chao.liu@processmission.com>, Junze Cao
 <caojunze424@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, Daniel Henrique Barboza	
 <daniel.barboza@oss.qualcomm.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>,  Fabiano Rosas <farosas@suse.de>, Laurent
 Vivier <lvivier@redhat.com>
Date: Sat, 15 Aug 2026 01:09:39 +1000
In-Reply-To: <CAAW0U4ZRqfcNmWi8davsvu-zVFmq4fJgbjjESb+_As3vPnu7jQ@mail.gmail.com>
References: <20260813135717.2758-1-flamboyant.h.01@gmail.com>
 <20260813135717.2758-2-flamboyant.h.01@gmail.com>
 <CAAW0U4ZRqfcNmWi8davsvu-zVFmq4fJgbjjESb+_As3vPnu7jQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.154;
 envelope-from=alistair@alistair23.me; helo=fhigh-a3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 2026-08-14 at 11:17 +0800, Kangjie Huang wrote:
> Hi all
> Kangjie Huang <flamboyant.h.01@gmail.com> =E4=BA=8E2026=E5=B9=B48=E6=9C=
=8813=E6=97=A5=E5=91=A8=E5=9B=9B 21:58=E5=86=99=E9=81=93=EF=BC=9A
> >=20
> > Add a SysBus model for the 64 K230 Function IO configuration
> > registers documented by the K230 Technical Reference Manual.
> ......
> > Suggested-by: Alistair Francis <Alistair.Francis@wdc.com>
> > Suggested-by: Chao Liu <chao.liu@processmission.com>
> > Suggested-by: Junze Cao <caojunze424@gmail.com>
> > Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
> =C2=A0 Hi all,
> =C2=A0 Just to clarify, I added the Suggested-by tags for Alistair Franci=
s
> and
> =C2=A0 Junze Cao in this patch just based on their concrete suggestions
> during the
> =C2=A0 public review. Neither tag was explicitly provided by them. Sorry
> =C2=A0 for any confusion this may have caused.
>=20

Please don't add Suggested-by tags just for review comments. Generally
you would only add Suggested-by for new patches where the idea was
largely contributed by someone

Alistair

> =C2=A0 Thank you again for your suggestions.
>=20
> =C2=A0 Best regards,
> =C2=A0 Kangjie

