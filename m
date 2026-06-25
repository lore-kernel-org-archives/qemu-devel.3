Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58580CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclOC-0003g2-Dp; Thu, 25 Jun 2026 10:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNo-0002hb-4D
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNk-000087-M7
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:47 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9juBw1723104
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HRwBm1PEj4CfI6jfh+n9tz4eTBvdQkmFIGL8YkDQmso=; b=Ho5hIdnONcpUZ+b1
 OxEg/Z3+mjJBZAm4q0v/RwDccYaLpypclQsGFk8W2L4eFR3GHIW8rf7nlw3dZrow
 hjAn64Cgk5UXLmhSgX0buykq21epqudpoS5zXxOo1rUYqW9sLIEvNEnFfyEoi0zs
 mLTVkXH5DqP1LzA0OIqMxaukt8syzUyaMMV5n/JnWw6+h1ur3mvgMAiMhd4PYC8F
 y2pTxBIh1ggAcslsEpDUwY8FeSDuKIWtKt5kA1SXRDmIzZ6qZ7V5BGVXepyu9M3G
 RFF/5XNiwahGKsxSzkXHziDymDWhja6mbOnPBsIGWBq4Sjpsov39gnUQcltzOXnA
 XOlQWw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0j7dvteb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:32 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso2720961eec.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782398911; x=1783003711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HRwBm1PEj4CfI6jfh+n9tz4eTBvdQkmFIGL8YkDQmso=;
 b=ctcr8M9S87OPTgGpo3zsXmAJr790NapbBOeeNAqUmZzeMxW4/s6t4EjNYRfYjeEC55
 /S/lzLqYsID8dTuW85v6zBVLCXk2V4WEhijgj5ClAqJqM+O7FCMZun4Zrslt1EE022X+
 aTCeizgu2s21IiwrjaxWF033K3C2E0BE3EdtMjcioJJwbygoQ5FrnkAHZimRTxMUeewS
 GhJRxiU+ftJ/uxJo0PFK5TrdfzhMtCHC0hHDMYljixzyLyx0lOtHJGmfXVJpnzmldL9T
 8Ewdq3HfnBKczzSnhifZQpojHchWXaL1bgC3OLnlVbj+/gDVPSaaf5ZmMvPoEfFvypT6
 rhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782398911; x=1783003711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HRwBm1PEj4CfI6jfh+n9tz4eTBvdQkmFIGL8YkDQmso=;
 b=oQhFtzUgdQDnlQvJsuW6hCogRRYmfH4M6e9G0cxzC/X9BPvqByKrz6BZDO0cIdeYgU
 zF3cOhNGGXjYMIQOKbrs1XTYCiemP7CkoZpLvTr91wwQoUbcnMGDz2UOpsTmNDlOvLF5
 jW9yVnkUwJoOozdb6iobqkgJjmlnkBSpPtJOCr+1pcZgPCRUsR2/VBaIz4mwDSyAv2H6
 kkaHhR8KaEfr3jH2SrE1C1GgRy9KSDBMncHZsHwQnKuLRHAAtYlxTE3661hVO/0Jv4gs
 YOM8ysFLEMo5EyUmkWMM+rLyT3sK676tWNPJcDy+9jY9xHPq3EvWlJuKEu7q5CJR4Y1o
 g/1w==
X-Gm-Message-State: AOJu0YzzHNcZ837US3KyIOeShmJgHnQCCNx/gLzHAJZFup/wp5ZpGn9I
 l70dQkyD2Ho/EupDs6d1WpDfwgjj3jc6QgQd3a8UCYyCSlkzTZ3JlGo2s9Kk9ycKEPoIPoYuGGY
 g/79ifq0t9bKMYLs7sNdA3cCc3eUb6go5rwnOVoZbYymX007WCqd6dOKwa7Qb1csfFw==
X-Gm-Gg: AfdE7cnHbgZt5RxEkVRTh8Ym99S/iymZo1Qx+2M8fzhoGb/txEXEQ4p9NE5SwY2J2ol
 dK/sA2RFV4Pau1VzG0//4MxLIugrA5QyP7k6T3ShDPrdA9M9dDYA3AeB3Fu1vy1398QmBy5uDwM
 n8hb/QJ5acjKTjy0/LTKlaVGq0JtkuG+yJgnQ6orc6lKgQqlvdUxugRXZs7Hzo9rCqZ0XJ5fjha
 5q6h3mqmFaGdyb4ohA5e5UyUpGkz4JoUtztUoeWfFp1q0PZxKF9D2my7FUZGdSkt4H9oMByAPX5
 c5vJVC4QTGZRsjxFqTXSa8q8rQET+hPSLye0TGTFUhaRhlLgoK4Av8gS4zsjnn8VsfbZfj5z/0X
 8kNMCTLOmIl/3Xgq5sqrdULwDb/aTVUlfUtGpKG/IIJVZz00oNq4TzD6JgbI=
