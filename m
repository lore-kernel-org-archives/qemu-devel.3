Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7846FC98325
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 01:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9v9t-0005DN-Q4; Thu, 24 Sep 2026 21:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9r-0005Cn-Gt
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:55:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9o-00066Z-V9
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:55:27 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P1l38e3186958
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:55:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eoZnPMfgh/uoiNhVRO9ZE3BANiXO18FNesirNIySkCQ=; b=E1BkFjwLiObzOWSG
 /rSLNh4WwtZFIGFyZ4RydKRovF1b1KO2W6CqHoi7ETqtpas/op/IYIHoeLaH5x6h
 t83oz1MLl5jD+EttRjK8JmCXoYQS5H/o4oGbH54pxkMKZGglDzph02ozpHq3ehS3
 kVCXoo1I6nh5WbVwmCYkhiuhacYlfYzNsqjsxsqagA4YNki1Ufgq6kLc7omd16eN
 VN5/Cz1cpy+G2jYNdgZk0ycoTg+UrKCc0IgEDF5FQud5A3s0wQBhy1BIGRko84Rj
 n0XpFjH50sn1IZBtg1uVQneUCTe9hV7jheOO8d+CMfWkJD4t0jcu22Xi5OfcKK8N
 LAZP9Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1t7ucpx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:55:13 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c0d568830so722848eec.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 18:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790301313; x=1790906113; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eoZnPMfgh/uoiNhVRO9ZE3BANiXO18FNesirNIySkCQ=;
 b=j5DQsQcy2xJIBB1lwu0fhtvfh427rcVhGohi3nUW7icFN1yQqBqbcyuMlL30JY/Aap
 00FX8P9TT7PjPDjSk0D2K/pMAjkQ2JN8/iQX+FoIebZA+KNQKvA4fyhnzUMJxvlJJBAp
 mJ9ZdRvRabrQr0HarcJZ2IQ5ely5PD01VILBUWTm+7jBIuSfQY9RyVa5tG81TIkG+MYT
 /ozs6JUxCS7Ev7hAfLx5g0zT1HAUvBv/t4Tm28rG9o97XarzWQJGd/POsyqhycFCzn4+
 GQ0PbIeinH3aUU9DqXfRM2EkmeQGGc5mkcIw1X50GWAzFo2KLuG1QGg7diCBHzDK6Hkc
 Yifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790301313; x=1790906113;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eoZnPMfgh/uoiNhVRO9ZE3BANiXO18FNesirNIySkCQ=;
 b=tA+gP5n7HUkQwMD1dvolGGiINzKZNZopUK7wjfJT6gdl17glMnW/hBfUPiZ8LnN3KU
 VY5WHUduz1KZ9nOjYAWtKfAC1mS7SjnWas5vWEaamyVADpMkURbQCLQLSOw0XRUNj5cG
 uD7ZDGau45jN3ao7jKSP/EzypHHF98/TOtv/drSbP70lqKv2Eu/rxVEFRjK2roKAw51F
 f6XjhWfYNtsFY6Y9r+OZt0tN5ohu+0rDnHoK5YVU4ohc44Q85kIP+Fdzeg5VZZGyeioP
 09oSYGC1iG1NvF/iznwM3BnreAm4bBX7EZ3W7tjx6C2WlLMuH6jS+GgDi0wFYoUB7R1B
 rtXw==
X-Gm-Message-State: AFuF++l902ivm1zhMlqNS7rcJmBqx6oOsiz8N4ancKtKN7tNV0u97C9I
 lnqKuI4U/WRUCzWy37cfIZ7b+7YsCD7JIuCC6AAPn2kbPtyOvsfRdnhK93ch8c+VkoYJMFvjPEN
 KFsVT5/F8mXAgCHzIBlXikXq5BlyPxpZmmztNxqqzwLo9DuBGopBSQhVa2GIRUo8d1w==
X-Gm-Gg: AYBFou0IZOWvkWCBURFajXeNEHppo8+jAminGclcBQSIHSA3dCcp/ojQOYqgt9Z3nzW
 1mYbVpENN3klbBnIce3n/4/QlvigWy+ht0z0KfPMIw4ZBYKYoa0XH9ICLsqcb70TH452iQhrxLf
 nCpzPtj8nCAZJUeh38D81UMJOF3qRPS9g+Z7auWqBfHG1JcPPVkfXP1Js9l6cq4erMxKPTU3+ej
 6rrz5nRAyv8RPttDCVFeMAlmGwv3ld2uL4Rs+2IEQw9o0YdJ/wwntVS0ghM9S1H7fQ3HoVX5NXp
 OmffMlg8HswnPlFocC519DxQ9ZYJ3ao+bCraVwX1IPTmyRxy90lsK9TYcuIvau82PwbSARcz/rU
 Q4yc/jKyiDonxvokb3J00hBpMFpmoLE4BOwsNH/mK9lD+qd0=
