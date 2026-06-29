Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28891C44501
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBno-0004it-6D; Mon, 29 Jun 2026 09:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBnm-0004ih-Nq
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBnl-0003Fr-0B
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:30 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TASuqi2640837
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SxgjDN8stbE6SIBeFPtrecas0sgHajmcu/RG683JGPg=; b=WsusiH9JaYZP+KGk
 QV0/0hGY1s9UJqSADnktKRDb0lcqivqvmwSj3Y8zS5Vf4TFr5wtbdLinKXwgQMSP
 yjFgE3LpvByi4dqWeR7DtmUAUD8q+GdFp8NzIb+f7dPSEjN/+2V9msx4YrxCu4tT
 93Pk88Nfm9KCuu/UowaQ68dimanDjXoCjWkuI8IqNukjwHPyuV3P2zAlFgUrbIpj
 RRpUgo9qInQ3KMkEdUU7mtnFQ7VCHfRgHRZjd5hppYqMB2I3a6eWybt06I2Rmxb8
 L0nI+0y4PCSnAJKFWUphj/TU/TvD2Hkn4nwHb5Ua/icMWKDTqEpVJuJk4L0EqVp6
 k/zj9A==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3n5s143v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:27 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-13b0686d13eso1427513c88.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782738807; x=1783343607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SxgjDN8stbE6SIBeFPtrecas0sgHajmcu/RG683JGPg=;
 b=eH9z69xOyoRG4NxmfNdV8/N5ImOLad+iBwmg+Ksqd53WLdccuduRwpCsjeM1MIGqDN
 2Z8w2G5Q1PMfa7b0SekPYLmOl6cTQ3mgkdKUaemhReer3QpolTljtHyhzv+3FuCLexDu
 9wCctWmrgJq/jhKLMjZDEjUEnXIipgLsO42UuZiU6YMBGTLVj7tkh+g78awgaWcghSpB
 /rdF/RkkvSDVFXWh7AbymSnpTsltnp01V0WLeeKeu5PScw/+9oSLrPKuFkErLnauw3ul
 3p/lt5av6JLvnRC1zTfoBAR5rtiUQjO3p7yeKa93gLMNF5Q9lmUMH8eEIYem4jpCZtKs
 +NcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782738807; x=1783343607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SxgjDN8stbE6SIBeFPtrecas0sgHajmcu/RG683JGPg=;
 b=DxPnkWPiEHBm/1lh0H3w7JMHjwAcbjUKzx/+Ivq/5l60JoiIe+9nx16YqtI7dTlB/v
 ff0Q5Sv+FOcxCndbXvxBNQOB80zOszsgL40dSaDfsaVFNW/82ySXkm3L2UYSpUxegCA8
 11qnR5SgBjfR+w8v3LQDpLIUmhEq4z/DCVthBQ1dTNAAkxQsKeL0XyQc6yGgdHJzvQez
 BJB+uc1M1cjbf4ln8qtvRnqD0Tjx45Vz3yB97921XUKtuQfBXQrIxxY6Iv3ntK8hDcLN
 wXCuM8RgxCkcn9G4DhOXunaqQaaGD8fYsxF0KJ5i7qGTVJ7mto9jQtGtVZAOCmyb1Fq1
 QvBw==
X-Gm-Message-State: AOJu0Yygvz7kLLZ7WPSvdVefPN1B+v7sgv+di5zfQJBGbFwtUAHOuD5r
 /PUAtUOAqu0sA2KgCwMcTKChceA/7z16Lbz3lhd6DDhsZK5MODrn70SqY2unAvi26N8+8SyhsxS
 v7LDMWuKsLK1DR/yDJtDccDM+GgAyczR346vqtu5/5z2EIxFtrFZSooYnxRN2EjaDwA==
X-Gm-Gg: AfdE7cmVEKzKxbEFED37LEZ1gxhowTiu2FM1E2C16byMChYLszfb2943nLVoIrz6BKr
 pNlQaK1IQ60zeOT63rTjcxhjjxRONbVHpKspPYvXDrIXVRUEWluDGLsmUQontd4tlGRefEYNgGR
 LbunkZKy1gtgf00+XkKrSBj+SEAmPqt5Adk0IjSxRnGhbBViRzqOo74FusPnTa1DpjvLCbUDcd0
 Af06ZMN3X+WZRQZ5pU6EGobHI0YnDCqeV7wd1IW19ZDY1trrJ+gNUTy4UuH3SZiP5NOMcZPAmkK
 UcHMzHzFnp4CUQEiHv8qi0Y5s3cHMMGMX5pS5ubWTlLbzlEqfogvchoolEuuHUKFJXFTOwPEJ1F
 J6eVD3vBCNGis1zbs5vgfxri1BQR4LJFGFVpyxXCIt3Rr2b/iI3EHQnww8oY=
X-Received: by 2002:a05:7022:e11:b0:136:ac69:b0f7 with SMTP id
 a92af1059eb24-13b226b5ac4mr455821c88.16.1782738807032; 
 Mon, 29 Jun 2026 06:13:27 -0700 (PDT)
