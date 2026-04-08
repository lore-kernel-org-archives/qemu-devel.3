Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655F710F996A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXqX-0004Yr-M8; Wed, 08 Apr 2026 14:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAXqR-000409-AH
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:41:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAKP4-0005b2-Ex
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:20:37 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637JlsxV1314650
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 04:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uTRk/geKwj2+iRzHqb5TRYkJBHt259KZAXeA+C70Da0=; b=SXkFPeH/Q12XOPgP
 i4LT/v4rzPkDLqu57Bwsef/B2SzD8RxzDPufxrtbVh2iDgQmWsdNwIFR8VZ/hlod
 UfakHZxj3sl6RVous0SxOdxRukQ8Y2pctZ+JAyskXkaR9z63zuaTAsDzIzg5IZir
 yW9FFEpDyBLyCXbFS3aAQ/x824U07YkYLuZi7TLasyppqK083tStnZh+PncG8m/k
 pex1a/hgxGeWeYFuncJL9sE/13MPmYkiMvK087IBMMzzH8RT5TycZXgRrCChOwyB
 HBbsNekGs9gsJluYjky9wlNRMKMl9oft4HXdrzpt+u/M5wRHFYG/nYKchzmpuSd7
 90vGhg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd8d6ha7e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:20:24 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-127133794b6so9493327c88.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 21:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775622024; x=1776226824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uTRk/geKwj2+iRzHqb5TRYkJBHt259KZAXeA+C70Da0=;
 b=LnMa75iV12gmxmlH4awRoz6SGPBNdK75/Q75ZBjKDAabOUK6aIGR4XkLaQIvFeAi3g
 19zoosNdoTlJy2N4dLpEM9sfl4koeEkGHenD5veTbuJJUxxhrUPbHZJqXkp4YE2HiWWX
 ab785WWjjOn+ynom0y2NzQlybuPiXAEo4lCW/A+gbiRSPZPPzc0kQQJrOcgSVLrpMetO
 YailJn2o8Nfk7dk7BTm0FMaU68TioUcYlot+LdG+62rPHj5hqWUX6xmubEC9dRDYPZlF
 38PhP88YRRkv6T5wZWuUbuabbmWwZOt1/t+h3QRjUYDDcT3T+Xql6EjLsx0Ih+2n0n5w
 +gww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775622024; x=1776226824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uTRk/geKwj2+iRzHqb5TRYkJBHt259KZAXeA+C70Da0=;
 b=hx18lr3akznhJHsANNlwlxJamh/2j6KWJOg0ViIU50oq0hcMblrsLOQ11A0Rxly8dh
 4Pgskuk/HJLDsgzsHN4v39F/ZQttacqhowY1dW4aCxFjA8sWssn8QsuTI4ZPuH5/oIWp
 fW/Tw/GuCDVUUfY0wTa1d+N1GBhqgBNmBx26cm4TynkhTy8qk520k7PlQ8L9Xp9Oyo2M
 PvnDgEZ/3UzrPkHkFjGEALo0wQ5B9BS68FQGdmXdjJLYTbP5RW5qVJNDFUZQEYzfpPOo
 eSn3e06HNgLm2PXWcDBe+IkEjmMbFQ2aoWSUH8BBaX3VsJgRSz+rX6skDGwNgQnPIw0o
 TVsQ==
X-Gm-Message-State: AOJu0YzF8ylls7yIuanBRxhu8K28+3pzKJ9BQ1ZpxjWBb13zfz4/UiB6
 m0cRUFd8JKchQUChMf8pZHGLdj/7NlqUVnQZVe+Sw6m/JUNwbeY9sCMtFc+UgwO+LisHVQ22EzM
 vhW0rbaDG8QreYgaiVjREErhgt03vRaxRDnTcze7j9BUZylPpm08l9NDBotkTOw+vIQ==
