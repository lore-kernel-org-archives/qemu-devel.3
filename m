Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A3210F9974
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYT7-0006pO-K9; Wed, 08 Apr 2026 15:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAY4V-0006Pb-OB
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:56:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAKOl-0005Yp-Qk
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:20:18 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637M6pEx2451580
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 04:20:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BQPx51Ys0BSe0nfcuWwE/ESRFU/f2P1cefwHo05cHP0=; b=H0fkjJABVhqpfTB9
 Lfb2hbIupYTm7q73Ka4jTZwKqrNpP8nQF1cRhVcQjnRk1vDmojJjEoQLJUbgKxfU
 nfe8sCxEeUUHoamVyyptOVi8f9RE1he5zvAW8qMCavHg/4/JILZGpVaEBJgyySqo
 Z9tNvv/ifDH9Rp8Rqd+G4SOiMpmxj7dOSTlTzBbSSXvpa2BtUZJuEHUA8r7JnxuO
 qG6GRhW0lCE4jfj3HA60p6cKZw2l8xaDZduNUk0uhxV5cZIs2pzK913vHSjJmhre
 7BTmLWyOq2ywAoKQ8KuE8dbJQNK7k9AWcfgqQTlIxMYn5pbiIg9xOJ6C+uXuN0iO
 uaCPgQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddae68wkj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:20:12 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-126e8ee6227so9485807c88.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 21:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775622011; x=1776226811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BQPx51Ys0BSe0nfcuWwE/ESRFU/f2P1cefwHo05cHP0=;
 b=QAysKq6CEC2Oz+Aotcg4A83Q/kuN142MN1zXvXj4sIEcBIHwRRbdBNklKBIJfvR2mP
 zs0dblrgyWem6wxUVJdOWSz6KITymNo19B32dpC1nUkLGajTqvv22Veyzjjb9SW3lK3G
 8TL4009FUlTsHYsiqyRbMcADgRpn2GFfMGT9q/pOCZQ3+WIc2Mur9Nd+n8OXKNzQ3v0Z
 ZY1hEkGpwiDHopbq8I1ejOJIeGWwc5Oa2GxiR1KkeDgsiIMmFZ93u/D+E4FFPE903RDv
 5j6TYwuqspBIn0ISEjouzzUAi/vjgVgQ8ZIIzmw4AQmT978Ij5HzyL1weKVGehGs72qq
 mvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775622011; x=1776226811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BQPx51Ys0BSe0nfcuWwE/ESRFU/f2P1cefwHo05cHP0=;
 b=A4WNxSnZD6Du7xUOypPcr+UYKjpDZq+KApM7h2nfELQiueHqt+TdG+3gwbbuqp718u
 LGJj4Kkh1FEndhuwhq3gVnNbzqy2fmnfxSPkMiatZ0hh8bbycVmvEf0xLKvDTr9LU73i
 ZrTjfYzbR8TS2fy81sjkBLrYi7es/Wb0XHHncTaluZvP+IT+Bb4iJDH22p7bItzTQxG8
 CCTDAqxOtEbMlwIMQQfPsA5FLo/8vqo6/e8WCfEk9ICOGTUpPFC0N3TPZFvCP2T/hESI
 NLKeKgQheaXnIS/ZsG4QZBLzEuuyC6ZsKCvtYhsiud4e+erAZXU+0GJUUKzYOsJTc7GL
 J8tg==
X-Gm-Message-State: AOJu0YxjMK8/R/+noURdIBT6hl0KDCXROceN8f/BNoG8kEKKnK92DZQo
 zv1N7ndyG3URm7rl4IucmHmex9H5yKY4cqO4gnrny6dZBg6xhf8nl9NybVb9rhAlWhxXu8YKFLw
 2kuJNJVA0lbgIFodsz1b8zQ3GBAqB12nItpFDcqs3eRVQtMWu/IV/SYGs9GYeBrWJ9A==
X-Gm-Gg: AeBDiev0ssnYWf9CivjbWluH2dhOQWq3qm4mM2qP8nPZP0SxW58PF8YZLs6upfjB2cp
 NuJ5VAPgXx0kFQJZrBWKfB3dkPeXeJbPlwuVSDTwlnV1NsbeqVdgKlAeYRQgrsNYh9knuOQjiGb
 5QDe4vV/FjRl+KHVFvL13F5KPUBf4Cd2uXuiKquGq0n9UESSIFEzttPPJeQPdC6H8Vgptj39hUL
 HTdsaZacchlhu5mjF/yJCMfUXrLE3nDZP/5BEqavvnGI3frjDDpwDfKkCxV/oeDSwy8BKFV+CsF
 ZKAAMaCx4qfd5W4aJhI62BlQnuRPFpmpC2GpSbaZMSh7Kj2M1F/zSaGchhHoC1rL5VgftEuxn7g
 1PpD6lpGlkcE94eyiJxfQ/cd5SMgmZhS5SVg+iQYWoyAZQn5+at/3pC0OX4iA01FUZmE62A==
