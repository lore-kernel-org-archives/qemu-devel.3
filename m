Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73168C79F91
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 18:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2uqe-0002xy-G6; Sat, 05 Sep 2026 14:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uqS-0002ss-5K
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uqO-0001eG-2z
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:26 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685Hb4XV2449910
 for <qemu-devel@nongnu.org>; Sat, 5 Sep 2026 18:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 H0JUj6zdvcDoUAMBJQhj6Hbt1bI3J7dLysQrguntyf0=; b=NnoPXpb61sL+VFth
 snJEsl5Jl1pNoxqJVhZDnP5kGTaHsc/6fZBTdQDjWWVE+tlcoDk0mVW9NlbSZAeX
 fNfhSOmRXpllNK1w2o98Vgf7c1LIXm64qUl4Wj/jRWYBDJpvPefp3lJJKYheAJgH
 jLBP8vWPl+cRYbO+3jG1Fs1hzgK5wuu1BGgRAH9RIAmLifIGlCUX4eVY+Oz9JTLh
 NHbfQkSeYlZzxtLH+qQAhxJEOKgcCr+D6zpU0eyD6iuOyqMTZXEcvJaqtR+bJYAX
 DjyKYvmn6rBfpfFdDH3yrK1YJFM6anI4g8oRkF7IS/v80x495um7QW8a9uGu9f7O
 2DbRMw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggbuehxg4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 18:10:22 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d02df2bf09so19268535ad.0
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 11:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788631822; x=1789236622; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=H0JUj6zdvcDoUAMBJQhj6Hbt1bI3J7dLysQrguntyf0=;
 b=YfFaVENKMlq4zGg+QAsV2QWKWHssNeGR4kzi8UGIikiOnEsl5KvR3ytfHHrvA9Vu9Y
 ngjwJkD9TA4g/EDmtc3EbaqDuN2v4oqLxI0pq8WQPlJRnfxmIPCA+VYF9RJ3kjmsKHrj
 D5Ov5af2efiUUgGCSbnQJsjoKl2kNNnSKziDYFZR/bk7sTIey5rooo0wkYeVeogW0rLc
 HcCAGTF8exJ2bd6W83h3hVe+aG1XdtTugDH4gN2JdS72s1CQhth61/JuOqXV29DhWnQf
 W8Ir1hXkv00HqxqoxmYo7J/d7Y6K7TRd6YWVZJ6EzGhEPNf8e1IpuLe0lLlqY0bZp+I+
 wzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788631822; x=1789236622;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H0JUj6zdvcDoUAMBJQhj6Hbt1bI3J7dLysQrguntyf0=;
 b=q96P65CjpYH3IywsXz1vPlz7zaNBGWliz1EVpTV+fvA0P4khxNXHSBbiKTFTjxNlCz
 p72VvulKAAvtk2ncXFCVB2+appxVC/jBMEHvszq85yg3AkmBq8GMWL2TCl7yHsvY8y8J
 SCXUkYOXnSVDZovt8XWlQ7rrC5PkGxYYdY7UI3A73tcTflDFmlwIvNGnVHrtDtQu2Hdz
 Gi2KJ3fGgXVrcuJ3hE/rEGtQjlS2atwIoCMQBsnuzvUsQJg9Zyw0ZWLwOvlRNaOz+Syf
 ewrtT9z3zkxYxmORN3tvxMzb4boQWLMI2btsc3VFj36WbqC9WPwUMAmBkYdqtRgnnWXW
 vWVw==
X-Gm-Message-State: AFuF++lm34t6X+ZmHeQ/c+ds9jCDurwen3vYRf5swUCeXl14wa8KTuEJ
 t1LUjEnnxHh50ahQWv+Wlp3o4JZ9mfwUkl6Lji/QzPG1SQUrs1UuiRuahY9/cZS5NdVFafJZ79L
 wCKICIm+lSB4ouxDnIY3nEEva7nq0XLWCsoxXUOXpQ67EJfcgJLM1f5ylsM/g1DFsZw==
