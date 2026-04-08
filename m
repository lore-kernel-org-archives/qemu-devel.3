Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E6610F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXsQ-0007tn-6G; Wed, 08 Apr 2026 14:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAXsP-0007mf-4P
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:43:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAKP2-0005ax-S7
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:20:36 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637Nfg8P1259479
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 04:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eOj4zoAq1FrIUJpyqyEImJhndv6ygl766X1sAeHwMk8=; b=TZqWonORM12CQ75V
 IXJJUUTZV1lLy2sUYr0BLI8cCUmPiewHGGNN/Z2evNx/M9R3pMdiZNN1XzsiQjMm
 ZIZ1jawXMWbRolstxbgjqD8PpMSFKJnIsg5MgeeVG6+Ujks4BVpssAcSckFbM+8I
 j9hZ+Jrts98DqJRYBJLiAAm1o33+e76FApKlWBV9IPQAYQDrUH6isGgFaJx4IwEr
 6ugtI7RVnHMfko3hHWHAEZNVslE/tRvUagkTDFLYBQte0ooUUCAp0y3jcEkMF56p
 siWLFXo62UX5HHCW27YhKx9LMp2gWZkrXHkGTR4GHnH+oVXtM4U3MmEoNinReC6J
 PGxowQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddbttrqq1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:20:23 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2b81ff82e3cso352043eec.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 21:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775622023; x=1776226823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eOj4zoAq1FrIUJpyqyEImJhndv6ygl766X1sAeHwMk8=;
 b=kH3yFDLd0mPFAbF/sV/UEZ8Ee7ZAc8nqTsfBbf3lq7NX1B+eq8y7awvWY86u3YdBda
 HHpO9gqTwX8f37+ZfBjBhyLMMCfK9mfig1ZsqJIG4MTG4f40AROO87pp6dBUvuqoHQ9U
 dhYa7AHMBx55qpWnXN73vU9bGxkducC3MAf2BocwD6KZ/1ecHrvCk1ZBj6ixqTQ99IuX
 8v/rLC6sqASFUU0qSydHNPPU/Wr30VQvSeI0OIUdlZZyLrs9VkrBtOs9cYbCWQGZdawf
 AXNi2j1FmEekbQ6OIYU0SSgPkO5wX4joOIypyuXQJHDZmelPDqXKKWn2RMmRpDT2RaEc
 tUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775622023; x=1776226823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eOj4zoAq1FrIUJpyqyEImJhndv6ygl766X1sAeHwMk8=;
 b=JqN4f8qIpFv9Fl6T15WP422X7j5biqo/qw2CkB2yNZ2pMu/71otpTnzCPGTzERP8QV
 ZMEXv8UqzLgG4tvnSnBtnUu7X2fyrkTt8tqdMw77xt6soworUs3FT36mkcKe2fqmol9U
 dEOZUH1FdfSmVYCzd3vIhDkfJIvcFbRT89bl19UuVAckM9wTRgSs/GjGmfBqCswzkMm/
 Hy2O6gmcd40kZigcak/KoxJJ4cs3rM9m+ttUFARYqMT75/HStkCCMUclrix/B8I/5PtL
 46tN8kSF8igT+OE+hyUEZFh6fyYSH1PAUmJqzRgWdJufWiyI1Ham/cjpGBieV77v8oNx
 gO9A==
X-Gm-Message-State: AOJu0Yw8ChGJwx2zJMRaL5XuSGRopNlOl4DA5QyQLhw1vQLGtcQpmbnF
 DOp7nvUjc0zS/BDEEDCXhKUwh/T8+EF/jTlekI3t8xTaflmOz2bFBObjDHKH/QxvzSDGBWJ2CrO
 foDbme3uss+WRk/7OBEDntVUIXtQWcwdiSFoLcCiVRIfVYXot126ynqJjUBGYg+LJCQ==
X-Gm-Gg: AeBDiesavwZ9Xg5v/ZjHG9LGkJGn/QfEWex3EGOtffTQdj1RccrWNAzItOKoTjmExgf
 ke7KH7P9q5+JK3lkjMf6g8JzKlsH2BMxJ33HaEMXm3so9XfGnUH/GL9EPX+Em1nISLytZsJxsKk
 BCMs/YJjLU7gEnZHGoTlOclAGkXOXSyDakwhtm2hMB5M56liqRNDdeakKTWoCTpD3GEPqIB+5Zi
 5SVmT+Y6LNmFpBf7cCHMAfSAg008oGwXsek5wCu3s2evEjbYq/UURi2GQnmkFu4nqfiz5kUb9WV
 guQve+RnIe/dvx8a1cVmTxnxJfZQciCYTbcDxRod0qpp21gIrpk2JjIZ9LGbSbtAP9xsUXelshS
 MFrroFvLsQlL/Gfgdk+5OZHr9Waxq/uBI8JcsCK3rleYfzTqujb6JzTNb+8QKcOLS9eiiHA==
