Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BDD606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 04:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HBzuCwlv;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M0g6jmLw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQGuc-0003lt-Hl; Sun, 08 Nov 2026 23:23:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQGua-0003l6-W1
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 23:23:17 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQGuZ-0008Rt-0p
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 23:23:16 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A93KIsR3889646
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 04:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Yf8nU9Io4DAMC/EjcnM7TnrjnmMPiXeI1NTAStZQm0s=; b=HBzuCwlv+ZAbdLvK
 +TRo0pQRZlhDL9wfwKq5lw/A1wg5vVWrTfFLQuGz6lNo4nHrlwTHZmyuYotgkV+c
 W4jGm7cf1DNUe2AmSYjPQVNs7fXyqkWquygjHOT6lK8ihJJkfcoDFXwL2deU2TFo
 9eeu31NKIHqpNoF5G03zawZuolPoatrzsbjgMspvBYBY3N2+SN2uUNcW7xyAD4rF
 AGKcSNOHImRc3bc1/pCyPaaMB+zZYpLPEA0AhJXdDG0CPXSh22BcGUIfeFN+3HVg
 oWiobzxcK0+BvPtCyuLpjTXqzeupMi2MjOrTQaCXfXLVUQPbTTCtkwH9gOrnA/qI
 bKEvkg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4htuqm1g2y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 04:23:13 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36a3451ea93so863653eec.1
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 20:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794198193; x=1794802993; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Yf8nU9Io4DAMC/EjcnM7TnrjnmMPiXeI1NTAStZQm0s=;
 b=M0g6jmLwdCJnMvtdf/r9+I8yJFQjSE9uHibKuPnaLASITU/q5mSSjrBYn8PNlUi46/
 APLtyycjTv9/fVQ7/hFvZoFeZSGdfY9qCdwSlg216Az060Sa6BChUue9uYxrUIqakz82
 32Pt/SDv44IOZqhNoHOlE3t7/YI0XuNrWM81yK6JgZB5XWnlcEY6KWi61pP/4i/fTTe0
 cfv1rymfmu5NhVWPDU88TWxgpw9bkDySZO7xzGsS5zx4JqATogeqHUGcK0HqwJCDsmfC
 //XI2Es0xsJjCERQNCgLMFu9QmhLbgr6LZ79446qm2C5A2S2jcBCyLP8YdzjQ0/SwxrD
 C9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794198193; x=1794802993;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Yf8nU9Io4DAMC/EjcnM7TnrjnmMPiXeI1NTAStZQm0s=;
 b=ci8AKUtqsOf55BH4XLGhI8QKHLgcy1Qa+hfaQbeIzAtaOMT0KCClnumudL6/g0zJoL
 uTmObZ+5PJ7yQ4Sf0Z2wfQjWNPR/FhM/vM0RUty26es0exg1A2UXbN1ndYVthatTaohE
 UTOMg/v6U93ediqo38USk8lH5iEUNQBffwvwJ/jJ1qVF8AjgvDBQZn0IbfKTZVoGZGOv
 hTwHwmmwQxqVb42szhGSIsgqVxbC2VBv8bfNOtWGSt+hvdnRg/JUAcgFxcxSK/nFiz6l
 Lpp5rCkjv+uOzZCt5ViDO7i5CEo4B7IPQMHJSp+eIcftFFggKdtqtHxkuGr8/fwakWCD
 R69Q==
X-Gm-Message-State: APuU4Z93LbMQ/hWiN2dZG3kMaeeBVmcScBf8UnrO4zc5yrQQRqmEEcxj
 66d6RP4Q2cvpq/uskylbA2Z3FdWYVmd5qJ04lQrlXzx/fG3HJiWgv+bHzOcrQLRfG/Z7IhJycCD
 812jjOR4NCcq5pRuEvM09RSrDyDJmuF6fLuaiUs1KVUdJhuuqjidJEbRJ5U0JQrjTOQ==
