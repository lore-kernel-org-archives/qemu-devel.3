Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28619C624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1cp2-0000nt-Pw; Wed, 02 Sep 2026 00:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1cp0-0000mC-Q4
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:43:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1coz-0000RK-5r
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:43:38 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681KTDUQ3663784
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 04:43:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LAqQgUytRG77JHSI3ck1VNsfjBat8NVIaDYB4UNVp1c=; b=O88gAtJsNvcZDVRQ
 kgk577s4OtmYxsd+W2/4Q+RL8iuLpxtwHSD1c25UeIGJH/Ku/5DIfTiHMg2pe+s2
 CPGf+U2f0wAD9WTyByPDc87mIkJyVqZJ48P0xu7qGd4l+AbuvGB3xRGaxyCh0IQ0
 SLYbLsZ1cr3B7nci5lpWHnb45uNvQr9iIWqpKcXse5Vj5tCVplFDWtopei1PQvG6
 l1mJ9IhuzRHKovKLTQYsp/fYEt7KK9MDkThH33NMr0I/vcDzO4JlePG1beh5UFVJ
 AMQ52iwApC9wokKUti+GX6Ka4dT2l/n6o4FMYgEMXfE6eDZS434oztDDmPdq+Ebf
 8lQoSA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge37j24hv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:43:25 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d7293f13c6so7944005ad.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788324205; x=1788929005; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LAqQgUytRG77JHSI3ck1VNsfjBat8NVIaDYB4UNVp1c=;
 b=AVCMLKWLd4Wk7JerrJXQUKMVAKn9g5UzLBQbtCI3AyNwzd0s+VyiUv6vtcM90e3k/Q
 deFqXGLjxbNHguzJqcz8cflKJqM/AWKBv1Hmja+4uimnOASlE0m39frg8ujt9nm9u4S8
 KHN/asn60joENyBcQSxR96ius3wtYNOSmW4PwFDk/x/0Iufr+LgBzhvql7ACgtj9gNgv
 dK6Q7U7fWvLPQ05psFXdUyskJbsG45gB2BXMarbBETRfXGp3BuHy0LTNHqohr3U3Gac0
 16YuwZ0FA8yRVl5THqCg/0sXCgJyeudOeV+SW9HUifV4qa8UBzcHh67sFmPqv6+D17i2
 tx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788324205; x=1788929005;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LAqQgUytRG77JHSI3ck1VNsfjBat8NVIaDYB4UNVp1c=;
 b=ri08nCn7ZDcqFl9WwC7X+2r3SuEhqwW0WSXKnXmxlCGjjXzw59g+iN22LaAX48xsTf
 iRaTFPzQ1zTZPG7zDcA57WPR2naagODMsGfh3nA5ypJhhWRM/5HSNtPc1M6XMbgKylJz
 K/rZDA71RsF93AQqtuMHgp5X/JJ9RrIqSRNO5YLZf0pPkNtEpQnmBGKf9r+coWsU5Y95
 8wOHOC7nP8ShnMoeouU/nUlOIwhzY2sQIZvzyVBAMVFK05/7IkpX31AcuUZ9pg5t5IqU
 fRAnSS928xgEI2+viDBOvngjHy7U8cruiYMw/DDbwgSd3OntI0s3m+ZNXwLnHIjBGEgN
 y4PQ==
X-Gm-Message-State: AFuF++n+uxfs9yOCynXeFXe1Irj3KAZPEihVMfrXZ4gfYm6BG1B4IZpE
 x3IUHzjLW/r3Aw7zFLP9n4NfXyGCfpfwteG0ZgW1bllOkhUJiUzUCQPDszX444cW+VNckxAxY1k
 9q5dFaUB5jWW5g/L5C3HAfIyubixnBhVzNU34ghznXoD1vSYnGsmmhJjIm9RtNkFIvg==
X-Gm-Gg: AYBFou0Sb7+oB3aAnqldIU+G6O823u//oQLlVEA8SQg4I32TeiYLLkBpYjSD9Nv9jtf
 mV7F72pltS2BVV7HP/5qLmxeSvhlhSI599invOeEnHLZjEOrY3/3Co/aGT3IZXTsBhayO/hF5oS
 HQwKf5fjkSTKB4KDMTf6fx2Dvvnei33b/hjr35/Xq0G+Rmk0lb0MI3EVbnPoghCmzz7EJZz9OJ7
 SpOUQRokiAvLoGJdS6kMTnIBrPPrX12I3at93E3VMIFV4TFGd3tfwK6OjDWJh4xYmN6FXKu2Plc
 aHrOGUd1LHqRIW+4bJ1bKCIYmwd65eZHpzmEL4hVQvo2594WWopjRuxBncy1mXD0f+qsb0deKqT
 LihWuU/zkWo4AXL3jXhDJUPgbKQCbJIXudUZUbwCiLymXTEqw
