Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D089DCDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcksu-0006cf-9u; Thu, 25 Jun 2026 10:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcksq-0006bH-VO
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:16:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcksp-0008Pf-B5
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:16:48 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9jxSL2010790
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=OES4OwpY68ze2Hmn3HRKPHOte4o1zK6n49UyqbIUhyE=; b=bX
 E5LJ7fGj+C1es7UiBxDlJBFjQSeh4DWPV+sMOfMELL0c3dzGiQsNRCHbz26tIGkV
 qgjl3kH02JekkDCKpoiIAYT0DGpkvJLi1AL4s24LvxXmUi3m9JbyR2Sb71OmXdp0
 4qsb2J4Vp5ur9mCP8N4WSAC++E16L5C51Xc9smIM7CQp/IUav3sxN+bXbsIjLWdx
 o8KnEa4pj1xXQLapKq+coGFJfPHtLxu3ogxyiRe4XwEEUOhXLtigRArBQrLDe1xI
 X/zMw9bhG0jqLC0CR0U2gIp43EYw3PQzNGAH+DgnGR724inkMT5Eke8zqknc3Lws
 +INUj0TyjWWFBgh0PjNw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0uhmjju6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:16:46 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c17f62afdso924613eec.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782397005; x=1783001805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OES4OwpY68ze2Hmn3HRKPHOte4o1zK6n49UyqbIUhyE=;
 b=SgAxJ8Q8KW1dBvvVbbBHIKGthdv5MXRs6vsNMoHt/EePYVe9lZSLlvEg5VagOfRrXc
 zgajAQyr+VXkpUCBdOT9TPmzo84TJfUHPdhPKSMR1Xy7DuUXAzkyuCgYTadNzYn1ewrq
 IkeMIEpB0GOynqKe4skgfFCd9kMHmTOPtBIUxMu2YnUklKPs3mRSqF1apqgurkYPNkP6
 Xh9xjmqbUr5PXHL5e3p8+MC79Ku1qvBVW71tHEdWguzfc04rWIncxUmq+XyUalUjB2Mf
 yvgWHMF2MC2FWnWBGSyVIVqu599vp1Hr6567vDd0TYOcCp/0C0aTkpRpOiRyaEaHBm8z
 a/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782397005; x=1783001805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OES4OwpY68ze2Hmn3HRKPHOte4o1zK6n49UyqbIUhyE=;
 b=GMUwrMIaO1ObCAeCWPW8/cDTx7rW9+L/Cd2cSM1ayWy3rF79Z3oMnSpE23oOXzNxD0
 9LbmgzeNjrM396/+bHt/kcslDSHr4vX0bbSp9taIPyitPoR9F2ZKZ0XJkD6Z5e7fvcP5
 wqeY+0TtMZBIjBqyva7K8Beyb7yI5cIyWhHc/d2exWrMrpGwf1pY1z82EVSnPw8GMmmE
 /mMIqSeK0z5EN+g6EFvOnoPUn+ApTEGjMOpApb6r2H++I5HJ8dcTWFE7H1AvdnBzZDaz
 S7nDvndJEiKaeMlCBvlEEOaM2Il/VTSwsJCDK6D+n5C4efDECNH/BqDDKqJ7CIxWiTLi
 HyCw==
X-Gm-Message-State: AOJu0YyILXvwId0Zq6LhsSxkxBuYN14O8C54sVbGFpNQa1JNs5j4W59r
 521cIEhCfEMcd6HSRQrE4c5Ak8VMUoJxBQuL+ZrBsZ3tnTKmX6eeo+HQfv+qzrgS/ibLXFQomAn
 A8rdrb9kHJQ0CSjoMmUT+dJm6NOZj+nvOiekvtzSfaERMKbRJ+f9hyMYRVeV0O5j5hQ==
X-Gm-Gg: AfdE7cmQrUmptBEiBQTvP7BcLyhv4HLzLp1GaNGa1ttdCQelQPJZjOabK6xv8ysX2eD
 YCNGqPCXnxMwqBvjU56PotKp08KOdKeGnRk0BBWHDzcpSuJVjLHV14iBt4E8Wz6Jx9G9LScU/BE
 cclHsFQ4f2kRBQsLTbZ9CmO6hP9BMJ4Zz5I4tQTZ+t8dxsftgp3aVMB1GgJSe1sC0b4nW3mnNRQ
 JbHJ33ihx/4K9+aCgfeROlGeENxRHlK/U4tqsghLhtKj/I32RwTlA4hVZwuF8Nf1uX9UnXhqbVv
 V0ztxG4pylBDRgULUXB26x5e0M/MGvv3390vNZEXiYj31GiJL5MCIio5XkO/nqYm4PO7e3onTVr
 FSq2TLuRkdnSC+DgAvXa68Mz4ydLcIcmex4OdwDXWsW05G8uvIKmth/cniUI=
X-Received: by 2002:a05:693c:62c4:b0:30c:650c:2161 with SMTP id
 5a478bee46e88-30c650c359bmr5369547eec.13.1782397005246; 
 Thu, 25 Jun 2026 07:16:45 -0700 (PDT)
X-Received: by 2002:a05:693c:62c4:b0:30c:650c:2161 with SMTP id
 5a478bee46e88-30c650c359bmr5369523eec.13.1782397004534; 
 Thu, 25 Jun 2026 07:16:44 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ae5sm10168446eec.16.2026.06.25.07.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:16:42 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>
