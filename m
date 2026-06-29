Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC019C43638
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBnB-0004KO-Dd; Mon, 29 Jun 2026 09:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBn9-0004Jt-6B
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:12:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBn7-00039x-Mt
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:12:50 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT4Il2618912
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:12:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=IkxVmrZuFWa1Fs3sFSDNQQouCUhLSalQWx3BbBytT1I=; b=RL
 mCZ1gJerq+VTeFKkwQ3EijdBBGouowWC5oXj3zzW7Rb5dZZE0OZj8WlOu5eYojmT
 L8jnDOL3CZvuTVn6AmLJ+5ja2JUsemAMN1PxrOXrTiWFU3wQuJKrmPWQ4VovTOZc
 i/nqPTSYCzZ3Vxpp69fNHby6NpbCrMCHNWm9mhHf4Zd/QOAyrZn/XMxeBznlS8ci
 r+0c8yRc22/O6XXPHHEXZ6peD1sIIm1COAlUukyN2ryuWeIKwEGZ976MWsO2+z7r
 RxqFKbxIkDJl9x5ZFSk+oWWFVoWHLH2ty5GLuqCiuAfCyNthaleTPh5KNce/cpv7
 n+kdK6Tt8l5oj7TRI1Sw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3pdkrr33-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:12:48 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1384427c3efso10310675c88.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782738768; x=1783343568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IkxVmrZuFWa1Fs3sFSDNQQouCUhLSalQWx3BbBytT1I=;
 b=kvpBG7GFa4NSYdes58RV20aTW5J02pjD5BhjFzw2FA/dqhbQ+2pl8yJyMvWBGhwQsU
 vSi1Xr88Ye7INRmmNhwIkFYr85wDlUzmbio7HMm6Mh/RhKR6I+qIT2O8Krm0W8G+fKb7
 c74qMHK9PJNNYIpCY7Qi5GXKGGCKP6gay4eRxyCtnRND2yr2EJmWTq3eGLdRBMktaFE8
 S0ilXdOJ29t6slNL84a3byCUbD7kospfd7CTASYnjJS7NhCZIpeXjKGC6ponsmOrHt7V
 UnqJrD9z+F7a8oHMqkWItp5ZLETEMDMLa6b69A3FEz7G0PWWPBIzyVzpRfGNFpgjBmBj
 Vmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782738768; x=1783343568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IkxVmrZuFWa1Fs3sFSDNQQouCUhLSalQWx3BbBytT1I=;
 b=lcMqEtJm6gsUVnI98paigJa9TTjnONVSlRXxDDuQUJvquDy+i9amv6VZBA/X/JmTvp
 1g7A7XHVZoXQ8oySOWPEFSITaSOpJFxLZmHu9GiQZSC6IJ2f0Al7aMWRUot60uSbM7b/
 CQ/+C3TRp8Sfxrpj+BA8WwpQdvQk1kAw0K3qqKRw6R7A+EQ9iy4wgf4ZABhjmuBZerHa
 cSGgHo6CkYHc/bxULE60zJg0w/Z3F49cbpDdx+WEKqjFb5GcuK/WFADEjSYWHTSKXIy1
 YowSnVgWrVvxwHf+A/iEqlfs91PfguDwSU3TC2ig2q80BWefksGdHw32PWYJ/Dg8Us4/
 UEQQ==
X-Gm-Message-State: AOJu0YwMZwmw2Sryw+sK4CAtkH18hGfswmEqtMh3rEAJWH+8ywBZEqfS
 DLM0FScwLWIIqzCB4UlLTZOhyLfhG6p2BITQOCubJOIwt+k4Vd0jMHpxMGQ3+MBJwOxsKlb9ocJ
 Sv8PuGZOuYt2jrFcItG4VIshrZFSbGZWPhTLxWmBv/K9gCeewQMFV5I1avxF9XINkjw==
X-Gm-Gg: AfdE7cle7fmxKUnk7Eiwm5WrKbUKsScKR3DKAHOUNZpb/L9g622OxvxMGys1fO4As0M
 ic+fm/5cSi83zTefJRkRP7qrZn2pWgrSMtPUek/UNZhjaN9c8UAUf7HWCps3lAYRyllSxpBhs3N
 tNS6E1z7HANzmsbOctR5A7d07Ayk2NirIt0/O52Es91KgD5t3ex4W1YrAmb5E1R4RGbFi2zoBzI
 tpD3HJPfw4dWNQwQXx1D/3snCPRewvU0sEK2c6gJNucrYclgQ5g9/sLJqU9vdfdGLGtHIg24xHX
 IL30ogAfvApsUsOROKIHujcxRhZMAKplvQZF8UW95HuYaBxbCdtiBWhA8oiHzioSyF3PiIsR9vc
 9PUCX/rrtWyWHZEU/lulAjti2OlMNEQtMxIEGXi/+7HadTFtfahTPvSS5Hx4=
X-Received: by 2002:a05:7022:21a:b0:139:f749:b077 with SMTP id
 a92af1059eb24-13b22731b49mr491933c88.43.1782738767878; 
 Mon, 29 Jun 2026 06:12:47 -0700 (PDT)
X-Received: by 2002:a05:7022:21a:b0:139:f749:b077 with SMTP id
 a92af1059eb24-13b22731b49mr491904c88.43.1782738767329; 
 Mon, 29 Jun 2026 06:12:47 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139e78317f3sm28459106c88.9.2026.06.29.06.12.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:12:46 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 07/77] target/hexagon: Fix badva reference, delete CAUSE
