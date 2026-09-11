Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C93AC88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4x8t-0001v3-Uv; Fri, 11 Sep 2026 05:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x8m-0001nT-15
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:01:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x8k-00083d-3i
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gBSHhMDPj1wNd+THvAUfp3LvU17AmLFoV6OMcA35G6I=;
 b=hMSKRwpS/McfX6GxLfXYQMD5Vj01Pj6qLvoOhLA/r36jS9lagFPTbDOKUwZ3omYGp8Lt0S
 nn6ENzLG7Ujdd1Z5hdUVKzDcf/zUfqBRzT0rJNOTraCMdkh1o0WMSaBM5LMWbYRzew4gRt
 0+978IFx8w/rWXWhacNUWHx9BJWDSWY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-l61MYQPuPCC8GHcH9i0SXA-1; Fri, 11 Sep 2026 05:01:44 -0400
X-MC-Unique: l61MYQPuPCC8GHcH9i0SXA-1
X-Mimecast-MFC-AGG-ID: l61MYQPuPCC8GHcH9i0SXA_1789117303
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4858f06e142so498972f8f.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117303; x=1789722103; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gBSHhMDPj1wNd+THvAUfp3LvU17AmLFoV6OMcA35G6I=;
 b=a7yniP5E4RduKG2fAqOy7wq2tdBsj9cok+t0PIpU+uesRCFIoQRUQ5aHP6IS2lGN2H
 pkqlT35MHtqazfIEbiGj6e0LfO2FOmfHeYFodxxYzV4YIuWr3lxsIFaR4rnA4hiyRagk
 Zx6oFgsiZnUlmIaza4a8C+3y1XmqSGVkQvf2iSLnF7+G0PvH5yOnSrNAG8jhGpZr0PZd
 uLOIgg8t3nQd43cMMY/3Br0R1NO0rIotRaBgjYFhFkBDkK7npD+LQlBIMdhSDbp0qeQs
 eGjQ1OVlZdoXdYov7l52d7+Y78JgbWz01R9PVVbkIrAOvwbbK2iTL0Cv4baNSYZFcjHP
 Nd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117303; x=1789722103;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gBSHhMDPj1wNd+THvAUfp3LvU17AmLFoV6OMcA35G6I=;
 b=R7dsvU0USN4vYDnTqAiAhcFvDeN8FP0ZE0syj+mXw1osceHD0H7Qxo2AsPHwPcLB26
 Qj+ierqFczFBOS1muTBvAXA5zr3n5E7gabguNB0RAlYWydQovrDGcVlkbu0ipKCEvVIJ
 K/1em59bWQ4a3dWB6cQkHU/HVBR2gbZeJ0v3Wv0exLBFOKJl0maHx1qMZ67IjwaVknv8
 1cG8p6NnlKLx5RgbsRJcdsu0bh8YNANcpout1wPQHHym67jtjPNRZwt5FRwy8ny2irj7
 RP4szYfRV7W1haj4vXR/oiul+8hHgUTfiH7YhyuJ5TOT2/HjKDJS86M2tT/09r52yFv2
 7L9g==
X-Gm-Message-State: AFuF++n4AOJ+vcNWXrcMmsk2cY8zavxgFIpqfFXBlmWZU6bs9U5ubSNu
 6QnTOX2ky1UPX6Tq5JxKR393pnzwIOgjzBiPHIFBHq8GZSKhj758XzHeyB1xjJgoSWklM6HsfgL
 8dZnuJ0iGSnYjpkwo5bF25dg5JC4wTZZT9eZ8o9GunM/VL+QtDmaf/YEjUmlOihzbHAlC2gbcun
 kEjgKBsTcGJpXYUnb2V4oSlBNpGHrMOOBmFQ==
