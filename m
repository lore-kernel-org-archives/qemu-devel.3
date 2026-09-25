Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E91C9831E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 02:00:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9vA0-0005KJ-NL; Thu, 24 Sep 2026 21:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9o-0005Bg-6Z
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:55:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9l-00066B-Pw
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:55:23 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P1kld4313548
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8f+YUKiUCgruigEWW6RCmqNqjaanWMaUWMcLnw3kF70=; b=ot4++gOgokTkSMzE
 9FUDAPKH4aZKDM9YYNVXz5NnQ2pwlCA+4UE5ZU87LSNSMgIRFoFzazaWg6Fjf2jM
 EP+HCaGCU/BDI9cZA944QOPgrjf5AIl0HfBLHjYXMbRn9vqoF9tqU89dqci8m4nX
 +j56hWX7JFqQ+WwkPxIRI5825ybzkhXcHgnheA6Ou0dgkWajdnTr0GKz+BBzO77W
 B3E+Vw7deVYCoQMxEW6sTar7zNRVwPfCG25ag5YvoVuCiW8/tvfyYjM2LidwM6/H
 fIL6jE3mqWDrw1uTWMLBBx4nHsWisFMYdcPrL8sJlpw8lQQj0gt6z0eoYj9czv1N
 HqGuRg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1s93d8r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:55:10 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3412efc2661so500268eec.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 18:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790301310; x=1790906110; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8f+YUKiUCgruigEWW6RCmqNqjaanWMaUWMcLnw3kF70=;
 b=P9WaH8MIxgwMAmaUy/t8Wv4vS3Z5w1la9BQjbRfb1Mk21SICIzUPQtrN5kCrdOq23Q
 PxPyFBDrWR/mGSO+7+5/C02Yr058qI40YD0DsThkEPyQ0xbvbHQ3csfEY2NN+WAF7bfl
 lGG4UFX9BPkAT6cOTUcmNeLr3jQkmCUNLElbR7KR3/JmVL2FsXZf8+KAasaUaqmjRnEY
 f6sgqlYfC3612V+qR8yTJXsM62ggi+RWsFN8MNcEDhr9DjYeRPKdNAJtoDXoj57CKPt1
 OPpSDgMy44+ezFtNAzvJargTt9+NEtH7cOwx1eWfk4EoUVsB9AEdHeZN5NqVzumU0I1e
 mrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790301310; x=1790906110;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8f+YUKiUCgruigEWW6RCmqNqjaanWMaUWMcLnw3kF70=;
 b=LCRLdZ4MEI9u7LwyD/3N8E37hggbSjLeoBLRkVMJAaFFzk/KPyE4Y5jHs4x05WE08r
 edAi9A3MIHgt+vCw2DzR2QS4rvAN/c61fagQGMuoHLMU5UzBgrQQ+04E3fZ6tFNaD54n
 JRuEDklynH2Din7KFC4f4zjnIp5Y9ilH9NZIXL6y7nEj3llqF79m0ocRPuqB+1kX7pa3
 SFQ48QCGrG2D21Sc3sKlSoUIbq0BiOuFj067+vrC5c/uU7ks2J6tml/VUHDTo6hiDVsI
 7eu9Ht1ze21AzhjahU4CaG3wx/ZYZzqdr1xQasVdXNC5Jv+5+alskegqzblrWzYdoRHL
 fX8A==
X-Gm-Message-State: AFuF++kI0uAuJoXqONw1/a2T25/SKBbLCbdAjZgmmUbBu4dv6ZNqe0IJ
 55RhS4qrE3+b3iqfDT1LrThTZpqccaDtYBftd674taRCDs3yShzkLTuR4Giaq4ZbyK+lap2/D+5
 pmtf4uW7GZJJKYSsUcI+j60gaMKNPDnn1U4YLp703Mcai3waSav+oDckrFzKBmBRM/A==
X-Gm-Gg: AYBFou0Tt3tdd+9CKNMgIKc0/HhgT2DqTfKIs+M+GV4Vc8/e5hLn/+7WDOhvAiewrB9
 Sp0I4l0YTqUt6MNvgrWg8Td1I4kSbBz8IdL2nd0URkRoYQeW2Dgr4Px/iQiPBYwHCjJZ99iCmJk
 kICHVgoASMSq1gxxL3+WG8urgAZGYX5cdEt5+UNHz3p+nZtM0yPnK0o7HZOWZdrQEBuRIzdsMfs
 ZcDK6PTj7XKsC6SP9efmvrXJTAuDRDK/dp85oK9xkf6PnA88dpe643VEryMB9+V6rYcEft+XFp7
 vytmWK8JdpAqGb38Lcy+aquweI1QcLb0vVrjJQuNfashcMTgElQzJoXNNtxbvzGIYASXufiAPl6
 6t8r+CkgLEKJm+th4VEApIeUuLgYFbQcL0MrfXmBQGp5nyFE=
