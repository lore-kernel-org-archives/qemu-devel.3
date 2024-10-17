Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40668D3C526
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 17:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1UXu-0003R6-3B; Thu, 17 Oct 2024 13:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1UXs-0003Qn-8s
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 13:44:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1UXq-0002Oy-Cd
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 13:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729187057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ah06S2G+f5fluSA2AMIZ2frEtaGnaP8XBwL+xhcL0ho=;
 b=TpOzwQnSkzfvgFo4POaINuJxU2M+DzNTXWf4dkIPB66ov5CseV0292ZPU+Hxo9MivyftvL
 B5ixLbn4SpipReIBEqdj3OibdMZKYO1syHAECQBRY7a4Yd+2nwMVBrluQSZgPkC93zRAPg
 CR6LVyM83yIPEG6gMKcmyrvkPLtVbww=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-Z6Eu9b_pMouMyNg8vU5n3w-1; Thu, 17 Oct 2024 13:44:15 -0400
X-MC-Unique: Z6Eu9b_pMouMyNg8vU5n3w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4315ad4938fso7181735e9.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 10:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729187053; x=1729791853;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ah06S2G+f5fluSA2AMIZ2frEtaGnaP8XBwL+xhcL0ho=;
 b=s59BcnciCi7EeI4lZJa5pmnHge1J3z7hlLeDAaxit9ct8DyFzdwAqr8OBIpunQ1gri
 sTfSuBSZSWXvL3QkacA8JWWo43QJQVNr8ixIvghEOpMD1gpNCSsa6gyYy180tUKcZnuo
 SoX2aiUsuUFkiAehnAVTYlbBxSTOUIUudxJ9TCk4QWF92MOiwcZAJKt1Nfz0XQhH9/PS
 iuRw+cRWiqb30UrJrbjvlDPtkv7gEhVUA6/PzbuTpVZe0vZWm9lKivAacujqJDa8Duhh
 NJxTMqmB/Pbpamsx1oSCy88eG7o9oGpwSjs6Kn/p70db4X8Ix04A4R5jCG3fkOpuUjrd
 n6lA==
X-Gm-Message-State: AOJu0YyYjnnvE0cMbDDg5MGwc9iWyVygBEmPDotJ19poQ4XcAy2hl6Fv
 8VyNBdcjDjfvoikVjaVx8t9PXM9jOajp6eaTrCIv0rPM788HVqqqw0agbqsZYDUaCKXwMWS/xv3
 p8NGedACW2W5APWA9mt5IVHxo11UP5TJXvmddVY2W8x8EOfyLbprr5I7lhoIAJKCsjlV7XcgZ+U
 RNLnYFzSCcsnuTcozARGn99B9uoZpXxouDyzsQzAU=
X-Received: by 2002:a05:600c:4f4e:b0:431:50fa:89c4 with SMTP id
 5b1f17b1804b1-43150fa8c5cmr50005255e9.3.1729187053186; 
 Thu, 17 Oct 2024 10:44:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNNwcnR3SbCb79dyH9f2BBdc38k4iW4aYqKCIF9FPxrLpiKkuQROHuih9XSdsIIiZaSCRxHg==
X-Received: by 2002:a05:600c:4f4e:b0:431:50fa:89c4 with SMTP id
 5b1f17b1804b1-43150fa8c5cmr50005035e9.3.1729187052697; 
 Thu, 17 Oct 2024 10:44:12 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d94626094sm3148828f8f.88.2024.10.17.10.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 10:44:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PULL v2 00/26] x86 and KVM patches for 2024-10-15
Date: Thu, 17 Oct 2024 19:44:08 +0200
Message-ID: <20241017174409.832033-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit f774a677507966222624a9b2859f06ede7608100:

  Merge tag 'pull-target-arm-20241015-1' of https://git.linaro.org/people/p=
