Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1C210F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYSq-0004an-9W; Wed, 08 Apr 2026 15:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAY3q-00067G-F0
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:55:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAKQO-0005iA-2N
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:21:57 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6382ZIGR2412265
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 04:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=ydC2fs+QPd4b5p/ut3R0AWJhnR2AhMIhRgDJsIwO3xo=; b=S9
 oz9nSS3R6ZvoRfaKN472K/m+2efpSdj0s8l499AR0ytlexpQBRTTC0PwGvAod/pd
 Fhk5zwpiGPtbcvtnILoNsqbpv9GWnFYAccI2RUSPJr9cDlvC2/Zo0/cE9GCu7BmQ
 Ob0TkyKhU9Dh9VJamNlXves5LMVFLsqsf/70/TPIjh1wfwndCpSgCcn37cZb1ZV6
 YqONp1O8L2yfk75KSye/dDjsARfmax8Ouw+LTyl0u+0AdD8ieXnKsySx9tC8BNTr
 RQmCzdNYzWspDksHZpXrNmHDNFOppHwhNEtIbZ1kT0gULEnIQvlAKyWXin7k9wxX
 O0IpEidwwdq0h5hnT4YA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd61v9xaf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:21:55 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-12776bebeb3so23525229c88.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 21:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775622114; x=1776226914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ydC2fs+QPd4b5p/ut3R0AWJhnR2AhMIhRgDJsIwO3xo=;
 b=Z/Iv1TVfNDcKqJ8A5lApmX0X7h+jZub1efD62dwcy9zq7LFzOn+RIVTuTt2zEDldHU
 V2hOfFHEeenEGxJ3fMJVEaKf3d3lgbor05fJxcpfqOfzFpJTofAvebCrSYyMRzlZg1Ht
 MzW1hfc0XBmGIQe+NEcHyUnQJdPXdUnnfFOYNRym39LiQ79L8hNGTrvoKm6pS+f6tjY5
 AbXdvdI3/LnPOZfVhoCVE2voc+Jeb9zV5odYMEpjNrDaOig5O6SKH8qxJYHd/2LdHE+Z
 se8cT0G8h/OVR1CuJPyatk1qmtuUOO98E2udS9BHhHQgIFQmtanK4Lwjjq3Uwm13mPSW
 Y96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775622114; x=1776226914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ydC2fs+QPd4b5p/ut3R0AWJhnR2AhMIhRgDJsIwO3xo=;
 b=LgeoChKo1a/AhoMya7h3+P+hs2WuIDo8VobxSWhAp/GlVT9RzQfP1tmnvpWmBdJxr/
 DoG8Hvs8queF4AVEKOobxyPDsekwxsEnS9PvcxwhX+4P6z/7XYCb5sj9mfFvd2efim0H
 ixq+Mm62ny5ZVkbrXWWbcHNvpW9ITAMCJPor/03YHa3K04qOUNI6SIDq/Bi7yHce3k9v
 OkiwdxBGN/NiogxZWWxuuxvdCIGoIH3o/cHI5Er92aRHqsDlTT3sJrrh2IO7CdPID4LT
 U3EutnLTqEl6WzN4MGFuZSQ04+NiarVuN/4gAdPNjWkqJ+T4JQtDZrq8CSCkxqwz+bHq
 Z2mw==
X-Gm-Message-State: AOJu0YwRC06oyDCquUsFTnXoYipG2rZDaj2FOC2Jo+bKnwHZ4VKnc51H
 Kz+E0eEUFh16DAD6/nQ7gde6kgADOeeO4+mPElmbnSLHSyBvimsXA0QBG0Kw2836KfXtDFu6pk4
 BrmUjfGdILiUy0IpXieYCKki5RQIRTchk97yvvGghCRdDvMqFBdkhk8mFF1U+bJnlow==
X-Gm-Gg: AeBDieuYWFOfx7fPEONJDdazYCwk83yQnkTHNx4c4pldnrEijoJp9TXeYlcoEmlMqZo
 qo9DGsKU/BMcn9rABkSZmNimpj2XH1ytdz++EDAsM4DdyB/Ey1EKMM2zBHDhPCuDuDk2d0JIzXi
 ojCu0BukLZm4MkuWtPbxsBnh4xluZWCiaiqM3QaFPKBO4xIyRvrkFitTWL8BWK1MXg2D4gHX2YY
 LClFp/05V76bG0vHWjF1sRzSgYz1CjlMPfu2ITGm2obwQYBGryKpYtA0fa6aXm+GYHsi40gigk6
 zvdoAfw5dZF92IoqBXuZ/OUlIoJOu1hfUgKtQb4S/n2nxnx3Yyyt2gC7zPAZevvojfbJTtVZ5oe
 yMGp0h1/pANtXYO0qtpPMmNnguAJbUAkc754PkVBZ2IGdVXF3lGoPJf94p1uD7UkKCqyPiQ==
X-Received: by 2002:a05:7022:6725:b0:12b:ed30:5b85 with SMTP id
 a92af1059eb24-12bfb6ecb3emr9135834c88.2.1775622113869; 
 Tue, 07 Apr 2026 21:21:53 -0700 (PDT)
X-Received: by 2002:a05:7022:6725:b0:12b:ed30:5b85 with SMTP id
 a92af1059eb24-12bfb6ecb3emr9135821c88.2.1775622113239; 
 Tue, 07 Apr 2026 21:21:53 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bed93f861sm23474816c88.0.2026.04.07.21.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 21:21:52 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 2/9] hw/hexagon: Add global register tracing
