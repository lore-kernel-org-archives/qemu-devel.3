Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0120A10F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYWO-0006dk-1c; Wed, 08 Apr 2026 15:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAY6x-0007NK-MT
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:58:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAKOr-0005aS-4w
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:20:23 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637J6dRK071787
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 04:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HscUhJd5IqP7CEl8rASeN9F33avOQQ7VyG6Y44RMDtY=; b=idi3LCho7Q2do5Xo
 +ikbfc+e/I3xJ5lHAepEvWt1UDkNMlbp+Y6UoozuvzZgGU1lllEmrzQt3Y3SKm2i
 G0Q5NdlukTlOP0MnI9p66OZ36FPlhHeTOz1R+0NOkB5G9uN9fWMcI5wVENVAiaTx
 bFH7rDmprT6pp6M0IShiJHItpr+GEgwT278boae+y3KvO6gK8wZtl03kY9opLoXv
 gw6U19JjToMzF3w06yyMpVB7N9m3n1IasT+EwQuQHyYrQQFrsx8x2ll0R6HcLJhr
 51Qpxf+wDTQAKKh6Aog6eJamb+Wh55IA6KedMxRQaU2ywKHSTD73iQ0jio9d42pQ
 yC8hVA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd7sx9dq8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:20:20 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-12c20d5d7f4so1164205c88.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 21:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775622019; x=1776226819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HscUhJd5IqP7CEl8rASeN9F33avOQQ7VyG6Y44RMDtY=;
 b=BGj8W1pnKW3MqIAqe6RZvGVh78TnZsvL7Z5CioCdns7/xgaDNsLfhMckWVrHqqpuEk
 +JG948fMMKgqTPxghYH7mvPo0qEIaxM7jhgLbhMYgZ4FhHWjHmKnILcM/Bn7DopFBs28
 h5hgRhdG+PA3KctvCxRSVSmqHvX0GVxfd4H4fjXPzFnRfSQkQbhlLFdvJGz8VKY4utE0
 hxR0oHMQBbNOYkwCz08ANx37k26Pj4fDePb2LbsEE+uz9hERjHdB8xw7uiCGk06QZUbA
 mjZ7rsUSSdB+Cm+C38M1+gR+oimf+UGwn3sanODR+IrEqTp9X0hp4J9TGjf5t7jHyX7q
 0fUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775622019; x=1776226819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HscUhJd5IqP7CEl8rASeN9F33avOQQ7VyG6Y44RMDtY=;
 b=Rd6qOzKoFn0F35aoKLjCYUpu6M58tWeQf5OeBveDTMQ+KFbQbUXyBJjlGuLAzkTx4F
 VyAX46n1wpmEjpAq5XJNiSnAVZfkWWgVdS/EdBG1tPpEq+F7nzC22B9iQXGG/VXqMdr0
 9ac4/ZmOTl4rg3yufrMf/1aAiQVkRKL2s762J8g0PxoKcc/ky3StPNnkSH0WCfEY//Va
 qNr+QFFoRR8zp38G6zitXBGaGz1r0jwOrOBj1l06NL2gF8qK/QYmWaSVslnkLnQFLp8u
 c934spQBb9ttye6Dp4inBZR9B0GZG2jf4MaWhcSfducsC0jIQagFsmAnhrqFbAxr+kXc
 Tf9w==
X-Gm-Message-State: AOJu0YwW7ZsL6VibvW3tEQN7DgkKbQ63ni256J1b9pTyd8SWu1rJ3kVd
 TtTksUR7Pkr+ulsWbB3irVPX2FmkWQb4QBVrBA3xaXZQx/Jer2Z6dbKJFvd9HVu4cNV8T/Qxcbp
 uoMPwOjPLrga0j59FppwIUozCNS2PjYuQ+lwuO1dQp07x+zgH72J/HKBLUMdryjodIA==
X-Gm-Gg: AeBDiet9x/GtoJXgsCUiLU6zscON9s3d4k/v7ScCkmq0WROG+XaCGRQ4v5YMhRr0R/l
 U30g6zpywpCuOpxrYnIloUiQW+FzOijCjzC5betMsdSMRMbYxImI5m6RDVnVuPDLQEtgKWEUwER
 I2pX9vjHTUxPPPz6Rc+H54d23sSShtqPmp1E4WWCMUxPNQMlgHGreIDHwftNWisFfInlRgsDLGG
 zfGHRn/2MKB7q2zUnxdQL6CJFG7vLYlYUcAcpMPwOXe77xQvM8as7//0fSbSjkahiIEtO2rXbBc
 lvgLbrrM62muE3KEGHNGPUBpFUDOHiWuiSqOnbI/8Zn7ws/Y1mRyZF7KdGhORyJOgIx11OakonQ
 LhWJX8DDOQHl/qTsdau9UwmhI1UUuEJcaN8U/ahJPWGVvzRsQ7S9thVDvgZIa8d9zCJAdsA==
