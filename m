Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890B1C624DB
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 18:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2uqI-0002rK-Dv; Sat, 05 Sep 2026 14:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uq9-0002mu-PM
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uq8-0001Qq-3F
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:09 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685Hb4Wc2449911
 for <qemu-devel@nongnu.org>; Sat, 5 Sep 2026 18:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0jznzsrL2c1cMANKS+KMYcmou2PNLYP6+Qmd0n2zxjY=; b=fOv68EBwkarus6az
 DUzRok1MyCdFzVJAMY8wt3BvIv9koedQyvGQsr+qAW+LLXdMj3UpCN2lp4uriM7C
 F9Se3WlX1pG+5zcgwr5cOQxhkzwlinGaPlLGuuTbMR++3vidLm7dOlxJFPNbbmgC
 n/w1VYDbiCco9VFaAv8MC7l33BgJzHzueL6yT3EuZuLT1/07sbYoqSJj4hkzT24b
 DZu5LNNGzVAZdArLAOyNgVts9SXlMO2H1C0Rc/RBLSiCeU4akkWDOfzukL3TNjZa
 qKHiLuR+FnzKbIovatYfWrZu+/bK6pfLtcKGpvuRb5i+Cf5ZZiLKc3Bt36e9bkjl
 kKRjWA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggbuehxfs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 18:10:04 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc132709c76so2789885a12.3
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 11:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788631803; x=1789236603; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0jznzsrL2c1cMANKS+KMYcmou2PNLYP6+Qmd0n2zxjY=;
 b=GjvLlUh/dPGdA91mJ+nfA9Z0L4NXdRzqC61OTY1RpqxBTIdZ1ux5Dmn733Z4EiJTSw
 IdF0Iux7zZXZKuiccoTcgE/SeEgLubd5eFwY+J/K+dIiq79rQKs9y8lBuSEm5D0PTjut
 qkDifloePdK5usytisK/wOj/UxZgVg6pXdUKXyytNY+OKAp0MztAkJ3UvpCB2Ch+BMFb
 anyx/dqRH7KwD8U0vdph1GlmAyDCtEoFxHOtUergDEiwPE2krM2U6hqlrQl6WdnQwMHf
 5dPgrX2FHnw1m8pH/bGnjMoKLKxPl63hHntI2CliHXsvmVU9a7DDUe53BhcDrK5SVwuv
 7ZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788631803; x=1789236603;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0jznzsrL2c1cMANKS+KMYcmou2PNLYP6+Qmd0n2zxjY=;
 b=NcrhD4/EkSf97/w6K5JufRaKwClImxiZmZEiYaqvDo97ean01i7aKFL0kuws1A7zWk
 aG2Xcx1iCUIZxBZrWaHJboh3iTRHRuzxTJAu+Kc5eysuT65pTSHk2sSdlX1sK1oDiNvZ
 ACNhUZQ5szr7W7kPWxWoa9wobEMyE5N9lnY0P1V/XYS39GAoIuaXMcj537nKxeVNQSyz
 1pt/OQ2dwXaKKPOOllkkksMxE4VxKIDnK7lucjYL0ZyJNUp1fmvghLaFSZqxWbfBbSYa
 vEieMABHXQvBnQwpBsA970bt5Xnpc2Ygh3Ge/OuDqglKNsEpykRKx9AG4jLTVne5Qwav
 dMhA==
X-Gm-Message-State: AFuF++l9LVKb32EEBatKilVcQdd2KSxwij+cvFi4Uzso+aVHc+Zq4+rW
 0ci73nJuquapl2X6HjftVjBapN0vHjqyR3MmVkVQeI9170NrufGpve3MVov6SEu4vfWWfpNoPWv
 mlIxd5StanRGzJyByNvYRUAGq7VdG7Cowy3RvspqW4Nwf+9I249s6422c7GQzbuFKbg==
