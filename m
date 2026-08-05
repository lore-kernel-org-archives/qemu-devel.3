Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95942C55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrerB-0005uT-W7; Wed, 05 Aug 2026 12:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrer6-0005t7-Qd
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:52:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrer5-00035S-Cf
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:52:36 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675FVJU03297594
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 16:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1m1pYGY1pWP19c0fIYSK/rzoArHWvUz0fBZQQlWbxb4=; b=Ty7myJi8qiMaGEQJ
 2OT7i+2vbEVWZY5pMSqiGED4cDgXVH4aiaE1IaeiVVWwwL69wIzckjtvkwUfF88j
 9qzKIubn4K4L34rXL2hpY8VuLcWCYCl4LIK8AoIcmVzihn242yfTHpVImmTMYXfs
 thEts5Cpbmk/kTv9ktnP8Xe4NRlQnunDRRz4+7dmfvh9mVF7cHC2Oxao0Cnx5LhD
 bEMRRWH6o516eWfO1tpivu4i2Muoko5echWC1ubX5adh58+jtAUqK5gtz4LPcbD/
 qYvJ9I1WoYtvAulOGqQfT/A1rh70X5PkqyqeRLpqkCMWrV8pBQRMSeg0ZkJZ13WL
 Dwzm7w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv5x5s44u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 16:52:34 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e8e864ef0so1873181a91.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 09:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785948753; x=1786553553; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1m1pYGY1pWP19c0fIYSK/rzoArHWvUz0fBZQQlWbxb4=;
 b=exks8p5DWTB5gI3U2lXzKJZi7y5ezpEEE9PGY/MHHunKqO/v79oNOb1g+Lsp0Vwi8E
 VP8TfkAypnXpqxw0qz6LKlrxePPsZJE0hKAjFSD5RZr/hICeKgK7L/OXfGFpOaZa9Pt+
 K5qcBzGRV8hYtIbJ5Upy8P0pbG2O50ll+56tENN1DK5UDNLkkotRApoOeE3FAQr6RB4b
 BrnnrAGIWVSdAB2JMWXHA2GPtdTl0ZEc2wSXsuR8xXZn8FFl3BLN9vdpJS6Z0+zOc25B
 YIwmLkVR+BtqB5xy9n/4V4Qvr/vck4oaN18T2P1qxr2gWRSwiew9Z5qhtyrFGLX2dHzy
 3HRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785948753; x=1786553553;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1m1pYGY1pWP19c0fIYSK/rzoArHWvUz0fBZQQlWbxb4=;
 b=Yl88oTrq7uw1R99aAXz1jvppkF4ICYhdES8tw8t2OH8qxIPJ1suYI5mNEmWJRpKSi+
 89VOk2qoCgrdjVabboQa5388HhtTswQOPD7/G6RY8M+L3YIaCzLxBJGmZw60XqtpiiVJ
 vryBqjh/kw4kVUzja/Olw5sN9MEfHvTk/sLRqCI1a+MXNQKgzvZXMTNwNAeuvU+bBmA/
 UYGbj5daWyW0LxjkLO+5dWOyHz4NNf1WJlKYPkErcjWIF8GWA+ZZHut0EILdpfkHzlGd
 KOtc7v00nkkhzyBYZAX+hSqs9Eup/GicAqeluJMjoG73f2cbsH7xjxZmrkbE61a27FpQ
 t24Q==
X-Gm-Message-State: AOJu0YyCfiSs/lmAxFE7U/sL3FO6ZBWH9khVsy8tp1UkfEuC4ZqtdT4o
 p0+8YyA+uT8cNQsvc7+C+s7iaF79oThwnhugSe7kigJuVIIL4tUp+kPoPmXt9hGe8RjggKqQ7bM
 8gcFpxMUWRWdndtzOx28xtPUhjLZ48qbo6sGdVpngNX3KhwY0gccsQA0Aa7A/s6fB3Q==
