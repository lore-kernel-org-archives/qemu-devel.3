Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE4CCD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waiC0-0002B5-Ln; Fri, 19 Jun 2026 19:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiBz-00028P-6c
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:00:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiBx-0001dX-G2
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:00:06 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLYSLn1337254
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N0iAGziQ+4iP1vKIbJyLWLa6evXdgIMUYRbL+wxICtw=; b=PSyzgqlg3Y4D5iHm
 2K2vekI2kIQACfx7yg+DIfkHr0sMYuuX8GSBErx/htWCaZ34xqmzw4wYWGE/kWYl
 ZomfR6p+pXRMOZ6Hpu1/C6zOy5VgKR57oVUK38EMMIzcxd1YeNRsEf/ptUlrri24
 j2bC+U+2uHL++w48Y4ghvTO7GbeN9OBJS0jSl3CY/enbV/l8Tzx8Jc1XkTGaGenf
 x2y5dLlOHiflqBBsA9mejVuhe3EyMHv1TfiA+bFWNMJuc5teLUfkI0HhHxnJYAQC
 C0yG3ktWzHp4+tgSbMLCIbVwGqlQbUYbqo8T+ria9UTcc/FlSON756uMVTn8jgpn
 0jRgbw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp67556r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:54 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30beab99453so4056129eec.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 15:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781909993; x=1782514793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N0iAGziQ+4iP1vKIbJyLWLa6evXdgIMUYRbL+wxICtw=;
 b=ZwMxmJ6Zdxfuc61quF8XHKS4jr+HyOMNTO2++92dFbYtABDnEkM6sZePxmdsxSqXmR
 8l3oHizFvqS+iKzmo5Svrl8GtJ3xLaGijiTKkDpFT2puPR9GP7rFAYkbKdixgz95Huh7
 Ax+7PARUqi3Pg2RkApe6i+e9mSEPriel3CqDGAhs0xs5rfryM3EWpmHAXcbv7isTw3tH
 390G0Lj1C+Q77SA52EQxi7qGwM6ULH4+inmGv4EhAmTrF9618C2aAs+ayMPIC2373l5y
 eFEXmQdrgsVsJDkXmRlYHLB4/zooD8Db0P/It6EiTtzpcYmYUAQ4Ih9qHfpXcesmuxHw
 tEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781909993; x=1782514793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N0iAGziQ+4iP1vKIbJyLWLa6evXdgIMUYRbL+wxICtw=;
 b=LbLEPFS2zEqOllP7rnWq3Cny+PX8R8oDiv4WzbbdmwnaBsP7Cmud7qSXACOjbA6exm
 HaZwzsmMIYlbiafE7/4r2VY+/8XbYWRmYdWl0wQoxhqnMLmVW3AHrnvter4SF/6xmrHC
 tETgOpH+yeLQRTfMtJ0TJ6RCh98cxKZnMgLuc/VXjJlpAuISLXz8fJ9J8Auvwbf70Yh+
 lUc0jvKz2DYvoaDjlVGZb9gluxXYExP2t/S+M+zlReISVxvFYV95typDKObrIa1eiU/h
 80Ok1QZ0L+m6opvCDYjVFxWeoSxf+S4ZI7KIy7LAwnyQ1xWR8bOMGTqS6WmAp+pvbHTx
 +0Ww==
X-Gm-Message-State: AOJu0YyfM15towsZVlri+PRgQoRlNN6Xb1wJ3Xz2Z2niU+7PLNNECuS/
 Nn68NII0vTb8/jzY68EU0A+MpwsTdRx8/4g324bmGhUTjL/W0gBxl3h3JDXxKitxehTl+L4P4EA
 OZQldcQR3gQGYqMqrGeFRSPOIhgkzUmOKnU1TaCD8KByYQd0hUsIvz1V4fVDjXdlC2A==
X-Gm-Gg: AfdE7ckrrJf0VL1Oi0h39OzmecqDwRsdw0pnAjG5S21dDNrNsr/oyv89cZuhf+ip1d1
 UVJwRDE8XAejK2fJAmwZ3UJlYPJ1qrlOnaVapOqnVnFFgHMfJQBOMykUveBejjzH80a19OoxUrZ
 vD2zeYcMAGUO3ti5/wI5Q+ATKFNSfAUGS/2c2kp0e9OIobpoHukt7259stR4FRFgXfrElDTTCbd
 mdI7WNCFBCKBp1KjK91wtFEROIPwH0QXOJ5E95+MC3X9gdP4ec71t47ngv4AWoAD4baw44Awod+
 fiug2ZvIWEk6ar9UKoi+NGcIFoHjLi0REjuknsv4Ks9n0fTvmw8gS0affJq+7LVJuBpvKW+jWj+
 U1773eSrGLVZakC0se9Loh8vM/5vB911d1H/Ph65nrWJVZ6EcvdWNh8bwgYs=