X-Gm-Gg: AYBFou3abec349QGfX9h9XLFYrmtVYX6nuabEVthMGeMxspv/GODZHYT7U9jF07Hsij
 MLib+Jtz8MLAkwvx/bjJxE5BEwVVpSAMeA8X6ev7tGk1W4xLgiUmYpGiT8Yu+Q+dqvmsyfpy6Od
 x+vUEKh4Cn3Zb3rRzmpNfRfDkamYnp2/wR3wWzJ3YvUd4ELT8DBxV3rFdKTI7HhkhCUgngfGKKR
 /KOeq+prAGscSxRgggc2ISA3eisVWDLUif+uZzJetj0My1p2CPeLOZNGvfu4CMhjuPb3/APufML
 zTrMlr1YK19XjJIx1qIKBXg50ivV8eGh0/vvcN+9RKHUk0GxCDpDxmx8qtB7b6Wz4HT0JmaS+bA
 zLggWUzQ5lpvVzPIdefxSLVjmx5Zq7LxVf0OFNmsFQNzMsWlo
X-Received: by 2002:a05:6a21:2983:b0:3cc:8f53:26c0 with SMTP id
 adf61e73a8af0-3da3a03ccf1mr22742956637.17.1788631803334; 
 Sat, 05 Sep 2026 11:10:03 -0700 (PDT)
X-Received: by 2002:a05:6a21:2983:b0:3cc:8f53:26c0 with SMTP id
 adf61e73a8af0-3da3a03ccf1mr22742895637.17.1788631802851; 
 Sat, 05 Sep 2026 11:10:02 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339a534df1sm17985505eec.7.2026.09.05.11.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 11:09:59 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, sid.manning@oss.qualcomm.com
Subject: [PATCH 05/17] tests/tcg/multiarch: suppress UBSan for float-to-int
 conversions
Date: Sat,  5 Sep 2026 11:09:37 -0700
Message-Id: <20260905180949.1852673-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
References: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfX3na8VeG0B4F0
 GlBkbi0YpGGql9eOd7mMlcI6NKpPw3CqmmWf1DlLqLJz0U09SMthMMFWUOJ1QM9DNX76QDeTQxu
 JNJw33i5JlauSQJ7V0yDf/ia5qcSjSpitjD1av/JQcgcbuRGA4nKxtM1kn8UT7fXqfLbN2+qydX
 cezFQylDuEOYdABvkirRw4mXbBfhfxkc8yJHZFuZsB/jdmpNBn+227wMEa92XzJPwp876Zedu37
 nj9wLmxNo+HCvBInTMxmH6808cYqapkoaX9KXSAdfEzq4udwVj/FPeeqRv3y8gQ0HmS2H+oB9QG
 /fOzW5SVFdmjJ/Tvv01Two/5IOTe3ddKHAL5S4xNvnh/1KOjYzh+oo1meji/tyjt3IpDsWTLWAk
 oYsDcfb3TveFZOZqNvuTKKoy1QkhYvXioyzl/1oI89GpeMYq3WPxABqO41UdIywZnJiJ3FG8yRg
 vT2t+NG+0ZQGZ4mTUYg==
X-Authority-Analysis: v=2.4 cv=P8AKQCAu c=1 sm=1 tr=0 ts=6a9c5afc cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=mocapJ0rodF7YK2GbI0A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: B2U_cQgTJpD3sF5K623Pplim2m1I5xAa
X-Proofpoint-ORIG-GUID: B2U_cQgTJpD3sF5K623Pplim2m1I5xAa
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfX59FxGeHiHzAd
 vEagI1OtG7aV4ilD4XelqOVYVcieCHhmzAMIRVHCaJrvqhJ38vYktjtulDTeR0/x6hN7WJuljhm
 ypUhspq3ufXVov+RkZsgulV3Y7Eo7nY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 adultscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609050201
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

