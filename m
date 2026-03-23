Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A363F483F8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 22:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4nNo-0000fb-5y; Mon, 23 Mar 2026 18:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saarnio@qti.qualcomm.com>)
 id 1w4nNj-0000fC-0I; Mon, 23 Mar 2026 18:04:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saarnio@qti.qualcomm.com>)
 id 1w4nNg-0006XY-7z; Mon, 23 Mar 2026 18:04:18 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHqiPD3634389; Mon, 23 Mar 2026 22:04:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=9iPdt3lmpQHaxkZJAS3bz6
 znY6DrG0x+4w/9tgQN0WI=; b=HtP9VQI6bvkIkObAzkps+Gl2pOi/F5+Q24UKRg
 bhGC+c34eeD2xNgLZNRF7LWoi9jk8wTDct24FC4bHTpuEHwr4HZNFsOg0+aIzaa9
 GPwPR3kihtaLIysVYsYSoSr1MYFsicX5xz0zlYQ3PbVMulsC2Xfpox9daRDcvhMv
 /OZGwAm8KuwDyoK68/iuGGMHJvqH3qfVp7k0MAyZOM+Wt9o6qcV0l2ZWlE5J8cSN
 mz/J00NJJw9GZZhHs2BmZy4tpqusFkyKmDgYJbv4oN76uwdIJa3TGPVQuByWOpyt
 eZhy7mu/cKxOohfwajxqTsRw0GeY8XKZwyvEW/mm7KqI3A3w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d34k4j6wh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 22:04:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 62NM4CQL007883
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 22:04:12 GMT
Received: from QCOM-tWJIMEwlxO.na.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 23 Mar 2026 15:04:01 -0700
From: Steve Aarnio <saarnio@qti.qualcomm.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-trivial@nongnu.org>, <mohamed@unpredictable.fr>, <mjt@tls.msk.ru>,
 Steve Aarnio <saarnio@qti.qualcomm.com>
Subject: [PATCH] meson.build: Add --enable-pdb option
Date: Mon, 23 Mar 2026 15:02:46 -0700
Message-ID: <20260323220328.943-1-saarnio@qti.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: qhKM2ieV9NfRTt5pH8Pa6ovwthVPyMjD
X-Proofpoint-ORIG-GUID: qhKM2ieV9NfRTt5pH8Pa6ovwthVPyMjD
X-Authority-Analysis: v=2.4 cv=c+imgB9l c=1 sm=1 tr=0 ts=69c1b8dd cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=03-b9m0o2sch-EDQva0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE2MyBTYWx0ZWRfX/hAEG2VxhTzu
 uGkf9EeicvblotzHHuYTCzqAyX498Bn/D6se6X90uA6BpUdKnr889AzxAxRXm/fAVoq4vjOLpS3
 ktyF1TX8C+CU+n38NlUT9mYyitY1X2qSZfOvP1oJVAOgXkirdpUXyxsP7B74YX/4jgUzsrLFoQD
 qj648gdZgPP9KDpcr9tVsLmxY4J7BHED/lrIVHZF6z2RK+BPCvXD3HtxA6O2tN39gCIkkyv5VhV
 5xI2qc98dPZSnGn0DSlIjYDU2wGnEZnSyZlfej3+Sqo3jhdBqvR4DAq63163SL1oO8EbY4KmJYs
 l5UGM5r+Cn2qF4oNg1XIUBA+SMrMdsEa3TsobGh4h1d2/wbV3yQ33S1KOv7YW1EnF9K6t8YVVEM
 X/BDHNNmoM/Vawp5J+oeiOG9Qy5XmbE0PhHrsfu6+kKHuk/f1wlfNjKtzvwayJqJRfXeonnwrND
 DTuA+rYccXjnjIlQ3PQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_05,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230163
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=saarnio@qti.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This option will (attempt to) modify the QEMU compile and link flags to emit
PDB symbol files rather than the standard (DWARF?) symbol output from gcc/clang.
Prerequisites for this are host_os == Windows and --enable-debug flag set.

This enables using native Windows debug tools (Windbg/Visual Studio) for
debugging QEMU.

Signed-off-by: Steve Aarnio <saarnio@qti.qualcomm.com>
---
Added Mohamed's suggested change to configure.

 configure         | 3 +++
 meson.build       | 5 +++++
 meson_options.txt | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/configure b/configure
index 42c45fe47a..502a61412f 100755
--- a/configure
+++ b/configure
@@ -707,6 +707,9 @@ for opt do
       meson_option_parse --enable-debug-mutex ""
       meson_option_add -Doptimization=0
   ;;
+  --enable-pdb)
+      meson_option_add -Dpdb=true
+  ;;
   --disable-tcg) tcg="disabled"
   ;;
   --enable-tcg) tcg="enabled"
diff --git a/meson.build b/meson.build
index d7c4095b39..e6f17dd5f7 100644
--- a/meson.build
+++ b/meson.build
@@ -692,6 +692,11 @@ endif
 
 qemu_common_flags += hardening_flags
 
+if host_os == 'windows' and get_option('debug') and get_option('pdb')
+  qemu_common_flags += cc.get_supported_arguments('-g','-gcodeview','-gcolumn-info','-fno-omit-frame-pointer')
+  qemu_ldflags += cc.get_supported_link_arguments('-g','-Wl,--pdb=')
+endif
+
 # Collect warning flags we want to set, sorted alphabetically
 warn_flags = [
   # First enable interesting warnings
diff --git a/meson_options.txt b/meson_options.txt
index 31d5916cfc..bffbc7923d 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -372,6 +372,8 @@ option('debug_stack_usage', type: 'boolean', value: false,
        description: 'measure coroutine stack usage')
 option('qom_cast_debug', type: 'boolean', value: true,
        description: 'cast debugging support')
+option('pdb', type: 'boolean', value: false,
+       description: 'use pdb symbol format on Windows debug builds')
 option('slirp_smbd', type : 'feature', value : 'auto',
        description: 'use smbd (at path --smbd=*) in slirp networking')
 
-- 
2.53.0


