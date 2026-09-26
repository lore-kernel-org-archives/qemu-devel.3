Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7796AC9832F
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 19:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAY03-0001Ku-2u; Sat, 26 Sep 2026 15:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xAXzx-0001Jq-BC
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 15:23:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xAXzv-0005rY-C4
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 15:23:49 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QGxQSn1449976
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 19:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z2ekY9HF98etmewvdt+Hswn64I/IwWHb7A8IgJocbO0=; b=QjDqJX9OgsjO39Cl
 5ZXQry6QyeYI6jrYtSFkotBayhUQmZfixbQQ65/wx0k4je9PSkGHKH//sXT3A5b6
 3jZpOjFuw1vKBrnsHi6+tVHDGgHEdxgKsZuyRaVZ7Ce4/i2rc0Z+2Mi3m6fzkZ/0
 HDu+Fyl7P1xHSQYRztwHXpdrEx4kM7mjfD6yX+2w0BDWujxgkK1d2f04j1CXm5d4
 5cKzdWA0ds8E6/RTxjVHGAqCgzKc7PUTPXX5cvcn0pYC03J9N9Ko1FGMz78V9AEe
 mXihxUQkIE9fhIR7L7wRyxzK+yKaLBiCgOJH7Gn9cs/6FND8ADmwLIUx01NBi425
 TZ//qw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx3rfsws5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 19:23:44 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso3124251eec.1
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 12:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790450623; x=1791055423; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z2ekY9HF98etmewvdt+Hswn64I/IwWHb7A8IgJocbO0=;
 b=CqoApZW9dRybg58kA3ANYchuCjZHawk+hBkx3+SnNasatxH8FYrSV//YOL8Pd3+dlT
 alBwGAMK33nx0C8u4NAX9Z72XFOszyNf9NE3Wmd/BLLWkdboBEZvZmxDTtcnlYcQrwY9
 FJpf1kDzjbqMrph5pumU6j/ZUN7a9Vt/kEzp3I6x8z7jVpQH9nviN66poyCthXyWkT6B
 /+qOEypxap4wmByfP9jW4TEOeGt+rFPVXXJBBApdaX72HaLn5dMSAAGTo4q5BSz2BaSj
 dPfF/ubkgZsH3YGxhl0v872MaeTbToYUcLeP6EF1RTFfYfLXkYEii+M5NyxGzNDIjRM7
 VwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790450623; x=1791055423;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z2ekY9HF98etmewvdt+Hswn64I/IwWHb7A8IgJocbO0=;
 b=obBOfDywzRM04CeIiZwKBafNf24L6OfF5NkKOXDJDj40pjPcLRdOcVSpLi0qwRgHAY
 0lgsd9sAoyzyDkeSG6hIaasGvUEsa0U92Lu8Vndmk6kzzs4/hCBGpnYGvHw2Rdwh9bQM
 PXBVZMt7UTSX43wZWgtgI2bb8GWJUo0X4KKl5ER3hY/JTSxF000rba6fX4YHDn02qiL/
 RbWjmo8YGdKvBpaW1GlGwppIXGTzoVngISJMDypWoQQYtRI4ONgIB4KNFVvq/BbONdWm
 PGp0vFWRmb1vY+wvmcjsF5D7vr2frSQo9c1QlGYsrKhrVfA98CsE6TWBAt6Q9Rr5rrGv
 REyQ==
X-Gm-Message-State: AFuF++nJFZ13lVAohJy6F90vPk7ijed5Rrhu2sg5x1LLrwN5OoWVjaI6
 y9AWlybbrkJNsWGoaq/q6G4zFdG3dRfSDB78+0+7iKL/q0+qMxirbGzKgPD6A9yER+YmpouqCwS
 7U0oKeq9a6AYchWMnZ6zbe0967b5aFIOZF+sM1vVo0NlWXhibJJ4siTljRBTLRVlJZg==
