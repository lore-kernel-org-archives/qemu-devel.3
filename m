Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A681039895
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4Zs-0006nb-9B; Fri, 27 Feb 2026 15:36:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4Zq-0006mh-0S
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:36:46 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4Zo-0006oL-J6
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:36:45 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RH0Q6j702328
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zqBYBLZUS/PTyeb/BYo6MbQkmUruROsWYFTRwF4oTEs=; b=K36AD/LHpzrUjus0
 lp+uKiEzIpojlNFfJ13Dc4vXV9nfOvwmw6BDsDgVuanYf6XGjZtbnJC9WvAIjaU4
 Cjl0go0s2DhuafcgKR7nMyzboybT9ZZgsgaAPwi/MHDbjs9TGV0CCKeulga2OT9w
 cdZglYdWZcR8n3TXRC/ktZjyiEXgTj+cpG3zRsNYXCBLlhDNa1gYKUnGBmy5qH0T
 wPsat9yDLKNzhaSai3DwosS5/nCA2vaxVsUKpIkAqNOjFtRlkeXHLEKflhD0/lgG
 DthhMPriNmyRpL9NmufRwBu2aqhPtveV2S8aJIHkyU+OfRAkOTCJJRYHxrHl3MnG
 6mAlcA==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ck8x8a30m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:36:43 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-679c6ef1538so51005858eaf.3
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 12:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772224602; x=1772829402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zqBYBLZUS/PTyeb/BYo6MbQkmUruROsWYFTRwF4oTEs=;
 b=IJTiqmw6mM6yVbrQ7c68Dn4OG/J4RWle6B7tCi3TdEbMiYVLti1t2O4DlkFNYdWuPe
 +TWiFi59IlUiLEY6aWT87zVgzrcRVattwAEDjBdwU1zipUW/S3QdyAAZxF3xPIAKO1Sj
 LNgCwZRBs8NpNQj5lcBa99S2k24ecSs+nT89SIknsxTfSOGuJ9ZMiNSoNwnrua97Y5SK
 uLnNMaPFx8jLhMJDKaxxvhVtnr3PIHRMHdV4WBkPiFSxR60cr7/DYq3Kd3EHXdV83338
 BFl2HGC/KaDgJn9i9E8G96EdPsxMPkUrga2IzTfa53g6K5QSV4a7+pr9mYECI+CeW8Og
 2PsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772224602; x=1772829402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zqBYBLZUS/PTyeb/BYo6MbQkmUruROsWYFTRwF4oTEs=;
 b=DGsSf/ZLrQhHm8M2v67XarHeT6XA/oj5LqmNp6MP4a/qOOvIGHD3W7v8rQzwFbpvcA
 xbrcMGXsOH8g53yF4awS0rGEXgsLAnEjNBI77VV4Zv+jsOosgMiDhdgAf7RvLvOkP6G8
 VVOdmfmZpfYcH6leMBdZFzOaKn78OlTcsBDA6Ekvd913p+IBOcARUGlED6nS+PCldcxY
 BckUcsKOGKfhOiI9cYZEWgE6i5cATq6sHUq7QGhP3f5yOp7i5uDodBlP7hIW9RpA+muW
 XiYNpD17HtPJm+7uyKLxd1XWhOLFzr/7HSji7gow/TR2sWe8xP8ASTrfyoNql7VZiPUn
 4Bjg==
X-Gm-Message-State: AOJu0YxA404YP7a9SgWSX22nSxzltSJhDW63iNQeYYSzfYYea9VvRewQ
 3ltzEW7a5K6hGfpnPtw8pcj0M+tQGNv+GJSZWoNlpqhRNuaoEJLWsBO7ysdVY5gSeYEWEQlUZFz
 OQcXr1caqTyUnTdNPMxabip7RHGe7WPZi57Kl9yJ0d8hZycE4U/UNtzZaeOskttbmng==
