Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB921C624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1col-0000Ja-DJ; Wed, 02 Sep 2026 00:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1coj-0000J2-Qt
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:43:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1cog-0000M5-3P
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:43:21 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68202SBv1013646
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 04:43:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uXO3tne317bGrEZCKuTBMVZVrng3uc6zCucp+Ub/ZgE=; b=UoIlfxp6W87VI0Hh
 39ydLREYm+yUOtC1EoHSyMvCGvZw7DBcupaNnYWiyoRUux1wTjggIBAX6frow96D
 mzTELebhEJ2UDZb7+L+3obp4lp5MbHJ/Mw2M43XVFobmke3+/5ur3tUJZx52oUhC
 lY7vCRDaxlVHt8W0fILHeGfC5C42WD+d7/UaD6GGaMdhaAp0pfvJP+PQCZH5WbN7
 eyR+UCtQlLDbeFHR5f+c/WntygAqLaXiof140HnKZnDYnEAQgg7xrKfsVqaXSCzk
 LranRMcwehpfdNUgaSmkV+4xk9uXeoeAG4NRHvnfeEmQQHaXrtZhmif2gXyMbX6h
 sBt6tg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge8whgskp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:43:06 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc132709c76so1127177a12.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788324186; x=1788928986; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uXO3tne317bGrEZCKuTBMVZVrng3uc6zCucp+Ub/ZgE=;
 b=W+u8lfh+9vl1Te3zJt02YliE+t8veO09QmoAKrh8n1m3bNcdgvMLOdeO3ScsP39vdg
 EmKkYTzjDGzWM/Aa/SVOD0Egmn5Bwka+WFqnVzaW2p0lcge/NnmRYKlpTiAv5NukDbgX
 0kO5ItiwP7QHmzb0Jk3U4QTp03bcUzbb3RP0zRirrWzstSpL7KeEDjmA2EVUnVssmDH4
 /JgIJ4qGUhpMjImaLMh8SnM2gG5S4y36TKKFyn8iI5s3iXEJnI58XQ8eHb4I3L1pRKPS
 MYqtZNywHVbWTeQ+J+bbDxx/4LuRqYKVUH6q537RAUDDTCVTtK3kpqU38DeeYpMOCri8
 OvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788324186; x=1788928986;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uXO3tne317bGrEZCKuTBMVZVrng3uc6zCucp+Ub/ZgE=;
 b=mlfHn/f/YYi9ZEo0Szg/jkcxolG3yX4tPkXWgOiru+Tpzix+ayjH2lLAm1AU2oRMAz
 e3i3UhBcqSi+UFIxA6URsWj33m4cGJ0tr27rsdcNRVacMubOLkjuN60nzcArhMvCdH4+
 C6EQkzHfJqUCj7JAxmm8XeJ/NXOmJaqq18HN65NwSY+aPKOid4Ztnoolh7odrGTik+Zb
 6Y7cayFIMKufdefWc6JWd+4B0feFNe79DpJ18PGTneKkZ/J4Ee39U1+NB5+igKxLZOLi
 5atLE4FgbS0+dcZVFd7uno4Rf/Mq/WTBWduA96hloH+GZN7vPAchn5EkpwcqHiX6XbKB
 0hiQ==
X-Gm-Message-State: AFuF++ml7A8nxFY6Msmvfs0pm/2zjV9BC+DfWVTX0EFWSHtrF3qOECHC
 NQL3iEcocgZ86UDHj9+ttnnKWSTyWFNtwncEKduCd6YLlva5LuVqktLpn28QRELO5AK+MUIWCai
 k5nOvfVvHbQfk/3o6tco2aCvKfgLJZlYjlEutikW71WiDrwSC/XnkYIUgWvinFENU0Q==
X-Gm-Gg: AR+sD10d8cIVrPgMuzqmy6UohVkKXLJQrtQgFX3ZgIEQEmSwU7hMXjTIKfhQnfqEmCK
 /jnL6dcin1xQdoCvqj3OgnUZzeIKdZ3nOYTi6YP7J/E3+I5Op4GsPWI546TSMNhzEOyd5ZtPGQ8
 JRsFV1VFT7ailOY1YJqyRvzbINAlbFYWMV6IhMoINMa1sKLrvC5gTTLQww/npcikYtu4KS5dVQx
 1EEbTUEzmdKKwgX5Ot9lMJ+qupBh/DZDRyfILqpjaGl03HhOAN86XrctM4eTZalbRifYHkLgHGU
 OYjrwuEmDbFCELmzGKXrO1gyFq8zEu+upvsiR2RDFXX1tlm7tQdoXHi0lXe7+FnUkvd9mnVEVHt
 KipnBp1IuciqEzS0A6tA0/FG916Q/XEgvs7a3+lznznYccxgq
X-Received: by 2002:a05:6a21:3282:b0:3b4:7e2d:a3c2 with SMTP id
 adf61e73a8af0-3d9af9f65acmr3078420637.18.1788324185873; 
 Tue, 01 Sep 2026 21:43:05 -0700 (PDT)
