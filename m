Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79BB606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=tMPulsLL;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vjZprcNB;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=GKdSV0hM;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sji+pk93
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3mE-0004Tl-RU; Mon, 16 Nov 2026 15:58:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xT3mC-0004RB-NW
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:58:08 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xT3mA-0000So-PN
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:58:08 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DB1B81FD15;
 Mon, 16 Nov 2026 20:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794862682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gFVKMm12xGPIbFGS98+Xx5Ly60X0J0dkc9w/6qa2Rbc=;
 b=tMPulsLLAbflgGf/ke+rDK1quWhciu0wS2Ps5dgWUaD0upvwtgyYRb+CID4C9P55xmZQ3P
 r79AuEp5Y0UqAOTxg9UQgwJ1r8DJ5BP04eb2aSDxCLcBtMagJxj+vYoyrWm+gfycyoksie
 XPz5v5EOWTk3/+PKiAoKxZjNapN7OFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794862682;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gFVKMm12xGPIbFGS98+Xx5Ly60X0J0dkc9w/6qa2Rbc=;
 b=vjZprcNB/2cBOvUscfGciEffxpza11kJRYgVJbM3LzkVMRo1txG83yWVFzWAS/FLqaDAnX
 VY0WvX9zE1RPGCBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794862681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gFVKMm12xGPIbFGS98+Xx5Ly60X0J0dkc9w/6qa2Rbc=;
 b=GKdSV0hM0iolDknF8QkElQ4v0A+1EQGxlEyCTv0cWFh9g3F6oAZTgBrrbGAgMv3XVloUUT
 4T7ZU+6YWYnL7xpucrUq8uBvvc1PbF4x5n5+a4VV3xfmHFrjI25b/CHHZCrgleYt+s6CZX
 /gGlj5h37wxtHJcVctzPJQxQ8W6Rhdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794862681;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gFVKMm12xGPIbFGS98+Xx5Ly60X0J0dkc9w/6qa2Rbc=;
 b=sji+pk93wk0KayTUSuatD2XdAKg+i0DIOy8Ft+E0P2GZMjbpgw+NZGlt5/yHzbj4x1hzQI
 qoNuomIxwF/WhqBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE50E1334C;
 Mon, 16 Nov 2026 20:58:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pyTOEFhu+2qPBgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 16 Nov 2026 20:58:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] qdev: Use g_autofree for visited strings
Date: Mon, 16 Nov 2026 17:57:58 -0300
Message-ID: <20261116205758.1340618-1-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-11.80 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -11.80
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use g_autofree for visited strings. This plugs leaks for set_chr() and
set_drive_helper(), the latter verifiable in qos-test. For the rest of
the changed functions, it keeps the code uniform.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 hw/core/qdev-properties-system.c | 34 +++++++++++---------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 4d605c20561..271d8049797 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -120,7 +120,7 @@ static void set_drive_helper(Object *obj, Visitor *v, const char *name,
     DeviceState *dev = DEVICE(obj);
     const Property *prop = opaque;
     void **ptr = object_field_prop_ptr(obj, prop);
-    char *str;
+    g_autofree char *str = NULL;
     BlockBackend *blk;
     bool blk_created = false;
     int ret;
@@ -155,7 +155,6 @@ static void set_drive_helper(Object *obj, Visitor *v, const char *name,
     }
 
     if (!*str) {
-        g_free(str);
         *ptr = NULL;
         return;
     }
@@ -209,8 +208,6 @@ fail:
         /* If we need to keep a reference, blk_attach_dev() took it */
         blk_unref(blk);
     }
