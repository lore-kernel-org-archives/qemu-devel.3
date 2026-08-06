Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D81FC56208
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 20:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws4gC-00044C-LU; Thu, 06 Aug 2026 16:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1ws4fs-0003tF-Dk
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 16:26:44 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1ws4fq-0004zE-Pk
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 16:26:44 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c96c92c0980so1719867a12.3
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 13:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786048000; x=1786652800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SaYapBLbD9XCZZx/Z5KC+hEKo+tfsakv4kbFa0GStzE=;
 b=lOXR2vUTjPO8CN0k66IzalwToIivIVNB19G4DUL5PkUfGXdxl+2gp8F4tU1+yhh/Bb
 jE5IuBHnlkm2Cx9bDJcKIqqeMGG7mEFCCKck7ee7HX21FaW9e5k2xyVsFj+PV1c1Ps+/
 VdIIoMOdJcRrsTUJ+tKg2nXD9Sx9Z8P2q9jFumLfayKzmfBOepgC+/PalY8SMgjGKBe2
 cpllh1rZMu6ov5UgjOhoIlx+tq+0O5r9z/ewaiU7dnkLPTG9kIUwpFLaT8KEnV/FV+Uq
 s2fxHem4XiyRLVpgTuOQ7meGj/JmFJYwTnQQJMumeJgfYyIRZI5DcsgblamCivwOVxbd
 OEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786048000; x=1786652800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SaYapBLbD9XCZZx/Z5KC+hEKo+tfsakv4kbFa0GStzE=;
 b=CRBgJ6cmuK4ZUyuWUaE62r7FsLI4RLFNBe9gGQcAfnRnHTMHWBV6kh5YFIwVBAiyYK
 vmuP03QchGCpJyux8AQC4xcuTu9g6AmTgQoYpAruwtyHUgtNBJgqSIrhvAe6ECJuEK8e
 E+zMvv9l6HLMNUWlu4W0NnZlnLNwef06Z6UtAgFDxtjF0j5DTMDa5Bg2Z6nntPugx32x
 spMCXQnK4axcqpDe5IdKKlIs7/K9nzdFpcxSRc2s53vhKDb/NPM+JZC5Ga3CfczIOD8I
 Ht2ja+mzO5QSOupLoxJx/kHERRlIcgfAhUjbBGkyhVu0HivEoCF7WiIvcxxgmt2BbHhq
 zaLQ==
X-Gm-Message-State: AOJu0Yy6VBJPT5YbjOpVI1avroD3oX96jjcbq19WV3FU1orYRT6BeBhC
 EgBeGkSAWGP+IW1g2ovgGMvpnW4z3K1wua8ckKukK2nb2lqunKDj2B4KwprC9aahpaGBUPvi
X-Gm-Gg: AR+sD11VhseWzJ3a6SH6kSaMpLUrgaenp1wYUiLp4Cy+wD1ODhLKD9gIC8jfDh7sVDP
 5e9beGJA44Xo27up50ywAa42VCFajsg29o+H3DCEH9ct5OLv3hRcx2gyDx560nLE42GkDXB/gCE
 Y3dXPXpO4E8BsasIpPAtOlQ/KIR9T3d/QORP4VrU4yURPmUCpLrdlV2L5falac8beoxOBZA1Jj2
 /DdhioWmrB8uUSnbh6FMCLjmnAD23LEm2AFzMiElvShyTM6e5GJBgeOTyZMs8j43YZKXudSSNV2
 Mg+nVvyA0Jfox5dp0V23wfEZ9IZNkmNz0L42fQfHGa4uorJ1BaFDciEJl27Bmqmfue3UTDabrow
 IMcO8urhp+d1MKSeQYh5UXZUstH8azubp4EqzXal38kcVXjLycxDF7pE+qXo0FPZQqe+4+RfT0e
 WxEheGEZyRvbPj2jKdzDKKsmaBThKj1HlPlXayjxa58O4X/chgZX0grFmO9lCGRH2jqQ6lwJ2JL
 pQ3V1rcXD000Vcs
X-Received: by 2002:a05:6a20:db92:b0:3c4:147e:98f1 with SMTP id
 adf61e73a8af0-3cbadcfd00emr5711890637.31.1786048000558; 
 Thu, 06 Aug 2026 13:26:40 -0700 (PDT)
