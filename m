Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A303DC369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 16:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5SAu-00015q-1r; Thu, 17 Apr 2025 12:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1u5SAs-00015X-Cg
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:33:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1u5SAq-0008QI-Di
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:33:14 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HClLNF001236
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 16:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=iKskHlquLVRRDrGvQHLb2yX/5t7tSjk/FmT
 ZWHXkV5g=; b=LCcAVyUnA8cBf5ELS23rqLSDBtv5nw5nznHjxvbTIG2OrKdA6y7
 F97lXkr2SIZg6b1M+uRfdKxe+mSBSPP71/g4mdm4bVD2Zx8db8jSLN1ANi8/qmbg
 81OZWFGDrWK/ovRUtsOFNDpd/LA0UviIsKY4avJmq8/ExYI4EwAJ/fSj55KNWDuL
 5l/mHUGCxJUlE9B6FN5cGc0aqIF7/dVnC3wnSQUo/+Hmd/woB8jm0gBeFuoUKfmL
 GJ6QPMPNG2VaK2dZob11PlCT03V3tBS86dajvhPjkPNOTtdWVw/V0H0LstoRmMSs
 slGvEHJEjvw/BJiLK49rUD71buvE6SWonwA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ydvjfu8x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 16:33:08 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-af534e796baso582730a12.3
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 09:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744907588; x=1745512388;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iKskHlquLVRRDrGvQHLb2yX/5t7tSjk/FmTZWHXkV5g=;
 b=Sm/p6hhZDPO8QqGnORorQqscZrjzvDn57ig/jKMtyoGufVIRdqv0RODjssjQzirSzF
 Gt7N8YiOg2zPP3MIQLyh5i8/i/gPohyv2W4JTYHhDswaKxeqrN9uFrM8HeKbLnL5ykiP
 OnKENrqgtHonxoPt00VvfscN1HgmLDue0ScLAasGnmdIXoB8i4/VN0Ju6+ohd6TFDp83
 43EvGM87RsDirVowRj9mR1Ie7qsX4/3BMYceT9qXxK4+aibColLR2n8o92J9CFq9RzSo
 YgM+fwJOIqhnFzgB5tX1Dskf/1JMKwKYroFEfUWfFIOXpptglNjHTZWNMYQOzG50NKtZ
 nqMw==
X-Gm-Message-State: AOJu0Ywei2UMZnTYqQiy7+3guf0lDhMbXWHhwzjD4YuYykiDu0grjx/3
 Fnd6BWmjYOVPFSHvJkymtSn6PmaL4QBfVmApcRaoBYacW8FajRTJE8NKAk5OlkSJgbd1rRL02p1
 SU9kOoejB1SCdoYAWWmxDlcGLj6IZCF7sor0sdpvG2zLL/3P2X4eNa5rQZCdheQ==
X-Gm-Gg: ASbGncus+wMhO2lWUbOu4vYphSwu++QJxWYSp0olikrlohVGgqZvBmkSEQlplJEkP3y
 ePpbRfkR7AmYsK0G4/UFQ5udSeSljVCDGDJ+V9hC1GSYqJ4Ta7Day9CJWy1VC0X5Cq/DBx/BqGv
 pMIKWyS/bygMSgDJhEU6J1GPGuEhGuCgSHpqAuk2xL6+yAy7WDMms0zE47Ua9qmWWccQyhTdKLZ
 /HwIK+8C0ntVezCthEk/5wvdF+c8TBzY4wF8TE+u2eL3UzecVZz39eTZc0k3biMJeKjOEv0WQ9L
 0d4SwvSDMSzlKf7oXKlWK6qLvq2s8pchNv8pKcTwBkvnL3CU7/27bMzSe+rJM3uQ6ZznxpN82oY
 =
X-Received: by 2002:a17:902:ed8e:b0:226:30f6:1639 with SMTP id
 d9443c01a7336-22c359852bbmr74143345ad.51.1744907587800; 
 Thu, 17 Apr 2025 09:33:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuV0QxPUyk7U+E2sCymAG64PK/AgKw2TFyrbD2UoOskfLczf+rrJg31pgLYPRoFO75NdmOCw==
X-Received: by 2002:a17:902:ed8e:b0:226:30f6:1639 with SMTP id
 d9443c01a7336-22c359852bbmr74143025ad.51.1744907587356; 
 Thu, 17 Apr 2025 09:33:07 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bd9954sm2119855ad.20.2025.04.17.09.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 09:33:07 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, peter.maydell@linaro.org
Subject: [PATCH] mailmap: update email address for Matheus Tavares (me)
Date: Thu, 17 Apr 2025 09:33:04 -0700
Message-Id: <c3a9a81f76262637d6d7d2d70c1264a8e18fd5b2.1744907562.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZIrXmW7b c=1 sm=1 tr=0 ts=68012d44 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=j8RhgVXbAAAA:8 a=1cGLs3X8AAAA:8
 a=unkj71DYAAAA:8 a=COk6AnOGAAAA:8 a=oCJs8q-oAAAA:8
 a=KKAkSRfTAAAA:8 a=ggQks4fKAAAA:8 a=lzDhS8hmAAAA:8 a=VwQbUJbxAAAA:8
 a=gPJu0pBYAAAA:8 a=nTSLIlzuRdZbrQ7FZ4sA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=3SzYsRL22XtqO3ZTpi69:22 a=d8ghUycwObenwynNfMyN:22 a=5RyQM4v5J9L3wGZf4tZl:22
 a=TjNXssC_j7lpFel5tvFf:22
 a=qUF70SbvcHBaGhGVny9j:22 a=cvBusfyB2V15izCimMoJ:22 a=6g8pSQqS8yRHbJHhMaLw:22
 a=rigQk1bY_8VmChEzA3fK:22 a=AlIIF0cMT2hfDT4axODj:22
X-Proofpoint-GUID: bFW8D0HH8jdoPJ0J_8L3ovcKTFcPGVKF
X-Proofpoint-ORIG-GUID: bFW8D0HH8jdoPJ0J_8L3ovcKTFcPGVKF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_05,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=711
 spamscore=0 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170121
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

This is the new email I'll be using from now on.

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 33fe75400f..e4f45c6734 100644
--- a/.mailmap
+++ b/.mailmap
@@ -94,6 +94,7 @@ Leif Lindholm <leif.lindholm@oss.qualcomm.com> <leif@nuviainc.com>
 Luc Michel <luc@lmichel.fr> <luc.michel@git.antfield.fr>
 Luc Michel <luc@lmichel.fr> <luc.michel@greensocs.com>
 Luc Michel <luc@lmichel.fr> <lmichel@kalray.eu>
+Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com> <quic_mathbern@quicinc.com>
 Radoslaw Biernacki <rad@semihalf.com> <radoslaw.biernacki@linaro.org>
 Paul Brook <paul@nowt.org> <paul@codesourcery.com>
 Paul Burton <paulburton@kernel.org> <paul.burton@mips.com>
-- 
2.37.2


