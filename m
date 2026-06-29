Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763EAC43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBo6-0005mN-V0; Mon, 29 Jun 2026 09:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBo5-0005gz-K4
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBo4-0003HA-4j
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:49 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATKLs2656156
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MzvUFKvc+sUpWvc2016FnOxj5PhtBZkyxIiMWx3S09s=; b=S5GV8S8UZNfFj7z6
 ibMp6ZmFL6znGjOPu7+wOL23jgEOayOg7czOVfnoH9uzVCGsJ4aBYMMaiUkWXVvZ
 gy89QBWTXVh1oZdI+LKJWxvG/gWIDrNLdQ2AgllGGkVq+L3IW9dduOEHxXXBln/I
 T8AOkFFrWAzi5FWLR1WVzsjwsdqfn6Nc608Gpi7SPAU3ddxnrwzgtE2BdxYuDcf7
 22399Gh9OnQ2Kj4CNfYsbjH8req8CZYH9/puh88HVDg8HAuRJvX1Tcj9Fw0oAUwG
 gJX01fqi+AeGWlV7zjzxb8Zi7eJ+jQNf1dtKb26lGXCi69IhkXlFQxKEtAAxIY40
 biINbQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3np7gxv3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:37 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30b877ee493so5157442eec.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782738816; x=1783343616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MzvUFKvc+sUpWvc2016FnOxj5PhtBZkyxIiMWx3S09s=;
 b=UC3qioMuu78ARsKPrDqFrb8KZbkPgPLtmLsJi0Ij8ktxPMrteIlo1d5UfLwf9l7Xrz
 BiEFQ9ceKsEis8Wt6mPZoZqxD3vW6k8kunczhKOE/HCEuZ75IwDb4QxNsgSBF0vZelyi
 cdswQ0P7LIOnkaFW2WqrVsqa0i98e/yKy3LjNsxjYnc8PN+Kw9RCC6C4A1DjZmqLkojn
 OjI2cxThFuezcXW1onHVnPyVVg/4Ux7wWTmixV0jw7PRM2NuSAgz6WzYyq5/28evleEw
 RX0U+qA77tfLl2aR93X034WAxtx1bf4uX3o/q2ZGjc3i/HwiTHTGTySMSXDIzC1ShnN3
 20fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782738816; x=1783343616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MzvUFKvc+sUpWvc2016FnOxj5PhtBZkyxIiMWx3S09s=;
 b=ppjBpBdvYQ3OfPF5OgVuJ6KhbUTqOKKpAZa2U8fz/CubZTWF4z8iJuXg0K3kGDXoAp
 mvmSXfWfgU0mKwULKJ3Ln/LA7BHDh7uedU7VZK9UKw6armUxm0lR0RPUoxu7yQODx9YJ
 Apg84S8Mi7VmTT/Hz3jG0Q+q2duxKlCVMt0eqbGg3+YexDBAEszOM6iD8jcJvtXsrRo3
 3vIQNdmHMnv/NdbeWDLVogqD+SUae4DfnrHjCL2ju+TzQ4rm8ge5a3c3GDVOjubPFWzm
 9DjcIVhlWzAjKXSmxrMlymweYRoyR3ARH8DXjofd5u/XcDX6NhOlsaiStSYabuv5OHBf
 v9tA==
X-Gm-Message-State: AOJu0YyKFTXitHO7xCD4bj2Lc58/dCEQSXBk0h9yI+z09PGIIrd3F4Ro
 K1dTQ0gKOC6eVN2n2MtImJZalphdszjPsIUQmg2Zn/bvbv4fkwdihcZU86c+17h58jiW0AYYQFP
 DoGAkP2Gl98QxI3rasdKvz0YG/qpZtG+ZARrsL7y01IDB1Dh6jWDlr08yuMp7EFc8Pw==