Subject: [PULL v3 03/76] target/hexagon/idef-parser: open input file in binary
 mode
Date: Thu, 25 Jun 2026 07:15:20 -0700
Message-Id: <20260625141633.449487-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=cqerVV4i c=1 sm=1 tr=0 ts=6a3d384e cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=XwlTJ2-QRR3pk5tWCfYA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfXxztKhuazCnyP
 Hrm46ULOweZTkkokNZz5yu6dS8sg/1HcuozPp6Yuh8USZXgCJhfv9WNKltiDFqNLdVcFpTcC73p
 VJl7uSQYuSiCl2G5meIBmUEyhhusI8fboz20yS2B9JxUSQFMq4Cw8hWOH5bME8QIvojj5k1MCEi
 ZNQYJ3/7ddxuXIq7TiR8U8MWFBBbMKBq1ZTSJOCDq6/iScWq8dHqhoj1x7X45OQj6Kw5x+I9QaQ
 bUlIXYHYtzslxE2F6e5t4/NEAK8lzZHCf3jndrzSdfWOhEoeDyBXZzdnZ4sk0lxsLn3oP7t+fTj
 fCnZ6lPGOCEoDkUrxo7I3/WGHRwIo148IIaBRWQBFu1XrA5UXc4MwqYl8S1h7aNuGGjmZVQdSNU
 olHIbJGfggjtezfv0+K9s+NKGrZFsjuL8Q6x/Uk9A2bOYzpOY9eLxaX3uMNlz58zffIhHtBwY31
 W18uyCLHYPy6Unev7Tg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX+U4rfJb6GyR8
 BIYVgi0++gQDdICq1siqhu7H6ixSdeKCKnG3VNMY9T7f1+jwrTaGnJLCXndMW9Bj4w0AJayddtD
 NjGqmQciQnIRzkuWXX2eN+O4Alv8NOk=
X-Proofpoint-GUID: RWWg1_Ckc0D3_cZ9RZR7Lfh0Mh_tYliM
X-Proofpoint-ORIG-GUID: RWWg1_Ckc0D3_cZ9RZR7Lfh0Mh_tYliM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250122
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

T24gV2luZG93cywgb3BlbmluZyBhIGZpbGUgaW4gdGV4dCBtb2RlIGNhdXNlcyBmcmVhZCgpIHRv
IHJldHVybiBmZXdlcgpieXRlcyB0aGFuIGZ0ZWxsKCkgcmVwb3J0ZWQsIGJlY2F1c2UgQ1JMRiBz
ZXF1ZW5jZXMgYXJlIHRyYW5zbGF0ZWQgdG8KTEYgb24gcmVhZC4gIFRoaXMgY2F1c2VzIGlkZWYt
cGFyc2VyIHRvIHJlcG9ydCBhbiBlcnJvciBhbmQgYWJvcnQuCgpPcGVuIHRoZSBpbnB1dCBmaWxl
IGluIGJpbmFyeSBtb2RlICgicmIiKSBzbyB0aGF0IGZ0ZWxsKCkgYW5kIGZyZWFkKCkKYWdyZWUg
b24gdGhlIGZpbGUgc2l6ZSBhY3Jvc3MgYWxsIHBsYXRmb3Jtcy4KClJldmlld2VkLWJ5OiBQaWVy
cmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClJldmlld2Vk
LWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQG9zcy5xdWFsY29tbS5jb20+ClNp
Z25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0t
CiB0YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9pZGVmLXBhcnNlci55IHwgMiArLQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vaWRlZi1wYXJzZXIvaWRlZi1wYXJzZXIueSBiL3RhcmdldC9oZXhhZ29uL2lk
ZWYtcGFyc2VyL2lkZWYtcGFyc2VyLnkKaW5kZXggYzZmMTdjNmFmYTcuLmNhYmEwZDI2NDRkIDEw
MDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9pZGVmLXBhcnNlci55CisrKyBi
L3RhcmdldC9oZXhhZ29uL2lkZWYtcGFyc2VyL2lkZWYtcGFyc2VyLnkKQEAgLTg2OSw3ICs4Njks
NyBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiAgICAgY29udGV4dC5oZWFkZXJf
c3RyID0gZ19zdHJpbmdfbmV3KE5VTEwpOwogICAgIGNvbnRleHQudGVybmFyeSA9IGdfYXJyYXlf
bmV3KEZBTFNFLCBUUlVFLCBzaXplb2YoVGVybmFyeSkpOwogICAgIC8qIFJlYWQgaW5wdXQgZmls
ZSAqLwotICAgIEZJTEUgKmlucHV0X2ZpbGUgPSBmb3Blbihhcmd2W0FSR19JTkRFWF9JREVGU10s
ICJyIik7CisgICAgRklMRSAqaW5wdXRfZmlsZSA9IGZvcGVuKGFyZ3ZbQVJHX0lOREVYX0lERUZT
XSwgInJiIik7CiAgICAgZnNlZWsoaW5wdXRfZmlsZSwgMEwsIFNFRUtfRU5EKTsKICAgICBsb25n
IGlucHV0X3NpemUgPSBmdGVsbChpbnB1dF9maWxlKTsKICAgICBjb250ZXh0LmlucHV0X2J1ZmZl
ciA9IChjaGFyICopIGNhbGxvYyhpbnB1dF9zaXplICsgMSwgc2l6ZW9mKGNoYXIpKTsKLS0gCjIu
MzQuMQoK

