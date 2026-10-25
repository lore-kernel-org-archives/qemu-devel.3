Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7AC606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 03:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O34O12Cm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P23tsFYI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKoqs-0007sv-2w; Sat, 24 Oct 2026 23:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKoqX-0007kx-7y
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:24:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKoqT-0001Ul-Sw
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:24:31 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69P17DSB2571645
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 82GTbX6co+CHV5P+y9vLi0NwE9T6aLWO6fg1F5HK7Zs=; b=O34O12Cm7wO7SA/2
 94zWgIovy568m5rtfRJpp81gBr4lG42hP9qScr4RlArV5IfEHi5q6tIySj/TdITO
 ZO2ysfKmVgE8ptm1IR/updY17tmi2Z5KiSMQpQGsElkjcYzcfdQE/hN3IALSpkhd
 38jWRRalcJyHW7HgmaEWbgkt2+ft6JDifhwBApKEMqumShciluOTIMfzG5oe6uAd
 fLHXfDs2W3WGfpDfQLo0ng85YgINxUfd6MvxfIW7X39j2wrURlQMXwTRMAv3XmvZ
 YL9OD4LJtic1wiR0TPt8TEmt78ksNWNz/9gl1HpEK/TsGp8RctlqhaPKh2xJ5UEY
 hZWu0w==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgnehj7yq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:24:28 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-169846a19aaso2584384c88.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 20:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792898668; x=1793503468; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=82GTbX6co+CHV5P+y9vLi0NwE9T6aLWO6fg1F5HK7Zs=;
 b=P23tsFYIbE9Zu+HIoT5Y3jGjtAuRgYFLdQOmoR+nqOIrxd1Q9tdC/kF0vQ5a4rDu64
 vbimauMkZMLIdWzf88VtGAgqZdoHl5cxXEvgdq9VfoeyxHSXyMPpamIFs0zjup+boTFc
 m8KDs4y0vc69vfTnIJFXTVPAUI+sxJG6LE/Mm0uhn0kloCzl3ibfg57ht9jcTpqeeQSG
 1W9l8A1b+3Lm6ZMX10w/c+3Xnb8hv+8EEnfUeEDZt2z489iJNiq/D80ncVEmLcsnWCBZ
 gE/FxJhFdYTWeKIXElKfvbMkVWZQAfBKQVsU0w0HyA+9Nrr0cSkpOGo0JaOLgGcdPWTg
 oh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792898668; x=1793503468;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=82GTbX6co+CHV5P+y9vLi0NwE9T6aLWO6fg1F5HK7Zs=;
 b=Pgj8xPJjfOmRZmOO9JvfWsklNj5luQUh1UThQiMDeW3TE5A5oC/StHzW+5uRNSFQ40
 QSkcka3LMKxfL0vpOXeEvQ5/D56E4nmfvti7WzvwVWILQP+ivJAKf2uwjUWuY6jg0PhR
 NQh2ZMRltyV4YPM7IBsq8V5mXbhGXhjGBnStQ3zQfnK3Ds2udPwjeAgCTY12TyjpTUn3
 JT+02GdYhZJ8k3j6T41KGZSBzQsoQXmoX7IJIA5gQbegQ9KU4H/DMO/rn7RtgXIkXaZq
 NCLzVNNbluTfBlQdXwikyRvowKJ1FtmIbfYVT6hwIrXB9+VPNoYVzIq57MsTryLa5mFo
 V/gw==
X-Gm-Message-State: AFq9FYIdOswUE2DtI6bVmqPhHOwgV02I5So/ID2LTuzEIScquhGIS7MT
 A50XZVj9tngmd3/QFQS6rsZshnaZVRbBfXu8CYO9qZiPGwib2AYPiRbRXWSBnhAivEYOuojUiC/
 DI7ZcfG6I7nrYulMbJ3QOZaEdsNt/9J8By65+1DK8BX3lkItbCOBVHEmW5GAv8YQN7g==
