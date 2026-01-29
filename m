Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECCAD73E83
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 19:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlXOa-0003dn-00; Thu, 29 Jan 2026 14:09:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vlXOP-0003TH-0I; Thu, 29 Jan 2026 14:09:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vlXOD-0003Au-4W; Thu, 29 Jan 2026 14:09:14 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60TEppe3011231;
 Thu, 29 Jan 2026 19:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=K/sebiUn2HvzVNjBb
 c4GSlaUQut/Y+hIcZ7uUyoXTbk=; b=A6g3tkaGzT9w+5oRmpHfSfpinL6nv/7ih
 9y6rV5Jq48HLx+bmWn+/G5ywqa34a58Gumq94DLo8OWCglHcv5RSoIV15eylwODm
 ND88DNZ5y5f7KqXjrzOucR9hPULBcIseNVHbcTR3mIGPaPVSOjcxxsRankmo6uTg
 mX55os364spMrR8lylnvxUoxbAJwSDczkgTXIJp/pyv3dFZowd8Z3XRCO4/N2CfF
 vLvclB9n3bgBITU4SJXmhej9JbyUVK0DcfvZp65w7eVfcgK15x0AfiMOpSliTvtK
 Nuz39K3VjnJ+LRc85UduGq66Ud5duY45dOdoZbdGyF+DsSBsxr6AQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgg7tqj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 19:09:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60TH4kwh018045;
 Thu, 29 Jan 2026 19:09:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwb42309g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 19:09:08 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60TJ96hP30474546
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jan 2026 19:09:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B3AF20043;
 Thu, 29 Jan 2026 19:09:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 315A920040;
 Thu, 29 Jan 2026 19:09:06 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.87.137.8])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Jan 2026 19:09:06 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 3/5] fpu: Restrict parts_round_to_int_normal to target
 precision
Date: Thu, 29 Jan 2026 19:57:23 +0100
Message-ID: <20260129190902.196262-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129190902.196262-1-iii@linux.ibm.com>
References: <20260129190902.196262-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Z4vh3XRA c=1 sm=1 tr=0 ts=697bb055 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=Y7_wFDRbBJZQL2pu5q4A:9
X-Proofpoint-GUID: OhW2xG-SxgqjpLgIRs_OtBmjmX5EJvMe
X-Proofpoint-ORIG-GUID: OhW2xG-SxgqjpLgIRs_OtBmjmX5EJvMe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEzNCBTYWx0ZWRfX+q9+lCcfd7Fm
 hxPRbBTNqWQY1WcZjiq/gxCCmCI8G8GVf3ZBRK6PEHlsWnFt8fdSiEpvafpm5JhiAZNpwa9TNl2
 /iM4LafScc6rKL+NLElNHwnUQ/Fo5VZMTrpTcffovA19cvPXN5glg6dKpgkO7tLjUSTtydHJJAF
 nc5LgadTjGa7kmedsJD3JCFE55VLSGFKu0FBiPwyS/Zxta4zajl6xQ9c7UuwqNBxKCsyX+WE6k1
 l3GFFImGADZkoFudLAERb3QhfM8ulI09Bk/wFZVU6J5iWsP9ESYMSLArA2gyYR2sjrXderdYzcr
 P4siEve4Ntp/F0mACj8ejMRDjh3gAvj6VEAYQmO/VcWD3vqV2xdBLP19v0EaVnqIECJOL8scKgm
 0Ws2xiJc70IrXA6dvWTgkvyXk2gDN5gULSTJ4dPcWAtQalVpt2SnrYh98qX54s5QFwFPnhWSPzp
 lHb6xmfQn9EC6bssf8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601290134
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Currently parts_round_to_int_normal() assumes that its input has just
been unpacked and therefore doesn't expect non-zero fraction bits past
target precision.

The upcoming DIVIDE TO INTEGER use cases needs it to support
calculations on intermediate values that utilize all fraction bits,
while at the same time restricting the result's precision to frac_size.

Delete the "All integral" check, because even though really large
values are always integer, their low fraction bits still need to be
truncated. For the same reason, make sure rnd_mask covers at least
fraction bits past target precision.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 fpu/softfloat-parts.c.inc | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 5e0438fc0b7..93ed59626e5 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -1118,11 +1118,6 @@ static bool partsN(round_to_int_normal)(FloatPartsN *a, FloatRoundMode rmode,
         return true;
     }
 
-    if (a->exp >= frac_size) {
-        /* All integral */
-        return false;
-    }
-
     if (N > 64 && a->exp < N - 64) {
         /*
          * Rounding is not in the low word -- shift lsb to bit 2,
@@ -1133,7 +1128,7 @@ static bool partsN(round_to_int_normal)(FloatPartsN *a, FloatRoundMode rmode,
         frac_lsb = 1 << 2;
     } else {
         shift_adj = 0;
-        frac_lsb = DECOMPOSED_IMPLICIT_BIT >> (a->exp & 63);
+        frac_lsb = DECOMPOSED_IMPLICIT_BIT >> MIN(a->exp, frac_size);
     }
 
     frac_lsbm1 = frac_lsb >> 1;
-- 
2.52.0


