Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280CAC36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 15:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1odH-0004yk-PS; Mon, 07 Apr 2025 11:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u1odG-0004xV-BW
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 11:43:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u1odE-0002fa-M1
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 11:43:30 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378dqBF013349
 for <qemu-devel@nongnu.org>; Mon, 7 Apr 2025 15:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 x7OQYxWqO/Klv3aLxEoeizMJ+O7vvC2qHk9AaZLiBHw=; b=Kv0h4NeZKGCW5wb6
 /P9aueKHl06mazW35XV02kVgFEnDMHgIU97PjjRhVNvqOrP6hkOznJB4WgsARalV
 hzRiMc5qSk23x8vTd6dC3+9KGsLUjI49fbrBNAbZ9c8/JyDszOwPaUzqVLbOtZ5O
 8QnpCS86an7VsiNi9MCjeCUTi2YqsZjdKSsqzCKPOYJjdgm84Vt+cP7mYXXwZssH
 cOCOnPZsrARQF2MS4JaCP8AuNXVw0bx4GSXIIoio2wbOqIhz5MDFnpm6+WXNhtQW
 /k9+9Aluq1qhaQA67oClzDDdZDifEJw6kydva8yDKRnXIOa1ny88tPm8/MeXNrIS
 I8wmdw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twc1cnma-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 15:43:27 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-736c1ea954fso2373903b3a.3
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 08:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744040605; x=1744645405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x7OQYxWqO/Klv3aLxEoeizMJ+O7vvC2qHk9AaZLiBHw=;
 b=AuZy/6ucCsAMGM+ubA8WFcV3CVuByBqZqq2tuAi/Aku1qpYBIKf/rSXwu2RkU7BIn8
 FLZqYOqI9u76AkGuJu76ENlx7Ae9OzQUl5tIhiaED9B8HjOYU5EwPI/sHGWq+exPkKGT
 wEPW3UZLdKYJLV44euCd5MN9Oxl93bkH6Ee37hNlNtf+oabCi6weIHmowAInDVs3fTyX
 4gUFKZmYceFZ4itfop5ll9DsiJBB+BkjGQGxYR5WAUXG/2M87/L9L8aCzp6nRuLOlVMd
 n0Fbj/gzwEFhzC4kT1rDf5+RQ+Kql/MSok125cz5eKUw++iGyvXG19g5fJYDFaskkmsh
 I9Xg==
X-Gm-Message-State: AOJu0YxzScDZf7e7cBb3NNJ5PXDI8H5EFmewDjv13XFQFRitwFVaU+rh
 PGdH3DNtmb+1CaSleswrG54qq36LBDHe0MFgeyTkv4QtlfEHPX3ExMbTOupH04FtVjYW14thWmc
 lAX3xzQUDds2j/JkKeJO3NmokVJCY7eXg4Yp4DTNBWplfVxyPvxi0BrkqOMpMSA==
X-Gm-Gg: ASbGncvudy8OY2OFYWJtYp1CUEdWByFedWso15U2IKkiggBErEkLk1KjESFLdq3RgpZ
 tWAmZ5WRNjkz2697z+GklW9BLELtDLjG3FizbmxzqoFUHLfnktw5IiPlOCPQ8ZfOVayN9AHCB9W
 Vji0SdtCJ5teDRmRwSb0qxIJpRqbmrf/4GfrilYZObVvY4d6dbil/k/OdteiliE+XuM1Py2IuuX
 +APD7nd+l3Gu1YDetdmXp3+1TtpRBiBIxGZvmpkClfbS7EhA2Z4Wq+Ca4AXWgyL6xoxh8JjJ1ru
 FTla6J1scVBGzoqagM/EffAjNK84DxuNW0XBGMdHJzx/OW041xsVeBjwVFWWiO/V
X-Received: by 2002:a05:6a00:23c8:b0:736:3c6a:be02 with SMTP id
 d2e1a72fcca58-739e4b49c79mr15598939b3a.11.1744040605512; 
 Mon, 07 Apr 2025 08:43:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuOMI2Xcy/nC6srbF6cfYh71RH09U11NZceBRNhbBZdMS89EUXYWBvu/Q/XgRJimIhyB8FHA==
X-Received: by 2002:a05:6a00:23c8:b0:736:3c6a:be02 with SMTP id
 d2e1a72fcca58-739e4b49c79mr15598897b3a.11.1744040605083; 
 Mon, 07 Apr 2025 08:43:25 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ee3fesm8681651b3a.37.2025.04.07.08.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 08:43:24 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 3/5] target/hexagon: Add missing A_CALL attr,
 hintjumpr to multi_cof
Date: Mon,  7 Apr 2025 08:43:12 -0700
Message-Id: <20250407154314.2512587-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250407154314.2512587-1-brian.cain@oss.qualcomm.com>
References: <20250407154314.2512587-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: doNTtGaEsPGU62-hPjJ-sbc5eccl93gN
X-Authority-Analysis: v=2.4 cv=KtdN2XWN c=1 sm=1 tr=0 ts=67f3f29f cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=ExrS_PMGiXDxMcIyg5oA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: doNTtGaEsPGU62-hPjJ-sbc5eccl93gN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=715 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070109
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
aGV4X2NvbW1vbi5weSB8IDcgKysrKystLQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9u
LnB5IGIvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQppbmRleCA2ODAzOTA4NzE4Li5hMmRj
YjBhYTJlIDEwMDc1NQotLS0gYS90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CisrKyBiL3Rh
cmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkKQEAgLTI0Nyw4ICsyNDcsMTEgQEAgZGVmIG5lZWRf
bmV4dF9QQyh0YWcpOgogCiAKIGRlZiBuZWVkX3BrdF9oYXNfbXVsdGlfY29mKHRhZyk6Ci0gICAg
cmV0dXJuICJBX0NPRiIgaW4gYXR0cmliZGljdFt0YWddCi0KKyAgICByZXR1cm4gKAorICAgICAg
ICAiQV9KVU1QIiBpbiBhdHRyaWJkaWN0W3RhZ10KKyAgICAgICAgb3IgIkFfQ0FMTCIgaW4gYXR0
cmliZGljdFt0YWddCisgICAgICAgIG9yICJKMl9ydGUiID09IHRhZworICAgICkgYW5kIHRhZyAh
PSAiSjJfaGludGp1bXByIgogCiBkZWYgbmVlZF9wa3RfbmVlZF9jb21taXQodGFnKToKICAgICBy
ZXR1cm4gJ0FfSU1QTElDSVRfV1JJVEVTX1VTUicgaW4gYXR0cmliZGljdFt0YWddCi0tIAoyLjM0
LjEKCg==

