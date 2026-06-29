Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99F8C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCIV-0004aX-Q9; Mon, 29 Jun 2026 09:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHk-0003nl-Bj
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHh-0006MK-V8
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:28 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATKq62656139
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W9aRU99FRJkCFdVjE14GeGuaLGKvifAUAOZ13h7xav8=; b=AINdiusTcjjc2OsY
 LULNCN516Uo8S8NyDv0G85mMkPzEQdCGbTxBTyCMbfhdZjX2rJYlW5hZarSUkJdP
 cF3a5IuOihK3wfG8ZeE+ycqWUlJCACGgvvFYSzRmOmQ00PwIwHbYLY9kyYg8Ta7y
 SavGxKi/mUkPzARVSrIVhase88FpuzrN5z/HvOa18r3W9JYfse3bRG7nPpS50lD/
 rK8U2Lfo9e+Y0iw8qMZpJpuRmhz6KCvPxO7q+976dPvrEoHI/TxVbt0VakXGR2dN
 jZAGUixiwQy6zP8pvxchyOluZSQn5bJ0bhTw0eXUJJsfFSvROsa6aJPmRJRKjv3R
 +tYzXA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3np7h311-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:24 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2c9e994869aso6915645ad.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782740664; x=1783345464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W9aRU99FRJkCFdVjE14GeGuaLGKvifAUAOZ13h7xav8=;
 b=cpXLM9v9MRs0FI2cIHNGpdtqIeJzFx5R8npplH9KyV4fPe3YA4VHATMzvfEKEMtsHp
 aMV2ZC2p81ejZyruzaZbW57HtNWNmtyD3ug1VqWrOFGz5h3iyrRdshUUdsUI9+5JstvU
 mGeN99lh09STo4tgRWmm3aEAM1pTgHHKGQgzN7TyLfFx+TMu933Kj/k3QgxBQyHELR19
 oturja0PTLYlYWU+pngwZHDCG8isZmQT3qqy4GuwzwJvpKdUB2LiHNbSCAWCw1S7CnPS
 i1U0bWoHQG04krTU9/3Z7FoszZOCfNioBydpzn8UZaZoAEQnSWhMziPMeNajAd2rfYQY
 xdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740664; x=1783345464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W9aRU99FRJkCFdVjE14GeGuaLGKvifAUAOZ13h7xav8=;
 b=F4taceoKhhcZR5IhMh1ugxoEK+pefOAf6u3MZCOI8ZcZ4F2Hlgsr7Ej2ywHN13L5S6
 vTkRB5WBk6oFWR4lrAnWLcr7VYMyCa/CKKC5iTGDUUlEJu63ZM297/2qtX2Ojx2mpRQ4
 GSz1Fg7AH6QNUFDZho4zLx73gXX4RjGE1qaT+VRGFL5VhbqCbgtLGkxXBRbcGz+FBKW7
 5Qe+Ekx0tvze49aL5ZMRHbEJebnGuK42N/Nm1k3meEA/Zwg5s+9Kq3SoDxVs618dT5Tm
 sB04o4a1axM9uRyWnTMRjCWIu0bcdM1MnRBSrCUAIFbeA8EakIt4/shYMTY778JaJIU/
 PY7Q==
X-Gm-Message-State: AOJu0Yw+68+6QainHf1OZB3M6aUpktFt0qiLQYUgp5PKigbKrd+e9sNr
 r+9z+tu0DIy9yjEQoNcwX0MpOOIyk24DFtOUn/iXMUxVy28PoBMVcJhKqyLpaBq2EcLlO8EVaW4
 1ynlVlZ4e5fwjTfQkSHH4MP6Tv8qXzKYGvMrgDArXNZX/N2bQ+QW6m+GgZKJDwb6sXA==
X-Gm-Gg: AfdE7cljKdaK/fgNMPXqnymk3kBVslSwIHMM8kbjhKuOrxK4uOY+9hE5bRxJ8DlwPyX
 KuFk9ZfhEfIhwljj3saS+9HVDXz+UyQG2X8TjrCClCuYO4Z5x0fDIdzvwCMa9w0k47CH3oAboaB
 b/fgtR1XtBUn2Wo3xXMr7U9vyMzE9lej9U2dUS7KIwXN8Qn1qjzMwqTQTuGLHmaJUQXOEiykWsW
 IkochOUtjPt0ePY3jXkOvTlgEmiBq967oHSgGnxuz+/3UR6jGelymwqChwmkrwiEPpH5fpIMsRH
 GWOI4xOxxMzHF2qph+Rj7U7P3ZEJWsOisfuaHWrmEQ4uNqVDoIYXicHTvBsywoobgUZSZ9+ydQr
 5iPwr+8xxMTO17CL37JblxXreP9YJjp5up3NiJBJj+E5uZiqxjPopTjGo2qE=