X-Received: by 2002:a05:6a21:3282:b0:3b4:7e2d:a3c2 with SMTP id
 adf61e73a8af0-3d9af9f65acmr3078345637.18.1788324185420; 
 Tue, 01 Sep 2026 21:43:05 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f079c33e9sm2933984eec.4.2026.09.01.21.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 21:43:02 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 15/28] tests/tcg/hexagon: check priv instructions raise SIGILL
Date: Tue,  1 Sep 2026 21:42:18 -0700
Message-Id: <20260902044231.843004-16-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
References: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=fLkJG5ae c=1 sm=1 tr=0 ts=6a97a95a cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=brjt2USROf7zqxP8TNAA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: QCaYE_WFPBMNGsMwlt0yPZCsBcwauqVH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX4lOZf0M/u9zE
 OXOWMz8k7il++SPLHVZhULbTNSZci1bK3ElYidEOsPXV43zV3vintkGCwC50087E85M5c09f8pH
 1ifwcQkBh2vp833k3U2qxsmT/lOZ7sX7bzHwTn2dVXR3tIhOSIJ6Z+YGsWLfPJU1uGIFBbsEWHd
 coSFj3JEnbGIWldgLtgPcKgFrdNzjLeadCgGaIi4sOJP+gyGSWkUZV9kx/WGFWYL0MeIuVKwlkN
 vIigJN43w6TBN6ZOIYFQSaN0xhESNsrRi8VN1ubXoG0k9WoAFI3AEtEH+vILitvF+jkD8cKsCln
 IN2KXE+vb8ClPFKh0+txxGm6B7XPEq2hIQetQLHlFZJew4CLM9NpGdrwYNfuNQ9rzuoYSR+ntmi
 u5g8TcMK2hUwP5RzkWXYQ59QHL5Qt6QnQHYvJgwdIf1a5SIAp4F/Cp3k8D4g6Ef96+i5PK3M0/F
 6z/3SV+XNZGEOSKyEZQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX0IGJ7+TshbSR
 6aBiszeX1WQDYgpiEtV7QgOBUVQIc4sEAIiqsOD9x4mKcB76P2WPmibyIHixGeGNR0MueBxl2lc
 YULojUmitpp1fp3DL4SbaBaiMX+svHo=
X-Proofpoint-GUID: QCaYE_WFPBMNGsMwlt0yPZCsBcwauqVH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020040
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

