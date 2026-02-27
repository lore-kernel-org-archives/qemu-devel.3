Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979621039895
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4ai-00086k-JK; Fri, 27 Feb 2026 15:37:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4aP-0007Th-Vx
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:22 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4aN-0006sb-C0
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:21 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RIevhr373651
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nDQl3+A1Glkk+mJbt31qfycz/0M5aapDfOrU62HMrpw=; b=RQ1e8+KJDnrL6Y5t
 lWg/Mg3AaaeSwufeP6njM6j4yGwFbrJ+53dZe6llw2J8Z/IykboEvytD7gNGDSJT
 a+1Z1saaWj3oPl0G1qBzLSLvcPyzIHyUEvNYdvMAtnUNnuLhWm/F9YKnw/GhCuus
 8GlU3IPFSfkNbzujww/VMpYDJmLd3sUZ1OKqojGScO+iKNtyKNCvvwndhjIkwzMS
 ExsA6RAyiGn4r3a65Lv0XXFrUbcwQyfLxifyUuXfNYZPIFgCvuGakOjxCEOznb/X
 d5BaeXlmx+pDS9XCmWKStjGcos/GUD6F+cDyq/LWyQ1IEIU9HJ/I0rdag0kNbkB6
 sReyoA==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ckgrtrav5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:37:07 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-66b612efb4aso36285882eaf.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 12:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772224627; x=1772829427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nDQl3+A1Glkk+mJbt31qfycz/0M5aapDfOrU62HMrpw=;
 b=kjgovohIMFUVH8PC/bvDTYJbpNRscr8JwjYZ0t/5g2efe8XF0W7p5au3WwWKRjPXp7
 F2JFJ1NelOQVTNmUFUUixgJuQvKOEBUiqWbkh6oMrnRVfkM0wqQUiWVKK4f4HtK6CC6h
 zOe8768OfIiXgTjRMrJhUxHpSDQC7h6fbg6e3Inhlakkqgo7p4QgUsoUqjCFmTL4ElJ1
 dSvRai5ixDnBqBoegVPziKFmpUThrSoq1M95ooBIes+HOCeCjAs8Zbx6xKFvoEj6QuUB
 D7RdhRVpQH+w3Hj4eQcWbhJ0YSA7QeYJu985FIP0Qknd1t22jJVDEZd67GSBevIpsZom
 GDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772224627; x=1772829427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nDQl3+A1Glkk+mJbt31qfycz/0M5aapDfOrU62HMrpw=;
 b=hq/mGoz+RZx8dS3sLhJEHuVSBsMwZji+OC7zjiLY+tCWM0WvspZtmCOT151l843wtH
 7btuf4u09D8nFbkYmRhHBzNtgDf2y0DZHv9MlBSWg4/jEjBcJ7W9/ccPMzyViPeokTXp
 dBHwCsXVZYSEOIkoD+Y8FpfowrODaaIhITTCDebfIY0175yekFYkzgqZduJstNmunZMY
 sp00zfjmMB3YEPZ9L/e9jtyFIjQYt03YRzTd4MawH6GRl5eXvZjxqwg5UMipYygHZaFU
 4KN3h/zWs0N0e7Y00lTjjSzbyMqXkgpbC2csPJMtc6Vg4zzkRLmI+ql7JY0CTR1cdOZY
 dNLA==
X-Gm-Message-State: AOJu0YyQX9Y4FiVrJZ3GR9CJWfSivxZF112dOYfWkMPgRDETRyKWSHb/
 gNmvXASXtkYUKmp02MfCDA7gV1xvvwj/SLgiKKMLoC5v5nd/cjYe2z9CcnZVIT14ll81GRTHAnD
 E35Ot7JT+JalxDC6PP1tVSO6PnimVvSOMHNg/AfP8BWFrqJrXdhVrjnzz1LkDamY1GQ==
