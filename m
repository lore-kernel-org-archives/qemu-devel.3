Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9686C88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x53k3-0003UK-EH; Fri, 11 Sep 2026 12:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x53jZ-0003MT-AH
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:04:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x53jI-0007VV-1e
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:04:13 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BEmAa3222587
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 16:03:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Eo60+DNsjyuICsw6LBKgEDx72MyCYiY9boywOMHKNAw=; b=mjCydMtDFve2bHJo
 JrkNDiHQI1yPRpbK29IIZzmTc8CIA3TuaohoU91V89mZslqdg/lSg4+WvvWH3wJq
 QNTYbUNZdTCw64OumEbeCHwG1uZrldBFCe2RsAyVat4WmcPV0O+lAFy4xy1ktaVO
 zF4I8d1tdu8AN0iikuJAmLxAe1USVpKyXDRo/sEs0grqS+M/ZS8wsqkx2IfjeClv
 FkYUjS/juq4KMHo7bjGloUVKOPo/7eq4FRmrF8P9furs7yn+6GA1dGBYJN6v1uAV
 roLNvVespcJ4r46qHRdBEbYVDLuxFQSxCbFNCffMj4QtKh4s2Z84/R8oSF85WK1b
 onpInA==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbdrakc6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 16:03:54 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-4ab4ca7ce3fso1214925b6e.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 09:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789142634; x=1789747434; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Eo60+DNsjyuICsw6LBKgEDx72MyCYiY9boywOMHKNAw=;
 b=FIowhsfsMDiKwUaxWa6UxMExYYqW4FGTvCSIN83VSQxNUnefWAbLDoC0zGkSpy/0cm
 i0SjmsETe1wMUmC3DE9T/ylq6ZPpcbMkI2MY0PZqhasP4w7rFgkLNj6AbiA1YyYeAQLy
 bU5vkcBWL/hsBjfUuxhFsrW5MJ5wHqSDl2ouq6J8wcogi4ntz73D73ks4VUlyxm3Kaa3
 ANbFwQBMpiBPpczP4s14PkjoYFehhaF12aD66ekC1VhRzR3OhCDFyjAD8mGcpu4YevPE
 xEIVlxnERcl04GIoSm+z86+LWpnQI4kP3oQ8MWy03AzFi6P5lhlwj1wUM1YdRkLQIweL
 u+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789142634; x=1789747434;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Eo60+DNsjyuICsw6LBKgEDx72MyCYiY9boywOMHKNAw=;
 b=pRvD/78u01Y7OI3xVDDTB0/3W1YBJfE1Z7FYn/PZfB83cNdRInKa+ddewx/fapnKKM
 3pRdHTGaK9P6MuH4dLktqEgbU887aXAU4gjfaEzefFGAXQanX0eKoF4rzn9SB7yFSLRp
 50CAMnpsclraXzcQoGl1JTLqYPnzGY1gJAWoo3BkNyruFFyysuwLTtjFjBjov6thRDf0
 sG7cyRsSbwYWelOGbwQsYrdgk4o4j9ySbDw9MF87tf6kgI7T2zSksx3v9dozEBGez9M1
 Rsu53Hk6amLOxbB/8v3mdPnjpfLAe5OUXpMnqIdiH/T343mxOdX/1YuX+4ZZdEgd6f/3
 ZQ0g==
X-Gm-Message-State: AFuF++ka5kzQb0qhhXOI6u0XQ0jel2kUYOXNflo5RhDSzVMmo31lowdl
 uhSN5mhczbc/ziJN3PYDQfjqMVkxNq8A/mB1AY0Gmlx3yo4eCPnm0P37+xlePWBqYNNalJ63Cc+
 VjdJFWPB7tBQVicIhyWp+JEf4pvY5grXDcqR9uXfaYJQY4zhh2upzKwyxQbZzyDUrkg==
X-Gm-Gg: AYBFou0Lylbyx7CzuNjRopc6UBPv6KB1DDdkm1GFKlJ1nsAPvP8F3L4KwarwbIIHO7L
 e4GqSApGp91zadqVbfTZ89Kx6bYVrF+MnrRLdbbjMAQr4mpwz2OkSOjSTkaab2vBi2NlEh7nski
 GfAPaNivOKFfCQWNxNI5VnDXevCl8ktNELA/1yAYxCRSrIBPbsNVucRBVnxt+Y7aUTj628evi7m
 ZfuzKDHjKbNYH3ppTA9xnpxBbG7lSGIkbSAeFUz1F9gb2JXMc++ViqfVc9PCyEvvYV+y1iacIQu
 0eODJVmU0+9UIcjO2vQIy+1ppZ8LCYDrZhsqs4Vk4I1KjNYIogqQQhgy9U8e2cuxGCCggcVv9bb
 zvsMvb260rRe7bsDHXQE7EFpfysdaSwTnUMXfiovlTgievxGs
