Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C31C88E77
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 22:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6FDs-0000fm-Up; Mon, 14 Sep 2026 18:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6FDa-0000dH-8h
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 18:32:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6FDY-0006qK-GN
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 18:32:06 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EJZ2nB2397310
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 22:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=JxiHMi29v8dd/y1rQXJwEQ
 3iNEoC70Is/wYrZ1Gyj7c=; b=XjZl0UANlqDzr/f7YmQXHS28DjfDYa83J3c+/1
 jH5zd59JF2Dl9GR3+VLNgf93vNo7s/J1LfRyPWPPCJHNpO8igoEFLu2ATMEevsGz
 JKD/gb5fwYlaBgqd3OKWov6xe9N7o9TGKKKZ50dtI8b0qHPqUkFM0IQjBWlS0LpP
 PrDH0jrDoQlCdWfxd16Us300MuAG2tkyskov0aPEfKnoU0hOVfgsKGpEswamqtM0
 sw1LD0oWNOozY108uU46QtlOgjFMJB3a0T0yMeabNMmU0tS2a40Zu2rmCKeiz6I1
 5RRH7VCwFjiICJOvfld1CDcclMrTo+4wTx8bGxOYinmlXyXg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpn41s28e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 22:32:01 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cbb92868263so3104034a12.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 15:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789425121; x=1790029921; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JxiHMi29v8dd/y1rQXJwEQ3iNEoC70Is/wYrZ1Gyj7c=;
 b=A+wQrsaRzscqW3Q1PAKQyrUCVLgNlyq5XUtqTFXVxJ8fE9WhXvIFacuAKFJtuHBmzZ
 RJnMRsuPVe24z3YIAhaXMSyLw1VekKRg0iKSQhgwWoufDu19k+JQf+qPLmS6fVAFkv5M
 bqvp38XulkcriPRF2tX74ZTefwQoxBStUe5txp7u3c0RkmWrd2PCGkgQdB1a4N7wMIqr
 f9c/LDgtpU3sGAvNmx0AIn8i7pkw/jK7Bk5hwVDe8xMLd6KYjCQKeMLevDdJDvA8NC8n
 lqa/nGldbQLK5ENlqC7Wr5qUQ+yd6DtjHlMLoORJmKSNUOGZoUgOLgfDSRTLZi0ghDBh
 qEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789425121; x=1790029921;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JxiHMi29v8dd/y1rQXJwEQ3iNEoC70Is/wYrZ1Gyj7c=;
 b=Wxqf7CdCK5C01Eq4MMZCC3R3j1odTOETb849S7N5pmFLx/DxxXSgZjvVk8DNVMCpZP
 T8i3Odkd1kqFKOGp0nyUDH+a9cfJf5ifau5JUEkQf7dOwl4w5y77EgRUaHkQueyu/ERu
 j+1u+KueidYyTPALggDwHuV2pehV3O2IKAKyyvVbLkBMsoYHRidrvvvFJjd0MxtpJEzi
 rnKDosGlz+5E11T1et/TOJk86aVIi3V3UPFCDGUADJCHhjfUwIru5J0DuACzRpavoUBc
 UkpYiSZWjtcoLeuEse9w45wHGo7cBm+x/WUWGDV75mXn4RP+/4s2KlG98ZfU6HnVZUrR
 QjvQ==
X-Gm-Message-State: AFuF++nTkn/lWVLTgN5zIc8u1zjgvLfgV1GWj7flXFt188BUcdYqljkE
 gIBQsTvNM+cDZ2XSLgo7gZiQ2TY8E1NLjpj30wxZveXBiHGn7GBimdcoawbvlRvgVYZMSZqAlzJ
 edJHRtE7z10meHc/PZhbPTRh2nViIK6U2Pgjl/HDZYZTRO92sDt1nbRhWtgCZDdHKoQ==
