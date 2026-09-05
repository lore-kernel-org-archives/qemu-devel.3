Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436E6C624DB
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 18:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2uqJ-0002rj-9y; Sat, 05 Sep 2026 14:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uq4-0002hp-Aa
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uq2-0001OQ-Ex
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:04 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685Hb9oH3176649
 for <qemu-devel@nongnu.org>; Sat, 5 Sep 2026 18:09:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=mMTttC2en3N0SnNFv00mzE
 CvRQrCkF559bfs7meYL/Y=; b=nklp0OFy/uypv/yrDgdGttZniqp7RUai07jLPd
 ibHSEEgJLFeHJIpD5hGvPq5bo/pugwCMvYpkxju6tubjbd60cJBCg0YwNM0mu0+g
 bOPss5/5VL/fsu4NcCEIPxAHVgpOngHiMrrHp+TFFwJVmawoEye1TLiOe8waN4cV
 LM/e7OedOIS+eLTwug8gQNXU7/gBnKvGzDEYdCkbHlXW8lgu4UbgiIj7fAB9hKAb
 r6VHpC/UK0bLOAUrGWLiQSVzXOuhWrjD76vvBdt/sDOtbk3z+a62LOgAFudpOTDo
 pbEy/NCgLGDvTkacs33Ydb0btvDu2+Xxh15edBKtRu/FCw4w==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggb5v9u59-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 18:09:53 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc1ca15334cso2684535a12.1
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 11:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788631792; x=1789236592; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mMTttC2en3N0SnNFv00mzECvRQrCkF559bfs7meYL/Y=;
 b=T3EeCLFmdunxtzUDc7ZL9JASWRXhUQljGCpMEhKM+BVMqYxVko80rl4cilvkI1N1mP
 +SWkUPqsR8//ipuae+9ChlCVCj1sFQrmFba+uc4t47Nsww6zic63yDtMn0hP0Dbkelsj
 1d6AXiONgoWoSPzz4HNz6SYw1GtmqvbZLTmVP61SRBvb08yotAjnopPU8WWnNIgV32Wu
 1HBzk9PqJ2zqjU+iDO9fiKU3yjrUWZyQ1Z0KwftKNWb9pWRWa5QieE7vcZpp148EHa0T
 26jc7i6jsn4IQxlXc3wUv+/zjkjw9vC96T67ud3Fli2fPZS18wlHfKouyS5y8qe/IbR5
 x/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788631792; x=1789236592;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mMTttC2en3N0SnNFv00mzECvRQrCkF559bfs7meYL/Y=;
 b=rJ+rkBNbPNbX55A3FR4UbFyvqpDdJRbjw2kUbsWYLl/lTpNR4W8XkG9LkNaAEia2YN
 OXIqN1gc26P8PdOLX/6nE9OeMw4SEgBFMUNnQh7VtJfpNVT4xfh7W6qgJm+fcGjcKl0s
 Ac8NDijm1VqPOJI64dqSp2mq6g6juG4cm6JosVZ7816MH11jlAxSfgyWthBIAg808li5
 NXSRQSLAxBn25AqCun1pGzXxMTzuy5dTARf/GNpfsO4j1TkJKM60Q/igCZ8ZQJcx3RzV
 87MmBIe3DKrJ92tXd25PRvc/VGi4suF7NM5rueo8HXcXdyb0ZPc11nZJPbLwirizBZXt
 77oA==
X-Gm-Message-State: AFuF++mkdQkM0KzmVHq1yDbRnDz3oFMARekPcRcvnLXRuMhIPKPCd90G
 uSMbJO5XggfviH4LnhtAp3OmpjjB3vNWAzSVMMALyo7nqosBVjooLoGUrwBBOyCHjtHaRe6xhoh
 H1ktvzJKCbasCC1LlJKOwPMqSVLq7RVEnwpftpulRodbStokdqa74wmLANyiMoiiRrw==
X-Gm-Gg: AYBFou0C6ysiTnDz9rbrczg7DXq78rM21WT2Zfea1jMQP4tfqNLGV+KqnEP8vb0xrVE
 7WOh1M2OMPIrrBQxgpDVRfEz7oObQY5jgwsO1tKWPubl6OFl9lDnupSOhjUnsZhamTHrBQjRwXD
 KJFCI1R4DGaLYcfvRKGE0MUeS9GQepOeR5tV/NTbbPLHYjS5vUsszTrpzqbzkgJxBToFhToznCp
 I8Uqf102oy5icj7GY2mYIGUcTsS0N0OSbCVyBatWnWeWTJqB1T5NKeYm23Tx/YvsgX5mN3fszN9
 PkCVvQVp+48iHwmtgh9nB57I2ojWKVnAMwUtOeyHqsb5O+h3RkI2DrCqFmSFJqn5Cz1eoln7Dxj
 NUlCuV7dnlczbTKnlyUPAafUadQtCPocXpPim6G2R64DI0L/d
