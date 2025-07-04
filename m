Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E49C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdSH-0006In-7u; Fri, 04 Jul 2025 06:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdS7-0006DU-Tz
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:15:34 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdS6-0006g5-1M
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:15:31 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a4e742dc97so1235835f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624127; x=1752228927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wxoW7z/LI9NHhMEdNzGYL7+8ON+AV57aS1ofLSGL0sY=;
 b=QNMXwR3wtJYD/0nfEUeIu2u7Pc62J/agQzSt6Ri5Kd/vVPDCA5PJbk1FKTn97hAhFa
 VJr+nVx+NvD9L8V+iE+KBNyi3w8TacELMBje9m93ZI//dM0PvlCDSVHUw+mHV4/JexEt
 ts09D487VjzJ88VHU1rLuhMpBpeWIQkHDPyRtxUXDMzhMrTS4ORTp+K+5DgzOsElRgs0
 46tLmrk0Pt1xhSb3RQj9RAvkfJJeuO4agQx4u9RMsbAqPg59E2NFUBMlWqH1PLNuGyFm
 koOml4YyysqaA0S+vBLkNblT5grtIXqB4LLXRn5XC0PkpM0U3TwEzeaJf81BVJydI43V
 y9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624127; x=1752228927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wxoW7z/LI9NHhMEdNzGYL7+8ON+AV57aS1ofLSGL0sY=;
 b=irn9ycEH90g9sL2CLqseJlwQ4o6Bi+gNnOt4O1ZZV8LA9P4Nz00Qh137J21wqbIW8P
 F9X1JT+kjbDHQ8zQfyMVJXaYmJwqbyYkE0BimzaKH0eDVG0oemePBbQbTLASi2W8U7W/
 4L6oRIvBX32j4eN05jUMzJ9x/GntDVOgeJVPIAGgN+18OBv8eeBbrOPXmGnoimpbBk/z
 oaJ7TGC65nD77fGCmLgWb/l0BJtOrxE1uaGzdLzuvBozL6mKOtQKtXDWLItU8aZIGxJN
 aE8WQ7OriR6AHrQE3BKF1+cNz71BVHkvQMeydagB+4oYgnCbnwQKJ/+ICVAWw1PALXCc
 TCfg==
X-Gm-Message-State: AOJu0Yx41z9/5LUlYRSNyq/vJRzZVSdQiYrCGSO4ybqTBs5pMRiFc38d
 lV2fnVokwOhOxVSvpgtuucmvoIWfRUQudz++g+QBv/On/JiHUYZ3K84hFSi9OwbmYNCbluq35Ow
 XZVe0oCc=
X-Gm-Gg: ASbGnctiyRdixPD+Zd/JWmCvjAbF/URF1zG+sLMjBlEex77ORVt7BUsGVKdXSp0u2Qp
 eZaSA0GjU+Jqh59tMzaTbVfw+amT2jsEiS3ZNZ96C3YYlgF6sOQeTeOzzXTJDXq1o0Hfv1RFPRV
 1+G8ubCUaYgjlUFMYWma3v15jTHu8zaDPrqUqR2at/X1qa5Pa3rBNIkYAYBLhJATZ3fG3GZkjEF
 ZZrOA55UNY0VLpnR38fI1Fy8MAbDYdW+FYlK6L812Yw3b1SAGOuWKSN3ZmJxksqNTvq47Iuk5Ji
 Ie5R09CNh23Wo5CWjOcfr0UOwNlXPSL1ohkBs8k8Xov6CY8CHtSTi6GHrK2pfEp+cPxJVFa0B+L
 Qcxt78CKWQvoL0DNq3nfs3/gWhENohgN7Fqac
X-Google-Smtp-Source: AGHT+IH+7BXrrIeoNn3xisSH1SpK91sMAOQ1eO5QzWBRZGwg8+4ZLVoZfzpikSJ+gJzzPns+MH1Yyw==
X-Received: by 2002:a05:6000:2801:b0:3aa:ac7b:705a with SMTP id
 ffacd0b85a97d-3b493204a97mr1510686f8f.11.1751624127151; 
 Fri, 04 Jul 2025 03:15:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454b16a3799sm22115115e9.35.2025.07.04.03.15.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 03:15:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/31] cpus: Document CPUState::vcpu_dirty field
Date: Fri,  4 Jul 2025 12:14:12 +0200
Message-ID: <20250704101433.8813-12-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704101433.8813-1-philmd@linaro.org>
References: <20250704101433.8813-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-Id: <20250703173248.44995-18-philmd@linaro.org>
---
 include/hw/core/cpu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 162a56a5daa..5eaf41a566f 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -442,6 +442,7 @@ struct qemu_work_item;
  * @opaque: User data.
  * @mem_io_pc: Host Program Counter at which the memory was accessed.
  * @accel: Pointer to accelerator specific state.
+ * @vcpu_dirty: Hardware accelerator is not synchronized with QEMU state
  * @kvm_fd: vCPU file descriptor for KVM.
  * @work_mutex: Lock to prevent multiple access to @work_list.
  * @work_list: List of pending asynchronous work.
@@ -538,7 +539,6 @@ struct CPUState {
     uint32_t kvm_fetch_index;
     uint64_t dirty_pages;
     int kvm_vcpu_stats_fd;
-    bool vcpu_dirty;
 
     /* Use by accel-block: CPU is executing an ioctl() */
     QemuLockCnt in_ioctl_lock;
@@ -554,6 +554,7 @@ struct CPUState {
     uint32_t halted;
     int32_t exception_index;
 
+    bool vcpu_dirty;
     AccelCPUState *accel;
 
     /* Used to keep track of an outstanding cpu throttle thread for migration
-- 
2.49.0