QV9QUklWIGFuZCBBX0dVRVNUIGluc3RydWN0aW9ucyBleGVjdXRlZCBmcm9tIHVzZXIgbW9kZSBy
YWlzZQpIRVhfQ0FVU0VfUFJJVl9VU0VSX05PX1NJTlNOIGFuZCBIRVhfQ0FVU0VfUFJJVl9VU0VS
X05PX0dJTlNOLCB3aGljaCBhYm9ydGVkCnFlbXUtaGV4YWdvbiB1bnRpbCB0aGUgcHJlY2VkaW5n
IHBhdGNoLgoKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJA
b3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBv
c3MucXVhbGNvbW0uY29tPgotLS0KIHRlc3RzL3RjZy9oZXhhZ29uL3ByaXZpbGVnZWQtaW5zbi5j
IHwgNzkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIHRlc3RzL3RjZy9oZXhhZ29uL01h
a2VmaWxlLnRhcmdldCAgIHwgIDEgKwogMiBmaWxlcyBjaGFuZ2VkLCA4MCBpbnNlcnRpb25zKCsp
CiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvdGNnL2hleGFnb24vcHJpdmlsZWdlZC1pbnNuLmMK
CmRpZmYgLS1naXQgYS90ZXN0cy90Y2cvaGV4YWdvbi9wcml2aWxlZ2VkLWluc24uYyBiL3Rlc3Rz
L3RjZy9oZXhhZ29uL3ByaXZpbGVnZWQtaW5zbi5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4
IDAwMDAwMDAwMDAwLi4zMDZkNDU0MmVhNAotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3RzL3RjZy9o
ZXhhZ29uL3ByaXZpbGVnZWQtaW5zbi5jCkBAIC0wLDAgKzEsNzkgQEAKKy8qCisgKiBUZXN0IHRo
YXQgcHJpdmlsZWdlZCBhbmQgZ3Vlc3QtbW9kZSBpbnN0cnVjdGlvbnMgcmFpc2UgU0lHSUxMIGlu
IHVzZXIgbW9kZS4KKyAqCisgKiBDb3B5cmlnaHQgKGMpIFF1YWxjb21tIFRlY2hub2xvZ2llcywg
SW5jLiBhbmQvb3IgaXRzIHN1YnNpZGlhcmllcy4KKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wLW9yLWxhdGVyCisgKi8KKworI2luY2x1ZGUgPGFzc2VydC5oPgorI2luY2x1ZGUg
PHNpZ25hbC5oPgorI2luY2x1ZGUgPHN0ZGlvLmg+CisjaW5jbHVkZSA8c3RkbGliLmg+CisjaW5j
bHVkZSA8c3RyaW5nLmg+CisjaW5jbHVkZSA8dW5pc3RkLmg+CisKK3N0YXRpYyB2b2lkICpyZXN1
bWVfcGM7CisKK3N0YXRpYyB2b2lkIGhhbmRsZV9zaWdpbGwoaW50IHNpZywgc2lnaW5mb190ICpp
bmZvLCB2b2lkICpwdWMpCit7CisgICAgdWNvbnRleHRfdCAqdWMgPSAodWNvbnRleHRfdCAqKXB1
YzsKKworICAgIGlmIChzaWcgIT0gU0lHSUxMKSB7CisgICAgICAgIF9leGl0KEVYSVRfRkFJTFVS
RSk7CisgICAgfQorCisgICAgdWMtPnVjX21jb250ZXh0LnIwID0gU0lHSUxMOworICAgIHVjLT51
Y19tY29udGV4dC5wYyA9ICh1bnNpZ25lZCBsb25nKXJlc3VtZV9wYzsKK30KKworc3RhdGljIGlu
dCB0ZXN0X3ByaXZfaW5zbih2b2lkKQoreworICAgIGludCBzaWc7CisKKyAgICBhc20gdm9sYXRp
bGUoCisgICAgICAgICJyMCA9ICMwXG4iCisgICAgICAgICJyMSA9ICMjMWZcbiIKKyAgICAgICAg
Im1lbXcoJVtwY10pID0gcjFcbiIKKyAgICAgICAgInN0b3AocjApXG4iCisgICAgICAgICIxOlxu
IgorICAgICAgICAiJVtzaWddID0gcjBcbiIKKyAgICAgICAgOiBbc2lnXSAiPXIiKHNpZykKKyAg
ICAgICAgOiBbcGNdICJyIigmcmVzdW1lX3BjKQorICAgICAgICA6ICJyMCIsICJyMSIsICJtZW1v
cnkiKTsKKworICAgIHJldHVybiBzaWc7Cit9CisKK3N0YXRpYyBpbnQgdGVzdF9ndWVzdF9pbnNu
KHZvaWQpCit7CisgICAgaW50IHNpZzsKKworICAgIGFzbSB2b2xhdGlsZSgKKyAgICAgICAgInIw
ID0gIzBcbiIKKyAgICAgICAgInIxID0gIyMxZlxuIgorICAgICAgICAibWVtdyglW3BjXSkgPSBy
MVxuIgorICAgICAgICAicjAgPSBnMFxuIgorICAgICAgICAiMTpcbiIKKyAgICAgICAgIiVbc2ln
XSA9IHIwXG4iCisgICAgICAgIDogW3NpZ10gIj1yIihzaWcpCisgICAgICAgIDogW3BjXSAiciIo
JnJlc3VtZV9wYykKKyAgICAgICAgOiAicjAiLCAicjEiLCAibWVtb3J5Iik7CisKKyAgICByZXR1
cm4gc2lnOworfQorCitpbnQgbWFpbigpCit7CisgICAgc3RydWN0IHNpZ2FjdGlvbiBhY3Q7CisK
KyAgICBtZW1zZXQoJmFjdCwgMCwgc2l6ZW9mKGFjdCkpOworICAgIGFjdC5zYV9zaWdhY3Rpb24g
PSBoYW5kbGVfc2lnaWxsOworICAgIGFjdC5zYV9mbGFncyA9IFNBX1NJR0lORk87CisgICAgYXNz
ZXJ0KHNpZ2FjdGlvbihTSUdJTEwsICZhY3QsIE5VTEwpID09IDApOworCisgICAgYXNzZXJ0KHRl
c3RfcHJpdl9pbnNuKCkgPT0gU0lHSUxMKTsKKyAgICBhc3NlcnQodGVzdF9ndWVzdF9pbnNuKCkg
PT0gU0lHSUxMKTsKKworICAgIHB1dHMoIlBBU1MiKTsKKyAgICByZXR1cm4gRVhJVF9TVUNDRVNT
OworfQpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vTWFrZWZpbGUudGFyZ2V0IGIvdGVz
dHMvdGNnL2hleGFnb24vTWFrZWZpbGUudGFyZ2V0CmluZGV4IDYxYWRmNjM1NmU0Li42NDFmNmJj
MTBlNyAxMDA2NDQKLS0tIGEvdGVzdHMvdGNnL2hleGFnb24vTWFrZWZpbGUudGFyZ2V0CisrKyBi
L3Rlc3RzL3RjZy9oZXhhZ29uL01ha2VmaWxlLnRhcmdldApAQCAtNTgsNiArNTgsNyBAQCBIRVhf
VEVTVFMgKz0gaW52YWxpZC1zbG90cwogSEVYX1RFU1RTICs9IHZhbGlkLXNsb3RzCiBIRVhfVEVT
VFMgKz0gaW52YWxpZC1lbmNvZGluZwogSEVYX1RFU1RTICs9IG11bHRpcGxlLXdyaXRlcworSEVY
X1RFU1RTICs9IHByaXZpbGVnZWQtaW5zbgogSEVYX1RFU1RTICs9IHVuYWxpZ25lZF9wYwogSEVY
X1RFU1RTICs9IHVuYWxpZ25lZF9kYXRhCiAKLS0gCjIuMzQuMQoK

