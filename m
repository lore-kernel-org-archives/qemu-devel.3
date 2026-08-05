Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72BAC56203
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrer9-0005ts-FI; Wed, 05 Aug 2026 12:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrer3-0005sN-D8
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:52:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrer1-00034u-OO
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:52:33 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675FVTPb303112
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 16:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NRMJDrz7uIQ5OVbMdSDUeJE1mYBxzgONpg8YLqlBHqQ=; b=GZwDJGg7qvL4Bu42
 mt3PUHl8YbAVXHVSE8XCrRn259PAEbzpCRC4fqQRa0nWJPFTRV07ywBNiqbI1FDI
 IUYgH/pGOtYokG6aal01YoW3XGxM+eBfSCG6ivgmkSLnnllGAwbvymJt0e0FUc7Z
 Dk8DreZhP6YDE1ezAx72uhQbodYVv5UkJu840IyPKFsihngvfeEpVQJJ13He0yez
 sNE/G9mKaxEurVzre5KjJElZcnQYL6D8UewmfvBjFoB8fBCZpvN4qtSgIxDDKQ24
 gm3oBs8QfsE+gyflYu3Klbd9A46ci0ZOoNsZ6DZuj873ZJrhT8KcZBel3sAPQI99
 q8caDw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fuu3um148-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 16:52:29 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cc88e22f92so26733255ad.1
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 09:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785948749; x=1786553549; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NRMJDrz7uIQ5OVbMdSDUeJE1mYBxzgONpg8YLqlBHqQ=;
 b=cDCJQ+fnwdS0LFdWg7u0rTdzD7gCzhWDXnmuRg184Z9m4TfxzHVRpVHmh48APwbato
 x531jeo9U87vOc0VDFhiKyNI1bHR4Qzr+wxDll2IO75VUXYWH9Oy2amjut7S52TPUWIW
 kPui5yRwTQybk6mkev05oQu4eQ27ZV21OSWsn0QsHWy18qaMvRZCyCXXNtqJicwNdd0V
 A+dCgWdEsBQqXtg6E5EvTsy+90Z5RnvAQFFhu2NrT8PzPNQ/5MRLtO4kvs0VGistgRQ3
 1O/N4i+xStKnxvLTmErj/OQBKlwfpCwe1BkZ56LtsXpL+PUS/GPUJD7YkMIQuNeb+13j
 zsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785948749; x=1786553549;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NRMJDrz7uIQ5OVbMdSDUeJE1mYBxzgONpg8YLqlBHqQ=;
 b=lilP0sDqoG8D5/3+p97Wh+pci7Xoi8iSdErOWhoq83TFg6jyzM0plQKmfMNDODDVqT
 P1xXO6qrtZRqz/RZw8b3pTQRb/zSPgav2kDflximLjRk2mMYhcM4ezeAAb4oZn7Otgm9
 5tI0qaEl8ALf2UCz1OIdh5GJ4o9a28w9AoSUipzhejSEiX58Pg0GbbjaidN9P4QnqXMV
 DuHiOBl2VrsKppLikshdju089c+v1s9ywNEnDKwMTHHa+NjEjnYOlYaGnp87gTqvgSaV
 GBVDibMtrzwa2H8g7StfrwuQWUllmrsXqAQh++BiKPveiHc7ch9T9SYJRiYQhg8Fyp9p
 1QVg==
X-Gm-Message-State: AOJu0YyQELve8R5MYmXpUnHuDDVVQJG21IwOF5fQxR+i1vOniMLQujl5
 RibqhK48qkQBW6hDvN9HFxEbxcl6Ws80E293/2N7bOybyPXw/AxNjBh5r7ZYZSmWVyhYwaNUBSc
 25WINmPB0LLzG3zYVzGTjkgGGt7qV21xgPsVYGLsi+ADS+horTzZ9cCMIx6FZqtiy6g==
X-Gm-Gg: AR+sD10kUnEL4NFP2ylRE/ktz+b5788vJ5N7SUMwnj7+ZdCOmIKEOEb4cQj6Sk2n56c
 KYnB96L8XokqBYVqKtcXXqUpaVZ6ECcTJNtdcdjTNdwD7ivMIOc3UI4pUfpBo74+HFlspqTbuc2
 PNkdzomwNkBILk9CmWpaIfB7EqwEwOcjqVgIUo2Wn3rtWJCDynB1DOPJvDzCyCsl7L1SvZ0fJdj
 /uM8MJvTbSU7dwSere3clz5wxdlcLchGj3yZs4Vg5GAAONamvz4rD3b7o2WhILbH5tUZqxdiNQm
 PfA4RCi0wBlly9VGNb2xV5vFpBbR2KG/QpBqImgD0X+P/+feV4IE4vXCEMCC2eDITt7iuPVBDJD
 rzk+IpBOZQXJVRkvSHPcuVEPit24O3l630h8emQ9LnnlUCcDz
X-Received: by 2002:a17:90b:274d:b0:38e:fea2:df53 with SMTP id
 98e67ed59e1d1-3903c534d46mr9941022a91.4.1785948749021; 
 Wed, 05 Aug 2026 09:52:29 -0700 (PDT)