X-Gm-Gg: AeBDietEuQNY40jMauhgpqj87w5N5xSn6ghS1sHhRFfGUZXp0ZPI/LTyJxnIAmA+fUL
 JPAjAz1dlZbsPMqDLTx7oEnPoD5lkyVLGSJ9hIMiyHPRcp3cxZXokIbG/Xw474BYtl7GizIn5fS
 G2Ht5jNBMN4rog1wSvYcZgMZj94HqZVgcZsm1WaKIfeW4liygS6XKbQuPztRG3VfFiJmep/QRLU
 kBqBYG0GLzhd8vb9papuGboH++vZA2C9lm5Ji+Xg83cDaoeUU7nPjv9n8QY5eD7H40ctdF9p+iw
 WZADHd1rgoYGdmuwEfhoX67oYJv8OSttuFp6Y7w/vS+lbltt+KHbJFkY8RKiog5nh8VounVe9US
 E3FlGsz8slE/3vhU81Xm1ypb4HWIA5uSs+SOvwj35YhzPuCqu8aJ8M9y9lUxizQNp75S95g==
X-Received: by 2002:a05:7022:43a8:b0:11b:9b98:aa4b with SMTP id
 a92af1059eb24-12bfb6ec461mr9948638c88.6.1775622023574; 
 Tue, 07 Apr 2026 21:20:23 -0700 (PDT)
X-Received: by 2002:a05:7022:43a8:b0:11b:9b98:aa4b with SMTP id
 a92af1059eb24-12bfb6ec461mr9948628c88.6.1775622023009; 
 Tue, 07 Apr 2026 21:20:23 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c14a371b1sm6480362c88.13.2026.04.07.21.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 21:20:22 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 15/28] target/hexagon: Implement setprio, resched
Date: Tue,  7 Apr 2026 21:19:40 -0700
Message-Id: <20260408041953.1899532-16-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
References: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: QTKiXLWHv2a9UV7yeXNSIwD7UO4cQkGx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX/Jjj3IcLKVKS
 iguZqe2Y0D8TzqJSJn1q2mOmtWFLrMmiwEjJLcsYi52KxIj4zcAVnnmO2+DDTBte8kaYZouUtwE
 gBwHWJRA6DfJP3C20NNIbgnpQzWScVu3Y7/h3BnTk+OKPStzrhmJuffqsko76bV2ZV/IOH6zG20
 PMjJLmwhxzETd0j0keq2BXS6qrUxFvOobaywA4XCu2YprmICuUleHkNVILO5p1eVhCThwEAT9jh
 TSVoxP+tFN6lVVl213u2ZqR6Tq0FCiUvtikEBHogqnYD39goKvJFkbwPu3Sj65KylQPKXIqBLIc
 kkzDAIzVaILt0Zei0mvHippVSuhUUoDeKmk65Qamk2edmmE9lxkvugmpXOyD6bS9mpRrnEXw+P7
 S+Mx62n7HA+dlmWSIOgCSuy+LkrIkrUoSolKr/RR1C0Dy7pqu4IOnLZsjfiNwu9kE00QZ0rM6fK
 akCElDDo7PIB6x//PKw==