Date: Tue,  7 Apr 2026 21:21:41 -0700
Message-Id: <20260408042149.1902796-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408042149.1902796-1-brian.cain@oss.qualcomm.com>
References: <20260408042149.1902796-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX3KufGbahvXOA
 yaZ+RaRx1EpdB9iZLF4qD/hdtGHT5nlYA73jtIje+mkHYViPx7Auxn1FcxktkzZZLgjbEBtJUM1
 Pv4/inRqXE0LoRIReuB7U7aKHTNUPulRWSSahI0ZaUVS8mZ39pBzwinGasZTKRHAgyZ+GaxrKUl
 2b6/wM+7bS1iYUg4CoFu4ZDAPyuOIa2V+iDrKvIjDukH3cDw2skmlMvsusJdziT+oPLoqubEsbP
 PP7hEFJgXRAgjpsBWfuT5m8sHUYjaZAb9TlztGrjYLpgtlfABGfuXU9Q+lOJaEn2Za2ekkSiLP7
 xmXP3TnN/ywHlREFmb2onM2JblmSBgV7cc2VIVudc4OSUET0dWrVLJ1oc/qGZxLty4UyCoFsJha
 Nr6D8mxuqSPhfGNwFIqkPg5dIoZ4UakBYiFKsUgvnWIxc4uBFY1XsWUFJJhugcegpa94nxBHsjK
 PLS/sEtFQoDpnGICMEg==
X-Authority-Analysis: v=2.4 cv=FecHAp+6 c=1 sm=1 tr=0 ts=69d5d7e3 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=8QmChvNvioVktlEtA_0A:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: rts389xXuDyC7h6AYdZ7lPOZoF1rhCfH
X-Proofpoint-GUID: rts389xXuDyC7h6AYdZ7lPOZoF1rhCfH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080036
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

UmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4K
U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIG1lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICB8ICAxICsKIGh3L2hleGFnb24vdHJh
Y2UuaCAgICAgICAgICAgICB8ICAyICsKIGh3L2hleGFnb24vaGV4YWdvbl9nbG9iYWxyZWcuYyB8
IDczICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIGh3L2hleGFnb24vdHJhY2Ut
ZXZlbnRzICAgICAgICB8ICAzICsrCiA0IGZpbGVzIGNoYW5nZWQsIDc5IGluc2VydGlvbnMoKykK
IGNyZWF0ZSBtb2RlIDEwMDY0NCBody9oZXhhZ29uL3RyYWNlLmgKIGNyZWF0ZSBtb2RlIDEwMDY0
NCBody9oZXhhZ29uL3RyYWNlLWV2ZW50cwoKZGlmZiAtLWdpdCBhL21lc29uLmJ1aWxkIGIvbWVz
b24uYnVpbGQKaW5kZXggZGFhNThlNDZhM2MuLjA2M2M2NjhjY2U1IDEwMDY0NAotLS0gYS9tZXNv
bi5idWlsZAorKysgYi9tZXNvbi5idWlsZApAQCAtMzYyNSw2ICszNjI1LDcgQEAgaWYgaGF2ZV9z
eXN0ZW0KICAgICAnaHcvZGlzcGxheScsCiAgICAgJ2h3L2RtYScsCiAgICAgJ2h3L2ZzaScsCisg
ICAgJ2h3L2hleGFnb24nLAogICAgICdody9oeXBlcnYnLAogICAgICdody9pMmMnLAogICAgICdo
dy9pM2MnLApkaWZmIC0tZ2l0IGEvaHcvaGV4YWdvbi90cmFjZS5oIGIvaHcvaGV4YWdvbi90cmFj
ZS5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwLi45ZTBiMzlmM2M2Ngot
LS0gL2Rldi9udWxsCisrKyBiL2h3L2hleGFnb24vdHJhY2UuaApAQCAtMCwwICsxLDIgQEAKKy8q
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyICovCisjaW5jbHVkZSAi
dHJhY2UvdHJhY2UtaHdfaGV4YWdvbi5oIgpkaWZmIC0tZ2l0IGEvaHcvaGV4YWdvbi9oZXhhZ29u
X2dsb2JhbHJlZy5jIGIvaHcvaGV4YWdvbi9oZXhhZ29uX2dsb2JhbHJlZy5jCmluZGV4IDYzNGQz
YjE2OWZkLi4zNGE0Y2E5ZjJiMiAxMDA2NDQKLS0tIGEvaHcvaGV4YWdvbi9oZXhhZ29uX2dsb2Jh
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
PSB7CiAgICAgW0hFWF9TUkVHX0VWQl0gPSAweDAwMDAwMGZmLApAQCAtNzUsNiArMTQ2LDcgQEAg
dWludDMyX3QgaGV4YWdvbl9nbG9iYWxyZWdfcmVhZChIZXhhZ29uR2xvYmFsUmVnU3RhdGUgKnMs
IHVpbnQzMl90IHJlZywKIAogICAgIHZhbHVlID0gcy0+cmVnc1tyZWddOwogCisgICAgdHJhY2Vf
aGV4YWdvbl9nbG9iYWxyZWdfcmVhZChodGlkLCBnZXRfc3JlZ19uYW1lKHJlZyksIHZhbHVlKTsK
ICAgICByZXR1cm4gdmFsdWU7CiB9CiAKQEAgLTg1LDYgKzE1Nyw3IEBAIHZvaWQgaGV4YWdvbl9n
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

