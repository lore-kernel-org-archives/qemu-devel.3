Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68468CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 17:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU6Tv-0000gP-TF; Mon, 01 Jun 2026 13:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wU6Tb-0000fk-8d
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 13:31:01 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wU6TK-0005yA-Q6
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 13:30:44 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-490b09e4cccso1578465e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 10:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780335041; x=1780939841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eOX4E9NTH4ace2x/yWyLnVDJzJJ1xaxeOxtTYLyOxF4=;
 b=lJ+LRvBk+TwZt1IOoyPrYkJcOWHo43fc4FsPdC++3CO3rBOkMVvADWr6pd/FBGb4c1
 UJIdSfxTpJJomh7JjhYyVAGN2YuPSY79aRerycwPyOhFjSLJWfme3GELaLSm2bE4Ix2I
 1bfkGDx6OKdeEgGVfCnJ4LLyZZho5V7UoeR75HaKuwaYs1k8jNKsit0xtzBJSgLjmFqq
 XXgSWxz/7ddzsALxcSxXaGENbZuEINQCIPFxP1K8aMPBFq1Ie1AdFjOfazkPVI4DW9N6
 5nru1vh0UV5UXcczmM2rdkOs+gZ0vpBZAKasrwNQAndXy5VhtpgBVuTHE1GYPJhCchUk
 57Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780335041; x=1780939841;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eOX4E9NTH4ace2x/yWyLnVDJzJJ1xaxeOxtTYLyOxF4=;
 b=Liy5lrh1W5tQXkuMC6YhBco2m2mkn/JcK28/3lB1JeAyx0AljLfiCPRjREZ+9Z1+vS
 Zn34fFuqK8Ar7Et8G9LOC/ckTr/ZrzjdkpdBzSHKDf1Ii9wtKVuo3xkRN2jNPn6eWFDR
 R1/aeWLdlpYS2GxGyPmXpQ/wsRReNvozHpkaz6vozAD+4ZThcfAsVTwjI3tQzQ0xckF4
 +mGnMz/qt1XAJ4iswXsJfpDhYz6qo/ZkGbvQIBMzP4znlVY6+XlzoDftVqewFuKPyojZ
 DO1xNNt7Vzl4ij+bGGdw4Myf7ltEjOtLQKcaABMhI7K1Nahr0bcy15nYKNCj7GxXxGJ/
 7TPQ==
X-Gm-Message-State: AOJu0YwqodbJucv4TLhrn6bs7ZOuNgwJfVVEiUGMrmB5RWRWXksrKD0B
 JLCGzUccFQ4FsKWEoE3PBXgzQ+YmuZiJ3qhHBEP0U6Fr2Dw601T0R9fK0X3qsRYx2GA=
X-Gm-Gg: Acq92OGpdjG+wP/XwkeaATO/Nh6hZJpeO6M+Hv/KTumLn4Hoq7VQTCDqjUb4g4as1Qn
 BvThmcS/vgqswm748pVdPQflOxI8s4d2csIMhp7nfzfzyUKWdUhlwMknC1kNaX1RkfQPv3kg3Ay
 VdgNGw8l0cJiVYHRtgWoWnrlgPe/LxXyj0QRv1i4RwpO0oGVbUi+A4+5ABjSyHHT81JsdozgStR
 geyRKV1h2cv9kR9Fh5iBzqZMG0MlwHu1iYG7jiPK+p0s5bnPgRTuA/5mypLCKrZVZH2phrDaalf
 h9OEPj6tx9P0NLAhnIoA27miOhudGJ1WGh36BtPc5Ek2VDQXF3h5WTYXpJnA1Vy8hRQorTYFCNv
 9UUwnJ1sPOTWu5pDqWAX/xFO8GTC5/w2V0n+YJjdFzpUHqqOJMJFxd1vXIb/uEhBh4+qCpkyVJa
 0LUuG6KmYhqqgp+QHiESyS0s++Klf/L0Yju36MitUn9wj2
