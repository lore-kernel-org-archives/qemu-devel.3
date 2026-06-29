Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E410BC43638
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBnm-0004iM-5l; Mon, 29 Jun 2026 09:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBnj-0004fX-GQ
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBnh-0003FF-Tn
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:27 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT4h32646950
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A6hX7dXQXO1+fIeZgKUska/ZVbxUwMZyizq5wXsBD70=; b=ITrPppUzeidfbKVu
 KcKG8eJnMcqlsmeJ2n+/R/S3vWz2Rt/ZHnGZaye5KgPRE+uDsPyCDGz3MixBVimV
 R2Ya5+T+5LwqOuv+0hmA2527fcIzRHgNCNYjCeEs7qTAmHztfaTzONOzwKHF7dU8
 PfC1b6YH2JwehoONBiHRX8iZSuteMOcXs+6bfBup5w1J95HtJt0Xy5Ln22tfVExQ
 lRIvX+3mkLpKH6CWm+ZkBPZmxzPXYnE41J0nYLgywewZgCZQ0RyrY9Zi6a+6FCoo
 9s5tPwUrmq7Z1TLz9OnrwUN9+QTCQ2PaO+6DmHmiI4bJpblHUyaATfgKv+QJ5Ddk
 1POaVg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3m4tsdmq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:24 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-139b70ca7e5so6898801c88.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782738804; x=1783343604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A6hX7dXQXO1+fIeZgKUska/ZVbxUwMZyizq5wXsBD70=;
 b=VcbmLbi6RNDmZL20IGCLJGJ2XHVfYO4s+dsIoJebe1SAAV1qzyYmWQ6iJInr6Fmny4
 NkoDE4WDyIj2vBae8LiKVoMzeT4TPaB7UGySDa++QMf57t19BePiQlzCcKe1KfMZVfq7
 Vq+GZzKgVJ0Yo30xbjMxSZv/G4tex2VbD0vQTOk0gjpj60BNdzOUHgIBsL8w38a7nVnT
 d3Xhp935UlcvtEoqhLE7T3hSxql42euXCgOrMVXgo0kr6el35AGLIal3DMGLeDu+Ofsa
 jXBYwTS0ydbUwxk+wOtFRO1GVZSrk994s/xMN5deKeyhawoIFQLbaYZP5kRYcmnYkSxy
 u4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782738804; x=1783343604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A6hX7dXQXO1+fIeZgKUska/ZVbxUwMZyizq5wXsBD70=;
 b=oXCLQlFz22A82c4XfQe28OARUlDK69iLYqRdv6C5mJXCVefe/t4EviEuJmPOoGpccz
 KkzoPjyxfRRJcJR8SvRkgkSITGK6UUa9wTuZHazaRgymzZWf0ipb0HQxBwxE5wVuo6DY
 8Onvz/rmH1+9mWg9iqMAuY3MRTQ5cCzVN5QcAN3ziCROlEpAB3nfj8IcuXJ2Pp1O/CBU
 prBJfuu6IMqrY7RVn134iemv+f7LK2EL4KC6UiFTBFjzq0WtGkTBoItbjmE20C7aYYFl
 g5TYfkBue4ywzAzMnNOYF2u4eVDkht+RNn8fC1URtIL0m4iLd1Myz+jYjOZkZZJ4IzgW
 FVuw==
X-Gm-Message-State: AOJu0YzecB4/gs2T8gXBh3nhMhHgfK9v0bfgshSVYJZdxsFGFJ1t5wOF
 l0ew5iZZZIhc/dxjeB7GO/jKQlPKnxq1Vc1p1keSDsamyZz0hqaAzuYxBL8yEwC6ZrwDCWgAN5X
 Fmc6XCGLHxE1Q5Df6SXhCGIGvlNeq40wTN4Wtu/Ug664oJr+FlPivGihq4WFHc7Btow==
X-Gm-Gg: AfdE7ckzhmbqRg2Eh0DJclJrG4NdQE4RnUBTiOd8D5o2diD5nttoliV5uwk38iPeVJo
 NaCs0mq50z6d4rwbpbMPrUPm8wnX6PPgO4FH+XsQY+boszwfW/lzoV6MvRBnWABDwBpm7EQcjJZ
 KP3nfnp4eNSyfHK4qgsoJ7GQWuaBJQ047V818XeFk5B2lt2DM4+BKrZstYzNgVP2fBsIjYATXOC
 2hySaFdIXYWveM+2CCMwJiMSnSIEISTJ/7z9awBkaK/jqQk4rS90J2VyqFITUGrPCOZY2SsMhiM
 ICyUMJ4dmjg7M+tqWv+p0GAdn3JeOeMF9vqM9limXBKsrX4Dyb8ESmrkShoa6XzOzHPdr9UCh+I
 D9i4XvPZHHAifq384Za3E2V9leJiJrRYVorCc9/Y9csQrJj4PjE5YxFAYZ+4=
X-Received: by 2002:a05:7022:23a0:b0:136:d237:b42f with SMTP id
 a92af1059eb24-139dbaba184mr14445251c88.32.1782738803890; 
 Mon, 29 Jun 2026 06:13:23 -0700 (PDT)
