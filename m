Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3328606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 10:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LHdOCt/0;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=pAR/p+4y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKCPk-0001Au-Dn; Fri, 23 Oct 2026 06:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xKCPi-0001AX-5T
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 06:22:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xKCPg-0004fi-EJ
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 06:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792750935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IWr4ksYU3AAVotqup6dpLZCQ5qwAwPFw5Y0CceDI3H0=;
 b=LHdOCt/0MUB4bZjV1R7pjx/97IrQ0YLOyoU0rFat2DiDmmlHNenXmLQFDtaL+xsXCiDiXX
 Mq8woblugiobPysoqLWC4tTWJjLe9EnwbqonClxvE1UZrirv7BhYOidbbfyLtXQZPevgOx
 tsWO4Fepzdxw/ilimNeZ5yc1j3fSMlk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-0meoTtVqNFG7TskqlAr9oA-1; Fri, 23 Oct 2026 06:22:14 -0400
X-MC-Unique: 0meoTtVqNFG7TskqlAr9oA-1
X-Mimecast-MFC-AGG-ID: 0meoTtVqNFG7TskqlAr9oA_1792750933
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48e1ad3cb66so408155f8f.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 03:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792750933; x=1793355733; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IWr4ksYU3AAVotqup6dpLZCQ5qwAwPFw5Y0CceDI3H0=;
 b=pAR/p+4yTvH2cBa/5QVopdE3jMJ7/QN1eMFY4uII/Drb1xN5q18+XE0qz11V4y/5u8
 hUlG1wcmg3drcMV2xSZ9Y24jret+zmppxIsmeGF7MNB28xR4BYISWAg7Mpe8mu4JoRKW
 j5QMF/Bhj7i7V5422dTWQFiv0ks8pWQqlN0DUMCABsGjqk/Pa+zBIXy2oI89S7SPaVMN
 mfhluBCoA3iuLjY5wN1Bc+2oU4tZDZLZidgeGiJKwbv28HRMn++CuJ9wzcI89hJZL+kG
 EdCNL5eZwe3DD3n8pX9fPeHZg1BOrFDG0JlQaMMo2HRf7sVzloQo999n9uZwN+CGdGEL
 qY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792750933; x=1793355733;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IWr4ksYU3AAVotqup6dpLZCQ5qwAwPFw5Y0CceDI3H0=;
 b=tizW61c6pfq1iJ6cNi+azD602IUM0MXNrXsOCCyJfUXq1E0pjv4YslbCC7vDNnPRg1
 el6cmH1xPRDFSqyXvj81BnZM56J3As3boei3++o5kYMnryYjnw864kJ3xlBZLX+ziOAt
 FlARIic4y+MNM7JdHMERJq/kPQ2/mAAoxChj911E/L3AWTmuJ5KnU4qaybCW4DbsVIYS
 88yhTXPzms5DDBhQxhjlsKBS+16QDa6KxVaJcXI86g9MHtkRANWC711KTjkxqVQI983c
 Fif5opIjZaEwdeF4r8W9Y97NtunkBKZitByzoqwPz3nlpz+zpAvyMHxKV8RaOCl0hDwv
 //4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxd2wrTf3/EH9Ww6ntFYdvOmBnMMMAdHRjZf7N/11f6xbNJ/v47FqxyMYqNOMTdsgMeFGRmCbslXRqt@nongnu.org
X-Gm-Message-State: AFq9FYIzi9CWXxrkk1IuD+Ufu8Oh2Sodhrz57uyp8pKx6VDCL3zwBYaH
 tTtKCuaQ4Yvm+TlayrL6mAUebuXRVHML1GyvEmVbB945lxcNwp6TmPutWMpnhABtYFo7qZmjXDf
 ArSUtTNRWnKv+/WDVGnr38lDdEpqIACFvAk0tPD0Ik492oWF+beqAQE1T
