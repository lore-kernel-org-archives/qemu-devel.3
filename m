Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784C7CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 08:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDfO8-0005n2-Np; Tue, 28 Oct 2025 04:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vDfNv-0005mS-Bt
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:48:55 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vDfNp-0006d4-MH
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:48:54 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47103b6058fso41649715e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 01:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761641325; x=1762246125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WQv72y0FXMxHo4R1brH6PeUUPynEY6XFnnx0SFP9c3o=;
 b=QRmc8TFXd9poPGwvEsqBU+4mvh6YaikEDoQRHvIKfapfPi3E38TqLEa1jpBRrCYPbE
 sykBjfCuoESVxTtVSRNTqXwsl3XG4EYzCr+OaXnssC2sA6MihkIsh9RM7oTNMx/gLKld
 n8JNId29ysgRhgUEEa/kneZ/AGmBaIIfwQ+aCdWHTpCmHPSiy9h9tJvL05Gosr7QGwjl
 wc4oWHJFAnlhv1NIdy+dA154FfB12P29S1uxWIn7lyQuk/uVOr//tMDe5vHBPTjFEvw1
 CzuHPwo3Hg/0joLhJdD80ZJyVXZv/ZDN6MnESIS+ULDoI0tj3QEWfrP0FiF7iK+FJ3Y4
 S5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761641325; x=1762246125;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WQv72y0FXMxHo4R1brH6PeUUPynEY6XFnnx0SFP9c3o=;
 b=rkkkwBo+yDhz8u2eCLUCKAepU+3N66ALYVAXpi6BrnLDLYiST4fbTZpynmqrDvMp/f
 W9XJKeYPcY+1FHzo0mk5KCv0cc7Bt9DRn/srWKJeS19yaevYiWoff5REp3Tctgf7nHfL
 QENRPWUhyp0mWdzNgO2GTiFdsWOrubVtgM5jqOx0gAZzvu7w2e49+Gez0F66rxIqQoBb
 KQsgp2KEdM9RPM0Ii+flrrpGYcL3MwSOkQChz/MKYlm0ikuup5Alrl9LoOMNI+PDlxgA
 DSvM7FeJ2CnlmkXvf3qNMvxB2pkncYLE5RXqqSiy5Q9kIA47JT/OKN5qJ9utTY3LOVMT
 +reg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAHST/BUNZLQujuAHyjc2ZRoU8naYYHanwE6obtCF1gZJmkSF6OOElKYimz3FDv5VdFTUfwZk2GovC@nongnu.org
X-Gm-Message-State: AOJu0Yyi7WGGji+hRm5+Qiw+39VXY3kN5XuVXIhyTIIcQFVVU5VE418p
 2O5Ky/lQD4y3hXXhBJPT3Y0GcTE3V4WjBWOpcEqKq/IDHP6WyUiAiME8
X-Gm-Gg: ASbGncu5RdCWQmBoty6a3XwUETaeMpmxhcb9EpmpH2qoaKiD/8iOhYykeDyJi7khlEA
 ngbT6SSmmGnoTgp31sVm8eKlA0RbyHymYnXduwb/+tjqK7FzW1kMH1a+ScG4JqVtI2LGq6GI5K4
 Mv0BGvLetRTAG63JtO2iIuupVIPqf86ikm8fodkXjeOBOCjx4QIfp4kEaMPDsw8aT09COEJlBdQ
 A9YNBmqZ/ckHAeolGBmR4t0do3PuiSOCgRwIcYT4BqoD1i9bz4xDwjT1FQD/NbzuXn1UIasT7RQ
 v/7z05qPImDb0Zm75bkHIHbMv/SxxGKci7isWFFdwldo9Zwf5R6JSdgKFfqyWsphSpTfzmcL1AA
 AGORtgaJbbvuhFgRKuaWVv2jqx8fShQA1DTBhNUKj2hFpxrhjDVDBebQ/BuGt9Mj4FhXp3szFOF
 LHspedwwJEHmR5T8Zz/gwcIFBfw3CZREETS9mQiQRblh6bz/5v6VfTRlRIGzMmRgpYXdiYOuRFL
 CO2X1KqLpE=
