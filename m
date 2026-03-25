Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE084106B534
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 21:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Vcf-0001dv-1D; Wed, 25 Mar 2026 17:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5Vcd-0001cs-T7
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:18:39 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5Vca-0001qw-R5
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:18:39 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43b4f48c47cso203710f8f.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 14:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774473515; x=1775078315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sYLEjfbOiczTZUFDQRpJ1WZc2p5N+UskvmbNC3BaZgI=;
 b=S/YXUGD6YXLJjanHRcE+nmVClXdBBIv+shjUwLVqpzHsjSCWOIurU23J3IHKTG6HIz
 uhvIPwqkD+AhruLJ0pJ3f92H2HXBCGbABF6jFDZNwV0Mmt4TF1ytjsC+n6S5Kdf5u5Lj
 2l608vgp7PdBM3ka0A9MM1ezJpvqw/lqoeghvr/WHWq86c6ADkE9xdWHIyjNIq0CKI9D
 5Wm0GuFb9dZdF6BYZplUS7m5e+lGtTZTWsWoIirzLoemMdGteqROw7tyJ+JzUqUIO/a9
 Syg5OJlQBMgZyl4ggpALcHf8WUy0TY1+exvgbDxRu1rOOn8TCrkmDeiuGni9LEzsK1pJ
 ZjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774473515; x=1775078315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sYLEjfbOiczTZUFDQRpJ1WZc2p5N+UskvmbNC3BaZgI=;
 b=DEeB/hZpm39imch12Zs76aG4iXQIaWgxpMqJ3PS+NWbfdRSvC4XbyFlCTBs893WWsq
 M3Y+5b0OnqdzqTv2phA5u+lY3MX0RN5eurhb4wqPvGS4G9nlxrO9VQKKxQOqnsTd1KDY
 UMtZ75RcsGzuuLDlXJ30s006FrHfrTMl+FHF+i63Pm7rL4DSV6jrIvvCqbnQ3d0piAvZ
 xq1Ysbcf+BHvT16l8dyVethRnCaaW6hWo/TPydWKFQ2YnxIBYdyAK1yHrrK0Biw8kmer
 YNNqwrMlVpAA0+TJM3ydaTDPLQepqszN6iNk6Yf/JkOjaisPGZn+t2FMblreS+sow/xY
 Ei7g==
X-Gm-Message-State: AOJu0YyRhAa7cSTKcGp3k64y7ClU1QG+UgVRwPP3z7DP7iuKW/l3LGid
 TZUcoUZ8gh/3sUahQAB/BF+DAUSYX7HbcajWDCBF0p0miLO5FK2p/bq8Vskadp4n3RgFhNo48VM
 cE2xzVOA=
X-Gm-Gg: ATEYQzyCmUbAvySaZmI4biS8sPAdJ5VGyQ/rMXGiERpxhDmf0x/4poWWyMDihEzY5nU
 Q99igmrXktDSxOL4lAIzxbk5zRMmNwpfgyEyLeL122PQTCYy88Y7e8B8cVXIuGUXmH+GLuSnbZg
 1Gjqrf0wwIQtdVP3+zL7DBzILrJbLU21E8Zd6NW/7KvZVDgEXJJoouNhpOPKw2S3e8YnIYvZ/pH
 OEuUfOo6GdVcMODuPTm5m1Ul9YwkOexOD+vCeJbUrB8ueN0KLvUZ01kgQC60PcUENU0Ir6OK8To
 DGIoRWukT1f/v191r+pr342pvA8J31oTCy0YkXNj7Z/HD26WcYI1NEJxNW13C2zuLIi808sJ8Qf
 vVCb281hc/rlGKv8xx8dzN+KsdvcnBsJikLXFS7ZEN0KAh0pit/xMf/SjatsAmw7Bn4btGRB2UW
 HORlKKNAXD4EYOk4rdyB5KBtxfbQQueRf/wHZj6uElHu/BJCS6XRKKB8Vnfwo3uwTWxZKjzmbj
X-Received: by 2002:a05:6000:2dc7:b0:439:b6d6:723 with SMTP id
 ffacd0b85a97d-43b88a1bcc5mr7764409f8f.42.1774473514778; 
 Wed, 25 Mar 2026 14:18:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b9192e3e8sm2917709f8f.5.2026.03.25.14.18.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Mar 2026 14:18:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 09/10] target/sparc: Replace VMSTATE_VARRAY_MULTIPLY
 -> VMSTATE_UINTTL_ARRAY
Date: Wed, 25 Mar 2026 22:17:27 +0100
Message-ID: <20260325211728.89204-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325211728.89204-1-philmd@linaro.org>
References: <20260325211728.89204-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

VMSTATE_VARRAY_MULTIPLY() seems to be an "optimized" version
of VMSTATE_UINTTL_ARRAY(), and is only used once. Prefer the
generic macro, removing the need for the VMS_MULTIPLY_ELEMENTS
field.

Bump the SPARC CPU migration stream version.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/migration/cpu.h     |  2 --
 include/migration/vmstate.h | 22 +++-------------------
 migration/vmstate.c         |  4 ----
 target/sparc/machine.c      |  7 +++----
 4 files changed, 6 insertions(+), 29 deletions(-)

diff --git a/include/migration/cpu.h b/include/migration/cpu.h
index ea411d863ad..05a1ddde343 100644
--- a/include/migration/cpu.h
+++ b/include/migration/cpu.h
@@ -12,13 +12,11 @@
     VMSTATE_UINT64_V(_f, _s, _v)
 #define VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, _v)                        \
     VMSTATE_UINT64_ARRAY_V(_f, _s, _n, _v)