X-Received: by 2002:a17:902:e74b:b0:2d6:df31:5bd0 with SMTP id
 d9443c01a7336-2daec71798fmr25412135ad.10.1788324205029; 
 Tue, 01 Sep 2026 21:43:25 -0700 (PDT)
X-Received: by 2002:a17:902:e74b:b0:2d6:df31:5bd0 with SMTP id
 d9443c01a7336-2daec71798fmr25411525ad.10.1788324204469; 
 Tue, 01 Sep 2026 21:43:24 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f079c33e9sm2933984eec.4.2026.09.01.21.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 21:43:23 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 28/28] hw/hexagon: decode an empty TLB size field as 4KB
Date: Tue,  1 Sep 2026 21:42:31 -0700
Message-Id: <20260902044231.843004-29-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
References: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: b6uX5arIMhOAkNRpV9sR8T6EpmaVqSrk
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfXxLXfilPT9F6g
 i/EjQIZePQRfJyaJBGQP/L3B6Uhd8KQu00H/2pkoJrh4VlXsDvn6xSHTB5Q4wNEbtFe5uki78Co
 EChB+WV998WcualYZunkBIf3F6WEBT0=
X-Proofpoint-ORIG-GUID: b6uX5arIMhOAkNRpV9sR8T6EpmaVqSrk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX7B63GnDwJc/K
 HS03AClNbywaL2xnvfvjXuPwZcho0u6xS5HAis7Gl3aDETOK6rqD7TrhNPnokfVIzbXRFctvnoS
 0Jma10U+vGLyM5idkvSy6g2csHJoLigRlR6fCe0ICxTQDSvJDm3mfW+O/f5Iq8Go/2aSGfA6F+x
 dyPiQhztqxZavyl0eSwwnNOo6RpC9XC3q5NFXYmwHq57Ip1EPUVkXrYVKHdwuf1CalVj1asiWOA
 4TXFSZ/KWeK5iSJazjY9/yl9wtDOo2zKwY/DLtufPGAjTEOfn8gIxR35OS/ReZpvMZGQHvzzlfP
 56lexK1q/o4Zw7Lj5kr0SYgYdMFh28D3VwQFozTeBlkesSkminooB5LM5AsRa/fS3jhCoUplQ4o
 pk1dEAVDUUhdWR5cGaUlGG9uRmk3BpVsjKg/j61BOcEFgj9SuvgKs1Q8PxrBfmu9wWXlUONvzEU
 UieU2dgcKUbAxA7hlvw==
X-Authority-Analysis: v=2.4 cv=PKg/P/qC c=1 sm=1 tr=0 ts=6a97a96d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=41wnHuTSjj-I1xIrTVIA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020040
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