X-Gm-Gg: AfdE7cmA9P4wqGwLY5nd+6iCC9PctfwV8DrwBJKrdFb+Vgi7DzUKX8Tssz57qKFP7A6
 bAWcJIX2Q2lrnYgEokioYElg6GzEMel3yKqwGL+yCKHOdZ0gWsxG63wI0iyrZ9qqvWiqB7EiQhu
 niOEiXb69Us5HeSLIESpt1NeOME6o1R3QELqo/ixpRRw0+rlw+nnCXKH5Vp8BAU4udUPC/mwTAY
 MvLIlDkUCKQ6kT1bIE+tRsCVl4ISd41SqznbJE59Jd8zD3bj0RG4RCW3VDJdpQVyhiC2Gtlxchc
 eFFdRv+1RzcstJvD/i1WxYkLzG/VTUkJuPgwp789pdgmNNivOST1ELqvUP32ABA4zE77VUYEEpL
 1/cxYBu6uZUoKHu3K0tdS5NsUZlPhU+SqAf0Ank0UN90Wv0Cka64xPCP1kdQ=
X-Received: by 2002:a05:7022:f9b:b0:138:5049:cb88 with SMTP id
 a92af1059eb24-139c3c1f687mr19960082c88.8.1782738816251; 
 Mon, 29 Jun 2026 06:13:36 -0700 (PDT)
X-Received: by 2002:a05:7022:f9b:b0:138:5049:cb88 with SMTP id
 a92af1059eb24-139c3c1f687mr19960057c88.8.1782738815703; 
 Mon, 29 Jun 2026 06:13:35 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139e78317f3sm28459106c88.9.2026.06.29.06.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:13:34 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 35/77] target/hexagon: Add pcycle setting functionality
Date: Mon, 29 Jun 2026 06:11:50 -0700
Message-Id: <20260629131232.2487780-36-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX0Ziw3SBocic/
 ljQ4ijB5CcsFar4Fy6Xe4o1OXxFYDjPTppRf/or0B32/zNQ4fB80auOhfBF75O7Q03o8PnrraMf
 7LfEDh3Nwzc6d6ON/Xpodl8S674t17e6/ocpWKrFkrOkzrvKf76e9hjyA2WIRxBfAeti2G/+NBa
 oTfD3f5/ASbbxnP1blewutkAHet79LJaz3pfM31eweTZ4I0ADaYOmsFZEtv/RO5Vegxe68lSLsQ
 L3ujuRz27XZKoCwLR4s/MU1HgwkK3iv6iMvQgC8tjyyXyNT3DEWPqCUySdxP0xFEneTC6EmBeKo
 UF+dskeCYihPKJAYsZQTPNdXSr+fD2oMjD5225zmnw71igoL6hyI59m44CaiwnBn8LLeM2yBET9
 crWQVCqqV9PjzcTo5+ZnOQe09lNVSMlO0JG7oZXGCvLQOYsb6cZOWB/a5q/YoyuquinACmPrIv/
 eAO9QV2WtTDiLx8OVdg==
X-Proofpoint-GUID: OoOOMFlYe6jbEmodmVb05lcTjZUs3-yc
X-Proofpoint-ORIG-GUID: OoOOMFlYe6jbEmodmVb05lcTjZUs3-yc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX449owf/NgXoW
 liUtrQRswRIrllpFZgPQZXdUsCrg9Hy7uIfkN1GFFYEn7oaZnoc36OBN1Lkz3qYVvhG+J4gJ1l8
 ITomyYERt7kx1sRDcDXWlIz14ebvcn8=
X-Authority-Analysis: v=2.4 cv=OcWoyBTY c=1 sm=1 tr=0 ts=6a426f81 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=OF6xqQKflNrgTLtdKXcA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290109
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