X-Gm-Gg: AYBFou3ANU9bZ+u2q4MEeyYzYUJTIaBPdhYewLChJ4+RNCZq2E1Yeox44uHWLTG7WdH
 kAkq9Aj+HOSMVDXg0unJY6rmaJsvFquAn1j9uQF8eyUgfRK6/9HcYwqp8QvcltnNLXNYpJmyS69
 jxdfNjJDrRTh2MYgDVL6VqhQ+RUbORIyzJjRQxIWRE158qgsSRjlt0vnLk6JGmgRZEMKo4x90vB
 O2mOt4wz4mGwInlx6ANFy7dz19GLASqhZnHpNrkYp0xT+d5Cg9wjThPpa7RIWkAtUZqhSrpF9gd
 rVb0FlLfAEyIIo54KYYw/BfZ+YIYzunffu4bV1JMtktnhFiJEUeaDtPcwX1M3w==
X-Received: by 2002:a05:6000:2310:b0:48b:f93:3b87 with SMTP id
 ffacd0b85a97d-48e3859ce44mr2921969f8f.30.1792750933164; 
 Fri, 23 Oct 2026 03:22:13 -0700 (PDT)
X-Received: by 2002:a05:6000:2310:b0:48b:f93:3b87 with SMTP id
 ffacd0b85a97d-48e3859ce44mr2921948f8f.30.1792750932850; 
 Fri, 23 Oct 2026 03:22:12 -0700 (PDT)
Received: from localhost ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38025e0esm4300291f8f.11.2026.10.23.03.22.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 03:22:12 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Oct 2026 12:22:11 +0200
Message-Id: <DMC560EFHM9D.1HX2E0YM5X8RM@redhat.com>
Cc: "Brian Cain" <brian.cain@oss.qualcomm.com>, "Pierrick Bouvier"
 <pierrick.bouvier@oss.qualcomm.com>,
 <qemu-devel-bounces+tcalifano=redhat.com@nongnu.org>
Subject: Re: [PATCH] hw/intc/hex-l2vic: avoid shift into sign bit
From: "Tommaso Califano" <tcalifano@redhat.com>
To: "Peter Maydell" <peter.maydell@linaro.org>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.22.0
References: <20261023084624.1063258-1-peter.maydell@linaro.org>
In-Reply-To: <20261023084624.1063258-1-peter.maydell@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=tcalifano@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri Oct 23, 2026 at 10:46 AM CEST, Peter Maydell wrote:
> In fastl2vic_write() we do:
>    val =3D 1 << (irq % 32);
>
> Because '1' is a signed integer, this can shift into the sign
> bit of 'int'; the cast to uint64_t to assign to 'val' then
> results in all the high bits being set. This happens to cause
> no visible problems because l2vic_write never looks at those
> bits, but it's obviously not intended. Use 1ULL so that we
> do the shift as 64 bits unsigned.
>
> Resolves: Coverity CID 1685261
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/hex-l2vic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/intc/hex-l2vic.c b/hw/intc/hex-l2vic.c
> index 736f1be3b1d..89b44200928 100644
> --- a/hw/intc/hex-l2vic.c
> +++ b/hw/intc/hex-l2vic.c
> @@ -381,7 +381,7 @@ static void fastl2vic_write(void *opaque, hwaddr offs=
et, uint64_t val,
>          uint32_t cmd =3D (val >> 16) & 0x3;
>          uint32_t irq =3D val & 0x3ff;
>          uint32_t slice =3D (irq / 32) * 4;
> -        val =3D 1 << (irq % 32);
> +        val =3D 1ULL << (irq % 32);
> =20
>          if (cmd =3D=3D FASTL2VIC_ENABLE) {
>              l2vic_write(opaque, L2VIC_INT_ENABLE_SETn + slice, val, size=
);


Not an expert, but LGTM.

Reviewed-by: Tommaso Califano <tcalifano@redhat.com>

Regards,
Tommaso