X-Authority-Analysis: v=2.4 cv=GN041ONK c=1 sm=1 tr=0 ts=69d5d788 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=9hY_xzidxOicKg_qOOkA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: QTKiXLWHv2a9UV7yeXNSIwD7UO4cQkGx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080036
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGUgaGFyZHdhcmUtYXNzaXN0
ZWQgc2NoZWR1bGVyIGhlbHBzIG1hbmFnZSB0YXNrcyBvbiB0aGUgcnVuIHF1ZXVlCmFuZCBpbnRl
cnJ1cHQgc3RlZXJpbmcuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9z
cy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgfCA3NyArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDc3IGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3Rh
cmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IDY0ZjFmYjIwNDNmLi43NGEwNDM5OGFhMSAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFn
b24vb3BfaGVscGVyLmMKQEAgLTE1ODksNiArMTU4OSw2NCBAQCBzdGF0aWMgdm9pZCBoZXhhZ29u
X3dhaXRfdGhyZWFkKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBQQykKICAgICBjcHVf
aW50ZXJydXB0KGNzLCBDUFVfSU5URVJSVVBUX0hBTFQpOwogfQogCitzdGF0aWMgaW5saW5lIFFF
TVVfQUxXQVlTX0lOTElORSB2b2lkIHJlc2NoZWQoQ1BVSGV4YWdvblN0YXRlICplbnYpCit7Cisg
ICAgdWludDMyX3Qgc2NoZWRjZmc7CisgICAgdWludDMyX3Qgc2NoZWRjZmdfZW47CisgICAgaW50
IGludF9udW1iZXI7CisgICAgQ1BVU3RhdGUgKmNzOworICAgIHVpbnQzMl90IGxvd2VzdF90aF9w
cmlvID0gMDsgLyogMCBpcyBoaWdoZXN0IHByaW8gKi8KKyAgICB1aW50MzJfdCBiZXN0d2FpdF9y
ZWc7CisgICAgdWludDMyX3QgYmVzdF9wcmlvOworICAgIEhleGFnb25DUFUgKmNwdTsKKworICAg
IEJRTF9MT0NLX0dVQVJEKCk7CisgICAgcWVtdV9sb2dfbWFzayhDUFVfTE9HX0lOVCwgIiVzOiBj
aGVjayByZXNjaGVkXG4iLCBfX2Z1bmNfXyk7CisgICAgY3B1ID0gZW52X2FyY2hjcHUoZW52KTsK
KyAgICBzY2hlZGNmZyA9IGNwdS0+Z2xvYmFscmVncyA/CisgICAgICAgIGhleGFnb25fZ2xvYmFs
cmVnX3JlYWQoY3B1LT5nbG9iYWxyZWdzLCBIRVhfU1JFR19TQ0hFRENGRywKKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBlbnYtPnRocmVhZElkKSA6IDA7CisgICAgc2NoZWRjZmdfZW4g
PSBHRVRfRklFTEQoU0NIRURDRkdfRU4sIHNjaGVkY2ZnKTsKKyAgICBpbnRfbnVtYmVyID0gR0VU
X0ZJRUxEKFNDSEVEQ0ZHX0lOVE5PLCBzY2hlZGNmZyk7CisKKyAgICBpZiAoIXNjaGVkY2ZnX2Vu
KSB7CisgICAgICAgIHJldHVybjsKKyAgICB9CisKKyAgICBDUFVfRk9SRUFDSChjcykgeworICAg
ICAgICBIZXhhZ29uQ1BVICp0aHJlYWQgPSBIRVhBR09OX0NQVShjcyk7CisgICAgICAgIENQVUhl
eGFnb25TdGF0ZSAqdGhyZWFkX2VudiA9ICYodGhyZWFkLT5lbnYpOworICAgICAgICB1aW50MzJf
dCB0aF9wcmlvID0gR0VUX0ZJRUxEKAorICAgICAgICAgICAgU1RJRF9QUklPLCB0aHJlYWRfZW52
LT50X3NyZWdbSEVYX1NSRUdfU1RJRF0pOworICAgICAgICBpZiAoIWhleGFnb25fdGhyZWFkX2lz
X2VuYWJsZWQodGhyZWFkX2VudikpIHsKKyAgICAgICAgICAgIGNvbnRpbnVlOworICAgICAgICB9
CisKKyAgICAgICAgbG93ZXN0X3RoX3ByaW8gPSAobG93ZXN0X3RoX3ByaW8gPiB0aF9wcmlvKQor
ICAgICAgICAgICAgPyBsb3dlc3RfdGhfcHJpbworICAgICAgICAgICAgOiB0aF9wcmlvOworICAg
IH0KKworICAgIGJlc3R3YWl0X3JlZyA9IGNwdS0+Z2xvYmFscmVncyA/CisgICAgICAgIGhleGFn
b25fZ2xvYmFscmVnX3JlYWQoY3B1LT5nbG9iYWxyZWdzLCBIRVhfU1JFR19CRVNUV0FJVCwKKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnYtPnRocmVhZElkKSA6IDA7CisgICAgYmVz
dF9wcmlvID0gR0VUX0ZJRUxEKEJFU1RXQUlUX1BSSU8sIGJlc3R3YWl0X3JlZyk7CisKKyAgICAv
KgorICAgICAqIElmIHRoZSBsb3dlc3QgcHJpb3JpdHkgdGhyZWFkIGlzIGxvd2VyIHByaW9yaXR5
IHRoYW4gdGhlCisgICAgICogdmFsdWUgaW4gdGhlIEJFU1RXQUlUIHJlZ2lzdGVyLCB3ZSBtdXN0
IHJhaXNlIHRoZSByZXNjaGVkdWxlCisgICAgICogaW50ZXJydXB0IG9uIHRoZSBsb3dlc3QgcHJp
b3JpdHkgdGhyZWFkLgorICAgICAqLworICAgIGlmIChsb3dlc3RfdGhfcHJpbyA+IGJlc3RfcHJp
bykgeworICAgICAgICBxZW11X2xvZ19tYXNrKENQVV9MT0dfSU5ULAorICAgICAgICAgICAgICAg
ICIlczogcmFpc2luZyByZXNjaGVkIGludCAlZCwiCisgICAgICAgICAgICAgICAgIiBjdXIgUEMg
MHglIiBQUkl4MzIgIlxuIiwKKyAgICAgICAgICAgICAgICBfX2Z1bmNfXywgaW50X251bWJlciwg
ZW52LT5ncHJbSEVYX1JFR19QQ10pOworICAgICAgICBTRVRfU1lTVEVNX0ZJRUxEKGVudiwgSEVY
X1NSRUdfQkVTVFdBSVQsIEJFU1RXQUlUX1BSSU8sIH4wKTsKKyAgICAgICAgaGV4X3JhaXNlX2lu
dGVycnVwdHMoZW52LCAxIDw8IGludF9udW1iZXIsIENQVV9JTlRFUlJVUFRfU1dJKTsKKyAgICB9
Cit9CisKIHZvaWQgSEVMUEVSKHdhaXQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBQ
QykKIHsKICAgICBCUUxfTE9DS19HVUFSRCgpOwpAQCAtMTY5Nyw4ICsxNzU1LDI3IEBAIHVpbnQ2
NF90IEhFTFBFUihncmVnX3JlYWRfcGFpcikoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90
IHJlZykKICAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOwogfQogCisvKgorICogc2V0cHJpby9y
ZXNjaGVkIC0gU2VlIHRoZSBIZXhhZ29uIFY3MyBQcm9ncmFtbWVyJ3MgUmVmZXJlbmNlIE1hbnVh
bCwKKyAqIFNlY3Rpb24gNi40ICJJbnRlcnJ1cHQgYW5kIFRocmVhZCBTY2hlZHVsaW5nIgorICov
CiB2b2lkIEhFTFBFUihzZXRwcmlvKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgdGhy
ZWFkLCB1aW50MzJfdCBwcmlvKQogeworICAgIENQVVN0YXRlICpjczsKKworICAgIEJRTF9MT0NL
X0dVQVJEKCk7CisgICAgQ1BVX0ZPUkVBQ0goY3MpIHsKKyAgICAgICAgSGV4YWdvbkNQVSAqZm91
bmRfY3B1ID0gSEVYQUdPTl9DUFUoY3MpOworICAgICAgICBDUFVIZXhhZ29uU3RhdGUgKmZvdW5k
X2VudiA9ICZmb3VuZF9jcHUtPmVudjsKKyAgICAgICAgaWYgKHRocmVhZCA9PSBmb3VuZF9lbnYt
PnRocmVhZElkKSB7CisgICAgICAgICAgICBTRVRfU1lTVEVNX0ZJRUxEKGZvdW5kX2VudiwgSEVY
X1NSRUdfU1RJRCwgU1RJRF9QUklPLCBwcmlvKTsKKyAgICAgICAgICAgIHFlbXVfbG9nX21hc2so
Q1BVX0xPR19JTlQsCisgICAgICAgICAgICAgICAgICAgICAgICAgICIlczogdGlkICUiIFBSSXUz
MiAiIHByaW8gPSAweCUiIFBSSXgzMiAiXG4iLAorICAgICAgICAgICAgICAgICAgICAgICAgICBf
X2Z1bmNfXywgZm91bmRfZW52LT50aHJlYWRJZCwgcHJpbyk7CisgICAgICAgICAgICByZXNjaGVk
KGVudik7CisgICAgICAgICAgICByZXR1cm47CisgICAgICAgIH0KKyAgICB9CiAgICAgZ19hc3Nl
cnRfbm90X3JlYWNoZWQoKTsKIH0KIAotLSAKMi4zNC4xCgo=