X-Received: by 2002:a05:7022:b81:b0:119:e55a:9c03 with SMTP id
 a92af1059eb24-12bfb765d17mr8578869c88.31.1775622011060; 
 Tue, 07 Apr 2026 21:20:11 -0700 (PDT)
X-Received: by 2002:a05:7022:b81:b0:119:e55a:9c03 with SMTP id
 a92af1059eb24-12bfb765d17mr8578863c88.31.1775622010517; 
 Tue, 07 Apr 2026 21:20:10 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c14a371b1sm6480362c88.13.2026.04.07.21.20.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 21:20:10 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 02/28] target/hexagon: Implement iassign{r,w} helpers
Date: Tue,  7 Apr 2026 21:19:27 -0700
Message-Id: <20260408041953.1899532-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
References: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX/GabarmlZ4HV
 zpst8jWpHfJ2PPTkoC9+QBQNmLGmNTOHPwWWKTt4yKeFE6dXJoo4zYr/zl+eikrNUXLyIWoNbjB
 Ff6tcwi/KGSSPHzb0RTJa1ECyZiz08bOh/remE39tph6Pu8s00GUTIrpz3u3p9uBQXCwlwuUgND
 DccGaCDwxhZWGgmn5fL/pBxyO0OB1CYUNxHMBQxcXTvEUqwshkN6ukqQI5gNVLRqJ3SZ5i4al0P
 pNF0hwCGuaL5mkdXkDGZlP+LRK660EQuSmIQFX94Ky7Nnw5PrazG/AiBXxP/6hJk2gYCdgG1zi1
 B6VLzGgcsYNdbz+flF51PXkx5SXqzkLokcqsFjq77txB0brNADk2azogblwH/eZgXq8aA8/HnZ1
 ql3+vf1JxP1B8bt/QxuOg7smKzAT0kaMpxA/ZLqZlhFQ4zgPQYjWXnXin/0kBYLgUAlKB8aIZeO
 D8uOgRuyyguZUjppm7A==
