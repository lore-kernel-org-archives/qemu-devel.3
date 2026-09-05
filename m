Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35007C624D6
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 18:11:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2uqc-0002we-Cn; Sat, 05 Sep 2026 14:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uqE-0002rC-D9
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uqB-0001cr-D1
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:13 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685HcWxx3521421
 for <qemu-devel@nongnu.org>; Sat, 5 Sep 2026 18:10:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Yrqh62pzVyNW02N+VwF8wglTlx2ZXqgjxuu+4LlRKEc=; b=RiHX9VeC1ZYsVbDx
 0Gvj0NvZ8wSIalkY4xndJv6HCYIE6b7npGehtiuWYD2GIXNDFg4EPgWcKcUbsOsB
 nPreHsTQVt+VWfKdKyZ7wn0etMZhIr6tVyS32Yo0gc/0igy0D4YWqsnq82PIquME
 rpfkd2tflBPaFejmOgWuLEnZ9OwLjzBX4tUoK4F3GPGlzt2jwq20O94HRQSnWirZ
 xvidAcSiI6rsLdcAwzFu1T97YMLx5RndB7NJBGHh2+BYXbcXyOYjOO23MQnYA9J3
 rO4GDwsSopWh8NPBR5v/7L91jTls4naOuYhxdO32Lcb8sBBgbrkKG0qWJ/FkIJB5
 nolQ2w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggany1xc9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 18:10:10 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38ea32e57e2so4206602a91.1
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 11:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788631809; x=1789236609; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Yrqh62pzVyNW02N+VwF8wglTlx2ZXqgjxuu+4LlRKEc=;
 b=Y72Tl15bKTjU9ESaEUiscBafirwNTocQgfwy6AcB2u0FKcw7zECshzLQeRJl+tKyKg
 5QXEEy5PT3491j3tpu82BUNLAnFtFP5banQ8sYwk2D7GHWP6Z8cJIpKmm6B3ImW0xnRE
 bG7W6vjhbCQEy3L+M9wMdAc9/7k1hTrLYLr7pKHH+Mu+/eHHZFG1j3FHCB+I3UESj9sq
 W4z5GEa3lI4RvvOI3V5WbUYMyghn7gxBXNn2bp29Zkq7xCk5B2V7RQXVSSKsrwQx3hsK
 HPsJqacwLcJrbpPBW7z0IxDhWnzpfe6DZGlQR7Q/Bv7d4s36saqABeZKLaBCcmXWWZbq
 E6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788631809; x=1789236609;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Yrqh62pzVyNW02N+VwF8wglTlx2ZXqgjxuu+4LlRKEc=;
 b=ec6dPHdckHdDwggmG0nlZFp8HYJkedEGSyYHzLCJKizbOU3/cEhzoLVv2eAvBJ9nw6
 ZWEvD2OD3rdX7he0j1igp/yWB9MBxWuiE8jD5pRvawzSYUJEAV1I5lHRBDhnNZ6qS5tz
 i9nDrMC3mf9y9gm0lFdrhaggzCh9iykwAg/CLQ25xkEKxoHjgI5cWVeMPhdUQ98G2CpK
 ZIomWNJYYslw6LnhReADQ3Z1VVSRzt6oPkOYu3TYxnaOFO5giV5sXOGADku1e5SU3rrY
 QMU05GvykZp3kZoKsXb0p8ihKRa0ib+5PlXZey6h/PWR3K7U7qZr7Eky9KwV0Y1eDNEQ
 3omw==
X-Gm-Message-State: AFuF++kyBaXygVaZbm7W66egKxw3fHaNMxsxEUEP9JqBXmTemz8urpc9
 +o4B49Yhw7xkSTRqh3VOiZcZDqj5WQLQiXs31VL0Cj6+FAeCmJC3hIOcHxMxF1mDJCIOUEh6vhp
 xntTpoGN93UFRcyzHiyUw49yY7OOY0uMXlKHlUWmtgH/DzRDhUYgXTgq6agYZGUcTPA==
