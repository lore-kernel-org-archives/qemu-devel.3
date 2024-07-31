Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A7AC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 12:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ8si-0006KN-67; Wed, 31 Jul 2024 08:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZ8sg-0006CW-70
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 08:56:38 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZ8se-0008Nb-GO
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 08:56:37 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ef2c56d9dcso73815821fa.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 05:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722430594; x=1723035394; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AK504CrbjKyIKsoqlY59MxTzWmq3hgVDrxhHvVIpBhw=;
 b=Ep0LmHd/Zh/bT7mWFcq2XUBFhF1fjnIyQ/D/qxKqHreGh7tlk4u8EoMt32EzlwKBZ2
 AAB32qrQI8v0J1nM90zIx60pTDFACTCrwUh+2zjhZwWPRalh4lX2u8v6l8BQyRIzbi+/
 wyXCRDlNTp1u2JjXp0ICKsPehCMkb/uLj/FRMWUxO/3UQ6F29hcNI9q6ZIKbcDYSaIEz
 DcuP08Kv6hMnOk+kR4TkZ+9Sxkzjx848TgGhXJNMF5jxPGInOGZCiA109kOJQnso9MAe
 TBaJ54Ln6L8Pw0tAjxsuRG/ZZReSWD0Kd+bTFs9SKJxi+7xlA7QhhqSmh2jGxyzDbmbs
 19Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722430594; x=1723035394;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AK504CrbjKyIKsoqlY59MxTzWmq3hgVDrxhHvVIpBhw=;
 b=RD2BYXqNPRfJFxjh3DJ6TrWvbmPHsofTvtmVMGlPDpjAzmh1Ukb4PEak+B70L6DQSN
 +SpTzpaTUpaeodsukI0OqZJwfjSILCZW4i4ReBJRIe1bql9jovlvtsLN529HAHsKq8FN
 Q26sn38n0bKPYzK4kMHCcPDD9iu317mHoo4k6yBeyUimEvkb6HXpkVkAxwECq35/JFis
 ruOuR+pUtXsSo7f2tXARe4uAhKmYQlKtYQ+YKOfXdlFhwW7//m/7/m7rfl23KI+li0aS
 HbLB/wEZPdy7wQCa7FpxtO2c11R2VIXr5BuMJJtNVlhz+4wo7g5q1iqwdED8LTHmmqYI
 erDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5I5gzKCXOeIynLBXdWQf9N38FvAeXAtdMhXRmoSDMmn/cy39rXylL2UZSRGTS2qqUOQgnpRtYG46OT5eoxHYiCuVTRJQ=
X-Gm-Message-State: AOJu0YyxlxPvrn9jrDBl2IwYULiKgMceWxZnf9jBJrd0QTtVIdLVcONb
 +EMUNu8jgnUNT9d1aKcfNljHF7fgeDKhJ1mIxTKnXcaPobx1/uVLjU3j1Yg5274=
X-Google-Smtp-Source: AGHT+IF5KxySbbFIb4o7k6TYejg1U9YQemar7GAVTXaYjTkMrKEkc6S+pivK1CcdeYL+hSqhACz7lg==
X-Received: by 2002:a2e:964f:0:b0:2ef:2b56:36a9 with SMTP id
 38308e7fff4ca-2f12ecd297emr102645641fa.16.1722430594359; 
 Wed, 31 Jul 2024 05:56:34 -0700 (PDT)
Received: from [192.168.214.175] (29.170.88.92.rev.sfr.net. [92.88.170.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282babaa2esm21212345e9.25.2024.07.31.05.56.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 05:56:33 -0700 (PDT)
Message-ID: <9fbf2f80-c7df-4819-8f74-c7ce75dc70a5@linaro.org>
Date: Wed, 31 Jul 2024 14:56:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/24] tests/functional: Convert the riscv_opensbi
 avocado test into a standalone test
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-17-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240730170347.4103919-17-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
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
> The avocado test defined test functions for both, riscv32 and riscv64.
> Since we can run the whole file with multiple targets in the new
> framework, we can now consolidate the functions so we have to only
> define one function per machine now.
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/avocado/riscv_opensbi.py         | 63 --------------------------
>   tests/functional/meson.build           |  8 ++++
>   tests/functional/test_riscv_opensbi.py | 36 +++++++++++++++
>   3 files changed, 44 insertions(+), 63 deletions(-)
>   delete mode 100644 tests/avocado/riscv_opensbi.py
>   create mode 100755 tests/functional/test_riscv_opensbi.py

Please squash:

-- >8 --
diff --git a/MAINTAINERS b/MAINTAINERS
index 98eddf7ae1..a906218f9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -336,6 +337,7 @@ F: include/hw/riscv/
  F: linux-user/host/riscv32/
  F: linux-user/host/riscv64/
  F: tests/tcg/riscv64/
+F: tests/functional/test_riscv_opensbi.py

  RISC-V XThead* extensions
  M: Christoph Muellner <christoph.muellner@vrull.eu>
---

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


