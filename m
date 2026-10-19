Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C42A606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 17:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=F3XEF/s9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ISCAHnAl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIr80-0001Lk-VM; Mon, 19 Oct 2026 13:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIr7y-0001LH-FK
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 13:26:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIr7w-0000Pc-Ps
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 13:26:26 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFOtMh4180406
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 17:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HH0OoexitI9I4wIBBsFHRBvPau94eWbdbLKDtFWOYtQ=; b=F3XEF/s9qcbs+/pz
 20YKuTCBLaOtXMQSrt7tNfLVwbQJ4oXMslysMtmJog4yWmwe6F5ihfRmw8L5xILi
 A5RampnhOBxDAt8K3e0/8q4O1jZTobptWcuXGPiJkfnLxlkr0I3qg5mG0r0kaKH0
 yMTlkxu4FRYzVusdMUf4WEfPWAZgV10m9rIYSxWhTNd1Y28+vU13XZumKTfbcgE1
 4vku9+rhepAW/eY/vW4NEMYV4fE++EGtaJNv3k/R/synd4hgbA9SmzTGlazF2blQ
 ZHA0Z36rJ3NNK+OFGl1zju69Vre6EmQGDyrjSsg0m0Q73A6g1ScgS73o8tGxcRSG
 ZirVgA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3fae3u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 17:26:23 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-341eff9e381so7028809eec.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 10:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792430783; x=1793035583; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HH0OoexitI9I4wIBBsFHRBvPau94eWbdbLKDtFWOYtQ=;
 b=ISCAHnAlOmWtaV3SgNIyeYBejP1ilwO0I2RzCU5MP12kNp4Z3JCZuteUVMzl+iQo3q
 w6yJ94nsjQ7rmLt5OE2f0QFK/ljTT/S1j5QB194xkKYoorRCP8G0NvCCQBes6IVINppL
 /Dj909zMHpqC6uJiPetuSOlfjXIi5OQnDhMu6mfzB7YIaDmb/avpaZfop7wn9O4REMXi
 DysycJCWhs3DQ6zqZRy9RWCWVY9pgyzwJiStZfO862A2zsV0KFPzk8nqXGBv2F7PIvBo
 qitLWGnGL6LsiTr4IU/0EL/Q+DItVoz815WtxvBld9vBhSlug5gBNN+QtNVadgtOAMu0
 b1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792430783; x=1793035583;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HH0OoexitI9I4wIBBsFHRBvPau94eWbdbLKDtFWOYtQ=;
 b=0c2WBBPKnMQvBcYrP0/QxZ0eQHUksI/znNRlKrGzMw+a378plPIN4Rxy5t6M6EV9Wg
 /bd+0YnjIpkZCgmvWiVVPQ0UCm6B345Q0WDL0S+ZfcZPk/PDghyFjJ2KD6am5n+2cZ/d
 XrncVSlHCh9BAwvhy/Ux7UxtSLjpkI8XsfhgpetZO3HL1vkH5Y/O+ZFnDBmb3b6w17kR
 QxETPUphSObV15pt6xuRm7zq0OT89s5xK9dxXSfFfAL4hoAXK5ewQiPMW6ndjAX7B0R/
 uLU7ImKc7Hcpiyf229wNbLucHQkJ7an9DobucD1vtmKn8gG/x+5nslR5OwwGAIUQTGrq
 VO9w==
X-Gm-Message-State: AFq9FYK3HDZiZmhwm/nH8HXnH2hYEPOI8bjfqzNGC+JWP7s19hur5G7U
 vtzm7tkGT26V2nh3q9/PNf+YBQ50LOfVemcT/5u9OShX7YBMy7muO+XZdUm0Qrwgsah2Jjd0hvQ
 5+zWAOpuHNNyhYWFo00VHVgW+1erOkXWp34Wp7waBv+MggAgOcqNTAi+I2oWDkIQ6vw==
X-Gm-Gg: AYBFou3ie4M0sjwSrVjORg95ER0/TJzleRNHO3l9Sliu86hGVFq9fO8uI5KklIN9yW7
 IvlkwSsrX+0JAoI+ROFLkA9RryGIIaCija3sNpoHoOSC1m7LJJ16y2lbcClv0WU6KIg6t7+dESp
 58xUyAul5zGnsSP2e1C5qm89cj8WMSSs9MLWvrYzAz/5SKW+W83+G6UHo7dSJU6DiyORI40xiHH
 KvJB226OoY52pxPBwLbCKxwzLXbIhjQIExN//GPHHx9U/7WxKf7di8O1Xrn6ZX8Q0mHx6Is6Qzh
 jcvsVp10PLKlab75nVd9rBXHXNEoX16VxatpdB/yiUvgIt1VlRjG30jhKbisHsHFj94G8uWObA6
 xtkl8PRK96kti+INjGoGm4tf87LKy6PLYDrAcoJoNV/RhlU0=
