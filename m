Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF24C5B56A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 21:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtXdq-00009V-J4; Fri, 20 Feb 2026 16:02:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vtXdo-00008z-E6
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 16:02:24 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vtXdl-0002kv-RH
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 16:02:24 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 50F50C0235;
 Sat, 21 Feb 2026 00:02:19 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:87::1:2c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id G2kijG5A6qM0-LtKTKSQ3; Sat, 21 Feb 2026 00:02:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771621338;
 bh=R9WmjSoEPmublVvdQmK6qLIe2k5hIT0UZlVaPvk+d5I=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=HRjkmg24/yXaneikSuQUSHoUz9yGK5vT3cM+yC1l2qf3ybQec9KO4n3ppVGib32T6
 1T9++wkmZfUiuiI8fZMnoXdeykphQ3YxpznCUwBcH3Qk/zvU38sJPiQYDWR6Hmo9aY
 QXHmlCfw+xu7wKomAtP7EjWNE8I41t/n3/0cRq+0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v2 04/16] migration: vmstate_load_state(): add some newlines
Date: Sat, 21 Feb 2026 00:02:02 +0300
Message-ID: <20260220210214.800050-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220210214.800050-1-vsementsov@yandex-team.ru>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Split logical blocks by newlines, that simplify reading the code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 migration/vmstate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 5111e7a141..dd7cd27993 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -139,6 +139,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
     int ret = 0;
 
     trace_vmstate_load_state(vmsd->name, version_id);
+
     if (version_id > vmsd->version_id) {
         error_setg(errp, "%s: incoming version_id %d is too new "
                    "for local version_id %d",
@@ -146,6 +147,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         trace_vmstate_load_state_end(vmsd->name, "too new", -EINVAL);
         return -EINVAL;
     }
+
     if  (version_id < vmsd->minimum_version_id) {
         error_setg(errp, "%s: incoming version_id %d is too old "
                    "for local minimum version_id %d",
@@ -153,6 +155,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
         return -EINVAL;
     }
+
     if (vmsd->pre_load_errp) {
         if (!vmsd->pre_load_errp(opaque, errp)) {
             error_prepend(errp, "pre load hook failed for: '%s', "
@@ -171,9 +174,12 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
             return ret;
         }
     }
+
     while (field->name) {
         bool exists = vmstate_field_exists(vmsd, field, opaque, version_id);
+
         trace_vmstate_load_state_field(vmsd->name, field->name, exists);
+
         if (exists) {
             void *first_elem = opaque + field->offset;
             int i, n_elems = vmstate_n_elems(opaque, field);
@@ -184,6 +190,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                 first_elem = *(void **)first_elem;
                 assert(first_elem || !n_elems || !size);
             }
+
             for (i = 0; i < n_elems; i++) {
                 void *curr_elem = first_elem + size * i;
                 const VMStateField *inner_field;
@@ -235,6 +242,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                                    vmsd->name, ret);
                     }
                 }
+
                 if (ret < 0) {
                     qemu_file_set_error(f, ret);
                     trace_vmstate_load_field_error(field->name, ret);
@@ -249,11 +257,13 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         field++;
     }
     assert(field->flags == VMS_END);
+
     ret = vmstate_subsection_load(f, vmsd, opaque, errp);
     if (ret != 0) {
         qemu_file_set_error(f, ret);
         return ret;
     }
+
     if (vmsd->post_load_errp) {
         if (!vmsd->post_load_errp(opaque, version_id, errp)) {
             error_prepend(errp, "post load hook failed for: %s, version_id: "
@@ -271,7 +281,9 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                        ret);
         }
     }
+
     trace_vmstate_load_state_end(vmsd->name, "end", ret);
+
     return ret;
 }
 
-- 
2.52.0