Date: Mon, 29 Jun 2026 06:11:22 -0700
Message-Id: <20260629131232.2487780-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a426f50 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8
 a=YHbvUooXmMNqKe3LDhEA:9 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: PDwv9js50Fj5ht2fII95wKiKjP_EGS3x
X-Proofpoint-ORIG-GUID: PDwv9js50Fj5ht2fII95wKiKjP_EGS3x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOCBTYWx0ZWRfX2/yUKUC7l6Ek
 2FY1fde1j4gfRii5QK7W9kb/6RkT68+hzeGIGLYHwakG5KGQzrFFdjCzU6o/Iq6uLuCAxFKizx7
 AHY4jiCqISAoCBRh8gm8tHPIaJ312n4TOmC1ZofhBsJEHY/Nhz0913KBTlN+mZkQB+1/WdVmasP
 tw5iDRZ2ZMZBB3Qbmed0phUbp4ZkauQz71ETu+GA86GFWRr4qJwDVuQLGZzQXqHF0qbdVIt/tjA
 L6GhoHHUGid+sKjbJiqT8pC4DhE0QXq3Owy7AC3FM01z1Ajw1jFS08KPUYhsT12ZEGs5zsOPchJ
 ryJNWsYakSwJ5C6dc9PUY3lO0mpdd48Iqeb0cAZUT0zmShYMuoKRD1lVEeB6Hms9c1UDACk714b
 dWEIxEzLJ2/jJKgkSI9Sw2e/ddZsoIv7BNm3mN5hjuA0wG3sfjDghtHNLmMa5YGanqkSfqNJd/a
 OZcHRbiArfV8YM8lcjQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOCBTYWx0ZWRfXxg633evmNtnp
 0lxXa7Mk5BGtdTN6M8Doq06sQp7HhtlNJjt1+b5vMHX9JQzTuZun028joFfx6sblYwY0ecLzpZ5
 MT0G5So/vok0EzFQ4tPirjJl86qfCOA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290108
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGUgQkFEVkEgcmVnIGlzIHJl
ZmVycmVkIHRvIHdpdGggdGhlIHdyb25nIGlkZW50aWZpZXIuICBUaGUKQ0FVU0UgcmVnIGZpZWxk
IG9mIFNTUiBpcyBub3QgeWV0IG1vZGVsZWQsIHdlIHdpbGwgZHVtcAp0aGUgU1NSIGluIGEgc3Vi
c2VxdWVudCBjb21taXQuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9z
cy5xdWFsY29tbS5jb20+ClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhp
bG1kQGxpbmFyby5vcmc+CgpSZXZpZXdlZC1ieTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1w
c29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3Mu
cXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2NwdS5jIHwgMTEgKysrKysrKysrLS0K
IDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCAy
YzUzZjJjMjgzNi4uYmQ1NjhiZGQ4NzEgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5j
CisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBAIC0xMTAsNiArMTEwLDE0IEBAIHN0YXRpYyB2
b2lkIHByaW50X3JlZyhGSUxFICpmLCBDUFVIZXhhZ29uU3RhdGUgKmVudiwgaW50IHJlZ251bSkK
ICAgICAgICAgICAgICAgICAgaGV4YWdvbl9yZWduYW1lc1tyZWdudW1dLCB2YWx1ZSk7CiB9CiAK
KyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorc3RhdGljIHZvaWQgcHJpbnRfdF9zcmVnKEZJTEUg
KmYsIGNvbnN0IENQVUhleGFnb25TdGF0ZSAqZW52LCBpbnQgcmVnbnVtKQoreworICAgIHFlbXVf
ZnByaW50ZihmLCAiICAlcyA9IDB4IiBUQVJHRVRfRk1UX2x4ICJcbiIsCisgICAgICAgICAgICAg
ICAgIGhleGFnb25fc3JlZ25hbWVzW3JlZ251bV0sIGVudi0+dF9zcmVnW3JlZ251bV0pOworfQor
I2VuZGlmCisKIHN0YXRpYyB2b2lkIHByaW50X3ZyZWcoRklMRSAqZiwgQ1BVSGV4YWdvblN0YXRl
ICplbnYsIGludCByZWdudW0sCiAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgc2tpcF9pZl96
ZXJvKQogewpAQCAtMjA5LDggKzIxNyw3IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fZHVtcChDUFVI
ZXhhZ29uU3RhdGUgKmVudiwgRklMRSAqZiwgaW50IGZsYWdzKQogICAgIHFlbXVfZnByaW50Zihm
LCAiICBjczAgPSAweDAwMDAwMDAwXG4iKTsKICAgICBxZW11X2ZwcmludGYoZiwgIiAgY3MxID0g
MHgwMDAwMDAwMFxuIik7CiAjZWxzZQotICAgIHByaW50X3JlZyhmLCBlbnYsIEhFWF9SRUdfQ0FV
U0UpOwotICAgIHByaW50X3JlZyhmLCBlbnYsIEhFWF9SRUdfQkFEVkEpOworICAgIHByaW50X3Rf
c3JlZyhmLCBlbnYsIEhFWF9TUkVHX0JBRFZBKTsKICAgICBwcmludF9yZWcoZiwgZW52LCBIRVhf
UkVHX0NTMCk7CiAgICAgcHJpbnRfcmVnKGYsIGVudiwgSEVYX1JFR19DUzEpOwogI2VuZGlmCi0t
IAoyLjM0LjEKCg==

