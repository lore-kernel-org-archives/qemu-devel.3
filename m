Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82440FD9E1B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 22:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvjRe-0002W6-US; Thu, 26 Feb 2026 17:02:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvjRX-0002Uy-SU
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:02:49 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvjRW-0001tD-2K
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:02:47 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4376acce52eso937149f8f.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 14:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772143364; x=1772748164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=785oPSJzDG9pvxZyQhvc47hwg0jYWN3ydc6kS0PNkOA=;
 b=IvUnR0hwfxBoOYwWFb6qZum1huQ9MLVuetwTzXSLoLNyqgrUMPp2lZ63C9IWq4rqw/
 b/QjvI4K0EtAQNKcWSSjQ6K8N0/L8K6UVFWBe6hmwvk9mcdPEDumAYOx/fpqW4Kcbm3P
 /ixBb8PA6TN1+GY0D7ntF7LKU6pFT6B5kKgwG9tNArEQ5Zb0rArBnehHswA5mBoigUdR
 h+0+hZWn9WJdx+red31oAgdg2RJgmZh9wty4HcG89jEs2hwQpeA2CvdsscKBfNZMvsjQ
 cCuJMs9alGQkp/iJPod5mMivqt5SHIb0VrGFMJ8tcy7v8mBHkQVx9iqIpVIJWV937zmr
 oXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772143364; x=1772748164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=785oPSJzDG9pvxZyQhvc47hwg0jYWN3ydc6kS0PNkOA=;
 b=Nyv9mIXxNJ94g1GRCK9aXbCq0saHJAczILgrZf3b8Hu9VIT5vIwUS5gIdYt5mINLcV
 iaaGJZ8DvTO0ez2Hm3IxhwGTBiPYExZ3y/5f/Hxz/bLgua7qtGOmB+gLI7LAPtqDYuC3
 2WbmDO6CrDValLTdxNDLeyM4WtEiKcKA7yXDeJwDo+LwLbHqRPDT1jjUrVkZn3fjDVrm
 I/VOf4XpUSFx1bqgi3DYiLRDc8oM6H1KgtvLzGPDrB+W6okV1ehyodgTeujQWgwzTy3n
 U8x1kfw0cyNNMFS25v9Sff+V5vGFECS32m0+iTAw+n9ETawyP2mQdhFE5ZkvBLBJn179
 z7MA==
X-Gm-Message-State: AOJu0YzuF7XPbJc81t+lKneBYhjolnVW9gfgDxt1HurzH2yRewkFD3OF
 Wfle8G3Dq1Q3hf2iR/QX43+WA4JQIcDHiGsf5AWEsPReywnIiTBG6HWrhKxqrqTqv+yqibcBlXi
 MFNM97mQ=
X-Gm-Gg: ATEYQzy1jD83kn/ddYcvbxCzyGFYhj2OtT8Zq42204SKn/9VK+VzO/MINKuferpc/R4
 DQAOnfDM/wsvs7fqiEVRHyNczgTsTd4vaUF341DrYDFJwcLDc0KmIgBUjB2/2K46FLUSkABwgJk
 bqDsN8QFSDTuWVNVJSCzZ3L9K+6qSIXAGkP/rYMSRNpqvEx2uHq+6ao0LElyN3vUsVGnvXSsasO
 OF6P/jBsy6z+dYXxRwB4D3TkpFEnSzFFewPm0/AbHVSP/zL6nXU5sy+ioSNZwnmfKh5fNhFFzCz
 jk6OXgRYjUM3rUW/QHDN8BnhUQPnBG5yHkyTpa4Zcgc3FYmm/UcxCHiOBrVw4PHZFPzSKq14oqI
 u7EGV0CmZssTrD4GyXleNUUFSLSIW8JiWPkMQvouMu70q/GoZ/bQmDtosgQOdgmuoeGBON1G91/
 h7n2TNRSKZBDl4X+bH2ccR8JCPmAOeU52g2NFcRyjb0iCVYlz71l1yeYGB1n9jdKrjNanxe+as
