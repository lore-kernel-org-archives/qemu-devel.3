Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756A9606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 23:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o62pEqAj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kGFje36n
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMZ9d-0002BO-LG; Thu, 29 Oct 2026 19:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMZ9b-00028O-Eo
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 19:03:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMZ9Z-0004DM-A2
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 19:03:27 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TLaGwp291019
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 23:03:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N3dgpQ4FB+P3m2zg9Yl/k47tyH5S02dgk9jayMF+R9k=; b=o62pEqAj9s/bIqI4
 qFrE69TJbnQm7J3Smu2oUW4kvRxDafqW8bsB6GAKeadQW2z4qFMSejYqqKFuIbcZ
 bj+tgAyUg8E2Q/xnoj293cpR7hSzUbxroIaBS/mzzzrHT508tNpM1QS4pSyVTquz
 ZHAgXBPLnw4lN9wLddUF8+GP5wwQW8WcxIVQgH/br00uxSTE0iIfse4WECsXAzAF
 AaYP+O+3p5im0AvtwQy0zdJkxp+5e942DSF5NdntRWp3FzK2s2d2lWSA31IohFsf
 3esx5EK+aQTlwzBfHVJJhmMZ2hYDD/kluIJm75F5Bg30iP3bAzefemZWZ4hB4lwC
 Fyvq5g==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p09cy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 23:03:24 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1383723dfddso182643c88.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 16:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793315003; x=1793919803; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N3dgpQ4FB+P3m2zg9Yl/k47tyH5S02dgk9jayMF+R9k=;
 b=kGFje36n4qZxuasLFRqk9qjtarMLFwh3Tq+FvgBncrQCXoqZLDA+vG4U0QlgzMheb9
 UeMFtaY8vvknrPdqTjnjfstnrRx32BytaRbdBD6HJpWvee/ZBKef7lDJKnJIK6or3R8A
 ydtMiFNWaM4d/Ut++uWK35Q3DnQDPrGQbZmUz8fynG4hFvUoDL3XiRnupsk+HceaSRJw
 lxnz3XKTqHcav/7popNJ91NEBrBARikl+NBnEXT1U5qoC5jrpbkyRQvPnMRJ5i6kDXOq
 Mp+A22kUnoWm1ZMO93MMx8Agni8/iMCUcRG3Ws5yucqAM9hiHoPZK4UVyfgU7RMgYhPO
 mqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793315003; x=1793919803;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N3dgpQ4FB+P3m2zg9Yl/k47tyH5S02dgk9jayMF+R9k=;
 b=EYFH2CTfh57KxoVQm0KFQ3SjOgkRKk5V+rncD7nUkC5xfgQt/YouSht+uC0wVn3J1I
 dh/9qHwLX4Vv+Oa7PS+EKs46bySD2ing73zmw7XvRxGQvQQtU5AQ1llFAtC4RxO2IVBS
 SCXByY5AIXUlcIJ6wdrdllioxL3yK5hx24uKgIjJumanysiHhSoWDzSl65PpkgJmIu3i
 1xMZUtyC1w3o6uacZOpRU36bnT4xw5LjQ8VI3uipWP1JcYqAxREpLHf8O4En9F+d0hRV
 5K65cbTtGpJ7SaO+UiwMyuNq+QTrqI69cavSoE1Akh+jsizoVALu1ZZoa/r5hhQBd8Up
 znmA==
X-Gm-Message-State: AFq9FYKQx9ustFXnRMN/2nnsKr02I37QuD/7lyIfjOC5l2IdGHdRTwaI
 0AKjluAFzcQdSDkmO9bhpmEMQS2xm0LZrGVjxCjcpv+/PZoyCsyzHAbDniYbzhjwUw2fujpoM8t
 pWEg4gef1d/rN6B+l1BMkvmLD92q0EpKhxGJQG2elOlY3n9bcyag4ORGs4DhXh/vvEg==