X-Gm-Gg: AR+sD13JJ/IdTyEQzun6DW6eN8twnlrvv2b4Dce0w4WLLDH26gftuaVuIvO3CQAr81x
 hlsI0r37tcurNbDFe9vl6RcJzQ2d5Y5FdaXbAAp6rUg36hOYJNgCsTVYfsl8cwNAHuEGllRH0zA
 MQyf18+lV1/eq3d+NTfsp65OUbf0F037Y4iy0dfzPU5qtwLeUOhQf2geEoPA6EYWUegSzn2Vetb
 ejZHFGg5REQUB1H88/HPo5BgnuxhraT03ioiGhOQIr+nXNT34JgMVlzO25aTKnQrXCFJlik+zGA
 ZT3OAkA40Frm2teZZim1oCLMVEhurj4pKAwyZFAPdSgOKjz2vFYL5Bq3tddDP0S5c2mQ9AhzAqK
 tn+7fnJt6xqYFXHzdGzxD/5MoeGDBiNpZDbY9ArXWZsUsHd29
X-Received: by 2002:a17:90b:1811:b0:38e:c7b0:84ad with SMTP id
 98e67ed59e1d1-3903bb0ab77mr6823052a91.0.1785948753445; 
 Wed, 05 Aug 2026 09:52:33 -0700 (PDT)
X-Received: by 2002:a17:90b:1811:b0:38e:c7b0:84ad with SMTP id
 98e67ed59e1d1-3903bb0ab77mr6822990a91.0.1785948752981; 
 Wed, 05 Aug 2026 09:52:32 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31586402e53sm26429356eec.11.2026.08.05.09.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 09:52:31 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, richard.henderson@linaro.org
Subject: [PATCH 4/6] target/hexagon: add GVec overrides for HVX absolute
 difference
Date: Wed,  5 Aug 2026 09:52:23 -0700
Message-Id: <20260805165225.3117924-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260805165225.3117924-1-brian.cain@oss.qualcomm.com>
References: <20260805165225.3117924-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: KIUmuBFQF_GE_2J4PoiY8qakM5wXw3cM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEzOCBTYWx0ZWRfX9LrA4YcoUUEE
 7jx4f/kTx/gtwZk98dqSsNOqcTWP5jF+UYpf6uLIulepgPAUqxFxLV/IGG5fpm3Y/tgDuUWnCR1
 +PgRGcJDXMVsMrBnwQ1YRs3943Omg/u4t0ybpsofdpliJ0psjhqlcFpdr4763iRiYNN2XOgSXl3
 YqT1rNIQCdg/b6srCfes9eFPPNtLvdfWNRSHxNwnrYE3GS6RBTN/kKsfMhyahUYwmgwu7uWwdVf
 RExhIfnclBxEM516svn15JvC2AmWl8NG1E2CeUGC971A1nDphuOlK86OKI16Uj5cZ3O406R8Ijo
 bmgrc/CjHKOgWlT3PEY3c+8YGqeQMY3ZdDhfeFxebZv6/UTqR8VqUpeYr44ASpm5nSBxHJLdFQG
 opS4a7GD935g0rhNyRSl4ZmWI1PbklMbrfE26dnpt+hKm4ef27SJjsM51TD5cM2RdPaqmb4CKd6
 QxBOVtHg1SCpZKAPx0Q==
X-Proofpoint-ORIG-GUID: KIUmuBFQF_GE_2J4PoiY8qakM5wXw3cM
X-Authority-Analysis: v=2.4 cv=RcygzVtv c=1 sm=1 tr=0 ts=6a736a52 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=0sK9JSh91jUPU9OSC0oA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEzOCBTYWx0ZWRfX5U9TKR+Vdbbw
 17sbgI5G2bObU+ix6IhKoyM6YQk/IW/g4Begn2NxPFQkrBzwiTKGREZi7+dm/HK91hL8CeZxE83
 89iBTcP0M9KLmrT44sQd2+3cRmQA93A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050138
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

