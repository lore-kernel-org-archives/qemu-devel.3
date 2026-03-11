Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27572FD88F3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AsK-0000tF-R1; Wed, 11 Mar 2026 00:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AsG-0000rH-1u
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AsD-00006d-Ui
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:43 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62AIutO43892938
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /erZ7Kp1j5Si6RLiGiEgcK8gl4a/qDTcfd2Iu42KlGo=; b=JUxPBguVdulAR5Ll
 jxwKKsT0CJe7EYD9oJXAiZbGLHZVByLydRbp8emsqxfb4R1tBZNSjX+vFkIcqZfW
 +9jOxfxcJGXan2+cOL/m+mge1Wucw5TALUAsNG4QGgVZ93yel9rHxpSTq3UzQ2AK
 HEvE0v9Bks8OZuIoN0oV0AFQOi4unw2/+O/WZkQBSbhXliiwUaAaPeFhHoJKPqTR
 dLn1WUGPyUW5h8vg51CR1NRx6hqF4U8MTWzeIAHJJaDX0HGMevdWN/t25BinQ2md
 pzmp9esO1zVSBiojGQxpBbw8krqY2hHKXbONu9xbwhBuztLmogj8FlsnxYae1eqP
 KqUXxw==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctkmyu1g7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:40 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-41783c35253so800426fac.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202119; x=1773806919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/erZ7Kp1j5Si6RLiGiEgcK8gl4a/qDTcfd2Iu42KlGo=;
 b=GhTJbO7/XDZLX9LmCJDXxd6yRakkh9khSh1dyQdr089+3aXchKJTuzOLwMXufPw7UB
 zKfr+TxnYEIRIuT5LkMTdfF7wI+JAdz+YabjziNCDdoOyoV5/93YCJIFvQrfpzL4lC/s
 j4oERJ5GpSIeaTpvCRiJTKVoZN7Z0SGXf29VR0XJiyOAr4wrUoIu38W4SQfMJbCc0J/Z
 IKK9A17F+h4UW2VAHN+FDqn0JESxQc495fAU18fMqlkv0KnfUCTUXWDw63WY3TqBEBe6
 0cGruhzHAP0b+jAALF4j6aKNJjYTfzjcJ8VyXtuwTwPgifM+roZAgwcvEewFAbrcUiE0
 xW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202119; x=1773806919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/erZ7Kp1j5Si6RLiGiEgcK8gl4a/qDTcfd2Iu42KlGo=;
 b=TGY+Vbsqy22RNYHBxkXJahZRqY6neTk/an6Y6eLPhqrYL5vRYI14UbDN5+LKh19pkC
 fdOQzzG7c43kpUcLtx3hd/HFUAARNynI/QWyrx2TNeBSmzdEWrpFA4lIJtTWsyhLQ5k1
 +/1wUmIVEb2f3f9nZu7raIg4w3giwuTB2e7jUUTiS4yxv3Uw/DuyqL5lxbeVnKO2DVJn
 WwtTW09c4/5IIFdTZqiPEvOalgsSKqCilePjFYof/K6ADsjlxi8NKUEHABeBCOZGH/XQ
 XOLWkNGi4w/vuKWUemudXrfrx4QiMar44oW9vOrCRpuToBATtAY4nQFSJjKxP+EQpkN0
 y5QA==
X-Gm-Message-State: AOJu0YylKO6T8FT/mW3YjF5kgxGxvl3eU0U1tWVziPjQGQgpenEC+jYv
 lc1DlVMTszL+Arod+/WgwIJqmT/WPzZ1GDTqermGGyXDHtVDi8Cn/+s/EbyVjAjkQYjTtF1Qwip
 aewPsa6Z1mPDJZHMNV6IECPxPeI6zkIy+kRHd1JBFlf6RcCo/KU3h2UuQqIXK5ACf+A==
X-Gm-Gg: ATEYQzxoQMXAm9QJd9hTaBc3xm01zVRV225WULcCgfn9eSZKPXkqo9df+xSScnEAmqb
 dUfI8mMMXb1ZchBWq+LfoE4icvg09cWfPNKiwKFrVmQLXzq15CQMXwe8x25STjpLd4vCLzu++jI
 YwMDBqorsf9QRIQ/X9nvk321MKSVp7F+rQZmCdDPPIf4X7t40hDbYJiRnX53HXE0Abn7WsOxj4F
 q4v+W6bUUrTHV1+/aQtlB5cBzVJsP2qdWIlgYioCLhvCRdBxO2X/jYZuRv9edR6zlcICbouq8MW
 7ITATsnj/bVeF4smSbvApYjmzxQFk9ZMc0rMxHDbde73IKQ61R7v/inT5fCYtlnQZBivzB24gwE
 c6dZbwVoxUEVV/afUmnMPYDdyA+tMQBzzuGYd8FAbrQkvt+7gh0XjYjxzfL1mQdnQ7e4d4g==
