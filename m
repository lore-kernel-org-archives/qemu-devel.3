Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02ADC624D6
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 18:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2uqW-0002u4-Ez; Sat, 05 Sep 2026 14:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uq7-0002j4-FT
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uq5-0001PL-MF
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:07 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685HcbMj2982717
 for <qemu-devel@nongnu.org>; Sat, 5 Sep 2026 18:10:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yv1og+tgkV4zuNnWr6KlL07Fz4+/Hi+TkEdL4lTJoHU=; b=MWt23kMEHsRqY1RN
 0Wtvj9D70XgCh6URrbvs/RfROGflNlqBJIaurou0Mg4hCnnRjrC/vyuoKwpsNOtl
 W0m1gB7OLkqFoVO5RMvhjI994czyyEJlNbW4a5gSluVy16FIEOv/41eD0VINB02X
 x4bMDIm5adg0H4J5xKoqUZF0ZbU9+Vt1Lwa7H3FH4/x8onm38dTppIKipqi9K1so
 VEVO1t2g9ljhYsxkoBkoSKzUvv1M7ZPNQknyNFIcS+be/Y1wumRqmTTCOf7Iuysg
 isaB5iGiVvbJAEfPDE2cCGGHGXCPnQJWRfnbgIl0ef1xSCIzXMgMKbeBS9EQGNm4
 rjLxtg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg8eq2f8u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 18:10:00 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2d7293f13c6so27200225ad.2
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 11:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788631800; x=1789236600; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yv1og+tgkV4zuNnWr6KlL07Fz4+/Hi+TkEdL4lTJoHU=;
 b=OSldEkhsH7pFFQCjtUd2KiHrUmSq6N4q8fCoZXfJIZ7sP/b1bNGx1+yUxtZAVb6S6G
 fhyF+ACMi33D/PQHUf22S9YcsM7q/XiG9SWOVSkVMkXqfLVYJbcUBwuRbzXecG3z2D0K
 SZqgVwkIF457QBjfeJx+4YKyCNMXXvg2eiwDK7yhvoidwMaHJFdHPUQgYEaATdbhat15
 Lui1Ub50UzchsrgLY924cKbY7fFIgO8WMrUT/QBXYH+VR0r63jRkQq8MUtVIWb84Z9YK
 b4IqmTmAf1lorV7ZdFVs9mdB9UJXCwiESQjGxzwswGwg9apGHhtSZCebkGkJyj44UV75
 Rumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788631800; x=1789236600;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yv1og+tgkV4zuNnWr6KlL07Fz4+/Hi+TkEdL4lTJoHU=;
 b=U3lIZ2igw14sKjdcPkXLtf6mCnjAjsNnld7c+kuoSGdeZnVBsoMuIfM9G44nF4UgHd
 Hc3Waw4TrsPKJKl8O8A66PeyT004VwBL44IohB8RuMQZ5b5h+roUZPfKqf41WdOeimL+
 GrsQkjb0/+RVKmAL5irLu3l4xZmsOAsqS6UUwQ0BTXdORmu8xpL1/EPsxL2cFpyDfg0F
 9J/gnYpcuU29uJdimNSWKHlg6g0GB9NK362Uwfpynr8goBtyLteO6Sy2yEitEuI0Lkqt
 zgITbcFMCoPDLq6QZLkXpsO3yfBntCl6JjkIcrb3zm6ttFyJCjFzULJDxWANSoJceeed
 pIiw==
X-Gm-Message-State: AFuF++kWVCpv2yqwqlo8pgwQ58GBbkc2yvj5mMi+VS+tiQsqkO6qX2Si
 QEWmsV5O5neuWbtMPi4437GNIXf8bYT4ZNs9Ut2Nlh4jwOQdZDGVaTdA59lHbuj4f13aJEd/BKw
 S8joJcu8gRpJIUik37b6oLRFvILz1FNLFrTmMw48Q48HxoNasaOc+wEDcV4PRjNRuuw==
X-Gm-Gg: AYBFou10O6+28C+m+xEtokFJ1qaHTh6aeNahwPusjsG5v/N4aqoZPgcgci4QpBDGeqx
 yDoocFXws30octS6y1xP6gd+91sLxd5AVyUs7VJuhSuvogJNXQFbgWZaqAhPJWwB1qgxu1lgsX8
 OJdU/obUCr6kCVOw6tHxQozlZVJFGF/pVVmMjXYcF7HiDrPgjD6jV3dPvbRKmUNwSX+pZMHeyLb
 Qu285Jrhkp0ACNT8bm/gaaxdge5zGuDDo1sY6bpYXoMGCl/FfImf18VcJU5nnqlNEffeaO2behR
 p/9orfVlGTt+On6I+YCd4b/QxMp6V44MnGYry4am6QjiEXXqn/NHmRZUO90OvoaWPYnwMY8Fc1j
 Y5Tej69HOmO4FroOsjeZ8HlqGqCMD6k1gqcuwdsLaAerYlWI4
