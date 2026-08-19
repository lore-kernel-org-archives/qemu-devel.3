Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A330AC5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwfvo-0000hB-Rb; Wed, 19 Aug 2026 09:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwfvl-0000gx-3O
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 09:02:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwfvi-0001ZJ-Kj
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 09:02:08 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JD0EjP693386
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 13:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=zlP7EkHcWTHqkw1EMJy6AY
 NxGBeaLX/goTg/6PGgEEQ=; b=IMbdb/TeuDWSSYSFvMDciptMggKTbWnwY79KRh
 /klmc6HFLsZ8QB9REqNUDu7B2RWcaUiVhTn5FDkwoMRifRkmeH6vhdGERQdBXUNu
 pp1A9ZmW4qcFRGzQJhBr6kxRMwsLhTXL2fwdRW0dDXgp0tO9EPRi6NBZIVEa2ULR
 1gdHo/fa7fkTPhFpR8IMJa2zVgYv5K2GTazJEKvDlIaSxRabgl31dhxg0B7BQep5
 +/JHpCLvFvkESxd3brojh6ufM6TuH/3fnBFRv+YZ9uUKk33z1VNTnp0QluH8RdJb
 FEqa5YBaD84Jhl4U8CqYqd5Cin3LgFpNHprnO0y6bxerjyfQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfmb90f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 13:02:04 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e22137fb3so1858849a91.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 06:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787144524; x=1787749324; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zlP7EkHcWTHqkw1EMJy6AYNxGBeaLX/goTg/6PGgEEQ=;
 b=OomYjW98gVE761UlnA6QCezUanJOplklyqY5fgctrEhXhn4s+NG5GLYrVv3IsHYbMM
 0Yo8UEeRhFX5aHEekiZDjRNkaN2ay+KWLtt+wbQUyjGx2+CulRA5xlV+GbpxTxWdkM9P
 l4MAr8bZgOLTCKQ3pG684VYl/jm3P5FKyx6Tf+rUe3oipykLfCHOydpAVga4/GsHAAZz
 +v0NhKlW8nK5zMUvVzwWC9uaY073ZyADDoCuVGSwMZGrI2FZbQx7QQdUGZ09qASfwUbk
 cobc7YTNUWHJbdK2Hyrzrp05lt8yEQ4P7KT8ukbBJJk+zF6qvlA4QKd19l4kxbVKBGdX
 EIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787144524; x=1787749324;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zlP7EkHcWTHqkw1EMJy6AYNxGBeaLX/goTg/6PGgEEQ=;
 b=ofbtk/yWpXKRqINYmyYvbxgNSD25RAEbSRHJdq7D+hVfGSCjOVtTY17ThM0HQyO/fA
 JltwQxLrNtRihv6S2C43Mtac+fKSVK7z0T08o/7YyUN6OtwhM0r30RteFluM9bIQtwQR
 k+IDpV0IwHowD10nKxco3tRwiRiGtZxoThuomHsR0LeNOap8e1qEf19S4+F2tPvg0yV3
 Y2RtaecSD9pY6+yiYk3WqdG4vw97yeHSTJpbVh3IWwVBvF+/HceqTwALQKFkifzODwus
 M4owEZAH5AzKOCWR9abPnwYlkexUIPUZPT84l1pe/UYX758SdESt/P3EhKYqDIPGSz5E
 rFSw==
X-Gm-Message-State: AFuF++m8uM/CyQdCsbHXiIA15QaPOx+yaJSi+ERzTIJlW7SyLAiy//Zr
 VIrwHwyJj3JKXK+G+EvPs4xlkMe2pA+b5RYlDo62CBGP21YgwakO8XNQvQZXJV2WiadmXP45HFf
 6TrQ/sJqhQjv+XMd8jWtFGicOAUoXqRkpj1hZqMG2iosOoqfW+KNxcnz2MD7VYz7W7w==
X-Gm-Gg: AR+sD13HFPZf9A1jEoCUgNuX6FpOHDudcJuT6V5t7TnrNZHv90dJxwBg7rrHoIDHqSo
 PACtHwTM/K4retS/8R0TVrkz1+SmRieUZ1bW9OVc5ziDqIRRu10Od3Tq7paB1Cn3BvOx86GXZSz
 B8fZo4y7KriZFkqXJP6cHLa+kDH47rGgigBnaSwqG+Z2AS3EHLToBdj7tIFZBPu+vHN1IsYMcvj
 mA2Gq0BnC6sAcxfBVNmkIMpIET5E6V3VZ30WvKV64r54VKcO9aifEBKmf12wp1f5TpUFy48A1E0
 5YVlmxG4YSAAn4inf3+sfB4ckrnYKRR3ShQzMFDVrBawTzhu6P6w9VPLlfqdbT4yB8fpdxVvDRD
 0HcwlBoSpMbsUmVtjKgU3yW/Kn8MKykJTuBDyi1t/vlyRk7DH
