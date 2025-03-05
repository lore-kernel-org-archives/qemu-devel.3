Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9F6C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 16:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tps4n-0005V9-3R; Wed, 05 Mar 2025 11:58:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tps4g-0005UK-Ej
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:58:26 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tps4e-0007An-Nt
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:58:26 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5e5050d19e9so9241854a12.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 08:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741193903; x=1741798703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OqqMOx2SW5qI2K7spDUtIJB3NXGuVoyvBTmNrS9R2c8=;
 b=Vny+/nRT0gmpnxbMrQAMjunP7UkkXReq2q3oToau/dcqpDEFTX3/QDdqKTsYP7sKPZ
 LfPkwM61ZG6J6XUjKFnctVPTBmjNb9g1wwVfvodrQP6rqMvO8Iv+v+oQ3z58ZuZoTCnd
 F7lg1jJPoX0AlgjSSWDEfA5O44DdOHMexYW9g+23wR7bYquv9xyr62XRyW8jmxjQX0Lp
 yLWwF4EWHrTtbWpzK/WjkDyqbQmAX86ZthB4x3TFT1/+/S+EQnSpKHSLYpTWDhLA4eal
 4O5zRv0nXF+q7HWBKw6j9d1CqzMFOZQDfR6oYZpQwd/wflIcz3l5ux2+9vdAPBXyTVVc
 cT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741193903; x=1741798703;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OqqMOx2SW5qI2K7spDUtIJB3NXGuVoyvBTmNrS9R2c8=;
 b=V2FDE0t+5f/gY4kbv4lfK7n6h2HP5Ce5t0f5Zammsz6ohAPPyVnc+9rwDOXt5i7PJN
 m57yI2ldEcq5rojCkhGuKEU8WcczkQhz+/TooRInFt+q/wKqVBzUDOoAPLCo31mzNDS/
 rZNe2MyTyZUQesuhVYXWUb661XtiFn85/i4Lxjmh3qYAAxgR5Gvo30wD9lCqBX8Y1czu
 mPdgP4s4TVsBL/uwvBFdi1Xmgc90RBCRHJqQ8DvTdsw/4jEBq1JhvtlKkqXetgS9itai
 nhJoRE5KR0KCrlLdls5FDWSgtSvafzxuYQV9f56Y2fqZoBLgXfs/MabRyjUrG0y9B2XD
 D3kQ==
X-Gm-Message-State: AOJu0YyJpXqccZEp5VHarGQAWPw7P6OYr66sq3HSZAs4lXKF434Oazbm
 kZ8ZqGM3CX9v5onnY71wXIOjMEPKNEH9qaFlNM8VYm7uHnFqWQqzLcLT9GqVs3c=
X-Gm-Gg: ASbGnct6HbtdGmPV1UqPVGJdDNUAOLXeodIBE8DaZozeKUWVoOZTt+MD5szZPJkix2b
 n8LqQeD+Jss8wZIwt6QWeQQYsVgelh3V2aBKxQxWLsLuodWdKiEYh/YLaV/k1Ruf0y27dJbNL1p
 rVP7H33b1K5NBGAK73Wmp70/Rb44YzAzjN4Pfi24yJzwvf0dRx3QPUVKD6Mn7S3pZEkqCWNgjVX
 JCfpPL8DBRTx9Bm4ZqtMEDcAZa/wrUHhmLaKlQtCVgJRhlhPmI7bglQ4m3MkNjLTfJBZmhmwhoK
 jq3X3O3MuucOFsOio84hztwtSntIaXtscLUF5mLZ5SRZcQk=
X-Google-Smtp-Source: AGHT+IHIWWaubpF2qPGZqYMf3xsxVjzVL+olHb49BMM3DkfVQKnMnEm8SORIy7gdJJpMka1l4tQgMw==
X-Received: by 2002:a05:6402:34c6:b0:5e0:82a0:50ab with SMTP id
 4fb4d7f45d1cf-5e59f4f947bmr4097005a12.27.1741193902922; 
 Wed, 05 Mar 2025 08:58:22 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e5bcd1595bsm314744a12.42.2025.03.05.08.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 08:58:21 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D7B0B5F932;
 Wed,  5 Mar 2025 16:58:19 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,  Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,  Laurent Vivier
 <laurent@vivier.eu>,  qemu-arm@nongnu.org,  Alexandre Iooss
 <erdnaxe@crans.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Riku Voipio
 <riku.voipio@iki.fi>,  Warner Losh <imp@bsdimp.com>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Kyle Evans <kevans@freebsd.org>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Ed Maste <emaste@freebsd.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v2 07/32] tests/functional: update the aarch64_virg_gpu
 images
In-Reply-To: <20f719a9-a26d-4cb7-aa59-aab6cb20fe77@redhat.com> (Thomas Huth's
 message of "Wed, 5 Mar 2025 09:35:08 +0100")
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
 <20250304222439.2035603-8-alex.bennee@linaro.org>
 <20f719a9-a26d-4cb7-aa59-aab6cb20fe77@redhat.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 05 Mar 2025 16:58:19 +0000
Message-ID: <87cyev4dp0.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Thomas Huth <thuth@redhat.com> writes:

> On 04/03/2025 23.24, Alex Benn=C3=A9e wrote:
>> Update to the most recent aarch64_virt_gpu image. The principle
>> differences are:
>>    - target a v8.0 baseline CPU
>>    - latest vkmark (2025.1)
>>    - actually uses the rootfs (previously was initrd)
>>    - rootfs includes more testing tools for interactive use
>> See README.md in https://fileserver.linaro.org/s/ce5jXBFinPxtEdx for
>> details about the image creation and the buildroot config.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   tests/functional/test_aarch64_virt_gpu.py | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>> diff --git a/tests/functional/test_aarch64_virt_gpu.py
>> b/tests/functional/test_aarch64_virt_gpu.py
>> index 3fdb31f034..e417ca9beb 100755
>> --- a/tests/functional/test_aarch64_virt_gpu.py
>> +++ b/tests/functional/test_aarch64_virt_gpu.py
>> @@ -25,14 +25,14 @@ class Aarch64VirtGPUMachine(LinuxKernelTest):
>>       ASSET_VIRT_GPU_KERNEL =3D Asset(
>>           'https://fileserver.linaro.org/s/ce5jXBFinPxtEdx/'
>>           'download?path=3D%2F&files=3D'
>> -        'Image',
>> -        '89e5099d26166204cc5ca4bb6d1a11b92c217e1f82ec67e3ba363d09157462=
f6')
>> +        'Image.6.12.16.aarch64',
>> +        '7888c51c55d37e86bbbdeb5acea9f08c34e6b0f03c1f5b2463285f6a6f6eec=
8b')
>>         ASSET_VIRT_GPU_ROOTFS =3D Asset(
>>           'https://fileserver.linaro.org/s/ce5jXBFinPxtEdx/'
>>           'download?path=3D%2F&files=3D'
>> -        'rootfs.ext4.zstd',
>> -        '792da7573f5dc2913ddb7c638151d4a6b2d028a4cb2afb38add513c1924bda=
d4')
>> +        'rootfs.aarch64.ext2.zstd',
>
> I'm a little bit surprised to see "ext2" instead of "ext4" here, did
> they really downgrade the filesystem?

I think buildroot just symlinked them all together. I'll double check.

>
> Anyway,
> Reviewed-by: Thomas Huth <thuth@redhat.com>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

