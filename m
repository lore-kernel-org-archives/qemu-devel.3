Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E289CC55ABF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 04:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrpmr-0002Cj-Up; Thu, 06 Aug 2026 00:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrpmX-00028p-Q1
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:32:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrpmW-00046W-5J
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:32:37 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675NbIxd170289
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 04:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j2Tq17a6Nx88JT8R5fCoaV+t6aHZHI82tO8YJOFApiw=; b=XXsa5y4YPZHQHEds
 tipZc+aDN7GDJrbmTTWAY+bjopW20NFyalfUhGFjNJv0hfrLnqtHtWRgtOiaRyiy
 zw1A6toizt9Qn8WwU3S4gm6CNlD6aC/6RlVa02ZJa/I3CZEnlK44WoGtWXV9opY3
 +74vPjP2ckqJppMkVdwK2LL7CBkZPhOLj9u6lBN6z12yMvxaeCJi4JVdwj5DjInb
 xC94b5ZRdv1OZEbQa43+A5tL/XKaw8xRkwiVIErWZxJNVnEOlnuZdTW2aYYYdE7h
 IkAnXNbgSGKgCdZgsPtOeCv8ewXlR2FtCb/uNEcmRCgGOefyDHhY4AYV+WmA8Sws
 nOfr9Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv5x5uk2t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 04:32:35 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cb5cc1e139bso1284809a12.3
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 21:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785990754; x=1786595554; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=j2Tq17a6Nx88JT8R5fCoaV+t6aHZHI82tO8YJOFApiw=;
 b=kXXFMOJm6XgE33uEYV14ZUMBtgDQFRQl0TzXhejjTBLLAFXEwwyBszAvuL2mcjtwCr
 2TWmlYIDvWNLus+aixxg64tetJX86xODnvLhgNnOujMDCzdvTQs99qcGstKqxqz6EhS6
 Yq6MO4ONNRREvggeJsstngjnRtvc9wGbFFADtFNvHRxgBEqrJ6UMb/JrIzmrF/AawN9U
 H203/6KBAaLP60Bqo69wKJK+jkKOd7dms7om9QjRlvsVDzKuuwmaBbiryJuh/RBfzhkE
 gkQgiZNFVo+wI8G8XT3hHy57LMeQEYE+oluN92DWJ3FwFvh5+Am/S/6m09FGrPGRAUJf
 lJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785990754; x=1786595554;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j2Tq17a6Nx88JT8R5fCoaV+t6aHZHI82tO8YJOFApiw=;
 b=KnMIhXkO9ZCiof8daIMx2/pVgtdaWfBWiOC9yfx0l7TATuA0x710NiCcidsiQpvoxi
 KR/uBuhUQLlPAkpCHcHZbXjMK+BXyj8X2jycKVP8F/rkDigEGe+OR5uTcKjVgg3HkSY0
 dLectW3Nmj7TWxeW0YcsqM6JTL1r5L3K09Vvh6/4/EmR9PKAvb98+1C+rGEka9MKhf5C
 mKi9G1VAOPiGYqx8iZR0EzRWLZfnnCRtnmCXsgXPsoimVI1HgfKUkTwPup1xg71HVgDR
 HAmcrgKKUeBOLpasJlILP3M0L7m85MnLliTd2N06BTfwbWnpAWyCFuHMjAAMNBAD0fpt
 N0vg==
X-Gm-Message-State: AOJu0YwdttcoarpceIxWd9MQdt/kDcbor4P4tYWUYueGfVcKsJGmALmv
 meQHvq+Li+tlSZxcByG+ohwyzVxzlL/vsDI2r3LzdXu4sELUhV4j/B2BibzVQ+WzDdLYbElYvS0
 Y7Q0kolUFpflUjP4dQ9hsxIQuL3F93DBB/WUXlrAPg4KfEhlJQ2rdFPmyQKuovDDZ/w==
X-Gm-Gg: AR+sD125Lxbbb9Osi86XP0VBPs2h0LuWlUe2RxQESPU6zKVGIHeqY8md9dSfFr6Ix9y
 ZcuyMzjGkzikpTk1wESdpft+tGZOQt8JenjxSKoqP6mHzJzhQY3Xdbnz19/d8G0GeHoShm9n7YT
 OoeqS2UZdfVGHcIBkv+UpaNsLmdJVvzFW9jcgk+2n3mn7CVejP3//AqCMYG3ekmqdlh0wvVUlDy
 HVcR361UAPqiQbTuftE5IB6LDRkPIurDBW7O+93njDu6WjvbLCQ7vIldeFnU20H91e8EHG7MNLj
 f/+xRm0kGEScH2wtrfq/a5kp+dog+9HigYqWexbapGgGsJ/vq7ueCEHFN8vjgUY/aRfhOch09YR
 +WqauTDuRNZD6X4Jgf7dBV3uZXsCCQUedj0hkXFBNb05z/EkR
