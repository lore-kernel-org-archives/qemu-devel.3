Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8231BC27C43
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 09:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCFsK-0005Bd-0V; Wed, 29 May 2024 05:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1sCFsG-00053W-73
 for qemu-devel@nongnu.org; Wed, 29 May 2024 05:45:36 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1sCFs8-0000T7-B3
 for qemu-devel@nongnu.org; Wed, 29 May 2024 05:45:32 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vq4CC6jFZz6JB59;
 Wed, 29 May 2024 17:41:27 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 9D887140A30;
 Wed, 29 May 2024 17:45:26 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.202.227.28) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 10:45:20 +0100
To: <peterx@redhat.com>, <farosas@suse.de>, <yuan1.liu@intel.com>
CC: <qemu-devel@nongnu.org>, <linuxarm@huawei.com>,
 <linwenkai6@hisilicon.com>, <zhangfei.gao@linaro.org>,
 <huangchenghai2@huawei.com>
Subject: [PATCH 2/7] configure: Add uadk option
Date: Wed, 29 May 2024 10:44:22 +0100
Message-ID: <20240529094435.11140-3-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20240529094435.11140-1-shameerali.kolothum.thodi@huawei.com>
References: <20240529094435.11140-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.28]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
From:  Shameer Kolothum via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add --enable-uadk and --disable-uadk options to enable and disable
UADK compression accelerator. This is for using UADK based hardware
accelerators for live migration.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 meson.build                   | 14 ++++++++++++++
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 3 files changed, 19 insertions(+)

diff --git a/meson.build b/meson.build
index 2a8d8385fe..f4ed29d876 100644
--- a/meson.build
+++ b/meson.build
@@ -1210,6 +1210,18 @@ if not get_option('qpl').auto() or have_system
                     required: get_option('qpl'),
                     method: 'pkg-config')
 endif
+uadk = not_found
+if not get_option('uadk').auto() or have_system
+  libwd = dependency('libwd', version: '>=2.6',
+                      required: get_option('uadk'),
+                      method: 'pkg-config')
+  libwd_comp = dependency('libwd_comp', version: '>=2.6',
+                           required: get_option('uadk'),
+                           method: 'pkg-config')
+  if libwd.found() and libwd_comp.found()
+     uadk = declare_dependency(dependencies: [libwd, libwd_comp])
+  endif
+endif
 virgl = not_found
 
 have_vhost_user_gpu = have_tools and host_os == 'linux' and pixman.found()
@@ -2316,6 +2328,7 @@ config_host_data.set('CONFIG_STATX', has_statx)
 config_host_data.set('CONFIG_STATX_MNT_ID', has_statx_mnt_id)
 config_host_data.set('CONFIG_ZSTD', zstd.found())
 config_host_data.set('CONFIG_QPL', qpl.found())
+config_host_data.set('CONFIG_UADK', uadk.found())
 config_host_data.set('CONFIG_FUSE', fuse.found())
 config_host_data.set('CONFIG_FUSE_LSEEK', fuse_lseek.found())
 config_host_data.set('CONFIG_SPICE_PROTOCOL', spice_protocol.found())
@@ -4444,6 +4457,7 @@ summary_info += {'bzip2 support':     libbzip2}
 summary_info += {'lzfse support':     liblzfse}
 summary_info += {'zstd support':      zstd}
 summary_info += {'Query Processing Library support': qpl}
+summary_info += {'UADK Library support': uadk}
 summary_info += {'NUMA host support': numa}
 summary_info += {'capstone':          capstone}
 summary_info += {'libpmem support':   libpmem}
diff --git a/meson_options.txt b/meson_options.txt
index 562db29ab4..d327eba593 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -261,6 +261,8 @@ option('zstd', type : 'feature', value : 'auto',
        description: 'zstd compression support')
 option('qpl', type : 'feature', value : 'auto',
        description: 'Query Processing Library support')
+option('uadk', type : 'feature', value : 'auto',
+       description: 'UADK Library support')
 option('fuse', type: 'feature', value: 'auto',
        description: 'FUSE block device export')
 option('fuse_lseek', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 26bf9e21fd..4aea75e9a5 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -223,6 +223,7 @@ meson_options_help() {
   printf "%s\n" '  xkbcommon       xkbcommon support'
   printf "%s\n" '  zstd            zstd compression support'
   printf "%s\n" '  qpl             Query Processing Library support'
+  printf "%s\n" '  uadk            UADK Library support'
 }
 _meson_option_parse() {
   case $1 in
@@ -565,6 +566,8 @@ _meson_option_parse() {
     --disable-zstd) printf "%s" -Dzstd=disabled ;;
     --enable-qpl) printf "%s" -Dqpl=enabled ;;
     --disable-qpl) printf "%s" -Dqpl=disabled ;;
+    --enable-uadk) printf "%s" -Duadk=enabled ;;
+    --disable-uadk) printf "%s" -Duadk=disabled ;;
     *) return 1 ;;
   esac
 }
-- 
2.17.1


