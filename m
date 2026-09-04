Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C8FC624D6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 01:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Idk-0007B0-J2; Thu, 03 Sep 2026 21:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2Idi-0007AJ-IT
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 21:22:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2Idg-0005Jl-SM
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 21:22:46 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6840E4iO1472720
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 01:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VRaZktLH6FSYAnvGOw4//fv/Pl+ly6gy7uH+narcn0w=; b=UCucK8UKs3xaoQCV
 Qx4/cFagi52ienloyyzj2HOmhbUUYt7GGUWwG6G6KMoNo4jJz7i1sCzCz4sym3l2
 eObyGNiTnttaKB0Y4yrPR+ijcF6zHD6XaMG+27AlLGwoiQ5SeEUk2lzJW1By90X8
 IHNO7xV5Y4kil4MRaO1ksaYOcexx5O/JvW511QT9U21+XOT3rQb2IJ1A5cs/LCDO
 5k6ANkFLeMVNJXbbMWbLunLfi35NbM1F+14Xn+K7AzOwXF7vlVn3QzLCKdv8MZxg
 QdTut/7H0qjB6Rb3S6MwdLNnrGqT5bBNH2J1DOA0aPjEp4hkWdnJI8sxULcHrYqt
 uLn5gw==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfk9204wv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 01:22:43 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-6b34d7f21d0so418517eaf.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 18:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788484962; x=1789089762; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VRaZktLH6FSYAnvGOw4//fv/Pl+ly6gy7uH+narcn0w=;
 b=Nu4U0dGCZmxSZnD7013vJL5FuGXVc6iGWCSmlP7EAXAiNrNgy3xKL6c9s3ipjiDfE0
 mMXmgiddYobOLwnrUmObGBj0+6amQC64jUCkHSrGcyPK+JyczarSy0g0HhpHv8pQNVnu
 gehX1d6qtGW9ZOlnQ0pGVJgXCOvx3OvmGNtsBz3zf+lZWzsR5191PeNE4LEAf5GEZW1S
 USE2MoGPxV8yzVKA4bPkqjw19IesBZ2lAJHgQq1U1qmucc3YIFr7IbkGJqVpLdG9Am08
 ChSvQ4isPktbdGvnvM4GvY2fKe7lWoasJ0fax+pZw6Ok1Ddto62RL2KBmVe35dHvOc6h
 0Cyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788484962; x=1789089762;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VRaZktLH6FSYAnvGOw4//fv/Pl+ly6gy7uH+narcn0w=;
 b=OeMdGNu2qfhD8GrVByWvYq2WVrtitlT+h+VnElA9IsP5D9aEBycMC6ru2aSWGILxFr
 fUdgABPS/nu9vFZr6OruobApMhc05JWV/dejAcI6DQHvNSLDVa6N/sSpygKkhJ99OUYs
 tvIkrxTPnW47Q4WJAgZhOIcq3hfm7ppbYoJ48nOfBaZE1ZZlNgwd0lOJXj0XHblIxddr
 pNqRqTBAvPb+j9LhHe72ZXoilM71/6a7bSvbGQJiK3QLGV9wh0+jeUT3D4nlVL+80erT
 L7riWhn5nPoOiwmmquO0KA8eBaeNlCAzmy0e8yNN+7kSDH0tIEiIsfU+/ShX3beGE5Od
 bLJg==
X-Gm-Message-State: AFuF++k/64vvNcapoHROvmQWIPt/DvwMvC/3bHd5a8sZqwhkThzj7IFQ
 Ci2RlavEukSIJMG6I1zQgX7FQTeiJPDBTVdoy5QNVHfpsM/h7Dt30+9fsTK2iUsbnMVyPlej7UI
 76WxDdJGNSnARkcdUFiZF4pgZam+LDBz+7BeXovOulS2XdSihtrPYymReq2KYXwFWeg==
