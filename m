Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3148C44500
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCIP-0004NC-IC; Mon, 29 Jun 2026 09:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHg-0003js-Hm
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHf-0006Gt-2c
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:24 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT2ca2646893
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3UuTOFdc8oYjbXiuLSyd2e3M5N5lZKNz6xk5uPNFpGs=; b=KktI+X9EWRfo1Fgb
 qoHC1GWbU0YIHNRUdAXLBGyvhH5RT9i7Etkn6NXbMghsRaKry/7HNqZf7/B6s7a4
 NBYCUd8UmW8xnj2sE7sT+/KNoiXRKsNvexhOTijDRZIZNJ3aT1z9EenccrcaEmbn
 BAlyckkezqKF0Y3GOLpPgtmH0RYfFosp6m1bQS8QxYah7VCcVQefCn9M+kFoB1dj
 LggN9437q6hmtelnmBKptYEdRBR799H1C7fhROpQJg0AKQqSbX6zy+AXiCYgdUSr
 2f6/ToBdwj8I/L+XzJB8OVE5RzDUK5kIa6B8GEdjbUrMpiwqzafgYK8Ntbhwcpgg
 2Q4AeQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3m4tshgr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:11 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c825562f8bso20875865ad.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782740651; x=1783345451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3UuTOFdc8oYjbXiuLSyd2e3M5N5lZKNz6xk5uPNFpGs=;
 b=UwLqMyu5/kyQwHo8VUR42LGRzqg3RceIEtdXs5PHgxEv9c2LqBjoDO/T22ntlewxRU
 PqiOwLkUI+x44pP1vsxA0aAylPg3Slk1/P+2nsZrjRfALcQcZd/s/aTAv/CbjR4r9mXh
 VXJ9gVvhHQ5H80iER1u7CYOOzF88YvVvPZcn7peY7AWhmBqnbX7e3RzRE+ef5ddnMVBL
 gNTZiSZOoeQWcRgktk7mDLr0dwzkK5Z1XTLjxh5l+GybgqIgNbuKKqmhuGnpt7biUO7h
 hrv8POGmz4bNeSyP1Y3Vacei3u3mmLkeiBX4IuGKatjdxTTQWVZba7tFfZ5vumrOvQbi
 0hyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740651; x=1783345451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3UuTOFdc8oYjbXiuLSyd2e3M5N5lZKNz6xk5uPNFpGs=;
 b=dYVnj9XlQNa9dofGbjThf+asV4Vv0GyttAhQrwfbqanlECzjhffl2L2XHPXFdQ5FeM
 U2f4vKEImsHFFhgN66cSBzyP8AdmhvUHedDB67xBFUqvMZD1g64pV6qd1dWyHXIyNx2l
 SnyTVz4w7tXq0c5EKqB4fs28NeHo3mtjnlvT+vHzZzF3v1rauxPd9w0RMz2B9cEDe1At
 uOK4QBIrKnafAqBdaC6enfSYOQ9sbFOGS0BkEptxsJZ5rJ3aFa4zyjcUpho75A4+B1E+
 fH55KuALU/aQCIFQwTp921LF1tf+vokS2y+Pj5vyonxYKagsRwMtOMIoCGPc2UBPczxG
 eXSw==
X-Gm-Message-State: AOJu0YxZaFIWTJmGveH5BB/Yfuk77mou3OjAWu0ku5HoSB7brQvhLjAq
 Deh3vwjRfTI/axoyKznbAHQ86b6LDY36dFb+u5hW49ofpHWQQ41xllUxziS4QHSgjSCu5AVF/J+
 eiPlwRRTORjblq91nHZ2UzV4z+CvCIK0cyL7uMxCleIR9+bCeNBsFm6jOAmTI3gbfqg==
X-Gm-Gg: AfdE7cntzKRASgKxhderkLMKRXYR0qWRjxYd7zURmTr5TrWOpRky1c8LOgf9zar/0hb
 XudKkM6zYm2t4nQU2UIa7uiMNru9pRETrfvTtwLbzHSKm02/+B8vMBY8THriJ6B2joQLzF68bAe
 j9Kn0N75RMhWUoQbqRHU/r9kATNLEMhMbXxe89YEgwWwwLdyA1yJO86cuhe49oE7VPKAGkJ7y1g
 yyVGUvwR9VP9CXGXOInmWK3fc2Bmip/aRID9jBiO7hGrshByLER8ylU7XZobOnIdV8FO+E7/0Zg
 sUBe88CXupnkPNTDaLNhtlD0ZuTvWm8lZom/kYSxT10XCkpLVRvZR+z8uz2axWX+3PC+DVmTuit
 JS5UWXuXX1jJz/4rwiCdNgN9tssAZuwnQwi1KVCzx5YQhQ3XQYZ+Y2BdXtvk=
