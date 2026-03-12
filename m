Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52522106ACEE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 21:09:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0nGv-0005tX-5L; Thu, 12 Mar 2026 17:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3VCuzaQQKCss81z8x55x2v.t537v3B-uvCv2454x4B.58x@flex--rkir.bounces.google.com>)
 id 1w0nGt-0005tJ-Ba
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 17:08:43 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3VCuzaQQKCss81z8x55x2v.t537v3B-uvCv2454x4B.58x@flex--rkir.bounces.google.com>)
 id 1w0nGr-0004JO-8N
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 17:08:42 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-2aec6c572fbso44160045ad.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 14:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1773349716; x=1773954516; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=dt3hntr+XMknIlkc9WyYiezvJf+IXkmVPBlpDR/PYCE=;
 b=xwhgKC98Hv9OSlfC1ZU5W4OO7vNliyX6tOR4VXKTXRj7FQ1f4czAcDV66qCdnocCgS
 lBN4/ViQ2dFOtU2IFzDGuy90bRBEcAEkYnAowLPDLe+mY53O1C6+xFdIfN+6JIGztTKX
 +If6US+74HPsyx24R14i+I0/0G/sbjqYo4szfRAhUcGIzjYjvV5ILXKkhdpehXdKjGA1
 fuhzEDBL2LqwZY+Fi4AisC4d5/cWwRAirIyw2xLLGSvnWcWP2XU4tFR0AGUQLJ+fbUrb
 bO8QjCwRK4GKIOhhs7XNdaHCRX6ppKeFI/kHHqB98Ywnq0C2qyj7PjBd3L3yXYylKmvt
 EdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773349716; x=1773954516;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dt3hntr+XMknIlkc9WyYiezvJf+IXkmVPBlpDR/PYCE=;
 b=oGf2zWc5/KBnrb9fNCxoVuXNNtnPQeTS/Cnspt6DjndOSKdHrfO9KhASA1398cI+NI
 gI28lOoc7F8EWN0dg4S+w6LOv649ajy04g42ylG/wNT+5Kyj/B9ylDuhM2g3ZDjA6r0/
 1IC6fgKjd/h8TgxIJYYsj12yUyGusOJKBGixbeUIyWQsXfrBWH2291xl04suZgZ5AvKU
 V4+b+U+vMFnyDKcpyQ6lt+X/ha+uBeL6/fWsRtCMykj91lG+JE7FTOH3F2j25+yW7dkv
 zJ2mdzF81Rk3tsjCRxUczfXfkZ+FwbY9T9ql7y5/xN8vICIEZwHSy5casHPtUv+T/rmT
 cSpA==
X-Gm-Message-State: AOJu0YzKW8px/p3aC026P07/KgO6HIkk68SlJ9JRIiM7XdMAt/A2IVVp
 va3mLp/NnQjD4QSL4DT2U6oVL4XLXhoOYsZqRQi70ssVZqJTjWvY3ajqndCCeAkWpRhSoRBJdw=
 =
X-Received: from plho15.prod.google.com ([2002:a17:903:23cf:b0:2a7:8c71:aa97])
 (user=rkir job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ea06:b0:2ae:4b91:8407
 with SMTP id d9443c01a7336-2aecaaa861amr8020345ad.34.1773349716036; Thu, 12
 Mar 2026 14:08:36 -0700 (PDT)
Date: Thu, 12 Mar 2026 21:08:02 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260312210802.899803-1-rkir@google.com>
Subject: [PATCH v2] vmstate: validate VMStateDescription::fields upon
 registration
From: Roman Kiryanov <rkir@google.com>
To: peterx@redhat.com, farosas@suse.de
Cc: qemu-devel@nongnu.org, whollins@google.com, jansene@google.com, 
 jpcottin@google.com, Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3VCuzaQQKCss81z8x55x2v.t537v3B-uvCv2454x4B.58x@flex--rkir.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

The vmstate_save_state_v() function does not support
NULL in VMStateDescription::fields and will crash if
one is provided.

This change prevents this situation from happening
by explicitly crashing earlier.

Suggested-by: Fabiano Rosas <farosas@suse.de>
Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Roman Kiryanov <rkir@google.com>
---
v2:
 - Moved the assert from vmstate_save_state_v to the registration
   path (vmstate_register_with_alias_id) and the qtest validation path
   (vmstate_check) to catch missing fields earlier.
---
 migration/savevm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 197c89e0e6..20c2b99231 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -861,6 +861,8 @@ static void vmstate_check(const VMStateDescription *vmsd)
     const VMStateField *field = vmsd->fields;
     const VMStateDescription * const *subsection = vmsd->subsections;
 
+    assert(field || vmsd->unmigratable);
+
     if (field) {
         while (field->name) {
             if (field->flags & (VMS_STRUCT | VMS_VSTRUCT)) {
@@ -900,6 +902,9 @@ int vmstate_register_with_alias_id(VMStateIf *obj, uint32_t instance_id,
     /* If this triggers, alias support can be dropped for the vmsd. */
     assert(alias_id == -1 || required_for_version >= vmsd->minimum_version_id);
 
+    /* If vmsd is migratable it MUST have valid fields. */
+    assert(vmsd->fields || vmsd->unmigratable);
+
     se = g_new0(SaveStateEntry, 1);
     se->version_id = vmsd->version_id;
     se->section_id = savevm_state.global_section_id++;
-- 
2.53.0.851.ga537e3e6e9-goog


