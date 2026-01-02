Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B181BFA3755
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 20:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vblVt-0003zO-Bv; Fri, 02 Jan 2026 15:12:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vblVg-0003sc-3b
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 15:12:32 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vblVY-0002TA-EE
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 15:12:27 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6029W2sl3961084
 for <qemu-devel@nongnu.org>; Fri, 2 Jan 2026 20:12:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mSXXj28aI93YT6eSHdym3ln05TVR8chTRJIg1bakFME=; b=LIM7oxgfzPq4YjRV
 1/J/kd/wQQRdZPTQ+wa8e24SB7/4lvgB4St/kj63edIOMccFLz/eXCmw864V/YZK
 Bn5g0g9X0g9WpDfp9LIIBZyAC73BFFvGvlC3haRHirYzcFUXAAJYm2f0S3u5phrZ
 5JZ2zqSFJPy1Xvec5UR2BfcznzbRvx/r7QASeQ4yrrfafaJibneGhmQkEh2nj+cn
 SjQ3QzH2zYlcdX7Ysgl0+fgzWMKrfhvf+qn6BsaLmnAkhs8Nmiu+U/8E5fDRny08
 okt3ZMFxlTYLCRWJS33BE4L/cYyLMSNq7oFfhOHgWmh95BSQO1b0cfU9ChoPmhd3
 pSfV5g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bd77v49j3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 20:12:23 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b5edecdf94eso20679060a12.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 12:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767384742; x=1767989542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mSXXj28aI93YT6eSHdym3ln05TVR8chTRJIg1bakFME=;
 b=htVXF7juwLxl+7nyn+kLjbhJqmE9+zGyDRcKS6lpH6NRnMCWibZavI2uiAGceoLfAA
 +bpvBTTCRKkZ00O/m5AGLo8VkDAWrcF+Y5/vJ4ouC035u2tQQL9TJrWwuveW1K8e4OWh
 8wP97SZ99GujDTIu58uBRjGgm5BTgZU31CF2iC9jBNkI6/uzo/6B//T79an+hn38Jacm
 Oge5AZK7plZf5Tty5qhjhS+9gMFFUAOsYQPOpVGQuYg5+Fu0VyOxnwiEYi+Iy7Kdg1Ai
 ILTU6D219ty0WHSU3HP3WOefCQ9eUY9/rGHB6wAhquec7ZAA58UCVDLoh6ssv7jcrA6P
 0bDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767384742; x=1767989542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mSXXj28aI93YT6eSHdym3ln05TVR8chTRJIg1bakFME=;
 b=CqLsIyma8Yw3/FkMnjxizMrXISJkafD0knJbEoxgGV2357IF5h/MpeixF9tvKZwxYj
 oJgia47iNtcOXYnosS2x0b6mHkvtKR7+Cnd1zXNX23qysVONUH1S5N/aNxfZmaZWQdWN
 7jVte5MgNX4Bh9zZ2pxoiNx2/LsvAzfnggnbvacbAVYfLUH17cWMnkmpOWL8tNVN87Kv
 k3mHYrKUClQtDr6vS8DBdwSbV2CTvwC+0C+zIb6/Ok/ON9MsttIff50RErKp4pIQVbDg
 mrHo/SDJhRiHo67sgbNXKaGIk/ps5TR+YBVN/Wx+MSKcmHw16s8rKy42gqROkgbSadtf
 HNGw==
X-Gm-Message-State: AOJu0YzNjbEHU4yF2P9bBd501Naxp9U0BR9bSsVi4NwAgtm7+aep6JFd
 4VlfEoIIxkYYkWokk8kn51tWALkQozcA3MMgFWNvhIQnO3AbI2iAR4rWWkAKibNO73YEIbvGgBa
 0htAseNpxh43zXHEsOhFhLzXFS79qR5P1dIgEm/7IGAsepnZbsYDHE023CKPHwx51+g==
