Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C19C10F16
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 08:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2oeD-0002jG-3j; Fri, 03 May 2024 04:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2oeB-0002dA-JU
 for qemu-devel@nongnu.org; Fri, 03 May 2024 04:52:03 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2oe9-0007aw-S9
 for qemu-devel@nongnu.org; Fri, 03 May 2024 04:52:03 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a58c89bda70so1030154566b.3
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 01:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714726320; x=1715331120; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1m1GRsehWy4YzYAHEJnp3cq6p3zxnFV0T98qEc+lhF4=;
 b=L0g2DU9saGCUU+1AReN26tKRths7sKKYoGx7iuPqxXeKMbP4HwbyZr5HsgUFfgGo0d
 GNmnS9visfFVJqti8He5z3QvCFMTRR1gyrNR7BvA+zUxGfCmC7FgYkvdAgQmNGa6sCUn
 +mS1tGsAOcnsRh/nxh8sPLrInghn/zVuWqqLvDhJUFMCugoj7hq9gpEh9zHb2nkJmVTA
 jhdUZoQpUah7NtJ26onCMm4OOTWdCuR5pWSt5q6n0UJctdgfgwI46L8Of1+FLZ9lrFV2
 wtXTDQdJSP4fX86z43lvFY9P9OxMUx0oIWi7xZxn3Zq9eUC7Uo7MW4AJPbSnB2SQNVAU
 R48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714726320; x=1715331120;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1m1GRsehWy4YzYAHEJnp3cq6p3zxnFV0T98qEc+lhF4=;
 b=cl5vnQEep+3SpOSn3oqav4zLM7wmA4iWSYmqVr2yFOaYJPqLAhd9VGhuis0+j2rG1v
 hF06A8fUUymUPCMGj2eW59uIInkCAEt+v3AT8dBThD42w0hKXlb2VA46sBSc2Fzdgp0w
 JooqSbcQs3v6OlWgpNJoCShFqXe61krY9qQrTVgxcVR6zh1Xh9Kt8NfBnspc8pd2W47R
 R6E51JkobXGZeAhpA4cFIUu+Rm3Y+ZnU2U5hkpL5xisDCxC225sAZV8JUyZd2alrrFmE
 bBhGBgp6E3UknCKmU0AK7asR5Ulfk7CduQfkXd0/JMZJ/cHRAYZe7IKDzDECVhfRF0zi
 7gcw==
X-Gm-Message-State: AOJu0YyJTZw7vpzyvRztvvfNu8dNwXwuEucDsrKa+wyhMLhxGdTanfRG
 mtzU30ThMk2bH4Hq9Ba2STD4Uv0IST2VT9/PD51urWomD1xyHrZ8hJtky7nUbVs=
X-Google-Smtp-Source: AGHT+IGJlU7KEg/+T5YIZe+P6PtHQq8wNA1cvPv3Uq2fQANqxXEubiIAljAwoPiSRjy7iZxd3Ik2Lg==
X-Received: by 2002:a17:906:dfc2:b0:a58:c6b2:7885 with SMTP id
 jt2-20020a170906dfc200b00a58c6b27885mr1109323ejc.5.1714726319925; 
 Fri, 03 May 2024 01:51:59 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 by17-20020a170906a2d100b00a5816a7381bsm1491639ejb.141.2024.05.03.01.51.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 01:51:59 -0700 (PDT)
Message-ID: <e8db4fec-5c7c-42d5-bba7-a85b09f0a358@linaro.org>
Date: Fri, 3 May 2024 10:51:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Re-enable riscv64-debian-cross-container (debian
 riscv64 is finally usable again!)
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20240503071634.841103-1-mjt@tls.msk.ru>
 <ZjSbRsOpJsTdTh6l@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZjSbRsOpJsTdTh6l@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

On 3/5/24 10:07, Daniel P. Berrangé wrote:
> On Fri, May 03, 2024 at 10:16:34AM +0300, Michael Tokarev wrote:
>> Revert "gitlab-ci: Disable the riscv64-debian-cross-container by default"
>> This reverts commit f51f90c65ed7706c3c4f7a889ce3d6b7ab75ef6a.
>>
>> riscv64 in debian has been non-functioning for almost a year, after the
>> architecture has been promoted to release architecture and all binary
>> packages started to be re-built, making the port not multi-arch-co-installable
>> for a long time (in debian, multi-arch packages must be of the same version,
>> but when a package is rebuilt on one architecture it gets a version bump too).
>> Later on, debiah had a long time64_t transition which made sid unusable for

"debian" (even "Debian")

>> quite some time too.  Both such events happens in debian very rarely (like,
>> once in 10 years or so - for example, previous big transition like that was
>> libc5 => libc6 transition).  Now both of these are finished (where qemu is

("QEMU")

>> concerned anyway).
>>
>> Hopefully debian unstable wont be very unstable.  At the very least it is
>> better to have sporadic CI failures here than no riscv64 coverage at all.
> 
> IME of running Debian sid in CI pipelines for libvirt, it is
> way too unstable to be used as a gating job. There are periods
> weeks-long when packages fail to install, even for relatively
> mainstream arch targets like x86, let alone a new target like
> riscv.
> 
> Running the job by default is sane, but it should not be made
> gating until in a formal Debian release IMHO.

So it is waste of resources, and each time maintainers will look
for failure and notice "oh this is still this broken image" and
skip. Hard to see the gain of bringing that back TBH.