X-Gm-Gg: AYBFou3sjh932e/ENlGslunL72cZDm8xHiHyVugZIik/yGzXyyaHUEGsI4ZJMeO649a
 Mnpp030wQph4QQ5+5B90YMuNbhDQmDMzmD1/1NnlR/s6wZNog+apAYhqAz2sYzjRjc2BUggrVMr
 1f8l3Y5pr1LBMzGLgFXb4wgiCXDg5VGeQwSFtEjFdkSY8VVJ/MiWcMi0Tid4VmCOBKfZ4kDkUXO
 5E9vOWKhr8VFA14EfUT4npalh5TzbidYJHehpjDIsIY6JXA5YAUYkGCa+45CXpErLSiG4a6fA2+
 GUyeOonYUJisAkeIUpAIYvXLwDBxm+K59KrHKQ35w2Hlpv7G/NSCWVAfBdmpMW8iM1vYZT7QjZT
 tc0/5U3O/q6hWz/wwmZiUtAEFpPmou1SNlnXxKGrytqgppLI=
X-Received: by 2002:a05:7022:f50f:b0:189:d6bf:7ec7 with SMTP id
 a92af1059eb24-19b75b5a3e1mr2090979c88.19.1792898667668; 
 Sat, 24 Oct 2026 20:24:27 -0700 (PDT)
X-Received: by 2002:a05:7022:f50f:b0:189:d6bf:7ec7 with SMTP id
 a92af1059eb24-19b75b5a3e1mr2090951c88.19.1792898667091; 
 Sat, 24 Oct 2026 20:24:27 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a249c331sm26812581c88.17.2026.10.24.20.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 20:24:26 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 19/40] hw/hexagon: let a machine place its DDR
Date: Sat, 24 Oct 2026 20:23:25 -0700
Message-Id: <20261025032346.2917451-20-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
References: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI1MDAxMiBTYWx0ZWRfXwIbJX4AEkOc5
 sab283xoRVRMzo7mPiBGAOo0cEw3NtDZqcgMIq9AhxHS/cjw3lu/On02T7FiNINfLnYqWUMqKZb
 cuFcQMwhkd21/UAP+C32e3iuCBGfDkA=
X-Proofpoint-ORIG-GUID: es6i7gnbZzaLFLW4RgQa5u9UXn5g86Dg
X-Authority-Analysis: v=2.4 cv=d5tgWhjE c=1 sm=1 tr=0 ts=6add766c cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=aYFWVRUMB-liYKm9W0cA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI1MDAxMiBTYWx0ZWRfX4Rxo5e7yjXyn
 7SuI89LZe06zMRHO5ZjpzbBBAq05YSjTn/YYjmhnJWHK9KjdY4zd/shccb+b/BgcecReOP3qj0R
 97TyLZzsUB5BaBs3WWA7l0phVg4p433fxipr8Ita8dNJHnK0W7BYVKwLHkN8ChAwP62zILdhIPy
 0SC4Ewr+XI0+HQQC+HY7e5Ao/SYn5n0RvwBzObOcu/QYSCIIl0xlxGOtqRqMn1Mh+JSNRAKop01
 ohgvAJl0mYCKaBmyOOI3oiCEa3fQvtSRgCZlw8nNl+Otcy2ZaS1h1ShGthzqouxY10YzgnuX2xt
 2Zq8sH13R50YHQLR54QbnfflRM6s+AGiAWb4JBJxVG8NW2yWMCF8qxw0qKi202kOEEajE2TCCD/
 cCJKMjx91DGkxUu1wtLmX3iNCm205lPA3q7DvVKb4jbLPaSpf4IqKncPsWplbIzA2iw6PtL+aPw
 HTwoijfjCARXK+XUcQA==
X-Proofpoint-GUID: es6i7gnbZzaLFLW4RgQa5u9UXn5g86Dg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-25_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610250012
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