X-Gm-Gg: AYBFou297/zWGK1VmfG2WYBG/CsN93bVhKRUN96rTdpcAUCpgXNDL9Ljb2ZT/IMsjUI
 y1d7fqK6ZTw0PrGnnv2XGjINkgiG80vJJFDJ8CyBW77Ei8XYVGdrcg2JTSrQ3X/rdJNupyoZTOw
 26XzUAnspY/Uvypp7ip9B5Kfg2TCUouHvyunIPOuA3ybWT7edq4uXdLZFM1wbW4PLAyRt9vjz8Z
 ixGFAXuc/4VFW97D6unXLGPLIdPvw4e5X2dphVyu96KAmkGa7t7CDMGBZQe8mUWO/QNuHBIvIUq
 b0W6y+JCbUZAsN254TSvlkuGKfJnhmY2UJXraKi7yPizjbU81SyHmgnUXFUohOnffeJI2UEFg9B
 DDlGtfzH+F+StLhx1ak780XumcR61WTl5Bc0PNu8OJ0V7YLOX
X-Received: by 2002:a17:90b:5844:b0:38f:5869:387b with SMTP id
 98e67ed59e1d1-39b26101c20mr20521363a91.9.1788631809011; 
 Sat, 05 Sep 2026 11:10:09 -0700 (PDT)
X-Received: by 2002:a17:90b:5844:b0:38f:5869:387b with SMTP id
 98e67ed59e1d1-39b26101c20mr20521285a91.9.1788631808238; 
 Sat, 05 Sep 2026 11:10:08 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339a534df1sm17985505eec.7.2026.09.05.11.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 11:10:06 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, sid.manning@oss.qualcomm.com
Subject: [PATCH 08/17] tests/tcg/hexagon: add cond call, tstbit-jump,
 and endloop01 tests
Date: Sat,  5 Sep 2026 11:09:40 -0700
Message-Id: <20260905180949.1852673-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
References: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=X45i7mTe c=1 sm=1 tr=0 ts=6a9c5b02 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=UPTrhlJ9XJtdYAbvsWkA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: bbAQTC9xrzAVc_c3SYzJ3rAfj68k-OM0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfX1Vgj3pvuziSG
 keulMpqyCUId8LoTgsrFlaR8AZ0JqCPsiUJ7/4JX12pIfS3xqjSrB4UNNZDWwFc5VlbV/3YzcpJ
 DU1Z8XJtwwRT0l43au/X4LEMSrZsZiz2E/mJ5Ikn1w55kAS82wPy45z2M2MqEUSghS9cTToD9rX
 BKeva8U1YfmA/jphEorkl4BwXSZ2ADZ2pgYCX6XrjO6TJjpDKzKUsQoZMsyCpl9yl3ZJhLlzvHM
 xbmI4horgWyOCB93Hjh/px3wXBSV5uTated/BA9Kih622iNIIKo4p683t/zGoA3t1Q2YgfxaD9w
 MvfJcFug/WHO2S2xMKTvqEmvG09vLh6eEjTQEAUGDr31FrRT1MD18mlujQweRVkBDHusPuRIUvO
 Ua5uHD3GZ7eOEu3abTeBDbheXV5XzM9Q1tMThDIaeEIiT3fXf5s/feGC31G3MDkRRbNU0Oqw6r4
 /fA6x0feRgsahyH7aCA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfX14FnenkkrkKH
 te032V1/T4TMk2quaJw4KiLRlFT+2NHwgJc5ApYiyVQlKPtXDC1nl5RShPN8YmkD4ImaosPXiIM
 pF8qdL4yTYkIJvZc0b3f9WnMTzqFXSE=
X-Proofpoint-GUID: bbAQTC9xrzAVc_c3SYzJ3rAfj68k-OM0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609050201
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

