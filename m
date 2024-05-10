Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4634C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 15:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5S0f-0008Op-NB; Fri, 10 May 2024 11:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5S0d-0008OZ-TD
 for qemu-devel@nongnu.org; Fri, 10 May 2024 11:18:08 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5S0c-00088a-3x
 for qemu-devel@nongnu.org; Fri, 10 May 2024 11:18:07 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2e428242a38so32360101fa.2
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 08:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715354284; x=1715959084; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PPoMkfZCmMQ3+G5MBiAD4+xCe8kdoS6PWza0l0xIpSk=;
 b=nB3tSDXTHsUUj2hZq8m69XTRFOr9rHGHhN4v19CzW/il/ODfsSyWMKU0weYLJ377SO
 UcbhE7TQ9JbrHXL80M9P6UTnWn/F1MrBpqifxco+VMP8k7JhboV0epmWW5t3kkQEeVHF
 zkD1hvV19NUcNQFcdqED8VTztQI7VYq1WQOyArtL2DqtuZ59amkAZ+o0cebQErf9db1O
 pG6p041RFJZaX/YzyXlfGyWtdpEoWaon2tP9H6glfGXaAjvkuSJN/FKY2K6ty/kcPSZr
 OAl3enMahUeAuBSCYQKVSQtJUEiERhZHbsGAutOXrSOil54CRf/9lIvqYJ3oyaudI6go
 BYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715354284; x=1715959084;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PPoMkfZCmMQ3+G5MBiAD4+xCe8kdoS6PWza0l0xIpSk=;
 b=f5DDTMMx4QfpIaRL23nwdNX3Sn6/Gy6CEJSWWeZNk198FH0+6l7iRbpwugnuNO2cSM
 FWhGLUrVWkhJJVN197QTB9XyIcHKSw08GOsVeKHWXPPWfpzlNI4ULNOKlMSLn3+sc0HW
 j3MA1uzuaVT2xA2DuOfyqMdFTUB6TTEu6D7sINONJo66jAcINduvJyDWQhUvnoyLRuik
 OIM86j6kYlL+OykuUTKlNNtisFTZ1tc6Og08dS09G1DJhBIQXE0JRXzuiNi/7xcdSi9E
 nDiaU0WBs7M8iq9pZHsppio3Z4+82/24QWiVK+n64tR7y0rf8p8SIu92OtmKl2W9mIs3
 zBjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/chk7H5yacmOzpoDbziu+GgbbTr9GblRKpOXjHkICFOpi2AIza+k1Uu6kq62MEqUKebcUsgs3b9NPFX61xrmBr9nK3hQ=
X-Gm-Message-State: AOJu0YwYDzZZS93ShzIMGyHaC1XhtJuYfHd6XqKEV8S/6yBIL6MRTBew
 aVEJY0122TVkLYdUiI/F8h45VSnYTlE2mFYh1lfA8BmQ8e+FIUmKl5JgWLDasV8=
X-Google-Smtp-Source: AGHT+IFD57DihRZinHVmu0c7wttZrGM6t0et+BC2/5bWiKIsfnpLnmjb5XVPKdq9KWBaNxzQSV+pkQ==
X-Received: by 2002:a05:651c:2114:b0:2e1:cb0f:4e1e with SMTP id
 38308e7fff4ca-2e51fc34061mr26931121fa.2.1715354284009; 
 Fri, 10 May 2024 08:18:04 -0700 (PDT)
Received: from [192.168.69.100] (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a179c822fsm193293966b.138.2024.05.10.08.18.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 08:18:03 -0700 (PDT)
Message-ID: <d9d8d90a-660c-4393-aa47-d2bdf2c05830@linaro.org>
Date: Fri, 10 May 2024 17:18:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/41] target/sparc: Perform DFPREG/QFPREG in decodetree
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com
References: <20240302051601.53649-1-richard.henderson@linaro.org>
 <20240302051601.53649-9-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240302051601.53649-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
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

On 2/3/24 06:15, Richard Henderson wrote:
> Form the proper register decoding from the start.
> 
> Because we're removing the translation from the inner-most
> gen_load_fpr_* and gen_store_fpr_* routines, this must be
> done for all insns at once.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/translate.c  |  18 ++--
>   target/sparc/insns.decode | 220 +++++++++++++++++++++++---------------
>   2 files changed, 138 insertions(+), 100 deletions(-)
> 
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index 6a6c259b06..97a5c636d2 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -241,34 +241,30 @@ static void gen_store_fpr_F(DisasContext *dc, unsigned int dst, TCGv_i32 v)
>   
>   static TCGv_i64 gen_load_fpr_D(DisasContext *dc, unsigned int src)
>   {
> -    src = DFPREG(src);
>       return cpu_fpr[src / 2];
>   }

Optionally squash removal of the macros:

-- >8 --
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 0efc561d4c..f59d08e9e4 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -193,10 +193,2 @@ typedef struct DisasContext {

-#ifdef TARGET_SPARC64
-#define DFPREG(r) (((r & 1) << 5) | (r & 0x1e))
-#define QFPREG(r) (((r & 1) << 5) | (r & 0x1c))
-#else
-#define DFPREG(r) (r & 0x1e)
-#define QFPREG(r) (r & 0x1c)
-#endif
-
  #define UA2005_HTRAP_MASK 0xff
@@ -2083,3 +2075,7 @@ static int extract_dfpreg(DisasContext *dc, int x)
  {
-    return DFPREG(x);
+    int r = x & 0x1c;
+#ifdef TARGET_SPARC64
+    r |= (x & 1) << 5;
+#endif
+    return r;
  }
@@ -2088,3 +2084,7 @@ static int extract_qfpreg(DisasContext *dc, int x)
  {
-    return QFPREG(x);
+    int r = x & 0x1e;
+#ifdef TARGET_SPARC64
+    r |= (x & 1) << 5;
+#endif
+    return r;
  }
---

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