X-Received: by 2002:a05:7022:e11:b0:136:ac69:b0f7 with SMTP id
 a92af1059eb24-13b226b5ac4mr455786c88.16.1782738806433; 
 Mon, 29 Jun 2026 06:13:26 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139e78317f3sm28459106c88.9.2026.06.29.06.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:13:24 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 29/77] target/hexagon: Add TCG overrides for int handler
 insts
Date: Mon, 29 Jun 2026 06:11:44 -0700
Message-Id: <20260629131232.2487780-30-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX/SeROTPYJATh
 UWwJZ7fuYSHFGyZfPe1tvFQLdNNHgq+ywNjrsxOuwJFDv5yd2u/0aog0HlYQjDHN1GMsrmuCDAs
 RcUlei+fEmpZ3Zgi/+4YFcoWpydmLgM=
X-Proofpoint-ORIG-GUID: bf4T1qRT17SFNgEeyoi6PFh7ZljP4tLC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX1L+hU24nHwYr
 L4qrNwrOP30/Kr0pb8D5XtuehZ6rkf2lMaJ0qgDiQ9o38J/nE5UlLDYaQw+DHUI12vprKXYDOIX
 CWRWdfFJsv05jW+oHzj/lB2H0ALcZzzg+8unIrHHX8hCJwjrhmJiojzkQe+brePTrnHHTLYHNiW
 yH0e2a8u43oGAobHMYn0XbDrshy96yCol+o8hYK4SYzuG4USuCSb/Q2enORqZYp2fW6GSJ367NO
 ry3N4jjHjNfJKSq94nxM3QK9TPys8PY04OqScSI3C4PBqe2yjgy+uq2DDZkJnzVfZDn8oOHe+tO
 RtLoIIOBOPwX9mOFwmjL/ydjjaXsn0R6qZvgPW4ph3Xg/74rwEjCVPL27VO8pd6Qzx57uOJses+
 IqBFtd8sNyOCM+fkrwskeGqhb0nbDOf3FJALzpvezmXLcVJgyuYyZWBIoV0qgzDtN9IdjgEoRLM
 tMch92Y/OX+m+KOk25g==
