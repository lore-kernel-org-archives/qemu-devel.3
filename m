Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408AEFD88F5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AsZ-0000yg-6t; Wed, 11 Mar 2026 00:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AsX-0000xS-E0
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:09:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AsT-00007C-DE
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:09:00 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B3ORPq3760444
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NRHeJLIWf6DpxvbvT8+bpoJCgjTEVUxUXaTL4xGT8ms=; b=mEmTADvR9kzpWg0+
 SQ7gqPzTnDY5sxHXRbKjjhcWMA5CHcywqCasAfIK5TH4a6bWR4olCCvPFiP/Q5ic
 OXgfKRtrCrTFWmn0+D2itS1TEiGOJ5h2p2KAM6uIgevbuuKDpOF4fcrDnLQJhQbF
 LvYtUVz/jJIlLj4rjndHUyT301di8YHEc6+vyFNSAE6tDyeVAq41T4M6fB/XAgvo
 4nNUhHAiGegROCaTj902p/6Vbnacy9aeEJYFY0f8puKJrh60P1N1J3LOsWNLBckT
 3xw0+sYla9ucmFKv0ZE2HKjTQkkOoRGim2CuzZQ2lqrCybmlQoWKvy12mrCpVhpL
 0UFIwA==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctk8uk4jd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:46 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4670ec8971cso20349512b6e.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202120; x=1773806920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NRHeJLIWf6DpxvbvT8+bpoJCgjTEVUxUXaTL4xGT8ms=;
 b=MUBgQUZOjFhyiPbDzS9SZZ7Eoyb8u6ojmhprKKxzIWr9K4ijGv3GoCJSGAkrRm8Hb+
 fS45v7Y3C9dqHCy1W+wFDgS8mIKj1T4ncmm7ruc15vzqnr/Uh3AhOuBD53kZMS+6oDoZ
 G9j1fweLT20IT5X26743dL4h7UfIIsdjztAhuT/yiwv4dWWsVNnoqqjOSmuduXGkSZeD
 /6NUlM3Uc3lXg8JTPAg/SqgBX/7Ncd0KcO8h/00CgR2fCCi2PvvGTHPFCiEnVQWj/9IH
 RkZNkd+fCiNTZTjR5yrCk9FdfDyxz2E235KBcsWsVjaDcE1hIZx6CVQKUUEV6k3Z/aTL
 8LAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202120; x=1773806920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NRHeJLIWf6DpxvbvT8+bpoJCgjTEVUxUXaTL4xGT8ms=;
 b=V4nQONFYONjpEmfvzkJ9U/VS42AoLGNTsMteUCbbidvO0qG1dUKn2uuerj2g0cLPfs
 ggQ7fzxWqJQXHlJeCn94a8yip5JeQd1ChEEH3VPTLPrGcpPDzelSaRTid2fsAQVZyozT
 mr3DYJ2Bz9FOeN96h68lFFZnuD7pk+FwlrFaP8wJyNrkyWGSvY9esxBbB5jDCyhjTUJD
 KCo3VGI0BN7Nos4tPxLRbGoWx/J+Ani3SL6Tti9m8mIjcGiSs14bcPT+5rC0Zr5scCTJ
 GtqL5LipbZG+XoU7DqqV/Txwdj/qv7b5LRXtk3S1TUN8BXKJ7sPGMkdxIAB2nDI7vEQM
 BWhQ==
X-Gm-Message-State: AOJu0YyGxeEe6nW0qALuh5jMA+pmvrMI796OvlUTsLnIMLe+yMNz7Dbx
 D7aE+5essFLCeqiGGWK97Vzvsrkn10y5tfRHivoBZ7T1guKUb4d6ekI1qxWAaCgVFMKjLyQw7RI
 41pVoKg0IFH6KTkD2dlyIoAS/sUnUMU2ZWXRL9/N9wjP2OYCJKXSo+KfZF2TOtwTY1Q==
X-Gm-Gg: ATEYQzy4m7mg04xse7WlP2vB8kRIiqKTfXnGLP134USkQlcspfiqgi0/9INxO+Z5oSd
 BfX7ZaW5YDtTdouySTOmL+fJjT6/ETQoD/mXFBxQSTTCOiQpkCDmJTTRbcrtWvUo+S2Ivz9i0ow
 2/V6cuqOfCKNJjm33RgQger7px+x3Wk3/aIH4OmCrKjG7XLVEP3ocLXtk6iJGD/ShuJeXKxPhze
 PjlninhwMMMD2tdjBxwrOShhbFYQ7WwFyDZbv4ljCfxwbVI92k3OIb4NORvBrD7CPjwudn1VRlY
 A00TlQn6ODts04/PPlD0T4qZJbsorLPR413YAVyliEPTazWFzgnTO/3Aqq17JSI9JFc6sefnGem
 pHT3cIT0y5xZzvfxqtY1KfC+78KLh+iZVrSwK4/lpMRamweSaSCjLxI8BkrhIbmLfDHy9kQ==
X-Received: by 2002:a05:6808:15a2:b0:467:226e:302e with SMTP id
 5614622812f47-46733439ffamr663310b6e.21.1773202120570; 
 Tue, 10 Mar 2026 21:08:40 -0700 (PDT)
