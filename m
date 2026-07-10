Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A77C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiAEp-0006Xy-Vq; Fri, 10 Jul 2026 08:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi3lG-0000Ms-Md
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:26:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi3lE-000492-Av
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:26:53 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3n9k43707758
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zx5e3hvpLfG
 gFFqw5DlLZdwsG1nOx/3xyThtl99TTe0=; b=kpuKGG1crFBDdRVoK00ZOggM2tY
 AnPQcqfo6+NwIu2l0LKd4YmzyH4WuqVmqfKQnZgmmoa2hhLcTAo9m463B8V4XKqc
 ewoHMPcOr7k/e8MIiE2J0X8VYhVGUCiqOATav2TA/PJbEoxNM8ZHokzKMLjHZoog
 vzYl4lN6hjnOTzeEWnQ9ZVwWL/DuCluzruXD7X7clnEyFw/OEvmTVKwzHzIQ/YuH
 1P9b0hQfpBJkr7VXGWi/QSwiUXVY635vNM2AD6LKQEKl44kVQdAuAsTL/b8OHCA3
 43HxYawm28HWnj2dUZkORfPZmhlZKxxsRNALl8+OLwYRIR04DeQD0ddRNEQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg5jvfp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:26:49 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-37dedbd1cf1so322950a91.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 22:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783661209; x=1784266009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zx5e3hvpLfGgFFqw5DlLZdwsG1nOx/3xyThtl99TTe0=;
 b=iCTGmp5fsCWWM94k2ngiMoPuiVuHdmtNtoJCg9VnYgYNQAOdDLmQl0DmzgCxi29qeL
 +GkzH+by6rnn2emXCcQd9hY0ml4M9U3hndL0us8luh+nAUvPk+0tITDM2N+2mdZC4ytr
 z5YDauK+xL9XvLu5qP+XDgIPHmdkB7r/Z0QGZYWH9yYJh6yMDEq8qxdqMJDdZH8CucyH
 jXttLq7cHzpawW2ig22jfHgDHqOQI0ogZxwh1TLU/1l9hXiKWy4lGf+Vl0LKyMfzDo93
 TEOD8dHMlxDHe5WQu4c7fkI9P7RjkbAHfopFMX10IM9XXtWItrBZ7fEVNxb7/SzAssqD
 6a5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783661209; x=1784266009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zx5e3hvpLfGgFFqw5DlLZdwsG1nOx/3xyThtl99TTe0=;
 b=PMJxuzDyNXQBMpdSiCr/w0KUPW17pr/83joWLtXrprzATwORHU2mB+VIQj/m6dv6ex
 ZHa0qDdYUK5BdYoqtkiwyAT6froglAar4OZLLWCvDzVUy43WWmO80oaoH6adHBqHib9A
 3BixPGgnceNgDz2AX19nfvoofU0JK63n0nsUA4Jz7lsFkpmdRy+U/LLceeBUxS28Xkl+
 u6qZ/6Syw66pU2LpBTq2oF4htLfU5wOAk/yPrZHdTm6eD6rxdcE3pikOzpedgu6oXjkv
 nQLNbce+jvk1PEGZiIBeHhr+4R3qRjkCQ4Nvqirejz7oS9akvyWU0D4Djq1S/zhDw/eT
 Wi4g==
X-Gm-Message-State: AOJu0YzWVSfpR4SE9MDKzCSVbh9v8PkQeBin2T4f3MYLckVeOlufTpsl
 j6Bw2sVbIqOlURlQGloxFQOkxjI81hqL2P6qRVuzO6GVulHGHi53EPXYQ/TdUG3zVkCgn3UUI/J
 fGXS9q4hg4FpvFXoVp/GbH67agvhszAfc/2gAakXv2lpv4sqvYCS7LeeL6fPGkXw84A==
