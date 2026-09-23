Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B74AC9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 15:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9P0S-0003RJ-UF; Wed, 23 Sep 2026 11:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9P0M-0003QS-4k
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 11:35:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9P0F-0007nF-T6
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 11:35:26 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NDKr6o2056317
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 15:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Typ3JYefTGrGd8ahyN+/L4
 +hq8M4enRrP3pRfwdoWcU=; b=nxRmjHt5xN+yo+8GZW08+KB/ZubYC02152auNN
 0hAfPKTQ2xYkOgowTRb1EbE791VRzYW3iauz6IA10LDmSeFcpFlDcz1kBQAmjjgx
 79/5PPGvH7OPdji1YBYM8Q8Kowf3OpRbwthEpJSBQeGhEI7UPJ8xod0Olyn+SfsZ
 UucrgMgJzGwTBWs0SD1jfrol1ANaLPMy5nSV0PikVu+zAy94XzaWMONG49vvTDti
 t/l/L9ztbfjd1RuXi6ENedn2lk9quXdVIg88FHYRyoOJCsjrqz4T3hgIH2MZ4X+e
 Tb8L52KBPw7oNO2hWRP4V0SuCr0rH7pXQ0fH/x70RRkqaHIQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfjv0mdr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 15:35:20 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cbb20f82a0eso509650a12.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 08:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790177720; x=1790782520; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Typ3JYefTGrGd8ahyN+/L4+hq8M4enRrP3pRfwdoWcU=;
 b=WSZr21zjwfjW2Qw/35NsRGh6B+2KiTytnNvgm3wIF/a6OcUWRHCOaLUzGGMSpXtYeO
 1cUBHJQSJlrMtwVdHA/M/BtbOuIcP+N/DC5B3/0fnXQLPMtV9dMpT0XvzwPttGcwzbKV
 VCxn8zqezfCjXSzngFAS8sqn/zBKkZkbeZchm8UbOkSZSepJA0MY1d5BojAH4rxAVZwJ
 fbtzLBcpGCnZ0RfjqbuJGol0Xrqwo82tNh7aFU0Kxx4MrXR1QYobGMw80EjHaTnS52Y9
 rnKK7TAegmdr2H8XqsFHFP3WfATx/mcElZJji3mzx1y1txhx7ZJvfcTXOahEaQcL57IF
 j8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790177720; x=1790782520;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Typ3JYefTGrGd8ahyN+/L4+hq8M4enRrP3pRfwdoWcU=;
 b=bbe0A/PM/JUyR2iU9wuucwNy0Qf4Z6soYc6vpscRrvhbEZgOK5Idjn1HhOAl/j/xry
 vduGjEXhWbVGALJ8jfyHkH0uhw01pRvoGXp7Yke4hYlD2P4ot8nKkEroBnKV01cipwe+
 wZTm/mzpYNQp55Nw1NPPRCuY1fhj8HX4lSEcNlCbOYSUkN9aS4k40mgcfB35FLO3Oq9p
 8k+wGXXGu1RawuvJAJ+4peyjZiBOqSloMrRPz3Rrvb1JjocmUaQ7+1or5/gcYWfGlkfc
 cQxHD2AMjpYX98DwKqg3+wU/vKs6L5gfPUm5p8eMT+9qdaYAq6Ov+cdE7FkfqRExZkSY
 mHpg==
X-Gm-Message-State: AFuF++lzysM3qf82FRjFwXmtAe0Pmp9QXQeykCAdm003kMaPhhcIsw1y
 uE+P/jEMfalMl6XqgAlE0WgKyYvRqrPaU9U/AoCGtkrlw5TpxQRJ4YmtG9vec6CLvpUe4BvvBPS
 9jUNw37yf63MfmELn1PhyJ5h8ffrGrtKg2zM6btVQ/OWExuueWvuLG/qgX/BxRpHpWw==
X-Gm-Gg: AYBFou2i0+FvQEQmxUUY4k8s83ai0kGjW3YMFJLg8ISJiDyqlJ3lduODSew0n9pLXAj
 sk8UmgBBynyCGMKp4QrZcBfLvv23SX3VDn3ZNvuMMharK8FTh/ZvJW3y41a7OG4tRmd2GI3d3qR
 u5Jf+FrReR5aiTVndeYXwmcyGlhJRczoSIibEvLp0HA3ghPEjx725d9Ui1Lzo6Q3yDhK8J0tMbS
 RJM+UDOcy9L9tFggH2LhnbILijb71OkdOjAOztlxLZ7wljHeYvisDpDlRNKm2N8IshWJPI+RKBF
 8qrJ811r3ANtEhumwvDJPsk2q+oHasEAnkDLHHQcYsT8YYOP7diXY6phG4iGktvQsZJJ+/rbkJ9
 +YdMrohRcljCDYSpxrm7d2JUn1H9N+3WZuUW93cM0kPAqldY=
