Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60857C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:03:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we39X-0001eP-SO; Sun, 28 Jun 2026 23:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39V-0001dg-FM
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39T-0006FU-VP
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:21 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T2d7JN1519190
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=AWqgRF4Ibw8S5E/4OIgHvd5Hhd9R0yIZ8RFAsz/XZEg=; b=jT
 AqHSCa0FTDQUVFpJEjjYXfX/b5+NY6miQPh1+oOhksMA1ab8NVTB2JyGz+uRxt5M
 6gg26izhmGg5NyZQcv+CgCbw5vkEHVBD/VWsKlAn+hSF1XoQxgRPAJrYVWrvqKam
 BTglUJ3QA83PQXG3cohErFTJ++h8gE0t/G9LuOybP5Pv/UNxwX7HjIEk0TDGIDwA
 CGd+HjkhM6YQ4yTIiT9hW4kTpeI7EplBlcWNjtY9q0pZJFPLx1Ns50ESlTe9whgI
 wMf6DbZpBVsKAcLwHMnFz8pJrycdjOzbgWpE1UvoUYTUZISFjejIm9RV6YJr6rna
 +OKzhxojnIduLgtrQ8Sg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f2734cdd8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:08 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-139c98d7bf4so2359710c88.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 20:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782705548; x=1783310348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AWqgRF4Ibw8S5E/4OIgHvd5Hhd9R0yIZ8RFAsz/XZEg=;
 b=PhatmYissGNxOoeSlxJfqFRUV+BLmdQq6dPdONQI5E+tRrkPelb1aJo3rNSW5eWtTT
 MHGcxkO/7vIE0xaOGYSeNEyaKzH3S7BK/639iD416QJgLscAtkpJBN1ErlvFeLRmAMvZ
 0QkCkcpinibWuhwNIDDHw2v+STdo9d6zYGJjNb4u2Bbd0as8QxGRHbnnrxYzZQjOA+0j
 KhzwsCulsO0OJlpEb7kC5LzfUT5E90pow5ULSSKJTsWMdtKiSg8/wrZe45YR75B+CStM
 0tPBGXZ5S6wTGNMSmz0CFt6dOOJ/Fd85ArbpiUgAZu1tCpHg4Nzl8ZSJRHF05E6nFssB
 dUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782705548; x=1783310348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AWqgRF4Ibw8S5E/4OIgHvd5Hhd9R0yIZ8RFAsz/XZEg=;
 b=jWOfKPhpz26TfvMJ9r2vUxVLdo08h6BBFWJEo5N99Og+w+DFQ2I7xs9BlQbyrGTig8
 TXHxo7Figj7LOuvpcegpDikMd7ehRhgDKFtqkDIvdjdZCk876Ka0dsIJ79bN372RatEJ
 0AcKwAQS6a0GCns1ukJXyJPvVU59EF65e2c5U/M2FGEpVFEVE+kgzl223lhreyRcv6VI
 A9eAr8p59yz0FatLyVB1cNHK0i+I5XlPjDyrgLlPmLFV5BzDjujZjZyn5VUNHGjUwYWP
 WoE6YUBWoLfhuCp8f2Asy1vxDIcxZ76FuZoY61S4ol7QZNrCPlJQnjg06qYdCfBUKf+p
 4KrQ==
X-Gm-Message-State: AOJu0YylmuiFYTyvYZvntumEUKXQUfM5QKGbhIUBirYkEQE8eM8Hx4Oa
 aog2CDnwQrIihnVAekXjYLgE+R1xT3kZ9WxQ8Udhou0rminDPwSqWcc22a/isEcUQ8naFtZXeqZ
 dsWrN76hugL/SKFydmNFOCym/hULbjL9DeS5DAW4JXxqZDNV6c0ok8xImZHebiSAqGg==
