Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E34B1098793
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3bBp-0006FZ-EG; Fri, 20 Mar 2026 10:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w3bBn-0006FJ-9y
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:51:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w3bBl-0007KS-3c
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:51:03 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62KEJXdQ989570
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 14:50:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=3Wut+3TyVA0PMRwkk2OVOZ
 fJr+108aCCXWBKxtfxnJY=; b=iEWcANH7yTDTd4qnms6Lzvl1/ckprDlREO9K2d
 lcNYtBQuWbtlNQN/pmmGWdGykGxc/Io24WygauIsyu2Fa/cIoKpF2foGcNZ2CodM
 aRRWm/cakTX60IRavj/R70PKWYizF1k/6bm8Fq1ATPEZh8vCHrsGxvwhY8r5eGPB
 y3p8XB3tB65bAZdWW/Q5bBqBHbkPMjjYMaVIpLka/LMhCXREnIzpzEtDBM4gOFRj
 6/TRE3Ma4TAiHZUO5HBB7Rzr1qnqLCVVVk9OlhddRIKYJnQpj36x3ksLLTw4diiM
 ZPlHAfLXXlzEZzEmISofNdQd/n3f/Y/2oCx9P+Xx/OPfYKoQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0k0vbq0d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 14:50:56 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2c0ba59a830so627931eec.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 07:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774018255; x=1774623055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3Wut+3TyVA0PMRwkk2OVOZfJr+108aCCXWBKxtfxnJY=;
 b=GexfVkJuvRRqfYImp78P0Ew3DmGkWeKRzIUlnLHv8X/we14VJThvDclVvP8tYWnbXJ
 WeJh+Y6CvJHf3FJefbCTegzTFaROBL/VngUQV+zhkVK9Bff+HXbjWUKhZbJs10SPhou3
 HT5kBTIHTn8A6uXsvRH079G4f7ZyN1TpCQU7k/XbCTKV4+sZHoLUgqr078vLJZTXAkQb
 0lr2yREG+FDfBtkGGId/oPydNwmfzwZLN4edqnm7cLOEzwthZ37WOEiI61hIZKw84i6/
 47h03Vox2ITCeHVG+UUg+eLSiP1z5Ii7YQmyKFMBxWETS4SvKePj3aMeQ6eLBlYrcIRB
 ygSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774018255; x=1774623055;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Wut+3TyVA0PMRwkk2OVOZfJr+108aCCXWBKxtfxnJY=;
 b=CxIiG1hmN29pJX4DfBscZhEPt3QMwhEcKc/jnWZdG1Y4Ah63C3M9+EW3Q99GkAdm8q
 vBTugPHTK4nMPyeAQaFy40CtZebJJi6bGrh5QK0UX9n7CCdgsknafbek9xE7ZfAyGk4H
 Z6pRYVzojf7nJWAFSKIvnDmFIHwdse2tbM+i5mHmUjxyoALQCz0FipF2KhDTWYYqdOmI
 IVuV9xPUABb2Ojmt0+KRoHLdkUMOD+RVSIHYpcl4otEk0llUrXTLGePrCCIztVEHq7iN
 rrqCFPKxik+xnmYeu3FQieBx45P3T3JqDetkBkYlJSnlAKOswaHSDZ+ds+yq8NQhTTCF
 fcTg==
X-Gm-Message-State: AOJu0YzrTHmRjxDGMHGvr9AdW7FCn7r6MbwvjorhwM7grbbXGGktLitl
 TXOCR0a18xdudE93cXQk38AYtiTpGou0zEIOuS1k7sdns7TuNR7LX6fHN/w+mC8SfiDJyyVM1h8
 EzFUvqGjzX0/F8tpIAWR88vilT3xFp377LdTJGoQe0Yg1m2Tv/cVS8SiDs332N3Euvg==
X-Gm-Gg: ATEYQzyZfLag6Pr3oMWxq0FiId27WEpO9tHLTNsF/E7JSyvozdJqMdAgzyBZciqv3Hw
 sRRJF86XCAj7D9JsUCqmP0cp9wNaeiqgupfB2LfViGwigliXseV2fIf8KXdxQ2B3phS3VTJhJbA
 BlAx1y8L6/wTAUmECctl4Y3qrmgBTASUdM2Q3jt8oYTWhW+p5SARd907frYw04MScy27l6GftrO
 ReGG8AXvZQ3568fRhCpdA/axnSVxulz0MTT0DE+htKwFKI2k3YMoPaH/VqCVM9j36aoIABULuZi
 EBbaIwtH9jUdvDOWxtMbhrAhf0wWFW3Q41QgSRT84Gzpo8GFe9an8b/acgJTO+FO/a1xNGYPC96
 QFtFr1pGNktpaJTCpOmRgzW040YZZHJf7rE09JBfBliyhTgU1p76HOU832Z+jOCnCVfwLtw==
X-Received: by 2002:a05:7022:4590:b0:128:cf5c:535a with SMTP id
 a92af1059eb24-12a7268c7dbmr1582555c88.11.1774018255261; 
 Fri, 20 Mar 2026 07:50:55 -0700 (PDT)