X-Gm-Gg: ATEYQzwTdQL8+WcdEOdg6f+rBsBBU5L3HLALW8AMV54aABKT6sn+Y3NaWTLOvkjaEQZ
 fpZi49GPhqOe8q2y9+YUTfCzRIuwL5BqdMcqDAzZ31KrMie9efiLpxLFAX2lF5jyokweK4DvAWY
 wS2TO7w62BaEQUnBudeYeO+SsOPFybNGV4txNwfV063Igiv2rLjVfnFxE7iHdwdwe+ZTKpi/urP
 dRYyoYUF6O4SlZ2Vf9dTeLpm/MgZyUn8fe9sVMFkNeEJUDAkwaPj6+77HFcqSY3FGG2wf3ziW0D
 lsHCaoSopyxD2Ej56fbDCtqq3VQmYEj6moaCpY2OJfWBShfeyYbO6Yna8rBJvawbVUKyC8HvqDY
 r71Vf8kFadDB5FzhvCn2ZJfAZpPH9hIEyoNhduFjlaMwAMoY+5m9PRcQY/19Qtq8h0egqfg==
X-Received: by 2002:a05:6870:2b08:b0:409:76e0:bd84 with SMTP id
 586e51a60fabf-41626f24988mr2510363fac.24.1772224602375; 
 Fri, 27 Feb 2026 12:36:42 -0800 (PST)
X-Received: by 2002:a05:6870:2b08:b0:409:76e0:bd84 with SMTP id
 586e51a60fabf-41626f24988mr2510347fac.24.1772224601955; 
 Fri, 27 Feb 2026 12:36:41 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cbd405fsm5762935fac.0.2026.02.27.12.36.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 12:36:41 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 06/37] target/hexagon: Make gen_exception_end_tb non-static
Date: Fri, 27 Feb 2026 12:35:56 -0800
Message-Id: <20260227203627.932864-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=WZwBqkhX c=1 sm=1 tr=0 ts=69a2005b cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=_kTDFcnIhj0vC2WMYgMA:9
 a=QEXdDO2ut3YA:10 a=-UhsvdU3ccFDOXFxFb4l:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4MSBTYWx0ZWRfX6/6cBAGAQKTC
 NXtjRuQLt2AQpZfbJs4o4SaLM6Ak44STv9smYbBHr/o3DsbncjsoUWgOBFnSZ1go9EVgegEQhZG
 Y+IWz9K3MGL+SoGUN7sDH/7vnb6t0JDSwvDHH+oPQKpDlg9NNRdwyu1MEYJtL3fKV/PxxbHJJDC
 goqa+utfGZUFEjyPKA66Tild5vzFsJ9ud5gfPOPf8aOKRgdsslvsSpapI/ZSgY1khj3j4oOJnBI
 8ifgrs0KFjTOjitWX3EzsyIHlRav8vJ6STPIr+8oIG8njvudtQAmi6RyIxY70GiAiCnWO9MhXis
 NvFQdMcYaI9bwxdQbLyZCZCmKvf1g2C3rOp2b0h+jp9ofxfPuOD9du0Cn+D2IHUbHLGA8orE0VB
 dv0GEAxaDqv/B7puefTdnsaeyRyBVLI/IHHH+yTGtUNbLHr4SwNuuSjE8IESKCW4znaqaTXaKay
 wVDnWPfNzc2GFnDrGOw==
