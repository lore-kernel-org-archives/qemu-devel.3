Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CC8C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x53mW-000522-Bx; Fri, 11 Sep 2026 12:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x53ji-0003O7-84
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:04:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x53jP-0007bi-Tf
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:04:18 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BEmK4W3780843
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 16:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C5AkgkYHKGamXlkWQavLxJtgCik313BWMyMDZsSh19o=; b=FtaSNXnIHMuE15DP
 741GVooozbMZJM1eVZ3ze/JWw37M1coKcHMotbHURVoCVZk3Jtd4vvzRtiHPQAD5
 1qf+deoqIiUPNQYvWd8qFGBgLx3UUaCmJEe7W+8kUJi0QGJvCHk6I0g9M4iIjoZc
 u1nMysfcudtU0+rzrWOjo4m9B8/noAJiZqWi4zBOfZK73Mxt7XcT5ZrAu0egt/Cm
 gHchitPfVvPTXG0v9Z2yDd43SeS5GDw2I3CW74ECibQAkOFhBSklxKysgJp338b8
 F2+Ib3tMTkawOyH4W0vKQhVXjt3upSppbFRvEjC0zZhqat0beCfTTKKNRNQyizhN
 Al+iZQ==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmcgfjav3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 16:04:02 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4b37620eb73so1479382b6e.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 09:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789142642; x=1789747442; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C5AkgkYHKGamXlkWQavLxJtgCik313BWMyMDZsSh19o=;
 b=TF42F4qUcqh0HpOX/+cVxl0MMano5Tq48lDhXE01G1Sc7YeIY/12Tjk3tmOtb6HOmL
 cbQkt1ihUAWjIqkftWMwjj3nBm91llDRRFcz5mtP7/mXJSulRQ2vEBaitO6wB2e6y/Ph
 +XVdNslph9wdKu059eHsshTUQrb2HZGp93mu+LyHgKQrXdU3ir31qIdeB30uI0Nqz2jd
 HvzQW7oLfe1n9eiEnw+u2ZZkOcH5dEFyw/sPJBCyPEWyYtt0kGVeismoQLYTmrJYuOgn
 b0nzXwu19yUh9wAM7BsznqSksATAsAzES2QSmlKk4EZSJ9XtFnrLuDzjpZuDC/21y6Ra
 2IuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789142642; x=1789747442;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C5AkgkYHKGamXlkWQavLxJtgCik313BWMyMDZsSh19o=;
 b=femaZlwlpPJMXph3wS8qFRAsFV0zpH7LIifdOMDcGkDZZRbnNLmW1uRWSBDB4qiyH/
 s0ndiTQT/dcx1aA8MptMHx3W+z/KgYP0XLtwto45rsP6pO9ZVVZfaU+8CWfce4j8+43c
 xZvIwN/RQ3uL5OPikGtzbw17c8JGtPYQV9xCp2Wyyvoo7TarDJEmk9bMlXZ5rFPlrqFl
 V2IUREqdNl2szXR1rQJdHwKnjU2qNMfEZuJh5WcmSV1t75Vfuwj2sh9C0soXOZQsOnqM
 QJM4IYi4Z6TO7hZGJgfWhRTgp61iodjONOGn9hxN8MKVcKmTRTCJRQ5eoOJTueOjsRMA
 W8zg==
X-Gm-Message-State: AFuF++lOu1xp5R7KpJT6QvwHEJWcCA0Q+lgUAK9POK7JPYNCCzmW4NpM
 7saUGBWxzBO4vxbt45k+xS4xJFmkS8utvDO8dvWrQ0VYS187Bq2LfSd+B13HIj+/vYN/HT3WiU/
 Jjozh28Bo3IlQ+nLhcFXxhktsd6rx/qCQppdkJA1pAccFLQUWh/GsssheGhKz1+8Yqg==
X-Gm-Gg: AYBFou0tsvxFCfDV/AuTQiut5zHMLr9VE6f5grBudZ2gEouJBS9pfmBVfIuP6jiJzf3
 EAZoUWogaAVYELIyRvgvMGlnuasUaV6gU+NPVb7frv26MPmyLXy0kHMtuIqZ0W9zCxJWOvg7e7j
 KAag9wNHr/X/lGM9jBX0cHXAg5AooA9L2RDFIC8gYaB9JXV+gJtKoU9JShUYw20jIpM42SczoSq
 MI7En61i3R+1wgBWXRkdScR05J3kHN9icEQHLsNNv3bg+Y90FVJjigxFWscQDM8q3fAz92x6y4h
 ee6erjQBMEhpOw8a7hSbCyMowZRpE3qG6BZ8cuGo+dZOpDgHvHSxCZk5hHMKPfLbslPulBVY1Yh
 coAB8HRpC1KEhw2i/Q9hQcmn3VPhhHMgYkQku8RKD18S1HA10
