Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC9AEF48C2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 02:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqjLd-0006Du-5M; Thu, 12 Feb 2026 21:56:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vqjLZ-0006CO-Vm
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 21:55:58 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vqjLY-0005Dz-9Z
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 21:55:57 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61CIlNsr455058
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 02:55:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GexMtmgfGvMqUlr405tGcNusaInSecWFUKDx3/DCuI8=; b=BJ9DLfW5ECWU8CGO
 5MQn6NqpB6809mvPFDLD6uDYyKhHSNcNsZdTbkr/HJ/uEDkEH3uCg5djPIjZ/Gv9
 VTPdwHjFZII1QHcBk8spvVnzNgX3cPsInHyNHGbzKmngFNTqjcG5DFbd7z1SPmwK
 SsIyKn/Y65CA8g3KiO1/cls/b1+DkV8df9wOwT/jTDtQ1w7zP1U7JfXjX/TwB1uP
 BR8Pvj3CKWSVy7a0iCYxwDvP/OqUz2nKhAvmO3Q719dAM5ng9uUZacOEyRcRHh+N
 Etn/QvH+uDMTciwrp2HMNrLsE9/8n590sD+zKQmydQ0YTiwL9ZA0Z3qByCNLrHcD
 A4Akrg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9mev1g2p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 02:55:54 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2b6b9c1249fso741710eec.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 18:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770951353; x=1771556153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GexMtmgfGvMqUlr405tGcNusaInSecWFUKDx3/DCuI8=;
 b=Ci3QsItrx72wE6HEmJA4Pop3w9mkwY5FpIB9UO6U0DP7W6Eml9YDmSrlZeYQZ4wh/S
 +QIEtcz1JPRkdlvWC7ZvuvwHQ590WxnJeRZM60PQq6bOrShgdDih787paeBnJMpJk7b0
 QEQeKKRAE3iknmAWq2K6hF1ovTYPPiL3CfpPWy6625hFboUsXBURwdhuCebipi3A9zuX
 Ha3AbG9Hu8UAeh+wUh5M2USDgBhNX+fxqqVJtJxb3DLh+slt7qf6mgH9d7EMaklfcbjY
 w6a1xuqh4Ih6u4qZXgi8RJ5CNPdgqhw3ZQxP0gqcTvPcSpfcS4W6WJAtTE5zT5BVPs+G
 Q2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770951353; x=1771556153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GexMtmgfGvMqUlr405tGcNusaInSecWFUKDx3/DCuI8=;
 b=LyRUGntXEuK8CtRx7wKTx2jJrx2JBoRweZMdwRUCKwvlvQGFhnwMzf7zlpDKa6J+oO
 fdBoUpJhnkseWIBjlzNpykRsAYYFKIP4pmVLr/ixcge7vMO2H79Ips2YOMm0N4Aed8qR
 LarI/ZTs35lgrYdA14643/i+zdDKWdx0VbJVIow8qyjhfLW4fmWuKjbI1wcbCK56WYxv
 RXZJJM8eX/u8zWdB3xAaicK/HoD0ceNYijSZyn/qCdooNW/C+tGU9Z3iKnCPcVnLsFoJ
 6FqSC1jWXCu8hXNLzDpmERT4cblfGC+HXqz5VvSej3LoJ6IMdbjt5s3/Abw7kaHwpjWP
 iIeg==
X-Gm-Message-State: AOJu0Yypnel2OgE/vxDhhaoZEZ8bTVDgicUknkYZcZPSzmgIKv3QOHO/
 p2SpRqBwXj6T6HWX7HkEaZFsgIcsClh2tQA7FFNjw7ZVXyEKAIe2q1F/kCjmSKxg/fntwKDRnUh
 IzSMRgHK3HebdWsIso5ZrRNVMltGzBQAwmCoBdkVfYh2BIp4O4ZiTDgefhvX5MiODeQ==
X-Gm-Gg: AZuq6aK9Owf+xP5cuC4VrTox+z6M8iie2KAU1XutwiabkSdOX2MiYEs+PewGzWK1AVP
 owMpWBsYyGG1lIHC+H6eHNnLp8cVB89NWUvJ+EAvxHDP+6sgQgAPFqXIyXf34pkZUBGlTtl6tcb
 I8OSQSjHYuGiRBjCBaxLGth73a6Z2Frff1gTXq+lBFaaqj3DFr43+jOiEOOVxfwd3k1N2QOtIBk
 pF7SMCRk3PFBh7IO3gTeHQTB5m8Gpmpj5/PQwQuE+GaDbVRWp0xuGl7xPOADpIw6gP5zP7isiQb
 BhHD0dErtg9N7vLt8ReDSigtyhowCNveWOdkObJqCNLa4mAtAQ5TgXPuHijgsxArkTcUo1pfybT
 XlsWgChdh8q+FTIW5Bt39kWZujYBOoAqYndv80Lr0rl8L66R7X6DR1C9cuVBU8UK5/yRjoA==
