Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379D2C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcD3-0002al-KE; Tue, 01 Jul 2025 10:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcCc-0001rx-7X
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:43:20 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcCa-00073w-7W
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:43:17 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45348bff79fso33266545e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751380991; x=1751985791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Uuv2h3s82hPAzYpnhwyO1+75T5oRaTFf+ZSAVIOeJ0=;
 b=RGvl/U5TjtgFBMqHdWAOkA6KOkijXGiukg9LAcdXgxmJrZiMyEXdVUAoKR2E5CtNUK
 OW0Gbq6yYU2jAUl0pXwt3t3/pWACzxzA+E0r1+H/Do+vDd+qa40jCJOUKmnVYQwVSR7A
 JTvBVj7uvKEk62jspceciBhUmzejkgB1iERbEcAiKfV6+8YINgM/6txvQBEmNcTind/I
 vfek57zEnO/LMBnkcDc3WGjSdttiLqBH3qzpWAa6r8Br5P3NH+bjm/J8pGrTdX6OLHuq
 OGFtjfea0t8N5mZYpK7qipTYKah4tC+LTxU685fYSikfrQzveajjeIDahXND6Qgmha4p
 OjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380991; x=1751985791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Uuv2h3s82hPAzYpnhwyO1+75T5oRaTFf+ZSAVIOeJ0=;
 b=uKTdSniIS5KBKkSdWUzIGalvzc52bTo6ndWg+rs21JfcXHTYERAIS27Evf9EyIDJbx
 mnbcH2qT1owh8MwpuqS3373X0/SkpkCqdjZwOxmvzLJ9FfVv2iCsWcAsHHvG8QSlfDEq
 rwpZvnnGVX7itPPx7U8ycl8iXEvzdF3SJVqZKlOIl+w3UemB8sz9R0euFGCj8+P3//Qq
 M3YqD/Sm0yP8nIP0aHEGuW0dHMbou/qMIxhufVZQfJw7HK5/MNRcwAL/jz/wKze/W9yN
 UmlILl63eNXZ0SPq2X8m6k3UwpwwU6AVCHJeRmUWURruRjAcJxpGm3FNV6DrRoT30AYu
 zFBw==
X-Gm-Message-State: AOJu0Yxs4IrssGSiG9/dHouTpN/L7vOLtanMWbc2hTNUCJ5giwftsdwY
 yU28wyLz1zrj7Z9SaQmkLBj8cE+tta1KdJwlmkazUhCCTCxfvufCMdcFDgVLDviP4QQzHYX+qbC
 Xtzsh
X-Gm-Gg: ASbGncuHiUiW0nbeUt6CtPRJoiCYt2K/TgV4D1pkdEatp6G54LIwKquR6mYvNU0Svgw
 6wsa2lBBIIrFdvVr5twVrq5GFrmwC9wSwteJPCGlikneEoW0xjdkYHnLl6ESzJGwpPmR9Sdg0qi
 TiYOa46X/XhU06qMDy7rwzPRwXk4Bw/dSohvsquULnyz2dDzRi4jsL3xcKI/cNAxU8dHbqLsVqV
 /NEmYx0d4hVdqYefs6OYwGG6LpQ73MnSyywwXgHzQ8ZRCBY9uSe1RLk3YCUPBXoI3YXoU0bI5hp
 mkUYKymhDqWHp5Pab6FXisK/wSQQqbtWz/xdDtO5rrd6h8fvPWVjr8/bBgx4ff+VTuV7pUcvOdT
 54ot1qsSrrnh1Tt3vljTfBvaKhGZdbptmg8J3
X-Google-Smtp-Source: AGHT+IH1FlGkVQVjNTmzz5bs7GJytt6TF1Z1nClpaY0hy6zWXByUB3OsAYkwGESvvTnAy4Gi1LejCA==
X-Received: by 2002:a05:600c:828e:b0:43d:fa59:a685 with SMTP id
 5b1f17b1804b1-453900db0e0mr154901405e9.33.1751380991502; 
 Tue, 01 Jul 2025 07:43:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453923a22fbsm126724855e9.34.2025.07.01.07.43.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:43:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 32/68] cpus: Document CPUState::vcpu_dirty field
Date: Tue,  1 Jul 2025 16:39:40 +0200
Message-ID: <20250701144017.43487-33-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 33296a1c080..726427449da 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -441,6 +441,7 @@ struct qemu_work_item;
  * @opaque: User data.
  * @mem_io_pc: Host Program Counter at which the memory was accessed.
  * @accel: Pointer to accelerator specific state.
+ * @vcpu_dirty: Hardware accelerator is not synchronized with QEMU state
  * @kvm_fd: vCPU file descriptor for KVM.
  * @work_mutex: Lock to prevent multiple access to @work_list.
  * @work_list: List of pending asynchronous work.
@@ -537,7 +538,6 @@ struct CPUState {
     uint32_t kvm_fetch_index;
     uint64_t dirty_pages;
     int kvm_vcpu_stats_fd;
-    bool vcpu_dirty;
 
     /* Use by accel-block: CPU is executing an ioctl() */
     QemuLockCnt in_ioctl_lock;
@@ -553,6 +553,7 @@ struct CPUState {
     uint32_t halted;
     int32_t exception_index;
 
+    bool vcpu_dirty;
     AccelCPUState *accel;
 
     /* Used to keep track of an outstanding cpu throttle thread for migration
-- 
2.49.0


