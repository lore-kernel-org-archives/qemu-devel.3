Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 223F1F417EE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbv1-0001Jv-Ic; Mon, 09 Mar 2026 10:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuN-0000p6-VR
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuK-0005DD-Qj
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:35 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629DHNlk1379892
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oyQeBADyW0qoyMUDS8naoSQ9Dp2Lde4NR4pnGUjIXG8=; b=PqX+5r/cb0rndXpx
 psiBH6zlUvK0MMjbYcBv0mxfVcBGbubsAgc9iETaMVYhydinGug86znyPzFXL+yv
 VO8p00DU6VZDcXlUPfM/bKt5k8WGLL5aeuxZb7f6WdD/pS7LYmp+5zZAadLbIP2w
 wWh8BN4iXk4UrxI2kPD6s5agVY0cKbng31Tv6OoVAIw+M6ttvV7L0LrH4HDOoVM7
 A/+RxYpe5Yztd+1uj6hIo9LDSPNV07xoRRTCFer1DzzYLpQI5EKRagCahihP3xCR
 VweVMpG5kNPQK8YQYktZr1wuEUm+7FLWyRE9pEOwaSNq8ybfpMyz6f3qY4qgRd1b
 cBVXCw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csxy80a0u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:48:30 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2be2f742c46so55206825eec.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067710; x=1773672510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oyQeBADyW0qoyMUDS8naoSQ9Dp2Lde4NR4pnGUjIXG8=;
 b=I6L0FmFU2mIyUo4PfdlMp02dcrJDhiBfvhgX4gCxKuyZ3MmmrckxeNaLfmIBS24qMf
 rZ1J2nXdW+/bKkErP4ZRZ8mCU1vG633cM6dwDFDTWcFaJZ0ehsJ2Eid/D0pE5EspeQgJ
 M6dg/xczYQAlAEc68oADZU0DPDJRhXobgGqWXcuwXjPo7rRERRBuUz6tTvWs9Rn9VwIa
 N+pRAbgMCTtgD9rPZNgAEpsmQhQGK0kHXtUu4Fw+2Zk/0WK2rmpFltNTVybE8pYcxdGB
 NGe63lvZVDjicRlOXH4w6SXzwH6bKnRK4NTrVVJamZp94YynrxoScz+Y+keIpjsLAD0y
 /e2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067710; x=1773672510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oyQeBADyW0qoyMUDS8naoSQ9Dp2Lde4NR4pnGUjIXG8=;
 b=D+lf4a14dxRN8miguAMXCT8yMKgJD5s0nTjThDtFWgrvf01eyNAF93d3SvEVP2DSYA
 OcdCfCSqxcCbL0ys5q0Yq0fqiXXUyEIf+VyvMdHqvPrL6+4s4nPRsv69viYo4rQdQtOT
 TCJrxMzdymv/UEOWFHbwQSqyJeT+8Mf5pGH9X7FPtmfiOwrX171tkW5lYbYoX0M8+CjQ
 ueM+31IxmKcOIv5QMwu0UWFviXcw9diIOoH8uhazrhg0oz+RqsXQ5jXYwphUK+M1Oiuj
 ekV9itEuQztyf/g1JXNNYrccXvhnwrAzT71pOtd2qX8PavkKitmUZZhCufZzJfDFHI1O
 XyDA==
X-Gm-Message-State: AOJu0YxszNlXplEZferPkuda8XVDtX2/on9prB590bqVbm4Uxy9xv5jS
 h43GgsRsu8z7HIa/9O1CDd0trD5dCp+3CD1NXBMY/ic406kUlbUNW3EXNFGCESBzhubLe39aXdI
 7trLK1mIo4Q9hskua7m+3UZEIo++IzK4zUoLr4fmRT1PonyUWQYBp0fmX/RTs054kTA==
