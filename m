Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB21CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 22:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5Dw-0005Ic-UL; Fri, 29 May 2026 17:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Dv-00057l-AG
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Dt-0000vg-FD
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:35 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TJZtNu4123960
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TRhzy/A1cTDgjaCTiUykI/3FI0JD/gjC9gP+SRi5Y9o=; b=e8GNsF7OgHkUUmJo
 8R9wW+IySIZDErFYCT8YUGZSf0Mfd/z5gBCEWyy7F2JRiyrJjO1u59tqYWWj5kB8
 R0lI9rrnDuB0Q+E9JnfoH+QT/nx3DfycgfvEiEAhNHHwIX53vCMCxxQwUFiARUn+
 OZBUOAoRmv2umqVdprh9bPTzPI2CaaKgWwMy4rVdF9fDh8zcXjSu/8paXYPC+siN
 xYF/8xFMHwRoftwBZ4dN8YQE2azzROU9cjd3oYnPvi5ItT9d6sHpfJyQftpU1/X0
 lM+IZ5Zr3aKH3NMQjUgbb162Iuj69V8bGgh9YBMxP6q3GBPAjLtG2RP1zjJkmgzy
 FBKzMA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efh3n8g2y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:32 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2fe1cf409a1so4777634eec.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091911; x=1780696711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TRhzy/A1cTDgjaCTiUykI/3FI0JD/gjC9gP+SRi5Y9o=;
 b=BNVX3IwfAuzNmjex3ZECwkX/54+FdCbYxyzdStWTqvqF96sm2K+N3j+3WXpKoaBVDL
 KQnZtfNZfGCZjEWi4F16+7Wyx5jKphr7y9lm4e/L4CLSN+hj4IoAU71tKpYRy+KQjo40
 9C4/JFctYrhBDPq8pzf4W8tKfrAVFF7vnKf28jAcLaFALTU31RZ5R5vx7NzKdzVUNCfu
 8p0elhvQUwsndPgtNeiRqUcJLKPSeNGGygVTG7uZKUkD/vMocH2gF6f2otLmRnIlEMAZ
 80lq0Pe8xD5dBWrxGM1On5V2dwTQT+h1FOJAYOVdKjuLSiaUH582uNnv1nvBSWhrZhqr
 0Pug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091911; x=1780696711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TRhzy/A1cTDgjaCTiUykI/3FI0JD/gjC9gP+SRi5Y9o=;
 b=nbr8mr872ZYMnqm9V/cdMg+M8ZLMmlPWHw1AJua+41qxXoXxB8fxLjhw843joQr9iQ
 fwdHMV4r9OOPbeWuKU7Z32L061Ghh4B29Spq/yqDKMVS1CPKVx/N00vJoB/G/ecCSZAs
 i7j3NhX7MzDhJjv/bwI4JMCd+Eh77TfAltuTr5n6TSl145gOo9ntHEy0ucnpQWs6V5wZ
 TPrII58ERERQyKk+tusLBnOu/BxYMJdlXxhSgA4I/nhj/SlL9Zh1a745QfvWC0KGZAFN
 XYA4jT0p3kR3da8UHLGLiG/HFGGtBNC51N/+UUxGx6VzfNnEepgaUwOJvcbC1mfBAyX6
 f2lw==
X-Gm-Message-State: AOJu0YxLrvVeAVqWyfNNew3hMFD7TIf8Am4ArFxRBXfJzyqFe4ygU8iO
 sUvYLBor1zbAz3poshR4qxe8Yzkw4v3AyiwIu8E4fFzbCRQuxM9VhDesleVQwUaEs2NOAlad7Pj
 j0gITm5BQQ2LhEdETbwydRnTf0P3u2Di97sIvdm4dKgbib4JRMLTerW7sb6XOGXdW2Q==
X-Gm-Gg: Acq92OGnIzAa/7EjxLmHNY3Xy708CVw9GAjn2SwgqaNCNqbO9Er9KIt4mmGicgrxWqT
 R/qxSrYxs5t5G8WFxOZGunaBjBIl0BHATJ56ySI2byjdjjhbBKfvsBIyfUTYJNTDvc3LpumeVaL
 HCU4BNWV1FwPJ8YOQWausDVP9I/Eo0zDL6yK5Xy8sFNIdQH/ASrhpD6xhJmb0Zw6V75DNYCHh6N
 Crkp6k6nLgp4DKP+RwjTRmoh+Ese6vn5j8gVNki3iFO5XNwLCU+nqq2Db0uxkQnA70Wben6aZtj
 ntmv7syaYdye5xRaq0dnbrwcjyFYudhLm35dOQpWuvBaA2RQ1GPGzaKj7d0xg+UzrBm/1D6R0gF
 nBeLkZ8RJLge8BWLTjGuhyR3ZbcI57uSWvxV/y1rG4vjHltQWUDgkv05s5BbEo4heFA1LNQXpys
 5eeA1t