X-Gm-Gg: AYBFou0e7u2VJmdWWzzPMOJgKQ/PuESYLUWOXlw+mOW3wAGi84kyjsSGZak0s+9OVRa
 jD8DQMSQ4+OsvxvwWK88L5HaJuGDs1nEgfhVJgE80eGHrN0Ky78SV/IQNdYa8VAMhAIkgOPIZ6E
 x3dkOuJR4Xp7/KydkrlYoIKkQqQ4BukC72/jhlidBiXkwA0oWZDnIvdZ9mfgtp9+g+w9gZ6ngfc
 4KJmw8h6Lv6Yutwh9VqMDY4kCy6OpR4O9ZwIrxFhG1MsfS9Pw9H82V4y039XbOjLat9sKZme9L1
 bEmWRKY0+Lzph6wFG5p2r2Q4gefRyuFy3k+u6gtdyBBY6ZfQCz8Q7A1tv5m65D33Tu6XbdugnNP
 BqowlhoU85c047/vOCFMnFLUSPLe9ZlPZ8HkWnkLR4gWwiTj13RnWenB96K4DfKsrBKf9ZbVrS9
 M4ol+yb3hrWhwcLzdYAn/68w==
X-Received: by 2002:a05:693c:880c:20b0:35f:2858:aa4b with SMTP id
 5a478bee46e88-3725855eeabmr5365286eec.30.1794198192511; 
 Sun, 08 Nov 2026 20:23:12 -0800 (PST)
X-Received: by 2002:a05:693c:880c:20b0:35f:2858:aa4b with SMTP id
 5a478bee46e88-3725855eeabmr5365251eec.30.1794198191927; 
 Sun, 08 Nov 2026 20:23:11 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-372669d2826sm10156773eec.29.2026.11.08.20.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 20:23:11 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 3/5] docs/system/hexagon: document boot interfaces
Date: Sun,  8 Nov 2026 20:23:04 -0800
Message-Id: <20261109042307.1301438-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109042307.1301438-1-brian.cain@oss.qualcomm.com>
References: <20261109042307.1301438-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAxNyBTYWx0ZWRfX1/njEOp05tW9
 O/DLXcSgmd0AxbVCl79ZXEzHYV+a49BtP6k9D0dsNz+S0HmQZlKOjicTZPeLrXCuFaXBYfGSCu/
 F+QP+5EkmqPgdxWQzmKzh3bm6U4SsbI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAxNyBTYWx0ZWRfX6wd4hmTKVnCX
 QZy2rPLMynkIb07NrM4g4IZZbV9/RFFEwoujgmRmyFtqgTzjB3grkKNe1fAQhvOTnrIBNGE+J4Y
 kd5Doc+7RhqsRZUCXmav1AFmxsbXUlLGw2cXEjbRfsTfeDqmZ2KriDGvfW8r+2C9DenoqluW9EN
 8SKMtXfmtEibDjpv3G6WgF16JJ0nrGhqmF+YEKil1H1rP1vxRLEHbQ0VZ+rzT+tps/WbH3tfvjA
 k0VnhFrKjTwXo/w+yJw+iNxT5UH772fykMOoYn2ZpfDALlAZnbjoQPuVKMhFg5Mp6StfFALYNS6
 TAxwsGAMOYiqymFe+jqlAo+BcvZvanLmCiGi1a4ICxgv8ri+gtY+t+zV4mPO+bxk7SQ2d6i0a6e
 zLRwBvitcJApdaFgxhhngbrPppCCYKOJlhdJ58cB0Th4ToiAvwD9aaNJOxl3ar7rrGZVhErh7hS
 qp4PKpED7qyMoG4e+Ig==