X-Gm-Gg: AYBFou2RgNH8xWSn7b6olTXXkO2fB3s4BXQAceWksLuxjcu7BgfCj+XL8aUDSZ6Ntut
 GZBdZS45C1BKbA0CoLUCINLf3kGTodjTpGgNjaArGOV3HUDYfokfielsSCRp5bgtRpPhzosbdsI
 5arzBqbjOJb9pqO4nMcSdXZO6b+RjPJALGCEyY3Bbm2Ld06RJtiqeTDt1xXqEBcbs/J1xlxWtmK
 N75muUD/r2OqeUJAnhQc5u1CcMHBjH34hdAxoYP5K9kExe1eDCX1iyDBqst7jM59DGywcdn4hhL
 7iXgGnx287xNfx12ylDyyKm3dCeE/WW4uiFnEmf3+E2EgcnZgMkm0t6Tc3YXc79CR459vbb0txe
 NYXNB6mg2Md6QEAEfEeSudUcS1UdHc4PVnLex16WLFXe92Gg4QxdMPQFeDdP0d5PLyNZt5e5Hn+
 3QGG1BmbV4FKGlkqsDelxI
X-Received: by 2002:a05:7022:158a:b0:185:869a:8c64 with SMTP id
 a92af1059eb24-1ac56ca0239mr773381c88.1.1793315002950; 
 Thu, 29 Oct 2026 16:03:22 -0700 (PDT)
X-Received: by 2002:a05:7022:158a:b0:185:869a:8c64 with SMTP id
 a92af1059eb24-1ac56ca0239mr773338c88.1.1793315002314; 
 Thu, 29 Oct 2026 16:03:22 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac193b8179sm2034887c88.11.2026.10.29.16.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 16:03:20 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH 5/8] target/hexagon: gate HMX exec on SSR:XE2
Date: Thu, 29 Oct 2026 16:03:07 -0700
Message-Id: <20261029230310.1632334-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029230310.1632334-1-brian.cain@oss.qualcomm.com>
References: <20261029230310.1632334-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA5MCBTYWx0ZWRfX/favWKZDr5CX
 F3/RSRDOMwdE3exF+XIzfXYzk6wHqV7LjBPU8Ug2QT61w7STrQDDDx/+OjVXcn2o7gLY83e6iKa
 XY1sMD6ZkVTC8uN6snAkPIM2eSjF8+NjuKYTAh2t3pGufp+eaBBRXiPAJVMDbEXYBtcDYnWh7g0
 2ZSx9R17YJ75tzApOC3AYQ/mxJSdZP643kywEBKvbuEbPHVr7gDN2nkC+0Qgc511khFaeM7nzmv
 mP/eSdzPV4NMEwKR57Pco3we54ICoW/lPMJ2/Wlj8AYXf8ERz7bZYgTfvof7Qp3J7a2XLWh6GIY
 8uVhqxh69pk2KL5oVR8HzNSns1R/VoOrcGaRvyQfm2V6aecDzb0JpnlHX9Y0gpTyKuZLH1FHRSL
 R8bwRfqzLv3IpIAI2kAawtv+fVxwc2TN8IAHAYxniUj4T53p8aGXglDzwot7HXYbw7IY5mrp6gC
 OcjSdnz5ZUGJSxXeSJQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA5MCBTYWx0ZWRfX7XDlvD+6sHRe
 qS+4maE0THcxhZV8IokK4t/Y9+1K1USzagSDzj/laaMF08MdIR9psb39Ng0SxBjS1A+wq4YptLw
 +d4zmzNW96leQWysp7HHNhnTXY9croU=
