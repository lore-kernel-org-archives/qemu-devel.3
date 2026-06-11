Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F1DCD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXXz8-0007mG-Se; Thu, 11 Jun 2026 01:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXz7-0007lc-Fk
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXz5-0000qn-T3
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:45 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GLNX3724999
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3X8bvXVW52I3fn1FyNjUiMXuaCQjKXZ/zTx+8O5PNqc=; b=SXRpd2PNjvTIepU2
 9o+qHQ9T5JbRTBWwuXakFKS1GK3ecZDx99IH/iM+RiU+EznbzNief5wRKa8KXa4l
 dc52/K/hgOToDyH+RDZAajVecfOWWcox4PBWkXDYGqRLVa7IXnD2WNSQsNBSQcc8
 5gjDVdd98l+bgxguHvtLJ8mLQCy3cj2W7XkX8sxOoZKFmBgYKyp2/QKOU9+xk+6a
 nCQ4460tmw34gBWICiWuDYSOfHcz7/ImDDnjvoy0W3YNsr/9aaPevMpeikzfCzja
 gjX/kBMEikaHqOTsEeLoUprJglemG7WkbP9GqrBX2DEWTvXwCwvE7l4KDA3x5wYC
 FVFRxQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6v9qbm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:32 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304df51ff3eso8597497eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155771; x=1781760571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3X8bvXVW52I3fn1FyNjUiMXuaCQjKXZ/zTx+8O5PNqc=;
 b=MXCczm2iNGQxvDxejIosxcm5pnETUOjAYx7Tkv4kgtBXXmUVwMgy07xXwI+vQ5ji49
 yIcxft+51sFhgtgcUxTPIH+vkKMJVvGsv+IBUOQlHLlehVHfUdY2axrRu7PttpIqJrZO
 kLCY+cnM9EzFCXOlWGb9vfYwq5Li3LmD8RR3Wf2RXLQn8eNStCK+X6o8ot2uTGsc8FN/
 V6QeOnDfqqJmIgtblWv1HitVzb1KRhAESbx6cdKoQ6W6nKesnFIByrH5sB2UxIkfkxrM
 7m/eVCm2XwPz+IwwLwExA2fF3c+IjlKqF5zHSq8hmasmRr67GAnxxR3SpkPOUAxFoHbm
 mhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155771; x=1781760571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3X8bvXVW52I3fn1FyNjUiMXuaCQjKXZ/zTx+8O5PNqc=;
 b=mTVifcNfRtH5fur4gON834ewHvynqC1w3g0R+3zHUfVpetMd4hoDtw309OIC/iGcsF
 FTNvEwB7Ky6yEn2uFj2bq8TLI9L9lVajJpqA7i9yUTsdjMmjJiszqUKvoRfGxYulQuMx
 AmxQ6PG2MqRfPiEXiY/OljqA7ftjgUm1y1sO1/2y1T8YaEfadaE1OvySCvd/SvXZxPgO
 OdnO1+emx4OJ+h8BJ3l7FG7LnnEDhpWZAEdAdmRUATRQ+4hQY56MDB1qI7X0/irBF+UJ
 Q9KQIuLcjB9cO66/w83kyTAL0MuW+8DweZHWpb3EQD2l0x/tEt4JABp+H/25AsnQzRNE
 yBsg==
X-Gm-Message-State: AOJu0Yy4uaVXb/R/m04vbyYj4HD51F4SU5vP8p/9tBs6dxb+1BcCzwxI
 YkEyNdP7AgAIt+G/uKW5Gc7OrDpAAysePOrll+8QJZC45anB9l/lcWjzErzxtw7jVMt8NbiRZJS
 jArPBMsNWaEQO12AfhGbgJMTnvis98d6Ne/1n4f9cwAIPVb471Pno5ImfelkPHxpQ/g==
