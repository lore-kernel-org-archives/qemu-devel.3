Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D8CC624DB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 18:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Cc5-0000ZZ-Ma; Thu, 03 Sep 2026 14:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2Cc3-0000Yp-U3
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:56:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2Cc0-0000Yg-SU
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:56:39 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G3drD1431114
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 18:56:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wVznByCgK+i9gSXEJKo6KBY6Af47d8yQQJ0eBo38CYg=; b=ZofCDRY66Xtat1DF
 CFpOYqWhFUbizoiy60dfHUALBNNrAG4TaLyFsfzFO1fxyDgf2sTbI0Ps0AViYwWS
 1WuDkPxf5CRp3VB7M5prXXgsHR1/nNF55RzhXF8aMhl3Ll4M2PWEUoUfCcJySNnU
 TN63ZTV5dQ4tFrQxYLF12l8R9RAehc9070k/dE4qvXD7KNynl2dWGpCd1IfxywTd
 +KrNGmuGqS0Z4uWUDrSFUCwes63lhhSz2+xK0ChwXLJYjmRJNKcacjdxifrlMpHj
 3PA0YSgmT4fCed+PPgMXzhYQodtHpYwWb9Os1PHIlYZPlK0Kkd9sl4Qf5hmmALmE
 +Jqbtg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf1j4kkv6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 18:56:35 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-396b9ef3070so168467a91.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 11:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788461795; x=1789066595; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wVznByCgK+i9gSXEJKo6KBY6Af47d8yQQJ0eBo38CYg=;
 b=cOzuvMJ5TMJ72Lud+dfAWOreLGzd96kkKKe2Pv3miTsbiODyPU4LY3Tg7ASt8quL1j
 15q/GflTWtJOwFJY1hSa6a1SDK+LsJVZSjomVaGtv1vn370TBeNSUR87/n6kAiCC3IAX
 wwk8yEatbQDI6kFzt6U0I3p/MCzCcjTSiOcnxAHgUtiGdDNu5vE4u+9cLzgPoodAqTp1
 H6YbhxGPak8sErqAhF6djShlYePnZ7WbOB8cNq00usn9TDoj5WOJpVYl/cSOoUuKNLxs
 qcbzB8yYXkyZGxObcJLKGtktbPV3KBkBbnWpgLr2FQ7VN/U6S9TqGXlayUWfiTE76h1l
 9nog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788461795; x=1789066595;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wVznByCgK+i9gSXEJKo6KBY6Af47d8yQQJ0eBo38CYg=;
 b=IDG7rYqXyBL12IWQF13ai9KKUHw4l3U7zpSQGBohtrU4CHEFSQVXNNDGx6Wnsv62rq
 DCUXd6v9N23WeuOH8NJ5CqZ9S+7wntcFI/7m9VpJ5S/2jufoDFKnXisYeOLQlBCtLl+c
 vz0DfhjKUGFw0YeWBozQgH4gojnos/9ghJptKBkzXWSfoffmVOTN0t02ds6DaFjcBTmH
 HB/wJc0vZS9vUzaAcUp+xqpP6gcur7hyzBNAZQpthjOgU6vXbGYrQCfl77e3o3TSmS+b
 hCWcXeGTPRHv4m5f9roqyrzi2EXcCxk+Axmp0tZ+i7XpeUoHnZdDBM6gooPkfJE81lgp
 Sadg==
X-Gm-Message-State: AFuF++lGDNq3tyDidez4+qEfCn5bp17Qk/baulDUN91neC9A06bZskq9
 kZF8r6biRHMPFiwxQvRzk65te1RmpyVT8LPgbuE8eS1xqTP4PVFQ/7ZY8wuyDLv0ozWAJZ7l+Fe
 6tQdvdV9/1fhwMHSDkvzE9dIG7PeWA7HRPzBBnubyXRTLh08ks0p+RwR0vGLDJ6uZ5g==
