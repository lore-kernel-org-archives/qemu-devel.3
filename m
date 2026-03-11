Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CBEFD88F3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Asa-0000z9-Bu; Wed, 11 Mar 2026 00:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AsY-0000y9-5O
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:09:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AsV-00007U-SV
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:09:01 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B2s8wY248601
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oJTXW5xClUnTu7Kz8Ux70TvRHcqnoEazBBycHHZzS5U=; b=WZUC6+t7C3xTZqJo
 hLH0aivyp1xhMIQOBb0mM7uoHCZfJ4DB2ZXdetn9+Zm3NsQ/FBgqYy9zozI0u/9Y
 on63zBxVS2kwgPsyORHZJKJweLaJjQWkzUPd0ztocty4Fe8XjD2svM5K+v31J9I1
 YE/pCFLceJy+gDzwmlYviSLO9tQ4cPk1ZscPKMLPnSIs4e7EOtLmLbqmYtEjRD4/
 ZdbZp71vT+CIDVQxYQtUFQVh39FcWVUkU+NynXpucFJVo9LxjZdqMNkguAiVZMTN
 Gol4k1lHBKSaCmIFRVsvCQbygZAmr9fq8kW0MPTHyb14yupBqcJbxco/cjSvM0kD
 yPbqFA==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqv11sx5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:48 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-409698ea4dbso8254682fac.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202128; x=1773806928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oJTXW5xClUnTu7Kz8Ux70TvRHcqnoEazBBycHHZzS5U=;
 b=a4Rer0cHYLacQnSh1iNWFJT9/iJPNYAQtlXhvszOpEeyJpbfBNG0KvZC1Xpp7900xN
 t9RJ19iRFf7mdXXFAD5rETowU7OR3nAzyj2fEjRtV40o2JrdPI3Pr93s6CtzrtavxXuW
 3knTVj8N0JGT0CvD3Cd4P/GcG5qOWXvc1uORWTssg9c+evH07iiLWODRsRDmQSr7hkjM
 oXElrtjNcFkb4J+khZATZcxP8WYZg8RbhY0t98DVwagd0RCkC1ZVxFUa2Sh7Wo9y/6/K
 rX9R0EgpVdficZADxCqP8Scr0rs1ngeXVAjl1vnog7A7HPWGJVKSgp1SwE8p279rZ+tX
 zGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202128; x=1773806928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oJTXW5xClUnTu7Kz8Ux70TvRHcqnoEazBBycHHZzS5U=;
 b=W12cSz4ecO11lFCNtU+8Z8FvRSRP/EWIHMDoLjAe8Sasop9vVfcsWvauPhShC944tx
 p9SxECgG+mnQosGZH4WgHGq1VWWqDm+tXhMWjkaK26lvjv8l+JkCBkuYg62VvR8SBLZ/
 Z7Ip37d25mNBQKFPEL8l0fcRr78vJhrCvxWOhT4fV740DZvVgeAPMzY61AST57O1KUbl
 7cXhWRuODTNgp9+8bXWtIKDAnfDPTAyEdGlholwFTwCCPFbw0gMikR68AXHQynEtJXGJ
 2ly4zTs+l05ei3rgFVL/Qgsep5yk0aUDT+gpTqDAbEdgZKKnhlHi7x+HKkHQhkgz0rXW
 db6A==
X-Gm-Message-State: AOJu0YyTX/E+kuuqzkXDsCe4la7jihhBbUAUGoAbg6KooKv4IWKycTW2
 ogY7QSZy21nyvxpRPjK8P7pan6F6OCLk+s9XacdHB9fEhslhIX/RjMVTIf2EMhhOBGtKmmu+gZt
 D53dJFshoxpfovNrvxBjEJxt/JAAUlkCMoyFKI/uKsGckrGxkU9/O1bcjGYvNJNsoPw==
