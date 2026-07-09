Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839AEC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 14:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whq8r-0004Ph-66; Thu, 09 Jul 2026 10:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shankerwangmiao@gmail.com>)
 id 1whq8p-0004PD-Mn
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 10:54:19 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shankerwangmiao@gmail.com>)
 id 1whq8n-0005yk-7e
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 10:54:19 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-84862aaa8bfso53280b3a.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 07:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783608855; x=1784213655; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZUZQ3TlwioJ2Q0YI4LedSkhZRP7eHwtvUx9GJC41xkg=;
 b=jaSzh7vxgYLNX0l+8FKzu8mhvRoUvsHwsAl8Ki3kNOUA32loGeLXbReQ7MMA8ATS8u
 OLRWDxYnTTKKpP13raTiTB6LNm7adMtx1CYVqFV8NDPN7zhZLB3DZJUfpM7n2jYGfe08
 yA9usjuO0YKHbr+XQuWeQLNutSY0Q1krOslz9rlRLNvV5BR4OBC2x9L/PAQzDxSeDdUz
 ifVXvWLI35V/h87PTYCYgldnZx2HVoI9Jgtgq+3SJ7kSusyl1RjvJddFLMhdN8JcLZel
 yzoSVETK2SnysQ5JQlvZ50V4kdi9JXRrMb5vjeA7vyv0etWME4RpkerePBlrxPVtJT8p
 4t6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783608855; x=1784213655;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZUZQ3TlwioJ2Q0YI4LedSkhZRP7eHwtvUx9GJC41xkg=;
 b=AWOxr8QztGZwAHewLQ+CYKyldUFbgC/lQY7pUjNlvzUVRmePy61oPtRhvFTFZYaw/D
 NISlAOCqog4JnBOzw3ZgkZUHK2Zyx8ZaL1/i20+JRY2NKlK6pxGBqmUY9yWRpE0dFxaX
 tBVrwfe1/ypUcDAoiQSMBzXSLDM57mV2m+sJ7jLUVvqXD9ETmWWKTft31Hu4W+tr38Xs
 MBfSYiI2F2X+rBNRn/zBFKKXRPfvstodpmKR43X0c8nMRw3JCe+9hYSVkbjIAVPQ8cpF
 gZ3Z2tCdKE5KextsGkUsPkhPnmw8xkuxE7eExEK4h/RkrHoFi8bbNMWpLDvdMHM8RryZ
 O6SQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5K9RxItfJQ8CLaoP6IVE7aZAlA3IBjpVLFlnKwVG3C4KuZP8syHQQf2U1I6fVcurVHvP5GvRQ+2rb@nongnu.org
X-Gm-Message-State: AOJu0Yxg6LLvbQ9DaAibe5UCgqCZqvuaeag0x/FLE+tbpa6tP56+++5K
 iIEzPUW5IZMT/j0zBnrh4I1JxtU0OfNp/3MyJfdL7KQ5Tfv1bdi85sss
X-Gm-Gg: AfdE7cl4d4ZPbUtqzMbSyLBK8Ky0AnRcUd3Kor1y5ByOl/KMcF2tEI4zGSXpiNduwbq
 vjmd1TA1wwddcr0iPH3b/G7hPdPi7qkB7vpA8a/sb9q4Dk4mPmbNwrVNrQzzrDCtdr3Q92xORpw
 cowzDBTveTZErKdfyT7OvmCCPEBCdv6ThKsgSpW8NsdXjwnMCj9tzeLYgqQYsdqrn7+lTFu7kkd
 +GZa5lKH4nL1yNtJYnzDKjHSMekqVX0cQLJ589j8fzjPuGfvtgFDAkMae5UIU3XKJGsR3kop3gv
 dG0RVDRa5uVzH1oPAECqX/Y3hVSB+soZ8CAx0dprIXWe4BhtUkyFmeQLIjt1QZYAB9i2S62TsCw
 YYq743UVtbe0iJvfTzusAIRnYsCzi0q6o6hJah5zw12g5WnZX0SY6AkEeVL9mMYUI6hOMdzDjmF
 sUSpOHJVhewK0iCRbBLl/HVvAqFVG5hhQ5Th8=
X-Received: by 2002:a05:6a00:1951:b0:848:468e:d33c with SMTP id
 d2e1a72fcca58-84855e8e4c5mr2959763b3a.5.1783608855261; 
 Thu, 09 Jul 2026 07:54:15 -0700 (PDT)
Received: from smtpclient.apple ([23.247.139.92])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d498dcsm8711200b3a.30.2026.07.09.07.54.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Jul 2026 07:54:14 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] pvscsi: translate data endianness
From: Miao Wang <shankerwangmiao@gmail.com>
In-Reply-To: <89089d8f-101c-4520-8031-e9522e2cbb1f@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 22:53:59 +0800
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-s390x@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <ACA8103D-AF3D-464A-900C-5448E29571DD@gmail.com>
References: <20260605-pvscsi-endianness-v1-1-b0bf472b0f59@gmail.com>
 <273f53b8-9edc-4c0b-a793-d0667548553a@tls.msk.ru>
 <89089d8f-101c-4520-8031-e9522e2cbb1f@oss.qualcomm.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=shankerwangmiao@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

> 2026=E5=B9=B47=E6=9C=889=E6=97=A5 22:41=EF=BC=8CPhilippe =
Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 9/7/26 08:39, Michael Tokarev wrote:
>> On 05.06.2026 16:27, Miao Wang via B4 Relay wrote:
>>> From: Miao Wang <shankerwangmiao@gmail.com>
>>>=20
>>> This patch improves the implementation of the pvscsi device by
>>> translating the endianness of the data sent or received from the =
guest.
>>> This ensures pvscsi can work on big-endian hosts with little-endian
>>> guests.
>> Hi!
>> Can we pick this one up for 11.1 please?
>> I know right to nothing about s390x internals so can't really review
>> the change.  But the fix seems to work, and it should be picked up =
for
>> the stable qemu series too, it loks like.
>=20
> I tagged this for review and forgot. Basically we shouldn't using
> tswap*() anywhere in system emulation except semihosting. Here it
> seems reasonable to use cpu_to_le*()/le*_to_cpu().

I have no idea why tswap* should not be used. Here the problem in
pvscsi is that the driver on the guest side is using the native
endianness of the guest CPU while for handling the values on the
host size, we need to convert it to host endianness. As a result,
what should be done is to convert from the target endianness to
the host endianness and vice versa, instead of converting from
a specific endianness to to host endianness.

Cheers,

Miao Wang