X-Gm-Gg: Acq92OHumTMj3JnIysNt1ZMrK7XN583Jhmnn37my13WmH1KVgmICYXTBzhHxUh0rx75
 2O7n6X9/AQRI8FnXh7LzGY9iqFZh1ATzzWlpOpOBdCpROA/HV5NyoCxUGekcTby96z7wNCEC10x
 nbKyqXWL2KkTzRA3AK5MfNVyEpajN22LGNIsXrcERZ+6uSJPlXDpB73tY+cOhM9x4K9vIeOZRVu
 b7ZqWRQtw9VPrqhLf7YPLG1vtQQXAp6Pr0DgGEFyoqNCsLVVYKStXUXXf6WR0/1g1kiJcnHy6in
 M8zR2XTDLrlyB+mg8n1o5C3+1GhYMoM93b9+5p5itONnOj8U/3aeZ286SHsXk3qkNqbkhXdf1Wx
 QMCFlthpcex2R8vHeB3Etf5SFxCzyZrkTg1Im1xDW37MkMfPj4fn8cBH5c8emrWakUqv/qnJDol
 lk9QeV
X-Received: by 2002:a05:7300:434c:b0:2f0:5605:466e with SMTP id
 5a478bee46e88-3080476c089mr1040312eec.9.1781155771545; 
 Wed, 10 Jun 2026 22:29:31 -0700 (PDT)
X-Received: by 2002:a05:7300:434c:b0:2f0:5605:466e with SMTP id
 5a478bee46e88-3080476c089mr1040287eec.9.1781155771011; 
 Wed, 10 Jun 2026 22:29:31 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806e8a402sm880475eec.17.2026.06.10.22.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:29:29 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v8] target/hexagon: Add placeholder greg/sreg r/w helpers
Date: Wed, 10 Jun 2026 22:28:38 -0700
Message-Id: <20260611052857.3911981-18-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
References: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: dTXmLbMfK1eLh_k5dTW_VFVKsWYFwffy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX1XOfCUYVvSVh
 1ZveUbO5Vt0+LhoHe/kheZRlXTh846iO3LFGXlDy6CLvCYpXR93aHzeFlUDcDCu6s/CgyeeTUKB
 XCC0VMmGwhD53pbTdllPX+gS5FE62J0=
