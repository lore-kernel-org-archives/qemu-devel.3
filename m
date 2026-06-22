Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5E4CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 23:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbndH-00030G-Fj; Mon, 22 Jun 2026 19:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbndF-0002zK-23
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbndD-0002Vx-7q
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:44 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJZdTL178964
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k98P3mzy875bIQ72dfi4cpupNsJGfuDp4DlfWaLieyw=; b=oMZ7sc3mEUKLol8B
 5+UrGjgOQ+12Fj75DmcRd8ujCrRzINQXdPQT7F1c/7s5FrBn60yrXZEopGbXuC6Q
 dEPsKR9oylJQBddM1DUVWJ7gHA2XRww8dK5zynYcZqG6I7nazVpITZ81RsBTuODf
 FKrgMJHS365RiRohd04PJpC4vl09XvyJuc5bbt9rWck+6K20MTiyBNYomqBFqx7Q
 e7ik6xnvmrX1aCOr7JZ9a/b9TvzByUNGi9zkho7n5KLeNcKdvBX2qRDXM3xeiJDz
 r946pkdEsdQOYAZd3XUZaf5FW8854SsNQHlpu5xlNvnF2ZjhNbNn/yYMlzSkp4XM
 joPB1w==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey2yhtmnx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:41 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1384427c3efso5329549c88.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 16:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782169240; x=1782774040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k98P3mzy875bIQ72dfi4cpupNsJGfuDp4DlfWaLieyw=;
 b=F6uGMHfIgNiNrnLMdaSbcgz2mGXJ8SPO2wPdQUQFQyAjPHlYqHRwHenzzRfu4TVyoV
 Eg1spuEle1mFeL6DufyqdTSkTTgZYfgMAaEUJigTqhjJ2nZLbZTTL5jXUTq7dTShek45
 U/h1sfoTQuGsHzrt299CgPkNpXfk8HZgxEBxueKYOpzYLRY182dV5fwPl7f6tfKEv7Zi
 5oZe0P9PRV2fLJCk8gvHAYZoD9kBIbAIS+it6fHm8IbZfDGK/rM5MKHkjpZGPyy3GwdB
 9zTAvQD1OmH1CjJV7/qvgDzJikmOIAP1jC2h+tke2TRIPWSjAmvsWeEEt1fTwkOJpstK
 IkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782169240; x=1782774040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k98P3mzy875bIQ72dfi4cpupNsJGfuDp4DlfWaLieyw=;
 b=OqCqhiaHh5btAHnScY5aoSI8KYX2yswf/MBembO/oqwQ3g0SFvQO+L8oYO0iRcN7FE
 a1Lw5H2keL0HGXrv9m8jS7W0YWPNGCXVp1WzJOmrI1HhtR11iddd7oBgFC4mye3GVxQP
 34D4hEHDuTsgzvskGXrkxXhhRDhggGp3Ogopf1P1StuK/HjvFA1OsBHQe9V2KBd7rahA
 ILqxHthaco9BS7CbD5++RIKdeFQ5N/uzz3T07+lVw3kBeItOQVLQdYL7nMYSoQTx7WxS
 q0NPyCAjHFtWLK3TmxfnO6H9CZsgH9e9IdgZPiyazYhIIeDZJ/O+81494INL64/SBybD
 8vrg==
X-Gm-Message-State: AOJu0YyBOWVHXAbOwk43pe2NPPJkLPJlKPy1s5H0wtFX1bYDWLyulfta
 5gxKtghfmWgcpseBvHIOI0G8bXx39dA9mpM0JjEpfJXgtGkZbxuGvNqaxM0NaKzSmTLBhMAqWhv
 iheBFhhqyn5mQ2XSNBoqrFFbUC4livFeZkwMaX0fMcRQLPs+yE3DiAHDBYJIVtCvwHg==
X-Gm-Gg: AfdE7cnPcRV6GOQkWZaxxDmdlQKwxtqtFBgJ5jbE3+ZtPzr1z2TuT2N2TzUF/B8DkUv
 y5RBeUiq8ft4T7kAmPBqHRgUCugIa5VXDQ5W2j1JsrC9bU6dHDwGcvr0REAvWWTI1LHS+mPBANm
 nAHzaeBjCqwiKWm0GRyO5EO9sVeE8JQuexxYRtxfaApQQoSuRnUX57HgeGEqCueleidrSnEm88T
 TITgyGUGjwC6+/4uGOqP/WNyxhKWmDWjbsBi1sN7lJftHdDSzAlEVsPdpoeAEZuSUWpo0ilztZk
 /qyc1d6zlBP9LE6b6/tW0FuW0RD3ffc7hod2J8Vn6V5iF9EMVYaAZ0Lask8uBjfkqy1DRV5kzZC
 2kmMX2plEtkv5CCJVw0TPHSnh7qoleD3AemsDVwGQA7o3fC73LvIZ0UkuAfE=