X-Proofpoint-GUID: xYaccXacgJ7mMuQ4GUWcjN0j3o4j49-4
X-Proofpoint-ORIG-GUID: xYaccXacgJ7mMuQ4GUWcjN0j3o4j49-4
X-Authority-Analysis: v=2.4 cv=K4AS2SWI c=1 sm=1 tr=0 ts=69d5d77c cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=VnV9S1Uu6eltRR5mmX4A:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080036
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgppYXNzaWdue3Isd30gYXJlIHRo
ZSAiSW50ZXJydXB0IHRvIHRocmVhZCBhc3NpZ25tZW50IHtyZWFkLHdyaXRlfSIKaW5zdHJ1Y3Rp
b25zLgoKUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5j
b20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNv
bT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyB8IDU2ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgNTQgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBi
L3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IDA0ZDlmMTI4NmM5Li43ZTZlMDRlNTEy
YSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hl
eGFnb24vb3BfaGVscGVyLmMKQEAgLTE0MTYsMTIgKzE0MTYsNjQgQEAgdm9pZCBIRUxQRVIoY3N3
aSkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IG1hc2spCiAKIHZvaWQgSEVMUEVSKGlh
c3NpZ253KShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3Qgc3JjKQogewotICAgIGdfYXNz
ZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgdWludDMyX3QgbW9kZWN0bDsKKyAgICB1aW50MzJfdCB0
aHJlYWRfZW5hYmxlZF9tYXNrOworICAgIENQVVN0YXRlICpjcHU7CisgICAgSGV4YWdvbkNQVSAq
aGV4X2NwdTsKKworICAgIEJRTF9MT0NLX0dVQVJEKCk7CisgICAgaGV4X2NwdSA9IGVudl9hcmNo
Y3B1KGVudik7CisgICAgbW9kZWN0bCA9IGhleF9jcHUtPmdsb2JhbHJlZ3MgPworICAgICAgICBo
ZXhhZ29uX2dsb2JhbHJlZ19yZWFkKGhleF9jcHUtPmdsb2JhbHJlZ3MsIEhFWF9TUkVHX01PREVD
VEwsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJZCkgOiAwOwor
ICAgIHRocmVhZF9lbmFibGVkX21hc2sgPSBHRVRfRklFTEQoTU9ERUNUTF9FLCBtb2RlY3RsKTsK
KworICAgIENQVV9GT1JFQUNIKGNwdSkgeworICAgICAgICBDUFVIZXhhZ29uU3RhdGUgKnRocmVh
ZF9lbnYgPSAmKEhFWEFHT05fQ1BVKGNwdSktPmVudik7CisgICAgICAgIHVpbnQzMl90IHRocmVh
ZF9pZF9tYXNrID0gMHgxIDw8IHRocmVhZF9lbnYtPnRocmVhZElkOworICAgICAgICBpZiAodGhy
ZWFkX2VuYWJsZWRfbWFzayAmIHRocmVhZF9pZF9tYXNrKSB7CisgICAgICAgICAgICB1aW50MzJf
dCBpbWFzayA9IHRocmVhZF9lbnYtPnRfc3JlZ1tIRVhfU1JFR19JTUFTS107CisgICAgICAgICAg
ICB1aW50MzJfdCBpbnRiaXRwb3MgPSAoc3JjID4+IDE2KSAmIDB4RjsKKyAgICAgICAgICAgIHVp
bnQzMl90IHZhbCA9IChzcmMgPj4gdGhyZWFkX2Vudi0+dGhyZWFkSWQpICYgMHgxOworICAgICAg
ICAgICAgaW1hc2sgPSBkZXBvc2l0MzIoaW1hc2ssIGludGJpdHBvcywgMSwgdmFsKTsKKyAgICAg
ICAgICAgIHRocmVhZF9lbnYtPnRfc3JlZ1tIRVhfU1JFR19JTUFTS10gPSBpbWFzazsKKworICAg
ICAgICAgICAgcWVtdV9sb2dfbWFzayhDUFVfTE9HX0lOVCwgIiVzOiB0aHJlYWQgIiBUQVJHRVRf
Rk1UX2xkCisgICAgICAgICAgICAgICAiLCBuZXcgaW1hc2sgMHglIiBQUkl4MzIgIlxuIiwgX19m
dW5jX18sCisgICAgICAgICAgICAgICB0aHJlYWRfZW52LT50aHJlYWRJZCwgaW1hc2spOworICAg
ICAgICB9CisgICAgfQorICAgIGhleF9pbnRlcnJ1cHRfdXBkYXRlKGVudik7CiB9CiAKIHVpbnQz
Ml90IEhFTFBFUihpYXNzaWducikoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHNyYykK
IHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIHVpbnQzMl90IG1vZGVjdGw7Cisg
ICAgdWludDMyX3QgdGhyZWFkX2VuYWJsZWRfbWFzazsKKyAgICB1aW50MzJfdCBpbnRiaXRwb3M7
CisgICAgdWludDMyX3QgZGVzdF9yZWc7CisgICAgQ1BVU3RhdGUgKmNwdTsKKyAgICBIZXhhZ29u
Q1BVICpoZXhfY3B1OworCisgICAgQlFMX0xPQ0tfR1VBUkQoKTsKKyAgICBoZXhfY3B1ID0gZW52
X2FyY2hjcHUoZW52KTsKKyAgICBtb2RlY3RsID0gaGV4X2NwdS0+Z2xvYmFscmVncyA/CisgICAg
ICAgIGhleGFnb25fZ2xvYmFscmVnX3JlYWQoaGV4X2NwdS0+Z2xvYmFscmVncywgSEVYX1NSRUdf
TU9ERUNUTCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnYtPnRocmVhZElkKSA6
IDA7CisgICAgdGhyZWFkX2VuYWJsZWRfbWFzayA9IEdFVF9GSUVMRChNT0RFQ1RMX0UsIG1vZGVj
dGwpOworICAgIC8qIHNyYyBmaWVsZHMgYXJlIGluIHNhbWUgcG9zaXRpb24gYXMgbW9kZWN0bCwg
YnV0IG1lYW4gZGlmZmVyZW50IHRoaW5ncyAqLworICAgIGludGJpdHBvcyA9IEdFVF9GSUVMRChN
T0RFQ1RMX1csIHNyYyk7CisgICAgZGVzdF9yZWcgPSAwOworICAgIENQVV9GT1JFQUNIKGNwdSkg
eworICAgICAgICBDUFVIZXhhZ29uU3RhdGUgKnRocmVhZF9lbnYgPSAmKEhFWEFHT05fQ1BVKGNw
dSktPmVudik7CisgICAgICAgIHVpbnQzMl90IHRocmVhZF9pZF9tYXNrID0gMHgxIDw8IHRocmVh
ZF9lbnYtPnRocmVhZElkOworICAgICAgICBpZiAodGhyZWFkX2VuYWJsZWRfbWFzayAmIHRocmVh
ZF9pZF9tYXNrKSB7CisgICAgICAgICAgICB1aW50MzJfdCBpbWFzayA9IHRocmVhZF9lbnYtPnRf
c3JlZ1tIRVhfU1JFR19JTUFTS107CisgICAgICAgICAgICBkZXN0X3JlZyB8PSAoKGltYXNrID4+
IGludGJpdHBvcykgJiAweDEpIDw8IHRocmVhZF9lbnYtPnRocmVhZElkOworICAgICAgICB9Cisg
ICAgfQorCisgICAgcmV0dXJuIGRlc3RfcmVnOwogfQogCiB2b2lkIEhFTFBFUihzdGFydCkoQ1BV
SGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IGltYXNrKQotLSAKMi4zNC4xCgo=

