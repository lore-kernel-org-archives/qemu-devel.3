Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097C8C369DC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl19-0004Ky-TU; Sun, 04 May 2025 21:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0k-0003w7-Uz
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:55 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0c-0002WM-7b
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:50 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-736bfa487c3so3407065b3a.1
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409961; x=1747014761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u3pVmvmULoy6BBYUkUdwM0L9kebw+2O/lrIQahS04Iw=;
 b=u60ZbMZHw7U7bV3WG5mj/KKe2EdVCSkta2H8oeYRrqG75F2Rv4G+hAlBdg4wN4hUnB
 edNWRP4n8tsgPO6rH2RGg/ccwXTPvvFEqic024+uiTgGI9opiBibDhQXBGCkWCah47w9
 ufoWVv+fKcjOBpQXi+SoVCAnILcXH+1ZfTeXWCU7kkq3Db1L6f/T2WCIwV8x7/yiDiQ3
 d0b9ufHz4aEewZngEFtFyAwkip8SGz1kQu5Qy5Qt0hGA3Damo3AG060Emph0hbOc6/j3
 YVKQk7cjz1DNB4bQd9oo32RvUAe2EwaiiTKaKNflZplb6BqpfkLzgc07u7fmtoIFHNCg
 /m/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409961; x=1747014761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u3pVmvmULoy6BBYUkUdwM0L9kebw+2O/lrIQahS04Iw=;
 b=nua/kUMcVYgIFj+8iwp1mHWIPnlvXEnRZqSA17asCWDLpDvRXFbjDaLHoqXZ6F19rO
 iIAwAjCk3ki44aU8pI8m28u+lUhgdLYkpEw6nUDy+kDbH7ZSU3yzug9vGJpV2a6T+vcA
 6lihzO1RgOvZumbWXkn3Q6enbniC2zRchM8YRp9MJXk81+XTA86yGd+TUbNgGQXNS3Y3
 LSyWZJNs16XaZwSiyrm4QeQzt53HaZxi7tJ+ozcFi6KgLzPbjvkbXH++cvB/KmjkJbnx
 ZcaMkAnnvYm8vNNJjnKkGWoTGOw9bzCUBPOAs+T+BtfO6CismieY+LZAhIGQXfGvIMhs
 FFOQ==
X-Gm-Message-State: AOJu0YyqBgPLWQ4HNL4h9Ncc/dSI0ecXHIwrEeFzJruJAUkm9hGQDhVl
 IXt1Lojk/2rsY4YVR5/5jyDQkINk/7+StKQtVJ9XsamycD3Os+PYy7tk1SdCRc+5+SVkLktIdcO
 k9ow=
X-Gm-Gg: ASbGnctG9H4ukrb17ZjJvHjWDkd/x8NVulyO7QUSPjzSo0usyb+UsBBW70iuOZXmosn
 V3qzgAWd2oFGV2vUOG1Jf8V3MLqX3y6bx9m39XCJ8vb2qOrqHLzHkQajwJRbIByg4lxAFwOhnxb
 vb+2G+ObFniDVHx5+p/yaaaAR17qOhKTkJOgkZ1hwvpN8vWyCX4dAK66smnAcNH3wxoIA3j+Chh
 Jw/11LwMK7fPoQ2p1rreHq+EgymksT9qQTIJX3vz30Rj4masGLWC/nhavDVj1JMP0QCdi8MZ/Od
 9/eus7zOt/AiUc5iSzp/u3QP8xmAYGfDkFyyy1vo
X-Google-Smtp-Source: AGHT+IHMzdomMMzlq4KGCLymz5PTggicrRz+TP8w/tfk7qhqTrOD0GKRynUQbqlHnDL/LsXEtE08DA==
X-Received: by 2002:a05:6a21:9991:b0:1f5:79c4:5da2 with SMTP id
 adf61e73a8af0-20e979c9149mr8579279637.31.1746409960824; 
 Sun, 04 May 2025 18:52:40 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.52.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:52:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 14/48] tcg: add vaddr type for helpers
Date: Sun,  4 May 2025 18:51:49 -0700
Message-ID: <20250505015223.3895275-15-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

