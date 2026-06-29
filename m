Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D92C44500
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we3A0-0002dg-W5; Sun, 28 Jun 2026 23:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39x-0002FF-LC
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39v-0006NQ-GN
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:49 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T2cteO1504331
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T4QeLlBFUTpGlmsbriWoI9s9TWXslg2oBf/G9cVJFSw=; b=HImFqgaxv+pakoTD
 zzfGMhtAPWdsXmiUP6lxVEDlTJO+1AXZNFrNtDLM+u2k50pGhejb3FT0ARINu1HQ
 QHM1mIM583cRYUmVPl5lR/AbSeuO6x7BS/fqVP5ccW6JUv3ejWqby7WgOfzcfvrr
 eUc6GNKwjrJI+2vvF8E+HmRQUrSNiPrnsoc2IfPQAgVCi49zkmwlht449D/dZIo4
 tCKXMGAyqkkQbOLHsCj8tSDvmop1ofec4LZfUdGp4kJijkS32Ezjrl1t6D2vCenq
 IWDKpPQFDZ0SQM1qe87nemMjHPyuHusQ6m3oy2Nbvr1IjBe8qUNue1DcG7YdpmIw
 KDJZdw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27t7v838-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:36 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-139b62317d0so12014467c88.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 20:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782705575; x=1783310375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T4QeLlBFUTpGlmsbriWoI9s9TWXslg2oBf/G9cVJFSw=;
 b=HMLtoKia0MWGx8bECTvt4dvjNCCllqRVwA1yFfyJ+nJ+wALR5il1hPzXd6ScXeagnW
 LRBN9Avejx8MBAg69OwnFEsBcpyCEnwbTSpi9ybW5g4HoNXskKKBWGMNcthwhNtY25cW
 05F5aDNcmrPXGRhWJvOCtm1i3GqXHXosKhw1iYSI2l/0xI686FN3OmbT57M1R8FJdgw0
 roMx6fjwzHDf1XSDAUoZy/mLxHmtg60MAT5DGeSotgl4POhxx6ROF71h8OjaWlCTfioI
 ZbCyf91acnUJLaC/+auRz05f3GIDbCQSvn7HI+M5KtolBAdF/VLjho5Kn+OIDFCzfNpB
 NCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782705575; x=1783310375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T4QeLlBFUTpGlmsbriWoI9s9TWXslg2oBf/G9cVJFSw=;
 b=GtR2NGPjqUZrQ7snrZ6CF40P69PtEJdTCFZk4zLiLmiRnRr2y1qOd1Bw3uiycWz3/3
 4yEXzukO2+DdxrNLyZGQ7CT5DYukMT6uuTM9YbEzpf3pyZVS8pmbKMKgqlpBDE0MSjFj
 GOIfIMk3HlJDK+wFM3gzd+0moyju3v8Pa5/lp+K9QvEDQ7DFTNLwKfqRm/ksrupAV7+N
 l7a6rExOa4ge73y1vGT7rJvUk3M3M9PZ4itqkAWw6yN8cJ6NK/oi8KUGOZU1glYD8eq5
 XUVWHl/dQXC4irUCgtjM4nwsHZgD1mXutrqqiCjuxlxRNPYbWIqsSGbm7Qd3D6WgNgUL
 QlYw==
X-Gm-Message-State: AOJu0YzupIoibApSeSqx2GmloNBKKg4yVeIHbRPWPinwvWfCv7ygHuvN
 OtVr85ikt4+53xla4jyQijQcoTwKiiU3d18cgz+nAAYYs7PYFQw0FZJ6Tw5SBiimNKS0uJ5iOEa
 K7eGdMKhhzDInI/2OddzMNRNcawrUwSVyO/jmFnncRbiIEQxVCsY0yH60/EEumuGbPg==