X-Gm-Gg: AYBFou1ssJ9Ih4iHpbUh/MeG8wS3wqFAblp89cKJcrO70CalW2+JwsFxdYAWpb3yGZi
 PQPcmkRMXhHDYieIa2BLbZPWG7tUSY94Pqzo9V+9vC+0acbNdb8RB40F7p1jjeaFnGF2pxLJ68m
 lzEhr+6PvoWkySghuOSFSJICRKPHwsJYYutSvykqftSl+PrfbRT8aEkD0PfVAfp4fUXF2ZXdcrk
 gTrf35q9q+3kEqNAoLtF9u7Q36MrZDR6ifEPVbspm2M91nTJqQjaY9pgr5nQoeNBX+K4eOtkr43
 +qR7+XPqQ+/esmx8LgEMKXPKUlH4rWdaJ1qTqTjVQyri5kFvBhleNcBNO4TP2LDVzRM46ljnGGi
 yj9iwPHt+w2pM4gzzenLCnNVnF4TLeKKapDi2oF05Udf4TUcI
X-Received: by 2002:a05:6820:4df7:b0:6a1:4507:3544 with SMTP id
 006d021491bc7-6b6fd7c9e58mr1980965eaf.28.1788484962449; 
 Thu, 03 Sep 2026 18:22:42 -0700 (PDT)
X-Received: by 2002:a05:6820:4df7:b0:6a1:4507:3544 with SMTP id
 006d021491bc7-6b6fd7c9e58mr1980948eaf.28.1788484961976; 
 Thu, 03 Sep 2026 18:22:41 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339885ca07sm2573234eec.1.2026.09.03.18.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 18:22:40 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 5/5] tests/tcg/hexagon: check the two HVX predicate build
 paths agree
Date: Thu,  3 Sep 2026 18:22:33 -0700
Message-Id: <20260904012233.3607547-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260904012233.3607547-1-brian.cain@oss.qualcomm.com>
References: <20260904012233.3607547-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDAxMCBTYWx0ZWRfX6gYfbaYN8RKQ
 39Ey5mH7pqsfj+FXKvCiZjKz4raIKC9MhZ2wSQM++2ZWrcij7BWr46n05j9ZWyIeDreVgdweKRz
 PotPRYWkuAML99V4dOQ1SOm3uVX25IcgSNk6UXodsuA/n+XzwGWFgtqoZxaRLqEFrul1r8tqQFW
 28DEOZ6vEo74g1QFgiK+oOyQRnav8VOBnbDeMD0FUfJGkc6ITsX/VhJOYqdafd19sIwU0/HJF/l
 cIMlFe94hQjkf2KLZYhC0UAjoUePPWNuHX6Hq28KEBIx8N/QN2jX7c7JBB+Qo8qQ/pZbz70/W9B
 +2gB8dSswndwvafvLb3XMNJ7HSlTW1V7jHbwZi0XlBneuQGV7GDFBMw791RNjHfVLP0HNpYpics
 lxyzFKaSHGS3oMcyZef+T1nnmnusgr+SEOwSVMz4Azyb/T86XAQ2r6nhfo46HgY3dngvh94NBV/
 mB7JSS0UxCGQOA1EMxQ==
X-Authority-Analysis: v=2.4 cv=Oc2oyBTY c=1 sm=1 tr=0 ts=6a9a1d63 cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=jjHI2IJ3bfbFesgfRcwA:9 a=QEXdDO2ut3YA:10
 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-ORIG-GUID: TxIGPlSUoBjz9ACEnTB1mnou9QToB3W3
X-Proofpoint-GUID: TxIGPlSUoBjz9ACEnTB1mnou9QToB3W3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDAxMCBTYWx0ZWRfX/P4bBvJcEd1t
 jdSFiXk4e4D4YiAUC0AfAixMJonT78cKqfQ7IcT5LoU1GqVM5o9OXgW/5sztPc+13qEPaVHdr+k
 ymVjGdTbUdNCAJU3jdSTVjTgrvOO2LQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_07,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040010
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

