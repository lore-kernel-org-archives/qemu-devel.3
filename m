Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F6DC54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 13:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rppQK-0000vG-9g; Thu, 28 Mar 2024 09:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rppPp-0000Ld-NC
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 09:03:34 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rppPn-00089O-Q7
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 09:03:33 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a4e1742d3a3so113099766b.1
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 06:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711631010; x=1712235810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q2x43f4g/1k9PawbCTBkD3eBnTaZfrxytFTBDY8Dk3g=;
 b=muj/Opuli31SzElOqB3E6eX5fW/swQMoSoK/5mRc+u8frnmG+83Z7pi/xdwMhC7N77
 3AAZmVKIGwTG0TnhZ1QZ0Nw4cSVuEbPRYmf1IqfrUTxQQSeXiME9E6QRpeoEZuslnO2q
 UjK4Mf3/z+qmgpQ2jF1ZolK1HuiJ1tJEcN6rhD5GgMSkFCbG+eLzrQ+lmZxB5k0sCqye
 Swp01qKq2qMCvqQjp0camaiRZ4WA+ZsjP7eXOHOr7wyrzRJ4txpyBvjeMBLqx1TPTIr5
 rFATVoPfdV6ZpxKglnezjZGoF0C0tKKxSGBey0To5HfBJ5PSW40toof34kS7gQxudvch
 KDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711631010; x=1712235810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q2x43f4g/1k9PawbCTBkD3eBnTaZfrxytFTBDY8Dk3g=;
 b=SfKkeCU/r49ioC4bBdXKX82FHhyGwsjW/AkY+r1lfGObvOTjZKQw14GoaMTq21hs6S
 kcRRRZpfIVpBh1Bc4RBnFREsiwaEt1NCJr3g8wubTbgLnwXGFdi3D2cLoK54YmrD2lW4
 faNVi3GCadRfw3S2w+XSrLiHwcAgImSfBorqtUyKPO967KoEsHwNi4RKRT6etTg12/1z
 Sc2BqPG0PD9T9AqeBB94ghpMJQ3pH50jF1v2K5yThP8fcKHYCxz6B7+CCCljFUoEtzgJ
 h8IJrmiWT9oTMTe1SrxkBCnPuZKHMVAEUejyQENiWGbCmUDqnsx6+X0MI71QYJyIN0dJ
 r38Q==
X-Gm-Message-State: AOJu0YwKINmEq25pvMtN8oHkoaNDobSP5uiTRYp8ZN98PAF7U1yw78P/
 JARDDjMdG6t7fqAy272O56JY11/d8HuiSBtY01UPAcu90GHtuZTuMjgoSCLcZJ8XdCTDgxJjMck
 e
X-Google-Smtp-Source: AGHT+IHCYFP2w6Zft+pz6ZBPav1fQP9UvRGriEZ8B33t9g1P3xdXeQrCxLbtekiiNs4Z5kHrqq7YLw==
X-Received: by 2002:a17:906:29d1:b0:a47:32b3:18c5 with SMTP id
 y17-20020a17090629d100b00a4732b318c5mr1695572eje.68.1711631009605; 
 Thu, 28 Mar 2024 06:03:29 -0700 (PDT)
Received: from m1x-phil.lan (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 gy16-20020a170906f25000b00a45f2dc6795sm724813ejb.137.2024.03.28.06.03.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 Mar 2024 06:03:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Cornelia Huck <cohuck@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Prasanna Kumar Kalever <prasanna4324@gmail.com>,
 Peter Xu <peterx@redhat.com>, integration@gluster.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 devel@lists.libvirt.org, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 v2 3/3] block/gluster: Remove RDMA protocol handling
Date: Thu, 28 Mar 2024 14:02:55 +0100
Message-ID: <20240328130255.52257-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240328130255.52257-1-philmd@linaro.org>
References: <20240328130255.52257-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=unavailable autolearn_force=no
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

GlusterFS+RDMA has been deprecated 8 years ago in commit
0552ff2465 ("block/gluster: deprecate rdma support"):

  gluster volfile server fetch happens through unix and/or tcp,
  it doesn't support volfile fetch over rdma. The rdma code may
  actually mislead, so to make sure things do not break, for now
  we fallback to tcp when requested for rdma, with a warning.

  If you are wondering how this worked all these days, its the
  gluster libgfapi code which handles anything other than unix
  transport as socket/tcp, sad but true.

