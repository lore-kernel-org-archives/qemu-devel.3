Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A643BC98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 07:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAjN7-00077W-M1; Sun, 27 Sep 2026 03:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAjMc-0006v3-QO
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 03:32:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAjMW-0006P0-Rq
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 03:31:55 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QNwB9Y2169659
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0vhTUWmO1CBOODqegI8wlkPMle6pvYQ7/sxMh+byiqM=; b=h1JlRj46pkHQBadU
 JUE3/VLWwT5BXShTVMLP4VnqB4CJjhE+bDpZ9ej2axSw8ZYZltqCEeYTLt86tvQg
 0ln7BYvvZIXzPv98a36iNsU63rToAUmCLLwu47TzBp+RCfWh/+3wqdQxEhvxBqp6
 HYv9PZWCtIKnQMPkx8H6vfG6v6qxyo2U594knUDg6Ch9kimGnjijowjNNVLJgayY
 85KKGtTyMAbAM1wG7HygGpc/L4JXzpbTTGtHgTwLRJBbLflEertxHM0a7Vq+96Tf
 h3z7oYTrbagSuqU8YETbS2Mdy7OPTOusRgxpFO0rfwoeCdIceg967W6Lu0DUlt6v
 Z+fW9w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx50sang2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:31:50 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93a0b66ecd9so336653485a.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 00:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790494310; x=1791099110; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0vhTUWmO1CBOODqegI8wlkPMle6pvYQ7/sxMh+byiqM=;
 b=MqWpm84nu1cbFt2nxuSSn4dP3jn/RG/0ALHomdVyf2yO+HHhDKiFO/aI/V+hYGX3kL
 tufeMGq1FxxX2uZGIgy3rfjwFpsgAuUTeeGfrZZuVFa9KBxdu9dcSqqGm3JNHxulSo4+
 UqbA0o6Wf4TaxmLURj7ClD1bHuAakhcW3eZMDvTrQ3MYQNW+vvfaQoJFQmwYi5N/Ph2/
 v7NCe22zRHMJH6t2pntxaR34FVnLSlgB1Q9nRLF541L9mOH6DphkWz9Pb8S/cJwFMt3K
 10mILM/0bYILReleSbZI/Gha7nl9udZ5QLCh5ekWuW46zxhg7x4A4/P7kS9q8RTb6TnK
 OzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790494310; x=1791099110;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0vhTUWmO1CBOODqegI8wlkPMle6pvYQ7/sxMh+byiqM=;
 b=WtNFFxywXz1Z18dx+BPSku1IT2jsGe8mA3p3aF+I0FXhv5hup+JD39G5/m9Ug1xokz
 6qINAN0fzpzycqFBrV/ruWlbQAJKfn9bUsZQQ0hltrH9BiSfXWp2a6Xi6w7g/bJC4Icd
 kbsR7j9wCiOpsAy+wuU32+gVxmKetR3mJpB0wVqtV1Z8Dwzav/qLundtB11Pg67WEIGs
 9FvNojZ7GlX1HrklWWJV51blfx2VHJF9oN9c9t87ChBr0tha4wC3s13WG4Nd2DZMdp/o
 HypgagPxgZ2Jwm7XiygTO1OBcTZJH7CGmisWcl+JsDMTQlF564pBtPloRTWDufUHVHnp
 dNzQ==
X-Gm-Message-State: AFuF++nx86Ggv1h6jmwr347IkE6RuRrvH5hzRZqkFN1K561yWRsQQW6y
 XA6P+KuW6B4sjcT7d0sOiG1UkwHMUdFfbAi1tbmp8dyqkWbfpC7K/Euwwx8gtqa8FjOHC1QEd45
 t3RG1OrgqYKsMYeDEOzZYhs2e95T6bjgQkv4SYihaD2c88Hs8Eks3q1nX5EXWgVI4eg==