X-Received: by 2002:a05:6000:4010:b0:430:fd84:3175 with SMTP id
 ffacd0b85a97d-4399de206c1mr675632f8f.38.1772143364138; 
 Thu, 26 Feb 2026 14:02:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c71ad07sm2309149f8f.16.2026.02.26.14.02.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Feb 2026 14:02:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 2/7] system/ramblock: Constify various RAMBlock arguments
Date: Thu, 26 Feb 2026 23:02:20 +0100
Message-ID: <20260226220226.20164-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260226220226.20164-1-philmd@linaro.org>
References: <20260226220226.20164-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Mark the RAMBlock structure const when is only accessed read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/ramblock.h | 26 +++++++++++++-------------
 stubs/ram-block.c         |  8 ++++----
 system/physmem.c          | 26 +++++++++++++-------------
 3 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index e9f58ac0457..221e8e5d03e 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -154,24 +154,24 @@ RAMBlock *qemu_ram_block_by_name(const char *name);
  */
 RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
                                    ram_addr_t *offset);
-ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host);
+ram_addr_t qemu_ram_block_host_offset(const RAMBlock *rb, void *host);
 void qemu_ram_set_idstr(RAMBlock *block, const char *name, DeviceState *dev);
 void qemu_ram_unset_idstr(RAMBlock *block);
-const char *qemu_ram_get_idstr(RAMBlock *rb);
-void *qemu_ram_get_host_addr(RAMBlock *rb);
-ram_addr_t qemu_ram_get_offset(RAMBlock *rb);
-ram_addr_t qemu_ram_get_fd_offset(RAMBlock *rb);
-ram_addr_t qemu_ram_get_used_length(RAMBlock *rb);
-ram_addr_t qemu_ram_get_max_length(RAMBlock *rb);
-bool qemu_ram_is_shared(RAMBlock *rb);
-bool qemu_ram_is_noreserve(RAMBlock *rb);
-bool qemu_ram_is_uf_zeroable(RAMBlock *rb);
+const char *qemu_ram_get_idstr(const RAMBlock *rb);
+void *qemu_ram_get_host_addr(const RAMBlock *rb);
+ram_addr_t qemu_ram_get_offset(const RAMBlock *rb);
+ram_addr_t qemu_ram_get_fd_offset(const RAMBlock *rb);
+ram_addr_t qemu_ram_get_used_length(const RAMBlock *rb);
+ram_addr_t qemu_ram_get_max_length(const RAMBlock *rb);
+bool qemu_ram_is_shared(const RAMBlock *rb);
+bool qemu_ram_is_noreserve(const RAMBlock *rb);
+bool qemu_ram_is_uf_zeroable(const RAMBlock *rb);
 void qemu_ram_set_uf_zeroable(RAMBlock *rb);
-bool qemu_ram_is_migratable(RAMBlock *rb);
+bool qemu_ram_is_migratable(const RAMBlock *rb);
 void qemu_ram_set_migratable(RAMBlock *rb);
 void qemu_ram_unset_migratable(RAMBlock *rb);
-bool qemu_ram_is_named_file(RAMBlock *rb);
-int qemu_ram_get_fd(RAMBlock *rb);
+bool qemu_ram_is_named_file(const RAMBlock *rb);
+int qemu_ram_get_fd(const RAMBlock *rb);
 
 size_t qemu_ram_pagesize(RAMBlock *block);
 size_t qemu_ram_pagesize_largest(void);
diff --git a/stubs/ram-block.c b/stubs/ram-block.c
index f0650b19ac6..3ca47214a0c 100644
--- a/stubs/ram-block.c
+++ b/stubs/ram-block.c
@@ -3,17 +3,17 @@
 #include "system/ramblock.h"
 #include "system/memory.h"
 
-void *qemu_ram_get_host_addr(RAMBlock *rb)
+void *qemu_ram_get_host_addr(const RAMBlock *rb)
 {
     return 0;
 }
 
-ram_addr_t qemu_ram_get_offset(RAMBlock *rb)
+ram_addr_t qemu_ram_get_offset(const RAMBlock *rb)
 {
     return 0;
 }
 
