Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9F4C3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 02:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0XAX-0005ue-7c; Thu, 03 Apr 2025 22:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u0XAU-0005to-SS
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 22:52:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u0XAS-0006m8-ST
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 22:52:30 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5341O2xo028502
 for <qemu-devel@nongnu.org>; Fri, 4 Apr 2025 02:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QsGP2ijL+WlGrewJ27McO4Tyi4F00Bmlcuv9pKxeHBE=; b=B3ds98udxwE2FyxH
 yck6qeXAtUZIwaulBkwtGBw2APMKj5qeE8NFyjpTS12ADWNHt3vGCOBtoGNK33iJ
 VhIhz7vuNCGB0RWLBtoJ6NxeBZbkng2iQNkTwkAKCwXHGW/K/IMVw/+3kkg0BP1M
 b5/izTGXqkOfsXIFQHtHd9z+2atyPQ3lEIfT0CSBDZp7/moBIhZqq/stg4l21JL+
 1rC+AsGBtVlsRgIYTqM+d02te6GjAO4Eo3qPzNEKNS02ddktrzfdw/VVV0t46xWv
 6/05dFeMNaI4o/q7zkZz9WZMxeiECygeEp7PxDeILpkDusl6mEMAIYmLi66bpqUt
 8TbnAA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45t2d40fwg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 02:52:27 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-227ed471999so14384575ad.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 19:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743735146; x=1744339946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QsGP2ijL+WlGrewJ27McO4Tyi4F00Bmlcuv9pKxeHBE=;
 b=BIpUeiG7VGCDmTOoUo92q2f2D45Hii3Hl/9knb/unwgGjTM2p5e/1A0CuFwZ3RDERh
 sJkbu5JskqBVqYEkKnbXLhcXbficDx8acBG/wn9DgFG7itZwiUvJck8S/aS1vDojkiXu
 wbOchUz+bbsjcxEuUYyNLfm6KAkiqSQTyzWqtZm7glUOwi/Na8dxjUV/SqRQ4Ek+/oNl
 QbWpGQpGrLS/SLx2L8PIGuloaVo8NYDl8XSQUHHOnUGujpJbHrTxOZIBnV9hxcJnwJLR
 8YrqS4bISIcwFcLdtaJbNCJMBXy0aetT2R0s67SzAHjZsdLW6+8UoThGDIc9Vu0ZJIUW
 WKkA==
X-Gm-Message-State: AOJu0YzEf6fouMlG7P8Qc9gg3pypT5UJtATQo2XH5iEtMRCFQmpq7Ud6
 Ga+bnqlCUF01EMlJ7bdNVmlMqNHOe2SDpD+IXegxXlRWSBp9S/txhC2uhNpQiDzEREiuAPBWO+8
 sR1cXnY8FyFD4z+7cvHikpt4FXgtzWruRRQ3ECwvUHa2OL0WESxGjGywOC9pAVQ==
X-Gm-Gg: ASbGncuDzPB/rEraZsLbldm0bLJULRivHwf0WpSibKfwp8uem8vuF/SaZvJqXU8xyDz
 1eu222jSbVEct5vUfKc54HETHGRArzx5c5IN9oFY1TCWr1I3yCIs99CD+mD0Ib1rPnT/p+vJO3J
 EeNU9ClhME92l7K8S1xf6r2HH6EtMrL8nke4cRack3Ud64GQxR6pB+py+q5WeoXaYVu7O7TH3b7
 CEKeLnZftBwvu0lIViVQitlp2olAJItWzfTLOrZXwRuna8xyYDO3t5fH8PsahQEYVHcWjR6CP1w
 5xys5t6OGkVpptu5OK2mR6wKbpAxiylf0vuApjDSdic6woRj7Xv+1pFDY3YoRpSk
X-Received: by 2002:a17:903:1a10:b0:224:2201:84da with SMTP id
 d9443c01a7336-22a8a049edcmr17446035ad.6.1743735146032; 
 Thu, 03 Apr 2025 19:52:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHN18YHDs9gEJzuYBVd92DhPG2qHkopHYswJNKEVer6zjkWdSLEGyMmtZNTYoheZF4x0YuXWw==
X-Received: by 2002:a17:903:1a10:b0:224:2201:84da with SMTP id
 d9443c01a7336-22a8a049edcmr17445855ad.6.1743735145664; 
 Thu, 03 Apr 2025 19:52:25 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785ea16bsm22014865ad.106.2025.04.03.19.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 19:52:25 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 3/6] target/hexagon: Add missing A_CALL attr,
 hintjumpr to multi_cof
Date: Thu,  3 Apr 2025 19:52:00 -0700
Message-Id: <20250404025203.335025-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250404025203.335025-1-brian.cain@oss.qualcomm.com>
References: <20250404025203.335025-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: CC8B3RQ4rZeHfGdcNJRiz3Zu8K8Pd-4l
X-Authority-Analysis: v=2.4 cv=HrJ2G1TS c=1 sm=1 tr=0 ts=67ef496b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=ExrS_PMGiXDxMcIyg5oA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: CC8B3RQ4rZeHfGdcNJRiz3Zu8K8Pd-4l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_01,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 clxscore=1015 mlxscore=0 phishscore=0
 mlxlogscore=715 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504040019
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
LnB5IGIvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQppbmRleCAyNDJkZWUzNzMxLi44NWVh
YmM5ODc2IDEwMDc1NQotLS0gYS90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CisrKyBiL3Rh
cmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkKQEAgLTI0Nyw4ICsyNDcsMTEgQEAgZGVmIG5lZWRf
bmV4dF9QQyh0YWcpOgogCiAKIGRlZiBuZWVkX3BrdF9oYXNfbXVsdGlfY29mKHRhZyk6Ci0gICAg
cmV0dXJuICJBX0NPRiIgaW4gYXR0cmliZGljdFt0YWddCi0KKyAgICByZXR1cm4gKAorICAgICAg
ICAiQV9KVU1QIiBpbiBhdHRyaWJkaWN0W3RhZ10KKyAgICAgICAgb3IgIkFfQ0FMTCIgaW4gYXR0
cmliZGljdFt0YWddCisgICAgICAgIG9yICJKMl9ydGUiID09IHRhZworICAgICkgYW5kIHRhZyAh
PSAiSjJfaGludGp1bXByIgogCiBkZWYgbmVlZF9wa3RfbmVlZF9jb21taXQodGFnKToKICAgICBy
ZXR1cm4gJ0FfSU1QTElDSVRfV1JJVEVTX1VTUicgaW4gYXR0cmliZGljdFt0YWddCi0tIAoyLjM0
LjEKCg==

