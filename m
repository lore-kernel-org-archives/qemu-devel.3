Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C57C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuB6t-0004Xo-6Y; Wed, 12 Aug 2026 11:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB6X-0004L5-GP
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:42:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB6U-0000EM-SF
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:42:57 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CDbYTg3597627
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ek2ZiHWFHeWKYPX7DkjBckxgukuuxX1Gf2L/3Ya/QyA=; b=CX50WMg2mdxLrF/3
 nv6RJY2kO2lAQvUP8RIq7pgO9ML4htdqhLGVBRWnYHIknn94x6stXW9bugVNh7Ju
 YDNitMjSdC4SrymlXQ3tyB1JlORFtRvELKmLZD2SyTsZW5SDLh5byoMTEwoA0b5m
 8r1aTeXiuwr6WaCXWldIDdlz945lCg3aSIj0ubkn0xKWRqT+DS0wjbXBzF4v7WWK
 OQRdNRIDprbKB2Kuh7XsalZhmM9Rxxrh2vLW0qfu/vXgvN1BgGfaSSReFgo7gt0C
 xG66iSFTWFHyCQcdCh8h3JQtOffDGw7WxDCTede+RAwEDlhKI2LXwZHuyQQtHyPy
 BHlhVQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g08jrmrpv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:42:47 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbef1d25500so212531a12.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786549367; x=1787154167; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ek2ZiHWFHeWKYPX7DkjBckxgukuuxX1Gf2L/3Ya/QyA=;
 b=Rdx9QBXN9mse4sYeDAvmDiL8Fp2i+GmAUgmqfiBLJSxkCsTJiGLZ4stMF+1qQWEkEx
 NmBF3Xr8i8GvJHMun540xnJelpqVcqITkTmQYbE5hHbrzHxMtLu8dFduXn7xtNAwMUvI
 dO8cBfLXZx2a7UoE94sv9TgfUSMeyYSTl9C7wgCurkoJ8tNgg+E/l+2E4PnOiiWpk/gj
 +099z9Ilj67pTFmPcJmjEU91DDq4sY8RVmBcRj87XqQ/vbgEq3wNpqA1B0BL7mbQH4R9
 0PDzTQ4rAsyTgzUHBC9U2CwWr4+B96MdjvUnAZbxI+AOYPXpeaPV1y/gl8t88LV2isJj
 +vKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786549367; x=1787154167;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ek2ZiHWFHeWKYPX7DkjBckxgukuuxX1Gf2L/3Ya/QyA=;
 b=VAWkX4Sy7ufbCEOKGNhyvynW5ilNOa5b4FZCbpO/g/h6VpqHI2n1bTKBLrQ+alBnJZ
 y6CLO7cawK2vCibcWr9AeY+xv1b7b+bi4C+I6ecoRffMNAYNLqFSC21FPQkFiQMCi27I
 Kvtw9CnWfT8BlyW9ZiFZqnsv7+VVgy9Mo6+qEjMK9I1R3+uurBju7BsjCqbJ5/LrqggN
 yk8YHt9z/YR/cPdtoUvAuk0AurQb1BV+SKTw1Y1nD8PkyL0JZtUNGT90elFYw4jJep0k
 BpyutGnZTgerwEJsedF+u4dpy3yCyU+gN8bUs3M43KdApJyzjY2QgKVpvGbEZRVdc8I0
 r//g==
X-Gm-Message-State: AOJu0YwgZ8+jGGgfR9id0q48jLv+oWCtQpJXAQrjOgSf6O5T6wE0j+Lk
 i/zDyNmd/jn+HVE67JOHJYLcI7/m38pwnjZfXY3qTd/jDRbFcJfuYD+gpjZaZmg138BIcnWb9if
 fc5kGKOPQh7q9BLS2pfFfFuu+R6gCydIPYoGQIHOovdWLrIYBvRg2ZWeiqTfw6g2QRQ==
X-Gm-Gg: AR+sD130EhlFSrxA86m5w0Sz6a+l96eNH/LPhshIwPHbLIgItb6uegUZsH1ol6XDwpm
 p12pEqK9jyMs+q1JFFAHfZKOJVFvwJCaT9GX7ZsVAj2J1BQreDCNV14UL6ZR+x6VWNZi1FViw2L
 Dxdz0U89novWAEs4vvklrnKaLKlwk8+KtDQeYTpDTzehcyEPDgrCLPxt0t2JzfvQ/6ZGMhhU7oO
 futof1e+R5tvbE+QDkHqj/K0FAK7GK0/etPNKTu9CJncXXeemS2glyqe1Rh+F/15F8RB5sgRbzX
 uIw2BHZwQ065LxsqwnLJf+I0EHSRLWQF+yXADplLP9QjEpqBo+X7rE1Rn3Syu0bjLMbp64oKIH5
 Ki3HPmoRTmudR8VD46ijazZJMlk9uUnU+R5WC0RYG+ZWpebO0
