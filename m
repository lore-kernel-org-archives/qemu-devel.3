Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7739FC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whqsm-0000Kv-FB; Thu, 09 Jul 2026 11:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shankerwangmiao@gmail.com>)
 id 1whqsj-0000KU-C8
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 11:41:45 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shankerwangmiao@gmail.com>)
 id 1whqsh-0006mD-SD
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 11:41:45 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2ccdce28edeso3154515ad.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 08:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783611700; x=1784216500; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qyBm4ifVw5+VziTSVj7pFOIJyM7JbKRWBsywXabspfM=;
 b=G3Il5+DtFZBl9gbZz0btiI8RidM3FW7BpDBmvSkIUQRexAMIIZ7bDaTnBgvt0FLBLN
 eA86ohpO1gYqmZWsewAA+8fiGSYSPhx/JzTcwL7AwFpP1SchmiNexLpywTWfKyGd3WMg
 8Rt2YgjdUv5tlghOrWWZd1GkQqxDT+e1XWsGbyy1XqT90LHqz2Y8CtAcChRRDf9eEaYc
 30JOM74kzXvDluVosoqFZLkgaFu4aLBkDi4YN3KrrM7pxgvq4AYUBMqzPE32JzK/Tokn
 cua+ZKtCAAGPDZepvwCqFjYDUZKv592ATj8PAmI5CaBHVYW0Lo/2h9Q2uY+qiaF4Uxlu
 UCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783611700; x=1784216500;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qyBm4ifVw5+VziTSVj7pFOIJyM7JbKRWBsywXabspfM=;
 b=LWllZaGqlqstr3IIfszxVot2jj84mjvyJ+d1za2rdvtSWVkDDrmIZU3nHxxHM3fWds
 V8rY/kRm96Wr80Fe0+Y5jr4Ehqi9wxv/kY4wf0vpk2psjUL2rMC3chYUlVpXjxlpmRN7
 LhO93oRmIjBVuTSk+ZtzJpcdAkrCfLRc36JmxjfSoZKvQwomio0FmdxGVhGulLDLkO+e
 wFHILIzfUeFYu5yHipk3PYOE8Gzqu+51f6jGslAqu0RyhOsZKFhbL0wWunqyqCTO2bpM
 GAYrMl1SUDVKzlWo2PDD4xZ3jLdiH+rOMaK04D9yvtYYgCzD431zRKWGZJhu4X+++AQp
 ALpw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq9qgIwAjOSLOMa2ynok1Db3Zw6RdxnSUV2RrInujNB06R5V85iezEaNUXbMTZpSq3mZpLdEA/Nywwk@nongnu.org
X-Gm-Message-State: AOJu0Yzvo2B++B74I1SVJ2KmQUHMRlRCm+1WpEBC0G/fPunlcRkGLAVk
 u3xFPxF57nltX93TVHOxItLZYNjmi6WcyOENYuw4XkS784CDSp95XIws8/OA0YNf
X-Gm-Gg: AfdE7ckzDyLgfQUuG4a18hiAhibcC0WkS6CkoOTRMqy8VaVPx5zdNXIUcNF+K111bxF
 p5BKIJV67H3fvdO0GcWoz3VGVgzP5KwESyKhK5zYSMwZiEOrrAFBKe6zNuqnj6RCUnW4dD6MmDY
 HaTjLv9mFwSPkhfBA4U+gahZDbgtQmj5iT/JOl0uEF89D0hXimuj4bI+l8619n6YvRV57DxydS7
 /zWTMBLOR59Qu1TwmbH1ppr9vfkcNV6CtrqFevRU0BXxDmzyjfpfJZd6jxlTBWFiHxSrYFM9vjt
 FOEc5mHKFfeZVzOwzbShPLXRdTg6x7UpuPPNJphrgfqFeHp29gNOE7yRI3jZsvODr1cMgHLaNmG
 a0sUiKDE/qfTd3LRP/M5Q0lpHpN3Pbesps0vla7x+Sw6csxGQpyowAemG3L4flQ8kNqCjAeXvgC
 7CgGgLEPLvPvYNCIgOHPDYvcyjUiE5enqKuxA=