X-Received: by 2002:a05:7022:23a0:b0:136:d237:b42f with SMTP id
 a92af1059eb24-139dbaba184mr14445235c88.32.1782738803386; 
 Mon, 29 Jun 2026 06:13:23 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139e78317f3sm28459106c88.9.2026.06.29.06.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:13:22 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 28/77] target/hexagon: Add implicit attributes to sysemu
 macros
Date: Mon, 29 Jun 2026 06:11:43 -0700
Message-Id: <20260629131232.2487780-29-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfXym4hOHqQ/eMF
 aH2GH22XKjx8Jlkx7Day4Rp8t+TNzrAVxI31WV7EKYix9RDvNsB0Da4hDgrnWZ7ziqjPw26zngt
 UO17mcjcCahZorC+rw0qPTOAWPAvgkd9qTDPnbVJGUEccOvH8OVHR1/TWC8mtVD/klE8rgmE/xE
 OLy6D4VC3Ax0BOmg4PLPfrB4m4exr46qeRvtEAth9TnJBi2abdAcqae+rQEJ4oBTPzv0AdzsqMs
 xbowppEMskQYtNtJU5FZ27C9BrboTj7eYw7TK8sXnXcJrYvQept2JHOjz/oo8ZQuvhuz7Yx1//y
 Lpyc+GFGyyDmEb0N5cA8UCnoXwdv310E/WNWRuYX8k1uUWWLycFb6bHDoASgntlo6b/Qx6JbnIq
 O8g2k/q1acZTZkIyMrxzmEQAEjy6Y3LsMQVJZJF8abNpIYAkOoLSYmP7yNd8bsioIROOEibixH6
 +tsfToierDj49wrtIuA==
X-Authority-Analysis: v=2.4 cv=R58z39RX c=1 sm=1 tr=0 ts=6a426f74 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=jiUnMIOmsb6gMTORg9AA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX5km7JcgoU7mb
 2YDiMEhkjOMNOtVkD/xxyxWBP18rHk24xpJPHzjOWS5wKo7Akf1EeReoLUW2yje94kCgM0XJ6FQ
 q9lcBzKQXi1bjJUPxw6HcL7yi/fFztM=
X-Proofpoint-ORIG-GUID: _gWD0LviM7OD4ah0sQRqZlmn54BHeEwh
X-Proofpoint-GUID: _gWD0LviM7OD4ah0sQRqZlmn54BHeEwh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290109
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hl
eF9jb21tb24ucHkgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkgYi90YXJnZXQvaGV4YWdvbi9o
ZXhfY29tbW9uLnB5CmluZGV4IDhjNmEwNTg5Zjg4Li5hY2FhYTNjOTQ0YSAxMDA3NTUKLS0tIGEv
dGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQorKysgYi90YXJnZXQvaGV4YWdvbi9oZXhfY29t
bW9uLnB5CkBAIC0xMjgsOCArMTI4LDExIEBAIGRlZiBjYWxjdWxhdGVfYXR0cmlicygpOgogICAg
IGFkZF9xZW11X21hY3JvX2F0dHJpYigiZlRSQVAiLCAiQV9JTVBMSUNJVF9SRUFEU19QQyIpCiAg
ICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCJmU0VUX09WRVJGTE9XIiwgIkFfSU1QTElDSVRfV1JJ
VEVTX1VTUiIpCiAgICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCJmU0VUX0xQQ0ZHIiwgIkFfSU1Q
TElDSVRfV1JJVEVTX1VTUiIpCisgICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCJmQ0xFQVJfUlRF
X0VYIiwgIkFfSU1QTElDSVRfV1JJVEVTX1NTUiIpCiAgICAgYWRkX3FlbXVfbWFjcm9fYXR0cmli
KCJmTE9BRCIsICJBX1NDQUxBUl9MT0FEIikKICAgICBhZGRfcWVtdV9tYWNyb19hdHRyaWIoImZT
VE9SRSIsICJBX1NDQUxBUl9TVE9SRSIpCisgICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCJmU0VU
X0swX0xPQ0siLCAiQV9JTVBMSUNJVF9SRUFEU19QQyIpCisgICAgYWRkX3FlbXVfbWFjcm9fYXR0
cmliKCJmU0VUX1RMQl9MT0NLIiwgIkFfSU1QTElDSVRfUkVBRFNfUEMiKQogICAgIGFkZF9xZW11
X21hY3JvX2F0dHJpYignZkxTQk5FVzAnLCAnQV9JTVBMSUNJVF9SRUFEU19QMCcpCiAgICAgYWRk
X3FlbXVfbWFjcm9fYXR0cmliKCdmTFNCTkVXME5PVCcsICdBX0lNUExJQ0lUX1JFQURTX1AwJykK
ICAgICBhZGRfcWVtdV9tYWNyb19hdHRyaWIoJ2ZSRUFEX1AwJywgJ0FfSU1QTElDSVRfUkVBRFNf
UDAnKQotLSAKMi4zNC4xCgo=

