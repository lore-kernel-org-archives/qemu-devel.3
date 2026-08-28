Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0AFC61DD3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05bb-0001oG-Gj; Fri, 28 Aug 2026 19:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05bL-0001Bf-H6
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:03:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05bJ-0006CK-2L
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:03:10 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTJjK014615
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 23:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=DqtIG53AlRe
 zvlq7vSu/yJbQEUyPOvahOZe+3M3x+9A=; b=l11tLpnc3zRz+RepKLqOxv/eu35
 2eoyvQvwhulpgSDJyKkNXMgxrFZ5XP2BPDV5i5MWFXEb0FhtSmJIgKEwGImbGza4
 aoGCLAscC2IuNgyLMiKdS6bTNdWS+jBWU/xUZ8eeCHmHrDRiPYEC6OXfIJYhE/SQ
 tTQw/OYwU9Mo0Q7nsIpRcnyor+2bsqmLTbeQ/4F9JUGdmfQpiR6xuUKAcRRKEkYv
 TpSAEWv2VSrjcMixojhX6PEQqsba3uHRFpl4+xd1rM1HlvL35gFdD1wa1jLBwTcT
 JdHnT2qpC/PLPShyVzeugTyAq4Ob7VPLIGUhSdpN/qx1lxMlVR3kce/qQQQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbgvfgfcb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 23:03:07 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cbedb8673ceso1782792a12.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 16:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787958187; x=1788562987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DqtIG53AlRezvlq7vSu/yJbQEUyPOvahOZe+3M3x+9A=;
 b=bl47CurX0udflnna5bco1T4JE+/znBw2nLqvpSR/kfJDS31w8MPalSD6LRhv+LDS7j
 8Z4JOiEkJDtpEb5G6WcrWvWn8ZFsycmxr7G6rds+gy8j0aT0N9suYAkmzwdqs+sZfz4N
 fH/bQtN4Nyc2W/rja7Kwu/6kfjGgUcv23PRCunOJgLZurZloakLxGD85Oi2ZK5v+vIbL
 iRLSWhrSvnnEn2Lg92/rT84MbXEGoLw7RWRdpz0/z/pC2D1q5t+9PM8wdYOJmuzlgHTd
 zwD4l5JnNdypGYnlMahoyDm2yGR2qwmAx/8H4x32vkMtega6S1E4SJbHmFOL+qkwgLyr
 OqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787958187; x=1788562987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DqtIG53AlRezvlq7vSu/yJbQEUyPOvahOZe+3M3x+9A=;
 b=cfB83+7qYG7Xi3+WvWWoK+38/FdWQPurgLoDIX7nvumVaUlRMUn4NlVhSkQVU0w/W8
 KVCadMHo6KaINIS3I8DQG5rsTHIbLKYak027WC1kaZdNPGQ+IEA2ZRR+ynKfUGITcWiW
 6v15FKWdLDxg6jVVREcNaz+UTMw1ThSCEL0fekEsCW/INbwEJuc2icotXk1nbsAanTp1
 vfW94SWnFn+fB8QUUWPOAAz7VYvkGbGef2syudcq963zKzJn+usmJjRMx8NDj1Sh107V
 DSEbT0w7H5ss59AjAgQB6TJisidKsiVJRLXU4soO9DW6F7Xvq6Sl/4ZvVvKQXeK/6ab1
 ddGw==
X-Gm-Message-State: AFuF++nleBSlm+0Pssg0qpCh3ODCefG2wj8z+lw7rtaoPyB96MyZRdXJ
 oDFA1Hxn3Xa/fi4TOCvSlrGkH6NWkOer7fy510vbDHKy8SGqe0Fd3UDhC81j5kTBq2IGO7620Hy
 cd0HdBJ7TDa4w7IgsZoBjoggYsGkCDXnCqdqJ4cQo7tPrT98Lmzi8CUMqVgPet6/cbg==
X-Gm-Gg: AR+sD13p97Mr2C7f6cz9dOgLcAVw+199C7UFQc6aXqEEl+SBO7fuMJnomKZFqzBHrs9
 30i1I7evfXNAOuyDqVSrBr+YlqHe+qvlQ/jwyWxQ8y71OJ5jjQU1xe0u1Tx0nf45rnztO/u8KX/
 Mq+nF3N1cCDxWDTiaockgd17eqZz8nDWy5fcFTTLMF1qopKO87xe+inAlI55L7obCMJVniHsGI6
 CP71ajn3p3zRhDp30vBEjbAyS9g+hBtGS2tUN0U8jwPe8lADszG3bPlgUmKwa4lxYF4v9a/suNr
 aqZ3fnSbPl6eLzbIKiWZuKsQJkSRNeFizQd7I+s6vcHGjqwVhI/6cwL7sO0db/sSHdWtd7XOQO/
 8N4TLpTLzbN5rZfHiwUV+UvBnVVrRWy27Zi/k13yG4XIiQ+nAo/zk+k1zPPg=