X-Received: by 2002:a05:7022:4590:b0:128:cf5c:535a with SMTP id
 a92af1059eb24-12a7268c7dbmr1582527c88.11.1774018254587; 
 Fri, 20 Mar 2026 07:50:54 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12a733e794esm2473061c88.6.2026.03.20.07.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 07:50:54 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com
Subject: [PULL 0/3] hex queue
Date: Fri, 20 Mar 2026 07:50:38 -0700
Message-Id: <20260320145041.3027130-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 4qHAdS6isSeWJ1qRpgnzTo5egmhXfwHi
X-Authority-Analysis: v=2.4 cv=EcjFgfmC c=1 sm=1 tr=0 ts=69bd5ed0 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=NEAV23lmAAAA:8 a=ZqJOnHd9RdeBHZvTe7UA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: 4qHAdS6isSeWJ1qRpgnzTo5egmhXfwHi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDExOSBTYWx0ZWRfX6y51Zh/OuYs7
 Giy4sZCHFDDyzuFHwLRUIgNokEMPxVMtFjOijjW6BygbGl1CGMoN841pN01BMjAc4p4LGl0eGM5
 LNansrhFyEPD7yG8jMg0UUkmG+9GB35nOmDU/VIe2FJ/NfFJ74uzPeBZG9r3Zw3TcJO/65nJZ7C
 ymEMFHCnx3zDW0AbU7ZfpnPB4BfUFMhp2AzVuWRHroPyJ3ASq6I2w5I5rMkhUoWHIrGWibAogpy
 NrXeA/a7Liqjdd5iTHtORznu4RcRRY61B9fx7lquruIN+THYfKkVur7lF4jhlTjt/KYn2AAT0yA
 Ch1WDCpm+8F9pFZQjUACFxh62t6RTXvgCNhUvFrT3NVWh2bd8jVh3YA/e6j67NBijEA8eTrHaKN
 uUek8MqQpg2kBLzULIV7tvLm3gpnoqHMDuiqKj66R4kUQal0L0ytdNDG+ThKU7phndkixGmbkC5
 c1yzObau04gYUPlNOaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200119
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA4ZTcxMTg1NmQ3NjM5Y2JmZmE1MTQw
NWYyY2MyMzY2ZTNkOWUzYTIzOgoKICBNZXJnZSB0YWcgJ2hwcGEtZml4ZXMtZm9yLXYxMS1wdWxs
LXJlcXVlc3QnIG9mIGh0dHBzOi8vZ2l0aHViLmNvbS9oZGVsbGVyL3FlbXUtaHBwYSBpbnRvIHN0
YWdpbmcgKDIwMjYtMDMtMjAgMTA6MDQ6NDggKzAwMDApCgphcmUgYXZhaWxhYmxlIGluIHRoZSBH
aXQgcmVwb3NpdG9yeSBhdDoKCiAgaHR0cHM6Ly9naXRodWIuY29tL3F1aWMvcWVtdSB0YWdzL3B1
bGwtaGV4LTIwMjYwMzIwCgpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gMWFkZjY3YjNj
NDQ1ZjQwNjA5MDA0NDBlYTIxMGU3YTFlMDMwNDJmNToKCiAgdGVzdHMvdGNnL2hleGFnb246IGFk
ZCB0ZXN0IGZvciBwcmVkaWNhdGVkIC5uZXcgYnJhbmNoIExTQiBldmFsdWF0aW9uICgyMDI2LTAz
LTIwIDA3OjQzOjAzIC0wNzAwKQoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpGaXggZm9yIEoyX2p1bXB0bmV3eyxwdH0gcHJl
ZC1yZWcgbWlzYmVoYXZpb3IKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KQnJpYW4gQ2FpbiAoMyk6CiAgICAgIHRhcmdldC9o
ZXhhZ29uOiBmaXggSjJfanVtcHRuZXcvcHQgcHJlZGljYXRlIGNoZWNrIHRvIHVzZSBMU0IKICAg
ICAgdGFyZ2V0L2hleGFnb246IHVzZSBUQ0dfQ09ORF9UU1RFUS9UU1RORSBmb3IgcHJlZGljYXRl
IGJyYW5jaGVzCiAgICAgIHRlc3RzL3RjZy9oZXhhZ29uOiBhZGQgdGVzdCBmb3IgcHJlZGljYXRl
ZCAubmV3IGJyYW5jaCBMU0IgZXZhbHVhdGlvbgoKIHRhcmdldC9oZXhhZ29uL2dlbl90Y2cuaCAg
ICAgICAgICAgICAgICAgfCAgOTQgKysrKy0tLS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyAg
ICAgICAgICAgICAgICAgIHwgIDMyICsrLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgICAg
ICAgICAgICAgICB8ICAgMiArLQogdGVzdHMvdGNnL2hleGFnb24vdGVzdF9wbmV3X2p1bXBfbG9h
ZHMuYyB8IDM0MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiB0ZXN0cy90Y2cvaGV4
YWdvbi9NYWtlZmlsZS50YXJnZXQgICAgICAgIHwgICAzICsKIDUgZmlsZXMgY2hhbmdlZCwgMzk0
IGluc2VydGlvbnMoKyksIDc4IGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3Rz
L3RjZy9oZXhhZ29uL3Rlc3RfcG5ld19qdW1wX2xvYWRzLmMK