Defined as an alias of i32/i64 depending on host pointer size.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/tcg/tcg-op-common.h    |  1 +
 include/tcg/tcg.h              | 14 ++++++++++++++
 include/exec/helper-head.h.inc | 11 +++++++++++
 tcg/tcg.c                      |  5 +++++
 4 files changed, 31 insertions(+)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index b439bdb385a..e1071adebf2 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -14,6 +14,7 @@
 
 TCGv_i32 tcg_constant_i32(int32_t val);
 TCGv_i64 tcg_constant_i64(int64_t val);
+TCGv_vaddr tcg_constant_vaddr(uintptr_t val);
 TCGv_vec tcg_constant_vec(TCGType type, unsigned vece, int64_t val);
 TCGv_vec tcg_constant_vec_matching(TCGv_vec match, unsigned vece, int64_t val);
 
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index aa300a2f8ba..72bfd3485aa 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -188,6 +188,7 @@ typedef tcg_target_ulong TCGArg;
     * TCGv_i64  : 64 bit integer type
     * TCGv_i128 : 128 bit integer type
     * TCGv_ptr  : a host pointer type
+    * TCGv_vaddr: an integer type wide enough to hold a target pointer type
     * TCGv_vec  : a host vector type; the exact size is not exposed
                   to the CPU front-end code.
     * TCGv      : an integer type the same size as target_ulong
@@ -216,6 +217,14 @@ typedef struct TCGv_ptr_d *TCGv_ptr;
 typedef struct TCGv_vec_d *TCGv_vec;
 typedef TCGv_ptr TCGv_env;
 
+#if __SIZEOF_POINTER__ == 4
+typedef TCGv_i32 TCGv_vaddr;
+#elif __SIZEOF_POINTER__ == 8
+typedef TCGv_i64 TCGv_vaddr;
+#else
+# error "sizeof pointer is different from {4,8}"
+#endif /* __SIZEOF_POINTER__ */
+
 /* call flags */
 /* Helper does not read globals (either directly or through an exception). It
    implies TCG_CALL_NO_WRITE_GLOBALS. */
@@ -577,6 +586,11 @@ static inline TCGv_ptr temp_tcgv_ptr(TCGTemp *t)
     return (TCGv_ptr)temp_tcgv_i32(t);
 }
 
+static inline TCGv_vaddr temp_tcgv_vaddr(TCGTemp *t)
+{
+    return (TCGv_vaddr)temp_tcgv_i32(t);
+}
+
 static inline TCGv_vec temp_tcgv_vec(TCGTemp *t)
 {
     return (TCGv_vec)temp_tcgv_i32(t);
diff --git a/include/exec/helper-head.h.inc b/include/exec/helper-head.h.inc
index bce5db06ef3..5b248fd7138 100644
--- a/include/exec/helper-head.h.inc
+++ b/include/exec/helper-head.h.inc
@@ -58,6 +58,17 @@
 # define dh_ctype_tl target_ulong
 #endif /* COMPILING_PER_TARGET */
 
+#if __SIZEOF_POINTER__ == 4
+# define dh_alias_vaddr i32
+# define dh_typecode_vaddr dh_typecode_i32
+#elif __SIZEOF_POINTER__ == 8
+# define dh_alias_vaddr i64
+# define dh_typecode_vaddr dh_typecode_i64
+#else
+# error "sizeof pointer is different from {4,8}"
+#endif /* __SIZEOF_POINTER__ */
+# define dh_ctype_vaddr uintptr_t
+
 /* We can't use glue() here because it falls foul of C preprocessor
    recursive expansion rules.  */
 #define dh_retvar_decl0_void void
diff --git a/tcg/tcg.c b/tcg/tcg.c
index c4e866e9c34..51ec8e04bdc 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2368,6 +2368,11 @@ TCGv_i64 tcg_constant_i64(int64_t val)
     return temp_tcgv_i64(tcg_constant_internal(TCG_TYPE_I64, val));
 }
 
+TCGv_vaddr tcg_constant_vaddr(uintptr_t val)
+{
+    return temp_tcgv_vaddr(tcg_constant_internal(TCG_TYPE_PTR, val));
+}
+
 TCGv_ptr tcg_constant_ptr_int(intptr_t val)
 {
     return temp_tcgv_ptr(tcg_constant_internal(TCG_TYPE_PTR, val));
-- 
2.47.2


