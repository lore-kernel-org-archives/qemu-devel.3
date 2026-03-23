Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F1EF46101
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:16:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4f8Z-0000Fw-4d; Mon, 23 Mar 2026 09:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w4f8R-0000E2-OZ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:15:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w4f8P-0000Kw-8N
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:15:59 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62N7X6PN3240094
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 13:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mRl0tEPmSml
 8N9vbVqFqWQaoiaqMFhuvOGyu/2fAPQE=; b=RPus7hbPDK7qFSn+U16PjwY6L9k
 2WMAiTS9BoHKcSkpv47iVxSfq8Pf7VddZfsG7Wb6VBWQBguym7JWpvCWxcQ7tla4
 y5xMFhXVNnbcNdB6Iw03IQhqg51R7ASffCzy6CA9FntLKXtvfGkMF41uUbGYMqYv
 1GHoMCgMtrO1lcnTWAzyLCB2276wNt1je1SBKZdd/NfibQQSmTxZmcow69QmPCBj
 djdYnqMfBPmwKX0XvFByKYVNvm1Kk8cpgxZ9iNdvHIEjbgBsUyS0KWlRPBX34Jiu
 aSIEXOicjM4az8HFUpOgU4eNFKOm8XvUnRq1yPzFuGA7J3WOXkLUrwqKMLg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1jng5fv7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 13:15:56 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2ba9a744f7dso3189442eec.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 06:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774271755; x=1774876555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mRl0tEPmSml8N9vbVqFqWQaoiaqMFhuvOGyu/2fAPQE=;
 b=B/gNupjkqGF86OrmaOMaSfblKYMSTB3xHkNt6smzvEdVAyF5AyoKyPk35+eJhQBsgO
 WFQW3kTSwEoh/rMpfofl5b1hINOHDxFOpIWRspGTS56a4WHc0Zh54DeTU8miC7kd2RsF
 isLpLpNiMCVxNJCQds1jE3IvkvdV8S/pq0IrmA6Erm1vEQpumx1OXT/fYz3xnRga5q98
 vAD18zRjr//Evd8BTOxt9Wn9zKYmkwhBJN5ap3/6KjElF3jRAXL0gPsaYbZTp72rKypu
 cFqW+eEPBrCLjp50Dc0n/lD4biAej2qHlwgZG/gCJVIWyMb4Q5o8Di0IQzzQIbwzQK5T
 vJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774271755; x=1774876555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mRl0tEPmSml8N9vbVqFqWQaoiaqMFhuvOGyu/2fAPQE=;
 b=IOg+nhmy30hW1thYWd1dpy5rW6m3bl+MpCuekottQ93oZRmoWVGaFdAFZAblwlLn8c
 0ZGCKmIgoBNvAh8/cxqtjIs72tGbR1mJdNQD2jFIBdneWNW4OjYRAMq4gcCdyFD+qwXo
 z76W9LCVB4ehJUBdvaR9+1N6Tv5atUpfxwAENiJSUtpM7Ka0nM4X0BZNqXhpS6T3jlq9
 KI34yFaRTXAyVxxtI/r1xahhrocH+ziejkpyIsWWkPDUKxZ0JeB0v+ViFdL2ISr/KXqF
 VqwMzy+LQ+qS7cLTuhoqOlZtwdAlqkTVa0lakJ2qCgfEtQj53YLIKfpSdt2eek7WBfpo
 Whog==
X-Gm-Message-State: AOJu0YxGqx3AfKVUSN0BnFaAjM5I2T4hVwt0/xzQEcSDh1aCsMwhEmtg
 n7iSYalQFgnpMsQQAyySCHcLOtmQwjJI+dURFH9Ui9r/K9Bm3qrHjBb4b2HGKNkShMiFq2ImD/q
 FvSUFrxv9iygUiHEa884MrOnH3BbeOoDGpes2g4hJPmMx7w9LTRFljwPA1li2i5jSRyTH