X-Gm-Gg: AYBFou2d1KuOuWB8yKkZoIHm6IVCJvCfEOmovf2nr5ux+tXysk6hWpHp7/XgtI+ZTTW
 paDe7xKpZYEtrTIPMdyx5GQszm1nQrGeM/oBhW7V2iz2WdjVEoeSxhYEsnfhsX0DinLT0ufNnqj
 r0kb5eYXOl+THbmJOw0by3FhKQJrSu45xEEtxiiwSH34FQPtEcPTyBRJ/xPZ3abHZJtj3FLH4A6
 zqg3+fqjks5TQFfAl9xLXyITUcEP6LJhLx8W3dYnKHITnG7SJpqbxM1ap6fUM697cWkX5ITThpP
 Q9zAbRCjnCNzd5xfL9Sop3YuIZGY9QTmzXbGI7Sl5gTXuTZeJMbUN9wRJfOPSlKkmG2qcLLoRtJ
 BeBIyfOqx3nmL0BrEoOkKk5jFrd3IkPEf9vogr2Yy
X-Received: by 2002:a05:620a:bd4:b0:939:57ca:7e06 with SMTP id
 af79cd13be357-93c43c306f6mr1421856885a.9.1790494309818; 
 Sun, 27 Sep 2026 00:31:49 -0700 (PDT)
X-Received: by 2002:a05:620a:bd4:b0:939:57ca:7e06 with SMTP id
 af79cd13be357-93c43c306f6mr1421854685a.9.1790494309281; 
 Sun, 27 Sep 2026 00:31:49 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a001778312sm93063945e9.8.2026.09.27.00.31.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 27 Sep 2026 00:31:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/9] MAINTAINERS: Add Anisa Su as a reviewer for CXL
Date: Sun, 27 Sep 2026 09:31:32 +0200
Message-ID: <20260927073140.41422-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927073140.41422-1-philmd@oss.qualcomm.com>
References: <20260927073140.41422-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDAyOSBTYWx0ZWRfXxXzNMP/EAweO
 8ehCS+3sySumEcYfpSbFlrLljSxbn0C6IITcFONvHzAA1HOpRNGj5s6WUA0KffII9l+AlqFF/IL
 SrzM+kVD+t+rOxXFV7wyVBfewp5W6Nw=
X-Proofpoint-ORIG-GUID: 1vnIbGdhQglxfvGHZRM6JsWOksUuf4aa
X-Authority-Analysis: v=2.4 cv=WuK+otfv c=1 sm=1 tr=0 ts=6ab8c667 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=R4ayLD03AAAA:8 a=hD80L64hAAAA:8 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=robCOLs_H-nC26XVNfAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=qJlm0-shE6CLU_iKUWNr:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDAyOSBTYWx0ZWRfX/yo9a1hEq6AN
 kiqUgm8tAox7BOmkf6eFKEESFEa/A6mWMnoSnuH1Ms/AxG0Dm1AAHKhLC5kOcRqINHhaKhay9/R
 zbSQ0dPZj8VMvgijCb55t1rsCPeolmy/yLxF7a3c7Y3lMiTP0O747R86i3c5NkpcMZh5AhcH34e
 FdND4ipR135FpnudP1wNtWHfi2TyGlbeVj41VMI/0vCTVuE8bZvpeyP/zr2em0ViMkCrD6KiCHB
 oieoOcHpRCCcEdO+6Q7GhvXPNJiU6mupF6kbkPWqh5Xtm0ugUCTEQ19g5K5wZG09rb9RDtb4sR0
 DTBZnn6mVQMOQeHobb83DdtcxVkaQFKY7eVsgrLUdmVW/5DyUA3Qkdis/MCn+146TQGczqh2IRk
 VWMLmV+XR36NNGYg1R5QPtgi9QFqy4mcwgZvgKJBVhpeeGe2xbk0rMSsXx1JtPnSfPIwByx42Mn
 sWE+95L9+qLYSP0Pyxw==
X-Proofpoint-GUID: 1vnIbGdhQglxfvGHZRM6JsWOksUuf4aa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270029
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Anisa Su <anisa.su887@gmail.com>

I contributed the FMAPI DCD mailbox command support in hw/cxl and also
work on the Linux driver side, which is developed and tested against QEMU's
CXL emulation, so I would like to be Cc'd on incoming CXL changes to help
with review.

Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260916002143.777233-1-anisa.su@samsung.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6be9c5725b9..026c11bd9b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3338,6 +3338,7 @@ F: docs/devel/migration/CPR.rst
 Compute Express Link
 M: Jonathan Cameron <jic23@kernel.org>
 R: Junjie Cao <junjie.cao@intel.com>
+R: Anisa Su <anisa.su@samsung.com>
 L: linux-cxl@vger.kernel.org
 S: Supported
 F: hw/cxl/
-- 
2.53.0