X-Gm-Gg: AY/fxX5PYtDFvgzFYUfqkFmTXE6L1DI3yCwvEZtA+SRxt2epq+omN6kW4CaVJ2g/PYY
 SySK23RDr1OE0ibXNNl3HGsytZYNnElvig1J9pPkB/Z5GXMwV1nthis5pCx7c54R3HXOQ6z9xB0
 hHwodJoWylLAKJv4O09w90LNfUmnfbqMQ9vCTGh9VAAJgmK3itLQ3zg9caVVphk3Pap5us+iMQA
 IRnjw5T9S2VTz8vtuLj3VdoJ3wPanKrvHXf2TmGXd4Nn4dGOMVeFBiYagMTh/FLM7Jl6tItOqmE
 jmehn6fnbCjT6B/Z90pVkrTaaV82Zu0nn4zLM2Q36apfwMfawAeSHRxCbJAQtDqEdoDJva+k95p
 0crMW5f/OMhxyDPLuPBY6Tx38dpUiZEjb7G7rwvWg/IQoOL/ycZcom/rOmg==
X-Received: by 2002:a05:7300:d814:b0:2b0:48f7:837d with SMTP id
 5a478bee46e88-2b05ebbbd85mr23743883eec.11.1767384741918; 
 Fri, 02 Jan 2026 12:12:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3qfeFXW1sl+ASgE9POQONlpISYby4Hb3XXZlTAaQwFmx8TitoP8v4MafKZ4TW0lu76Ay4tQ==
X-Received: by 2002:a05:7300:d814:b0:2b0:48f7:837d with SMTP id
 5a478bee46e88-2b05ebbbd85mr23743869eec.11.1767384741367; 
 Fri, 02 Jan 2026 12:12:21 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b140c42e7esm1794621eec.22.2026.01.02.12.12.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 12:12:20 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com
Subject: [PULL 3/9] Hexagon (target/hexagon) Implicit writes to USR don't
 force packet commit
Date: Fri,  2 Jan 2026 12:11:59 -0800
Message-Id: <20260102201205.2050363-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260102201205.2050363-1-brian.cain@oss.qualcomm.com>
References: <20260102201205.2050363-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: AYD0L46imUFwQbEsVXZztkKTX8y7Jw0u
X-Proofpoint-ORIG-GUID: AYD0L46imUFwQbEsVXZztkKTX8y7Jw0u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDE4MSBTYWx0ZWRfX4UC/naV9ZDqg
 QgbfB0SU+UWY3KaC/kMTdKdeNb3RgGfnHE9UgFuD0ejsS8nrTtwq3iD60Qdum50f2ROFmAWZoYW
 LhnWQTVmTWCTcpa8sCzbOVWl11J9P8CiN1qZFwIFbxCd382/OwPjRV1P6NQdlrKezmvTq0giQG8
 LWNKWgY1PZr//m7Aq8cOXneu56MrCam61+sHrnp27SWhvF5yFhfqsA3HyUAvkipJM5G4wHNQgzA
 Lr4aal3MkcW2iOuZXvk6YMh+3peKRE4KQe9mUnpquGmKW2jzUL3Fyj6bm8BeGCD6HNaIVgEhwRe
 eIF6Xwy727K2ggMNimpy/G3I1qGFk6Jv+ZBWCbQIsE2zdZX0no9HoV/Rpg86DXlUPTkUbidYxOY
 QtHef2SsVKm8+3zowLkVUafPjmYA9ECaGkSCHl7qW/xwJFeixOKHRTqN5RlLpy3d3b1FGk8yfwB
 aKPxcL3g6YCFrLRGdBA==