QWRkIF9fYXR0cmlidXRlX18oKG5vX3Nhbml0aXplKCJ1bmRlZmluZWQiKSkpIHRvIHRoZSBmbG9h
dC9kb3VibGUKdG8gaW50ZWdlciBjb252ZXJzaW9uIGZ1bmN0aW9ucy4KCkMxNyA2LjMuMS40cDEg
b25seSBkZWZpbmVzIGZsb2F0LXRvLWludGVnZXIgY29udmVyc2lvbiBmb3IgZmluaXRlCnZhbHVl
cyB3aG9zZSBpbnRlZ3JhbCBwYXJ0IGZpdHMgaW4gdGhlIGRlc3RpbmF0aW9uIHR5cGU7IGl0IGRp
c2NhcmRzCnRoZSBmcmFjdGlvbmFsIHBhcnQgYW5kIGV4cGxpY2l0bHkgbWFrZXMgaXQgVUIgaWYg
dGhlIGludGVncmFsIHBhcnQKZG9lc24ndCBmaXQuCgpUaGVzZSB0ZXN0cyBpbnRlbnRpb25hbGx5
IGV4ZXJjaXNlIGJvdGggb2YgdGhvc2UgVUIgY2FzZXMsIHNvIHdlJ2xsIHN1cHByZXNzCml0IHRv
IGdldCBhIGNsZWFuIHVic2FuIHJ1biBvbiB0aGUgVENHIHRlc3Qgc3VpdGUuCgpTaWduZWQtb2Zm
LWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGVzdHMv
dGNnL211bHRpYXJjaC9mbG9hdF9jb252ZC5jIHwgMSArCiB0ZXN0cy90Y2cvbXVsdGlhcmNoL2Zs
b2F0X2NvbnZzLmMgfCAxICsKIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvdGVzdHMvdGNnL211bHRpYXJjaC9mbG9hdF9jb252ZC5jIGIvdGVzdHMvdGNnL211
bHRpYXJjaC9mbG9hdF9jb252ZC5jCmluZGV4IDU4ZDdmOGI0YzU4Li5jYjM4ODRkZjk3NCAxMDA2
NDQKLS0tIGEvdGVzdHMvdGNnL211bHRpYXJjaC9mbG9hdF9jb252ZC5jCisrKyBiL3Rlc3RzL3Rj
Zy9tdWx0aWFyY2gvZmxvYXRfY29udmQuYwpAQCAtNjIsNiArNjIsNyBAQCBzdGF0aWMgdm9pZCBj
b252ZXJ0X2RvdWJsZV90b19zaW5nbGUoZG91YmxlIGlucHV0KQogI2RlZmluZSBzdHIoYSkgI2EK
IAogI2RlZmluZSBDT05WRVJUX0RPVUJMRV9UT19JTlQoVFlQRSwgRk1UKSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBcCisgICAgX19hdHRyaWJ1dGVfXygobm9fc2FuaXRpemUoInVuZGVmaW5l
ZCIpKSkgICAgICAgICAgICAgICAgICAgICAgIFwKICAgICBzdGF0aWMgdm9pZCBjb252ZXJ0X2Rv
dWJsZV90b18gIyMgVFlQRShkb3VibGUgaW5wdXQpICAgICAgICAgICAgXAogICAgIHsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBc
CiAgICAgICAgIFRZUEUgIyMgX3Qgb3V0cHV0OyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFwKZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9tdWx0aWFyY2gvZmxvYXRfY29u
dnMuYyBiL3Rlc3RzL3RjZy9tdWx0aWFyY2gvZmxvYXRfY29udnMuYwppbmRleCBjYjFmZGQ0Mzll
My4uNTg0Y2U4OWFhMTcgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3RjZy9tdWx0aWFyY2gvZmxvYXRfY29u
dnMuYworKysgYi90ZXN0cy90Y2cvbXVsdGlhcmNoL2Zsb2F0X2NvbnZzLmMKQEAgLTYyLDYgKzYy
LDcgQEAgc3RhdGljIHZvaWQgY29udmVydF9zaW5nbGVfdG9fZG91YmxlKGZsb2F0IGlucHV0KQog
I2RlZmluZSBzdHIoYSkgI2EKIAogI2RlZmluZSBDT05WRVJUX1NJTkdMRV9UT19JTlQoVFlQRSwg
Rk1UKSAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCisgICAgX19hdHRyaWJ1dGVfXygobm9f
c2FuaXRpemUoInVuZGVmaW5lZCIpKSkgICAgICAgICAgICAgICAgICAgICAgIFwKICAgICBzdGF0
aWMgdm9pZCBjb252ZXJ0X3NpbmdsZV90b18gIyMgVFlQRShmbG9hdCBpbnB1dCkgICAgICAgICAg
ICAgXAogICAgIHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBcCiAgICAgICAgIFRZUEUgIyMgX3Qgb3V0cHV0OyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKLS0gCjIuMzQuMQoK