X-Received: by 2002:a05:7022:1a86:b0:12b:ebf6:a3bc with SMTP id
 a92af1059eb24-12bfac012a0mr8102366c88.3.1775622022722; 
 Tue, 07 Apr 2026 21:20:22 -0700 (PDT)
X-Received: by 2002:a05:7022:1a86:b0:12b:ebf6:a3bc with SMTP id
 a92af1059eb24-12bfac012a0mr8102360c88.3.1775622022213; 
 Tue, 07 Apr 2026 21:20:22 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c14a371b1sm6480362c88.13.2026.04.07.21.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 21:20:21 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 14/28] target/hexagon: Implement hexagon_resume_threads()
Date: Tue,  7 Apr 2026 21:19:39 -0700
Message-Id: <20260408041953.1899532-15-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
References: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: _87cY6I4Br3KLLJM9rKAsEHj0wwtxZUl
X-Proofpoint-GUID: _87cY6I4Br3KLLJM9rKAsEHj0wwtxZUl
X-Authority-Analysis: v=2.4 cv=TOt1jVla c=1 sm=1 tr=0 ts=69d5d788 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=uy5dMy9T3THg1DqjAFIA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNSBTYWx0ZWRfX+xnTz1oB/vBZ
 rrVHjPdvyr4oRUNB69s8hPKh6srqHI6UveBXAq4CgIuTepD5XJWvspqa77uv8J6fm6eKJqZ1Ups
 jEidcOGczFv3lD7XCAFq/k47uT69FuShiv9OlJku4jUxAgbgW3k6HrH44wM/oDHAs0J0OfUVGJ5
 0+rCNiguFKMH+fy+8xQlMWjvAk5mKlbX3XReNlqfXgO1+gWMMzv2qothz2s8Pd9fsZDhmgAqMMV
 w9woziZDceOi5jjTgVHj+mX4RtUfx3QGnhtvtwkCEmw540Cyvc/DPFG4RWWVaBknxrYnnXHcWHc
 4BHGwSgmbjK04OPnK0fZVh0PIOQoESYxvouufiJfabbllyWtfC5xyJBHKLQirh1fX7uVgRLbgVs
 Yc2CvDzSgT1BI0/YmFhEtJsWco/1qAXzfzpr07l2NiTEVmCFMQCdlH2T7Ogk5WjydH+b7mJqB8m
 jdU2FF73WN/Y3dT4y2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080035
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
dS5oICAgICAgIHwgMSArCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyB8IDMgKystCiAyIGZp
bGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKaW5kZXggMjkzODI5
MWZmMWQuLjEwNDhlNzY3ZTZkIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysg
Yi90YXJnZXQvaGV4YWdvbi9jcHUuaApAQCAtNTMsNiArNTMsNyBAQCB0eXBlZGVmIHN0cnVjdCBI
ZXhhZ29uR2xvYmFsUmVnU3RhdGUgSGV4YWdvbkdsb2JhbFJlZ1N0YXRlOwogI2RlZmluZSBQUkVE
X1dSSVRFU19NQVggNSAgICAgICAgICAgICAgICAgICAvKiA0IGluc25zICsgZW5kbG9vcCAqLwog
I2RlZmluZSBWU1RPUkVTX01BWCAyCiAjZGVmaW5lIE1BWF9UTEJfRU5UUklFUyAxMDI0CisjZGVm
aW5lIFRIUkVBRFNfTUFYIDgKIAogI2RlZmluZSBDUFVfUkVTT0xWSU5HX1RZUEUgVFlQRV9IRVhB
R09OX0NQVQogI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4
YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IGUzNmVi
MmRmODZkLi42NGYxZmIyMDQzZiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVy
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTE2MDAsNyArMTYwMCw4IEBA
IHZvaWQgSEVMUEVSKHdhaXQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBQQykKIAog
dm9pZCBIRUxQRVIocmVzdW1lKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykK
IHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIEJRTF9MT0NLX0dVQVJEKCk7Cisg
ICAgaGV4YWdvbl9yZXN1bWVfdGhyZWFkcyhlbnYsIG1hc2spOwogfQogCiB1aW50MzJfdCBIRUxQ
RVIoZ2V0aW1hc2spKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCB0aWQpCi0tIAoyLjM0
LjEKCg==