aGV4X3N1YnN5c19jcmVhdGUoKSBhbHdheXMgbWFwcyB0aGUgbWFpbiBERFIgYXQgYWRkcmVzcyAw
LiAgVGhpcyBpcyBhcHByb3ByaWF0ZQpmb3IgaGV4YWdvbi1zaW0tc3R5bGUgbWFjaGluZXMsIGJ1
dCByZWFsIFNvQ3MgbWFwIGl0IGVsc2V3aGVyZS4KClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2
aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJy
aWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBpbmNsdWRlL2h3L2hl
eGFnb24vaGV4YWdvbi5oIHwgMiArKwogaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMgICAgICB8IDQg
KystLQogMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb24uaCBiL2luY2x1ZGUvaHcvaGV4
YWdvbi9oZXhhZ29uLmgKaW5kZXggNzk2MTdhMDY4ZGEuLjAxZWQwM2NjODMzIDEwMDY0NAotLS0g
YS9pbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5oCisrKyBiL2luY2x1ZGUvaHcvaGV4YWdvbi9o
ZXhhZ29uLmgKQEAgLTE0OCw2ICsxNDgsOCBAQCB1bmlvbiBoZXhhZ29uX2NvbmZpZ190YWJsZSB7
CiB9OwogCiBzdHJ1Y3QgaGV4YWdvbl9tYWNoaW5lX2NvbmZpZyB7CisgICAgLyogQmFzZSBhZGRy
ZXNzIG9mIHRoZSBtYWluIEREUiByZWdpb24gKi8KKyAgICBod2FkZHIgZGRyX2Jhc2U7CiAgICAg
LyogQmFzZSBhZGRyZXNzIG9mIGNvbmZpZyB0YWJsZSAqLwogICAgIHVpbnQzMl90IGNmZ2Jhc2U7
CiAgICAgLyogU2l6ZSBvZiBMMiBUQ00gKi8KZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vaGV4LXN1
YnN5cy5jIGIvaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMKaW5kZXggOTgxOGNmNTg4NzguLjM4MmY0
NWJkMDlmIDEwMDY0NAotLS0gYS9ody9oZXhhZ29uL2hleC1zdWJzeXMuYworKysgYi9ody9oZXhh
Z29uL2hleC1zdWJzeXMuYwpAQCAtMTM2LDEwICsxMzYsMTAgQEAgdm9pZCBoZXhfc3Vic3lzX2Ny
ZWF0ZShIZXhhZ29uQ29tbW9uTWFjaGluZVN0YXRlICpobXMsCiAgICAgTWFjaGluZVN0YXRlICpt
YWNoaW5lID0gTUFDSElORShobXMpOwogICAgIE1lbW9yeVJlZ2lvbiAqc3lzbWVtID0gZ2V0X3N5
c3RlbV9tZW1vcnkoKTsKIAotICAgIC8qIE1haW4gRERSIGF0IHRoZSByZXNldCB2ZWN0b3IuICov
CisgICAgLyogTWFpbiBERFIuICovCiAgICAgbWVtb3J5X3JlZ2lvbl9pbml0X3JhbSgmaG1zLT5y
YW0sIE5VTEwsICJkZHIucmFtIiwgbWFjaGluZS0+cmFtX3NpemUsCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAmZXJyb3JfZmF0YWwpOwotICAgIG1lbW9yeV9yZWdpb25fYWRkX3N1YnJlZ2lv
bihzeXNtZW0sIDB4MCwgJmhtcy0+cmFtKTsKKyAgICBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdp
b24oc3lzbWVtLCBtX2NmZy0+ZGRyX2Jhc2UsICZobXMtPnJhbSk7CiAKICAgICAvKiBDb25maWct
dGFibGUgUk9NIGFuZCB0aGUgYmxvYiB0aGF0IGJhY2tzIGl0LiAqLwogICAgIG1lbW9yeV9yZWdp
b25faW5pdF9yb20oJmhtcy0+Y2ZndGFibGVfcm9tLCBOVUxMLCAiY29uZmlnX3RhYmxlLnJvbSIs
Ci0tIAoyLjM0LjEKCg==