X-Received: by 2002:a05:6808:c3f3:b0:4b2:5529:ed3c with SMTP id
 5614622812f47-4c31a785e30mr7285092b6e.7.1789142641870; 
 Fri, 11 Sep 2026 09:04:01 -0700 (PDT)
X-Received: by 2002:a05:6808:c3f3:b0:4b2:5529:ed3c with SMTP id
 5614622812f47-4c31a785e30mr7284980b6e.7.1789142641186; 
 Fri, 11 Sep 2026 09:04:01 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c3321ecd0asm2451876b6e.17.2026.09.11.09.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 09:03:58 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 07/10] target/hexagon: widen v81 CPU masks
Date: Fri, 11 Sep 2026 09:03:04 -0700
Message-Id: <20260911160307.865892-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911160307.865892-1-brian.cain@oss.qualcomm.com>
References: <20260911160307.865892-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIyNCBTYWx0ZWRfX2W0cVC0S67EI
 ddVGNnu8t4rxRv0uhHD8u72TycyDlAZWc21XvNEdUBLZzusvwBkZt1C6QOJnlEPr8xm0iKtZdvs
 GHGtaigcVtMN5Tu5cdprbMUnKkpgXt283gBjzr4SZ9l3w4HL9SLICWVJyKh1z15fnQ6NPGuNsb+
 j1Q4uGTHlaYGIXG2k0K+RFBd5Us+EgAqB7YhAJIhKc5uLvZ30/pgJcSB2T7EaXI0MmBLCDkCRdG
 D/jZSRxrkMeSPHif7efXSjfM8RKxU8IazrWcHFZ3waOks2fpWasB/6ksZRgUIUYzdNgGmm1ZPu8
 REv1mb5ZtQ/Ni/Pc8ogRFun0Jns8WU/YYx4/HRCxSn3xl8s4UvflBHvsTWwPrFWsuoptVrxFAbS
 47TpKbUzCtDg9xNunCdTdxlWaVoWSLcPNM9aRiCIKdtymkvQpLsMdGDNppTjAdogLWU0xWhjajm
 sQJn20Xzhn6Hap8ttiQ==
X-Proofpoint-GUID: ZQp-sKsv_fmHFGYgnY3GGEGTwYempYQm
X-Proofpoint-ORIG-GUID: ZQp-sKsv_fmHFGYgnY3GGEGTwYempYQm
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIyNCBTYWx0ZWRfX6wJ29qbCd7E3
 GTEEHnRAH6dxgSeFhe8U7qfg5UFRKqpVlNlaKXIqpmYOAHDSxG8tFobjXdpq3wEHEWMy89Ck/bx
 xeMNS73DW0Zn6jScaYh5a4sqgCrLcEI=
X-Authority-Analysis: v=2.4 cv=ULtIjyfy c=1 sm=1 tr=0 ts=6aa42672 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=IhbGQmEIjLns90X6lycA:9 a=QEXdDO2ut3YA:10
 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110224
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

UmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFsY29tbS5jb20+
ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4K
LS0tCiB0YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzX2RlZi5oLmluYyB8IDkgKysrKy0tLS0tCiB0
YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyAgICAgICAgICAgICB8IDggKysrKysrLS0KIDIgZmlsZXMg
Y2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90
YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzX2RlZi5oLmluYyBiL3RhcmdldC9oZXhhZ29uL3JlZ19m
aWVsZHNfZGVmLmguaW5jCmluZGV4IDI5NDk3ZmJjYzRkLi5hNmIxNzAxMWQ4MiAxMDA2NDQKLS0t
IGEvdGFyZ2V0L2hleGFnb24vcmVnX2ZpZWxkc19kZWYuaC5pbmMKKysrIGIvdGFyZ2V0L2hleGFn
b24vcmVnX2ZpZWxkc19kZWYuaC5pbmMKQEAgLTQ0LDcgKzQ0LDcgQEAgREVGX1JFR19GSUVMRChJ
UEVOREFEX0lBRCwgMTYsIDE2KQogREVGX1JFR19GSUVMRChJUEVOREFEX0lQRU5ELCAwLCAxNikK
IAogREVGX1JFR19GSUVMRChTQ0hFRENGR19FTiwgOCwgMSkKLURFRl9SRUdfRklFTEQoU0NIRURD
RkdfSU5UTk8sIDAsIDQpCitERUZfUkVHX0ZJRUxEKFNDSEVEQ0ZHX0lOVE5PLCAwLCA1KQogREVG
X1JFR19GSUVMRChCRVNUV0FJVF9QUklPLCAwLCA5KQogCiAKQEAgLTEwOSwxNCArMTA5LDEzIEBA
IERFRl9SRUdfRklFTEQoU1NSX1NTLCAzMCwgMSkKIERFRl9SRUdfRklFTEQoU1NSX1hFLCAzMSwg
MSkKIAogLyogbWlzYyByZWdpc3RlcnMgKi8KLURFRl9SRUdfRklFTEQoSU1BU0tfTUFTSywgMCwg
MTYpCitERUZfUkVHX0ZJRUxEKElNQVNLX01BU0ssIDAsIDMyKQogCiBERUZfUkVHX0ZJRUxEKFNU
SURfUFJJTywgMTYsIDgpCiBERUZfUkVHX0ZJRUxEKFNUSURfU1RJRCwgMCwgOCkKIAotLyogTU9E
RUNUTCBmaWVsZHMgKi8KLURFRl9SRUdfRklFTEQoTU9ERUNUTF9FLCAwLCA4KQotREVGX1JFR19G
SUVMRChNT0RFQ1RMX1csIDE2LCA4KQorREVGX1JFR19GSUVMRChNT0RFQ1RMX0UsIDAsIDE2KQor
REVGX1JFR19GSUVMRChNT0RFQ1RMX1csIDE2LCAxNikKIAogREVGX1JFR19GSUVMRChDQ1JfTDFJ
Q1AsIDAsIDIpCiBERUZfUkVHX0ZJRUxEKENDUl9MMURDUCwgMywgMikKZGlmZiAtLWdpdCBhL3Rh
cmdldC9oZXhhZ29uL2dlbnB0ci5jIGIvdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMKaW5kZXggOWY1
M2ZjYjZiOTUuLjRlOWE5NjcwZDU0IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9nZW5wdHIu
YworKysgYi90YXJnZXQvaGV4YWdvbi9nZW5wdHIuYwpAQCAtMjY5LDE0ICsyNjksMTggQEAgc3Rh
dGljIGNvbnN0IHVpbnQzMl90IHNyZWdfaW1tdXRfbWFza3NbTlVNX1NSRUdTXSA9IHsKICAgICBb
SEVYX1NSRUdfU1NSXSA9IDB4MDAwMDgwMDAsCiAgICAgW0hFWF9TUkVHX0NDUl0gPSAweDEwZTBm
ZjI0LAogICAgIFtIRVhfU1JFR19IVElEXSA9IElNTVVUQUJMRSwKLSAgICBbSEVYX1NSRUdfSU1B
U0tdID0gMHhmZmZmMDAwMCwKICAgICBbSEVYX1NSRUdfR0VWQl0gPSAweDAwMDAwMGZmLAogfTsK
IAogR19HTlVDX1VOVVNFRAogc3RhdGljIHZvaWQgZ2VuX2xvZ19zcmVnX3dyaXRlKERpc2FzQ29u
dGV4dCAqY3R4LCBpbnQgcm51bSwgVENHdl9pMzIgdmFsKQogewotICAgIGNvbnN0IHVpbnQzMl90
IHJlZ19tYXNrID0gc3JlZ19pbW11dF9tYXNrc1tybnVtXTsKKyAgICB1aW50MzJfdCByZWdfbWFz
ayA9IHNyZWdfaW1tdXRfbWFza3Nbcm51bV07CisKKyAgICBpZiAocm51bSA9PSBIRVhfU1JFR19J
TUFTSyAmJgorICAgICAgICBjdHgtPmhleF9kZWYtPmhleF92ZXJzaW9uIDwgSEVYX1ZFUl9WODEp
IHsKKyAgICAgICAgcmVnX21hc2sgPSAweGZmZmYwMDAwOworICAgIH0KIAogICAgIGlmIChyZWdf
bWFzayAhPSBJTU1VVEFCTEUpIHsKICAgICAgICAgaWYgKHJudW0gPCBIRVhfU1JFR19HTEJfU1RB
UlQpIHsKLS0gCjIuMzQuMQoK