X-Gm-Gg: ATEYQzyr4BxnNcO5YP1dPQf6teTJcJlB6ohTHLnnuyadDezZ6/K5QDhJ1Az6az7uRce
 sr70SfZI/MamYuoUd3e5SgJ6B06e9+Yqspgd+jZbeICur0Kduhetxr6YKs3iCJ+gvvTAXWGvj9b
 s4fLVi/KIVu7OMR37E9ZrM1YvqsXScqZyS6mv6tiVeqd8AGGRrdlc8U11IO8ptd09gCCJeNQcUD
 nRge2gprgzvc2CgaVaa2vQwee5RwUPMGcY/Ev4q8cKMw9wZnlslLR1RSwglJIpyuzvAABbl/TBE
 Jef4RUhYS9U/Bo/GPRJCgo0v6OTiVbPypuEPddQ4P7jS4mm/SYyhMioTsVH38UozpsR8MRI0lKI
 fHUUsSZOVGLXCEH0/xOxViBYznZon1AspdrWCqCG0cStx2creOiMCfwq0amOA0je3EKLAxw==
X-Received: by 2002:a05:6820:2215:b0:66a:e8cd:4954 with SMTP id
 006d021491bc7-679f2211fd6mr4692058eaf.7.1772224627201; 
 Fri, 27 Feb 2026 12:37:07 -0800 (PST)
X-Received: by 2002:a05:6820:2215:b0:66a:e8cd:4954 with SMTP id
 006d021491bc7-679f2211fd6mr4692041eaf.7.1772224626803; 
 Fri, 27 Feb 2026 12:37:06 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cbd405fsm5762935fac.0.2026.02.27.12.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 12:37:06 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 26/37] target/hexagon: Add implicit attributes to sysemu
 macros
Date: Fri, 27 Feb 2026 12:36:16 -0800
Message-Id: <20260227203627.932864-27-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=C8jkCAP+ c=1 sm=1 tr=0 ts=69a20073 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=2tsdG8XDORIkKkt9vG4A:9
 a=QEXdDO2ut3YA:10 a=k4UEASGLJojhI9HsvVT1:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ijK3WtEUS9vEbvwh9SumCTC90JLWoM4u
X-Proofpoint-ORIG-GUID: ijK3WtEUS9vEbvwh9SumCTC90JLWoM4u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4MSBTYWx0ZWRfX5C3jM8YjTjFy
 odRrqn5cbfC7v/1GZWCmEx1/KP4OADjWJctcwJUsXbHxYoaYB3nzH7w2QVLdmmeEBrou3x143hX
 hoFRNE+oewKrF8OL8n82V0yIYyeJ7BMSbWUG19t3d9k+nDkCkWTGiRlWj5GLuhp4ZcHw7oTdDyv
 wjXSZtOBlc6LF8LI1Tqu/IJ/ocMUpFll3q2mM2zjrJnVZHw6Yu4jV2ANoYFuF98G8pvMMvIvbRs
 tL6+1dIOt74alMtUti/HLKowdibsZ0nCp9aqfpBhNmBpMI4QnUJklJg3ujrLYKTk4uZxvgyr2AI
 +8oHpkAFA6AIB49j+B2ZsMeCgBoPqdoO5DOjP3SUCEGFpR0oEG/HQkZgFjz7H39nXXgsJJf2JJc
 HA3My7LCkG+FIiJO392drb4HOc+fBNVOtiGpLAlI8o6opFhVWWAuBcJg/Vq17BCSo5rLR0G324V
 7iwQtb7lQ3YSCRAZYLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270181
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
ZXhfY29tbW9uLnB5CmluZGV4IGFkNjBlOTc4Njg1Li5mMDJhZDc4OGY4NSAxMDA3NTUKLS0tIGEv
dGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQorKysgYi90YXJnZXQvaGV4YWdvbi9oZXhfY29t
bW9uLnB5CkBAIC0xMjksOCArMTI5LDExIEBAIGRlZiBjYWxjdWxhdGVfYXR0cmlicygpOgogICAg
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

