Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DB4606A323
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cd0E4BlS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMkgE-0001Se-8d; Fri, 30 Oct 2026 07:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xMkfw-0001L5-Fk
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:21:37 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xMkfs-0002kj-Uj
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:21:35 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so275919f8f.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 04:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793359291; x=1793964091; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vd5BWeOhgl4OJE0+2tUQcWMWNMpBRcJ6kN3JbG9lrMQ=;
 b=Cd0E4BlSvDpPikwFm9m6opqrk++Zo1sCsfN0zBmcVR9ogwUxrNFT3o4IothA3+KxXK
 OWgB0rDG945PK6qc0euXraa6mZHn/VyT+RKNGZ7Avv+NYWDa26HXnIB+ulLuDcOyEXXB
 2n2RCavU9avvF1yFel3z+lwiD8Mp4X70wSzgi4NCJRFJH5uzrByvPg2eQtZ6t/MxcwrX
 h74jiUXnzihbeOMnnWAoHHDBURmlUPYs1tDSURZyZg2ITGKRoSG2KDzDDarKtZ2Kv9gE
 Tg+ekqqAdzvuiMoOzPd2zcxsqog9dwGRxUEFQxlur/XfMhaTYkPH1lOZcIUyhWiG1vnC
 QDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793359291; x=1793964091;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vd5BWeOhgl4OJE0+2tUQcWMWNMpBRcJ6kN3JbG9lrMQ=;
 b=rXqN7gmfUSKZiR2duFwNOrjPwICZBLI3ulwC9f64Tkw7u1mP5bzMLj6ryfXLAWFSgU
 6iDbI/I4HziC9Sm/R9XveUKp6kksAlu61hoP5ECRCz+4stbq3GMw0ymlO8CE/KbiAyeF
 dtnFIbTbIDXF6EPkn6zBiopi/hVPUPK5fzV1Srp2JL4SysjP4DXXjj3DhKs7bIx0XHjK
 JOkeKrpv6OOmxn8K9Raks45ZtxpaCbCDyeU6NZQPcsSwarrH9WTLv4dYKj+4sbvS1kiN
 2YP0G85QmJgp6nXsjbqdnbDrj+QPbo8Y3LkmTbJUeYRulQrjTD07n0Z5mC9fXTVJsrx9
 b+gQ==
X-Gm-Message-State: AFq9FYLVJbm+hoJrtlz2yMUwte1rPXk6fXnIEltR9BmG8/t8LeO1sa2H
 jbe2SHp4md1Df2jzAd2hW8G0nsaH2WEqXZPIDu+UokkNQ25Rqwu5D8co
X-Gm-Gg: AYBFou2ck0Q1sbLPgohja8Vm95lP25QiAzEmdkKDfsZD50+eLZwfXa78bAMf+0J/RIV
 CIqz2naXlUny5+iHcxCc5b7XP42J/RT7Pgtg1lP+BJ2R0ZCeQF52YiMXhal55Br9tWGQ3IdyaQr
 s6wPvTFToI0BVL3Kq2avXxBkT9eQGKsdcRfKKTo3NPPo6ngTSvkfw8dKd2Vk5fwrC9vu6BdG/uz
 CgSYqaYDx3BFg5WH/kx7JT+WZNKNf99cPlTEZcarvJOU5037lvyQQF5RLjuE3MW6CIxtitEgwck
 +KIjwGU3GizvQAuTj/Gwtmgc9PC/iisvWLh2T80odigqSpHI/gRNJofOFpTZJU4cCcGwP+aQpRt
 vgXh8zSKc3EMMUWls6+GH7QsJky+VnyX8EImp12F9iRbXFaf8qbAi1ZFhvyHfV/BCpfURmF7HG1
 r49d6ma0y7OLoBaM99IpANVBf686gUlQ2I50toUjyvish0GoudFLXntQoKjFctXfkwOK9DOYgDX
 Gzwg1hItaKI1S8j7dUKKbLlXKWYGuh2aLhETJyzxQEnhpsgs7zusJ6GVKiRqcgH3TmlNGk909K1
 4j26CTpGedW50MC6X88ZHwPScFPJDAkg7uYEUn8AL1K802UXRWGMv21feYN1MaYjBGYJK8essg7
 kpNWbLEL38t4I7uDjJXuL25SO7VMOfW+qdgInoBwM4uu8c3368FmFW4V6ezSmaA==
X-Received: by 2002:a05:6000:41c8:b0:48d:faa6:cedf with SMTP id
 ffacd0b85a97d-48e6e50645dmr4644278f8f.56.1793359291162; 
 Fri, 30 Oct 2026 04:21:31 -0700 (PDT)
Received: from tim-m2.local
 (dynamic-2a02-3100-61d8-3600-98fd-cd98-7ae6-cb49.310.pool.telefonica.de.
 [2a02:3100:61d8:3600:98fd:cd98:7ae6:cb49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm2893608f8f.6.2026.10.30.04.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 04:21:30 -0700 (PDT)
From: Tim Pambor <timpambor@gmail.com>
Date: Fri, 30 Oct 2026 12:20:54 +0100
Subject: [PATCH v2 1/9] libvhost-user: detect memfd support with a link
 test
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-vhost-user-posix-v2-1-cda7c17aad13@gmail.com>
References: <20261030-vhost-user-posix-v2-0-cda7c17aad13@gmail.com>
In-Reply-To: <20261030-vhost-user-posix-v2-0-cda7c17aad13@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-block@nongnu.org, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Brad Smith <brad@comstyle.com>, 
 vhost-user@lists.linux.dev, Tim Pambor <timpambor@gmail.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: b4 0.16.0
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=timpambor@gmail.com; helo=mail-wr1-x42a.google.com
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
 subprojects/libvhost-user/libvhost-user.c | 15 +++++++--------
 subprojects/libvhost-user/meson.build     | 11 ++++++++++-
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 2fed792e85..adda700630 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -1800,13 +1800,12 @@ vu_get_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
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
@@ -2001,7 +2000,7 @@ vu_inflight_queue_size(uint16_t queue_size)
            sizeof(uint16_t), INFLIGHT_ALIGNMENT);
 }
 
-#ifdef MFD_ALLOW_SEALING
+#ifdef CONFIG_MEMFD
 static void *
 memfd_alloc(const char *name, size_t size, unsigned int flags, int *fd)
 {
@@ -2068,7 +2067,7 @@ vu_get_inflight_fd(VuDev *dev, VhostUserMsg *vmsg)
 
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


