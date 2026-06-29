Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CFFC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBo1-0005d0-57; Mon, 29 Jun 2026 09:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBnz-0005Z0-Sb
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBny-0003GI-9S
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:43 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT4oT2627854
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2jO0e8rIhKLjhW5IYHunqKRgXza1ukawimSTttXDmgI=; b=pZMH4SN9wLPuTQiI
 t8CYA3R4j9+nbvCloZr7TZCH5Cer32So1J733W+5MYcfs2jQz1O5vWd/uktXn0Vs
 WOrczinJIJ81yGMbGhvhWcLdlasDeuSJvL/M1OFEsgiOuFcmSztkxtAWiLNiZBIM
 Dft5nBaY6PHw2iBih3VDL1hXHUWJl7H2TX9L4y1rfUV6mymxiywTcZX5GXoddevN
 7CGE8wEP95fAaWSZVDpucFFqlLIlBn0XSIkxS0Uya81Uq371DQ7Nbia0UDz2YpAU
 hl6mags4tYNUsOqaCx6DI8u1784MLlixOlRu1p60UUjEAnDEo+RJSbO8s+8CM7ND
 AyN+og==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nbgs1ah-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:31 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-139ca26403fso1576491c88.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782738810; x=1783343610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2jO0e8rIhKLjhW5IYHunqKRgXza1ukawimSTttXDmgI=;
 b=IfFp3nesHic8g5bBAqAF51P5Z2ppDEbxilQo+PCfUfETKoU2QeYq0kFVJ3T2HgTWN4
 cW0hznZUr8K7/wfBbrz0eyt1+L/JBTTI91RxyFkyhaG/Pxs1PwIms4+FYLijf3mGY36J
 fOg4wlc+lugjzOF2t3y8yYrHOuPQE2dwhZyhTJ3pqbJzM2a3v1ahCHlXT18iOhZDh4CN
 5NtMwNjG5kX/IOGYHrOUNQUR7LF4l5NtIB8rKgLzI4JP3vtU//8Ai9JX7T6XTZscTf1L
 pn7dzZ+XV0gN6NiCIgtUVTnIGJ/PV2+QTxufwCYTgWs4kYc49Sgjx2+TO08PkWQazNWz
 yJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782738810; x=1783343610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2jO0e8rIhKLjhW5IYHunqKRgXza1ukawimSTttXDmgI=;
 b=KGixe3VFix3yUen3R42qVf/FrHMtpMNZJ+ZBHuzH6htN4sLNKCcA5W/n+7L47vptyS
 L83GMCAX/mqdUVhXPvRq1eNYz+s/nz1trCbhdUhSbYUT+rlNbatbmb+YOM0Z88Oy8ndZ
 4BDmef8SSFCTCHga7GRMlKfQBQ9mdHxJHzI4jFR0DLsK3EOEPLHwMdCunnZoh0fuWUTR
 CarKp4PUv9JEwTxARSUliN/XR45oGYw3Crqdc6ilZkQ/VIV4kmPYthR+zwN9uAIwZnEI
 wtiYiI0usZrD3Q5grvoBStpMwfq6S33RWPNYjrYG1YQd89/kMCDWpgr728TUroLcD/dO
 LWYQ==
X-Gm-Message-State: AOJu0Yz9H3sTvMjQuB8+y0C/dcdTl0eiKfivo3w4bRRexFZJAO1Aiv/k
 5P83KmQKypbn0KlQbf0CTl1NaoTsKYOvJRQe9dUx7iMUgbqz2VnY1RAnGM0knwDqku60H5qDbPQ
 3OuCjGMzPFbhxFaHYpWlz1GZDf9aenrfNLm0Th200v0tOl5sx3Zc2IC1cGbkYW1+f+A==
X-Gm-Gg: AfdE7clflBcw859/cpCu4qtKHtNnea6mT8Yr2A3/IjHZZRdDJdpGs2fPpuVPOT+6O1t
 MZf90Pcx5wsY+KNmFRDSxn97xoQ+otKZnifVoRRaV5VfvzyhMsR4dvt3yQVxib3x8isd2nL4eF6
 BKoRWrfQc1YtPxHe/6wSahJT20kLVn978iO9bP7x67UhU91GXxoY5E0BP8fGeZvS6VIMqf2supt
 kbWJVB0e+5g0EQZOS55uysFSyPwP6Ry5CurYVj3R1XREdxD6gZBa8KOLB15HzSvcJ0xEjnruulj
 hBOIcYmidvtI69hNPZF5MhxGqGnvK+eHnV4PXcEEop3kze7N3hMPGIREB4YiwuDPtjXzmovTaTG
 DIPTlIo5NZkMyefzadEw4iu0F9RWNKIhqWsgkJE5GvHuAtaPq+ZGMC1ilFcw=
