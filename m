Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAD3C43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBn7-0004Ix-3q; Mon, 29 Jun 2026 09:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBn4-0004Hz-G0
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:12:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBn3-00039A-4s
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:12:46 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT4oJ2627854
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:12:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=OES4OwpY68ze2Hmn3HRKPHOte4o1zK6n49UyqbIUhyE=; b=KI
 oYIayPXHgYy8q1Iiezb73dn6kEKQOjVnYQzKHPcnDegaLYfOrzhWY2EnRFYpAvMZ
 EPJCoDyhvycjFeM10eFDJyvNra2EIoDacmaHB9rEyuNgSeJ+qEIW4oYa8VvsQ5h9
 aEGZBGjsYBeK8ArETooijN77dY01SGAkD06jZKW6YE5BPHWdozyV1TyizLbT1H2f
 raiIRbUBlpOMfWfFEIaIwrjFOHPI9eIAHOO2UnkjCkia/J/AjdoiBE7mbBPRNTUR
 LrU5n/n2QG88W821JpIN5CdhVJurDR+6KGsXm3uLdMvDJm16YqUo9h9o0H8StODE
 cO1nBvpPT9dbtt/mByOg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nbgs16y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:12:43 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-137f3465368so3922418c88.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782738763; x=1783343563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OES4OwpY68ze2Hmn3HRKPHOte4o1zK6n49UyqbIUhyE=;
 b=cARpCr7bT+TRK0lSepLcZtW4KFHXYIum9AK9X6P/o7ttDVwEhUp5uIXVp9yUb2FTIg
 1gqDEFXnhnF1ZWtJ0N3tB8D/yB9hZxNYqHfMoTII+Xt9WVzNOMrJXkzxTj5Y/c5ktlwa
 rly69J3NCbQuC2Zs5735R9rfU8lJ928lDpY39dosPG62ZOvrzsNKvWoRUNJ07f32qWTu
 TPq9qfs79ikluOAyCrwa1YmELuhqb7/tZBGhLA4nqe4+uXoIDlw1ZmEPdhRG1u8rdns9
 QHikJv/hRq+w/eX8RpNEMTEBd7JKUmptr6VcYWHkEe/CwleaTUONRpH31XJLm9eN0PZv
 g7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782738763; x=1783343563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OES4OwpY68ze2Hmn3HRKPHOte4o1zK6n49UyqbIUhyE=;
 b=qJ1MKK16F66f77rBq9KK4ITGp4iQYopwj6oushBkSDITCfA9xRTIyh7YyUr6+mUaeG
 LjwYdzIZWPQOUucwDYW5KOL+b9j4b2r6txUS/TlCBVFw5Fhl6DLFXPnRVV9gCicX6+X6
 Z6Dxnsc28eMv7x+TqRmRiwjuMbypKvkpCQlj4yFGNvGJjlmpnFbI44UnehNXSeGDKne/
 CoCQmVkT2oHtloUkICxZPICLkg/UFpcHu9+YstO2QmdsJXUUe1s6so56jnfbiqXLpvVv
 sRnOewaB0mXaw706FFm+XTBXFvZioo0fOZYs3FnjmtAGaBme4QV55nrvr4gzBNY0R8sv
 jPug==
X-Gm-Message-State: AOJu0YzDltEupGar0aBfk9NuY7vrK4nuBSY7BoE5U8N4SQgIrmTOKwVq
 uDb4cNgoXkl+8kdLE8zD7mg0eD2g3SILV2N6jnM2Sc0a3o2KI7VkgUk3TDpLzozvd2of+V0+lts
 8PgJ+QpMR0rYpTsJ5h2Zy/LwfrI5unUUcWRFF/KIX2XiqD7qAhgz56SYw3OekuT2Niw==
X-Gm-Gg: AfdE7cnxDjeWUOqxLS+k8ibDfOBEGBFZONTxSEkfGCE6mErSCzf8U/3Rqb2RReUpP0s
 9jKs6DpI/Jr8hLmwZaFrjWEeHxLqxiT8+w0VYOCAoKVrr/amFoocYOJ8R9dxTRwKmH6gt0rGiAk
 hVTlTbRmH66qQj6qmF0NmnNm7yioO2+cZ+l71OPuNuWJ7sdkUgOTO5n+qhwICXVFfz/a8qpRiES
 k2vrZF8CuiXVJDsEYbVxkKl3MWvbpyYJLvXF2jiAWFRYkSi+lcrGPolyXX6fnxof7vLAsPhujSh
 Sg29EX0WEzmgbvJNrQtvJH2FloABzV/dIBGacE+jfAo0UTEl25sAWu8KGzO1zQcg9esCXTm8wNK
 dKHzQVp+CsZgoC2JS/PbzVqXPhmDr1fXnGL8vwCtH57YL27ykjXfGL7EcqPM=
X-Received: by 2002:a05:7022:788:b0:134:df7f:a5cf with SMTP id
 a92af1059eb24-139dbbaf082mr12364916c88.29.1782738762959; 
 Mon, 29 Jun 2026 06:12:42 -0700 (PDT)
X-Received: by 2002:a05:7022:788:b0:134:df7f:a5cf with SMTP id
 a92af1059eb24-139dbbaf082mr12364892c88.29.1782738762427; 
 Mon, 29 Jun 2026 06:12:42 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139e78317f3sm28459106c88.9.2026.06.29.06.12.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:12:41 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>
Subject: [PULL v5 04/77] target/hexagon/idef-parser: open input file in binary
 mode
Date: Mon, 29 Jun 2026 06:11:19 -0700
Message-Id: <20260629131232.2487780-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: ar28R-0nHOGbQgWHe8zA9o2ck-Q-5gxz
X-Authority-Analysis: v=2.4 cv=Z4Hc2nRA c=1 sm=1 tr=0 ts=6a426f4c cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=XwlTJ2-QRR3pk5tWCfYA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX1wEH6JlYAQST
 dL7K7zRBug8F76vp38Vvk4QwD0g5vuj2goR/jlDRlmTKESVudXdqxjP0Hju7wM4TrVmm0CMQo6n
 kx9HZUWAQS18rFlXeLJJnmruXOgRsWI=
X-Proofpoint-GUID: ar28R-0nHOGbQgWHe8zA9o2ck-Q-5gxz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX2XaNBCSv9kCQ
 ZL3UOJULzckAiLskyGmud/WyvTFFyqpCmsG7uMTsqKWtkjFEKzvpS2T8t8mhKGaoEhnuGMJbgaY
 9REoRUXQnFwRKBt0D7DSS3IOcmeJQ+TUqPzp8afGa+FItmcHCD5OjOA/wz7rw+sSpb+cMJ3VUuZ
 gXTYIRMxZNdwLg5Q2+VYIb5H1ohryJRzDjwIV0htAIPQGTJqmSlxltvctjR6tHNMx8Luq5wi5ns
 ERwo8JBXwRT3eyBzN6N70EDmiA1nRRK+okwPNBHPoHijI4/VvrHBZfwm64fAmz/75q6Hn5o7ObV
 tF/hPugKcir8+7L0e8RW9ihyVM22CLOij1txNOltAprOO4XlXoLRmlSaLjOuLtfJtAH+VPzzGrz
 YUB2ZCQHV4IhWBWUrjc+Dwlw3u6QfvKC7YoZmjdW1oq/OuyQ8srwRYBU9Khj2aa0YlYksbpWFdY
 t4vqUJuqSNQKEP6BxSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290109
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

