Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342C8F417EE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbun-0000vD-Lh; Mon, 09 Mar 2026 10:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuQ-0000pH-BA
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuM-0005DM-OM
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:36 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6299d4Ao2332397
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wSssiVBzS2+X4CJlLfz4Zk+nOQJzPosKBp+OnhCFU84=; b=gCVPBCmm1W9gSImP
 XlpPCViSMEp4jtVVJSbbrgv7iIJmI7B08Z+kZJl/F6e6WvmLxSVX2pjKEqDNe6S9
 IRiShfQSMSpqJD1MMFKIqb5r2Nt0/CtfOdPKQjlOQoR0o1s1UOPjiBLQWGKM+nFJ
 JhFpGB0mKY2CcMEG39gNwu0BrHHBC1cz6mmukCa6YVC4FWWm6ZUvlIGhdk/Fgn2N
 oIiCZG8Dw9sVmPcCOP5JCLK0zQbbTg0XVXAg8AUt0wiGUy+GzQAv8/JCia3UzlTN
 YtexSzLqZ8LOUCVPa8CcMY00FyerGHtXvZsresnPVAWc3wUlNVpKEXqz2OlER4nn
 A20BYA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4crd6fdr5j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:48:33 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2bdc1b30ac8so47868963eec.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067713; x=1773672513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wSssiVBzS2+X4CJlLfz4Zk+nOQJzPosKBp+OnhCFU84=;
 b=d0yKq+SgEbXRJ6YglD3DQa+m2cqtyCPBpG3ilE6Wr7kWt9fq3i2kIY2CAxzvAq26lI
 bGuze+ZxC2KvNordr9sJEGy7LAfo3x11kOgD7zV144zFW8ftdCqw5XpE56trMR+H3pmR
 EC9kY06mUUObIsGuFMzluHp8S+2rKeU/tNZXLRCxfLaCdqT1VOobYFo6KXSopjK2Rm41
 c4bHXIbukjffDUchgy9U2n62X92gt6WeKQ3ig5TrI4PDEWsCRsOzH1z+KQtHHbrOUqLT
 QTsb24QL/Su0hI30E9e/T3/8MZhYxatZ6SaflAODKCarbumFdfGAESRiY1hoSPhaY8s8
 vH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067713; x=1773672513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wSssiVBzS2+X4CJlLfz4Zk+nOQJzPosKBp+OnhCFU84=;
 b=izhZz6e4pDKdYUkPR5EkvvulnaOS5gc6JGQCiJECDJge3XJNpLhkASAhrXPiITJzlR
 TcPqxNeA7/T8TCs53GpeXhs94NgfuRE7EVH2aTewswWu1VDfongOyc34aA9d4rw/2FP1
 LS9uaRsiBYLfuzZdsy/42YQ9v8Dof17oygWmh/6q//IzLMUANj7QgP8ioj+SRKDewVdk
 gRkG/tVFwdgUDvuiArBCL/2+MRLIe/baXRkMebC0931T+guGrLrSMof4MV+u46cX5Zp2
 rdGn30KMhGv5u6tvMMrS4TCoeWJ8fUcr6bIpSahlhToslXq0XlBTNRAGMOnw7Xw7ipD/
 46Mw==
X-Gm-Message-State: AOJu0YzePqRsp/UlsTaqutFsiAC9SdfdSdOcq19o+iev02Y/KSVh3avT
 TuqaBD7oeUuya6MTsel7gIp0o+r7lEMQxZfhemcySMvJEIxxSoCmowApJPM/x9fJHdM5H+8py9H
 UVabIf1DD2YVoQoOr289KQ/iOnZjpe3DBYEveStHorYqS61UzqiDJEieF0Mkk5t8KmA==
X-Gm-Gg: ATEYQzwqsi60n6S017sV33KNxsvyGwK4D9xBXNTWiceqLtZ/6Mkd8CDTtZ2/+tOFlkl
 +SsvUtFEHDdIWSxmOgWQ5NHt/CtwXxnBZXkMSRDhUM9rhVZdy04Kb4zETk/m+h9TKNO1ckodb15
 PvnvmvMYcMD+fS0r2ZQIi5u/D1K09tfm7ZYGGM4TLJvsp1oSNtzXt+Yh5qF+JiRdeOFlbGVW1RZ
 qwsyerwKhx+l5h9T4kd+l9u/WQ8l8nFQna5upmLjtWD5CtAnAaVeZ3RNGkPL6GB/zBfbHI/+Mto
 UllQIekIITeGORcJjxDmd3nwPAWRR3A2h1FdKnzfMf2Va0Y5CiBHTPWhBFZhY40ZEcXHBxfFwmq
 +fBcWJ0nv9WbW0RY4hrhTbsw+n/tumP2XPEdE0q9F/qFDW9ajPAeITp/4oMxWYZUigYSqSw==
X-Received: by 2002:a05:693c:3104:b0:2b8:26b8:3444 with SMTP id
 5a478bee46e88-2be4e065b0fmr4802666eec.19.1773067712583; 
 Mon, 09 Mar 2026 07:48:32 -0700 (PDT)
X-Received: by 2002:a05:693c:3104:b0:2b8:26b8:3444 with SMTP id
 5a478bee46e88-2be4e065b0fmr4802641eec.19.1773067711949; 
 Mon, 09 Mar 2026 07:48:31 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:48:30 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 04/35] target/hexagon: Add missing A_CALL attr,
 hintjumpr to multi_cof
Date: Mon,  9 Mar 2026 07:47:51 -0700
Message-Id: <20260309144822.877695-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: sdd_iqS4X8cXyQLin2Gt9ONvJai9fx7_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfXw0UdccSX34ol
 MzyRkGhVKuTz3jeazlBejYNQ6QGnZ7EJGc/OeNTRZrXinbSEWBhiVkZu4wn1lOAB/LSUs9SVHsv
 ouNNceuy+HsK7UrHtjxQNvq8C8Zx7CqvsZOMH2m/la5vSYEgeMzOrLCKfauufiMAaFFPCutcyhJ
 FS3MzMnsDVoR/Jc9t4wEqOtIB+Iq9uoOmP+KLfuoiDCAp+JfeaSIHQ4o3zjKEYIWH9TsLXJPPdz
 A5rRYVqQrE7ZsrtonaY580wD8Oy+th2HxfTnLXvUOgVoNhxEowSZQ66iA76e0z+BGuf+419bOHx
 pdMFopyyBrJ0tMQQYEhwpMhjfsYG/W6aG4TfMwkHLBBo+5qcMiR0jN4Z5ld2gb97D+pzB+5ckzL
 pYJCz+/Elw4MGi60eGBZg8LRUbiVd4L3U9GLUmDFaWyJYRCu3AJIe7GxX5XH7WerEniktote59b
 MZWVrg9tidkh8vRhaOw==
X-Proofpoint-GUID: sdd_iqS4X8cXyQLin2Gt9ONvJai9fx7_
X-Authority-Analysis: v=2.4 cv=RP++3oi+ c=1 sm=1 tr=0 ts=69aeddc1 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=QFI6e2jESK29WoJ26_YA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090133
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Brian Cain <bcain@quicinc.com>

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/hex_common.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index c0e9f26aebe..002afcdb9e3 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -247,7 +247,9 @@ def need_next_PC(tag):
 
 
 def need_pkt_has_multi_cof(tag):
-    return "A_COF" in attribdict[tag]
+    if attribdict[tag] & {"A_JUMP", "A_CALL"}:
+        return tag != "J4_hintjumpr"
+    return False
 
 
 def need_pkt_need_commit(tag):
-- 
2.34.1