X-Received: by 2002:a05:7023:b0c:b0:138:14dd:16ba with SMTP id
 a92af1059eb24-13b22714f85mr393644c88.38.1782738810284; 
 Mon, 29 Jun 2026 06:13:30 -0700 (PDT)
X-Received: by 2002:a05:7023:b0c:b0:138:14dd:16ba with SMTP id
 a92af1059eb24-13b22714f85mr393621c88.38.1782738809762; 
 Mon, 29 Jun 2026 06:13:29 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139e78317f3sm28459106c88.9.2026.06.29.06.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:13:28 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 31/77] target/hexagon: Add TCG overrides for rte, nmi
Date: Mon, 29 Jun 2026 06:11:46 -0700
Message-Id: <20260629131232.2487780-32-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: x9Gmg7yzIQ-_j6XyvIODIQzNTncLNzao
X-Authority-Analysis: v=2.4 cv=Z4Hc2nRA c=1 sm=1 tr=0 ts=6a426f7b cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=QG2uPxDT_WX1JUO730YA:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfXyeJGQ7P7NLiG
 lWGzzMoOe+3YZEXqr3mquGU+zfgAigZWb2szHRdhNt0vrirYqYLeN+jQifZfscyU0hXl4JhCq2V
 t8Bk3vmFs7aEwKzEMK57cBMy7AG4Fec=