Besides, the whole RDMA subsystem was deprecated in commit
e9a54265f5 ("hw/rdma: Deprecate the pvrdma device and the rdma
subsystem") released in v8.2.

Cc: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/system/device-url-syntax.rst.inc  |  4 +--
 docs/system/qemu-block-drivers.rst.inc |  1 -
 block/gluster.c                        | 39 --------------------------
 3 files changed, 2 insertions(+), 42 deletions(-)

diff --git a/docs/system/device-url-syntax.rst.inc b/docs/system/device-url-syntax.rst.inc
index 7dbc525fa8..43b5c2596b 100644
--- a/docs/system/device-url-syntax.rst.inc
+++ b/docs/system/device-url-syntax.rst.inc
@@ -87,8 +87,8 @@ These are specified using a special URL syntax.
 
 ``GlusterFS``
    GlusterFS is a user space distributed file system. QEMU supports the
-   use of GlusterFS volumes for hosting VM disk images using TCP, Unix
-   Domain Sockets and RDMA transport protocols.
+   use of GlusterFS volumes for hosting VM disk images using TCP and Unix
+   Domain Sockets transport protocols.
 
    Syntax for specifying a VM disk image on GlusterFS volume is
 
diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-block-drivers.rst.inc
index 105cb9679c..384e95ba76 100644
--- a/docs/system/qemu-block-drivers.rst.inc
+++ b/docs/system/qemu-block-drivers.rst.inc
@@ -737,7 +737,6 @@ Examples
   |qemu_system| -drive file=gluster+tcp://[1:2:3:4:5:6:7:8]:24007/testvol/dir/a.img
   |qemu_system| -drive file=gluster+tcp://server.domain.com:24007/testvol/dir/a.img
   |qemu_system| -drive file=gluster+unix:///testvol/dir/a.img?socket=/tmp/glusterd.socket
-  |qemu_system| -drive file=gluster+rdma://1.2.3.4:24007/testvol/a.img
   |qemu_system| -drive file=gluster://1.2.3.4/testvol/a.img,file.debug=9,file.logfile=/var/log/qemu-gluster.log
   |qemu_system| 'json:{"driver":"qcow2",
                            "file":{"driver":"gluster",
diff --git a/block/gluster.c b/block/gluster.c
index cc74af06dc..4253c8db5e 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -371,9 +371,6 @@ static int qemu_gluster_parse_uri(BlockdevOptionsGluster *gconf,
     } else if (!strcmp(uri->scheme, "gluster+unix")) {
         gsconf->type = SOCKET_ADDRESS_TYPE_UNIX;
         is_unix = true;
-    } else if (!strcmp(uri->scheme, "gluster+rdma")) {
-        gsconf->type = SOCKET_ADDRESS_TYPE_INET;
-        warn_report("rdma feature is not supported, falling back to tcp");
     } else {
         ret = -EINVAL;
         goto out;
@@ -1638,44 +1635,8 @@ static BlockDriver bdrv_gluster_unix = {
     .strong_runtime_opts          = gluster_strong_open_opts,
 };
 
-/* rdma is deprecated (actually never supported for volfile fetch).
- * Let's maintain it for the protocol compatibility, to make sure things
- * won't break immediately. For now, gluster+rdma will fall back to gluster+tcp
- * protocol with a warning.
- * TODO: remove gluster+rdma interface support
- */
-static BlockDriver bdrv_gluster_rdma = {
-    .format_name                  = "gluster",
-    .protocol_name                = "gluster+rdma",
-    .instance_size                = sizeof(BDRVGlusterState),
-    .bdrv_file_open               = qemu_gluster_open,
-    .bdrv_reopen_prepare          = qemu_gluster_reopen_prepare,
-    .bdrv_reopen_commit           = qemu_gluster_reopen_commit,
-    .bdrv_reopen_abort            = qemu_gluster_reopen_abort,
-    .bdrv_close                   = qemu_gluster_close,
-    .bdrv_co_create               = qemu_gluster_co_create,
-    .bdrv_co_create_opts          = qemu_gluster_co_create_opts,
-    .bdrv_co_getlength            = qemu_gluster_co_getlength,
-    .bdrv_co_get_allocated_file_size = qemu_gluster_co_get_allocated_file_size,
-    .bdrv_co_truncate             = qemu_gluster_co_truncate,
-    .bdrv_co_readv                = qemu_gluster_co_readv,
-    .bdrv_co_writev               = qemu_gluster_co_writev,
-    .bdrv_co_flush_to_disk        = qemu_gluster_co_flush_to_disk,
-#ifdef CONFIG_GLUSTERFS_DISCARD
-    .bdrv_co_pdiscard             = qemu_gluster_co_pdiscard,
-#endif
-#ifdef CONFIG_GLUSTERFS_ZEROFILL
-    .bdrv_co_pwrite_zeroes        = qemu_gluster_co_pwrite_zeroes,
-#endif
-    .bdrv_co_block_status         = qemu_gluster_co_block_status,
-    .bdrv_refresh_limits          = qemu_gluster_refresh_limits,
-    .create_opts                  = &qemu_gluster_create_opts,
-    .strong_runtime_opts          = gluster_strong_open_opts,
-};
-
 static void bdrv_gluster_init(void)
 {
-    bdrv_register(&bdrv_gluster_rdma);
     bdrv_register(&bdrv_gluster_unix);
     bdrv_register(&bdrv_gluster_tcp);
     bdrv_register(&bdrv_gluster);
-- 
2.41.0


