Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4DE107BCD9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 19:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w17zd-000226-50; Fri, 13 Mar 2026 15:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1w17za-00021h-SW
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 15:16:15 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1w17zW-000871-4c
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 15:16:14 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4671cbce2feso1144774b6e.3
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 12:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1773429367; x=1774034167;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x+XFIkuJroaTGFW+LTP/H8OwGI5xiQcEDLoqgEwG0jk=;
 b=BfsNs28MY98svO5vHDXl8SN6cJ8304EntAkrfmL4gm4Nud4S76RR61TudrI/k92ad7
 Y6gS790YCHBsbSnpx13euDHtEWVC/lv+277IY0NH7FllKQMu/rXqK2Llkyyeh4eblVaP
 uCJiBnbMO4OQUusOGEoU3mA9j0Olq6+ySU4Py/sR/umGhEqeMMQwPXSMWaS1mXqYe21G
 LIgH6wC6BIlXMJwD5tc3AyPqHg+9VMr3/M9eEtA/lJ6A0PNY20wj2BGNYJ5Dhw+LAjAp
 8SNXdLDfQIrWEpz+jBYbcxexvm2Wf6zsPxCtp4xxjRAJltDxT3a56C+k2tLVJGZoj8l1
 vMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773429367; x=1774034167;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+XFIkuJroaTGFW+LTP/H8OwGI5xiQcEDLoqgEwG0jk=;
 b=IGO57oFouOa7JhSkh0JtZQWZROj8G5CETueDtTQoix5Nppnqv8ybd6mANaYZlylrQb
 tFfPnjif+Epu0/BOBsjeH3md6mSlRFkxHlc25P1eHxagOTA6LP1l4VSGFoZDnFcdnICO
 o7OgwUtOrilbc7V6XtxkQ3w0xnNozCZcpEJ7nxAvcIEXGIT2QfNGtIkje2fEapUrByu2
 n1LTX8liZANIKl5J5GFPwtz+suW+o+zReW9iSknQZwBFDLBbI6E0DUYm4kFVaCFUENhi
 qDdBeBS9yr1Dme8NLfk/2ORnqqrZHoVXNs9F7d7GoLVejejJw+QTcMBl1JMAqAH3Y/mi
 SoaQ==
X-Gm-Message-State: AOJu0YySQX9cFirB/z6zVziAyAfBYZanO7ZGVIwRgkNNydkSYznQEtjJ
 MdFfwrwXsHC0Qc3LvdUEH89tspd/DrrYU+4joYfF3Tzptz9lpUdLFL1J8bZvCgNhCY0=
X-Gm-Gg: ATEYQzxUdUfEJ5dPp/B8YEccRchulvRkeiePaskUb89GEdvvPqr+QznR0D9OSxMyVBr
 Z7ianyUbZDhjeuxU+nwnmlWb7xD9Gk+ku7Yweeh0yphBUk8ewqaDsiOglyTfACCalI/O961O/TN
 VrHydaYVVtxGOPEQt/XDDT33xvfBhWzw1TvnObZuwgVXm2FKCms0a8T7ApLmXcGLjz4oKt9LDHf
 GY30qtlBqKIwgmOftAGpJXP300h/wX5SUbc4/4ETUWK3l0wr+8Z91iwCvb6amk6B9egpDiHLH7o
 9MrLb2CZoeaO6UGlYwsYVyfN4v812+dlSlqKxUcTbx0tqUDwN2Y8iYUqGFUAsvpiUntsorqIVw+
 QmLsAFf8bblhhyM7cHXk7CDER19mrWzVMGkgQK5418YF9eIgi0bR9QqZjQsNwD3U+CWnsZapTKN
 h+H0Vymk9J7e9wjfmhf01Q
X-Received: by 2002:a05:6808:2385:b0:450:bcc7:18d7 with SMTP id
 5614622812f47-4675704dfa8mr2441934b6e.2.1773429366905; 
 Fri, 13 Mar 2026 12:16:06 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-467342c1218sm5309162b6e.11.2026.03.13.12.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 12:16:06 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 13 Mar 2026 13:15:43 -0600