X-Proofpoint-GUID: x9Gmg7yzIQ-_j6XyvIODIQzNTncLNzao
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX4waxq2Td/Xb9
 Y4ZU3TMpxYjDF0HFVi/+fLzJ1FVK/hD7qqI3Ko43QJQfkXkCguDbXpZoSoFVYwqz33fGw71INdO
 FeflrwprOrmyvSybSB79jIyeq9dmV7B3OOcAAQg8R7nRetFfja7QoqtPTXYMuomXcanSezr6iHb
 wuwg+WfmUIM3V4XGstK/JzR0ACg5KgeLFu60xqi42JZ9fWspTQ3htQEl0wO/++/RWvnSHKk3f1B
 NztnQ/ZZwiTluGa44ac4dKzG3vhP12q0mKqm1N0xBPPrOf8b0o3dYLhUAXparE2kLp/qqaP2zsV
 kxzAzWaOCJA/dBe2Q3rsnW52W8WGsPQlroSFgeJBn5m9bKbfKAiDoZG7GuQgaMQbXHVEJsdOs8g
 w7HA7cMpyjb/bp0kgo3Q1zJ71XUh4vd5PUPv0LXwLAt9oQ5ZYlg0spr8gr1ByO45WNbuFbuJsOg
 ZqTBPN+7ZylQuXIKd7Q==
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2dl
bl90Y2dfc3lzLmggfCAxNiArKysrKysrKysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9oZWxwZXIu
aCAgICAgIHwgIDMgKysrCiB0YXJnZXQvaGV4YWdvbi9zeXNfbWFjcm9zLmggIHwgIDMgKysrCiB0
YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAgIHwgIDYgKysrKysrCiA0IGZpbGVzIGNoYW5nZWQs
IDI4IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5
cy5oIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMuaAppbmRleCA4NjUwZjY0YTZkNC4uMjY0
ZWEwMjc1MmQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfc3lzLmgKKysrIGIv
dGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMuaApAQCAtOTUsNCArOTUsMjAgQEAKICAgICAgICAg
Z2VuX2hlbHBlcl9zdG9wKHRjZ19lbnYpOyBcCiAgICAgfSB3aGlsZSAoMCkKIAorLyoKKyAqIHJ0
ZSAocmV0dXJuIGZyb20gZXhjZXB0aW9uKQorICogICAgIENsZWFyIHRoZSBFWCBiaXQgaW4gU1NS
CisgKiAgICAgSnVtcCB0byBFTFIKKyAqLworI2RlZmluZSBmR0VOX1RDR19KMl9ydGUoU0hPUlRD
T0RFKSBcCisgICAgZG8geyBcCisgICAgICAgIFRDR3ZfaTMyIG5ld19zc3IgPSB0Y2dfdGVtcF9u
ZXdfaTMyKCk7IFwKKyAgICAgICAgdGNnX2dlbl9kZXBvc2l0X3RsKG5ld19zc3IsIGhleF90X3Ny
ZWdbSEVYX1NSRUdfU1NSXSwgXAorICAgICAgICAgICAgICAgICAgICAgICAgICAgdGNnX2NvbnN0
YW50X3RsKDApLCBcCisgICAgICAgICAgICAgICAgICAgICAgICAgICByZWdfZmllbGRfaW5mb1tT
U1JfRVhdLm9mZnNldCwgXAorICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2lu
Zm9bU1NSX0VYXS53aWR0aCk7IFwKKyAgICAgICAgZ2VuX2xvZ19zcmVnX3dyaXRlKGN0eCwgSEVY
X1NSRUdfU1NSLCBuZXdfc3NyKTsgXAorICAgICAgICBnZW5fanVtcHIoY3R4LCBoZXhfdF9zcmVn
W0hFWF9TUkVHX0VMUl0pOyBcCisgICAgfSB3aGlsZSAoMCkKKwogI2VuZGlmCmRpZmYgLS1naXQg
YS90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaCBiL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oCmluZGV4
IDY4MmYwYzZjMjZlLi4wZWMzYTA5OWNiNiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaGVs
cGVyLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vaGVscGVyLmgKQEAgLTEyNyw0ICsxMjcsNyBAQCBE
RUZfSEVMUEVSXzIoc3RhcnQsIHZvaWQsIGVudiwgaTMyKQogREVGX0hFTFBFUl8xKHN0b3AsIHZv
aWQsIGVudikKIERFRl9IRUxQRVJfMih3YWl0LCB2b2lkLCBlbnYsIGkzMikKIERFRl9IRUxQRVJf
MihyZXN1bWUsIHZvaWQsIGVudiwgaTMyKQorREVGX0hFTFBFUl8xKHJlc2NoZWQsIHZvaWQsIGVu
dikKK0RFRl9IRUxQRVJfMyhtb2RpZnlfc3NyLCB2b2lkLCBlbnYsIGkzMiwgaTMyKQorREVGX0hF
TFBFUl8xKHBlbmRpbmdfaW50ZXJydXB0LCB2b2lkLCBlbnYpCiAjZW5kaWYKZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL3N5c19tYWNyb3MuaCBiL3RhcmdldC9oZXhhZ29uL3N5c19tYWNyb3Mu
aAppbmRleCA0ZGU0ZDUzODIzYS4uZThiYmVhZGZkZmIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhh
Z29uL3N5c19tYWNyb3MuaAorKysgYi90YXJnZXQvaGV4YWdvbi9zeXNfbWFjcm9zLmgKQEAgLTIz
Niw0ICsyMzYsNyBAQAogCiAjZGVmaW5lIE5VTV9UTEJfUkVHUyh4KSAoaGV4YWdvbl90bGJfZ2V0
X251bV9lbnRyaWVzKGVudl9hcmNoY3B1KGVudiktPnRsYikpCiAKKy8qIE5NSSByb3V0aW5nIG5v
dCB5ZXQgaW1wbGVtZW50ZWQ7IFk0X25taSBpcyBhIG5vLW9wIGZvciBub3cgKi8KKyNkZWZpbmUg
ZkRPX05NSShUSFJFQURfTUFTSykgZG8geyB9IHdoaWxlICgwKQorCiAjZW5kaWYKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVy
LmMKaW5kZXggYzYyMGE1Yjg2MzYuLjJjZDdmNDhlYTJmIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4
YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAtMTQ4
MCw2ICsxNDgwLDEyIEBAIHZvaWQgSEVMUEVSKHNldHByaW8pKENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCB0aHJlYWQsIHVpbnQzMl90IHByaW8pCiAgICAgZ19hc3NlcnRfbm90X3JlYWNo
ZWQoKTsKIH0KIAorCit2b2lkIEhFTFBFUihwZW5kaW5nX2ludGVycnVwdCkoQ1BVSGV4YWdvblN0
YXRlICplbnYpCit7CisgICAgQlFMX0xPQ0tfR1VBUkQoKTsKKyAgICBoZXhfaW50ZXJydXB0X3Vw
ZGF0ZShlbnYpOworfQogI2VuZGlmCiAKIAotLSAKMi4zNC4xCgo=

