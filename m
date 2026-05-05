Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FB8FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 23:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKOti-0005n5-KC; Tue, 05 May 2026 19:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKOtg-0005mJ-1c
 for qemu-devel@nongnu.org; Tue, 05 May 2026 19:09:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKOte-00049H-Ct
 for qemu-devel@nongnu.org; Tue, 05 May 2026 19:09:47 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645LAK4T3187664
 for <qemu-devel@nongnu.org>; Tue, 5 May 2026 23:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=34GNT8PoHzG
 XPlJBtPfctOkEmSK/n118/2PiF/yaGFM=; b=jWjqxpkbqCc/VtF4jIuCW3lQodf
 JaASzUsk5BHzQ3AX+zmP32qZcu3psIGcdLPlEg/0lvJL/kOtOK0MWfF2nlnQvOdd
 YuEOIHbzDEk5oI4bIPf2vHb/DO1DhSoWbO0pTCmsd21hDnVfeeoCctGeLcRKDLd1
 x6blSCVkCHVp7xLCFXbRsFA0W1AGAIkSSWWfPWw6oA+3sUbO8U8Kj0IVsd4P82fE
 nnP+rz/bSxqsK+tWYGb6F0Z4Hb08ToC/3YOVbWU6uOGdQ9hn/SX6zQZ7JdW37Ew1
 im4rDGfyQFO/Tt3o6f9+QIUxppIrVNmVCeOUMKbBRGkr13oJHbXwimF4Ulg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dybkkbp76-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 23:09:45 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2f485961555so1068639eec.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 16:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778022584; x=1778627384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=34GNT8PoHzGXPlJBtPfctOkEmSK/n118/2PiF/yaGFM=;
 b=gmnmZUFhwCWw+FU2CWsgN3Ku8ZovwX9qqCMY2A9GZdlGk2x3YZ1AVZnI3OKEG3sIi1
 Y8V4XKX6tCtNrNELOx+y7zrjlqJunUl8Hk6PlWx6Ju9rRhWj7OCb5QXjjH5AwreP2vfR
 zcu1x69c8gPA4TvcbNICuLr7BLFsVKdfd5o+VwKYSEhl5CNxhTSFWDfIVRT2tVTWSv8N
 vniNmOzdAPXKFXIxRJFDICWucKpoGgB0hmonFzOsWuX3/dOUZUF1/UC+bTqoMGnnlidm
 Ebng++JlUCZcnrzImxKQ3PbaITGLH3cYytO1Dyxz0YWvHuG6mhFP1ChN2PuR4Sgd7xgv
 hxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778022584; x=1778627384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=34GNT8PoHzGXPlJBtPfctOkEmSK/n118/2PiF/yaGFM=;
 b=o01X5kIK2gFR+XXXToXiVKd8c39Y2PdyncLn/MoGdATOLU9MdE8KuJTMW+NviDoz02
 DY9CoS4FIJ4AclMgFezw8uKMoacSNj+D/52kLWSUsQLTBIbIJ1fzVNbslQp/mslDDb2B
 LY6I9Qvvtewo3oRU4pp58L00kHNitORUw4C8UCMqU//F2jlCzh3ODj6+QCEzH+FKz/a6
 XcpV7AqrGczbOVkmTmL3CccKZCQiDdHmRfus0jjwJ3a/8c2I+A7y+nrmheLWtUbMRtUg
 bRY8mnX11arK4lxl25HrhjbcMLg38m32pCec0bWdHX6Vpp+Pn0sz8TbzkhmD2Swtln5T
 mnLw==
X-Gm-Message-State: AOJu0YzQwNwE6aDZDxPLIxLXYeTe8WHkasfbW4agwmVmC8xf2H8ISFnA
 jOjRigkz+6KxVUFITOnfOboth0sCKrOX/5wRMmdW2tnUxLf1IEq5A61PRJRQuzi/OUbdN6Lp1Ng
 /wqLvhuYJB4Kofo6x5uUZKikcpQel32gRO5RFdiUKk9m4EspmugTTsgijc1bhLVnB3qww