X-Received: by 2002:a17:903:2ec5:b0:2cf:8131:75e8 with SMTP id
 d9443c01a7336-2db125c412dmr226713635ad.13.1788631799611; 
 Sat, 05 Sep 2026 11:09:59 -0700 (PDT)
X-Received: by 2002:a17:903:2ec5:b0:2cf:8131:75e8 with SMTP id
 d9443c01a7336-2db125c412dmr226713205ad.13.1788631799222; 
 Sat, 05 Sep 2026 11:09:59 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339a534df1sm17985505eec.7.2026.09.05.11.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 11:09:58 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, sid.manning@oss.qualcomm.com
Subject: [PATCH 04/17] tests/tcg/hexagon: fix undefined integer overflow in
 v69_hvx.c
Date: Sat,  5 Sep 2026 11:09:36 -0700
Message-Id: <20260905180949.1852673-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
References: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=F61nsKhN c=1 sm=1 tr=0 ts=6a9c5af8 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=hLQBpLl1in5vK7AdPdsA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfX3N46RO6UWbsh
 KnhA2uovznq9oseOyIxYbArVUdBVASQom5QdwDCdgjxMBF/PcOZ0xwzUAzUnKHfs7zbMuVedNHx
 jaavZhtDwN84gVSd+JSTJaacXpIXOJg=
X-Proofpoint-ORIG-GUID: BET0HwUSjnbNSuxkIuROcMLXO0t4zH7O
X-Proofpoint-GUID: BET0HwUSjnbNSuxkIuROcMLXO0t4zH7O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfX3RGQ0Z0FTaai
 vnsUtxMBTjQ/IVl9W5j2EG30NqMciQhYws4sIJyhLhfjNt03HYkbFSPaDSGP+Lf56fhOZ/QWhG7
 pBZ3dr5QUd7rkGZIhuQDkW2PmWZJfof1c1p65KD5iHSawQIEDgh3JEw3qvwI/GJcZk4HFJ8nbbn
 wtanNhE88MAgQ6SqmBr8nrHiX9iripdTW40E9QYNuO8iOq2cjm4900jgtyIir5D4JsKR6jJ9T2m
 Mq1nR9HLV45M5jkU1He1Njr7+dx6OjPMWPftZM9eIvWmRO232OYdSE6A+X0TZ4fgXoBZxF32Uen
 Kw1z1xJnPzKLnOluejbUxnlHC2DuSMxDsWj5bgA+HK2meZFHt2+qA30v6yCTCkQbA4e+J88zFVx
 Zdej+/aCol598vDy3Xmc47xgY7BbmSYBhcX5fuonA+u+pDVye9MGK9dNsSrD/raG9K5JJ7prnS5
 /mzRd9VNcRZvuKJ5/qg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609050201
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

Q2FzdCB0byB1aW50MzJfdCBiZWZvcmUgbXVsdGlwbHlpbmcgdWludDE2X3QgdmFsdWVzIHRvIHBy
ZXZlbnQKc2lnbmVkIGludGVnZXIgb3ZlcmZsb3cuIFdpdGhvdXQgdGhlIGNhc3QsIHRoZSB1aW50
MTZfdCBvcGVyYW5kcwphcmUgcHJvbW90ZWQgdG8gaW50LCBhbmQgdGhlIHByb2R1Y3QgY2FuIG92
ZXJmbG93IHRoZSBpbnQgcmFuZ2UuCkZvdW5kIHdpdGggVUJTYW4uCgpTaWduZWQtb2ZmLWJ5OiBC
cmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGVzdHMvdGNnL2hl
eGFnb24vdjY5X2h2eC5jIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90ZXN0cy90Y2cvaGV4YWdvbi92NjlfaHZ4LmMg
Yi90ZXN0cy90Y2cvaGV4YWdvbi92NjlfaHZ4LmMKaW5kZXggYTBkNTY3ZDE0MmYuLmVmZjkzNjA2
NGEwIDEwMDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi92NjlfaHZ4LmMKKysrIGIvdGVzdHMv
dGNnL2hleGFnb24vdjY5X2h2eC5jCkBAIC0yOTIsNyArMjkyLDggQEAgc3RhdGljIHZvaWQgdGVz
dF92bXB5dWh2cyh2b2lkKQogICAgICAgICBwb3V0ICs9IHNpemVvZihNTVZlY3Rvcik7CiAKICAg
ICAgICAgZm9yIChpbnQgaiA9IDA7IGogPCBNQVhfVkVDX1NJWkVfQllURVMgLyAyOyBqKyspIHsK
LSAgICAgICAgICAgIGV4cGVjdFtpXS51aFtqXSA9IChidWZmZXIwW2ldLnVoW2pdICogYnVmZmVy
MVtpXS51aFtqXSkgPj4gMTY7CisgICAgICAgICAgICBleHBlY3RbaV0udWhbal0gPQorICAgICAg
ICAgICAgICAgICgodWludDMyX3QpYnVmZmVyMFtpXS51aFtqXSAqIGJ1ZmZlcjFbaV0udWhbal0p
ID4+IDE2OwogICAgICAgICB9CiAgICAgfQogCi0tIAoyLjM0LjEKCg==

