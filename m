Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 835AFC624D3
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 18:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2uqW-0002uW-Uk; Sat, 05 Sep 2026 14:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uqC-0002r0-BQ
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uqA-0001cV-6V
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:11 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685Hb9oK3176649
 for <qemu-devel@nongnu.org>; Sat, 5 Sep 2026 18:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BNTBfg/jxMUKDIrquAXtLbZF4+6WD2+luYrCyOoqZ6E=; b=PjOUUofRQ9vcCs1v
 OiUg4G3ByY0MEZfWM18UDE1tQ3261uf7mRBmF4OuBVNV1AetSD7ec15lW7uERlvR
 PXiEb5f7WeM8XaZcE9V6V9XQdZ8jsEJK3VjEkotWXOY7cqLFJR0PY7OKHzn0fzY6
 I0mhAovNqcmm913v+1hiS5Z17pMAwUPlBPCT6KCCMX5M6YUBIazuMecKjLJHQdHC
 oWaxeHqhmd1P2gjTTsKPBxBHYKuN2yyDKNQNd+x+XmU1wIIjHfk/XdHeeYmO3zs/
 p5n6q8HPrnCXwF5YHQunV5iBIC6k+Zrs4vaiQBQ5XuMTSot1gC4RryxtKJRPcw+h
 tH+nuw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggb5v9u5p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 18:10:09 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-398ba5404d2so3663897a91.1
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 11:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788631807; x=1789236607; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BNTBfg/jxMUKDIrquAXtLbZF4+6WD2+luYrCyOoqZ6E=;
 b=fEUDmsShpRhNnesjIIBkZStPht+RpWyeSgeRiuQk4agBppZYpt0oRoevGoAaQJr7W6
 3L5k3ExWiXj9SkWlbytB/xIjID9Ny78YXS8kc6AZg/JoUgD9OsN7oIdoohbQFALUckpD
 rslgql+XN/v9phVs6sGUodwqmSKHZEO1jpxHPeGJ5MWJJcF7/yL/AcVxj4zoFZV2FiwZ
 4YqrXSMjPSBtcSiDob7r5ba1cn2fYn2QBs+RO20WhTjPC8jkr2U0qyFNjWLbTAjiGkJe
 1HwKyA8tgv1NhHwoCnikIZsDkE2SHXPlrDRekgJDS5WqeBFPtC9dE4PQ9hUDbzFMr0Bj
 rX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788631807; x=1789236607;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BNTBfg/jxMUKDIrquAXtLbZF4+6WD2+luYrCyOoqZ6E=;
 b=fkKlSke4nxIyESPBU25B9q0mfvYlS3yEPpnsTE1o1oGNYiYmmZiiGCEH+akYxm37RM
 IQpU8Q7TJWiAU84HHPC52HPrv4HlWRSdu1E+fNfiGn0ReYElFH2lis2dQAv9Kv4L+P5T
 A/sIN+az06o10ZZQJ+mN3V2qBV7DS7+Rv4azJFDZb1hXn8i9o6tRKFauSg7y/rYSJrwO
 6ozdtp2+wnFDwPsGFuv1vLLzOGY0y7uPkZz7y7Y7YyFrj2cN+oueWZHAsbo3Q+YIrE2o
 04CQWzJieRgsQqv8vcM7IKEr5PPHMlPWXmt8x+IEzc4mYfbyGnaWqQnusM5hckdHQAmZ
 O9ag==
X-Gm-Message-State: AFuF++n0euhNrSjtADEn3FCW0kUbnDh5zf8DHH/fbzN3I35NS4uUMA2W
 29aIN1/FZi9GcIxsRA8GgFIXzV8S3WQ3XViD2VzK8o7k5e/lCUOLTw3qiUviP8AEzFQrtz7tmj+
 E9KglE4BCcAvrBECXCFTfDJMLRhIaFYQbUBwE2Kdumng28TDxHnIuYYtxhVmkF6Llew==
X-Gm-Gg: AYBFou3ssWTFRO7ZxVTSHNUNwZ/R56Dpa2BI2LGcooFOyVGjmu6xxoiRhLmOIP58smL
 3ZbozJR8IsoVug5efeoeL6ZNZ5X5jUWC0R3NT9R5xHFJTojtYmPk0HLNP1C08YwzijHNszpMp4F
 0miJxcyf7af/vGdd4meLNSbsPoBNV+FvKzq+nY0naMGI7HDU7TtYnY/phBxTzHadezOvLx6ld8L
 C2fpgxZwyLUfawL4Wqi9Ruoi/5eX8/jxZv42dzzryhNO9qhFZcncHQPHeBHA0C6hZ8K0j7T3lUA
 yUBbH0g280TCXNM4tfJp2gApiRBSH4BfZWsH03tnMMnMpnqCZ1gl3zZm+jXpaixUVXS39d7TM3G
 iw6ruGY8RpfWpNCCrb70ieS+xyy8Uj1GTUWUEUKr8r92BMgKq