X-Received: by 2002:a17:90b:274d:b0:38e:fea2:df53 with SMTP id
 98e67ed59e1d1-3903c534d46mr9940969a91.4.1785948748467; 
 Wed, 05 Aug 2026 09:52:28 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31586402e53sm26429356eec.11.2026.08.05.09.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 09:52:27 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, richard.henderson@linaro.org
Subject: [PATCH 1/6] host-utils: fix ssub32/64_saturate return type and clamp
 direction
Date: Wed,  5 Aug 2026 09:52:20 -0700
Message-Id: <20260805165225.3117924-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260805165225.3117924-1-brian.cain@oss.qualcomm.com>
References: <20260805165225.3117924-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEzOCBTYWx0ZWRfX5x+Abnu74uF5
 1PC7sTzp2PKo4ogdExAPnI0TT96xh+3Dp92y06969BXrY1TO2wlKGKkrjmbB4mnYpa9uyod09jU
 wTXVtjm3MPNhcB0y6qDAAqdDyADHqlA=
X-Proofpoint-GUID: SxJJgM0Jy6aWk4QnMj--wGCIHojyG99E
X-Authority-Analysis: v=2.4 cv=B5aJFutM c=1 sm=1 tr=0 ts=6a736a4d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=kM50MvNqywxRmdRKJWUA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: SxJJgM0Jy6aWk4QnMj--wGCIHojyG99E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEzOCBTYWx0ZWRfX5Not6lA6QA7T
 VUlARWvPJTrQ1mN/0rutvbclDe8GmTNKxpVaz1JuzZPiy/Zgfmpt+gCe9j+1zB3plawdcw1Nhbp
 UyY9CKa74eecBYkMbVEakTCdmfyq5MEzPmvNeGlGXGZllZKR8FIcCHvBn1ylsPo6wOchgO2jolO
 Sj72iGyPMFm7oufeUzRZG2QtVebRcrnoyYYoufFpv4MxR7MdFG6194nGsPbcH76DRVsoU1ngAGk
 IoG3Xo5FG4BWABqjSvWftT4ECWMH+3G/FNK5UsiSSxK8HDkbWeo2/b8xJXclHrbBQebBHVc5HwN
 dRswde1I3YnqLI1a1hFaZwgAVd4tcLoB1K4PYpkuXhiirl5bL+/rTDZJCwj3J6IMgo+au9T5KEZ
 h6D0FUbLA155/8djg0e9gacxcBLj+ypRlgl1dbcq1zzcRWKWSAfngnY7ZZiIbjlEZ3OAcn7Jogm
 QOCu3O9+5w4pJc9ehKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050138
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