X-Received: by 2002:a05:7301:e10b:b0:33c:141b:73a5 with SMTP id
 5a478bee46e88-34006f8c72bmr3474803eec.41.1790301309651; 
 Thu, 24 Sep 2026 18:55:09 -0700 (PDT)
X-Received: by 2002:a05:7301:e10b:b0:33c:141b:73a5 with SMTP id
 5a478bee46e88-34006f8c72bmr3474794eec.41.1790301309076; 
 Thu, 24 Sep 2026 18:55:09 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3416e4c2f50sm1873720eec.27.2026.09.24.18.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 18:55:07 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 23/40] tests/tcg/hexagon: add unconditional store-immediate
 tests
Date: Thu, 24 Sep 2026 18:54:12 -0700
Message-Id: <20260925015429.2579174-24-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
References: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX8r7aafvUs3T4
 dHpUnztGigwnsTMlEbR+kF/oJfn8bHkGo4D3hxU3BECg9X5cuSYZCDAEHxU8lHu72P6KlaOd8Mj
 pJULUVir2FJhzsbNUwUZo2eC9iJ4ZQo8Kj/wZF+UUoAymW0FoisanZIi4BgDOypGpb+Cl6J3A3+
 V5rQ20LwgCcKiIjZ5k7w3FB2djVG9js8gmOV1WEfmY6zlk+WcaaBznV1Ux2bXQ4kBHFHfSPoZqq
 DmgpYMl3RPGcCU9GNvMhfnUHQnGZACh1aonLM90JKBGBbnnLuQVSpbVvjL7EVh5BpXxwU486SWL
 PBCrsFT/m3Uc9jrCEJo0usIpWf4QZ526vmWxiCw4+uW1yayzsw1tfE7bJ8raKEaZEposk8kPj1l
 49onbmLp4I/d6SK+dXcTPDhHW6F2iM2dMLr7a2P/YU6Kf4oxivMK9YuExP1xNwzUajRsZ4V2o1u
 I6/kQE/NmSrMkmw3zhA==
X-Authority-Analysis: v=2.4 cv=VPxIDNPX c=1 sm=1 tr=0 ts=6ab5d47e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=0l-Zo2GwZyP_T63qDoMA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX3cctLr9vuUbb
 ivodVQpse9rj8NZKg5M5AOS1vkml8tNckdadGhqI/XUNGz/shRwACfZyxa9EBPpl5KM6TExob5w
 ixYesWQ3bvVP/eZlqwxvAFs7bwdZvX8=
X-Proofpoint-ORIG-GUID: D1wGKc4I61dTBmKzveqg_C0YBrbGwEJG
X-Proofpoint-GUID: D1wGKc4I61dTBmKzveqg_C0YBrbGwEJG
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

UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tPgotLS0KIHRlc3RzL3RjZy9oZXhhZ29uL21pc2MuYyB8IDQ0ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA0NCBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vbWlzYy5jIGIvdGVzdHMvdGNnL2hl
eGFnb24vbWlzYy5jCmluZGV4IGNhMjJiYjc5ZjdiLi5jMDc1NDdiNmY2OCAxMDA2NDQKLS0tIGEv
dGVzdHMvdGNnL2hleGFnb24vbWlzYy5jCisrKyBiL3Rlc3RzL3RjZy9oZXhhZ29uL21pc2MuYwpA
QCAtNDA0LDYgKzQwNCw0OCBAQCB2b2lkIHRlc3RfZHBtcHlzc19ybmRfczAodm9pZCkKICAgICBj
aGVjazMyKGRwbXB5c3Nfcm5kX3MwKDB4N2ZmZmZmZmYsIDB4N2ZmZmZmZmYpLCAweDNmZmZmZmZm
KTsKIH0KIAorc3RhdGljIHVpbnQ4X3Qgc3RvcmVpbW1fYnl0ZV9hcnJheVsxNl07CitzdGF0aWMg
dWludDE2X3Qgc3RvcmVpbW1faGFsZl9hcnJheVsxNl07CitzdGF0aWMgdWludDMyX3Qgc3RvcmVp
bW1fd29yZF9hcnJheVsxNl07CisKKy8qCisgKiBVbmNvbmRpdGlvbmFsIHN0b3JlLWltbWVkaWF0
ZSBpbnN0cnVjdGlvbnMgKFM0X3N0b3JlaXIqX2lvKS4KKyAqIFRoZSBwcmVkaWNhdGVkIGZvcm1z
IGFyZSB0ZXN0ZWQgYWJvdmU7IHRoZXNlIGV4ZXJjaXNlIHRoZSBiYXNlIGVuY29kaW5nCisgKiB3
aXRoIHBvc2l0aXZlIGFuZCBuZWdhdGl2ZSAjUzggaW1tZWRpYXRlIHZhbHVlcy4KKyAqLworc3Rh
dGljIHZvaWQgY2hlY2tfc3RvcmVfaW1tKHZvaWQpCit7CisgICAgLyogbWVtYihScysjdTY6MCkg
PSAjUzggKi8KKyAgICBtZW1zZXQoc3RvcmVpbW1fYnl0ZV9hcnJheSwgMCwgc2l6ZW9mKHN0b3Jl
aW1tX2J5dGVfYXJyYXkpKTsKKyAgICBhc20gdm9sYXRpbGUoIm1lbWIoJVtwdHJdICsgIzApID0g
IzB4MTJcblx0IgorICAgICAgICAgICAgICAgICA6IDogW3B0cl0gInIiKHN0b3JlaW1tX2J5dGVf
YXJyYXkpIDogIm1lbW9yeSIpOworICAgIGNoZWNrMzIoc3RvcmVpbW1fYnl0ZV9hcnJheVswXSwg
MHgxMik7CisKKyAgICBhc20gdm9sYXRpbGUoIm1lbWIoJVtwdHJdICsgIzMpID0gIy0xXG5cdCIK
KyAgICAgICAgICAgICAgICAgOiA6IFtwdHJdICJyIihzdG9yZWltbV9ieXRlX2FycmF5KSA6ICJt
ZW1vcnkiKTsKKyAgICBjaGVjazMyKHN0b3JlaW1tX2J5dGVfYXJyYXlbM10sIDB4ZmYpOworCisg
ICAgLyogbWVtaChScysjdTY6MSkgPSAjUzggKi8KKyAgICBtZW1zZXQoc3RvcmVpbW1faGFsZl9h
cnJheSwgMCwgc2l6ZW9mKHN0b3JlaW1tX2hhbGZfYXJyYXkpKTsKKyAgICBhc20gdm9sYXRpbGUo
Im1lbWgoJVtwdHJdICsgIzApID0gIzB4MzRcblx0IgorICAgICAgICAgICAgICAgICA6IDogW3B0
cl0gInIiKHN0b3JlaW1tX2hhbGZfYXJyYXkpIDogIm1lbW9yeSIpOworICAgIGNoZWNrMzIoc3Rv
cmVpbW1faGFsZl9hcnJheVswXSwgMHgzNCk7CisKKyAgICBhc20gdm9sYXRpbGUoIm1lbWgoJVtw
dHJdICsgIzQpID0gIy0xXG5cdCIKKyAgICAgICAgICAgICAgICAgOiA6IFtwdHJdICJyIihzdG9y
ZWltbV9oYWxmX2FycmF5KSA6ICJtZW1vcnkiKTsKKyAgICBjaGVjazMyKHN0b3JlaW1tX2hhbGZf
YXJyYXlbMl0sIDB4ZmZmZik7CisKKyAgICAvKiBtZW13KFJzKyN1NjoyKSA9ICNTOCAqLworICAg
IG1lbXNldChzdG9yZWltbV93b3JkX2FycmF5LCAwLCBzaXplb2Yoc3RvcmVpbW1fd29yZF9hcnJh
eSkpOworICAgIGFzbSB2b2xhdGlsZSgibWVtdyglW3B0cl0gKyAjMCkgPSAjMHg1NlxuXHQiCisg
ICAgICAgICAgICAgICAgIDogOiBbcHRyXSAiciIoc3RvcmVpbW1fd29yZF9hcnJheSkgOiAibWVt
b3J5Iik7CisgICAgY2hlY2szMihzdG9yZWltbV93b3JkX2FycmF5WzBdLCAweDU2KTsKKworICAg
IGFzbSB2b2xhdGlsZSgibWVtdyglW3B0cl0gKyAjOCkgPSAjLTFcblx0IgorICAgICAgICAgICAg
ICAgICA6IDogW3B0cl0gInIiKHN0b3JlaW1tX3dvcmRfYXJyYXkpIDogIm1lbW9yeSIpOworICAg
IGNoZWNrMzIoc3RvcmVpbW1fd29yZF9hcnJheVsyXSwgMHhmZmZmZmZmZik7Cit9CisKIGludCBt
YWluKCkKIHsKICAgICBpbnQzMl90IHJlczsKQEAgLTU0Nyw2ICs1ODksOCBAQCBpbnQgbWFpbigp
CiAKICAgICB0ZXN0X2RwbXB5c3Nfcm5kX3MwKCk7CiAKKyAgICBjaGVja19zdG9yZV9pbW0oKTsK
KwogICAgIHB1dHMoZXJyID8gIkZBSUwiIDogIlBBU1MiKTsKICAgICByZXR1cm4gZXJyOwogfQot
LSAKMi4zNC4xCgo=