X-Received: by 2002:a05:6a20:12d5:b0:3bf:c28f:8afc with SMTP id
 adf61e73a8af0-3cc3f2168camr6867546637.0.1786549366932; 
 Wed, 12 Aug 2026 08:42:46 -0700 (PDT)
X-Received: by 2002:a05:6a20:12d5:b0:3bf:c28f:8afc with SMTP id
 adf61e73a8af0-3cc3f2168camr6866825637.0.1786549361676; 
 Wed, 12 Aug 2026 08:42:41 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31da7bf64b5sm8121190eec.10.2026.08.12.08.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:42:40 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 02/41] hw/hexagon: move VTCM to the common machine state
Date: Wed, 12 Aug 2026 08:41:41 -0700
Message-Id: <20260812154220.1029828-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
References: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: -SgEI_vMSC4TwMolepcswMwP3MeXUpNi
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfX2MhrBo5n+0/e
 iGgnadkyieVBS+rZY1SveVuJXNbxOuAB+Ii3SBzp9wyYkhrBTKtvYF8SUGcQ5AZ3QGgJJBikCb4
 RG+dlhr35EgHHYEs/GHCEs9ycDixxwA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfXwa3s4Co/y7IR
 JKoPIzTIJHE9GocuPXDWucZpNoido7eEkOQTZInFRz0bjFvgCe6N9+SEVZbvitP04v3L16JFywL
 Rx9nG4oH1jdMAuCKMTTslikMmW1Q68LfWU/7O1lDrmXFoK45OQlDVKPmJeOIKmGiewjOyGD/Npk
 4P+8u4F6ZGXau5qlR8DIav9xRmrhTlD1rJFBh7MTboiswkjnsSkXJFhQLTpHUFJOWHezg6m0Oa1
 ANsdEpttmdCepz/MBAN3G5/2YEiO/B9htJRpDy2nE0hapCEblw99pR0+haJjR9dAhGAA+riwIjQ
 /sjUNB4vWuPAVpP9Q7kHo55p5lbZKy7MCPGa6EM1X8r5TD113CYGvhhAKM4YV+7Qc3OP5TZz/F+
 AVRsS36ppK5Xz/7FxYcjcfwneU0KETgsaXVGRIWRgbBSwYyuHJIF/kS60e8M7/n/rwZFYdHHTPT
 3yKPV7WZc8P6baSRc9Q==
X-Authority-Analysis: v=2.4 cv=Z7Dc2nRA c=1 sm=1 tr=0 ts=6a7c9477 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=31cAqr7vU2O6cbMaemAA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: -SgEI_vMSC4TwMolepcswMwP3MeXUpNi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120128
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

