Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDDDEA8114
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpnsn-0005e2-LN; Tue, 10 Feb 2026 08:34:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vpnsl-0005dj-QD
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:34:23 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vpnsj-0001o0-Ni
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:34:23 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61AA9CJ41172867
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 13:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GPUiSXKwen3lJ7VamxwDEFzXupLyXqvuwOfovAsxzxc=; b=cenCmf9PEqGoI/ag
 n3OXdViCbmU2DoJsbzHCPUSZWSKYzEgXxX823dp3LFcP0j0ll4RBFt7kXqBsder9
 G7wobdfOZpRLGpT+WWRsFat+Zp17TbiM8ln19yV4aN3N3Q5nUhMUX2RSbqrcEmBv
 bYNBoMp5UMnjQwoKAu2BSLFYzYjgsrBcxijXYXEfyhda/5UXttsVpeiUioqM5iuU
 Z9ESXM3o0gMbikeIINLx4zfcsXYhGdenWM8/4oK1p8M/6VuvYgwZBcwIuKVbMinc
 GM2sMse4PUf5ohiWKmC5YlErUaWpQUwOjwXLSBA3iTlL5um91HnFvmKCDxdrH65s
 MIWGlw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7kftupev-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 13:34:19 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2ba745f54c6so5133198eec.0
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 05:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770730459; x=1771335259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GPUiSXKwen3lJ7VamxwDEFzXupLyXqvuwOfovAsxzxc=;
 b=isNjBOHck2j2laWH7x0K+jUkjtrSyB3d9WgX/7uOeoZWJe6B3lLRw9PxiwL5pX9BB8
 1PO2UwedgPFktBiVwPMXhnZy5QQwlHAanHiPVe2EOTyrS4k8cN3kJX2rqcKZECGHMy0D
 1PoTYEcqKVykxqswIcjZ/YDUQ/6w1gKJ6GdUKgtNv8AJ7MMeSKZ4GfMCCJHIuHPZymwa
 lBXm4cRi2Qb78D5HeCrvwjMi9SV53I/FeBxf6HiorSi+rNgjSBTO2U5eqAxsTkpP9xLK
 qOeQf6uGgkdJZLapoC3/mwe3TwvwzNceaMGXzlF1BYqC4PkvsuPEUnDTV5nkwJebIWU+
 bQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770730459; x=1771335259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GPUiSXKwen3lJ7VamxwDEFzXupLyXqvuwOfovAsxzxc=;
 b=V0yDNtwedQbK2QA2S99DLbHvVS4KtMDHbub8MI82B2LZDI+/FxX6DME9AGGYNe0R1X
 XyvmuexcZksl90I3mUu19/6XZgn+SZSLBNXLb/hj3NUfEx0/JvhAJa/wZpuvSWIPYxd9
 psg5d63t+7GEmD+RI+V+ayzi0JCEiK9QvoMg6XflMs5kc/SozdYOpfiRksiH9jfzWtkQ
 cos4dF8E94+tso1SzMb6SsZ9yW+SKKtJm+J/56tJQukKeFYdR8fDDNsfCnTE9bLsL0Gf
 5Jsk4mSSZPL3Pg0cVBwNaOsb3oSwl2dPtW38NmakKEbqk6gcko8pHsjTjL7ffktJR29P
 c2gw==
X-Gm-Message-State: AOJu0YzkdAvLUazRBAp539hcxlDkExIqR8+hHn5qSpkq4cZgDvrH4zuc
 q/OVQQgWoYYfJHsDiNKQ60XpPR5S7NFZV+M/uuHGBUiWhSfQ8AwJAYpGOtU/1nVYmSNlZ7rYWDR
 xLiNwZrRoblKqWgvHWa4kK5V3ENU2wMjk1ZAEXH8tSyZAMZU3BNonB5znvupuk+HCDA==
X-Gm-Gg: AZuq6aLncMveOaGOWpnOGh4+8mLXzToQXC4g3CxMz9JTfX9i34k+ee6c3zUGFRSy6LD
 ygfGjYgVKasiZPA5ueHlb1oZaKYffFvENTkxx2ZpCjmjsvrGga48keaGgkdJr857gLuYr7oJDFe
 GtL5xLtE1X2sLGXNxVcZ4ZqLcsdVIf+gQYLVuTP8JdH/l8aeQaoQKL87NY09IHpgPFiv0CCsf7U
 KAFZADwJhMs/29Riacby46sa3dQdrl/nXobLMFBSBfulw+XP7PcV9HBERKBmdpAj040Td07br/L
 Y5OBDg3vqrP76P/oNiZWGSseVECsHCgTzVk0LPmUWQemOzXHnrLX8VU1nvMdPteia/fOdUp42wu
 2tkNehSJOtMjBpEF1GCfOiYSOQfKO1SCmoP4Y4FCal7qEh+B9Bp3SNu1cEMOfvy5G68Df6A==
