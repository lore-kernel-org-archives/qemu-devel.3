Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5418BD58E6A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 06:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwxAA-0008DN-Kc; Mon, 02 Mar 2026 01:53:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vwx9j-000855-35
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 01:53:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vwx9X-000287-Np
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 01:53:17 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 621Kmtx91890335; Mon, 2 Mar 2026 06:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=42GHLE
 zyYFMDmz/9ppHvw7UejZW+On288zGUaRJetl0=; b=GiCnisJ+rgA0VNHqe4HOH6
 yiECdYgvf7U6dhoDfTaN1IlOXICxmRs0JXK1nf1QhY13+jnG99pFb0tUrjyFMYgw
 jhjLQMhzEX0b5NIdu4ayZjGvHLYLkbUQ9ChUrHdL3yNxmu095aV6irA8iu/biSAs
 NJKSgIUoElDrWJuo6VGHPszVVLDf/2877j0HU1frNkolCY/riNZ6qhBP9jtMkaD5
 47609REOmcbV//n9LlObgdvJ9LSvW9HJ8jOdf9Idvfpqslt8ZSnGD42OkeyprH49
 OMfqbAuhpUD9IWu9HGyrSliePUDAeDSvn5V3dkxRKckN5tkwIr4dEA5OFsblQX+g
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskcn99y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Mar 2026 06:53:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6224MM1t029016;
 Mon, 2 Mar 2026 06:53:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmaprvu9p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Mar 2026 06:53:09 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6226r6lu31785374
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Mar 2026 06:53:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5038E20078;
 Mon,  2 Mar 2026 06:53:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5989620077;
 Mon,  2 Mar 2026 06:53:05 +0000 (GMT)
Received: from Mac.com (unknown [9.124.211.120])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Mar 2026 06:53:05 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 4/4] MAINTAINERS: Add self as reviewer for PowerPC TCG
Date: Mon,  2 Mar 2026 12:22:17 +0530
Message-ID: <20260302065230.56220-5-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302065230.56220-1-harshpb@linux.ibm.com>
References: <20260302065230.56220-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: k98EwVMfVrjh3kVWUu9fbJ5JyVJ1rDQT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA1NiBTYWx0ZWRfX+di8Z424iV75
 wzRbZfRr5E8f6PeztDhJNd4SNhgJ3Z2MEfR2Hi1EqQwhqPbEIb7xj9gUZkv+9E6VDaGbCT/clkk
 nIEzIM58Jwpclwbwr/oMXcI+LZzxLkxi9EfqIN9rbP9iI4OyLYf8r+STO6gzQEyBg3O/Oz+5BCO
 /RPo3Jj3/p40hbxNrQTkkO+KquNgTMzSVwKGbrhWc5Z4EohyBPcX6B+8XnVNYx7jxknpO7SKhbG
 M0mRtG/BbMz9dld4MaxDpTeZ2nQ1B8KCEnO6dF0pDKRHI1UP6TaIjm5dTIIlnAwwQpC3UY6M/3a
 wBcpJeKJRu5C0R+0/0ObfIyQ5SPzsfTGfbkcgTlwBFlW6hOItALF3s2HWege2W/xqAF+m9JIbuN
 BbtK1E5opp6hB+g3rDpzfk1K+VPdCRdJpaFbpPD3OqAMiGioYGPWehhmqyCg8fKM3hA1Aqa+NcM
 N5B2S77nd8fMpqjVLNQ==
X-Authority-Analysis: v=2.4 cv=H7DWAuYi c=1 sm=1 tr=0 ts=69a533d6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8
 a=69wJf7TsAAAA:8 a=D8mJCP6V91pwcp4Pq3QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: k98EwVMfVrjh3kVWUu9fbJ5JyVJ1rDQT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020056
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Glenn Miles <milesg@linux.ibm.com>

Added myself as a reviewer for PowerPC TCG

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260225162118.914008-1-milesg@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 606b16762c..a07a3a7d4f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -313,6 +313,7 @@ F: tests/tcg/or1k/
 PowerPC TCG CPUs
 M: Nicholas Piggin <npiggin@gmail.com>
 R: Chinmay Rath <rathc@linux.ibm.com>
+R: Glenn Miles <milesg@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: target/ppc/
-- 
2.52.0


