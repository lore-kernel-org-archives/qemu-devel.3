Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA968C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuB7Q-0005Qn-HL; Wed, 12 Aug 2026 11:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB72-0004nh-U8
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:43:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB71-0000N7-D1
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:43:28 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CDcalB104593
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W6c6LZ+jwSWDITdL6eA5pVfUOXy66bHnIoas/zO1RfU=; b=lxWLCa9h+s+9RS0m
 2mmNETYZTGRbZltsqgOV1YRSatkmAm71q2wj9G7Z9aTrAxSBtdT2DcBF/VjnmiBX
 OHFi7kc/SFa8tb1ssT+9hXBADQDNVoY4hIv0Kw8YMyRbueH7WMUajrNNbEtd1/tW
 yJF42LTrCVGlQXXuogm/rB8zEgbcwLE+EE0GjyuwyBybpbEVdH6l0Vabx6bWOUz6
 z/yaG9oLL4sLvQUW5Ifb0WbmcI7XjRw2HL2MoXV7nv2FYeSEUw1yWqKJwJj4b9/3
 GN2sTLRILipT3oGickz1RAgGcxsLMR7+FiVTt01pUSRDejBJ+rofQK6+MhJ9vxY7
 rQPIJQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0nuchqny-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:43:16 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cfe48ca1efso15375255ad.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786549395; x=1787154195; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=W6c6LZ+jwSWDITdL6eA5pVfUOXy66bHnIoas/zO1RfU=;
 b=N7uKfqlg37e9j92g0q914F4+RxYIRdzpA38rIaeAIVPp+VO8PRI4b3uNylyd2hXPc6
 nY3SXa34ijE0LLMBfDzCqRvMRuASYh5NEuD23kybvCcxGWqzoD0N8NsYS76nJHl8Al/r
 j+djL4j0ZQplsG/Hwa+yfntzLxySf5DZYf5/hi931HXlGDKsDN1cJFFB7gotjZOzc3Xa
 mtqK8cXR40DWPK40ytcOFkCR7kYxTo2CjUeQj6aXBH9mtpaGYfPsvz4kRrJnZPqZfjP4
 /tqXscluhSstCw8E3KS2RsAwHR8wmS0VDxJtg7cRgd3cYw/JbzmqN+OmvoASbs836ari
 DU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786549395; x=1787154195;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W6c6LZ+jwSWDITdL6eA5pVfUOXy66bHnIoas/zO1RfU=;
 b=MVaYd+ilZgEpiYwboDxwEp+cNqL673N7Cw9EqePo1tNiQ0nOGmiLMqNicBpbgtdEAv
 DGw0I/fXyxw7kQrGd67Bd9A9GrkDDW26eZQSA5Y//ri+phEiRwWepzrANIOZLCsZ2V5h
 fyvgCAUiKMqWUHfmk29NYSQ+Y1h16jUFKlFk0TRp5eY5ttlQH+A6AN3sXtK7uBwdhuMg
 7DbPh0XUeRJnoZ4P04Aq8vD2VESbDy1NtzFgzvJfCCfTMMWq8sssOMc/I0imDtAEy5ca
 Dq6waRDp8PlDxFlCH0SzxKrAAdVEE+UFHwXbZ1e2zte8NKgCr5fRteikwCfTZ5IUST9y
 fg1g==
X-Gm-Message-State: AOJu0YyhOoBIxSKsx1sw2vITAWHcP3ZK05RYAvKH2z+KHXHvdMdEqFvB
 5ZjAsU+FztbdjDeeX9UnMkLwisaxy/kdGMKGYN4GIM0jfRs7d5FpLTdaH/KjsvhO4wnxEA+dAUv
 zrbgGqhfLf6W+hifqfr8DW4DkJTxhh/CjPkvrH9qj4YjHrgaXmAbOEeUowJQiKncpYg==
X-Gm-Gg: AR+sD10foEwce220L49uhxAg34xVqawTlmXwaWSmXfkCtOOJe3JCEeA0tWIatTlXRCV
 kZklrl6C6ST3yixmBzPBWlon2CEJZ5HCsXhei0g4HJFMWO9O5khIt7V3wJndpQerFIdz521cQkj
 Cf32mB6FfIDxWWHhGoRKRrBlRloKwS1LIp5QUhzIFnzzCyF9k26fcTPr9LbhqFF/sa1bRhi4GRI
 Eyi82WX6EgJ+nv/XTrn4gSPp2LFjjQB3ZGm4eyDgCrSIiTgUb35DuAyeDoXGjn7r26CnJwVpaik
 FW+AU5i2WLhiwp5DI/hBmn5DNsPyGsmlmhdGaRLnlteiC4GAN7eM2XvzlNUWgFpB7Ayqw2FN0yA
 2JZBOX3/mXPoi4ALyd33Q7imhzfZCt1DtPSmC9dv1ZsUzYhcv