X-Received: by 2002:a05:7300:c8d:b0:2ae:5bde:a5c5 with SMTP id
 5a478bee46e88-2b8568311bcmr6489247eec.30.1770730458716; 
 Tue, 10 Feb 2026 05:34:18 -0800 (PST)
X-Received: by 2002:a05:7300:c8d:b0:2ae:5bde:a5c5 with SMTP id
 5a478bee46e88-2b8568311bcmr6489234eec.30.1770730458161; 
 Tue, 10 Feb 2026 05:34:18 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ba7e149c58sm2716162eec.26.2026.02.10.05.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 05:34:17 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com, alex@alexrp.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 3/4] tests/tcg/hexagon: Handle SIGILL internally in
 invalid-slots test
Date: Tue, 10 Feb 2026 05:33:53 -0800
Message-Id: <20260210133355.16093-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260210133355.16093-1-brian.cain@oss.qualcomm.com>
References: <20260210133355.16093-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDExNCBTYWx0ZWRfX43pQALMuHlKi
 fxw23tZjEmryCjWAowj1BfVPApwXdCOEEC8v8LVeLRxdECWjDezftEJee+1wRwUyqTWyJup7CZT
 d5noqWBIEH9eZ4zo4C2lgtil8fXZzSkPHi5FQxCLnrlr5lfeQ5wi5GLC0dQOR/qwws8jSfxa/j9
 x+PcJmaXbUDRcfYKUSmtcTAFRBskg8MyPvO2TMmvKxeFJT6/ObgQf33c2WRAEa2583yUpI3cC2k
 MzEwdn+ZXx9tC2M9yrXj2WwPCoiLgYR4RdS5D8HFRhHd72QsIgxgsU5SpS3ccJ5tOKTwJoj5zH6
 iUUWavfQVyo9YnaSPyhLjsK0IyGnYf+9HSQthWyfI3DQ/m3pHoMglWL1W53i+XWfaARWiGcMGlO
 DUkSDdoJvp1HPMGHmZFBwJsSOIiQYZkOqwmHHpV8zdpBL/XfLXIzxl7/ek5OOpfQ5ZqHHpqL7qD
 OOtTT/b7+Sdsi/G99Lg==
X-Proofpoint-ORIG-GUID: l8AZOrP_juWl5SIsIUZvFx-iHmr4gAj1
X-Authority-Analysis: v=2.4 cv=XfuEDY55 c=1 sm=1 tr=0 ts=698b33db cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=mDV3o1hIAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=F0Jt1ehG-eUF7qKHwFUA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: l8AZOrP_juWl5SIsIUZvFx-iHmr4gAj1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100114
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

