Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D3310F6FBF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7xUd-00010E-99; Wed, 01 Apr 2026 11:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xUO-0000pE-Nj
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xUN-00083w-1A
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:16 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631CPvXr1285902
 for <qemu-devel@nongnu.org>; Wed, 1 Apr 2026 15:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3X8bvXVW52I3fn1FyNjUiMXuaCQjKXZ/zTx+8O5PNqc=; b=ImeCLWb6hKMJ9FA9
 vW/RwYyAnCUfY4g2jezy/9p/SUrnN8L9FOA3yoMvLT8TIE1eXzoH4uzg+sH6cWN/
 lNNDPUYIHlftr8x9o7V1iqesAEmbOOW88miq5XCQOdcYoiFTJLSohoLGJN15DjfI
 ZcpAdsxsvI3eb2lPFPKGwoKLBvgFZxzEaJLR4XLgVO0plfIybGcYZO/Pc8NOdOYN
 09QsYAA85kVv18s7IIVXrtnOU8JNc9dpq2QfLK0SAJ3BlAA3kYpVKOHd4wl2pQ8w
 GN0C/sCqoGQa8WAql1kFl0CpXCzqvr7YAeZ2RL6BVc2dUN9YeZZqI67OlMB4zb8O
 mBKUeQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8xm3t2t1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 15:28:07 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2bdf6fe90a9so6985018eec.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 08:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775057283; x=1775662083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3X8bvXVW52I3fn1FyNjUiMXuaCQjKXZ/zTx+8O5PNqc=;
 b=h3/3kBRguCxT0wYRriiZU+h7xVHY40echSp0gxrjjUwBgTjAK/J7qLjJaF4qi/xoeC
 FNPZZzPrPjzf2cnf5kCRA1PWcMaNJdeVczIzg1Izscn6/xtY7W4eVdx1uS2F6JcnsBmf
 t6dxGoYr8iSLNV0zSwqEXdnODxSI0coFPYVmoVq/XiCzRigzEkh8xbFonjUKrmrCTUmw
 69NaxAKR0jqo/aB4YhOauo26sJCudhZVdIOLZ9oow6z0yKAntnyEY0vgxBAtB5T76LfE
 HmBWDtDX7Jgz2ewA7102pc9/tZ3uGp4eoEAdYGA4Xblki173qACWtkP8bks6mqNIZjjb
 ys0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775057283; x=1775662083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3X8bvXVW52I3fn1FyNjUiMXuaCQjKXZ/zTx+8O5PNqc=;
 b=VzuUpgyt4VGAf2UyKrTLxTWLXwq98qEEWyQOJeO/xxDcmDTgp2cxIRo8YxDjmxckmq
 GGJlSBdRe51fmg46qMPha1Xlx2ME4h3rlLkWC/TkgoXofCsZSYY2b3s975VnxJ6u18JS
 FJPnYE+Y5Vy1xal63i9g1/wfcxXIbUVYFNAV4Jq23dQFT2eb0J4fS4cFAVvzwKEgri42
 5l0GYPc2gY6iXLs9ur8qKgPWd6wu2IMENsF3rxMn1bm/y6TWr4tDtMGG88S5F0i3hVaY
 M/3wZ7yEpoYArvV09evY+za+sq1dFkp4O5Fx7+OKV4jd1ItRKIBl2hngJuYq8shqms95
 XQrA==
X-Gm-Message-State: AOJu0YxhACTohc8PlturX/u2EExbiUQCmJLdwJ6Uq+GsMY2kG3zcejfe
 p77jVbCCcRoEzftX8QvQM3OIApWgGpYiMJuriTt6Kqr3L8Mv7qPGDTtvSlN7agFAq+jYFUPR8ly
 MR7Ki3GuvjIOPS6isGiPoAxmDaGLw/mnVtODDtGK3QJL47Ag9XXZ2hWiQlws9MMnAOQ==
X-Gm-Gg: ATEYQzym5Mj0sQxUUwZV5GiGdwMZfytO2EqrXJF9HV/4BE8Q+PXQWiyiwJny6UfmW8U
 GxkjIxIbx4WlBo43lysG0DVRPKQ36WC4Bdl2uyRQneZDpm2MzNhWh1jKfeH7wmm+hmY3G6tnnMJ
 QN1gMBmct5eGi78d5XQII3mg4ETNDO8rmHQFE4gCCdROGvuDuhm6+RdVrcSXR2l8aq6+HzONqGH
 2Q13zIz+ArFOELxnvj3e0Pe+g5Q7e8+0714mDHptQshmW80b1YvBIAaH4ObPy/CWRU9mbbW830M
 NJbdJ2W+YY+0foC6MEWxU1i2wILjJ0a/MxQztpdReK44R8oMjcpNnqSD3h+AAYtC/NAVs5xDflD
 UXYswazJwns87z4vpal9NCyjgQ90rMkvxGTKEzPWwpfpJdm1bO633l9lyp1CHosUL/mJrWg==
X-Received: by 2002:a05:7300:2391:b0:2c5:50fe:c792 with SMTP id
 5a478bee46e88-2c931177af7mr2117650eec.12.1775057282875; 
 Wed, 01 Apr 2026 08:28:02 -0700 (PDT)
X-Received: by 2002:a05:7300:2391:b0:2c5:50fe:c792 with SMTP id
 5a478bee46e88-2c931177af7mr2117620eec.12.1775057282302; 
 Wed, 01 Apr 2026 08:28:02 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca78df3b84sm38491eec.5.2026.04.01.08.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 08:28:01 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6 18/37] target/hexagon: Add placeholder greg/sreg r/w helpers
Date: Wed,  1 Apr 2026 08:26:38 -0700
Message-Id: <20260401152657.314902-19-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=L90QguT8 c=1 sm=1 tr=0 ts=69cd3987 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=wA0rHRt5QP8iJxr38i8A:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: M6RWljLrQQBU0q52xXBszstxdKM9Nk_G
X-Proofpoint-GUID: M6RWljLrQQBU0q52xXBszstxdKM9Nk_G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE0NCBTYWx0ZWRfXx2QjFIbbmB9x
 bmCUeyZ1zviKkmWyhCZeWuXlNPd1rh9VcvUCZTYMw5O0I/YLq9He6sm3tpbmMAvUdHhL5Su88pA
 J2kt319ruV0x70OSwaJgpJNUzLjyZW7c7USEztpDXVnKrGpEtqxAx4y7JZFQtgLqqP54X2womu4
 sKsYSlI68dAXGvV0r+PUmR8LnJOQ+HTqk2DOxWeyx6LmxY5sK9vx96ropeRMuMe+BK+7TNw0Zyf
 yvlS9SHSgCnfeiUaPBjLYGhv8oN8/e7QJJ8t5jJx9Wo+i4erSTa0Mc80W1LOYQHk4tedaFeac6s
 0OtFITaVDXr9Wncm/sBsU1Zlld46auIDkqYWiDR9je5XJK7WEz6ae+sO6znv+rZzso153Lz85s7
 co+H2PvJUi5zpn5zpBmml3YGqu5AbSlseTf9lmGxsRZbDgrF3Cdka1TUlWDXxR3ANpimjMokuNv
 V0EPYjOCjN+wzng8pkA==
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