UmVwbGFjZSBwY3ljbGUgc2V0IHN0dWJzIHdpdGggcmVhbCBpbXBsZW1lbnRhdGlvbnMgdGhhdApk
aXN0cmlidXRlIGN5Y2xlIGNvdW50IGNoYW5nZXMgYWNyb3NzIGFsbCBhY3RpdmUgdGhyZWFkcy4K
ClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpT
aWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0t
LQogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jIHwgNDMgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jIGIvdGFy
Z2V0L2hleGFnb24vY3B1X2hlbHBlci5jCmluZGV4IGJiOTkxYTY3MWU4Li42NGM1NzQ2YzZkOSAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhh
Z29uL2NwdV9oZWxwZXIuYwpAQCAtNTYsMTcgKzU2LDU0IEBAIHVpbnQzMl90IGhleGFnb25fZ2V0
X3N5c19wY3ljbGVfY291bnRfbG93KENQVUhleGFnb25TdGF0ZSAqZW52KQogCiB2b2lkIGhleGFn
b25fc2V0X3N5c19wY3ljbGVfY291bnRfaGlnaChDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMy
X3QgdmFsKQogewotICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgdWludDY0X3Qgb2xk
OworCisgICAgZ19hc3NlcnQoYnFsX2xvY2tlZCgpKTsKKyAgICBvbGQgPSBoZXhhZ29uX2dldF9z
eXNfcGN5Y2xlX2NvdW50KGVudik7CisgICAgb2xkID0gZGVwb3NpdDY0KG9sZCwgMzIsIDMyLCB2
YWwpOworICAgIGhleGFnb25fc2V0X3N5c19wY3ljbGVfY291bnQoZW52LCBvbGQpOwogfQogCiB2
b2lkIGhleGFnb25fc2V0X3N5c19wY3ljbGVfY291bnRfbG93KENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCB2YWwpCiB7Ci0gICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICB1aW50
NjRfdCBvbGQ7CisKKyAgICBnX2Fzc2VydChicWxfbG9ja2VkKCkpOworICAgIG9sZCA9IGhleGFn
b25fZ2V0X3N5c19wY3ljbGVfY291bnQoZW52KTsKKyAgICBvbGQgPSBkZXBvc2l0NjQob2xkLCAw
LCAzMiwgdmFsKTsKKyAgICBoZXhhZ29uX3NldF9zeXNfcGN5Y2xlX2NvdW50KGVudiwgb2xkKTsK
IH0KIAogdm9pZCBoZXhhZ29uX3NldF9zeXNfcGN5Y2xlX2NvdW50KENQVUhleGFnb25TdGF0ZSAq
ZW52LCB1aW50NjRfdCB2YWwpCiB7Ci0gICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICBD
UFVTdGF0ZSAqY3M7CisgICAgdWludDY0X3QgdG90YWw7CisgICAgaW50IG51bV90aHJlYWRzOwor
ICAgIGludDY0X3QgZGVsdGEsIHBlcl90aHJlYWQsIHJlbWFpbmRlcjsKKworICAgIGdfYXNzZXJ0
KGJxbF9sb2NrZWQoKSk7CisgICAgdG90YWwgPSBoZXhhZ29uX2dldF9zeXNfcGN5Y2xlX2NvdW50
KGVudik7CisKKyAgICAvKiBDb3VudCBhY3RpdmUgdGhyZWFkcyAqLworICAgIG51bV90aHJlYWRz
ID0gMDsKKyAgICBDUFVfRk9SRUFDSChjcykgeworICAgICAgICBudW1fdGhyZWFkcysrOworICAg
IH0KKyAgICBnX2Fzc2VydChudW1fdGhyZWFkcyA+IDApOworCisgICAgLyoKKyAgICAgKiBEaXN0
cmlidXRlIHRoZSBkZWx0YSBldmVubHkgYWNyb3NzIGFsbCB0aHJlYWRzLgorICAgICAqIEFueSBy
ZW1haW5kZXIgZ29lcyB0byB0aGUgY2FsbGluZyB0aHJlYWQuCisgICAgICovCisgICAgZGVsdGEg
PSAoaW50NjRfdCkodmFsIC0gdG90YWwpOworICAgIHBlcl90aHJlYWQgPSBkZWx0YSAvIG51bV90
aHJlYWRzOworICAgIHJlbWFpbmRlciA9IGRlbHRhIC0gcGVyX3RocmVhZCAqIG51bV90aHJlYWRz
OworCisgICAgQ1BVX0ZPUkVBQ0goY3MpIHsKKyAgICAgICAgQ1BVSGV4YWdvblN0YXRlICp0aHJl
YWRfZW52ID0gY3B1X2Vudihjcyk7CisgICAgICAgIHRocmVhZF9lbnYtPnRfY3ljbGVfY291bnQg
Kz0gcGVyX3RocmVhZDsKKyAgICB9CisgICAgZW52LT50X2N5Y2xlX2NvdW50ICs9IHJlbWFpbmRl
cjsKIH0KIAogc3RhdGljIHZvaWQgaGV4YWdvbl9yZXN1bWVfdGhyZWFkKENQVUhleGFnb25TdGF0
ZSAqZW52KQotLSAKMi4zNC4xCgo=