X-Received: by 2002:a05:6870:21e6:b0:417:3307:e1cb with SMTP id
 586e51a60fabf-4177c8bd680mr844771fac.21.1773202119346; 
 Tue, 10 Mar 2026 21:08:39 -0700 (PDT)
X-Received: by 2002:a05:6870:21e6:b0:417:3307:e1cb with SMTP id
 586e51a60fabf-4177c8bd680mr844755fac.21.1773202118885; 
 Tue, 10 Mar 2026 21:08:38 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5ea30asm998656fac.10.2026.03.10.21.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:08:38 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 24/32] target/hexagon: Add next_PC, {s,g}reg writes
Date: Tue, 10 Mar 2026 21:07:50 -0700
Message-Id: <20260311040758.1068731-25-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=RYudyltv c=1 sm=1 tr=0 ts=69b0eac8 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=E45M5x4EOcbb2jMLJMAA:9 a=QEXdDO2ut3YA:10
 a=eBU8X_Hb5SQ8N-bgNfv4:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: P-xCoPTsHIf4cTI1D8DeKNeOpr3px8KS
X-Proofpoint-ORIG-GUID: P-xCoPTsHIf4cTI1D8DeKNeOpr3px8KS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMiBTYWx0ZWRfX7pstPpKLE894
 7s9L5JWxECnA9INAoNcNjyQvw9LeQBtBTeAAEKZMUUeaZgfsr8l54BwIQowcZk8ZW1Ig24PSrUH
 aX7NXgWqzrKpNkJpLpM3lRfv7cr1JyVfGGwWTWcEoxchqpGC78fq3cJYvGbf40Q6aH4ewY/MImf
 Bxq6Bsa00dyNiFjEnWTUJlr9PWs97C3L9PbIIOR5xwOBPJbwDzhwai2r0Mz788bpgEM0TK9SvLx
 LO7yrXnvHH6KK961hPZQnf5uOPLJ56Zq69X2jb+VrtAcY9RXsAS+wNoh+2gxrVwyFprztllA/Q6
 FGvzpmW9V15fkabJ2Uya0KzjZ19fcYaJxSeOmzDJhfcVat6f1W5j14XzadFMfM3j8ltvybMM+zL
 yatsafc3iVwuWmj3/tF/96oCRBXJNEgBGaVq08cSzaxCK2ljyVPDudjVc3vmC25Didn6HWg/CdU
 0N74eMfJ/TMUrjMJSLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110032
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmMgfCA4OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQog
MSBmaWxlIGNoYW5nZWQsIDg1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xh
dGUuYwppbmRleCA5NTNiMzRiNzg5MS4uNzkwMjdlOGEzMjcgMTAwNjQ0Ci0tLSBhL3RhcmdldC9o
ZXhhZ29uL3RyYW5zbGF0ZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCkBAIC01
NTIsNiArNTUyLDEwIEBAIHN0YXRpYyB2b2lkIGdlbl9zdGFydF9wYWNrZXQoRGlzYXNDb250ZXh0
ICpjdHgpCiAgICAgY3R4LT5yZWdfbG9nX2lkeCA9IDA7CiAgICAgYml0bWFwX3plcm8oY3R4LT5y
ZWdzX3dyaXR0ZW4sIFRPVEFMX1BFUl9USFJFQURfUkVHUyk7CiAgICAgYml0bWFwX3plcm8oY3R4
LT5wcmVkaWNhdGVkX3JlZ3MsIFRPVEFMX1BFUl9USFJFQURfUkVHUyk7CisjaWZuZGVmIENPTkZJ
R19VU0VSX09OTFkKKyAgICBjdHgtPmdyZWdfbG9nX2lkeCA9IDA7CisgICAgY3R4LT5zcmVnX2xv
Z19pZHggPSAwOworI2VuZGlmCiAgICAgY3R4LT5wcmVnX2xvZ19pZHggPSAwOwogICAgIGJpdG1h
cF96ZXJvKGN0eC0+cHJlZ3Nfd3JpdHRlbiwgTlVNX1BSRUdTKTsKICAgICBjdHgtPmZ1dHVyZV92
cmVnc19pZHggPSAwOwpAQCAtNTg0LDYgKzU4OCwyNSBAQCBzdGF0aWMgdm9pZCBnZW5fc3RhcnRf
cGFja2V0KERpc2FzQ29udGV4dCAqY3R4KQogICAgICAqIGdlbiBwaGFzZSwgc28gY2xlYXIgaXQg
YWdhaW4uCiAgICAgICovCiAgICAgYml0bWFwX3plcm8oY3R4LT5wcmVnc193cml0dGVuLCBOVU1f
UFJFR1MpOworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgZm9yIChpID0gMDsgaSA8IE5V
TV9TUkVHUzsgaSsrKSB7CisgICAgICAgIGN0eC0+dF9zcmVnX25ld192YWx1ZVtpXSA9IE5VTEw7
CisgICAgfQorICAgIGZvciAoaSA9IDA7IGkgPCBjdHgtPnNyZWdfbG9nX2lkeDsgaSsrKSB7Cisg
ICAgICAgIGludCByZWdfbnVtID0gY3R4LT5zcmVnX2xvZ1tpXTsKKyAgICAgICAgaWYgKHJlZ19u
dW0gPCBIRVhfU1JFR19HTEJfU1RBUlQpIHsKKyAgICAgICAgICAgIGN0eC0+dF9zcmVnX25ld192
YWx1ZVtyZWdfbnVtXSA9IHRjZ190ZW1wX25ldygpOworICAgICAgICAgICAgdGNnX2dlbl9tb3Zf
dGwoY3R4LT50X3NyZWdfbmV3X3ZhbHVlW3JlZ19udW1dLCBoZXhfdF9zcmVnW3JlZ19udW1dKTsK
KyAgICAgICAgfQorICAgIH0KKyAgICBmb3IgKGkgPSAwOyBpIDwgTlVNX0dSRUdTOyBpKyspIHsK
KyAgICAgICAgY3R4LT5ncmVnX25ld192YWx1ZVtpXSA9IE5VTEw7CisgICAgfQorICAgIGZvciAo
aSA9IDA7IGkgPCBjdHgtPmdyZWdfbG9nX2lkeDsgaSsrKSB7CisgICAgICAgIGludCByZWdfbnVt
ID0gY3R4LT5ncmVnX2xvZ1tpXTsKKyAgICAgICAgY3R4LT5ncmVnX25ld192YWx1ZVtyZWdfbnVt
XSA9IHRjZ190ZW1wX25ldygpOworICAgIH0KKyNlbmRpZgogCiAgICAgLyogSW5pdGlhbGl6ZSB0
aGUgcnVudGltZSBzdGF0ZSBmb3IgcGFja2V0IHNlbWFudGljcyAqLwogICAgIGlmIChuZWVkX3Ns
b3RfY2FuY2VsbGVkKHBrdCkpIHsKQEAgLTc0NCw2ICs3NjcsNjAgQEAgc3RhdGljIHZvaWQgZ2Vu
X3JlZ193cml0ZXMoRGlzYXNDb250ZXh0ICpjdHgpCiAgICAgfQogfQogCisjaWZuZGVmIENPTkZJ
R19VU0VSX09OTFkKK3N0YXRpYyB2b2lkIGdlbl9ncmVnX3dyaXRlcyhEaXNhc0NvbnRleHQgKmN0
eCkKK3sKKyAgICBpbnQgaTsKKworICAgIGZvciAoaSA9IDA7IGkgPCBjdHgtPmdyZWdfbG9nX2lk
eDsgaSsrKSB7CisgICAgICAgIGludCByZWdfbnVtID0gY3R4LT5ncmVnX2xvZ1tpXTsKKworICAg
ICAgICB0Y2dfZ2VuX21vdl90bChoZXhfZ3JlZ1tyZWdfbnVtXSwgY3R4LT5ncmVnX25ld192YWx1
ZVtyZWdfbnVtXSk7CisgICAgfQorfQorCisKK3N0YXRpYyB2b2lkIGdlbl9zcmVnX3dyaXRlcyhE
aXNhc0NvbnRleHQgKmN0eCkKK3sKKyAgICBpbnQgaTsKKworICAgIFRDR3ZfaTMyIG9sZF9yZWcg
PSB0Y2dfdGVtcF9uZXdfaTMyKCk7CisgICAgZm9yIChpID0gMDsgaSA8IGN0eC0+c3JlZ19sb2df
aWR4OyBpKyspIHsKKyAgICAgICAgaW50IHJlZ19udW0gPSBjdHgtPnNyZWdfbG9nW2ldOworCisg
ICAgICAgIGlmIChyZWdfbnVtID09IEhFWF9TUkVHX1NTUikgeworICAgICAgICAgICAgdGNnX2dl
bl9tb3ZfdGwob2xkX3JlZywgaGV4X3Rfc3JlZ1tyZWdfbnVtXSk7CisgICAgICAgICAgICB0Y2df
Z2VuX21vdl90bChoZXhfdF9zcmVnW3JlZ19udW1dLCBjdHgtPnRfc3JlZ19uZXdfdmFsdWVbcmVn
X251bV0pOworICAgICAgICAgICAgZ2VuX2hlbHBlcl9tb2RpZnlfc3NyKHRjZ19lbnYsIGN0eC0+
dF9zcmVnX25ld192YWx1ZVtyZWdfbnVtXSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBvbGRfcmVnKTsKKyAgICAgICAgICAgIC8qIFRoaXMgY2FuIGNoYW5nZSBwcm9jZXNzb3Ig
c3RhdGUsIHNvIGVuZCB0aGUgVEIgKi8KKyAgICAgICAgICAgIGN0eC0+YmFzZS5pc19qbXAgPSBE
SVNBU19OT1JFVFVSTjsKKyAgICAgICAgICAgIGNvbnRpbnVlOworICAgICAgICB9IGVsc2UgaWYg
KChyZWdfbnVtID09IEhFWF9TUkVHX1NUSUQpIHx8CisgICAgICAgICAgICAgICAgICAgKHJlZ19u
dW0gPT0gSEVYX1NSRUdfSU1BU0spIHx8CisgICAgICAgICAgICAgICAgICAgKHJlZ19udW0gPT0g
SEVYX1NSRUdfSVBFTkRBRCkpIHsKKyAgICAgICAgICAgIGlmIChyZWdfbnVtIDwgSEVYX1NSRUdf
R0xCX1NUQVJUKSB7CisgICAgICAgICAgICAgICAgdGNnX2dlbl9tb3ZfdGwob2xkX3JlZywgaGV4
X3Rfc3JlZ1tyZWdfbnVtXSk7CisgICAgICAgICAgICAgICAgdGNnX2dlbl9tb3ZfdGwoaGV4X3Rf
c3JlZ1tyZWdfbnVtXSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjdHgtPnRfc3Jl
Z19uZXdfdmFsdWVbcmVnX251bV0pOworICAgICAgICAgICAgfQorICAgICAgICAgICAgLyogVGhp
cyBjYW4gY2hhbmdlIHRoZSBpbnRlcnJ1cHQgc3RhdGUsIHNvIGVuZCB0aGUgVEIgKi8KKyAgICAg
ICAgICAgIGdlbl9oZWxwZXJfcGVuZGluZ19pbnRlcnJ1cHQodGNnX2Vudik7CisgICAgICAgICAg
ICBjdHgtPmJhc2UuaXNfam1wID0gRElTQVNfTk9SRVRVUk47CisgICAgICAgIH0gZWxzZSBpZiAo
KHJlZ19udW0gPT0gSEVYX1NSRUdfQkVTVFdBSVQpIHx8CisgICAgICAgICAgICAgICAgICAgKHJl
Z19udW0gPT0gSEVYX1NSRUdfU0NIRURDRkcpKSB7CisgICAgICAgICAgICAvKiBUaGlzIGNhbiB0
cmlnZ2VyIHJlc2NoZWQgaW50ZXJydXB0LCBzbyBlbmQgdGhlIFRCICovCisgICAgICAgICAgICBn
ZW5faGVscGVyX3Jlc2NoZWQodGNnX2Vudik7CisgICAgICAgICAgICBjdHgtPmJhc2UuaXNfam1w
ID0gRElTQVNfTk9SRVRVUk47CisgICAgICAgIH0KKworICAgICAgICBpZiAocmVnX251bSA8IEhF
WF9TUkVHX0dMQl9TVEFSVCkgeworICAgICAgICAgICAgdGNnX2dlbl9tb3ZfdGwoaGV4X3Rfc3Jl
Z1tyZWdfbnVtXSwgY3R4LT50X3NyZWdfbmV3X3ZhbHVlW3JlZ19udW1dKTsKKyAgICAgICAgfQor
ICAgIH0KK30KKyNlbmRpZgorCiBzdGF0aWMgdm9pZCBnZW5fcHJlZF93cml0ZXMoRGlzYXNDb250
ZXh0ICpjdHgpCiB7CiAgICAgLyogRWFybHkgZXhpdCBpZiBub3QgbmVlZGVkIG9yIHRoZSBsb2cg
aXMgZW1wdHkgKi8KQEAgLTEwNDQsNiArMTEyMSwxMCBAQCBzdGF0aWMgdm9pZCBnZW5fY29tbWl0
X3BhY2tldChEaXNhc0NvbnRleHQgKmN0eCkKICAgICBwcm9jZXNzX3N0b3JlX2xvZyhjdHgpOwog
CiAgICAgZ2VuX3JlZ193cml0ZXMoY3R4KTsKKyNpZiAhZGVmaW5lZChDT05GSUdfVVNFUl9PTkxZ
KQorICAgIGdlbl9ncmVnX3dyaXRlcyhjdHgpOworICAgIGdlbl9zcmVnX3dyaXRlcyhjdHgpOwor
I2VuZGlmCiAgICAgZ2VuX3ByZWRfd3JpdGVzKGN0eCk7CiAgICAgaWYgKHBrdC0+cGt0X2hhc19o
dngpIHsKICAgICAgICAgZ2VuX2NvbW1pdF9odngoY3R4KTsKQEAgLTEyNTUsNiArMTMzNiwxMCBA
QCB2b2lkIGhleGFnb25fdHJhbnNsYXRlX2luaXQodm9pZCkKICAgICAgICAgb2Zmc2V0b2YoQ1BV
SGV4YWdvblN0YXRlLCBsbHNjX3ZhbF9pNjQpLCAibGxzY192YWxfaTY0Iik7CiAgICAgaGV4X2N5
Y2xlX2NvdW50ID0gdGNnX2dsb2JhbF9tZW1fbmV3X2k2NCh0Y2dfZW52LAogICAgICAgICAgICAg
b2Zmc2V0b2YoQ1BVSGV4YWdvblN0YXRlLCB0X2N5Y2xlX2NvdW50KSwgInRfY3ljbGVfY291bnQi
KTsKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAgIGhleF9jYXVzZV9jb2RlID0gdGNnX2ds
b2JhbF9tZW1fbmV3X2kzMih0Y2dfZW52LAorICAgICAgICBvZmZzZXRvZihDUFVIZXhhZ29uU3Rh
dGUsIGNhdXNlX2NvZGUpLCAiY2F1c2VfY29kZSIpOworI2VuZGlmCiAgICAgZm9yIChpID0gMDsg
aSA8IFNUT1JFU19NQVg7IGkrKykgewogICAgICAgICBzbnByaW50ZihzdG9yZV9hZGRyX25hbWVz
W2ldLCBOQU1FX0xFTiwgInN0b3JlX2FkZHJfJWQiLCBpKTsKICAgICAgICAgaGV4X3N0b3JlX2Fk
ZHJbaV0gPSB0Y2dfZ2xvYmFsX21lbV9uZXcodGNnX2VudiwKQEAgLTEyOTIsOCArMTM3Nyw0IEBA
IHZvaWQgaGV4YWdvbl90cmFuc2xhdGVfaW5pdCh2b2lkKQogICAgICAgICAgICAgb2Zmc2V0b2Yo
Q1BVSGV4YWdvblN0YXRlLCB2c3RvcmVfcGVuZGluZ1tpXSksCiAgICAgICAgICAgICB2c3RvcmVf
cGVuZGluZ19uYW1lc1tpXSk7CiAgICAgfQotI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCi0gICAg
aGV4X2NhdXNlX2NvZGUgPSB0Y2dfZ2xvYmFsX21lbV9uZXcodGNnX2VudiwKLSAgICAgICAgb2Zm
c2V0b2YoQ1BVSGV4YWdvblN0YXRlLCBjYXVzZV9jb2RlKSwgImNhdXNlX2NvZGUiKTsKLSNlbmRp
ZgogfQotLSAKMi4zNC4xCgo=

