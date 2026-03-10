Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F103FD88D2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 23:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w06e4-0002PR-1D; Tue, 10 Mar 2026 19:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06e2-0002PC-Ok
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:37:46 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06e0-00037S-RB
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:37:46 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439cd6b09f8so4989848f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 16:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773185862; x=1773790662; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m/Sl2aKI8GEMsQH4bLjlg2oZBT3SOYIfP15MwOMwX80=;
 b=nOLJYH4qdZ8CQUi38XCquePSdGKM5t+AqhBNqR4zJBdQ+7qFaPqnaK94UOIeQbCku9
 LfVfzsMSsrFw/L0VoKWcSoMGK2P4ULblRQ2J0XAR8hCG2QaOfUi2fw0dja7/A/BLjvfK
 g3dedo/gd3aFlJRqoKZNef4QRhzO86zhRfCjmTK8JM6q9pqZv5X75FikWG+SnZRE2SNL
 n0s9cARpC6fYK34mMUk5NHoNww6L16lprm2+xh5lfLYflk3UvlziTnUCaJK9b6euHRXw
 bhRtsOtfHXsV8h602MTVWJnCCxa8mWQJ0Xj9V+vqRPrYrxstk2qoglmYac0XZa7wVGIS
 O7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773185862; x=1773790662;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m/Sl2aKI8GEMsQH4bLjlg2oZBT3SOYIfP15MwOMwX80=;
 b=qEQNiVC7iZ6BZpvLvDth3suX3NS5Px4oHl6biXs2XOSw/ai6wMLDKjEpnx7uydK3p9
 ijBVDliChKUym0NFAg7AhYbdyWLcb+CAoM+DJeKN3DMSjseN9oSPHKBgJJheBEf91Q0J
 epfJjfsKW1cv72gMdp4j3HkV+qoeAHLvva/Se+OoPXpy88SYmcQOFc1UQ26OEA5D5QXP
 edXH9EqPKfUCwVA4TI0N8K29aPFWMswJLsrgOPktLQCy92oKy0b4Sbc1WnPkdo6Tb/ji
 fQKcDpYU2V97yhVr+yKtrG6f6NxuKy7Bhqb6VBu0/6zBHXRSsfIJ+DMFusONJo8pkvQM
 BhQw==
X-Gm-Message-State: AOJu0Yx4jaXiEZ0xwfiRPJ2mSib+fOamq0Qm259jiUMinNuEU6WNwZZl
 MzujaN11RCz8M/kSLFPvLU48CtCH2CiUcn6jU+gc5ueGubjsl9Q+H3ngYc2TvxN+Vuovxf479ZJ
 PYo8zgAI=
X-Gm-Gg: ATEYQzzWBSw0byl5xranhtcb5YWbK3WwcRa/IxkPOlLNem2nGBm2EJ7oi28vaV9VWq3
 7GtqIL4Nwi+q6XjbyhEN8k+tLiAzhnK1eUmx9oBwHaQa8Q2JA2Pa8UMIVg6VyyAFsYdzPh/69Kz
 mwpTTdflATbxzDIDFpItR0kI7sbueZKo6vlrmF68sziEpl2l6u7ct7rWRNyrEipOvSiXqTd5thD
 vjsy3ixkoWTK2pPoYC5wibIBmL/0Zyikj/RsMa0G27Qrq/T2Ixwd8l5gUqFN9H7+9+vyZ9BM0KJ
 C8ZirJ/YacRkbVXAPXERUjGJd6pH4ySSZqsefGpD9ioqdixbM3fkM8P9YGmsxP4VKaTIrsUHLDT
 ODJ+PHgwXRNLaF0DuaK9oFKu4If56Hwuc9JfY5zBNlpHIoQCHBof5aoA/0GnyEcg2z7Y/U1qsr7
 Ch82OOUew6tl118x8bbHgAkOd10fmhSw+QBowPezhzMzUtrUVQXGLZlJbghI3R5e94TQ==
X-Received: by 2002:a05:6000:1846:b0:437:6625:d0d7 with SMTP id
 ffacd0b85a97d-439f8438f5dmr1241442f8f.42.1773185862457; 
 Tue, 10 Mar 2026 16:37:42 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439f8200606sm1282366f8f.27.2026.03.10.16.37.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2026 16:37:41 -0700 (PDT)
Message-ID: <22332fe2-fd47-4493-b7d8-7ce3b3badc4c@linaro.org>
Date: Wed, 11 Mar 2026 00:37:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/16] tests/tcg: Disable prot-none test on GitLab
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260310232045.58440-1-philmd@linaro.org>
 <20260310232045.58440-3-philmd@linaro.org>
In-Reply-To: <20260310232045.58440-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 11/3/26 00:20, Philippe Mathieu-Daudé wrote:
> When adding gdb-multiarch on our container images, we
> see the prot-none tests to pass on GitHub but fail on
> GitLab. Disable and track:
> https://gitlab.com/qemu-project/qemu/-/issues/3329
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/tcg/multiarch/Makefile.target | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
> index 73c2a78215c..70e2ac38f5a 100644
> --- a/tests/tcg/multiarch/Makefile.target
> +++ b/tests/tcg/multiarch/Makefile.target
> @@ -117,12 +117,17 @@ run-gdbstub-registers: sha512
>   		--bin $< --test $(MULTIARCH_SRC)/gdbstub/registers.py, \
>   	checking register enumeration)
>   
> +# The prot-none test was skipped on gitlab due to missing gdb-multiarch,
> +# however it seems to have bitrotten. Disable, it is tracked as
> +# https://gitlab.com/qemu-project/qemu/-/issues/3329
> +ifneq ($(GITLAB_CI),)
>   run-gdbstub-prot-none: prot-none
>   	$(call run-test, $@, env PROT_NONE_PY=1 $(GDB_SCRIPT) \
>   		--gdb $(GDB) \
>   		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
>   		--bin $< --test $(MULTIARCH_SRC)/gdbstub/prot-none.py, \
>   	accessing PROT_NONE memory)

Makefile is harder than meson, I had forgotten about it =)

To be squashed:

-- >8 --
diff --git a/tests/tcg/multiarch/Makefile.target 
b/tests/tcg/multiarch/Makefile.target
index 23377f7a4e3..b05bde23df0 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -120,8 +120,10 @@ run-gdbstub-registers: sha512
  # The prot-none test was skipped on gitlab due to missing gdb-multiarch,
  # however it seems to have bitrotten. Disable, it is tracked as
  # https://gitlab.com/qemu-project/qemu/-/issues/3329
-ifneq ($(GITLAB_CI),)
  run-gdbstub-prot-none: prot-none
+ifeq ($(GITLAB_CI),)
+       $(call skip-test, $<, "Broken on GitLab")
+else
         $(call run-test, $@, env PROT_NONE_PY=1 $(GDB_SCRIPT) \
                 --gdb $(GDB) \
                 --qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
---

> +endif
>   
>   run-gdbstub-catch-syscalls: catch-syscalls
>   	$(call run-test, $@, $(GDB_SCRIPT) \


