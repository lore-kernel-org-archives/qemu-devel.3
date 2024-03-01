Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1A5C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgBy6-0005Gx-Nd; Fri, 01 Mar 2024 18:07:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxq-0004vj-Mw
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:52 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxp-0004GG-57
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:50 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1dcd6a3da83so20220675ad.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334408; x=1709939208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fLzyN00Ww9I7UVC17/1x1fEMCCUgdxWcszCn7cBZ/1g=;
 b=GQFkxJp7FdjlEqaKG6Y6wINtyrrAyPg3+oQfUicYG5PXGgZ+fHqCRDKwQv1bKti7V6
 hzRjQd89+jYqKgqmpAXbnKP3JV1thn4U2CAfOhg78MFMcExaAYybTuIFmQ3cRxkrXvOd
 5+bBtr6rwwNTvWSJk5Ivw4NmRGcOX09UHe0PvJh2s0XcrfAVthveB5/ykjXbTNMEC6eN
 IR07x3PIPIn2IsQXgRxYGMVoDpmB3VXS6H4Zmi920bQh3UgiX9//5J88umdUS50eyXmC
 LxeAZcSWy7fGWDThgEaK/3WFRgGm0XByeE7pMyuZh8XcqRv19TInTeIPNori5YAa3VZk
 juAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334408; x=1709939208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fLzyN00Ww9I7UVC17/1x1fEMCCUgdxWcszCn7cBZ/1g=;
 b=w1Ma/jbKBc4RC2mE9YqN224ovCtf+wUa0i1oh/vcLy0Ia8UXQ6FBwBGPZpOcNU20vo
 22aNkre6v9deBBmGsjttNkZqgyiFkffwTOO9QY3CrJsl+pvQ8WmtNzIo5vUslI6T5mBp
 f/m7pHoH5bpMSDqRkMSCrWwuJO0IeMN1oIkKKxNw9g8Nx+JN/KozOAQlOPukWMRWiKvU
 A4TDLRbQJjmqc6YL5CYZDo/fxMpLYqYOaZFFZVuoGiBhJxHF/iIWiLWepf8/4QWK7ReR
 WfF6QbHsNp1ZzKoMwAUUrtFhCVv/hxNBiJLF+6wrsPOqJ/1vGQgbW9irW8ET2YEp5SZd
 5o7A==
X-Gm-Message-State: AOJu0YxYJ7sUJQKehqiwyoUPQNGsX80M6xLDQTi2y0DRQC0is+1sgqSv
 XVDtYViuZgC9iFjj0geE81STnZKhyZ0Y7pM5RWzaS1hkxS3xJwHKc6Iiu7yfZEC4ExVXXzzKl8x
 L
X-Google-Smtp-Source: AGHT+IHxweZfhk4PaCLoafF4gl6XSO4Lh9KhArLeXTdfKV5RFwIBrcjVw+CAcsqmHn7kzD0QrBnirw==
X-Received: by 2002:a17:902:dacc:b0:1dc:b2ee:c7 with SMTP id
 q12-20020a170902dacc00b001dcb2ee00c7mr4090566plx.14.1709334407974; 
 Fri, 01 Mar 2024 15:06:47 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:06:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 19/60] linux-user: Adjust SVr4 NULL page mapping
Date: Fri,  1 Mar 2024 13:05:38 -1000
Message-Id: <20240301230619.661008-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use TARGET_PAGE_SIZE and MAP_FIXED_NOREPLACE.

We really should be attending to this earlier during
probe_guest_base, as well as better detection and
emulation of various Linux personalities.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-3-richard.henderson@linaro.org>
---
 linux-user/elfload.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 38bfc9ac67..a51518f817 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3912,8 +3912,9 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
                and some applications "depend" upon this behavior.  Since
                we do not have the power to recompile these, we emulate
                the SVr4 behavior.  Sigh.  */
-            target_mmap(0, qemu_host_page_size, PROT_READ | PROT_EXEC,
-                        MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+            target_mmap(0, TARGET_PAGE_SIZE, PROT_READ | PROT_EXEC,
+                        MAP_FIXED_NOREPLACE | MAP_PRIVATE | MAP_ANONYMOUS,
+                        -1, 0);
         }
 #ifdef TARGET_MIPS
         info->interp_fp_abi = interp_info.fp_abi;
-- 
2.34.1