X-Gm-Gg: AYBFou081sKCaWtI4nbOwSGVyZfhlpCryefL4IR1dRWqoaOfDKxK0OvhWS55QrdLTru
 SVyZnIcWRz15jiHSHSvr3Dtap/uFPXZ9QegXR1yQX8zv2TdAQOPH2Sfvxyg3tdAcc4XUZVcAnVa
 vvvE2qj92OZganYoKYZsFH4kjl9v2YRzBSUWg0BCTOnVKV7VXnBBCXuQ/3vkkEMcHmGFwaYU0K9
 jkkhA1EJRcTDR43vWp23uwdVvgb2xbU8l2/VG4SaxhiAXJw+aj+3MZgDO2Q/hXy+bh0CnudMvC3
 VKFu+zML8PD4OFn2tF0fzRziyKxukbxag2r+VRkEHsdK+lBgKqZ0r/t4oVgql20eVHeaT3fzAxi
 mhvcWTiYocnKQCl2FdmMngQQ=
X-Received: by 2002:a05:6000:646:b0:485:8ca8:caa with SMTP id
 ffacd0b85a97d-486eb34c229mr2627882f8f.52.1789117302587; 
 Fri, 11 Sep 2026 02:01:42 -0700 (PDT)
X-Received: by 2002:a05:6000:646:b0:485:8ca8:caa with SMTP id
 ffacd0b85a97d-486eb34c229mr2627810f8f.52.1789117301580; 
 Fri, 11 Sep 2026 02:01:41 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb2ecfc3sm4359780f8f.4.2026.09.11.02.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:01:41 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:01:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>,
 Ben Chaney <bchaney@akamai.com>, Jason Wang <jasowangio@gmail.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PULL v2 10/75] net/tap: improve script/downscript options
 documentation
Message-ID: <add167b90b8eaa9aa04a5ab68aba1e0d1a6d4fd9.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Properly document defaults and special values of "" and "no".

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260819180201.1970193-3-vsementsov@yandex-team.ru>
---
 qapi/net.json   | 10 ++++++++--
 qemu-options.hx |  9 +++++----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/qapi/net.json b/qapi/net.json
index 85c78710fe..ab8ed9c086 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -399,9 +399,15 @@
 # @fds: multiple file descriptors of already opened multiqueue capable
 #     tap
 #
-# @script: script to initialize the interface
+# @script: script to initialize the interface.  An empty string or
+#     "no" disables script execution.  Defaults to
+#     ``<sysconfdir>/qemu-ifup``, where ``<sysconfdir>`` is the
+#     system configuration directory at build time (typically /etc).
 #
-# @downscript: script to shut down the interface
+# @downscript: script to shut down the interface.  An empty string or
+#     "no" disables script execution.  Defaults to
+#     ``<sysconfdir>/qemu-ifdown``, where ``<sysconfdir>`` is the
+#     system configuration directory at build time (typically /etc).
 #
 # @br: bridge name (since 2.8)
 #
diff --git a/qemu-options.hx b/qemu-options.hx
index 6c1713ed61..16ef7d5455 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3022,7 +3022,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
     "                use network scripts 'file' (default=" DEFAULT_NETWORK_SCRIPT ")\n"
     "                to configure it and 'dfile' (default=" DEFAULT_NETWORK_DOWN_SCRIPT ")\n"
     "                to deconfigure it\n"
-    "                use '[down]script=no' to disable script execution\n"
+    "                use '[down]script=no' or '[down]script=' to disable script execution\n"
     "                use network helper 'helper' (default=" DEFAULT_BRIDGE_HELPER ") to\n"
     "                configure it\n"
     "                use 'fd=h' to connect to an already opened TAP interface\n"
@@ -3558,9 +3558,10 @@ SRST
     Use the network script file to configure it and the network script
     dfile to deconfigure it. If name is not provided, the OS
     automatically provides one. The default network configure script is
-    ``/etc/qemu-ifup`` and the default network deconfigure script is
-    ``/etc/qemu-ifdown``. Use ``script=no`` or ``downscript=no`` to
-    disable script execution.
+    ``<sysconfdir>/qemu-ifup`` and the default network deconfigure script is
+    ``<sysconfdir>/qemu-ifdown``, where ``<sysconfdir>`` is the system
+    configuration directory at build time (typically ``/etc``).
+    Use ``[down]script=no`` or ``[down]script=`` to disable script execution.
 
     If running QEMU as an unprivileged user, use the network helper
     to configure the TAP interface and attach it to the bridge.
-- 
MST