X-Received: by 2002:a05:7300:80ca:b0:30b:f3b8:3e7f with SMTP id
 5a478bee46e88-30c06fb6af6mr3449043eec.1.1781909993450; 
 Fri, 19 Jun 2026 15:59:53 -0700 (PDT)
X-Received: by 2002:a05:7300:80ca:b0:30b:f3b8:3e7f with SMTP id
 5a478bee46e88-30c06fb6af6mr3449030eec.1.1781909992976; 
 Fri, 19 Jun 2026 15:59:52 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1b4f7d81sm1309510eec.0.2026.06.19.15.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 15:59:52 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 26/74] target/hexagon: Add TCG overrides for thread ctl
Date: Fri, 19 Jun 2026 15:58:23 -0700
Message-Id: <20260619225911.159473-27-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: CK1VY7PKLXkTI1rtqHJfjfHsftZfbixB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfX50kde5LiFdxX
 P9Yd2bEU8iIy3mMvuj1FFeLz2H4aE/k7zN3JsFPgFUri5fUvyfMxsALHgr6Vd9Q782tmMWD1Uoc
 iPlF7FlpCh0SWsHQ9DroxRn6U8nzD6vYpGDS6Tf9+k4q/VAujbKtFfQVybs2NnmHKk6oIiZH7jK
 91pbwwYCfZ/gt2h3p9XCv+lT3+vS/4gP93F4ckdFU2wTW64h5OKIC/zlQpZq+jwMwYBe6NRKWjf
 EwtWgzCiZcMxcGnheg0MNy3S1x/2Hjc3stwwTx+jQlwl2AsLPiu4T76vqd6/J8w+3A3MtMpfqF9
 Ws3+5oZWS1dEUWSVABJqJ6jofHqPGj8QCS7qK/jKm0LS5xFnYl6XxSwPfSaewZwBqRkpmXEfbrg
 eRU7FKgi3VI8FfxlyOZUSiJM9czScO3D0TDjVE+PfXcTznUy9+62ax70ydd7YcaB56y1lvkNBK5
 ep5ooXJwnLCKiU6UeHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfX4QT6Gg94E6ds
 5Q6eY7yOrfIgLBP+ENKmMUTeNt0l1yWZTN9sTcWK14scDvCS8F7HWcq20lLQ2nDt26qwCqupq1Z
 DJSuPv1CaBii6c1JJ7waU0CvMopieug=