-#define vmstate_info_uinttl vmstate_info_uint64
 #else
 #define VMSTATE_UINTTL_V(_f, _s, _v)                                  \
     VMSTATE_UINT32_V(_f, _s, _v)
 #define VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, _v)                        \
     VMSTATE_UINT32_ARRAY_V(_f, _s, _n, _v)
-#define vmstate_info_uinttl vmstate_info_uint32
 #endif
 
 #define VMSTATE_UINTTL(_f, _s)                                        \
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 62c2abd0c49..663b0c8ae06 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -94,7 +94,7 @@ enum VMStateFlags {
     VMS_ARRAY_OF_POINTER = 0x040,
 
     /* The field is an array of variable size. The uint16_t at opaque
-     * + VMStateField.num_offset (subject to VMS_MULTIPLY_ELEMENTS)
+     * + VMStateField.num_offset
      * contains the number of entries in the array. See the VMS_ARRAY
      * description regarding array handling in general. May not be
      * combined with VMS_ARRAY or any other VMS_VARRAY*. */
@@ -115,14 +115,14 @@ enum VMStateFlags {
     VMS_MULTIPLY         = 0x200,
 
     /* The field is an array of variable size. The uint8_t at opaque +
-     * VMStateField.num_offset (subject to VMS_MULTIPLY_ELEMENTS)
+     * VMStateField.num_offset
      * contains the number of entries in the array. See the VMS_ARRAY
      * description regarding array handling in general. May not be
      * combined with VMS_ARRAY or any other VMS_VARRAY*. */
     VMS_VARRAY_UINT8     = 0x400,
 
     /* The field is an array of variable size. The uint32_t at opaque
-     * + VMStateField.num_offset (subject to VMS_MULTIPLY_ELEMENTS)
+     * + VMStateField.num_offset
      * contains the number of entries in the array. See the VMS_ARRAY
      * description regarding array handling in general. May not be
      * combined with VMS_ARRAY or any other VMS_VARRAY*. */
@@ -139,12 +139,6 @@ enum VMStateFlags {
      * cause the individual entries to be allocated. */
     VMS_ALLOC            = 0x2000,
 
-    /* Multiply the number of entries given by the integer at opaque +
-     * VMStateField.num_offset (see VMS_VARRAY*) with VMStateField.num
-     * to determine the number of entries in the array. Only valid in
-     * combination with one of VMS_VARRAY*. */
-    VMS_MULTIPLY_ELEMENTS = 0x4000,
-
     /* A structure field that is like VMS_STRUCT, but uses
      * VMStateField.struct_version_id to tell which version of the
      * structure we are referencing to use. */
@@ -398,16 +392,6 @@ extern const VMStateInfo vmstate_info_qlist;
     .offset     = vmstate_offset_2darray(_state, _field, _type, _n1, _n2),  \
 }
 
-#define VMSTATE_VARRAY_MULTIPLY(_field, _state, _field_num, _multiply, _info, _type) { \
-    .name       = (stringify(_field)),                               \
-    .num_offset = vmstate_offset_value(_state, _field_num, uint32_t),\
-    .num        = (_multiply),                                       \
-    .info       = &(_info),                                          \
-    .size       = sizeof(_type),                                     \
-    .flags      = VMS_VARRAY_UINT32|VMS_MULTIPLY_ELEMENTS,           \
-    .offset     = vmstate_offset_varray(_state, _field, _type),      \
-}
-
 #define VMSTATE_SUB_ARRAY(_field, _state, _start, _num, _version, _info, _type) { \
     .name       = (stringify(_field)),                               \
     .version_id = (_version),                                        \
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 4d28364f7ba..e960bc7a7c4 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -97,10 +97,6 @@ static int vmstate_n_elems(void *opaque, const VMStateField *field)
         n_elems = *(uint8_t *)(opaque + field->num_offset);
     }
 
-    if (field->flags & VMS_MULTIPLY_ELEMENTS) {
-        n_elems *= field->num;
-    }
-
     trace_vmstate_n_elems(field->name, n_elems);
     return n_elems;
 }
diff --git a/target/sparc/machine.c b/target/sparc/machine.c
index 0a449f2f8c6..5f402e098cf 100644
--- a/target/sparc/machine.c
+++ b/target/sparc/machine.c
@@ -189,9 +189,9 @@ static int cpu_pre_save(void *opaque)
  * versions are different.
  */
 #ifndef TARGET_SPARC64
-#define SPARC_VMSTATE_VER 7
+#define SPARC_VMSTATE_VER 8
 #else
-#define SPARC_VMSTATE_VER 9
+#define SPARC_VMSTATE_VER 10
 #endif
 
 const VMStateDescription vmstate_sparc_cpu = {
@@ -202,8 +202,7 @@ const VMStateDescription vmstate_sparc_cpu = {
     .fields = (const VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(env.gregs, SPARCCPU, 8),
         VMSTATE_UINT32(env.nwindows, SPARCCPU),
-        VMSTATE_VARRAY_MULTIPLY(env.regbase, SPARCCPU, env.nwindows, 16,
-                                vmstate_info_uinttl, target_ulong),
+        VMSTATE_UINTTL_ARRAY(env.regbase, SPARCCPU, MAX_NWINDOWS * 16 + 8),
         VMSTATE_CPUDOUBLE_ARRAY(env.fpr, SPARCCPU, TARGET_DPREGS),
         VMSTATE_UINTTL(env.pc, SPARCCPU),
         VMSTATE_UINTTL(env.npc, SPARCCPU),
-- 
2.53.0