X-Gm-Gg: AeBDiesSIyV9sujvqCVBdj/rAXU2nUHmXU1SimjCynRBucfk4HJz9NtVEqf5OMKI/dg
 tREd7bnpBBj2UEeKCxLw5e3/1NJeQCrMEB9P2lzeCpvOafIaxlx5uvoeLI67bmAoawxRFny9qJ8
 N82hEDm2/7GACWQTTzakOMKqLqGPwqlDuFk03S7uIpiHhpPErONeZ9ophSN++Q4O5JZ7zNySZQ5
 oBHBrJwRF2QfG85gUIDCwuIf6RIB0NpSBiKq8gFpVyNCN8oKnxON2c4dBsz/qP7CGTrJYAeLxRD
 o5F/gXJJCDp/CQypC5rSqJeV8TI1o/jMSyI/s/L1pPOk2j+Z9BZCwlH3PxnekOpf1bg3L2cFnGQ
 lwchdbV5WF62G2bbk5RwfQJhMMPbYFQ9I3OrCfd7bNDcyghYgtFozemla6+Fy3jYptPSnieQh9w
 /Sga1LhUjTMrhq3j1N
X-Received: by 2002:a05:7301:3f07:b0:2ed:e17:d50d with SMTP id
 5a478bee46e88-2f54aa86739mr762368eec.32.1778022583930; 
 Tue, 05 May 2026 16:09:43 -0700 (PDT)
X-Received: by 2002:a05:7301:3f07:b0:2ed:e17:d50d with SMTP id
 5a478bee46e88-2f54aa86739mr762348eec.32.1778022583301; 
 Tue, 05 May 2026 16:09:43 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f56f891a56sm991137eec.14.2026.05.05.16.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 16:09:42 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/1] docs/devel/codebase: add link to rev.ng video series
Date: Tue,  5 May 2026 16:09:33 -0700
Message-ID: <20260505230933.2712543-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505230933.2712543-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260505230933.2712543-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDIyNSBTYWx0ZWRfX8hLDLX9zVQjS
 fBNga4Vzfnv/tiC7r36pF23WCSVOn48BfC01E2/XBg/goQ6K+jYU8g2BTWI+wQBYT5t39XQzxY4
 HYzLwImFp21m7TRGpK5NcpsGrL4bZySLI9+jrREsyUQmjrZ9STcHXSk/822XQ1lJeWdefBeINSC
 jU1Sc0ODoZk767t443MdeAD/uOoqFIBsCGlLp0K/z+svjH3rFGtrkZx/K5xEuKn8FoiNnwqNMCl
 iQxrzBYBFnuN1ejVIKo4Yk9ybKC962vpGzVCySV0jLD+3ju9qQR61vF6PhN5Tc3aGDJZ/vAdlrF
 XUJeEjp76Kne3qYm6b6JIzDHT191JrGEkYkWVKE5ps8ij53Xaeqv1BTedFs5MYIbX7KCHdGjOYo
 AY0grkjGEvOvsLOS2hicha+4kkzEJvt3PRSLrJM6Z1Uw0ckZsGk3GNs1jO4aiDk3fwcXoxf2oci
 v/I4hll3M6nswsszgrw==
X-Authority-Analysis: v=2.4 cv=SPBykuvH c=1 sm=1 tr=0 ts=69fa78b9 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=vnREMb7VAAAA:8 a=BFbAF7SdUxoGnZdPjq4A:9
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: TypHyMnwHCtAHpYy4H7mY3aEwtzo-eU9
X-Proofpoint-ORIG-GUID: TypHyMnwHCtAHpYy4H7mY3aEwtzo-eU9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050225
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

Those two videos provide an excellent introduction for a new QEMU
developer, and such resources are rare.

Kudos to Anton Johansson <anjo@rev.ng> for creating this.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260423213557.780112-1-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 docs/devel/codebase.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/docs/devel/codebase.rst b/docs/devel/codebase.rst
index f09307b8971..f065d7eee0b 100644
--- a/docs/devel/codebase.rst
+++ b/docs/devel/codebase.rst
@@ -8,6 +8,11 @@ organized.
 Beyond giving succinct descriptions, the goal is to offer links to various
 parts of the documentation/codebase.
 
+Those two videos are an excellent introduction to QEMU codebase:
+
+- `QEMU Dev Starter guide - General overview <https://www.youtube.com/watch?v=OCBLTMKLGAk>`_
+- `QEMU Dev Starter guide - System mode <https://www.youtube.com/watch?v=jrZ56K3Sl_k>`_
+
 Subsystems
 ----------
 
-- 
2.43.0


