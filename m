Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4A110F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYMo-0006kO-Fx; Wed, 08 Apr 2026 15:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAYJy-0001Dp-Rd
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:12:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAKPJ-0005dA-Ef
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:20:53 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637M4aIU2861188
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 04:20:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VyS//kJE8X1YiFhWbpMP89yyJBq8IVDF64zKKUVJKZQ=; b=IN+auyB3ntkHmqf/
 HKDJ+cmlc2q1YPJ8dEjbkJsXZn7NDdETNNPCw8bb5OfZp0NAxJTWP4BmkBuBQrf+
 AN1R5ZNquindE3DNbQM5S568N/Fb3X5D0EuBfP9LlxG3S/gyBYuiRS1PRgW3MdOW
 pxAdW822Ko4+bpDePKXiGyCWt7OLiDeKdhYU7ehH5HyOScsPVu2zLzkdTwgQQ42n
 a9uDDD2oPp3O4E1C11fBB1re1hRiZqm+IkH/Pu9s61iolQo89rTz1FlHn4OnRSkw
 yzvRKybZe1U6r/6xifEoyVfWHa0gDEUJKM8GgY2W5lrjeyzMatTxNdNtjqQlebOH
 RvthDA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddad8rwvm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:20:38 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2b81ff82e3cso352182eec.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 21:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775622037; x=1776226837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VyS//kJE8X1YiFhWbpMP89yyJBq8IVDF64zKKUVJKZQ=;
 b=DbYaC4KzSAvRNhcGSAay84LwGfuiC46BrcZBb6BkosXGZiucEpVysjZCmnL+0uoTyj
 dBsXb1+3V8ntEtM+hj7pA5wSMEoKQloQ/uwzwfiNM2vEJ71bQhgWCJ7LYVd3WZAluoa7
 27ivX5MRu+JOByNguDWzH0VE+mW6FBmrNEAYK2Fr0vwvC6ItWmEqE/IjGaZbL8nY4/t4
 Y7QU9RA9Elusmvtc0cQrKh0mLpAZXoZm1sY+cK8aDtgTM49rnb0ZTP2pkW3A6zN+lXuR
 So6MK/Dzsvj2LlY2Z5QHSv6nVxUtD8E6GUQnX8JDGN7nfNNwVfMxVRkQAVeJyEIk0l/g
 6Ewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775622037; x=1776226837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VyS//kJE8X1YiFhWbpMP89yyJBq8IVDF64zKKUVJKZQ=;
 b=UPjAJ6oCGuNSORRznIHDAi5SQbquERTx7oy4c0OJBiYgoAe2JHIvDVCl2ZpEV+0h3/
 NxCZlKL1VdcWmfexU279tZHx8FNVCOqv9H//OcQgDkrv960QrnloE/RYQOniBdZ3mWRa
 KZuFRYbBMUFDXF59ouM0fBwmABBUslMo8BKZB0mTyPuJL8Q/n6dbNjxMFOfwQUFIjiby
 nB3MnGdupzv4mUC8oU/JqZyvb8BLbCd/SfNjaVadMDU003RLa86e2G9KNezjMeSaPdOP
 GJdhMZKtOMYWc3bcY2ErNGafbqRV3TPDbzd0rdcv4BgcX0rDHrWl9rKFzJThdEb1jO8O
 TOcw==
X-Gm-Message-State: AOJu0YxZ2j0/5ZIOUDdxkg4FcXgVIRmkZtreUFG9n/W6f9JFJ3RKjIGf
 ZwxKg12iZdG9vemacuYWTiSJDDET2ccZNYubvZRhMaJF6qq7+3CYMa6CNriOOy51hyjcY+Hd+Zx
 tRs7p+UXaGR6tUMGNJz6154QgnGvQu60rnXm/YTT04rJ5mQb1kacer+4iHyosfsDFuw==
X-Gm-Gg: AeBDieutZMG8r4Qlk6zOW4D4dX0XlUwpH0M0EiUFuZ3cMFRhqYbtiyUO29b32RKRZkq
 WYEuiU42u9Hd3jKZ0TiKh4rNOIkCQ8aAXtDG19o6LHi/i2M0RmAWe7Xw08snh3aKv+KOX3y21gE
 wnRa+EHld7aHBifoy0aqiRCNYkp1/E0uz8tYqUze4l+avDA9778PwbJYoWOWcLOwl2jaP9sRIhN
 /jF4F7j+wHg0KeLsVjv4hy6N3R4fQgM4keeYDwLOSNzxvlv6pISbDtCzksrsW7FrKT/MdE2i+2C
 yWw2U5XDdXJUuik02w4Yj/MuTFkdamVKbn4AYz/aXglpuHBNrHFCzwFuo8nee0SOIskENh9Au0J
 V7Dl+/El+M9awrT66MlvvPEdxmMCRc/4y6TtorkjRbKSsfFsgI++EBqAuclrI3BdyRfuQxg==