X-Proofpoint-ORIG-GUID: WLFre0a932fRuQ4MXFg1mkfLujB4l13K
X-Proofpoint-GUID: WLFre0a932fRuQ4MXFg1mkfLujB4l13K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5oIHwgMiArKwogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgfCA2ICsrKy0tLQog
MiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmggYi90YXJnZXQvaGV4YWdvbi90cmFuc2xh
dGUuaAppbmRleCBiMzdjYjQ5MjM4MS4uMjgwNGUwOGNlNTcgMTAwNjQ0Ci0tLSBhL3RhcmdldC9o
ZXhhZ29uL3RyYW5zbGF0ZS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCkBAIC0y
ODIsNiArMjgyLDggQEAgZXh0ZXJuIFRDR3YgaGV4X3ZzdG9yZV9hZGRyW1ZTVE9SRVNfTUFYXTsK
IGV4dGVybiBUQ0d2IGhleF92c3RvcmVfc2l6ZVtWU1RPUkVTX01BWF07CiBleHRlcm4gVENHdiBo
ZXhfdnN0b3JlX3BlbmRpbmdbVlNUT1JFU19NQVhdOwogCit2b2lkIGhleF9nZW5fZXhjZXB0aW9u
X2VuZF90YihEaXNhc0NvbnRleHQgKmN0eCwgaW50IGV4Y3ApOworCiB2b2lkIHByb2Nlc3Nfc3Rv
cmUoRGlzYXNDb250ZXh0ICpjdHgsIGludCBzbG90X251bSk7CiAKIEZJRUxEKFBST0JFX1BLVF9T
Q0FMQVJfU1RPUkVfUzAsIE1NVV9JRFgsICAgICAgIDAsIDIpCmRpZmYgLS1naXQgYS90YXJnZXQv
aGV4YWdvbi90cmFuc2xhdGUuYyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IDhh
MjIzZjZlMTNlLi44NzdjYjM4YWU3NyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNs
YXRlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKQEAgLTE4OSw3ICsxODksNyBA
QCBzdGF0aWMgdm9pZCBnZW5fZW5kX3RiKERpc2FzQ29udGV4dCAqY3R4KQogICAgIGN0eC0+YmFz
ZS5pc19qbXAgPSBESVNBU19OT1JFVFVSTjsKIH0KIAotc3RhdGljIHZvaWQgZ2VuX2V4Y2VwdGlv
bl9lbmRfdGIoRGlzYXNDb250ZXh0ICpjdHgsIGludCBleGNwKQordm9pZCBoZXhfZ2VuX2V4Y2Vw
dGlvbl9lbmRfdGIoRGlzYXNDb250ZXh0ICpjdHgsIGludCBleGNwKQogewogICAgIGdlbl9leGVj
X2NvdW50ZXJzKGN0eCk7CiAgICAgdGNnX2dlbl9tb3ZpX3RsKGhleF9ncHJbSEVYX1JFR19QQ10s
IGN0eC0+bmV4dF9QQyk7CkBAIC0yMDcsNyArMjA3LDcgQEAgc3RhdGljIHZvaWQgZ2VuX2V4Y2Vw
dGlvbl9kZWNvZGVfZmFpbChEaXNhc0NvbnRleHQgKmN0eCwgaW50IG53b3JkcywgaW50IGV4Y3Ap
CiAKICAgICBnZW5fZXhlY19jb3VudGVycyhjdHgpOwogICAgIHRjZ19nZW5fbW92aV90bChoZXhf
Z3ByW0hFWF9SRUdfUENdLCBmYWlsX3BjKTsKLSAgICBnZW5fZXhjZXB0aW9uX3JhdyhleGNwKTsK
KyAgICBnZW5fZXhjZXB0aW9uKGV4Y3AsIGZhaWxfcGMpOwogICAgIGN0eC0+YmFzZS5pc19qbXAg
PSBESVNBU19OT1JFVFVSTjsKICAgICBjdHgtPmJhc2UucGNfbmV4dCA9IGZhaWxfcGM7CiB9CkBA
IC01OTAsNyArNTkwLDcgQEAgc3RhdGljIHZvaWQgZ2VuX2luc24oRGlzYXNDb250ZXh0ICpjdHgp
CiAgICAgICAgIGN0eC0+aW5zbi0+Z2VuZXJhdGUoY3R4KTsKICAgICAgICAgbWFya19zdG9yZV93
aWR0aChjdHgpOwogICAgIH0gZWxzZSB7Ci0gICAgICAgIGdlbl9leGNlcHRpb25fZW5kX3RiKGN0
eCwgSEVYX0NBVVNFX0lOVkFMSURfT1BDT0RFKTsKKyAgICAgICAgaGV4X2dlbl9leGNlcHRpb25f
ZW5kX3RiKGN0eCwgSEVYX0NBVVNFX0lOVkFMSURfT1BDT0RFKTsKICAgICB9CiB9CiAKLS0gCjIu
MzQuMQoK

