Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8923CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5CE-00053T-8N; Fri, 29 May 2026 17:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5C8-0004Xk-0H
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5C6-0000V0-9W
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:43 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2Oxj1912421
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A6hX7dXQXO1+fIeZgKUska/ZVbxUwMZyizq5wXsBD70=; b=ho4MNdt2tTMsKD2Y
 7RCetTvUsmGssl3f7BewpyFFbHOPna6AWjTS1xHFUwNKYCQHletKWVlzC3vtFWzk
 fobHmbaRjNtlAVK4Rg0tN8xcK9+kLruOf2xB9cmdcHE/2XLQDdW/jz55HvkRzAH1
 uE9/HuMjf98K5LhRzH0um4HtIDOFhsyhG/VoW9pAatcLzFi9+1qZgKJcFg87l2eq
 lo1g2YGESD2LGtZEDHNPNhO+V7IKRVRpxqUPo6Fp5AIsUqo6ZrYIHUSdbJbfB1M3
 z5kKC5RYUJTdPUcdVS0j4KQcOhnvrPgvEQ3bYwJq7s0CvQfKv+N5xusfiIWrx+u1
 HtpnpA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efbu52gj5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:40 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304df51ff3eso2144849eec.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091800; x=1780696600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A6hX7dXQXO1+fIeZgKUska/ZVbxUwMZyizq5wXsBD70=;
 b=FG+EUvVdirQ3g8N1aAz0yd8tNf4TVVM6iMPU8MUMqh4rDcKx0alxYRSUxYWgRZKW42
 pPPqqqXPQWtPAYIn82b6EjHgfe+RrLrLBTr7/09bHb/7ap8HH6tzhWRr0FexEfMDyjfv
 YiTMN1DJrzge6Z8PRjsX0gDednGp+JVQEBDQB0cbyOL8eGAlWBlS+PEinrjwrX3oH4dZ
 dwOLfgTJ+o4TvaQzQfqODVcRNdY9KOI7hiI5Exw+XA++8lEUPXnxDkhr6HFMAcmzZ871
 b/0m5s/9mhPXUglA8t1wlooHhiPYaiOi0//lfhFzpXww6dYN/blKniigdjP2YmvZqiLu
 XKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091800; x=1780696600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A6hX7dXQXO1+fIeZgKUska/ZVbxUwMZyizq5wXsBD70=;
 b=af5ppRtmnh4GJKXHnaeJbbYe0ETIwJWp9Nn/NCJWcNGokUD9NNOKPaPyCaBxHEHsXT
 BOy4oaBJo6jDSjdetKHdGhbpul3Hky+hy6QTOES41K9eC0Tp3YYAWNeGJBQYfi8EKpjb
 LI714pHZNLZajNGyAs27EP4AKiBmdlkMmArGrSjcc110rjeBGLysrjcbWI/2DO0ELAOy
 75kOvs12hWl8gISljKhMzU8MiWetOsr3feXTEoKDb7x8+OZ4uFh/tO6HOptnIFdqjWog
 j45SrxbvT5WgbEWPJiHXvMPHOJl3LGZIAj/cgQ0Y2GpK322Simrf5oUuxuFzCLbnUIvV
 deCQ==
X-Gm-Message-State: AOJu0YzI6TXBHwwOSpCk1ejNS6t/oP1f/y4VXOjnOxegyvUJBYaiP7Yl
 x8QV2cpnIYvxh9/ijKo6acoG1rbmIyKH6wTvG1Zh0d+kHj76tACfagjhh7RZsBXrxgDAULYRYK+
 S41WANDwsnYzJcAW+3KyH+yxyKnXKdPCBsYawFMVV9fxdgUtDDRp62zPMFto9HZFhlw==
X-Gm-Gg: Acq92OG/tYspamgl/30Y1+LbQYoN/wKNVMSO6A2Yw49HWuiqhrc6aKUi0iUcw5e88GR
 qFa4JJ1O3dGwsig+ZgKCad8Rsq1ZFqRoRJCPsDGm41IBg/QFz1+wan8ZONNyWkHuaNJM6n8S6A8
 UbViqaM+R6j3QIbq+jOUFfaqrV7/DDn4Crb6OWgAkj69mzGj5sQbxBQblxdJeBkCVVd97GQWqC4
 FNrzDm02r8ocs70aMlcz7PkQgtmceYxUJpK2Ln0lUd1tBzcSPU6LAjhyjOrjvShe1JfYil5Yu0r
 CZBQqht5+ChEbOxw4exxatx/TqNEwu86ytfs82nveh1ui50I+TUo2Aar0Q+7tlL5QVj2+DkAmKt
 IR6hNBCVR9/ne9hNWia+LadjoJBehEkXacZgBiHErIEm3j5tju/hMGjuvcHoGrf2M3woky7931o
 I28X1q
X-Received: by 2002:a05:7300:2214:b0:304:cefc:5fe3 with SMTP id
 5a478bee46e88-304fa62a999mr866729eec.18.1780091800150; 
 Fri, 29 May 2026 14:56:40 -0700 (PDT)
X-Received: by 2002:a05:7300:2214:b0:304:cefc:5fe3 with SMTP id
 5a478bee46e88-304fa62a999mr866717eec.18.1780091799631; 
 Fri, 29 May 2026 14:56:39 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ee0dd8e1sm3026279eec.21.2026.05.29.14.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:56:38 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v7 25/38] target/hexagon: Add implicit attributes to sysemu
 macros
Date: Fri, 29 May 2026 14:55:41 -0700
Message-Id: <20260529215554.606133-26-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=SMRykuvH c=1 sm=1 tr=0 ts=6a1a0b98 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=jiUnMIOmsb6gMTORg9AA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: fPtdZTWLNGErM_0Xd1u65pfTPYMHvK26
X-Proofpoint-ORIG-GUID: fPtdZTWLNGErM_0Xd1u65pfTPYMHvK26
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfXwIJirwy9Vf3b
 iQ2+W5ljJFUnQ8BW2y5NS8JAp++gak/AqOm6Chn5vH3SmSEbeuG9B082IM4HdC7973RJr0Z3IfL
 iMK6u2g0N20DynYmwsBAa1cV7BjNuTIrYWQaYeR4hUw2Q1p57Ef/jcCL0juMGiKhA2qht0a1Rzk
 wxcO5zUgoopf9oRfh1hyE/RZfgHyYsd4rT7DzaDk91Yh+u/umORl/dFFsqlA2Bwer90wnv/Bsh1
 t5XwKSFJbJXMt8dozflzLQtjS/nDFBJhmbdm8ZjT/lF29ZDnXdNx0feyIGjxw7aupTtxnhxX5Py
 X8mEnyWTBl8fGjdYvYY96H4ERCFnlOMEEfk4dQlgL/M2sFTuDSNbXGqpuBPV5SLp4IIsyu2rn/P
 FXLytmz46sCyAokSPP/ZHNBnTfx04kDbsWUHYPDzl3/Rw2NJo/TQ5dMJNEwCIO2YBuFkYbwpWNv
 CWRhASUn2fZi2klVcuw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290219
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

