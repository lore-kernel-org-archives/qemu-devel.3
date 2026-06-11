Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADBCCD8CB2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY2S-0000ST-Hj; Thu, 11 Jun 2026 01:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2O-00009g-Cc
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2M-0002SG-4W
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:08 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GPwT3817100
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1jpKCgBwtqkrdB9t81UhgSZ/GfmKuIq6Q/Jl5ya/59o=; b=pEBXVfaqI0Hg1cH8
 DyiPm4+RN8wb8G/8cZGnSWYmIJSAsaU9c1ayFRlJkhPK99VxOT4jTHtgMiPchj3O
 TJoFmdNirFpfV+EmpfU4vvSQJlFwm0tHOhQZbKCcFohJlFdfnts6VaAlDzbUMXK9
 HBVi9utm8oWRGn+VNM57+kdmFuK2e+kF9axlCNifmeJn3JoJIiQZxzQf70oFEv9N
 /zle0z0BghqpxAKVu1ta/vSB0+gy4RBo7nohoqhtw/CSI6cuvmwYmgT/dOjjUpdG
 TDkEUSOYv+HX2GIhO/g5Aw6/tHNSf0P2moNZbsHUp4dKQUNP5GyVMqQPHpnEXGih
 1bcapg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6uss5j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:04 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304ea42b025so339563eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155984; x=1781760784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1jpKCgBwtqkrdB9t81UhgSZ/GfmKuIq6Q/Jl5ya/59o=;
 b=NJzguJpP+Rigl4I2HJpv+piCUkL2D/jTr8RZ64S32msL8xAIn91G24Zpx/NLJam3yL
 8IASBRv754g/FtN42yrgoL8PkMG9bNgrevF63wLEhVMWwiNEM3frpNti91OCfomUNLeS
 G3TNl+YNDp7yqJ1SzKn5Cnd1R/KxxNNPRwWDIbX3TS9bAHqlCmblLRlGvDIIFIU6D5EA
 2ClIp7s8oATn8+QboFEWIfck3ZL/rUgepgNrQugPmgDiNTUzqMM3c4hjGDimWlTJBNw2
 CdgpP1N31SuocBzS9lZp7TmCDEtTtrpEfgO0cEtg9gj1YWlz0sH3ltw8ypfFhntUBSqy
 RlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155984; x=1781760784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1jpKCgBwtqkrdB9t81UhgSZ/GfmKuIq6Q/Jl5ya/59o=;
 b=C6YNrCHRq7vKps6kM3o4akdCmDrpfn6PPloX8Au+ghErdIDgsV+Mg9Q3pVuPxaU5si
 Qkk86e11UkrBwvihu7OU/zbkv1iasCR6fAFG1l+TjpyZziuhWTJsyUXtsaSsWkNYi4CS
 hlMuZk2e5AfP3O5To3Q8Id9nqUo/VcRRDIXgPHeR2IwhxoOpH2KaRsn6goLUoUXVTQWj
 26/1w3MbG95QiBDCvwBhbhETerWUmz8LcyO1LwdL1cKpFV0WezZxAz7kouGPt+QeOedY
 uavRkzTV+e+ccGNK84DnUzIVayBbXmFclda4NYDr8C+riRusEOMye1SPnNYS/cnHxysr
 Tzbw==
X-Gm-Message-State: AOJu0YznIalbMs7KmsQZ3tUTudniwr+8igl4BiZeHHvTjLpWEIhkSusV
 /jD24EmI+HejioqJJtZ7Mhip/n1RUSGri+2wDDzVz5tUZTNE6bYfth4bnhx0JX4sU4sw3UNUlOO
 yzs3i231U1xDz8aos7Y0P1TjTGLpCmyqUYLrr/BMcK+b0Z5e8f41zDuTNR5pCkjDLNA==
