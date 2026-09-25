Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371AEC98318
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 01:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9v9Z-000557-1H; Thu, 24 Sep 2026 21:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9U-00050C-SF
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:55:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9R-0005u5-UZ
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:55:04 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P1kld0313548
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:55:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 d+11tnix2V/bt8ArMEcPhg4E6n1O2gIEaiQ5iZ3BXXI=; b=hC7Fmp2GuPIYVT6J
 ysf3Lu11PeiQyAGbm6c5evgbXWQ6HBduhJpiS8Fy78B2T4wco3dVqTeQQDeVAJMk
 BqLjL+DYDo4X50M8TP0Sc+6Hh8pOT6v3tRbv4YnRt02qfRtXihhAECUqpQe+8qAq
 wiiFigxqWG8OIczy+OqVPw2gy4+c2DThjZa9XFVljknwHeqmUrTfjYswnrKcna7K
 OG2LthbLCBiindLtEkKyAfA1Ow0Cyuh1DXvUD4Q7aK2UYz8RdV/JjyeiniQBB9+V
 UpqwVxMgph4VueGpdAaLRUMWiSBUBN8yXHUeQjvQtUQ/Iave5EBOHLGZaCq+m4jI
 kw85fg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1s93d81-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:55:00 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3412efc2661so500095eec.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 18:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790301299; x=1790906099; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d+11tnix2V/bt8ArMEcPhg4E6n1O2gIEaiQ5iZ3BXXI=;
 b=d8DIKH1JAASylt132fOGt0mV0XPA696MqCrRNhwYcLKc9J9G9/6j2pJkbUY+aYRo3B
 LFLjJpKE9yOWBVikKK7BGYf3Rf3xLAzYRx0klHwo/FXUxnjCCV0U7e3UAJ4PKJtOzV0l
 MGYYTAb50Gdv/Xsr8cwwfKCbZ2P+F0JJW3TwYqDyo4Qbyn2iKayNZo8OjVqXg5GpAd0f
 8OVYbqMWOw/rgmjWOlPZzCNV4lGm/g8g+u5WNfLUe+KAa0KjcxuXJq9csI/hsfc/UyF6
 0+3mgt41ynxMSm4gxIDRdzs611cK7Hq6sLcn+o8Pn5Wc8ObBJDBiHr7Z5SkaXhFHhHe6
 8iUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790301299; x=1790906099;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d+11tnix2V/bt8ArMEcPhg4E6n1O2gIEaiQ5iZ3BXXI=;
 b=dJOXRbjT47giPf9YaS0p9J/WSJU4fo0F6K+qeAqrXc9ezGX2iLKq317sYf+x3uhnqR
 b+cgHn0PfrAqLKPz2kZuXraIwLvxswSUcUTU2K/RUdJfbW+OOPfqHm0dD0PpeSBLL+Pd
 h2hFC1u+fmo2hCB4Ti1psOEbRXzZMLiV0xdeZFDifGQobNZUPwl6d3J2soasW16/ifNm
 Wah8UD51UD5d12szRUdzrPLNj3sZ9fwRYbHU8Cdyp/2IXvre4LgAlgP4MG6bqsfG9I5V
 xfaWqPAmoY+4KVbwo/ZzPes51dHbpaRnLpDtCDtG5M4HFMD8dzMMgx5z+Hcw2RbnXuob
 MBGQ==
X-Gm-Message-State: AFuF++ndYANpgW5eyNc03DRkgk7IejPhRrfVBRvbfcBOe8XFfb7uXrtw
 eDcu1gbpAay7tFrYQIpyufGb7cTYtUfcBGbgH9QXd2zQ+yNrr8NVKVsycH3IPVoX0E2wx5/i7XI
 J78TMAeBqtfCzqCXkczpGUZVz+ruMon+d+vjoaftkAp44liLFBbvApl8PUuU4iJdn3g==