X-Gm-Gg: ATEYQzx/nb2tsGC/eF6WgmyETpr0+GAPbFSV+NNfnwqysWILFzQ2JaRnVJKh9NvPubO
 +dMpkbAn5UHs+VNcZHn8nPTiZT2fn986EeOjFlB6NLTW4pnp0K48BISbbewruMyUVqyeTVOZlvH
 Mu/PlJwNqXMidNtk1K5NmKOCQ9QV2xV8X5FCT/Q6z4zzbVBjUgTtUjUycA3paK6xavefh6mmzRh
 0cQiclMUnY9RbzZugtUZlRu2JmfLS36e5eTelOPX5r8Su+UO75pUMsUJoNzw0KkzKUZ/oDafb6u
 7rlda8VClTTNKStZyhaaGlaH50z4SuYrJJrPECHQIz2d5f/63aLp0gHIaH6fmcgUsLFAyE+II2q
 lLqwtmjBTAAvoaqjuXgAy+G4p+L6fvivjMwcckq4/7gfZ04kuPCnpFERtlNiHKjcMWo5EDA==
X-Received: by 2002:a05:6870:d203:b0:40e:a9c5:5c32 with SMTP id
 586e51a60fabf-417568b1e96mr3525606fac.8.1773202128196; 
 Tue, 10 Mar 2026 21:08:48 -0700 (PDT)
X-Received: by 2002:a05:6870:d203:b0:40e:a9c5:5c32 with SMTP id
 586e51a60fabf-417568b1e96mr3525589fac.8.1773202127787; 
 Tue, 10 Mar 2026 21:08:47 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5ea30asm998656fac.10.2026.03.10.21.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:08:47 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Subject: [PATCH v3 31/32] target/hexagon: Add guest reg reading functionality
Date: Tue, 10 Mar 2026 21:07:57 -0700
Message-Id: <20260311040758.1068731-32-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMiBTYWx0ZWRfX20F7JhLHyRyq
 Ez08C7+B2L4tx02nqa88agIs9X/1s5BoqO8St1blXVKDhnUhu31inrcmBoZQUhM2/pySjVd1GNz
 nJnR+9PG9hjqVAgC+3gTeFgVIkPdR+Laq2IASSjFvKsuE4F0yzrbiL1dDAeZ+BfwnaBT3r95K5q
 E1LECt0bZLBW51VZZyJjZcYW/mZ8Y0dAYyYmrJfpHH6SDhHIxGXqEUHOCIPYwpEDnNSDl2GdVRI
 Gw/wqAIYrEXK7GpQbNe1vTdbpy6AaUwus6AzXbcw4EwBb+lwH0Qb1SkwqleJ6qH/IQqJQgEz968
 ZqpHy3gY4yVMFgjJ2YCWesGvd3sA7L9k3j7CkJm1nQhCTnJqzjB6McPsEhNMFjgEPj3G0QbHWv5
 R2Ri+XL1+vgBEz6FwMEeKFXpZZ75nWA500fifUnHfgmrmHsTkTmjaYbRQu6GprBtTWv69jaunXs
 pUflcy3wvUsAPBAGqVQ==
