Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8EB410F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYZT-0004vZ-1D; Wed, 08 Apr 2026 15:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAY8B-000811-Og
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:00:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAKQf-0005jW-0P
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:22:15 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637M3ILZ1619595
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 04:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DeH2wubJHVYpkGei61VcjbWJb/j95FBb/C0QOgjdibs=; b=PitJHdqtQcXUW8h7
 /XZKwl3PKrM3Gf+ukImYIOHmiolNL7r560nU/uWbIb2pUtE8p4PZ4W8nNy1ZQzyB
 2j349H6FgiAPL+P1rNUv9ZmxCYnGgxocWJTZp2AWLsFbYTKrC4baPoK2Uz3489N9
 d8//CxVdnG/cKEgmKu9/OFNfioX+nEkc3Cehbulhfo+OMw6lJzP5FLa6YvVirse7
 4RYkH3pChpJmJ2bNn4vSa0PdOIJjDum6IWsm7dYw2tWsF4aY43e8KAtd4lfrsspH
 3PazgHErejqssFSVkhIbA+KtebSuOSWmpLUq9WM6js2Yc5QgMjsaTjzJzZe30Ye3
 PMUfkg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddacrgxph-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:22:02 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12c20a91932so4018324c88.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 21:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775622121; x=1776226921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DeH2wubJHVYpkGei61VcjbWJb/j95FBb/C0QOgjdibs=;
 b=auFnWxlfuQpLBw+BgdVmePmj/sTKYSHZ1psG9WuLlRRsbYkvBBgBYbBA5Avjb58eOn
 LuM9/GnmcLe9aJ4ptBjw1W8VKlDG+i/HcQ06SOFftjf2acITRq28yLEI5hk4h9XbjEFr
 oUDOO8qRr4Y0kp2mzOL4R3fUs7cgDN3k3LliAmQqUAigSJyRp+N9wiCWzC9SjrvN8Oul
 bwYFkRdsjd7RparoifujEMufKh+i+eCR3uQdHYxUUfwh2molwHXuxlUVnlTI9htSDgne
 7zq7Ba//Mc/mUIbBxUEl7QkapIoVuQp+KY8636YxSXo9mcNgy93EAgNzssTmM3qDVG9J
 6wEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775622121; x=1776226921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DeH2wubJHVYpkGei61VcjbWJb/j95FBb/C0QOgjdibs=;
 b=U/9dnlH1wCyTGS2UT4AWhTCVWZ4vbFLYpWOes5fsMyht6Q5mCE94nYqObyuJFHZNXP
 ZP5pVVb4T+BmGW0yoDAZ5sY+iWy1+1dZ70SFenb8AZ2i5hNYzdm6s8R+tkLhjvpSdVRF
 T7dLeoD9JsFNpWdK/veUBtI11bDiLFCZjDYYwVRHh4AnocUSSF0Xh8a/5s1dpR2/YA+e
 469eaokc0HZefwVw1yCHYcJ0iGlNDbXtZoLbjT0hL8tK/5QAUWmoExMqTnWBrxnT+tme
 tI1lZ9ku6Ilew+9p0vi6mC1VxTHfp2lYUcN59aHnWzjcc4Jwoe/4RnTTyxusF29eq3fJ
 fCGA==
X-Gm-Message-State: AOJu0Ywgzd5W2P8ME1Oh3u+66bL87w4MUFrUf+s/5/rwhOzVw2S+3rFk
 OA71lRLau5W467c/x7oQBcCoyut3oG+rQwUI17vyQcSdt9DyflbLABrMOVOowCracWiU/iHEp8M
 tYk2snavlO7PyKK85IM3hmUcTTmASlucJ4q+wY/5KCG+nRV7VRHKQY7q4/KFvbAGtwg==
X-Gm-Gg: AeBDievet0lR5bAnntoV3jBko1Uv55JuAhS5X1752+If9A9OYj5Z+eCeLbyhebo37Lc
 IjEAUSHyGR13Hmows4YuIUXkk1lGUgcuJGKGZGzsxZOU7CGHEx9F3RthbqUF9cGba3VfaXccLww
 /zqaHvH9kogHrhvfcUkBMgVAfQpAgfTSzrhwXaGsj3pfgq1HD5C3SkPMDTJHmgRp24PITepvFIS
 yyTpqIf7LG0ipc3R7Ev+HBu0KsGG+j5L3xXr4lwC/OjVwSZRxsR4jIg5c0wpzrdmpOfmSpksfAf
 o9+gwUm19eC2mCgykYdNeltnwkuvpaaqIHH6z2o928V4ml3VMjylcHX1Az4+NWRPGxu5L1gCgRO
 SG9W8B7LG0g6UctdZ2E1e8xvkcXwJ+wvDMusFZAjMSymEYAMu97SFBizHlbpjp3rhv7Rhlw==