X-Received: by 2002:a05:6808:15a2:b0:467:226e:302e with SMTP id
 5614622812f47-46733439ffamr663291b6e.21.1773202120183; 
 Tue, 10 Mar 2026 21:08:40 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5ea30asm998656fac.10.2026.03.10.21.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:08:39 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 25/32] target/hexagon: Add implicit sysreg writes
Date: Tue, 10 Mar 2026 21:07:51 -0700
Message-Id: <20260311040758.1068731-26-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: _dwKehHDeqlAZOpjfyIALPOqE6iIoGkW
X-Proofpoint-GUID: _dwKehHDeqlAZOpjfyIALPOqE6iIoGkW
X-Authority-Analysis: v=2.4 cv=YcmwJgRf c=1 sm=1 tr=0 ts=69b0eace cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ySlkKLH3HnL0fBWr2zQA:9
 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMiBTYWx0ZWRfX9OJfrBhggZTZ
 LlbHNccTfpdEKd5piTiRbbTYBI/LgSbhPq/4zbOZhfIaMTt1S8HyIrBXbqy/JmaJSkh7GCEGVmI
 XLjFEkip3sm1BJEPOX7BmFxzz7sD2su35LQXZI7i4UNO9tLBHvldkaV1JC3M4I6NCdCBxNxkrI/
 SVOlh665lCks917pXUMezMWnbKXy3fKJDu17YpMoAsloT/LxgGf928vLnZw5hHCHpNPqIOhmyMR
 ZN5FMghyXF6562CS0duPEBZIu2DneI6l/y4IMkKxP/BeHmVjDC6x8wVgTkiz9MechnoLgWufAXX
 JsEULpQg0tpybcyHG2UDwCLt26MOCYHgUFsNT7l2ClTq/nmY4J5QNkkWhOleuX9TNwDuyBAHNYO
 2ua5W0DaugiLB/OTChq7kdUQHm/bZZVVyYtMAYhts5nQV68hDKXbiBnmRUoeQmN4rn/S81eS0H5
 5jhYll6mOEG8ijCXIeA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110032
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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
YW5zbGF0ZS5jIHwgMTYgKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDE2IGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3Rhcmdl
dC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IDc5MDI3ZThhMzI3Li5kZGYzMjhlMGE2MiAxMDA2
NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmMKQEAgLTQyOCw2ICs0MjgsMTYgQEAgc3RhdGljIHZvaWQgbWFya19pbXBsaWNp
dF91c3Jfd3JpdGUoRGlzYXNDb250ZXh0ICpjdHgsIGludCBhdHRyaWIpCiAgICAgfQogfQogCisj
aWZuZGVmIENPTkZJR19VU0VSX09OTFkKK3N0YXRpYyB2b2lkIG1hcmtfaW1wbGljaXRfc3JlZ193
cml0ZShEaXNhc0NvbnRleHQgKmN0eCwgaW50IGF0dHJpYiwgaW50IHNudW0pCit7CisgICAgdWlu
dDE2X3Qgb3Bjb2RlID0gY3R4LT5pbnNuLT5vcGNvZGU7CisgICAgaWYgKEdFVF9BVFRSSUIob3Bj
b2RlLCBhdHRyaWIpKSB7CisgICAgICAgIGN0eF9sb2dfc3JlZ193cml0ZShjdHgsIHNudW0pOwor
ICAgIH0KK30KKyNlbmRpZgorCiBzdGF0aWMgdm9pZCBtYXJrX2ltcGxpY2l0X3JlZ193cml0ZXMo
RGlzYXNDb250ZXh0ICpjdHgpCiB7CiAgICAgbWFya19pbXBsaWNpdF9yZWdfd3JpdGUoY3R4LCBB
X0lNUExJQ0lUX1dSSVRFU19GUCwgIEhFWF9SRUdfRlApOwpAQCAtNDQwLDYgKzQ1MCwxMiBAQCBz
dGF0aWMgdm9pZCBtYXJrX2ltcGxpY2l0X3JlZ193cml0ZXMoRGlzYXNDb250ZXh0ICpjdHgpCiAK
ICAgICBtYXJrX2ltcGxpY2l0X3Vzcl93cml0ZShjdHgsIEFfSU1QTElDSVRfV1JJVEVTX1VTUik7
CiAgICAgbWFya19pbXBsaWNpdF91c3Jfd3JpdGUoY3R4LCBBX0ZQT1ApOworCisjaWZuZGVmIENP
TkZJR19VU0VSX09OTFkKKyAgICBtYXJrX2ltcGxpY2l0X3NyZWdfd3JpdGUoY3R4LCBBX0lNUExJ
Q0lUX1dSSVRFU19TR1AwLCBIRVhfU1JFR19TR1AwKTsKKyAgICBtYXJrX2ltcGxpY2l0X3NyZWdf
d3JpdGUoY3R4LCBBX0lNUExJQ0lUX1dSSVRFU19TR1AxLCBIRVhfU1JFR19TR1AxKTsKKyAgICBt
YXJrX2ltcGxpY2l0X3NyZWdfd3JpdGUoY3R4LCBBX0lNUExJQ0lUX1dSSVRFU19TU1IsIEhFWF9T
UkVHX1NTUik7CisjZW5kaWYKIH0KIAogc3RhdGljIHZvaWQgbWFya19pbXBsaWNpdF9wcmVkX3dy
aXRlKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgYXR0cmliLCBpbnQgcG51bSkKLS0gCjIuMzQuMQoK

