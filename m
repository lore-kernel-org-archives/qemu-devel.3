Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A1810F6FD9
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7xVg-0003aV-Pc; Wed, 01 Apr 2026 11:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xVK-0002SZ-03
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:29:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xVI-00084A-2X
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:29:13 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631CdFj31285928
 for <qemu-devel@nongnu.org>; Wed, 1 Apr 2026 15:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RVQEUAzFE4SplFIuQaA6cs92F6G+KviXiKGvFjQVQak=; b=hCpnf/0+zbw8c010
 3AuNJp+Um2t7eMrfMVbtF27TI/EnYOu8YtVwL2nz5FTCsXfXGwHKMUdwyksjObgy
 6zCzrNz9IU6W4t7sH4kU8EGI+3zr7N/EXhDPUy+7O3MEIUDJbANZ7dQAsqUMhnxH
 0YahIh4DkROwFUqKTuJcORUFglgj2huwxy/QenqMUAhoi7Ny8U6FMYZkwObKhHop
 M3kdSgkOhlz39hhwQRy2+28ENGbg/h7ZWeNuAznJPevc10EkIaAYS1OGnr+4XbPI
 U9PGAT1dyre+91WCaJlDUwrFLU5sky/j2cV1VVBh3cLvXKqeKvPQeSfvxmO55ZOr
 L05SPQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8xm3t2r2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 15:28:06 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2bdf75bc88fso6124169eec.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 08:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775057279; x=1775662079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RVQEUAzFE4SplFIuQaA6cs92F6G+KviXiKGvFjQVQak=;
 b=R6K4q7y764OfX+8yg4tbtH8V0z14raj1N5gG4kE8YJsaT7cXSVXLEcORoMCt/RDU7D
 QM+ejwtuPX4QtB1jOWdaPRw2rE4A8i1rChL9TGbAebxrQJUUEl1K0V8KXhefPXK+/hSZ
 bvCzyjryWkxOWDh47pTmceAUlWIrQ/OvQ8KRCAHqg6jbURY+2Rh/4ueIkDaVarjXqnzl
 PLW+jwrp2Be2FbD/IynX/GrHNhEMWET4j8XfUQtVDaeh2r2JlvoFfm/iUTcn8hjW2vgg
 EHHMCcsy3YWQWz+5IbeUwwTdVfNKee+u+Goa3htHoyGrUD14P9+n1G1SFiKZ2NA12Ooy
 1iug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775057279; x=1775662079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RVQEUAzFE4SplFIuQaA6cs92F6G+KviXiKGvFjQVQak=;
 b=Lb/CGiPTG1TPqc6JRa4wauNgsArdVLbpWpLTB/77Em/jTFOT5KkeJQg/OC4HXboyXa
 2SUyRlksOVA932FkRwvZAU8t6ljqnk9ifULP0a4m26+UFAyPhYtH/69cq/O7+jgBkblz
 iOCDx6jRggITkKjsaY60XfTQyXyyy0XmlZX6yMC1wLfwBycVf/3r4kVveKggsT3jpJeW
 ZOAxbHlhoV8jcrStp5WJS9WQ0+1kMrrJ5vgNChppvBnJO5ucJoXT51I2AA7AXDfPPe04
 SPKzf3OpOxSczHbbHmreiFJUs4HLv79sjGKHLygUJy8Vf2nI6ku0Rsa3TTm0r0IXnNt+
 TavA==
X-Gm-Message-State: AOJu0YxXm29XsrmJcqWuX+5qROI/q9ZOq13A9JUdRjap0Ag9zeZcdJ2M
 TiS3x3iu4xRkSja5OqAMCXWM1sm/GB8O+v+vRQa/hsl6W/S1VvayqS+o83KhvtP9UgSIrD2DIEm
 d/YmU2/mYxgXmSt5YYmRxFjqe05lAweOAKasSu2iYKbhmIzKoZo46W05jLfmIuUYT7Q==