X-Received: by 2002:a17:903:2f8b:b0:2c8:1c3e:9636 with SMTP id
 d9443c01a7336-2c9860ba606mr92803485ad.25.1782740650877; 
 Mon, 29 Jun 2026 06:44:10 -0700 (PDT)
X-Received: by 2002:a17:903:2f8b:b0:2c8:1c3e:9636 with SMTP id
 d9443c01a7336-2c9860ba606mr92803295ad.25.1782740650395; 
 Mon, 29 Jun 2026 06:44:10 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9b0992227sm48968555ad.37.2026.06.29.06.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:44:09 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 59/77] target/hexagon: Implement modify_ssr, resched,
 pending_interrupt
Date: Mon, 29 Jun 2026 06:12:14 -0700
Message-Id: <20260629131232.2487780-60-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX05EpMaI35OD/
 tylviw0zYrQkoE5+eiScq3ZevWejl7E2nBwD2pakEIGISSMUFoJNsEE/kDS6LB2NfMS3chYoOH/
 GQl6CMRZ9cgzIms820XpPYrv1BVKPDPT9aQDiQwKYT1yabh3VXGYRaNCx1Fktlr3ujWxsWcqTtM
 H3vvTiJv5/Eiy+VAOQwguzYJf0vykqvJ0dSKNc8tEZGRrPK80oAFpL1G4natBLd3cFgQupI1de0
 KCfA8GdmDHdGx/Sf2s3IcbbmxI8US/yWXutGB2klVD2Ml1EOXUiz1Wf/spYvQHNeE5lCmgyVL3B
 X59Whxo3UzNinpsj/euje8tdhHFoDUu9Fe/4f2wQTfgPEsitymCyEWOtwghSlh9IZq7hJ4/sPN2
 fMx4ymK0Hnk81zgxJ8+IGAs3z0qv3Fe/rEVqU5MQ837LFsTjknl2Oo2rlfIPaCbRPA26ji0mZqG
 IlzyKr3+BK80YgXtjqw==
X-Authority-Analysis: v=2.4 cv=R58z39RX c=1 sm=1 tr=0 ts=6a4276ab cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=c5yFZwH1WPb9xS9x6awA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfXzXGmfThAb7Rp
 YoUUIZ1UYpZgg/yBxiy0qJnj5ZjCK9UcEdnvHmZ/BviI8u0vb90igEQZXM9aaaLjPxo5xBNTxXK
 gMwzoDv80d8TV6KeXDxDGQCpklgxGc4=
X-Proofpoint-ORIG-GUID: yZ0F1tT7VWgNKHCzOepIuWomGzkSHu9X
X-Proofpoint-GUID: yZ0F1tT7VWgNKHCzOepIuWomGzkSHu9X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290114
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jIHwgMTQgKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgYi90YXJnZXQv
aGV4YWdvbi9vcF9oZWxwZXIuYwppbmRleCAzYzI1M2IzOTFlNy4uOWZiY2Q3OWM5ZDQgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jCkBAIC0xMjI3LDYgKzEyMjcsMTUgQEAgZmxvYXQ2NCBIRUxQRVIoZGZtcHloaCko
Q1BVSGV4YWdvblN0YXRlICplbnYsIGZsb2F0NjQgUnh4ViwKICAgICByZXR1cm4gUnh4VjsKIH0K
IAorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCit2b2lkIEhFTFBFUihtb2RpZnlfc3NyKShDUFVI
ZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbmV3LCB1aW50MzJfdCBvbGQpCit7CisgICAgQlFM
X0xPQ0tfR1VBUkQoKTsKKyAgICBoZXhhZ29uX21vZGlmeV9zc3IoZW52LCBuZXcsIG9sZCk7Cit9
CisjZW5kaWYKKworCiAvKiBIaXN0b2dyYW0gaW5zdHJ1Y3Rpb25zICovCiAKIHZvaWQgSEVMUEVS
KHZoaXN0KShDUFVIZXhhZ29uU3RhdGUgKmVudikKQEAgLTE2NDgsNiArMTY1NywxMSBAQCBzdGF0
aWMgaW5saW5lIFFFTVVfQUxXQVlTX0lOTElORSB2b2lkIHJlc2NoZWQoQ1BVSGV4YWdvblN0YXRl
ICplbnYpCiAgICAgfQogfQogCit2b2lkIEhFTFBFUihyZXNjaGVkKShDUFVIZXhhZ29uU3RhdGUg
KmVudikKK3sKKyAgICByZXNjaGVkKGVudik7Cit9CisKIHZvaWQgSEVMUEVSKHdhaXQpKENQVUhl
eGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBQQykKIHsKICAgICBCUUxfTE9DS19HVUFSRCgpOwot
LSAKMi4zNC4xCgo=