X-Received: by 2002:a17:90b:3b41:b0:38e:4114:d8c7 with SMTP id
 98e67ed59e1d1-3958049908amr8542379a91.0.1787144523897; 
 Wed, 19 Aug 2026 06:02:03 -0700 (PDT)
X-Received: by 2002:a17:90b:3b41:b0:38e:4114:d8c7 with SMTP id
 98e67ed59e1d1-3958049908amr8542233a91.0.1787144523312; 
 Wed, 19 Aug 2026 06:02:03 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d5c1ee476bsm23377015ad.75.2026.08.19.06.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 06:02:02 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH] hw/hexagon: decode an empty TLB size field as 4KB
Date: Wed, 19 Aug 2026 06:02:01 -0700
Message-Id: <20260819130201.4067696-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: g2KAQ2VmvPKvZk7GdvhHQcVub0QnU0kq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwMCBTYWx0ZWRfX2QWaXIPT4RnV
 C7+xt8TvCMHCz2i/tI9IH5hG4rCJ51Hh+yoop02trm/TlEgi2XL2xU/c2tHEHZX90RZPu6tlgLQ
 nsLdU0fqFGTnoN9yNltszdY8Mvmdk2o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwMCBTYWx0ZWRfX6PZ+/kot6BeW
 AuF+xUxiXXpxsLYMo6HIAsLCSi5zbO97yyHanS9SaSXOLZIy/TEuZ2J/28FcAQ+fO/g+6rfk86Y
 0PzSNy1asNHfSM+SwcmDSD7SBECDGJyJ5vfxSS2Q7rZg5f43BLHVQ6+UCKO9Xgp/1P2+zxqnmip
 olVtZ9/eJdNr0efsHpdhh351N22ZFycUdLHXqwayF8nG/qXBH6Fq9/woyDFvnZ2ox038L9Gg8oH
 Jy+WLgJpClsjpgKcqNUcUWpn4lq4idxl1BHrhU1Q3KoJel0FTTaR+RnNybdy7wRTRTMiFy1okHn
 IKSxXrxX8PNHWglMmu9GgZa96MDLW1kielltJUL/MFJBVzFvrPJYRcSKqPxDnyzynVKPuvh2VHs
 YgTJgyhyBSbaGryleOAsZFXukXr3omG/muC9m2iofWI/+6M/rPY230OF1OXMg98yU+63UpK/tQh
 a3KtBIVjiBUMA54gcMw==
X-Authority-Analysis: v=2.4 cv=aNrAb79m c=1 sm=1 tr=0 ts=6a85a94c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=41wnHuTSjj-I1xIrTVIA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: g2KAQ2VmvPKvZk7GdvhHQcVub0QnU0kq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190100
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

