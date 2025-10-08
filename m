Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7227ACCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 01:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6JI0-00073M-3H; Tue, 07 Oct 2025 21:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v6JHt-00072G-Gm
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 21:48:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v6JHn-0004vB-GJ
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 21:48:16 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59803VXa018096
 for <qemu-devel@nongnu.org>; Wed, 8 Oct 2025 01:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jtuM00cA83ptQ7G++jqLdI7SGG9TDjKmk2p7IOaZER8=; b=E2lA421eBR8xaO6I
 AZjKB0y/gcX4mK1vJ2+16GBp6sCVhEgIb0bhvVTMZ1txXDZOm5cFQrXgcSDp+S7a
 woC9N8++hX64k6cnasCsecT/8dD/xR5eBtlSfIJtSTJtXdM1CmR6V3DGwQ0VYRJ0
 FPbZv26wIeq/rbMrIrYYLJWw7mtN8A3w65iMUsgTIOPTa3z5NsUL54N5FeUYDwsV
 sJ+Zx+bLm1lFjTKreMgk7O/V36SP9E0+pQ2j01XXOvpnT62pPh51oZ+UNcsrauPM
 EB+hTBYCvGMUr86VftpJbrzd9OI6Gx9XkOWHQzDdZKaHsqr/u0Knb2t9X0RmfWBD
 aYvTcw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtwgs3c2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 01:48:06 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-780f914b5a4so6316379b3a.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 18:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759888085; x=1760492885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jtuM00cA83ptQ7G++jqLdI7SGG9TDjKmk2p7IOaZER8=;
 b=dlEW61pwCw1xdxOTg5mKv3W8MFCDFX1G8uF855Dn+mecTQJvAn6HIb6Q9wRelIDofU
 +x0QsWXuSkejJCO/18atm1lf3o5rVmgArW0YLfAaA6eTWPLEgEQZt7WhzNa0/O9/0mle
 7mp7VMguP+OcCGokJNJpsNHL4N3axtpPdjZrdVxHOceCBHSQl8RudCW2sonD39A+jytn
 ALSo5V1NxKePkt2HRiOG0/uAtcsAaY23qH1TTn4ug7TgCy+T4WmTZ6bub5Njio3rysJG
 xlFkvpenkSkPIXLw3CjkAoUWXEknZxM7EqvGwZepGBKWsCMpKst0h1ht51nGVrXlHYlK
 Fihw==
X-Gm-Message-State: AOJu0YxZOlXKpjO3BZtH1TxAn5g6y83BCQ3S7eJo4KqCdkWeJMcrZmKV
 MQMf/zqVrFMTrcKjYyJ0j2TVqXpCYXd+FGnOtYvSjlWtawuy2ODJNTUqqKz7VH5/Jif1Ad+LjGV
 bhNVrxuwnXpEb/ghZR8QkPUb+Umfz0O44lWEBctJBpOarpQ4wRpMde+X4L3+KX7ZhAw==
X-Gm-Gg: ASbGncuU3OtVqySMujd/Tmm4OP69+GEu2XdjKm2msPVIZe8O4Emc/OIjWnW+AQNhjUB
 /Nee+LAjNrT9TLz62IDhhOgVBogUBafNU62wr65sjI8SpNW1Lc+JpAJi+doSMBfClsgfHJll3VL
 ZIE1Mt3xEjoFBl5ljiOm9Eia0IOj18vJFF7tht43R4fpi0oH3iY2bKJW3ZZssq7Vw8MZKWFOYJK
 veubm0/NHyKSI7fZN94wj8l3msozWmQJhm4muqdwuE9s4NLizetnG2b3Yp8Up9A9lnxlr04YvE5
 Y6d27IHF3WxOOAI+6DGePf2bLxEIFZs29i/Qj4ZQVazigvZchN3yLmnkD8HARo3YDYVKVUtV+0y
 nP0eQT6ERbsMuBFPsSw==
X-Received: by 2002:a05:6a00:a8f:b0:781:24ec:c8f4 with SMTP id
 d2e1a72fcca58-793857098bamr1637919b3a.3.1759888084444; 
 Tue, 07 Oct 2025 18:48:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExQFCDqbtgZLDpU4bw9yLZJNqglV/VqViwflVHg5rY+nDzrx9z6RM0SInyJ5UIZBS5a3DByw==
X-Received: by 2002:a05:6a00:a8f:b0:781:24ec:c8f4 with SMTP id
 d2e1a72fcca58-793857098bamr1637870b3a.3.1759888083408; 
 Tue, 07 Oct 2025 18:48:03 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b0206ea2fsm16772684b3a.66.2025.10.07.18.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 18:48:03 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com
Subject: [PATCH 2/2] tests/tcg/hexagon: Add cs{0,1} coverage
Date: Tue,  7 Oct 2025 18:47:54 -0700
Message-Id: <20251008014754.3565553-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251008014754.3565553-1-brian.cain@oss.qualcomm.com>
References: <20251008014754.3565553-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOSBTYWx0ZWRfX2Y0Zor+aIklq
 SCUlolNfcR0iQmbxnmHnqHo0ZVapu0bBHgv9046nqGl93VszRCb2bKXsFgta0//m03M+qldvBWf
 CqezYDdU7mXVH8YcbtHIQ7rMcRsrHQSyB+81VsQijSoXvpYDyI681E1siae2f6b/L1sLnfP55OA
 MQ3yuCdJ2dO72o1zOYAuYMNcT+RhqY4DrIO6VYAP7kVf7ZPvqqGlv8278uIXTLB9XFjcYBWb4kD
 mPB/gcIbaDdjmTf0erhMdDBsJhyj0Kv9cB27K2ff866W94Ke6AGQVimXPMMqBi0ZUUrGI1C8a59
 HHq4YX+thJfX/80QqIpmJaIv1g9wHXCc3chEyltx4Wjk5E0Pmtm8YiVAN0bPdXpWmpogcHczDH+
 dyI/b1vhxyal32zvuKK4AairezoeRg==
