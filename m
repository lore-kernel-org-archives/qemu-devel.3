Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86311C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5bX-0000U9-9y; Tue, 07 Jul 2026 09:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5bW-0000RF-6T
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:12:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5bU-0000QI-Mq
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:12:49 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C8qKh3749245
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pca0Z4WzBDeiCYBG+XEsZYICqDBGUaJK5JfZvXzY688=; b=EcSPvZrcFtA7kWbY
 GM4hTaiXyTHNiTVD4Vzsi4iEFINrIwD+RbXS+ALV9xvmp3Kzv4mr+u6MLoovJS8h
 VmQncpqsGeaIxl1SZ/cgX6BPAWTypNkTlqi0MqLJf8VUYfuAgaITpXFyGQRObAgf
 lTml9TkWllvWk2DlSgeROVw5+74EbzDS/Lacd3xsSTHsKm2/m2aRDIku/yUqijS3
 bfs/xYltQ9M7G98bbH3Q6HNiDPlCBXEmTi0JcKRoEcuK3BjvNMobHF25nyhyQpzH
 Ul8doyuQ86I5QeUbX03yjBPV7HrybCDvgrtvtPIH9uKF64KU6P/Z5nCQCk9TU2RV
 LmIooQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8vdj9j6x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:12:47 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c083f1818so45608011cf.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783429967; x=1784034767; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pca0Z4WzBDeiCYBG+XEsZYICqDBGUaJK5JfZvXzY688=;
 b=asx3V+8ZyicB3MXgXOYkn1igoXdEoo9Z0gYS5P+243rOueDvH5LxCf22kWYfWv1fwG
 Arsd05DfW6mqhBaNxjQT5iucI1ENsOwKd8Nr68yOTUVwX4YHhMN/iJVskpxSX46IHmZ0
 2A7WHjPQcjZI+Ivi5osouzaNcBgRIe+w+wwF5OTsWm6E2NWESAHQOuFODxth+Z5xjno6
 R0+D7Y8P0rJqHwsLHsHZfVs+lQE4KD+5KdhlGQ3sJ9hSvdkqKrsyNLz/GPx9MCSoJPDk
 2tWsacJaMos40OjVsZOvOzxxfUVhbS/KEOJswuhLzTEhvxtLVGrAPNAK1AIknCpE//Vp
 X1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783429967; x=1784034767;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pca0Z4WzBDeiCYBG+XEsZYICqDBGUaJK5JfZvXzY688=;
 b=d6sYrN0w1Nn5PiG35NGyt+1CbRaHLsoZzycz2FwwcbOTWcIYFnuGC6Dtz3twrYQ4W7
 IlKOrTSTBGvao9KDYGtHyOE/OOHkikOCbos3SvHPzfA3SjaD9R6J81U7YG6IbEzR+C5U
 Z7ejSu4Vc4Efww1nqpe4rpzEnPZH04lbSrBWh8tq8oA9Nb3s8lhdovpWnSIB/FO49F4v
 EoSMndbhnXMUuqq0naFIwnOBwyMvXTXVAdqe0GqXFMzCK5jpQXhLH49uKFTQo0uzKi9w
 UJm3TUlH78+Nbwgnu+JNBWkZBAXRvkmBmiqpGH0wdkHP8gpjP5xbIhGqUwcQzZJaJCO2
 sakA==
X-Gm-Message-State: AOJu0YyQFk9sLKXLqA3v0AD9vgvotiHwkFLxFE9pqr+e0KMbDH73MV5X
 Hs2m3+eK/lZ7JsgVl+OdnlhUDntRyLa+YBtPXNc+9pHGrZbJ3qZATbcdDkdf56bDSYYWuHs2MJ9
 Lkkzc9hV7FfYBk69IWXyCfUMDztYzsGiTdeZutY5+93WdiuWhTkXfk4uJoKY+2hsgSw==
X-Gm-Gg: AfdE7ckdrtOVJ982gGszmwDMRdAbN01uJMFI0ai3Ql7m3AMT+DsYuF/LIJpRSqUdYrF
 qvCnyMDn6rRC8Rpg0wVSk8qzliCv+g9XjtyA0vvaYQDdNgMyPdgs+K/nwOSNVjK80bqUVNKHCsP
 02y6EUwcAn5WH9Kw25SAiSzqMFL4AN6INjj7fCyj4T7YrOjMG6g89AjvWfbsT9BNLPAHb2WXNgQ
 Bnb/GOx8Mvj5f5l8mJi4Wnw+u2mK4jRBz9bI7dH2rrbFh+Rc5KlN8jVvje3LNW8osQco7NwhLNU
 zAQbAqCAVw721mfhSjxVNNK+8086i5HTV8xsakB8nwAl/Nk2n3Lwwa168dobTpRy2H4a7Pvewet
 BtplFFwAArTgLJj4ZDZdoCMrYVqFad5wWoxCtmFzz4s6H5WYt62zZv2qJWRzPZKrDQrvY