X-Proofpoint-GUID: dTXmLbMfK1eLh_k5dTW_VFVKsWYFwffy
X-Authority-Analysis: v=2.4 cv=UsRT8ewB c=1 sm=1 tr=0 ts=6a2a47bc cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=wA0rHRt5QP8iJxr38i8A:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfXx/tkNDczie4w
 INqwTyUKulmbpVipWlAE3SloQD/quBhKVo88PrObROv+2PP9GgrMLW2bpXV3PL/jRejB0ocFQEl
 dQWrq2PcG8PaeGDTaMo9llw1tOE5/qWHkgweKcJFy5Lu7XJqb6r2s+vt4mSyrVCEXO8oXZLB4nC
 JCPVidL4EErrUJpZcRp1+acCXJt5ewwFaX918mSn8dkvqlr8y4vnJs4VekevsbwUUrgY6dlXDz7
 4Vloj4pmBLvraIFkfiqQWhQBkD3weMvgbOUAxb0azSD5jIspg38/9fmLnfvtXEN7D7yjXib6gri
 6zdFbcerIgcmb6iHHpMJDcIuViZvOA6pvnreZ2ZZbAIZG+LpY9VJuxJe0IwvuNw231f73cdCi8D
 a7FvYM1LTvXfRUTehGlAZ6llfnKct9kUUJtvx7RXBhJ/kyrLJGxFTEC8mzKfHv1fgpG4s4BkueF
 FVdfi+/nuFwnUfPk60w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110051
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hl
bHBlci5oICAgIHwgIDggKysrKysrKysKIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIHwgMjgg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAzNiBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGVscGVyLmggYi90YXJnZXQvaGV4
YWdvbi9oZWxwZXIuaAppbmRleCA2NDQ1NjgyMmJjMS4uMjhiOWI1OWUwZjIgMTAwNjQ0Ci0tLSBh
L3RhcmdldC9oZXhhZ29uL2hlbHBlci5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oCkBA
IC0xMDcsMyArMTA3LDExIEBAIERFRl9IRUxQRVJfNChwcm9iZV9ub3NodWZfbG9hZCwgdm9pZCwg
ZW52LCBpMzIsIGludCwgaW50KQogREVGX0hFTFBFUl8yKHByb2JlX3BrdF9zY2FsYXJfc3RvcmVf
czAsIHZvaWQsIGVudiwgaW50KQogREVGX0hFTFBFUl8yKHByb2JlX2h2eF9zdG9yZXMsIHZvaWQs
IGVudiwgaW50KQogREVGX0hFTFBFUl8yKHByb2JlX3BrdF9zY2FsYXJfaHZ4X3N0b3Jlcywgdm9p
ZCwgZW52LCBpbnQpCisKKyNpZiAhZGVmaW5lZChDT05GSUdfVVNFUl9PTkxZKQorREVGX0hFTFBF
Ul8yKHNyZWdfcmVhZCwgaTMyLCBlbnYsIGkzMikKK0RFRl9IRUxQRVJfMihzcmVnX3JlYWRfcGFp
ciwgaTY0LCBlbnYsIGkzMikKK0RFRl9IRUxQRVJfMihncmVnX3JlYWQsIGkzMiwgZW52LCBpMzIp
CitERUZfSEVMUEVSXzIoZ3JlZ19yZWFkX3BhaXIsIGk2NCwgZW52LCBpMzIpCitERUZfSEVMUEVS
XzMoc3JlZ193cml0ZV9tYXNrZWQsIHZvaWQsIGVudiwgaTMyLCBpMzIpCisjZW5kaWYKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVs
cGVyLmMKaW5kZXggNTM4OThkYjgxNWIuLjM1OWJmMTJmMWYyIDEwMDY0NAotLS0gYS90YXJnZXQv
aGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAt
MTM3Myw2ICsxMzczLDM0IEBAIHZvaWQgSEVMUEVSKHZ3aGlzdDEyOHFtKShDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgaW50MzJfdCB1aVYpCiAgICAgfQogfQogCisjaWZuZGVmIENPTkZJR19VU0VSX09O
TFkKK3ZvaWQgSEVMUEVSKHNyZWdfd3JpdGVfbWFza2VkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgcmVnLCB1aW50MzJfdCB2YWwpCit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQo
KTsKK30KKwordWludDMyX3QgSEVMUEVSKHNyZWdfcmVhZCkoQ1BVSGV4YWdvblN0YXRlICplbnYs
IHVpbnQzMl90IHJlZykKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQorCit1aW50
NjRfdCBIRUxQRVIoc3JlZ19yZWFkX3BhaXIpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJf
dCByZWcpCit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKK30KKwordWludDMyX3QgSEVM
UEVSKGdyZWdfcmVhZCkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHJlZykKK3sKKyAg
ICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQorCit1aW50NjRfdCBIRUxQRVIoZ3JlZ19yZWFk
X3BhaXIpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcpCit7CisgICAgZ19hc3Nl
cnRfbm90X3JlYWNoZWQoKTsKK30KKyNlbmRpZgorCisKIC8qIFRoZXNlIG1hY3JvcyBjYW4gYmUg
cmVmZXJlbmNlZCBpbiB0aGUgZ2VuZXJhdGVkIGhlbHBlciBmdW5jdGlvbnMgKi8KICNkZWZpbmUg
d2FybiguLi4pIC8qIE5vdGhpbmcgKi8KICNkZWZpbmUgZmF0YWwoLi4uKSBnX2Fzc2VydF9ub3Rf
cmVhY2hlZCgpOwotLSAKMi4zNC4xCgo=