X-Gm-Gg: AYBFou2RJf5pXFp0oS9Yth01mCuz31IC9Pcb0eNbF2WNe1wpWDidJ/F2aI5ZiP83avY
 ibuYTgWOZU1jk/BPVsGHGpcvBP7QYFLgU0xiqeWDe9Myvsw/tgnEjgGl/X8mhkn26tfYC9XpPGY
 KGML8eaW0LS/KfkPWECgDGp8W/XJ/xpwA3m37EemK/ev7GBOzpceDDILm4yCDQorMmum7MRs8fl
 ATHI2ZVkro3woygcQT1NcTO0Ow9uK6jajWoCtqHq6hjd7nwAGAymgY+mzP0E2dhwgIu2Yd37y3V
 TI8q3pTD3j2NJolM/cLCgdHB/lOkVXuQyHb5aYXx6jrXXiTa00zqeWK3BTfj3l9aUc1h0TR7uzR
 F2t6WaY4330F4OD++FLXxMOjJQHUgaZ/H96LqNSi3ur1lfY1S
X-Received: by 2002:a17:90b:4c51:b0:38e:57a3:f218 with SMTP id
 98e67ed59e1d1-39b26204e5bmr599310a91.13.1788461794538; 
 Thu, 03 Sep 2026 11:56:34 -0700 (PDT)
X-Received: by 2002:a17:90b:4c51:b0:38e:57a3:f218 with SMTP id
 98e67ed59e1d1-39b26204e5bmr599261a91.13.1788461794037; 
 Thu, 03 Sep 2026 11:56:34 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339c0ec914sm922974eec.31.2026.09.03.11.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 11:56:33 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 6/8] hexagon: raise imprecise exception for multi-TLB matches
Date: Thu,  3 Sep 2026 11:56:20 -0700
Message-Id: <20260903185622.3234171-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260903185622.3234171-1-brian.cain@oss.qualcomm.com>
References: <20260903185622.3234171-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=dufrzVg4 c=1 sm=1 tr=0 ts=6a99c2e3 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=afvixaqROyvvyxJKKgMA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: Lmn1WjxSerdEIaeBRgaU4fXrERXhPYU3
X-Proofpoint-ORIG-GUID: Lmn1WjxSerdEIaeBRgaU4fXrERXhPYU3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2NSBTYWx0ZWRfX8G4XuHtj9Md6
 6BBP3Urivycw//ksPKzPUZplaauoPjhqu/FY9hqGmolRl307pOm2SMi8natEdv7stY3MncgYA8T
 THJU9ya34OepEBgVD35gJOVgGtZ1jjw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2NSBTYWx0ZWRfX1fe/Qt4Ms/Pi
 cZ84uy7DOv0iSl5CHo7YSkZTHk2j+kmBuSBF72zVuZD9Vo/1gzR0FylkHS+Wnm94wQQXY/fsuY8
 8SbPne5Yw+EiIZMFe6vs2bxB7OjvvuI0ltWIY9RFPm/0/OfRnjg4AhoKeeGYmk1VGtQe7dtf+0l
 oV6+lHXWEJXaN6nyclnk/7CxqyLG84zZaenmi5QF/WP72L2pZ/0TVH2h4rheQjiRmgnBl2r1szk
 u9WC8tO8Ul8Xq4jEl018vgx2nfMya5U8p3PzsF4h03SaM/U6uLoJRHn7Nb1d7uFVKU447+Qi447
 fZdFeqeGrRA7saT4g0c1CykBMqYJUnvNSUuf5SgntEPx5YjI/S3plqLxAE0qzEcez7l1wf3HtLH
 4Wzt75sMNnTDhqq0l3uCks6STOGwpHtua1oswohKuXIV2F3jGz1kIRkJytOzj1tN9sRw4QfWbct
 hxL11lC/m6RebcYtM/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030165
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