X-Received: by 2002:a05:7301:6497:b0:359:1b05:ed30 with SMTP id
 5a478bee46e88-3619ed12958mr12135233eec.4.1792430782600; 
 Mon, 19 Oct 2026 10:26:22 -0700 (PDT)
X-Received: by 2002:a05:7301:6497:b0:359:1b05:ed30 with SMTP id
 5a478bee46e88-3619ed12958mr12135203eec.4.1792430782003; 
 Mon, 19 Oct 2026 10:26:22 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-360813b6791sm38243061eec.6.2026.10.19.10.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 10:26:16 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Anton Johansson <anjo@rev.ng>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 02/11] Hexagon: add v85 CPU model
Date: Mon, 19 Oct 2026 10:25:54 -0700
Message-Id: <20261019172603.2625677-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019172603.2625677-1-brian.cain@oss.qualcomm.com>
References: <20261019172603.2625677-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: CYeD0sIvm8CiGOmpXsMBWHh76J2MrWso
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA2OSBTYWx0ZWRfX0cbXY7Fsvu2l
 uSAGlKcuoOW9jwmjQQTrUdYkao/dpG2FzX7keCfbochXsGbGICzry9chOvWMMt0R3aI3iYGGOsm
 1ZQUCIm+vfaK17KStBEQlk40GnxlkYESmbBs47bdwnWSWxEjTouojvbNwmVszQjrcsjWgoh76rJ
 KuL4XrJskHhU+k8AcildGEkVLET0XQXc94Y1qssYgVM64D+XwG/OK6iHFC3DVWzTBOcNFyRoD3f
 r6W/BRk+PwdMqCWAHjWYBGKv46GEswjBVOMYsY6WXxnBiB348UDo7MhnCY+ybYOMBc+lycZZ+qo
 k7Mvo2RL/OPD2CEH+xaAoFWx9m6+IEO3apRUQXZPiZ4gzcjy+TB8dyW3tBmVK8A372IknXXyoEz
 deAZ44RjPchSZGxI7sQciC7hGZmtoiSqkElHlnJOrzdOIkKs53YY1GJTsEytL4jod8P+8H4XHfg
 rMf/FT8bw0n+qYkHQZA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA2OSBTYWx0ZWRfX7qkxfSUjrHxH
 j+MyGGZQ0RKC62SL1ao6HQhJxblNeGYb0iClxDwhywDUziFNjtpD/68DNrU7Q1OyPctR3MGMdd6
 Miicnf6CC+v8QrRkjy0rh1ipFmu47A8=
X-Proofpoint-GUID: CYeD0sIvm8CiGOmpXsMBWHh76J2MrWso
X-Authority-Analysis: v=2.4 cv=OaANnRTY c=1 sm=1 tr=0 ts=6ad652bf cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=6RDhHJMOdHl8aUYkYD8A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190069
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

UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KUmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFs
Y29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxj
b21tLmNvbT4KLS0tCiBkb2NzL3N5c3RlbS9oZXhhZ29uL2VtdWxhdGlvbi5yc3QgfCAyICstCiB0
YXJnZXQvaGV4YWdvbi9jcHUtcW9tLmggICAgICAgICAgfCA0ICsrKysKIGxpbnV4LXVzZXIvaGV4
YWdvbi9lbGZsb2FkLmMgICAgICB8IDQgKysrKwogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICAg
ICAgICAgIHwgMiArKwogNCBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0IGIv
ZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0CmluZGV4IDEyMzg1MzExYWE0Li5mYjU3
Yzc3YWU5MCAxMDA2NDQKLS0tIGEvZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0Cisr
KyBiL2RvY3Mvc3lzdGVtL2hleGFnb24vZW11bGF0aW9uLnJzdApAQCAtNiw3ICs2LDcgQEAgSGV4
YWdvbiBDUFUgYXJjaGl0ZWN0dXJlIHN1cHBvcnQKID09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09CiAKIFFFTVUncyBUQ0cgZW11bGF0aW9uIGluY2x1ZGVzIHN1cHBvcnQgZm9yIHY2NSwg
djY2LCB2NjcsIHY2OCwgdjY5LCB2NzEsIHY3MywKLXY3NSwgdjc3LCB2NzksIHY4MS4KK3Y3NSwg
djc3LCB2NzksIHY4MSwgdjgzLCB2ODUuCiBJdCBhbHNvIGhhcyBzdXBwb3J0IGZvciB0aGUgZm9s
bG93aW5nIGFyY2hpdGVjdHVyZSBleHRlbnNpb25zOgogCiAtIEhWWCAoSGV4YWdvbiBWZWN0b3Ig
ZVh0ZW5zaW9ucykKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS1xb20uaCBiL3Rhcmdl
dC9oZXhhZ29uL2NwdS1xb20uaAppbmRleCAyYmZhNGQ1ZDBmYy4uZDRjODQxM2RlZDMgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS1xb20uaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHUt
cW9tLmgKQEAgLTI4LDYgKzI4LDggQEAgdHlwZWRlZiBlbnVtIHsKICAgICBIRVhfVkVSX1Y3NSA9
IDB4NzUsCiAgICAgSEVYX1ZFUl9WNzkgPSAweDc5LAogICAgIEhFWF9WRVJfVjgxID0gMHg4MSwK
KyAgICBIRVhfVkVSX1Y4MyA9IDB4ODMsCisgICAgSEVYX1ZFUl9WODUgPSAweDg1LAogICAgIEhF
WF9WRVJfQU5ZID0gMHhmZiwKIH0gSGV4YWdvblZlcnNpb247CiAKQEAgLTU1LDYgKzU3LDggQEAg
dHlwZWRlZiBzdHJ1Y3QgewogI2RlZmluZSBUWVBFX0hFWEFHT05fQ1BVX1Y3NSBIRVhBR09OX0NQ
VV9UWVBFX05BTUUoInY3NSIpCiAjZGVmaW5lIFRZUEVfSEVYQUdPTl9DUFVfVjc5IEhFWEFHT05f
Q1BVX1RZUEVfTkFNRSgidjc5IikKICNkZWZpbmUgVFlQRV9IRVhBR09OX0NQVV9WODEgSEVYQUdP
Tl9DUFVfVFlQRV9OQU1FKCJ2ODEiKQorI2RlZmluZSBUWVBFX0hFWEFHT05fQ1BVX1Y4MyBIRVhB
R09OX0NQVV9UWVBFX05BTUUoInY4MyIpCisjZGVmaW5lIFRZUEVfSEVYQUdPTl9DUFVfVjg1IEhF
WEFHT05fQ1BVX1RZUEVfTkFNRSgidjg1IikKIAogT0JKRUNUX0RFQ0xBUkVfQ1BVX1RZUEUoSGV4
YWdvbkNQVSwgSGV4YWdvbkNQVUNsYXNzLCBIRVhBR09OX0NQVSkKIApkaWZmIC0tZ2l0IGEvbGlu
dXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYyBiL2xpbnV4LXVzZXIvaGV4YWdvbi9lbGZsb2FkLmMK
aW5kZXggM2E2YmE0ZTEzMDQuLjlmOThhZDhmYjg2IDEwMDY0NAotLS0gYS9saW51eC11c2VyL2hl
eGFnb24vZWxmbG9hZC5jCisrKyBiL2xpbnV4LXVzZXIvaGV4YWdvbi9lbGZsb2FkLmMKQEAgLTEx
Myw2ICsxMTMsMTAgQEAgY29uc3QgY2hhciAqZ2V0X2VsZl9jcHVfbW9kZWwodWludDMyX3QgZWZs
YWdzKQogICAgICAgICByZXR1cm4gInY3OSI7CiAgICAgY2FzZSAweDgxOgogICAgICAgICByZXR1
cm4gInY4MSI7CisgICAgY2FzZSAweDgzOgorICAgICAgICByZXR1cm4gInY4MyI7CisgICAgY2Fz
ZSAweDg1OgorICAgICAgICByZXR1cm4gInY4NSI7CiAgICAgfQogCiAgICAgZXJyID0gc25wcmlu
dGYoYnVmLCBzaXplb2YoYnVmKSwgInVua25vd24gKDB4JXgpIiwgZWZsYWdzKTsKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggZjIw
ZDZkZTZmNjMuLjFlM2RmNWQwZDAzIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYwor
KysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtOTM0LDYgKzkzNCw4IEBAIHN0YXRpYyBjb25z
dCBUeXBlSW5mbyBoZXhhZ29uX2NwdV90eXBlX2luZm9zW10gPSB7CiAgICAgREVGSU5FX0NQVShU
WVBFX0hFWEFHT05fQ1BVX1Y3NSwgICAgICAgICAgICAgIEhFWF9WRVJfVjc1KSwKICAgICBERUZJ
TkVfQ1BVKFRZUEVfSEVYQUdPTl9DUFVfVjc5LCAgICAgICAgICAgICAgSEVYX1ZFUl9WNzkpLAog
ICAgIERFRklORV9DUFUoVFlQRV9IRVhBR09OX0NQVV9WODEsICAgICAgICAgICAgICBIRVhfVkVS
X1Y4MSksCisgICAgREVGSU5FX0NQVShUWVBFX0hFWEFHT05fQ1BVX1Y4MywgICAgICAgICAgICAg
IEhFWF9WRVJfVjgzKSwKKyAgICBERUZJTkVfQ1BVKFRZUEVfSEVYQUdPTl9DUFVfVjg1LCAgICAg
ICAgICAgICAgSEVYX1ZFUl9WODUpLAogfTsKIAogREVGSU5FX1RZUEVTKGhleGFnb25fY3B1X3R5
cGVfaW5mb3MpCi0tIAoyLjM0LjEKCg==

