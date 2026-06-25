Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB24CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclOE-0003zk-OA; Thu, 25 Jun 2026 10:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclOB-0003b3-4M
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:49:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclO9-0000ER-4J
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:49:10 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9ju6J1753945
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=koogbpqsRfa0PrvfbI4x1+QqWqwbbpCsK4Ya9bbJIn4=; b=Jv
 OlxM8zX8Q8XpUyX775OdPx+j1mdYrgWmi4sqfuKPq4060aDmrYDdGE+jOFSiUxvB
 2I3cifkL5sUME2MQ7zgJaFEBskF/+uB5iknN39XNfUvgb8FwbUx+3N99zMv18g3K
 8cRXTHi0bKPXANhf9eEGXB270kaJG48z+mdHrCUXQi6smeJWMOijXPcABdbpLZEm
 qcgQS1U4uPjJJKiyH5n/PqsgpCXTrm27tPHhLBEWc/3aV3kIjIHza3MMV8uI4gVa
 p7iD7VWzBjWSq9Infqyvdt5n1UNtyhuFZWaLnQz9dLkiLpryh9lWwJR65DPGQG4i
 7lJdkZfWoG9MwW7P/jnQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0w0q2c1r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:57 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bcbb34e57so2846922eec.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782398936; x=1783003736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=koogbpqsRfa0PrvfbI4x1+QqWqwbbpCsK4Ya9bbJIn4=;
 b=YSxP/gVi7HXBc6S4W4B6LAb6KYXUjbw5/6lnUgNTYhy2LHFyBg1d7ARmJNU2aXURs4
 WeU8O6XLkCajL3P0xy1B3GulqfB7F+zjBksHGgACkpAOde3Un9u3rOXaQ5tPAaPAr39i
 Oa+8vY+onf8+PzBeHVMa6c0AN60/iiX3vd/O4pG+nzjGaAYzSujqp27lBtDR0mCzWaMM
 lxXZD1F8gXDaUfK3nZuiUqvKN1HylBYbUnD5xCZwwXgfA9f6CSklZjSuC3H8dIn6oz0t
 bt47y/6I5UYwK2pKbnALy1w4desU+Kp36CGUW7WwdR/Q25oxIHuDd4O2hhw+f5SoIhZ4
 HwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782398936; x=1783003736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=koogbpqsRfa0PrvfbI4x1+QqWqwbbpCsK4Ya9bbJIn4=;
 b=cVY4W9/R96hs8JEkp7ebL7v9YpmiTKDiG8pb6IMsZz/SwzVzJ+ZaCJb4eaMVtIPeiz
 p/s6okpZ7gcNleqjP7osgOCzxUpvOJ5mT6mDQD+APb35Jm/06RNPmJuipJ4mLXj02AZI
 4SO8p9Yc6Ezz5REhb6DoOhPfyQcgXIPDiWmyHNc0kOuYRBqq11hADitrdYU164XW+y0g
 xD08mKW/pAE52y9SfU50+0y7C5jXGu3xO15bUXcLrgtn9E9/ZJ2zcfrzzZyOprMNqLVe
 8tQTW8NP6M7SREntHDB+6pVeivjygIYAu3I+wJpw+BPYy0i+6wNXNfgbdhEebdhmjmfO
 toKQ==
X-Gm-Message-State: AOJu0YwBWE5ffrs3UISbuAuyypISfUDTwKIokXiLi4JMzvqPMXe6ny4R
 PDtjW/vLsLqF+BBpzVs/qbYdsv/wrXoNRLAnpv3tmCfkRuFCudVfGNNjs3+TwH8efEBRFYkGr8v
 yRnYrs7qOJQy0LP+TdTL5Js/kwxr8ywldpTHCIOteJwWBZF0mS7MHHHkodfb1Y55nvA==
X-Gm-Gg: AfdE7cnH7bPh8ISHLjyMcqGxfnMV/yHNt91QeE7aC7BFxuhX6V5/sUHsrM0WMdPJBRc
 +3I3Inv50NrRHhMeWYhpxVla/sQlRgt9TTTXpyifVb7nj6Vs4Bxx0EoptVGo76pTNNgcZrJ/nRN
 6kas91/R2eVJMnBLQ9cnovFyndCDwCEuhTWh+tScZxuIeMphz8i2yalUdkzDZv/R9LaBa1kfo8A
 axrYG1ba6c6XPH60XgT+4WXariJea4JqwLtvldlJtFOo+1OqzJ5B9iG8DVQrdlrLb1oP3z1jj38
 UXRzSwlQ3zpk8noVJmN9ifGeQCBBwJx9pvy9Q/JMnQ/ZriNMbopQPkR0ncoTqkUbPZb9Z/ZXmhU
 yRGur3YwkhQNykofwrs20+ZMBS6Gl9DbYOy/7hBrcEkQCPLtuaQCfzInjQL8=