X-Gm-Gg: ATEYQzy0+U5aunqH2fYS4nVYwDtP1Q/79kQQa/dr9n4xotI7gOemD1IU88m/V/blwih
 73u4QQi2Gbjr+k8lMmeCZL/dufPJ2APJvvQcSDNMZoiK40hPdowyvEwpUDrS0pQqPLtyu27mMPt
 0be7iUDIEGZNfGGXNHS3d5jeSHMLHfcR8Ck3v29Zkeaob3KsyiS1wcJe3PaqDFRl9g7+UT3pUx/
 8iO/gwmOZWOlXmPY8Upet0hQkeuShdS49zJqAnWTs1Hgte8EIrckoGZTrbrCStiOoRygYIrWDyL
 uhbHgOjVTXSy9o5kh+A96J9Iu37mtoUOCy/nVAE3Lj4E1JJRE/Ne7ZCjo0/5VZcX21IlRVn93VC
 HarY3dibsDBsxtVv0fYQdz3o0WeU1oN+PrCBst83DdjVqeQo96cL95ZX5KYkjwGqrJNzl12f+AE
 CyCCPclZGX
X-Received: by 2002:a05:7301:290a:b0:2be:6f30:fa7c with SMTP id
 5a478bee46e88-2c109755a09mr5406593eec.16.1774271754585; 
 Mon, 23 Mar 2026 06:15:54 -0700 (PDT)
X-Received: by 2002:a05:7301:290a:b0:2be:6f30:fa7c with SMTP id
 5a478bee46e88-2c109755a09mr5406551eec.16.1774271753697; 
 Mon, 23 Mar 2026 06:15:53 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b14cadbsm14702574eec.3.2026.03.23.06.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 06:15:53 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com, marco.liebel@oss.qualcomm.com,
 philmd@linaro.org, quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH 02/13] target/hexagon: fix incorrect/too-permissive HVX
 encodings
Date: Mon, 23 Mar 2026 06:15:38 -0700
Message-Id: <dee3cd0407272dacb1ac617e6179943168fb0691.1774271525.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 66sN7EzMRAnO0YD0YTPEhcJEykHJzyzH
X-Authority-Analysis: v=2.4 cv=Q63fIo2a c=1 sm=1 tr=0 ts=69c13d0c cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=LtKSMYrkcOpncNoavBoA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: 66sN7EzMRAnO0YD0YTPEhcJEykHJzyzH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEwMyBTYWx0ZWRfX2o2/5C7g2nTF
 RbSD18YX+vp3nMWI2+W7xY4Eu4o6Fiui8bIaIgiiRJiLw/++X/F0tPAsTzJdGYICew5SabjxVsu
 RC9nsHYkYx6jdvVcU/RkwqXyL0UV21PAFbFD9+ySVlTmZw8ShB4McJ8qecpwKSD7aCHwCFN6o9I
 IGut6u++tu2fWL/uVWzZg4m7v1+3ddnxcxSitAvnaqZE/d84AIldio/0QTrPfff6uL+xnzZeCpN
 ldUXBJyDqd+PCZEGukOSTS/cZtwg3HtDeqNSNk2O4ykpE0fU66VQPuKegppHq/QmQdPLotrNYQ/
 dEolAd0LkZuxiQN0hDI8GFK4co6enxAgG1vPkzJamDnT3jJ913bQyqhFAv8wX6Z5PEFvRF8px89
 AGlJ9aVf+lcCF1GYJg+Mf6V49BG/Nxxl5Tl7/xgr51qidh9WjSFMUq1RsHNMZPYm07tRQ55Il8K
 TqPDee0Ytn5CDZVmsDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230103
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The following encodings have become stricter since v68:

    - V6_vunpackob, V6_vunpackoh: ---00 -> --000
    - V6_vaddbq/hq/wq, V6_vaddbnq/hnq/wnq: ---01 -> --001
    - V6_vsubbq/hq, V6_vsubwq/bnq/hnq/wnq: ---01/---10 -> --001/--010
    - V6_vhist, V6_vwhist128/256, V6_vwhist128/256_sat: ---00 -> --000
    - V6_vhistq, V6_vwhist128/256q, V6_vwhist128/256q_sat: ---10 -> --010