X-Gm-Gg: AfdE7clTFJODXpFwJN9qBc76fO7Bn1ueV5Ds9UJoreBr1+VOoRSzOrifvzf2JgLAy0V
 mtZAzYr3s/lxlOYNM3Y3Mbx6AE6xWr/3KqrEkSs57ZltoJHK9MBkB/glCkvv5EEI1m/T/N2msRX
 3b2Ojt2aKm4qZl4+2M90CO7Lr2XU4LBd26M6v8SS810jeNRPvcx49qNobP94L4DnC0xvcj6A9CF
 n9Oa3zU5auKU1wqp+4YyxRRZTW+1gll2K2dRQxxJveX0fA4kvrGSpajYi5ra/WcIbXFdjWovuyc
 ROLp5tjw9vFA/9lcqxRObRBsJZnLS0aH3X2y7KMAaTDGI3fU7TURxhwOCrFpI881p/aeinzTWQ1
 Rxdcb/WEDEktWwksE++oEN4wxrTzUMqG00mBqyTTv/pQ7+Cys87C7C23EdIA=
X-Received: by 2002:a05:7022:98f:b0:12a:8122:24a9 with SMTP id
 a92af1059eb24-139c3d0958amr17971191c88.22.1782705547591; 
 Sun, 28 Jun 2026 20:59:07 -0700 (PDT)
X-Received: by 2002:a05:7022:98f:b0:12a:8122:24a9 with SMTP id
 a92af1059eb24-139c3d0958amr17971165c88.22.1782705547099; 
 Sun, 28 Jun 2026 20:59:07 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139fc2ebcc0sm8367088c88.14.2026.06.28.20.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 20:59:06 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 16/77] target/hexagon: Add TCG values for sreg, greg
Date: Sun, 28 Jun 2026 20:57:29 -0700
Message-Id: <20260629035830.1520296-17-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: hntDn5WZaqeJD35xECM7oiH8OVBOzdWz
X-Proofpoint-ORIG-GUID: hntDn5WZaqeJD35xECM7oiH8OVBOzdWz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfXxBfZyUjgwXzc
 S0e+vyP4HJI/4AIML8ghz+M7Dp0HZzHNCeeZxRYfp5ZYHpu9fuuYy415S556pW1IFtNUUBHTXVH
 GZnitZD67UvvjR5l/rrP7bNKeva44gs=
