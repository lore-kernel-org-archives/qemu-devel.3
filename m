Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72507C5B567
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 06:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu2Tg-00072Q-7n; Wed, 12 Aug 2026 02:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2Tb-00071L-ER
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:30:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2TY-0003gj-H2
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:30:11 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C62B4C2646680
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ek2ZiHWFHeWKYPX7DkjBckxgukuuxX1Gf2L/3Ya/QyA=; b=YVrs45iRQoacI3d6
 DlQzeQfTgLXKlUH+9Ve3RgYscMyT8KWBtr80QEwRRE92jkoG5kOFx4X6mzdvutjy
 Um727HGEhXxST4t73JBHEprR/xxmzIzcwpGylYl7xjErWkixdqzHKakk0pLv7GIv
 IaG2NXkT3gfHoplVzH4XcysxtXTbMgYLsXHkiu7S6crfBA1E9b08KA6lnI8SVFQC
 iKbdnyFeE0npS5Y6TCYj1C3dqDauAT96Qb77evINxu7tiDZPll1jPN+FdO+oeF/K
 2jgaAq8jch06XPK70BxZhfKizhvBZ5zO7G+XB/F6C32drVy52MfswOmhTf0cAG8N
 zdPNug==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049kkvp6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:30:03 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e11baa66eso802159a91.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 23:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786516203; x=1787121003; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ek2ZiHWFHeWKYPX7DkjBckxgukuuxX1Gf2L/3Ya/QyA=;
 b=bGfzJHdmfF23Wam+LKcPg8ekd9ys7oYHMTCdCvJq7ZrZdT91Y+yFWbEmKyKYytaxav
 KaF8abePY+cRPiGc+ahRLbv6C71kpmzc5pBmANQWNVL+cQ3WOQWPgqKKOVGEj+O/Xc5j
 R4HRjornx2tt6F1qNeoE6Tg4Ox8lgjuLnlXrEoUB5tZivw4JYnAa11aEWVbjRSeChH/z
 uSBu9jvDRlgU6W90Nmij3mqd9Yj/JIEGXscFUBzxrjPZ4od2TGV8L8IuwJf/Dpcjhq+l
 ZR4UQT0iaUIb/iRnJONnxzPUpl92nEG+GQztyn8X3+OuAtOoGJWra/9VYXEU1AcGQAXv
 ORYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786516203; x=1787121003;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ek2ZiHWFHeWKYPX7DkjBckxgukuuxX1Gf2L/3Ya/QyA=;
 b=bjt6DsRgftgkm7tFZOso84nHc/EiCWZboK0XVpAtPIvf2QnROPHbQVID8gKG01wC7n
 4xVArz8q1eAvj/E/b+Oko4yjRVeuxezna6zyhcBk0SgR1/+v2zpcY3HmWEOIyTQ9tTzb
 8CfWTOnFc+hinHe08uYqh0xARYLZfKBEIFu4RM3Tg4FM/30wNd8EV1Oe5EK+3ifgN0I8
 oF/GvSMhSIdflpbBg3aNSkS7n510gbIvZhUWTgRFNe17Zs5KN297iZ95QqWnEwAWMkmA
 hBXD8sfJxzXHSxmHKF/rL77u2k6lNbbnFMxYSTMorU79oQ1I/3VUxoDEag/gBywLsm/I
 qMJw==
X-Gm-Message-State: AOJu0YxP592MQI/vCeEMY8MdlomeJfgnOvXEHmzh7JRZQC7LD7hdDkQw
 f0XQJ2AxI3t7Q9Zi/KptjeQEHRS6pR1SqWSFbJ0uarvGbSbmnbpS5LwQlS+koeYonNdIZE4YYdD
 IVYpnKP5eX6umtpjD9JgNzoeXzDkIdPn4h29pMW8KLOPbNqY7wRkYqxGRpUjfX+iVEQ==
X-Gm-Gg: AR+sD12AFKS1lwuXRUexBUwox0fBApA9LfyDmDF4PmRyiwBe2QBiBxMweh2rXO/IW+B
 bAVpy1zq5MJtZgwfm+mweaMVZCqn5Q4D62V9Njsfi06vEJapEcItqcDhnwBxbYJ+aqyCKfZXbnR
 ffKuWIpQczIXj/Oe90CtAn2MyOsIOSsjhq9YMybwynPnTCX2H/PE/2CUrsyacKusVgkvNQ3XC30
 8Q/KGU+dPqSwh4mfXS3py7DQ6/5NbmTryNxA10Sn2A66P7YFabSkW+ffnwE2DWwCBzbWln8pK33
 V2kPACWLU5nJxHPwHcpxoRfxPLmwDEc07YDg1pWkGyIXJGSwb79nWxL6LJLEcLUW8JaXOoAAT56
 0iPXAXnpPxQqhQbG4Xf3yyT9cva0zhG11DHqeTpF2orOy3UIt