X-Received: by 2002:a17:90b:4b0c:b0:37f:fdc8:71b4 with SMTP id
 98e67ed59e1d1-39b26121f6cmr20827855a91.2.1788631807039; 
 Sat, 05 Sep 2026 11:10:07 -0700 (PDT)
X-Received: by 2002:a17:90b:4b0c:b0:37f:fdc8:71b4 with SMTP id
 98e67ed59e1d1-39b26121f6cmr20827801a91.2.1788631806554; 
 Sat, 05 Sep 2026 11:10:06 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339a534df1sm17985505eec.7.2026.09.05.11.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 11:10:05 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, sid.manning@oss.qualcomm.com
Subject: [PATCH 07/17] tests/tcg/hexagon: add bit interleave and convergent
 rounding tests
Date: Sat,  5 Sep 2026 11:09:39 -0700
Message-Id: <20260905180949.1852673-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
References: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 15Db4-tPK6abWD1LzIUJgTm-PNnhZnlJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfX/HLTG92gRyzl
 yDgR5WLAGkWPS7NHqhHBYLU6yaliz4ofeCf5vaOpYdA/8HZQT5YX4WWMIbSbv3WL6GXBzqDVoZe
 f+thRhVStdWZUxMkjdHX9EVgWUHz6OhzBZTa42z5Xw/zgZ9tQi0SHvgtc+TK1UYjRc+soVSwPZR
 7AM52Dh07DPPjzIBmvIqO6dxE6D7II/+ZTtleL0Z0yAbvH3nVhfjyXvPSnRpvh7QU3PPdFeLwmY
 e6ido4KI9I4t5y+j4zVnusOJIY63Eazdbp9smiXcD373Rb/3LfUWhtKt7JMa/31R3ixibwUbnyK
 tA/yh/dvwi6eRvmp4mQ4LQwCHvihROd28ONXkq35eG7snE/OrJKqSavgyx7LnPSpldEuXD064hf
 smGXQd7+xVJ4qMUa4rsnFob4BtgyKh7uY/l7sUEy+6IS2gWzmEJ3j++3d85D3PuaJbDI7DmichO
 DkDnUnL4ByAkai19ccQ==
X-Authority-Analysis: v=2.4 cv=UO3t2ify c=1 sm=1 tr=0 ts=6a9c5b01 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=MD3S-f5BDBJKRhxJpBIA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 15Db4-tPK6abWD1LzIUJgTm-PNnhZnlJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfXz2sBcvEaImyi
 WK4SFU6cRemlHiqtD6UsM7k62QClP34s8Ps9aIzFQSlabAZFG+2BH4sI93xHq++wp+g9g+JE6GH
 FipvpxNZKIczuOk3fNmYm8vxRbysbac=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
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