X-Authority-Analysis: v=2.4 cv=JLquIMKb c=1 sm=1 tr=0 ts=6af14ab1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=P_3Ky2eAZP25M8n5cw8A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: Oy6Ts3fmvD6CUBfEOIFNBF0LUo6l785Z
X-Proofpoint-ORIG-GUID: Oy6Ts3fmvD6CUBfEOIFNBF0LUo6l785Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090017
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RGVzY3JpYmUgRUxGIGFuZCByYXctaW1hZ2UgbG9hZGluZywgcmVzZXQgc3RhdGUsIHRoZSBEVEIg
aGFuZG9mZiB0byBWTQpob3N0IGZpcm13YXJlLCBhbmQgaW5pdGlhbCB0aHJlYWQgc3RhdGUuIEV4
cGxhaW4gVUFSVCBhbmQgc2VtaWhvc3RpbmcKY29uc29sZSByb3V0aW5nLgoKU2lnbmVkLW9mZi1i
eTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGRvY3Mvc3lz
dGVtL2hleGFnb24vYm9vdC5yc3QgICB8IDEwMCArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysKIGRvY3Mvc3lzdGVtL3RhcmdldC1oZXhhZ29uLnJzdCB8ICAgMSArCiAyIGZpbGVzIGNo
YW5nZWQsIDEwMSBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2NDQgZG9jcy9zeXN0ZW0v
aGV4YWdvbi9ib290LnJzdAoKZGlmZiAtLWdpdCBhL2RvY3Mvc3lzdGVtL2hleGFnb24vYm9vdC5y
c3QgYi9kb2NzL3N5c3RlbS9oZXhhZ29uL2Jvb3QucnN0Cm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cmlu
ZGV4IDAwMDAwMDAwMDAwLi4zNmM2MDNjNjllMAotLS0gL2Rldi9udWxsCisrKyBiL2RvY3Mvc3lz
dGVtL2hleGFnb24vYm9vdC5yc3QKQEAgLTAsMCArMSwxMDAgQEAKKy4uIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCisKK0hleGFnb24gYm9vdCBpbnRlcmZhY2UKKz09
PT09PT09PT09PT09PT09PT09PT0KKworYGBxZW11LXN5c3RlbS1oZXhhZ29uYGAgbG9hZHMgdGhl
IGluaXRpYWwgaW1hZ2UuIEd1ZXN0IHN0YXJ0dXAgY29kZQoraW5pdGlhbGl6ZXMgdGhlIHN0YWNr
LCBleGNlcHRpb24gaGFuZGxpbmcsIGFuZCBydW50aW1lIHN0YXRlLiBXaGVuIGEKK0hleGFnb24g
Vk0gaG9zdCBpcyBsb2FkZWQsIGl0IGVzdGFibGlzaGVzIHRoZSBndWVzdCBPUydzIGJvb3QgZW52
aXJvbm1lbnQuCisKK0luaXRpYWwgaGFyZHdhcmUgc3RhdGUKKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KKworT25seSBoYXJkd2FyZSB0aHJlYWQgemVybyBzdGFydHMgZXhlY3V0aW5nLiBPdGhlciB0
aHJlYWRzIHN0YXJ0IHBvd2VyZWQKK29mZi4KKworRXhlY3V0aW9uIHVzZXMgdW50cmFuc2xhdGVk
IHBoeXNpY2FsIGFkZHJlc3NlcyBpbiBtb25pdG9yIG1vZGUuIEd1ZXN0IHNvZnR3YXJlCittdXN0
IHBvcHVsYXRlIFRMQiBlbnRyaWVzIGJlZm9yZSBlbmFibGluZyB0aGUgTU1VLCBhbmQgc2V0IHVw
IGV4Y2VwdGlvbiB2ZWN0b3JzCithbmQgaW50ZXJydXB0IG1hc2tzIGJlZm9yZSBlbmFibGluZyBp
bnRlcnJ1cHRzLiBTZWUKKzpkb2M6YC4uLy4uL2RldmVsL2hleGFnb24tc3lzYCBmb3IgdGhlIHN5
c3RlbSBhcmNoaXRlY3R1cmUuCisKK1FFTVUgc2V0cyB0aHJlYWQgemVybydzIFBDIHRvIHRoZSBz
ZWxlY3RlZCBpbWFnZSBlbnRyeSBhZGRyZXNzLiBgYEVWQmBgCitpbml0aWFsbHkgY29udGFpbnMg
emVybzsgRUxGIHN0YXJ0dXAgY29kZSBpbnN0YWxscyBpdHMgb3duIGFsaWduZWQgZXZlbnQKK3Zl
Y3RvciBiYXNlLgorCitTaW11bGF0b3ItY29tcGF0aWJsZSBtYWNoaW5lcworLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KKworYGAta2VybmVsIGZpbGVgYCBsb2FkcyBhIGxpdHRsZS1lbmRp
YW4gSGV4YWdvbiBFTEYsIHBsYWNlcyBpdHMgbG9hZGFibGUKK3NlZ21lbnRzIGFjY29yZGluZyB0
byB0aGVpciBwaHlzaWNhbCBhZGRyZXNzZXMsIHplcm8tZmlsbHMgdGhlIHNlZ21lbnRzJworcmVt
YWluaW5nIG1lbW9yeSwgYW5kIHN0YXJ0cyB0aHJlYWQgemVybyBhdCB0aGUgRUxGIGVudHJ5IHBv
aW50LiBMaW5rCitzdGFydHVwIGNvZGUgZm9yIHVudHJhbnNsYXRlZCBleGVjdXRpb24sIHdpdGgg
dGhlIGVudHJ5IHBvaW50IGFjY2Vzc2libGUKK2F0IGl0cyBsaW5rZWQgYWRkcmVzcy4KKworVGhl
IHZpcnQgbWFjaGluZQorLS0tLS0tLS0tLS0tLS0tLQorCitgYC1rZXJuZWwgZmlsZWBgIGFsb25l
IGxvYWRzIGEgSGV4YWdvbiBFTEYgaW50byBERFIsIHdoaWNoIHN0YXJ0cyBhdAorYGAweDgwMDAw
MDAwYGAsIGFuZCBzdGFydHMgYXQgaXRzIEVMRiBlbnRyeSBwb2ludC4KKworYGAtYmlvcyBmaWxl
YGAgYWxvbmUgbG9hZHMgYSByYXcgZmlybXdhcmUgaW1hZ2UgYXQgdGhlIHN0YXJ0IG9mIEREUiBh
bmQKK3N0YXJ0cyBleGVjdXRpbmcgdGhlcmUuCisKK2BgLWJpb3NgYCB3aXRoIGBgLWtlcm5lbGBg
IGJvb3RzIHRoZSBrZXJuZWwgdGhyb3VnaCBIZXhhZ29uIFZNIGhvc3QKK2Zpcm13YXJlLCBhcyBk
ZXNjcmliZWQgaW4gOnJlZjpgaGV4YWdvbi12bS1ib290YC4gVGhlIGtlcm5lbCB3aW5kb3cgc3Rh
cnRzCithdCBgYDB4YTAwMDAwMDBgYC4KKworT3RoZXJ3aXNlLCBndWVzdCBzb2Z0d2FyZSByZWFk
cyB0aGUgZ2VuZXJhdGVkIERUQiBhdCBgYDB4OTk4MDAwMDBgYC4KK2BgLWFwcGVuZGBgIHNldHMg
aXRzIGBgL2Nob3Nlbi9ib290YXJnc2BgIHByb3BlcnR5LgorCitCb2FyZC1zcGVjaWZpYyBtYWNo
aW5lcworLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCisKK0JvdGggYGAta2Vy
bmVsYGAgYW5kIGBgLWJpb3NgYCBhY2NlcHQgSGV4YWdvbiBFTEYgaW1hZ2VzLiBUaGUgY29tYmlu
YXRpb25zCitoYXZlIGRpZmZlcmVudCBtZWFuaW5nczoKKworLi4gbGlzdC10YWJsZTo6CisgICA6
aGVhZGVyLXJvd3M6IDEKKworICAgKiAtIE9wdGlvbnMKKyAgICAgLSBMb2FkaW5nIGFuZCBlbnRy
eQorICAgKiAtIGBgLWtlcm5lbGBgIGFsb25lCisgICAgIC0gTG9hZCBzZWdtZW50cyBhdCBFTEYg
cGh5c2ljYWwgYWRkcmVzc2VzIGFuZCBzdGFydCBhdCB0aGUgRUxGIGVudHJ5LgorICAgKiAtIGBg
LWJpb3NgYCBhbG9uZQorICAgICAtIExvYWQgZmlybXdhcmUgc2VnbWVudHMgYXQgRUxGIHBoeXNp
Y2FsIGFkZHJlc3NlcyBhbmQgc3RhcnQgYXQgaXRzIGVudHJ5LgorICAgKiAtIGBgLWJpb3NgYCBh
bmQgYGAta2VybmVsYGAKKyAgICAgLSBMb2FkIGZpcm13YXJlIG5vcm1hbGx5LCByZWxvY2F0ZSB0
aGUga2VybmVsIHNlZ21lbnRzIGludG8gdGhlIGJvYXJkJ3MKKyAgICAgICBrZXJuZWwgd2luZG93
LCBhbmQgZW50ZXIgZmlybXdhcmUgdGhyb3VnaCBhIFFFTVUgYm9vdCBzdHViLgorCitUaGUgY29t
YmluZWQgY2FzZSBpcyBkZXNjcmliZWQgaW4gOnJlZjpgaGV4YWdvbi12bS1ib290YCwgdXNpbmcg
dGhlIGtlcm5lbAorYmFzZSBpbiA6ZG9jOmBjZHNwYC4KKworYGAtZHRiIGZpbGVgYCByZXBsYWNl
cyB0aGUgZ2VuZXJhdGVkIHRyZWUuIEEgbm9uZW1wdHkgYGAtYXBwZW5kYGAgdmFsdWUKK3NldHMg
aXRzIGBgL2Nob3Nlbi9ib290YXJnc2BgLiBBIHJlcGxhY2VtZW50IHRyZWUgbXVzdCBkZXNjcmli
ZSB0aGUKK3NlbGVjdGVkIGhhcmR3YXJlLXRocmVhZCBjb3VudCwgYWN0dWFsIFJBTSwgYW5kIG1h
dGNoaW5nIGRldmljZSBkcml2ZXJzLgorCisuLiBfaGV4YWdvbi12bS1ib290OgorCitCb290aW5n
IGEga2VybmVsIHRocm91Z2ggSGV4YWdvbiBWTSBob3N0IGZpcm13YXJlCistLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCisKK09uIHRoZSBgYHZpcnRgYCBh
bmQgYm9hcmQtc3BlY2lmaWMgbWFjaGluZXMsIGBgLWJpb3NgYCB3aXRoIGBgLWtlcm5lbGBgCitz
dGFydHMgdGhlIGtlcm5lbCB0aHJvdWdoIEhleGFnb24gVk0gaG9zdCBmaXJtd2FyZS4gUUVNVSBs
b2FkcyB0aGUgZmlybXdhcmUKK0VMRiBhcyBsaW5rZWQgYW5kIGFkZHMgdGhlIG1hY2hpbmUncyBr
ZXJuZWwgYmFzZSB0byB0aGUga2VybmVsIEVMRidzCitwaHlzaWNhbCBsb2FkIGFkZHJlc3Nlcywg
c28gdGhlIGtlcm5lbCdzIGFkZHJlc3NlcyBhcmUgcmVsYXRpdmUgdG8gdGhlCitzdGFydCBvZiBp
dHMgd2luZG93LiBUaGUga2VybmVsIG11c3QgdXNlIHRoZSBjb3JyZXNwb25kaW5nIEhleGFnb24g
Vk0KK2d1ZXN0IGxheW91dC4gUUVNVSBzdGFydHMgdGhyZWFkIHplcm8gYXQgYSBib290IHN0dWIg
YXQgYGAweDk5YzAwMDAwYGAuCitUaGUgc3R1YiBwYXNzZXMgdGhlIERUQiBhZGRyZXNzIHdpdGgg
dGhlIGxvdyB3b3JkIGluIGBgcjBgYCBhbmQgdGhlIGhpZ2gKK3dvcmQgaW4gYGByMWBgLCB0aGVu
IGp1bXBzIHRvIHRoZSBmaXJtd2FyZSdzIEVMRiBlbnRyeSBwb2ludC4gVGhlIEhleGFnb24KK1ZN
IGhvc3QgZGVmaW5lcyB0aGUgY2hpbGQgVk0ncyByZWdpc3RlciBhbmQgZXhlY3V0aW9uIHN0YXRl
LgorCitRRU1VIHBsYWNlcyB0aGUgRFRCIGFmdGVyIHRoZSBsb2FkZWQga2VybmVsLiAgUUVNVSBj
b3BpZXMgaXQgdG8gZ3Vlc3QgUkFNCitiZWZvcmUgZW50ZXJpbmcgdGhlIGZpcm13YXJlLiBBbiBv
cHRpb25hbCBgYC1pbml0cmRgYCBpcyBwbGFjZWQKK2FmdGVyIHRoZSBEVEIgYmFzZS4gIGBgLWlu
aXRyZGBgIHJlcXVpcmVzIGJvdGggYGAtYmlvc2BgIGFuZCBgYC1rZXJuZWxgYC4KKworQ29uc29s
ZSBhbmQgc2VtaWhvc3RpbmcKKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCisKK1NESyBzaW11bGF0
b3IgcHJvZ3JhbXMgdXNlIHNlbWlob3N0aW5nIGZvciBjb25zb2xlIEkvTy4gVGhlIGBgdmlydGBg
IGFuZAorYm9hcmQtc3BlY2lmaWMgbWFjaGluZXMgYWxzbyBwcm92aWRlIGEgUEwwMTEgVUFSVCwg
d2hvc2UgaG9zdCBiYWNrZW5kIGlzCitzZWxlY3RlZCB3aXRoIGBgLXNlcmlhbGBgLgpkaWZmIC0t
Z2l0IGEvZG9jcy9zeXN0ZW0vdGFyZ2V0LWhleGFnb24ucnN0IGIvZG9jcy9zeXN0ZW0vdGFyZ2V0
LWhleGFnb24ucnN0CmluZGV4IDdiN2QwYmMzMWJjLi5lMDkxYjc1YzdhMyAxMDA2NDQKLS0tIGEv
ZG9jcy9zeXN0ZW0vdGFyZ2V0LWhleGFnb24ucnN0CisrKyBiL2RvY3Mvc3lzdGVtL3RhcmdldC1o
ZXhhZ29uLnJzdApAQCAtMTA3LDUgKzEwNyw2IEBAIG1hY2hpbmVzLiBUaGlzIGNhbiBiZSBmdXJ0
aGVyIGNvbmZpZ3VyZWQgdGhyb3VnaCBgYC1zZW1paG9zdGluZy1jb25maWdgYC4KICAgIDpjYXB0
aW9uOiBIZXhhZ29uIGRvY3VtZW50YXRpb24KIAogICAgaGV4YWdvbi9tYWNoaW5lcworICAgaGV4
YWdvbi9ib290CiAgICBoZXhhZ29uL2VtdWxhdGlvbgogICAgaGV4YWdvbi9jZHNwCi0tIAoyLjM0
LjEKCg==