X-Gm-Gg: AYBFou0GG13fRZSRIJXcCngnFZUlq2YIaH1j62n/H7oswkN9856kEwrxTnOM5cLM9Ck
 CXkz7NxqGZWUjQ0y9jzMhD/+w1etNQp8HM2jPSVKiXCLNWPSrRM3f+aC7/AYsvE92OONXWD2SI4
 osi8bUj4HNzdlsKkcGWBzO1dTNh1qk6i8ID8V98YLrAiRXgMA3bTQXtdqhO5/PpWFU2lfhwVXx/
 jtsMAEftw4H+hidTUvIORvWFegJeL8FAt6PKKv+Dntu+7j3S3YS3o4UJ0LY11alAjokEct9xwD2
 Q/l8+K50i7lG+f4DiitduhiMOdUSxV5jxLYQLWuPiLs64lYlyrKV+Ct5beNACiFlUHk3IcscE6C
 WMUVkfuXUhEUUHQAO0pvNWwM/nk+ISdgtPneanZoJ7/Fqm5ni
X-Received: by 2002:a05:6a21:7a91:b0:3d0:e034:a26f with SMTP id
 adf61e73a8af0-3da3a0a6f2fmr24335059637.17.1788631821915; 
 Sat, 05 Sep 2026 11:10:21 -0700 (PDT)
X-Received: by 2002:a05:6a21:7a91:b0:3d0:e034:a26f with SMTP id
 adf61e73a8af0-3da3a0a6f2fmr24334993637.17.1788631821443; 
 Sat, 05 Sep 2026 11:10:21 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339a534df1sm17985505eec.7.2026.09.05.11.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 11:10:18 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, sid.manning@oss.qualcomm.com
Subject: [PATCH 12/17] tests/tcg/hexagon: add dfmpyhh
Date: Sat,  5 Sep 2026 11:09:44 -0700
Message-Id: <20260905180949.1852673-13-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
References: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfXwuMgTUn3JOFF
 CTSKsBtqXH9mtxzvsxaVNO5pPVaqDmQmt/Xaqthvj8VzYi5V89zzj2LXVv/iiS9x89iYvfzwp0z
 3Vqa0opMBzoUZO6OeuPaI/PYa5lhC+lABbjs1ZzC4KBNWqpKnb18ri0JJEqi6/ZCY6RN0Y9TARJ
 CFDJH2sGLWLwo4nGSm9ZD/h7CVVm6wCKsDlfQ8CE6zoy12NNprZcEcI+LKS6Bn+sjv0yW5izlmi
 IgiDUdrS/UPTZCNEVoBgCI/kDwsAJmi+4ISNAEBFaPN8PzSuvfOokjydO/1DntsDfxTXhGG4D8I
 sZoMxQqEMAV4kK8wvG3n0f+FC4C5vD4ymVXf35EuDECjMGs+G5NbF8N0q5SXzHC3YBGbOizg7Ef
 s214ZUavTmeTDxVmaNV03eUy2j720dgSQdELfNUHTX3mDHK1Fv8qBrakUMKjZcaYDCVa32hr1Pp
 +tUFlQVekCqhJM7Hqcg==
X-Authority-Analysis: v=2.4 cv=P8AKQCAu c=1 sm=1 tr=0 ts=6a9c5b0e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=7ev5N2rqXU9IWHHYf1oA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: t25vsm4Qu2PQ8NCeGtw4HzIMcZ2WkAG-
X-Proofpoint-ORIG-GUID: t25vsm4Qu2PQ8NCeGtw4HzIMcZ2WkAG-
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfX+MGh0wTp4uqU
 Fbm5KH5aarFwbIl/p/h/HL7l0yT5tlBJqEG1kA9+GTUlKv7BlcdhO7BB49Bgt/3oO5cNAhsvAcJ
 aeTk24G8DAmD9YSyIcYxJzvvi6XrT9U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 adultscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609050201
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