X-Gm-Gg: AYBFou1f13/UxfQm2BoPnuEsdp03hwKUKSWiGeGjKhBYBfPz71INuXjurDJJqd/Rs3T
 vYXFlthfK289OKpdLTrp8jYScXYaXZMUvTJXGznxngJlLHxNujK66WFaW48cybdREoDYL+vWz8M
 C5sVCt2vUPwP86OoZfBiOlhqmqL3CFTto3lMMfUKFfFDJ2fIV4tUtwbE59n1YVDOLZdFrkbz+jV
 4I1y2/3E09vq+4ihh2rPxmuZgMlej+i8/hO0NYPUpAVFSXQVoWRV7EjNJgkwSRJOSG6fJL8jFzQ
 QO3T/xrpLpZp2AfOcLOm7Nqp0Men4G8T7ryxhTL2a20WGa/yWkczwiiuLexCpZtCnOYwHFxEVAY
 PKT994GlyFesvJNs7YeZLCKjQGnYtCj2dSI0pUBTVYHLRmuI=
X-Received: by 2002:a05:701b:241a:b0:144:c90f:2583 with SMTP id
 a92af1059eb24-146cdeb8c80mr3265443c88.6.1790450623230; 
 Sat, 26 Sep 2026 12:23:43 -0700 (PDT)
X-Received: by 2002:a05:701b:241a:b0:144:c90f:2583 with SMTP id
 a92af1059eb24-146cdeb8c80mr3265420c88.6.1790450622549; 
 Sat, 26 Sep 2026 12:23:42 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145aa0cb6b9sm13526271c88.1.2026.09.26.12.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 12:23:41 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 richard.henderson@linaro.org, marco.liebel@oss.qualcomm.com,
 Taylor Simpson <ltaylorsimpson@gmail.com>
Subject: [PATCH 02/10] tests/tcg/hexagon: Cover HVX vector write conflicts
Date: Sat, 26 Sep 2026 12:23:30 -0700
Message-Id: <20260926192338.2702952-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260926192338.2702952-1-brian.cain@oss.qualcomm.com>
References: <20260926192338.2702952-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA3NyBTYWx0ZWRfX2XeW4DiFYloO
 V/FvaZ9i+4VL0B02GsvzDnT9BXWO3JyQD/NPX4e9GLfU/8L+kvrbmacDH/F4EiE7osfLPP6Ir9W
 CijAzJkBS6kzXqUzAaimOxNyjs7EFnM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA3NyBTYWx0ZWRfXxgRBacMo9bv5
 W+MgWvxArt+zImr7WwzETS1cgpLDmD6+P6OhEalMFYZBzh+686MAnMc8eBEL9rLuwPhJGOy7dHe
 1dFdElsbk12sF43ftzBwWnmQo+3D9CYTT3mkK8yx/BRmmmt+0dmbO8mZd8GVJP7YIZPZg6MVuME
 H+bFTEN8yU0Ipme2ATfIxzOY/QV1rGec65guVIG6RFwolQNFkGLX191G5ywy34oZzzb58J0J/EL
 2TwoQiDZXxJ4v7J0OIvHKvdbuPwaanx9fm4OmwXI6gZI+3YHJQERQX+fxuQGaVoItGN6i2c9kU6
 9Iq2pm0XmBYon9PGw3zT3SB+bC0JwcedCalNltsDCH8mA1jVX7eSQlrByd9FAFbXhu5DaQ8ok7u
 vOp7m86EYe1OeK915o9J/r8cwUIJM500HL7fl+3m8BtSCnfCx9DTdWCRabo7F2SHZGTuff0P4k2
 wdKG/rCimLuIfGTNe/w==
X-Proofpoint-GUID: ZBU3RNHb7Z_k0GOEw4AMoHSme-CZEnjU
X-Proofpoint-ORIG-GUID: ZBU3RNHb7Z_k0GOEw4AMoHSme-CZEnjU
X-Authority-Analysis: v=2.4 cv=K6G3jCWI c=1 sm=1 tr=0 ts=6ab81bc0 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=LU5tE7T4vROUmwdGADEA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260077
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

