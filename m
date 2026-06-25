Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A3ECDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcktq-0007RW-6n; Thu, 25 Jun 2026 10:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcktk-00072W-67
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:17:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wckti-00005I-Cj
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:17:43 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9k4i52048176
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A6hX7dXQXO1+fIeZgKUska/ZVbxUwMZyizq5wXsBD70=; b=EmT4rkAnGyCgosYl
 MWiALQKktkfLYdZ5noYE0YXHRQrinR/i4BIpjOzzvUGn1s9cXWMMa47gmsjifD+i
 zH4mSMTSLYDKBetdcwUTh74ptab0PgUmSZ0qrKNwi3PdGPQvZyWK3/bDg88B6oCS
 RsMsXdtiXuMwQbV0mKcbJK+mo//pZvP0IZbhPzaSgaVdoQS2XcmaAU7828hskNnt
 3PC/NSN8xh1Lhj0YpNfcpIHQXta9Qji6nrCuDCfAYXOnNSYV3jDhLHTOvClKniJS
 Pe2+FQpGdKmDl2Ou802i56HVttsRpkVwtdJAfakZSug8Cge2jlXqLPrGFgN4X42s
 N76s2w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0uyqjf5n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:31 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c50cd6cbcso2571768eec.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782397050; x=1783001850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A6hX7dXQXO1+fIeZgKUska/ZVbxUwMZyizq5wXsBD70=;
 b=Xe/SrkAITZgyXME1I86AwJUiGeI5fT4BuoAdguRyfo18Z8W621lvQNClgxsR7NQj54
 OWB5cnIyt+vK5cIZHS8k5J5sYE0cFWNH10X2+SyNvKNeT0+mBa8DH6DG5NQxHs1GhHzr
 a6+0l31miDT3uEf8h4tDzV1jqYOzVEuRlExktA1N8xGIHbaXDv3Uj1coEWmDZqG3UybE
 1Et+9IQvt+OhgXUxwp68c6z6fQ+jz9Rmmcgr8so+NCDRCVCE7r7Ais2DagEGUNe3T57B
 IcpZth2FtH4ArLJuJySQqte7dGVRqhAmaqwc9V2nq9gyCGVLMHQ7hIFOKe/2KnaWUMKq
 TrWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782397050; x=1783001850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A6hX7dXQXO1+fIeZgKUska/ZVbxUwMZyizq5wXsBD70=;
 b=oE4e00+WNqv/2qRoYhChONDATU7LTxY51dwO4SHMOBXZUvwFA6fPFAmhBVuMBsT3m2
 oVoX+AU1TZ4xl2d9bGeoXqB3kawCQdqhhrQbk+j/VSsXqLidD1OF6FwOjdeVv8/e1VNG
 EX1sRCvll9+I0d2rX8hyFp6z/lswpBK/5lqMMnGcxDy2L98xmTgDyAVRxey6NMVTOa2P
 +PBcsGzc4A4uiNKDpZe2kE7uMbdWaGKPtUROjJFoMWRwpfqG9Wt1j5wcDB+4TcGEYYR3
 pzakyRBaUvyT3RphEDcblJkWj8m68TGCm6ve7bNwL2k9p0Cj7+MEzg5rF7zkfTwPRZUh
 QpiQ==
X-Gm-Message-State: AOJu0Yz3SOfoD84YIgmaAxZuWZI4gmUFmNmQCLTS5gq4UNE3mxWRv3Iv
 imJSg17+O77tG2g4ebS1de2XZUJKFImGqDOmnHaURtVrApKJC9f2W40PdzCZDwGUJ0ckj6Qk5TZ
 BuCXEuazY2vY2+VlTiLVyTuT/5EFj29L36LQJTtXvdfUX5HLbTTBAR4d6hEeUH6h6Ow==
X-Gm-Gg: AfdE7clI8reaNEKOjugWnQILPcXklrONC8LuKa71mvOuTlPGpLOCro2iPGiYAHXwwAc
 bapDpDNRgQiw+korJQEszrhQz4KjYJ604daf//VlLY4cj5pyqm/vuTjPl4nEtcstOlefyRYnLUi
 nt+2zS0VBojrFfJjaLn1AO9aEjxraCl1cTxCOc3T1kvNJu0+rdVVU9bfhRqrV0hQpW8wMOEBKKj
 WocClpp5mGyYv1di1WXjcvsCuJURJyXsXl6zkYMp4HrbRJt7cSLmy+m1ACkqkvV0sDrcleHoGwr
 8s0WepS6DhuKJAnankagGzfIl/3QV1wy0hakGp1Dcm/ej7SkRsThL9NQG89xEE9MijLCug5FSO1
 f9+e7QU1hNbzb0qGAT2tCNCBhbKGq3JfCn2rxvkrLnLOxH7GLVrfs/WkmO9s=
X-Received: by 2002:a05:7300:8606:b0:30c:5807:abc7 with SMTP id
 5a478bee46e88-30c84cac264mr3151650eec.17.1782397050192; 
 Thu, 25 Jun 2026 07:17:30 -0700 (PDT)