X-Received: by 2002:a05:7301:1695:b0:2ba:68d6:47b6 with SMTP id
 5a478bee46e88-2babc4a9f6emr125435eec.35.1770951352910; 
 Thu, 12 Feb 2026 18:55:52 -0800 (PST)
X-Received: by 2002:a05:7301:1695:b0:2ba:68d6:47b6 with SMTP id
 5a478bee46e88-2babc4a9f6emr125426eec.35.1770951352404; 
 Thu, 12 Feb 2026 18:55:52 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ba9dbd5d3esm4500943eec.10.2026.02.12.18.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 18:55:52 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 2/7] target/hexagon: Return decode failure for invalid
 non-duplex encodings
Date: Thu, 12 Feb 2026 18:55:39 -0800
Message-Id: <20260213025544.2497992-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260213025544.2497992-1-brian.cain@oss.qualcomm.com>
References: <20260213025544.2497992-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=Zq7g6t7G c=1 sm=1 tr=0 ts=698e92ba cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=D67r-eMCZ0zeLs--bqkA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: _gKRVDT57z6q848fbKTd6LZnv2wh7JqA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDAyMSBTYWx0ZWRfX6P14VE62liv7
 JtBoXi7dTjKt4sEwcMKJuwvzhbqJBp6NaUJBXqUpk8B9ZuOlOjgoKIBbFg58pMhJs0qTXryy7Vm
 vhzkKsGJOpGJ9TM3QI6oS1X6VQuyjzu9UwCvPcQCDAsxTXB3g++vV1JoE5Q38uI7taGWUuhEIWp
 zAyWNMrxxYJC7LgF/dw5EYIM5kGUjrS6QR8wXsTLDM42asQB9n0bpjltrX2J03SH4E0ySlwBW5l
 KH7lcrC81rWsbDVuF3UyGyR5wgZTo1cCdyuu8/6vKYMKS6kuNosKkZJw1nnvAx4/Zj6LJ34AFAb
 V/29Z7gOtllOehIPFnx6NMdKlsnYCR5r4vur1RWo+LObPBTjVgB+2TMZM18oR91/xObhuya/7UG
 vlRBnwRF2huuEW/gVhDZBImbuxsPl++7Ed2vm5+pgGcrdE0fGWDQsPbmLUAJL3n/SntOOElIOBL
 CHtQbaKFtReTc5YqFuA==
X-Proofpoint-GUID: _gKRVDT57z6q848fbKTd6LZnv2wh7JqA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602130021
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