X-Received: by 2002:a05:622a:508:b0:51c:1bcd:5cc3 with SMTP id
 d75a77b69052e-51c747a5403mr51318281cf.25.1783429966895; 
 Tue, 07 Jul 2026 06:12:46 -0700 (PDT)
X-Received: by 2002:a05:622a:508:b0:51c:1bcd:5cc3 with SMTP id
 d75a77b69052e-51c747a5403mr51317751cf.25.1783429966175; 
 Tue, 07 Jul 2026 06:12:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ad9bc41esm141059066b.37.2026.07.07.06.12.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:12:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/32] hw/display/ati: guard against zero bpp in
 ati_host_data_flush
Date: Tue,  7 Jul 2026 15:11:53 +0200
Message-ID: <20260707131223.51505-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707131223.51505-1-philmd@oss.qualcomm.com>
References: <20260707131223.51505-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=R7cz39RX c=1 sm=1 tr=0 ts=6a4cfb4f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=QyXUC8HyAAAA:8 a=69wJf7TsAAAA:8 a=57R0qBCtAAAA:8 a=EUspDBNiAAAA:8
 a=fAhWzQUUEP2HniuozqAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=mR_gFduoMj4eUoa7Ntlv:22
X-Proofpoint-GUID: OFwuL1ZqQGPaoP1IgcGJR5Kf-VGJONcc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX/OAu0ZaIMWkT
 n6kPCeJLCMTdjSX0DRjoJv4vadXTsMn9M0GuqQ9u5G+vp+oSr2BzusnMDQwWVWOpkvUbADH491I
 /W7KKh5qBlvGIMCLWpzzDOzQaKK2zaWvx2HszqeooGk5ylTxvW2QAfVQcGGzllpR4cKfDnMojAG
 D/Cdn50mwurKGwz3tIs67Co/4xiwZIXv2HowRqOl3/Tx7T17k03cwxb7cC8L8Pf5EAUnmlfWmAU
 LD07dFRHqQjeg6StlUjFiR16sOPp/rIZoK8UIzV19wG5YcM5FCJjeBRiMbkHHzgzvhy0FiGjWj0
 tXZ3B3jiKM3siXvjEgnpzKvxrlz3xRCd6Ci73szb/E2Zp3rYg44cUJSbQIIEbwn9SADJQwyc9Uz
 S42bioQGTdqdu5zuhJzicjfrlkAFKZjBTbTCWD7IVXTfO6FXsab7+KGwgRiuvd+lKWNgf3w/0JU
 zW1pBo73s0oNnQwuFVQ==
X-Proofpoint-ORIG-GUID: OFwuL1ZqQGPaoP1IgcGJR5Kf-VGJONcc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX5DmhIzHEDeSn
 ovXJ6LEvmaqPxLIT3pGsQSCnNFP3uMiWMjxDc2pSHNcknoWzYiCHmk96LzDm+FxB+0YOAC5HwZx
 nMj1Ad3XzA3I/jNRwS0Ca4LEYAEw7ks=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070129
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

From: Junjie Cao <junjie.cao@intel.com>

ati_bpp_from_datatype() returns 0 for unrecognized dp_datatype nibble
values (0, 1, or >= 7). ati_host_data_flush() only guards against the
bpp == 24 case but not bpp == 0, leading to:

  1. Division by zero at "pix_count /= ctx.bpp" (SIGFPE) when
     src_datatype is SRC_COLOR.
  2. g_assert_not_reached() in stn_he_p() when bypp (= bpp/8 = 0)
     hits the default case of the size switch.

Both are guest-triggerable via MMIO writes to the dp_datatype register
while a HOST_DATA blit is active.

Add an explicit bpp == 0 check with LOG_GUEST_ERROR before proceeding
with the blit, consistent with the existing check in ati_2d_do_blt().

Cc: qemu-stable@nongnu.org
Reported-by: Feifan Qian <bea1e@proton.me>
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Chad Jablonski <chad@jablonski.xyz>
Message-ID: <20260519023937.439077-3-junjie.cao@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/display/ati_2d.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 8ef82bb87fd..22dd811bd85 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -377,6 +377,11 @@ bool ati_host_data_flush(ATIVGAState *s)
 
     setup_2d_blt_ctx(s, &ctx);
 
+    if (!ctx.bpp) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "host_data_blt: invalid bpp from datatype\n");
+        return false;
+    }
     if (ctx.bpp == 24) {
         qemu_log_mask(LOG_UNIMP,
                       "host_data_blt: unsupported in 24 bits mode\n");
-- 
2.53.0


