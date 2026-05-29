Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40274CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 22:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5F7-0008IQ-Si; Fri, 29 May 2026 17:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5F6-00089E-56
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:59:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5F4-0001EU-30
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:59:47 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TJZrsq4123936
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=yWV8JyiPbjIQ6wQYmC6LoK8Ei8xlWzJUcneEu7w0zbE=; b=UQ
 RtQoSm84n517/BId8KXrltfUW7N120K6pW5pIITmc7ss6pffIkDbZHdAIspDr6MB
 2k4AV8xArz5ALBnhEro1uMidgmh98ENYhtm8BYTyG1WTgKTI3vShgomD5HVhiRXa
 R1AwqJN5nhrsKkOqmV65tkVBsV0zzGkcM4rye62JUTemwH6UVZsqHqXU+z4gazz8
 UL0wzYL7KxlfJmhNKYmYJLND8E/xryHtMZC6gQ71qYtgjhNsqtQMf9Iprpp4F+8c
 4zh00grp3Hrh83fSMxaSUsXCOHHUgrBX4DhZxWQOnS6VM9NRiy8Lszw27e83wSvJ
 iu7jeatf3Ks5ZkZ3Cejg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efh3n8g8v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:59:44 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304c652be4eso1952518eec.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091984; x=1780696784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yWV8JyiPbjIQ6wQYmC6LoK8Ei8xlWzJUcneEu7w0zbE=;
 b=GneikJvJYrZCji/8Q21J244F76s8hLJZiJNETG8c+DG8TSq/weBMScYAJee062djRH
 N4Jn6mmpwuVHWkGNVSEsiZhLPi2MwOHgws+k0ic19/bGTHZddRnfFzwX9FcCA8x5GaYN
 dDzs+OspTDQjmNl0J0REIFkhlx0PKnaj31l6jF/Oqir5unC5tpmQGbcswgrNugJjgCbX
 KOjRnpRagealRGq2ULAuIClSg+YKvMN53NIzZlTPEyRk42qADFQYMS17x/9RCT9iHf4g
 prW38iQjEwAr3DUH+RrBEkFDPnMyZFp/ruxwvwCARBEJPMuUzZYouk8cKsi5zBDNTGkf
 /dBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091984; x=1780696784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yWV8JyiPbjIQ6wQYmC6LoK8Ei8xlWzJUcneEu7w0zbE=;
 b=OHZb6/zUSwmeYN7Oi67F6ssIXZQCH6ChnksPsKF+7e2rvPaY+YLfV+srfnHApOlzZ4
 V26dngh0l9b3E9CI1a4y/5KHFNjjt+F/gYUT4YfpVoxzmpk/V/4H31ozDhnN7rf6RGYY
 yBvZ8sCWfiKLxdVdKjtmp2ssz6yLHAgw3LWalkkJ9c+tiZgokSDYY4+xiySoa5dBE7a3
 tLTywYjwriXULClHCKV7ljhB4RAKSgcAyru/9BZIoubiWPnvRnlmCs7WnVUKQXbh0/oT
 mD0g5g4U1q+WR8rHBAiaTmeAzYpF6ReUO1YZwBE194x8vWSPRGB0AUUm018U16oVW0QU
 eTig==
X-Gm-Message-State: AOJu0YxSGD30dHAcyB/VfTGhqWRDKulYZOGwAuz7dtTcwIFV1sNnk43z
 5z1/9JHgrwC1bxxjuHhgan05qkmfh+VFkPFawaeSFUdCtoFqDyZspbsuApv1wf9Z8Aw6Wv114rs
 +xJpA53FwvI0P/Ly/V5gKvidmoORYdUDHybtikfMdkUXxSX4FUVkun7V55dIelwn8AA==
X-Gm-Gg: Acq92OE2e9VB+XNO1eIuhRcdx4YjKtj/bYNHpQBQ119IGs9In1egUQnLX8f/kUHIiKQ
 uIzH0NxX65oBtxchgZ5jVo8HHde1FSXfCtGRchYWSozvZiHTsYSwdNmO0XZk9NXtdgLOvdxDxx6
 6axgBZSejiKwH8j0vWJpc8oJy8PHWdeucvpZq6gql/jwrkCwJ4zDzcoyeiMjGrqf8piGDTeQhOC
 zAfkh4iPDOcl4dI31yto//vUssZsLDMvg7/CajgRqNdViHnmVmQmisAiv/Ml4Ry3k/MAKaAFVjl
 owbvb1ItoUpi4B6fjgPvknt0/HLB2D91WIqJ9FVfBsJ6PAHJRBcH4PFKEc9C0F0F+lljAOzkath
 1aS8DvrYcVhJXnkn6rvpII0RWn24q4J8L33/rBC8Z0nWJeTeAEWZ3JkUOlnmmREX+CuLxn5G1z3
 kE81nq
