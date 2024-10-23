Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D34BD2E010
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 03:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3S9V-0007PE-TH; Tue, 22 Oct 2024 23:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S95-0006zp-O5
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:52 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S92-0008MY-JE
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:51 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7ea68af2f62so4874617a12.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 20:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729654486; x=1730259286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E9BZ1D2dqbD5itfvWww7sIn9+uEnlW5x+Ejm53Jry8E=;
 b=IkRIFIesPfdi+wUdXS20D6AKTUCXhaRJDaUPU57HaAjQb95//d0wjFK+GNMZFSp8Pp
 lfzaW3wDjk5Cd9lowBbBBTakbsN/WuxjOtBtlW0LHqruYsW+t0fEBu9KnUYWVwudCEPN
 Xlg5RhoEyVubxX9LzSxCwBHeWhvItlONF6zEcSs2+mYCrf4O3c7EXbaLuLWJvRLNNLUf
 Wd8NVLUc06EpcczL8GdC8/M5rUQL1ym2lcKvnWWQcFlicRUU7x+24OxNSXl3FqCnhHC9
 LhvsgWmzdNtrkNTfrN7XdwiGQdebYO8aCPiQvThEVKBBOC3wMKknV/stIFbVMnbKATqQ
 t75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729654486; x=1730259286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E9BZ1D2dqbD5itfvWww7sIn9+uEnlW5x+Ejm53Jry8E=;
 b=YR4/k5PqBrfhfD3HczoW/55o5Uq5mLib7+R/8tab91rdM05sCHiTIdNTQrbutgZMYl
 QPAyCMySJEGXIKwhwRzKIMR40ODyyxAbt5keVtkmGMR9pNSKhT6Ozb5Fa0hbjhqMNSKH
 HybG5Mqm+/9XHSUV8ddpdsSEhg01xnmACE44HQ919SJUYTxT8gIEuipFV6qvc/dqWPhq
 9W1jVQuixEstfvhODDuERzyyB5V22TlxYOBIDwgY1CuH1fa1INqjDU//IFzbNucw8rpK
 C0LmjC2vlQM6G4nRbPXeeK0QnUmbVMBsv87Px7NFTg17JkbnO+04L8igzf3MG6DUYlXf
 XR+w==
X-Gm-Message-State: AOJu0YxkcFizdY8CusCZz1JqzwN9kf9Dsy3VKw+8+TMQhyUf9gMkyd9f
 ZQgGosWKkiQHas4zodPDEc7bFWY9sEg8b+EcpUGYZ/WxsjL3WjBgAqZbqlpMTtUUNK3ZpMwAqQU
 J
X-Google-Smtp-Source: AGHT+IHzI4jDJAu5EumahZPEIqhIs+WHTEWc45oXxE4fEK0yknjTKWrGqWpyacy6p3VGpXmrp+wIxg==
X-Received: by 2002:a05:6a21:6e41:b0:1d9:1fac:7256 with SMTP id
 adf61e73a8af0-1d978b358abmr1359260637.30.1729654486607; 
 Tue, 22 Oct 2024 20:34:46 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13d73b1sm5438338b3a.105.2024.10.22.20.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 20:34:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 16/24] include/exec: Improve probe_access_full{,
 _mmu} documentation
Date: Tue, 22 Oct 2024 20:34:24 -0700
Message-ID: <20241023033432.1353830-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023033432.1353830-1-richard.henderson@linaro.org>
References: <20241023033432.1353830-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241013184733.1423747-2-richard.henderson@linaro.org>
---
 include/exec/exec-all.h | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 72240ef426..2e4c4cc4b4 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -368,6 +368,13 @@ int probe_access_flags(CPUArchState *env, vaddr addr, int size,
  * The CPUTLBEntryFull structure returned via @pfull is transient
  * and must be consumed or copied immediately, before any further
  * access or changes to TLB @mmu_idx.
+ *
+ * This function will not fault if @nonfault is set, but will
+ * return TLB_INVALID_MASK if the page is not mapped, or is not
+ * accessible with @access_type.
+ *
+ * This function will return TLB_MMIO in order to force the access
+ * to be handled out-of-line if plugins wish to instrument the access.
  */
 int probe_access_full(CPUArchState *env, vaddr addr, int size,
                       MMUAccessType access_type, int mmu_idx,
@@ -375,22 +382,14 @@ int probe_access_full(CPUArchState *env, vaddr addr, int size,
                       CPUTLBEntryFull **pfull, uintptr_t retaddr);
 
 /**
- * probe_access_mmu() - Like probe_access_full except cannot fault and
- * doesn't trigger instrumentation.
+ * probe_access_full_mmu:
+ * Like probe_access_full, except:
  *
- * @env: CPUArchState
- * @vaddr: virtual address to probe
- * @size: size of the probe
- * @access_type: read, write or execute permission
- * @mmu_idx: softmmu index
- * @phost: ptr to return value host address or NULL
- * @pfull: ptr to return value CPUTLBEntryFull structure or NULL
- *
- * The CPUTLBEntryFull structure returned via @pfull is transient
- * and must be consumed or copied immediately, before any further
- * access or changes to TLB @mmu_idx.
- *
- * Returns: TLB flags as per probe_access_flags()
+ * This function is intended to be used for page table accesses by
+ * the target mmu itself.  Since such page walking happens while
+ * handling another potential mmu fault, this function never raises
+ * exceptions (akin to @nonfault true for probe_access_full).
+ * Likewise this function does not trigger plugin instrumentation.
  */
 int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
                           MMUAccessType access_type, int mmu_idx,
-- 
2.43.0