X-Received: by 2002:a05:600d:10f:b0:490:b0e0:3de2 with SMTP id
 5b1f17b1804b1-490b0e0427dmr6221195e9.33.1780335040907; 
 Mon, 01 Jun 2026 10:30:40 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c0495fcsm131085785e9.0.2026.06.01.10.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 10:30:40 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 212FC5F7C7;
 Mon, 01 Jun 2026 18:30:39 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Kyle Evans
 <kevans@freebsd.org>,  Peter
 Maydell <peter.maydell@linaro.org>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  John Snow <jsnow@redhat.com>,  Thomas Huth
 <th.huth+qemu@posteo.eu>,  Brad Smith <brad@comstyle.com>,  Warner Losh
 <imp@bsdimp.com>,  qemu-arm@nongnu.org,  Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9?=
 <berrange@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Jiaxun Yang
 <jiaxun.yang@flygoat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Song Gao <gaosong@loongson.cn>,  Cornelia
 Huck <cohuck@redhat.com>
Subject: Re: [PATCH 2/3] gitlab: work around the inability to build targets
 for MacOS
In-Reply-To: <22a283dc-38a5-44f5-b402-c334205e81cc@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Mon, 1 Jun 2026 09:44:28 -0700")
References: <20260601143129.144786-1-alex.bennee@linaro.org>
 <20260601143129.144786-3-alex.bennee@linaro.org>
 <57d0477a-3bbd-4948-8e18-33df41991545@oss.qualcomm.com>
 <87bjduxmne.fsf@draig.linaro.org>
 <22a283dc-38a5-44f5-b402-c334205e81cc@oss.qualcomm.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Mon, 01 Jun 2026 18:30:39 +0100
Message-ID: <875x42xj5s.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On 6/1/2026 9:15 AM, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>=20
>>> On 6/1/2026 7:31 AM, Alex Benn=C3=A9e wrote:
>>>> Unfortunately a previous fix to ensure .ninja-goals was set for the
>>>> TCG tests broken the ability to run check-functional-FOO. As we have
>>>> now reverted we need a solution for the MacOS gitlab run. The simplest
>>>> is to add an explicit make invocation to build the signed binaries
>>>> before we run the tests.
>>>>
>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>> ---
>>>>  .gitlab-ci.d/macos.yml | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/.gitlab-ci.d/macos.yml b/.gitlab-ci.d/macos.yml
>>>> index f61750a3f4a..8366b4ad564 100644
>>>> --- a/.gitlab-ci.d/macos.yml
>>>> +++ b/.gitlab-ci.d/macos.yml
>>>> @@ -29,6 +29,7 @@
>>>>      - cd build
>>>>      - ../configure --enable-werror $CONFIGURE_ARGS || { cat config.lo=
g meson-logs/meson-log.txt; exit 1; }
>>>>      - $MAKE -j$(sysctl -n hw.ncpu)
>>>> +    - for TARGET in $TEST_BINARIES ; do $MAKE $TARGET ; done
>>>>      - for TARGET in $TEST_TARGETS ; do $MAKE $TARGET ; done
>>>>=20=20
>>>>  aarch64-macos-15-build:
>>>> @@ -44,6 +45,7 @@ aarch64-macos-15-build:
>>>>          --cross-prefix-i386=3Di686-elf-
>>>>          --cross-prefix-x86_64=3Dx86_64-elf-
>>>>          --disable-plugins
>>>> +    TEST_BINARIES: qemu-system-aarch64 qemu-system-i386 qemu-system-x=
86_64
>>>>      TEST_TARGETS: check-unit run-tcg-tests-aarch64-softmmu run-tcg-te=
sts-i386-softmmu run-tcg-tests-x86_64-softmmu
>>>>=20=20
>>>>  aarch64-macos-26-build:
>>>> @@ -60,4 +62,5 @@ aarch64-macos-26-build:
>>>>          --cross-prefix-i386=3Di686-elf-
>>>>          --cross-prefix-x86_64=3Dx86_64-elf-
>>>>          --disable-plugins
>>>> +    TEST_BINARIES: qemu-system-aarch64 qemu-system-i386 qemu-system-x=
86_64
>>>>      TEST_TARGETS: check-unit run-tcg-tests-aarch64-softmmu run-tcg-te=
sts-i386-softmmu run-tcg-tests-x86_64-softmmu
>>>
>>> Could make all be enough?
>>=20
>> No - not without the goal having the signed binaries in them.
>>
>
> Which comes back to my initial (unanswered question), why do we need
> signed binaries for running tcg tests?
> Signed is only for HVF access.

Because it exposes a bug in our build system: 20260505103649.68361-1-alex.b=
ennee@linaro.org

Ideally we should build the final product - whatever it may be - from
make all. However I suspect we can't achieve that given the circular
Makefile dependency until check-tcg is integrated into meson.

I will review you suggested path forwards tomorrow.

>
>>>
>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