X-Gm-Gg: AfdE7ckzRnGTD5jwYv07Ou+BdM4mDCxeFqjuUV/JoFVzwfenkCrSN+WT+9VfqNUUjJx
 7yiBvypuc7MMnDAfdcOqK5s8/htbcPB1S+qyj+cr44mOfcJOXbU0godX7KKerhYlbChSF2CvKxg
 /8I85ic9iZeZJRMckqpI9fOXYqoiqYjZ7Myz+DkiQowgbXYmBwfoBIPbxkcwmJgzTpEwKIh2RB6
 6LsUhpOgAab+4KcM2Tfht+CSaBOf8kvAHaBdSfu0IpbvipdbhwokrsCVGqDeTuRXET6pHV/4OIQ
 13tZ1RxnheraakCx1M3Aq/CcjuRwvjejGYF72/UjF1KsKjEWJddWvjd1G7/WG56fM+kzActmcaT
 TQipzJmOGETAzQw5wOYDcPsAmgvOyfY0UWgRDQ1soXtDZWZWxtqdWksG6Rk0=
X-Received: by 2002:a05:7022:6726:b0:134:df7f:910d with SMTP id
 a92af1059eb24-139dbaa7145mr12695118c88.7.1782705575513; 
 Sun, 28 Jun 2026 20:59:35 -0700 (PDT)
X-Received: by 2002:a05:7022:6726:b0:134:df7f:910d with SMTP id
 a92af1059eb24-139dbaa7145mr12695107c88.7.1782705574989; 
 Sun, 28 Jun 2026 20:59:34 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139fc2ebcc0sm8367088c88.14.2026.06.28.20.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 20:59:34 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 37/77] hw/hexagon: Declare hexagon TLB device interface
Date: Sun, 28 Jun 2026 20:57:50 -0700
Message-Id: <20260629035830.1520296-38-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfXy/XG4+OGXbUc
 dGmC8Sdol1cXhO02LlUy8sM6y/RN6vMWtTWJ7XuV3DgtL9wAGI7dJ/uGC55BedxXsh4ivmVbwPo
 i3GBfKGV6/IDlfqdPWDhjnUZ1Ybd2FGN3ntmaM/Cih1RiN0Zagc6LCiujoyE6heH9CF2kro7kHa
 jIDHvSYOdIuzHa9Eu9hWkfK0zpanwA5cMIYz8Dz1Fo4XzPdW3lErwVa9m8pJmqw7b8k/ng2uNhQ
 JTIF40zd4HmoVKEpVmtbnVj+f9aWx1udUrMDyliTQBO9W+Umvbm+EKPi77fAnnXY3biy7fsZ4Ea
 R7ptr+JmrZhqzwiuXwNTLt8sChlK6u6j+Pg4jVE+sW9kvx2rfwgCO1+gx9TBNQgr371vKQfyinH
 KEp65lvGpTCiStUdJStHSobRy0Ya+ZlwEDaF/CHdgzq51ODSSDIIngiE85VCS316e+xusV5cQdh
 hIODB8sQlH1vfRETpkQ==
X-Proofpoint-GUID: ESr1qZPPw3zrrzzv3oYUWEa5rQAORbzS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX4VxH2CDRdxN6
 /9vhFhdHC/jmNbesKke/IGIQrAjJ1Z4xDSKUrv0fxI0hb2sbbMLRsAHRZq2BpjmBWqH/CZOAtxm
 w9o6ee1JTuzvlTFAKF1jCjT7/9F/TeM=
X-Proofpoint-ORIG-GUID: ESr1qZPPw3zrrzzv3oYUWEa5rQAORbzS
X-Authority-Analysis: v=2.4 cv=BdnoFLt2 c=1 sm=1 tr=0 ts=6a41eda8 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=p_7iY2stt2bzV07uMJkA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290031
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

