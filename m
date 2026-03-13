Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FBF107BCD1
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 23:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1C2y-0000cX-Ql; Fri, 13 Mar 2026 19:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3W5-0aQQKCsAxqoxmuumrk.iuswks0-jk1krtutmt0.uxm@flex--rkir.bounces.google.com>)
 id 1w1C2x-0000cI-Jm
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 19:35:59 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3W5-0aQQKCsAxqoxmuumrk.iuswks0-jk1krtutmt0.uxm@flex--rkir.bounces.google.com>)
 id 1w1C2w-0002sS-5e
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 19:35:59 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-c739120475fso1449286a12.3
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 16:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1773444956; x=1774049756; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=SAPEylkIV0nBuTHJQyf+c/OAybfX0uEC9xGFY7/Ve7M=;
 b=wBXZTpIMivpHbPLAc+6Rgk2J1GyM6n5sMPRZ7pUxpLVJFXQWnDmQTw3U+it2+1dyAD
 1k3ymn6svkm3qOQCWvNfJz0m0C6xJ5ZDSU3g40z+ViLSS3s3XFluejQCdyS/V4A7zIZ/
 Kuw7HlJGbtlmev7Kn5eh9S+FOIfYNwc0BiF135VsLBftf6Nh7VL3nP5xQM6wAl9uBDm5
 D/+h8jW4EmEMh9SFV6v7WkkOnBx9qLybSzA6ptYq2sMr9jpny1rUZm9YZf4UmCKsJEFc
 BbG5NjD7ELtB7UGntjYZNn0iRWf8DvCxMg4JQDeS8o2vxxfn0UBwaPc9k5BVQuYqZzfn
 2TfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773444956; x=1774049756;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SAPEylkIV0nBuTHJQyf+c/OAybfX0uEC9xGFY7/Ve7M=;
 b=MOcZu0hvBJkO5QmK8aNUzopnn0f9aD11/D54uO/SQt0A+3ByFAP3VqXkHHz0Rj+0wh
 qKU/VQLlHLV9GaHxPH5WErS3yndjDsxQ+ybdGN56hVsdnhGx9sfcqF+YrOdLQ3x2yTtT
 I+ojt4QShNNAJPLKl+ELHDCM0ern47FIJEerFKZRIWThjgApUFXEuFR/OUSoMLu5Lv2P
 VxU/QSHWQoQ+iwf/nKjPkaFEZMXFugBoZLtYsSAs2wcnWeyuJWWqZ2VJr5JtQN/Gzada
 Xq7FH7O+VuhYheffOt2NRmeMpN1xqZTK00Ic+YQlzUwSaOkXKK5/P0j+hAKf3tH8ZLo7
 k0cQ==
X-Gm-Message-State: AOJu0YwpSpCfBespipibSEjsgH87asaeHKNlpxQvE9/Qm9hhIGqbZK9V
 cg0XfT/AwXNV9dZFUJeXC36NYXIGZqAmQgQkrpEfnC0PaejSK4terCunr7zzpbXSWtqfvIHWXA=
 =
X-Received: from pgar3.prod.google.com ([2002:a05:6a02:2e83:b0:c73:cc95:c0be])
 (user=rkir job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:1805:b0:398:9794:3309
 with SMTP id adf61e73a8af0-398eca10f57mr4527080637.10.1773444955733; Fri, 13
 Mar 2026 16:35:55 -0700 (PDT)
Date: Fri, 13 Mar 2026 23:35:38 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260313233538.1519319-1-rkir@google.com>
Subject: [PATCH v3] vmstate: validate VMStateDescription::fields upon
 registration
From: Roman Kiryanov <rkir@google.com>
To: peterx@redhat.com, farosas@suse.de
Cc: qemu-devel@nongnu.org, whollins@google.com, jansene@google.com, 
 jpcottin@google.com, Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3W5-0aQQKCsAxqoxmuumrk.iuswks0-jk1krtutmt0.uxm@flex--rkir.bounces.google.com;
 helo=mail-pg1-x54a.google.com
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
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Roman Kiryanov <rkir@google.com>
---
v3:
 - Also added assert to virtio.c to validate
   VirtioDeviceClass instances which bypass
   vmstate_register_with_alias_id.
 - Updated the commit message to "Reviewed-by".
v2:
 - Moved the assert from vmstate_save_state_v to the registration
   path (vmstate_register_with_alias_id) and the qtest validation path
   (vmstate_check) to catch missing fields earlier.
---
 hw/virtio/virtio.c | 6 ++++++
 migration/savevm.c | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 0ba734d0bc..e4543de335 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -4054,6 +4054,12 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
     /* Devices should either use vmsd or the load/save methods */
     assert(!vdc->vmsd || !vdc->load);
 
+    /*
+     * If a device has vmsd, it either MUST have valid fields
+     * or marked unmigratable.
+     */
+    assert(!vdc->vmsd || (vdc->vmsd->unmigratable || vdc->vmsd->fields));
+
     if (vdc->realize != NULL) {
         vdc->realize(dev, &err);
         if (err != NULL) {
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