X-Gm-Gg: ATEYQzxprBrteN7RcTVq8SOUraxLwmBqled2vMZ8jNYOJVIMfcKjkAynQgJ8YqQR2+y
 yvwf6cHGW9S5SeVEuEXkG+EWvhTl7UNqWUQ467bHE4Q29iFxNttlQP4/EWINZVH0MeieABXpb2e
 p/EClodePR3K1sr9nxzAZ/MBzZTCWheXd62jTYx821VZdoqozme15xE+pYCSgAD59D7NRid3M8Z
 8zsWCgwYg8I/BL0VGIr9cfdNRK8iDquffuC4+4H59saZTs9JLzZ3m3CO2iEe8woP5h3hI9ATajM
 n4EfxbMXnyep7gXcHy2EOqqw9LhhOJxo9kguqA1x9iNDgyg9W0qsxw/4gpNsxDlsA/8XPDE3PHj
 JGKekAKP6Jk1SPZ+GqyT7061jT9roDOPypcWyAGignZLMGK9vkx6cD7wbE0tlxDSKT5sEHA==
X-Received: by 2002:a05:7300:bc97:b0:2ba:956e:d26a with SMTP id
 5a478bee46e88-2be4e06797fmr4648885eec.36.1773067709957; 
 Mon, 09 Mar 2026 07:48:29 -0700 (PDT)
X-Received: by 2002:a05:7300:bc97:b0:2ba:956e:d26a with SMTP id
 5a478bee46e88-2be4e06797fmr4648858eec.36.1773067709281; 
 Mon, 09 Mar 2026 07:48:29 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:48:28 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 02/35] docs/system: Add hexagon CPU emulation
Date: Mon,  9 Mar 2026 07:47:49 -0700
Message-Id: <20260309144822.877695-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SvmdKfO0 c=1 sm=1 tr=0 ts=69aeddbe cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=2pVdXvZyqgCw3DkElpQA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: duaClyn8XZfl1aQ5Hcl4yOZfI3_JXMO0
X-Proofpoint-ORIG-GUID: duaClyn8XZfl1aQ5Hcl4yOZfI3_JXMO0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfX9CQLmYlArWXo
 XjMOi3CWsnf7CFSA6SyLBEe4NRnw4PH3ZRKV8USwaebZCsTClWuqhStzwiNtr1qgw66OLDc0IlT
 Ia49uT7jBlWK9M1YlvzkjBpfwdFDALE3vWC0nC+n+BJWAi5wM8nXwEEYr1vscoujxSM1Sv8rT1Q
 ZN/gPGkrt7xtNHJWBzJ0I58RKPxClD7G9A/UGfMWFvESq3ylBFQqDHz7TZ347dmGf1tlQ0N52GD
 PT5mjtxHjV+NpFqnzNy1nTk5qxMP0rcUOmtKzl34gYMOtKQs2D2LtNfMNB/CZQGPlUj6b0YFryM
 FSVee8joi3kWSO/lsknqtRB5ef7DYdtTsjg878KvvNLi8254Bh2UVBXYd7uFBmSbAF00+Qh1B0g
 ib3LWt3qSxL3LqNQA2muet0DhrzrnyvU1bB7YxpI9hPekT3rLKf8PlNnr1s40L2NMg0e3gUEiFR
 Rqd/WTNchzoTlajrusg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
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

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 docs/system/hexagon/emulation.rst | 15 +++++++++++++++
 docs/system/target-hexagon.rst    |  1 +
 2 files changed, 16 insertions(+)
 create mode 100644 docs/system/hexagon/emulation.rst

diff --git a/docs/system/hexagon/emulation.rst b/docs/system/hexagon/emulation.rst
new file mode 100644
index 00000000000..36f54f058af
--- /dev/null
+++ b/docs/system/hexagon/emulation.rst
@@ -0,0 +1,15 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+.. _Hexagon Emulation:
+
+Hexagon CPU architecture support
+================================
+
+QEMU's TCG emulation includes support for v65, v66, v67, v68, v69, v71, v73.
+It also has support for the following architecture extensions:
+
+- HVX (Hexagon Vector eXtensions)
+
+For information on the specifics of the HVX extension, please refer
+to the `Qualcomm Hexagon V73 HVX Programmer's Reference Manual
+<https://docs.qualcomm.com/bundle/publicresource/80-N2040-53.pdf>`_.
diff --git a/docs/system/target-hexagon.rst b/docs/system/target-hexagon.rst
index 5f7084a6a08..416b8f7be76 100644
--- a/docs/system/target-hexagon.rst
+++ b/docs/system/target-hexagon.rst
@@ -98,5 +98,6 @@ is not yet implemented in QEMU hexagon.
 Hexagon Features
 ================
 .. toctree::
+   hexagon/emulation
    hexagon/cdsp
 
-- 
2.34.1