X-Received: by 2002:a05:7022:6881:b0:12a:b39a:339f with SMTP id
 a92af1059eb24-12bfb7451abmr9575117c88.21.1775622019042; 
 Tue, 07 Apr 2026 21:20:19 -0700 (PDT)
X-Received: by 2002:a05:7022:6881:b0:12a:b39a:339f with SMTP id
 a92af1059eb24-12bfb7451abmr9575104c88.21.1775622018498; 
 Tue, 07 Apr 2026 21:20:18 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c14a371b1sm6480362c88.13.2026.04.07.21.20.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 21:20:18 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 10/28] target/hexagon: Implement exec_interrupt, set_irq
Date: Tue,  7 Apr 2026 21:19:35 -0700
Message-Id: <20260408041953.1899532-11-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
References: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=etfvCIpX c=1 sm=1 tr=0 ts=69d5d784 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=GA9jbsKyPMLDJDmtv64A:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 707idYfVyiyq9crw1LgW9u-FWY8kFxZA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNSBTYWx0ZWRfX2nNWUKlau1VF
 MYt7xcvJwRjd9IJHhtrch8Z6cV/gJ0NbqjpAB0Dd2aO0DtBpuGSu8ms2B1LWFMX6k6FD3jIqgca
 p6fH9BulZr2Zk7PQfRsjO8Tq5ChdUzLOshxr9rRaTGp4t13sW6palgEhPlyWH5BO3HatY3399ZP
 f7k3SnPNezSk0hBbRbns6xnK8Ypcv3qxTy85i9RqhdSr560zlei2tHG1QTGPBKH+LdSa06bpDpe
 3wv/pPYEUaRu8a1W6GuxjK1n42ZMdehvElkQU59A44E+p0RgbqG2HSXBbXvMrFavfzfvB/gTDRi
 A8W4ZlljiDgavYM5guxNmWeq/t+xm9lhj7/4N9GeL8XQNx5YeW+31gA5W6hXMt46V3150NoeHYn
 7hifAv/gKmQN4fqElVT9wXN48DzsFv5p8Qc91gXRuDF88Xln8+imepENP7XcJpeBGBgsPgzs1mO
 4PP1XLSvud6KtYNsnUg==