X-Authority-Analysis: v=2.4 cv=B6O0EetM c=1 sm=1 tr=0 ts=68e5c2d6 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=gohRq8mKNrDRu6Qpr2AA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: ZKyHnhSTLlPNKkasSj47p9pFlIL0Ee8c
X-Proofpoint-ORIG-GUID: ZKyHnhSTLlPNKkasSj47p9pFlIL0Ee8c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040019
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

Q292ZXIgY3MwLDEgcmVnaXN0ZXIgY29ycnVwdGlvbiBpbiB0aGUgc2lnbmFsX2NvbnRleHQgdGVz
dCBjYXNlLgoKU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tPgotLS0KIHRlc3RzL3RjZy9oZXhhZ29uL3NpZ25hbF9jb250ZXh0LmMgfCAyMiArKysr
KysrKysrKysrKysrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0cy90Y2cvaGV4YWdvbi9zaWduYWxfY29udGV4
dC5jIGIvdGVzdHMvdGNnL2hleGFnb24vc2lnbmFsX2NvbnRleHQuYwppbmRleCA3MjAyZmE2NGI2
Li4wMGJiYjNlZmM3IDEwMDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9zaWduYWxfY29udGV4
dC5jCisrKyBiL3Rlc3RzL3RjZy9oZXhhZ29uL3NpZ25hbF9jb250ZXh0LmMKQEAgLTI2LDcgKzI2
LDExIEBAIHZvaWQgc2lnX3VzZXIoaW50IHNpZywgc2lnaW5mb190ICppbmZvLCB2b2lkICpwdWMp
CiAgICAgICAgICJwMSA9IHI3XG5cdCIKICAgICAgICAgInAyID0gcjdcblx0IgogICAgICAgICAi
cDMgPSByN1xuXHQiCi0gICAgICAgIDogOiA6ICJyNyIsICJwMCIsICJwMSIsICJwMiIsICJwMyIp
OworICAgICAgICAicjYgPSAjMHgxMjM0NTY3OFxuXHQiCisgICAgICAgICJjczAgPSByNlxuXHQi
CisgICAgICAgICJyNiA9ICMweDg3NjU0MzIxXG5cdCIKKyAgICAgICAgImNzMSA9IHI2XG5cdCIK
KyAgICAgICAgOiA6IDogInI2IiwgInI3IiwgInAwIiwgInAxIiwgInAyIiwgInAzIik7CiB9CiAK
IGludCBtYWluKCkKQEAgLTUyLDcgKzU2LDExIEBAIGludCBtYWluKCkKICAgICBpdC5pdF92YWx1
ZS50dl9uc2VjID0gMTAwMDAwOwogICAgIHRpbWVyX3NldHRpbWUodGlkLCAwLCAmaXQsIE5VTEwp
OwogCi0gICAgYXNtKCJsb29wMCgxZiwgJTEpXG5cdCIKKyAgICBhc20oInI5ID0gIzB4ZGVhZGJl
ZWZcblx0IgorICAgICAgICAiICAgY3MwID0gcjlcblx0IgorICAgICAgICAiICAgcjkgPSAjMHhi
YWRjMGZlZVxuXHQiCisgICAgICAgICIgICBjczEgPSByOVxuXHQiCisgICAgICAgICIgICBsb29w
MCgxZiwgJTEpXG5cdCIKICAgICAgICAgIjE6IHI4ID0gIzB4ZmZcblx0IgogICAgICAgICAiICAg
cDAgPSByOFxuXHQiCiAgICAgICAgICIgICBwMSA9IHI4XG5cdCIKQEAgLTc0LDEwICs4MiwxOCBA
QCBpbnQgbWFpbigpCiAgICAgICAgICIgICByOCA9IHAzXG5cdCIKICAgICAgICAgIiAgIHAwID0g
Y21wLmVxKHI4LCAjMHhmZilcblx0IgogICAgICAgICAiICAgaWYgKCFwMCkganVtcCAyYlxuXHQi
CisgICAgICAgICIgICByOCA9IGNzMFxuXHQiCisgICAgICAgICIgICByOSA9ICMweGRlYWRiZWVm
XG5cdCIKKyAgICAgICAgIiAgIHAwID0gY21wLmVxKHI4LCByOSlcblx0IgorICAgICAgICAiICAg
aWYgKCFwMCkganVtcCAyYlxuXHQiCisgICAgICAgICIgICByOCA9IGNzMVxuXHQiCisgICAgICAg
ICIgICByOSA9ICMweGJhZGMwZmVlXG5cdCIKKyAgICAgICAgIiAgIHAwID0gY21wLmVxKHI4LCBy
OSlcblx0IgorICAgICAgICAiICAgaWYgKCFwMCkganVtcCAyYlxuXHQiCiAgICAgICAgICI0OiB7
fTogZW5kbG9vcDBcblx0IgogICAgICAgICA6CiAgICAgICAgIDogInIiKCZlcnIpLCAiciIoaSkK
LSAgICAgICAgOiAibWVtb3J5IiwgInI4IiwgInAwIiwgInAxIiwgInAyIiwgInAzIik7CisgICAg
ICAgIDogIm1lbW9yeSIsICJyOCIsICJyOSIsICJwMCIsICJwMSIsICJwMiIsICJwMyIpOwogCiAg
ICAgcHV0cyhlcnIgPyAiRkFJTCIgOiAiUEFTUyIpOwogICAgIHJldHVybiBlcnI7Ci0tIAoyLjM0
LjEKCg==

