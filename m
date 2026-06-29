Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B78C43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBoA-0005vd-5B; Mon, 29 Jun 2026 09:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBo8-0005sh-RD
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBo7-0003HN-5S
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:52 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATBAV2647650
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T4QeLlBFUTpGlmsbriWoI9s9TWXslg2oBf/G9cVJFSw=; b=bkEVdnqhX2McVuCw
 sjLvQNO+W5CjoCpmFHjDv3pa4w9rLxQ0Z9dMTr1QaBUKNucEQ1xxhr8rzxGcEdFm
 IbK1ArMyRmaXqeKvBD6EYnbiOkvtEUyExhdbhkdJ5VEB2BtSSkwdc+rRk4NWkfRF
 0+FRmMpv8fme1BI39Zzl6YlTY4QSNVzjlgaXXopTbxS1XDPiDLU9W4oBodYEwKDE
 DU5cZ8ayb/dYV7fRbAboBjno34TDjn9zUq0ijaTjaOYZgtE9Mb9zkX2mMnAZOjwM
 SNPHnDvyz2MSmOKU8xbjQIWEq6UXi4cO6yEvPeR0plMEf1w57hwzErgAHTCW89ET
 C3PVpA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kyjhe6j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:39 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-139871a52c2so4635437c88.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782738819; x=1783343619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T4QeLlBFUTpGlmsbriWoI9s9TWXslg2oBf/G9cVJFSw=;
 b=B2aMW1NBUFWvwptZ1sShUtAcOVxmkOD5oqUlQgGbX1YaGsR+qy0UlSqG3q/OQT37bx
 4mwI1RT+oLU0wmOk7e1Y9jK+EcZK6VcMewa0Pf44xDi3RZncQ245s+v50Is6cz/OFjLP
 c4VFpPqfoU6jw1/33xM/K4lJCIwv9nz4hCtu8LCcYRvrwHY1B2T5hdoRwTXf3uzm6HYg
 dNtgIhr1fvcKxGXsUuEs6iGyPOHnSbEGpyP81IHF2hnwNCnShn86Gv0B3qOTl5NjTVZV
 WwI5Ie0fidbcg/6dPp6F2tVGOqA57lJQs515F0Rl/HjTpyiU1JKLiQcPWumcGMFM+klX
 mukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782738819; x=1783343619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T4QeLlBFUTpGlmsbriWoI9s9TWXslg2oBf/G9cVJFSw=;
 b=J3PVgrr4naXGjgo5mRGN4bJszwxZtGkzKzYOHzMq29t3t1tgHA9E3W8vCPRXfNosGF
 gcJ1KVDAto38ioyxbmhdeXS2tpvCrLy/acuBPaJVcxtCohqFcqEeWZeuhO4uFoTNBrai
 oyfNc30K1pxPZYfwnFYWEAcb6Z1D2hTfGeXfgsrS/zMcrhvGrCgvOzpt7dVdDsEXvEtI
 te6T00khG8L25/5yobaa3FXMD5J8rrxzC3bnKKXoT9+eix7A3qw9uc2Q/XtzPyzD0dLU
 ziqWgoIqAbfLm42m6noUlfHbh6rXpXyhXsJE/waYIlIFMjMvo5F7to0Nvz8hu7L0Sxg+
 IJ5A==
X-Gm-Message-State: AOJu0Yw8je2HfSoDlc9tS8lZBBruIXWLFvjCNDJCuoAhV2IbBK6dm3Z9
 1Dh3iO41UgUu/QbjX+2xBG64z9iiv5z2Rf6I/py02iv7EyKtNrWYggSZ6vHyRTM7Dd7JX4Ww2KS
 B6YEVOR4UonZB+87MwWzaaQI6LMfu07bSQbTKR7okYsBgNTJCR/K4SdVnkxMDVqgbmw==
X-Gm-Gg: AfdE7cncpciZJws8vO5lFx9+H0JgLs+9fXuGl2L3ixsoPtiVMjr+Tpx93J/pBiJME1E
 lZL69lL2eiNmG7JGk3Yd6PMn0bZzfMcsAuwASZMrzYOYL7M0ulxEIq5J5PRhC4jwUwAEUN6W/lm
 JD509hEmyy6+je9NL2iW4yJ3bCemA9foc8njnL4MupgPB9t8sYJHhAfFSff5rng8BQbkbYnVuWw
 h1Bfhq7KprxwLayoenh+nka0fDHLgjcn0QgtO/e3+OQpL20k3UchTbhdVFJzuvfexZkk/8i3vcQ
 Ry4XRAcSoNgqD2FCgzd9bFxNLbvse+/Cz6b81nG5fw3+o+/ABaiA80Xsv/kVJNV0kGAa5PymlXF
 najZUV3l0iPi1WZhgQu51iDd7x7hEMlTT0MwQnbZqrmlCuO9q3NfwHlgpCm4=
X-Received: by 2002:a05:7022:160c:b0:139:d39c:d395 with SMTP id
 a92af1059eb24-139dba38a57mr13447133c88.15.1782738818960; 
 Mon, 29 Jun 2026 06:13:38 -0700 (PDT)
X-Received: by 2002:a05:7022:160c:b0:139:d39c:d395 with SMTP id
 a92af1059eb24-139dba38a57mr13447111c88.15.1782738818447; 
 Mon, 29 Jun 2026 06:13:38 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139e78317f3sm28459106c88.9.2026.06.29.06.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:13:37 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 37/77] hw/hexagon: Declare hexagon TLB device interface
Date: Mon, 29 Jun 2026 06:11:52 -0700
Message-Id: <20260629131232.2487780-38-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: Xv9t4JDcNYkLVeoNAohnOugrDj8vFlzg
X-Proofpoint-ORIG-GUID: Xv9t4JDcNYkLVeoNAohnOugrDj8vFlzg
X-Authority-Analysis: v=2.4 cv=Ftk1OWrq c=1 sm=1 tr=0 ts=6a426f83 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=p_7iY2stt2bzV07uMJkA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX9ISUoyYO0QR/
 t0ijt72qRy4aHbEgGGwmQSFw1Bc0cyR5/eu685qngzUqfXj0hxZHrMcDn0Pwlb+GvoK75nZMkoN
 awSmf6lehhFgUMOZclQwGsAyoLly+qI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX4nuBw8i+g2AJ
 hGZHtkhKP3fcmI1aLaT67EdCjfv6fb8cF2q4ms5UveVvJ0ZKqLDX4JavuImPoC40i5Y7VpPGf0W
 q9EiZRfnr5K7SAUm55+Z0Gkjw/h9Wr+ld82+o4Hcv11sQrcp27a6kUvJm/olE+t7HPv9XdIPxDW
 VrxYyIsgH15DRUKuF53pK68LsnmzU6brWdAbfIOKAZ5ZcC9/YQ/CwnwTHF+KMCnkJhA/AlHRJyO
 h8Tc6avK6RHPaPCbrydFrMfXFisJm0DqRCeuD5zixUEkV3inTgXrQCM7fQFJcXeiENLpSnTq44N
 dXPxS9J0fAPhSQhXjn2BSJFxBGInqtFHJ7t7k1gLqnwGHwAa7rVIxZK2dTQxEXS9sIP48QpSDPy
 Vs2ieQA8/oO6pVbU+KFGHPToz26BFjhyQ7RWNBM4OmUGSmQwJAXWifcXh+m2vg9XQq6fz6rEtXK
 iiXpVZeEhYohHEB/bNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290109
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