X-Gm-Gg: ATEYQzysTBqtrRsm7xPU6VkmfoHlkg3qzMSLo/1Vceg9PDbxV/Lbil0bCUTaS0Rt7/V
 KgpuMzJ7eZLdMU726a0eiiXd8xOHKEQp9LlDMFYpmNDaqyTwgOtEkK4anZ2Eykeo1KgMB+G9dOy
 3iaIe9D+prssF2ddcLOEW+2CXlviTlzwK9kZ2e7KpKJAIcREPSX37+uLOQ1EJ4SM1MfNx1NiwtU
 Bi5RQknXgXI60SVNCVEAGmTshNUjpUhdBGZ29SiQBg6e/PyJCiZOkrht0p7QSfcV1NUqUoX/rDJ
 XlRG+jBSTTmujq489/dgdlEtx2KAdBFWkdCWQQ88J/h5/FORNRrwCaFMaG1WOFhYo62FDWJZF88
 8myELN/zuotaUOXcCPnLjS+C6aI1GuINQGKkpqJuld/LbJ4oK/klumvPBomvnMYZO5ID4FA==
X-Received: by 2002:a05:7301:fa0d:b0:2c1:85a:d25d with SMTP id
 5a478bee46e88-2c930e6bc1emr2065395eec.1.1775057278558; 
 Wed, 01 Apr 2026 08:27:58 -0700 (PDT)
X-Received: by 2002:a05:7301:fa0d:b0:2c1:85a:d25d with SMTP id
 5a478bee46e88-2c930e6bc1emr2065377eec.1.1775057277954; 
 Wed, 01 Apr 2026 08:27:57 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca78df3b84sm38491eec.5.2026.04.01.08.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 08:27:57 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6 13/37] target/hexagon: Add TCG values for sreg, greg