X-Received: by 2002:a05:6a20:7fa1:b0:3c8:e140:63c3 with SMTP id
 adf61e73a8af0-3cb86076804mr12923899637.37.1785990754104; 
 Wed, 05 Aug 2026 21:32:34 -0700 (PDT)
X-Received: by 2002:a05:6a20:7fa1:b0:3c8:e140:63c3 with SMTP id
 adf61e73a8af0-3cb86076804mr12923855637.37.1785990753681; 
 Wed, 05 Aug 2026 21:32:33 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0a9csm29958146eec.2.2026.08.05.21.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 21:32:32 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com,
 Brian Cain <brian.cain@oss.qualcomm.com>, richard.henderson@linaro.org
Subject: [PATCH v2 6/6] tests/tcg/hexagon: add HVX test for V6_vsubwsat
 saturation
Date: Wed,  5 Aug 2026 21:32:23 -0700
Message-Id: <20260806043223.3787083-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806043223.3787083-1-brian.cain@oss.qualcomm.com>
References: <20260806043223.3787083-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 4b-umCXmVeJtVZdXBIGU7vLgCxTOhsxp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAzMSBTYWx0ZWRfX1Sm3UKRsi0eV
 kpr65rmWkyATXdC9wj6icycq/HxgRLScqzXjAYxNrmZQKl/FIogQBBXDJRdIv1pmI8WkZ+jKWzs
 jBtZhxYqvzqTNvkLKFUFBKAoYBZrv7bykSz6t3jEvBrqSHyHox7FyX3kZblOhCNG335sSHyeUOu
 At1PQE+jhto7pnbku3HCzJeZOUaDNpjljou1IowDDicfmSYWJM9VXvUBnPr9oUl5KiP8PMq6dng
 Xb7IDVbFQ27ZiNsNZeq/3qXSgbA3OZxLPcdZhOgp1hSlBjSQzWOQ2Yu0sPkLYNUC3Lx633P8s9B
 BSKmEKShnk2k54W7ZAF4BXNE/rpaQNkvxcRFelLRhpmEKLsdir8HSbigMORFKCk3CQBHpajU/Fu
 71p8eZhsFKxuGRFJBSGnCmrjtMVXHrT64p7EcPZ/GjGdAkFD1XtD6z3EXbzOn+apUmTalUEzDdE
 SjH8C7UJEJwITUEt3tw==
X-Proofpoint-ORIG-GUID: 4b-umCXmVeJtVZdXBIGU7vLgCxTOhsxp
X-Authority-Analysis: v=2.4 cv=RcygzVtv c=1 sm=1 tr=0 ts=6a740e63 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KziaR8soUeEz0EukW7EA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAzMSBTYWx0ZWRfX/cEVb+1pv7Ai
 Mfe5T3obB5zoGcULE5CUhyaRUOmiV/gbKASGaSpDcZHfBTEHNoVsrr+PWCJrG6T4AxqzOEYWQkD
 D4SZA5x6bD1UzxFLbjwCiEhOPfUWNUc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060031
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

UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tPgotLS0KIHRlc3RzL3RjZy9oZXhhZ29uL2h2eF9taXNjLmMgfCA0NCArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA0NCBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vaHZ4X21pc2MuYyBiL3Rlc3RzL3Rj
Zy9oZXhhZ29uL2h2eF9taXNjLmMKaW5kZXggOTBjMzczM2RhMDcuLjY0MWNmZjU5YWJhIDEwMDY0
NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9odnhfbWlzYy5jCisrKyBiL3Rlc3RzL3RjZy9oZXhh
Z29uL2h2eF9taXNjLmMKQEAgLTIwLDYgKzIwLDggQEAKICNpbmNsdWRlIDxzdGRib29sLmg+CiAj
aW5jbHVkZSA8c3RyaW5nLmg+CiAjaW5jbHVkZSA8bGltaXRzLmg+CisjaW5jbHVkZSA8aGV4YWdv
bl90eXBlcy5oPgorI2luY2x1ZGUgPGh2eF9oZXhhZ29uX3Byb3Rvcy5oPgogCiBpbnQgZXJyOwog
CkBAIC0zODYsNiArMzg4LDQ3IEBAIHN0YXRpYyB2b2lkIHRlc3RfdnN1YnV3c2F0X2R2KHZvaWQp
CiAgICAgY2hlY2tfb3V0cHV0X3coX19MSU5FX18sIDIpOwogfQogCitzdGF0aWMgdm9pZCB0ZXN0
X3ZzdWJ3c2F0KHZvaWQpCit7CisgICAgY29uc3QgaW50MzJfdCB4MCA9IElOVDMyX01JTjsKKyAg
ICBjb25zdCBpbnQzMl90IHkwID0gMTsKKyAgICBjb25zdCBpbnQzMl90IHgxID0gSU5UMzJfTUFY
OworICAgIGNvbnN0IGludDMyX3QgeTEgPSAtMTsKKyAgICBIVlhfVmVjdG9yIHYwOworICAgIEhW
WF9WZWN0b3IgdjE7CisgICAgSFZYX1ZlY3RvciB2cmVzOworCisgICAgLyogSU5UMzJfTUlOIC0g
MSB1bmRlcmZsb3dzIGFuZCBtdXN0IHNhdHVyYXRlIHRvIElOVDMyX01JTiAqLworICAgIG1lbXNl
dChleHBlY3QsIDB4MTIsIHNpemVvZihNTVZlY3RvcikpOworICAgIG1lbXNldChvdXRwdXQsIDB4
MzQsIHNpemVvZihNTVZlY3RvcikpOworCisgICAgdjAgPSBRNl9WX3ZzcGxhdF9SKHgwKTsKKyAg
ICB2MSA9IFE2X1ZfdnNwbGF0X1IoeTApOworICAgIHZyZXMgPSBRNl9Wd192c3ViX1Z3Vndfc2F0
KHYwLCB2MSk7CisgICAgbWVtY3B5KCZvdXRwdXRbMF0sICZ2cmVzLCBzaXplb2YoTU1WZWN0b3Ip
KTsKKworICAgIGZvciAoaW50IGogPSAwOyBqIDwgTUFYX1ZFQ19TSVpFX0JZVEVTIC8gNDsgaisr
KSB7CisgICAgICAgIGV4cGVjdFswXS53W2pdID0gSU5UMzJfTUlOOworICAgIH0KKworICAgIGNo
ZWNrX291dHB1dF93KF9fTElORV9fLCAxKTsKKworICAgIC8qIElOVDMyX01BWCAtICgtMSkgb3Zl
cmZsb3dzIGFuZCBtdXN0IHNhdHVyYXRlIHRvIElOVDMyX01BWCAqLworICAgIG1lbXNldChleHBl
Y3QsIDB4MTIsIHNpemVvZihNTVZlY3RvcikpOworICAgIG1lbXNldChvdXRwdXQsIDB4MzQsIHNp
emVvZihNTVZlY3RvcikpOworCisgICAgdjAgPSBRNl9WX3ZzcGxhdF9SKHgxKTsKKyAgICB2MSA9
IFE2X1ZfdnNwbGF0X1IoeTEpOworICAgIHZyZXMgPSBRNl9Wd192c3ViX1Z3Vndfc2F0KHYwLCB2
MSk7CisgICAgbWVtY3B5KCZvdXRwdXRbMF0sICZ2cmVzLCBzaXplb2YoTU1WZWN0b3IpKTsKKwor
ICAgIGZvciAoaW50IGogPSAwOyBqIDwgTUFYX1ZFQ19TSVpFX0JZVEVTIC8gNDsgaisrKSB7Cisg
ICAgICAgIGV4cGVjdFswXS53W2pdID0gSU5UMzJfTUFYOworICAgIH0KKworICAgIGNoZWNrX291
dHB1dF93KF9fTElORV9fLCAxKTsKK30KKwogc3RhdGljIHZvaWQgdGVzdF9sb2FkX3RtcF9wcmVk
aWNhdGVkKHZvaWQpCiB7CiAgICAgdm9pZCAqcDAgPSBidWZmZXIwOwpAQCAtNTMwLDYgKzU3Myw3
IEBAIGludCBtYWluKCkKIAogICAgIHRlc3RfdmFkZHV3c2F0KCk7CiAgICAgdGVzdF92c3VidXdz
YXRfZHYoKTsKKyAgICB0ZXN0X3ZzdWJ3c2F0KCk7CiAKICAgICB0ZXN0X2xvYWRfdG1wX3ByZWRp
Y2F0ZWQoKTsKICAgICB0ZXN0X2xvYWRfY3VyX3ByZWRpY2F0ZWQoKTsKLS0gCjIuMzQuMQoK

