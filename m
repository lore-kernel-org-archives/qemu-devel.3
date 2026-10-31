Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECE1606A31C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=packetfive-com.20260707.gappssmtp.com header.i=@packetfive-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Yo16CHYK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN7qX-00025t-Om; Sat, 31 Oct 2026 08:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1xN7qR-00025L-KJ
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 08:05:59 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1xN7qP-0002X2-As
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 08:05:59 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so17282725e9.2
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 05:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=packetfive-com.20260707.gappssmtp.com; s=20260707; t=1793448354; x=1794053154;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=euFmJZlpwd6ICIruXg5JhUlleoHCe/XSYjJ01l2Of9s=;
 b=Yo16CHYKPqLI9Fr19ZW5iFh3WDHfAy5E8ed0JJcTjFC+xH8+pl1opm7K8m8aHj0NzG
 1CNGYqmhEYF8MBP+Zgvn5xc3H+JJY2uARDdi1QAwNLcfIpeAdwvcJyotCcVXuAktXM/o
 SCLab29HqWJPasHRdOs9UqgDehIirPA/vFNmzrlOUHKzCWIBNEd6x7D2uZHpwzlzUEL/
 4kQ8J41AVYOJo+wOp0qgkHrXMfzgNZWrPa/IJ7P6nPH3pekrIlQ67x7G2StehqQn7Ust
 5111jYhgE28+qf+cv4cfSkNRk1JpGFGIzEd+8es3pmXr0HG8Aoxc84iSJPwUckSfOpuZ
 MDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793448354; x=1794053154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=euFmJZlpwd6ICIruXg5JhUlleoHCe/XSYjJ01l2Of9s=;
 b=mEn/ZmxDAN52vO8cd+zf7c74q79Q3JvyaPfHcofJcO0+KuMrnV7iM6L4meP4lmsw6K
 FI1Kobrx69f2SCfx/lnY0xVCouxNQfkkMvbeCs4eZqmKn7ZdqEoZYypJINCgpegnIhfx
 bcF4zQ0zvz7lZaKa6S41E/o1aYf0xTEw9qAL4BxGl85NEOtfKhHGraUwFZeOicyrQnPH
 IrdGzW1MeXWWhgKzCWWEZuIfAiXAM0hqgh/AS6YzGvomYN9mAs155YhV6IE4jRvzV2Mk
 MiQFhQJI9mqCNm1xOHqQoi7KR9tpLbMLMjZ1ZqVKNx0F1qkdMUAfRbWlUWbPw8G4O4iV
 OrFw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxhZxxtpq7HuJu10BZXxAQCMpldMFYivrIMFAvsNydy85nIZaLEEOhRg6bYY9HysAtLMeWpYOeYvC0i@nongnu.org
X-Gm-Message-State: AFq9FYKoQLJY47T+9pr845f03f70XqsZAFcrkjouHLHAtYgfWY+nstlo
 D8cVxXWnivC0hbnKRCwDBPK7YoI7EQJdC74HVYYSO8EsFvi3/QXv0L9DNZ49eX8iwt4=
X-Gm-Gg: AYBFou29T50bs5k1MPlhREs0eFFDXKObn6ngEbLB2ClgANYvQwSgC7fhqUD/2SVjj8e
 sDM0dAD+dfPDj+uXY7XXV+cbr1X2TWvP8jaSGcJ/TwfSsyakdXeZQ2OVgV3wmdIQMlvRiEEmBTH
 /jk8/o6vg6mk/2+sIJdG7RC1dta/TpLtAuwtLmgefxcFGLSse++hAmFLg1ho+x4JxRUcB74CshN
 302EGES+YLhuX0qSA423CLdL6PcV15Hd2DW5X2hsr2hcyRfIDMjeIgt6eZ04OrFuF5W6ZSpYGo+
 IaITUhrGmbG7/gc4iXD0aPqhLw9yE4kqzkbJSS3WR6mgxu7JFmBVKfaeZx2MJsqQitXi0msc1eq
 REm6xBnFrFLtR94X1KlOhY7LQMO/+S2sDYvjTE+fBTYn8Pr4L9CABcvtvqftafxALPSw8hZuWFB
 R8QrrrISRhBpOpj9jHf6ZaF2S8zYuQKGnvgPyM8Qj4X42aLtIBS+IutapTTcmX1OuZuf5k+5rOz
 dpgKXNSR6sLrLqTJQRRKVHKtgvUgNmSi3e+DVZGApRtwktSN0MxBkxvcg4l8zmo+C3KuGXY9bNv
 O1c+roOa4S9LkZzK4W677UUebXMEx1U9LSCYh7iQ2Pd4qg==