X-Received: by 2002:a05:7301:9e41:b0:30c:472a:248 with SMTP id
 5a478bee46e88-30c84df9c55mr2745710eec.32.1782398936336; 
 Thu, 25 Jun 2026 07:48:56 -0700 (PDT)
X-Received: by 2002:a05:7301:9e41:b0:30c:472a:248 with SMTP id
 5a478bee46e88-30c84df9c55mr2745689eec.32.1782398935772; 
 Thu, 25 Jun 2026 07:48:55 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8afca8sm8999209eec.17.2026.06.25.07.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:48:55 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 72/76] hw/hexagon: Add v68, sa8775-cdsp0 defs
Date: Thu, 25 Jun 2026 07:16:29 -0700
Message-Id: <20260625141633.449487-73-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: _WHd1XecJ12FTqAMttrq6xCjxpQkW2Ms
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfX9vyqilZINefv
 OiQvKL3YVitWOJeRETrjqNhOuyH+AbjzTUqrggHCLdOv3qZzNr7mWv0L/Pl4tCY0LzK2o2exnzD
 +XwCAEA2QXE5iXpHXeUI8iDpn6WphOA=
X-Proofpoint-GUID: _WHd1XecJ12FTqAMttrq6xCjxpQkW2Ms
X-Authority-Analysis: v=2.4 cv=R6Ez39RX c=1 sm=1 tr=0 ts=6a3d3fd9 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=G5se95cPlkO2hgD9IGUA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfX3jESOMKdDGfs
 KjyDU2Ay06e1iYRSIKAVwRoiGqmO95zZrkPnPobxitwtsRSwwdAvwE4EegOW+5pNQ+F8RxupLaJ
 Yiddb6a55m9RsL/rEEICtRyjpXrdsDeeIHNtiprgmtqkbEV9RCpQVYrgurmRXSpWhY6qiig+zRw
 WJxaA3ZAt2GHTw7oxeCJd83g4GGQcJv8oLCXz0LMSHKpmYvDUOKdsFej4f+5I3J1MnBdZt2Ruj5
 izl8qDYTlKSBi0wI7OMW3Ws7NdPeAHtpVAfxWbpg3OqrtlMLfVNgPGPzHVnZxAMzlfUC+629chE
 eSs5gTI28QOO9fGhNhlij5Nc0hMiayYbPTzoAhbaEl64nIDxLMM6vTD1Qx75+8VO5LUd7mHAt4h
 sseTYGmOK8Owzn8HrPGxv/BIgksOmZNYf0z5fPygIxECeLkUeSig3T9FnqOvf1n3vFtotPPimcC
 yXykNgX3J7jIlZsw7EQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250127
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpBY2tlZC1ieTogVGF5bG9yIFNp
bXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KQWNrZWQtYnk6IFBoaWxpcHBlIE1hdGhp
ZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZp
ZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJp
YW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGh3L2hleGFnb24vbWFj
aGluZV9jZmdfc2E4Nzc1X2Nkc3AwLmguaW5jIHwgNjQgKysrKysrKysrKysrKysrKysrKysrKysK
IGh3L2hleGFnb24vbWFjaGluZV9jZmdfdjY4bl8xMDI0LmguaW5jICAgIHwgNjQgKysrKysrKysr
KysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTI4IGluc2VydGlvbnMoKykKIGNyZWF0
ZSBtb2RlIDEwMDY0NCBody9oZXhhZ29uL21hY2hpbmVfY2ZnX3NhODc3NV9jZHNwMC5oLmluYwog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2hleGFnb24vbWFjaGluZV9jZmdfdjY4bl8xMDI0LmguaW5j
CgpkaWZmIC0tZ2l0IGEvaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ19zYTg3NzVfY2RzcDAuaC5pbmMg
Yi9ody9oZXhhZ29uL21hY2hpbmVfY2ZnX3NhODc3NV9jZHNwMC5oLmluYwpuZXcgZmlsZSBtb2Rl
IDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uNDQyY2JlM2JlMzEKLS0tIC9kZXYvbnVsbAorKysg
Yi9ody9oZXhhZ29uL21hY2hpbmVfY2ZnX3NhODc3NV9jZHNwMC5oLmluYwpAQCAtMCwwICsxLDY0
IEBACisvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlciAqLworCitz
dGF0aWMgY29uc3Qgc3RydWN0IGhleGFnb25fbWFjaGluZV9jb25maWcgU0E4Nzc1UF9jZHNwMCA9
IHsKKyAgICAuY2ZnYmFzZSA9ICAgICAgICAgMHgyNDAwMDAwMCArIDB4MTgwMDAwLAorICAgIC5s
MnRjbV9zaXplID0gICAgICAweDAwMDAwMDAwLAorICAgIC5sMnZpY19iYXNlID0gICAgICAweDI2
MzAwMDAwICsgMHg5MDAwMCwKKyAgICAubDJ2aWNfc2l6ZSA9ICAgICAgMHgwMDAwMTAwMCwKKyAg
ICAuY3NyX2Jhc2UgPSAgICAgICAgMHgyNjMwMDAwMCwKKyAgICAucXRtcl9yZWdpb24gPSAgICAg
MHgyNjMwMDAwMCArIDB4QTEwMDAsCisgICAgLmNmZ3RhYmxlID0geworICAgICAgICAubDJ0Y21f
YmFzZSA9IDB4MDAwMDI0MDAsCisgICAgICAgIC5yZXNlcnZlZDAgPSAweDAwMDAwMDAwLAorICAg
ICAgICAuc3Vic3lzdGVtX2Jhc2UgPSAweDAwMDAyNjM4LAorICAgICAgICAuZXRtX2Jhc2UgPSAw
eDAwMDAyNDE5LAorICAgICAgICAubDJjZmdfYmFzZSA9IDB4MDAwMDI0MWEsCisgICAgICAgIC5y
ZXNlcnZlZDEgPSAweDAwMDAyNDFiLAorICAgICAgICAubDFzMF9iYXNlID0gMHgwMDAwMjUwMCwK
KyAgICAgICAgLmF4aTJfbG93YWRkciA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5zdHJlYW1lcl9i
YXNlID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLnJlc2VydmVkMiA9IDB4MDAwMDAwMDAsCisgICAg
ICAgIC5mYXN0bDJ2aWNfYmFzZSA9IDB4MDAwMDI0MWUsCisgICAgICAgIC5qdGxiX3NpemVfZW50
cmllcyA9IDB4MDAwMDAwODAsCisgICAgICAgIC5jb3Byb2NfcHJlc2VudCA9IDB4MDAwMDAwMDEs
CisgICAgICAgIC5leHRfY29udGV4dHMgPSAweDAwMDAwMDA0LAorICAgICAgICAudnRjbV9iYXNl
ID0gMHgwMDAwMjUwMCwKKyAgICAgICAgLnZ0Y21fc2l6ZV9rYiA9IDB4MDAwMDIwMDAsCisgICAg
ICAgIC5sMnRhZ19zaXplID0gMHgwMDAwMDQwMCwKKyAgICAgICAgLmwyZWNvbWVtX3NpemUgPSAw
eDAwMDAwMDAwLAorICAgICAgICAudGhyZWFkX2VuYWJsZV9tYXNrID0gMHgwMDAwMDAzZiwKKyAg
ICAgICAgLmVjY3JlZ19iYXNlID0gMHgwMDAwMjQxZiwKKyAgICAgICAgLmwybGluZV9zaXplID0g
MHgwMDAwMDA4MCwKKyAgICAgICAgLnRpbnlfY29yZSA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5s
Mml0Y21fc2l6ZSA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5sMml0Y21fYmFzZSA9IDB4MDAwMDI0
MDAsCisgICAgICAgIC5yZXNlcnZlZDMgPSAweDAwMDAwMDAwLAorICAgICAgICAuZHRtX3ByZXNl
bnQgPSAweDAwMDAwMDAwLAorICAgICAgICAuZG1hX3ZlcnNpb24gPSAweDAwMDAwMDAzLAorICAg
ICAgICAuaHZ4X3ZlY19sb2dfbGVuZ3RoID0gMHgwMDAwMDAwNywKKyAgICAgICAgLmNvcmVfaWQg
PSAweDAwMDAwMDAwLAorICAgICAgICAuY29yZV9jb3VudCA9IDB4MDAwMDAwMDAsCisgICAgICAg
IC5jb3Byb2MyX3JlZzAgPSAweDAwMDAwMDQwLAorICAgICAgICAuY29wcm9jMl9yZWcxID0gMHgw
MDAwMDAyMCwKKyAgICAgICAgLnYyeF9tb2RlID0gMHgwMDAwMDAwMSwKKyAgICAgICAgLmNvcHJv
YzJfcmVnMiA9IDB4MDAwMDAwMDgsCisgICAgICAgIC5jb3Byb2MyX3JlZzMgPSAweDAwMDAwMDIw
LAorICAgICAgICAuY29wcm9jMl9yZWc0ID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmNvcHJvYzJf
cmVnNSA9IDB4MDAwMDAwMDIsCisgICAgICAgIC5jb3Byb2MyX3JlZzYgPSAweDAwMDAwMDE2LAor
ICAgICAgICAuY29wcm9jMl9yZWc3ID0gMHgwMDAwMDAwNiwKKyAgICAgICAgLmFjZF9wcmVzZXQg
PSAweDAwMDAwMDAxLAorICAgICAgICAubW5kX3ByZXNldCA9IDB4MDAwMDAwMDAsCisgICAgICAg
IC5sMWRfc2l6ZV9rYiA9IDB4MDAwMDAwMTAsCisgICAgICAgIC5sMWlfc2l6ZV9rYiA9IDB4MDAw
MDAwMjAsCisgICAgICAgIC5sMWRfd3JpdGVfcG9saWN5ID0gMHgwMDAwMDAwMiwKKyAgICAgICAg
LnZ0Y21fYmFua193aWR0aCA9IDB4MDAwMDAwODAsCisgICAgICAgIC5yZXNlcnZlZDQgPSAweDAw
MDAwMDAxLAorICAgICAgICAucmVzZXJ2ZWQ1ID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLnJlc2Vy
dmVkNiA9IDB4MDAwMDAwMDMsCisgICAgICAgIC5jb3Byb2MyX2N2dF9tcHlfc2l6ZSA9IDB4MDAw
MDAwMGEsCisgICAgICAgIC5jb25zaXN0ZW5jeV9kb21haW4gPSAweDAwMDAwMGUwLAorICAgICAg
ICAuY2FwYWNpdHlfZG9tYWluID0gMHgwMDAwMDA4MCwKKyAgICAgICAgLmF4aTNfbG93YWRkciA9
IDB4MDAwMDAwMDAsCisgICAgfSwKK307CmRpZmYgLS1naXQgYS9ody9oZXhhZ29uL21hY2hpbmVf
Y2ZnX3Y2OG5fMTAyNC5oLmluYyBiL2h3L2hleGFnb24vbWFjaGluZV9jZmdfdjY4bl8xMDI0Lmgu
aW5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwLi4wYzc5Njg5YmMyMQot
LS0gL2Rldi9udWxsCisrKyBiL2h3L2hleGFnb24vbWFjaGluZV9jZmdfdjY4bl8xMDI0LmguaW5j
CkBAIC0wLDAgKzEsNjQgQEAKKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9y
LWxhdGVyICovCisKK3N0YXRpYyBjb25zdCBzdHJ1Y3QgaGV4YWdvbl9tYWNoaW5lX2NvbmZpZyB2
NjhuXzEwMjQgPSB7CisgICAgLmNmZ2Jhc2UgPSAgICAgICAgICAgMHhkZTAwMDAwMCwKKyAgICAu
bDJ0Y21fc2l6ZSA9ICAgICAgICAweDAwMDAwMDAwLAorICAgIC5sMnZpY19iYXNlID0gICAgICAg
IDB4ZmM5MTAwMDAsCisgICAgLmwydmljX3NpemUgPSAgICAgICAgMHgwMDAwMTAwMCwKKyAgICAu
Y3NyX2Jhc2UgPSAgICAgICAgICAweGZjOTAwMDAwLAorICAgIC5xdG1yX3JlZ2lvbiA9ICAgICAg
IDB4ZmM5MjEwMDAsCisgICAgLmNmZ3RhYmxlID0geworICAgICAgICAubDJ0Y21fYmFzZSA9IDB4
MDAwMGQ4MDAsCisgICAgICAgIC5yZXNlcnZlZDAgPSAweDAwMDAwMDAwLAorICAgICAgICAuc3Vi
c3lzdGVtX2Jhc2UgPSAweDAwMDBmYzkwLAorICAgICAgICAuZXRtX2Jhc2UgPSAweDAwMDBkODE5
LAorICAgICAgICAubDJjZmdfYmFzZSA9IDB4MDAwMGQ4MWEsCisgICAgICAgIC5yZXNlcnZlZDEg
PSAweDAwMDAwMDAwLAorICAgICAgICAubDFzMF9iYXNlID0gMHgwMDAwZDg0MCwKKyAgICAgICAg
LmF4aTJfbG93YWRkciA9IDB4MDAwMDMwMDAsCisgICAgICAgIC5zdHJlYW1lcl9iYXNlID0gMHgw
MDAwZDgxYywKKyAgICAgICAgLnJlc2VydmVkMiA9IDB4MDAwMGQ4MWQsCisgICAgICAgIC5mYXN0
bDJ2aWNfYmFzZSA9IDB4MDAwMGQ4MWUsCisgICAgICAgIC5qdGxiX3NpemVfZW50cmllcyA9IDB4
MDAwMDAwODAsCisgICAgICAgIC5jb3Byb2NfcHJlc2VudCA9IDB4MDAwMDAwMDEsCisgICAgICAg
IC5leHRfY29udGV4dHMgPSAweDAwMDAwMDA0LAorICAgICAgICAudnRjbV9iYXNlID0gMHgwMDAw
ZDg0MCwKKyAgICAgICAgLnZ0Y21fc2l6ZV9rYiA9IDB4MDAwMDEwMDAsCisgICAgICAgIC5sMnRh
Z19zaXplID0gMHgwMDAwMDQwMCwKKyAgICAgICAgLmwyZWNvbWVtX3NpemUgPSAweDAwMDAwNDAw
LAorICAgICAgICAudGhyZWFkX2VuYWJsZV9tYXNrID0gMHgwMDAwMDAzZiwKKyAgICAgICAgLmVj
Y3JlZ19iYXNlID0gMHgwMDAwZDgxZiwKKyAgICAgICAgLmwybGluZV9zaXplID0gMHgwMDAwMDA4
MCwKKyAgICAgICAgLnRpbnlfY29yZSA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5sMml0Y21fc2l6
ZSA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5sMml0Y21fYmFzZSA9IDB4MDAwMGQ4MjAsCisgICAg
ICAgIC5yZXNlcnZlZDMgPSAweDAwMDAwMDAwLAorICAgICAgICAuZHRtX3ByZXNlbnQgPSAweDAw
MDAwMDAwLAorICAgICAgICAuZG1hX3ZlcnNpb24gPSAweDAwMDAwMDAxLAorICAgICAgICAuaHZ4
X3ZlY19sb2dfbGVuZ3RoID0gMHgwMDAwMDAwNywKKyAgICAgICAgLmNvcmVfaWQgPSAweDAwMDAw
MDAwLAorICAgICAgICAuY29yZV9jb3VudCA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5jb3Byb2My
X3JlZzAgPSAweDAwMDAwMDQwLAorICAgICAgICAuY29wcm9jMl9yZWcxID0gMHgwMDAwMDAyMCwK
KyAgICAgICAgLnYyeF9tb2RlID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLmNvcHJvYzJfcmVnMiA9
IDB4MWYxZjFmMWYsCisgICAgICAgIC5jb3Byb2MyX3JlZzMgPSAweDFmMWYxZjFmLAorICAgICAg
ICAuY29wcm9jMl9yZWc0ID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLmNvcHJvYzJfcmVnNSA9IDB4
MWYxZjFmMWYsCisgICAgICAgIC5jb3Byb2MyX3JlZzYgPSAweDFmMWYxZjFmLAorICAgICAgICAu
Y29wcm9jMl9yZWc3ID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLmFjZF9wcmVzZXQgPSAweDFmMWYx
ZjFmLAorICAgICAgICAubW5kX3ByZXNldCA9IDB4MWYxZjFmMWYsCisgICAgICAgIC5sMWRfc2l6
ZV9rYiA9IDB4MWYxZjFmMWYsCisgICAgICAgIC5sMWlfc2l6ZV9rYiA9IDB4MWYxZjFmMWYsCisg
ICAgICAgIC5sMWRfd3JpdGVfcG9saWN5ID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLnZ0Y21fYmFu
a193aWR0aCA9IDB4MWYxZjFmMWYsCisgICAgICAgIC5yZXNlcnZlZDQgPSAweDFmMWYxZjFmLAor
ICAgICAgICAucmVzZXJ2ZWQ1ID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLnJlc2VydmVkNiA9IDB4
MWYxZjFmMWYsCisgICAgICAgIC5jb3Byb2MyX2N2dF9tcHlfc2l6ZSA9IDB4MWYxZjFmMWYsCisg
ICAgICAgIC5jb25zaXN0ZW5jeV9kb21haW4gPSAweDFmMWYxZjFmLAorICAgICAgICAuY2FwYWNp
dHlfZG9tYWluID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLmF4aTNfbG93YWRkciA9IDB4MWYxZjFm
MWYsCisgICAgfSwKK307Ci0tIAoyLjM0LjEKCg==

