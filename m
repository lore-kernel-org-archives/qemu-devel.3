Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51EBC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 12:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ8q2-00040C-Fn; Wed, 31 Jul 2024 08:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZ8pz-0003l5-MB
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 08:53:52 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZ8py-0007kA-0k
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 08:53:51 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so5508825e9.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 05:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722430428; x=1723035228; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kc9/863yKCUCvLhVkEExQixFK5TpiwEDZUksJ855ofM=;
 b=vJkpJtfLepVdbFprfHcyHEX2LK/KOM0pqfYWYuRjhl0wl8cf7cs1vC8siixujreB31
 MVJCiD2YTM3xaA7dxrA1ERye3fy7vtR3N3qVr0Nk+xlf+DSd3h24aPS8HRXbQR6A4r7j
 SrV31QTChXtdmptr/3bs634WEwV3+FQTVJgOClwdcysYx0pi3Rd2R6nD1LfrEhf5l9s7
 xEw+N2MjS1wLKkDuirJs2z/nM77XlXrl79+5/4zaEg/KYcJcoUfKgcEADreevcUZVv1k
 FP7FMEox0GThlfiacmoC3SU0tXowPCx24ZIPh6sE8UtDqpgNP/iIUOXzyvhUBTsNa3Ah
 l9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722430428; x=1723035228;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kc9/863yKCUCvLhVkEExQixFK5TpiwEDZUksJ855ofM=;
 b=B7xcTmQA/P0RyFZSu6gANrciqvkuzQZhsPjZvp3gq8tQt3/kZgj2OoAoyxgzvn1MWu
 iOr/MioQxe7JPcZ3SDLq5SghuCZ9O8CWhusTj9KS4l71imFDtp+ATM4XaxGI6N72FX+W
 lE01a4ht0zy5TTIYczCqTTF+ZWoct2xEc5EJ2VhG985/XC0ddV4AgyzyI1meyvRepe0p
 oAZhXdsze8PlUbTeQOFvMCHTcmTyoEQsxMieU3lVC5vAWRj/IjscfZqW/CKvKP/VXdNF
 rW5N8xvzevBHLBXpI+VThPQ/lDnUWLjTRomJihFeVkctxDlCbj+IaR4DSrM00gF2fQtB
 Qknw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDQ10FEL5lbv6qDY+gShfPyjGcTfzdkfYcUZFCfCep+O6h9OLX5Lz8wTD4QMTFFjAgqoT+sji718xp8pI1a8n0LGWqVDY=
X-Gm-Message-State: AOJu0Yz8ktW2o7CTFntNdx9wsR96uDAEJo9fbgDKLSknGHbsIGtY7Rgc
 945KecPjv7t1Qz9ojWG8k6HlZrDkyFdYPX/u08IKgDgDKXjbr+oP8dLmTVQEQxU=
X-Google-Smtp-Source: AGHT+IHK/bNJ2H+pcECIiM+2G2Xm6L5kUMOMz7/uXLYlcFXuV2ZRnhqgRUlhjoh6QLT9UA25OnqRrw==
X-Received: by 2002:a05:600c:3b17:b0:426:5e32:4857 with SMTP id
 5b1f17b1804b1-4282439538cmr38376675e9.0.1722430428435; 
 Wed, 31 Jul 2024 05:53:48 -0700 (PDT)
Received: from [192.168.214.175] (29.170.88.92.rev.sfr.net. [92.88.170.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36857e3bsm16967782f8f.81.2024.07.31.05.53.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 05:53:48 -0700 (PDT)
Message-ID: <0451aac3-37d2-426c-bd25-c9b3ea2c506d@linaro.org>
Date: Wed, 31 Jul 2024 14:53:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/24] tests/functional: Add base classes for the
 upcoming pytest-based tests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-3-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240730170347.4103919-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 30/7/24 19:03, Daniel P. Berrangé wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The file is mostly a copy of the tests/avocado/avocado_qemu/__init__.py
> file with some adjustments to get rid of the Avocado dependencies (i.e.
> we also have to drop the LinuxSSHMixIn and LinuxTest for now).
> 
> The emulator binary and build directory are now passed via
> environment variables that will be set via meson.build later.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> [DB: split __init__.py into multiple files]
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/__init__.py |  13 ++
>   tests/functional/qemu_test/cmd.py      | 171 +++++++++++++++++++++++++
>   tests/functional/qemu_test/config.py   |  36 ++++++
>   tests/functional/qemu_test/testcase.py | 154 ++++++++++++++++++++++
>   4 files changed, 374 insertions(+)
>   create mode 100644 tests/functional/qemu_test/__init__.py
>   create mode 100644 tests/functional/qemu_test/cmd.py
>   create mode 100644 tests/functional/qemu_test/config.py
>   create mode 100644 tests/functional/qemu_test/testcase.py

Please squash:

-- >8 --
diff --git a/MAINTAINERS b/MAINTAINERS
index 98eddf7ae1..a906218f9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4127,6 +4137,7 @@ F: .travis.yml
  F: docs/devel/ci*
  F: scripts/ci/
  F: tests/docker/
+F: tests/functional/
  F: tests/vm/
  F: tests/lcitool/
  F: tests/avocado/tuxrun_baselines.py
---

