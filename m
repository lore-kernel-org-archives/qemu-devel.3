Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E578F10F6FDB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:31:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7xVC-00025f-Hl; Wed, 01 Apr 2026 11:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xV4-0001qr-Uz
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xV3-0008Hg-6M
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:58 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631Ef3up3174289
 for <qemu-devel@nongnu.org>; Wed, 1 Apr 2026 15:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VD8bHDqIwxQ/ejdGEqcRWpPLOabnnnaX/QlfiL4OvyI=; b=XSnRL4YNVEF2GY7K
 I3TtDyqyy7bTmM6PjyZh50qCJTvdnleOHgTG+LDr0IiPpvai3hA3BRT2QD6Jrtcc
 3L/7ToromZU4rujqPd9OA6kCB42P11D3WZI5vKe1bXDOvGEUmHfSB1vXYwRbQ1HL
 BU8vouA4ju8SYmpjkADmJHyYxgAhjR3dVNU57UWoUP0O5hEKKC4bi/4zOZcTKJTK
 RBcyrmGCyO5lwyrvhufzlvbKhaWB1PUoVOD2QSo4MeKmZ8JLNksGuopo+8BeHtep
 wwJ92XJxfsPiWCpBTxiOv0G6NxIQ8haZUXNjrRqspvV2M3d9ZCRQGXR84s7p6j8z
 q/9U6Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d90gbhpaa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 15:28:52 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2c0ba59a830so8887870eec.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 08:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775057286; x=1775662086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VD8bHDqIwxQ/ejdGEqcRWpPLOabnnnaX/QlfiL4OvyI=;
 b=CkYaQBewTCB4xxuBWhnq7wnZjYjJroKUPooWOjibvLo66dCnWgm60kuhVGZkNHmH1j
 UfP1K6rE7KelfDOmvxy7lkmKcD5312wCxB10nYNMIeCjbODzwKvmNxl9tKpuZeVXSV5v
 JTy6HS/QEwFl0KPHDq00sCzIdpXVPCN/c5RCQSipnfy4c1Y4ya49ZP1h5hddoNg9oO9u
 jqX1iupQULsPmvWTlNGylOmqXOQlmulrVRWw4fcPd8UbTRxM6rk/i+NhjKvMG41zdGk0
 8jlFvk7bxd39ISVb3UYKn2YafevxjVkpr699n2qG/KrTvwAQ1dnRDdxA4H+WH+s/OW0C
 HiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775057286; x=1775662086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VD8bHDqIwxQ/ejdGEqcRWpPLOabnnnaX/QlfiL4OvyI=;
 b=r9jEVZwOZl+NROIk6zBnjP1P+3VLiyFArW50KcRzDRdWIGwHDeX+Vfj7TOu8qZ4UqO
 oU+tjSP4gzFkWX5BFdWB1BEl1jwpEAAI0VLnsM9InOpdsCAwg+O4I0GFhjGco5lz9no4
 tRUyRcst+S+gambKj7scq0SfNcJxZ/VfNJMdImz11ODCC19TSvCFiHX+2R0D5mYPnbFA
 im2racPv70jGUlLRkWYdjUZGst4kzHbWs6zEbHeaAoeIswNm2qsv0xv3PAdGYflH/S5w
 5ZuigwTtK/8kQISCx8DIsoQNTS/4BHgy+WK9bpo2fD13WweUmSyq7A1cyuyzq9Sv5L0G
 pfGw==
X-Gm-Message-State: AOJu0YwuQp+/yaQELTIbpSptVZMIEnpfsz5/0jAn6bbXAJmegojWiRUs
 2DiT1wAkrYxVIWwJ7G/vKIMeWcnGKmDUAl383H93BZNjx2EVI+6qBbszR7jwBd7EU8piFch7YRO
 QCnFNyszF744sKFIsQWpCMPrQ2mqvDxcu+yErDfYVUrbJg6HoOw+AvImPVxxUm+r7ug==
X-Gm-Gg: ATEYQzziWAG+7HbkFWJDqF3c6dth0UL6A+tcq+62102Rnx0di4Szg0s5Nb/v/7ibJRZ
 m2ZTl7+QBkZ4QT82s5nvB7+2sHGL++ACtFnue6dqrWn5xviubqROsiCzrio0EDMLLDyuwoNYu4W
 1/E/MrzKZfg6YbtoFzUWAkMMTQOJ98pgU78l0dixBDFTs/LAGis5ot86GZc7Wf2k1nsmUIO1DD6
 p5lVSPFBZArhoOkGuNhlQzog8YKImHURvy68WjI0omcFQjYxmO8SOWvQNNcstQyQTWPpXB/ELdI
 xAAYZvAT7Ga3DYEFZrvZzWCQW6zeeFvNW6xOqqB5tnVB2XV7Zhmf5g5cLeYBUDNOWJlx0YVasru
 oEXiwdFoL0yKC54GQAqGVKs3LS/2O0lNryTDWSCZaRoFSOF/kXsBnqi/IItlFH6316riiXg==
X-Received: by 2002:a05:7300:d50c:b0:2c5:704f:714a with SMTP id
 5a478bee46e88-2c930c77e37mr2311673eec.8.1775057286352; 
 Wed, 01 Apr 2026 08:28:06 -0700 (PDT)