X-Authority-Analysis: v=2.4 cv=ev7SD4pX c=1 sm=1 tr=0 ts=695826a7 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=MMWtOl-RLpcBRfZQO0EA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601020181
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KCkltcGxpY2l0
IHdyaXRlcyB0byBVU1IgYXJlIG9ubHkgdG8gc3BlY2lmaWMgZmllbGRzIG9mIFVTUiB0byBpbmRp
Y2F0ZQpzaWRlIGVmZmVjdHMgKGUuZy4sIHNhdHVyYXRpb24gb3ZlcmZsb3csIGZsb2F0aW5nIHBv
aW50IHN0YXR1cykuCkluIHRoZXNlIGNhc2VzLCB3ZSBkb24ndCBmb3JjZSBhIHBhY2tldCBjb21t
aXQuIFRoaXMgd2lsbCBhbGxvdyBtb3JlCnBhY2tldHMgdG8gYmUgc2hvcnQtY2lyY3VpdGVkIChh
dm9pZCB3cml0aW5nIHRoZSByZXN1bHRzIHRvIHRlbXBvcmFyaWVzKS4KCldoZW4gdGhlcmUgaXMg
YSBwYWNrZXQgY29tbWl0IHdpdGggYW4gaW1wbGljaXQgd3JpdGUgdG8gVVNSLCB3ZSBpbml0aWFs
aXplCm5ld192YWx1ZV91c3IgZHVyaW5nIGdlbl9zdGFydF9wYWNrZXQgYW5kIHdyaXRlIHRvIFVT
UiBpbiBnZW5fcmVnX3dyaXRlcy4KClJldmlld2VkLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWlu
QG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9y
c2ltcHNvbkBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5A
b3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaCB8ICAxICsK
IHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIHwgMzUgKysrKysrKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmggYi90YXJnZXQv
aGV4YWdvbi90cmFuc2xhdGUuaAppbmRleCBkMjUxZTIyMzNmLi5hMDEwMmI2Y2JkIDEwMDY0NAot
LS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaAorKysgYi90YXJnZXQvaGV4YWdvbi90cmFu
c2xhdGUuaApAQCAtMzksNiArMzksNyBAQCB0eXBlZGVmIHN0cnVjdCBEaXNhc0NvbnRleHQgewog
ICAgIGludCByZWdfbG9nX2lkeDsKICAgICBERUNMQVJFX0JJVE1BUChyZWdzX3dyaXR0ZW4sIFRP
VEFMX1BFUl9USFJFQURfUkVHUyk7CiAgICAgREVDTEFSRV9CSVRNQVAocHJlZGljYXRlZF9yZWdz
LCBUT1RBTF9QRVJfVEhSRUFEX1JFR1MpOworICAgIGJvb2wgaW1wbGljaXRfdXNyX3dyaXRlOwog
ICAgIGludCBwcmVnX2xvZ1tQUkVEX1dSSVRFU19NQVhdOwogICAgIGludCBwcmVnX2xvZ19pZHg7
CiAgICAgREVDTEFSRV9CSVRNQVAocHJlZ3Nfd3JpdHRlbiwgTlVNX1BSRUdTKTsKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRl
LmMKaW5kZXggOGZjZTIxOWMwZC4uZjMyNDA5NTNiNSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKQEAgLTI3Miwx
MiArMjcyLDcgQEAgc3RhdGljIHZvaWQgbWFya19pbXBsaWNpdF9yZWdfd3JpdGUoRGlzYXNDb250
ZXh0ICpjdHgsIGludCBhdHRyaWIsIGludCBybnVtKQogewogICAgIHVpbnQxNl90IG9wY29kZSA9
IGN0eC0+aW5zbi0+b3Bjb2RlOwogICAgIGlmIChHRVRfQVRUUklCKG9wY29kZSwgYXR0cmliKSkg
ewotICAgICAgICAvKgotICAgICAgICAgKiBVU1IgaXMgdXNlZCB0byBzZXQgb3ZlcmZsb3cgYW5k
IEZQIGV4Y2VwdGlvbnMsCi0gICAgICAgICAqIHNvIHRyZWF0IGl0IGFzIGNvbmRpdGlvbmFsCi0g
ICAgICAgICAqLwotICAgICAgICBib29sIGlzX3ByZWRpY2F0ZWQgPSBHRVRfQVRUUklCKG9wY29k
ZSwgQV9DT05ERVhFQykgfHwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcm51bSA9PSBI
RVhfUkVHX1VTUjsKKyAgICAgICAgYm9vbCBpc19wcmVkaWNhdGVkID0gR0VUX0FUVFJJQihvcGNv
ZGUsIEFfQ09OREVYRUMpOwogCiAgICAgICAgIC8qIExDMC9MQzEgaXMgY29uZGl0aW9uYWxseSB3
cml0dGVuIGJ5IGVuZGxvb3AgaW5zdHJ1Y3Rpb25zICovCiAgICAgICAgIGlmICgocm51bSA9PSBI
RVhfUkVHX0xDMCB8fCBybnVtID09IEhFWF9SRUdfTEMxKSAmJgpAQCAtMjkxLDYgKzI4NiwxNCBA
QCBzdGF0aWMgdm9pZCBtYXJrX2ltcGxpY2l0X3JlZ193cml0ZShEaXNhc0NvbnRleHQgKmN0eCwg
aW50IGF0dHJpYiwgaW50IHJudW0pCiAgICAgfQogfQogCitzdGF0aWMgdm9pZCBtYXJrX2ltcGxp
Y2l0X3Vzcl93cml0ZShEaXNhc0NvbnRleHQgKmN0eCwgaW50IGF0dHJpYikKK3sKKyAgICB1aW50
MTZfdCBvcGNvZGUgPSBjdHgtPmluc24tPm9wY29kZTsKKyAgICBpZiAoR0VUX0FUVFJJQihvcGNv
ZGUsIGF0dHJpYikpIHsKKyAgICAgICAgY3R4LT5pbXBsaWNpdF91c3Jfd3JpdGUgPSB0cnVlOwor
ICAgIH0KK30KKwogc3RhdGljIHZvaWQgbWFya19pbXBsaWNpdF9yZWdfd3JpdGVzKERpc2FzQ29u
dGV4dCAqY3R4KQogewogICAgIG1hcmtfaW1wbGljaXRfcmVnX3dyaXRlKGN0eCwgQV9JTVBMSUNJ
VF9XUklURVNfRlAsICBIRVhfUkVHX0ZQKTsKQEAgLTMwMCw4ICszMDMsOSBAQCBzdGF0aWMgdm9p
ZCBtYXJrX2ltcGxpY2l0X3JlZ193cml0ZXMoRGlzYXNDb250ZXh0ICpjdHgpCiAgICAgbWFya19p
bXBsaWNpdF9yZWdfd3JpdGUoY3R4LCBBX0lNUExJQ0lUX1dSSVRFU19TQTAsIEhFWF9SRUdfU0Ew
KTsKICAgICBtYXJrX2ltcGxpY2l0X3JlZ193cml0ZShjdHgsIEFfSU1QTElDSVRfV1JJVEVTX0xD
MSwgSEVYX1JFR19MQzEpOwogICAgIG1hcmtfaW1wbGljaXRfcmVnX3dyaXRlKGN0eCwgQV9JTVBM
SUNJVF9XUklURVNfU0ExLCBIRVhfUkVHX1NBMSk7Ci0gICAgbWFya19pbXBsaWNpdF9yZWdfd3Jp
dGUoY3R4LCBBX0lNUExJQ0lUX1dSSVRFU19VU1IsIEhFWF9SRUdfVVNSKTsKLSAgICBtYXJrX2lt
cGxpY2l0X3JlZ193cml0ZShjdHgsIEFfRlBPUCwgSEVYX1JFR19VU1IpOworCisgICAgbWFya19p
bXBsaWNpdF91c3Jfd3JpdGUoY3R4LCBBX0lNUExJQ0lUX1dSSVRFU19VU1IpOworICAgIG1hcmtf
aW1wbGljaXRfdXNyX3dyaXRlKGN0eCwgQV9GUE9QKTsKIH0KIAogc3RhdGljIHZvaWQgbWFya19p
bXBsaWNpdF9wcmVkX3dyaXRlKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgYXR0cmliLCBpbnQgcG51
bSkKQEAgLTM1MSwxMSArMzU1LDYgQEAgc3RhdGljIGJvb2wgbmVlZF9jb21taXQoRGlzYXNDb250
ZXh0ICpjdHgpCiAgICAgICAgIH0KICAgICB9CiAKLSAgICAvKiBGbG9hdGluZyBwb2ludCBpbnN0
cnVjdGlvbnMgYXJlIGhhcmQtY29kZWQgdG8gdXNlIG5ld192YWx1ZSAqLwotICAgIGlmIChjaGVj
a19mb3JfYXR0cmliKHBrdCwgQV9GUE9QKSkgewotICAgICAgICByZXR1cm4gdHJ1ZTsKLSAgICB9
Ci0KICAgICBpZiAoY3R4LT5yZWFkX2FmdGVyX3dyaXRlIHx8IGN0eC0+aGFzX2h2eF9vdmVybGFw
KSB7CiAgICAgICAgIHJldHVybiB0cnVlOwogICAgIH0KQEAgLTQ2Nyw2ICs0NjYsMTIgQEAgc3Rh
dGljIHZvaWQgZ2VuX3N0YXJ0X3BhY2tldChEaXNhc0NvbnRleHQgKmN0eCkKICAgICAgICAgfQog
ICAgIH0KIAorICAgIC8qIFByZWxvYWQgdXNyIHRvIG5ld192YWx1ZV91c3IgKi8KKyAgICBpZiAo
Y3R4LT5uZWVkX2NvbW1pdCAmJiBjdHgtPmltcGxpY2l0X3Vzcl93cml0ZSAmJgorICAgICAgICAh
dGVzdF9iaXQoSEVYX1JFR19VU1IsIGN0eC0+cmVnc193cml0dGVuKSkgeworICAgICAgICB0Y2df
Z2VuX21vdl90bChoZXhfbmV3X3ZhbHVlX3VzciwgaGV4X2dwcltIRVhfUkVHX1VTUl0pOworICAg
IH0KKwogICAgIC8qCiAgICAgICogUHJlbG9hZCB0aGUgcHJlZGljYXRlZCBwcmVkIHJlZ2lzdGVy
cyBpbnRvIGN0eC0+bmV3X3ByZWRfdmFsdWVbcHJlZF9udW1dCiAgICAgICogT25seSBlbmRsb29w
IGluc3RydWN0aW9ucyBjb25kaXRpb25hbGx5IHdyaXRlIHRvIHByZWQgcmVnaXN0ZXJzCkBAIC01
ODcsNiArNTkyLDEwIEBAIHN0YXRpYyB2b2lkIGdlbl9yZWdfd3JpdGVzKERpc2FzQ29udGV4dCAq
Y3R4KQogICAgICAgICAgICAgY3R4LT5pc190aWdodF9sb29wID0gZmFsc2U7CiAgICAgICAgIH0K
ICAgICB9CisKKyAgICBpZiAoY3R4LT5pbXBsaWNpdF91c3Jfd3JpdGUgJiYgIXRlc3RfYml0KEhF
WF9SRUdfVVNSLCBjdHgtPnJlZ3Nfd3JpdHRlbikpIHsKKyAgICAgICAgdGNnX2dlbl9tb3ZfdGwo
aGV4X2dwcltIRVhfUkVHX1VTUl0sIGhleF9uZXdfdmFsdWVfdXNyKTsKKyAgICB9CiB9CiAKIHN0
YXRpYyB2b2lkIGdlbl9wcmVkX3dyaXRlcyhEaXNhc0NvbnRleHQgKmN0eCkKLS0gCjIuMzQuMQoK