Received: from t-kidd-X299-AORUS-Gaming-3-Pro.lan ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863fd2b3sm33140471eec.7.2026.08.06.13.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 13:26:40 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V11 03/15] iothread: track users with holder name
Date: Fri,  7 Aug 2026 04:25:12 +0800
Message-ID: <20260806202531.243806-4-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806202531.243806-1-zhangckid@gmail.com>
References: <20260806202531.243806-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Introduce iothread_ref_and_get_aio_context() with a holder argument
and its counterpart iothread_put_aio_context().

Previously, users of an IOThread AioContext did not explicitly record
their identity, making it difficult to debug which devices or
subsystems were pinning an IOThread.

Registering a holder takes an IOThread object reference so that the
IOThread and its AioContext stay alive until the matching put
operation. Document the ownership and BQL requirements.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 include/system/iothread.h | 21 +++++++++++++++++++++
 iothread.c                | 23 ++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/system/iothread.h b/include/system/iothread.h
index b8aeb32b0e..b6664e7a38 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -67,6 +67,27 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
 char *iothread_get_id(IOThread *iothread);
 IOThread *iothread_by_id(const char *id);
 AioContext *iothread_get_aio_context(IOThread *iothread);
+
+/*
+ * Register @holder and return @iothread's AioContext.  The holder is copied,
+ * and a reference is taken on @iothread so that both the IOThread and its
+ * AioContext remain alive.
+ *
+ * The caller must eventually call iothread_put_aio_context() with an
+ * equivalent holder.  This function is not thread-safe and must be called
+ * under the Big QEMU Lock (BQL).
+ */
+AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
+                                             const IOThreadHolder *holder);
+
+/*
+ * Unregister @holder and release the corresponding reference on @iothread.
+ * Calling this function without a matching
+ * iothread_ref_and_get_aio_context() call is a programming error.
+ *
+ * This function is not thread-safe and must be called under the BQL.
+ */
+void iothread_put_aio_context(IOThread *iothread, const IOThreadHolder *holder);
 GMainContext *iothread_get_g_main_context(IOThread *iothread);
 
 /*
diff --git a/iothread.c b/iothread.c
index 2a4c92e08b..0cc8344ee6 100644
--- a/iothread.c
+++ b/iothread.c
@@ -33,6 +33,11 @@ void iothread_ref(IOThread *iothread, const IOThreadHolder *holder)
     assert(holder);
 
     QAPI_LIST_PREPEND(iothread->holders, QAPI_CLONE(IOThreadHolder, holder));
+    /*
+     * This guarantees that the IOThread and its AioContext remain alive
+     * as long as there is a holder.
+     */
+    object_ref(OBJECT(iothread));
 }
 
 static int iothread_holder_compare(const IOThreadHolder *holder_a,
@@ -78,6 +83,7 @@ void iothread_unref(IOThread *iothread, const IOThreadHolder *holder)
             *prev = curr->next;
             curr->next = NULL;
             qapi_free_IOThreadHolderList(curr);
+            object_unref(OBJECT(iothread));
             return;
         }
         prev = &curr->next;
@@ -199,7 +205,7 @@ static void iothread_init_gcontext(IOThread *iothread, const char *thread_name)
     g_autofree char *name = g_strdup_printf("%s aio-context", thread_name);
 
     iothread->worker_context = g_main_context_new();
-    source = aio_get_g_source(iothread_get_aio_context(iothread));
+    source = aio_get_g_source(iothread->ctx);
     g_source_set_name(source, name);
     g_source_attach(source, iothread->worker_context);
     g_source_unref(source);
@@ -421,6 +427,21 @@ AioContext *iothread_get_aio_context(IOThread *iothread)
     return iothread->ctx;
 }
 
+AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
+                                             const IOThreadHolder *holder)
+{
+    /* Add IOThreadHolder to the list */
+    iothread_ref(iothread, holder);
+
+    return iothread->ctx;
+}
+
+void iothread_put_aio_context(IOThread *iothread, const IOThreadHolder *holder)
+{
+    /* Delete IOThreadHolder from the list */
+    iothread_unref(iothread, holder);
+}
+
 static int query_one_iothread(Object *object, void *opaque)
 {
     IOThreadInfoList ***tail = opaque;
-- 
2.53.0


