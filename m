Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0F9606A32E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 01:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=F+X9x53D;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f7iDeefq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4SQ-0003ug-WB; Thu, 22 Oct 2026 21:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4Rn-0002SX-LW
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:51:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4Rl-0006QX-Mp
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:51:55 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N1ErhS772827
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:51:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EYDXHpper7kq7feUcXjc3Ekpr9bgCb8ycrVHhM+7ovY=; b=F+X9x53Dx3AtGTym
 WpKWqLcwQ7l24dZKhaSmk5K1TLMTiwm9OaaPhtom0Z/RCDmYA5aP7z8Yp9RawYld
 s18SWdz43+EqLhk72KJHZXQLbcEHsVgFU+RCKgyThNMdq4rdn8GB5zgArwjBFR1c
 oqe4Rv1gVjDQqBK5+D0XrM9X+xAxEzNRd+pP9/XidPchUkKix2JhyB3nNc8bRnLi
 +vgZBv1oSBbBe0lZe9Qn5zQ8SJCySRof3Poq/qQL7y6HeFsWMRoPC8a2jjmHO3Nk
 ptvUPf/GdOAhoZWjY4l+zGeIKiLjID0ju2+Cel86ZGBEplse10OVOVpbgaziC2U+
 NgkB3w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmtsbv7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:51:42 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35a04491c56so317910eec.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792720302; x=1793325102; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EYDXHpper7kq7feUcXjc3Ekpr9bgCb8ycrVHhM+7ovY=;
 b=f7iDeefqCJeIDzCa7QGRB/pI0Twgn45Gta1QwXOUOKXZ2ADLZcuu6DHbfkPt2MZWyr
 Bsoo+zHb0lFd+Hhq4z2DOdNLRVfc1H/t5AVPoS7l6NRtE9Z7OhswKJppcJjlIFyc25H7
 1MUKtJItiAViwQZ1mpzJ+sZCZnTLRhXKwvfsOxwuuSDpqDp7nc9kG44SlDvkFf931y6G
 /936E5kwDmjn9hwKMtlpCG9ZXL56BjWtsDxwmRwCCQq4ODIFJ6p5sGQ32a2o2bCK0h/d
 EvR39sh2WY8HjZfe6GxWTUqvpNYyeJ9QlklR4bUtf8sjAJIA0TXmS+DKBKnYPqxQY8Jd
 zS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792720302; x=1793325102;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EYDXHpper7kq7feUcXjc3Ekpr9bgCb8ycrVHhM+7ovY=;
 b=DtI5VdNh04L/vESitUORJ4GTUsZWeS1GpKFp07yet3rHvs7SO2Gm9iWnix4qjL3sXS
 8pDhJLICTgcEXMcuqGa5vyW8+XnOsmdxTEj8Ke0UQWP0VRbwd6PXP507DxxTwR87VGps
 VqUZe4kJJIv2U9h3s53JGRNALhGsnhCNKCRNYEGZ0S2L6hN5ZMXl6WGspmUI1gHIKVQg
 Fc4O/7OWpzHnb2jpfE8XapO2CZ+rwfWjd3PUJnIA85iaRmKlrDAP1a0bOQENg5d53ggU
 pYZRWXM90nqjwbo/gbWrO0g9VPZ0YVCKz8OEUqq6+Bb9So1MPemhaVevda5v4yAyd0t8
 EEng==
X-Gm-Message-State: AFq9FYKqitn+/hcrbpkfKxPHmu15HJMWMCCoovWhA7m04XOeNZCaMZkc
 7nkkxKw0DixQRW8wKNxRE4ePXGZwROixaRqzhYvaD1LygZA3gcKolndwk/zkI9qZt9BZQaZtsvF
 e3txq28InPjN9VVwKJ0fTN0h+ERY4hrTStAkbQKMy2GPszbod3Ih0YNQRspeNBwvclQ==
X-Gm-Gg: AYBFou3tVPQfYNTQrngfzjWY+uqVMsKoYLxymBx1+wjV5U9rzqxP5a/Kev0Cu98P1Zs
 8SrG61SZkDob6M3apk66BZGB0+ki7FWvaYr0empgBviV8nCzULf1P9einSvxQHCLOPQPgi3G0Wd
 Zn3UVCBDUIHUXqTgLNUY5ILeYRYjTsaUfxyY2DXGKKx9vKLJZ9/oAHJj9nLElrB9CSWjQmTjDRL
 x4P0KFqR6fNQF9Lzhdy4xhVBCE24c6gK2Njk6PZHMT6o7mHFnlp2lkKFgr2q6BDTnGdhg0bzeWF
 xH1fBNjYuhvCYzl6XgEHRJP4dm/UElEAt3bHxnebKLiLZx5ScFuU0LwXkIrKZW/T3wFsZMfXNcE
 3566v7eD9jqfIhRWZMlutLmlrzZWS9nDNMcb0AXHGk3qh+Q4h
X-Received: by 2002:a05:7300:3e95:b0:366:eabf:ad9c with SMTP id
 5a478bee46e88-369d974db62mr899434eec.5.1792720301541; 
 Thu, 22 Oct 2026 18:51:41 -0700 (PDT)
X-Received: by 2002:a05:7300:3e95:b0:366:eabf:ad9c with SMTP id
 5a478bee46e88-369d974db62mr899413eec.5.1792720300898; 
 Thu, 22 Oct 2026 18:51:40 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9d5fadbsm1948565eec.8.2026.10.22.18.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 18:51:40 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 35/43] target/hexagon: assert qfloat shift
