Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51214C88E5C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 07:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkGtB-000535-0n; Mon, 26 Jan 2026 02:19:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGfl-00034A-MJ
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:06:17 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGff-0004Qa-EU
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:06:04 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-8230c2d3128so1646661b3a.0
 for <qemu-devel@nongnu.org>; Sun, 25 Jan 2026 23:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769411151; x=1770015951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1DUM9H9Xhv4bjjQ4nTppfOZBFCe9No2iFqGRcQo1YjY=;
 b=Unb4FAEU2VbgXMPeRIkvK1LTeOWAeulY1yAlWJQTydet6I4vzyuZbnBDrQlq9POA2o
 6CbsHTAtjOPoygnZZFPAqQbz8wUM/UFb7BFE5NgOISCB1Rsaly1FsFbC3pnkol2rzCnK
 v3usP239gJQxiveiYjG3jfYGCFFvMH2oJ5tG7NLy3MCUm3I6Lq8vqQdBXGH5xLHVJZVk
 /QQT44iF9mtCIIJtI5xSUes5hN5+nFpVaxZqoV28BKjkHyLzpvxYiu5bzaV13Sql5Zvq
 uxq3J2MpSa+wv/OwhEeNus0+eqD5+ZzSDGjwBkxW/TdcgMbqss/3jJIxUjiG741EyLEs
 Iy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769411151; x=1770015951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1DUM9H9Xhv4bjjQ4nTppfOZBFCe9No2iFqGRcQo1YjY=;
 b=sNHjOMYYg/Tt6ahtL3dGeZOI0RJdpThztI0rGHujO63/QtG5ei0XSuQGgaq8wZPtJo
 xJLDAb03bieLKpOEG5c3SGYfx2b2b1aTMy5ofi14JS9YA9WEouaWdhsZUvLfJW/VdRzU
 UxhMUgGFgFDN6rj2gxnGLFYdt1k4es5nCwMcybTVKaXV05sENsobP7nKjsIQgtKWrUsI
 vYIcM6ffSOYvkZNpX4l7K7HMgH2vlzcbJUZ5+9VRqzl9Uas8ggZV+CeZXKvHptXbUWb9
 qm5HZzY3wp0xfb3DK7il41F2PBdmgbJ8GwaE8MDGgCps85ur4FoVbSHxxFF23d0lKFeC
 E/uw==
X-Gm-Message-State: AOJu0Yz/eiKwev9kfqtYU2zQhPmC6grp8BTpYVCOCKzQWN0ziRRe+rCg
 yb//lvYMaSrPL12mor+fPfLitM2p174X5JR8AfZWEA8NbiFRyFTR/iyp0UQnnTzQ
X-Gm-Gg: AZuq6aIl9bgfevp7rGOn053m0yAqDNwQdIZnmIrZ7CgsR85GOwiR0jX0fr1Yqb8sxpH
 5iD12XR5qtBWmxPmOAA7sNpH3m2q7y9o+PUDpsnYz1npkKFIhzp8RQWimSYH5GhE91P3MgM84dj
 Xw8JVQAQu7Drt/XmdLdLJeVY0ukxtHWh83xTHFK0H+APb0VtI27k1ZoB/tv9Ao+VDFsb7wWomBE
 Ssn2usMbjB7Qpw+aQMUvf8cyIDIr7J3aogtGA5DRgZqe/J8WCXSgYvf+eALbGYLI58YwGrCEftK
 w4h/jq8POED/pWm4113IZl3eHptGS2A//MVfxDetqKw/3vH5rbcykwLeTAKLBxXPxuAtct/k8f1
 JwAYLS0Xv+IgJzNOgQ47CY4h+G0jMoes/3WrARk2zK9vebPdfD07YdZtDGUMby1XGAX4NVZW7PE
 tHUuf4Ixrw4rsA/fcIO4t38R0lkOpe9tXKVeYjg2ylMA==
X-Received: by 2002:a05:6a00:b904:b0:823:148c:d785 with SMTP id
 d2e1a72fcca58-823411dd242mr2978008b3a.27.1769411150705; 
 Sun, 25 Jan 2026 23:05:50 -0800 (PST)
