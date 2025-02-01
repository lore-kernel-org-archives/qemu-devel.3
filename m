Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3EFC0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGZ5-0008RJ-5w; Sat, 01 Feb 2025 11:41:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYf-0007Pn-9n
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:27 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYd-0001Jx-IP
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:24 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38789e5b6a7so1611500f8f.1
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428082; x=1739032882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qymzXrO+9F4JBSFIAl0zaVLUHcekNoeWY0bsti7Y49Q=;
 b=PcbTa1r7Czsw2GvxssBQV4Mh/wHgQ/Ik4f9eTPTYW24m0hGETmjMSU2OfIFBCHLffY
 3FOHiHhquz60eEvagQZh3EEBzyelbbhGC/UTJlyaAT4zoD3TelE88rlGmsgAKFYNhmFZ
 /TAsiBEOb6puOXe8eLqbiTG6vn5crWQxmGcUj5QKXFsd5ZP2seK6g6L/iAmOKMjnOzpy
 tDoI/K4N9/A8Cq2y7Q9hOSwtZXnJGfojzczqGBo9azHxEkGjF8BxtnGgzQmCRtVttehh
 tHD8IEE/91UWhyiCvyEA011y2SMU6YXY+BSMYrTXdBidmZ3Lz9vtZ3mqnGs1H7DjqmeD
 2KJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428082; x=1739032882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qymzXrO+9F4JBSFIAl0zaVLUHcekNoeWY0bsti7Y49Q=;
 b=c1dgXzTLwAIMNyaNuiC+v8EUytoLfcXLO/Sm6FYsxWv6TC4/mArKHgH87GX/kde2jz
 /rhKPs2jzbIll9KLSX3S4lmMa9ySxR95SthibUc+7neDUhMRI5wmCqS4kkRH1olyBwwT
 wmWySKdheiDt1GmLJYLNC+VSaaeb2olCySLu/z3ZJrE45hyUwFIpoM26rkVhy4KzcbxD
 bPxWnu33N5e140r5OcWZPcXhyCwr3iR+5mgqOHD7QoppqwTD0ZZfeDRieDCJX37bJv6C
 Bofe8vkBnUWkkAaW226ISEoovPZ878dYRzC4GcmXaSHs8DN9yajqAo21Htwt7ErKDiNB
 NbmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqR1fzTmUGkp6RnMeKZvkh9COxpUiX9PpoZN5HU8n9MvTDhUTJCqABWO5nA+1uOBG8bsE7Od4V5W/Y@nongnu.org
X-Gm-Message-State: AOJu0Yx1uxWuGv+G7iFROLrJyK1A94KxdPIGmNBwJYbhmwSj0VNcoKkH
 OyjbIdGsfL7CZJQwrS4Kf9P+4/aKed1gBq5go8q08+pNc8z2soDC+mWZ1hODV3DlFSFbe/kgKhL
 n
X-Gm-Gg: ASbGncuWqLMVrDrHcc9uQ+NrGmDOCL4Up5udMu4M8MnYKJcsqppmGJvSvKIvlN2rDgh
 c84lY0hyXAmtIhSwv+XNMX02mog1BYuOS3vZMRZTAu2xH697X67g1KsAlSWB63PpqUZrdoeXWwf
 NM/ak3JQD6YqF5jIbvVWkzcHvP/ZREvW99y4HPK6CXjQoRxsuGvKfn9b7csW0CndrjBxML+4EKe
 MudVKDFcOCLarLGugPWpVP2xi3S1fuOZbArMJ4Kbl7TzKijOlaByWM9e0AmxbTB33xN6ot/4ZD7
 yJuoSCaEHE8OZ4yJrKjT
X-Google-Smtp-Source: AGHT+IHwhMx3rtq5vB02NTMHUnJwSLOWjqT3s7Gr6+lLs9qehwzYUT6a+b99stMWMF51DtbjX3Avlg==
X-Received: by 2002:a5d:6489:0:b0:38c:246f:b0b3 with SMTP id
 ffacd0b85a97d-38c52097871mr13913178f8f.51.1738428081810; 
 Sat, 01 Feb 2025 08:41:21 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:41:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 52/69] target/arm: Enable FEAT_AFP for '-cpu max'
Date: Sat,  1 Feb 2025 16:39:55 +0000
Message-Id: <20250201164012.1660228-53-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Now that we have completed the handling for FPCR.{AH,FIZ,NEP}, we
can enable FEAT_AFP for '-cpu max', and document that we support it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 60176d08597..63b4cdf5fb1 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -20,6 +20,7 @@ the following architecture extensions:
 - FEAT_AA64EL3 (Support for AArch64 at EL3)
 - FEAT_AdvSIMD (Advanced SIMD Extension)
 - FEAT_AES (AESD and AESE instructions)
+- FEAT_AFP (Alternate floating-point behavior)
 - FEAT_Armv9_Crypto (Armv9 Cryptographic Extension)
 - FEAT_ASID16 (16 bit ASID)
 - FEAT_BBM at level 2 (Translation table break-before-make levels)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 93573ceeb1a..0bc68aac177 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1218,6 +1218,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR1, XNX, 1);      /* FEAT_XNX */
     t = FIELD_DP64(t, ID_AA64MMFR1, ETS, 2);      /* FEAT_ETS2 */
     t = FIELD_DP64(t, ID_AA64MMFR1, HCX, 1);      /* FEAT_HCX */
+    t = FIELD_DP64(t, ID_AA64MMFR1, AFP, 1);      /* FEAT_AFP */
     t = FIELD_DP64(t, ID_AA64MMFR1, TIDCP1, 1);   /* FEAT_TIDCP1 */
     t = FIELD_DP64(t, ID_AA64MMFR1, CMOW, 1);     /* FEAT_CMOW */
     cpu->isar.id_aa64mmfr1 = t;
-- 
2.34.1