X-Proofpoint-GUID: CK1VY7PKLXkTI1rtqHJfjfHsftZfbixB
X-Authority-Analysis: v=2.4 cv=TdOmcxQh c=1 sm=1 tr=0 ts=6a35c9ea cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=t9Y8JitlK4h6-XB8aEcA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190221
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpEZWZpbmUgVENHIG92ZXJyaWRl
cyBmb3Igc3RhcnQsIHN0b3AsIHdhaXQsIHJlc3VtZSBpbnN0cnVjdGlvbnMuCgpSZXZpZXdlZC1i
eTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1i
eTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9o
ZXhhZ29uL2dlbl90Y2dfc3lzLmggfCAxOCArKysrKysrKysrKysrKysrKysKIHRhcmdldC9oZXhh
Z29uL2hlbHBlci5oICAgICAgfCAgNCArKysrCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAg
IHwgMjAgKysrKysrKysrKysrKysrKysrKysKIDMgZmlsZXMgY2hhbmdlZCwgNDIgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfc3lzLmggYi90YXJnZXQv
aGV4YWdvbi9nZW5fdGNnX3N5cy5oCmluZGV4IDRjYmJkZDFmNzBiLi44NjUwZjY0YTZkNCAxMDA2
NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMuaAorKysgYi90YXJnZXQvaGV4YWdv
bi9nZW5fdGNnX3N5cy5oCkBAIC03Nyw0ICs3NywyMiBAQAogICAgICAgICB9IFwKICAgICB9IHdo
aWxlICgwKQogCisjZGVmaW5lIGZHRU5fVENHX1kyX3dhaXQoU0hPUlRDT0RFKSBcCisgICAgZG8g
eyBcCisgICAgICAgIFJzViA9IFJzVjsgXAorICAgICAgICBnZW5faGVscGVyX3dhaXQodGNnX2Vu
diwgdGNnX2NvbnN0YW50X3RsKGN0eC0+cGt0LT5wYykpOyBcCisgICAgfSB3aGlsZSAoMCkKKwor
I2RlZmluZSBmR0VOX1RDR19ZMl9yZXN1bWUoU0hPUlRDT0RFKSBcCisgICAgZ2VuX2hlbHBlcl9y
ZXN1bWUodGNnX2VudiwgUnNWKQorCisjZGVmaW5lIGZHRU5fVENHX1kyX3N0YXJ0KFNIT1JUQ09E
RSkgXAorICAgIGdlbl9oZWxwZXJfc3RhcnQodGNnX2VudiwgUnNWKQorCisjZGVmaW5lIGZHRU5f
VENHX1kyX3N0b3AoU0hPUlRDT0RFKSBcCisgICAgZG8geyBcCisgICAgICAgIFJzViA9IFJzVjsg
XAorICAgICAgICBnZW5faGVscGVyX3N0b3AodGNnX2Vudik7IFwKKyAgICB9IHdoaWxlICgwKQor
CiAjZW5kaWYKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oIGIvdGFyZ2V0L2hl
eGFnb24vaGVscGVyLmgKaW5kZXggOTU1Mjg3MTMzZTQuLjY4MmYwYzZjMjZlIDEwMDY0NAotLS0g
YS90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaAorKysgYi90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaApA
QCAtMTIzLDQgKzEyMyw4IEBAIERFRl9IRUxQRVJfMihncmVnX3JlYWQsIGkzMiwgZW52LCBpMzIp
CiBERUZfSEVMUEVSXzIoZ3JlZ19yZWFkX3BhaXIsIGk2NCwgZW52LCBpMzIpCiBERUZfSEVMUEVS
XzMoc3JlZ193cml0ZV9tYXNrZWQsIHZvaWQsIGVudiwgaTMyLCBpMzIpCiBERUZfSEVMUEVSXzMo
c2V0cHJpbywgdm9pZCwgZW52LCBpMzIsIGkzMikKK0RFRl9IRUxQRVJfMihzdGFydCwgdm9pZCwg
ZW52LCBpMzIpCitERUZfSEVMUEVSXzEoc3RvcCwgdm9pZCwgZW52KQorREVGX0hFTFBFUl8yKHdh
aXQsIHZvaWQsIGVudiwgaTMyKQorREVGX0hFTFBFUl8yKHJlc3VtZSwgdm9pZCwgZW52LCBpMzIp
CiAjZW5kaWYKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0
L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggYzkwYjc1NzI0MTkuLmM2MjBhNWI4NjM2IDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9v
cF9oZWxwZXIuYwpAQCAtMTQyMCw2ICsxNDIwLDI2IEBAIHVpbnQzMl90IEhFTFBFUihpYXNzaWdu
cikoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHNyYykKICAgICBnX2Fzc2VydF9ub3Rf
cmVhY2hlZCgpOwogfQogCit2b2lkIEhFTFBFUihzdGFydCkoQ1BVSGV4YWdvblN0YXRlICplbnYs
IHVpbnQzMl90IGltYXNrKQoreworICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cit9CisKK3Zv
aWQgSEVMUEVSKHN0b3ApKENQVUhleGFnb25TdGF0ZSAqZW52KQoreworICAgIGdfYXNzZXJ0X25v
dF9yZWFjaGVkKCk7Cit9CisKK3ZvaWQgSEVMUEVSKHdhaXQpKENQVUhleGFnb25TdGF0ZSAqZW52
LCB0YXJnZXRfdWxvbmcgUEMpCit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKK30KKwor
dm9pZCBIRUxQRVIocmVzdW1lKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykK
K3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQorCiB1aW50MzJfdCBIRUxQRVIoZ2V0
aW1hc2spKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCB0aWQpCiB7CiAgICAgZ19hc3Nl
cnRfbm90X3JlYWNoZWQoKTsKLS0gCjIuMzQuMQoK