X-Received: by 2002:a05:7022:41a3:b0:128:d714:3ca1 with SMTP id
 a92af1059eb24-12bfb6ecd04mr10265205c88.5.1775622120770; 
 Tue, 07 Apr 2026 21:22:00 -0700 (PDT)
X-Received: by 2002:a05:7022:41a3:b0:128:d714:3ca1 with SMTP id
 a92af1059eb24-12bfb6ecd04mr10265193c88.5.1775622120212; 
 Tue, 07 Apr 2026 21:22:00 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bed93f861sm23474816c88.0.2026.04.07.21.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 21:21:59 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 9/9] tests/qtest: Add hexagon boot-serial-test
Date: Tue,  7 Apr 2026 21:21:48 -0700
Message-Id: <20260408042149.1902796-10-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408042149.1902796-1-brian.cain@oss.qualcomm.com>
References: <20260408042149.1902796-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: pvRrIFJ5uJt5KIv4i6NdyJJjq9RYIJo9
X-Proofpoint-GUID: pvRrIFJ5uJt5KIv4i6NdyJJjq9RYIJo9
X-Authority-Analysis: v=2.4 cv=WZs8rUhX c=1 sm=1 tr=0 ts=69d5d7ea cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=mx_w8yxdHMTqIFmIFlQA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfXwBBJWaJnPAb/
 HvV3itf9cWxdJHkCxFVn7MY4RJstyvuAOWWgdpu/wubXdu+r5a/bhqweX1XdRlGhSQpvS8Bb5pm
 EqZNbs2wGDANsRt5SkcsBkuhGJlR4OkyBYqORLPxqUkzdWipN2wPloeRbEA/HaIFqcmpQX8QDiH
 /o9hSPdm/L2BAJCeBYl5p4M3t6lDPze9xeqztr1grLzFw2uecY6nmWISEBnsO8mDOyyZd1ZbiIc
 cfHvjUeVN3ZW37YSnQmrX63lEG5D+faUeBQK08l2+NyDlnbh1EdC+2qeGFX4B34yEz17LZQwSw3
 U8DZw/IV4FuuhFvw9wvFCBjhEYPOpu04OjL6f/PHhTRaszhMlgZmRi24KqR5CvDBAMqFXBJiaiV
 8j/coWiYIQzvkhCrrybKUNvNBrHLNTNgnFtm2bpWP7K28Vruxw39mTYJr79P47A9DSc76mkUnCP
 yyIvaay/pspWcEqfLEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

