Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C622C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuB7L-0005HR-Ua; Wed, 12 Aug 2026 11:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB78-0004r4-Nq
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:43:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB76-0000O6-Us
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:43:34 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CDbtFH2728893
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=6JZfcYgiHkLJYfajT4dIecVjGyRwLhk+lobOnrbE4ow=; b=B4
 DyPTl95Kvt3RE61qPzsN1mSHcm5IRh6SDQrtpKSdjeSPStYGoZ1lDL3gW4p/AhdK
 G9P6m1VisQfuabkvyMoSHmVWs0q0anRXOzYBQyj+KX/dpRRgOO+Pfv/ofxTLjX9Z
 uxR8Vxij3Rn1GJiWTNkVFxOHhamU+hgJz2w+A/Xxr/ea9DAiZ8XpCAwenXuBFSsc
 CHxy5Y6Ou4mS3iwQqkN8thkC64vpERo8FJ8aheRZXYclZkH32LRGU2B+y6sxsjiI
 Xafq4v6F0paEHW1DvfFV4iH3lXxEXlZzasS9OUhEMe7XAOtd0EJjNMOPlucXImpx
 Q4CFfHmGAIFI1qUBFWcw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hfw2rjd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:43:21 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cee894b3d8so21290685ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786549401; x=1787154201; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6JZfcYgiHkLJYfajT4dIecVjGyRwLhk+lobOnrbE4ow=;
 b=GyrJpGhtWHsfHRQmVqhGu0ReGPTX5NWyiF/V9fqCo+7UB8DKh1Bfs7qHQnbCvRgI1U
 ZeeyjcylFDURroVphLmMNfTjrGhsXN3018tRyg4bCSjLG+KZt8vNF+ftxndHfeKAcerq
 mLaSc+BP4McyxnSSsBWqZdg+M+Aghr29Fw1NZ0aCqk4+JfwuNgl133nb+9G+va+VGSfD
 3tZpM2SgPwMN1gQ0gH1eVHdqOifJpkXDgAtFb2Gy5C7db584O5iPMQ+2Q+BPVM45sf9z
 3zlu1YrecZk634I9y4qbvSvKkINFvR3vcv9IBmj/7ZXaTI9xMZiC0ASNM1lNNrjrHDEl
 UEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786549401; x=1787154201;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6JZfcYgiHkLJYfajT4dIecVjGyRwLhk+lobOnrbE4ow=;
 b=PIaa4PmOU/1zAzJvsESKvMoNk6I5V9EPy9bpN2OEqppK2isidooB6KKWFlzcf1wcE4
 Er4v8Sn2+sjGyRxf1rP1Vg6Qb/QybGTmXh+xKC7RQX1Q/xESgNxHo+jAHah94nrefwz5
 fF3rSxZoHoJq+abuFGfbnE8azHdZZdmWMBYYQ8rUlOUQYVgrB8ZcovsygFq0E9KcWG2T
 jvTy2HdhWk8Dmh7inytyUdcIiYrqCyPwFTRHtvhuHHcabzYKxXx5WkwghfrPHR2Cn/x7
 Nv6Y4C8Vl9tGDkBwZCW+84sWX8ptuRAq44iIBvykupw99kTtrkERFIJrRW1Ug2FZdRqh
 naLg==
X-Gm-Message-State: AOJu0Yy/Ekh74EfovAaaGssvVh/6WlqQoSmJNsSCkq/C+hPfEGMMdygH
 gXFfFdaWYF5vHIvtWVcGCHoAubZczdbgjrEtLKdbCSQZcz9nXm8DjPhbWlGY+hq1CMRI0q32AsN
 Lm0avKODRe3xAl070f5fp3PY07YoIof7tNqPNT7DkFrIA8PpaBpFBS+plh5seq7kO2g==
X-Gm-Gg: AR+sD12AtYAcyQhpQ+a6ia+DMz0+OPVKBGwJ4ezkx39wXR+hVX4z8RAzd5pKRC7STXZ
 xIeAlVegqpN3vJJKFIW2sf8gSx8BwbuEW7MInFrPJ1ZhudWZk2JcGfRbJeUQBKHcCT5yfoet+Zw
 bqBlxKQAm0ER96ytb+C8aKVL3weBXRRJQ4KzgmwbahsRlPQ+wO8mnB35YB5UUxPafQMbSulxHYw
 UD4SV9S02mE6M259cRPc9FKY2dB7agX4w0suI5hAstAIF7hGQaZDL3mecXcAkgERk6WMxfsbc7S
 IWelX6whaDs9rTgQQMDmFA0GVa3nC3AESABohAWeGavSIWiFWZZeSyNmSvn95F6cZx0V4g1pFYA
 BhF/X2XVQdCnZFn4fKPyKcTqFDosvgNpwfcViRz1yRq117DRs
