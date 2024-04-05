Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084CFC67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsglC-000609-4a; Fri, 05 Apr 2024 06:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsgl4-0005xm-I2
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:18 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsgl2-0004hX-3D
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:18 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5a9f6b0ea90so202955eaf.1
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712312715; x=1712917515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KviirDjHb5dnSu9MfRISBG6Gixu/OE0N1lnN0IvuL2c=;
 b=S9fyKbXH00dnERwd3wEV96x7eKnWaeK6C6Nndw6aCDoO5RKIu02K5/tdCQO950EzKt
 Z+ySbbWHJeV4juET3chI1aw33prsNtIBAqBboMw8X4nbec+EvG5dP2Ft/ebR/o1Nxgaz
 8jps5++sacAF6TocKLkVYeZ7O2wWgDAZ9lHJ7rI6HElwaMf7yqNrjxOgUwGbINt/VAu7
 afQHR99F6Q3dN5XrYCu1Nv9641EW/vzpFaJtZOhLZN3lJH1p9v5TTRx/oSI7ToLQzbUg
 uBknnv+L7m6OTn4xdbZBFfqm1HydRXpshfPNvvnmviJ1HaXg9oqhPQUHkMyJh+1E5RQy
 KVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712312715; x=1712917515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KviirDjHb5dnSu9MfRISBG6Gixu/OE0N1lnN0IvuL2c=;
 b=Bsm7VS7Jyymwssd3eeG7hNYUKzFLBzc275aMjvGOuWneL+9/kHa+mzMBzrC4ATu+CK
 bHrLjFUxBIb5Y6Nmhr7n5Mxiiyj9Ao502J6/rD0Gg63ADiw4m0/+RbmjYfLo9Z0SzEhz
 654BKJX10RDUJ1fqk7Vyz4bnZCXA2VQP8ZWG1vIQzWV5yNid7HOlxVhjvtRZ/Hsdbivd
 HmRNQu4p0Qx5+MsYZSrPEFaWN/sTTr/DqF0cB7/0evh5QS3UCmI6GtXZq04WXOVZaifi
 q+D+O8dE4I1aRLG9ePBPaHqTyN/R7HjwbaHucK+SuesOP1FCTYL7QI6eCpfzGZSAdexk
 yGWg==
X-Gm-Message-State: AOJu0YyADKpLunTEbL0jdQTdDN6G5IPdimPkTK/K4QvjJciNt1v60dx8
 wE58ODhg4UWFmVNND6zEabaqTSj/Ra9ebiDw5GX0G6ypjjtzr1kal/5IdbN5n5Q6KPqtXuHddbA
 V
X-Google-Smtp-Source: AGHT+IEJOOe2DxgICOX2842hCalTFCbDuYJXbn4nuECBafGl6Sv8eW8HBy2VCdMQW96O9YyQDfW4ig==
X-Received: by 2002:a05:6358:98f:b0:183:645b:cfa5 with SMTP id
 t15-20020a056358098f00b00183645bcfa5mr966128rwi.15.1712312714763; 
 Fri, 05 Apr 2024 03:25:14 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a63f90a000000b005e438fe702dsm1104304pgi.65.2024.04.05.03.25.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:25:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/32] accel/tcg: Implement translator_st
Date: Fri,  5 Apr 2024 00:24:37 -1000
Message-Id: <20240405102459.462551-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405102459.462551-1-richard.henderson@linaro.org>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
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

Copy data out of a completed translation.  This will be used
for both plugins and disassembly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h | 23 ++++++++++++++++
 accel/tcg/translator.c    | 55 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 2d42a4e7ed..97cdb7439e 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -245,6 +245,29 @@ translator_ldq_swap(CPUArchState *env, DisasContextBase *db,
  */
 void translator_fake_ldb(DisasContextBase *db, vaddr pc, uint8_t insn8);
 
+/**
+ * translator_st
+ * @db: disassembly context
+ * @dest: address to copy into
+ * @addr: virtual address within TB
+ * @len: length
+ *
+ * Copy @len bytes from @addr into @dest.
+ * All bytes must have been read during translation.
+ * Return true on success or false on failure.
+ */
+bool translator_st(const DisasContextBase *db, void *dest,
+                   vaddr addr, size_t len);
+
+/**
+ * translator_st_len
+ * @db: disassembly context
+ *
+ * Return the number of bytes available to copy from the
+ * current translation block with translator_st.
+ */
+size_t translator_st_len(const DisasContextBase *db);
+
 #ifdef NEED_CPU_H
 /*
  * Return whether addr is on the same page as where disassembly started.
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 4a1c98cb63..3421469a31 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -350,6 +350,61 @@ static void record_save(DisasContextBase *db, vaddr pc,
     memcpy(db->record + (offset - db->record_start), from, size);
 }
 
+size_t translator_st_len(const DisasContextBase *db)
+{
+    return db->fake_insn ? db->record_len : db->tb->size;
+}
+
+bool translator_st(const DisasContextBase *db, void *dest,
+                   vaddr addr, size_t len)
+{
+    size_t offset, offset_end;
+
+    if (addr < db->pc_first) {
+        return false;
+    }
+    offset = addr - db->pc_first;
+    offset_end = offset + len;
+    if (offset_end > translator_st_len(db)) {
+        return false;
+    }
+
+    if (!db->fake_insn) {
+        size_t offset_page1 = -(db->pc_first | TARGET_PAGE_MASK);
+
+        /* Get all the bytes from the first page. */
+        if (db->host_addr[0]) {
+            if (offset_end <= offset_page1) {
+                memcpy(dest, db->host_addr[0] + offset, len);
+                return true;
+            }
+            if (offset < offset_page1) {
+                size_t len0 = offset_page1 - offset;
+                memcpy(dest, db->host_addr[0] + offset, len0);
+                offset += len0;
+                dest += len0;
+            }
+        }
+
+        /* Get any bytes from the second page. */
+        if (db->host_addr[1] && offset >= offset_page1) {
+            memcpy(dest, db->host_addr[1] + (offset - offset_page1),
+                   offset_end - offset);
+            return true;
+        }
+    }
+
+    /* Else get recorded bytes. */
+    if (db->record_len != 0 &&
+        offset >= db->record_start &&
+        offset_end <= db->record_start + db->record_len) {
+        memcpy(dest, db->record + (offset - db->record_start),
+               offset_end - offset);
+        return true;
+    }
+    return false;
+}
+
 static void plugin_insn_append(vaddr pc, const void *from, size_t size)
 {
 #ifdef CONFIG_PLUGIN
-- 
2.34.1


