Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F97EF48C3
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 02:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqjLd-0006Dv-Ar; Thu, 12 Feb 2026 21:56:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vqjLb-0006Ci-Gr
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 21:55:59 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vqjLY-0005E5-9k
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 21:55:59 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61CKRCar421513
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 02:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GPUiSXKwen3lJ7VamxwDEFzXupLyXqvuwOfovAsxzxc=; b=TyneOP3/JwCDvtjY
 XrDQmrNyPdyd+uAucy/5rhpdNeX20/dPnMbVuPr5nn6bqrXirP3BUmVr5iW5HH20
 R444cgDVzd51yc4xScHy5wws0sg3quv41KcIaRt+g4nPHOTR9I3gCUcQgrId3H56
 LEeD67hfT5A4YZuqewNHH65dJUVEY9TGQQiFCJ3/4T2mPYM5e27lO32gq9uDWA79
 0y+5bm1qtlLMJzXTqAZZ7Z/q3oBvo2gUDnUvVdeFWNIsMtiZ4H4bnrufpwB+B+UQ
 ri7fP0tli3AdvIwqtOgNKGZOz7U3K3kfdoO+HMoZo27relf9bn7QyJuyypX5j1Du
 019Yfg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9cy4b6r2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 02:55:55 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2ba87c0e198so476920eec.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 18:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770951354; x=1771556154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GPUiSXKwen3lJ7VamxwDEFzXupLyXqvuwOfovAsxzxc=;
 b=FQafOjEiAc3aX+YmMX1RiLH9FYwPZ72fIP5uQk295ipyojHOTQlbElDuJvZLRp/hFC
 o0EKRJlmDC/m8HLvon6aQNRsD1+jpnE7/LcOpse3yTsXSL3cS/SLCqgaxb+O/nUIqL3W
 jxQAxEpwHwxEJSWrHgzSaJCtolLP30aLqd0QCh8UGcurDxapkNtOSQtG2uB1rc8g7WJI
 PutNYPKc+dVx7WUoxZt2u4j5HmFjRdH6y33MNNN2d9HLi7qCSXYBR8x43WDm2jn/FfsE
 82K4tPEmvOtRzJJ420aya0sd5iR8zwmoMju3+lFewVaPSyCrMCMHPzSsVkddnERIBFsK
 wyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770951354; x=1771556154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GPUiSXKwen3lJ7VamxwDEFzXupLyXqvuwOfovAsxzxc=;
 b=cXSE+iKNNc3FSt8kGxCjs2CB9o5k6XZT65hgbMk+nGyUKGOvc20OkWo61GaIGIUqvq
 vm8WmZIx3yiGsYepvPhwLOQNY6E//9x9X0fM2vlG4ydMOq6pHpe5L0eeJAlTjxvIX6A6
 tRhyQoaJ8M2F3p8HJL4CIDqSjJOHhL/DlKoiIMvq+0MpKD+c+4aIbEdyMmtLtdp8sdig
 tE5U/oGwyVN9COGshuiOZEkBsCfImA0iQXZmhk5eUug5NLIlmI9Hos87O21BhKs3Frbz
 8GHIe7UVJfD2nn7cKe5DfcjEXP+onGnYHuUiMNlSdbh62l9GBClig0iF7HNJVU5lzT68
 wDUA==
X-Gm-Message-State: AOJu0YxVRVs2DPQOKAR8vXmT1+NT0s5HH09gTW8xdkSnc/JHpK10QL5b
 jIf+sCvGtctlKhQ10KHVlWD+ylI9mGCT+STR6Ycq0s7TsBWhzxm0osZ2m5cM/KOzUolTTbfXAQp
 ePYJirV/pc1CKN+24HRF3zzAnBGYgxR23zrqZ4jFjAnXXfqG+e87KTZFwTnIJT1LHLg==
X-Gm-Gg: AZuq6aIh4llgssco8HqyzUKLQVVw29IhEY0YV6LHdRldiFPJtXqJPmHr+RqdeJJFOdd
 hl8L41O1AMjMjhGngzaAZFmKt0mFXV2v7kaN/k4LLn7elZF0qH/MDY0i2XGF+rDYKoCQ21H1MX5
 t03kQgLdhAA/8hnUitoueSSxZk9I4ALg9+fN30JMYUjXWDevCp4rTuyMLP+0xss3sKaVv8PKiRd
 pUOeRFmydlUEnP9iFRD7qRMVhlAEMh9JK0Iq4qxmI453nh3GdbQ/6o6zPew7b3f4PMFeBbVcUW7
 ydOQf4xxuZdasxCQnHmrlpz6AxEtsRvZWbLephuDSFaipUt+w0vxi2cfTWiXEzuwiJiornhX3Je
 Drd8YkMGLKDjGJEx4PI6Sk9X6IsR+CDfnvikVl/6qoegkJ0tkeXX9rX2WhgNsgESKk4ejMg==
X-Received: by 2002:a05:7300:5709:b0:2ab:ca55:89c8 with SMTP id
 5a478bee46e88-2baba1546edmr396430eec.43.1770951353774; 
 Thu, 12 Feb 2026 18:55:53 -0800 (PST)
X-Received: by 2002:a05:7300:5709:b0:2ab:ca55:89c8 with SMTP id
 5a478bee46e88-2baba1546edmr396413eec.43.1770951353212; 
 Thu, 12 Feb 2026 18:55:53 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ba9dbd5d3esm4500943eec.10.2026.02.12.18.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 18:55:52 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 3/7] tests/tcg/hexagon: Handle SIGILL internally in
 invalid-slots test
Date: Thu, 12 Feb 2026 18:55:40 -0800
Message-Id: <20260213025544.2497992-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260213025544.2497992-1-brian.cain@oss.qualcomm.com>
References: <20260213025544.2497992-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: FPVU7INK1uRaG87HkUCnUe_ZxbGR3GsT
X-Proofpoint-GUID: FPVU7INK1uRaG87HkUCnUe_ZxbGR3GsT
X-Authority-Analysis: v=2.4 cv=XvX3+FF9 c=1 sm=1 tr=0 ts=698e92bb cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=mDV3o1hIAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=F0Jt1ehG-eUF7qKHwFUA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDAyMSBTYWx0ZWRfX6c1R+nnDYmRR
 j1GZ/JsnMg+vL0rX+7SK1N9mHJx3UOpOMQadDy5Jv26ICtq3Wm3XOJOdw/kHbYq3lDuIJ6gUnDg
 toDidYS6u1gGT08ZECaFl3bISvDa2vjrQWHUB1jmKxDenjhiV3wPluC5OX+A6XDzEuqrBD3xzOy
 1bWokSkJ7l0F4GDFhWAQXOIny5XHttjeTbh1mqhz6IPkNmO8h8mQnXuWFFingVDT9WyKtvfpcGx
 P8PcieSVUGqjUYxI2TwdMXjOWh7jS5dXX4zxFf3fDx3tbVB5R+l31BRu8EEjUxzfjlJvqdJvvDv
 Ws+fJjJ95zpVkFT4Bm3Ki/5nHslnFB1qZFWUZ0cWOCSH1hF4Mk0Eisea9ELnat9gKc2aQaf7IJT
 0elyWeoPWjoqpr8689nF+8qSmTcNSdHlDrl0k2sL5TZturpjysTK+u3s5AgEY97576ppgUoa1j+
 Zs+PRh+NXoDKr1vDilQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130021
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

