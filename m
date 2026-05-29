Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E15CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5Dh-0003sI-IR; Fri, 29 May 2026 17:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Dg-0003k6-16
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5De-0000qz-9M
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:19 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TIf813118239
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vprTvSEgzIgWASZmcb1NhYWButaf8Vz6pBv1wMZS9Rk=; b=H+B2xqPx67zm/Blt
 MWYPkY/fLAAQJM6PZv8+OKrGbQEA91ozvin7WnGs3Qs04DrwQ+iBoefArLbZT7q7
 k+1GSJz3gIzoFtkFtTjZze0CzsK/Sx+guV87cKxDJDXTyo96RzaNpYJzQ8hjTO2+
 O+go07s1jjOyjfIYFmLDej1W0ZICK6qnCgnmSFhub6JiQ8qVFaePguMaKYFM7qDC
 RjVxfRJZLFt9uo6m0PwM+oyAqxoEVGFdc7jNUgvLzDDZq1qW8ckd9IH/GEl+wuDI
 a8zUVHm54b/0Vdt/bAqPO1b1w9mFnzPpRQNGZMNQWXMKfmzPO16loDHIosg7UvRD
 lXLm3Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efg9vrqha-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:17 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304dd917645so2001343eec.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091896; x=1780696696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vprTvSEgzIgWASZmcb1NhYWButaf8Vz6pBv1wMZS9Rk=;
 b=i6ZT2/4H9udUzSyUYGgg+CFceMt6War+yYupqyv/E9fl7TbBpuGnQHxHLKruTB2y6J
 FMDwV2qdvsdnn9d0Z6TX5oaCatxxNBzyH1OmaP1rJggANADB+EYF66pBs9w/ReGOkzC3
 xtInrx+6tu+HQpszqp7ScXMSl4xlusUEFEVIsoDRR/w3rTOLrKwMQ8kQx7YUvS/aQhIC
 QnqrZKZOftweL6cqCe1ieHpel/Mk99KJu41K7ghL4yv1bCqXv3+hbVw1UD/9Yr5Bv5qt
 v025P9ElSf+xaWYEr+8TbBquOuH1N3hOD77VMWk0qIlYnEVMvFkGhFEgoa1jMhRxSIIV
 LSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091896; x=1780696696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vprTvSEgzIgWASZmcb1NhYWButaf8Vz6pBv1wMZS9Rk=;
 b=PKhd9qC9R/gpp5NBOxHa2FyYun8RDubi3/l+3MBOF60gurKGNMyQdwulmMk6Pn3Faq
 VpAA46VcG/VWlNheDEY1OARXbRHjRrihg4W+8S3IeTn4NPMUNt9cL9fVx6PrwvmINhaD
 QNuzxQQJGSVpjnXvUlkrSyvhZFSzCh8EUnplnCzWYj2Fd5sXPpTF2TFS2pigzhrf8uGq
 tuXVx2iUw2Ph6M2z7EGe0AuU/kNTjqnWp+x2t71mQeZ9xPRhDq08HwpwUnguMQJT/EoZ
 9ty3ck4krKxR2hqbrtGOxxTfxZYufZbXDrwhz45WxH7WEXB7R+AFRkckBerxnjYCRJwB
 fIxA==
X-Gm-Message-State: AOJu0YwXETI9kwzyQq+8rr9xCg03vioHYJ2tSe/euSzeck2IEWgTRksV
 ncTkD/HVr0TO6eq/0lZf2ufH+ug52qqVsthreTYIKdO2CTC6i+oP0PhKO7nRWAVntxeVGNmIYom
 WzgVLOOto41SPhF6gElvdkIdZqTg211JLWslBhTd5+HN1lydHQeQ61E6fJaqhmxediA==
X-Gm-Gg: Acq92OFJAws4pI1eZ1Xm7Z7ewlizXRcGu1uxN3oHlb/TQqlXxKaOjvtdwDFdqlZclr5
 1zm/DaE7R3CD1mgXYFvwOtrLpIgeaqSPpOGayiycBi/CucUkIjBoMk6FwYXuiEg5Brz6WTWPpJS
 vc+3pfz20rGaQJpJM93q6ZRb54TfECy7p8hKmtINmI1NzL9t2TjgzOsgV+/UqGj8Wd9mxWNzL8Y
 cL1JXpLGCloFdjpyNdo9rL2F2oiaIbtPFSccjuKpn2RujYBRPhkl0vg5HzQMBJoiUavkdj5jKhQ
 li12HKrD6btgAzlGrKSDIBA+bjRqLxXvIE37PKUOtPLE+LzcQGjFLPeaJPEori55AdDQogoRmH+
 7zHm70yYH7dOpezJiT+4Sj0j4Qu95TgA7z6k57bBIX8kTHuGtdZoYqTNtvpeg96Z3ILxgqPUcOX
 E+8Z8h
X-Received: by 2002:a05:7300:e58b:b0:2ea:edc0:4fbe with SMTP id
 5a478bee46e88-304fa5230d9mr932588eec.14.1780091896264; 
 Fri, 29 May 2026 14:58:16 -0700 (PDT)
X-Received: by 2002:a05:7300:e58b:b0:2ea:edc0:4fbe with SMTP id
 5a478bee46e88-304fa5230d9mr932572eec.14.1780091895802; 
 Fri, 29 May 2026 14:58:15 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5a9d27sm2428313eec.25.2026.05.29.14.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:58:13 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 04/28] target/hexagon: Implement {g,s}etimask helpers
Date: Fri, 29 May 2026 14:57:42 -0700
Message-Id: <20260529215806.608770-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
References: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX9wUk8KcAj48r
 yr5uQGzoXSJ5Jz9ZjFBXNdMNPPfNcuaN8XWvRwPji6irmKORA4kiSpjSQ3rE5cboljdKLZ8obGP
 y2nN8pYi4OCyxiKrRDIOAuc9xlbJ1/F1es2Ujby6zmlPtQA51esp6QHL18e9JKRTa20XcQsEyH3
 jsqfoWCKWDDvtj1HiR+MyPjIvFmTAod4IIGE9d4MzBXicrMZnzKnO/Ij8XOv69jUQ4XbyBllHEL
 BvPK9PPu0r4ZtXS6SOyMhHDYT/WyFDnVMPUjl8SHrKqOGkK56uwpkAjFSZIbNxUlG3M1BjJMNwq
 ML/FqB5Ji0xj0xxfC60PeXcNMmeoaBrOBvipiCDzNauMIGWf+qaJeH2zeWxfc73hv01VXtzLmk5
 cKVyFqtUBY5u4J+12lUI62yOCOBj/fZPllLroOVf2v+RklvSlJxkvlvBVY6GB9kAlKrztdOcQmX
 rqW0V2Jxn0MT9p+Vgxw==
X-Proofpoint-GUID: oifpgk5Zp9059McgQcqtPmozqngRSZ1u
X-Proofpoint-ORIG-GUID: oifpgk5Zp9059McgQcqtPmozqngRSZ1u
X-Authority-Analysis: v=2.4 cv=MJpQXsZl c=1 sm=1 tr=0 ts=6a1a0bf9 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=he7afFXPmx5H4pWyvLYA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290219
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jIHwgMzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tCiAxIGZp
bGUgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5j
CmluZGV4IGEyOGVkMDYxNDEyLi4yMzVjNzBmNzM3MCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
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