X-Received: by 2002:a05:7301:4918:b0:304:630d:e4ec with SMTP id
 5a478bee46e88-304fa666a76mr916478eec.28.1780091911421; 
 Fri, 29 May 2026 14:58:31 -0700 (PDT)
X-Received: by 2002:a05:7301:4918:b0:304:630d:e4ec with SMTP id
 5a478bee46e88-304fa666a76mr916466eec.28.1780091910865; 
 Fri, 29 May 2026 14:58:30 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5a9d27sm2428313eec.25.2026.05.29.14.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:58:29 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 15/28] target/hexagon: Implement setprio, resched
Date: Fri, 29 May 2026 14:57:53 -0700
Message-Id: <20260529215806.608770-16-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
References: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=RcCgzVtv c=1 sm=1 tr=0 ts=6a1a0c08 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=9hY_xzidxOicKg_qOOkA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX0qx3VnWTsktN
 CqO2TwXIuNUrX2t5toG7yWsG8WoqKZPL6bK0M28rhrqNbuNXZdGzZwTm6s/IspWfuNbnKq+ZaxY
 Apu3HsEvD2deRtLS5Q+sh06gcf2xCvNVa7KlkrccahMRTdUam2GXEYbUwXxSjzrX0z2iwtN7fbA
 e/h54wuIDMcPyQFBsvELDP0uRGN1RTdi/Gv9I30AclAe93ZAjtNTHZyUhV47iDfemLqV/SXzEoQ
 gYvvE6GUb0iXCwxhiZIDOQ6Qgf/Q6F1Ug+qjlRpKKK+CaR0a5NUJkWmlrRhnfRVZ68SUlXqbiNI
 dnrhWURA8A/TQ4m3nA6mublbMIxJ6Ynnmiy1vmYts9Qx3rNsXQJvQWZoYGXnTFbckB3fEWIzdil
 MbKqpx++g6k2/tbCqOELQzSEznJADTwQAIcRm5HdtvK6fFnx0YFmK7qRN3LIoYiQ5Y0qrHoKuDN
 WLzigDlFkk+i6GhiNkA==
X-Proofpoint-ORIG-GUID: kLDqFYt2nIEugwrihjqrpuBY8_Wznii2
X-Proofpoint-GUID: kLDqFYt2nIEugwrihjqrpuBY8_Wznii2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290219
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGUgaGFyZHdhcmUtYXNzaXN0
ZWQgc2NoZWR1bGVyIGhlbHBzIG1hbmFnZSB0YXNrcyBvbiB0aGUgcnVuIHF1ZXVlCmFuZCBpbnRl
cnJ1cHQgc3RlZXJpbmcuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9z
cy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgfCA3NyArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDc3IGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3Rh
cmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IDY0ZjFmYjIwNDNmLi44MjA2MmEyZjgwMiAx
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
ICIlczogcmFpc2luZyByZXNjaGVkIGludCAldSwiCisgICAgICAgICAgICAgICAgIiBjdXIgUEMg
MHglIiBQUkl4MzIgIlxuIiwKKyAgICAgICAgICAgICAgICBfX2Z1bmNfXywgKHVuc2lnbmVkKWlu
dF9udW1iZXIsIGVudi0+Z3ByW0hFWF9SRUdfUENdKTsKKyAgICAgICAgU0VUX1NZU1RFTV9GSUVM
RChlbnYsIEhFWF9TUkVHX0JFU1RXQUlULCBCRVNUV0FJVF9QUklPLCB+MCk7CisgICAgICAgIGhl
eF9yYWlzZV9pbnRlcnJ1cHRzKGVudiwgMSA8PCBpbnRfbnVtYmVyLCBDUFVfSU5URVJSVVBUX1NX
SSk7CisgICAgfQorfQorCiB2b2lkIEhFTFBFUih3YWl0KShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgUEMpCiB7CiAgICAgQlFMX0xPQ0tfR1VBUkQoKTsKQEAgLTE2OTcsOCArMTc1NSwy
NyBAQCB1aW50NjRfdCBIRUxQRVIoZ3JlZ19yZWFkX3BhaXIpKENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCByZWcpCiAgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKIH0KIAorLyoKKyAq
IHNldHByaW8vcmVzY2hlZCAtIGhhcmR3YXJlLWFzc2lzdGVkIHNjaGVkdWxlciBoZWxwZXJzIGZv
ciBtYW5hZ2luZworICogdGhlIHJ1biBxdWV1ZSBhbmQgaW50ZXJydXB0IHN0ZWVyaW5nLgorICov
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