U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIHRhcmdldC9oZXhhZ29uL2dlbl90Y2dfaHZ4LmggfCAyMyArKysrKysrKysrKysrKysrKysr
KysrKwogMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJn
ZXQvaGV4YWdvbi9nZW5fdGNnX2h2eC5oIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19odnguaApp
bmRleCBmODQzZmU0ZTJlMS4uM2NiNTJjNzYxYWUgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29u
L2dlbl90Y2dfaHZ4LmgKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19odnguaApAQCAtMzMy
LDYgKzMzMiwyOSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgYXNzZXJ0X3ZoaXN0X3RtcChEaXNhc0Nv
bnRleHQgKmN0eCkKICAgICB0Y2dfZ2VuX2d2ZWNfbXVsKE1PXzE2LCBWZFZfb2ZmLCBWdVZfb2Zm
LCBWdlZfb2ZmLCBcCiAgICAgICAgICAgICAgICAgICAgICBWRUNUT1JfU0laRV9CWVRFLCBWRUNU
T1JfU0laRV9CWVRFKQogCisjZGVmaW5lIGZHRU5fVENHX1ZFQ19BQlNESUZGKFZFQ0UsIE1BWF9G
TiwgTUlOX0ZOKSBcCisgICAgZG8geyBcCisgICAgICAgIGludHB0cl90IHRtcG9mZiA9IG9mZnNl
dG9mKENQVUhleGFnb25TdGF0ZSwgdnRtcCk7IFwKKyAgICAgICAgTUFYX0ZOKFZFQ0UsIHRtcG9m
ZiwgVnVWX29mZiwgVnZWX29mZiwgXAorICAgICAgICAgICAgICAgVkVDVE9SX1NJWkVfQllURSwg
VkVDVE9SX1NJWkVfQllURSk7IFwKKyAgICAgICAgTUlOX0ZOKFZFQ0UsIFZkVl9vZmYsIFZ1Vl9v
ZmYsIFZ2Vl9vZmYsIFwKKyAgICAgICAgICAgICAgIFZFQ1RPUl9TSVpFX0JZVEUsIFZFQ1RPUl9T
SVpFX0JZVEUpOyBcCisgICAgICAgIHRjZ19nZW5fZ3ZlY19zdWIoVkVDRSwgVmRWX29mZiwgdG1w
b2ZmLCBWZFZfb2ZmLCBcCisgICAgICAgICAgICAgICAgICAgICAgICAgVkVDVE9SX1NJWkVfQllU
RSwgVkVDVE9SX1NJWkVfQllURSk7IFwKKyAgICB9IHdoaWxlICgwKQorCisjZGVmaW5lIGZHRU5f
VENHX1Y2X3ZhYnNkaWZmdWIoU0hPUlRDT0RFKSBcCisgICAgZkdFTl9UQ0dfVkVDX0FCU0RJRkYo
TU9fOCwgdGNnX2dlbl9ndmVjX3VtYXgsIHRjZ19nZW5fZ3ZlY191bWluKQorCisjZGVmaW5lIGZH
RU5fVENHX1Y2X3ZhYnNkaWZmdWgoU0hPUlRDT0RFKSBcCisgICAgZkdFTl9UQ0dfVkVDX0FCU0RJ
RkYoTU9fMTYsIHRjZ19nZW5fZ3ZlY191bWF4LCB0Y2dfZ2VuX2d2ZWNfdW1pbikKKworI2RlZmlu
ZSBmR0VOX1RDR19WNl92YWJzZGlmZmgoU0hPUlRDT0RFKSBcCisgICAgZkdFTl9UQ0dfVkVDX0FC
U0RJRkYoTU9fMTYsIHRjZ19nZW5fZ3ZlY19zbWF4LCB0Y2dfZ2VuX2d2ZWNfc21pbikKKworI2Rl
ZmluZSBmR0VOX1RDR19WNl92YWJzZGlmZncoU0hPUlRDT0RFKSBcCisgICAgZkdFTl9UQ0dfVkVD
X0FCU0RJRkYoTU9fMzIsIHRjZ19nZW5fZ3ZlY19zbWF4LCB0Y2dfZ2VuX2d2ZWNfc21pbikKKwog
LyogVmVjdG9yIHNoaWZ0IHJpZ2h0IC0gdmFyaW91cyBmb3JtcyAqLwogI2RlZmluZSBmR0VOX1RD
R19WNl92YXNyaChTSE9SVENPREUpIFwKICAgICBkbyB7IFwKLS0gCjIuMzQuMQoK