QWRkIGJvb3Qtc2VyaWFsLXRlc3Qgc3VwcG9ydCBmb3IgSGV4YWdvbiBhcmNoaXRlY3R1cmUgdXNp
bmcgdGhlIHZpcnQKbWFjaGluZS4KClJldmlld2VkLWJ5OiBGYWJpYW5vIFJvc2FzIDxmYXJvc2Fz
QHN1c2UuZGU+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxj
b21tLmNvbT4KLS0tCiB0ZXN0cy9xdGVzdC9ib290LXNlcmlhbC10ZXN0LmMgfCA4ICsrKysrKysr
CiB0ZXN0cy9xdGVzdC9tZXNvbi5idWlsZCAgICAgICAgfCAyICsrCiAyIGZpbGVzIGNoYW5nZWQs
IDEwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90ZXN0cy9xdGVzdC9ib290LXNlcmlhbC10
ZXN0LmMgYi90ZXN0cy9xdGVzdC9ib290LXNlcmlhbC10ZXN0LmMKaW5kZXggYmNkMGE5YzUwZTcu
LjM3ZmVlN2E5MWM0IDEwMDY0NAotLS0gYS90ZXN0cy9xdGVzdC9ib290LXNlcmlhbC10ZXN0LmMK
KysrIGIvdGVzdHMvcXRlc3QvYm9vdC1zZXJpYWwtdGVzdC5jCkBAIC0xNDIsNiArMTQyLDEzIEBA
IHN0YXRpYyBjb25zdCB1aW50OF90IGtlcm5lbF9zdG0zMnZsZGlzY292ZXJ5W10gPSB7CiAgICAg
MHgwNCwgMHgzOCwgMHgwMSwgMHg0MCAgICAgICAgICAgICAgICAgIC8qIDB4NDAwMTM4MDQgPSBV
U0FSVDEgVFhEICovCiB9OwogCitzdGF0aWMgY29uc3QgdWludDhfdCBiaW9zX2hleGFnb25bXSA9
IHsKKyAgICAweDAwLCAweDQwLCAweDAwLCAweDAxLCAgICAgICAgICAgICAgICAgLyogaW1tZXh0
KCMweDEwMDAwMDAwKSAqLworICAgIDB4MDAsIDB4YzAsIDB4MDAsIDB4NzgsICAgICAgICAgICAg
ICAgICAvKiByMCA9ICMjMHgxMDAwMDAwMCAqLworICAgIDB4NTQsIDB4YzAsIDB4MDAsIDB4M2Ms
ICAgICAgICAgICAgICAgICAvKiBtZW1iKHIwKyMwKSA9ICMweDU0IFdyaXRlICdUJyAqLworICAg
IDB4ZjgsIDB4ZmYsIDB4ZmYsIDB4NTkgICAgICAgICAgICAgICAgICAvKiBqdW1wIDB4MCA7IExv
b3AgYmFjayB0byBzdGFydCAqLworfTsKKwogdHlwZWRlZiBzdHJ1Y3QgdGVzdGRlZiB7CiAgICAg
Y29uc3QgY2hhciAqYXJjaDsgICAgICAgLyogVGFyZ2V0IGFyY2hpdGVjdHVyZSAqLwogICAgIGNv
bnN0IGNoYXIgKm1hY2hpbmU7ICAgIC8qIE5hbWUgb2YgdGhlIG1hY2hpbmUgKi8KQEAgLTE5NCw2
ICsyMDEsNyBAQCBzdGF0aWMgY29uc3QgdGVzdGRlZl90IHRlc3RzW10gPSB7CiAgICAgeyAiYXJt
IiwgIm1pY3JvYml0IiwgIiIsICJUIiwgc2l6ZW9mKGtlcm5lbF9ucmY1MSksIGtlcm5lbF9ucmY1
MSB9LAogICAgIHsgImFybSIsICJzdG0zMnZsZGlzY292ZXJ5IiwgIiIsICJUIiwKICAgICAgIHNp
emVvZihrZXJuZWxfc3RtMzJ2bGRpc2NvdmVyeSksIGtlcm5lbF9zdG0zMnZsZGlzY292ZXJ5IH0s
CisgICAgeyAiaGV4YWdvbiIsICJ2aXJ0IiwgIiIsICJUVCIsIHNpemVvZihiaW9zX2hleGFnb24p
LCBOVUxMLCBiaW9zX2hleGFnb24gfSwKIAogICAgIHsgTlVMTCB9CiB9OwpkaWZmIC0tZ2l0IGEv
dGVzdHMvcXRlc3QvbWVzb24uYnVpbGQgYi90ZXN0cy9xdGVzdC9tZXNvbi5idWlsZAppbmRleCBi
ZTRmYTYyN2I1Zi4uYmFhMTE5NTM3MWIgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3F0ZXN0L21lc29uLmJ1
aWxkCisrKyBiL3Rlc3RzL3F0ZXN0L21lc29uLmJ1aWxkCkBAIC0yOTAsNiArMjkwLDggQEAgcXRl
c3RzX3Jpc2N2NjQgPSBbJ3Jpc2N2LWNzci10ZXN0J10gKyBcCiAgICBjb25maWdfYWxsX2Rldmlj
ZXMuaGFzX2tleSgnQ09ORklHX1JJU0NWX0lPTU1VJykgPwogICAgWydpb21tdS1yaXNjdi10ZXN0
J10gOiBbXSkKIAorcXRlc3RzX2hleGFnb24gPSBbJ2Jvb3Qtc2VyaWFsLXRlc3QnXQorCiBxb3Nf
dGVzdF9zcyA9IHNzLnNvdXJjZV9zZXQoKQogcW9zX3Rlc3Rfc3MuYWRkKAogICAnYWM5Ny10ZXN0
LmMnLAotLSAKMi4zNC4xCgo=