X-Gm-Gg: AfdE7ckJYYSgQu2n5BqQGOKOYi4GFCBSbvHWoUxdiUE2Q+5iQSN51va3FLLexA57bHP
 NiHkz3zL67Chf2y4vcpc1Ha4T/Iq1JvHXs94a3QVFW+QxjfkGj+/b9KUlcr9ynXTZ1paIS5U0Ox
 Ap/TKZB1yGQ6bz70ejzbBgBrIeAmTWgYKaEDnot8wKb5w+1KtfQlxnxEaFfDmKkRCp7wi7p0Tlb
 A83Xhwv53LqyKVEGGAx4MJydj5OZN03jMBaMv5vBgObUjlgJVcsaXXv42gLqWgR4ajJF0P9lRxq
 o98DVHWp4sv+71XJLWK5IMQRj/Vr+HP+FSTBFsCHs3uwL1Lt+18qgGAta9vwu8s/FsPjCNzQBlN
 jRHTiV6r/d9QyW7HYI/lSjQdwORb3E1wAv5GEv0Sc+w3Mkzp7sSQAVoRquyjA9IJ+nD4SJu5aoh
 nXbsIqQiwbaMXuJRGaZ8A/Hud0d2p3+MEmc1697C6Reg==
X-Received: by 2002:a17:90b:37cc:b0:381:6cf0:d5f5 with SMTP id
 98e67ed59e1d1-38a2122afafmr5569047a91.5.1783661208641; 
 Thu, 09 Jul 2026 22:26:48 -0700 (PDT)
X-Received: by 2002:a17:90b:37cc:b0:381:6cf0:d5f5 with SMTP id
 98e67ed59e1d1-38a2122afafmr5569029a91.5.1783661208044; 
 Thu, 09 Jul 2026 22:26:48 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm62476707c88.14.2026.07.09.22.26.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 22:26:47 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/10] build: add optional librpmi dependency
Date: Fri, 10 Jul 2026 10:56:33 +0530
Message-ID: <1f2732b7220280efc1b5f69ae022b318dbbc3827.1783660209.git.subrahmanya.lingappa@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783660209.git.subrahmanya.lingappa@qti.qualcomm.com>
References: <cover.1783660209.git.subrahmanya.lingappa@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FN8rAeos c=1 sm=1 tr=0 ts=6a508299 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=_6tmRKQHnRYSWcN6IbQA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA0OCBTYWx0ZWRfX34t3AZQlWxTA
 hbQD2tWtK1xRMVOy0g4c4iYRFCStsOQ8S5fiqlQM7Ss92RFMOAEvZzRgWXB5JjJ8r8sIReK9R4V
 c3a89MMjD8ckhN3J/UKpcrEB5ZcNQ7E=
X-Proofpoint-ORIG-GUID: XwXcyZAMabP-59oH6HVX67yyciKGKVFk
X-Proofpoint-GUID: XwXcyZAMabP-59oH6HVX67yyciKGKVFk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA0OCBTYWx0ZWRfX9GPf7Z8btbUk
 HhG4aQQ/Zx876bKgivsRjkXyISknXqmIUuVDWXXbZfaBwMAnBmb9dA0J5GZwRB/RMmae7lZWSFU
 Iaf2BkaMrp1OkMX+/tUAY02eN5AEAf1970IK0skdXGsIaEARUqB2KWK0zq4z3k4A3547t5XcTih
 yInfA3yLEvP7arh77+4Nx4N/vp2fpWSYi6E5c2eyOJ3eJWQWN8T7A4GMdYqgSF9W0hS81pnei/j
 1y9YNiMRr1uU8itChQVArW38st1OqmzxzKVzSAGTTaczsqX3BYJUs6Lcgwp5zHTpctmDS69Ngyd
 UhlKEwCD9DxxdYFaNXx9KboErUxwgTG55Yfxf/+QpvftgasTVYMaVYe0i9+ZRYF+pd/weir3Zpv
 uDhqjhCcxtl9TYaUyhsLqOYRs4T2ig7+o9w56EvNYFM7rGV1PoplAYdA+SXVaQ7NH6TDpfd81tm
 cm+XnMx8t4rL6mSBXbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1011 impostorscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100048
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Jul 2026 08:21:33 -0400
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

From: Subrahmanya Lingappa <subrahmanya.lingappa@qti.qualcomm.com>

Add a meson option and config probe for librpmi so RISC-V machines can
opt into RPMI support when the library is available. Keep the dependency
optional so default builds without librpmi continue to work.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@qti.qualcomm.com>
---
 Kconfig.host                  |  3 +++
 meson.build                   | 14 ++++++++++++++
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 4 files changed, 22 insertions(+)

diff --git a/Kconfig.host b/Kconfig.host
index 933425c74b..6f98dadb2e 100644
--- a/Kconfig.host
+++ b/Kconfig.host
@@ -8,6 +8,9 @@ config LINUX
 config LIBCBOR
     bool
 
+config LIBRPMI
+    bool
+
 config GNUTLS
     bool
 