X-Received: by 2002:a05:7300:2d2c:b0:30c:41df:3734 with SMTP id
 5a478bee46e88-30c84caee33mr3429373eec.22.1782398911211; 
 Thu, 25 Jun 2026 07:48:31 -0700 (PDT)
X-Received: by 2002:a05:7300:2d2c:b0:30c:41df:3734 with SMTP id
 5a478bee46e88-30c84caee33mr3429346eec.22.1782398910762; 
 Thu, 25 Jun 2026 07:48:30 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8afca8sm8999209eec.17.2026.06.25.07.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:48:29 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 55/76] target/hexagon: Add sysemu_ops,
 cpu_get_phys_page_debug()
Date: Thu, 25 Jun 2026 07:16:12 -0700
Message-Id: <20260625141633.449487-56-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 4P8vR7q62zjdf-rRa-T7vjO31aL1QDOn
X-Authority-Analysis: v=2.4 cv=NvHhtcdJ c=1 sm=1 tr=0 ts=6a3d3fc0 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fg0LxJQkbHe3Ved8Rg4A:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfXyVXKkfftR7BL
 C+ToAw63Or88dEoQFrpXit7CxhjIe+UVIWilQk5eGg68aTZ2ehOE5SqKGiV2xj5wtw4WPMMbOks
 bXlx9VAZoOWsaz2tidmvct+aCG3K8B0=
