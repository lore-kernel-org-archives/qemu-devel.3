Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F28C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 12:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqtIr-0006X2-8R; Sat, 08 Mar 2025 07:29:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqtIU-0006SY-2J
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 07:28:56 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqtIS-0002At-HO
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 07:28:53 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3913d129c1aso223115f8f.0
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 04:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741436930; x=1742041730; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bJ87N+2KXZXtdZu2WpJSCBt2aVSM5GEZOX3NVdYChCE=;
 b=Bab3MX1y6+A2nQWpSa1wm+RN/sSy39h09MToWRAzCUT9y6IPMVqmQwibVpzKOZXuIf
 wPmWy+dDkoL+Isa3IuHIa1kJIS+clDi/nFeyr6E4UrzVPYjR80jRJtpuTcoZzvjOWDEV
 wCTRTUOIyCeGRnwySmuSrK7OsniG1yDoym1TJPeHqgLZlpliQHV2ZCKQaSUGv1f3sPZJ
 vqHeW+XrzpVDjGzmwGBOu8hDQhKnCPD76Z959/Bii6sCzs4kjOH79/2YQgb490Dw/HI0
 Cgklg4HPKm6UTN/g+EVjX+q4D1/blzdfKorLSFBWXMlhL2RaFUAx/WtMLj5dQA6R2IbS
 Oeow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741436930; x=1742041730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bJ87N+2KXZXtdZu2WpJSCBt2aVSM5GEZOX3NVdYChCE=;
 b=CJ497Ik27amfCKTB0i6i47fNoHfqARFjjBE2XInp90yWpga1pqExjUAgzLzCRHU4NY
 mmRc7IpqqjoTvjx1BZLNEDQxJmfzlmv39hlidACOquXN7bc+kpLV0+Sg40xDdIpwuVDR
 oES8HhU72Of149qMESZR0ijgA6MA4vFGOyOhooDByNKoILeF4HOLP6IfIJXJSdb+4uGx
 VS4cVA12jyYFRSiFmctZqx6w+CgoDvEkqt+HzkCl6m0sIJzvPNHF4mh94KqbgV//suUF
 ebpasuIUf5nNiby/MOKf8jjZf/+UNdW/UgdrmtBddHBAV2tuGGC25FfUAuTSVzkH5a03
 yvFA==
X-Gm-Message-State: AOJu0YyQxx7ub5hFmzkH0iIvSXVk9OUx3kkeyC1qvqWhEa+2xaxqFlQX
 yTun+ecGXsTryGzXu8R7grdu1wZwVjuxKl9u7cBt3sXBHS9ZmABP+DNN6cUEcmySS5KnDoIZOPk
 vo64=
X-Gm-Gg: ASbGncvUgzxG8NADsSb16iWK3b5Gfgt17vKc2y77FnZ/FsgUvf8NH/n8RJK23XLIAaT
 eOXuqptQJwwoHnQ3ADk8B/Uy2e+mvYrqRIIry4y2AY+86PEy4URUSv5ZrQfnM1tBP7xg4EEY7EV
 RQVpcrXsN0l3rin3IAmty+uMe70ugSmJdyhcQEoEG6NfSUMVInz3+nkzfHs2IzEE/Z1iY6Gifnv
 EF0kG0/Wcba8SUt59hhFTmtFySnmo/V6rPkBIbZ0D613dTNcZLVn5TIF8DoYK3tibWnZbJaI9Ki
 fixO27cqwsCSw169u1VsTEGPSYv0peGdggDHTtUXcE+GYCniLmNCvXJeS+80mzYylxkEW7NdnJ0
 CRiEp2mqdX0Ad0fInh5E=
X-Google-Smtp-Source: AGHT+IF1zAlRHcCE7HeQPpV1KJ6CxscezPz+MVGX+/3jauJK9t8/DKG/AwOW9MeSy7Sd+4Qc1BRKcA==
X-Received: by 2002:a05:6000:18a9:b0:390:f025:9e85 with SMTP id
 ffacd0b85a97d-3913af2e4bemr2293185f8f.21.1741436929959; 
 Sat, 08 Mar 2025 04:28:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cea8076fcsm16162575e9.15.2025.03.08.04.28.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 04:28:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 1/3] bsd-user: Always use mmap_find_vma_aligned() in
 target_mmap()
Date: Sat,  8 Mar 2025 13:28:40 +0100
Message-ID: <20250308122842.76377-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308122842.76377-1-philmd@linaro.org>
References: <20250308122842.76377-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Massage target_mmap(): calculate alignment once, then
unconditionally call mmap_find_vma_aligned().

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 bsd-user/mmap.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 346f2cefd32..dfa6e728ab5 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -489,13 +489,12 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
      * before we truncate the length for mapping files below.
      */
     if (!(flags & MAP_FIXED)) {
+        abi_ulong alignment;
+
         host_len = len + offset - host_offset;
         host_len = HOST_PAGE_ALIGN(host_len);
-        if ((flags & MAP_ALIGNMENT_MASK) != 0)
-            start = mmap_find_vma_aligned(real_start, host_len,
-                (flags & MAP_ALIGNMENT_MASK) >> MAP_ALIGNMENT_SHIFT);
-        else
-            start = mmap_find_vma(real_start, host_len);
+        alignment = (flags & MAP_ALIGNMENT_MASK) >> MAP_ALIGNMENT_SHIFT;
+        start = mmap_find_vma_aligned(real_start, host_len, alignment);
         if (start == (abi_ulong)-1) {
             errno = ENOMEM;
             goto fail;
-- 
2.47.1