X-Authority-Analysis: v=2.4 cv=HYokiCE8 c=1 sm=1 tr=0 ts=6a41ed8c cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=8kp5zrIFwsha1M26KQwA:9 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfXwhkCehPuJTj1
 aqSStMwByPxML3AntwM3qywpyxJ4lSGY5qAiU1Ao6uONZ+joEMVFZdi+j51K5qbkDjyA9UQSfRl
 x4C1JnibgEl3B/aebmgMPW3XGsX9lyifnbh0OjCnRUBqnHPAbpgZxXfEH0TlJSjgWxtLkqt08ld
 509JWXc3IsucDC8R0ce+vgXZqLit6TZnVdeSe6Qo8NQalHfkt5W9Sj63NGbXHex7T6VdCLg4KCJ
 rd+4ZdUX1QY0VF7xlZSdPDy7WSt2kD3N5p+uttCh6W0GGoPOhM4MWBTHf3NZxOuEWJStoJq1stC
 OblxPdb4q56uGympikiSse8kh/z9sRSekWcj4dO1K5maFG8xwu8j2Gbodvg1jaAi+9iFl1QrqpT
 DFaXXCpmQO5RLII0nQ2OcRKhY9fIg31VrYB5Q1mhuuhF7wkpGyezk6D12nvXF3w8Vs6TBVUHfzX
 cLJ/LlzcAHKZ56l9yQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290031
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
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5oIHwgIDUgKysrKysKIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIHwgMTYgKysr
KysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspCgpkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmggYi90YXJnZXQvaGV4YWdvbi90cmFuc2xh
dGUuaAppbmRleCBkODBiYzUzMmUyNC4uZDhlZWE1NjE5MWQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9o
ZXhhZ29uL3RyYW5zbGF0ZS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCkBAIC0y
ODIsNiArMjgyLDExIEBAIGV4dGVybiBUQ0d2X2k2NCBoZXhfbGxzY192YWxfaTY0OwogZXh0ZXJu
IFRDR3YgaGV4X3ZzdG9yZV9hZGRyW1ZTVE9SRVNfTUFYXTsKIGV4dGVybiBUQ0d2IGhleF92c3Rv
cmVfc2l6ZVtWU1RPUkVTX01BWF07CiBleHRlcm4gVENHdiBoZXhfdnN0b3JlX3BlbmRpbmdbVlNU
T1JFU19NQVhdOworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCitleHRlcm4gVENHdl9pMzIgaGV4
X2dyZWdbTlVNX0dSRUdTXTsKK2V4dGVybiBUQ0d2X2kzMiBoZXhfdF9zcmVnW05VTV9TUkVHU107
CisjZW5kaWYKKwogCiB2b2lkIGhleF9nZW5fZXhjZXB0aW9uX2VuZF90YihEaXNhc0NvbnRleHQg
KmN0eCwgaW50IGV4Y3ApOwogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUu
YyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IGQ2MTY1OGE3OThjLi45Nzg0OWFi
ODYxYSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0
L2hleGFnb24vdHJhbnNsYXRlLmMKQEAgLTY2LDYgKzY2LDggQEAgVENHdiBoZXhfdnN0b3JlX3Np
emVbVlNUT1JFU19NQVhdOwogVENHdiBoZXhfdnN0b3JlX3BlbmRpbmdbVlNUT1JFU19NQVhdOwog
CiAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKK1RDR3ZfaTMyIGhleF9ncmVnW05VTV9HUkVHU107
CitUQ0d2X2kzMiBoZXhfdF9zcmVnW05VTV9TUkVHU107CiBUQ0d2X2kzMiBoZXhfY2F1c2VfY29k
ZTsKICNlbmRpZgogCkBAIC0xMDg0LDYgKzEwODYsMjAgQEAgdm9pZCBoZXhhZ29uX3RyYW5zbGF0
ZV9pbml0KHZvaWQpCiAKICAgICBvcGNvZGVfaW5pdCgpOwogCisjaWZuZGVmIENPTkZJR19VU0VS
X09OTFkKKyAgICBmb3IgKGkgPSAwOyBpIDwgTlVNX0dSRUdTOyBpKyspIHsKKyAgICAgICAgICAg
IGhleF9ncmVnW2ldID0gdGNnX2dsb2JhbF9tZW1fbmV3X2kzMih0Y2dfZW52LAorICAgICAgICAg
ICAgICAgIG9mZnNldG9mKENQVUhleGFnb25TdGF0ZSwgZ3JlZ1tpXSksCisgICAgICAgICAgICAg
ICAgaGV4YWdvbl9ncmVnbmFtZXNbaV0pOworICAgIH0KKyAgICBmb3IgKGkgPSAwOyBpIDwgTlVN
X1NSRUdTOyBpKyspIHsKKyAgICAgICAgaWYgKGkgPCBIRVhfU1JFR19HTEJfU1RBUlQpIHsKKyAg
ICAgICAgICAgIGhleF90X3NyZWdbaV0gPSB0Y2dfZ2xvYmFsX21lbV9uZXdfaTMyKHRjZ19lbnYs
CisgICAgICAgICAgICAgICAgb2Zmc2V0b2YoQ1BVSGV4YWdvblN0YXRlLCB0X3NyZWdbaV0pLAor
ICAgICAgICAgICAgICAgIGhleGFnb25fc3JlZ25hbWVzW2ldKTsKKyAgICAgICAgfQorICAgIH0K
KyNlbmRpZgogICAgIGZvciAoaSA9IDA7IGkgPCBUT1RBTF9QRVJfVEhSRUFEX1JFR1M7IGkrKykg
ewogICAgICAgICBoZXhfZ3ByW2ldID0gdGNnX2dsb2JhbF9tZW1fbmV3KHRjZ19lbnYsCiAgICAg
ICAgICAgICBvZmZzZXRvZihDUFVIZXhhZ29uU3RhdGUsIGdwcltpXSksCi0tIAoyLjM0LjEKCg==