VGVzdCB0aGUgZGZtcHloaCBpbnN0cnVjdGlvbi4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4g
PGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy90Y2cvaGV4YWdvbi9mcHN0
dWZmLmMgfCA1NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUg
Y2hhbmdlZCwgNTcgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29u
L2Zwc3R1ZmYuYyBiL3Rlc3RzL3RjZy9oZXhhZ29uL2Zwc3R1ZmYuYwppbmRleCBmODIyNjJhYjRh
Yy4uMGYyOGEyMThkODQgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3RjZy9oZXhhZ29uL2Zwc3R1ZmYuYwor
KysgYi90ZXN0cy90Y2cvaGV4YWdvbi9mcHN0dWZmLmMKQEAgLTkzNSw2ICs5MzUsMTYgQEAgc3Rh
dGljIHVpbnQ2NF90IGRvX2RmbXB5Zml4KHVpbnQ2NF90IGEsIHVpbnQ2NF90IGIpCiAgICAgcmV0
dXJuIHJlc3VsdDsKIH0KIAorc3RhdGljIHVpbnQ2NF90IGRvX2RmbXB5aGgodWludDY0X3QgYSwg
dWludDY0X3QgYiwgdWludDY0X3QgYWNjKQoreworICAgIHVpbnQ2NF90IHJlc3VsdCA9IGFjYzsK
KworICAgIGFzbSgiJVtyZXNdICs9IGRmbXB5aGgoJVthXSwgJVtiXSlcblx0IgorICAgICAgICA6
IFtyZXNdICIrciIocmVzdWx0KQorICAgICAgICA6IFthXSAiciIoYSksIFtiXSAiciIoYikpOwor
ICAgIHJldHVybiByZXN1bHQ7Cit9CisKIHN0YXRpYyB2b2lkIGNoZWNrX2RmbXB5Zml4KHZvaWQp
CiB7CiAgICAgLyoKQEAgLTk2MSw2ICs5NzEsNTIgQEAgc3RhdGljIHZvaWQgY2hlY2tfZGZtcHlm
aXgodm9pZCkKICAgICAgICAgICAgIDB4MDAxMDAwMDAwMDAwMDAwMFVMTCk7CiB9CiAKKy8qCisg
KiBUZXN0IGRmbXB5aGggKGRvdWJsZS1wcmVjaXNpb24gRlAgbXVsdGlwbHkgaGlnaCpoaWdoIGFu
ZCBhY2N1bXVsYXRlKToKKyAqICAgLSBub3JtYWwgaW5wdXRzCisgKiAgIC0gZGVub3JtYWwgaW5w
dXRzIChjcnVzaGVkIHRvIGluZXhhY3QgemVybykKKyAqICAgLSB6ZXJvL05hTi9pbmZpbml0eSBp
bnB1dHMKKyAqICAgLSBub256ZXJvIGFjY3VtdWxhdG9yCisgKi8KK3N0YXRpYyBpbmxpbmUgdWlu
dDY0X3QgZGZfYWJzKHVpbnQ2NF90IHYpIHsgcmV0dXJuIHYgJiAweDdGRkZGRkZGRkZGRkZGRkZV
TEw7IH0KK3N0YXRpYyBpbmxpbmUgdWludDY0X3QgZGZfZXhwKHVpbnQ2NF90IHYpIHsgcmV0dXJu
IHYgJiAweDdGRjAwMDAwMDAwMDAwMDBVTEw7IH0KK3N0YXRpYyBpbmxpbmUgdWludDY0X3QgZGZf
bWFudCh1aW50NjRfdCB2KSB7IHJldHVybiB2ICYgMHgwMDBGRkZGRkZGRkZGRkZGVUxMOyB9CisK
K3N0YXRpYyB2b2lkIGNoZWNrX2RmbXB5aGgodm9pZCkKK3sKKyAgICB1aW50NjRfdCByZXN1bHQ7
CisKKyAgICAvKiBOb3JtYWwgKiBub3JtYWw6IDEuMCAqIDEuMCArIDAgLT4gbm9uemVybyBmaW5p
dGUgKi8KKyAgICByZXN1bHQgPSBkb19kZm1weWhoKERGX29uZSwgREZfb25lLCAwVUxMKTsKKyAg
ICBjaGVjazY0X25lKGRmX2FicyhyZXN1bHQpLCAwVUxMKTsKKworICAgIC8qIERlbm9ybWFsIGlu
cHV0IGE6IGNydXNoZWQgdG8gemVybyAqLworICAgIHJlc3VsdCA9IGRvX2RmbXB5aGgoMHgwMDA4
MDAwMDAwMDAwMDAwVUxMLCBERl9vbmUsIDBVTEwpOworICAgIGNoZWNrNjQoZGZfYWJzKHJlc3Vs
dCksIDBVTEwpOworCisgICAgLyogRGVub3JtYWwgaW5wdXQgYjogY3J1c2hlZCB0byB6ZXJvICov
CisgICAgcmVzdWx0ID0gZG9fZGZtcHloaChERl9vbmUsIDB4MDAwODAwMDAwMDAwMDAwMFVMTCwg
MFVMTCk7CisgICAgY2hlY2s2NChkZl9hYnMocmVzdWx0KSwgMFVMTCk7CisKKyAgICAvKiBaZXJv
IGlucHV0OiBlYXJseSBleGl0ICovCisgICAgcmVzdWx0ID0gZG9fZGZtcHloaChERl96ZXJvLCBE
Rl9vbmUsIDBVTEwpOworICAgIGNoZWNrNjQoZGZfYWJzKHJlc3VsdCksIDBVTEwpOworCisgICAg
LyogSW5maW5pdHkgaW5wdXQ6IGVhcmx5IGV4aXQsIHJlc3VsdCBjb250YWlucyBpbmYgKi8KKyAg
ICByZXN1bHQgPSBkb19kZm1weWhoKDB4N0ZGMDAwMDAwMDAwMDAwMFVMTCwgREZfb25lLCAwVUxM
KTsKKyAgICBjaGVjazY0KGRmX2V4cChyZXN1bHQpLCAweDdGRjAwMDAwMDAwMDAwMDBVTEwpOwor
CisgICAgLyogTmFOIGlucHV0OiBlYXJseSBleGl0LCByZXN1bHQgaXMgTmFOICovCisgICAgcmVz
dWx0ID0gZG9fZGZtcHloaChERl9RTmFOLCBERl9vbmUsIDBVTEwpOworICAgIGNoZWNrNjQoZGZf
ZXhwKHJlc3VsdCksIDB4N0ZGMDAwMDAwMDAwMDAwMFVMTCk7CisgICAgY2hlY2s2NF9uZShkZl9t
YW50KHJlc3VsdCksIDBVTEwpOworCisgICAgLyogTm9uemVybyBhY2N1bXVsYXRvcjogbm9uemVy
byBmaW5pdGUgcmVzdWx0ICovCisgICAgcmVzdWx0ID0gZG9fZGZtcHloaChERl9vbmUsIERGX29u
ZSwgREZfb25lKTsKKyAgICBjaGVjazY0X25lKGRmX2FicyhyZXN1bHQpLCAwVUxMKTsKKyAgICBj
aGVjazY0X25lKGRmX2V4cChyZXN1bHQpLCAweDdGRjAwMDAwMDAwMDAwMDBVTEwpOworfQorCiBp
bnQgbWFpbigpCiB7CiAgICAgY2hlY2tfY29tcGFyZV9leGNlcHRpb24oKTsKQEAgLTk4MSw2ICsx
MDM3LDcgQEAgaW50IG1haW4oKQogICAgIGNoZWNrX2NvbnZfdXcyZGYoKTsKICAgICBjaGVja19j
b252X3VkMmRmKCk7CiAgICAgY2hlY2tfZGZtcHlmaXgoKTsKKyAgICBjaGVja19kZm1weWhoKCk7
CiAKICAgICBwdXRzKGVyciA/ICJGQUlMIiA6ICJQQVNTIik7CiAgICAgcmV0dXJuIGVyciA/IDEg
OiAwOwotLSAKMi4zNC4xCgo=