X-Received: by 2002:a05:7300:d0aa:b0:33c:e8f:5701 with SMTP id
 5a478bee46e88-34000f2d481mr2998995eec.34.1790301312563; 
 Thu, 24 Sep 2026 18:55:12 -0700 (PDT)
X-Received: by 2002:a05:7300:d0aa:b0:33c:e8f:5701 with SMTP id
 5a478bee46e88-34000f2d481mr2998987eec.34.1790301311937; 
 Thu, 24 Sep 2026 18:55:11 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3416e4c2f50sm1873720eec.27.2026.09.24.18.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 18:55:10 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 25/40] tests/tcg/hexagon: add rounding conv, sffma:lib,
 and sfinvsqrta
Date: Thu, 24 Sep 2026 18:54:14 -0700
Message-Id: <20260925015429.2579174-26-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
References: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: xNhSfSvy0JEDhdOBJpLFl3VC1NMd4PkB
X-Authority-Analysis: v=2.4 cv=U/MHnuru c=1 sm=1 tr=0 ts=6ab5d481 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Yw4lSlXxLJphHwZ-g9MA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX6xewIZs6a99z
 NQ/3KrXWoF6cd4zMKVThAlA3reF5UuoGTMGID/RcXwB9IxX9I98z5MwQtieQZVyvqCzwg/LYP0T
 c1Ew0Fr1CWSxn/b5m7q04kFClhRNrN+pYxEA6QabOctKahfiCPMhuleZi2dtwUxTyKdc170KhZz
 aGkIEGaeU8EUKeXwHhFTaygzzXL18R+NZj/kOC6vTTJPckELDUz4L0PbKkOlJoNMM4QkW/xEi8C
 ZY48iVucgms3OJOFKq1BIhErHTc1p1YlpLn9ZprbOA3EYjp1XlBaLPcAHXDAsmB/Vju5dDl6gjV
 4VjoP2bwt4PFZc1PW4G4SERPCfGxgwVvNp+l/xTP/Ii3TlBEAVrNYhGBQG0Q+zGaoZrKoUBWPMh
 qB1TJRHWgyNBUfzRwYhP6Awbfqf+7TRTvjX8Bwg9iIeDzZ99Uth/486Cg2ebH1AetTwsDRK5A/B
 WanmSYW4op83QqsDUlA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX1f/NRiJqYkrt
 rUVt17//0naILFEfe+iym1qVVn9KWGbOdRjyeKyLVPBeM2jEVeLXljPzcrb5GQrb5CZs4N/1WAb
 8moJTykoPfOtOBJ/O5rJt/rXddkkuUo=
X-Proofpoint-ORIG-GUID: xNhSfSvy0JEDhdOBJpLFl3VC1NMd4PkB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250007
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