X-Gm-Gg: AYBFou1ttbAJ/xc57YnpjNV0/7xT4lwzHRxNTgngp6Noc2GsK6hyKhyu1RLIalNqy6j
 lcQQfp+lLMJg5O+vz0hNpX0ldi3ie1E94toWeFyWyyA9EN45yaAisK0qlubrN6crC7THq4kavzz
 8UGMZSyOUkUtxvDoBicVfhsbRhcHi/Wj0cGx0PJTGFYhmVTh1ZiGK0MlazH9bzOFZD+W4b+yxiE
 6pqHNSqyEEf5WhA6bqvsxJjOGZb50dfzfIQALFtsHw0S+NsvL+Tbb5xabu4X/LcvBLiURrLggLR
 irH2TvsmlgZvBF8fFPZ6CgQY+FVLKQ+1qxm90kEK4zK+1503dOMQRRscCK8hgLuCYkDeA1XCSyv
 Ze+jk5WkdsbeF5MdLJ2KZ0exPgCvyw7Ekybxterv2CYh+x7c=
X-Received: by 2002:a05:693c:41dc:20b0:339:7f8d:60dd with SMTP id
 5a478bee46e88-34006169f38mr3346753eec.27.1790301299232; 
 Thu, 24 Sep 2026 18:54:59 -0700 (PDT)
X-Received: by 2002:a05:693c:41dc:20b0:339:7f8d:60dd with SMTP id
 5a478bee46e88-34006169f38mr3346744eec.27.1790301298608; 
 Thu, 24 Sep 2026 18:54:58 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3416e4c2f50sm1873720eec.27.2026.09.24.18.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 18:54:57 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 16/40] tests/tcg/hexagon: add FP classification, conversion,
 and fixup tests
Date: Thu, 24 Sep 2026 18:54:05 -0700
Message-Id: <20260925015429.2579174-17-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
References: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX9o0WGkm7uJ6S
 v+xuP2SZzalf+WXys6t4wHHwfZ/uqBYHvPYSuO2Ku0AC+qC5ehouxbSenuxzSXDmDqBUJO0jurb
 ZuWcGEfe8vecX0evGHfZS14/J9kFYIyZPvazviErvG3vg2lLprthMmMbK9F7fZ5X8THjvtRdqrr
 c+tx38M4LsKzl+pa6Y2q6DfVeiRfdFIKsZ5I5yFHzlrNo+bG/urrbS56Na0UFPOgmhQ4QRSiI+v
 o96HvsDJnEJbbcRvJ09KSDtpMcRPxMrWMjIRxDl+uzq8DO0yfET3hUFsjI/7jwtlibl5yTOMvwl
 c8v02XCagn0tJkubBezNa6UR8DEM4VZGUsqHsIrFxz54E2YQpUC4nLn2FEBfsJ9EEZm7bYY2spY
 jCoB7BDy+CK7mH57KB2w1guE8HqNCMrwl5d6jBmBQA66QuZDRtGDYrHSz59KX/Civf1kOEuk2DV
 daD3yN8HgWZleF/8MYQ==
X-Authority-Analysis: v=2.4 cv=VPxIDNPX c=1 sm=1 tr=0 ts=6ab5d474 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=anSrM8_wVXE1bCkXRQoA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX356XXs/WlwP0
 FMZ1ZFivofz3Ili85KJq65Mp55Rv/bM9VM6vWy7RcDEOWhQ669YKvXM/pnnTRP1V4gmKLAFnRvy
 9KhyZaNsoI6oCdSYV9Q5XaGS9VfmDLs=
X-Proofpoint-ORIG-GUID: LdZ9c4vhwNN6CmmnJDf6TVKBpq464_3A
X-Proofpoint-GUID: LdZ9c4vhwNN6CmmnJDf6TVKBpq464_3A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250007
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