X-Google-Smtp-Source: AGHT+IF+bXKN0eXZjcdzIcJXWHAZ7wGiGx2tI03419aHzTho2s/tQpQ7tWzG4kowPpu3mN+qokjMJA==
X-Received: by 2002:a05:600d:830f:b0:475:d91d:28fb with SMTP id
 5b1f17b1804b1-477180f3b54mr13453825e9.4.1761641325284; 
 Tue, 28 Oct 2025 01:48:45 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf271400c439911fd9f45c3c.dip0.t-ipconnect.de.
 [2003:fa:af27:1400:c439:911f:d9f4:5c3c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd478202sm182509315e9.14.2025.10.28.01.48.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 01:48:44 -0700 (PDT)
Date: Tue, 28 Oct 2025 08:48:42 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
CC: Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Huacai Chen <chenhuacai@kernel.org>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_docs/system/security=3A_Restrict_?=
 =?US-ASCII?Q?=22virtualization_use_case=22_to_specific_machines?=
In-Reply-To: <CAFEAcA8RaZOXpav64E5-0CDhB66zQXRuLaFuz22GiyPGwGVQJw@mail.gmail.com>
References: <20251016131159.750480-1-peter.maydell@linaro.org>
 <CAFEAcA8RaZOXpav64E5-0CDhB66zQXRuLaFuz22GiyPGwGVQJw@mail.gmail.com>
Message-ID: <000E4FA1-EE4A-476B-8CAE-680FC068BCAA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x335.google.com
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



Am 27=2E Oktober 2025 12:48:29 UTC schrieb Peter Maydell <peter=2Emaydell@=
linaro=2Eorg>:
>On Thu, 16 Oct 2025 at 14:12, Peter Maydell <peter=2Emaydell@linaro=2Eorg=
> wrote:
>>
>> Currently our security policy defines a "virtualization use case"
>> where we consider bugs to be security issues, and a
>> "non-virtualization use case" where we do not make any security
>> guarantees and don't consider bugs to be security issues=2E
>>
>> The rationale for this split is that much code in QEMU is older and
>> was not written with malicious guests in mind, and we don't have the
>> resources to audit, fix and defend it=2E  So instead we inform users
>> about what the can in practice rely on as a security barrier, and
>> what they can't=2E
>>
>> We don't currently restrict the "virtualization use case" to any
>> particular set of machine types=2E  This means that we have effectively
>> barred ourselves from adding KVM support to any machine type that we
>> don't want to put into the "bugs are security issues" category, even
>> if it would be useful for users to be able to get better performance
>> with a trusted guest by enabling KVM=2E This seems an unnecessary
>> restriction, and in practice the set of machine types it makes
>> sense to use for untrusted-guest virtualization is quite small=2E
>>
>> Specifically, we would like to be able to enable the use of
>> KVM with the imx8 development board machine types, but we don't
>> want to commit ourselves to having to support those SoC models
>> and device models as part of QEMU's security boundary:
>> https://lore=2Ekernel=2Eorg/qemu-devel/20250629204851=2E1778-3-shentey@=
gmail=2Ecom/
>>
>> This patch updates the security policy to explicitly list the
>> machine types we consider to be useful for the "virtualization
>> use case"=2E
>>
>> Signed-off-by: Peter Maydell <peter=2Emaydell@linaro=2Eorg>
>> ---
>> changes v1->v2: updated the list:
>>  * remove isapc
>>  * remove ppc, mips, mips64 (no machines supported)
>>  * list pseries as only supported ppc64 machine
>>  * list virt as only supported riscv32, riscv64 machine
>>
>> I believe the list to now be correct, and I think we generally
>> had some consensus about the idea on the v1 patch discussion, so
>> this one is a non-RFC patch=2E
>
>This has now had various reviews and acks, and no
>suggestions for further revision=2E I propose to take
>this via target-arm=2Enext, unless anybody has any
>objections=2E

Sounds good, I'm looking forward to it=2E

Maybe we could then also merge https://lore=2Ekernel=2Eorg/qemu-devel/2025=
0629204851=2E1778-3-shentey@gmail=2Ecom/ which had some technical comments =
and no follow-up=2E

Best regards,
Bernhard

>
>thanks
>-- PMM