-
-    g_free(str);
 }
 
 static void set_drive(Object *obj, Visitor *v, const char *name, void *opaque,
@@ -278,7 +275,7 @@ static void set_chr(Object *obj, Visitor *v, const char *name, void *opaque,
     const Property *prop = opaque;
     CharFrontend *fe = object_field_prop_ptr(obj, prop);
     Chardev *s;
-    char *str;
+    g_autofree char *str = NULL;
 
     if (!visit_type_str(v, name, &str, errp)) {
         return;
@@ -293,7 +290,6 @@ static void set_chr(Object *obj, Visitor *v, const char *name, void *opaque,
     }
 
     if (!*str) {
-        g_free(str);
         fe->chr = NULL;
         return;
     }
@@ -306,7 +302,6 @@ static void set_chr(Object *obj, Visitor *v, const char *name, void *opaque,
         error_prepend(errp, "Property '%s.%s' can't take value '%s': ",
                       object_get_typename(obj), name, str);
     }
-    g_free(str);
 }
 
 static void release_chr(Object *obj, const char *name, void *opaque)
@@ -354,7 +349,7 @@ static void set_mac(Object *obj, Visitor *v, const char *name, void *opaque,
     const Property *prop = opaque;
     MACAddr *mac = object_field_prop_ptr(obj, prop);
     int i, pos;
-    char *str;
+    g_autofree char *str = NULL;
     const char *p;
 
     if (!visit_type_str(v, name, &str, errp)) {
@@ -384,12 +379,10 @@ static void set_mac(Object *obj, Visitor *v, const char *name, void *opaque,
         }
         mac->a[i] = val;
     }
-    g_free(str);
     return;
 
 inval:
     error_set_from_qdev_prop_error(errp, EINVAL, obj, name, str);
-    g_free(str);
 }
 
 const PropertyInfo qdev_prop_macaddr = {
@@ -430,7 +423,7 @@ static void set_netdev(Object *obj, Visitor *v, const char *name,
     NetClientState **ncs = peers_ptr->ncs;
     NetClientState *peers[MAX_QUEUE_NUM];
     int queues, err = 0, i = 0;
-    char *str;
+    g_autofree char *str = NULL;
 
     if (!visit_type_str(v, name, &str, errp)) {
         return;
@@ -478,7 +471,6 @@ static void set_netdev(Object *obj, Visitor *v, const char *name,
 
 out:
     error_set_from_qdev_prop_error(errp, err, obj, prop->name, str);
-    g_free(str);
 }
 
 const PropertyInfo qdev_prop_netdev = {
@@ -790,7 +782,7 @@ static void set_reserved_region(Object *obj, Visitor *v, const char *name,
     ReservedRegion *rr = object_field_prop_ptr(obj, prop);
     const char *endptr;
     uint64_t lob, upb;
-    char *str;
+    g_autofree char *str = NULL;
     int ret;
 
     if (!visit_type_str(v, name, &str, errp)) {
@@ -801,7 +793,7 @@ static void set_reserved_region(Object *obj, Visitor *v, const char *name,
     if (ret) {
         error_setg(errp, "start address of '%s'"
                    " must be a hexadecimal integer", name);
-        goto out;
+        return;
     }
     if (*endptr != ':') {
         goto separator_error;
@@ -811,7 +803,7 @@ static void set_reserved_region(Object *obj, Visitor *v, const char *name,
     if (ret) {
         error_setg(errp, "end address of '%s'"
                    " must be a hexadecimal integer", name);
-        goto out;
+        return;
     }
     if (*endptr != ':') {
         goto separator_error;
@@ -824,12 +816,10 @@ static void set_reserved_region(Object *obj, Visitor *v, const char *name,
         error_setg(errp, "type of '%s'"
                    " must be a non-negative decimal integer", name);
     }
-    goto out;
+    return;
 
 separator_error:
     error_setg(errp, "reserved region fields must be separated with ':'");
-out:
-    g_free(str);
 }
 
 const PropertyInfo qdev_prop_reserved_region = {
@@ -964,7 +954,8 @@ static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
 {
     const Property *prop = opaque;
     PCIHostDeviceAddress *addr = object_field_prop_ptr(obj, prop);
-    char *str, *p;
+    g_autofree char *str = NULL;
+    char *p;
     char *e;
     unsigned long val;
     unsigned long dom = 0, bus = 0;
@@ -1020,12 +1011,10 @@ static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
     addr->slot = slot;
     addr->function = func;
 
-    g_free(str);
     return;
 
 inval:
     error_set_from_qdev_prop_error(errp, EINVAL, obj, name, str);
-    g_free(str);
 }
 
 const PropertyInfo qdev_prop_pci_host_devaddr = {
@@ -1240,7 +1229,7 @@ static void set_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
 {
     const Property *prop = opaque;
     QemuUUID *uuid = object_field_prop_ptr(obj, prop);
-    char *str;
+    g_autofree char *str = NULL;
 
     if (!visit_type_str(v, name, &str, errp)) {
         return;
@@ -1251,7 +1240,6 @@ static void set_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
     } else if (qemu_uuid_parse(str, uuid) < 0) {
         error_set_from_qdev_prop_error(errp, EINVAL, obj, name, str);
     }
-    g_free(str);
 }
 
 static void set_default_uuid_auto(ObjectProperty *op, const Property *prop)
-- 
2.53.0


