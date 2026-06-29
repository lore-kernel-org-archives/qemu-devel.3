Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB68C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we39u-00021P-6c; Sun, 28 Jun 2026 23:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39c-0001fk-Sv
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39b-0006KM-6M
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:28 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T2ctDN1514090
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SxgjDN8stbE6SIBeFPtrecas0sgHajmcu/RG683JGPg=; b=Ce4RWQMRALHjlolO
 NtGm3cX4gofOYCPxyfYN/xunnArCfjIHL5I546dwuwNikUNx4dClsNXP/limSPca
 O2L9yCD39C76CHflu+8j+ekjMtL0Lxtu2CAE3eCzqzNkGNhXacjrZOAVw8hdLrPZ
 JaHssOEQeoPJsIb3exgVa1qEZ/F6xIZILnTCV9vA4GV7DyHkiJhVtOwZWhibl6Iz
 SkMqPVx0gHWNMIcofuk0fU0YRe324o7YLze6ZUblVXVFSMnSFIEbsUgDAn0IIHw8
 PdzEnZceYeRqSKtClnH3at6hPpwgV+Zr941lKoocbkGD52QG4/p6X+xoYTXBsurW
 o3ky1w==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f279cm8wq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:25 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-137f3465368so2930648c88.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 20:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782705565; x=1783310365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SxgjDN8stbE6SIBeFPtrecas0sgHajmcu/RG683JGPg=;
 b=HCh65J7bHhyvpJ6ugNa8EUUmT9BMlq0KYGwUWpMxbt7kt+kMQ+XFdcIuptaaI5wYY1
 In/ZAe1m5B+87ur12F6dGSaSJnkVgxo44GiFdLPar8IE6CjbTjhAuNNtPDN6cAKXzY3M
 /UDiKoqILA7KcVi/Zrd3fcZYUSuHkXmlsqmalXq9SE2f+Qnwjly4iuRIjR73MfK/BnHN
 W5M3C3uK7StM2VdMmtt3V8PYcC5fNBjFk3H/57n6HrF821Gr1mcAmpAURyC/x376lcSL
 pVsPALidKt464aqXQ+XSkWZXtyg46zKolIaALApUPx1S+6MXHqTzrfXmd6yGzrh0tZ8e
 2ltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782705565; x=1783310365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SxgjDN8stbE6SIBeFPtrecas0sgHajmcu/RG683JGPg=;
 b=GD2ufw2bqgGrvIIPlYPIBi83PNEZTNUnawCfg199i8PIiVwNKs8GV2dau8R0HfunRm
 a+7pO3rmaui/XUOjOKBwgUn9wJ8rMBsG4frkOYYDaXHcqiZjRvjBo9LKSh7AsnVC9E/b
 awjTVgYWVNAPRYd4zzupNkVzdcEzsfUyrjY8QnLMbiPXEDdK6AA2B2ERseX2sxro+Zh2
 T90Xm4lpi3XvoBPFmZnAaoKh1RNzB+4vtlp/D/4xjyfxD9MXWz1/Klwj21cnvq/IO9nL
 IzfN++q9Xbgstj/tiYPBc1UkIzmDEOQ9CMizKxu6SoIwTC//CPWPDS+LEJnqElRkuTAG
 b3ig==
X-Gm-Message-State: AOJu0YwQ0GXkLwk1dWHzD3jCMRNnTtxC5mwRY7v8Suh3LYiQdgQMmjH8
 /d2YCp5fYBLD7fgZEQNnUi2fLUv9UJnhbuVgCcTV3Y+4Kce1Lt6nPv1kvq6yoNNu5leqpBXqd5l
 c/DZG0GPleEujlCJPXaLPCN3cgqrJHdy6tQ4uKzuavr1Hz7PSOItrs7GD0ChuwWLHdQ==
X-Gm-Gg: AfdE7clpUI7ENwrvG6g5pHYMxbzmplcQSwI9watah2lfQ/LD2VqNR0DULvHikbWnM9b
 1gYfeBEe352+/T8kp12xxrG19y7sN8O8DXPifuMjJpYGcMtMUxjIQ47jmWZjrEkss0PDnKNbHQH
 3z5BO6c+y4sXWI5bT/cmfPMq5rzsISL4qLPk835Sw1iPHCfxlVBgZCh/RjLWGzv9IKhEQq7xoJ/
 y3aIC+NW8O4G7BkDWO8c0gDh9gTDm5QT0a2gt+uKH5GswQsAXzlVZLWBKF2O1khq+9gZvTIRPkL
 XufADeKjiXgStonw/jYx/pMol51/cvVnDbp2Q7papWxoY9NjML2ymKhU0OI8bBI19UF6B1ffJZU
 L88CaP03zj3CKS9zsBzsxdXVkMNFHr68aXHdeLuYpyYSZIAexh/sFqCe+acc=
X-Received: by 2002:a05:7022:ff47:b0:139:ceca:20c5 with SMTP id
 a92af1059eb24-139dbb90706mr11408392c88.19.1782705565032; 
 Sun, 28 Jun 2026 20:59:25 -0700 (PDT)
X-Received: by 2002:a05:7022:ff47:b0:139:ceca:20c5 with SMTP id
 a92af1059eb24-139dbb90706mr11408375c88.19.1782705564485; 
 Sun, 28 Jun 2026 20:59:24 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139fc2ebcc0sm8367088c88.14.2026.06.28.20.59.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 20:59:22 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 29/77] target/hexagon: Add TCG overrides for int handler
 insts
Date: Sun, 28 Jun 2026 20:57:42 -0700
Message-Id: <20260629035830.1520296-30-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=evzvCIpX c=1 sm=1 tr=0 ts=6a41ed9d cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ncxFUDX8U6Z2rYVbhVQA:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX+ZvvI8Pj2Ilr
 Vimz/OtKyaVGorRzddrym7lRGk0RpXfwXuCBc6zjX+hOkaC7vephmUf1mnfQE6zeS9ro6OKWIso
 VUEITudg4Ho/jbGZzQVSM1F05Oka3kk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX37w7WkGr3E5h
 R65CFjT7/4LOFb+GQY5IdWIX1pHOTjkhArLg/k29rdqFrbDyP0Jm8gb/zTRnOf32qhwkduc/Liu
 h/y0vUEFsvA8kJ1/hMJmQKEKkTA9Uvb6ng2eWs53hPT5mfll3kptGeiJplm5uNmcbTee9+uyOGk
 WBFHskDe/zc/ntm07Z8DttN9NXNSg1RnqeYTlDS2dfrOaZr17zelf0y/A0JZAeCUxhTEZVXdKbv
 6q8pc6sHBJsXdjhg3WfOfNkbv90OnGDPjazqV3/41x3H8WLQmye6qN+f1m9j3mL5BU+NRJDNm6n
 QT9S3vjNG54pHCgHQ58KQNkIxDBof87giPc6LYNXdY7hecrFaw/iwTrzl/DaDRAxlZfUMRdMOeC
 WOUygRpgn+FUIq1rQv6PNnwY5wwTzy+XtBK3oWf+4yunN3IwO3yroX3vQeLy3c2xAQLDO7doORi
 LafbXo/jKsAy+LurwWg==
X-Proofpoint-GUID: mM0SqfhzAYJqZ0zrJC1qP6PTdMh1fYyF
X-Proofpoint-ORIG-GUID: mM0SqfhzAYJqZ0zrJC1qP6PTdMh1fYyF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290031
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

