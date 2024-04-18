Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB47C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 08:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxMor-0008Gq-Rp; Thu, 18 Apr 2024 04:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rxMoq-0008GR-Fj
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 04:08:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rxMol-0005AL-PN
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 04:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713427706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jkl93earccohRsZfy8Bq8byUvMRjDs8r5QCezC1z+K4=;
 b=TZM9HQLcg0FYIGumrIBC+nV1BVCplJ18eC/s3C4qJzoN8eGTamxFfxTnPNb4REcXjaFnoH
 fUDLPNhMN2QYChf7ZNcQgeFN+oC2TZhshT89V8kuw72agIE1uV4mKGJig7DSTk0glLkHTq
 hFFH5eyzI+wSHiuGn4oxopx1lYp+n5Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-QnAFO0ZONGigvIbEMlpsUQ-1; Thu, 18 Apr 2024 04:08:22 -0400
X-MC-Unique: QnAFO0ZONGigvIbEMlpsUQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-349d779625eso465840f8f.2
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 01:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713427701; x=1714032501;
 h=in-reply-to:references:user-agent:from:subject:cc:to:message-id
 :date:content-transfer-encoding:mime-version:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jkl93earccohRsZfy8Bq8byUvMRjDs8r5QCezC1z+K4=;
 b=HsvmWrO5x6gNCyTqP9ZO8dUrzGgI1EG0/cvYtSqwctCmzE7getd2bAKE2Wu/0bNi6A
 986lS7meh5NWKitxlTgxzNrQ2H0W+Cny8zLqaCbe3aHPSrKBNNfBBVlPc2iq2v1VhEFe
 wY+Z+HI+6uUYpGHonEipG+sY9MhEqZnhOzkjFDsCCPB26BsMJ1SrLmQSrUg8IuSDZW00
 ksuHMqJUhhhqLyygmQ3HHoGert5SXOMoG6ISxNIbO7DGMEpd0liRwxOiOEtmxO1h7zDN
 /gtGfG4ir6nX+72IQam93jySdTKY9pemqYFWdIIpRRNpNxu0XLi1qxDy6YSkIplLIycG
 RE/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8TuF+TiVynGWyfCvvBaxXFj4kgRJx2g22HcE4n9Tet64e2T30EPGibrnEN0wVaYJnDKelULHUTFQoPejua5gFcdZP/o0=
X-Gm-Message-State: AOJu0Yzya5ox/rX1Lo4jGNWyce4TyCFYWiwlvwoX1zWHvBSjT7L7gq3P
 nowpVEI+eBIejrz20/oBAG9HJvTJI2P5DkysfTnftZ3WlQxwYuYfwl6UXXiPx9QCjxUHGWFOW0U
 JVl1mm54SUS+tKGC0TQnv9K6Kzx5ct6/R74sBcdVvAGvGK6KfxnYI
X-Received: by 2002:adf:e882:0:b0:343:7032:7283 with SMTP id
 d2-20020adfe882000000b0034370327283mr1374294wrm.8.1713427701584; 
 Thu, 18 Apr 2024 01:08:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrZtx7Px6SQOfXQxRkYUbfKeqekYPVmcqAEx7HYzoYPqm5XJ0eLx9zUyy60/IhXlbd6ZvemA==
X-Received: by 2002:adf:e882:0:b0:343:7032:7283 with SMTP id
 d2-20020adfe882000000b0034370327283mr1374274wrm.8.1713427701209; 
 Thu, 18 Apr 2024 01:08:21 -0700 (PDT)
Received: from localhost ([2a01:e0a:a9a:c460:2827:8723:3c60:c84a])
 by smtp.gmail.com with ESMTPSA id
 j6-20020adff006000000b00349856b640bsm1170729wro.67.2024.04.18.01.08.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 01:08:20 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Apr 2024 10:08:20 +0200
Message-Id: <D0N3FEXCT47P.1GGY1XRK5JZMO@fedora>
To: =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Cc: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <qemu-devel@nongnu.org>,
 <vchundur@redhat.com>, <rjarry@redhat.com>
Subject: Re: [PATCH v5 0/3] Add support for the RAPL MSRs series
From: "Anthony Harivel" <aharivel@redhat.com>
User-Agent: aerc/0.15.2-111-g39195000e213
References: <20240411121434.253353-1-aharivel@redhat.com>
 <ZiAFd5GMcQV1yZhU@redhat.com>
In-Reply-To: <ZiAFd5GMcQV1yZhU@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.719,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


Hi Daniel,

Daniel P. Berrang=C3=A9, Apr 17, 2024 at 19:23:
> On Thu, Apr 11, 2024 at 02:14:31PM +0200, Anthony Harivel wrote:
> > Dear maintainers,=20
> >=20
> > First of all, thank you very much for your review of my patch=20
> > [1].
> >=20
> > In this version (v5), I have attempted to address all the problems=20
> > addressed by Daniel during the last review. I've been more careful with=
=20
> > all the remarks made.
>
> I'm wondering if you had tips for testing this functionality ?
>
> Is there any nice app to run in the host/guest to report the
> power usage, to see that it is working as desired ?
>

Great question. Unfortunately, there isn't an easy-to-use,=20
out-of-the-box app that can assist you.

The 'cpupower' tool in linux/tools/power/ or 'turbostat' in=20
linux/tools/power/x86/ require some modifications as they fail the=20
sanity check inside a VM. It is on my agenda to work on a proposal patch=20
for these tools if the vmsr patch lands in QEMU. These are the excellent=20
apps that everyone should use IMO.

So how do I test my patch ?=20
I'm using a slightly more complex tool called Kepler [1]. Since a patch=20
that has been merged [2], it can also report VM consumption.
The installation is easy on RPM based distribution [3].
But indeed, this tools is a Prometheus exporter so you need=20
a Prometheus/Grafana stack for the observation which make the test more=20
complex than the 2 previous tools mentioned.

Last month, I conducted a test with Kepler tools on both a host and=20
within VMs. I was pleased to observe that the power graph trends were=20
identical both outside and inside the VMs, albeit with a slight=20
variation in terms of 1:1 Watt comparison.

If Kepler isn't the tool you're looking for, I'm open to any suggestions=20
regarding cpupower/turbostat. I can work on a temporary patch that would=20
enable us to utilize them.

Regards,
Anthony

[1]: https://sustainable-computing.io/
[2]: https://github.com/sustainable-computing-io/kepler/pull/931
[3]: https://sustainable-computing.io/installation/kepler-rpm/