X-Received: by 2002:a05:6a20:6a27:b0:3d3:ae1f:d7f5 with SMTP id
 adf61e73a8af0-3d3ae2013d9mr3626016637.21.1787958187009; 
 Fri, 28 Aug 2026 16:03:07 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a27:b0:3d3:ae1f:d7f5 with SMTP id
 adf61e73a8af0-3d3ae2013d9mr3625962637.21.1787958186565; 
 Fri, 28 Aug 2026 16:03:06 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f99585csm8448569eec.21.2026.08.28.16.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 16:03:06 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 46/47] hw/pci-bridge: filter from CONFIG_CXL
Date: Fri, 28 Aug 2026 22:59:00 +0000
Message-ID: <20260828225901.367438-47-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfXzD5PKKDVRUhk
 RVgsf5ScUvxfCD6GZBzDt57OHHhzrNA5xokxwMyOeUxWoFwf716+clyz/ii70xJQTB0XmxrlajG
 D5JMxuW9ugtZJjBdPjbLlvQmwpRvJK/H+SK2dga6tW3JpKBNDJ1hLX/tnR1A/In64RIQKRzStIE
 TpV7JEc3HZz0mPAHoTlZ3sFpkWoDCtw4Qph7ricvijaaVC02k0Er8ipvad/3T5fEAIN+3VL/va0
 u9bx3tLlbGQV9P8FzA9DG7KVVwqAvYw4JW55rhnA7X5Aq4/KByuVUHPTwX4UpOMrZRr10tDb5Tj
 qEx/WEiXttzXcC1xOgEGS1AjdiKzmx59oIPtHQ5MiHVEoe9suztSsu7D1X8+Ji65nHu3xJg3o6O
 qav4NCl5vs58R36qD6+3QbdKGuie/F1uN21E+kFGd1uGa3c9XxTVAlDV0qqbDzTmzSHgD3FCdmc
 C65tpqCLnddJ8fe1G9w==
X-Proofpoint-ORIG-GUID: iyCGFIIwf68sOMLsXVBDq8Nq4_UkwSIY
X-Authority-Analysis: v=2.4 cv=UcthjqSN c=1 sm=1 tr=0 ts=6a9213ab cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=vbsKY5us0WoHdvgjJyMA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX72TosqYUNdHe
 3eW4ps2Bv/p7ntUO59QcbbQHIH05ZtS0oNXIa8K+P+I6JaBA5hgU3uYZELsCRrjXgmitherU794
 kaDyIaR9cZndiFHVKIb/rvqwRVV5pHk=
X-Proofpoint-GUID: iyCGFIIwf68sOMLsXVBDq8Nq4_UkwSIY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280200
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/pci-bridge/cxl_downstream.c | 1 +
 hw/pci-bridge/cxl_root_port.c  | 1 +
 hw/pci-bridge/cxl_upstream.c   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index ec450d1aa09..a8aad11d4e5 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -252,6 +252,7 @@ static const TypeInfo cxl_dsp_info = {
     .instance_size = sizeof(CXLDownstreamPort),
     .parent = TYPE_PCIE_SLOT,
     .class_init = cxl_dsp_class_init,
+    .is_available = target_config_cxl,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { INTERFACE_CXL_DEVICE },
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index e2093ac39ee..dfa2af7d86b 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -297,6 +297,7 @@ static const TypeInfo cxl_root_port_info = {
     .parent = TYPE_PCIE_ROOT_PORT,
     .instance_size = sizeof(CXLRootPort),
     .class_init = cxl_root_port_class_init,
+    .is_available = target_config_cxl,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CXL_DEVICE },
         { }
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index 69773ff1638..d0398588e1b 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -400,6 +400,7 @@ static const TypeInfo cxl_usp_info = {
     .parent = TYPE_PCIE_PORT,
     .instance_size = sizeof(CXLUpstreamPort),
     .class_init = cxl_upstream_class_init,
+    .is_available = target_config_cxl,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { INTERFACE_CXL_DEVICE },
-- 
2.43.0