c3N1YjMyX3NhdHVyYXRlKCkgYW5kIHNzdWI2NF9zYXR1cmF0ZSgpIHdlcmUgZGVjbGFyZWQgdG8g
cmV0dXJuIGJvb2wKaW5zdGVhZCBvZiBpbnQzMl90L2ludDY0X3QsIGFuZCBjbGFtcGVkIHRvIHRo
ZSB3cm9uZyBib3VuZCBvbiBvdmVyZmxvdy4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJy
aWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBpbmNsdWRlL3FlbXUvaG9zdC11dGlscy5o
IHwgMjAgKysrKysrKysrKy0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25z
KCspLCAxMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL3FlbXUvaG9zdC11dGls
cy5oIGIvaW5jbHVkZS9xZW11L2hvc3QtdXRpbHMuaAppbmRleCAyZThkYTdmYjNkMC4uMjkxYmIx
OThiNjUgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvcWVtdS9ob3N0LXV0aWxzLmgKKysrIGIvaW5jbHVk
ZS9xZW11L2hvc3QtdXRpbHMuaApAQCAtNjEwLDcgKzYxMCw3IEBAIHN0YXRpYyBpbmxpbmUgYm9v
bCB1bXVsNjRfb3ZlcmZsb3codWludDY0X3QgeCwgdWludDY0X3QgeSwgdWludDY0X3QgKnJldCkK
ICAqIHNhZGQzMl9zYXR1cmF0ZSAtIGFkZGl0aW9uIHdpdGggc2F0dXJhdGlvbgogICogQHgsIEB5
OiBhZGRlbmRzCiAgKgotICogQ29tcHV0ZXMgQHggKyBAeSwgYW5kIHNhdHVyYXRlcyByYXRoZXJu
IHRoYW4gdHJ1bmNhdGluZyB0aGUgcmVzdWx0LgorICogQ29tcHV0ZXMgQHggKyBAeSwgYW5kIHNh
dHVyYXRlcyByYXRoZXIgdGhhbiB0cnVuY2F0aW5nIHRoZSByZXN1bHQuCiAgKi8KIHN0YXRpYyBp
bmxpbmUgaW50MzJfdCBzYWRkMzJfc2F0dXJhdGUoaW50MzJfdCB4LCBpbnQzMl90IHkpCiB7CkBA
IC02MjUsNyArNjI1LDcgQEAgc3RhdGljIGlubGluZSBpbnQzMl90IHNhZGQzMl9zYXR1cmF0ZShp
bnQzMl90IHgsIGludDMyX3QgeSkKICAqIHNhZGQ2NF9zYXR1cmF0ZSAtIGFkZGl0aW9uIHdpdGgg
c2F0dXJhdGlvbgogICogQHgsIEB5OiBhZGRlbmRzCiAgKgotICogQ29tcHV0ZXMgQHggKyBAeSwg
YW5kIHNhdHVyYXRlcyByYXRoZXJuIHRoYW4gdHJ1bmNhdGluZyB0aGUgcmVzdWx0LgorICogQ29t
cHV0ZXMgQHggKyBAeSwgYW5kIHNhdHVyYXRlcyByYXRoZXIgdGhhbiB0cnVuY2F0aW5nIHRoZSBy
ZXN1bHQuCiAgKi8KIHN0YXRpYyBpbmxpbmUgaW50NjRfdCBzYWRkNjRfc2F0dXJhdGUoaW50NjRf
dCB4LCBpbnQ2NF90IHkpCiB7CkBAIC02MzgsMzAgKzYzOCwzMCBAQCBzdGF0aWMgaW5saW5lIGlu
dDY0X3Qgc2FkZDY0X3NhdHVyYXRlKGludDY0X3QgeCwgaW50NjRfdCB5KQogCiAvKioKICAqIHNz
dWIzMl9zYXR1cmF0ZSAtIHN1YnRyYWN0aW9uIHdpdGggc2F0dXJhdGlvbgotICogQHgsIEB5OiBh
ZGRlbmRzCisgKiBAeCwgQHk6IG1pbnVlbmQgYW5kIHN1YnRyYWhlbmQKICAqCi0gKiBDb21wdXRl
cyBAeCArIEB5LCBhbmQgc2F0dXJhdGVzIHJhdGhlcm4gdGhhbiB0cnVuY2F0aW5nIHRoZSByZXN1
bHQuCisgKiBDb21wdXRlcyBAeCAtIEB5LCBhbmQgc2F0dXJhdGVzIHJhdGhlciB0aGFuIHRydW5j
YXRpbmcgdGhlIHJlc3VsdC4KICAqLwotc3RhdGljIGlubGluZSBib29sIHNzdWIzMl9zYXR1cmF0
ZShpbnQzMl90IHgsIGludDMyX3QgeSkKK3N0YXRpYyBpbmxpbmUgaW50MzJfdCBzc3ViMzJfc2F0
dXJhdGUoaW50MzJfdCB4LCBpbnQzMl90IHkpCiB7CiAgICAgaW50MzJfdCByZXQ7CiAgICAgaWYg
KHNzdWIzMl9vdmVyZmxvdyh4LCB5LCAmcmV0KSkgewotICAgICAgICByZXQgPSB4IDwgMCA/IElO
VDMyX01BWCA6IElOVDMyX01JTjsKKyAgICAgICAgcmV0ID0geCA8IDAgPyBJTlQzMl9NSU4gOiBJ
TlQzMl9NQVg7CiAgICAgfQogICAgIHJldHVybiByZXQ7CiB9CiAKIC8qKgogICogc3N1YjY0X3Nh
dHVyYXRlIC0gc3VidHJhY3Rpb24gd2l0aCBzYXR1cmF0aW9uCi0gKiBAeCwgQHk6IGFkZGVuZHMK
KyAqIEB4LCBAeTogbWludWVuZCBhbmQgc3VidHJhaGVuZAogICoKLSAqIENvbXB1dGVzIEB4ICsg
QHksIGFuZCBzYXR1cmF0ZXMgcmF0aGVybiB0aGFuIHRydW5jYXRpbmcgdGhlIHJlc3VsdC4KKyAq
IENvbXB1dGVzIEB4IC0gQHksIGFuZCBzYXR1cmF0ZXMgcmF0aGVyIHRoYW4gdHJ1bmNhdGluZyB0
aGUgcmVzdWx0LgogICovCi1zdGF0aWMgaW5saW5lIGJvb2wgc3N1YjY0X3NhdHVyYXRlKGludDY0
X3QgeCwgaW50NjRfdCB5KQorc3RhdGljIGlubGluZSBpbnQ2NF90IHNzdWI2NF9zYXR1cmF0ZShp
bnQ2NF90IHgsIGludDY0X3QgeSkKIHsKICAgICBpbnQ2NF90IHJldDsKICAgICBpZiAoc3N1YjY0
X292ZXJmbG93KHgsIHksICZyZXQpKSB7Ci0gICAgICAgIHJldCA9IHggPCAwID8gSU5UNjRfTUFY
IDogSU5UNjRfTUlOOworICAgICAgICByZXQgPSB4IDwgMCA/IElOVDY0X01JTiA6IElOVDY0X01B
WDsKICAgICB9CiAgICAgcmV0dXJuIHJldDsKIH0KLS0gCjIuMzQuMQoK