V2hlbiBhIG5vbi1kdXBsZXggZW5jb2RpbmcgKHBhcnNlX2JpdHMgIT0gMCkgZmFpbHMgYm90aCBk
ZWNvZGVfbm9ybWFsKCkKYW5kIGRlY29kZV9odngoKSwgdGhlIGRlY29kZXIgaGl0IGFuIHVucmVh
Y2hhYmxlLiAgSW5zdGVhZCwgaGFuZGxlCnRoZSBkZWNvZGUgZmFpbHVyZSBhbmQgcmFpc2UgYW4g
ZXhjZXB0aW9uLgoKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZp
ZXJAbGluYXJvLm9yZz4KUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNv
bkBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1
YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9kZWNvZGUuYyAgICAgICAgICAgICAgfCAg
MyArKy0KIHRlc3RzL3RjZy9oZXhhZ29uL2ludmFsaWQtZW5jb2RpbmcuYyB8IDI1ICsrKysrKysr
KysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jIGIvdGFyZ2V0
L2hleGFnb24vZGVjb2RlLmMKaW5kZXggNjliYTFlYzk2Yy4uMzNhZDYwYzViNCAxMDA2NDQKLS0t
IGEvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMK
QEAgLTQ4OSw3ICs0ODksOCBAQCBkZWNvZGVfaW5zbnMoRGlzYXNDb250ZXh0ICpjdHgsIEluc24g
Kmluc24sIHVpbnQzMl90IGVuY29kaW5nKQogICAgICAgICAgICAgaW5zbi0+aWNsYXNzID0gaWNs
YXNzX2JpdHMoZW5jb2RpbmcpOwogICAgICAgICAgICAgcmV0dXJuIDE7CiAgICAgICAgIH0KLSAg
ICAgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICAgICAgLyogSW52YWxpZCBub24tZHVw
bGV4IGVuY29kaW5nICovCisgICAgICAgIHJldHVybiAwOwogICAgIH0gZWxzZSB7CiAgICAgICAg
IHVpbnQzMl90IGljbGFzcyA9IGdldF9kdXBsZXhfaWNsYXNzKGVuY29kaW5nKTsKICAgICAgICAg
dW5zaWduZWQgaW50IHNsb3QwX3N1Ymluc24gPSBnZXRfc2xvdDBfc3ViaW5zbihlbmNvZGluZyk7
CmRpZmYgLS1naXQgYS90ZXN0cy90Y2cvaGV4YWdvbi9pbnZhbGlkLWVuY29kaW5nLmMgYi90ZXN0
cy90Y2cvaGV4YWdvbi9pbnZhbGlkLWVuY29kaW5nLmMKaW5kZXggMDEwYTVlYjc0MS4uNjM5ZDdm
MjQ5NSAxMDA2NDQKLS0tIGEvdGVzdHMvdGNnL2hleGFnb24vaW52YWxpZC1lbmNvZGluZy5jCisr
KyBiL3Rlc3RzL3RjZy9oZXhhZ29uL2ludmFsaWQtZW5jb2RpbmcuYwpAQCAtNjUsNiArNjUsMzAg
QEAgc3RhdGljIGludCB0ZXN0X2ludmFsaWRfZHVwbGV4KHZvaWQpCiAgICAgcmV0dXJuIHNpZzsK
IH0KIAorLyoKKyAqIEludmFsaWQgbm9uLWR1cGxleCBlbmNvZGluZzoKKyAqIFRoZSBlbmNvZGlu
ZyAweGZmZmZjMDAwIGhhcyBwYXJzZSBiaXRzIFsxNToxNF0gPSAwYjExLCBtYWtpbmcgaXQgYQor
ICogbm9uLWR1cGxleCBpbnN0cnVjdGlvbiBhbmQgcGFja2V0IGVuZC4gIFRoZSByZW1haW5pbmcg
Yml0cyBkbyBub3QgbWF0Y2gKKyAqIGFueSB2YWxpZCBub3JtYWwgb3IgSFZYIGluc3RydWN0aW9u
IGVuY29kaW5nLCBzbyB0aGlzIHNob3VsZCByYWlzZSBTSUdJTEwuCisgKi8KK3N0YXRpYyBpbnQg
dGVzdF9pbnZhbGlkX25vbmR1cGxleCh2b2lkKQoreworICAgIGludCBzaWc7CisKKyAgICBhc20g
dm9sYXRpbGUoCisgICAgICAgICJyMCA9ICMwXG4iCisgICAgICAgICJyMSA9ICMjMWZcbiIKKyAg
ICAgICAgIm1lbXcoJTEpID0gcjFcbiIKKyAgICAgICAgIi53b3JkIDB4ZmZmZmMwMDBcbiIKKyAg
ICAgICAgIjE6XG4iCisgICAgICAgICIlMCA9IHIwXG4iCisgICAgICAgIDogIj1yIihzaWcpCisg
ICAgICAgIDogInIiKCZyZXN1bWVfcGMpCisgICAgICAgIDogInIwIiwgInIxIiwgIm1lbW9yeSIp
OworCisgICAgcmV0dXJuIHNpZzsKK30KKwogaW50IG1haW4oKQogewogICAgIHN0cnVjdCBzaWdh
Y3Rpb24gYWN0OwpAQCAtNzUsNiArOTksNyBAQCBpbnQgbWFpbigpCiAgICAgYXNzZXJ0KHNpZ2Fj
dGlvbihTSUdJTEwsICZhY3QsIE5VTEwpID09IDApOwogCiAgICAgYXNzZXJ0KHRlc3RfaW52YWxp
ZF9kdXBsZXgoKSA9PSBTSUdJTEwpOworICAgIGFzc2VydCh0ZXN0X2ludmFsaWRfbm9uZHVwbGV4
KCkgPT0gU0lHSUxMKTsKIAogICAgIHB1dHMoIlBBU1MiKTsKICAgICByZXR1cm4gRVhJVF9TVUND
RVNTOwotLSAKMi4zNC4xCgo=