X-Received: by 2002:a17:90b:2d87:b0:38d:ddc2:7ccb with SMTP id
 98e67ed59e1d1-393012cedf9mr2878924a91.1.1786516203119; 
 Tue, 11 Aug 2026 23:30:03 -0700 (PDT)
X-Received: by 2002:a17:90b:2d87:b0:38d:ddc2:7ccb with SMTP id
 98e67ed59e1d1-393012cedf9mr2878884a91.1.1786516202590; 
 Tue, 11 Aug 2026 23:30:02 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392f985e9fcsm771402a91.1.2026.08.11.23.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 23:30:00 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 02/41] hw/hexagon: move VTCM to the common machine state
Date: Tue, 11 Aug 2026 23:28:53 -0700
Message-Id: <20260812062932.543840-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
References: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: Ts3mI3fARMCsLSge1vRQ2aqv2pu7rx4D
X-Authority-Analysis: v=2.4 cv=IO4yzAvG c=1 sm=1 tr=0 ts=6a7c12eb cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=31cAqr7vU2O6cbMaemAA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA0OSBTYWx0ZWRfX7Eym1bfCPa0o
 SqjBklaclpE28GfevSwbEYZegSs6NcPpHbVag6Idwkrd0yXFRPbvprzoq57S9eaniCN/eACqDWJ
 Opmkj0qsYmXQ4E2GO91zJ5GvyZXebBCKXv7cqRWOVZgyytBAKVppuxROWukvn0UzanDeHjpesSK
 AjZ6+9cbHYEmfp5IjdYRGwmTOrjqXQWPd12dLV3Eo+wJFv5qTEvc8YVmsse6cQwwil8Q1tGZ5qG
 oXHOuTn+o2kGbafgOv5Q3S6/RGc/1I0YmaknvpJVaVoH90MZpdQfq6aFGlYo2a9Sb+BN/bmUPSy
 YY3eOL6z1YMA2B2XV3OSl8VGHgzf3HHWp3A19MXlvZVQefSAES9jcze61Kls9y3vpcrk0LvbBut
 ixgpImJnb0ypZHSm9a4e9ks8VhGARJzV9ADYVeyMrfTN0devlT7BnRl0a66D1WXV02DBY/vmzUL
 VOt0nxzjbmIzSxckd4g==
X-Proofpoint-GUID: Ts3mI3fARMCsLSge1vRQ2aqv2pu7rx4D
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA0OSBTYWx0ZWRfXxjFVsgHLQQdr
 1NZOfpPrCE/B4QdrdwCz+dLHDTVd2FhDkPvdffpG0XjlSMm9vzZY9QiZFM8a+fYid2uUcz/Crde
 gD1GkvCFad4S+HjVvUpZGcBpxZwG/Go=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120049
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