X-Proofpoint-GUID: 707idYfVyiyq9crw1LgW9u-FWY8kFxZA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080035
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5jIHwgODQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEg
ZmlsZSBjaGFuZ2VkLCA4NCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFn
b24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCAwNjcwMjI1ZDg1OC4uYTIzY2M0
NzVhOTggMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhh
Z29uL2NwdS5jCkBAIC0xNiw2ICsxNiw3IEBACiAgKi8KIAogI2luY2x1ZGUgInFlbXUvb3NkZXAu
aCIKKyNpbmNsdWRlICJxZW11L2xvZy5oIgogI2luY2x1ZGUgInFlbXUvcWVtdS1wcmludC5oIgog
I2luY2x1ZGUgImNwdS5oIgogI2luY2x1ZGUgImludGVybmFsLmgiCkBAIC0zMSwxMCArMzIsMTIg
QEAKICNpbmNsdWRlICJoZXhfbW11LmgiCiAKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorI2lu
Y2x1ZGUgIm1hY3Jvcy5oIgogI2luY2x1ZGUgInN5c19tYWNyb3MuaCIKICNpbmNsdWRlICJhY2Nl
bC90Y2cvY3B1LWxkc3QuaCIKICNpbmNsdWRlICJxZW11L21haW4tbG9vcC5oIgogI2luY2x1ZGUg
ImhleF9pbnRlcnJ1cHRzLmgiCisjaW5jbHVkZSAiZXhlYy9jcHUtaW50ZXJydXB0LmgiCiAjZW5k
aWYKIAogc3RhdGljIHZvaWQgaGV4YWdvbl92NjZfY3B1X2luaXQoT2JqZWN0ICpvYmopIHsgfQpA
QCAtMzA5LDYgKzMxMiwzNiBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9zeW5jaHJvbml6ZV9m
cm9tX3RiKENQVVN0YXRlICpjcywKICAgICBjcHVfZW52KGNzKS0+Z3ByW0hFWF9SRUdfUENdID0g
dGItPnBjOwogfQogCisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKK2Jvb2wgaGV4YWdvbl90aHJl
YWRfaXNfZW5hYmxlZChDUFVIZXhhZ29uU3RhdGUgKmVudikKK3sKKyAgICBIZXhhZ29uQ1BVICpj
cHUgPSBlbnZfYXJjaGNwdShlbnYpOworICAgIHVpbnQzMl90IG1vZGVjdGw7CisgICAgdWludDMy
X3QgdGhyZWFkX2VuYWJsZWRfbWFzazsKKyAgICBib29sIEVfYml0OworCisgICAgaWYgKCFjcHUt
Pmdsb2JhbHJlZ3MpIHsKKyAgICAgICAgcmV0dXJuIHRydWU7CisgICAgfQorICAgIG1vZGVjdGwg
PQorICAgICAgICBoZXhhZ29uX2dsb2JhbHJlZ19yZWFkKGNwdS0+Z2xvYmFscmVncywgSEVYX1NS
RUdfTU9ERUNUTCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnYtPnRocmVhZElk
KTsKKyAgICB0aHJlYWRfZW5hYmxlZF9tYXNrID0gR0VUX0ZJRUxEKE1PREVDVExfRSwgbW9kZWN0
bCk7CisgICAgRV9iaXQgPSB0aHJlYWRfZW5hYmxlZF9tYXNrICYgKDB4MSA8PCBlbnYtPnRocmVh
ZElkKTsKKworICAgIHJldHVybiBFX2JpdDsKK30KKworc3RhdGljIGJvb2wgaGV4YWdvbl9jcHVf
aGFzX3dvcmsoQ1BVU3RhdGUgKmNzKQoreworICAgIENQVUhleGFnb25TdGF0ZSAqZW52ID0gY3B1
X2Vudihjcyk7CisKKyAgICByZXR1cm4gaGV4YWdvbl90aHJlYWRfaXNfZW5hYmxlZChlbnYpICYm
CisgICAgICAgIChjcy0+aW50ZXJydXB0X3JlcXVlc3QgJiAoQ1BVX0lOVEVSUlVQVF9IQVJEIHwg
Q1BVX0lOVEVSUlVQVF9TV0kKKyAgICAgICAgICAgIHwgQ1BVX0lOVEVSUlVQVF9LMF9VTkxPQ0sg
fCBDUFVfSU5URVJSVVBUX1RMQl9VTkxPQ0spKTsKK30KKyNlbmRpZgorCiBzdGF0aWMgdm9pZCBo
ZXhhZ29uX3Jlc3RvcmVfc3RhdGVfdG9fb3BjKENQVVN0YXRlICpjcywKICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgVHJhbnNsYXRpb25CbG9jayAqdGIsCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHVpbnQ2NF90ICpk
YXRhKQpAQCAtNDA4LDEwICs0NDEsNTggQEAgc3RhdGljIGludCBoZXhhZ29uX2NwdV9tbXVfaW5k
ZXgoQ1BVU3RhdGUgKmNzLCBib29sIGlmZXRjaCkKICAgICByZXR1cm4gTU1VX1VTRVJfSURYOwog
fQogCisjaWYgIWRlZmluZWQoQ09ORklHX1VTRVJfT05MWSkKK3N0YXRpYyB2b2lkIGhleGFnb25f
Y3B1X3NldF9pcnEodm9pZCAqb3BhcXVlLCBpbnQgaXJxLCBpbnQgbGV2ZWwpCit7CisgICAgSGV4
YWdvbkNQVSAqY3B1ID0gSEVYQUdPTl9DUFUob3BhcXVlKTsKKyAgICBDUFVTdGF0ZSAqY3MgPSBD
UFUoY3B1KTsKKyAgICBDUFVIZXhhZ29uU3RhdGUgKmVudiA9IGNwdV9lbnYoY3MpOworCisgICAg
c3dpdGNoIChpcnEpIHsKKyAgICBjYXNlIEhFWEFHT05fQ1BVX0lSUV8wIC4uLiBIRVhBR09OX0NQ
VV9JUlFfNzoKKyAgICAgICAgcWVtdV9sb2dfbWFzayhDUFVfTE9HX0lOVCwgIiVzOiBpcnEgJWQs
IGxldmVsICVkXG4iLAorICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBpcnEsIGxldmVs
KTsKKyAgICAgICAgaWYgKGxldmVsKSB7CisgICAgICAgICAgICBoZXhfcmFpc2VfaW50ZXJydXB0
cyhlbnYsIDEgPDwgaXJxLCBDUFVfSU5URVJSVVBUX0hBUkQpOworICAgICAgICB9CisgICAgICAg
IGJyZWFrOworICAgIGRlZmF1bHQ6CisgICAgICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cisg
ICAgfQorfQorI2VuZGlmCisKIHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X2luaXQoT2JqZWN0ICpv
YmopCiB7CisjaWYgIWRlZmluZWQoQ09ORklHX1VTRVJfT05MWSkKKyAgICBIZXhhZ29uQ1BVICpj
cHUgPSBIRVhBR09OX0NQVShvYmopOworICAgIHFkZXZfaW5pdF9ncGlvX2luKERFVklDRShjcHUp
LCBoZXhhZ29uX2NwdV9zZXRfaXJxLCA4KTsKKyNlbmRpZgogfQogCisjaWZuZGVmIENPTkZJR19V
U0VSX09OTFkKKworc3RhdGljIGJvb2wgaGV4YWdvbl9jcHVfZXhlY19pbnRlcnJ1cHQoQ1BVU3Rh
dGUgKmNzLCBpbnQgaW50ZXJydXB0X3JlcXVlc3QpCit7CisgICAgQ1BVSGV4YWdvblN0YXRlICpl
bnYgPSBjcHVfZW52KGNzKTsKKyAgICBpZiAoaW50ZXJydXB0X3JlcXVlc3QgJiBDUFVfSU5URVJS
VVBUX1RMQl9VTkxPQ0spIHsKKyAgICAgICAgY3MtPmhhbHRlZCA9IGZhbHNlOworICAgICAgICBj
cHVfcmVzZXRfaW50ZXJydXB0KGNzLCBDUFVfSU5URVJSVVBUX1RMQl9VTkxPQ0spOworICAgICAg
ICByZXR1cm4gdHJ1ZTsKKyAgICB9CisgICAgaWYgKGludGVycnVwdF9yZXF1ZXN0ICYgQ1BVX0lO
VEVSUlVQVF9LMF9VTkxPQ0spIHsKKyAgICAgICAgY3MtPmhhbHRlZCA9IGZhbHNlOworICAgICAg
ICBjcHVfcmVzZXRfaW50ZXJydXB0KGNzLCBDUFVfSU5URVJSVVBUX0swX1VOTE9DSyk7CisgICAg
ICAgIHJldHVybiB0cnVlOworICAgIH0KKyAgICBpZiAoaW50ZXJydXB0X3JlcXVlc3QgJiAoQ1BV
X0lOVEVSUlVQVF9IQVJEIHwgQ1BVX0lOVEVSUlVQVF9TV0kpKSB7CisgICAgICAgIHJldHVybiBo
ZXhfY2hlY2tfaW50ZXJydXB0cyhlbnYpOworICAgIH0KKyAgICByZXR1cm4gZmFsc2U7Cit9CisK
KyNlbmRpZgorCiBzdGF0aWMgY29uc3QgVENHQ1BVT3BzIGhleGFnb25fdGNnX29wcyA9IHsKICAg
ICAvKiBNVFRDRyBub3QgeWV0IHN1cHBvcnRlZDogcmVxdWlyZSBzdHJpY3Qgb3JkZXJpbmcgKi8K
ICAgICAuZ3Vlc3RfZGVmYXVsdF9tZW1vcnlfb3JkZXIgPSBUQ0dfTU9fQUxMLApAQCAtNDIyLDYg
KzUwMyw5IEBAIHN0YXRpYyBjb25zdCBUQ0dDUFVPcHMgaGV4YWdvbl90Y2dfb3BzID0gewogICAg
IC5zeW5jaHJvbml6ZV9mcm9tX3RiID0gaGV4YWdvbl9jcHVfc3luY2hyb25pemVfZnJvbV90YiwK
ICAgICAucmVzdG9yZV9zdGF0ZV90b19vcGMgPSBoZXhhZ29uX3Jlc3RvcmVfc3RhdGVfdG9fb3Bj
LAogICAgIC5tbXVfaW5kZXggPSBoZXhhZ29uX2NwdV9tbXVfaW5kZXgsCisjaWYgIWRlZmluZWQo
Q09ORklHX1VTRVJfT05MWSkKKyAgICAuY3B1X2V4ZWNfaW50ZXJydXB0ID0gaGV4YWdvbl9jcHVf
ZXhlY19pbnRlcnJ1cHQsCisjZW5kaWYgLyogIUNPTkZJR19VU0VSX09OTFkgKi8KIH07CiAKIHN0
YXRpYyB2b2lkIGhleGFnb25fY3B1X2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKmMsIGNvbnN0IHZv
aWQgKmRhdGEpCi0tIAoyLjM0LjEKCg==