X-Authority-Analysis: v=2.4 cv=NZzWEWD4 c=1 sm=1 tr=0 ts=6a426f77 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ncxFUDX8U6Z2rYVbhVQA:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: bf4T1qRT17SFNgEeyoi6PFh7ZljP4tLC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290109
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpEZWZpbmUgVENHIG92ZXJyaWRl
cyBmb3Ige2MsfXN3aSB7YyxzfWlhZCwgaWFzc2lnbntyLHd9LCB7cyxnfWV0aW1hc2sKaW5zdHJ1
Y3Rpb25zLgoKUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFp
bC5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21t
LmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oIHwgMjUgKysrKysrKysrKysr
KysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vaGVscGVyLmggICAgICB8ICA4ICsrKysrKysrCiB0
YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAgIHwgNDAgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDczIGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3Rj
Z19zeXMuaAppbmRleCBmNzhjOTYzNWMzZi4uNGNiYmRkMWY3MGIgMTAwNjQ0Ci0tLSBhL3Rhcmdl
dC9oZXhhZ29uL2dlbl90Y2dfc3lzLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMu
aApAQCAtNyw2ICs3LDMxIEBACiAjaWZuZGVmIEhFWEFHT05fR0VOX1RDR19TWVNfSAogI2RlZmlu
ZSBIRVhBR09OX0dFTl9UQ0dfU1lTX0gKIAorLyogU3lzdGVtIG1vZGUgaW5zdHJ1Y3Rpb25zICov
CisjZGVmaW5lIGZHRU5fVENHX1kyX3N3aShTSE9SVENPREUpIFwKKyAgICBnZW5faGVscGVyX3N3
aSh0Y2dfZW52LCBSc1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfWTJfY3N3aShTSE9SVENPREUpIFwK
KyAgICBnZW5faGVscGVyX2Nzd2kodGNnX2VudiwgUnNWKQorCisjZGVmaW5lIGZHRU5fVENHX1ky
X2NpYWQoU0hPUlRDT0RFKSBcCisgICAgZ2VuX2hlbHBlcl9jaWFkKHRjZ19lbnYsIFJzVikKKwor
I2RlZmluZSBmR0VOX1RDR19ZNF9zaWFkKFNIT1JUQ09ERSkgXAorICAgIGdlbl9oZWxwZXJfc2lh
ZCh0Y2dfZW52LCBSc1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfWTJfaWFzc2lnbncoU0hPUlRDT0RF
KSBcCisgICAgZ2VuX2hlbHBlcl9pYXNzaWdudyh0Y2dfZW52LCBSc1YpCisKKyNkZWZpbmUgZkdF
Tl9UQ0dfWTJfaWFzc2lnbnIoU0hPUlRDT0RFKSBcCisgICAgZ2VuX2hlbHBlcl9pYXNzaWducihS
ZFYsIHRjZ19lbnYsIFJzVikKKworI2RlZmluZSBmR0VOX1RDR19ZMl9nZXRpbWFzayhTSE9SVENP
REUpIFwKKyAgICBnZW5faGVscGVyX2dldGltYXNrKFJkViwgdGNnX2VudiwgUnNWKQorCisjZGVm
aW5lIGZHRU5fVENHX1kyX3NldGltYXNrKFNIT1JUQ09ERSkgXAorICAgIGdlbl9oZWxwZXJfc2V0
aW1hc2sodGNnX2VudiwgUHRWLCBSc1YpCisKICNkZWZpbmUgZkdFTl9UQ0dfWTJfc2V0cHJpbyhT
SE9SVENPREUpIFwKICAgICBnZW5faGVscGVyX3NldHByaW8odGNnX2VudiwgUHRWLCBSc1YpCiAK
ZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oIGIvdGFyZ2V0L2hleGFnb24vaGVs
cGVyLmgKaW5kZXggNTQwNTM0MmY3OTguLjk1NTI4NzEzM2U0IDEwMDY0NAotLS0gYS90YXJnZXQv
aGV4YWdvbi9oZWxwZXIuaAorKysgYi90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaApAQCAtMTA5LDYg
KzEwOSwxNCBAQCBERUZfSEVMUEVSXzIocHJvYmVfaHZ4X3N0b3Jlcywgdm9pZCwgZW52LCBpbnQp
CiBERUZfSEVMUEVSXzIocHJvYmVfcGt0X3NjYWxhcl9odnhfc3RvcmVzLCB2b2lkLCBlbnYsIGlu
dCkKIAogI2lmICFkZWZpbmVkKENPTkZJR19VU0VSX09OTFkpCitERUZfSEVMUEVSXzIoc3dpLCB2
b2lkLCBlbnYsIGkzMikKK0RFRl9IRUxQRVJfMihjc3dpLCB2b2lkLCBlbnYsIGkzMikKK0RFRl9I
RUxQRVJfMihjaWFkLCB2b2lkLCBlbnYsIGkzMikKK0RFRl9IRUxQRVJfMihzaWFkLCB2b2lkLCBl
bnYsIGkzMikKK0RFRl9IRUxQRVJfMihpYXNzaWdudywgdm9pZCwgZW52LCBpMzIpCitERUZfSEVM
UEVSXzIoaWFzc2lnbnIsIGkzMiwgZW52LCBpMzIpCitERUZfSEVMUEVSXzIoZ2V0aW1hc2ssIGkz
MiwgZW52LCBpMzIpCitERUZfSEVMUEVSXzMoc2V0aW1hc2ssIHZvaWQsIGVudiwgaTMyLCBpMzIp
CiBERUZfSEVMUEVSXzIoc3JlZ19yZWFkLCBpMzIsIGVudiwgaTMyKQogREVGX0hFTFBFUl8yKHNy
ZWdfcmVhZF9wYWlyLCBpNjQsIGVudiwgaTMyKQogREVGX0hFTFBFUl8yKGdyZWdfcmVhZCwgaTMy
LCBlbnYsIGkzMikKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFy
Z2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggMzIzNmNlMGM4ZjAuLmM5MGI3NTcyNDE5IDEw
MDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdv
bi9vcF9oZWxwZXIuYwpAQCAtMTM5MCw2ICsxMzkwLDQ2IEBAIHZvaWQgSEVMUEVSKHZ3aGlzdDEy
OHFtKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgaW50MzJfdCB1aVYpCiB9CiAKICNpZm5kZWYgQ09O
RklHX1VTRVJfT05MWQordm9pZCBIRUxQRVIoY2lhZCkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVp
bnQzMl90IG1hc2spCit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKK30KKwordm9pZCBI
RUxQRVIoc2lhZCkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IG1hc2spCit7CisgICAg
Z19hc3NlcnRfbm90X3JlYWNoZWQoKTsKK30KKwordm9pZCBIRUxQRVIoc3dpKShDUFVIZXhhZ29u
U3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgp
OworfQorCit2b2lkIEhFTFBFUihjc3dpKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3Qg
bWFzaykKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQorCit2b2lkIEhFTFBFUihp
YXNzaWdudykoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHNyYykKK3sKKyAgICBnX2Fz
c2VydF9ub3RfcmVhY2hlZCgpOworfQorCit1aW50MzJfdCBIRUxQRVIoaWFzc2lnbnIpKENQVUhl
eGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBzcmMpCit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNo
ZWQoKTsKK30KKwordWludDMyX3QgSEVMUEVSKGdldGltYXNrKShDUFVIZXhhZ29uU3RhdGUgKmVu
diwgdWludDMyX3QgdGlkKQoreworICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cit9CisKK3Zv
aWQgSEVMUEVSKHNldGltYXNrKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgdGlkLCB1
aW50MzJfdCBpbWFzaykKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQorCiB2b2lk
IEhFTFBFUihzcmVnX3dyaXRlX21hc2tlZCkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90
IHJlZywgdWludDMyX3QgdmFsKQogewogICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Ci0tIAoy
LjM0LjEKCg==