VGVzdCB0aGUgaW50ZXJsZWF2ZS9kZWludGVybGVhdmUgNjQtYml0IGJpdC1tYW5pcHVsYXRpb24g
aW5zdHJ1Y3Rpb25zCmFuZCB0aGUgY3JvdW5kIGluc3RydWN0aW9uLgoKU2lnbmVkLW9mZi1ieTog
QnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRlc3RzL3RjZy9o
ZXhhZ29uL3Rlc3RfYml0b3BzLmMgfCA5OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysKIHRlc3RzL3RjZy9oZXhhZ29uL21lc29uLmJ1aWxkICAgfCAgMSArCiAyIGZpbGVzIGNoYW5n
ZWQsIDk5IGluc2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy90Y2cvaGV4YWdv
bi90ZXN0X2JpdG9wcy5jCgpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vdGVzdF9iaXRv
cHMuYyBiL3Rlc3RzL3RjZy9oZXhhZ29uL3Rlc3RfYml0b3BzLmMKbmV3IGZpbGUgbW9kZSAxMDA2
NDQKaW5kZXggMDAwMDAwMDAwMDAuLjNlOTI3NGRkZGRkCi0tLSAvZGV2L251bGwKKysrIGIvdGVz
dHMvdGNnL2hleGFnb24vdGVzdF9iaXRvcHMuYwpAQCAtMCwwICsxLDk4IEBACisvKgorICogQ29w
eXJpZ2h0IChjKSBRdWFsY29tbSBUZWNobm9sb2dpZXMsIEluYy4gYW5kL29yIGl0cyBzdWJzaWRp
YXJpZXMuCisgKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgorICov
CisKKy8qCisgKiBUZXN0IGJpdCBpbnRlcmxlYXZlL2RlaW50ZXJsZWF2ZSBhbmQgY29udmVyZ2Vu
dCByb3VuZGluZy4KKyAqLworCisjaW5jbHVkZSA8c3RkaW8uaD4KKyNpbmNsdWRlIDxzdGRpbnQu
aD4KKyNpbmNsdWRlIDxoZXhhZ29uX3Byb3Rvcy5oPgorCitpbnQgZXJyOworCisjaW5jbHVkZSAi
aGV4X3Rlc3QuaCIKKworc3RhdGljIHZvaWQgY2hlY2tfaW50ZXJsZWF2ZSh2b2lkKQoreworICAg
IHVpbnQ2NF90IGlucHV0OworICAgIHVpbnQ2NF90IGludGVyOworICAgIHVpbnQ2NF90IGRlaW50
ZXI7CisKKyAgICAvKgorICAgICAqIGludGVybGVhdmUgdGFrZXMgdGhlIDMyIGV2ZW4gYml0cyBh
bmQgMzIgb2RkIGJpdHMgb2YgUnNzIGFuZAorICAgICAqIGludGVybGVhdmVzIHRoZW06IGV2ZW5b
MF0gZ29lcyB0byBiaXQgMCwgb2RkWzBdIHRvIGJpdCAxLAorICAgICAqIGV2ZW5bMV0gdG8gYml0
IDIsIG9kZFsxXSB0byBiaXQgMywgZXRjLgorICAgICAqCisgICAgICogSW5wdXQ6ICBsb3cgMzIg
Yml0cyAoZXZlbiBoYWxmKSwgaGlnaCAzMiBiaXRzIChvZGQgaGFsZikKKyAgICAgKiBJZiBsb3cg
PSAweEZGRkZGRkZGLCBoaWdoID0gMHgwMDAwMDAwMDoKKyAgICAgKiAgIHJlc3VsdCBoYXMgZXZl
cnkgZXZlbiBiaXQgc2V0LCBldmVyeSBvZGQgYml0IGNsZWFyCisgICAgICogICA9IDB4NTU1NTU1
NTU1NTU1NTU1NQorICAgICAqLworICAgIGlucHV0ID0gMHgwMDAwMDAwMEZGRkZGRkZGVUxMOwor
ICAgIGludGVyID0gUTZfUF9pbnRlcmxlYXZlX1AoaW5wdXQpOworICAgIGNoZWNrNjQoaW50ZXIs
IDB4NTU1NTU1NTU1NTU1NTU1NVVMTCk7CisKKyAgICAvKiBBbGwgb25lcyBzaG91bGQgc3RheSBh
bGwgb25lcyAqLworICAgIGlucHV0ID0gMHhGRkZGRkZGRkZGRkZGRkZGVUxMOworICAgIGludGVy
ID0gUTZfUF9pbnRlcmxlYXZlX1AoaW5wdXQpOworICAgIGNoZWNrNjQoaW50ZXIsIDB4RkZGRkZG
RkZGRkZGRkZGRlVMTCk7CisKKyAgICAvKiBBbGwgemVyb3Mgc2hvdWxkIHN0YXkgYWxsIHplcm9z
ICovCisgICAgaW5wdXQgPSAweDAwMDAwMDAwMDAwMDAwMDBVTEw7CisgICAgaW50ZXIgPSBRNl9Q
X2ludGVybGVhdmVfUChpbnB1dCk7CisgICAgY2hlY2s2NChpbnRlciwgMHgwMDAwMDAwMDAwMDAw
MDAwVUxMKTsKKworICAgIC8qCisgICAgICogZGVpbnRlcmxlYXZlIGlzIHRoZSBpbnZlcnNlIG9m
IGludGVybGVhdmUuCisgICAgICogZGVpbnRlcmxlYXZlKGludGVybGVhdmUoeCkpIHNob3VsZCBl
cXVhbCB4LgorICAgICAqLworICAgIGlucHV0ID0gMHhERUFEQkVFRkNBRkVCQUJFVUxMOworICAg
IGludGVyID0gUTZfUF9pbnRlcmxlYXZlX1AoaW5wdXQpOworICAgIGRlaW50ZXIgPSBRNl9QX2Rl
aW50ZXJsZWF2ZV9QKGludGVyKTsKKyAgICBjaGVjazY0KGRlaW50ZXIsIGlucHV0KTsKKworICAg
IC8qIGRlaW50ZXJsZWF2ZSBvZiAweDU1NTUuLi41NTU1IC0+IGxvdyBoYWxmIGFsbCAxcywgaGln
aCBoYWxmIGFsbCAwcyAqLworICAgIGRlaW50ZXIgPSBRNl9QX2RlaW50ZXJsZWF2ZV9QKDB4NTU1
NTU1NTU1NTU1NTU1NVVMTCk7CisgICAgY2hlY2s2NChkZWludGVyLCAweDAwMDAwMDAwRkZGRkZG
RkZVTEwpOworfQorCitzdGF0aWMgdm9pZCBjaGVja19jcm91bmQodm9pZCkKK3sKKyAgICAvKgor
ICAgICAqIGNyb3VuZCgweDMwMCwgIzgpIC0+IDMgKGV4YWN0IHNoaWZ0LCBubyByb3VuZGluZyBu
ZWVkZWQpLgorICAgICAqIDB4MzAwID4+IDggPSAzCisgICAgICovCisgICAgY2hlY2szMihRNl9S
X2Nyb3VuZF9SSSgweDMwMCwgOCksIDMpOworCisgICAgLyoKKyAgICAgKiBjcm91bmQoMHgzODAs
ICM4KSAtPiA0ICgweDM4MCA+PiA4ID0gMy41LCByb3VuZHMgdG8gZXZlbiA9IDQpCisgICAgICov
CisgICAgY2hlY2szMihRNl9SX2Nyb3VuZF9SSSgweDM4MCwgOCksIDQpOworCisgICAgLyoKKyAg
ICAgKiBjcm91bmQoMHgyODAsICM4KSAtPiAyICgweDI4MCA+PiA4ID0gMi41LCByb3VuZHMgdG8g
ZXZlbiA9IDIpCisgICAgICovCisgICAgY2hlY2szMihRNl9SX2Nyb3VuZF9SSSgweDI4MCwgOCks
IDIpOworCisgICAgLyoKKyAgICAgKiBjcm91bmQoMHgzQzAsICM4KSAtPiA0ICgweDNDMCA+PiA4
ID0gMy43NSwgcm91bmRzIHVwIHRvIDQpCisgICAgICovCisgICAgY2hlY2szMihRNl9SX2Nyb3Vu
ZF9SSSgweDNDMCwgOCksIDQpOworCisgICAgLyoKKyAgICAgKiBTaGlmdCBieSAwIC0+IHJldHVy
biB0aGUgaW5wdXQgdW5jaGFuZ2VkLgorICAgICAqLworICAgIGNoZWNrMzIoUTZfUl9jcm91bmRf
UkkoNDIsIDApLCA0Mik7Cit9CisKK2ludCBtYWluKHZvaWQpCit7CisgICAgY2hlY2tfaW50ZXJs
ZWF2ZSgpOworICAgIGNoZWNrX2Nyb3VuZCgpOworCisgICAgcHV0cyhlcnIgPyAiRkFJTCIgOiAi
UEFTUyIpOworICAgIHJldHVybiBlcnIgPyAxIDogMDsKK30KZGlmZiAtLWdpdCBhL3Rlc3RzL3Rj
Zy9oZXhhZ29uL21lc29uLmJ1aWxkIGIvdGVzdHMvdGNnL2hleGFnb24vbWVzb24uYnVpbGQKaW5k
ZXggNGEyODI2YzQyNzYuLjZjOGUyNjg3NmFmIDEwMDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdv
bi9tZXNvbi5idWlsZAorKysgYi90ZXN0cy90Y2cvaGV4YWdvbi9tZXNvbi5idWlsZApAQCAtNjks
NiArNjksNyBAQCB0ZXN0cyArPSB7CiAgICd0ZXN0X2Ficy5TJzogeydjZmxhZ3MnOiBhc21mbGFn
c30sCiAgICd0ZXN0X2JpdGNudC5TJzogeydjZmxhZ3MnOiBhc21mbGFnc30sCiAgICd0ZXN0X2Jp
dHNwbGl0LlMnOiB7J2NmbGFncyc6IGFzbWZsYWdzfSwKKyAgJ3Rlc3RfYml0b3BzLmMnOiB7J2Nm
bGFncyc6IGNmbGFnc30sCiAgICd0ZXN0X2NhbGwuUyc6IHsnY2ZsYWdzJzogYXNtZmxhZ3N9LAog
ICAndGVzdF9jbG9iYmVyLlMnOiB7J2NmbGFncyc6IGFzbWZsYWdzfSwKICAgJ3Rlc3RfY21wLlMn
OiB7J2NmbGFncyc6IGFzbWZsYWdzfSwKLS0gCjIuMzQuMQoK

