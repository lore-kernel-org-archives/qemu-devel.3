Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3EBCE9D63
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 15:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd9Bf-00021n-GB; Tue, 06 Jan 2026 10:41:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vd9BF-0001r7-Cj
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 10:41:11 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vd9BB-0003N8-Qg
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 10:41:09 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47d3ffa6720so10903305e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 07:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767714062; x=1768318862; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4raLPLwDw2qVhH4Xs42DMzR/cpvh3kuQQFmsJx9X4dw=;
 b=q3M3dOAKxXaXq3kbf1BEYogFfBqYtsDmvwWZBzg7yQIMcS5MGvSdYPoXeBWX2fNpcT
 +y1tKxrrUMvVUPzkETujZ8cI50q1JFQVQ1BSvozQHzmtEaTHThX1iG1dtimWV5Dheh3j
 F7qsxPLibDpdSi2Si8Hjf5OhD56pN6y6fvtQigELrwv9dQD0oZmF1x78TjAUdE8vrNaH
 qeVQvIrPtn9hqq3M6jF8NWf3cPEFp3lLd4xEFydZBFlISR/6mXFOiFV+Muujzsn2ltTB
 gOfFEH1BNh/bg2lJ5rghfLv009kxDJrWhWAbg8JxLW+JIADHWrUlfjOn1zt8P1dggNAB
 3S1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767714062; x=1768318862;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4raLPLwDw2qVhH4Xs42DMzR/cpvh3kuQQFmsJx9X4dw=;
 b=I4sReeVIcfNHsIkjF1PdAo9oC0nuWLoY0Eawm+vlO6z2gzOYakfljevAeZ0ZO6Wvgb
 wsKYjSc0jXWsxwmH3ZEDo9NjwhNN0VuumpaHOxm86lkcBM64+RZtzGZZPfRKaJ/cHSRw
 jPnwGmtJiq/Sy9ZXHXm4lpkVO9uNgPh02IJHc+rOIwRMRNwKrD/W9F447jCkK8kyEwoU
 H0cthp5nc+QaiIOtKd5z+qhRN/XEQSE82TFH9LzmQHbypPIPdTLuB5enTx/BdHT5HtXS
 lxCP2ADKO5fmGVeZA8+h/zm2t2q/0sTN7CwEYULTSsDI9Zumr4VjmJgtEZTbk8YZnrFT
 p6Bw==
X-Gm-Message-State: AOJu0Yz+sZ17GHMfv27nMzSHMEZonSECgonqgaP16u9Pt6omBiKMjL3z
 +DvxRmqxNd6S+r0fuuS+d+cByKiPQ6qRqX6B1EJoEOo56+2rvybj3TCLyBpxIZE6ZhdL73nzM+b
 mUdSr8BU=
X-Gm-Gg: AY/fxX7WbBiJrmcePRFya/1sN9Ln5qDyrKtNbiKaZk52xl0smx9LS8pnMi+pXWb3GYh
 o5qoDPEJep0pbBzXRQTcVNOXJPoqzetr4Ev3j+kqI9ngsagJdR5YGfxnLKYMEiWYBs3y69qWFzv
 PuGqZUV0T9fy8dXqIKdop1SE/X3pqug102bXo7YxACBkTZEevc1HW21ukyq3rDEzMl/ZjUS3dRU
 PXkRQ45EdXaSPLwLLSIloudQl8hWQQcg91eMCVmkFrTB2ul9epTnMSEeuNpcKj2Y3jsWKvyhCqa
 /CgbtvsRWc4K5fBbJxXdfthsVKLVURj828poW+WM8haHE+59P5cUqRs6gP+3nMOmGJmEmJvHwiH
 Y8u9o4NChZzgLEk+YaeWctHLNP9qIVbfYUH59mW3vC30/R52iD9I+WZdk0QmgBwj/9hVAhnVR5o
 +s6V9ZQ9vf0LKH3uE=
X-Google-Smtp-Source: AGHT+IHIrvW9FE2+jYcDrPhMYZRQLNv+9WKs776WoIo6kaye4XpQSA1DfxfWrp2lXpnx92xKVjdd5Q==
X-Received: by 2002:a5d:5f55:0:b0:432:5bac:391c with SMTP id
 ffacd0b85a97d-432bc9f6541mr4400960f8f.52.1767714062436; 
 Tue, 06 Jan 2026 07:41:02 -0800 (PST)
Received: from [127.0.1.1] ([2a10:d582:31e:0:f4c7:3474:b1ea:cee2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5edd51sm4841351f8f.29.2026.01.06.07.41.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 07:41:02 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Tue, 06 Jan 2026 15:40:48 +0000
Subject: [PATCH] linux-user/elfload.c: Correction to HWCAP2 accessor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-fix-hwcap2-sve2-v1-1-1d70dff63370@linaro.org>
X-B4-Tracking: v=1; b=H4sIAP8sXWkC/x2MywqAIBAAfyX23IIKmfUr0cHHWnupULBA+vek4
 8DMVMiUmDLMXYVEhTOfRwPZd+B3e2yEHBqDEkoLKTRGfnC/vb0U5kIKTQjOx0E6M07QqitRU/7
 jsr7vBy0BWrFhAAAA
To: qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32b.google.com
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

get_elf_hwcap was used when get_elf_hwcap2 should have been.

Fixes: fcac98d0ba8b ("linux-user: Remove ELF_HWCAP2")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3259
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 0002d5be2f..35471c0c9a 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -708,7 +708,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     NEW_AUX_ENT(AT_EXECFN, info->file_string);
 
     if (HAVE_ELF_HWCAP2) {
-        NEW_AUX_ENT(AT_HWCAP2, get_elf_hwcap(thread_cpu));
+        NEW_AUX_ENT(AT_HWCAP2, get_elf_hwcap2(thread_cpu));
     }
     if (u_base_platform) {
         NEW_AUX_ENT(AT_BASE_PLATFORM, u_base_platform);

---
base-commit: 0fc482b73d8e085d1375b4e17b0647fd2e6fe8f0
change-id: 20260106-fix-hwcap2-sve2-8ddbcf51b879

Best regards,
-- 
Jim MacArthur <jim.macarthur@linaro.org>