diff --git a/meson.build b/meson.build
index 19e123423b..103b4649b8 100644
--- a/meson.build
+++ b/meson.build
@@ -2005,6 +2005,17 @@ if lzo.found() and not cc.links('''
   endif
 endif
 
+librpmi = not_found
+if not get_option('librpmi').auto() or have_system
+  librpmi = dependency('librpmi', required: get_option('librpmi'),
+                       method: 'pkg-config')
+  if librpmi.found() and not cc.has_header_symbol('librpmi.h',
+                                                  'rpmi_service_group_logging_create',
+                                                  dependencies: librpmi)
+    error('librpmi support requires the RPMI logging service group API')
+  endif
+endif
+
 numa = not_found
 if not get_option('numa').auto() or have_system or have_tools
   numa = cc.find_library('numa', has_headers: ['numa.h'],
@@ -2427,6 +2438,7 @@ config_host_data.set('CONFIG_LINUX', host_os == 'linux')
 config_host_data.set('CONFIG_POSIX', host_os != 'windows')
 config_host_data.set('CONFIG_WIN32', host_os == 'windows')
 config_host_data.set('CONFIG_LZO', lzo.found())
+config_host_data.set('CONFIG_LIBRPMI', librpmi.found())
 config_host_data.set('CONFIG_MPATH', mpathpersist.found())
 config_host_data.set('CONFIG_BLKIO', blkio.found())
 if blkio.found()
@@ -3258,6 +3270,7 @@ host_kconfig = \
   (multiprocess_allowed ? ['CONFIG_MULTIPROCESS_ALLOWED=y'] : []) + \
   (vfio_user_server_allowed ? ['CONFIG_VFIO_USER_SERVER_ALLOWED=y'] : []) + \
   (hv_balloon ? ['CONFIG_HV_BALLOON_POSSIBLE=y'] : []) + \
+  (librpmi.found() ? ['CONFIG_LIBRPMI=y'] : []) + \
   (have_rust ? ['CONFIG_HAVE_RUST=y'] : [])
 
 ignored = [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR' ]
@@ -4971,6 +4984,7 @@ summary_info += {'TPM support':       have_tpm}
 summary_info += {'IGVM support':      igvm}
 summary_info += {'libssh support':    libssh}
 summary_info += {'lzo support':       lzo}
+summary_info += {'librpmi support':   librpmi}
 summary_info += {'snappy support':    snappy}
 summary_info += {'bzip2 support':     libbzip2}
 summary_info += {'lzfse support':     liblzfse}
diff --git a/meson_options.txt b/meson_options.txt
index a07cb47d35..9f773a7886 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -204,6 +204,8 @@ option('lzfse', type : 'feature', value : 'auto',
        description: 'lzfse support for DMG images')
 option('lzo', type : 'feature', value : 'auto',
        description: 'lzo compression support')
+option('librpmi', type : 'feature', value : 'auto',
+       description: 'RISC-V RPMI support')
 option('pvg', type: 'feature', value: 'auto',
        description: 'macOS paravirtualized graphics support')
 option('rbd', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index c003985047..e8a20068e7 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -140,6 +140,7 @@ meson_options_help() {
   printf "%s\n" '  libkeyutils     Linux keyutils support'
   printf "%s\n" '  libnfs          libnfs block device driver'
   printf "%s\n" '  libpmem         libpmem support'
+  printf "%s\n" '  librpmi         RISC-V RPMI support'
   printf "%s\n" '  libssh          ssh block device support'
   printf "%s\n" '  libudev         Use libudev to enumerate host devices'
   printf "%s\n" '  libusb          libusb support for USB passthrough'
@@ -376,6 +377,8 @@ _meson_option_parse() {
     --disable-libnfs) printf "%s" -Dlibnfs=disabled ;;
     --enable-libpmem) printf "%s" -Dlibpmem=enabled ;;
     --disable-libpmem) printf "%s" -Dlibpmem=disabled ;;
+    --enable-librpmi) printf "%s" -Dlibrpmi=enabled ;;
+    --disable-librpmi) printf "%s" -Dlibrpmi=disabled ;;
     --enable-libssh) printf "%s" -Dlibssh=enabled ;;
     --disable-libssh) printf "%s" -Dlibssh=disabled ;;
     --enable-libudev) printf "%s" -Dlibudev=enabled ;;
-- 
2.43.0


