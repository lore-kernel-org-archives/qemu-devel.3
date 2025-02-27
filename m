Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784B3C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tneln-00015D-RH; Thu, 27 Feb 2025 09:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnel2-0007ia-OG
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:21:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekz-0003qb-SA
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:21:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W2DTEL0GvEgD05Vg/aBlXWWfjE1Jq68V9IAsv0IIcfk=;
 b=TKzodS39GChu4vh3QJ7LvfEIpbaUg2OA3OZcQR2j14O2Zx9ddQWsBqVtjvHT+q/U6G37nY
 uX/6/hB2wOFPf5OAB/GfZoFeNwDVbq1+xjqtjvxhcCgMZnoAFI58v+y1waOgGRVF0C+nLN
 xtHtKckr/SgNK7buAF7lehpNj6TQIqs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-yYxRgl66P8Kpnts6Wi53Yg-1; Thu, 27 Feb 2025 09:20:55 -0500
X-MC-Unique: yYxRgl66P8Kpnts6Wi53Yg-1
X-Mimecast-MFC-AGG-ID: yYxRgl66P8Kpnts6Wi53Yg_1740666055
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5e4aecbd88fso1149299a12.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:20:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666054; x=1741270854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W2DTEL0GvEgD05Vg/aBlXWWfjE1Jq68V9IAsv0IIcfk=;
 b=r480jGFftfMuh8kcRv+1hLWIEOtTFBoFyj+ntGtnEWboPBjU4Qex3qUV2ZiP6SphcE
 0l0CjJMaOro/PtRZuUUgWLRu2JwwUUyIm8pc3ovn3eAQmZpnmrgqucLWlbcLrmwaF+Zy
 KiLMNuZcxptacOv/xQzddulWRE88tN2irh0fJwGVC34drmAxY6PElILg08c2JiFgZkZ/
 HFAzVDJftNJA4THzUsv4A/pzHCJBE1uJbWkZ6DJJhdmkye6UwC1+vGtuaAGyH9jacjZ8
 afEfUq76o9mrzgNUTgpxAHKrU/qi1cJ+AySyPRa5jqYBd0eHZ/SXZi+E0qUcHWg4MPlh
 WdFg==
X-Gm-Message-State: AOJu0YwW0LvxL5zG8Bpx07fo/c+wUmM0F42ZvYDqRcDR8OMp3lS8F0iw
 dY59Ffl5i/FPL5mT2N/UOzrTRcvC01Ic6n8M8muX+wQNZmb60H5DLcN9w+I7ZFUBZ8in48dhEwh
 6OFc0F7Pbddg0c7zDbWDa2sZ+VA7CFaqdKTz+zvTTIXFbpV3ucRBhhejF6Axjz5CvLdlW1370mk
 7B4EqeDhEYvLm3bvw49EbC/XG1yzDoSkwrmW+W4Z0=
X-Gm-Gg: ASbGncskRBFpLrGYbqVLDUdP++aG5bGJso79kRifxa2D02o1s9QJQFFes49fYVKj7Gg
 NII1Z2FVMq4bR/w+FHSMhmBtgAXlLnEAcyJxZh61XKULKVSvtM1fbLyPEDJ1UIgMj01wniZQYxj
 O4pGRM90TEeeCyCNjhMWzwxea9UnO0jMu6WBjN7NDRsY6u4pXMdgC7gcSrhi2SpyCU6vWtj2L4/
 K3uzYs/EHqVWig4u/AgYr8ReO9pMQkLM2WBwOPsMY9gTw2U2OZE/uihJRT0cImyMtnl2Alz+DMI
 JVAALCuwC7YfujBEOs/L
X-Received: by 2002:a05:6402:2548:b0:5db:e7eb:1b34 with SMTP id
 4fb4d7f45d1cf-5e0b70f07d4mr29001794a12.13.1740666053775; 
 Thu, 27 Feb 2025 06:20:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNsxeGbB+ZyF929QRj/hqGtIm2BMFKVfQd0zLRSDWQNLAUaW9RIj3K1h0b5ko8JQeCbTFUbA==
X-Received: by 2002:a05:6402:2548:b0:5db:e7eb:1b34 with SMTP id
 4fb4d7f45d1cf-5e0b70f07d4mr29001757a12.13.1740666053283; 
 Thu, 27 Feb 2025 06:20:53 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c43a55besm1139424a12.72.2025.02.27.06.20.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:20:51 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 27/34] i386/pc: Support cache topology in -machine for PC
 machine
Date: Thu, 27 Feb 2025 15:19:45 +0100
Message-ID: <20250227141952.811410-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227141952.811410-1-pbonzini@redhat.com>
References: <20250227141952.811410-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Allow user to configure l1d, l1i, l2 and l3 cache topologies for PC
machine.

Additionally, add the document of "-machine smp-cache" in
qemu-options.hx.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://lore.kernel.org/r/20250110145115.1574345-5-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c    |  4 ++++
 qemu-options.hx | 30 +++++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f199a8c7ad1..63a96cd23f8 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1798,6 +1798,10 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->nvdimm_supported = true;
     mc->smp_props.dies_supported = true;
     mc->smp_props.modules_supported = true;
+    mc->smp_props.cache_supported[CACHE_LEVEL_AND_TYPE_L1D] = true;
+    mc->smp_props.cache_supported[CACHE_LEVEL_AND_TYPE_L1I] = true;
+    mc->smp_props.cache_supported[CACHE_LEVEL_AND_TYPE_L2] = true;
+    mc->smp_props.cache_supported[CACHE_LEVEL_AND_TYPE_L3] = true;
     mc->default_ram_id = "pc.ram";
     pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_AUTO;
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 61270e32067..dc694a99a30 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -42,7 +42,8 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                aux-ram-share=on|off allocate auxiliary guest RAM as shared (default: off)\n"
 #endif
     "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
-    "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n",
+    "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n"
+    "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n",
     QEMU_ARCH_ALL)
 SRST
 ``-machine [type=]name[,prop=value[,...]]``
@@ -172,6 +173,33 @@ SRST
         ::
 
             -machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=128G,cxl-fmw.0.interleave-granularity=512
+
+    ``smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel``
+        Define cache properties for SMP system.
+
+        ``cache=cachename`` specifies the cache that the properties will be
+        applied on. This field is the combination of cache level and cache
+        type. It supports ``l1d`` (L1 data cache), ``l1i`` (L1 instruction
+        cache), ``l2`` (L2 unified cache) and ``l3`` (L3 unified cache).
+
+        ``topology=topologylevel`` sets the cache topology level. It accepts
+        CPU topology levels including ``core``, ``module``, ``cluster``, ``die``,
+        ``socket``, ``book``, ``drawer`` and a special value ``default``. If
+        ``default`` is set, then the cache topology will follow the architecture's
+        default cache topology model. If another topology level is set, the cache
+        will be shared at corresponding CPU topology level. For example,
+        ``topology=core`` makes the cache shared by all threads within a core.
+        The omitting cache will default to using the ``default`` level.
+
+        The default cache topology model for an i386 PC machine is as follows:
+        ``l1d``, ``l1i``, and ``l2`` caches are per ``core``, while the ``l3``
+        cache is per ``die``.
+
+        Example:
+
+        ::
+
+            -machine smp-cache.0.cache=l1d,smp-cache.0.topology=core,smp-cache.1.cache=l1i,smp-cache.1.topology=core
 ERST
 
 DEF("M", HAS_ARG, QEMU_OPTION_M,
-- 
2.48.1