VGhlIFRMQiB3YWxrIHN0b3BwZWQgYXQgdGhlIGZpcnN0IG1hdGNoaW5nIGVudHJ5LCBzbyBpbnN0
cnVjdGlvbiBhbmQgZGF0YQp0cmFuc2xhdGlvbnMgZGlkIG5vdCBkZXRlY3QgYSBzZWNvbmQgdmFs
aWQgbWFwcGluZyBmb3IgdGhlIHNhbWUgVkEgYW5kIEFTSUQuCgpTY2FuIHRoZSByZW1haW5pbmcg
ZW50cmllcyBhZnRlciBzZWxlY3RpbmcgdGhlIHRyYW5zbGF0aW9uLiAgT24gYSBzZWNvbmQKbWF0
Y2gsIHJldGFpbiB0aGUgZmlyc3QgZW50cnkgZm9yIHRoZSBhY2Nlc3MgYnV0IHJlY29yZApIRVhf
Q0FVU0VfSU1QUkVDSVNFX01VTFRJX1RMQl9NQVRDSCBhcyBhIHBlbmRpbmcgaW1wcmVjaXNlIGV4
Y2VwdGlvbi4KCk1vdmUgdGhhdCBleGNlcHRpb24gb3V0IG9mIHRoZSBzeW5jaHJvbm91cyBUTEIt
ZmlsbCByZXN1bHQgYW5kIGNoZWNrIGZvciBpdAphZnRlciBldmVyeSBwYWNrZXQsIHJhdGhlciB0
aGFuIG9ubHkgcGFja2V0cyBjb250YWluaW5nIHRsYnAuICBUaGlzIGRlbGl2ZXJzCnRoZSBhcmNo
aXRlY3R1cmFsIGltcHJlY2lzZSBleGNlcHRpb24gYWZ0ZXIgYW4gb3JkaW5hcnkgbWVtb3J5IGFj
Y2VzcyBhbmQKYXZvaWRzIHRyZWF0aW5nIGl0IGFzIGEgcHJlY2lzZSBwZXJtaXNzaW9uIGZhdWx0
LiAgQ2xlYXIgdGhlIHBlbmRpbmcgc3RhdGUKd2hlbiBzdGFydGluZyBhIG5ldyB0cmFuc2xhdGlv
biBhbmQgYWZ0ZXIgZGVsaXZlcmluZyB0aGUgZXhjZXB0aW9uLgoKVGhlIHYwLjIuMTQgbW11X211
bHRpX3RsYiBzeXN0ZXN0IHVuY292ZXJlZCB0aGlzIGJ1Zy4KClNpZ25lZC1vZmYtYnk6IEJyaWFu
IENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBody9oZXhhZ29uL2hleGFn
b25fdGxiLmMgICB8IDEwICsrKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2hleF9tbXUuYyAgIHwg
MTIgKysrKysrKysrLS0tCiB0YXJnZXQvaGV4YWdvbi9oZXhzd2kuYyAgICB8ICAxICsKIHRhcmdl
dC9oZXhhZ29uL3RyYW5zbGF0ZS5jIHwgMjIgKysrKysrKystLS0tLS0tLS0tLS0tLQogNCBmaWxl
cyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9ody9oZXhhZ29uL2hleGFnb25fdGxiLmMgYi9ody9oZXhhZ29uL2hleGFnb25fdGxiLmMKaW5k
ZXggYzc2ODA1YWJhYzkuLjE1N2QwM2U1MWJmIDEwMDY0NAotLS0gYS9ody9oZXhhZ29uL2hleGFn
b25fdGxiLmMKKysrIGIvaHcvaGV4YWdvbi9oZXhhZ29uX3RsYi5jCkBAIC0zMjYsNiArMzI2LDE2
IEBAIGJvb2wgaGV4YWdvbl90bGJfZmluZF9tYXRjaChIZXhhZ29uVExCU3RhdGUgKnRsYiwgdWlu
dDMyX3QgYXNpZCwKICAgICBmb3IgKHVpbnQzMl90IGkgPSAwOyBpIDwgdGxiLT5udW1fZW50cmll
czsgaSsrKSB7CiAgICAgICAgIGlmIChoZXhfdGxiX2VudHJ5X21hdGNoKHRsYi0+ZW50cmllc1tp
XSwgYXNpZCwgVkEsIGFjY2Vzc190eXBlLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBQQSwgcHJvdCwgc2l6ZSwgZXhjcCwgY2F1c2VfY29kZSwgbW11X2lkeCkpIHsKKyAgICAgICAg
ICAgIGlmICgqZXhjcCA9PSAwKSB7CisgICAgICAgICAgICAgICAgZm9yIChpKys7IGkgPCB0bGIt
Pm51bV9lbnRyaWVzOyBpKyspIHsKKyAgICAgICAgICAgICAgICAgICAgaWYgKGhleF90bGJfZW50
cnlfbWF0Y2hfbm9wZXJtKHRsYi0+ZW50cmllc1tpXSwgYXNpZCwKKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZBKSkgeworICAgICAgICAgICAgICAg
ICAgICAgICAgKmV4Y3AgPSBIRVhfRVZFTlRfSU1QUkVDSVNFOworICAgICAgICAgICAgICAgICAg
ICAgICAgKmNhdXNlX2NvZGUgPSBIRVhfQ0FVU0VfSU1QUkVDSVNFX01VTFRJX1RMQl9NQVRDSDsK
KyAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOworICAgICAgICAgICAgICAgICAgICB9Cisg
ICAgICAgICAgICAgICAgfQorICAgICAgICAgICAgfQogICAgICAgICAgICAgcmV0dXJuIHRydWU7
CiAgICAgICAgIH0KICAgICB9CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhfbW11LmMg
Yi90YXJnZXQvaGV4YWdvbi9oZXhfbW11LmMKaW5kZXggZDYyNThjNjczZDEuLmQ2ZWU3YzQwNzk4
IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9oZXhfbW11LmMKKysrIGIvdGFyZ2V0L2hleGFn
b24vaGV4X21tdS5jCkBAIC03MSwxMCArNzEsMTYgQEAgYm9vbCBoZXhfdGxiX2ZpbmRfbWF0Y2go
Q1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IFZBLAogICAgIHVpbnQzMl90IHNzciA9IGVu
di0+dF9zcmVnW0hFWF9TUkVHX1NTUl07CiAgICAgdWludDhfdCBhc2lkID0gR0VUX1NTUl9GSUVM
RChTU1JfQVNJRCwgc3NyKTsKICAgICBpbnQgY2F1c2VfY29kZSA9IDA7CisgICAgYm9vbCBmb3Vu
ZDsKIAotICAgIGJvb2wgZm91bmQgPSBoZXhhZ29uX3RsYl9maW5kX21hdGNoKGNwdS0+dGxiLCBh
c2lkLCBWQSwgYWNjZXNzX3R5cGUsCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgUEEsIHByb3QsIHNpemUsIGV4Y3AsICZjYXVzZV9jb2RlLAotICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIG1tdV9pZHgpOworICAgIGVudi0+aW1wcmVjaXNlX2V4
Y2VwdGlvbiA9IDA7CisgICAgZm91bmQgPSBoZXhhZ29uX3RsYl9maW5kX21hdGNoKGNwdS0+dGxi
LCBhc2lkLCBWQSwgYWNjZXNzX3R5cGUsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFBBLCBwcm90LCBzaXplLCBleGNwLCAmY2F1c2VfY29kZSwKKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgbW11X2lkeCk7CisgICAgaWYgKCpleGNwID09IEhFWF9FVkVOVF9J
TVBSRUNJU0UpIHsKKyAgICAgICAgZW52LT5pbXByZWNpc2VfZXhjZXB0aW9uID0gKmV4Y3A7Cisg
ICAgICAgICpleGNwID0gMDsKKyAgICB9CiAgICAgaWYgKGNhdXNlX2NvZGUpIHsKICAgICAgICAg
ZW52LT5jYXVzZV9jb2RlID0gY2F1c2VfY29kZTsKICAgICB9CmRpZmYgLS1naXQgYS90YXJnZXQv
aGV4YWdvbi9oZXhzd2kuYyBiL3RhcmdldC9oZXhhZ29uL2hleHN3aS5jCmluZGV4IDc1ZjBhOWNj
NTIwLi40NzA1ZTkxNWFlYSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMKKysr
IGIvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMKQEAgLTkzNCw2ICs5MzQsNyBAQCB2b2lkIGhleGFn
b25fY3B1X2RvX2ludGVycnVwdChDUFVTdGF0ZSAqY3MpCiAgICAgICAgIGJyZWFrOwogCiAgICAg
Y2FzZSBIRVhfRVZFTlRfSU1QUkVDSVNFOgorICAgICAgICBlbnYtPmltcHJlY2lzZV9leGNlcHRp
b24gPSAwOwogICAgICAgICBpZiAoZ2V0X2V4ZV9tb2RlKGVudikgPT0gSEVYX0VYRV9NT0RFX1dB
SVQpIHsKICAgICAgICAgICAgIGVudi0+Z3ByW0hFWF9SRUdfUENdID0gZW52LT53YWl0X25leHRf
cGMgLSA0OwogICAgICAgICAgICAgY2xlYXJfd2FpdF9tb2RlKGVudik7CmRpZmYgLS1naXQgYS90
YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmlu
ZGV4IGJlNzVlNWZkZWI4Li41ZDNkNjdlNWQzZSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKQEAgLTEwNjUsMjAg
KzEwNjUsMTQgQEAgc3RhdGljIHZvaWQgdXBkYXRlX2V4ZWNfY291bnRlcnMoRGlzYXNDb250ZXh0
ICpjdHgpCiAgKiBBIHRsYnAgaW5zdHJ1Y3Rpb24gbWF5IGRldGVjdCBtdWx0aXBsZSBUTEIgbWF0
Y2hlcyBhbmQgc2V0IGEgcGVuZGluZwogICogaW1wcmVjaXNlIGV4Y2VwdGlvbi4gIFJhaXNlIGl0
IGFmdGVyIHRoZSBwYWNrZXQgdGhhdCByYW4gdGhlIHRsYnAuCiAgKi8KLXN0YXRpYyB2b2lkIGNo
ZWNrX2ltcHJlY2lzZV9leGNlcHRpb24oUGFja2V0ICpwa3QpCitzdGF0aWMgdm9pZCBjaGVja19p
bXByZWNpc2VfZXhjZXB0aW9uKERpc2FzQ29udGV4dCAqY3R4KQogewotICAgIGZvciAoaW50IGkg
PSAwOyBpIDwgcGt0LT5udW1faW5zbnM7IGkrKykgewotICAgICAgICBpZiAocGt0LT5pbnNuW2ld
Lm9wY29kZSA9PSBZMl90bGJwKSB7Ci0gICAgICAgICAgICBUQ0d2IFBDID0gdGNnX2NvbnN0YW50
X3RsKHBrdC0+cGMpOwotICAgICAgICAgICAgVENHTGFiZWwgKmxhYmVsID0gZ2VuX25ld19sYWJl
bCgpOwotICAgICAgICAgICAgdGNnX2dlbl9icmNvbmRpX3RsKFRDR19DT05EX0VRLCBoZXhfaW1w
cmVjaXNlX2V4Y2VwdGlvbiwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwLCBsYWJl
bCk7Ci0gICAgICAgICAgICBnZW5faGVscGVyX3JhaXNlX2V4Y2VwdGlvbih0Y2dfZW52LAotICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaGV4X2ltcHJlY2lzZV9leGNlcHRp
b24sIFBDKTsKLSAgICAgICAgICAgIGdlbl9zZXRfbGFiZWwobGFiZWwpOwotICAgICAgICAgICAg
cmV0dXJuOwotICAgICAgICB9Ci0gICAgfQorICAgIFRDR3YgUEMgPSB0Y2dfY29uc3RhbnRfdGwo
Y3R4LT5wa3QucGMpOworICAgIFRDR0xhYmVsICpsYWJlbCA9IGdlbl9uZXdfbGFiZWwoKTsKKwor
ICAgIHRjZ19nZW5fYnJjb25kaV90bChUQ0dfQ09ORF9FUSwgaGV4X2ltcHJlY2lzZV9leGNlcHRp
b24sIDAsIGxhYmVsKTsKKyAgICBnZW5faGVscGVyX3JhaXNlX2V4Y2VwdGlvbih0Y2dfZW52LCBo
ZXhfaW1wcmVjaXNlX2V4Y2VwdGlvbiwgUEMpOworICAgIGdlbl9zZXRfbGFiZWwobGFiZWwpOwog
fQogI2VuZGlmCiAKQEAgLTExODIsNyArMTE3Niw3IEBAIHN0YXRpYyB2b2lkIGdlbl9jb21taXRf
cGFja2V0KERpc2FzQ29udGV4dCAqY3R4KQogICAgIH0KIAogI2lmbmRlZiBDT05GSUdfVVNFUl9P
TkxZCi0gICAgY2hlY2tfaW1wcmVjaXNlX2V4Y2VwdGlvbigmY3R4LT5wa3QpOworICAgIGNoZWNr
X2ltcHJlY2lzZV9leGNlcHRpb24oY3R4KTsKICNlbmRpZgogCiAgICAgaWYgKGN0eC0+cGt0X2Vu
ZHNfdGIgfHwgY3R4LT5iYXNlLmlzX2ptcCA9PSBESVNBU19OT1JFVFVSTikgewotLSAKMi4zNC4x
Cgo=

