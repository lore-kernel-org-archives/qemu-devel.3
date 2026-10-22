Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE95606AF80
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M6iI//PY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJt9r-0001Gu-TH; Thu, 22 Oct 2026 09:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xJt9W-0000Uq-K4
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:48:19 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xJt9R-00058L-Qb
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:48:16 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a20b122af8so4824665e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 06:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792676891; x=1793281691; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rV63IJW9kz+/YA+jmT/F3tBVCpkCtWkImKaAF2bvNIw=;
 b=M6iI//PYDw03jTIOuaB95R4tgjdClm1RznHj3AH2VYrRqjtjY53D+g2qD7lG6QGSPx
 Xlc9JUjIdQ3hLY+q4l5Bfz2PM9l3rDQWt/r2NFuYUqpOkqHOLOSYahmL+OEfMlYNNfdt
 up49fCQFonAZHb3/A7ZRSnKnx/jt5FiI0NdfU4DnRlkBePSKAcrngYeqFNRkYH5SVWX0
 MjP2cUok++/sBN/8X+13V/8ZXKdA5q/l9OW37WDYvE5DSPk+sVqTD5fIE8bv6NTUYuYV
 T5AcPNL9QwZdY+7Rgj6aCLSMh4xUItu/3WDIl8si250wSZ5E9oi5mhFuVe4R3+fzZFHj
 zZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792676891; x=1793281691;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rV63IJW9kz+/YA+jmT/F3tBVCpkCtWkImKaAF2bvNIw=;
 b=JndEfvjgJvcJFlhEVPQaYY/2CV8KPR6JlSMn5igNvaeCpsSBUE7wRw33wU+IRHdcSW
 UotlVSx+7BAx/4pfy2zmD/DKW7YWwiqb8Y9vMh2g3s83lzWYTcTraOatuiOdGnZCdl00
 Ej3X0OsEKlVZfIh1nhSY2b/oD52A/QFO+fcGSKXKfNfIzdQaSZSEYfFxWPsPGWKSHYwh
 hJP0iVDru4Svq/FuV3Uf4UDvspBh6QUyqm5MaQ+nAWVX4ujbnnkuhFzXJW0RouRi6a1L
 bzb9hAz9+ymvbzg9ojDIA9TaYhoczB+QCKNrQNBo4BR9Edf+2rvzu0pb/uAr23nTLphc
 jq5g==
X-Gm-Message-State: AFq9FYLAIptuw0ZH56jy58WbihbmXr83Trz/T1VNGTbzLJJNKe78mFE4
 5r4dcr/4+Iv2eMlP/no44ZhxHI20VnCpx1HtzCX+3Hw7kTF2jauTwV7V
X-Gm-Gg: AYBFou1Aiik3HbPetVa697x6XWGDaiq6NzSO2QeHoRORfdzOWNHUx+pn7su9iltz1EG
 NrvKC6AGUu7hvcrgr5y+N0WfBcHCtr32DP7HJJjPddDLUylyTDsazUH+kfnEK30T/cwggp/OeER
 0BYuce6UPqqt2l4gt5D+3s99vUgNMjAlb2IJiEg7UznIcbN59vofWODmN3GnOASdajIaQOV/ucV
 Gpaa4on6J48O8BSfD4v1gpCGaRE9nBnVVo2n18DKUTwMM985r0Xw6PXf2kz5EOek99BZrBdb/yD
 mh/JqqT6mA8E91QrdPK1q6tivG/xe+coG9t5dbMFuNchA+m6rFKpNjCOHh8d7NYfB+Y0tlMSGZ9
 ewHFrkVfP3zIlIfiqJ8/jOZGPvu9F/XK5H7G4ueJpgtT1PZ9KJGjx64x9OFETOf5n/Kejm81vwk
 kY+yhyy7bczC5JosUyZuMGjIZzV4kYvBlIgPzv7mQij+CFkeKFKNEbcdP8eYEi37NPZz6xYmM4g
 WF26vyPmRvVfhi9aBlT8qoWt0r+yu4ZVRfbtUNb3u4QlW+YbEgFMdAzpm1My1TxbYuf8A3n3S5c
 5mLmRx+Ns4s/4P4Bo3ZwOybElkwPDsBKklRByrxtcpoG86RMhfYzYQNRCoeAWyT09sjTzVmkA9F
 ixtxW66aYbppyl89nJUlLzMCcmTL0eLY=
X-Received: by 2002:a05:600c:34c4:b0:49f:ce78:3562 with SMTP id
 5b1f17b1804b1-4a1fdd37971mr109273495e9.19.1792676890715; 
 Thu, 22 Oct 2026 06:48:10 -0700 (PDT)