X-Gm-Gg: Acq92OHAzPPxyHjAqjgXVZC6BSem0kW97B+OTsZ2Vsifmei6Pd2SMy94CMxJBmwPOOm
 5ydU39Ge7MrsSnYQGzofPHOZCKJ4o8nBIJjBItoIs4z8L3JW1wKerZoW48uv1+b7ixuSebYInQw
 pq8R/oMfbMvteFyxH3bPNT0vfxYM2tdUaPnJymdH9Cls8Rre7NgQGL57r5IL3UHkq7sD8dhG5db
 KDBoBsnM+pCLKineRvlQAEzNE+QwWFLo1tkvu9cUmdHah87fMgvcBff8x9PjkEV8TRInnP4VB8a
 c+rB9eYxbDYk4R3/g1ZvGOiyh4IUmiNlye68+mbxXiX294etnWcZSgzh/BYUcNwai7sLnudIWHP
 1vieMG7qCrFgEQ3OR4CdbXsEnsMPaHHV6S7AE5NoTjV6QBCM57qFB06YfAHNVf3+ZvjVHOgTHBw
 HeKANe
X-Received: by 2002:a05:7300:ccaf:b0:2df:7882:1cf3 with SMTP id
 5a478bee46e88-308059e9316mr584490eec.2.1781155983989; 
 Wed, 10 Jun 2026 22:33:03 -0700 (PDT)
X-Received: by 2002:a05:7300:ccaf:b0:2df:7882:1cf3 with SMTP id
 5a478bee46e88-308059e9316mr584469eec.2.1781155983478; 
 Wed, 10 Jun 2026 22:33:03 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806ee207asm720800eec.29.2026.06.10.22.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:33:02 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6] target/hexagon: Implement {g,s}etimask helpers
Date: Wed, 10 Jun 2026 22:32:25 -0700
Message-Id: <20260611053249.3918491-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
References: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=FJ8rAeos c=1 sm=1 tr=0 ts=6a2a4890 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=he7afFXPmx5H4pWyvLYA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfX1ogfNQ7ZDbuM
 ++xeMXhdlcdfvQEDqZICuD12pQsNSca2ZMnPXmhUp3HPj+li277yoHCiaKHP14/u/xV9tBYFQFC
 2b2UOlExhO9XtCkfc7YZbAVs2I9pNqI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfX5XliE77CwrLY
 BYjqXm1rVGHosppVmZY143V2OKpwkpRIUVdfUxvwcu0msWWB6zj+0d34jrYWUa5xJfS6JjIiXx4
 TvPViHVM6XWtPYIfo8BllXFMPFdc6uDLWC2x5MSLjmtAOrNqjKtTRvEPxwyhsz059rvLtV2iYXb
 03QAxQKY85M18FIRitWX/bj5Q4Sr0RSaBNqsD63C7s962KdmHvi0Tn68UY6jouA9ZguPpI+Td/c
 hHZF5x1DuA/9w4wBSb0FPr/xBePqyHd/ojRKIPdyJO48VzNbXd7uMkVKSgaaDXW7tXMViCUp/en
 YwDqogosQkuckcJedurRqQncrGJ+ZIeO0jUfrzUBBz0VnxBxL1KBZx0X/ZlLwYgD29/dYT51tdv
 ULr6XoZni8QeSiex9DDzglEY5npPoIxEBBSd3cBUOsICHBCmGqk2ugVouKe0U1vevw8lTWyCRai
 lKFV0VPXOoD+yoUp3XA==
