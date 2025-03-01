Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E689C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFOL-0004Mx-J2; Sat, 01 Mar 2025 00:28:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFOF-00040e-O3
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:55 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFOC-0008Bf-Sl
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:55 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213JRpA016337
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XaaZHguGE2oa0W2yRBp1qEcys7Sm84FgTtqAr2wjTTo=; b=RYtVT3KVCk/Q7PCJ
 beMhP5QamGlF1XGIHLATvtAJxCPxqha6WEFqSHJSkpgd1Igwi+5M1DDZkJ9dQ1ar
 ZVUhwZLWMPgM3ZZ6Kbjfe5gkrvxmic2u6N5q/vfbPWJbkzJaPqmGL+1PkzGJAinC
 qc1zEPlCMGN7VVYucwIKREknT5P0R97YGUJg5L9L291oXF1+AbxnX76vpBOENv6F
 2hNLMjE5k9AIYbjgV2X183t920iErpcvD2BkAffKPGajOdHx+I0yWWsHZAdUrD6V
 HJ0nbMeZNeMgfYSaiOGdVUlS5NYFjJF3q8hA7dT7CVl1eXEoDHgsrZ3dTk39n7+d
 UxKS3g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t7hr68a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:27:41 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2fed5debb85so748581a91.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:27:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806857; x=1741411657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XaaZHguGE2oa0W2yRBp1qEcys7Sm84FgTtqAr2wjTTo=;
 b=rNv7V8uKmqAnZBOETMTW4Is/YMG1E8u+1ZFeFi9oj7dECoJCbdjadHZ5Fh4hYYuDeo
 F2xT/OvbgbF2fgSQGT7E5RxR5rzfM77LZR6wPB6rIXtJKjJyAt4IORqcvYCCIAtp6XzD
 w308sjQuDFCS27ZRj5CQI7uksJYCYXl7Tb9mtC/MvsSgfclXKD4m/mqVFQEqCoNz9560
 tZv/ef+D+OUhPvCh1u0r4UtB+Pof7JqMskAsocg3RNg34nBMmHzJ6F/rm1YmDVtP2D6l
 BRzYf9DfmgVr5uDECQr7JCpbVVAQLUUD4BCM0eW1Ul5HbHqTfSAG9KUFkj17w8qnouFA
 eFjw==
X-Gm-Message-State: AOJu0YxxkAwa8H+59tiCEpUv9xKlRLYQAvlVPB3jUgyb8EbvtlusOD+R
 p/HVyQg2uaovC2bnPL6V1SWsZ0vuMeRJF1wryQk/BnSDBSujNdJmfaTiF3Yfw1g01R6ZZ4OZ/zY
 Mgk/+ju9AdgFZcXqB2PkHN0jUavPVckAg1F0NRlIWue9WHTZURrnNoXIpRkyukA==
X-Gm-Gg: ASbGncv/rEzRnEN0vZ8ef3Y1jtsK9oIn22rfGycNlDqaFd649davtN8VG4kCKqJK+Zo
 P+FpQVtCHgwXACMrQo4cMFkL8hEvX5vpD9yQT7rL3G+IUHSrOcdUlh+yrkmWCZmFyiCR8eWM72T
 qSuHSw6lh7JvcUoPdO2Ky/ZxuTh9eo03ccoOp4YAuyXBd+Fn8DM8cb6m3d0h+cIm7KqXuLogW5N
 N3PS4OAp+lqd1CoSzvtCflR786BiB7Shrdj8lUhHus66zzbqAXdvu33MqgAhTOHJoRHO4J9mTN+
 FSSXhpNWt8fs1kHKkwvF2JY0vMW6ItNcNKcKMnhqbQQIOKYmWZ7usOQcL3amFfUJ
X-Received: by 2002:a17:90b:1ccb:b0:2ea:356f:51b4 with SMTP id
 98e67ed59e1d1-2febab3e1d8mr9691549a91.13.1740806856947; 
 Fri, 28 Feb 2025 21:27:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8Siqess9MS+68fepLdDKKu8VjQe0k5xf8iez+R5YH2qLTO/Un3OCICJfwekfY5KriBchy8A==
X-Received: by 2002:a17:90b:1ccb:b0:2ea:356f:51b4 with SMTP id
 98e67ed59e1d1-2febab3e1d8mr9691528a91.13.1740806856637; 
 Fri, 28 Feb 2025 21:27:36 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe825bb346sm6930596a91.18.2025.02.28.21.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:27:36 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 37/38] target/hexagon: Define f{S,G}ET_FIELD macros
Date: Fri, 28 Feb 2025 21:26:27 -0800
Message-Id: <20250301052628.1011210-38-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: TeA-UR-ePvbWH3ICPu4bw5emwreTlhIs
X-Proofpoint-ORIG-GUID: TeA-UR-ePvbWH3ICPu4bw5emwreTlhIs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=611 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010040
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
bWFjcm9zLmggfCAxMCArKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL21hY3Jvcy5oIGIvdGFyZ2V0L2hleGFnb24v
bWFjcm9zLmgKaW5kZXggYjBlOTYxMGQ5OC4uYWZiYmU4ZTI2NSAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vbWFjcm9zLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vbWFjcm9zLmgKQEAgLTY0OSw2
ICs2NDksMTYgQEAgc3RhdGljIGlubGluZSBUQ0d2IGdlbl9yZWFkX2lyZWcoVENHdiByZXN1bHQs
IFRDR3YgdmFsLCBpbnQgc2hpZnQpCiAgICAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2luZm9b
RklFTERdLndpZHRoLCBcCiAgICAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2luZm9bRklFTERd
Lm9mZnNldCkKIAorI2RlZmluZSBmR0VUX0ZJRUxEKFZBTCwgRklFTEQpIFwKKyAgICBmRVhUUkFD
VFVfQklUUyhWQUwsIFwKKyAgICAgICAgICAgICAgICAgICByZWdfZmllbGRfaW5mb1tGSUVMRF0u
d2lkdGgsIFwKKyAgICAgICAgICAgICAgICAgICByZWdfZmllbGRfaW5mb1tGSUVMRF0ub2Zmc2V0
KQorI2RlZmluZSBmU0VUX0ZJRUxEKFZBTCwgRklFTEQsIE5FV1ZBTCkgXAorICAgIGZJTlNFUlRf
QklUUyhWQUwsIFwKKyAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2luZm9bRklFTERdLndpZHRo
LCBcCisgICAgICAgICAgICAgICAgIHJlZ19maWVsZF9pbmZvW0ZJRUxEXS5vZmZzZXQsIFwKKyAg
ICAgICAgICAgICAgICAgKE5FV1ZBTCkpCisKICNpZmRlZiBRRU1VX0dFTkVSQVRFCiAjZGVmaW5l
IGZEQ1pFUk9BKFJFRykgXAogICAgIGRvIHsgXAotLSAKMi4zNC4xCgo=

