Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5EEC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 14:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzdOl-0002Hb-Ff; Wed, 24 Apr 2024 10:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzdOc-0001yK-OX
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 10:14:51 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzdOZ-0007uY-VP
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 10:14:50 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-346f4266e59so5086758f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 07:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713968086; x=1714572886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2bDf9lJZXeC+AkSOyvp9fPxiaZmS9nFw5CAd+3sgKN8=;
 b=Xy5/yxOZqAxrpS4azdTsah3FmWb70rCeFRI/ILZ2tzKkvZ9llKyLBFVmlDlrPnuCES
 v/d/Lg/VsC4fcsEZbkStZO1noKyzvwxxB/VLMKCxHbKPtfsewroyEL2lJmsGQb4MhqQb
 aGbiOzEhDsB6DzC/pNWqDj6Z/JwzpK/F8Dd74GuxxG4kCmQfHHWj1gcNgUhUjeaYmqqT
 COomGwtKm6lGbv746L3FoDhLttpQmJElhSUvNVj2GiehGX2yRH9oCB5yXyfqUL7QenOc
 ewSTeOqLRN8P+/kPEpS80PTqpdIYPkYPSg4ew7B2VphjE+2Dns5Z8OnXSg0kA79PIzc4
 ziuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713968086; x=1714572886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2bDf9lJZXeC+AkSOyvp9fPxiaZmS9nFw5CAd+3sgKN8=;
 b=tvK4NYxxakWm8dkupy0aQPQ7Qnj06ZmgAvpZoeKuQnXfzmCmUqbULss5KMLvCuguOV
 HztWkPZzxq4bKj2al90oG0C6Ai8sEJU0/NbnMCB3J4aRKC+VO+sr7hf5EcVYmmZBeL3U
 X/9efWfz67b2hUtKPCt9cLnkETFmamfbConatThVwBlOPWymkZEba0WCgIS5ZGFnaXg7
 4Y87NMeTeXfPwgdAaX4THKF5SN1QP4z5OeGILZOZ2K82lSo7BH3O/4W+McTg+z4Xu6K0
 ko49YQJe+DxrcVijRwpdPMw5qOWvNKMrAu2DXb3Da6gKhPO5guJA+jHbjYdJ3cV84pUT
 +toA==
X-Gm-Message-State: AOJu0YzR+3JiIukW8AdUUP5MYXbmLtne8EF0nyJK2w0qBFO/i61KJiLA
 lUVMYT4mSwDo8PKyhLoYwdgD+OQjMjDKRwEKz17UYzJt2FCdmXMBpLfabm8qECfGXwNa5yc/te0
 ST+Q=
X-Google-Smtp-Source: AGHT+IEXXyzW4FF+nltF0sK5ewq9VosMCUbb0fAfF8p/N9bTfkZzsg2IH3nRfPVeUHUyFG7X3GLTWw==
X-Received: by 2002:a5d:5644:0:b0:349:9b7f:8df3 with SMTP id
 j4-20020a5d5644000000b003499b7f8df3mr1693597wrw.40.1713968085672; 
 Wed, 24 Apr 2024 07:14:45 -0700 (PDT)
Received: from localhost.localdomain
 (mon75-h03-176-184-51-42.dsl.sta.abo.bbox.fr. [176.184.51.42])
 by smtp.gmail.com with ESMTPSA id
 p2-20020a5d59a2000000b0034aaf0f2bb3sm11659535wrr.20.2024.04.24.07.14.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Apr 2024 07:14:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 integration@gluster.org
Subject: [PULL 5/5] block/gluster: Remove deprecated RDMA protocol handling
Date: Wed, 24 Apr 2024 16:14:07 +0200
Message-ID: <20240424141408.87779-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240424141408.87779-1-philmd@linaro.org>
References: <20240424141408.87779-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20240328130255.52257-4-philmd@linaro.org>
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