X-Proofpoint-GUID: KjqHCo_GhBuB5XPObC_M4YZ1-b_VIMQ2
X-Authority-Analysis: v=2.4 cv=S5vUAYsP c=1 sm=1 tr=0 ts=69b0ead0 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=XzmyB_kLrSAsql_ziIIA:9 a=QEXdDO2ut3YA:10
 a=eBU8X_Hb5SQ8N-bgNfv4:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: KjqHCo_GhBuB5XPObC_M4YZ1-b_VIMQ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110032
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPHF1aWNfbWF0aGJlcm5AcXVpY2luYy5j
b20+CgpTaWduZWQtb2ZmLWJ5OiBNYXRoZXVzIFRhdmFyZXMgQmVybmFyZGlubyA8cXVpY19tYXRo
YmVybkBxdWljaW5jLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICB8IDIxICsr
KysrKysrKysrKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgfCAxNiArKysr
KysrKysrKysrKy0tCiAyIGZpbGVzIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdv
bi9jcHUuYwppbmRleCBhMTljZGY4NGE5Mi4uZjZhOGIyM2QyOGQgMTAwNjQ0Ci0tLSBhL3Rhcmdl
dC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBAIC03NzAsNiArNzcw
LDI3IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKmMs
IGNvbnN0IHZvaWQgKmRhdGEpCiAjZW5kaWYKIH0KIAorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZ
Cit1aW50MzJfdCBoZXhhZ29uX2dyZWdfcmVhZChDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMy
X3QgcmVnKQoreworICAgIGlmIChyZWcgPD0gSEVYX0dSRUdfRzMpIHsKKyAgICAgICAgcmV0dXJu
IGVudi0+Z3JlZ1tyZWddOworICAgIH0KKyAgICBzd2l0Y2ggKHJlZykgeworICAgIGNhc2UgSEVY
X0dSRUdfR1BDWUNMRUxPOgorICAgICAgICByZXR1cm4gaGV4YWdvbl9nZXRfc3lzX3BjeWNsZV9j
b3VudF9sb3coZW52KTsKKworICAgIGNhc2UgSEVYX0dSRUdfR1BDWUNMRUhJOgorICAgICAgICBy
ZXR1cm4gaGV4YWdvbl9nZXRfc3lzX3BjeWNsZV9jb3VudF9oaWdoKGVudik7CisKKyAgICBkZWZh
dWx0OgorICAgICAgICBxZW11X2xvZ19tYXNrKExPR19VTklNUCwgInJlYWRpbmcgZ3JlZyAlIiBQ
UklkMzIKKyAgICAgICAgICAgICAgICAiIG5vdCB5ZXQgc3VwcG9ydGVkLlxuIiwgcmVnKTsKKyAg
ICAgICAgcmV0dXJuIDA7CisgICAgfQorfQorI2VuZGlmCisKICNkZWZpbmUgREVGSU5FX0NQVSh0
eXBlX25hbWUsIGluaXRmbikgICAgICBcCiAgICAgeyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXAogICAgICAgICAubmFtZSA9IHR5cGVfbmFtZSwgICAgICAgICAgICAgICAg
IFwKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFn
b24vb3BfaGVscGVyLmMKaW5kZXggMzcyMGYyNjc5ZGEuLjQ1NzgxN2IyZTFjIDEwMDY0NAotLS0g
YS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxw
ZXIuYwpAQCAtMTg1NiwxMyArMTg1NiwyNSBAQCB1aW50NjRfdCBIRUxQRVIoc3JlZ19yZWFkX3Bh
aXIpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcpCiB9CiAKIHVpbnQzMl90IEhF
TFBFUihncmVnX3JlYWQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcpCisKIHsK
LSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIHJldHVybiBoZXhhZ29uX2dyZWdfcmVh
ZChlbnYsIHJlZyk7CiB9CiAKIHVpbnQ2NF90IEhFTFBFUihncmVnX3JlYWRfcGFpcikoQ1BVSGV4
YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHJlZykKKwogewotICAgIGdfYXNzZXJ0X25vdF9yZWFj
aGVkKCk7CisgICAgaWYgKHJlZyA9PSBIRVhfR1JFR19HMCB8fCByZWcgPT0gSEVYX0dSRUdfRzIp
IHsKKyAgICAgICAgcmV0dXJuICh1aW50NjRfdCkoZW52LT5ncmVnW3JlZ10pIHwKKyAgICAgICAg
ICAgICAgICgoKHVpbnQ2NF90KShlbnYtPmdyZWdbcmVnICsgMV0pKSA8PCAzMik7CisgICAgfQor
ICAgIHN3aXRjaCAocmVnKSB7CisgICAgY2FzZSBIRVhfR1JFR19HUENZQ0xFTE86CisgICAgICAg
IHJldHVybiBoZXhhZ29uX2dldF9zeXNfcGN5Y2xlX2NvdW50KGVudik7CisgICAgZGVmYXVsdDoK
KyAgICAgICAgcmV0dXJuICh1aW50NjRfdCloZXhhZ29uX2dyZWdfcmVhZChlbnYsIHJlZykgfAor
ICAgICAgICAgICAgICAgKCh1aW50NjRfdCkoaGV4YWdvbl9ncmVnX3JlYWQoZW52LCByZWcgKyAx
KSkgPDwgMzIpOworICAgIH0KIH0KIAogLyoKLS0gCjIuMzQuMQoK