X-Received: by 2002:a05:6a20:d495:b0:3c3:9070:96b3 with SMTP id
 adf61e73a8af0-3cc3f52b68cmr7166514637.3.1786549395338; 
 Wed, 12 Aug 2026 08:43:15 -0700 (PDT)
X-Received: by 2002:a05:6a20:d495:b0:3c3:9070:96b3 with SMTP id
 adf61e73a8af0-3cc3f52b68cmr7166426637.3.1786549394781; 
 Wed, 12 Aug 2026 08:43:14 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31da7bf64b5sm8121190eec.10.2026.08.12.08.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:43:13 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 25/41] tests/tcg/hexagon: add HVX tests for vabsdiff
Date: Wed, 12 Aug 2026 08:42:04 -0700
Message-Id: <20260812154220.1029828-26-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
References: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: YroiSk4_aFUNeLZmMuqmpWHjjC0SWN5e
X-Proofpoint-ORIG-GUID: YroiSk4_aFUNeLZmMuqmpWHjjC0SWN5e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfXzIDlcNagvfSG
 OdIhH3dgx9hVJm8IEbWUjvn3rZdeBvi8g7VyNUNiI0sq9Cfn3poseKpq/62PwI4q22rcXjYGmSo
 ePTuq8KYj59FhDB75/HUSZObABqRZPRFjKeDuw3VABsQ5QXXj3zdrePJTCPrbRDoLnptJMrGFgo
 2hRXJmqQxDS6tx4LFGSLgmTKAsqIC2wj1GtN9rz3G53ChSiaW+YGnRiKCBs6QaT8caBOE5osGPQ
 apEiao5Ai455REFHIlJ7Cs5sF5vZLvXagxJy4hSLadTCfd8CUgm05Q/qWBYUM8XNS1UnntXbphn
 TxG4rzJk+YNCpjM3HB6VVwOE6ULkNxiXgGLfgrBAD09/43I6A0eYccLqjUNHMMj7viIW7Ay62xV
 EaJWkcckYZB5KTSIC4OFxn/OM6L6U766YmDw8ZWkg31vycFAwuXyNOt0aA3NGSJy6K5kJuevxh0
 kQZ7DFG8SPwd4+XCKiw==
X-Authority-Analysis: v=2.4 cv=VcjH+lp9 c=1 sm=1 tr=0 ts=6a7c9494 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=BpNi1cdwbXwK4F8ztrgA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfX6HMIzR0YPqKw
 OppZ5+N5sWaqvyh2WD+TKXxiG4OwdRQBiHtKjOu9uQx43nmTr/5NUqLttWzTPkAGs4pdw3uDFlK
 fubVb5Y0JtpIZgUUsEcmZ890rbd/a6c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120128
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