X-Received: by 2002:a17:903:2f8b:b0:2c8:1c3e:9636 with SMTP id
 d9443c01a7336-2c9860ba606mr92809935ad.25.1782740663946; 
 Mon, 29 Jun 2026 06:44:23 -0700 (PDT)
X-Received: by 2002:a17:903:2f8b:b0:2c8:1c3e:9636 with SMTP id
 d9443c01a7336-2c9860ba606mr92809605ad.25.1782740663490; 
 Mon, 29 Jun 2026 06:44:23 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9b0992227sm48968555ad.37.2026.06.29.06.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:44:21 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 67/77] target/hexagon: Add support for loadw_phys
Date: Mon, 29 Jun 2026 06:12:22 -0700
Message-Id: <20260629131232.2487780-68-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfXwKy0XZ3YkuXH
 rnUoH5CNmfdJOZjLyMnQO+In5+S9jjXXGr+AhMK2RVfcJhktAU0beZgr2aQvxZoEPyVrgeuEhJq
 5QMZGo6M1M/79cw4E0Dzvi7vta0eNIeYwbfc4HZUF2likxHodppcwPxLUm5ONO2qUkWHeQBhbMf
 o/mhEeNsXBPBKKqoHqgxC+DjbCtoeLXUfA9i+7+LauUEgg5M9k8nlGp92P0NR0fGbKtAZ3XyMI0
 1sgyigYeLQfCSJC+U2gM81gahAcyFH3JhoDgkI4XR3mev2H4xPD35ZRN+6ydfoKqXSAJX/YBhZ3
 mC0BjXGVfzbzrhCYIU5nvcIBOZ+4n8QVeQ/hOt0RPY7LtmUZnRRxquc9hF84pYTUdbMhAteeId6
 bVcb6KES+ZZ6t9i43pqIVsPXccBA2xSJM3ZxLUGLNayVBcBLTBTkJkzn2wFuVLMFEUM63R29/W0
 YqM6bX3wNMRFb0z4X+Q==
X-Proofpoint-GUID: 5Nvl8s0_nvbqeNwJl3rAEGiF9u9Sljan
X-Proofpoint-ORIG-GUID: 5Nvl8s0_nvbqeNwJl3rAEGiF9u9Sljan
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX1hxbGn9jgy3n
 Z/e6N+BLKzQ2T1xuDFaFLT0HwKvvlC8y/nBdNWUebDUKEBjxxuIMe6T6eQnu5cwHH4ihxD1Mmbj
 lTM9W3Jo0NGayFZLX7dF4IIimg6B6yY=