X-Received: by 2002:a05:6a20:93a1:b0:3dd:a196:30a4 with SMTP id
 adf61e73a8af0-3ddf836b601mr2884169637.84.1790177720038; 
 Wed, 23 Sep 2026 08:35:20 -0700 (PDT)
X-Received: by 2002:a05:6a20:93a1:b0:3dd:a196:30a4 with SMTP id
 adf61e73a8af0-3ddf836b601mr2884124637.84.1790177719495; 
 Wed, 23 Sep 2026 08:35:19 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d1e601b5dsm1516072b3a.61.2026.09.23.08.35.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 08:35:18 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 peter.maydell@linaro.org
Subject: [PATCH v3 0/4] hexagon semihosting: Address coverity finding
Date: Wed, 23 Sep 2026 08:35:12 -0700
Message-Id: <20260923153516.3615007-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2MiBTYWx0ZWRfX45hTiXtetnXB
 ytKcQ3VpY/EdgBtQTJe+UwOIRaf30fwruQ4J9AOpdxgA1eZSHNe57y6xoENQ+DVPJFHdsLAXoZi
 Fx9qKhaOkyr5CUCBobRJbrMAZmL/1a63uFgw3oD39COjSLf37NY0Ghkx1XP9BPMEQih9fZQstSz
 XHLAWznGoRRVZK0wJCKWGPeY+ZTR0sWAKGA/uULjGB/5L2ojgmNqQORoFja/RUB9HjwZ87dyhuh
 LUDocfhIT7aUfjhIBHXWCDEofgLKGxQEjEYEkoX/mTLsR9OJjLga/OhWA10c8yRtaahDXbX0k0s
 +lRjvIGabsFNTk3GjQStUV9YMJH5Gwh9itn+KD6E8Dp1nGFIw13C5o5x6fZ4vf9vFgr6HYd0p8E
 Vd3cMGFy97JsonLg88NaFlTnJLvm7fbKrQ4fbvktxcwv6nu7gqFOiElUckK+8501i5vbGPbuKdg
 rSHRUS39NVmbRV1o8FA==
X-Authority-Analysis: v=2.4 cv=aIxlOr9m c=1 sm=1 tr=0 ts=6ab3f1b8 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=avrHuUREsgjVG1DLOuAA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: 8wAUQgGSaEddGIsTBmIuRGYWqzwacTlV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2MiBTYWx0ZWRfXzsuDQ/fH/SNG
 H+Ax0h0tsq+Z+YBNffOt7RhtsUJFS4HE27BUOav886wdG94RYLj+T3dt81ymHfKp1mtp6KA6Mgv
 ULXvIt+3ZD4oMfrGZH++c3u+FuuxnH4=