Subject: [PATCH RFC v2] bsd-user: Copy linux-user/think.c to bsd-user
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260313-share-thunk-v2-1-5b52cfe6cddd@bsdimp.com>
X-B4-Tracking: v=1; b=H4sIAF5itGkC/22NQQ6CMBREr0L+2pr+VsC6MjHxAG4NiwLF/hAoa
 bHREO5u07XLN5N5s0EwnkyAS7GBN5ECuTmBOBTQWT2/DKM+MQguKi5RsGC1N2y173lkusXyXJ7
 qWikFabF4M9An257wuN+gSaGlsDr/zQ8Rc/VXFpEhE4OsOJcaFcprG3qalmPnJmj2ff8BtqRU6
 KwAAAA=
X-Change-ID: 20260312-share-thunk-ab1585477999
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=16776; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=CrwoDk/DDA0hgR95kO+NGTrHZRicCBe0WxJ3xgMeH/g=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBptGJimvrvYAs4Tj/GREraxgjB5lm5jF6fbYAal
 RI6xfr+FFWJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCabRiYgAKCRBsHNEofbAR
 ANgtD/9eaNjr1UHq9jizjkJmeLa5NKVFpsH951aG5Xv98iSTNy/O2QlgQLExoXUjjvsXYMH3QuQ
 NhcJiE4/UCyclAXjeNVfuMLpwMsgEO2xGmr9WfTIAAHXGBeXkPHLAJsZNZ2zvKqKAzK9C7QZg/n
 ml9PZYFsk1dgZg/w5BzJT7JmXFWZ7TTaAmFZ31PSAPmI33GcQloJN1IZMy2/MdApOAqDukGUUa7
 UYe9llPc+e6x5oz+ipTihaE4j5phhDEaik9WT1om9oQDy2sIExZ6uy4ZrE0UW7mjjJiVeqHycw+
 EJc65MDeJuATKdmESOGHhS7yCXJ+i94YD20O/Ipy/kzruCp0C136TGZorRylxByBxAd+4ffLNZ8
 RENYMLUq2SNVWUaf5vHdMd+eOZcyJKIiN1oxxsEG0+pvFY60C5+yFTNuOVgEZS4KwDffT+yPqa1
 l3GWG+3MNX4DnnqqSdVCBviscqp2QmboMRQiv3HwMHHU8EtOICMG5Fu2pn9q5WOwj7EpkCWjv0Y
 KO2SqDkjd5hbSiNdrCka+vtZ6uiYqmBU2ZF/9aEX9BTnGJp1kGf3eCYLXBnuxFQxpt0Ci4oxGNv
 8bqrprjmQ3j8aU4az+8IXT6KnwQX+leG+SPo1i+ob7f2pwe0B6f0aEW/qMC7QQmr+VJduRS6Uvl
 15jeRGDBkh3Sx/Q==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::235;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x235.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

bsd-user's blitz branch has used this file verbatim for a while. Copy it
verbatim, but update to the new QEMU standards.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
As suggested in the v1 thread, just copy this file.  Refactoring was
difficult due to the inter-relatedness of all its bits with
*-user/qemu.h file. We couldn't move it to common-user and putting it in
that directory because (a) qemu.h dependencies and (b) common-user is
built only once. It may be possible to refactor this into a .h file, but
the interdependencies have so far restisted my efforts to do that, so
I gave up after a couple of hours of different attempts.