QSBRIHJlZyBjYW4gYmUgYnVpbHQgYnkgYSB2ZWN0b3IgY29tcGFyZSBvciBieSB2YW5kKFZ1LCBS
dCksIGFuZAp0aG9zZSByZWFjaCB0aGUgcHJlZGljYXRlIHJlZ2lzdGVyIHRocm91Z2ggaW5kZXBl
bmRlbnQgY29kZSBwYXRocy4gQ2hlY2sKdGhhdCBib3RoIHNlbGVjdCB0aGUgc2FtZSBieXRlIGxh
bmVzLCBzbyBhIGJ5dGUtb3JkZXIgbWlzdGFrZSBpbiBlaXRoZXIKb25lIGlzIGNhdWdodC4KClRo
ZSBpbnB1dCBhbHRlcm5hdGVzIGV2ZXJ5IGVpZ2h0IGxhbmVzOiBhIGZsYXR0ZXIgcGF0dGVybgpz
dGF5cyB1bmNoYW5nZWQgd2hlbiBwcmVkaWNhdGUgYnl0ZXMgYXJlIHBlcm11dGVkIGFuZCBoaWRl
cyB0aGUgYnVnLgoKU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVh
bGNvbW0uY29tPgotLS0KIHRlc3RzL3RjZy9oZXhhZ29uL2h2eF9taXNjLmMgfCA0NSArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA0NSBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vaHZ4X21pc2MuYyBiL3Rlc3Rz
L3RjZy9oZXhhZ29uL2h2eF9taXNjLmMKaW5kZXggMzJhMzY2MWE4NmYuLjIyNTY2NjEzN2M5IDEw
MDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9odnhfbWlzYy5jCisrKyBiL3Rlc3RzL3RjZy9o
ZXhhZ29uL2h2eF9taXNjLmMKQEAgLTE4MSw2ICsxODEsNTAgQEAgc3RhdGljIHZvaWQgdGVzdF9z
dG9yZV91bmFsaWduZWQodm9pZCkKICAgICBjaGVja19vdXRwdXRfdyhfX0xJTkVfXywgMik7CiB9
CiAKKy8qCisgKiBBIFEgcmVnaXN0ZXIgY2FuIGJlIGJ1aWx0IGVpdGhlciBieSBhIHZlY3RvciBj
b21wYXJlIG9yIGJ5IHZhbmQoVnUsIFJ0KS4KKyAqIFRob3NlIGFyZSB0d28gaW5kZXBlbmRlbnQg
Y29kZSBwYXRocyBvbnRvIHRoZSBzYW1lIHByZWRpY2F0ZS1yZWdpc3RlcgorICogbGF5b3V0LCBz
byBjcm9zcy1jaGVjayB0aGF0IHRoZXkgc2VsZWN0IGV4YWN0bHkgdGhlIHNhbWUgYnl0ZSBsYW5l
cy4KKyAqIEEgYnl0ZS1vcmRlciBtaXN0YWtlIGluIGVpdGhlciBvbmUgc2hvd3MgdXAgaGVyZSBh
cyBhIG1pc21hdGNoLgorICoKKyAqIFRoZSBpbnB1dCBwYXR0ZXJuIGhhcyB0byB2YXJ5IGFjcm9z
cyA4LWxhbmUgYmxvY2tzLCBvdGhlcndpc2UgYSBwcmVkaWNhdGUKKyAqIHdob3NlIGJ5dGVzIGFy
ZSBwZXJtdXRlZCBzdGlsbCBzZWxlY3RzIHRoZSBzYW1lIGxhbmVzIGFuZCB0aGUgbWlzbWF0Y2gg
aXMKKyAqIGludmlzaWJsZS4KKyAqLworc3RhdGljIHZvaWQgdGVzdF9xcmVnX2FsaWFzKHZvaWQp
Cit7CisgICAgSFZYX1ZlY3RvciAqcGNtcCA9IChIVlhfVmVjdG9yICopJm91dHB1dFswXTsKKyAg
ICBIVlhfVmVjdG9yICpwYW5kID0gKEhWWF9WZWN0b3IgKikmb3V0cHV0WzFdOworICAgIEhWWF9W
ZWN0b3IgaW5wdXQ7CisgICAgSFZYX1ZlY3RvciBvbmVzOworICAgIEhWWF9WZWN0b3JQcmVkIHFj
bXA7CisgICAgSFZYX1ZlY3RvclByZWQgcWFuZDsKKworICAgIGZvciAoaW50IGkgPSAwOyBpIDwg
QlVGU0laRTsgaSsrKSB7CisgICAgICAgIC8qCisgICAgICAgICAqIEJ1aWxkIDAvMSBwZXIgYnl0
ZSwgYWx0ZXJuYXRpbmcgZXZlcnkgOCBsYW5lcywgc28gdGhhdCAiIT0gMCIgYW5kCisgICAgICAg
ICAqICJsb3cgYml0IHNldCIgZGVzY3JpYmUgdGhlIHNhbWUgbGFuZXMuICBUaGVuIGZvcm0gb25l
IHByZWRpY2F0ZQorICAgICAgICAgKiB3aXRoIGEgY29tcGFyZSBhbmQgdGhlIG90aGVyIHdpdGgg
dmFuZChWdSwgUnQpLCBzdG9yZSAweGZmIHRocm91Z2gKKyAgICAgICAgICogZWFjaCwgYW5kIHJl
cXVpcmUgdGhlIHR3byByZXN1bHQgdmVjdG9ycyB0byBiZSBpZGVudGljYWwuCisgICAgICAgICAq
LworICAgICAgICBmb3IgKGludCBqID0gMDsgaiA8IE1BWF9WRUNfU0laRV9CWVRFUzsgaisrKSB7
CisgICAgICAgICAgICBleHBlY3RbMF0udWJbal0gPSAoKGogPj4gMykgKyBpKSAmIDE7CisgICAg
ICAgIH0KKyAgICAgICAgbWVtY3B5KCZpbnB1dCwgJmV4cGVjdFswXSwgc2l6ZW9mKE1NVmVjdG9y
KSk7CisgICAgICAgIG1lbXNldChvdXRwdXQsIDAsIDIgKiBzaXplb2YoTU1WZWN0b3IpKTsKKwor
ICAgICAgICBvbmVzID0gUTZfVl92c3BsYXRfUigweGZmZmZmZmZmKTsKKyAgICAgICAgcWNtcCA9
IFE2X1FfdmNtcF9ndF9WdWJWdWIoaW5wdXQsIFE2X1Zfdnplcm8oKSk7CisgICAgICAgIHFhbmQg
PSBRNl9RX3ZhbmRfVlIoaW5wdXQsIDB4MDEwMTAxMDEpOworICAgICAgICBRNl92bWVtX1FSSVYo
cWNtcCwgcGNtcCwgb25lcyk7CisgICAgICAgIFE2X3ZtZW1fUVJJVihxYW5kLCBwYW5kLCBvbmVz
KTsKKworICAgICAgICBmb3IgKGludCBqID0gMDsgaiA8IE1BWF9WRUNfU0laRV9CWVRFUzsgaisr
KSB7CisgICAgICAgICAgICBjaGVjayhfX0xJTkVfXywgaSwgaiwgb3V0cHV0WzBdLnViW2pdLCBv
dXRwdXRbMV0udWJbal0pOworICAgICAgICB9CisgICAgfQorfQorCiBzdGF0aWMgdm9pZCB0ZXN0
X21hc2tlZF9zdG9yZShib29sIGludmVydCkKIHsKICAgICB2b2lkICpwMCA9IGJ1ZmZlcjA7CkBA
IC01NzksNiArNjIzLDcgQEAgaW50IG1haW4oKQogICAgIHRlc3Rfc3RvcmVfdW5hbGlnbmVkKCk7
CiAgICAgdGVzdF9tYXNrZWRfc3RvcmUoZmFsc2UpOwogICAgIHRlc3RfbWFza2VkX3N0b3JlKHRy
dWUpOworICAgIHRlc3RfcXJlZ19hbGlhcygpOwogICAgIHRlc3RfbmV3X3ZhbHVlX3N0b3JlKCk7
CiAgICAgdGVzdF9tYXhfdGVtcHMoKTsKIAotLSAKMi4zNC4xCgo=