Q2M6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25lZC1vZmYt
Ynk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy90
Y2cvaGV4YWdvbi9tdWx0aXBsZS13cml0ZXMuYyB8IDk4ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrCiAxIGZpbGUgY2hhbmdlZCwgOTggaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Rl
c3RzL3RjZy9oZXhhZ29uL211bHRpcGxlLXdyaXRlcy5jIGIvdGVzdHMvdGNnL2hleGFnb24vbXVs
dGlwbGUtd3JpdGVzLmMKaW5kZXggYmQyYjEzODRkZDkuLjIxNzcxMjUyMDIwIDEwMDY0NAotLS0g
YS90ZXN0cy90Y2cvaGV4YWdvbi9tdWx0aXBsZS13cml0ZXMuYworKysgYi90ZXN0cy90Y2cvaGV4
YWdvbi9tdWx0aXBsZS13cml0ZXMuYwpAQCAtMTMsNiArMTMsNyBAQAogCiAjaW5jbHVkZSA8YXNz
ZXJ0Lmg+CiAjaW5jbHVkZSA8c2lnbmFsLmg+CisjaW5jbHVkZSA8c3RkaW50Lmg+CiAjaW5jbHVk
ZSA8c3RkaW8uaD4KICNpbmNsdWRlIDxzdGRsaWIuaD4KICNpbmNsdWRlIDxzdHJpbmcuaD4KQEAg
LTIyMyw2ICsyMjQsODAgQEAgc3RhdGljIGludCB0ZXN0X3ZyZWdfbGVnYWxfcHJlZGljYXRlZCh2
b2lkKQogICAgIHJldHVybiBzaWc7CiB9CiAKKy8qCisgKiBDb21wbGVtZW50YXJ5IHByZWRpY2F0
ZWQgd3JpdGVzIHRvIHRoZSBzYW1lIFYtcmVnaXN0ZXIgcGFpciBhcmUgbGVnYWwuCisgKiB2MTYg
YW5kIHYyMiBhcmUgc3BsYXR0ZWQgd2l0aCBkaXN0aW5jdCBwYXR0ZXJuczsgc2luY2UgcDAgaXMg
YWx3YXlzCisgKiB0cnVlLCB2MTQgbXVzdCBlbmQgdXAgaG9sZGluZyB2MTYncyBwYXR0ZXJuLiAg
RXh0cmFjdGluZyBhIHdvcmQgZnJvbQorICogdjE0IGNvbmZpcm1zIHRoZSBleGVjdXRlZCBicmFu
Y2ggYWN0dWFsbHkgcmFuLCByYXRoZXIgdGhhbiBtZXJlbHkgdGhhdAorICogbm8gU0lHSUxMIHdh
cyByYWlzZWQuCisgKi8KK3N0YXRpYyBpbnQgdGVzdF92cmVnX3BhaXJfbGVnYWxfcHJlZGljYXRl
ZCh2b2lkKQoreworICAgIGludCBzaWc7CisgICAgdWludDMyX3QgcmVzdWx0OworCisgICAgYXNt
IHZvbGF0aWxlKAorICAgICAgICAicjAgPSAjMFxuIgorICAgICAgICAicjEgPSAjIzFmXG4iCisg
ICAgICAgICJtZW13KCVbcmVzdW1lX3BjXSkgPSByMVxuIgorICAgICAgICAicjQgPSAjMHgxMTEx
MTExMVxuIgorICAgICAgICAicjUgPSAjMHgyMjIyMjIyMlxuIgorICAgICAgICAidjE2ID0gdnNw
bGF0KHI0KVxuIgorICAgICAgICAidjIyID0gdnNwbGF0KHI1KVxuIgorICAgICAgICAicjQgPSAj
MFxuIgorICAgICAgICAicDAgPSBjbXAuZXEocjAsIHIwKVxuIgorICAgICAgICAie1xuIgorICAg
ICAgICAiICAgIGlmIChwMCkgdjE1OjE0ID0gdmNvbWJpbmUodjIxLCB2MTYpXG4iCisgICAgICAg
ICIgICAgaWYgKCFwMCkgdjE1OjE0ID0gdmNvbWJpbmUodjIzLCB2MjIpXG4iCisgICAgICAgICJ9
XG4iCisgICAgICAgICIlW3Jlc3VsdF0gPSB2ZXh0cmFjdCh2MTQsIHI0KVxuIgorICAgICAgICAi
MTpcbiIKKyAgICAgICAgIiVbc2lnXSA9IHIwXG4iCisgICAgICAgIDogW3NpZ10gIj1yIihzaWcp
LCBbcmVzdWx0XSAiPXIiKHJlc3VsdCkKKyAgICAgICAgOiBbcmVzdW1lX3BjXSAiciIoJnJlc3Vt
ZV9wYykKKyAgICAgICAgOiAicjAiLCAicjEiLCAicjQiLCAicjUiLCAicDAiLAorICAgICAgICAg
ICJ2MTQiLCAidjE1IiwgInYxNiIsICJ2MjEiLCAidjIyIiwgInYyMyIsICJtZW1vcnkiKTsKKwor
ICAgIHJldHVybiBzaWcgPT0gU0lHSUxMID8gU0lHSUxMIDogcmVzdWx0OworfQorCisvKgorICog
QSBmdXR1cmUgd3JpdGUgbWF5IGNvbnN1bWUgYSB0ZW1wb3JhcnkgdmFsdWUgZnJvbSB0aGUgc2Ft
ZSBWLXJlZ2lzdGVyLgorICogYnVmIGlzIHplcm9lZCwgc28gdjAudG1wIGxvYWRzIGFsbC16ZXJv
IGFuZCB2MC53ID0gdmFkZCh2MC50bXAudywgMSkKKyAqIG11c3QgZW5kIHVwIGFzIDEgaW4gZXZl
cnkgd29yZC4gIEV4dHJhY3RpbmcgYSB3b3JkIGZyb20gdGhlIHJlc3VsdAorICogY29uZmlybXMg
dGhlIGFkZCBhY3R1YWxseSB1c2VkIHRoZSBsb2FkZWQgLnRtcCB2YWx1ZSwgcmF0aGVyIHRoYW4K
KyAqIG1lcmVseSB0aGF0IG5vIFNJR0lMTCB3YXMgcmFpc2VkLgorICovCitzdGF0aWMgaW50IHRl
c3RfdnJlZ19sZWdhbF90bXAodm9pZCkKK3sKKyAgICBsb25nIGxvbmcgYnVmWzE2XSBfX2F0dHJp
YnV0ZV9fKChhbGlnbmVkKDEyOCkpKTsKKyAgICBpbnQgc2lnOworICAgIHVpbnQzMl90IHJlc3Vs
dDsKKworICAgIG1lbXNldChidWYsIDAsIHNpemVvZihidWYpKTsKKworICAgIGFzbSB2b2xhdGls
ZSgKKyAgICAgICAgInIwID0gIzBcbiIKKyAgICAgICAgInIxID0gIyMxZlxuIgorICAgICAgICAi
bWVtdyglW3Jlc3VtZV9wY10pID0gcjFcbiIKKyAgICAgICAgInIyID0gJVtidWZdXG4iCisgICAg
ICAgICJyMyA9ICMxXG4iCisgICAgICAgICJyNCA9ICMwXG4iCisgICAgICAgICJ2MSA9IHZzcGxh
dChyMylcbiIKKyAgICAgICAgIntcbiIKKyAgICAgICAgIiAgICB2MC50bXAgPSB2bWVtKHIyICsg
IzApXG4iCisgICAgICAgICIgICAgdjAudyA9IHZhZGQodjAudywgdjEudylcbiIKKyAgICAgICAg
In1cbiIKKyAgICAgICAgIiVbcmVzdWx0XSA9IHZleHRyYWN0KHYwLCByNClcbiIKKyAgICAgICAg
IjE6XG4iCisgICAgICAgICIlW3NpZ10gPSByMFxuIgorICAgICAgICA6IFtzaWddICI9ciIoc2ln
KSwgW3Jlc3VsdF0gIj1yIihyZXN1bHQpCisgICAgICAgIDogW3Jlc3VtZV9wY10gInIiKCZyZXN1
bWVfcGMpLCBbYnVmXSAiciIoYnVmKQorICAgICAgICA6ICJyMCIsICJyMSIsICJyMiIsICJyMyIs
ICJyNCIsICJ2MCIsICJ2MSIsICJtZW1vcnkiKTsKKworICAgIHJldHVybiBzaWcgPT0gU0lHSUxM
ID8gU0lHSUxMIDogcmVzdWx0OworfQorCiBzdGF0aWMgaW50IHRlc3RfdnJlZ19pbGxlZ2FsX21p
eGVkKHZvaWQpCiB7CiAgICAgaW50IHNpZzsKQEAgLTI0Miw2ICszMTcsMjYgQEAgc3RhdGljIGlu
dCB0ZXN0X3ZyZWdfaWxsZWdhbF9taXhlZCh2b2lkKQogICAgIHJldHVybiBzaWc7CiB9CiAKKy8q
IEEgcGFpciB3cml0ZSBhbmQgYSBzaW5nbGUgd3JpdGUgdG8gZWl0aGVyIHBhaXIgbWVtYmVyIGFy
ZSBpbGxlZ2FsLiAqLworc3RhdGljIGludCB0ZXN0X3ZyZWdfaWxsZWdhbF9wYWlyX292ZXJsYXAo
dm9pZCkKK3sKKyAgICBpbnQgc2lnOworCisgICAgYXNtIHZvbGF0aWxlKAorICAgICAgICAicjAg
PSAjMFxuIgorICAgICAgICAicjEgPSAjIzFmXG4iCisgICAgICAgICJtZW13KCVbcmVzdW1lX3Bj
XSkgPSByMVxuIgorICAgICAgICAiLndvcmQgMHgxZjUwNTVlZSAgICAvKiB7IHYxNToxNCA9IHZj
b21iaW5lKHYyMSwgdjE2KSAqL1xuIgorICAgICAgICAiLndvcmQgMHgxZTAzZTVlZSAgICAvKiAg
IHYxNCA9IHY1IH0gKi9cbiIKKyAgICAgICAgIjE6XG4iCisgICAgICAgICIlW3NpZ10gPSByMFxu
IgorICAgICAgICA6IFtzaWddICI9ciIoc2lnKQorICAgICAgICA6IFtyZXN1bWVfcGNdICJyIigm
cmVzdW1lX3BjKQorICAgICAgICA6ICJyMCIsICJyMSIsICJtZW1vcnkiKTsKKworICAgIHJldHVy
biBzaWc7Cit9CisKIHN0YXRpYyBpbnQgdGVzdF92cmVnX2lsbGVnYWxfdW5jb25kKHZvaWQpCiB7
CiAgICAgaW50IHNpZzsKQEAgLTMwOCw3ICs0MDMsMTAgQEAgaW50IG1haW4oKQogICAgIGFzc2Vy
dCh0ZXN0X3Bvc3RfaW5jcmVtZW50MygpID09IFNJR0lMTCk7CiAKICAgICBhc3NlcnQodGVzdF92
cmVnX2xlZ2FsX3ByZWRpY2F0ZWQoKSA9PSAyMyk7CisgICAgYXNzZXJ0KHRlc3RfdnJlZ19wYWly
X2xlZ2FsX3ByZWRpY2F0ZWQoKSA9PSAweDExMTExMTExKTsKKyAgICBhc3NlcnQodGVzdF92cmVn
X2xlZ2FsX3RtcCgpID09IDEpOwogICAgIGFzc2VydCh0ZXN0X3ZyZWdfaWxsZWdhbF9taXhlZCgp
ID09IFNJR0lMTCk7CisgICAgYXNzZXJ0KHRlc3RfdnJlZ19pbGxlZ2FsX3BhaXJfb3ZlcmxhcCgp
ID09IFNJR0lMTCk7CiAgICAgYXNzZXJ0KHRlc3RfdnJlZ19pbGxlZ2FsX3VuY29uZCgpID09IFNJ
R0lMTCk7CiAKICAgICBhc3NlcnQodGVzdF9xcmVnX2lsbGVnYWwoKSA9PSBTSUdJTEwpOwotLSAK
Mi4zNC4xCgo=