● 6e7455de310b: bsd-user: Copy linux-user/think.c to bsd-user
  ● checkpatch.pl: 66: ERROR: do not use C99 // comments
  ● checkpatch.pl: 78: ERROR: space required before the open parenthesis '('
  ● checkpatch.pl: 136: ERROR: space required after that ';' (ctx:VxV)
  ● checkpatch.pl: 136: ERROR: space required before the open parenthesis '('
  ● checkpatch.pl: 142: ERROR: braces {} are necessary for all arms of this statement
  ● checkpatch.pl: 175: ERROR: space required before the open parenthesis '('
  ● checkpatch.pl: 272: ERROR: space required after that ';' (ctx:VxV)
  ● checkpatch.pl: 272: ERROR: space required before the open parenthesis '('
  ● checkpatch.pl: 301: ERROR: space required after that ';' (ctx:VxV)
  ● checkpatch.pl: 301: ERROR: space required before the open parenthesis '('
  ● checkpatch.pl: 477: WARNING: Block comments use a leading /* on a separate line
  ● checkpatch.pl: 531: WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?

I'm not fixing style issues in copied files. These files need to be
identical. Style issues have historically wasted my time tracking
upstream changes so are more harm than good. I had a simpler solution
w/o this issue, but this issue already exists in thunk.c.
---
Changes in v2:
- Just copy it
- Link to v1: https://lore.kernel.org/qemu-devel/20260312-share-thunk-v1-1-2f36003a1913@bsdimp.com
---
 bsd-user/meson.build |   1 +
 bsd-user/thunk.c     | 470 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 471 insertions(+)

diff --git a/bsd-user/meson.build b/bsd-user/meson.build
index 00428fc2f8..9cc5c6c459 100644
--- a/bsd-user/meson.build
+++ b/bsd-user/meson.build
@@ -17,6 +17,7 @@ bsd_user_ss.add(files(
   'plugin-api.c',
   'signal.c',
   'strace.c',
+  'thunk.c',
   'uaccess.c',
 ))
 
diff --git a/bsd-user/thunk.c b/bsd-user/thunk.c
new file mode 100644
index 0000000000..3c89ae3ab8
--- /dev/null
+++ b/bsd-user/thunk.c
@@ -0,0 +1,470 @@
+/*
+ * Generic thunking code to convert data between host and target CPU
+ *
+ * Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+
+#include "qemu.h"
+#include "user/thunk.h"
+
+//#define DEBUG
+
+static unsigned int max_struct_entries;
+StructEntry *struct_entries;
+
+static const argtype *thunk_type_next_ptr(const argtype *type_ptr);
+
+static inline const argtype *thunk_type_next(const argtype *type_ptr)
+{
+    int type;
+
+    type = *type_ptr++;
+    switch(type) {
+    case TYPE_CHAR:
+    case TYPE_SHORT:
+    case TYPE_INT:
+    case TYPE_LONGLONG:
+    case TYPE_ULONGLONG:
+    case TYPE_LONG:
+    case TYPE_ULONG:
+    case TYPE_PTRVOID:
+    case TYPE_OLDDEVT:
+        return type_ptr;
+    case TYPE_PTR:
+        return thunk_type_next_ptr(type_ptr);
+    case TYPE_ARRAY:
+        return thunk_type_next_ptr(type_ptr + 1);
+    case TYPE_STRUCT:
+        return type_ptr + 1;
+    default:
+        return NULL;
+    }
+}
+
+static const argtype *thunk_type_next_ptr(const argtype *type_ptr)
+{
+    return thunk_type_next(type_ptr);
+}
+
+void thunk_register_struct(int id, const char *name, const argtype *types)
+{
+    const argtype *type_ptr;
+    StructEntry *se;
+    int nb_fields, offset, max_align, align, size, i, j;
+
+    assert(id < max_struct_entries);
+
+    /* first we count the number of fields */
+    type_ptr = types;
+    nb_fields = 0;
+    while (*type_ptr != TYPE_NULL) {
+        type_ptr = thunk_type_next(type_ptr);
+        nb_fields++;
+    }
+    assert(nb_fields > 0);
+    se = struct_entries + id;
+    se->field_types = types;
+    se->nb_fields = nb_fields;
+    se->name = name;
+#ifdef DEBUG
+    printf("struct %s: id=%d nb_fields=%d\n",
+           se->name, id, se->nb_fields);
+#endif
+    /* now we can alloc the data */
+
+    for (i = 0; i < ARRAY_SIZE(se->field_offsets); i++) {
+        offset = 0;
+        max_align = 1;
+        se->field_offsets[i] = g_new(int, nb_fields);
+        type_ptr = se->field_types;
+        for(j = 0;j < nb_fields; j++) {
+            size = thunk_type_size(type_ptr, i);
+            align = thunk_type_align(type_ptr, i);
+            offset = (offset + align - 1) & ~(align - 1);
+            se->field_offsets[i][j] = offset;
+            offset += size;
+            if (align > max_align)
+                max_align = align;
+            type_ptr = thunk_type_next(type_ptr);
+        }
+        offset = (offset + max_align - 1) & ~(max_align - 1);
+        se->size[i] = offset;
+        se->align[i] = max_align;
+#ifdef DEBUG
+        printf("%s: size=%d align=%d\n",
+               i == THUNK_HOST ? "host" : "target", offset, max_align);
+#endif
+    }
+}
+
+void thunk_register_struct_direct(int id, const char *name,
+                                  const StructEntry *se1)
+{
+    StructEntry *se;
+
+    assert(id < max_struct_entries);
+    se = struct_entries + id;
+    *se = *se1;
+    se->name = name;
+}
+
+
+/* now we can define the main conversion functions */
+const argtype *thunk_convert(void *dst, const void *src,
+                             const argtype *type_ptr, int to_host)
+{
+    int type;
+
+    type = *type_ptr++;
+    switch(type) {
+    case TYPE_CHAR:
+        *(uint8_t *)dst = *(uint8_t *)src;
+        break;
+    case TYPE_SHORT:
+        *(uint16_t *)dst = tswap16(*(uint16_t *)src);
+        break;
+    case TYPE_INT:
+        *(uint32_t *)dst = tswap32(*(uint32_t *)src);
+        break;
+    case TYPE_LONGLONG:
+    case TYPE_ULONGLONG:
+        *(uint64_t *)dst = tswap64(*(uint64_t *)src);
+        break;
+#if HOST_LONG_BITS == 32 && TARGET_ABI_BITS == 32
+    case TYPE_LONG:
+    case TYPE_ULONG:
+    case TYPE_PTRVOID:
+        *(uint32_t *)dst = tswap32(*(uint32_t *)src);
+        break;
+#elif HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 32
+    case TYPE_LONG:
+    case TYPE_ULONG:
+    case TYPE_PTRVOID:
+        if (to_host) {
+            if (type == TYPE_LONG) {
+                /* sign extension */
+                *(uint64_t *)dst = (int32_t)tswap32(*(uint32_t *)src);
+            } else {
+                *(uint64_t *)dst = tswap32(*(uint32_t *)src);
+            }
+        } else {
+            *(uint32_t *)dst = tswap32(*(uint64_t *)src & 0xffffffff);
+        }
+        break;
+#elif HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 64
+    case TYPE_LONG:
+    case TYPE_ULONG:
+    case TYPE_PTRVOID:
+        *(uint64_t *)dst = tswap64(*(uint64_t *)src);
+        break;
+#elif HOST_LONG_BITS == 32 && TARGET_ABI_BITS == 64
+    case TYPE_LONG:
+    case TYPE_ULONG:
+    case TYPE_PTRVOID:
+        if (to_host) {
+            *(uint32_t *)dst = tswap64(*(uint64_t *)src);
+        } else {
+            if (type == TYPE_LONG) {
+                /* sign extension */
+                *(uint64_t *)dst = tswap64(*(int32_t *)src);
+            } else {
+                *(uint64_t *)dst = tswap64(*(uint32_t *)src);
+            }
+        }
+        break;
+#else
+#warning unsupported conversion
+#endif
+    case TYPE_OLDDEVT:
+    {
+        uint64_t val = 0;
+        switch (thunk_type_size(type_ptr - 1, !to_host)) {
+        case 2:
+            val = *(uint16_t *)src;
+            break;
+        case 4:
+            val = *(uint32_t *)src;
+            break;
+        case 8:
+            val = *(uint64_t *)src;
+            break;
+        }
+        switch (thunk_type_size(type_ptr - 1, to_host)) {
+        case 2:
+            *(uint16_t *)dst = tswap16(val);
+            break;
+        case 4:
+            *(uint32_t *)dst = tswap32(val);
+            break;
+        case 8:
+            *(uint64_t *)dst = tswap64(val);
+            break;
+        }
+        break;
+    }
+    case TYPE_ARRAY:
+        {
+            int array_length, i, dst_size, src_size;
+            const uint8_t *s;
+            uint8_t  *d;
+
+            array_length = *type_ptr++;
+            dst_size = thunk_type_size(type_ptr, to_host);
+            src_size = thunk_type_size(type_ptr, 1 - to_host);
+            d = dst;
+            s = src;
+            for(i = 0;i < array_length; i++) {
+                thunk_convert(d, s, type_ptr, to_host);
+                d += dst_size;
+                s += src_size;
+            }
+            type_ptr = thunk_type_next(type_ptr);
+        }
+        break;
+    case TYPE_STRUCT:
+        {
+            int i;
+            const StructEntry *se;
+            const uint8_t *s;
+            uint8_t  *d;
+            const argtype *field_types;
+            const int *dst_offsets, *src_offsets;
+
+            assert(*type_ptr < max_struct_entries);
+            se = struct_entries + *type_ptr++;
+            if (se->convert[0] != NULL) {
+                /* specific conversion is needed */
+                (*se->convert[to_host])(dst, src);
+            } else {
+                /* standard struct conversion */
+                field_types = se->field_types;
+                dst_offsets = se->field_offsets[to_host];
+                src_offsets = se->field_offsets[1 - to_host];
+                d = dst;
+                s = src;
+                for(i = 0;i < se->nb_fields; i++) {
+                    field_types = thunk_convert(d + dst_offsets[i],
+                                                s + src_offsets[i],
+                                                field_types, to_host);
+                }
+            }
+        }
+        break;
+    default:
+        fprintf(stderr, "Invalid type 0x%x\n", type);
+        break;
+    }
+    return type_ptr;
+}
+
+const argtype *thunk_print(void *arg, const argtype *type_ptr)
+{
+    int type;
+
+    type = *type_ptr++;
+
+    switch (type) {
+    case TYPE_CHAR:
+        qemu_log("%c", *(uint8_t *)arg);
+        break;
+    case TYPE_SHORT:
+        qemu_log("%" PRId16, tswap16(*(uint16_t *)arg));
+        break;
+    case TYPE_INT:
+        qemu_log("%" PRId32, tswap32(*(uint32_t *)arg));
+        break;
+    case TYPE_LONGLONG:
+        qemu_log("%" PRId64, tswap64(*(uint64_t *)arg));
+        break;
+    case TYPE_ULONGLONG:
+        qemu_log("%" PRIu64, tswap64(*(uint64_t *)arg));
+        break;
+#if HOST_LONG_BITS == 32 && TARGET_ABI_BITS == 32
+    case TYPE_PTRVOID:
+        qemu_log("0x%" PRIx32, tswap32(*(uint32_t *)arg));
+        break;
+    case TYPE_LONG:
+        qemu_log("%" PRId32, tswap32(*(uint32_t *)arg));
+        break;
+    case TYPE_ULONG:
+        qemu_log("%" PRIu32, tswap32(*(uint32_t *)arg));
+        break;
+#elif HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 32
+    case TYPE_PTRVOID:
+        qemu_log("0x%" PRIx32, tswap32(*(uint64_t *)arg & 0xffffffff));
+        break;
+    case TYPE_LONG:
+        qemu_log("%" PRId32, tswap32(*(uint64_t *)arg & 0xffffffff));
+        break;
+    case TYPE_ULONG:
+        qemu_log("%" PRIu32, tswap32(*(uint64_t *)arg & 0xffffffff));
+        break;
+#elif HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 64
+    case TYPE_PTRVOID:
+        qemu_log("0x%" PRIx64, tswap64(*(uint64_t *)arg));
+        break;
+    case TYPE_LONG:
+        qemu_log("%" PRId64, tswap64(*(uint64_t *)arg));
+        break;
+    case TYPE_ULONG:
+        qemu_log("%" PRIu64, tswap64(*(uint64_t *)arg));
+        break;
+#else
+    case TYPE_PTRVOID:
+        qemu_log("0x%" PRIx64, tswap64(*(uint64_t *)arg));
+        break;
+    case TYPE_LONG:
+        qemu_log("%" PRId64, tswap64(*(uint64_t *)arg));
+        break;
+    case TYPE_ULONG:
+        qemu_log("%" PRIu64, tswap64(*(uint64_t *)arg));
+        break;
+#endif
+    case TYPE_OLDDEVT:
+    {
+        uint64_t val = 0;
+        switch (thunk_type_size(type_ptr - 1, 1)) {
+        case 2:
+            val = *(uint16_t *)arg;
+            break;
+        case 4:
+            val = *(uint32_t *)arg;
+            break;
+        case 8:
+            val = *(uint64_t *)arg;
+            break;
+        }
+        switch (thunk_type_size(type_ptr - 1, 0)) {
+        case 2:
+            qemu_log("%" PRIu16, tswap16(val));
+            break;
+        case 4:
+            qemu_log("%" PRIu32, tswap32(val));
+            break;
+        case 8:
+            qemu_log("%" PRIu64, tswap64(val));
+            break;
+        }
+    }
+    break;
+    case TYPE_ARRAY:
+        {
+            int i, array_length, arg_size;
+            uint8_t *a;
+            int is_string = 0;
+
+            array_length = *type_ptr++;
+            arg_size = thunk_type_size(type_ptr, 0);
+            a = arg;
+
+            if (*type_ptr == TYPE_CHAR) {
+                qemu_log("\"");
+                is_string = 1;
+            } else {
+                qemu_log("[");
+            }
+
+            for (i = 0; i < array_length; i++) {
+                if (i > 0 && !is_string) {
+                    qemu_log(",");
+                }
+                thunk_print(a, type_ptr);
+                a += arg_size;
+            }
+
+            if (is_string) {
+                qemu_log("\"");
+            } else {
+                qemu_log("]");
+            }
+
+            type_ptr = thunk_type_next(type_ptr);
+        }
+        break;
+    case TYPE_STRUCT:
+        {
+            int i;
+            const StructEntry *se;
+            uint8_t  *a;
+            const argtype *field_types;
+            const int *arg_offsets;
+
+            se = struct_entries + *type_ptr++;
+
+            if (se->print != NULL) {
+                se->print(arg);
+            } else {
+                a = arg;
+
+                field_types = se->field_types;
+                arg_offsets = se->field_offsets[0];
+
+                qemu_log("{");
+                for (i = 0; i < se->nb_fields; i++) {
+                    if (i > 0) {
+                        qemu_log(",");
+                    }
+                    field_types = thunk_print(a + arg_offsets[i], field_types);
+                }
+                qemu_log("}");
+            }
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return type_ptr;
+}
+
+/* from em86 */
+
+/* Utility function: Table-driven functions to translate bitmasks
+ * between host and target formats
+ */
+unsigned int target_to_host_bitmask_len(unsigned int target_mask,
+                                        const bitmask_transtbl *tbl,
+                                        size_t len)
+{
+    unsigned int host_mask = 0;
+
+    for (size_t i = 0; i < len; ++i) {
+        if ((target_mask & tbl[i].target_mask) == tbl[i].target_bits) {
+            host_mask |= tbl[i].host_bits;
+        }
+    }
+    return host_mask;
+}
+
+unsigned int host_to_target_bitmask_len(unsigned int host_mask,
+                                        const bitmask_transtbl *tbl,
+                                        size_t len)
+{
+    unsigned int target_mask = 0;
+
+    for (size_t i = 0; i < len; ++i) {
+        if ((host_mask & tbl[i].host_mask) == tbl[i].host_bits) {
+            target_mask |= tbl[i].target_bits;
+        }
+    }
+    return target_mask;
+}
+
+int thunk_type_size_array(const argtype *type_ptr, int is_host)
+{
+    return thunk_type_size(type_ptr, is_host);
+}
+
+int thunk_type_align_array(const argtype *type_ptr, int is_host)
+{
+    return thunk_type_align(type_ptr, is_host);
+}
+
+void thunk_init(unsigned int max_structs)
+{
+    max_struct_entries = max_structs;
+    struct_entries = g_new0(StructEntry, max_structs);
+}

---
base-commit: 769a37d8bd0c81c39128fc292352f01bad0769f4
change-id: 20260312-share-thunk-ab1585477999

Best regards,
-- 
Warner Losh <imp@bsdimp.com>