X-Proofpoint-ORIG-GUID: 8wAUQgGSaEddGIsTBmIuRGYWqzwacTlV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230062
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
cml0eSBhbmQgUGV0ZXIKTWF5ZGVsbC4KCkluIHYzOgotIFRoZSBmaXJzdCBwYXRjaCBub3cgdXNl
cyBnZXRfdXNlcl8qKCkgZm9yIHNlbWlob3N0aW5nIGFyZ3VtZW50IGFjY2Vzc2VzLAppbnN0ZWFk
IG9mIGhleGFnb25fcmVhZF9tZW1vcnkoKSwgbm93IHJlbW92ZWQuCi0gRm9yIEhFWF9TWVNfT1BF
TiwgZmlsZW5hbWUvbGVuIHZhbGlkYXRpb24gZXJyb3JzIGFyZSBoYW5kbGVkIHRvZ2V0aGVyLgoK
SW4gdjI6Ci0gSEVYX1NZU19PUEVOIHN3aXRjaGVkIHRvIGxvY2tfdXNlcigpIGZyb20gbG9ja191
c2VyX3N0cmluZygpCi0gcHVsbGVkIGluIHtvcGVuLHJlYWQsY2xvc2V9ZGlyIGZyb20gdGhlIGEg
cHJldiBwYXRjaCwgY2hhbmdlcyBzaW5jZSB0aGF0IHYyOgogICogUmVwbGFjZXMgUE9TSVggRElS
LCBvcGVuZGlyKCksIHJlYWRkaXIoKSwgYW5kIGNsb3NlZGlyKCkgd2l0aCBwb3J0YWJsZSBHTGli
IEdEaXIgQVBJcy4KICB7dW4sfWxvY2tfdXNlcgogICogUmVwbGFjZXMgdGhlIGZpeGVkIEJVRlNJ
WiBwYXRoIGJ1ZmZlciBhbmQgYnl0ZS1ieS1ieXRlIGd1ZXN0IHJlYWRzIHdpdGggbG9ja191c2Vy
X3N0cmluZygpL3VubG9ja191c2VyKCkuCiAgKiBBZGRzIFNlbWlob3N0aW5nRGlyLCB3aGljaCBz
dG9yZXMgdGhlIEdEaXIgcGx1cyBlbnVtZXJhdGlvbiBzdGF0ZQogICogU3ludGhlc2l6ZXMgLiBh
bmQgLi4sIG9taXR0ZWQgYnkgZ2xpYgogICogV3JpdGVzIGlub2RlIHplcm8gaW5zdGVhZCBvZiBo
b3N0IGRfaW5vLCB3aGljaCBHTGliIGRvZXMgbm90IGV4cG9zZSBwb3J0YWJseS4KICAqIExpbWl0
cyByZXR1cm5lZCBuYW1lcyB0byAyNTQgY2hhcmFjdGVycyBwbHVzIE5VTCwgcmF0aGVyIHRoYW4g
ZGVwZW5kaW5nIG9uIGhvc3Qgc3RydWN0IGRpcmVudDo6ZF9uYW1lIHNpemUuCiAgUHJldiBvcGVu
ZGlyIHYyOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzk4MjNmNjdmLWJmYzYt
NDBlMi1iYTNlLWNiMDJlNTNhNDAwNEBvc3MucXVhbGNvbW0uY29tLwoKdjI6IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjA5MTQyMjMxNTkuMjczNTI2Mi0xLWJyaWFuLmNh
aW5Ab3NzLnF1YWxjb21tLmNvbS8KdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2
ZWwvMjAyNjA5MDYyMjI1NTEuMzcxMjk1NC0xLWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbS8K
CkJyaWFuIENhaW4gKDMpOgogIHRhcmdldC9oZXhhZ29uOiBmaXggc2VtaWhvc3RpbmcgT1BFTiBm
aWxlbmFtZSBoYW5kbGluZwogIHRhcmdldC9oZXhhZ29uOiBmaXggc2VtaWhvc3RpbmcgU1RBVCBm
aWxlbmFtZSBoYW5kbGluZwogIHRhcmdldC9oZXhhZ29uOiBmaXggc2VtaWhvc3RpbmcgQUNDRVNT
IGZpbGVuYW1lIGhhbmRsaW5nCgpNYXRoZXVzIFRhdmFyZXMgQmVybmFyZGlubyAoMSk6CiAgdGFy
Z2V0L2hleGFnb246IGFkZCBkaXJlY3Rvcnkgc2VtaWhvc3Rpbmcgb3BlcmF0aW9ucwoKIGluY2x1
ZGUvaHcvaGV4YWdvbi9oZXhhZ29uLmggICAgICAgICAgICAgIHwgIDE0ICstCiB0YXJnZXQvaGV4
YWdvbi9jcHVfaGVscGVyLmggICAgICAgICAgICAgICB8ICAgMiAtCiBody9oZXhhZ29uL2hleC1z
dWJzeXMuYyAgICAgICAgICAgICAgICAgICB8ICAzMiArKy0KIHRhcmdldC9oZXhhZ29uL2NwdV9o
ZWxwZXIuYyAgICAgICAgICAgICAgIHwgIDQ4ICstLS0tCiB0YXJnZXQvaGV4YWdvbi9oZXhzd2ku
YyAgICAgICAgICAgICAgICAgICB8IDI0MiArKysrKysrKysrKysrKysrKy0tLS0tCiB0ZXN0cy9m
dW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weSB8ICAxMSArCiA2IGZpbGVzIGNoYW5n
ZWQsIDIzNSBpbnNlcnRpb25zKCspLCAxMTQgZGVsZXRpb25zKC0pCgotLSAKMi4zNC4xCgo=