X-Gm-Gg: AYBFou2v8+ILXO3BzkH8TzRskwZc7iceqftAq4VI08XfhiIXJrtKX4a8dG8rYl54m6k
 /D/gGOKZkXLc8IGjaMQpYJ5HxQJdp/GDa1C7xqOpOc/k5g4mP9SD66aIymN6vUwQeLGPf3n+7o9
 EjwMsikzMDdx2iaVYC8aznPK5GIED90J4gCKQwZAJvSWzRY4ZWBsZQRxeMsogtkOIrMZ8QhdGvt
 xOdBy6S0OfNgR+x/hReHOf2earLmpnQO0kqHNwTGZalMBNxcDhpekDCl9CVEgTsQDQHUBJJsawb
 i7qkwm4nQHwMtvi6aefovgTeXmDvYURpbfGe+WZZV0E1EWdA3XXSNDcPXoaTEvCwSToLM18/VqF
 A39DjfdMFGtaIvAb32kpdVh1vj6H41G59gmU5tdIla9/KFs6v
X-Received: by 2002:a05:6a21:4a8c:b0:3da:bea4:6219 with SMTP id
 adf61e73a8af0-3db40639da2mr12456367637.20.1789425121248; 
 Mon, 14 Sep 2026 15:32:01 -0700 (PDT)
X-Received: by 2002:a05:6a21:4a8c:b0:3da:bea4:6219 with SMTP id
 adf61e73a8af0-3db40639da2mr12456280637.20.1789425120771; 
 Mon, 14 Sep 2026 15:32:00 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba7a9bb56sm30190753eec.31.2026.09.14.15.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 15:31:59 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 peter.maydell@linaro.org
Subject: [PATCH v2 0/4] hexagon semihosting: Address coverity finding
Date: Mon, 14 Sep 2026 15:31:55 -0700
Message-Id: <20260914223159.2735262-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDMyMiBTYWx0ZWRfXwQFzNcskiftw
 kr3bKF8mfJ7reEB9uqdssoOwmHutbJUmgQBDqPHyc5SCaqeV1TP2+tXl4tb5QZWaKcLFmsmyCU0
 8hZF3pWFUCLjekLSS6ieaK3ONCO55wgfOQ/S2w0rQz8Yw7t0RDjL9E0VEX4l8MxQFV54rR3WmOq
 TJyLjSN5i9x1HI7jOrDNJpnTBxF7xUTrVh7NJc15aZftN244IRoWNFuPFDnHtWd52xVLU62o0eH
 n5vgW2AWHHqJLwhPoTFpDf1JFT5SRgcKz8QUYv8iYeV5hCMP4XYeFj58mLLQbwZSs3MynEn95eh
 PP6M6Mo0l9lybr6mHKXFQnnvLANiJSxyslpxRJXl2Fm41D5U8SgBjt6ls7Qb+O/g9DHdZiQj+au
 kAzYjBej2O2MPJXevpNIIg170H3QZ4X8TyzjiKMltt8RbShFL+i1Uhkz3sPhVph4LZ+kGbD4s3j
 X5BsCSxFwQ2f9ylh70Q==
X-Proofpoint-GUID: O-G3LEtFDdvUlOsJeKD8yOH02955jqmb
X-Authority-Analysis: v=2.4 cv=cqQOAF4i c=1 sm=1 tr=0 ts=6aa875e1 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=2Bx91_897axU4BNsLVcA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: O-G3LEtFDdvUlOsJeKD8yOH02955jqmb
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDMyMiBTYWx0ZWRfXzLBbjILSbFWG
 SJSR2Ul28Ibs89IK7qsFK30kXSFGz5ug9Uz/72WXkugnZDQzv1dXmY989npdD3OYxGBf4ppxRZ4
 iVYPiMAIuZdLU8B2nSATUbAJbgiNxg4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140322
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