QWRkIHRoZSBoZXhhZ29uIFRMQiBkZXZpY2UgaW50ZXJmYWNlIGhlYWRlci4KClJldmlld2VkLWJ5
OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNp
Z25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0t
CiBpbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbl90bGIuaCB8IDQ2ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNDYgaW5zZXJ0aW9ucygrKQogY3JlYXRl
IG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uX3RsYi5oCgpkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb25fdGxiLmggYi9pbmNsdWRlL2h3L2hleGFnb24v
aGV4YWdvbl90bGIuaApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uOTBk
OWVkODQwNDMKLS0tIC9kZXYvbnVsbAorKysgYi9pbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbl90
bGIuaApAQCAtMCwwICsxLDQ2IEBACisvKgorICogSGV4YWdvbiBUTEIgUU9NIERldmljZQorICoK
KyAqIENvcHlyaWdodCAoYykgUXVhbGNvbW0gVGVjaG5vbG9naWVzLCBJbmMuIGFuZC9vciBpdHMg
c3Vic2lkaWFyaWVzLgorICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0
ZXIKKyAqLworCisjaWZuZGVmIEhXX0hFWEFHT05fVExCX0gKKyNkZWZpbmUgSFdfSEVYQUdPTl9U
TEJfSAorCisjaW5jbHVkZSAiaHcvY29yZS9zeXNidXMuaCIKKyNpbmNsdWRlICJxb20vb2JqZWN0
LmgiCisjaW5jbHVkZSAiZXhlYy9od2FkZHIuaCIKKyNpbmNsdWRlICJleGVjL21tdS1hY2Nlc3Mt
dHlwZS5oIgorI2luY2x1ZGUgIm1vbml0b3IvbW9uaXRvci5oIgorI2RlZmluZSBUWVBFX0hFWEFH
T05fVExCICJoZXhhZ29uLXRsYiIKK09CSkVDVF9ERUNMQVJFX1NJTVBMRV9UWVBFKEhleGFnb25U
TEJTdGF0ZSwgSEVYQUdPTl9UTEIpCisKK3N0cnVjdCBIZXhhZ29uVExCU3RhdGUgeworICAgIFN5
c0J1c0RldmljZSBwYXJlbnRfb2JqOworCisgICAgdWludDMyX3QgbnVtX2VudHJpZXM7CisgICAg
dWludDY0X3QgKmVudHJpZXM7Cit9OworCit1aW50NjRfdCBoZXhhZ29uX3RsYl9yZWFkKEhleGFn
b25UTEJTdGF0ZSAqdGxiLCB1aW50MzJfdCBpbmRleCk7Cit2b2lkIGhleGFnb25fdGxiX3dyaXRl
KEhleGFnb25UTEJTdGF0ZSAqdGxiLCB1aW50MzJfdCBpbmRleCwgdWludDY0X3QgdmFsdWUpOwor
Citib29sIGhleGFnb25fdGxiX2ZpbmRfbWF0Y2goSGV4YWdvblRMQlN0YXRlICp0bGIsIHVpbnQz
Ml90IGFzaWQsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgVkEsIE1NVUFj
Y2Vzc1R5cGUgYWNjZXNzX3R5cGUsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHdhZGRy
ICpQQSwgaW50ICpwcm90LCB1aW50NjRfdCAqc2l6ZSwKKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpbnQzMl90ICpleGNwLCBpbnQgKmNhdXNlX2NvZGUsIGludCBtbXVfaWR4KTsKKwordWlu
dDMyX3QgaGV4YWdvbl90bGJfbG9va3VwKEhleGFnb25UTEJTdGF0ZSAqdGxiLCB1aW50MzJfdCBh
c2lkLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IFZBLCBpbnQgKmNhdXNl
X2NvZGUpOworCitpbnQgaGV4YWdvbl90bGJfY2hlY2tfb3ZlcmxhcChIZXhhZ29uVExCU3RhdGUg
KnRsYiwgdWludDY0X3QgZW50cnksCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50
NjRfdCBpbmRleCk7CisKK3ZvaWQgaGV4YWdvbl90bGJfZHVtcChNb25pdG9yICptb24sIEhleGFn
b25UTEJTdGF0ZSAqdGxiKTsKKworYm9vbCBoZXhhZ29uX3RsYl9kdW1wX2VudHJ5KE1vbml0b3Ig
Km1vbiwgdWludDY0X3QgZW50cnkpOworCit1aW50MzJfdCBoZXhhZ29uX3RsYl9nZXRfbnVtX2Vu
dHJpZXMoSGV4YWdvblRMQlN0YXRlICp0bGIpOworCisjZW5kaWYgLyogSFdfSEVYQUdPTl9UTEJf
SCAqLwotLSAKMi4zNC4xCgo=