X-Received: by 2002:a05:7022:609d:b0:12d:b993:c68f with SMTP id
 a92af1059eb24-139c5ce08c3mr279109c88.4.1782169240304; 
 Mon, 22 Jun 2026 16:00:40 -0700 (PDT)
X-Received: by 2002:a05:7022:609d:b0:12d:b993:c68f with SMTP id
 a92af1059eb24-139c5ce08c3mr279089c88.4.1782169239751; 
 Mon, 22 Jun 2026 16:00:39 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add73a44sm9128726c88.13.2026.06.22.16.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 16:00:38 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 62/75] target/hexagon: Add PC to raise_exception,
 use fTRAP() helper
Date: Mon, 22 Jun 2026 15:28:51 -0700
Message-Id: <20260622222904.607771-63-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX/UQZSXAzJuuN
 cVhk94+oqD1voYw5lzuB2jhMbOvtfAjv8/i+5lAF7WtVBz7l6DozsclG4Bl41m1ihKFD4El35Om
 tB7mptZrYZbl2JhxMQG6q77HORVrzFw=
X-Proofpoint-ORIG-GUID: 2y3MUG56qHjw_XmB1lLrlEBmgKe2DMgI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX0BLpgm2eSHLg
 T77ksqF5hTGKPvXjmHEyQGj2MKVs3HQcypUdqyenoozLrZjuAc1VxqATS+Q3FnkK19BYp3SIfXb
 jkvTpJC0ObHRuc4pvveqzcO8c8T8nRJ5VyOzKHQXZ12QN1hFj2caWhKNQnoICmZ35NwGviNiHUu
 ZNpwBKQkEAadyKPSgOseI7dEKvbeMdEX6XgRjmllsds1Ca6Eo8J1SFGTvuVQ0yYX8oJlo15SPBs
 JbTlD0dQfgxFIbVty//7gFkyCNErr+KtFS8VjhvLYewC6FqAXZGHm9amq+DNBvDEtSW6f5JqiMy
 UFnJPXWU8OQABzl7VbydwQUB5i9Q9PXG5MvHw5kjf99hUlwW9nm1wsoBAS+R5UUjLpe/jEzv+xv
 cSIvrHJVjWQt/mLSvXypeInJV8fNcFoRvZnsGDIH8BKegHiUCUgl/GaXoo1Gefyly5V2mCtbvJa
 aPH7P506UU1UxEfjNLQ==