Q292ZXIgdGhlIGZvdXIgdmFic2RpZmYgdmFyaWFudHMuCgpUaGUgZXhwZWN0ZWQgdmFsdWUgaXMg
Y29tcHV0ZWQgaW4gaW50NjRfdCB0byBhdm9pZCBvdmVyZmxvd2luZyB0aGUKc291cmNlIGVsZW1l
bnQgdHlwZS4KClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVy
QG9zcy5xdWFsY29tbS5jb20+Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2
ZWwvMjAyNjA4MDcxNTIyNDEuMTU3NjMzNC04LWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbQpT
aWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0t
LQogdGVzdHMvdGNnL2hleGFnb24vaHZ4X21pc2MuYyB8IDMzICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS90ZXN0cy90Y2cvaGV4YWdvbi9odnhfbWlzYy5jIGIvdGVzdHMvdGNnL2hleGFnb24vaHZ4
X21pc2MuYwppbmRleCA2NDFjZmY1OWFiYS4uMzJhMzY2MWE4NmYgMTAwNjQ0Ci0tLSBhL3Rlc3Rz
L3RjZy9oZXhhZ29uL2h2eF9taXNjLmMKKysrIGIvdGVzdHMvdGNnL2hleGFnb24vaHZ4X21pc2Mu
YwpAQCAtMzE3LDYgKzMxNywzNCBAQCBURVNUX1ZFQ19PUDIodmFuZCwgdmFuZCwgLCBkLCA4LCAm
KQogVEVTVF9WRUNfT1AyKHZvciwgdm9yLCAsIGQsIDgsIHwpCiBURVNUX1ZFQ19PUDEodm5vdCwg
dm5vdCwgLCBkLCA4LCB+KQogCisjZGVmaW5lIFRFU1RfVkVDX0FCU0RJRkYoTkFNRSwgSU5UUklO
U0lDLCBTUkNfRklFTEQsIERTVF9GSUVMRCwgXAorICAgICAgICAgICAgICAgICAgICAgICAgIENI
RUNLX0ZJRUxELCBGSUVMRFNaKSBcCitzdGF0aWMgaW5saW5lIHZvaWQgdGVzdF8jI05BTUUodm9p
ZCkgXAoreyBcCisgICAgSFZYX1ZlY3RvciB2MDsgXAorICAgIEhWWF9WZWN0b3IgdjE7IFwKKyAg
ICBIVlhfVmVjdG9yIHZyZXM7IFwKKyAgICBmb3IgKGludCBpID0gMDsgaSA8IEJVRlNJWkU7IGkr
KykgeyBcCisgICAgICAgIG1lbWNweSgmdjAsICZidWZmZXIwW2ldLCBzaXplb2YoTU1WZWN0b3Ip
KTsgXAorICAgICAgICBtZW1jcHkoJnYxLCAmYnVmZmVyMVtpXSwgc2l6ZW9mKE1NVmVjdG9yKSk7
IFwKKyAgICAgICAgdnJlcyA9IElOVFJJTlNJQyh2MCwgdjEpOyBcCisgICAgICAgIG1lbWNweSgm
b3V0cHV0W2ldLCAmdnJlcywgc2l6ZW9mKE1NVmVjdG9yKSk7IFwKKyAgICB9IFwKKyAgICBmb3Ig
KGludCBpID0gMDsgaSA8IEJVRlNJWkU7IGkrKykgeyBcCisgICAgICAgIGZvciAoaW50IGogPSAw
OyBqIDwgTUFYX1ZFQ19TSVpFX0JZVEVTIC8gRklFTERTWjsgaisrKSB7IFwKKyAgICAgICAgICAg
IGludDY0X3QgZGlmZiA9IChpbnQ2NF90KWJ1ZmZlcjBbaV0uU1JDX0ZJRUxEW2pdIC0gXAorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgKGludDY0X3QpYnVmZmVyMVtpXS5TUkNfRklFTERbal07
IFwKKyAgICAgICAgICAgIGV4cGVjdFtpXS5EU1RfRklFTERbal0gPSBkaWZmIDwgMCA/IC1kaWZm
IDogZGlmZjsgXAorICAgICAgICB9IFwKKyAgICB9IFwKKyAgICBjaGVja19vdXRwdXRfIyNDSEVD
S19GSUVMRChfX0xJTkVfXywgQlVGU0laRSk7IFwKK30KKworVEVTVF9WRUNfQUJTRElGRih2YWJz
ZGlmZnViLCBRNl9WdWJfdmFic2RpZmZfVnViVnViLCB1YiwgdWIsIGIsIDEpCitURVNUX1ZFQ19B
QlNESUZGKHZhYnNkaWZmdWgsIFE2X1Z1aF92YWJzZGlmZl9WdWhWdWgsIHVoLCB1aCwgaCwgMikK
K1RFU1RfVkVDX0FCU0RJRkYodmFic2RpZmZoLCAgUTZfVnVoX3ZhYnNkaWZmX1ZoVmgsICAgaCwg
IHVoLCBoLCAyKQorVEVTVF9WRUNfQUJTRElGRih2YWJzZGlmZncsICBRNl9WdXdfdmFic2RpZmZf
VndWdywgICB3LCAgdXcsIHcsIDQpCisKIFRFU1RfUFJFRF9PUDIocHJlZF9vciwgb3IsIHwsICIi
KQogVEVTVF9QUkVEX09QMihwcmVkX29yX24sIG9yLCB8LCAiISIpCiBURVNUX1BSRURfT1AyKHBy
ZWRfYW5kLCBhbmQsICYsICIiKQpAQCAtNTc1LDYgKzYwMywxMSBAQCBpbnQgbWFpbigpCiAgICAg
dGVzdF92c3VidXdzYXRfZHYoKTsKICAgICB0ZXN0X3ZzdWJ3c2F0KCk7CiAKKyAgICB0ZXN0X3Zh
YnNkaWZmdWIoKTsKKyAgICB0ZXN0X3ZhYnNkaWZmdWgoKTsKKyAgICB0ZXN0X3ZhYnNkaWZmaCgp
OworICAgIHRlc3RfdmFic2RpZmZ3KCk7CisKICAgICB0ZXN0X2xvYWRfdG1wX3ByZWRpY2F0ZWQo
KTsKICAgICB0ZXN0X2xvYWRfY3VyX3ByZWRpY2F0ZWQoKTsKIAotLSAKMi4zNC4xCgo=

