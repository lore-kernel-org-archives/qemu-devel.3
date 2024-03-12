Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31653C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5Yp-0000gn-5C; Tue, 12 Mar 2024 13:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5VX-00083R-Uh; Tue, 12 Mar 2024 13:01:44 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5VW-00009P-2D; Tue, 12 Mar 2024 13:01:43 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e6ac58fceaso605905b3a.1; 
 Tue, 12 Mar 2024 10:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262899; x=1710867699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1+p2N2ydmuh4NiUkruo5k6BsdLADhep4spOhwhm1AwI=;
 b=lzUZcIl5D8zyg/kQNpviQJIq365TZuoVrLRkdaDCH20SJgVXYygqDSC5rlUdpGGMup
 o10V943ujIIITG0tu6rS4cYt1P8PfsmW3Inorw7nQFYZR88uy3g5K9GwYrMksmYYYtVP
 Ebh+hptIvjMSBxkg2TbsSBeci2zCFcdxd8ygCeXLbHFHWALLfjTdOmZxbLDts/r8Kng4
 xfVCJIJ7rZyCRDftDUXx4ct6lLge89cFYd3Yh1NuHrVXQobkZZT9MAV7tUddX9SgTdaA
 npFuIm7jCXHYy4xTMN5XOjjP8eSkAVUnVY43ySApFfV5IRa67mI3WU0+16zgAJN4RutC
 D06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262899; x=1710867699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1+p2N2ydmuh4NiUkruo5k6BsdLADhep4spOhwhm1AwI=;
 b=JuwKZUAM56WqG2P0EKkwT2Z1WnA5QWe8fNuTUffF9osi2vjulOq/lQqpTVurp4YLXU
 +UQr0DVfK8+K6VB9XNr/ACfMXaxRQYT3TlIYZyYwqUVPX+e1RbGxXP7X54MaRAffFjII
 eJ71ocWet1yeLvFJIM+E/6v8TA2hIVdHHx217nvuFuYeHGV4y5I15ZSPb64cs3PBzzKW
 /h1rWcaqm8UkH0k9KTLCXKj8R96yxUOxUZ3CZlqsC7j6mxcf3nWu4OIwIFnzRFP4wh1c
 mM9Aisj61h6X2hrsxw2l28nkwdWXwacvJwaQmpvPBU7uZh9QDu/9C2td0jjYNoBh1TTy
 jA6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9oU6G7y81yO0rQgROqO0LS5Tbt/IYVnbJa75rA4fFY77c1fN/YCKF3L6RDZd+147e6qomwZZrjw4kpU+Qf9l/+sfd
X-Gm-Message-State: AOJu0YwTYc5M734qYqExen8Os7NqBN8veYtIxcW1wyjDz11j09pn7lfg
 gT7EM+lAIRC2mqd1qtxvj/lxIqdxSYW5frizIjAhdogJgL+t5/VDpVBnHJd1P4Y=
X-Google-Smtp-Source: AGHT+IGQj20GoVZOoCvsTVrpTfhh8reWlaOfqq+/qg1Q7DDVCb9QZfbs1k33lbF+OUZTKpOotFJJVw==
X-Received: by 2002:a05:6a00:178a:b0:6e6:57c8:6fc3 with SMTP id
 s10-20020a056a00178a00b006e657c86fc3mr112481pfg.0.1710262898683; 
 Tue, 12 Mar 2024 10:01:38 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.10.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 10:01:38 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Michael Neuling <mikey@neuling.org>
Subject: [PULL 36/38] spapr: nested: Use correct source for parttbl info for
 nested PAPR API.
Date: Wed, 13 Mar 2024 02:58:47 +1000
Message-ID: <20240312165851.2240242-37-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312165851.2240242-1-npiggin@gmail.com>
References: <20240312165851.2240242-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

For nested PAPR API, we use SpaprMachineStateNestedGuest struct to store
partition table info, use the same in spapr_get_pate_nested() via
helper.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c                |  6 +++--
 hw/ppc/spapr_nested.c         | 41 ++++++++++++++++++++++++++---------
 include/hw/ppc/spapr_nested.h |  2 ++
 3 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e001ffe06f..aaf73781b0 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1421,11 +1421,13 @@ static bool spapr_get_pate(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu,
         entry->dw1 = spapr->patb_entry;
         return true;
     } else {
-        assert(spapr_nested_api(spapr));
         if (spapr_nested_api(spapr) == NESTED_API_KVM_HV) {
             return spapr_get_pate_nested_hv(spapr, cpu, lpid, entry);
+        } else if (spapr_nested_api(spapr) == NESTED_API_PAPR) {
+            return spapr_get_pate_nested_papr(spapr, cpu, lpid, entry);
+        } else {
+            g_assert_not_reached();
         }
-        return false;
     }
 }
 
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index cea282926f..1a5cb254c9 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -58,6 +58,31 @@ bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
     return true;
 }
 
+static
+SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *spapr,
+                                                     target_ulong guestid)
+{
+    SpaprMachineStateNestedGuest *guest;
+
+    guest = g_hash_table_lookup(spapr->nested.guests, GINT_TO_POINTER(guestid));
+    return guest;
+}
+
+bool spapr_get_pate_nested_papr(SpaprMachineState *spapr, PowerPCCPU *cpu,
+                                target_ulong lpid, ppc_v3_pate_t *entry)
+{
+    SpaprMachineStateNestedGuest *guest;
+    assert(lpid != 0);
+    guest = spapr_get_nested_guest(spapr, lpid);
+    if (!guest) {
+        return false;
+    }
+
+    entry->dw0 = guest->parttbl[0];
+    entry->dw1 = guest->parttbl[1];
+    return true;
+}
+
 #define PRTS_MASK      0x1f
 
 static target_ulong h_set_ptbl(PowerPCCPU *cpu,
@@ -540,16 +565,6 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
     }
 }
 
-static
-SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *spapr,
-                                                     target_ulong guestid)
-{
-    SpaprMachineStateNestedGuest *guest;
-
-    guest = g_hash_table_lookup(spapr->nested.guests, GINT_TO_POINTER(guestid));
-    return guest;
-}
-
 static bool spapr_nested_vcpu_check(SpaprMachineStateNestedGuest *guest,
                                     target_ulong vcpuid, bool inoutbuf)
 {
@@ -1590,6 +1605,12 @@ bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
     return false;
 }
 
+bool spapr_get_pate_nested_papr(SpaprMachineState *spapr, PowerPCCPU *cpu,
+                                target_ulong lpid, ppc_v3_pate_t *entry)
+{
+    return false;
+}
+
 void spapr_register_nested_papr(void)
 {
     /* DO NOTHING */
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index bf9b258c29..93ef14adcc 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -519,4 +519,6 @@ bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
                               target_ulong lpid, ppc_v3_pate_t *entry);
 uint8_t spapr_nested_api(SpaprMachineState *spapr);
 void spapr_nested_gsb_init(void);
+bool spapr_get_pate_nested_papr(SpaprMachineState *spapr, PowerPCCPU *cpu,
+                                target_ulong lpid, ppc_v3_pate_t *entry);
 #endif /* HW_SPAPR_NESTED_H */
-- 
2.42.0