X-Received: by 2002:a05:7300:d50c:b0:2c5:704f:714a with SMTP id
 5a478bee46e88-2c930c77e37mr2311639eec.8.1775057285709; 
 Wed, 01 Apr 2026 08:28:05 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca78df3b84sm38491eec.5.2026.04.01.08.28.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 08:28:05 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6 22/37] target/hexagon: Implement do_raise_exception()
Date: Wed,  1 Apr 2026 08:26:42 -0700
Message-Id: <20260401152657.314902-23-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE0NCBTYWx0ZWRfXyBJS+yfT29EE
 j7qCWX67rYpOzmLBPc6QOrIyW+qp4xqpz0IFJOAPGWFBxxEYkwksQj8Zxo1XbSDH2ABV0y1YH+A
 hBTOFlnfImCfNpoczhPD/u8Q+/STsqmcCZxV0T6K4BodsanWYm244JQTdlFqLlLJd4Jtuo/FDlw
 SjKYO7j96W5dqHh0YDHXwAe/FueEGw9xb0rUevKIKQhAgbfUsvhXkDTXPVySfwXrxpLpRQpovJe
 n4mDQbD5nBPDD5j/QG5yFplTtCyA46ftKPf9S+eNaG2JOWiklGa0gEOsx5h42aCLgVBnPuHc0sW
 kB3T1dUxdK9nZEEURODHV8SPYeTFoW8/Z8gFBMWB2CDJ1168rwcLp8P8R5RYY2mx2xc1Pap/YBD
 BIzxxqk3hfI9rbR6Qj5g1kPs1r8/lyWubHLPczjHuRtSj5esMwdMuWc7NFckyChN6RBDQPCliTi
 /jg/Vx6CJNvziTiyzlg==
X-Authority-Analysis: v=2.4 cv=QJJlhwLL c=1 sm=1 tr=0 ts=69cd39b6 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=hK29HtBGQMdOITfcgGsA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: rkGxaKH2r102BGZnbXqep49AQLfNwdNj
X-Proofpoint-ORIG-GUID: rkGxaKH2r102BGZnbXqep49AQLfNwdNj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010144
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2lu
dGVybmFsLmggIHwgIDUgKysrKysKIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIHwgMTQgKysr
KysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL2ludGVybmFsLmggYi90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5o
CmluZGV4IGNkMDZmZjQxZDRmLi4zM2Q3M2VkMThkMSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vaW50ZXJuYWwuaAorKysgYi90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5oCkBAIC0zMSw2ICsz
MSwxMSBAQCB2b2lkIGhleGFnb25fZGVidWcoQ1BVSGV4YWdvblN0YXRlICplbnYpOwogCiBleHRl
cm4gY29uc3QgY2hhciAqIGNvbnN0IGhleGFnb25fcmVnbmFtZXNbVE9UQUxfUEVSX1RIUkVBRF9S
RUdTXTsKIAordm9pZCBHX05PUkVUVVJOIGRvX3JhaXNlX2V4Y2VwdGlvbihDUFVIZXhhZ29uU3Rh
dGUgKmVudiwKKyAgICAgICAgdWludDMyX3QgZXhjZXB0aW9uLAorICAgICAgICB1aW50MzJfdCBQ
QywKKyAgICAgICAgdWludHB0cl90IHJldGFkZHIpOworCiAjaWZuZGVmIENPTkZJR19VU0VSX09O
TFkKIGV4dGVybiBjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9oZXhhZ29uX2NwdTsK
ICNlbmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgYi90YXJnZXQv
aGV4YWdvbi9vcF9oZWxwZXIuYwppbmRleCAzNTliZjEyZjFmMi4uMzI3YzIzM2MwMWIgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jCkBAIC00MCw2ICs0MCwyMCBAQAogI2RlZmluZSBTRl9NQU5UQklUUyAgICAyMwog
CiAvKiBFeGNlcHRpb25zIHByb2Nlc3NpbmcgaGVscGVycyAqLworR19OT1JFVFVSTgordm9pZCBk
b19yYWlzZV9leGNlcHRpb24oQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IGV4Y2VwdGlv
biwKKyAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IFBDLCB1aW50cHRyX3QgcmV0YWRk
cikKK3sKKyAgICBDUFVTdGF0ZSAqY3MgPSBlbnZfY3B1KGVudik7CisgICAgcWVtdV9sb2dfbWFz
ayhDUFVfTE9HX0lOVCwgIiVzOiAweCUwOCIgUFJJeDMyICIsIEAgJTA4IiBQUkl4MzIgIlxuIiwK
KyAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBleGNlcHRpb24sIFBDKTsKKyAgICBBU1NFUlRf
RElSRUNUX1RPX0dVRVNUX1VOU0VUKGVudiwgZXhjZXB0aW9uKTsKKworICAgIGVudi0+Z3ByW0hF
WF9SRUdfUENdID0gUEM7CisgICAgY3MtPmV4Y2VwdGlvbl9pbmRleCA9IGV4Y2VwdGlvbjsKKyAg
ICBjcHVfbG9vcF9leGl0X3Jlc3RvcmUoY3MsIHJldGFkZHIpOworfQorCiBHX05PUkVUVVJOIHZv
aWQgaGV4YWdvbl9yYWlzZV9leGNlcHRpb25fZXJyKENQVUhleGFnb25TdGF0ZSAqZW52LAogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBleGNlcHRp
b24sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnRwdHJf
dCBwYykKLS0gCjIuMzQuMQoK