X-Received: by 2002:a05:7300:8606:b0:30c:5807:abc7 with SMTP id
 5a478bee46e88-30c84cac264mr3151589eec.17.1782397049584; 
 Thu, 25 Jun 2026 07:17:29 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ae5sm10168446eec.16.2026.06.25.07.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:17:28 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 27/76] target/hexagon: Add implicit attributes to sysemu
 macros
Date: Thu, 25 Jun 2026 07:15:44 -0700
Message-Id: <20260625141633.449487-28-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: CAUbIkoXzscjwsJrGOl7fYKgd8uI39lw
X-Proofpoint-ORIG-GUID: CAUbIkoXzscjwsJrGOl7fYKgd8uI39lw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfXwNu9MKR7I9uB
 Wfd5KAawOEEeScLJmdWzcJ6onwKXBlN8RGl7L6S46C595R/PZzRgt7ZPyYbEN3uxfxwa2cGw3eq
 Yyc9N/eyO2k22GkJsBBFhyADGDZgmqQ=
X-Authority-Analysis: v=2.4 cv=EsLiaycA c=1 sm=1 tr=0 ts=6a3d387b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=jiUnMIOmsb6gMTORg9AA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX55W4eMh5rj1K
 8LzC5m0R+9cuZv9QDx3TVdK3U4wWZAzlEKkYtxLmF+IBWlEjQgP3q+122ZH3I9U9yHOGoKHp+I2
 8dh/cm78Z3UfMd9V0p1hgnDF53AfsZb+hZGAyc2H9syh8SnG4y/m3oAOUMC08JOwjaBYK1iIPT2
 vaSEFxk/lVwIVRGgVEQTII4N63XxXy6PP9fpRkCuXJP48/qSd1BkXRHDreK9lpNRqFyflWOLLKk
 uUFdg0YTrUrylyLV+319KtbZP/js2I9iu7LPDwZH/Nm7fkqbeQ5O4W9iy4Ei8f9eiMrUNRbA4K/
 /ZyLd+PH9AAuGKt4ci4vPJLIy+Gg1IOxLya4/aFu6wKfxppvRkF5KH38FLYKi0+lavZN322lnbk
 yQuSkuR5+GaTj74EP70px5M85mvUhcc401kHa2SmiwDCsnL9OkNf3DehIgtMz8+EKM01xcQCjka
 VRN0HtlWldfmX0hAE0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 adultscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250122
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hl
eF9jb21tb24ucHkgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkgYi90YXJnZXQvaGV4YWdvbi9o
ZXhfY29tbW9uLnB5CmluZGV4IDhjNmEwNTg5Zjg4Li5hY2FhYTNjOTQ0YSAxMDA3NTUKLS0tIGEv
dGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQorKysgYi90YXJnZXQvaGV4YWdvbi9oZXhfY29t
bW9uLnB5CkBAIC0xMjgsOCArMTI4LDExIEBAIGRlZiBjYWxjdWxhdGVfYXR0cmlicygpOgogICAg
IGFkZF9xZW11X21hY3JvX2F0dHJpYigiZlRSQVAiLCAiQV9JTVBMSUNJVF9SRUFEU19QQyIpCiAg
ICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCJmU0VUX09WRVJGTE9XIiwgIkFfSU1QTElDSVRfV1JJ
VEVTX1VTUiIpCiAgICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCJmU0VUX0xQQ0ZHIiwgIkFfSU1Q
TElDSVRfV1JJVEVTX1VTUiIpCisgICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCJmQ0xFQVJfUlRF
X0VYIiwgIkFfSU1QTElDSVRfV1JJVEVTX1NTUiIpCiAgICAgYWRkX3FlbXVfbWFjcm9fYXR0cmli
KCJmTE9BRCIsICJBX1NDQUxBUl9MT0FEIikKICAgICBhZGRfcWVtdV9tYWNyb19hdHRyaWIoImZT
VE9SRSIsICJBX1NDQUxBUl9TVE9SRSIpCisgICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCJmU0VU
X0swX0xPQ0siLCAiQV9JTVBMSUNJVF9SRUFEU19QQyIpCisgICAgYWRkX3FlbXVfbWFjcm9fYXR0
cmliKCJmU0VUX1RMQl9MT0NLIiwgIkFfSU1QTElDSVRfUkVBRFNfUEMiKQogICAgIGFkZF9xZW11
X21hY3JvX2F0dHJpYignZkxTQk5FVzAnLCAnQV9JTVBMSUNJVF9SRUFEU19QMCcpCiAgICAgYWRk
X3FlbXVfbWFjcm9fYXR0cmliKCdmTFNCTkVXME5PVCcsICdBX0lNUExJQ0lUX1JFQURTX1AwJykK
ICAgICBhZGRfcWVtdV9tYWNyb19hdHRyaWIoJ2ZSRUFEX1AwJywgJ0FfSU1QTElDSVRfUkVBRFNf
UDAnKQotLSAKMi4zNC4xCgo=

