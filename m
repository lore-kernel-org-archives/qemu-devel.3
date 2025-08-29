Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F13CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN7q-0000OF-5r; Sat, 30 Aug 2025 11:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urt66-0005u9-9R
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:00:30 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urt64-0003w3-Bh
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:00:30 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45a1b065d59so11121085e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 00:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756450826; x=1757055626; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8mDwc7859lUawsk8WvPSdQIfrO/qUoTqwkKzFjnxmlk=;
 b=vaNz+0AzWRmAtZ5K3Pad8umzvjGajgOiJ5zhTCeL1QFRNU4ne9DCQqseNJ73Pa8wNV
 RrVaNvtGIOXBPg4Ti57oK7uGSKaQimrLwgRDUoLXajk6iuXqDMcOMByAiRPkxCXzMIgn
 Ny1U+6dkL/BWLfSzyClrpvTANtg74z49F9k/RP8kVYG03nYWSVWZU3rWS4e6KNHSe68I
 Fwe42Kzylel68Rreor7WbrD5d+ItFHuqkZUzN01emgBG+D8sxYcNt2IiaCLwJw0sfAjS
 e+oGtunKGpcH3g6kYhygUECh/zgRur0EkZkOYJXNwRAUMmbJ9S8kzyDk8ycXQMm445Gg
 531w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756450826; x=1757055626;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8mDwc7859lUawsk8WvPSdQIfrO/qUoTqwkKzFjnxmlk=;
 b=c7whS3w8KN0BciNY4Agj4EhD77cMDqSdpF6YnWpzMadbsFK50dS+CJ1h7bpnyTegB5
 3zDamXE5pRaDKMu8xFJo/aNf4ccSndG5cmBGfHT51AUkGCwg398JcoPXgrBMVXCKuT2F
 ikwDdes9/tQA3vrzuJBcHkR6npkbaIk/sBldqG+pFDnBzvXz5RPPEEXquWNCNWhx2+2j
 rQLzQR1+5w77Zb1YJ92rWkRLFaCVoyuult8pHGpaPw+t+ZrVwbCLWLRZdzrXrIJzL8+Q
 dN1rtT4KHyywyG2SH/P6/eiO0+hxBxKGlfmorjM8tQuo5Ube9oQVVbvqWuCYG810SWB4
 +0kA==
X-Gm-Message-State: AOJu0Yy9GimpO+C4IJSLdAnVKBMTvLDeo3HQcwHNee+5QStB18OP+IiA
 W10WdJf31tB2e4w53YVL/LN4ES2Bi1KuU+dcNMS30Q3/QbWcaRfDtXj0nkjK7K/uJbKLs/TUSpR
 KoBdiF7Y=
X-Gm-Gg: ASbGncuJxQcj6NHTV1kQp/UTsthEklBJae2WDyn+0lShUPM1oLQvR0ywEdTevIo8fAX
 ychCiUbITdCn3m4Iq29O+C+di7fXuLXVb0IGCoCn6FvJSBMer8IJBEBM3maK2IOnPFpjRHWuLrt
 578PmoZTkz5DQlOjYotdqxs9fXiMIZcdSvGJ2rdxFcO3sqVU96x8dYYiuee9DYgX3vwDtaTfakX
 3C/FVU/LGGH7ytASlhhlkQMoCSJdCoo9lIB+80B1QaKmy0X1ssimu0vmnkwfqc6e7dp7ddHFDYS
 ONZOfCkiTW2NsCksMo7qKkVNd7vM7PVvSY/zRzJ2T7exHyj/djRVn6MsuPo8ClQ1QANzhKV23yI
 wXPELg8axxP5MZ1USFOHp3A7IjkT8V/gOg0bPfNTCAhT2GymsNDftUV5OlMxs3w3V7NIs8C1p
X-Google-Smtp-Source: AGHT+IHPYF6amWyn5ekA2SxAYNR1XU4lzwddYmnEBpzfzVgX4WPX9oAZMW76zcsB2+m55Nl/R+eNAA==
X-Received: by 2002:a05:600c:190a:b0:453:5c30:a1fd with SMTP id
 5b1f17b1804b1-45b517954bfmr255114055e9.8.1756450825994; 
 Fri, 29 Aug 2025 00:00:25 -0700 (PDT)
Received: from meli-email.org (athedsl-4441256.home.otenet.gr.
 [79.129.180.152]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b73c52735sm85216535e9.22.2025.08.29.00.00.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 00:00:25 -0700 (PDT)
Date: Fri, 29 Aug 2025 09:59:22 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org
Subject: Re: [PATCH 05/61] target/arm/hvf: Add KVMID_TO_HVF, HVF_TO_KVMID
User-Agent: meli/0.8.12
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
 <20250827010453.4059782-7-richard.henderson@linaro.org>
In-Reply-To: <20250827010453.4059782-7-richard.henderson@linaro.org>
Message-ID: <t1qu4o.3fgegimfxo66f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
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

On Wed, 27 Aug 2025 04:03, Richard Henderson <richard.henderson@linaro.org> wrote:
>Conversion between KVM system registers ids and the HVF system
>register ids is trivial.
>
>Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>---


Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> target/arm/hvf/hvf.c | 20 ++++++++++++++++++++
> 1 file changed, 20 insertions(+)
>
>diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>index 7b0413093d..47165bd29c 100644
>--- a/target/arm/hvf/hvf.c
>+++ b/target/arm/hvf/hvf.c
>@@ -403,6 +403,26 @@ struct hvf_sreg_match {
>     uint32_t cp_idx;
> };
> 
>+/*
>+ * QEMU uses KVM system register ids in the migration format.
>+ * Conveniently, HVF uses the same encoding of the op* and cr* parameters
>+ * within the low 16 bits of the ids.  Thus conversion between the
>+ * formats is trivial.
>+ */
>+
>+#define KVMID_TO_HVF(KVM)  ((KVM) & 0xffff)
>+#define HVF_TO_KVMID(HVF)  \
>+    (CP_REG_ARM64 | CP_REG_SIZE_U64 | CP_REG_ARM64_SYSREG | (HVF))
>+
>+/* Verify this at compile-time. */
>+
>+#define DEF_SYSREG(HVF_ID, ...) \
>+  QEMU_BUILD_BUG_ON(HVF_ID != KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
>+
>+#include "sysreg.c.inc"
>+
>+#undef DEF_SYSREG
>+
> #define DEF_SYSREG(HVF_ID, op0, op1, crn, crm, op2) \
>     { HVF_ID, HVF_SYSREG(crn, crm, op0, op1, op2) },
> 
>-- 
>2.43.0
>
>