maydell/qemu-arm into staging (2024-10-15 15:18:22 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 15d955975bd484c2c66af0d6daaa02a7d04d2256:

  target/i386: Use only 16 and 32-bit operands for IN/OUT (2024-10-17 19:41=
:30 +0200)

----------------------------------------------------------------
* tcg/s390x: Fix for TSTEQ/TSTNE
* target/i386: Fixes for IN and OUT with REX prefix
* target/i386: New CPUID features and logic fixes
* target/i386: Add support save/load HWCR MSR
* target/i386: Move more instructions to new decoder; separate decoding
  and IR generation
* target/i386/tcg: Use DPL-level accesses for interrupts and call gates
* accel/kvm: perform capability checks on VM file descriptor when necessary
* accel/kvm: dynamically sized kvm memslots array
* target/i386: fixes for Hyper-V
* docs/system: Add recommendations to Hyper-V enlightenments doc

----------------------------------------------------------------

v1->v2: new patch to fix tcg/s390x
        mark new patch and "check for KVM_CAP_READONLY_MEM on VM" for stable

Chao Gao (1):
      target/i386: Add more features enumerated by CPUID.7.2.EDX

Gao Shiyuan (1):
      target/i386: Add support save/load HWCR MSR

Paolo Bonzini (10):
      tcg/s390x: fix constraint for 32-bit TSTEQ/TSTNE
      target/i386: convert bit test instructions to new decoder
      target/i386: decode address before going back to translate.c
      target/i386: convert CMPXCHG8B/CMPXCHG16B to new decoder
      target/i386: do not check PREFIX_LOCK in old-style decoder
      target/i386: list instructions still in translate.c
      target/i386: assert that cc_op* and pc_save are preserved
      target/i386/tcg: Use DPL-level accesses for interrupts and call gates
      accel/kvm: check for KVM_CAP_MULTI_ADDRESS_SPACE on vm
      accel/kvm: check for KVM_CAP_MEMORY_ATTRIBUTES on vm

Peter Xu (4):
      KVM: Dynamic sized kvm memslots array
      KVM: Define KVM_MEMSLOTS_NUM_MAX_DEFAULT
      KVM: Rename KVMMemoryListener.nr_used_slots to nr_slots_used
      KVM: Rename KVMState->nr_slots to nr_slots_max

Richard Henderson (1):
      target/i386: Use only 16 and 32-bit operands for IN/OUT

Tom Dohrmann (1):
      accel/kvm: check for KVM_CAP_READONLY_MEM on VM

Vitaly Kuznetsov (4):
      target/i386: Fix conditional CONFIG_SYNDBG enablement
      target/i386: Exclude 'hv-syndbg' from 'hv-passthrough'
      target/i386: Make sure SynIC state is really updated before KVM_RUN
      docs/system: Add recommendations to Hyper-V enlightenments doc

Xiaoyao Li (4):
      target/i386: Don't construct a all-zero entry for CPUID[0xD 0x3f]
      target/i386: Enable fdp-excptn-only and zero-fcs-fds
      target/i386: Construct CPUID 2 as stateful iff times > 1
      target/i386: Make invtsc migratable when user sets tsc-khz explicitly

 docs/system/i386/hyperv.rst      |  43 +++-
 include/sysemu/kvm_int.h         |   7 +-
 target/i386/cpu.h                |   9 +
 target/i386/tcg/decode-new.h     |  19 +-
 accel/kvm/kvm-all.c              | 131 ++++++++----
 target/i386/cpu.c                |  21 +-
 target/i386/kvm/hyperv.c         |   1 +
 target/i386/kvm/kvm.c            |  47 +++--
 target/i386/machine.c            |  20 ++
 target/i386/tcg/seg_helper.c     |  17 +-
 target/i386/tcg/translate.c      | 444 ++++++-----------------------------=
----
 target/i386/tcg/decode-new.c.inc | 145 +++++++++----
 target/i386/tcg/emit.c.inc       | 246 +++++++++++++++++++++-
 tcg/s390x/tcg-target.c.inc       |  24 ++-
 accel/kvm/trace-events           |   1 +
 15 files changed, 682 insertions(+), 493 deletions(-)
--=20
2.46.2

From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 17 Oct 2024 11:09:52 +0200
Subject: [PULL 11/26] tcg/s390x: fix constraint for 32-bit TSTEQ/TSTNE
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

32-bit TSTEQ and TSTNE is subject to the same constraints as
for 64-bit, but setcond_i32 and negsetcond_i32 were incorrectly
using TCG_CT_CONST ("i") instead of TCG_CT_CONST_CMP ("C").

Adjust the constraint and make tcg_target_const_match use the
same sequence as tgen_cmp2: first check if the constant is a
valid operand for TSTEQ/TSTNE, then accept everything for 32-bit
non-test comparisons, finally check if the constant is a valid
operand for 64-bit non-test comparisons.

Reported-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Cc: qemu-stable@nongnu.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tcg/s390x/tcg-target.c.inc | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index a5d57197a4b..27bccc14e50 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -565,6 +565,20 @@ static bool tcg_target_const_match(int64_t val, int ct,
     }
=20
     if (ct & TCG_CT_CONST_CMP) {
+        if (is_tst_cond(cond)) {
+            if (is_const_p16(uval) >=3D 0) {
+                return true;  /* TMxx */
+            }
+            if (risbg_mask(uval)) {
+                return true;  /* RISBG */
+            }
+            return false;
+        }
+
+        if (type =3D=3D TCG_TYPE_I32) {
+            return true;
+        }
+
         switch (cond) {
         case TCG_COND_EQ:
         case TCG_COND_NE:
@@ -584,13 +598,7 @@ static bool tcg_target_const_match(int64_t val, int ct,
             break;
         case TCG_COND_TSTNE:
         case TCG_COND_TSTEQ:
-            if (is_const_p16(uval) >=3D 0) {
-                return true;  /* TMxx */
-            }
-            if (risbg_mask(uval)) {
-                return true;  /* RISBG */
-            }
-            break;
+            /* checked above, fallthru */
         default:
             g_assert_not_reached();
         }
@@ -3231,9 +3239,9 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpc=
ode op)
     case INDEX_op_rotl_i64:
     case INDEX_op_rotr_i32:
     case INDEX_op_rotr_i64:
+        return C_O1_I2(r, r, ri);
     case INDEX_op_setcond_i32:
     case INDEX_op_negsetcond_i32:
-        return C_O1_I2(r, r, ri);
     case INDEX_op_setcond_i64:
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rC);
--=20
2.46.2