Received: from brahms.. (fp93c00990.tkyc601.ap.nuro.jp. [147.192.9.144])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-823187716ebsm8661487b3a.66.2026.01.25.23.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 23:05:50 -0800 (PST)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 23/33] tcg/wasm64: Write wasm binary to TB
Date: Mon, 26 Jan 2026 07:03:36 +0000
Message-ID: <6f6e5a4d136f0e736b732f30481446d360271978.1769407033.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769407033.git.ktokunaga.mail@gmail.com>
References: <cover.1769407033.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This commit updates tcg_out_tb_start and tcg_out_tb_end to emit Wasm
binaries into the TB code buffer. The generated Wasm binary defines a
function of type wasm_tb_func which takes a WasmContext, executes the TB,
and returns a result. In the Wasm backend, each TB starts with a
WasmTBHeader which contains pointers to the following data:

- TCI code
- Wasm code
- Array of helper function pointers imported into the Wasm instance

tcg_out_tb_start writes the WasmTBHeader to the code buffer. tcg_out_tb_end
generates the full Wasm executable binary by creating the Wasm module header
following the spec[1][2][3] and copying the Wasm code body from sub_buf to
the TB. This Wasm binary is placed after the TCI code which was emitted
earlier.

Additionally, an array of imported function pointers is appended to the
TB. They are used during Wasm module instantiation. Function are imported to
Wasm with names like "helper.0", "helper.1", etc., where the number
corresponds to the array index.

Each function's type signature must also be encoded in the Wasm module
header. To support this, every emission of "call", "qemu_ld" and "qemu_st"
operations also records the target function's type information in a buffer
which will be copied to the code buffer during tcg_out_tb_end.

Memory is shared between QEMU and the TBs and is imported to the Wasm module
with the name "env.memory".

[1] https://webassembly.github.io/spec/core/binary/modules.html
[2] https://github.com/WebAssembly/threads/blob/b2567bff61ee6fbe731934f0ed17a5d48dc9ab01/proposals/threads/Overview.md
[3] https://github.com/WebAssembly/memory64/blob/9003cd5e24e53b84cd9027ea3dd7ae57159a6db1/proposals/memory64/Overview.md

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm64.h                |  26 +++
 tcg/wasm64/tcg-target.c.inc | 406 ++++++++++++++++++++++++++++++++++++
 2 files changed, 432 insertions(+)

diff --git a/tcg/wasm64.h b/tcg/wasm64.h
index f2b67c1099..b5d9ce75da 100644
--- a/tcg/wasm64.h
+++ b/tcg/wasm64.h
@@ -32,4 +32,30 @@ struct WasmContext {
     uint64_t *stack;
 };
 
+/* Instantiated Wasm function of a TB */
+typedef uintptr_t (*wasm_tb_func)(struct WasmContext *);
+
+/*
+ * A TB of the Wasm backend starts from a header which contains pointers for
+ * each data stored in the following region in the TB.
+ */
+struct WasmTBHeader {
+    /*
+     * Pointer to the region containing TCI instructions.
+     */
+    void *tci_ptr;
+
+    /*
+     * Pointer to the region containing Wasm instructions.
+     */
+    void *wasm_ptr;
+    int wasm_size;
+
+    /*
+     * Pointer to the array containing imported function pointers.
+     */
+    void *import_ptr;
+    int import_size;
+};
+
 #endif
