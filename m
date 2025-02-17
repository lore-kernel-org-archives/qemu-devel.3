Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E688BC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6qZ-0004Jk-DC; Mon, 17 Feb 2025 14:32:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6pA-0001zK-Ae
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:44 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6p4-0008QU-Vv
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:35 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2fbffe0254fso8694938a91.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739820628; x=1740425428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CLskJS7NaQB4gx7iCFIleGp2eUUyNj3sDlYnjboU4bU=;
 b=PlCavxctxOveuvsIymIoLT23E8JgclYTlGASFJfvqOlj/+I/QZckN7wNhLfKvh+M6q
 l8rcTyS9ibcxJkmo6VN7qPovOY9xnqBM3FAWcfQ+oAU+lVrjUk1pZPGzV/tCdB3wQGPN
 j5cNn7L7b0/j3nfJxqYmV/HfU+9sE0k7qZLOc11FMbe3rLPVcxBdhdIZcs5C62BMAso5
 BI+RhBry6iRdL/1VHoqdeUq80YRJb2kDGbUXnMaSz3dzyuoraI3RfuBX5dOtZnWDfzVF
 p84puYzvpK/NGKC9dcGBb7R55fIly7QJ1JqDQXZhw9U+b09zaXjnjN2QHaRxvLxRguZ0
 dBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820628; x=1740425428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CLskJS7NaQB4gx7iCFIleGp2eUUyNj3sDlYnjboU4bU=;
 b=hKYBLGtvAL5lEYKGwnMM6cOn6GMFRgWkezS+vR7HvlCGhB3KP4OvKQe+kft/aUiNBU
 nV+/V272GcSMTz5+ZblYbuTvnGtWdwYQrj+F2YIlvKSffzq8h5vhA0CYBhJXOi8f91C9
 vGURjZHQMEtwjeWOTlYuF51vgQMfRibeAtzQIbaMrVwO/qlrYS7vmi/0mr8ZgzsSrOyk
 qgxz7CzWnPtw5cvYkQC7mlDKpeo/1CIHaZ1VstTaikMml6qlJOLbiCzCHkq4h4TuIWNL
 bz2qRT3KjXn0T/IMQHwR+oA3NR6qpOuxSiMgInesyBrRA18my5lLxLeaUN6qyf900t6B
 kgVA==
X-Gm-Message-State: AOJu0YxRGwZOV34yYsCqfSnPRHhJ3/npSTBsclRnh2T48gnJ4KjXhZrz
 g9Cz8OXISZUNu/4QTOpjSjuze08GWfmwzSliH5878DHo2V6YNjhw2y9PE/pJgp1LqZUd1z4DofH
 a
X-Gm-Gg: ASbGncsF6ckJH8JHMnPuwGp7gqhzVXpa2ibrczNAXU+kzfvmichpcwzvGAPTLudsCTa
 GezfEDePfqp7hCKx2X3mg4+v2htrqPMNYqMyzr6cO6+xVGFMduoq2LvEmrrc4LMGck0mLG9V5Hd
 /IC/Jp39KIelS0XP9aUI+aqkEkvEUlBtohUYzu4d53mNea/meclvoYG7RRuseEU3+sV1qq3sMm0
 0Imgtq6/Od8dMlkn1+wr2Lovvq6atWgrzLB/vozJ5svJM5k39dHWV0g8/2zZYOQLoeCOlOwQN2F
 tXm4FPBY9ECrf12ieHgIBu5GMRW6S2vCZMrAy1EfC4oE9G4=
X-Google-Smtp-Source: AGHT+IEnovu11LaPCPsyNaUKJv5Wq+NpZJ/6LTwIWCYb3YkcgCquMpWX4+b/nLaHt4Kzy7cK083L+Q==
X-Received: by 2002:a05:6a00:2447:b0:732:7fc1:92b with SMTP id
 d2e1a72fcca58-7327fc109efmr6331791b3a.14.1739820628099; 
 Mon, 17 Feb 2025 11:30:28 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326a38ff76sm4347164b3a.160.2025.02.17.11.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 11:30:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>
Subject: [PULL v2 21/27] elfload: Fix alignment when unmapping excess
 reservation
Date: Mon, 17 Feb 2025 11:30:02 -0800
Message-ID: <20250217193009.2873875-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217193009.2873875-1-richard.henderson@linaro.org>
References: <20250217193009.2873875-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

From: Fabiano Rosas <farosas@suse.de>

When complying with the alignment requested in the ELF and unmapping
the excess reservation, having align_end not aligned to the guest page
causes the unmap to be rejected by the alignment check at
target_munmap and later brk adjustments hit an EEXIST.

Fix by aligning the start of region to be unmapped.

Fixes: c81d1fafa6 ("linux-user: Honor elf alignment when placing images")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1913
Signed-off-by: Fabiano Rosas <farosas@suse.de>
[rth: Align load_end as well.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250213143558.10504-1-farosas@suse.de>
---
 linux-user/elfload.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a2c152e5ad..8799e4ea27 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3351,8 +3351,8 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
 
     if (align_size != reserve_size) {
         abi_ulong align_addr = ROUND_UP(load_addr, align);
-        abi_ulong align_end = align_addr + reserve_size;
-        abi_ulong load_end = load_addr + align_size;
+        abi_ulong align_end = TARGET_PAGE_ALIGN(align_addr + reserve_size);
+        abi_ulong load_end = TARGET_PAGE_ALIGN(load_addr + align_size);
 
         if (align_addr != load_addr) {
             target_munmap(load_addr, align_addr - load_addr);
-- 
2.43.0