X-Received: by 2002:a17:902:e5c5:b0:2c6:b3d9:9bbd with SMTP id
 d9443c01a7336-2ccea4822d3mr55572195ad.8.1783611699994; 
 Thu, 09 Jul 2026 08:41:39 -0700 (PDT)
Received: from smtpclient.apple ([23.247.139.92])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bfe040sm46494945ad.31.2026.07.09.08.41.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Jul 2026 08:41:39 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] pvscsi: translate data endianness
From: Miao Wang <shankerwangmiao@gmail.com>
In-Reply-To: <CAFEAcA8Rx2MHUDXKAyr-4B_L7DxGEpOHtB=tfauTvfoqhkkPnQ@mail.gmail.com>
Date: Thu, 9 Jul 2026 23:41:24 +0800
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-s390x@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F04E93A5-9C6C-42AA-9097-838EF31C847D@gmail.com>
References: <20260605-pvscsi-endianness-v1-1-b0bf472b0f59@gmail.com>
 <273f53b8-9edc-4c0b-a793-d0667548553a@tls.msk.ru>
 <89089d8f-101c-4520-8031-e9522e2cbb1f@oss.qualcomm.com>
 <ACA8103D-AF3D-464A-900C-5448E29571DD@gmail.com>
 <CAFEAcA8Rx2MHUDXKAyr-4B_L7DxGEpOHtB=tfauTvfoqhkkPnQ@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=shankerwangmiao@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



> 2026=E5=B9=B47=E6=9C=889=E6=97=A5 23:06=EF=BC=8CPeter Maydell =
<peter.maydell@linaro.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, 9 Jul 2026 at 15:54, Miao Wang <shankerwangmiao@gmail.com> =
wrote:
>>=20
>> Hi,
>>=20
>>> 2026=E5=B9=B47=E6=9C=889=E6=97=A5 22:41=EF=BC=8CPhilippe =
Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> On 9/7/26 08:39, Michael Tokarev wrote:
>>>> On 05.06.2026 16:27, Miao Wang via B4 Relay wrote:
>>>>> From: Miao Wang <shankerwangmiao@gmail.com>
>>>>>=20
>>>>> This patch improves the implementation of the pvscsi device by
>>>>> translating the endianness of the data sent or received from the =
guest.
>>>>> This ensures pvscsi can work on big-endian hosts with =
little-endian
>>>>> guests.
>>>> Hi!
>>>> Can we pick this one up for 11.1 please?
>>>> I know right to nothing about s390x internals so can't really =
review
>>>> the change.  But the fix seems to work, and it should be picked up =
for
>>>> the stable qemu series too, it loks like.
>>>=20
>>> I tagged this for review and forgot. Basically we shouldn't using
>>> tswap*() anywhere in system emulation except semihosting. Here it
>>> seems reasonable to use cpu_to_le*()/le*_to_cpu().
>>=20
>> I have no idea why tswap* should not be used. Here the problem in
>> pvscsi is that the driver on the guest side is using the native
>> endianness of the guest CPU while for handling the values on the
>> host size, we need to convert it to host endianness. As a result,
>> what should be done is to convert from the target endianness to
>> the host endianness and vice versa, instead of converting from
>> a specific endianness to to host endianness.
>=20
> Right, but what is the spec of the device supposed to be?
> Generally speaking in real hardware devices don't have any
> way of knowing the endianness of the CPU, they're specified
> as "data is always little endian" or "data is always big endian".
> Sometimes paravirtual devices end up with "assumes guest
> endianness" baked into them, but this is usually a bad idea:
> the legacy virtio does this, but we fixed this in 1.0 virtio,
> which is always little endian.
>=20
> Do you have a pointer to the specification for this device?
> There's no URL in the source files.

Sadly, I do not have such specification and I strongly suspect=20
that neither does the designer of it, since it is designed to
be used with x86. In the source code of its driver in Linux,
it can be seen that the code is not endianness aware. However
in the Kconfig, the driver is limited to be compiled on X86.
As a result, there might be two possibilities:

- pvscsi is designed to use (guest) native endianness
- pvscsi is designed to use little endianness and since the
  linux driver limits itself to be used on X86, the author
  chose not to bother to ensure the correctness of the
  endianness

Cheers,

Miao Wang