-ram_addr_t qemu_ram_get_used_length(RAMBlock *rb)
+ram_addr_t qemu_ram_get_used_length(const RAMBlock *rb)
 {
     return 0;
 }
@@ -42,7 +42,7 @@ RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
     return NULL;
 }
 
-int qemu_ram_get_fd(RAMBlock *rb)
+int qemu_ram_get_fd(const RAMBlock *rb)
 {
     return -1;
 }
diff --git a/system/physmem.c b/system/physmem.c
index 2fb0c25c93b..2384c6dbba4 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1857,48 +1857,48 @@ static void qemu_ram_setup_dump(void *addr, ram_addr_t size)
     }
 }
 
-const char *qemu_ram_get_idstr(RAMBlock *rb)
+const char *qemu_ram_get_idstr(const RAMBlock *rb)
 {
     return rb->idstr;
 }
 
-void *qemu_ram_get_host_addr(RAMBlock *rb)
+void *qemu_ram_get_host_addr(const RAMBlock *rb)
 {
     return rb->host;
 }
 
-ram_addr_t qemu_ram_get_offset(RAMBlock *rb)
+ram_addr_t qemu_ram_get_offset(const RAMBlock *rb)
 {
     return rb->offset;
 }
 
-ram_addr_t qemu_ram_get_fd_offset(RAMBlock *rb)
+ram_addr_t qemu_ram_get_fd_offset(const RAMBlock *rb)
 {
     return rb->fd_offset;
 }
 
-ram_addr_t qemu_ram_get_used_length(RAMBlock *rb)
+ram_addr_t qemu_ram_get_used_length(const RAMBlock *rb)
 {
     return rb->used_length;
 }
 
-ram_addr_t qemu_ram_get_max_length(RAMBlock *rb)
+ram_addr_t qemu_ram_get_max_length(const RAMBlock *rb)
 {
     return rb->max_length;
 }
 
-bool qemu_ram_is_shared(RAMBlock *rb)
+bool qemu_ram_is_shared(const RAMBlock *rb)
 {
     return rb->flags & RAM_SHARED;
 }
 
-bool qemu_ram_is_noreserve(RAMBlock *rb)
+bool qemu_ram_is_noreserve(const RAMBlock *rb)
 {
     return rb->flags & RAM_NORESERVE;
 }
 
 /* Note: Only set at the start of postcopy */
-bool qemu_ram_is_uf_zeroable(RAMBlock *rb)
+bool qemu_ram_is_uf_zeroable(const RAMBlock *rb)
 {
     return rb->flags & RAM_UF_ZEROPAGE;
 }
@@ -1908,7 +1908,7 @@ void qemu_ram_set_uf_zeroable(RAMBlock *rb)
     rb->flags |= RAM_UF_ZEROPAGE;
 }
 
-bool qemu_ram_is_migratable(RAMBlock *rb)
+bool qemu_ram_is_migratable(const RAMBlock *rb)
 {
     return rb->flags & RAM_MIGRATABLE;
 }
@@ -1923,12 +1923,12 @@ void qemu_ram_unset_migratable(RAMBlock *rb)
     rb->flags &= ~RAM_MIGRATABLE;
 }
 
-bool qemu_ram_is_named_file(RAMBlock *rb)
+bool qemu_ram_is_named_file(const RAMBlock *rb)
 {
     return rb->flags & RAM_NAMED_FILE;
 }
 
-int qemu_ram_get_fd(RAMBlock *rb)
+int qemu_ram_get_fd(const RAMBlock *rb)
 {
     return rb->fd;
 }
@@ -2770,7 +2770,7 @@ void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr)
 }
 
 /* Return the offset of a hostpointer within a ramblock */
-ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host)
+ram_addr_t qemu_ram_block_host_offset(const RAMBlock *rb, void *host)
 {
     ram_addr_t res = (uint8_t *)host - (uint8_t *)rb->host;
     assert((uintptr_t)host >= (uintptr_t)rb->host);
-- 
2.52.0


