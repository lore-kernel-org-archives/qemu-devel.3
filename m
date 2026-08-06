Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62688C56208
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 20:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws4gB-00040T-3O; Thu, 06 Aug 2026 16:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1ws4fu-0003uu-Tb
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 16:26:51 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1ws4ft-0004zg-AJ
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 16:26:46 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-ca97d139d8dso1764299a12.2
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 13:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786048004; x=1786652804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zJmtyUkklFhBPEIpsWKaEmdq4HWMkw7BrqZ8d0rzmAw=;
 b=Mp2O/8xPSBB4glFvZzM0Ds75cfDHboTXWfGk7K+FQ+wUGmDSERWGRhNxEV5uoHNxRz
 4nNZWnws/M9NqlYhJ5tV4sLpFbaLOAvE8Hzg5F2ufEVQE71q676w8oSK+4lcHM+EQ8Mx
 jCyKMUVTl3ave6xXmpfZ0Vpkcft3gka0ZfOzfoKhofhrD+jz0SWDB9yTTbzknQejmrVb
 k9ggjBRiq4bYXzYQ3gXeahUpPG551qj6j2F/QGTXEniOcqW3TsdBkXb+kD1K1CD7TX7A
 k7Os7bYxlCpWW+ysLBH1m1t8G1BMo8Erj/lWj4CGv1wDuYPruMtcBQvRrwaeOS7PHLyZ
 yd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786048004; x=1786652804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zJmtyUkklFhBPEIpsWKaEmdq4HWMkw7BrqZ8d0rzmAw=;
 b=IofJNPBohkyXKi63+CM+GsTjgof/7D/nj1xQ37nEY/0Kw5jC2u5dlB7xcZ5PqvxiS1
 MHnwbvpjont88LI6+UYZ428J7Zx/z0SwOQtJsxPC9z42pkiv6CXyopNz9kocqLRt29j/
 Gp7GYvdo2oq98UeQZWNY5I3woc1wx08nEh6J6g8mMR7k8iGlQwG72Q3+kNfo91iuxXlr
 UvNptt5oEumzqYMlNMeZ4n3m+in7vgTRsVG7+fASkZxa1TmeRo5nqOvRGUlWMFijo3ux
 ePM8rj/k74btQwK9x63IYGRrUtm8FEh+xjKen3tTGndAhKnndg4p7ChaaCVCpv2akOBP
 5ZPA==
X-Gm-Message-State: AOJu0YxHOgqM/VsZtoXlrAM7uYuNR5C61VPeTkjczhMN/GxldCqy3gRV
 FsZVu4p2h+iXBJg7aVY6AOr4/D6KNf8VFo0ZbQPSgFrLj2D2cfo5BwsyaK/SI6NlOw8e8UdY
X-Gm-Gg: AR+sD10k3F+NVkquyHG96XXUZ5iOarjz0u3IKhN8bBYdGEEqzLb8yGYC2eCu2Ssj8Nt
 F75d9QGFwLad0spa2JjF9LeeSDKtnKlW2stgTwFZOhYX0kdH4VdaKi49hsr/PlwsJrF7Bm5mRb+
 D4mt5exNdEizxvd0a1vsluFoXT/JNAsC3Svt3hOSXQLnvJncHP0+pyAHGphp6Q3V3R2b4wvSSFX
 6FN82OK23udnXSRg3OtxbxCxediYHuDSOzAcld+LFKk0FeqJvEfcfreX4gLtOHYc6qGvbMgfX3u
 mgDxiJGqIx9hgY+yy2nNyx40GRckgHsnQEGjEJez85NXDAYLapVtnNsH1cjdAmffuHb2C/3RlQw
 QdFfyPpI3LunwI61n4SJ63A27j/RPTlDTYGU+rGIHDYPtts1mN66Rmezk014zEHZvLgKNiduAls
 iXf7TF72QfGUeuUbeK0ckFKedWX/JcMmtTRWDSiwhfINrtFIP05l3nJlZIOtcqYN1DmLI9WfRHD
 tgpAap3LNQZKKmD
X-Received: by 2002:a05:6a21:1b85:b0:3c8:d3a4:7b40 with SMTP id
 adf61e73a8af0-3cb85ded978mr22825451637.2.1786048003924; 
 Thu, 06 Aug 2026 13:26:43 -0700 (PDT)
Received: from t-kidd-X299-AORUS-Gaming-3-Pro.lan ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863fd2b3sm33140471eec.7.2026.08.06.13.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 13:26:43 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V11 04/15] iothread: introduce
 iothread_unsafe_get_aio_context()
Date: Fri,  7 Aug 2026 04:25:13 +0800
Message-ID: <20260806202531.243806-5-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806202531.243806-1-zhangckid@gmail.com>
References: <20260806202531.243806-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x533.google.com
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

Add an explicitly unsafe accessor for legacy callers that cannot
provide a matching holder lifecycle, and convert blockdev.c to use it.

Keep iothread_get_aio_context() temporarily so that later caller
conversions remain independently buildable. It will be removed after
all production callers have migrated.

New code should use iothread_ref_and_get_aio_context().

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 blockdev.c                |  2 +-
 include/system/iothread.h | 10 ++++++++++
 iothread.c                |  5 +++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index 6e86c6262f..baeab3a3e1 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3683,7 +3683,7 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
             goto out;
         }
 
-        new_context = iothread_get_aio_context(obj);
+        new_context = iothread_unsafe_get_aio_context(obj);
     } else {
         new_context = qemu_get_aio_context();
     }
diff --git a/include/system/iothread.h b/include/system/iothread.h
index b6664e7a38..cf1b6e0cdc 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -68,6 +68,16 @@ char *iothread_get_id(IOThread *iothread);
 IOThread *iothread_by_id(const char *id);
 AioContext *iothread_get_aio_context(IOThread *iothread);
 
+/*
+ * Return @iothread's AioContext without registering a holder or taking a
+ * reference on @iothread.  The caller must ensure that the IOThread remains
+ * alive for as long as the returned AioContext is used.
+ *
+ * This API exists for legacy callers without a clear ref/unref lifecycle.  Do
+ * not use it in new code; use iothread_ref_and_get_aio_context() instead.
+ */
+AioContext *iothread_unsafe_get_aio_context(IOThread *iothread);
+
 /*
  * Register @holder and return @iothread's AioContext.  The holder is copied,
  * and a reference is taken on @iothread so that both the IOThread and its
diff --git a/iothread.c b/iothread.c
index 0cc8344ee6..43f42c65c8 100644
--- a/iothread.c
+++ b/iothread.c
@@ -442,6 +442,11 @@ void iothread_put_aio_context(IOThread *iothread, const IOThreadHolder *holder)
     iothread_unref(iothread, holder);
 }
 
+AioContext *iothread_unsafe_get_aio_context(IOThread *iothread)
+{
+    return iothread->ctx;
+}
+
 static int query_one_iothread(Object *object, void *opaque)
 {
     IOThreadInfoList ***tail = opaque;
-- 
2.53.0