aGV4X3RsYl9wZ3NpemVfdHlwZSgpIGRlY29kZWQgYSBUTEIgZW50cnkncyBwYWdlIHNpemUgYnkg
c2Nhbm5pbmcgZm9yCnRoZSBsb3dlc3Qgc2V0IGJpdCBhY3Jvc3MgdGhlIGVudHJ5IHdpdGggY3R6
LgoKQSBndWVzdCBUTEIgd3JpdGUgd2l0aCBhbiBlbXB0eSBQUERbOTowXSBzaXplIGZpZWxkIGJ1
dCBhbnkgb3RoZXIgYml0CnNldCBjYXVzZWQgYW4gYXNzZXJ0aW9uLgoKU2lnbmVkLW9mZi1ieTog
QnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGh3L2hleGFnb24v
aGV4YWdvbl90bGIuYyB8IDI0ICsrKysrKysrKysrKysrLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5n
ZWQsIDE0IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2h3L2hl
eGFnb24vaGV4YWdvbl90bGIuYyBiL2h3L2hleGFnb24vaGV4YWdvbl90bGIuYwppbmRleCBiNmQ0
YWZmMzg5ZS4uYWFhMGI5NGZjY2QgMTAwNjQ0Ci0tLSBhL2h3L2hleGFnb24vaGV4YWdvbl90bGIu
YworKysgYi9ody9oZXhhZ29uL2hleGFnb25fdGxiLmMKQEAgLTY5LDggKzY5LDYgQEAgc3RhdGlj
IGNvbnN0IGNoYXIgKnBnc2l6ZV9zdHJbTlVNX1BHU0laRV9UWVBFU10gPSB7CiAgICAgIjFHIiwK
IH07CiAKLSNkZWZpbmUgSU5WQUxJRF9NQVNLIDB4ZmZmZmZmZmZMTAotCiBzdGF0aWMgY29uc3Qg
dWludDY0X3QgZW5jbWFza18yX21hc2tbXSA9IHsKICAgICAweDBmZmZMTCwgICAgICAgICAgICAg
ICAgICAgICAgICAgICAvKiA0aywgICAwMDAwICovCiAgICAgMHgzZmZmTEwsICAgICAgICAgICAg
ICAgICAgICAgICAgICAgLyogMTZrLCAgMDAwMSAqLwpAQCAtODIsMTkgKzgwLDI1IEBAIHN0YXRp
YyBjb25zdCB1aW50NjRfdCBlbmNtYXNrXzJfbWFza1tdID0gewogICAgIDB4M2ZmZmZmZkxMLCAg
ICAgICAgICAgICAgICAgICAgICAgIC8qIDY0bSwgIDAxMTEgKi8KICAgICAweGZmZmZmZmZMTCwg
ICAgICAgICAgICAgICAgICAgICAgICAvKiAyNTZtLCAxMDAwICovCiAgICAgMHgzZmZmZmZmZkxM
LCAgICAgICAgICAgICAgICAgICAgICAgLyogMWcsICAgMTAwMSAqLwotICAgIElOVkFMSURfTUFT
SywgICAgICAgICAgICAgICAgICAgICAgIC8qIFJTVkQsIDEwMTAgKi8KIH07CiAKKy8qCisgKiBU
aGUgcGFnZSBzaXplIGlzIGVuY29kZWQgYXMgdGhlIHBvc2l0aW9uIG9mIHRoZSBsb3dlc3Qgc2V0
IGJpdCBvZgorICogUFBEWzk6MF0uICBCaXRzIG91dHNpZGUgdGhhdCBmaWVsZCBiZWxvbmcgdG8g
dGhlIGNhY2hlYWJpbGl0eSBhbmQKKyAqIHBlcm1pc3Npb24gZmllbGRzIGFuZCBtdXN0IG5vdCB0
YWtlIHBhcnQgaW4gdGhlIGRlY29kZS4gIEFuIGFsbC16ZXJvCisgKiBmaWVsZCBkZW5vdGVzIHRo
ZSBzbWFsbGVzdCBwYWdlLCBtYXRjaGluZyBnZXRfcGdzaXplKCkgaW4gdGhlIHJlZmVyZW5jZQor
ICogc2ltdWxhdG9yLgorICovCisjZGVmaW5lIFBHU0laRV9GSUVMRF9NQVNLICgoMSA8PCBOVU1f
UEdTSVpFX1RZUEVTKSAtIDEpCisKIHN0YXRpYyBpbmxpbmUgdGxiX3Bnc2l6ZV90IGhleF90bGJf
cGdzaXplX3R5cGUodWludDY0X3QgZW50cnkpCiB7Ci0gICAgaWYgKGVudHJ5ID09IDApIHsKLSAg
ICAgICAgcWVtdV9sb2dfbWFzayhDUFVfTE9HX01NVSwgIiVzOiBTdXBwbGllZCBUTEIgZW50cnkg
d2FzIDAhXG4iLAotICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fKTsKLSAgICAgICAgcmV0
dXJuIDA7CisgICAgdWludDMyX3QgZmllbGQgPSBHRVRfUFRFX1BQRChlbnRyeSkgJiBQR1NJWkVf
RklFTERfTUFTSzsKKworICAgIGlmIChmaWVsZCA9PSAwKSB7CisgICAgICAgIHJldHVybiBQR1NJ
WkVfNEs7CiAgICAgfQotICAgIHRsYl9wZ3NpemVfdCBzaXplID0gY3R6NjQoZW50cnkpOwotICAg
IGdfYXNzZXJ0KHNpemUgPCBOVU1fUEdTSVpFX1RZUEVTKTsKLSAgICByZXR1cm4gc2l6ZTsKKyAg
ICByZXR1cm4gY3R6MzIoZmllbGQpOwogfQogCiBzdGF0aWMgaW5saW5lIHVpbnQ2NF90IGhleF90
bGJfcGFnZV9zaXplX2J5dGVzKHVpbnQ2NF90IGVudHJ5KQotLSAKMi4zNC4xCgo=

