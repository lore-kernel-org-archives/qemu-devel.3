Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7281AC43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we3gd-0007Xj-C9; Mon, 29 Jun 2026 00:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3da-0002uk-Nn
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3dU-00015F-J3
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:24 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T4NJEV1780994
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Yp87kcoinbDBfUm50phdJD1Q0SWWmLVPCkRoyO7PWUc=; b=m2AXefKDBUw513Ug
 46ZAvlHDO7HzhntX2Pu2r9IWVEsm2ma6MSmBuOkUy2QVuGEOUlaRh0m7Hd+pLKkk
 A2B2W9/F28jArHToxZ6+4DAL+PESgUNy72zYh4Sl+HaZ+CPfaDYytjNpaDtsuzbn
 X4d5dtJyQ0UGN57PuYoNyhnhu/BBRz/ZcjBvk50vRFTOirWUVCDYy5p2M77dKH0A
 aSQRki93o/fJ2DwzCLHStRbmcAfuquG2618wkkF1dZLWbQYxyG2vljuhBpId0mOY
 vDJf/pmwAsm4TT5KrUKxbB05CJ2KmtjL0JSsNHuT9vUY8q+BP4isk2XJ2DSHxDiw
 gG23pg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26u74gjs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:30:08 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30ca3374c6aso7999354eec.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 21:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782707407; x=1783312207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yp87kcoinbDBfUm50phdJD1Q0SWWmLVPCkRoyO7PWUc=;
 b=C7kB4geUlvr0IbK7LZWEp+ZxsbORo+/omOdqKW3ZRqxDP2tqqOt6hxmz3AkTxTdB+a
 MS3pDpzNp6TArOCJQhS8Uwoqo4TxMN1JmsDLPui9yfVNo9hvoHroNmfX0gcFPTvhdyGY
 JzKV4kNxkK6vJP1rhZMYVq07Br1mkL1Z/lsPn9v4kpe7Dlp0/wCrYYUFcBzl9msXLn84
 /dDyMlPAGdahlf8+VD38Pf3H68i7jt9n71ZS5hmplMW4QOTXdrsn2ooPf76KCdOZkN88
 xXeDEuzyvIn8UHohwwaNArzJ9NQwYuqmecpyR6g7X893htI4LvQW9b2XhS+O+6XhhLvZ
 ttnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782707407; x=1783312207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Yp87kcoinbDBfUm50phdJD1Q0SWWmLVPCkRoyO7PWUc=;
 b=tTClaplfzIVXM/FWA+OEhKN5zp+URAPFEDwkjC/u9QhIqGAIGjEOTfGH4IKhh287Ap
 54iGYmKt+rcuRQMLUA4I2JsGKqoV+fuA0Hl6Ou9APovdimJasFH19WTNkgXQsiObvyJ0
 eDJ6J3u91ub4eqraXd6rRD2gkuCZnBzsvbu/5pPPFVZ5g28beondf1UHIgJLcfcuT7IS
 Mpef4HmDRVG5YP45Aa39mMlp+Vq3ZjzDwHAqmBtVrZNmy380yAWQ3bMssBUB4ZSm9xFD
 pF1a75zBs0mHpa/Z1F9+k3kFbrizvG7HFT1F/aYKgMf8GX3iNOVt+zqS6y0ftkZPJO7i
 /Ivg==
X-Gm-Message-State: AOJu0Yw7QUak5DwW3mcjaryw3rjHvv9/zvH+qI5pXSinmdJk6qQGPU1v
 OP0tkIjX1bmRnafgJPt0fpoxQhdBY4QG9Cna/CKaHR5kS2GmwXwN2w8byNXzZhCfhjVLVc0wTcA
 jLfAS/7y7BJAnk5XrFxVq2FP3gheplDJ8DbuvnpxMoOCXpboS4NOS7dV2ESzWdRLu8A==
X-Gm-Gg: AfdE7clS6/FNGRxTI5SQAwMbkAJhEjJd96n4oRA0eJLhAEBRXE02dDtGv2GE0xiIMIl
 hMNtp2sQXEu4Ld3ngdz8CrUs3GOjjxI6xKPikLdtB0YZu4abYQc+sjbn9u6P2Mt0rnw6l1bHtg1
 2UiaSOXClJ8H2/CUxY4uDf59rf1n8ds3QDabGx6rufVaMsSFq2xLrC14v5m4ZgKkn7iJxkMT8XL
 YPgdJCfIVHJlh5gaAbpvJDUGL6vO5oVz/U9PoGp1mKREVTkPHN4StTkO/y/OZpFg4neS94WkDO8
 WRo0JlXx675rRRUQHOLq9zmS6uJHeLUO+KhmM93LYrp4KSNSHygF8llzgmtPTFJDU45nEfFSI6a
 ZJsjfhKmV85QxNBwKus85tfu3T67NIYAa/stzXv3C5eRojffZT/OD7vfEmis=