diff --git a/tcg/wasm64/tcg-target.c.inc b/tcg/wasm64/tcg-target.c.inc
index f5d4cb4139..9854f5538c 100644
--- a/tcg/wasm64/tcg-target.c.inc
+++ b/tcg/wasm64/tcg-target.c.inc
@@ -154,6 +154,8 @@ static const uint8_t tcg_target_reg_index[TCG_TARGET_NB_REGS] = {
 /* Function index */
 #define HELPER_IDX_START 0 /* The first index of helper functions */
 
+#define PTR_TYPE 0x7e
+
 typedef enum {
     OPC_UNREACHABLE = 0x00,
     OPC_LOOP = 0x03,
@@ -312,6 +314,19 @@ static int linked_buf_len(LinkedBuf *p)
     return total;
 }
 
+static int linked_buf_write(LinkedBuf *p, void *dst)
+{
+    int total = 0;
+    LinkedBufEntry *e;
+
+    QSIMPLEQ_FOREACH(e, p, entry) {
+        memcpy(dst, e->data, e->size);
+        dst += e->size;
+        total += e->size;
+    }
+    return total;
+}
+
 /*
  * wasm code is generataed in the dynamically allocated buffer which
  * are managed as a linked list.
@@ -928,6 +943,99 @@ static void gen_call(TCGContext *s,
     }
 }
 
+static __thread LinkedBuf types_buf;
+
+static void init_types_buf(void)
+{
+    QSIMPLEQ_INIT(&types_buf);
+}
+
+static void types_buf_out8(uint8_t v)
+{
+    linked_buf_out8(&types_buf, v);
+}
+
+static void gen_func_type_call(TCGContext *s, const TCGHelperInfo *info)
+{
+    unsigned typemask = info->typemask;
+    int rettype = typemask & 7;
+    uint32_t vec_size = 0;
+
+    if (rettype == dh_typecode_i128) {
+        vec_size++;
+    }
+    for (int m = typemask >> 3; m; m >>= 3) {
+        if ((m & 7) != dh_typecode_void) {
+            vec_size++;
+        }
+    }
+
+    types_buf_out8(0x60);
+    linked_buf_out_leb128(&types_buf, vec_size);
+
+    if (rettype == dh_typecode_i128) {
+        types_buf_out8(PTR_TYPE);
+    }
+
+    for (int m = typemask >> 3; m; m >>= 3) {
+        switch (m & 7) {
+        case dh_typecode_void:
+            break;
+        case dh_typecode_i32:
+        case dh_typecode_s32:
+            types_buf_out8(0x7f);
+            break;
+        case dh_typecode_i64:
+        case dh_typecode_s64:
+            types_buf_out8(0x7e);
+            break;
+        case dh_typecode_i128:
+            types_buf_out8(PTR_TYPE);
+            break;
+        case dh_typecode_ptr:
+            types_buf_out8(PTR_TYPE);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+
+    switch (rettype) {
+    case dh_typecode_void:
+    case dh_typecode_i128:
+        types_buf_out8(0x0);
+        break;
+    case dh_typecode_i32:
+    case dh_typecode_s32:
+        types_buf_out8(0x1);
+        types_buf_out8(0x7f);
+        break;
+    case dh_typecode_i64:
+    case dh_typecode_s64:
+        types_buf_out8(0x1);
+        types_buf_out8(0x7e);
+        break;
+    case dh_typecode_ptr:
+        types_buf_out8(0x1);
+        types_buf_out8(PTR_TYPE);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static __thread LinkedBuf imports_buf;
+
+static void init_imports_buf(void)
+{
+    QSIMPLEQ_INIT(&imports_buf);
+}
+
+static void imports_buf_out8(uint8_t v)
+{
+    linked_buf_out8(&imports_buf, v);
+}
+
 typedef struct HelperInfo {
     intptr_t idx_on_qemu;
     QSIMPLEQ_ENTRY(HelperInfo) entry;
@@ -944,15 +1052,56 @@ static void init_helpers(void)
 
 static uint32_t register_helper(TCGContext *s, intptr_t helper_idx_on_qemu)
 {
+    uint32_t typeidx = helper_idx + 1;
+    char buf[11]; /* enough for decimal int max + NULL*/
+    int n = snprintf(buf, sizeof(buf), "%d", helper_idx - HELPER_IDX_START);
+
     tcg_debug_assert(helper_idx_on_qemu >= 0);
 
     HelperInfo *e = tcg_malloc(sizeof(HelperInfo));
     e->idx_on_qemu = helper_idx_on_qemu;
     QSIMPLEQ_INSERT_TAIL(&helpers, e, entry);
 
+    tcg_debug_assert(n < sizeof(buf));
+    imports_buf_out8(6); /* helper */
+    imports_buf_out8(0x68);
+    imports_buf_out8(0x65);
+    imports_buf_out8(0x6c);
+    imports_buf_out8(0x70);
+    imports_buf_out8(0x65);
+    imports_buf_out8(0x72);
+    linked_buf_out_leb128(&imports_buf, (uint32_t)n);
+    for (int i = 0; i < n; i++) {
+        imports_buf_out8(buf[i]);
+    }
+    imports_buf_out8(0); /* type(0) */
+    linked_buf_out_leb128(&imports_buf, typeidx);
+
     return helper_idx++;
 }
 
