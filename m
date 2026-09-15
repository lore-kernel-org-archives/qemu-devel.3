Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57164C88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6W4W-0006GN-PU; Tue, 15 Sep 2026 12:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W4C-0005zp-Os
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:31:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W4B-0003sQ-23
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:31:32 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FFAdmK2836562
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hRpOAAmPkxRy8tVUpIWqs9FFG5bf3DWD2jGR8TiQ8p8=; b=e9xj/Ah6Se5+n3sb
 kGx1CdQCF1yvQsuN32g8JpafkyZCu3hCdLrAjBlG87PCxVReRlJbIMU8PTF1uTOu
 h3VDMaX3p/2agMaP6BKGlitoqNtPduQoTz8CqBsjegnLGeYmh6BqPYil5ipSLLyM
 p+enUieOYWiWmJsyDfmoddrOljYbyAX3GtnRmIJN/va2sKdF4uzXwpnocpgmOYgC
 4KGeeiiXelcW+pzYQsGNoCkZTFhd6Xvc91QF4mbMk5bbhuDdgT144YmzKd6ECB2D
 jv9mI2z8QLxOMrGnXJ/WI1ixUTPvxVUUWkH0Kaht69QThR3A5jDFOPry8X+33J5c
 c2wJdQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq1qpayp4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:31:29 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39deb05ef51so3097504a91.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789489889; x=1790094689; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hRpOAAmPkxRy8tVUpIWqs9FFG5bf3DWD2jGR8TiQ8p8=;
 b=J9tjpL4xKvxfGJxtKTB1Bb9pONlAF5pUv/wakHJhRJEMF/yo/ky+67jeZGpvpnhrJa
 YTFWH2J+puL+3ROOeGL2Dpo6Pn2xvwMs52By6E2lL/gVUxYprxG8zvAFnYlC7SFolIGb
 8uoWfHMqX3ofWGh3ub81zM01eYgHgXZhGjxJsdV99QV/K97q/VkWi+6V+Qc/T7+/6I/O
 0ivHhSFaI2APIZUDRjnKix0wA2EWgA8TrufSa2nRPBqfHeWMKz3Kf7ylMMkT1wL0YPMh
 7sB/9uhkuan1Vs+Ydgw2IawNCqXVQsa+Nthkr6pE+8tX9IiTozOwqMC7s9pqDvRtT4zM
 nEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789489889; x=1790094689;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hRpOAAmPkxRy8tVUpIWqs9FFG5bf3DWD2jGR8TiQ8p8=;
 b=eKxouQwpEm/ziEmnEA9pOUwQip4AMfyQPh5kIHDr+i2Wx8W//OeD5cjFBwIa4ImoZd
 /7ip2ogPFUgTwY9IMMFj+nAhzPjYbo9CtGUnMZNgIMiF1RYhjDbXp904PR8rnRsYXg9g
 r4S802RDRZuHKU4sD1RAnw+9cQ35CWA/BmOXQiaooa4l5EfXm+UAeV5hvx3CJFQJ2CCi
 TJcLhQtx6PQHioUBOOVE6yXn9C0JKRwl1BJ5zXRi/OOdzGcZTAjSv1DemMcr/yVaYIHA
 lXlHkJ/IOH5VGwXcSVCA8PA9HF9mqunVvlzJBA5ztuO10hKYOCLrGiZZogusgmEa7E90
 c2RQ==
X-Gm-Message-State: AFuF++nTVvnGp0Z0d5/ipPIFbessBoCbUXMO7Zvg2owUjbHxMH6p8JZ6
 mctU4yLoohXhFDseiieyzGdyILWtCPRr90p57c4RGDPhQUlesW2SKCIfT1ABbGBzraNwCnugUGL
 /5FsB4K8RUIDKjrEipfH5X8KsnTmmhHV+JCniJcowadTvuRrGEs8MoJwL/T+A2sUXlg==
X-Gm-Gg: AYBFou23j1JUqpQDzTkV8qyplacif69hARN3pRNtZkA/0P92QpRQPeHt0hhVe3l1SsA
 r1nNuwuKiGCuffez/9r0qsnnAhDWPdhrDU8PJo/MHhncxBGIKZYB0zihtvh9rWi4xzSy0S46V4N
 5fekRK5OWd5UiXU9P8f7PFt3j3UrQOf1ctNZcjmgMVt3JB2e3GXznODZo8ZUnLP0HvXn4Bln7tU
 zuRoKaDyXvrCa/3iMWKrtbnCl7dZSF3XP3ECTCZ/MRp+4ntBc83wC6B0Z0r7WYYYJb/BA5gmT8A
 cRB3Wrwt1F3UTG+zlVap+OnT3no0r2Yp7bkhBg1YZ0wgBqzis6+0OW/Y7j2Mg0WPumPBJoE/4ti
 7zwMiwCqeMkMT/Bshw0/tB8UExs22C8OaaUCFPmDDGO3ixFKp