X-Received: by 2002:a17:90b:5844:b0:398:e436:370 with SMTP id
 98e67ed59e1d1-39b260ff0e9mr22049471a91.2.1788631792257; 
 Sat, 05 Sep 2026 11:09:52 -0700 (PDT)
X-Received: by 2002:a17:90b:5844:b0:398:e436:370 with SMTP id
 98e67ed59e1d1-39b260ff0e9mr22049420a91.2.1788631791824; 
 Sat, 05 Sep 2026 11:09:51 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339a534df1sm17985505eec.7.2026.09.05.11.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 11:09:50 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, sid.manning@oss.qualcomm.com
Subject: [PATCH 00/17] hexagon: TCG test coverage + ubsan fixes
Date: Sat,  5 Sep 2026 11:09:32 -0700
Message-Id: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: dc4uEs0bVCgisTR8zcX13u98nkyIhMMy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfX8g626sLhIxcT
 JibLLqCLRLvPZShNmkhUiErFsmgEQPeJ1h4q0qsBDx1Fj/+MM3DULdBPnxqTMMKtmaO7wek9YEn
 cXub8F52h615Baqe5UOKfD+7sceEJpjKkGOgwV3GASBlZnd+ERjCPUvoTJ+rBT2Paw62PRLIU5N
 Qg1ph5Cx6/YwnCWbTgmxlrOt9qpTj4EPsciV9mhoR7HAuQONt213L8q5dNr9yqeP2NnSTomeDi0
 dSuVm40/BffHa25QXheGFhm9XDJEvVrSdBj/DW0ol3YAKBq0tKQydLdEdVdHNEYh/sJPkDxRXyb
 NvDRn+4aDfjR4PyJjUxacT1SXYNH6P12rrJacALCGg07ZebOJUVypM6aQ13Salylx2G7y1A/Y7K
 ++hM1+IAR7+Wc0Vi3JKo/iS8K59rpRngCiUEUt2/c2/ouoiwsVSg7F+aCjZEd8bPLjVXdtmofOx
 PaSecWF/IygZ6Fp3r1A==
X-Authority-Analysis: v=2.4 cv=UO3t2ify c=1 sm=1 tr=0 ts=6a9c5af1 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=u0-lxZPOwUuEB_SkxfwA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: dc4uEs0bVCgisTR8zcX13u98nkyIhMMy
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfX9bg1DEfWR9Yi
 gc8FVKReV0JwO/5NQm4f48Zzr+WDK/L85LVjZKiTTpLneKLsm9FDLej1RXlWKK+14l8KSYBFYqy
 In9OnQpfbDRzYcfqSGzV52hhUmjnkC4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609050201
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