X-Authority-Analysis: v=2.4 cv=OcWoyBTY c=1 sm=1 tr=0 ts=6a4276b8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=M_0_kNSAHlZdZebFLzYA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290114
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hl
eF9jb21tb24ucHkgICAgICAgICAgfCAzICsrKwogdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvZW5j
b2RlX3BwLmRlZiB8IDEgKwogdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbGRzdC5pZGVmICAgICB8
IDMgKysrCiAzIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Rh
cmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkgYi90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5
CmluZGV4IGFjYWFhM2M5NDRhLi5kOTFhNjUzYzNkNCAxMDA3NTUKLS0tIGEvdGFyZ2V0L2hleGFn
b24vaGV4X2NvbW1vbi5weQorKysgYi90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CkBAIC0y
NjQsNiArMjY0LDkgQEAgZGVmIG5lZWRfc2xvdCh0YWcpOgogICAgICAgICBhbmQgIkFfQ1ZJX0dB
VEhFUiIgbm90IGluIGF0dHJpYmRpY3RbdGFnXQogICAgICAgICBhbmQgKCJBX1NUT1JFIiBpbiBh
dHRyaWJkaWN0W3RhZ10KICAgICAgICAgICAgICBvciAiQV9MT0FEIiBpbiBhdHRyaWJkaWN0W3Rh
Z10pCisgICAgICAgIGFuZCB0YWcgIT0gIkw0X2xvYWR3X3BoeXMiCisgICAgICAgIGFuZCB0YWcg
IT0gIkw2X21lbWNweSIKKyAgICAgICAgYW5kIHRhZyAhPSAiWTZfZG1saW5rIgogICAgICk6CiAg
ICAgICAgIHJldHVybiAxCiAgICAgZWxzZToKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2lt
cG9ydGVkL2VuY29kZV9wcC5kZWYgYi90YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9lbmNvZGVfcHAu
ZGVmCmluZGV4IDA0ZTkxMWY1OWM4Li4xYzY0NDk1ZDUxOSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hl
eGFnb24vaW1wb3J0ZWQvZW5jb2RlX3BwLmRlZgorKysgYi90YXJnZXQvaGV4YWdvbi9pbXBvcnRl
ZC9lbmNvZGVfcHAuZGVmCkBAIC0zODQsNiArMzg0LDcgQEAgREVGX0VOQzMyKEw0X3JldHVybl9m
bmV3X3BudCwgSUNMQVNTX0xEIiAwMTEgMCAwMDAgc3Nzc3MgUFAxMDEwdnYgLS0tZGRkZGQiKQog
CiAvKiogTG9hZCBBY3F1aXJlIFN0b3JlIFJlbGVhc2UgRW5jb2RpbmcgKiovCiAKK0RFRl9FTkMz
MihMNF9sb2Fkd19waHlzLCAgICAgIElDTEFTU19MRCIgMDAxIDAgMDAwIHNzc3NzIFBQMXR0dHR0
IC0wMGRkZGRkIikKIERFRl9FTkMzMihMMl9sb2Fkd19sb2NrZWQsICAgIElDTEFTU19MRCIgMDAx
IDAgMDAwIHNzc3NzIFBQMDAwLS0tIDAwMGRkZGRkIikKIERFRl9FTkMzMihMNF9sb2FkZF9sb2Nr
ZWQsICAgIElDTEFTU19MRCIgMDAxIDAgMDAwIHNzc3NzIFBQMDEwLS0tIDAwMGRkZGRkIikKIApk
aWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbGRzdC5pZGVmIGIvdGFyZ2V0L2hl
eGFnb24vaW1wb3J0ZWQvbGRzdC5pZGVmCmluZGV4IDUzMTk4MTc2YTk5Li40ZTFlNWQ1MzI2ZCAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbGRzdC5pZGVmCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL2ltcG9ydGVkL2xkc3QuaWRlZgpAQCAtMjAzLDYgKzIwMyw5IEBAIFE2SU5TTihT
Ml9zdG9yZXdfbG9ja2VkLCJtZW13X2xvY2tlZChSczMyLFBkNCk9UnQzMiIsIEFUVFJJQlMoQV9S
RUdXUlNJWkVfNEIsQV9NCiBRNklOU04oTDRfbG9hZGRfbG9ja2VkLCJSZGQzMj1tZW1kX2xvY2tl
ZChSczMyKSIsIEFUVFJJQlMoQV9SRUdXUlNJWkVfOEIsQV9NRU1TSVpFXzhCLEFfTE9BRCxBX1JF
U1RSSUNUX1NMT1QwT05MWSxBX1JFU1RSSUNUX1BBQ0tFVF9BWE9LLEFfTk9URV9BWE9LKSwgIkxv
YWQgZG91YmxlIHdpdGggbG9jayIsCiB7IGZFQV9SRUcoUnNWKTsgZkxPQURfTE9DS0VEKDEsOCx1
LEVBLFJkZFYpIH0pCiAKK1E2SU5TTihMNF9sb2Fkd19waHlzLCJSZDMyPW1lbXdfcGh5cyhSczMy
LFJ0MzIpIiwgQVRUUklCUyhBX1JFR1dSU0laRV80QixBX1BSSVYsQV9SRVNUUklDVF9TTE9UME9O
TFksQV9OT1RFX1BSSVYsQV9NRU1TSVpFXzRCLEFfTE9BRCxBX05PVEVfTk9QQUNLRVQsQV9SRVNU
UklDVF9OT1BBQ0tFVCksICJMb2FkIHdvcmQgZnJvbSBwaHlzaWNhbCBhZGRyZXNzIiwKK3sgZkxP
QURfUEhZUygxLDQsdSxSc1YsUnRWLFJkVik7IH0pCisKIFE2SU5TTihTNF9zdG9yZWRfbG9ja2Vk
LCJtZW1kX2xvY2tlZChSczMyLFBkNCk9UnR0MzIiLCBBVFRSSUJTKEFfUkVHV1JTSVpFXzhCLEFf
TUVNU0laRV84QixBX1NUT1JFLEFfUkVTVFJJQ1RfU0xPVDBPTkxZLEFfUkVTVFJJQ1RfUEFDS0VU
X0FYT0ssQV9OT1RFX0FYT0ssQV9SRVNUUklDVF9MQVRFUFJFRCxBX05PVEVfTEFURVBSRUQpLCAi
U3RvcmUgd29yZCB3aXRoIGxvY2siLAogeyBmRUFfUkVHKFJzVik7IGZTVE9SRV9MT0NLRUQoMSw4
LEVBLFJ0dFYsUGRWKSB9KQogCi0tIAoyLjM0LjEKCg==