X-Received: by 2002:a05:6808:16a6:b0:4c3:ee9e:2001 with SMTP id
 5614622812f47-4c3ee9e2396mr1665439b6e.3.1789142633983; 
 Fri, 11 Sep 2026 09:03:53 -0700 (PDT)
X-Received: by 2002:a05:6808:16a6:b0:4c3:ee9e:2001 with SMTP id
 5614622812f47-4c3ee9e2396mr1665397b6e.3.1789142633465; 
 Fri, 11 Sep 2026 09:03:53 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c3321ecd0asm2451876b6e.17.2026.09.11.09.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 09:03:51 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 04/10] target/hexagon: add Y2_tlbpp as unimplemented
Date: Fri, 11 Sep 2026 09:03:01 -0700
Message-Id: <20260911160307.865892-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911160307.865892-1-brian.cain@oss.qualcomm.com>
References: <20260911160307.865892-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: VWzfa66bmd3uc5A8GrlyhHFIxdk8yc_l
X-Authority-Analysis: v=2.4 cv=PLmaavqC c=1 sm=1 tr=0 ts=6aa4266a cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=lfClExg8J67ehGbBbBgA:9 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-ORIG-GUID: VWzfa66bmd3uc5A8GrlyhHFIxdk8yc_l
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIyNCBTYWx0ZWRfX6Fy8AdgU75cC
 V5b//w4QLH7YboJ3esmdrb2cEQrrCjywPS7NcRP+MEMzijXyJsbL9yZjPY7h0KAZgGo++UR4rPJ
 yhBsVNd9LeE0r9OZYwXyNZVGiRSKcZ0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIyNCBTYWx0ZWRfX99SJduXZIAaP
 jyxydDCgCvcrjSQNF88tl1O2SbqZosZyQRWFJ3ifLjwTkkgmL3GqGcT9NIwuLnAx4I7OoUxaJSv
 4XCrrLAvXEGf1raTN1qzEp1BA5LTKmPE11hltVrOdt4754b4S7Ve2eAAcSWFeVnJSI4j9N9SPCx
 pT/5d+Zr2sFtWphrvnmrtipxvL0vAGtl2FgM4wgoxBiRx2QjGVDmC3mMsZQwdxaEqIAPuaRiofv
 hAm7sjDI8PvDAj78Oz8Esmsie7PfmKT0MZ0xrkgN9PiDYjhuLQDapPc5YIBEWXVDsRv1gvnju2N
 FKTdSu+MlgghGQRYofURyVvLoQ4lXKeZCMBHUCLbkb11gFxMLlURBFoxrPep3+fwb4pfBOF9fNF
 oDF0HE601+XJij9osGHRCTxWXoYb3dxQ2B1pVEP7TUmtdvQe5kTJ16qzO95tvDnkGo//B4eLL5R
 SsDqgRMk0hMYRVCJ6ug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110224
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