X-Received: by 2002:a05:600c:4e48:b0:4a2:150f:1610 with SMTP id
 5b1f17b1804b1-4ac183d16eemr108375035e9.23.1793448353364; 
 Sat, 31 Oct 2026 05:05:53 -0700 (PDT)
Received: from node-dev.home ([2001:bb6:1895:f400:7a91:41fd:83ea:4c4b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa813d295csm202204745e9.7.2026.10.31.05.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 05:05:52 -0700 (PDT)
From: Weqaar Janjua <weqaar.janjua@packetfive.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Weqaar Janjua <weqaar.janjua@packetfive.com>, qemu-devel@nongnu.org,
 kraxel@redhat.com, peter.maydell@linaro.org,
 pierrick.bouvier@oss.qualcomm.com, jasowangio@gmail.com,
 pbonzini@redhat.com, farosas@suse.de, lvivier@redhat.com,
 marcel.apfelbaum@gmail.com, peterx@redhat.com, lizhijian@fujitsu.com,
 odaki@rsg.ci.i.u-tokyo.ac.jp
Subject: Re: [PATCH v3 0/6] hw: Add Cnuas virtual devices
Date: Sat, 31 Oct 2026 12:05:14 +0000
Message-ID: <20261031120516.2846639-1-weqaar.janjua@packetfive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030191556-mutt-send-email-mst@kernel.org>
References: <20260929202358.725310-1-weqaar.janjua@packetfive.com>
 <20261016153247.1815153-1-weqaar.janjua@packetfive.com>
 <20261027080746.2468700-1-weqaar.janjua@packetfive.com>
 <20261027063724-mutt-send-email-mst@kernel.org>
 <20261029115735.2716219-1-weqaar.janjua@packetfive.com>
 <20261029134859-mutt-send-email-mst@kernel.org>
 <20261029194227.2735464-1-weqaar.janjua@packetfive.com>
 <20261030191556-mutt-send-email-mst@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::32c;
 envelope-from=weqaar.janjua@packetfive.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 07:19:05PM -0400, Michael S. Tsirkin wrote:=0D
> I see. Then a simple way for you to get some eyes on this, and a path=0D
> towards upstreaming, could be to try and add this rdma functionality=0D
> in the virtio spec.=0D
> Interface changes might be required during the standardization=0D
> process.=0D
=0D
Thanks Michael, that is a helpful pointer.=0D
=0D
The intended use of the Cnuas emulated PCIe devices is the reason they=0D
were not designed as virtio devices.=0D
=0D
Cnuas is intended for teaching and research of Open Compute ORV3=0D
(and future versions as it evolves) rack-scale data center systems, where t=
he=0D
PCIe devices and their drivers are what is being studied. CnuasNIC and=0D
CnuasGPU are small, fully documented PCIe devices in the spirit of=0D
edu, but with production-like features such as configurable link speed and=
=0D
width, a 64-bit prefetchable BAR (CnuasGPU), and a switch transport=0D
that joins several guests into one fabric. Their guest drivers are=0D
full netdev and RDMA core drivers that run rping, perftest and QEMU=0D
RDMA migration unmodified. Just to clarify these aren't edu extensions =0D
because they are different PCI classes (network and co-processor), and =0D
edu's fixed register map is used by existing course material. My concern wi=
th=0D
virtio device is that it would hide the layer we want people to work with.=
=0D
=0D
Also, that in the ORV3 rack model, each sled carries its own NIC and accele=
rator=0D
as separate PCIe functions with their own driver, next to the virtio=0D
devices the guest uses for its disk and management network.=0D
=0D
I understand that a virtio-rdma device could definitely be useful in its ow=
n right, =0D
I am happy to look at it separately since the CnuasSwitch backend could ser=
ve =0D
both. If you are ok with it, for this series I would like to keep the devic=
es as =0D
they are, in the same spirit as the other QEMU-only devices in the 1b36 ran=
ge, and =0D
keep looking for a reviewer for patches 2 and 3 (Jason, Peter, Zhijian, Aki=
hiko, =0D
any of you?).=0D
=0D
Thanks,=0D
=0D
Weqaar=0D