UmV3cml0ZSBpbnZhbGlkLXNsb3RzLmMgdG8gY2F0Y2ggYW5kIHZlcmlmeSBTSUdJTEwgdXNpbmcg
YSBzaWdhY3Rpb24KaGFuZGxlciB0aGF0IG1vZGlmaWVzIHRoZSB1Y29udGV4dCwgbWF0Y2hpbmcg
dGhlIHBhdHRlcm4gdXNlZCBieQppbnZhbGlkLWVuY29kaW5nLmMuCgpSZXZpZXdlZC1ieTogVGF5
bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KUmV2aWV3ZWQtYnk6IFBpZXJy
aWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4KU2lnbmVkLW9mZi1ieTog
QnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRlc3RzL3RjZy9o
ZXhhZ29uL2ludmFsaWQtc2xvdHMuYyB8IDc2ICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0KIHRlc3RzL3RjZy9oZXhhZ29uL01ha2VmaWxlLnRhcmdldCB8ICA2IC0tLQogMiBmaWxlcyBj
aGFuZ2VkLCA1OSBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90
ZXN0cy90Y2cvaGV4YWdvbi9pbnZhbGlkLXNsb3RzLmMgYi90ZXN0cy90Y2cvaGV4YWdvbi9pbnZh
bGlkLXNsb3RzLmMKaW5kZXggMzY2Y2U0ZjQyZi4uNjA3MDI3ZjMxNCAxMDA2NDQKLS0tIGEvdGVz
dHMvdGNnL2hleGFnb24vaW52YWxpZC1zbG90cy5jCisrKyBiL3Rlc3RzL3RjZy9oZXhhZ29uL2lu
dmFsaWQtc2xvdHMuYwpAQCAtMSwyOSArMSw3MSBAQAogLyoKLSAqICBDb3B5cmlnaHQoYykgMjAy
MyBRdWFsY29tbSBJbm5vdmF0aW9uIENlbnRlciwgSW5jLiBBbGwgUmlnaHRzIFJlc2VydmVkLgor
ICogVGVzdCB0aGF0IGludmFsaWQgc2xvdCBhc3NpZ25tZW50cyBhcmUgcHJvcGVybHkgcmVqZWN0
ZWQuCiAgKgotICogIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlz
dHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5Ci0gKiAgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBH
TlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkKLSAqICB0aGUgRnJlZSBT
b2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNlLCBvcgot
ICogIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uCi0gKgotICogIFRoaXMgcHJv
Z3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAot
ICogIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdh
cnJhbnR5IG9mCi0gKiAgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxB
UiBQVVJQT1NFLiAgU2VlIHRoZQotICogIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBt
b3JlIGRldGFpbHMuCi0gKgotICogIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2Yg
dGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCi0gKiAgYWxvbmcgd2l0aCB0aGlzIHByb2dy
YW07IGlmIG5vdCwgc2VlIDxodHRwOi8vd3d3LmdudS5vcmcvbGljZW5zZXMvPi4KKyAqIENvcHly
aWdodCAoYykgUXVhbGNvbW0gVGVjaG5vbG9naWVzLCBJbmMuIGFuZC9vciBpdHMgc3Vic2lkaWFy
aWVzLgorICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKICAqLwog
CisjaW5jbHVkZSA8YXNzZXJ0Lmg+CisjaW5jbHVkZSA8c2lnbmFsLmg+CisjaW5jbHVkZSA8c3Rk
aW8uaD4KKyNpbmNsdWRlIDxzdGRsaWIuaD4KKyNpbmNsdWRlIDxzdHJpbmcuaD4KKyNpbmNsdWRl
IDx1bmlzdGQuaD4KKworc3RhdGljIHZvaWQgKnJlc3VtZV9wYzsKKworc3RhdGljIHZvaWQgaGFu
ZGxlX3NpZ2lsbChpbnQgc2lnLCBzaWdpbmZvX3QgKmluZm8sIHZvaWQgKnB1YykKK3sKKyAgICB1
Y29udGV4dF90ICp1YyA9ICh1Y29udGV4dF90ICopcHVjOworCisgICAgaWYgKHNpZyAhPSBTSUdJ
TEwpIHsKKyAgICAgICAgX2V4aXQoRVhJVF9GQUlMVVJFKTsKKyAgICB9CisKKyAgICB1Yy0+dWNf
bWNvbnRleHQucjAgPSBTSUdJTEw7CisgICAgdWMtPnVjX21jb250ZXh0LnBjID0gKHVuc2lnbmVk
IGxvbmcpcmVzdW1lX3BjOworfQorCiBjaGFyIG1lbVs4XSBfX2F0dHJpYnV0ZV9fKChhbGlnbmVk
KDgpKSk7CiAKLWludCBtYWluKCkKKy8qCisgKiBJbnZhbGlkIHBhY2tldCB3aXRoIDIgaW5zdHJ1
Y3Rpb25zIGF0IHNsb3QgMDoKKyAqIC0gV29yZCAwOiAweGExODA0MTAwID0gbWVtdyhyMCkgPSBy
MQorICogLSBXb3JkIDE6IDB4MjgwMzI4MDQgPSB7IHIzID0gIzA7IHI0ID0gIzAgfQorICoKKyAq
IFRoaXMgc2hvdWxkIHJhaXNlIFNJR0lMTCBkdWUgdG8gdGhlIGludmFsaWQgc2xvdCBhc3NpZ25t
ZW50LgorICovCitzdGF0aWMgaW50IHRlc3RfaW52YWxpZF9zbG90cyh2b2lkKQogeworICAgIGlu
dCBzaWc7CisKICAgICBhc20gdm9sYXRpbGUoCisgICAgICAgICJyMCA9ICMwXG4iCisgICAgICAg
ICJyMSA9ICMjMWZcbiIKKyAgICAgICAgIm1lbXcoJTEpID0gcjFcbiIKICAgICAgICAgInIwID0g
I21lbVxuIgotICAgICAgICAvKiBJbnZhbGlkIHBhY2tldCAoMiBpbnN0cnVjdGlvbnMgYXQgc2xv
dCAwKTogKi8KICAgICAgICAgIi53b3JkIDB4YTE4MDQxMDBcbiIgLyogeyBtZW13KHIwKSA9IHIx
OyAgICAgICovCiAgICAgICAgICIud29yZCAweDI4MDMyODA0XG4iIC8qICAgcjMgPSAjMDsgcjQg
PSAjMCB9ICAqLwotICAgICAgICA6IDogOiAicjAiLCAicjMiLCAicjQiLCAibWVtb3J5Iik7Ci0g
ICAgcmV0dXJuIDA7CisgICAgICAgICIxOlxuIgorICAgICAgICAiJTAgPSByMFxuIgorICAgICAg
ICA6ICI9ciIoc2lnKQorICAgICAgICA6ICJyIigmcmVzdW1lX3BjKQorICAgICAgICA6ICJyMCIs
ICJyMSIsICJyMyIsICJyNCIsICJtZW1vcnkiKTsKKworICAgIHJldHVybiBzaWc7Cit9CisKK2lu
dCBtYWluKCkKK3sKKyAgICBzdHJ1Y3Qgc2lnYWN0aW9uIGFjdDsKKworICAgIG1lbXNldCgmYWN0
LCAwLCBzaXplb2YoYWN0KSk7CisgICAgYWN0LnNhX3NpZ2FjdGlvbiA9IGhhbmRsZV9zaWdpbGw7
CisgICAgYWN0LnNhX2ZsYWdzID0gU0FfU0lHSU5GTzsKKyAgICBhc3NlcnQoc2lnYWN0aW9uKFNJ
R0lMTCwgJmFjdCwgTlVMTCkgPT0gMCk7CisKKyAgICBhc3NlcnQodGVzdF9pbnZhbGlkX3Nsb3Rz
KCkgPT0gU0lHSUxMKTsKKworICAgIHB1dHMoIlBBU1MiKTsKKyAgICByZXR1cm4gRVhJVF9TVUND
RVNTOwogfQpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vTWFrZWZpbGUudGFyZ2V0IGIv
dGVzdHMvdGNnL2hleGFnb24vTWFrZWZpbGUudGFyZ2V0CmluZGV4IDE2NjY5ZTA0YTguLmQ2NGFl
YmEwOTAgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3RjZy9oZXhhZ29uL01ha2VmaWxlLnRhcmdldAorKysg
Yi90ZXN0cy90Y2cvaGV4YWdvbi9NYWtlZmlsZS50YXJnZXQKQEAgLTU0LDEyICs1NCw2IEBAIEhF
WF9URVNUUyArPSBpbnZhbGlkLXNsb3RzCiBIRVhfVEVTVFMgKz0gaW52YWxpZC1lbmNvZGluZwog
SEVYX1RFU1RTICs9IHVuYWxpZ25lZF9wYwogCi1ydW4tYW5kLWNoZWNrLWV4Y2VwdGlvbiA9ICQo
Y2FsbCBydW4tdGVzdCwkMiwkMyAyPiQyLnN0ZGVycjsgXAotCXRlc3QgJCQ/IC1lcSAxICYmIGdy
ZXAgLXEgImV4Y2VwdGlvbiAkKHN0cmlwICQxKSIgJDIuc3RkZXJyKQotCi1ydW4taW52YWxpZC1z
bG90czogaW52YWxpZC1zbG90cwotCSQoY2FsbCBydW4tYW5kLWNoZWNrLWV4Y2VwdGlvbiwgMHgx
NSwgJEAsICQoUUVNVSkgJChRRU1VX09QVFMpICQ8KQotCiBIRVhfVEVTVFMgKz0gdGVzdF9hYnMK
IEhFWF9URVNUUyArPSB0ZXN0X2JpdGNudAogSEVYX1RFU1RTICs9IHRlc3RfYml0c3BsaXQKLS0g
CjIuMzQuMQoK