X-Received: by 2002:a05:7022:420:b0:128:d1f6:16da with SMTP id
 a92af1059eb24-12bfaf58986mr9462708c88.14.1775622037369; 
 Tue, 07 Apr 2026 21:20:37 -0700 (PDT)
X-Received: by 2002:a05:7022:420:b0:128:d1f6:16da with SMTP id
 a92af1059eb24-12bfaf58986mr9462695c88.14.1775622036845; 
 Tue, 07 Apr 2026 21:20:36 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c14a371b1sm6480362c88.13.2026.04.07.21.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 21:20:36 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Subject: [PATCH v4 28/28] target/hexagon: Add guest reg reading functionality
Date: Tue,  7 Apr 2026 21:19:53 -0700
Message-Id: <20260408041953.1899532-29-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
References: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: BQ9pnrlvzdFZKAgeMwANDIPnqX5MtvP2
X-Proofpoint-GUID: BQ9pnrlvzdFZKAgeMwANDIPnqX5MtvP2
X-Authority-Analysis: v=2.4 cv=EoDiaycA c=1 sm=1 tr=0 ts=69d5d796 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=IJQQmebJWjVxhimlKuwA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX89OPvUBJRefe
 f8yxL3p8v1Fyw1D6tlBc3MBmZk++mu+/WabA6AEuh4QL0DHLyZ1VExbCD1CKfF/LxAesdSlpKfd
 oq258P3EsIxPVpZ4p+5wP3AMkX6nYukiRVvzQKKLPwMVLEdCHgaxmWPmCq6JL4wR4aKUIkWH3tI
 zjAt7jiMJM0ph9bwps7ryxpZufARnn7MOvB8MyHpkMhI/wxUodfRJPNLD/UUobwajmso5mjASZG
 0j4LHaTWqMkdQuKOhjw2mrnMLEV4re9/KHuRdHWY715/pGkKrR0tDHjHEcig69b8GdJ+EvPKDWd
 ceFcVDAWTeptp2m5cF778NZ2XCtt5YUk8Kzdz5ixwGlNGbjBCGg9FOgnXBxloDMdfhbeHv4RCh2
 93j9IzjZ8eOiqEOysurt5H1o1zcQbVM2CxsfwGKLqS6bCJn/zdVMSGhV8eVLEKQE2GeJusV8HlW
 FiRFLIqEbwgpLsS01LA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036
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

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPHF1aWNfbWF0aGJlcm5AcXVpY2luYy5j
b20+CgpTaWduZWQtb2ZmLWJ5OiBNYXRoZXVzIFRhdmFyZXMgQmVybmFyZGlubyA8cXVpY19tYXRo
YmVybkBxdWljaW5jLmNvbT4KUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2lt
cHNvbkBnbWFpbC5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vY3B1LmggICAgICAgfCAgMSArCiB0
YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICB8IDE5ICsrKysrKysrKysrKysrKysrKysKIHRhcmdl
dC9oZXhhZ29uL29wX2hlbHBlci5jIHwgMTYgKysrKysrKysrKysrKystLQogMyBmaWxlcyBjaGFu
Z2VkLCAzNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKaW5kZXggMTA0OGU3NjdlNmQu
LjA5ZDVjYWM0ZmU1IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysgYi90YXJn
ZXQvaGV4YWdvbi9jcHUuaApAQCAtMjE5LDYgKzIxOSw3IEBAIEdfTk9SRVRVUk4gdm9pZCBoZXhh
Z29uX3JhaXNlX2V4Y2VwdGlvbl9lcnIoQ1BVSGV4YWdvblN0YXRlICplbnYsCiAgKiBub3Qgc3Rv
cHBlZC4KICAqLwogYm9vbCBoZXhhZ29uX3RocmVhZF9pc19lbmFibGVkKENQVUhleGFnb25TdGF0
ZSAqdGhyZWFkX2Vudik7Cit1aW50MzJfdCBoZXhhZ29uX2dyZWdfcmVhZChDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgdWludDMyX3QgcmVnKTsKIHZvaWQgaGV4YWdvbl9jcHVfc29mdF9yZXNldChDUFVI
ZXhhZ29uU3RhdGUgKmVudik7CiAjZW5kaWYKIApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24v
Y3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCBhNDhkNjE3OGUwNi4uYmQzZWVjMGQ1
MjUgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhhZ29u
L2NwdS5jCkBAIC03NjUsNiArNzY1LDI1IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X2NsYXNz
X2luaXQoT2JqZWN0Q2xhc3MgKmMsIGNvbnN0IHZvaWQgKmRhdGEpCiAjZW5kaWYKIH0KIAorI2lm
bmRlZiBDT05GSUdfVVNFUl9PTkxZCit1aW50MzJfdCBoZXhhZ29uX2dyZWdfcmVhZChDUFVIZXhh
Z29uU3RhdGUgKmVudiwgdWludDMyX3QgcmVnKQoreworICAgIGlmIChyZWcgPD0gSEVYX0dSRUdf
RzMpIHsKKyAgICAgICAgcmV0dXJuIGVudi0+Z3JlZ1tyZWddOworICAgIH0KKyAgICBzd2l0Y2gg
KHJlZykgeworICAgIGNhc2UgSEVYX0dSRUdfR1BDWUNMRUxPOgorICAgICAgICByZXR1cm4gaGV4
YWdvbl9nZXRfc3lzX3BjeWNsZV9jb3VudF9sb3coZW52KTsKKyAgICBjYXNlIEhFWF9HUkVHX0dQ
Q1lDTEVISToKKyAgICAgICAgcmV0dXJuIGhleGFnb25fZ2V0X3N5c19wY3ljbGVfY291bnRfaGln
aChlbnYpOworICAgIGRlZmF1bHQ6CisgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX1VOSU1QLCAi
cmVhZGluZyBncmVnICUiIFBSSWQzMgorICAgICAgICAgICAgICAgICIgbm90IHlldCBzdXBwb3J0
ZWQuXG4iLCByZWcpOworICAgICAgICByZXR1cm4gMDsKKyAgICB9Cit9CisjZW5kaWYKKwogI2Rl
ZmluZSBERUZJTkVfQ1BVKHR5cGVfbmFtZSwgaW5pdGZuKSAgICAgIFwKICAgICB7ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCiAgICAgICAgIC5uYW1lID0gdHlwZV9uYW1l
LCAgICAgICAgICAgICAgICAgXApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVy
LmMgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwppbmRleCBjNGFkNjAxNTY4OS4uYTFjMGM5
OTEwZjIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL29wX2hlbHBlci5jCkBAIC0xODc3LDEzICsxODc3LDI1IEBAIHVpbnQ2NF90IEhF
TFBFUihzcmVnX3JlYWRfcGFpcikoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHJlZykK
IH0KIAogdWludDMyX3QgSEVMUEVSKGdyZWdfcmVhZCkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVp
bnQzMl90IHJlZykKKwogewotICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgcmV0dXJu
IGhleGFnb25fZ3JlZ19yZWFkKGVudiwgcmVnKTsKIH0KIAogdWludDY0X3QgSEVMUEVSKGdyZWdf
cmVhZF9wYWlyKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgcmVnKQorCiB7Ci0gICAg
Z19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICBpZiAocmVnID09IEhFWF9HUkVHX0cwIHx8IHJl
ZyA9PSBIRVhfR1JFR19HMikgeworICAgICAgICByZXR1cm4gKHVpbnQ2NF90KShlbnYtPmdyZWdb
cmVnXSkgfAorICAgICAgICAgICAgICAgKCgodWludDY0X3QpKGVudi0+Z3JlZ1tyZWcgKyAxXSkp
IDw8IDMyKTsKKyAgICB9CisgICAgc3dpdGNoIChyZWcpIHsKKyAgICBjYXNlIEhFWF9HUkVHX0dQ
Q1lDTEVMTzoKKyAgICAgICAgcmV0dXJuIGhleGFnb25fZ2V0X3N5c19wY3ljbGVfY291bnQoZW52
KTsKKyAgICBkZWZhdWx0OgorICAgICAgICByZXR1cm4gKHVpbnQ2NF90KWhleGFnb25fZ3JlZ19y
ZWFkKGVudiwgcmVnKSB8CisgICAgICAgICAgICAgICAoKHVpbnQ2NF90KShoZXhhZ29uX2dyZWdf
cmVhZChlbnYsIHJlZyArIDEpKSA8PCAzMik7CisgICAgfQogfQogCiAvKgotLSAKMi4zNC4xCgo=

