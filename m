Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D66D6ACC0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 12:26:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGH7C-0003Gc-G3; Wed, 27 Nov 2024 07:25:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGH7B-0003GU-Gx
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 07:25:53 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGH79-00040G-Fu
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 07:25:53 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-434a742481aso14122845e9.3
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 04:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732710349; x=1733315149; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YPVKW+2PJwBX+oqXSrfw0EjNrh41i3t87LJ7lMy00h4=;
 b=Etos5HIGFg1NF4X5ida6iFzdcJYqYcArqpHj4WpBcMOy+WBVSOY1pVN7rUfF3nc2Kj
 4oZ9kE0pUtJ+UkQdj6IsA7dTdCnwRftaHQcweKga7fisHVCUhUJqvH0hvG+DTmyfe+Tn
 Me4nN9fbhk8CnN8t9DRKQQk2Xj+tdFe+CGLltEYf4KYLgD8rv54FMegWiF0zpum4IKM6
 QwYf7QA8IlJv665ModPHVVHhouSj1OkroOW5IR4CWztkY08yXSK1g/0K1ovzcJA1Xkxi
 dVb6Yyqxf5Sfe85Ixu0d5WDEqA5F8UCmGOxxDgKhhosN20TljNC+up+yBn2Esq2S0PzE
 +UnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732710349; x=1733315149;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YPVKW+2PJwBX+oqXSrfw0EjNrh41i3t87LJ7lMy00h4=;
 b=nlwbx3Hll/dnCbapVrJIfwos3G1jmcbnH0C2UuOINL9e3Nu+CbMmSxyYXkF4hap+wU
 LffXy3rvHr0P00EvHQe6YHIKlpPzssxeZOzmkNTvkgWRsRifdZc+YbZuFEBTwGQD8vWI
 FTp07tbeMkY6MtM2zuVTjUm+IVBVMm/bLlH9P/waPkkSgKzTN0SDHlFikYrFVk7t9J5U
 z5VXhPMhiB2ESfUcJvU6xbp5nsL4b5kUcgV7Ppq7soqCbmPpypMw2Jb4zbRpP2GuWZfW
 /U5BckAkEc7NO6jtEe6LS+7O2z7sx0K5npkKGfAVxLUsTS5FqnuyWnaGCxHuK6sN0YmD
 aKbQ==
X-Gm-Message-State: AOJu0Yymv/vtmHec0EGsOOQauM7et+j5xd9lQhYJo/Gllch5GIPJcLqA
 9A00t2wEM+ll3F3MzxoRch+28HbbYTaW2Nw5KzvLbDVmMCoi7aKrKDK1yL+YFHCoZwhXWVHuB44
 s
X-Gm-Gg: ASbGncvrkYH0TImdW7Ud+9j/GQ9vsSmyEwehTczMKQOT5pvW0oMW8T2/JSIQjf65Da/
 XOxpNT36aIXmzuE/a6udskoDz2XKsly5Ex6bdrfLYDcUWv3H2tVzlbuO4dn/IPxsbN2Gf3X34BI
 55KV7xjnXAExijpUN1jRFBw2iM6uBeN0ojokDkPRXbqiwscaA+pBFlRW7nqgSUuSoqwfkvj2cnf
 Rve3W8kWzfYBFZcrUziDPBwUgrHvBhjHxbnLdoBZFA9Sd3RjZoxcdpSeytdFnk8ulNL4t2aFU84
 hgY0DSf++slIZ0zXh/dZHYh2aVgNX5uYihey
X-Google-Smtp-Source: AGHT+IFKSl2h1NI/p0tdu4mmd38dqJG4jtrT8DdieTb7OIrAdZWVD10SxpsTIXcstZl/5D5Sl09PRA==
X-Received: by 2002:a05:600c:19d3:b0:42c:a580:71cf with SMTP id
 5b1f17b1804b1-434a9e0f01cmr27236505e9.30.1732710349357; 
 Wed, 27 Nov 2024 04:25:49 -0800 (PST)
Received: from [192.168.69.146] (plb95-h02-176-184-14-96.dsl.sta.abo.bbox.fr.
 [176.184.14.96]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa74f1f6sm20263155e9.8.2024.11.27.04.25.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 04:25:48 -0800 (PST)
Message-ID: <7103f10d-5852-4c07-83d3-8e25fd3a0578@linaro.org>
Date: Wed, 27 Nov 2024 13:25:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 4/6] include: Expose QemuArch in 'qemu/arch_id.h'
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20241127121658.88966-1-philmd@linaro.org>
 <20241127121658.88966-5-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241127121658.88966-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 27/11/24 13:16, Philippe Mathieu-Daudé wrote:
> While QEMU architecture bitmask values are only used by
> system emulation code, they can be used in generic code
> like TCG accelerator.
> 
> Move the declarations to "qemu/arch_id.h" and add the
> QemuArch type definition.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/qemu/arch_id.h     | 28 ++++++++++++++++++++++++++++
>   include/sysemu/arch_init.h | 28 +++-------------------------

Alternatively we can restrict TCGCPUOps::arch_id to
system emulation, using in the next patch:

-- >8 --
diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index ec3d2b50a9e..6fe0e1a7e97 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -19,8 +19,6 @@
  #include "exec/vaddr.h"

  struct TCGCPUOps {
-    QemuArch arch_id;
-
      /**
       * @initialize_once: Initialize TCG state
       *
@@ -58,6 +56,7 @@ struct TCGCPUOps {
      void (*debug_excp_handler)(CPUState *cpu);

  #ifdef CONFIG_USER_ONLY
+    QemuArch arch_id;
      /**
       * @fake_user_interrupt: Callback for 'fake exception' handling.
       *
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index b37995f7d0c..31a2ab18e7c 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1072,15 +1072,20 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
  {
      static unsigned initialized_targets;
      const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
+#ifndef CONFIG_USER_ONLY
+    unsigned arch_id = tcg_ops->arch_id;
+#else
+    unsigned arch_id = 1;
+#endif

-    if (!(initialized_targets & tcg_ops->arch_id)) {
+    if (!(initialized_targets & arch_id)) {
          /* Check mandatory TCGCPUOps handlers */
  #ifndef CONFIG_USER_ONLY
          assert(tcg_ops->cpu_exec_halt);
          assert(tcg_ops->cpu_exec_interrupt);
  #endif /* !CONFIG_USER_ONLY */
          tcg_ops->initialize_once();
-        initialized_targets |= tcg_ops->arch_id;
+        initialized_targets |= arch_id;
      }

---

But it add more #ifdef'ry and doesn't seem worthwhile IMHO.