X-Received: by 2002:a05:6a20:734b:b0:3c0:b766:74f4 with SMTP id
 adf61e73a8af0-3cc3f7e214emr5955567637.31.1786549400742; 
 Wed, 12 Aug 2026 08:43:20 -0700 (PDT)
X-Received: by 2002:a05:6a20:734b:b0:3c0:b766:74f4 with SMTP id
 adf61e73a8af0-3cc3f7e214emr5955509637.31.1786549400247; 
 Wed, 12 Aug 2026 08:43:20 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31da7bf64b5sm8121190eec.10.2026.08.12.08.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:43:19 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 29/41] hexagon: group cpu configurations in their own struct
Date: Wed, 12 Aug 2026 08:42:08 -0700
Message-Id: <20260812154220.1029828-30-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
References: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfX3WHqRbnqxhtW
 ZZWoD34tCH4Gtru/KBuFBC6uG+Mp8jvZ8ycUcnCvhguKqzfNicbV+ZBj4lU3bfE6h0dYq3BGdgB
 zH17tMe0fo/+WtSc7g4766yHQ+thcPg=
X-Proofpoint-GUID: -G1cLwYzZIiV2mm_QU_ZTF2qjvvEpA-o
X-Authority-Analysis: v=2.4 cv=fpDsol4f c=1 sm=1 tr=0 ts=6a7c9499 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8
 a=Cawoy3z-aL3jkQ-xqsQA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: -G1cLwYzZIiV2mm_QU_ZTF2qjvvEpA-o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfX+eVG3HU6gY3N
 EvmBsVPSLM0FUYP8aIflq/RDCEwhfOqoe/u6L7I0Djb5y5hTvTqNrrUxuQyE+o6UHkL05xcn0Hu
 lcLWt6424eOigNcfp+uTIEzFek+A6tY5XUG9WEJ/rdJDpta4iTtV/udJv8i+Vq1OYSBOn0igdnQ
 YHcojWljyi3HeR/eDRKljOgsdcIQ7cbekjgHKYtKxVbnKEPNYofhmWr4kQrJmtljSJQNiE43P3C
 JSOFOq+Ot3IwSNdFc4J3/+c4oHf6oj6JzlOYpG6qfI+ZXn7hQgYpFEKvdxkYMjNksrHIm4PD9BI
 GK7Q3wDcljfN0MQfScRXa9lD6tD+lsJpbXvq/A/rF7yPGOi/h/NEkZZPeCa2oggXRwdCC9wuIBy
 jrZXIaE1ZPvxpJoH7mHlXrCwjfVYEEVFHtfVI/pgHDf/a1KzQoov+DQulaaqgW47wtu2yTLl6fz
 OkqX3rH8Whiel+R8VDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120128
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

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPG1hdGhldXMuYmVybmFyZGlub0Bvc3Mu
cXVhbGNvbW0uY29tPgoKVGhpcyB3aWxsIGJlIHVzZWQgaW4gYSBmb2xsb3cgdXAgY29tbWl0LgoK
UmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNp
Z25lZC1vZmYtYnk6IE1hdGhldXMgVGF2YXJlcyBCZXJuYXJkaW5vIDxtYXRoZXVzLmJlcm5hcmRp
bm9Ab3NzLnF1YWxjb21tLmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOp
IDxwaGlsbWRAbGluYXJvLm9yZz4KUmV2aWV3ZWQtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5A
b3NzLnF1YWxjb21tLmNvbT4KTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZl
bC84ZjlhMmUyY2NmZDJlZWRhNzNhNjNkMWE2YWJiZmQ2ZTU0NThiNDRjLjE3NzYzMzk0NTEuZ2l0
Lm1hdGhldXMuYmVybmFyZGlub0Bvc3MucXVhbGNvbW0uY29tClNpZ25lZC1vZmYtYnk6IEJyaWFu
IENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9j
cHUuaCAgICAgICB8IDEwICsrKy0tLS0tLS0KIHRhcmdldC9oZXhhZ29uL2NwdV9iaXRzLmggIHwg
IDcgKysrKysrKwogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICAgfCAxNCArKysrKysrLS0tLS0t
LQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgfCAgNiArKystLS0KIDQgZmlsZXMgY2hhbmdl
ZCwgMjAgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L2hleGFnb24vY3B1LmggYi90YXJnZXQvaGV4YWdvbi9jcHUuaAppbmRleCA1MDJmMjc5ODNiZS4u
YjBkNzI2YmYwMjIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5oCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL2NwdS5oCkBAIC0xODYsMTUgKzE4NiwxMyBAQCB0eXBlZGVmIHN0cnVjdCBIZXhh
Z29uQ1BVQ2xhc3MgewogICAgIGNvbnN0IEhleGFnb25DUFVEZWYgKmhleF9kZWY7CiB9IEhleGFn
b25DUFVDbGFzczsKIAorI2luY2x1ZGUgImNwdV9iaXRzLmgiCisKIHN0cnVjdCBBcmNoQ1BVIHsK
ICAgICBDUFVTdGF0ZSBwYXJlbnRfb2JqOwogCiAgICAgQ1BVSGV4YWdvblN0YXRlIGVudjsKLQot
ICAgIGJvb2wgbGxkYl9jb21wYXQ7Ci0gICAgdGFyZ2V0X3Vsb25nIGxsZGJfc3RhY2tfYWRqdXN0
OwotICAgIGJvb2wgc2hvcnRfY2lyY3VpdDsKLSAgICBib29sIGllZWVfZnBfZXh0ZW5zaW9uOwor
ICAgIEhleGFnb25DUFVDb25maWcgY2ZnOwogI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCiAgICAg
SGV4YWdvblRMQlN0YXRlICp0bGI7CiAgICAgdWludDMyX3QgYm9vdF9hZGRyOwpAQCAtMjA0LDgg
KzIwMiw2IEBAIHN0cnVjdCBBcmNoQ1BVIHsKICNlbmRpZgogfTsKIAotI2luY2x1ZGUgImNwdV9i
aXRzLmgiCi0KIEZJRUxEKFRCX0ZMQUdTLCBJU19USUdIVF9MT09QLCAwLCAxKQogRklFTEQoVEJf
RkxBR1MsIE1NVV9JTkRFWCwgMSwgMykKIEZJRUxEKFRCX0ZMQUdTLCBQQ1lDTEVfRU5BQkxFRCwg
NCwgMSkKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdV9iaXRzLmggYi90YXJnZXQvaGV4
YWdvbi9jcHVfYml0cy5oCmluZGV4IDE2NGU3NGM3ODJiLi43OTdlY2FiY2E5MiAxMDA2NDQKLS0t
IGEvdGFyZ2V0L2hleGFnb24vY3B1X2JpdHMuaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHVfYml0
cy5oCkBAIC0yMSw2ICsyMSwxMyBAQAogI2luY2x1ZGUgInFlbXUvYml0b3BzLmgiCiAjaW5jbHVk
ZSAiY3B1LXFvbS5oIgogCit0eXBlZGVmIHN0cnVjdCBIZXhhZ29uQ1BVQ29uZmlnIHsKKyAgICBi
b29sIGxsZGJfY29tcGF0OworICAgIHVpbnQzMl90IGxsZGJfc3RhY2tfYWRqdXN0OworICAgIGJv
b2wgc2hvcnRfY2lyY3VpdDsKKyAgICBib29sIGllZWVfZnBfZXh0ZW5zaW9uOworfSBIZXhhZ29u
Q1BVQ29uZmlnOworCiAjZGVmaW5lIFBDQUxJR04gNAogI2RlZmluZSBQQ0FMSUdOX01BU0sgKFBD
QUxJR04gLSAxKQogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3RhcmdldC9o
ZXhhZ29uL2NwdS5jCmluZGV4IGYyNTg3OGNkNjcwLi4zYmMyYTJlZmE5NyAxMDA2NDQKLS0tIGEv
dGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTcxLDEx
ICs3MSwxMSBAQCBzdGF0aWMgY29uc3QgUHJvcGVydHkgaGV4YWdvbl9jcHVfcHJvcGVydGllc1td
ID0gewogICAgICAgICBUWVBFX0hFWEFHT05fR0xPQkFMUkVHLCBIZXhhZ29uR2xvYmFsUmVnU3Rh
dGUgKiksCiAgICAgREVGSU5FX1BST1BfVUlOVDMyKCJodGlkIiwgSGV4YWdvbkNQVSwgaHRpZCwg
MCksCiAjZW5kaWYKLSAgICBERUZJTkVfUFJPUF9CT09MKCJsbGRiLWNvbXBhdCIsIEhleGFnb25D
UFUsIGxsZGJfY29tcGF0LCBmYWxzZSksCi0gICAgREVGSU5FX1BST1BfVU5TSUdORUQoImxsZGIt
c3RhY2stYWRqdXN0IiwgSGV4YWdvbkNQVSwgbGxkYl9zdGFja19hZGp1c3QsIDAsCi0gICAgICAg
ICAgICAgICAgICAgICAgICAgcWRldl9wcm9wX3VpbnQzMiwgdGFyZ2V0X3Vsb25nKSwKLSAgICBE
RUZJTkVfUFJPUF9CT09MKCJzaG9ydC1jaXJjdWl0IiwgSGV4YWdvbkNQVSwgc2hvcnRfY2lyY3Vp
dCwgdHJ1ZSksCi0gICAgREVGSU5FX1BST1BfQk9PTCgiaWVlZS1mcCIsIEhleGFnb25DUFUsIGll
ZWVfZnBfZXh0ZW5zaW9uLCB0cnVlKSwKKyAgICBERUZJTkVfUFJPUF9CT09MKCJsbGRiLWNvbXBh
dCIsIEhleGFnb25DUFUsIGNmZy5sbGRiX2NvbXBhdCwgZmFsc2UpLAorICAgIERFRklORV9QUk9Q
X1VOU0lHTkVEKCJsbGRiLXN0YWNrLWFkanVzdCIsIEhleGFnb25DUFUsIGNmZy5sbGRiX3N0YWNr
X2FkanVzdCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAwLCBxZGV2X3Byb3BfdWludDMyLCB0
YXJnZXRfdWxvbmcpLAorICAgIERFRklORV9QUk9QX0JPT0woInNob3J0LWNpcmN1aXQiLCBIZXhh
Z29uQ1BVLCBjZmcuc2hvcnRfY2lyY3VpdCwgdHJ1ZSksCisgICAgREVGSU5FX1BST1BfQk9PTCgi
aWVlZS1mcCIsIEhleGFnb25DUFUsIGNmZy5pZWVlX2ZwX2V4dGVuc2lvbiwgdHJ1ZSksCiB9Owog
CiBjb25zdCBjaGFyICogY29uc3QgaGV4YWdvbl9yZWduYW1lc1tUT1RBTF9QRVJfVEhSRUFEX1JF
R1NdID0gewpAQCAtMTI3LDcgKzEyNyw3IEBAIGNvbnN0IGNoYXIgKiBjb25zdCBoZXhhZ29uX2dy
ZWduYW1lc1tdID0gewogc3RhdGljIHRhcmdldF91bG9uZyBhZGp1c3Rfc3RhY2tfcHRycyhDUFVI
ZXhhZ29uU3RhdGUgKmVudiwgdGFyZ2V0X3Vsb25nIGFkZHIpCiB7CiAgICAgSGV4YWdvbkNQVSAq
Y3B1ID0gZW52X2FyY2hjcHUoZW52KTsKLSAgICB0YXJnZXRfdWxvbmcgc3RhY2tfYWRqdXN0ID0g
Y3B1LT5sbGRiX3N0YWNrX2FkanVzdDsKKyAgICB0YXJnZXRfdWxvbmcgc3RhY2tfYWRqdXN0ID0g
Y3B1LT5jZmcubGxkYl9zdGFja19hZGp1c3Q7CiAgICAgdGFyZ2V0X3Vsb25nIHN0YWNrX3N0YXJ0
ID0gZW52LT5zdGFja19zdGFydDsKICAgICB0YXJnZXRfdWxvbmcgc3RhY2tfc2l6ZSA9IDB4MTAw
MDA7CiAKQEAgLTIzOSw3ICsyMzksNyBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2R1bXAoQ1BVSGV4
YWdvblN0YXRlICplbnYsIEZJTEUgKmYsIGludCBmbGFncykKIHsKICAgICBIZXhhZ29uQ1BVICpj
cHUgPSBlbnZfYXJjaGNwdShlbnYpOwogCi0gICAgaWYgKGNwdS0+bGxkYl9jb21wYXQpIHsKKyAg
ICBpZiAoY3B1LT5jZmcubGxkYl9jb21wYXQpIHsKICAgICAgICAgLyoKICAgICAgICAgICogV2hl
biBjb21wYXJpbmcgd2l0aCBMTERCLCBpdCBkb2Vzbid0IHN0ZXAgdGhyb3VnaCBzaW5nbGUtY3lj
bGUKICAgICAgICAgICogaGFyZHdhcmUgbG9vcHMgdGhlIHNhbWUgd2F5LiAgU28sIHdlIGp1c3Qg
c2tpcCB0aGVtIGhlcmUKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIGIv
dGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKaW5kZXggNThjODRkZjY2ZWMuLjA2YTgxNTlkMjgz
IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYworKysgYi90YXJnZXQvaGV4
YWdvbi90cmFuc2xhdGUuYwpAQCAtMTIwOSw5ICsxMjA5LDkgQEAgc3RhdGljIHZvaWQgaGV4YWdv
bl90cl9pbml0X2Rpc2FzX2NvbnRleHQoRGlzYXNDb250ZXh0QmFzZSAqZGNiYXNlLAogICAgIGN0
eC0+bnVtX2h2eF9pbnNucyA9IDA7CiAgICAgY3R4LT5icmFuY2hfY29uZCA9IFRDR19DT05EX05F
VkVSOwogICAgIGN0eC0+aXNfdGlnaHRfbG9vcCA9IEZJRUxEX0VYMzIoaGV4X2ZsYWdzLCBUQl9G
TEFHUywgSVNfVElHSFRfTE9PUCk7Ci0gICAgY3R4LT5zaG9ydF9jaXJjdWl0ID0gaGV4X2NwdS0+
c2hvcnRfY2lyY3VpdDsKKyAgICBjdHgtPnNob3J0X2NpcmN1aXQgPSBoZXhfY3B1LT5jZmcuc2hv
cnRfY2lyY3VpdDsKICAgICBjdHgtPmhleF9kZWYgPSBIRVhBR09OX0NQVV9HRVRfQ0xBU1MoaGV4
X2NwdSktPmhleF9kZWY7Ci0gICAgY3R4LT5pZWVlX2ZwX2V4dGVuc2lvbiA9IGhleF9jcHUtPmll
ZWVfZnBfZXh0ZW5zaW9uOworICAgIGN0eC0+aWVlZV9mcF9leHRlbnNpb24gPSBoZXhfY3B1LT5j
ZmcuaWVlZV9mcF9leHRlbnNpb247CiAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKICAgICBjdHgt
Pm51bV9jeWNsZXMgPSAwOwogICAgIGN0eC0+cGN5Y2xlX2VuYWJsZWQgPSBGSUVMRF9FWDMyKGhl
eF9mbGFncywgVEJfRkxBR1MsIFBDWUNMRV9FTkFCTEVEKTsKQEAgLTEyNjgsNyArMTI2OCw3IEBA
IHN0YXRpYyB2b2lkIGhleGFnb25fdHJfdHJhbnNsYXRlX3BhY2tldChEaXNhc0NvbnRleHRCYXNl
ICpkY2Jhc2UsIENQVVN0YXRlICpjcHUpCiAgICAgICAgICAqIHNvIGVuZCB0aGUgVExCIGFmdGVy
IGV2ZXJ5IHBhY2tldC4KICAgICAgICAgICovCiAgICAgICAgIEhleGFnb25DUFUgKmhleF9jcHUg
PSBlbnZfYXJjaGNwdShlbnYpOwotICAgICAgICBpZiAoaGV4X2NwdS0+bGxkYl9jb21wYXQgJiYg
cWVtdV9sb2dsZXZlbF9tYXNrKENQVV9MT0dfVEJfQ1BVKSkgeworICAgICAgICBpZiAoaGV4X2Nw
dS0+Y2ZnLmxsZGJfY29tcGF0ICYmIHFlbXVfbG9nbGV2ZWxfbWFzayhDUFVfTE9HX1RCX0NQVSkp
IHsKICAgICAgICAgICAgIGN0eC0+YmFzZS5pc19qbXAgPSBESVNBU19UT09fTUFOWTsKICAgICAg
ICAgfQogICAgIH0KLS0gCjIuMzQuMQoK