Date: Wed,  1 Apr 2026 08:26:33 -0700
Message-Id: <20260401152657.314902-14-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=L90QguT8 c=1 sm=1 tr=0 ts=69cd3987 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=md9odPwznpFxaQMInv8A:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ElbodzAfXOyvD3PgKTYPxqNSnqHDFGma
X-Proofpoint-GUID: ElbodzAfXOyvD3PgKTYPxqNSnqHDFGma
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE0NCBTYWx0ZWRfX6+eG5oubOofs
 EvukeMgikW65IHYAdzDJ68W9AxrSqPXGV2kmLcZd0EdZTVnRB4loytBlXVXO/nt9rBgXr4kn1KV
 zM1JCRNoZN9besAfjT+iMgDx9nXHZSs+/ZOUXZ/XN+WsjLt16xUaAKaVFbnLUVRdg1zXN1l5fE2
 Dy2fPYn2ZIxezUSv81urDzNUs66XzlLuWLjkIoxZ/YQj46yk8bzuGrogtYjsGuOdLoCO2TvuBuV
 AYaaBKrJIWvbm19YfX1v50QY1xpvjovSfGrwuUfx9+ombtAj90ovkTOni0cSEuugKx8OjFilzET
 A84wkKc+oWdwFufv7uAhtw5umLOeM3fjX/VtFig9AcHu42Ex2ZJMmUYyiTgo6vOkTkya4J9Fab2
 4v1dCUepWdaOUP/UpfjcIrvQrPXc0imaCR2pakqkRG1RkuSqELXEar5o/A/mHtlLa4cYfAANvWu
 HejgoosLVJNmdikorvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010144
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5oIHwgIDUgKysrKysKIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIHwgMTYgKysr
KysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspCgpkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmggYi90YXJnZXQvaGV4YWdvbi90cmFuc2xh
dGUuaAppbmRleCAyODA0ZTA4Y2U1Ny4uNDBkMzY1ZjQyNTAgMTAwNjQ0Ci0tLSBhL3RhcmdldC9o
ZXhhZ29uL3RyYW5zbGF0ZS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCkBAIC0y
ODEsNiArMjgxLDExIEBAIGV4dGVybiBUQ0d2X2k2NCBoZXhfbGxzY192YWxfaTY0OwogZXh0ZXJu
IFRDR3YgaGV4X3ZzdG9yZV9hZGRyW1ZTVE9SRVNfTUFYXTsKIGV4dGVybiBUQ0d2IGhleF92c3Rv
cmVfc2l6ZVtWU1RPUkVTX01BWF07CiBleHRlcm4gVENHdiBoZXhfdnN0b3JlX3BlbmRpbmdbVlNU
T1JFU19NQVhdOworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCitleHRlcm4gVENHdl9pMzIgaGV4
X2dyZWdbTlVNX0dSRUdTXTsKK2V4dGVybiBUQ0d2X2kzMiBoZXhfdF9zcmVnW05VTV9TUkVHU107
CisjZW5kaWYKKwogCiB2b2lkIGhleF9nZW5fZXhjZXB0aW9uX2VuZF90YihEaXNhc0NvbnRleHQg
KmN0eCwgaW50IGV4Y3ApOwogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUu
YyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IGM5NDdkYjg1YWI3Li4wMTQ0NWZk
Y2JhYyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0
L2hleGFnb24vdHJhbnNsYXRlLmMKQEAgLTY2LDYgKzY2LDggQEAgVENHdiBoZXhfdnN0b3JlX3Np
emVbVlNUT1JFU19NQVhdOwogVENHdiBoZXhfdnN0b3JlX3BlbmRpbmdbVlNUT1JFU19NQVhdOwog
CiAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKK1RDR3ZfaTMyIGhleF9ncmVnW05VTV9HUkVHU107
CitUQ0d2X2kzMiBoZXhfdF9zcmVnW05VTV9TUkVHU107CiBUQ0d2X2kzMiBoZXhfY2F1c2VfY29k
ZTsKICNlbmRpZgogCkBAIC0xMDk5LDYgKzExMDEsMjAgQEAgdm9pZCBoZXhhZ29uX3RyYW5zbGF0
ZV9pbml0KHZvaWQpCiAKICAgICBvcGNvZGVfaW5pdCgpOwogCisjaWZuZGVmIENPTkZJR19VU0VS
X09OTFkKKyAgICBmb3IgKGkgPSAwOyBpIDwgTlVNX0dSRUdTOyBpKyspIHsKKyAgICAgICAgICAg
IGhleF9ncmVnW2ldID0gdGNnX2dsb2JhbF9tZW1fbmV3X2kzMih0Y2dfZW52LAorICAgICAgICAg
ICAgICAgIG9mZnNldG9mKENQVUhleGFnb25TdGF0ZSwgZ3JlZ1tpXSksCisgICAgICAgICAgICAg
ICAgaGV4YWdvbl9ncmVnbmFtZXNbaV0pOworICAgIH0KKyAgICBmb3IgKGkgPSAwOyBpIDwgTlVN
X1NSRUdTOyBpKyspIHsKKyAgICAgICAgaWYgKGkgPCBIRVhfU1JFR19HTEJfU1RBUlQpIHsKKyAg
ICAgICAgICAgIGhleF90X3NyZWdbaV0gPSB0Y2dfZ2xvYmFsX21lbV9uZXdfaTMyKHRjZ19lbnYs
CisgICAgICAgICAgICAgICAgb2Zmc2V0b2YoQ1BVSGV4YWdvblN0YXRlLCB0X3NyZWdbaV0pLAor
ICAgICAgICAgICAgICAgIGhleGFnb25fc3JlZ25hbWVzW2ldKTsKKyAgICAgICAgfQorICAgIH0K
KyNlbmRpZgogICAgIGZvciAoaSA9IDA7IGkgPCBUT1RBTF9QRVJfVEhSRUFEX1JFR1M7IGkrKykg
ewogICAgICAgICBoZXhfZ3ByW2ldID0gdGNnX2dsb2JhbF9tZW1fbmV3KHRjZ19lbnYsCiAgICAg
ICAgICAgICBvZmZzZXRvZihDUFVIZXhhZ29uU3RhdGUsIGdwcltpXSksCi0tIAoyLjM0LjEKCg==