VGVzdCBjb25kaXRpb25hbCBjYWxsciwgY29tcG91bmQgdHN0Yml0MC1hbmQtanVtcCBpbnN0cnVj
dGlvbnMgYW5kCmVuZGxvb3AwMS4gIFRoZXNlIGV4ZXJjaXNlIHByZXZpb3VzbHkgdW5jb3ZlcmVk
IGJyYW5jaCBwYXRocyBpbiB0cmFuc2xhdGUuYy4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4g
PGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy90Y2cvaGV4YWdvbi90ZXN0
X2NvbmRfYnJhbmNoLmMgfCAxNjIgKysrKysrKysrKysrKysrKysrKysrKysrKysrCiB0ZXN0cy90
Y2cvaGV4YWdvbi9tZXNvbi5idWlsZCAgICAgICAgfCAgIDEgKwogMiBmaWxlcyBjaGFuZ2VkLCAx
NjMgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3RjZy9oZXhhZ29uL3Rl
c3RfY29uZF9icmFuY2guYwoKZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29uL3Rlc3RfY29u
ZF9icmFuY2guYyBiL3Rlc3RzL3RjZy9oZXhhZ29uL3Rlc3RfY29uZF9icmFuY2guYwpuZXcgZmls
ZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uNzNiZThmYmI0M2MKLS0tIC9kZXYvbnVs
bAorKysgYi90ZXN0cy90Y2cvaGV4YWdvbi90ZXN0X2NvbmRfYnJhbmNoLmMKQEAgLTAsMCArMSwx
NjIgQEAKKy8qCisgKiBDb3B5cmlnaHQgKGMpIFF1YWxjb21tIFRlY2hub2xvZ2llcywgSW5jLiBh
bmQvb3IgaXRzIHN1YnNpZGlhcmllcy4KKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwt
Mi4wLW9yLWxhdGVyCisgKi8KKworLyoKKyAqIFRlc3QgY29uZGl0aW9uYWwgY2FsbHMsIGNvbXBv
dW5kIHRlc3RiaXQwLWFuZC1qdW1wIGluc3RydWN0aW9ucywKKyAqIGFuZCBlbmRsb29wMDEgKGR1
YWwgaGFyZHdhcmUgbG9vcCBlbmQpLgorICovCisKKyNpbmNsdWRlIDxzdGRpby5oPgorI2luY2x1
ZGUgPHN0ZGludC5oPgorCitpbnQgZXJyOworCisjaW5jbHVkZSAiaGV4X3Rlc3QuaCIKKworLyog
VGFyZ2V0IGZ1bmN0aW9uIGZvciBjb25kaXRpb25hbCBjYWxscyAqLworc3RhdGljIGludCBjYWxs
X3RhcmdldF92YWw7CisKK19fYXR0cmlidXRlX18oKG5vaW5saW5lKSkKK3N0YXRpYyB2b2lkIGNh
bGxfdGFyZ2V0KHZvaWQpCit7CisgICAgY2FsbF90YXJnZXRfdmFsID0gNDI7Cit9CisKKy8qCisg
KiBUZXN0IGNvbmRpdGlvbmFsIGNhbGw6IGlmIChQdSkgY2FsbHIgUnMgLyBpZiAoIVB1KSBjYWxs
ciBScworICovCitzdGF0aWMgdm9pZCBjaGVja19jb25kX2NhbGwodm9pZCkKK3sKKyAgICB2b2lk
ICgqZm4pKHZvaWQpID0gY2FsbF90YXJnZXQ7CisKKyAgICAvKgorICAgICAqIGNhbGxyIGNsb2Ji
ZXJzIGFsbCBjYWxsZXItc2F2ZWQgcmVnaXN0ZXJzLgorICAgICAqIEhleGFnb24gY2FsbGVyLXNh
dmVkOiByMC1yNSwgcjE0LXIxNSwgcjI4LCBwMC1wMy4KKyAgICAgKi8KKworICAgIC8qIGlmIChw
MCkgY2FsbHIgUnMgLS0gcHJlZGljYXRlIHRydWUgKi8KKyAgICBjYWxsX3RhcmdldF92YWwgPSAw
OworICAgIGFzbSB2b2xhdGlsZSgicDAgPSBjbXAuZXEoJVtvbmVdLCAlW29uZV0pXG5cdCIgIC8q
IHAwID0gdHJ1ZSAqLworICAgICAgICAgICAgICAgICAiaWYgKHAwKSBjYWxsciAlW2ZuXVxuXHQi
CisgICAgICAgICAgICAgICAgIDoKKyAgICAgICAgICAgICAgICAgOiBbb25lXSAiciIoMSksIFtm
bl0gInIiKGZuKQorICAgICAgICAgICAgICAgICA6ICJyMCIsICJyMSIsICJyMiIsICJyMyIsICJy
NCIsICJyNSIsCisgICAgICAgICAgICAgICAgICAgInIxNCIsICJyMTUiLCAicjI4IiwgInIzMSIs
CisgICAgICAgICAgICAgICAgICAgInAwIiwgInAxIiwgInAyIiwgInAzIiwgIm1lbW9yeSIpOwor
ICAgIGNoZWNrMzIoY2FsbF90YXJnZXRfdmFsLCA0Mik7CisKKyAgICAvKiBpZiAoIXAwKSBjYWxs
ciBScyAtLSBwcmVkaWNhdGUgdHJ1ZSwgc28gIXAwIGlzIGZhbHNlICovCisgICAgY2FsbF90YXJn
ZXRfdmFsID0gMDsKKyAgICBhc20gdm9sYXRpbGUoInAwID0gY21wLmVxKCVbb25lXSwgJVtvbmVd
KVxuXHQiICAvKiBwMCA9IHRydWUgKi8KKyAgICAgICAgICAgICAgICAgImlmICghcDApIGNhbGxy
ICVbZm5dXG5cdCIKKyAgICAgICAgICAgICAgICAgOgorICAgICAgICAgICAgICAgICA6IFtvbmVd
ICJyIigxKSwgW2ZuXSAiciIoZm4pCisgICAgICAgICAgICAgICAgIDogInIwIiwgInIxIiwgInIy
IiwgInIzIiwgInI0IiwgInI1IiwKKyAgICAgICAgICAgICAgICAgICAicjE0IiwgInIxNSIsICJy
MjgiLCAicjMxIiwKKyAgICAgICAgICAgICAgICAgICAicDAiLCAicDEiLCAicDIiLCAicDMiLCAi
bWVtb3J5Iik7CisgICAgY2hlY2szMihjYWxsX3RhcmdldF92YWwsIDApOworCisgICAgLyogaWYg
KCFwMCkgY2FsbHIgUnMgLS0gcHJlZGljYXRlIGZhbHNlLCBzbyAhcDAgaXMgdHJ1ZSAqLworICAg
IGNhbGxfdGFyZ2V0X3ZhbCA9IDA7CisgICAgYXNtIHZvbGF0aWxlKCJwMCA9IGNtcC5lcSglW2Fd
LCAlW2JdKVxuXHQiICAvKiBwMCA9IGZhbHNlICgxICE9IDIpICovCisgICAgICAgICAgICAgICAg
ICJpZiAoIXAwKSBjYWxsciAlW2ZuXVxuXHQiCisgICAgICAgICAgICAgICAgIDoKKyAgICAgICAg
ICAgICAgICAgOiBbYV0gInIiKDEpLCBbYl0gInIiKDIpLCBbZm5dICJyIihmbikKKyAgICAgICAg
ICAgICAgICAgOiAicjAiLCAicjEiLCAicjIiLCAicjMiLCAicjQiLCAicjUiLAorICAgICAgICAg
ICAgICAgICAgICJyMTQiLCAicjE1IiwgInIyOCIsICJyMzEiLAorICAgICAgICAgICAgICAgICAg
ICJwMCIsICJwMSIsICJwMiIsICJwMyIsICJtZW1vcnkiKTsKKyAgICBjaGVjazMyKGNhbGxfdGFy
Z2V0X3ZhbCwgNDIpOworfQorCisvKgorICogVGVzdCBjb21wb3VuZCB0ZXN0Yml0MC1hbmQtanVt
cC4KKyAqIHAwID0gdHN0Yml0KFJzLCAjMCk7IGlmIChbIV1wMC5uZXcpIGp1bXA6dC9udCB0YXJn
ZXQKKyAqLworc3RhdGljIHZvaWQgY2hlY2tfdHN0Yml0MF9qdW1wKHZvaWQpCit7CisgICAgdWlu
dDMyX3QgcmVzdWx0OworCisgICAgLyogUnMgaGFzIGJpdDAgPSAxLCB0ZXN0ICJpZiAocDAubmV3
KSBqdW1wIiAtPiBzaG91bGQganVtcCAqLworICAgIHJlc3VsdCA9IDA7CisgICAgYXNtIHZvbGF0
aWxlKAorICAgICAgICAie1xuXHQiCisgICAgICAgICIgICAgcDAgPSB0c3RiaXQoJVt2YWxdLCAj
MClcblx0IgorICAgICAgICAiICAgIGlmIChwMC5uZXcpIGp1bXA6dCAxZlxuXHQiCisgICAgICAg
ICJ9XG5cdCIKKyAgICAgICAgIiVbcmVzXSA9ICMwXG5cdCIKKyAgICAgICAgImp1bXAgMmZcblx0
IgorICAgICAgICAiMTpcblx0IgorICAgICAgICAiJVtyZXNdID0gIzFcblx0IgorICAgICAgICAi
Mjpcblx0IgorICAgICAgICA6IFtyZXNdICI9ciIocmVzdWx0KQorICAgICAgICA6IFt2YWxdICJy
IigweDUpICAvKiBiaXQgMCBpcyBzZXQgKi8KKyAgICAgICAgOiAicDAiKTsKKyAgICBjaGVjazMy
KHJlc3VsdCwgMSk7CisKKyAgICAvKiBScyBoYXMgYml0MCA9IDAsIHRlc3QgImlmIChwMC5uZXcp
IGp1bXAiIC0+IHNob3VsZCBOT1QganVtcCAqLworICAgIHJlc3VsdCA9IDA7CisgICAgYXNtIHZv
bGF0aWxlKAorICAgICAgICAie1xuXHQiCisgICAgICAgICIgICAgcDAgPSB0c3RiaXQoJVt2YWxd
LCAjMClcblx0IgorICAgICAgICAiICAgIGlmIChwMC5uZXcpIGp1bXA6dCAxZlxuXHQiCisgICAg
ICAgICJ9XG5cdCIKKyAgICAgICAgIiVbcmVzXSA9ICMwXG5cdCIKKyAgICAgICAgImp1bXAgMmZc
blx0IgorICAgICAgICAiMTpcblx0IgorICAgICAgICAiJVtyZXNdID0gIzFcblx0IgorICAgICAg
ICAiMjpcblx0IgorICAgICAgICA6IFtyZXNdICI9ciIocmVzdWx0KQorICAgICAgICA6IFt2YWxd
ICJyIigweDQpICAvKiBiaXQgMCBpcyBjbGVhciAqLworICAgICAgICA6ICJwMCIpOworICAgIGNo
ZWNrMzIocmVzdWx0LCAwKTsKKworICAgIC8qIFJzIGhhcyBiaXQwID0gMCwgdGVzdCAiaWYgKCFw
MC5uZXcpIGp1bXAiIC0+IHNob3VsZCBqdW1wICovCisgICAgcmVzdWx0ID0gMDsKKyAgICBhc20g
dm9sYXRpbGUoCisgICAgICAgICJ7XG5cdCIKKyAgICAgICAgIiAgICBwMCA9IHRzdGJpdCglW3Zh
bF0sICMwKVxuXHQiCisgICAgICAgICIgICAgaWYgKCFwMC5uZXcpIGp1bXA6dCAxZlxuXHQiCisg
ICAgICAgICJ9XG5cdCIKKyAgICAgICAgIiVbcmVzXSA9ICMwXG5cdCIKKyAgICAgICAgImp1bXAg
MmZcblx0IgorICAgICAgICAiMTpcblx0IgorICAgICAgICAiJVtyZXNdID0gIzFcblx0IgorICAg
ICAgICAiMjpcblx0IgorICAgICAgICA6IFtyZXNdICI9ciIocmVzdWx0KQorICAgICAgICA6IFt2
YWxdICJyIigweDQpICAvKiBiaXQgMCBpcyBjbGVhciAqLworICAgICAgICA6ICJwMCIpOworICAg
IGNoZWNrMzIocmVzdWx0LCAxKTsKK30KKworLyoKKyAqIFRlc3QgZW5kbG9vcDAxOiBhIHBhY2tl
dCB0aGF0IHRlcm1pbmF0ZXMgYm90aCBsb29wMCBhbmQgbG9vcDEuCisgKiBPdXRlciBsb29wIHJ1
bnMgMyBpdGVyYXRpb25zLCBpbm5lciBsb29wIHJ1bnMgNC4KKyAqLworc3RhdGljIHZvaWQgY2hl
Y2tfZW5kbG9vcDAxKHZvaWQpCit7CisgICAgdWludDMyX3QgY291bnQ7CisKKyAgICBhc20gdm9s
YXRpbGUoCisgICAgICAgICIlW2NudF0gPSAjMFxuXHQiCisgICAgICAgICJsb29wMSgxZiwgIzMp
XG5cdCIgICAgLyogb3V0ZXIgbG9vcDogMyBpdGVyYXRpb25zICovCisgICAgICAgICIxOlxuXHQi
CisgICAgICAgICJsb29wMCgyZiwgIzQpXG5cdCIgICAgLyogaW5uZXIgbG9vcDogNCBpdGVyYXRp
b25zICovCisgICAgICAgICIyOlxuXHQiCisgICAgICAgICJ7ICVbY250XSA9IGFkZCglW2NudF0s
ICMxKSB9OmVuZGxvb3AwMVxuXHQiCisgICAgICAgIDogW2NudF0gIj1yIihjb3VudCkpOworCisg
ICAgLyogMyBvdXRlciAqIDQgaW5uZXIgPSAxMiB0b3RhbCBpdGVyYXRpb25zICovCisgICAgY2hl
Y2szMihjb3VudCwgMTIpOworfQorCitpbnQgbWFpbih2b2lkKQoreworICAgIGNoZWNrX2NvbmRf
Y2FsbCgpOworICAgIGNoZWNrX3RzdGJpdDBfanVtcCgpOworICAgIGNoZWNrX2VuZGxvb3AwMSgp
OworCisgICAgcHV0cyhlcnIgPyAiRkFJTCIgOiAiUEFTUyIpOworICAgIHJldHVybiBlcnIgPyAx
IDogMDsKK30KZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29uL21lc29uLmJ1aWxkIGIvdGVz
dHMvdGNnL2hleGFnb24vbWVzb24uYnVpbGQKaW5kZXggNmM4ZTI2ODc2YWYuLmFhMTc2ZTU2ODgz
IDEwMDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9tZXNvbi5idWlsZAorKysgYi90ZXN0cy90
Y2cvaGV4YWdvbi9tZXNvbi5idWlsZApAQCAtNzMsNiArNzMsNyBAQCB0ZXN0cyArPSB7CiAgICd0
ZXN0X2NhbGwuUyc6IHsnY2ZsYWdzJzogYXNtZmxhZ3N9LAogICAndGVzdF9jbG9iYmVyLlMnOiB7
J2NmbGFncyc6IGFzbWZsYWdzfSwKICAgJ3Rlc3RfY21wLlMnOiB7J2NmbGFncyc6IGFzbWZsYWdz
fSwKKyAgJ3Rlc3RfY29uZF9icmFuY2guYyc6IHsnY2ZsYWdzJzogY2ZsYWdzfSwKICAgJ3Rlc3Rf
ZG90bmV3LlMnOiB7J2NmbGFncyc6IGFzbWZsYWdzfSwKICAgJ3Rlc3RfZXh0LlMnOiB7J2NmbGFn
cyc6IGFzbWZsYWdzfSwKICAgJ3Rlc3RfZmlib25hY2NpLlMnOiB7J2NmbGFncyc6IGFzbWZsYWdz
fSwKLS0gCjIuMzQuMQoK