X-Proofpoint-ORIG-GUID: DKCs3bRQG3x71PfEQMFEUn4JWAkks0e1
X-Proofpoint-GUID: DKCs3bRQG3x71PfEQMFEUn4JWAkks0e1
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae3d0bc cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=c4piSl41iiwCIC5ZPTQA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290090
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RXhlY3V0aW5nIGFuIEhNWCBpbnN0cnVjdGlvbiB3aXRoIFNTUjpYRTIgY2xlYXIgcmFpc2VzIGEg
Tk9fQ09QUk9DMl9FTkFCTEUKZXhjZXB0aW9uLgoKTG9nIHBhY2tldHMgb25lIGFzIExPR19VTklN
UCBmb3Igbm93LgoKU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVh
bGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2NwdS5oICAgICAgICAgICAgICAgICAgICAg
IHwgIDEgKwogdGFyZ2V0L2hleGFnb24vaW5zbi5oICAgICAgICAgICAgICAgICAgICAgfCAgMSAr
CiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaCAgICAgICAgICAgICAgICB8ICAyICsrCiB0YXJn
ZXQvaGV4YWdvbi9jcHUuYyAgICAgICAgICAgICAgICAgICAgICB8ICAyICsrCiB0YXJnZXQvaGV4
YWdvbi9kZWNvZGUuYyAgICAgICAgICAgICAgICAgICB8ICAzICsrKwogdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmMgICAgICAgICAgICAgICAgfCAyMSArKysrKysrKysrKysrKysrKysrKysKIHRl
c3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X3N5c3Rlc3RzLnB5IHwgIDMgKysrCiA3IGZpbGVz
IGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9j
cHUuaCBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCmluZGV4IDIyYWExNjMwNzY3Li4xY2RmZjU4M2Rh
NCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmgKKysrIGIvdGFyZ2V0L2hleGFnb24v
Y3B1LmgKQEAgLTI0Nyw2ICsyNDcsNyBAQCBGSUVMRChUQl9GTEFHUywgTU1VX0lOREVYLCAxLCAz
KQogRklFTEQoVEJfRkxBR1MsIEhWWF9DT1BST0NfRU5BQkxFRCwgNSwgMSkKIEZJRUxEKFRCX0ZM
QUdTLCBDUFVfTU9ERSwgNiwgMikKIEZJRUxEKFRCX0ZMQUdTLCBTU19BQ1RJVkUsIDgsIDEpCitG
SUVMRChUQl9GTEFHUywgSE1YX0NPUFJPQ19FTkFCTEVELCAxNSwgMSkKIAogR19OT1JFVFVSTiB2
b2lkIGhleGFnb25fcmFpc2VfZXhjZXB0aW9uX2VycihDUFVIZXhhZ29uU3RhdGUgKmVudiwKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgZXhjZXB0
aW9uLApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaW5zbi5oIGIvdGFyZ2V0L2hleGFnb24v
aW5zbi5oCmluZGV4IDVkNTk0MzBkYTllLi5hZmFlOTI4ZTY3OSAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vaW5zbi5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2luc24uaApAQCAtNzAsNiArNzAs
NyBAQCBzdHJ1Y3QgUGFja2V0IHsKICAgICBib29sIHBrdF9oYXNfc2NhbGFyX3N0b3JlX3MxOwog
CiAgICAgYm9vbCBwa3RfaGFzX2h2eDsKKyAgICBib29sIHBrdF9oYXNfaG14OwogICAgIEluc24g
KnZoaXN0X2luc247CiAKICAgICBJbnNuIGluc25bSU5TVFJVQ1RJT05TX01BWF07CmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaCBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0
ZS5oCmluZGV4IGJjNWYyMDIxNjNmLi44OGI5NDhlODY2OSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hl
eGFnb24vdHJhbnNsYXRlLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgKQEAgLTEw
MSw2ICsxMDEsOCBAQCB0eXBlZGVmIHN0cnVjdCBEaXNhc0NvbnRleHQgewogICAgIFRDR3YgZGN6
ZXJvX2FkZHI7CiAgICAgYm9vbCBodnhfY29wcm9jX2VuYWJsZWQ7CiAgICAgYm9vbCBodnhfY2hl
Y2tfZW1pdHRlZDsKKyAgICBib29sIGhteF9jb3Byb2NfZW5hYmxlZDsKKyAgICBib29sIGhteF9j
aGVja19lbWl0dGVkOwogfSBEaXNhc0NvbnRleHQ7CiAKIGJvb2wgaXNfZ2F0aGVyX3N0b3JlX2lu
c24oRGlzYXNDb250ZXh0ICpjdHgpOwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMg
Yi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCA4M2UyMzc3NWVhMi4uMWJmYjk0ODIyN2IgMTAw
NjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5j
CkBAIC0zOTMsNiArMzkzLDggQEAgc3RhdGljIFRDR1RCQ1BVU3RhdGUgaGV4YWdvbl9nZXRfdGJf
Y3B1X3N0YXRlKENQVVN0YXRlICpjcykKICAgICBoZXhfZmxhZ3MgPSBGSUVMRF9EUDMyKGhleF9m
bGFncywgVEJfRkxBR1MsIFNTX0FDVElWRSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgIEdF
VF9TU1JfRklFTEQoU1NSX1NTLCBlbnYtPnRfc3JlZ1tIRVhfU1JFR19TU1JdKSAmJgogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZ2V0X2NwdV9tb2RlKGVudikgIT0gSEVYX0NQVV9NT0RFX01P
TklUT1IpOworICAgIGhleF9mbGFncyA9IEZJRUxEX0RQMzIoaGV4X2ZsYWdzLCBUQl9GTEFHUywg
SE1YX0NPUFJPQ19FTkFCTEVELAorICAgICAgICAgICAgICAgICAgICAgICAgICAgR0VUX1NTUl9G
SUVMRChTU1JfWEUyLCBlbnYtPnRfc3JlZ1tIRVhfU1JFR19TU1JdKSk7CiAjZWxzZQogICAgIGhl
eF9mbGFncyA9IEZJRUxEX0RQMzIoaGV4X2ZsYWdzLCBUQl9GTEFHUywgTU1VX0lOREVYLCBNTVVf
VVNFUl9JRFgpOwogI2VuZGlmCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9kZWNvZGUuYyBi
L3RhcmdldC9oZXhhZ29uL2RlY29kZS5jCmluZGV4IDBhYzg3YmJlZTBjLi4yOTE2ZTRjNjhkZiAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24v
ZGVjb2RlLmMKQEAgLTc3Myw5ICs3NzMsMTIgQEAgaW50IGRlY29kZV9wYWNrZXQoRGlzYXNDb250
ZXh0ICpjdHgsIGludCBtYXhfd29yZHMsIGNvbnN0IHVpbnQzMl90ICp3b3JkcywKIAogICAgIHBr
dC0+ZW5jb2RfcGt0X3NpemVfaW5fYnl0ZXMgPSB3b3Jkc19yZWFkICogNDsKICAgICBwa3QtPnBr
dF9oYXNfaHZ4ID0gZmFsc2U7CisgICAgcGt0LT5wa3RfaGFzX2hteCA9IGZhbHNlOwogICAgIGZv
ciAoaSA9IDA7IGkgPCBudW1faW5zbnM7IGkrKykgewogICAgICAgICBwa3QtPnBrdF9oYXNfaHZ4
IHw9CiAgICAgICAgICAgICBHRVRfQVRUUklCKHBrdC0+aW5zbltpXS5vcGNvZGUsIEFfQ1ZJKTsK
KyAgICAgICAgcGt0LT5wa3RfaGFzX2hteCB8PQorICAgICAgICAgICAgR0VUX0FUVFJJQihwa3Qt
Pmluc25baV0ub3Bjb2RlLCBBX0hNWCk7CiAgICAgfQogCiAgICAgLyoKZGlmZiAtLWdpdCBhL3Rh
cmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKaW5k
ZXggOTE5MjVkMmRkYjEuLjRjODRmZWFlZWI1IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90
cmFuc2xhdGUuYworKysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwpAQCAtODYwLDYgKzg2
MCwyNCBAQCBzdGF0aWMgdm9pZCBnZW5fc3RhcnRfcGFja2V0KERpc2FzQ29udGV4dCAqY3R4KQog
ICAgICAgICBjdHgtPmh2eF9jaGVja19lbWl0dGVkID0gdHJ1ZTsKICAgICB9CiAjZW5kaWYKKwor
ICAgIGlmIChjdHgtPnBrdC5wa3RfaGFzX2hteCkgeworICAgICAgICBmb3IgKGkgPSAwOyBpIDwg
Y3R4LT5wa3QubnVtX2luc25zOyBpKyspIHsKKyAgICAgICAgICAgIGlmIChHRVRfQVRUUklCKGN0
eC0+cGt0Lmluc25baV0ub3Bjb2RlLCBBX0hNWCkpIHsKKyAgICAgICAgICAgICAgICBxZW11X2xv
Z19tYXNrKExPR19VTklNUCwgIiclcycgaXMgbm90IGltcGxlbWVudGVkXG4iLAorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgb3Bjb2RlX25hbWVzW2N0eC0+cGt0Lmluc25baV0ub3Bjb2Rl
XSk7CisgICAgICAgICAgICB9CisgICAgICAgIH0KKyAgICB9CisKKyNpZm5kZWYgQ09ORklHX1VT
RVJfT05MWQorICAgIC8qIEhNWCBuZWVkcyBTU1I6WEUyICovCisgICAgaWYgKGN0eC0+cGt0LnBr
dF9oYXNfaG14ICYmICFjdHgtPmhteF9jb3Byb2NfZW5hYmxlZCAmJgorICAgICAgICAhY3R4LT5o
bXhfY2hlY2tfZW1pdHRlZCkgeworICAgICAgICBnZW5fcHJlY2lzZV9leGNlcHRpb24oSEVYX0NB
VVNFX05PX0NPUFJPQzJfRU5BQkxFLCBjdHgtPnBrdC5wYyk7CisgICAgICAgIGN0eC0+aG14X2No
ZWNrX2VtaXR0ZWQgPSB0cnVlOworICAgIH0KKyNlbmRpZgogfQogCiBib29sIGlzX2dhdGhlcl9z
dG9yZV9pbnNuKERpc2FzQ29udGV4dCAqY3R4KQpAQCAtMTQzNCw2ICsxNDUyLDkgQEAgc3RhdGlj
IHZvaWQgaGV4YWdvbl90cl9pbml0X2Rpc2FzX2NvbnRleHQoRGlzYXNDb250ZXh0QmFzZSAqZGNi
YXNlLAogICAgICAgICBjdHgtPmJhc2UubWF4X2luc25zID0gMTsKICAgICAgICAgY3R4LT5pc190
aWdodF9sb29wID0gZmFsc2U7CiAgICAgfQorICAgIGN0eC0+aG14X2NvcHJvY19lbmFibGVkID0K
KyAgICAgICAgRklFTERfRVgzMihoZXhfZmxhZ3MsIFRCX0ZMQUdTLCBITVhfQ09QUk9DX0VOQUJM
RUQpOworICAgIGN0eC0+aG14X2NoZWNrX2VtaXR0ZWQgPSBmYWxzZTsKICNlbmRpZgogfQogCmRp
ZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weSBiL3Rl
c3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X3N5c3Rlc3RzLnB5CmluZGV4IDFjMWQ1NDQwYmI2
Li5kM2Y5Yjk1ZDk2MSAxMDA3NTUKLS0tIGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rf
c3lzdGVzdHMucHkKKysrIGIvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMu
cHkKQEAgLTkwLDYgKzkwLDkgQEAgZGVmIHRlc3RfYWNjZXNzKHNlbGYpOgogICAgIGRlZiB0ZXN0
X3NlbWlob3N0KHNlbGYpOgogICAgICAgICBzZWxmLnJ1bl9jb25zb2xlX3BhdHRlcm4oInNlbWlo
b3N0IiwgIlBBU1MiLCAiLWFwcGVuZCIsICJhcmcxIiwgImFyZzIiKQogCisgICAgZGVmIHRlc3Rf
aW52YWxpZF9obXgoc2VsZik6CisgICAgICAgIHNlbGYucnVuX2V4aXRfemVybygiaW52YWxpZF9o
bXgiKQorCiAgICAgZGVmIHRlc3RfZHRnX2ludGVycnVwdChzZWxmKToKICAgICAgICAgc2VsZi5y
dW5fZXhpdF96ZXJvKCJkdGdfaW50ZXJydXB0IikKIAotLSAKMi4zNC4xCgo=