Pre v68 compilers, by default, already use "0" for the non-specified bit
that changed in v68, so unless someone is manually writing the binary
encoding, this should not cause any backwards incompatibility with
pre-v68 binaries.

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/imported/mmvec/encode_ext.def | 48 ++++++++++----------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/target/hexagon/imported/mmvec/encode_ext.def b/target/hexagon/imported/mmvec/encode_ext.def
index 402438f566..6d70086b5f 100644
--- a/target/hexagon/imported/mmvec/encode_ext.def
+++ b/target/hexagon/imported/mmvec/encode_ext.def
@@ -647,36 +647,36 @@ DEF_ENC(V6_vsubububb_sat,    ICLASS_CJ" 1 110 101 vvvvv PP 0 uuuuu 101 ddddd")
 DEF_ENC(V6_vmpyewuh_64,        ICLASS_CJ" 1 110 101 vvvvv PP 0 uuuuu 110 ddddd")
 
 DEF_FIELDROW_DESC32(        ICLASS_CJ" 1 110 --0 ----- PP 1 ----- ----- ---","Vx32=Vu32")
-DEF_ENC(V6_vunpackob,         ICLASS_CJ" 1 110 --0 ---00 PP 1 uuuuu 000 xxxxx") //
-DEF_ENC(V6_vunpackoh,         ICLASS_CJ" 1 110 --0 ---00 PP 1 uuuuu 001 xxxxx") //
+DEF_ENC(V6_vunpackob,         ICLASS_CJ" 1 110 --0 --000 PP 1 uuuuu 000 xxxxx") //
+DEF_ENC(V6_vunpackoh,         ICLASS_CJ" 1 110 --0 --000 PP 1 uuuuu 001 xxxxx") //
 //DEF_ENC(V6_vunpackow,     ICLASS_CJ" 1 110 --0 ---00 PP 1 uuuuu 010 xxxxx") //
 
-DEF_ENC(V6_vhist,            ICLASS_CJ" 1 110 --0 ---00 PP 1 -000- 100 -----")
-DEF_ENC(V6_vwhist256,        ICLASS_CJ" 1 110 --0 ---00 PP 1 -0010 100 -----")
-DEF_ENC(V6_vwhist256_sat,    ICLASS_CJ" 1 110 --0 ---00 PP 1 -0011 100 -----")
-DEF_ENC(V6_vwhist128,        ICLASS_CJ" 1 110 --0 ---00 PP 1 -010- 100 -----")
-DEF_ENC(V6_vwhist128m,        ICLASS_CJ" 1 110 --0 ---00 PP 1 -011i 100 -----")
+DEF_ENC(V6_vhist,            ICLASS_CJ" 1 110 --0 --000 PP 1 -000- 100 -----")
+DEF_ENC(V6_vwhist256,        ICLASS_CJ" 1 110 --0 --000 PP 1 -0010 100 -----")
+DEF_ENC(V6_vwhist256_sat,    ICLASS_CJ" 1 110 --0 --000 PP 1 -0011 100 -----")
+DEF_ENC(V6_vwhist128,        ICLASS_CJ" 1 110 --0 --000 PP 1 -010- 100 -----")
+DEF_ENC(V6_vwhist128m,        ICLASS_CJ" 1 110 --0 --000 PP 1 -011i 100 -----")
 
 DEF_FIELDROW_DESC32(        ICLASS_CJ" 1 110 --0 ----- PP 1 ----- ----- ---","if (Qv4) Vx32=Vu32")