X-Received: by 2002:a17:90a:f16:b0:39e:b7:cbe8 with SMTP id
 98e67ed59e1d1-39e00b7d278mr6649075a91.5.1789489888834; 
 Tue, 15 Sep 2026 09:31:28 -0700 (PDT)
X-Received: by 2002:a17:90a:f16:b0:39e:b7:cbe8 with SMTP id
 98e67ed59e1d1-39e00b7d278mr6648996a91.5.1789489888317; 
 Tue, 15 Sep 2026 09:31:28 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdd0baaasm6068590a91.9.2026.09.15.09.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:31:27 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: sid.manning@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 16/17] tests/tcg/hexagon: add scalar+HVX and masked store
 tests
Date: Tue, 15 Sep 2026 09:30:46 -0700
Message-Id: <20260915163047.4180600-17-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
References: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIzOSBTYWx0ZWRfX+bB/ms1oSRIS
 LiSi7W+bivyBJwfIGv167UjCmK/n1yBWdchLtARGSWBxrd7Jxx8ZLvmTlnAKcpeR96NaoGX9hEQ
 yr6vPaLw6EduZYp1ZK8ZbbkjRcXy3Xk=
X-Authority-Analysis: v=2.4 cv=I4Xw19gg c=1 sm=1 tr=0 ts=6aa972e1 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=ZgKQQoYZz-FTevMfDfAA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: XpOknXGNity_0mQV1uYTIpWpycNTTii1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIzOSBTYWx0ZWRfXz6fBFPmunon1
 PEF2PC/DDLJzO923dHpn6/11DDmu2DCK7HMaRUQzn2B1yy0bouB3vrHe0XYOxlAyS//tm35Gxnp
 8NxPKbKifu1J+KL5QTwmkBqqFpdpZNXthLkl1B//nM6R4UKIS9WPWK7AnLdkkn2NIHCdiw9UG/o
 o/1HRhmzZz20PMzg6YGrFOQrHIsTJnzP4+msfEjnHFKcm/UYHhH4ijrsp0+Xc0HbbtJDkUm98on
 L+CKPBe6A9G/M0+22F320/o7oZoedC/gWFmwQu34UFKFYz0OgS0fY4NpSIdDmggCtKA64eI0mye
 aCu6RrKDwXzDJ3BD/m3aD54Iey+LwMEj0+NLzeGb2Q2rGpxQizMi5saLFKb8sIkrpbKK0EmBgZd
 h72YdOJl4PjB7ItvrfVelBOeVkiJ5Q5sVaFImIKsNirDe8Vf6V6g2hFBfrrsiuiO+Un1iTejuCD
 NQBecaBh3rEjZmodd1A==
X-Proofpoint-GUID: XpOknXGNity_0mQV1uYTIpWpycNTTii1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150239
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