VGhlIFZUQ00gaXMgZGVzY3JpYmVkIGJ5IHRoZSBjb25maWcgdGFibGUsIHNvIGV2ZXJ5IG1hY2hp
bmUgY2FuIHNldCBpdAp1cCB0aGUgc2FtZSB3YXkuCgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91
dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpMaW5rOiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYwODA2MDQyNzIzLjM3ODUzNjktMy1icmlhbi5j
YWluQG9zcy5xdWFsY29tbS5jb20KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2Fp
bkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGluY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uLmggfCAx
ICsKIGluY2x1ZGUvaHcvaGV4YWdvbi92aXJ0LmggICAgfCAxIC0KIGh3L2hleGFnb24vaGV4LXN1
YnN5cy5jICAgICAgfCA4ICsrKysrKysrCiBody9oZXhhZ29uL3ZpcnQuYyAgICAgICAgICAgIHwg
NSAtLS0tLQogNCBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb24uaCBiL2luY2x1ZGUvaHcv
aGV4YWdvbi9oZXhhZ29uLmgKaW5kZXggMTAzNGIwOWMyYWMuLjljNzNjYWRiMTZkIDEwMDY0NAot
LS0gYS9pbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5oCisrKyBiL2luY2x1ZGUvaHcvaGV4YWdv
bi9oZXhhZ29uLmgKQEAgLTE1Niw2ICsxNTYsNyBAQCBzdHJ1Y3QgSGV4YWdvbkNvbW1vbk1hY2hp
bmVTdGF0ZSB7CiAKICAgICBNZW1vcnlSZWdpb24gcmFtOwogICAgIE1lbW9yeVJlZ2lvbiBjZmd0
YWJsZV9yb207CisgICAgTWVtb3J5UmVnaW9uIHZ0Y207CiB9OwogCiAjZW5kaWYKZGlmZiAtLWdp
dCBhL2luY2x1ZGUvaHcvaGV4YWdvbi92aXJ0LmggYi9pbmNsdWRlL2h3L2hleGFnb24vdmlydC5o
CmluZGV4IGZjYjQ3NzYyMTk0Li5jZjBjZDJmOGYyMiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9ody9o
ZXhhZ29uL3ZpcnQuaAorKysgYi9pbmNsdWRlL2h3L2hleGFnb24vdmlydC5oCkBAIC0xNyw3ICsx
Nyw2IEBAIHN0cnVjdCBIZXhhZ29uVmlydE1hY2hpbmVTdGF0ZSB7CiAgICAgaW50IGZkdF9zaXpl
OwogICAgIE1lbW9yeVJlZ2lvbiAqc3lzOwogICAgIE1lbW9yeVJlZ2lvbiB0Y207Ci0gICAgTWVt
b3J5UmVnaW9uIHZ0Y207CiAgICAgTWVtb3J5UmVnaW9uIGJpb3M7CiAgICAgQ2xvY2sgKmFwYl9j
bGs7CiB9OwpkaWZmIC0tZ2l0IGEvaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMgYi9ody9oZXhhZ29u
L2hleC1zdWJzeXMuYwppbmRleCBkMTQ2ZWUwYzA3NS4uMGMyMGNmMDJlN2QgMTAwNjQ0Ci0tLSBh
L2h3L2hleGFnb24vaGV4LXN1YnN5cy5jCisrKyBiL2h3L2hleGFnb24vaGV4LXN1YnN5cy5jCkBA
IC0yOSw0ICsyOSwxMiBAQCB2b2lkIGhleF9zdWJzeXNfY3JlYXRlKEhleGFnb25Db21tb25NYWNo
aW5lU3RhdGUgKmhtcywKICAgICByb21fYWRkX2Jsb2JfZml4ZWRfYXMoImNvbmZpZ190YWJsZS5y
b20iLCAmbV9jZmctPmNmZ3RhYmxlLAogICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplb2Yo
bV9jZmctPmNmZ3RhYmxlKSwgbV9jZmctPmNmZ2Jhc2UsCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICZhZGRyZXNzX3NwYWNlX21lbW9yeSk7CisKKyAgICBpZiAobV9jZmctPmNmZ3RhYmxlLnZ0
Y21fc2l6ZV9rYiA+IDApIHsKKyAgICAgICAgbWVtb3J5X3JlZ2lvbl9pbml0X3JhbSgmaG1zLT52
dGNtLCBOVUxMLCAidnRjbS5yYW0iLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1f
Y2ZnLT5jZmd0YWJsZS52dGNtX3NpemVfa2IgKiAxMDI0LAorICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICZlcnJvcl9mYXRhbCk7CisgICAgICAgIG1lbW9yeV9yZWdpb25fYWRkX3N1YnJl
Z2lvbihzeXNtZW0sIG1fY2ZnLT5jZmd0YWJsZS52dGNtX2Jhc2UgPDwgMTYsCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAmaG1zLT52dGNtKTsKKyAgICB9CiB9CmRpZmYgLS1n
aXQgYS9ody9oZXhhZ29uL3ZpcnQuYyBiL2h3L2hleGFnb24vdmlydC5jCmluZGV4IGFkMGJjNGYx
MzI5Li41M2VhYWZhZjg1YSAxMDA2NDQKLS0tIGEvaHcvaGV4YWdvbi92aXJ0LmMKKysrIGIvaHcv
aGV4YWdvbi92aXJ0LmMKQEAgLTc1LDExICs3NSw2IEBAIHN0YXRpYyB2b2lkIGZkdF9hZGRfaHZ4
KEhleGFnb25WaXJ0TWFjaGluZVN0YXRlICp2bXMsCiAgICAgY29uc3QgTWFjaGluZVN0YXRlICpt
cyA9IE1BQ0hJTkUodm1zKTsKICAgICB1aW50MzJfdCB2dGNtX3NpemVfYnl0ZXMgPSBtX2NmZy0+
Y2ZndGFibGUudnRjbV9zaXplX2tiICogMTAyNDsKICAgICBpZiAodnRjbV9zaXplX2J5dGVzID4g
MCkgewotICAgICAgICBtZW1vcnlfcmVnaW9uX2luaXRfcmFtKCZ2bXMtPnZ0Y20sIE5VTEwsICJ2
dGNtLnJhbSIsIHZ0Y21fc2l6ZV9ieXRlcywKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAmZXJyb3JfZmF0YWwpOwotICAgICAgICBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdpb24odm1z
LT5zeXMsIG1fY2ZnLT5jZmd0YWJsZS52dGNtX2Jhc2UgPDwgMTYsCi0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAmdm1zLT52dGNtKTsKLQogICAgICAgICBxZW11X2ZkdF9hZGRf
c3Vibm9kZShtcy0+ZmR0LCAiL3NvYy92dGNtIik7CiAgICAgICAgIHFlbXVfZmR0X3NldHByb3Bf
c3RyaW5nKG1zLT5mZHQsICIvc29jL3Z0Y20iLCAiY29tcGF0aWJsZSIsCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICJxY29tLGhleGFnb25fdnRjbSIpOwotLSAKMi4zNC4xCgo=