QWRkIHNmY2xhc3MvZGZjbGFzcyBGUCBjbGFzc2lmaWNhdGlvbiB0ZXN0cywgdW5zaWduZWQtdG8t
ZG91YmxlCmNvbnZlcnNpb25zLCBhbmQgZGZtcHlmaXggZGVub3JtYWwgZml4dXAgdGVzdHMuCgpS
ZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNv
bW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29t
bS5jb20+Ci0tLQogdGVzdHMvdGNnL2hleGFnb24vZnBzdHVmZi5jIHwgMTc1ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDE3NSBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vZnBzdHVmZi5jIGIvdGVzdHMvdGNn
L2hleGFnb24vZnBzdHVmZi5jCmluZGV4IDZhYWRhY2NhYmRmLi43NTYxZjMxY2RjMyAxMDA2NDQK
LS0tIGEvdGVzdHMvdGNnL2hleGFnb24vZnBzdHVmZi5jCisrKyBiL3Rlc3RzL3RjZy9oZXhhZ29u
L2Zwc3R1ZmYuYwpAQCAtNzExLDYgKzcxMSwxNzYgQEAgc3RhdGljIHZvaWQgY2hlY2tfZGZtcHl4
eCh2b2lkKQogICAgIGNoZWNrNjQocmVzNjQsIDB4N2ZlZmZmZmZmZmZmZmZmZlVMTCk7CiB9CiAK
Ky8qCisgKiBzZmNsYXNzIG1hc2sgYml0czoKKyAqICAgYml0IDA6IHBvc2l0aXZlL25lZ2F0aXZl
IHplcm8KKyAqICAgYml0IDE6IHBvc2l0aXZlL25lZ2F0aXZlIG5vcm1hbAorICogICBiaXQgMjog
cG9zaXRpdmUvbmVnYXRpdmUgZGVub3JtYWwKKyAqICAgYml0IDM6IHBvc2l0aXZlL25lZ2F0aXZl
IGluZmluaXR5CisgKiAgIGJpdCA0OiBwb3NpdGl2ZS9uZWdhdGl2ZSBOYU4KKyAqLworI2RlZmlu
ZSBURVNUX1NGQ0xBU1MoVkFMLCBNQVNLLCBFWFBFQ1QpIFwKKyAgICBkbyB7IFwKKyAgICAgICAg
dWludDMyX3QgcmVzOyBcCisgICAgICAgIGFzbSgiJVtyZXNdID0gIzBcblx0IiBcCisgICAgICAg
ICAgICAicDAgPSBzZmNsYXNzKCVbdmFsXSwgIyIgI01BU0sgIilcblx0IiBcCisgICAgICAgICAg
ICAiaWYgKHAwKSAlW3Jlc10gPSAjMVxuXHQiIFwKKyAgICAgICAgICAgIDogW3Jlc10gIj0mciIo
cmVzKSBcCisgICAgICAgICAgICA6IFt2YWxdICJyIihWQUwpIFwKKyAgICAgICAgICAgIDogInAw
Iik7IFwKKyAgICAgICAgY2hlY2szMihyZXMsIEVYUEVDVCk7IFwKKyAgICB9IHdoaWxlICgwKQor
CitzdGF0aWMgdm9pZCBjaGVja19zZmNsYXNzKHZvaWQpCit7CisgICAgLyogWmVybzogbWFzayBi
aXQgMCAqLworICAgIFRFU1RfU0ZDTEFTUyhTRl96ZXJvLCAweDAxLCAxKTsKKyAgICBURVNUX1NG
Q0xBU1MoU0ZfemVyb19uZWcsIDB4MDEsIDEpOworICAgIFRFU1RfU0ZDTEFTUyhTRl96ZXJvLCAw
eDAyLCAwKTsKKworICAgIC8qIE5vcm1hbDogbWFzayBiaXQgMSAqLworICAgIFRFU1RfU0ZDTEFT
UyhTRl9vbmUsIDB4MDIsIDEpOworICAgIFRFU1RfU0ZDTEFTUyhTRl9vbmUsIDB4MDEsIDApOwor
CisgICAgLyogRGVub3JtYWw6IG1hc2sgYml0IDIgKi8KKyAgICBURVNUX1NGQ0xBU1MoU0ZfZGVu
b3JtLCAweDA0LCAxKTsKKyAgICBURVNUX1NGQ0xBU1MoU0ZfZGVub3JtLCAweDAxLCAwKTsKKwor
ICAgIC8qIEluZmluaXR5OiBtYXNrIGJpdCAzICovCisgICAgVEVTVF9TRkNMQVNTKFNGX0lORiwg
MHgwOCwgMSk7CisgICAgVEVTVF9TRkNMQVNTKFNGX0lORiwgMHgwMSwgMCk7CisKKyAgICAvKiBO
YU46IG1hc2sgYml0IDQgKi8KKyAgICBURVNUX1NGQ0xBU1MoU0ZfUU5hTiwgMHgxMCwgMSk7Cisg
ICAgVEVTVF9TRkNMQVNTKFNGX1NOYU4sIDB4MTAsIDEpOworICAgIFRFU1RfU0ZDTEFTUyhTRl9R
TmFOLCAweDAxLCAwKTsKKworICAgIC8qIENvbWJpbmVkOiBhbnkgY2xhc3MgKGFsbCBiaXRzIHNl
dCkgKi8KKyAgICBURVNUX1NGQ0xBU1MoU0Zfb25lLCAweDFmLCAxKTsKK30KKworLyoKKyAqIGRm
Y2xhc3MgbWFzayBiaXRzIGFyZSB0aGUgc2FtZSBhcyBzZmNsYXNzLgorICovCitzdGF0aWMgY29u
c3QgdWludDY0X3QgREZfSU5GID0gMHg3ZmYwMDAwMDAwMDAwMDAwVUxMOworc3RhdGljIGNvbnN0
IHVpbnQ2NF90IERGX2Rlbm9ybSA9IDB4MDAwMDAwMDAwMDAwMDAwMVVMTDsKK3N0YXRpYyBjb25z
dCB1aW50NjRfdCBERl9uZWdfb25lID0gMHhiZmYwMDAwMDAwMDAwMDAwVUxMOworCisjZGVmaW5l
IFRFU1RfREZDTEFTUyhWQUwsIE1BU0ssIEVYUEVDVCkgXAorICAgIGRvIHsgXAorICAgICAgICB1
aW50MzJfdCByZXM7IFwKKyAgICAgICAgYXNtKCIlW3Jlc10gPSAjMFxuXHQiIFwKKyAgICAgICAg
ICAgICJwMCA9IGRmY2xhc3MoJVt2YWxdLCAjIiAjTUFTSyAiKVxuXHQiIFwKKyAgICAgICAgICAg
ICJpZiAocDApICVbcmVzXSA9ICMxXG5cdCIgXAorICAgICAgICAgICAgOiBbcmVzXSAiPSZyIihy
ZXMpIFwKKyAgICAgICAgICAgIDogW3ZhbF0gInIiKFZBTCkgXAorICAgICAgICAgICAgOiAicDAi
KTsgXAorICAgICAgICBjaGVjazMyKHJlcywgRVhQRUNUKTsgXAorICAgIH0gd2hpbGUgKDApCisK
K3N0YXRpYyB2b2lkIGNoZWNrX2RmY2xhc3Modm9pZCkKK3sKKyAgICAvKiBaZXJvOiBtYXNrIGJp
dCAwICovCisgICAgVEVTVF9ERkNMQVNTKERGX3plcm8sIDB4MDEsIDEpOworICAgIFRFU1RfREZD
TEFTUyhERl96ZXJvX25lZywgMHgwMSwgMSk7CisgICAgVEVTVF9ERkNMQVNTKERGX3plcm8sIDB4
MDIsIDApOworCisgICAgLyogTm9ybWFsOiBtYXNrIGJpdCAxICovCisgICAgVEVTVF9ERkNMQVNT
KERGX29uZSwgMHgwMiwgMSk7CisgICAgVEVTVF9ERkNMQVNTKERGX25lZ19vbmUsIDB4MDIsIDEp
OworICAgIFRFU1RfREZDTEFTUyhERl9vbmUsIDB4MDEsIDApOworCisgICAgLyogRGVub3JtYWw6
IG1hc2sgYml0IDIgKi8KKyAgICBURVNUX0RGQ0xBU1MoREZfZGVub3JtLCAweDA0LCAxKTsKKyAg
ICBURVNUX0RGQ0xBU1MoREZfZGVub3JtLCAweDAxLCAwKTsKKworICAgIC8qIEluZmluaXR5OiBt
YXNrIGJpdCAzICovCisgICAgVEVTVF9ERkNMQVNTKERGX0lORiwgMHgwOCwgMSk7CisgICAgVEVT
VF9ERkNMQVNTKERGX0lORiwgMHgwMSwgMCk7CisKKyAgICAvKiBOYU46IG1hc2sgYml0IDQgKi8K
KyAgICBURVNUX0RGQ0xBU1MoREZfUU5hTiwgMHgxMCwgMSk7CisgICAgVEVTVF9ERkNMQVNTKERG
X1NOYU4sIDB4MTAsIDEpOworICAgIFRFU1RfREZDTEFTUyhERl9RTmFOLCAweDAxLCAwKTsKK30K
KworLyogUmRkID0gY29udmVydF91dzJkZihScykgKi8KK3N0YXRpYyB1aW50NjRfdCBjb252X3V3
MmRmKHVpbnQzMl90IHZhbCkKK3sKKyAgICB1aW50NjRfdCByZXN1bHQ7CisKKyAgICBhc20oIiVb
cmVzXSA9IGNvbnZlcnRfdXcyZGYoJVt2YWxdKVxuXHQiCisgICAgICAgIDogW3Jlc10gIj1yIihy
ZXN1bHQpCisgICAgICAgIDogW3ZhbF0gInIiKHZhbCkpOworICAgIHJldHVybiByZXN1bHQ7Cit9
CisKK3N0YXRpYyB2b2lkIGNoZWNrX2NvbnZfdXcyZGYodm9pZCkKK3sKKyAgICBjaGVjazY0KGNv
bnZfdXcyZGYoMCksIERGX3plcm8pOworICAgIGNoZWNrNjQoY29udl91dzJkZigxKSwgREZfb25l
KTsKKyAgICAvKiAxMDAgLT4gMHg0MDU5MDAwMDAwMDAwMDAwICovCisgICAgY2hlY2s2NChjb252
X3V3MmRmKDEwMCksIDB4NDA1OTAwMDAwMDAwMDAwMFVMTCk7CisgICAgLyogMHhGRkZGRkZGRiAt
PiA0Mjk0OTY3Mjk1LjAgPSAweDQxRUZGRkZGRkZFMDAwMDAgKi8KKyAgICBjaGVjazY0KGNvbnZf
dXcyZGYoMHhGRkZGRkZGRiksIDB4NDFFRkZGRkZGRkUwMDAwMFVMTCk7Cit9CisKKy8qIFJkZCA9
IGNvbnZlcnRfdWQyZGYoUnNzKSAqLworc3RhdGljIHVpbnQ2NF90IGNvbnZfdWQyZGYodWludDY0
X3QgdmFsKQoreworICAgIHVpbnQ2NF90IHJlc3VsdDsKKworICAgIGFzbSgiJVtyZXNdID0gY29u
dmVydF91ZDJkZiglW3ZhbF0pXG5cdCIKKyAgICAgICAgOiBbcmVzXSAiPXIiKHJlc3VsdCkKKyAg
ICAgICAgOiBbdmFsXSAiciIodmFsKSk7CisgICAgcmV0dXJuIHJlc3VsdDsKK30KKworc3RhdGlj
IHZvaWQgY2hlY2tfY29udl91ZDJkZih2b2lkKQoreworICAgIGNoZWNrNjQoY29udl91ZDJkZigw
VUxMKSwgREZfemVybyk7CisgICAgY2hlY2s2NChjb252X3VkMmRmKDFVTEwpLCBERl9vbmUpOwor
ICAgIC8qIDEwMDAwMDAgLT4gMHg0MTJFODQ4MDAwMDAwMDAwICovCisgICAgY2hlY2s2NChjb252
X3VkMmRmKDEwMDAwMDBVTEwpLCAweDQxMkU4NDgwMDAwMDAwMDBVTEwpOworfQorCisvKiBSZGQg
PSBkZm1weWZpeChSc3MsUnR0KSAtLSBERiBtdWx0aXBseSBkZW5vcm1hbCBmaXh1cCAqLworc3Rh
dGljIHVpbnQ2NF90IGRvX2RmbXB5Zml4KHVpbnQ2NF90IGEsIHVpbnQ2NF90IGIpCit7CisgICAg
dWludDY0X3QgcmVzdWx0OworCisgICAgYXNtKCIlW3Jlc10gPSBkZm1weWZpeCglW2FdLCAlW2Jd
KVxuXHQiCisgICAgICAgIDogW3Jlc10gIj1yIihyZXN1bHQpCisgICAgICAgIDogW2FdICJyIihh
KSwgW2JdICJyIihiKSk7CisgICAgcmV0dXJuIHJlc3VsdDsKK30KKworc3RhdGljIHZvaWQgY2hl
Y2tfZGZtcHlmaXgodm9pZCkKK3sKKyAgICAvKgorICAgICAqIFdpdGggdHdvIG5vcm1hbCB2YWx1
ZXMgKG5laXRoZXIgZGVub3JtYWwsIGV4cHMgPCA1MTIpLAorICAgICAqIHRoZSByZXN1bHQgc2hv
dWxkIGJlIHRoZSBmaXJzdCBvcGVyYW5kIHVuY2hhbmdlZC4KKyAgICAgKi8KKyAgICBjaGVjazY0
KGRvX2RmbXB5Zml4KERGX29uZSwgREZfb25lKSwgREZfb25lKTsKKworICAgIC8qCisgICAgICog
Q2FzZTogYiBpcyBkZW5vcm1hbCBBTkQgYSBpcyBub3JtYWwgd2l0aCBleHAgPj0gNTEyLgorICAg
ICAqIGEgZ2V0cyBtdWx0aXBsaWVkIGJ5IDJeLTUyICgweDNjYjAwMDAwMDAwMDAwMDApLgorICAg
ICAqIGEgPSAxLjAsIHJlc3VsdCA9IDEuMCAqIDJeLTUyID0gMHgzY2IwMDAwMDAwMDAwMDAwCisg
ICAgICovCisgICAgY2hlY2s2NChkb19kZm1weWZpeChERl9vbmUsIERGX2Rlbm9ybSksIDB4M0NC
MDAwMDAwMDAwMDAwMFVMTCk7CisKKyAgICAvKgorICAgICAqIENhc2U6IGEgaXMgZGVub3JtYWwg
QU5EIGIgaXMgbm9ybWFsIHdpdGggZXhwID49IDUxMi4KKyAgICAgKiBhIGdldHMgbXVsdGlwbGll
ZCBieSAyXjUyICgweDQzMzAwMDAwMDAwMDAwMDApLgorICAgICAqIGEgPSBzbWFsbGVzdCBkZW5v
cm0gPSAyXi0xMDc0LCBiID0gMl41MTIgKGJpYXNlZCBleHAgMHg1ZmYpLgorICAgICAqIFJlc3Vs
dCA9IDJeLTEwNzQgKiAyXjUyID0gMl4tMTAyMiA9IHNtYWxsZXN0IG5vcm1hbAorICAgICAqICAg
ICAgICA9IDB4MDAxMDAwMDAwMDAwMDAwMAorICAgICAqLworICAgIGNoZWNrNjQoZG9fZGZtcHlm
aXgoREZfZGVub3JtLCAweDVGRjAwMDAwMDAwMDAwMDBVTEwpLAorICAgICAgICAgICAgMHgwMDEw
MDAwMDAwMDAwMDAwVUxMKTsKK30KKwogaW50IG1haW4oKQogewogICAgIGNoZWNrX2NvbXBhcmVf
ZXhjZXB0aW9uKCk7CkBAIC03MjUsNiArODk1LDExIEBAIGludCBtYWluKCkKICAgICBjaGVja19m
bG9hdDJpbnRfY29udnMoKTsKICAgICBjaGVja19mbG9hdF9jb25zdHMoKTsKICAgICBjaGVja19k
Zm1weXh4KCk7CisgICAgY2hlY2tfc2ZjbGFzcygpOworICAgIGNoZWNrX2RmY2xhc3MoKTsKKyAg
ICBjaGVja19jb252X3V3MmRmKCk7CisgICAgY2hlY2tfY29udl91ZDJkZigpOworICAgIGNoZWNr
X2RmbXB5Zml4KCk7CiAKICAgICBwdXRzKGVyciA/ICJGQUlMIiA6ICJQQVNTIik7CiAgICAgcmV0
dXJuIGVyciA/IDEgOiAwOwotLSAKMi4zNC4xCgo=