Date: Thu, 22 Oct 2026 18:50:32 -0700
Message-Id: <20261023015040.2473105-36-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
References: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6adabdae cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=7yAfEa69Y000KskGGPkA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: jCu-lBesSuevNFkjTfoQSMNjxiS09keU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfXyhwhXWPGDh/Z
 bcewLPPoxaeIYVFLUcZ8gYj0yYyPXgtzu4yZydCZSBE4u0tZRScmGqdcjsop4LFfWpE1ZcQxhTi
 cgocR7OLzryh+tDhvOc49437XKQAt8CUbA75gxL4lgWagGhiM/1F5jX8aTYYrORkB3BOygJ5yJi
 HeTi9HcVIZy4xkIfOXyENszUpIneGBhhWTiNyjH/Vvzd+/euKtmLM40vFMHOItp5fiDKzmrROY7
 g+Qi6rwtSi32RnLpB2xSjw3qL7R9u7BYbha+O40NiH10He4bV6wsxcDVWf5KuKBRKwW2u4ITB3p
 4Y/ies60jJMfdkV1qY/4dHLbOROlOeBF08dRyz+OflgmQ3FjTn9HFcHLTwM+kpZiaCpZkZ4Qsmx
 bRdqxQI3+6M55gtBOMstny7d6JRCTrgMGxXx14WOsw1QuTlJCjUSBT8lxsZ8yEgW84wWqIHFhxq
 vmkHxSP8mquDYZ/fHXg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfX/p9XB2EsH3Kg
 912R8jVLZR61WP1+Iun8dPyEV4Pk3fynQP2DwOnytGfltQIhpfvvoHKqxYNGYVp4D4/m4+JeOmr
 m0S13n74DZlKATQF7xZ1rjA1oCcnQI8=
X-Proofpoint-ORIG-GUID: jCu-lBesSuevNFkjTfoQSMNjxiS09keU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230007
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

VGhlIG1pZHBvaW50IHJvdW5kaW5nIHRocmVzaG9sZHMgc2hpZnQgYnkgInNoaWZ0IC0gMyIsIHdo
aWNoIENvdmVyaXR5IGZsYWdnZWQKYXMgcG90ZW50aWFsIHVuZGVmaW5lZCBiZWhhdmlvci4KClRo
ZSBsZWdhY3kgYWRkIGFuZCBtdWx0aXBseSBwYXRocyBzZWxlY3QgZXhwIHN1Y2ggdGhhdCB0aGUg
bm9ybWFsaXplZCByZXN1bHQKaXMgYXQgbW9zdCBvbmUgYml0IGFib3ZlIGl0LiBXaXRoIHRoZSBs
YXJnZXN0IGxlZ2FjeSBmcmFjdGlvbiB3aWR0aCBvZiAyMyBiaXRzLApzaGlmdCBpcyBhdCBsZWFz
dCA0MS4gIFdlIGNhbiBzYWZlbHkgYXNzZXJ0IHRoaXMgaGVyZS4KCkxpbms6IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvQ0FGRUFjQV9XSi1QWUNmaWl1NDR1VFFpRG9jNThfOUt5
M3VFZC05ZzE0blBnRFBUX19nQG1haWwuZ21haWwuY29tLwpGaXhlczogYjU4ZjQ2NTQ5NjQ5ICgi
dGFyZ2V0L2hleGFnb246IGFkZCB0aGUgUUZsb2F0IGxvZ2ljIikKUmVzb2x2ZXM6IENvdmVyaXR5
IENJRCAxNjg4MjQwClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2
aWVyQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNh
aW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9tbXZlYy9odnhfcWZsb2F0
LmMgfCA1ICsrKysrCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvdGFyZ2V0L2hleGFnb24vbW12ZWMvaHZ4X3FmbG9hdC5jIGIvdGFyZ2V0L2hleGFnb24vbW12
ZWMvaHZ4X3FmbG9hdC5jCmluZGV4IDQxY2M4MjdhYTg3Li4zNDViZGRjZDM2NCAxMDA2NDQKLS0t
IGEvdGFyZ2V0L2hleGFnb24vbW12ZWMvaHZ4X3FmbG9hdC5jCisrKyBiL3RhcmdldC9oZXhhZ29u
L21tdmVjL2h2eF9xZmxvYXQuYwpAQCAtNzIxLDYgKzcyMSwxMSBAQCBzdGF0aWMgaW50NjRfdCBs
ZWdhY3lfcm91bmRfbihGbG9hdFBhcnRzNjQgcGFydHMsIGludCBleHAsIGludCBmcmFjLCBpbnQg
YWRqLAogICAgIH0KIAogICAgIGlmIChtaWRwb2ludCkgeworICAgICAgICAvKgorICAgICAgICAg
KiBUaGUgbGVnYWN5IGFkZC9tdWx0aXBseSByZXN1bHQgaXMgYXQgbW9zdCBvbmUgYml0IGFib3Zl
IGV4cCwKKyAgICAgICAgICogbWFraW5nIHNoaWZ0IGF0IGxlYXN0IDQxLgorICAgICAgICAgKi8K
KyAgICAgICAgZ19hc3NlcnQoc2hpZnQgPj0gNDEpOwogICAgICAgICB0aHJlc2hvbGQgPSBVSU5U
NjRfQygzKSA8PCAoc2hpZnQgLSAzKTsKICAgICAgICAgaWYgKGxvdyA8PSB0aHJlc2hvbGQpIHsK
ICAgICAgICAgICAgIHJldHVybiBiYXNlICsgMTsKLS0gCjIuMzQuMQoK