X-Received: by 2002:a05:7300:2211:b0:30e:be3f:e7f7 with SMTP id
 5a478bee46e88-30ebe3fea66mr3631340eec.15.1782707407188; 
 Sun, 28 Jun 2026 21:30:07 -0700 (PDT)
X-Received: by 2002:a05:7300:2211:b0:30e:be3f:e7f7 with SMTP id
 5a478bee46e88-30ebe3fea66mr3631320eec.15.1782707406644; 
 Sun, 28 Jun 2026 21:30:06 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30d3af0d2e4sm21314609eec.22.2026.06.28.21.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 21:30:06 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 61/77] target/hexagon: Add next_PC, {s,g}reg writes
Date: Sun, 28 Jun 2026 20:58:14 -0700
Message-Id: <20260629035830.1520296-62-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX1YFkngJcnDUu
 RzdaYlI4qgk2uzWYhSe2ixRHUIgk/4/aCETDY+EKdkjp+ObDnJjGzSUSIqRYlQf6gwsn2Ln+AYg
 /FQcD/AyV0AEk5X+/YI3JDXrPe/iRUs=
X-Authority-Analysis: v=2.4 cv=ftnsol4f c=1 sm=1 tr=0 ts=6a41f4d0 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=fJQQT6FIS2xgNqPK2MMA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: D085f_0i5f8NU6azcEwv_h7SUj1zdCWS
X-Proofpoint-ORIG-GUID: D085f_0i5f8NU6azcEwv_h7SUj1zdCWS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX5zK1Xy0G1Iq8
 WDP92HllPWy+dulNugBygyHtxTfLNxyQ/GOI98Z0siTYi69ZO6SAtf5UqS12Suu65Z6DV8RYpWI
 P87cXO0rzFsiM7i5Q/Q73nIMKu9ZFNEIT0TDkrgoLEQpWAYgrznOGpje/YvF23w35sHnIggoFc5
 qOAjus8xf7sZUXFrmJ9OvYs8eFdSy7ONNjbcx8WFnWeViWJ8FZiYJglq7ln3KCN4w5nrk6wI2oF
 FC+/qiedRZkh7YFx2FBfrVxhXgvjRbzi2dymPA/ZbwFyuaVXs0jvzWcDWqH9Ioii4ekUgcGpoZk
 o0nvyozF+WxWBXEZxcF5k8FzgPYwrXmcohuPohvEgKd10u3JH3E3dWuS6+5IVIE0NHjdJ7yaOoI
 39tOnqvAM0Kn2OJRJk0AhqZwF1p8xO9TfPydL9KrqC0UIn6hjXfM7GuDJ0mTYR6JlwA4NoKnU0M
 B0CwexRvyvvYHkqqF1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290034
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogUGllcnJp
Y2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2Zm
LWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0
L2hleGFnb24vdHJhbnNsYXRlLmggfCAgMiArLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMg
fCA3NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQogMiBmaWxlcyBjaGFu
Z2VkLCA3NCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL3RyYW5zbGF0ZS5oIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgKaW5kZXgg
ZmVhODhjYjJkYjcuLjBhN2YzN2Q1ODQyIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFu
c2xhdGUuaAorKysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaApAQCAtNDYsNyArNDYsNyBA
QCB0eXBlZGVmIHN0cnVjdCBEaXNhc0NvbnRleHQgewogICAgIGludCBncmVnX2xvZ19pZHg7CiAg
ICAgaW50IHNyZWdfbG9nW1NSRUdfV1JJVEVTX01BWF07CiAgICAgaW50IHNyZWdfbG9nX2lkeDsK
LSAgICBUQ0d2X2kzMiB0X3NyZWdfbmV3X3ZhbHVlW05VTV9TUkVHU107CisgICAgVENHdl9pMzIg
dF9zcmVnX25ld192YWx1ZVtIRVhfU1JFR19HTEJfU1RBUlRdOwogICAgIFRDR3ZfaTMyIGdyZWdf
bmV3X3ZhbHVlW05VTV9HUkVHU107CiAjZW5kaWYKICAgICBpbnQgcHJlZ19sb2dbUFJFRF9XUklU
RVNfTUFYXTsKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIGIvdGFyZ2V0
L2hleGFnb24vdHJhbnNsYXRlLmMKaW5kZXggMzVlOTAzNjI4ODAuLmY0YTM1Mzk1OGZmIDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYworKysgYi90YXJnZXQvaGV4YWdvbi90
cmFuc2xhdGUuYwpAQCAtNTQ1LDYgKzU0NSwxMCBAQCBzdGF0aWMgdm9pZCBnZW5fc3RhcnRfcGFj
a2V0KERpc2FzQ29udGV4dCAqY3R4KQogICAgIGN0eC0+cmVnX2xvZ19pZHggPSAwOwogICAgIGJp
dG1hcF96ZXJvKGN0eC0+cmVnc193cml0dGVuLCBUT1RBTF9QRVJfVEhSRUFEX1JFR1MpOwogICAg
IGJpdG1hcF96ZXJvKGN0eC0+cHJlZGljYXRlZF9yZWdzLCBUT1RBTF9QRVJfVEhSRUFEX1JFR1Mp
OworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgY3R4LT5ncmVnX2xvZ19pZHggPSAwOwor
ICAgIGN0eC0+c3JlZ19sb2dfaWR4ID0gMDsKKyNlbmRpZgogICAgIGN0eC0+cHJlZ19sb2dfaWR4
ID0gMDsKICAgICBiaXRtYXBfemVybyhjdHgtPnByZWdzX3dyaXR0ZW4sIE5VTV9QUkVHUyk7CiAg
ICAgY3R4LT5mdXR1cmVfdnJlZ3NfaWR4ID0gMDsKQEAgLTU3Nyw2ICs1ODEsMjUgQEAgc3RhdGlj
IHZvaWQgZ2VuX3N0YXJ0X3BhY2tldChEaXNhc0NvbnRleHQgKmN0eCkKICAgICAgKiBnZW4gcGhh
c2UsIHNvIGNsZWFyIGl0IGFnYWluLgogICAgICAqLwogICAgIGJpdG1hcF96ZXJvKGN0eC0+cHJl
Z3Nfd3JpdHRlbiwgTlVNX1BSRUdTKTsKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAgIGZv
ciAoaSA9IDA7IGkgPCBIRVhfU1JFR19HTEJfU1RBUlQ7IGkrKykgeworICAgICAgICBjdHgtPnRf
c3JlZ19uZXdfdmFsdWVbaV0gPSBOVUxMOworICAgIH0KKyAgICBmb3IgKGkgPSAwOyBpIDwgY3R4
LT5zcmVnX2xvZ19pZHg7IGkrKykgeworICAgICAgICBpbnQgcmVnX251bSA9IGN0eC0+c3JlZ19s
b2dbaV07CisgICAgICAgIGlmIChyZWdfbnVtIDwgSEVYX1NSRUdfR0xCX1NUQVJUICYmCisgICAg
ICAgICAgICAoY3R4LT5uZWVkX2NvbW1pdCB8fCByZWdfbnVtID09IEhFWF9TUkVHX1NTUikpIHsK
KyAgICAgICAgICAgIGN0eC0+dF9zcmVnX25ld192YWx1ZVtyZWdfbnVtXSA9IHRjZ190ZW1wX25l
dygpOworICAgICAgICB9CisgICAgfQorICAgIGZvciAoaSA9IDA7IGkgPCBOVU1fR1JFR1M7IGkr
KykgeworICAgICAgICBjdHgtPmdyZWdfbmV3X3ZhbHVlW2ldID0gTlVMTDsKKyAgICB9CisgICAg
Zm9yIChpID0gMDsgaSA8IGN0eC0+Z3JlZ19sb2dfaWR4OyBpKyspIHsKKyAgICAgICAgaW50IHJl
Z19udW0gPSBjdHgtPmdyZWdfbG9nW2ldOworICAgICAgICBjdHgtPmdyZWdfbmV3X3ZhbHVlW3Jl
Z19udW1dID0gdGNnX3RlbXBfbmV3KCk7CisgICAgfQorI2VuZGlmCiAKICAgICAvKiBJbml0aWFs
aXplIHRoZSBydW50aW1lIHN0YXRlIGZvciBwYWNrZXQgc2VtYW50aWNzICovCiAgICAgaWYgKG5l
ZWRfc2xvdF9jYW5jZWxsZWQoJmN0eC0+cGt0KSkgewpAQCAtNzM0LDYgKzc1Nyw1MCBAQCBzdGF0
aWMgdm9pZCBnZW5fcmVnX3dyaXRlcyhEaXNhc0NvbnRleHQgKmN0eCkKICAgICB9CiB9CiAKKyNp
Zm5kZWYgQ09ORklHX1VTRVJfT05MWQorc3RhdGljIHZvaWQgZ2VuX2dyZWdfd3JpdGVzKERpc2Fz
Q29udGV4dCAqY3R4KQoreworICAgIGludCBpOworCisgICAgZm9yIChpID0gMDsgaSA8IGN0eC0+
Z3JlZ19sb2dfaWR4OyBpKyspIHsKKyAgICAgICAgaW50IHJlZ19udW0gPSBjdHgtPmdyZWdfbG9n
W2ldOworCisgICAgICAgIHRjZ19nZW5fbW92X3RsKGhleF9ncmVnW3JlZ19udW1dLCBjdHgtPmdy
ZWdfbmV3X3ZhbHVlW3JlZ19udW1dKTsKKyAgICB9Cit9CisKKworc3RhdGljIHZvaWQgZ2VuX3Ny
ZWdfd3JpdGVzKERpc2FzQ29udGV4dCAqY3R4KQoreworICAgIGludCBpOworCisgICAgVENHdl9p
MzIgb2xkX3JlZyA9IHRjZ190ZW1wX25ld19pMzIoKTsKKyAgICBmb3IgKGkgPSAwOyBpIDwgY3R4
LT5zcmVnX2xvZ19pZHg7IGkrKykgeworICAgICAgICBpbnQgcmVnX251bSA9IGN0eC0+c3JlZ19s
b2dbaV07CisKKyAgICAgICAgaWYgKHJlZ19udW0gPT0gSEVYX1NSRUdfU1NSKSB7CisgICAgICAg
ICAgICB0Y2dfZ2VuX21vdl90bChvbGRfcmVnLCBoZXhfdF9zcmVnW3JlZ19udW1dKTsKKyAgICAg
ICAgICAgIHRjZ19nZW5fbW92X3RsKGhleF90X3NyZWdbcmVnX251bV0sIGN0eC0+dF9zcmVnX25l
d192YWx1ZVtyZWdfbnVtXSk7CisgICAgICAgICAgICBnZW5faGVscGVyX21vZGlmeV9zc3IodGNn
X2VudiwgY3R4LT50X3NyZWdfbmV3X3ZhbHVlW3JlZ19udW1dLAorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIG9sZF9yZWcpOworICAgICAgICB9IGVsc2UgaWYgKChyZWdfbnVtID09
IEhFWF9TUkVHX1NUSUQpIHx8CisgICAgICAgICAgICAgICAgICAgKHJlZ19udW0gPT0gSEVYX1NS
RUdfSU1BU0spIHx8CisgICAgICAgICAgICAgICAgICAgKHJlZ19udW0gPT0gSEVYX1NSRUdfSVBF
TkRBRCkpIHsKKyAgICAgICAgICAgIGlmIChjdHgtPm5lZWRfY29tbWl0ICYmIHJlZ19udW0gPCBI
RVhfU1JFR19HTEJfU1RBUlQpIHsKKyAgICAgICAgICAgICAgICB0Y2dfZ2VuX21vdl90bChoZXhf
dF9zcmVnW3JlZ19udW1dLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGN0eC0+dF9z
cmVnX25ld192YWx1ZVtyZWdfbnVtXSk7CisgICAgICAgICAgICB9CisgICAgICAgICAgICBnZW5f
aGVscGVyX3BlbmRpbmdfaW50ZXJydXB0KHRjZ19lbnYpOworICAgICAgICB9IGVsc2UgaWYgKChy
ZWdfbnVtID09IEhFWF9TUkVHX0JFU1RXQUlUKSB8fAorICAgICAgICAgICAgICAgICAgIChyZWdf
bnVtID09IEhFWF9TUkVHX1NDSEVEQ0ZHKSkgeworICAgICAgICAgICAgZ2VuX2hlbHBlcl9yZXNj
aGVkKHRjZ19lbnYpOworICAgICAgICB9IGVsc2UgaWYgKGN0eC0+bmVlZF9jb21taXQgJiYgcmVn
X251bSA8IEhFWF9TUkVHX0dMQl9TVEFSVCkgeworICAgICAgICAgICAgdGNnX2dlbl9tb3ZfdGwo
aGV4X3Rfc3JlZ1tyZWdfbnVtXSwgY3R4LT50X3NyZWdfbmV3X3ZhbHVlW3JlZ19udW1dKTsKKyAg
ICAgICAgfQorICAgIH0KK30KKyNlbmRpZgorCiBzdGF0aWMgdm9pZCBnZW5fcHJlZF93cml0ZXMo
RGlzYXNDb250ZXh0ICpjdHgpCiB7CiAgICAgLyogRWFybHkgZXhpdCBpZiBub3QgbmVlZGVkIG9y
IHRoZSBsb2cgaXMgZW1wdHkgKi8KQEAgLTEwMzAsNiArMTA5NywxMCBAQCBzdGF0aWMgdm9pZCBn
ZW5fY29tbWl0X3BhY2tldChEaXNhc0NvbnRleHQgKmN0eCkKICAgICBwcm9jZXNzX3N0b3JlX2xv
ZyhjdHgpOwogCiAgICAgZ2VuX3JlZ193cml0ZXMoY3R4KTsKKyNpZm5kZWYgQ09ORklHX1VTRVJf
T05MWQorICAgIGdlbl9ncmVnX3dyaXRlcyhjdHgpOworICAgIGdlbl9zcmVnX3dyaXRlcyhjdHgp
OworI2VuZGlmCiAgICAgZ2VuX3ByZWRfd3JpdGVzKGN0eCk7CiAgICAgaWYgKGN0eC0+cGt0LnBr
dF9oYXNfaHZ4KSB7CiAgICAgICAgIGdlbl9jb21taXRfaHZ4KGN0eCk7CkBAIC0xMjQyLDYgKzEz
MTMsOCBAQCB2b2lkIGhleGFnb25fdHJhbnNsYXRlX2luaXQodm9pZCkKICAgICBoZXhfbGxzY192
YWxfaTY0ID0gdGNnX2dsb2JhbF9tZW1fbmV3X2k2NCh0Y2dfZW52LAogICAgICAgICBvZmZzZXRv
ZihDUFVIZXhhZ29uU3RhdGUsIGxsc2NfdmFsX2k2NCksICJsbHNjX3ZhbF9pNjQiKTsKICNpZm5k
ZWYgQ09ORklHX1VTRVJfT05MWQorICAgIGhleF9jYXVzZV9jb2RlID0gdGNnX2dsb2JhbF9tZW1f
bmV3X2kzMih0Y2dfZW52LAorICAgICAgICBvZmZzZXRvZihDUFVIZXhhZ29uU3RhdGUsIGNhdXNl
X2NvZGUpLCAiY2F1c2VfY29kZSIpOwogICAgIGhleF9jeWNsZV9jb3VudCA9IHRjZ19nbG9iYWxf
bWVtX25ld19pNjQodGNnX2VudiwKICAgICAgICAgb2Zmc2V0b2YoQ1BVSGV4YWdvblN0YXRlLCB0
X2N5Y2xlX2NvdW50KSwgInRfY3ljbGVfY291bnQiKTsKICNlbmRpZgpAQCAtMTI4Miw4ICsxMzU1
LDQgQEAgdm9pZCBoZXhhZ29uX3RyYW5zbGF0ZV9pbml0KHZvaWQpCiAgICAgICAgICAgICBvZmZz
ZXRvZihDUFVIZXhhZ29uU3RhdGUsIHZzdG9yZV9wZW5kaW5nW2ldKSwKICAgICAgICAgICAgIHZz
dG9yZV9wZW5kaW5nX25hbWVzW2ldKTsKICAgICB9Ci0jaWZuZGVmIENPTkZJR19VU0VSX09OTFkK
LSAgICBoZXhfY2F1c2VfY29kZSA9IHRjZ19nbG9iYWxfbWVtX25ldyh0Y2dfZW52LAotICAgICAg
ICBvZmZzZXRvZihDUFVIZXhhZ29uU3RhdGUsIGNhdXNlX2NvZGUpLCAiY2F1c2VfY29kZSIpOwot
I2VuZGlmCiB9Ci0tIAoyLjM0LjEKCg==