X-Proofpoint-GUID: VLxyanlogT69D6z-imm2ukZwlrs5-RKr
X-Proofpoint-ORIG-GUID: VLxyanlogT69D6z-imm2ukZwlrs5-RKr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110052
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jIHwgMzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tCiAxIGZp
bGUgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5j
CmluZGV4IGJlNTQ2NjNmMjhhLi45NTdkZWEyZTc3YSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTE0OTgs
MTIgKzE0OTgsNDQgQEAgdm9pZCBIRUxQRVIocmVzdW1lKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgbWFzaykKIAogdWludDMyX3QgSEVMUEVSKGdldGltYXNrKShDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgdWludDMyX3QgdGlkKQogewotICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cisg
ICAgQ1BVU3RhdGUgKmNzOworICAgIEJRTF9MT0NLX0dVQVJEKCk7CisgICAgQ1BVX0ZPUkVBQ0go
Y3MpIHsKKyAgICAgICAgSGV4YWdvbkNQVSAqZm91bmRfY3B1ID0gSEVYQUdPTl9DUFUoY3MpOwor
ICAgICAgICBDUFVIZXhhZ29uU3RhdGUgKmZvdW5kX2VudiA9ICZmb3VuZF9jcHUtPmVudjsKKyAg
ICAgICAgaWYgKGZvdW5kX2Vudi0+dGhyZWFkSWQgPT0gdGlkKSB7CisgICAgICAgICAgICB1aW50
MzJfdCBpbWFzayA9IGZvdW5kX2Vudi0+dF9zcmVnW0hFWF9TUkVHX0lNQVNLXTsKKyAgICAgICAg
ICAgIHFlbXVfbG9nX21hc2soQ1BVX0xPR19JTlQsICIlczogdGlkICIgVEFSR0VUX0ZNVF9seAor
ICAgICAgICAgICAgICAgICAgICAgICAgICAiIGltYXNrID0gMHglIiBQUkl4MzIgIlxuIiwgX19m
dW5jX18sCisgICAgICAgICAgICAgICAgICAgICAgICAgIGVudi0+dGhyZWFkSWQsCisgICAgICAg
ICAgICAgICAgICAgICAgICAgICh1aW50MzJfdClHRVRfRklFTEQoSU1BU0tfTUFTSywgaW1hc2sp
KTsKKyAgICAgICAgICAgIHJldHVybiBHRVRfRklFTEQoSU1BU0tfTUFTSywgaW1hc2spOworICAg
ICAgICB9CisgICAgfQorICAgIHJldHVybiAwOwogfQogCiB2b2lkIEhFTFBFUihzZXRpbWFzayko
Q1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHRpZCwgdWludDMyX3QgaW1hc2spCiB7Ci0g
ICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICBDUFVTdGF0ZSAqY3M7CisKKyAgICBCUUxf
TE9DS19HVUFSRCgpOworICAgIENQVV9GT1JFQUNIKGNzKSB7CisgICAgICAgIEhleGFnb25DUFUg
KmZvdW5kX2NwdSA9IEhFWEFHT05fQ1BVKGNzKTsKKyAgICAgICAgQ1BVSGV4YWdvblN0YXRlICpm
b3VuZF9lbnYgPSAmZm91bmRfY3B1LT5lbnY7CisKKyAgICAgICAgaWYgKHRpZCA9PSBmb3VuZF9l
bnYtPnRocmVhZElkKSB7CisgICAgICAgICAgICBTRVRfU1lTVEVNX0ZJRUxEKGZvdW5kX2Vudiwg
SEVYX1NSRUdfSU1BU0ssIElNQVNLX01BU0ssIGltYXNrKTsKKyAgICAgICAgICAgIHFlbXVfbG9n
X21hc2soQ1BVX0xPR19JTlQsICIlczogdGlkICIgVEFSR0VUX0ZNVF9seAorICAgICAgICAgICAg
ICAgICAgICAgICAgICAiIGltYXNrIDB4JSIgUFJJeDMyICJcbiIsCisgICAgICAgICAgICAgICAg
ICAgICAgICAgIF9fZnVuY19fLCBmb3VuZF9lbnYtPnRocmVhZElkLCBpbWFzayk7CisgICAgICAg
ICAgICBoZXhfaW50ZXJydXB0X3VwZGF0ZShmb3VuZF9lbnYpOworICAgICAgICAgICAgcmV0dXJu
OworICAgICAgICB9CisgICAgfQorICAgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNUX0VSUk9SLAor
ICAgICAgICAgICAgICAgICAgInNldGltYXNrIHVzZWQgd2l0aCBhbiBpbnZhbGlkIHRpZCBuZWFy
IFBDOiAweCUiCisgICAgICAgICAgICAgICAgICBQUkl4MzIgIlxuIiwgZW52LT5uZXh0X1BDKTsK
IH0KIAogdm9pZCBIRUxQRVIoc3JlZ193cml0ZV9tYXNrZWQpKENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCByZWcsIHVpbnQzMl90IHZhbCkKLS0gCjIuMzQuMQoK