VGhlIFZUQ00gaXMgZGVzY3JpYmVkIGJ5IHRoZSBjb25maWcgdGFibGUsIHNvIGV2ZXJ5IG1hY2hp
bmUgY2FuIHNldCBpdAp1cCB0aGUgc2FtZSB3YXkuCgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91
dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpMaW5rOiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYwODA2MDQyNzIzLjM3ODUzNjktMy1icmlhbi5j
YWluQG9zcy5xdWFsY29tbS5jb20KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2Fp
bkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGluY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uLmggfCAx
ICsKIGluY2x1ZGUvaHcvaGV4YWdvbi92aXJ0LmggICAgfCAxIC0KIGh3L2hleGFnb24vaGV4LXN1
YnN5cy5jICAgICAgfCA4ICsrKysrKysrCiBody9oZXhhZ29uL3ZpcnQuYyAgICAgICAgICAgIHwg
NSAtLS0tLQogNCBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb24uaCBiL2luY2x1ZGUvaHcv
aGV4YWdvbi9oZXhhZ29uLmgKaW5kZXggMTAzNGIwOWMyYWMuLjljNzNjYWRiMTZkIDEwMDY0NAot
LS0gYS9pbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5oCisrKyBiL2luY2x1ZGUvaHcvaGV4YWdv
bi9oZXhhZ29uLmgKQEAgLTE1Niw2ICsxNTYsNyBAQCBzdHJ1Y3QgSGV4YWdvbkNvbW1vbk1hY2hp
bmVTdGF0ZSB7CiAKICAgICBNZW1vcnlSZWdpb24gcmFtOwogICAgIE1lbW9yeVJlZ2lvbiBjZmd0
YWJsZV9yb207CisgICAgTWVtb3J5UmVnaW9uIHZ0Y207CiB9OwogCiAjZW5kaWYKZGlmZiAtLWdp
dCBhL2luY2x1ZGUvaHcvaGV4YWdvbi92aXJ0LmggYi9pbmNsdWRlL2h3L2hleGFnb24vdmlydC5o
CmluZGV4IGZjYjQ3NzYyMTk0Li5jZjBjZDJmOGYyMiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9ody9o
ZXhhZ29uL3ZpcnQuaAorKysgYi9pbmNsdWRlL2h3L2hleGFnb24vdmlydC5oCkBAIC0xNyw3ICsx
Nyw2IEBAIHN0cnVjdCBIZXhhZ29uVmlydE1hY2hpbmVTdGF0ZSB7CiAgICAgaW50IGZkdF9zaXpl
OwogICAgIE1lbW9yeVJlZ2lvbiAqc3lzOwogICAgIE1lbW9yeVJlZ2lvbiB0Y207Ci0gICAgTWVt
b3J5UmVnaW9uIHZ0Y207CiAgICAgTWVtb3J5UmVnaW9uIGJpb3M7CiAgICAgQ2xvY2sgKmFwYl9j
bGs7CiB9OwpkaWZmIC0tZ2l0IGEvaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMgYi9ody9oZXhhZ29u
L2hleC1zdWJzeXMuYwppbmRleCBkMTQ2ZWUwYzA3NS4uMGMyMGNmMDJlN2QgMTAwNjQ0Ci0tLSBh
L2h3L2hleGFnb24vaGV4LXN1YnN5cy5jCisrKyBiL2h3L2hleGFnb24vaGV4LXN1YnN5cy5jCkBA
IC0yOSw0ICsyOSwxMiBAQCB2b2lkIGhleF9zdWJzeXNfY3JlYXRlKEhleGFnb25Db21tb25NYWNo
aW5lU3RhdGUgKmhtcywKICAgICByb21fYWRkX2Jsb2JfZml4ZWRfYXMoImNvbmZpZ190YWJsZS5y
b20iLCAmbV9jZmctPmNmZ3RhYmxlLAogICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplb2Yo
bV9jZmctPmNmZ3RhYmxlKSwgbV9jZmctPmNmZ2Jhc2UsCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICZhZGRyZXNzX3NwYWNlX21lbW9yeSk7CisKKyAgICBpZiAobV9jZmctPmNmZ3RhYmxlLnZ0
Y21fc2l6ZV9rYiA+IDApIHsKKyAgICAgICAgbWVtb3J5X3JlZ2lvbl9pbml0X3JhbSgmaG1zLT52
dGNtLCBOVUxMLCAidnRjbS5yYW0iLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1f
Y2ZnLT5jZmd0YWJsZS52dGNtX3NpemVfa2IgKiAxMDI0LAorICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICZlcnJvcl9mYXRhbCk7CisgICAgICAgIG1lbW9yeV9yZWdpb25fYWRkX3N1YnJl
Z2lvbihzeXNtZW0sIG1fY2ZnLT5jZmd0YWJsZS52dGNtX2Jhc2UgPDwgMTYsCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAmaG1zLT52dGNtKTsKKyAgICB9CiB9CmRpZmYgLS1n
aXQgYS9ody9oZXhhZ29uL3ZpcnQuYyBiL2h3L2hleGFnb24vdmlydC5jCmluZGV4IGFkMGJjNGYx
MzI5Li41M2VhYWZhZjg1YSAxMDA2NDQKLS0tIGEvaHcvaGV4YWdvbi92aXJ0LmMKKysrIGIvaHcv
aGV4YWdvbi92aXJ0LmMKQEAgLTc1LDExICs3NSw2IEBAIHN0YXRpYyB2b2lkIGZkdF9hZGRfaHZ4
KEhleGFnb25WaXJ0TWFjaGluZVN0YXRlICp2bXMsCiAgICAgY29uc3QgTWFjaGluZVN0YXRlICpt
cyA9IE1BQ0hJTkUodm1zKTsKICAgICB1aW50MzJfdCB2dGNtX3NpemVfYnl0ZXMgPSBtX2NmZy0+
Y2ZndGFibGUudnRjbV9zaXplX2tiICogMTAyNDsKICAgICBpZiAodnRjbV9zaXplX2J5dGVzID4g
MCkgewotICAgICAgICBtZW1vcnlfcmVnaW9uX2luaXRfcmFtKCZ2bXMtPnZ0Y20sIE5VTEwsICJ2
dGNtLnJhbSIsIHZ0Y21fc2l6ZV9ieXRlcywKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAmZXJyb3JfZmF0YWwpOwotICAgICAgICBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdpb24odm1z
LT5zeXMsIG1fY2ZnLT5jZmd0YWJsZS52dGNtX2Jhc2UgPDwgMTYsCi0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAmdm1zLT52dGNtKTsKLQogICAgICAgICBxZW11X2ZkdF9hZGRf
c3Vibm9kZShtcy0+ZmR0LCAiL3NvYy92dGNtIik7CiAgICAgICAgIHFlbXVfZmR0X3NldHByb3Bf
c3RyaW5nKG1zLT5mZHQsICIvc29jL3Z0Y20iLCAiY29tcGF0aWJsZSIsCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICJxY29tLGhleGFnb25fdnRjbSIpOwotLSAKMi4zNC4xCgo=