QWRkIHJvdW5kLXRvLW5lYXJlc3QgZmxvYXQtdG8taW50IGNvbnZlcnNpb24gdGVzdHMgZm9yIHRo
ZSBub24tOmNob3AgdmFyaWFudHMsCnNmbXB5OmxpYiB3aXRoIEluZi1JbmYgdG8gdmVyaWZ5IGV4
Y2VwdGlvbiBzdXBwcmVzc2lvbiwgYW5kIHNmaW52c3FydGEKd2l0aCBhIGRlbm9ybWFsIGlucHV0
LgoKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1
YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVh
bGNvbW0uY29tPgotLS0KIHRlc3RzL3RjZy9oZXhhZ29uL2Zwc3R1ZmYuYyB8IDk5ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA5OSBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vZnBzdHVmZi5jIGIvdGVzdHMv
dGNnL2hleGFnb24vZnBzdHVmZi5jCmluZGV4IDBmMjhhMjE4ZDg0Li45ZWE3OWM2MTdkOSAxMDA2
NDQKLS0tIGEvdGVzdHMvdGNnL2hleGFnb24vZnBzdHVmZi5jCisrKyBiL3Rlc3RzL3RjZy9oZXhh
Z29uL2Zwc3R1ZmYuYwpAQCAtMTAxNyw2ICsxMDE3LDEwMiBAQCBzdGF0aWMgdm9pZCBjaGVja19k
Zm1weWhoKHZvaWQpCiAgICAgY2hlY2s2NF9uZShkZl9leHAocmVzdWx0KSwgMHg3RkYwMDAwMDAw
MDAwMDAwVUxMKTsKIH0KIAorLyoKKyAqIFJvdW5kLXRvLW5lYXJlc3QgZmxvYXQtdG8taW50IGNv
bnZlcnNpb25zIHdpdGggbm9ybWFsIHZhbHVlcy4KKyAqIFRoZXNlIHRlc3QgdGhlIG5vbi06Y2hv
cCB2YXJpYW50cyB3aGljaCB1c2UgdGhlIFVTUiByb3VuZGluZyBtb2RlLgorICovCitzdGF0aWMg
dm9pZCBjaGVja19jb252X3JuZCh2b2lkKQoreworICAgIHVpbnQzMl90IHJlczMyOworICAgIHVp
bnQ2NF90IHJlczY0OworCisgICAgLyogY29udmVydF9zZjJ3KDEuNSkgcm91bmRzIHRvIG5lYXJl
c3QtZXZlbiA9IDIgKi8KKyAgICBhc20oQ0xFQVJfRlBTVEFUVVMKKyAgICAgICAgIiVbcmVzXSA9
IGNvbnZlcnRfc2YydyglW3ZhbF0pXG5cdCIKKyAgICAgICAgOiBbcmVzXSAiPXIiKHJlczMyKQor
ICAgICAgICA6IFt2YWxdICJyIigweDNmYzAwMDAwKSAgICAvKiAxLjVmICovCisgICAgICAgIDog
InIyIiwgInVzciIpOworICAgIGNoZWNrMzIocmVzMzIsIDIpOworCisgICAgLyogY29udmVydF9z
ZjJkKDEuNSkgPSAyICovCisgICAgYXNtKENMRUFSX0ZQU1RBVFVTCisgICAgICAgICIlW3Jlc10g
PSBjb252ZXJ0X3NmMmQoJVt2YWxdKVxuXHQiCisgICAgICAgIDogW3Jlc10gIj1yIihyZXM2NCkK
KyAgICAgICAgOiBbdmFsXSAiciIoMHgzZmMwMDAwMCkgICAgLyogMS41ZiAqLworICAgICAgICA6
ICJyMiIsICJ1c3IiKTsKKyAgICBjaGVjazY0KHJlczY0LCAyVUxMKTsKKworICAgIC8qIGNvbnZl
cnRfZGYydygxLjUpID0gMiAqLworICAgIGFzbShDTEVBUl9GUFNUQVRVUworICAgICAgICAiJVty
ZXNdID0gY29udmVydF9kZjJ3KCVbdmFsXSlcblx0IgorICAgICAgICA6IFtyZXNdICI9ciIocmVz
MzIpCisgICAgICAgIDogW3ZhbF0gInIiKDB4M0ZGODAwMDAwMDAwMDAwMFVMTCkgICAgLyogMS41
ICovCisgICAgICAgIDogInIyIiwgInVzciIpOworICAgIGNoZWNrMzIocmVzMzIsIDIpOworCisg
ICAgLyogY29udmVydF9kZjJkKDEuNSkgPSAyICovCisgICAgYXNtKENMRUFSX0ZQU1RBVFVTCisg
ICAgICAgICIlW3Jlc10gPSBjb252ZXJ0X2RmMmQoJVt2YWxdKVxuXHQiCisgICAgICAgIDogW3Jl
c10gIj1yIihyZXM2NCkKKyAgICAgICAgOiBbdmFsXSAiciIoMHgzRkY4MDAwMDAwMDAwMDAwVUxM
KSAgICAvKiAxLjUgKi8KKyAgICAgICAgOiAicjIiLCAidXNyIik7CisgICAgY2hlY2s2NChyZXM2
NCwgMlVMTCk7Cit9CisKKy8qCisgKiBUZXN0IHNmbXB5OmxpYiB3aXRoIEluZi1JbmYuCisgKgor
ICogUnggKz0gc2ZtcHkoUnMsIFJ0KTpsaWIgd2l0aCBSeCA9IC1JbmYsIFJzKlJ0IC0+ICtJbmYK
KyAqIEluZiAtIEluZiBpcyBpbnZhbGlkLCBidXQgdGhlIDpsaWIgdmFyaWFudCBzdXBwcmVzc2Vz
IHRoZQorICogZXhjZXB0aW9uIGFuZCByZXR1cm5zIHplcm8uCisgKi8KK3N0YXRpYyB2b2lkIGNo
ZWNrX3NmZm1hX2xpYl9pbmYodm9pZCkKK3sKKyAgICB1aW50MzJfdCByZXN1bHQ7CisKKyAgICAv
KiArSW5mICs9IHNmbXB5KCtJbmYsIDEuMCk6bGliIC0+IEluZiAobm8gZXhjZXB0aW9uLCBub3Jt
YWwpICovCisgICAgcmVzdWx0ID0gU0ZfSU5GOworICAgIGFzbShDTEVBUl9GUFNUQVRVUworICAg
ICAgICAiJVtyZXNdICs9IHNmbXB5KCVbYV0sICVbYl0pOmxpYlxuXHQiCisgICAgICAgIDogW3Jl
c10gIityIihyZXN1bHQpCisgICAgICAgIDogW2FdICJyIihTRl9JTkYpLCBbYl0gInIiKFNGX29u
ZSkKKyAgICAgICAgOiAicjIiLCAidXNyIik7CisgICAgY2hlY2szMihyZXN1bHQsIFNGX0lORik7
CisKKyAgICAvKgorICAgICAqIC1JbmYgKz0gc2ZtcHkoK0luZiwgMS4wKTpsaWIgLT4gSW5mIC0g
SW5mID0gaW52YWxpZAorICAgICAqIFRoZSA6bGliIHZhcmlhbnQgc2hvdWxkIHJldHVybiB6ZXJv
IGZvciBJbmYgLSBJbmYuCisgICAgICovCisgICAgcmVzdWx0ID0gU0ZfSU5GIHwgKDF1IDw8IDMx
KTsgICAgLyogLUluZiAqLworICAgIGFzbShDTEVBUl9GUFNUQVRVUworICAgICAgICAiJVtyZXNd
ICs9IHNmbXB5KCVbYV0sICVbYl0pOmxpYlxuXHQiCisgICAgICAgIDogW3Jlc10gIityIihyZXN1
bHQpCisgICAgICAgIDogW2FdICJyIihTRl9JTkYpLCBbYl0gInIiKFNGX29uZSkKKyAgICAgICAg
OiAicjIiLCAidXNyIik7CisgICAgY2hlY2szMihyZXN1bHQsIDApOworfQorCisvKgorICogVGVz
dCBzZmludnNxcnRhIHdpdGggYSBkZW5vcm1hbCBpbnB1dC4KKyAqLworc3RhdGljIHZvaWQgY2hl
Y2tfaW52c3FydGFfZGVub3JtKHZvaWQpCit7CisgICAgdWludDMyX3QgcmVzdWx0OworICAgIHVp
bnQzMl90IHByZWR2YWw7CisgICAgdWludDMyX3QgZXhwX2JpdHM7CisKKyAgICAvKiBEZW5vcm1h
bCBwb3NpdGl2ZSBmbG9hdDogMHgwMDQwMDAwMCAoc21hbGwgZGVub3JtKSAqLworICAgIGFzbSB2
b2xhdGlsZSgiJVtyZXNdLHAwID0gc2ZpbnZzcXJ0YSglW3ZhbF0pXG5cdCIKKyAgICAgICAgICAg
ICAgICAgIiVbcHJlZF0gPSBwMFxuXHQiCisgICAgICAgICAgICAgICAgIDogW3Jlc10gIj1yIihy
ZXN1bHQpLCBbcHJlZF0gIj1yIihwcmVkdmFsKQorICAgICAgICAgICAgICAgICA6IFt2YWxdICJy
IihTRl9kZW5vcm0pCisgICAgICAgICAgICAgICAgIDogInAwIik7CisgICAgLyogUmVzdWx0IHNo
b3VsZCBiZSBhIHZhbGlkIGZsb2F0IChub3QgTmFOL3plcm8pICovCisgICAgY2hlY2szMl9uZShy
ZXN1bHQsIDApOworICAgIGV4cF9iaXRzID0gKHJlc3VsdCA+PiAyMykgJiAweGZmOworICAgIGNo
ZWNrMzJfbmUoZXhwX2JpdHMsIDB4ZmYpOyAgLyogbm90IEluZi9OYU4gKi8KK30KKwogaW50IG1h
aW4oKQogewogICAgIGNoZWNrX2NvbXBhcmVfZXhjZXB0aW9uKCk7CkBAIC0xMDM4LDYgKzExMzQs
OSBAQCBpbnQgbWFpbigpCiAgICAgY2hlY2tfY29udl91ZDJkZigpOwogICAgIGNoZWNrX2RmbXB5
Zml4KCk7CiAgICAgY2hlY2tfZGZtcHloaCgpOworICAgIGNoZWNrX2NvbnZfcm5kKCk7CisgICAg
Y2hlY2tfc2ZmbWFfbGliX2luZigpOworICAgIGNoZWNrX2ludnNxcnRhX2Rlbm9ybSgpOwogCiAg
ICAgcHV0cyhlcnIgPyAiRkFJTCIgOiAiUEFTUyIpOwogICAgIHJldHVybiBlcnIgPyAxIDogMDsK
LS0gCjIuMzQuMQoK