Received: from tim-m2.local
 (dynamic-2a02-3100-5a78-7100-00df-217a-667a-8b0a.310.pool.telefonica.de.
 [2a02:3100:5a78:7100:df:217a:667a:8b0a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e254ef1bfsm13120414f8f.6.2026.10.22.06.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 06:48:10 -0700 (PDT)
From: Tim Pambor <timpambor@gmail.com>
Date: Thu, 22 Oct 2026 15:47:29 +0200
Subject: [PATCH 8/8] libvhost-user: detect memfd support with a link test
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-vhost-user-posix-v1-8-0bd4d450d23c@gmail.com>
References: <20261022-vhost-user-posix-v1-0-0bd4d450d23c@gmail.com>
In-Reply-To: <20261022-vhost-user-posix-v1-0-0bd4d450d23c@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-block@nongnu.org, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Brad Smith <brad@comstyle.com>, 
 Tim Pambor <timpambor@gmail.com>
X-Mailer: b4 0.16.0
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=timpambor@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The inflight fd code is guarded by #ifdef MFD_ALLOW_SEALING, which only
tells us that the headers define the flag, not that memfd_create() is
available in the C library. There are environments where the flag is
defined but the link fails:

  ld: error: libvhost-user.a(libvhost-user.c.o): undefined symbol: memfd_create

Probe for memfd_create() with MFD_ALLOW_SEALING in the subproject's
meson.build, using the same test QEMU's top-level meson.build uses for
CONFIG_MEMFD, and guard the code with CONFIG_MEMFD instead.

When memfd is not available, VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD is
masked out as before, so the frontend never sends
VHOST_USER_GET_INFLIGHT_FD.

Signed-off-by: Tim Pambor <timpambor@gmail.com>
---
 subprojects/libvhost-user/libvhost-user.c | 17 ++++++++---------
 subprojects/libvhost-user/meson.build     | 11 ++++++++++-
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 7ce73fba19..32b7ae82ce 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -85,7 +85,7 @@ int eventfd_read(int fd, eventfd_t *value)
 }
 #endif
 
-#ifdef MFD_ALLOW_SEALING
+#ifdef CONFIG_MEMFD
 #include <fcntl.h>
 
 #ifndef F_LINUX_SPECIFIC_BASE
@@ -1963,13 +1963,12 @@ vu_get_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
         features |= dev->iface->get_protocol_features(dev);
     }
 
-#ifndef MFD_ALLOW_SEALING
+#ifndef CONFIG_MEMFD
     /*
-     * If MFD_ALLOW_SEALING is not defined, we are not able to handle
-     * VHOST_USER_GET_INFLIGHT_FD messages, since we can't create a memfd.
-     * Those messages are used only if VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD
-     * is negotiated. A device implementation can enable it, so let's mask
-     * it to avoid a runtime panic.
+     * Without memfd we are not able to handle VHOST_USER_GET_INFLIGHT_FD
+     * messages. Those messages are used only if
+     * VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD is negotiated. A device
+     * implementation can enable it, so let's mask it to avoid a runtime panic.
      */
     features &= ~(1ULL << VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD);
 #endif
@@ -2164,7 +2163,7 @@ vu_inflight_queue_size(uint16_t queue_size)
            sizeof(uint16_t), INFLIGHT_ALIGNMENT);
 }
 
-#ifdef MFD_ALLOW_SEALING
+#ifdef CONFIG_MEMFD
 static void *
 memfd_alloc(const char *name, size_t size, unsigned int flags, int *fd)
 {
@@ -2231,7 +2230,7 @@ vu_get_inflight_fd(VuDev *dev, VhostUserMsg *vmsg)
 
     mmap_size = vu_inflight_queue_size(queue_size) * num_queues;
 
-#ifdef MFD_ALLOW_SEALING
+#ifdef CONFIG_MEMFD
     addr = memfd_alloc("vhost-inflight", mmap_size,
                        F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
                        &fd);
diff --git a/subprojects/libvhost-user/meson.build b/subprojects/libvhost-user/meson.build
index a18014e7f2..aa5894a642 100644
--- a/subprojects/libvhost-user/meson.build
+++ b/subprojects/libvhost-user/meson.build
@@ -11,10 +11,19 @@ add_project_arguments(cc.get_supported_arguments('-Wsign-compare',
 threads = dependency('threads')
 glib = dependency('glib-2.0')
 
+vhost_user_flags = ['-D_GNU_SOURCE']
+
+if cc.links('''
+    #define _GNU_SOURCE
+    #include <sys/mman.h>
+    int main(void) { return memfd_create("foo", MFD_ALLOW_SEALING); }''')
+  vhost_user_flags += '-DCONFIG_MEMFD'
+endif
+
 vhost_user = static_library('vhost-user',
                             files('libvhost-user.c'),
                             dependencies: threads,
-                            c_args: '-D_GNU_SOURCE')
+                            c_args: vhost_user_flags)
 
 executable('link-test', files('link-test.c'),
            link_whole: vhost_user)

-- 
2.55.0