X-Proofpoint-ORIG-GUID: 4P8vR7q62zjdf-rRa-T7vjO31aL1QDOn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfX446edUAXheTW
 zOaWo9DH1Ip1OpqzYiTdG6VECtMkdZ8W1o/oRiyNTn88I5shISbRKBMMYjSVfpcZkWu3Rza6umA
 jXsBZTi1wHuNf5UPj1CpCG2yQNOIFXd34Jh6v2yzzIcEpUG2cEmns0+g8tsNAKl3ZDxds0n3XMp
 jDjW3yQLM+9GsKIQa7b4i29Gcee1/EO5a54SYmzwIvcLz6/xoiANFtRsLQnlO87vOtOsLVGRSHd
 cpZkGJbjgnCP8SJI0gFSyvbedL8jDNGp2RExP13QgpuW4HqorrGYG+RdWxOF8ky9gr5MbAN1QVv
 89N78Si4mbpy0XEPwpkJTK9dgLHhFxjaeY1ssB8awXqhAVEaFOS/E48058W3sDb7P8cvbV4PyjR
 84XXIdSD69VW+RXXM5lVLBgYNpsOa9kgSrfHAKhXHzBrj7f8ZVOSjW/IBWs025pF/JVp2Kj+RR1
 uVo10apqtq4/ZqgQMBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250127
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5jIHwgMzIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2Vk
LCAzMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90
YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCA0ZTVhMjU3NDRhMS4uNjcwNjY4ODA4YTggMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBA
IC0yMCw2ICsyMCw3IEBACiAjaW5jbHVkZSAicWVtdS9xZW11LXByaW50LmgiCiAjaW5jbHVkZSAi
Y3B1LmgiCiAjaW5jbHVkZSAiaW50ZXJuYWwuaCIKKyNpbmNsdWRlICJleGVjL2NwdXRsYi5oIgog
I2luY2x1ZGUgImV4ZWMvdHJhbnNsYXRpb24tYmxvY2suaCIKICNpbmNsdWRlICJxYXBpL2Vycm9y
LmgiCiAjaW5jbHVkZSAiaHcvY29yZS9xZGV2LXByb3BlcnRpZXMuaCIKQEAgLTM3LDYgKzM4LDcg
QEAKICNpbmNsdWRlICJhY2NlbC90Y2cvY3B1LWxkc3QuaCIKICNpbmNsdWRlICJxZW11L21haW4t
bG9vcC5oIgogI2luY2x1ZGUgImhleF9pbnRlcnJ1cHRzLmgiCisjaW5jbHVkZSAiaGV4c3dpLmgi
CiAjaW5jbHVkZSAiZXhlYy9jcHUtaW50ZXJydXB0LmgiCiAjaW5jbHVkZSAiZXhlYy9wYWdlLXBy
b3RlY3Rpb24uaCIKICNpbmNsdWRlICJleGVjL3RhcmdldF9wYWdlLmgiCkBAIC01MDQsNiArNTA2
LDI0IEBAIHN0YXRpYyB2b2lkIGZpbmRfcWVtdV9zdWJwYWdlKHZhZGRyICphZGRyLCBod2FkZHIg
KnBoeXMsIHVpbnQ2NF90IHBhZ2Vfc2l6ZSkKICAgICAqcGh5cyArPSBvZmZzZXQ7CiB9CiAKK3N0
YXRpYyBod2FkZHIgaGV4YWdvbl9jcHVfZ2V0X3BoeXNfYWRkcl9kZWJ1ZyhDUFVTdGF0ZSAqY3Ms
IHZhZGRyIGFkZHIpCit7CisgICAgQ1BVSGV4YWdvblN0YXRlICplbnYgPSBjcHVfZW52KGNzKTsK
KyAgICBod2FkZHIgcGh5c19hZGRyOworICAgIGludCBwcm90OworICAgIHVpbnQ2NF90IHBhZ2Vf
c2l6ZSA9IDA7CisgICAgaW50MzJfdCBleGNwID0gMDsKKyAgICBpbnQgbW11X2lkeCA9IE1NVV9L
RVJORUxfSURYOworCisgICAgaWYgKGdldF9waHlzaWNhbF9hZGRyZXNzKGVudiwgJnBoeXNfYWRk
ciwgJnByb3QsICZwYWdlX3NpemUsICZleGNwLAorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBhZGRyLCAwLCBtbXVfaWR4KSkgeworICAgICAgICBmaW5kX3FlbXVfc3VicGFnZSgmYWRkciwg
JnBoeXNfYWRkciwgcGFnZV9zaXplKTsKKyAgICAgICAgcmV0dXJuIHBoeXNfYWRkcjsKKyAgICB9
CisKKyAgICByZXR1cm4gLTE7Cit9CisKIAogI2RlZmluZSBJTlZBTElEX0JBRFZBIDB4YmFkYWJh
ZGEKIApAQCAtNjExLDYgKzYzMSwxMyBAQCBzdGF0aWMgYm9vbCBoZXhhZ29uX3RsYl9maWxsKENQ
VVN0YXRlICpjcywgdmFkZHIgYWRkcmVzcywgaW50IHNpemUsCiAgICAgZG9fcmFpc2VfZXhjZXB0
aW9uKGVudiwgY3MtPmV4Y2VwdGlvbl9pbmRleCwgZW52LT5ncHJbSEVYX1JFR19QQ10sIHJldGFk
ZHIpOwogfQogCisjaW5jbHVkZSAiaHcvY29yZS9zeXNlbXUtY3B1LW9wcy5oIgorCitzdGF0aWMg
Y29uc3Qgc3RydWN0IFN5c2VtdUNQVU9wcyBoZXhhZ29uX3N5c2VtdV9vcHMgPSB7CisgICAgLmhh
c193b3JrID0gaGV4YWdvbl9jcHVfaGFzX3dvcmssCisgICAgLmdldF9waHlzX2FkZHJfZGVidWcg
PSBoZXhhZ29uX2NwdV9nZXRfcGh5c19hZGRyX2RlYnVnLAorfTsKKwogc3RhdGljIGJvb2wgaGV4
YWdvbl9jcHVfZXhlY19pbnRlcnJ1cHQoQ1BVU3RhdGUgKmNzLCBpbnQgaW50ZXJydXB0X3JlcXVl
c3QpCiB7CiAgICAgQ1BVSGV4YWdvblN0YXRlICplbnYgPSBjcHVfZW52KGNzKTsKQEAgLTY1Myw2
ICs2ODAsOCBAQCBzdGF0aWMgY29uc3QgVENHQ1BVT3BzIGhleGFnb25fdGNnX29wcyA9IHsKICAg
ICAucG9pbnRlcl93cmFwID0gaGV4YWdvbl9wb2ludGVyX3dyYXAsCiAgICAgLmNwdV9leGVjX3Jl
c2V0ID0gY3B1X3Jlc2V0LAogICAgIC50bGJfZmlsbCA9IGhleGFnb25fdGxiX2ZpbGwsCisgICAg
LmNwdV9leGVjX2hhbHQgPSBoZXhhZ29uX2NwdV9oYXNfd29yaywKKyAgICAuZG9faW50ZXJydXB0
ID0gaGV4YWdvbl9jcHVfZG9faW50ZXJydXB0LAogI2VuZGlmIC8qICFDT05GSUdfVVNFUl9PTkxZ
ICovCiB9OwogCkBAIC02ODAsOSArNzA5LDEyIEBAIHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X2Ns
YXNzX2luaXQoT2JqZWN0Q2xhc3MgKmMsIGNvbnN0IHZvaWQgKmRhdGEpCiAgICAgY2MtPmdkYl9j
b3JlX3htbF9maWxlID0gImhleGFnb24tY29yZS54bWwiOwogICAgIGNjLT5kaXNhc19zZXRfaW5m
byA9IGhleGFnb25fY3B1X2Rpc2FzX3NldF9pbmZvOwogI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZ
CisgICAgY2MtPnN5c2VtdV9vcHMgPSAmaGV4YWdvbl9zeXNlbXVfb3BzOwogICAgIGRjLT52bXNk
ID0gJnZtc3RhdGVfaGV4YWdvbl9jcHU7CiAjZW5kaWYKKyNpZmRlZiBDT05GSUdfVENHCiAgICAg
Y2MtPnRjZ19vcHMgPSAmaGV4YWdvbl90Y2dfb3BzOworI2VuZGlmCiB9CiAKIHN0YXRpYyB2b2lk
IGhleGFnb25fY3B1X2NsYXNzX2Jhc2VfaW5pdChPYmplY3RDbGFzcyAqYywgY29uc3Qgdm9pZCAq
ZGF0YSkKLS0gCjIuMzQuMQoK