X-Received: by 2002:a05:7022:2221:b0:136:4bbe:9524 with SMTP id
 a92af1059eb24-137ae61dbe5mr2064304c88.10.1780091983936; 
 Fri, 29 May 2026 14:59:43 -0700 (PDT)
X-Received: by 2002:a05:7022:2221:b0:136:4bbe:9524 with SMTP id
 a92af1059eb24-137ae61dbe5mr2064282c88.10.1780091983363; 
 Fri, 29 May 2026 14:59:43 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137b3c69c0asm2101445c88.11.2026.05.29.14.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:59:42 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v6 2/9] hw/hexagon: Add global register tracing
Date: Fri, 29 May 2026 14:59:30 -0700
Message-Id: <20260529215937.610229-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215937.610229-1-brian.cain@oss.qualcomm.com>
References: <20260529215937.610229-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=RcCgzVtv c=1 sm=1 tr=0 ts=6a1a0c50 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=8QmChvNvioVktlEtA_0A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfXz1//EngyS2TU
 c5i3iidY65CMUr5/H7JuypJBa4EYUtXVIABtovpIHQqXD27AAZHHESOGL64sKjyjU4UxL69maQn
 88NhhbX7LO/TznZGMqzZ0+Ae3sCe5a4CWqdpjrS2A1VCRhQ1ESRp9us0WPCmOZlwOyHH7B5XR9P
 nHPbcIEAzl24YYi0AdyQtNyOU3t3VQEz5iTqW7wKrKjwcAGKiqd7HR/bW1kVUD+SjPSFzdks2dY
 KSMMw8Y8LyumI/TkRVm04sdQ2MUOOK5RHhWeS7rJZkniYmUzvUe4NUWspUyRqDUryoq5s+NYcQ4
 TUVD6imubSp5M1i0dNtAoPdV5IsD6trvz6Fjpa1E4rtPcMrHpdagT4yUcivnNy5YE6171818ous
 AIL57QyUPojRqoHG/fUFzZN0R0mppClSW5xgn8H5LmC5UTf47qdgynqKC9mj3KqalZlCJ9T92Dp
 2kJFCGW2D/psm+qOhow==
X-Proofpoint-ORIG-GUID: SiueorSbPUr7zo5oq0JNBUS0meAxVDjM
X-Proofpoint-GUID: SiueorSbPUr7zo5oq0JNBUS0meAxVDjM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290219
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

UmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4K
U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIG1lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICB8ICAxICsKIGh3L2hleGFnb24vdHJh
Y2UuaCAgICAgICAgICAgICB8ICAyICsKIGh3L2hleGFnb24vaGV4YWdvbl9nbG9iYWxyZWcuYyB8
IDczICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIGh3L2hleGFnb24vdHJhY2Ut
ZXZlbnRzICAgICAgICB8ICAzICsrCiA0IGZpbGVzIGNoYW5nZWQsIDc5IGluc2VydGlvbnMoKykK
IGNyZWF0ZSBtb2RlIDEwMDY0NCBody9oZXhhZ29uL3RyYWNlLmgKIGNyZWF0ZSBtb2RlIDEwMDY0
NCBody9oZXhhZ29uL3RyYWNlLWV2ZW50cwoKZGlmZiAtLWdpdCBhL21lc29uLmJ1aWxkIGIvbWVz
b24uYnVpbGQKaW5kZXggZWIwNzQ5MTgxOTMuLjg0YjM5NjgyYzdhIDEwMDY0NAotLS0gYS9tZXNv
bi5idWlsZAorKysgYi9tZXNvbi5idWlsZApAQCAtMzU5OSw2ICszNTk5LDcgQEAgaWYgaGF2ZV9z
eXN0ZW0KICAgICAnaHcvZGlzcGxheScsCiAgICAgJ2h3L2RtYScsCiAgICAgJ2h3L2ZzaScsCisg
ICAgJ2h3L2hleGFnb24nLAogICAgICdody9oeXBlcnYnLAogICAgICdody9pMmMnLAogICAgICdo
dy9pM2MnLApkaWZmIC0tZ2l0IGEvaHcvaGV4YWdvbi90cmFjZS5oIGIvaHcvaGV4YWdvbi90cmFj
ZS5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwLi45ZTBiMzlmM2M2Ngot
LS0gL2Rldi9udWxsCisrKyBiL2h3L2hleGFnb24vdHJhY2UuaApAQCAtMCwwICsxLDIgQEAKKy8q
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyICovCisjaW5jbHVkZSAi
dHJhY2UvdHJhY2UtaHdfaGV4YWdvbi5oIgpkaWZmIC0tZ2l0IGEvaHcvaGV4YWdvbi9oZXhhZ29u
X2dsb2JhbHJlZy5jIGIvaHcvaGV4YWdvbi9oZXhhZ29uX2dsb2JhbHJlZy5jCmluZGV4IDI4Y2I1
YTQxNThkLi5iNWU1OTEzNTA3ZSAxMDA2NDQKLS0tIGEvaHcvaGV4YWdvbi9oZXhhZ29uX2dsb2Jh
bHJlZy5jCisrKyBiL2h3L2hleGFnb24vaGV4YWdvbl9nbG9iYWxyZWcuYwpAQCAtMTYsMTEgKzE2
LDgyIEBACiAjaW5jbHVkZSAidGFyZ2V0L2hleGFnb24vY3B1LmgiCiAjaW5jbHVkZSAidGFyZ2V0
L2hleGFnb24vaGV4X3JlZ3MuaCIKICNpbmNsdWRlICJxZW11L2xvZy5oIgorI2luY2x1ZGUgInRy
YWNlLmgiCiAjaW5jbHVkZSAicWFwaS9lcnJvci5oIgogCiAjZGVmaW5lIElNTVVUQUJMRSAofjAp
CiAjZGVmaW5lIElOVkFMSURfUkVHX1ZBTCAweGRlYWRiZWVmCiAKK3N0YXRpYyBjb25zdCBjaGFy
ICpoZXhfc3JlZ19uYW1lc1tdID0geworICAgIFtIRVhfU1JFR19TR1AwXSA9ICJzZ3AwIiwKKyAg
ICBbSEVYX1NSRUdfU0dQMV0gPSAic2dwMSIsCisgICAgW0hFWF9TUkVHX1NUSURdID0gInN0aWQi
LAorICAgIFtIRVhfU1JFR19FTFJdID0gImVsciIsCisgICAgW0hFWF9TUkVHX0JBRFZBMF0gPSAi
YmFkdmEwIiwKKyAgICBbSEVYX1NSRUdfQkFEVkExXSA9ICJiYWR2YTEiLAorICAgIFtIRVhfU1JF
R19TU1JdID0gInNzciIsCisgICAgW0hFWF9TUkVHX0NDUl0gPSAiY2NyIiwKKyAgICBbSEVYX1NS
RUdfSFRJRF0gPSAiaHRpZCIsCisgICAgW0hFWF9TUkVHX0JBRFZBXSA9ICJiYWR2YSIsCisgICAg
W0hFWF9TUkVHX0lNQVNLXSA9ICJpbWFzayIsCisgICAgW0hFWF9TUkVHX0dFVkJdID0gImdldmIi
LAorICAgIFtIRVhfU1JFR19FVkJdID0gImV2YiIsCisgICAgW0hFWF9TUkVHX01PREVDVExdID0g
Im1vZGVjdGwiLAorICAgIFtIRVhfU1JFR19TWVNDRkddID0gInN5c2NmZyIsCisgICAgW0hFWF9T
UkVHX0lQRU5EQURdID0gImlwZW5kYWQiLAorICAgIFtIRVhfU1JFR19WSURdID0gInZpZCIsCisg
ICAgW0hFWF9TUkVHX1ZJRDFdID0gInZpZDEiLAorICAgIFtIRVhfU1JFR19CRVNUV0FJVF0gPSAi
YmVzdHdhaXQiLAorICAgIFtIRVhfU1JFR19JRUxdID0gImllbCIsCisgICAgW0hFWF9TUkVHX1ND
SEVEQ0ZHXSA9ICJzY2hlZGNmZyIsCisgICAgW0hFWF9TUkVHX0lBSExdID0gImlhaGwiLAorICAg
IFtIRVhfU1JFR19DRkdCQVNFXSA9ICJjZmdiYXNlIiwKKyAgICBbSEVYX1NSRUdfRElBR10gPSAi
ZGlhZyIsCisgICAgW0hFWF9TUkVHX1JFVl0gPSAicmV2IiwKKyAgICBbSEVYX1NSRUdfUENZQ0xF
TE9dID0gInBjeWNsZWxvIiwKKyAgICBbSEVYX1NSRUdfUENZQ0xFSEldID0gInBjeWNsZWhpIiwK
KyAgICBbSEVYX1NSRUdfSVNEQlNUXSA9ICJpc2Ric3QiLAorICAgIFtIRVhfU1JFR19JU0RCQ0ZH
MF0gPSAiaXNkYmNmZzAiLAorICAgIFtIRVhfU1JFR19JU0RCQ0ZHMV0gPSAiaXNkYmNmZzEiLAor
ICAgIFtIRVhfU1JFR19MSVZFTE9DS10gPSAibGl2ZWxvY2siLAorICAgIFtIRVhfU1JFR19CUktQ
VFBDMF0gPSAiYnJrcHRwYzAiLAorICAgIFtIRVhfU1JFR19CUktQVENGRzBdID0gImJya3B0Y2Zn
MCIsCisgICAgW0hFWF9TUkVHX0JSS1BUUEMxXSA9ICJicmtwdHBjMSIsCisgICAgW0hFWF9TUkVH
X0JSS1BUQ0ZHMV0gPSAiYnJrcHRjZmcxIiwKKyAgICBbSEVYX1NSRUdfSVNEQk1CWElOXSA9ICJp
c2RibWJ4aW4iLAorICAgIFtIRVhfU1JFR19JU0RCTUJYT1VUXSA9ICJpc2RibWJ4b3V0IiwKKyAg
ICBbSEVYX1NSRUdfSVNEQkVOXSA9ICJpc2RiZW4iLAorICAgIFtIRVhfU1JFR19JU0RCR1BSXSA9
ICJpc2RiZ3ByIiwKKyAgICBbSEVYX1NSRUdfUE1VQ05UNF0gPSAicG11Y250NCIsCisgICAgW0hF
WF9TUkVHX1BNVUNOVDVdID0gInBtdWNudDUiLAorICAgIFtIRVhfU1JFR19QTVVDTlQ2XSA9ICJw
bXVjbnQ2IiwKKyAgICBbSEVYX1NSRUdfUE1VQ05UN10gPSAicG11Y250NyIsCisgICAgW0hFWF9T
UkVHX1BNVUNOVDBdID0gInBtdWNudDAiLAorICAgIFtIRVhfU1JFR19QTVVDTlQxXSA9ICJwbXVj
bnQxIiwKKyAgICBbSEVYX1NSRUdfUE1VQ05UMl0gPSAicG11Y250MiIsCisgICAgW0hFWF9TUkVH
X1BNVUNOVDNdID0gInBtdWNudDMiLAorICAgIFtIRVhfU1JFR19QTVVFVlRDRkddID0gInBtdWV2
dGNmZyIsCisgICAgW0hFWF9TUkVHX1BNVVNUSUQwXSA9ICJwbXVzdGlkMCIsCisgICAgW0hFWF9T
UkVHX1BNVUVWVENGRzFdID0gInBtdWV2dGNmZzEiLAorICAgIFtIRVhfU1JFR19QTVVTVElEMV0g
PSAicG11c3RpZDEiLAorICAgIFtIRVhfU1JFR19USU1FUkxPXSA9ICJ0aW1lcmxvIiwKKyAgICBb
SEVYX1NSRUdfVElNRVJISV0gPSAidGltZXJoaSIsCisgICAgW0hFWF9TUkVHX1BNVUNGR10gPSAi
cG11Y2ZnIiwKKyAgICBbSEVYX1NSRUdfUzU5XSA9ICJzNTkiLAorICAgIFtIRVhfU1JFR19TNjBd
ID0gInM2MCIsCisgICAgW0hFWF9TUkVHX1M2MV0gPSAiczYxIiwKKyAgICBbSEVYX1NSRUdfUzYy
XSA9ICJzNjIiLAorICAgIFtIRVhfU1JFR19TNjNdID0gInM2MyIsCit9OworCitzdGF0aWMgY29u
c3QgY2hhciAqZ2V0X3NyZWdfbmFtZSh1aW50MzJfdCByZWcpCit7CisgICAgaWYgKHJlZyA8IEFS
UkFZX1NJWkUoaGV4X3NyZWdfbmFtZXMpICYmIGhleF9zcmVnX25hbWVzW3JlZ10pIHsKKyAgICAg
ICAgcmV0dXJuIGhleF9zcmVnX25hbWVzW3JlZ107CisgICAgfQorICAgIHJldHVybiAiVU5LTk9X
TiI7Cit9CisKIC8qIEdsb2JhbCBzeXN0ZW0gcmVnaXN0ZXIgbXV0YWJpbGl0eSBtYXNrcyAqLwog
c3RhdGljIGNvbnN0IHVpbnQzMl90IGdsb2JhbF9zcmVnX2ltbXV0X21hc2tzW05VTV9TUkVHU10g
PSB7CiAgICAgW0hFWF9TUkVHX0VWQl0gPSAweDAwMDAwMGZmLApAQCAtNzcsNiArMTQ4LDcgQEAg
dWludDMyX3QgaGV4YWdvbl9nbG9iYWxyZWdfcmVhZChIZXhhZ29uR2xvYmFsUmVnU3RhdGUgKnMs
IHVpbnQzMl90IHJlZywKIAogICAgIHZhbHVlID0gcy0+cmVnc1tyZWddOwogCisgICAgdHJhY2Vf
aGV4YWdvbl9nbG9iYWxyZWdfcmVhZChodGlkLCBnZXRfc3JlZ19uYW1lKHJlZyksIHZhbHVlKTsK
ICAgICByZXR1cm4gdmFsdWU7CiB9CiAKQEAgLTg5LDYgKzE2MSw3IEBAIHZvaWQgaGV4YWdvbl9n
bG9iYWxyZWdfd3JpdGUoSGV4YWdvbkdsb2JhbFJlZ1N0YXRlICpzLCB1aW50MzJfdCByZWcsCiAg
ICAgZ19hc3NlcnQocmVnIDwgTlVNX1NSRUdTKTsKICAgICBnX2Fzc2VydChyZWcgPj0gSEVYX1NS
RUdfR0xCX1NUQVJUKTsKICAgICBzLT5yZWdzW3JlZ10gPSB2YWx1ZTsKKyAgICB0cmFjZV9oZXhh
Z29uX2dsb2JhbHJlZ193cml0ZShodGlkLCBnZXRfc3JlZ19uYW1lKHJlZyksIHZhbHVlKTsKIH0K
IAogdWludDMyX3QgaGV4YWdvbl9nbG9iYWxyZWdfbWFza2VkX3ZhbHVlKEhleGFnb25HbG9iYWxS
ZWdTdGF0ZSAqcywgdWludDMyX3QgcmVnLApkaWZmIC0tZ2l0IGEvaHcvaGV4YWdvbi90cmFjZS1l
dmVudHMgYi9ody9oZXhhZ29uL3RyYWNlLWV2ZW50cwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRl
eCAwMDAwMDAwMDAwMC4uNWQ2MjNlZDI1MTYKLS0tIC9kZXYvbnVsbAorKysgYi9ody9oZXhhZ29u
L3RyYWNlLWV2ZW50cwpAQCAtMCwwICsxLDMgQEAKKyMgSGV4YWdvbiBnbG9iYWwgcmVnaXN0ZXIg
YWNjZXNzCitoZXhhZ29uX2dsb2JhbHJlZ19yZWFkKHVpbnQzMl90IGh0aWQsIGNvbnN0IGNoYXIg
KnJlZ19uYW1lLCB1aW50MzJfdCB2YWx1ZSkgImh0aWQ9JXUgcmVnPSVzIHZhbHVlPTB4JXgiCito
ZXhhZ29uX2dsb2JhbHJlZ193cml0ZSh1aW50MzJfdCBodGlkLCBjb25zdCBjaGFyICpyZWdfbmFt
ZSwgdWludDMyX3QgdmFsdWUpICJodGlkPSV1IHJlZz0lcyB2YWx1ZT0weCV4IgotLSAKMi4zNC4x
Cgo=