aGV4X3RsYl9wZ3NpemVfdHlwZSgpIGRlY29kZWQgYSBUTEIgZW50cnkncyBwYWdlIHNpemUgYnkg
c2Nhbm5pbmcgZm9yCnRoZSBsb3dlc3Qgc2V0IGJpdCBhY3Jvc3MgdGhlIGVudHJ5IHdpdGggY3R6
LgoKQSBndWVzdCBUTEIgd3JpdGUgd2l0aCBhbiBlbXB0eSBQUERbOTowXSBzaXplIGZpZWxkIGJ1
dCBhbnkgb3RoZXIgYml0CnNldCBjYXVzZWQgYW4gYXNzZXJ0aW9uLgoKUmV2aWV3ZWQtYnk6IFBp
ZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVk
LW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGh3
L2hleGFnb24vaGV4YWdvbl90bGIuYyB8IDI0ICsrKysrKysrKysrKysrLS0tLS0tLS0tLQogMSBm
aWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2h3L2hleGFnb24vaGV4YWdvbl90bGIuYyBiL2h3L2hleGFnb24vaGV4YWdvbl90bGIuYwpp
bmRleCA2NTM5NDU4ZjI1Zi4uZDg5ZTQxNjFmMTEgMTAwNjQ0Ci0tLSBhL2h3L2hleGFnb24vaGV4
YWdvbl90bGIuYworKysgYi9ody9oZXhhZ29uL2hleGFnb25fdGxiLmMKQEAgLTY5LDggKzY5LDYg
QEAgc3RhdGljIGNvbnN0IGNoYXIgKnBnc2l6ZV9zdHJbTlVNX1BHU0laRV9UWVBFU10gPSB7CiAg
ICAgIjFHIiwKIH07CiAKLSNkZWZpbmUgSU5WQUxJRF9NQVNLIDB4ZmZmZmZmZmZMTAotCiBzdGF0
aWMgY29uc3QgdWludDY0X3QgZW5jbWFza18yX21hc2tbXSA9IHsKICAgICAweDBmZmZMTCwgICAg
ICAgICAgICAgICAgICAgICAgICAgICAvKiA0aywgICAwMDAwICovCiAgICAgMHgzZmZmTEwsICAg
ICAgICAgICAgICAgICAgICAgICAgICAgLyogMTZrLCAgMDAwMSAqLwpAQCAtODIsMTkgKzgwLDI1
IEBAIHN0YXRpYyBjb25zdCB1aW50NjRfdCBlbmNtYXNrXzJfbWFza1tdID0gewogICAgIDB4M2Zm
ZmZmZkxMLCAgICAgICAgICAgICAgICAgICAgICAgIC8qIDY0bSwgIDAxMTEgKi8KICAgICAweGZm
ZmZmZmZMTCwgICAgICAgICAgICAgICAgICAgICAgICAvKiAyNTZtLCAxMDAwICovCiAgICAgMHgz
ZmZmZmZmZkxMLCAgICAgICAgICAgICAgICAgICAgICAgLyogMWcsICAgMTAwMSAqLwotICAgIElO
VkFMSURfTUFTSywgICAgICAgICAgICAgICAgICAgICAgIC8qIFJTVkQsIDEwMTAgKi8KIH07CiAK
Ky8qCisgKiBUaGUgcGFnZSBzaXplIGlzIGVuY29kZWQgYXMgdGhlIHBvc2l0aW9uIG9mIHRoZSBs
b3dlc3Qgc2V0IGJpdCBvZgorICogUFBEWzk6MF0uICBCaXRzIG91dHNpZGUgdGhhdCBmaWVsZCBi
ZWxvbmcgdG8gdGhlIGNhY2hlYWJpbGl0eSBhbmQKKyAqIHBlcm1pc3Npb24gZmllbGRzIGFuZCBt
dXN0IG5vdCB0YWtlIHBhcnQgaW4gdGhlIGRlY29kZS4gIEFuIGFsbC16ZXJvCisgKiBmaWVsZCBk
ZW5vdGVzIHRoZSBzbWFsbGVzdCBwYWdlLCBtYXRjaGluZyBnZXRfcGdzaXplKCkgaW4gdGhlIHJl
ZmVyZW5jZQorICogc2ltdWxhdG9yLgorICovCisjZGVmaW5lIFBHU0laRV9GSUVMRF9NQVNLICgo
MSA8PCBOVU1fUEdTSVpFX1RZUEVTKSAtIDEpCisKIHN0YXRpYyBpbmxpbmUgdGxiX3Bnc2l6ZV90
IGhleF90bGJfcGdzaXplX3R5cGUodWludDY0X3QgZW50cnkpCiB7Ci0gICAgaWYgKGVudHJ5ID09
IDApIHsKLSAgICAgICAgcWVtdV9sb2dfbWFzayhDUFVfTE9HX01NVSwgIiVzOiBTdXBwbGllZCBU
TEIgZW50cnkgd2FzIDAhXG4iLAotICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fKTsKLSAg
ICAgICAgcmV0dXJuIDA7CisgICAgdWludDMyX3QgZmllbGQgPSBHRVRfUFRFX1BQRChlbnRyeSkg
JiBQR1NJWkVfRklFTERfTUFTSzsKKworICAgIGlmIChmaWVsZCA9PSAwKSB7CisgICAgICAgIHJl
dHVybiBQR1NJWkVfNEs7CiAgICAgfQotICAgIHRsYl9wZ3NpemVfdCBzaXplID0gY3R6NjQoZW50
cnkpOwotICAgIGdfYXNzZXJ0KHNpemUgPCBOVU1fUEdTSVpFX1RZUEVTKTsKLSAgICByZXR1cm4g
c2l6ZTsKKyAgICByZXR1cm4gY3R6MzIoZmllbGQpOwogfQogCiBzdGF0aWMgaW5saW5lIHVpbnQ2
NF90IGhleF90bGJfcGFnZV9zaXplX2J5dGVzKHVpbnQ2NF90IGVudHJ5KQotLSAKMi4zNC4xCgo=