+static int helpers_len(void)
+{
+    int n = 0;
+    HelperInfo *e;
+
+    QSIMPLEQ_FOREACH(e, &helpers, entry) {
+        n++;
+    }
+    return n;
+}
+
+static int helpers_write_to_array(intptr_t *dst)
+{
+    intptr_t *start = dst;
+    HelperInfo *e;
+
+    QSIMPLEQ_FOREACH(e, &helpers, entry) {
+        *dst++ = e->idx_on_qemu;
+    }
+    return (intptr_t)dst - (intptr_t)start;
+}
+
 static int64_t get_helper_idx(TCGContext *s, intptr_t helper_idx_on_qemu)
 {
     uint32_t idx = HELPER_IDX_START;
@@ -974,6 +1123,7 @@ static void tcg_wasm_out_call(TCGContext *s, intptr_t func,
     int64_t func_idx = get_helper_idx(s, func);
     if (func_idx < 0) {
         func_idx = register_helper(s, func);
+        gen_func_type_call(s, info);
     }
 
     ofs = tcg_wasm_out_get_ctx(s, CTX_OFFSET(tci_tb_ptr));
@@ -985,6 +1135,39 @@ static void tcg_wasm_out_call(TCGContext *s, intptr_t func,
     gen_call(s, info, func_idx);
 }
 
+static void gen_func_type_qemu_ld(TCGContext *s, uint32_t oi)
+{
+    types_buf_out8(0x60);
+    types_buf_out8(0x4);
+    types_buf_out8(PTR_TYPE);
+    types_buf_out8(0x7e);
+    types_buf_out8(0x7f);
+    types_buf_out8(PTR_TYPE);
+    types_buf_out8(0x1);
+    types_buf_out8(0x7e);
+}
+
+static void gen_func_type_qemu_st(TCGContext *s, uint32_t oi)
+{
+    MemOp mop = get_memop(oi);
+
+    types_buf_out8(0x60);
+    types_buf_out8(0x5);
+    types_buf_out8(PTR_TYPE);
+    types_buf_out8(0x7e);
+    switch (mop & MO_SSIZE) {
+    case MO_UQ:
+        types_buf_out8(0x7e);
+        break;
+    default:
+        types_buf_out8(0x7f);
+        break;
+    }
+    types_buf_out8(0x7f);
+    types_buf_out8(PTR_TYPE);
+    types_buf_out8(0x0);
+}
+
 static void *qemu_ld_helper_ptr(uint32_t oi)
 {
     MemOp mop = get_memop(oi);
@@ -1018,6 +1201,7 @@ static void tcg_wasm_out_qemu_ld(TCGContext *s, TCGReg data_reg,
     func_idx = get_helper_idx(s, helper_idx);
     if (func_idx < 0) {
         func_idx = register_helper(s, helper_idx);
+        gen_func_type_qemu_ld(s, oi);
     }
 
     /* call the target helper */
@@ -1058,6 +1242,7 @@ static void tcg_wasm_out_qemu_st(TCGContext *s, TCGReg data_reg,
     func_idx = get_helper_idx(s, helper_idx);
     if (func_idx < 0) {
         func_idx = register_helper(s, helper_idx);
+        gen_func_type_qemu_st(s, oi);
     }
 
     /* call the target helper */
@@ -2079,14 +2264,164 @@ static void tcg_out_set_carry(TCGContext *s)
     g_assert_not_reached();
 }
 
+static const uint8_t mod_1[] = {
+    0x0, 0x61, 0x73, 0x6d, /* magic */
+    0x01, 0x0, 0x0, 0x0,   /* version */
+
+    0x01,                         /* type section */
+    0x80, 0x80, 0x80, 0x80, 0x00, /* placehodler for size */
+    0x80, 0x80, 0x80, 0x80, 0x00, /* placehodler for num of types vec */
+    0x60,                         /* 0: Type of "start" function */
+    0x01, PTR_TYPE,               /* arg: ctx pointer */
+    0x01, PTR_TYPE,               /* return: res */
+};
+
+#define MOD_1_PH_TYPE_SECTION_SIZE_OFF 9
+#define MOD_1_PH_TYPE_VEC_NUM_OFF 14
+
+static const uint8_t mod_2[] = {
+    0x02,                                     /* import section */
+    0x80, 0x80, 0x80, 0x80, 0x00,             /* placehodler for size */
+    0x80, 0x80, 0x80, 0x80, 0x00,             /* placehodler for imports num */
+    0x03, 0x65, 0x6e, 0x76,                   /* module: "env" */
+    0x06, 0x6d, 0x65, 0x6d, 0x6f, 0x72, 0x79, /* name: "memory" */
+#if defined(WASM64_MEMORY64_2)
+    /* 32bit memory is used for Emscripten's "-sMEMORY64=2" configuration. */
+    0x02, 0x03,                               /* shared mem */
+    0x00, 0x80, 0x80, 0x04,                   /* min: 0, max: 65536 pages */
+#else
+    /*
+     * 64bit memory is used for Emscripten's "-sMEMORY64=1" configuration.
+     * Note: the maximum 64bit memory size of the engine implementations is
+     * limited to 262144 pages(16GiB)
+     * https://webassembly.github.io/memory64/js-api/#limits
+     */
+    0x02, 0x07,                               /* shared mem(64bit) */
+    0x00, 0x80, 0x80, 0x10,                   /* min: 0, max: 262144 pages */
+#endif
+};
+
+#define MOD_2_PH_IMPORT_SECTION_SIZE_OFF 1
+#define MOD_2_PH_IMPORT_VEC_NUM_OFF 6
+
+static const uint8_t mod_3[] = {
+    0x03,       /* function section */
+    2, 1, 0x00, /* function type 0 */
+
+    0x06,                         /* global section */
+    86,                           /* section size */
+    17,                           /* num of global vars */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+
+    0x07,                               /* export section */
+    13,                                 /* size of section */
+    1,                                  /* num of funcs */
+    0x05, 0x73, 0x74, 0x61, 0x72, 0x74, /* "start" function */
+    0x00, 0x80, 0x80, 0x80, 0x80, 0x00, /* placeholder for func index*/
+
+    0x0a,                         /* code section */
+    0x80, 0x80, 0x80, 0x80, 0x00, /* placeholder for section size*/
+    1,                            /* num of codes */
+    0x80, 0x80, 0x80, 0x80, 0x00, /* placeholder for code size */
+    0x0,                          /* local variables (none) */
+};
+
+#define MOD_3_PH_EXPORT_START_FUNC_IDX 102
+#define MOD_3_PH_CODE_SECTION_SIZE_OFF 108
+#define MOD_3_PH_CODE_SIZE_OFF 114
+#define MOD_3_VARIABLES_SIZE 5
+#define MOD_3_CODE_SECTION_SIZE_ADD 11
+
+static void fill_uint32_leb128(uint8_t *b, uint32_t v)
+{
+    do {
+        *b |= v & 0x7f;
+        v >>= 7;
+        b++;
+    } while (v != 0);
+}
+
+typedef struct FillValueU32 {
+    int64_t offset;
+    uint32_t value;
+} FillValueU32;
+
+static int write_mod(TCGContext *s, const uint8_t mod[], int len,
+                     FillValueU32 values[], int values_len)
+{
+    void *base = s->code_ptr;
+
+    if (unlikely(((void *)s->code_ptr + len)
+                 > s->code_gen_highwater)) {
+        return -1;
+    }
+
+    memcpy(s->code_ptr, mod, len);
+    s->code_ptr += len;
+
+    for (int i = 0; i < values_len; i++) {
+        fill_uint32_leb128(base + values[i].offset, values[i].value);
+    }
+
+    return 0;
+}
+
+static int write_mod_code(TCGContext *s)
+{
+    void *base = s->code_ptr;
+    int code_size = sub_buf_len();
+    BlockPlaceholder *e;
+
+    if (unlikely(((void *)s->code_ptr + code_size) > s->code_gen_highwater)) {
+        return -1;
+    }
+    linked_buf_write(&sub_buf, s->code_ptr);
+    s->code_ptr += code_size;
+
+    QSIMPLEQ_FOREACH(e, &block_placeholder, entry) {
+        uint8_t *ph = e->pos + base;
+        int blk = get_block_of_label(e->label);
+        tcg_debug_assert(blk >= 0);
+        fill_uint32_leb128(ph, blk);
+    }
+
+    return 0;
+}
+
 static void tcg_out_tb_start(TCGContext *s)
 {
     intptr_t ofs;
+    struct WasmTBHeader *h;
 
     init_sub_buf();
     init_blocks();
     init_label_info();
     init_helpers();
+    init_types_buf();
+    init_imports_buf();
+
+    /* TB starts from a header */
+    h = (struct WasmTBHeader *)(s->code_ptr);
+    s->code_ptr += sizeof(struct WasmTBHeader);
+
+    /* Followed by TCI code */
+    h->tci_ptr = s->code_ptr;
 
     /* Initialize fundamental registers */
     tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(TCG_AREG0));
@@ -2113,10 +2448,81 @@ static void tcg_out_tb_start(TCGContext *s)
 
 static int tcg_out_tb_end(TCGContext *s)
 {
+    int res;
+    struct WasmTBHeader *h = (struct WasmTBHeader *)(s->code_buf);
+
     tcg_wasm_out_op(s, OPC_END); /* end if */
     tcg_wasm_out_op(s, OPC_END); /* end loop */
     tcg_wasm_out_op(s, OPC_UNREACHABLE);
     tcg_wasm_out_op(s, OPC_END); /* end func */
 
+    /* write wasm blob */
+    h->wasm_ptr = s->code_ptr;
+
+    res = write_mod(s, mod_1, sizeof(mod_1), (FillValueU32[]) {
+            {
+                MOD_1_PH_TYPE_SECTION_SIZE_OFF,
+                linked_buf_len(&types_buf) +
+                sizeof(mod_1) - MOD_1_PH_TYPE_VEC_NUM_OFF
+            },
+            {
+                MOD_1_PH_TYPE_VEC_NUM_OFF,
+                HELPER_IDX_START + helpers_len() + 1/* start */
+            },
+    }, 2);
+    if (res < 0) {
+        return res;
+    }
+    s->code_ptr += linked_buf_write(&types_buf, s->code_ptr);
+
+    res = write_mod(s, mod_2, sizeof(mod_2), (FillValueU32[]) {
+            {
+                MOD_2_PH_IMPORT_SECTION_SIZE_OFF,
+                linked_buf_len(&imports_buf) +
+                sizeof(mod_2) - MOD_2_PH_IMPORT_VEC_NUM_OFF
+            },
+            {
+                MOD_2_PH_IMPORT_VEC_NUM_OFF,
+                HELPER_IDX_START + helpers_len() + 1/* memory */
+            },
+    }, 2);
+    if (res < 0) {
+        return res;
+    }
+    s->code_ptr += linked_buf_write(&imports_buf, s->code_ptr);
+
+    res = write_mod(s, mod_3, sizeof(mod_3), (FillValueU32[]) {
+            {
+                MOD_3_PH_EXPORT_START_FUNC_IDX,
+                HELPER_IDX_START + helpers_len()
+            },
+            {
+                MOD_3_PH_CODE_SECTION_SIZE_OFF,
+                sub_buf_len() + MOD_3_CODE_SECTION_SIZE_ADD
+            },
+            {
+                MOD_3_PH_CODE_SIZE_OFF,
+                sub_buf_len() + MOD_3_VARIABLES_SIZE
+            },
+    }, 3);
+    if (res < 0) {
+        return res;
+    }
+
+    res = write_mod_code(s);
+    if (res < 0) {
+        return res;
+    }
+    h->wasm_size = (intptr_t)s->code_ptr - (intptr_t)h->wasm_ptr;
+
+    /* record imported helper functions */
+    if (unlikely(((void *)s->code_ptr + helpers_len() * 4)
+                 > s->code_gen_highwater)) {
+        return -1;
+    }
+    h->import_ptr = s->code_ptr;
+    s->code_ptr += helpers_write_to_array((intptr_t *)s->code_ptr);
+    h->import_size = (intptr_t)s->code_ptr - (intptr_t)h->import_ptr;
+
     return 0;
 }
-- 
2.43.0