VGhlc2UgZml4ZXMgYXJlIHRvIG1pdGlnYXRlIHRoZSBpc3N1ZShzKSByZXBvcnRlZCBieSBDb3Zl
cml0eSBhbmQgUGV0ZXIKTWF5ZGVsbC4KCkluIHYyOgotIEhFWF9TWVNfT1BFTiBzd2l0Y2hlZCB0
byBsb2NrX3VzZXIoKSBmcm9tIGxvY2tfdXNlcl9zdHJpbmcoKQotIHB1bGxlZCBpbiB7b3Blbixy
ZWFkLGNsb3NlfWRpciBmcm9tIHRoZSBhIHByZXYgcGF0Y2gsIGNoYW5nZXMgc2luY2UgdGhhdCB2
MjoKICAqIFJlcGxhY2VzIFBPU0lYIERJUiwgb3BlbmRpcigpLCByZWFkZGlyKCksIGFuZCBjbG9z
ZWRpcigpIHdpdGggcG9ydGFibGUgR0xpYiBHRGlyIEFQSXMuCiAge3VuLH1sb2NrX3VzZXIKICAq
IFJlcGxhY2VzIHRoZSBmaXhlZCBCVUZTSVogcGF0aCBidWZmZXIgYW5kIGJ5dGUtYnktYnl0ZSBn
dWVzdCByZWFkcyB3aXRoIGxvY2tfdXNlcl9zdHJpbmcoKS91bmxvY2tfdXNlcigpLgogICogQWRk
cyBTZW1paG9zdGluZ0Rpciwgd2hpY2ggc3RvcmVzIHRoZSBHRGlyIHBsdXMgZW51bWVyYXRpb24g
c3RhdGUKICAqIFN5bnRoZXNpemVzIC4gYW5kIC4uLCBvbWl0dGVkIGJ5IGdsaWIKICAqIFdyaXRl
cyBpbm9kZSB6ZXJvIGluc3RlYWQgb2YgaG9zdCBkX2lubywgd2hpY2ggR0xpYiBkb2VzIG5vdCBl
eHBvc2UgcG9ydGFibHkuCiAgKiBMaW1pdHMgcmV0dXJuZWQgbmFtZXMgdG8gMjU0IGNoYXJhY3Rl
cnMgcGx1cyBOVUwsIHJhdGhlciB0aGFuIGRlcGVuZGluZyBvbiBob3N0IHN0cnVjdCBkaXJlbnQ6
OmRfbmFtZSBzaXplLgogIFByZXYgb3BlbmRpciB2MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
cWVtdS1kZXZlbC85ODIzZjY3Zi1iZmM2LTQwZTItYmEzZS1jYjAyZTUzYTQwMDRAb3NzLnF1YWxj
b21tLmNvbS8KCnYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYwOTA2
MjIyNTUxLjM3MTI5NTQtMS1icmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20vCgpCcmlhbiBDYWlu
ICgzKToKICB0YXJnZXQvaGV4YWdvbjogZml4IHNlbWlob3N0aW5nIE9QRU4gZmlsZW5hbWUgaGFu
ZGxpbmcKICB0YXJnZXQvaGV4YWdvbjogZml4IHNlbWlob3N0aW5nIFNUQVQgZmlsZW5hbWUgaGFu
ZGxpbmcKICB0YXJnZXQvaGV4YWdvbjogZml4IHNlbWlob3N0aW5nIEFDQ0VTUyBmaWxlbmFtZSBo
YW5kbGluZwoKTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gKDEpOgogIHRhcmdldC9oZXhhZ29u
OiBhZGQgZGlyZWN0b3J5IHNlbWlob3N0aW5nIG9wZXJhdGlvbnMKCiBpbmNsdWRlL2h3L2hleGFn
b24vaGV4YWdvbi5oICAgICAgICAgICAgICB8ICAxNCArLQogaHcvaGV4YWdvbi9oZXgtc3Vic3lz
LmMgICAgICAgICAgICAgICAgICAgfCAgMzIgKystLQogdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMg
ICAgICAgICAgICAgICAgICAgfCAxNzcgKysrKysrKysrKysrKysrKystLS0tLQogdGVzdHMvZnVu
Y3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkgfCAgMTEgKysKIDQgZmlsZXMgY2hhbmdl
ZCwgMTg2IGluc2VydGlvbnMoKyksIDQ4IGRlbGV0aW9ucygtKQoKLS0gCjIuMzQuMQoK