X-Proofpoint-GUID: 2y3MUG56qHjw_XmB1lLrlEBmgKe2DMgI
X-Authority-Analysis: v=2.4 cv=cKbQdFeN c=1 sm=1 tr=0 ts=6a39be99 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=4FQt9sIIQT5CW9ciUtIA:9
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220221
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpBZGQgUEMgdG8gcmFpc2VfZXhj
ZXB0aW9uIGhlbHBlcgoKUmVwbGFjZSB0aGUgZkdFTl9UQ0dfSjJfdHJhcDAgbWFjcm8gb3ZlcnJp
ZGUgd2l0aCB0aGUgZlRSQVAoKS1nZW5lcmF0ZWQKc3lzdGVtIGhlbHBlciBpbnN0ZWFkLgoKUmV2
aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25l
ZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0
YXJnZXQvaGV4YWdvbi9nZW5fdGNnLmggICB8ICA3IC0tLS0tLS0KIHRhcmdldC9oZXhhZ29uL2hl
bHBlci5oICAgIHwgIDIgKy0KIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIHwgMTAgKysrKy0t
LS0tLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgfCAyMSArKysrKysrKysrKysrKysrLS0t
LS0KIDQgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZy5oIGIvdGFyZ2V0L2hleGFnb24vZ2Vu
X3RjZy5oCmluZGV4IDRhNThlYWQ4NzdiLi5hMjhhZjBjMjQ1YiAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vZ2VuX3RjZy5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2dlbl90Y2cuaApAQCAtMTM0
OSwxMyArMTM0OSw2IEBACiAjZGVmaW5lIGZHRU5fVENHX1MyX3N0b3Jld19ybF9zdF92aShTSE9S
VENPREUpICAgICAgICAgIFNIT1JUQ09ERQogI2RlZmluZSBmR0VOX1RDR19TNF9zdG9yZWRfcmxf
c3RfdmkoU0hPUlRDT0RFKSAgICAgICAgICBTSE9SVENPREUKIAotI2RlZmluZSBmR0VOX1RDR19K
Ml90cmFwMChTSE9SVENPREUpIFwKLSAgICBkbyB7IFwKLSAgICAgICAgdWlWID0gdWlWOyBcCi0g
ICAgICAgIHRjZ19nZW5fbW92aV90bChoZXhfZ3ByW0hFWF9SRUdfUENdLCBjdHgtPnBrdC5wYyk7
IFwKLSAgICAgICAgVENHdiBleGNwID0gdGNnX2NvbnN0YW50X3RsKEhFWF9FVkVOVF9UUkFQMCk7
IFwKLSAgICAgICAgZ2VuX2hlbHBlcl9yYWlzZV9leGNlcHRpb24odGNnX2VudiwgZXhjcCk7IFwK
LSAgICB9IHdoaWxlICgwKQogI2VuZGlmCiAKICNkZWZpbmUgZkdFTl9UQ0dfQTJfbm9wKFNIT1JU
Q09ERSkgZG8geyB9IHdoaWxlICgwKQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGVscGVy
LmggYi90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaAppbmRleCBhYTM2MDRkYmRjNS4uMDMzZTU2MTlk
NmIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oCisrKyBiL3RhcmdldC9oZXhh
Z29uL2hlbHBlci5oCkBAIC0xOCw3ICsxOCw3IEBACiAjaW5jbHVkZSAiaW50ZXJuYWwuaCIKICNp
bmNsdWRlICJoZWxwZXJfcHJvdG9zX2dlbmVyYXRlZC5oLmluYyIKIAotREVGX0hFTFBFUl9GTEFH
U18yKHJhaXNlX2V4Y2VwdGlvbiwgVENHX0NBTExfTk9fUkVUVVJOLCBub3JldHVybiwgZW52LCBp
MzIpCitERUZfSEVMUEVSX0ZMQUdTXzMocmFpc2VfZXhjZXB0aW9uLCBUQ0dfQ0FMTF9OT19SRVRV
Uk4sIG5vcmV0dXJuLCBlbnYsIGkzMiwgaTMyKQogREVGX0hFTFBFUl8yKGNvbW1pdF9zdG9yZSwg
dm9pZCwgZW52LCBpbnQpCiBERUZfSEVMUEVSXzMoZ2F0aGVyX3N0b3JlLCB2b2lkLCBlbnYsIGkz
MiwgaW50KQogREVGX0hFTFBFUl8xKGNvbW1pdF9odnhfc3RvcmVzLCB2b2lkLCBlbnYpCmRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hl
bHBlci5jCmluZGV4IGI4MjcxM2JkMWMwLi44YTM3MjNjYmFmYSAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAg
LTY2LDE1ICs2NiwxMyBAQCBHX05PUkVUVVJOIHZvaWQgaGV4YWdvbl9yYWlzZV9leGNlcHRpb25f
ZXJyKENQVUhleGFnb25TdGF0ZSAqZW52LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1aW50MzJfdCBleGNlcHRpb24sCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHVpbnRwdHJfdCBwYykKIHsKLSAgICBDUFVTdGF0ZSAqY3Mg
PSBlbnZfY3B1KGVudik7Ci0gICAgcWVtdV9sb2dfbWFzayhDUFVfTE9HX0lOVCwgIiVzOiAlZFxu
IiwgX19mdW5jX18sIGV4Y2VwdGlvbik7Ci0gICAgY3MtPmV4Y2VwdGlvbl9pbmRleCA9IGV4Y2Vw
dGlvbjsKLSAgICBjcHVfbG9vcF9leGl0X3Jlc3RvcmUoY3MsIHBjKTsKKyAgICBkb19yYWlzZV9l
eGNlcHRpb24oZW52LCBleGNlcHRpb24sIHBjLCAwKTsKIH0KIAotR19OT1JFVFVSTiB2b2lkIEhF
TFBFUihyYWlzZV9leGNlcHRpb24pKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBleGNw
KQorR19OT1JFVFVSTiB2b2lkIEhFTFBFUihyYWlzZV9leGNlcHRpb24pKENQVUhleGFnb25TdGF0
ZSAqZW52LCB1aW50MzJfdCBleGNwLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVpbnQzMl90IFBDKQogewotICAgIGhleGFnb25fcmFpc2VfZXhjZXB0aW9uX2Vycihl
bnYsIGV4Y3AsIDApOworICAgIGhleGFnb25fcmFpc2VfZXhjZXB0aW9uX2VycihlbnYsIGV4Y3As
IFBDKTsKIH0KIAogdm9pZCBsb2dfc3RvcmUzMihDUFVIZXhhZ29uU3RhdGUgKmVudiwgdGFyZ2V0
X3Vsb25nIGFkZHIsCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3Rh
cmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IGY1NDUwY2VkN2RlLi5lMDQxOGVlOTkwZCAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2hleGFn
b24vdHJhbnNsYXRlLmMKQEAgLTEyNiwxMiArMTI2LDE5IEBAIGludHB0cl90IGN0eF90bXBfdnJl
Z19vZmYoRGlzYXNDb250ZXh0ICpjdHgsIGludCByZWdudW0sCiAgICAgcmV0dXJuIG9mZnNldDsK
IH0KIAotc3RhdGljIHZvaWQgZ2VuX2V4Y2VwdGlvbl9yYXcoaW50IGV4Y3ApCitzdGF0aWMgdm9p
ZCBnZW5fZXhjZXB0aW9uKGludCBleGNwLCB1aW50MzJfdCBQQykKIHsKLSAgICBnZW5faGVscGVy
X3JhaXNlX2V4Y2VwdGlvbih0Y2dfZW52LCB0Y2dfY29uc3RhbnRfaTMyKGV4Y3ApKTsKKyAgICBn
ZW5faGVscGVyX3JhaXNlX2V4Y2VwdGlvbih0Y2dfZW52LCB0Y2dfY29uc3RhbnRfaTMyKGV4Y3Ap
LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRjZ19jb25zdGFudF9pMzIoUEMpKTsK
IH0KIAogI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCitzdGF0aWMgaW5saW5lIHZvaWQgZ2VuX3By
ZWNpc2VfZXhjZXB0aW9uKGludCBleGNwLCB1aW50MzJfdCBQQykKK3sKKyAgICB0Y2dfZ2VuX21v
dmlfaTMyKGhleF9jYXVzZV9jb2RlLCBleGNwKTsKKyAgICBnZW5fZXhjZXB0aW9uKEhFWF9FVkVO
VF9QUkVDSVNFLCBQQyk7Cit9CisKIHN0YXRpYyB2b2lkIGdlbl9wY3ljbGVfY291bnRlcnMoRGlz
YXNDb250ZXh0ICpjdHgpCiB7CiAgICAgaWYgKGN0eC0+cGN5Y2xlX2VuYWJsZWQpIHsKQEAgLTE0
MCw2ICsxNDcsNyBAQCBzdGF0aWMgdm9pZCBnZW5fcGN5Y2xlX2NvdW50ZXJzKERpc2FzQ29udGV4
dCAqY3R4KQogfQogI2VuZGlmCiAKKwogc3RhdGljIHZvaWQgZ2VuX2V4ZWNfY291bnRlcnMoRGlz
YXNDb250ZXh0ICpjdHgpCiB7CiAgICAgdGNnX2dlbl9hZGRpX3RsKGhleF9ncHJbSEVYX1JFR19R
RU1VX1BLVF9DTlRdLApAQCAtMjExLDggKzIxOSwxMSBAQCBzdGF0aWMgdm9pZCBnZW5fZW5kX3Ri
KERpc2FzQ29udGV4dCAqY3R4KQogdm9pZCBoZXhfZ2VuX2V4Y2VwdGlvbl9lbmRfdGIoRGlzYXND
b250ZXh0ICpjdHgsIGludCBleGNwKQogewogICAgIGdlbl9leGVjX2NvdW50ZXJzKGN0eCk7Ci0g
ICAgdGNnX2dlbl9tb3ZpX3RsKGhleF9ncHJbSEVYX1JFR19QQ10sIGN0eC0+bmV4dF9QQyk7Ci0g
ICAgZ2VuX2V4Y2VwdGlvbl9yYXcoZXhjcCk7CisjaWZkZWYgQ09ORklHX1VTRVJfT05MWQorICAg
IGdlbl9leGNlcHRpb24oZXhjcCwgY3R4LT5wa3QucGMpOworI2Vsc2UKKyAgICBnZW5fcHJlY2lz
ZV9leGNlcHRpb24oZXhjcCwgY3R4LT5wa3QucGMpOworI2VuZGlmCiAgICAgY3R4LT5iYXNlLmlz
X2ptcCA9IERJU0FTX05PUkVUVVJOOwogfQogCkBAIC0yMjYsNyArMjM3LDcgQEAgc3RhdGljIHZv
aWQgZ2VuX2V4Y2VwdGlvbl9kZWNvZGVfZmFpbChEaXNhc0NvbnRleHQgKmN0eCwgaW50IG53b3Jk
cywgaW50IGV4Y3ApCiAKICAgICBnZW5fZXhlY19jb3VudGVycyhjdHgpOwogICAgIHRjZ19nZW5f
bW92aV90bChoZXhfZ3ByW0hFWF9SRUdfUENdLCBmYWlsX3BjKTsKLSAgICBnZW5fZXhjZXB0aW9u
X3JhdyhleGNwKTsKKyAgICBnZW5fZXhjZXB0aW9uKGV4Y3AsIGZhaWxfcGMpOwogICAgIGN0eC0+
YmFzZS5pc19qbXAgPSBESVNBU19OT1JFVFVSTjsKICAgICBjdHgtPmJhc2UucGNfbmV4dCA9IGZh
aWxfcGM7CiB9Ci0tIAoyLjM0LjEKCg==