UnVubmluZyBhIGNvdmVyYWdlIGJ1aWxkIGlkZW50aWZpZWQgc29tZSBnYXBzIGluIHRoZSBjb3Zl
cmFnZSBvZiB0cmFuc2xhdGlvbgpjb2RlLiAgTmV3IHRlc3RzIGFyZSBhZGRlZCBoZXJlIHRvIGNs
b3NlIHNvbWUgb2YgdGhvc2UgZ2Fwcy4KCkFmdGVyIHJ1bm5pbmcgdWJzYW4gb24gdGhlIGhleGFn
b24gVENHIHRlc3RzLCBzb21lIHRlc3RzIHdlcmUgZmxhZ2dlZAphcyBoYXZpbmcgdW5kZWZpbmVk
IGJlaGF2aW9yLiAgRml4ZXMgZm9yIG1hbnkgb2YgdGhvc2UgaXNzdWVzIGFyZSBpbmNsdWRlZC4K
CkJyaWFuIENhaW4gKDE3KToKICB0ZXN0cy90Y2cvaGV4YWdvbjogZml4IHVuZGVmaW5lZCBzaWdu
ZWQgbGVmdCBzaGlmdCBpbiBjaXJjLmMKICB0ZXN0cy90Y2cvaGV4YWdvbjogZml4IHVuZGVmaW5l
ZCBzaWduZWQgbGVmdCBzaGlmdCBpbiBicmV2LmMKICB0ZXN0cy90Y2cvaGV4YWdvbjogZml4IHVu
ZGVmaW5lZCBzaWduZWQgaW50ZWdlciBvdmVyZmxvdyBpbiBodnhfbWlzYwogIHRlc3RzL3RjZy9o
ZXhhZ29uOiBmaXggdW5kZWZpbmVkIGludGVnZXIgb3ZlcmZsb3cgaW4gdjY5X2h2eC5jCiAgdGVz
dHMvdGNnL211bHRpYXJjaDogc3VwcHJlc3MgVUJTYW4gZm9yIGZsb2F0LXRvLWludCBjb252ZXJz
aW9ucwogIHRlc3RzL3RjZy9oZXhhZ29uOiBhZGQgRlAgY2xhc3NpZmljYXRpb24sIGNvbnZlcnNp
b24sIGFuZCBmaXh1cCB0ZXN0cwogIHRlc3RzL3RjZy9oZXhhZ29uOiBhZGQgYml0IGludGVybGVh
dmUgYW5kIGNvbnZlcmdlbnQgcm91bmRpbmcgdGVzdHMKICB0ZXN0cy90Y2cvaGV4YWdvbjogYWRk
IGNvbmQgY2FsbCwgdHN0Yml0LWp1bXAsIGFuZCBlbmRsb29wMDEgdGVzdHMKICB0ZXN0cy90Y2cv
aGV4YWdvbjogYWRkIGRjemVyb2EgY2FjaGUgbGluZSB6ZXJvIHRlc3QKICB0ZXN0cy90Y2cvaGV4
YWdvbjogYWRkIEhWWCB2d2hpc3QgdGVzdHMKICB0ZXN0cy90Y2cvaGV4YWdvbjogYWRkIHNmcmVj
aXBhIGVkZ2UgY2FzZSB0ZXN0cwogIHRlc3RzL3RjZy9oZXhhZ29uOiBhZGQgZGZtcHloaAogIHRl
c3RzL3RjZy9oZXhhZ29uOiBhZGQgdW5jb25kaXRpb25hbCBzdG9yZS1pbW1lZGlhdGUgdGVzdHMK
ICB0ZXN0cy90Y2cvaGV4YWdvbjogYWRkIHByZWRpY2F0ZSByZWdpc3RlciB0cmFuc2ZlciB0ZXN0
CiAgdGVzdHMvdGNnL2hleGFnb246IGFkZCByb3VuZGluZyBjb252LCBzZmZtYTpsaWIsIGFuZCBz
ZmludnNxcnRhCiAgdGVzdHMvdGNnL2hleGFnb246IGFkZCBzY2FsYXIrSFZYIGFuZCBtYXNrZWQg
c3RvcmUgdGVzdHMKICB0ZXN0cy90Y2cvaGV4YWdvbjogYWRkIGRlY2JpbiBNUFMgdGVzdCBjYXNl
CgogdGVzdHMvdGNnL2hleGFnb24vaHZ4X21pc2MuaCAgICAgICAgIHwgICAxICsKIHRlc3RzL3Rj
Zy9oZXhhZ29uL2JyZXYuYyAgICAgICAgICAgICB8ICAgMiArLQogdGVzdHMvdGNnL2hleGFnb24v
Y2lyYy5jICAgICAgICAgICAgIHwgICA2ICstCiB0ZXN0cy90Y2cvaGV4YWdvbi9mcHN0dWZmLmMg
ICAgICAgICAgfCA0MTIgKysrKysrKysrKysrKysrKysrKysrKysrKysrCiB0ZXN0cy90Y2cvaGV4
YWdvbi9odnhfbWlzYy5jICAgICAgICAgfCAgODQgKysrKystCiB0ZXN0cy90Y2cvaGV4YWdvbi9t
aXNjLmMgICAgICAgICAgICAgfCAgNzkgKysrKysKIHRlc3RzL3RjZy9oZXhhZ29uL3Rlc3RfYml0
b3BzLmMgICAgICB8ICA5OCArKysrKysrCiB0ZXN0cy90Y2cvaGV4YWdvbi90ZXN0X2NvbmRfYnJh
bmNoLmMgfCAxNjIgKysrKysrKysrKysKIHRlc3RzL3RjZy9oZXhhZ29uL3Rlc3RfZGN6ZXJvYS5j
ICAgICB8ICA4OCArKysrKysKIHRlc3RzL3RjZy9oZXhhZ29uL3Rlc3RfdndoaXN0LmMgICAgICB8
IDM2MSArKysrKysrKysrKysrKysrKysrKysrKwogdGVzdHMvdGNnL2hleGFnb24vdjY5X2h2eC5j
ICAgICAgICAgIHwgICAzICstCiB0ZXN0cy90Y2cvbXVsdGlhcmNoL2Zsb2F0X2NvbnZkLmMgICAg
fCAgIDEgKwogdGVzdHMvdGNnL211bHRpYXJjaC9mbG9hdF9jb252cy5jICAgIHwgICAxICsKIHRl
c3RzL3RjZy9oZXhhZ29uL21lc29uLmJ1aWxkICAgICAgICB8ICAgNCArCiAxNCBmaWxlcyBjaGFu
Z2VkLCAxMjg4IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAw
NjQ0IHRlc3RzL3RjZy9oZXhhZ29uL3Rlc3RfYml0b3BzLmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0
ZXN0cy90Y2cvaGV4YWdvbi90ZXN0X2NvbmRfYnJhbmNoLmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0
ZXN0cy90Y2cvaGV4YWdvbi90ZXN0X2RjemVyb2EuYwogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3Rz
L3RjZy9oZXhhZ29uL3Rlc3RfdndoaXN0LmMKCi0tIAoyLjM0LjEKCg==