WTJfdGxicHAgaXMgbW9zdGx5IGFzc29jaWF0ZWQgd2l0aCB0aGUgbm90LXlldC1pbXBsZW1lbnRl
ZCBETUEKZW5naW5lLiAgTGV0J3MgZGVjb2RlIGl0IGFzIHVuaW1wbCBmb3Igbm93LgoKUmV2aWV3
ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFsY29tbS5jb20+ClNpZ25l
ZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0
YXJnZXQvaGV4YWdvbi9zeXNfbWFjcm9zLmggICAgICAgICAgIHwgMyArKysKIHRhcmdldC9oZXhh
Z29uL2F0dHJpYnNfZGVmLmguaW5jICAgICAgfCAxICsKIHRhcmdldC9oZXhhZ29uL3RhZ19yZXZf
aW5mby5jLmluYyAgICAgfCAyICsrCiB0YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9lbmNvZGVfcHAu
ZGVmIHwgMSArCiB0YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9zeXN0ZW0uaWRlZiAgIHwgMiArKwog
NSBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4
YWdvbi9zeXNfbWFjcm9zLmggYi90YXJnZXQvaGV4YWdvbi9zeXNfbWFjcm9zLmgKaW5kZXggYTQ5
YzcyNzE1ZGMuLjJlMTNiYTAwYzhhIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9zeXNfbWFj
cm9zLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vc3lzX21hY3Jvcy5oCkBAIC0xNzcsNiArMTc3LDkg
QEAKICAgICAgICAgICAgICAgICAgICAgIGZUTEJfTk9OUE9XMldSQVAoZlRMQl9JRFhNQVNLKElO
REVYKSkpCiAjZGVmaW5lIGZUTEJQKFRMQkhJKSBcCiAgICAgaGV4X3RsYl9sb29rdXAoZW52LCAo
KFRMQkhJKSA+PiAxMiksICgoVExCSEkpIDw8IDEyKSkKKyNkZWZpbmUgZlRMQlBQKFRMQkhJKSAo
eyBcCisgICAgcWVtdV9sb2dfbWFzayhMT0dfVU5JTVAsICJ0bGJwcCBpcyBub3QgaW1wbGVtZW50
ZWRcbiIpOyBcCisgICAgMDsgfSkKICNkZWZpbmUgaWljX2ZsdXNoX2NhY2hlKHApCiAKICNkZWZp
bmUgZklOX0RFQlVHX01PREUoVE5VTSkgKHsgXApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24v
YXR0cmlic19kZWYuaC5pbmMgYi90YXJnZXQvaGV4YWdvbi9hdHRyaWJzX2RlZi5oLmluYwppbmRl
eCA4YjRlYjI3ZDY4Mi4uNWE5OGVhMzMxMzkgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2F0
dHJpYnNfZGVmLmguaW5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2F0dHJpYnNfZGVmLmguaW5jCkBA
IC0yNSw2ICsyNSw3IEBAIERFRl9BVFRSSUIoTkFfTlQsICJOb24tQWxsb2NhdGluZyBOb24tVGVt
cG9yYWwgaW5zdHJ1Y3Rpb24iLCAiIiwgIiIpCiAKIERFRl9BVFRSSUIoUFJJViwgIk5vdCBhdmFp
bGFibGUgaW4gdXNlciBvciBndWVzdCBtb2RlIiwgIiIsICIiKQogREVGX0FUVFJJQihHVUVTVCwg
Ik5vdCBhdmFpbGFibGUgaW4gdXNlciBtb2RlIiwgIiIsICIiKQorREVGX0FUVFJJQihUTEJQUF9J
TlNOLCAiRXh0ZW5kZWQgKDY0LWJpdCBWQSkgVExCIHByb2JlIGluc3RydWN0aW9uIiwgIiIsICIi
KQogCiBERUZfQVRUUklCKEZQT1AsICJGbG9hdGluZyBQb2ludCBPcGVyYXRpb24iLCAiIiwgIiIp
CiAKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3RhZ19yZXZfaW5mby5jLmluYyBiL3Rhcmdl
dC9oZXhhZ29uL3RhZ19yZXZfaW5mby5jLmluYwppbmRleCA0OGJkYzUyYmZkYi4uNjhiZThjYmFm
YjIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RhZ19yZXZfaW5mby5jLmluYworKysgYi90
YXJnZXQvaGV4YWdvbi90YWdfcmV2X2luZm8uYy5pbmMKQEAgLTY0Miw2ICs2NDIsOCBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IHRhZ19yZXZfaW5mbyB0YWdfcmV2X2luZm9bWFhfTEFTVF9PUENPREVd
ID0gewogICAgIFtTMl9zdG9yZXJpX3BpX250XSA9IHsgLmludHJvZHVjZWQgPSBIRVhfVkVSX1Y3
OSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKICAgICBbWTJfZGNmZXRjaGJvX250XSA9IHsg
LmludHJvZHVjZWQgPSBIRVhfVkVSX1Y3OSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKICAg
ICBbWTJfZGN6ZXJvYV9udF0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WNzksIC5yZW1vdmVk
ID0gSEVYX1ZFUl9OT05FIH0sCisKKyAgICBbWTJfdGxicHBdID0geyAuaW50cm9kdWNlZCA9IEhF
WF9WRVJfVjgxLCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAogfTsKIAogI2VuZGlmIC8qIEhF
WEFHT05fVEFHX0FSQ0hfVEFCTEVfSCAqLwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaW1w
b3J0ZWQvZW5jb2RlX3BwLmRlZiBiL3RhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2VuY29kZV9wcC5k
ZWYKaW5kZXggZmNhOGY4YWViMWEuLjRiMzA3Yjk3YjMwIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4
YWdvbi9pbXBvcnRlZC9lbmNvZGVfcHAuZGVmCisrKyBiL3RhcmdldC9oZXhhZ29uL2ltcG9ydGVk
L2VuY29kZV9wcC5kZWYKQEAgLTg5MCw2ICs4OTAsNyBAQCBERUZfRU5DMzIoWTJfdGxidW5sb2Nr
LElDTEFTU19DUiIgMTEwMCAwMDEtLS0tLSBQUC0tLS0tLSAwMTAtLS0tLSIpCiBERUZfRU5DMzIo
WTJfazBsb2NrLCAgIElDTEFTU19DUiIgMTEwMCAwMDEtLS0tLSBQUC0tLS0tLSAwMTEtLS0tLSIp
CiBERUZfRU5DMzIoWTJfazB1bmxvY2ssIElDTEFTU19DUiIgMTEwMCAwMDEtLS0tLSBQUC0tLS0t
LSAxMDAtLS0tLSIpCiBERUZfRU5DMzIoWTJfdGxicCwgICAgIElDTEFTU19DUiIgMTEwMCAxMDBz
c3NzcyBQUC0tLS0tLSAtLS1kZGRkZCIpCitERUZfRU5DMzIoWTJfdGxicHAsIjAxMTAxMTAwMDEx
c3Nzc3NQUC0tLS0tLS0tLWRkZGRkIikKIERFRl9FTkMzMihZNV90bGJvYywgICAgSUNMQVNTX0NS
IiAxMTAwIDExMXNzc3NzIFBQLS0tLS0tIC0tLWRkZGRkIikKIERFRl9FTkMzMihZNV90bGJhc2lk
aSwgSUNMQVNTX0NSIiAxMTAwIDEwMXNzc3NzIFBQLS0tLS0tIC0tLS0tLS0tIikKIERFRl9FTkMz
MihZMl90bGJyLCAgICAgSUNMQVNTX0NSIiAxMTAwIDAxMHNzc3NzIFBQLS0tLS0tIC0tLWRkZGRk
IikKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2ltcG9ydGVkL3N5c3RlbS5pZGVmIGIvdGFy
Z2V0L2hleGFnb24vaW1wb3J0ZWQvc3lzdGVtLmlkZWYKaW5kZXggNjE4N2FkYTVhYmIuLmE1OGRh
OGY4MjY5IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9zeXN0ZW0uaWRlZgor
KysgYi90YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9zeXN0ZW0uaWRlZgpAQCAtMTE4LDYgKzExOCw4
IEBAIFE2SU5TTihZMl90bGJyLCJSZGQzMj10bGJyKFJzMzIpIiwgQVRUUklCUyhBX1BSSVYsQV9O
T1RFX1BSSVYsQV9OT1RFX05PUEFDS0VULEFfCiAKIFE2SU5TTihZMl90bGJwLCJSZDMyPXRsYnAo
UnMzMikiLCBBVFRSSUJTKEFfUFJJVixBX05PVEVfUFJJVixBX05PVEVfTk9QQUNLRVQsQV9SRVNU
UklDVF9OT1BBQ0tFVCksICJQcm9iZSBUTEIiLCB7UmRWPWZUTEJQKFJzVik7fSkKIAorUTZJTlNO
KFkyX3RsYnBwLCJSZDMyPXRsYnAoUnNzMzIpIiwgQVRUUklCUyhBX1BSSVYsQV9OT1RFX1BSSVYs
QV9OT1RFX05PUEFDS0VULEFfUkVTVFJJQ1RfTk9QQUNLRVQsQV9UTEJQUF9JTlNOKSwgIlByb2Jl
IFRMQjY0Iiwge1JkVj1mVExCUFAoUnNzVik7fSkKKwogUTZJTlNOKFk1X3RsYmFzaWRpLCJ0bGJp
bnZhc2lkKFJzMzIpIixBVFRSSUJTKEFfUFJJVixBX05PVEVfUFJJVixBX05PVEVfTk9QQUNLRVQs
QV9SRVNUUklDVF9OT1BBQ0tFVCksICJJbnZhbGlkYXRlIEFTSUQiLAogewogCWZISURFKGludCBp
OykKLS0gCjIuMzQuMQoK