-DEF_ENC(V6_vaddbq,             ICLASS_CJ" 1 110 vv0 ---01 PP 1 uuuuu 000 xxxxx") //
-DEF_ENC(V6_vaddhq,             ICLASS_CJ" 1 110 vv0 ---01 PP 1 uuuuu 001 xxxxx") //
-DEF_ENC(V6_vaddwq,             ICLASS_CJ" 1 110 vv0 ---01 PP 1 uuuuu 010 xxxxx") //
-DEF_ENC(V6_vaddbnq,         ICLASS_CJ" 1 110 vv0 ---01 PP 1 uuuuu 011 xxxxx") //
-DEF_ENC(V6_vaddhnq,         ICLASS_CJ" 1 110 vv0 ---01 PP 1 uuuuu 100 xxxxx") //
-DEF_ENC(V6_vaddwnq,         ICLASS_CJ" 1 110 vv0 ---01 PP 1 uuuuu 101 xxxxx") //
-DEF_ENC(V6_vsubbq,             ICLASS_CJ" 1 110 vv0 ---01 PP 1 uuuuu 110 xxxxx") //
-DEF_ENC(V6_vsubhq,             ICLASS_CJ" 1 110 vv0 ---01 PP 1 uuuuu 111 xxxxx") //
+DEF_ENC(V6_vaddbq,             ICLASS_CJ" 1 110 vv0 --001 PP 1 uuuuu 000 xxxxx") //
+DEF_ENC(V6_vaddhq,             ICLASS_CJ" 1 110 vv0 --001 PP 1 uuuuu 001 xxxxx") //
+DEF_ENC(V6_vaddwq,             ICLASS_CJ" 1 110 vv0 --001 PP 1 uuuuu 010 xxxxx") //
+DEF_ENC(V6_vaddbnq,         ICLASS_CJ" 1 110 vv0 --001 PP 1 uuuuu 011 xxxxx") //
+DEF_ENC(V6_vaddhnq,         ICLASS_CJ" 1 110 vv0 --001 PP 1 uuuuu 100 xxxxx") //
+DEF_ENC(V6_vaddwnq,         ICLASS_CJ" 1 110 vv0 --001 PP 1 uuuuu 101 xxxxx") //
+DEF_ENC(V6_vsubbq,             ICLASS_CJ" 1 110 vv0 --001 PP 1 uuuuu 110 xxxxx") //
+DEF_ENC(V6_vsubhq,             ICLASS_CJ" 1 110 vv0 --001 PP 1 uuuuu 111 xxxxx") //
 
-DEF_ENC(V6_vsubwq,             ICLASS_CJ" 1 110 vv0 ---10 PP 1 uuuuu 000 xxxxx") //
-DEF_ENC(V6_vsubbnq,         ICLASS_CJ" 1 110 vv0 ---10 PP 1 uuuuu 001 xxxxx") //
-DEF_ENC(V6_vsubhnq,         ICLASS_CJ" 1 110 vv0 ---10 PP 1 uuuuu 010 xxxxx") //
-DEF_ENC(V6_vsubwnq,         ICLASS_CJ" 1 110 vv0 ---10 PP 1 uuuuu 011 xxxxx") //
+DEF_ENC(V6_vsubwq,             ICLASS_CJ" 1 110 vv0 --010 PP 1 uuuuu 000 xxxxx") //
+DEF_ENC(V6_vsubbnq,         ICLASS_CJ" 1 110 vv0 --010 PP 1 uuuuu 001 xxxxx") //
+DEF_ENC(V6_vsubhnq,         ICLASS_CJ" 1 110 vv0 --010 PP 1 uuuuu 010 xxxxx") //
+DEF_ENC(V6_vsubwnq,         ICLASS_CJ" 1 110 vv0 --010 PP 1 uuuuu 011 xxxxx") //
 
-DEF_ENC(V6_vhistq,            ICLASS_CJ" 1 110 vv0 ---10 PP 1 --00- 100 -----")
-DEF_ENC(V6_vwhist256q,        ICLASS_CJ" 1 110 vv0 ---10 PP 1 --010 100 -----")
-DEF_ENC(V6_vwhist256q_sat,    ICLASS_CJ" 1 110 vv0 ---10 PP 1 --011 100 -----")
-DEF_ENC(V6_vwhist128q,        ICLASS_CJ" 1 110 vv0 ---10 PP 1 --10- 100 -----")
-DEF_ENC(V6_vwhist128qm,        ICLASS_CJ" 1 110 vv0 ---10 PP 1 --11i 100 -----")
+DEF_ENC(V6_vhistq,            ICLASS_CJ" 1 110 vv0 --010 PP 1 --00- 100 -----")
+DEF_ENC(V6_vwhist256q,        ICLASS_CJ" 1 110 vv0 --010 PP 1 --010 100 -----")
+DEF_ENC(V6_vwhist256q_sat,    ICLASS_CJ" 1 110 vv0 --010 PP 1 --011 100 -----")
+DEF_ENC(V6_vwhist128q,        ICLASS_CJ" 1 110 vv0 --010 PP 1 --10- 100 -----")
+DEF_ENC(V6_vwhist128qm,        ICLASS_CJ" 1 110 vv0 --010 PP 1 --11i 100 -----")
 
 
 DEF_ENC(V6_vandvqv,            ICLASS_CJ" 1 110 vv0 ---11 PP 1 uuuuu 000 ddddd")
-- 
2.37.2