VGVzdCBhIHBhY2tldCB3aXRoIGJvdGggYSBzY2FsYXIgc3RvcmUgYW5kIGFuIEhWWCBzdG9yZSwg
YW5kIHRlc3QKYSBub24taW52ZXJ0ZWQgbWFza2VkIHN0b3JlIChpZiAocTApIHZtZW0pIHRvIHZl
cmlmeSB0aGUgaW52ZXJ0PWZhbHNlCnBhdGggaW4gbWFza2VkIHN0b3JlIGdlbmVyYXRpb24uCgpS
ZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNv
bW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29t
bS5jb20+Ci0tLQogdGVzdHMvdGNnL2hleGFnb24vaHZ4X21pc2MuYyB8IDY2ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDY2IGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS90ZXN0cy90Y2cvaGV4YWdvbi9odnhfbWlzYy5jIGIvdGVzdHMvdGNn
L2hleGFnb24vaHZ4X21pc2MuYwppbmRleCBmMjBhZmM4ZTY3MC4uMDI4NTg4NmMyYTUgMTAwNjQ0
Ci0tLSBhL3Rlc3RzL3RjZy9oZXhhZ29uL2h2eF9taXNjLmMKKysrIGIvdGVzdHMvdGNnL2hleGFn
b24vaHZ4X21pc2MuYwpAQCAtNTY2LDYgKzU2Niw2OSBAQCB2b2lkIHRlc3Rfc3RvcmVfbmV3KCkK
ICAgICBjaGVja19vdXRwdXRfdyhfX0xJTkVfXywgMSk7CiB9CiAKKy8qCisgKiBUZXN0IGEgcGFj
a2V0IHdpdGggYm90aCBhIHNjYWxhciBzdG9yZSBhbmQgYW4gSFZYIHN0b3JlLgorICovCitzdGF0
aWMgdWludDMyX3Qgc2NhbGFyX3N0b3JlX2RzdDsKKworc3RhdGljIHZvaWQgdGVzdF9zY2FsYXJf
aHZ4X3N0b3JlKHZvaWQpCit7CisgICAgc2NhbGFyX3N0b3JlX2RzdCA9IDA7CisgICAgbWVtc2V0
KCZleHBlY3RbMF0sIDAsIHNpemVvZihNTVZlY3RvcikpOworCisgICAgLyogRmlsbCB2MCB3aXRo
IDB4QUJDRCBwYXR0ZXJuICovCisgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBNQVhfVkVDX1NJWkVf
QllURVMgLyA0OyBpKyspIHsKKyAgICAgICAgZXhwZWN0WzBdLnV3W2ldID0gMHhBQkNEQUJDRDsK
KyAgICB9CisKKyAgICBhc20oInIwID0gIzB4QUJDREFCQ0Rcblx0IgorICAgICAgICAidjAgPSB2
c3BsYXQocjApXG5cdCIKKyAgICAgICAgInIxID0gIzQyXG5cdCIKKyAgICAgICAgIntcblx0Igor
ICAgICAgICAiICAgIG1lbXcoJVtzY2FsYXJdKSA9IHIxXG5cdCIKKyAgICAgICAgIiAgICB2bWVt
KCVbaHZ4XSkgPSB2MFxuXHQiCisgICAgICAgICJ9XG5cdCIKKyAgICAgICAgOgorICAgICAgICA6
IFtzY2FsYXJdICJyIigmc2NhbGFyX3N0b3JlX2RzdCksCisgICAgICAgICAgW2h2eF0gInIiKCZv
dXRwdXRbMF0pCisgICAgICAgIDogInIwIiwgInIxIiwgInYwIiwgIm1lbW9yeSIpOworCisgICAg
Y2hlY2tfb3V0cHV0X3coX19MSU5FX18sIDEpOworICAgIGlmIChzY2FsYXJfc3RvcmVfZHN0ICE9
IDQyKSB7CisgICAgICAgIHByaW50ZigiRVJST1IgYXQgbGluZSAlZDogc2NhbGFyX3N0b3JlX2Rz
dCA9ICVkLCBleHBlY3RlZCA0MlxuIiwKKyAgICAgICAgICAgICAgIF9fTElORV9fLCBzY2FsYXJf
c3RvcmVfZHN0KTsKKyAgICAgICAgZXJyKys7CisgICAgfQorfQorCisvKgorICogVGVzdCBub24t
aW52ZXJ0ZWQgbWFza2VkIHN0b3JlOiBpZiAoUXYpIHZtZW0oUnQpID0gVnMuCisgKiBFeGlzdGlu
ZyB0ZXN0cyBvbmx5IGNvdmVyIHRoZSBpbnZlcnRlZCBmb3JtICghUXYpLgorICogVXNlIGFuIGFs
bC10cnVlIFEgcHJlZGljYXRlIHRvIHVuY29uZGl0aW9uYWxseSBzdG9yZS4KKyAqLworc3RhdGlj
IHZvaWQgdGVzdF9tYXNrZWRfc3RvcmVfbm9uaW52ZXJ0KHZvaWQpCit7CisgICAgdm9pZCAqcDAg
PSBidWZmZXIwOworICAgIHZvaWQgKnBvdXQgPSBvdXRwdXQ7CisKKyAgICBtZW1zZXQoJm91dHB1
dFswXSwgMHhmZiwgc2l6ZW9mKE1NVmVjdG9yKSk7CisKKyAgICBmb3IgKGludCBpID0gMDsgaSA8
IE1BWF9WRUNfU0laRV9CWVRFUyAvIDQ7IGkrKykgeworICAgICAgICBleHBlY3RbMF0udXdbaV0g
PSBidWZmZXIwWzBdLnV3W2ldOworICAgIH0KKworICAgIGFzbSgidjUgPSB2bWVtKCVbc3JjXSAr
ICMwKVxuXHQiCisgICAgICAgICJyMCA9ICMtMVxuXHQiCisgICAgICAgICJ2NiA9IHZzcGxhdChy
MClcblx0IgorICAgICAgICAicTAgPSB2YW5kKHY2LCByMClcblx0IgorICAgICAgICAiaWYgKHEw
KSB2bWVtKCVbZHN0XSkgPSB2NVxuXHQiCisgICAgICAgIDoKKyAgICAgICAgOiBbc3JjXSAiciIo
cDApLCBbZHN0XSAiciIocG91dCkKKyAgICAgICAgOiAicjAiLCAidjUiLCAidjYiLCAicTAiLCAi
bWVtb3J5Iik7CisKKyAgICBjaGVja19vdXRwdXRfdyhfX0xJTkVfXywgMSk7Cit9CisKIGludCBt
YWluKCkKIHsKICAgICBpbml0X2J1ZmZlcnMoKTsKQEAgLTYxNSw2ICs2NzgsOSBAQCBpbnQgbWFp
bigpCiAKICAgICB0ZXN0X3N0b3JlX25ldygpOwogCisgICAgdGVzdF9zY2FsYXJfaHZ4X3N0b3Jl
KCk7CisgICAgdGVzdF9tYXNrZWRfc3RvcmVfbm9uaW52ZXJ0KCk7CisKICAgICBwdXRzKGVyciA/
ICJGQUlMIiA6ICJQQVNTIik7CiAgICAgcmV0dXJuIGVyciA/IDEgOiAwOwogfQotLSAKMi4zNC4x
Cgo=

