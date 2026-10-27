Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C810606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 20:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cNW1BioK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hNrfEfUB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLnNy-00089q-Q2; Tue, 27 Oct 2026 16:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLnNw-00089N-JO
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 16:03:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLnNu-00061Q-6V
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 16:03:04 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHof14036021
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 20:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8Jz4TBwnKhYXI+dr9+L1hGA1ssJY1x79b9/2wqzHwnU=; b=cNW1BioKt2gYwSVB
 sy2Cw5jVu1vjLENjQuQRiHNaTF//9ZEPCozAh5OTxTams0bHDNKy7HPdTcsomSEH
 +mVW47tSLWussPJGnS8mcJfYXbbO1MqZfPPvEouoHpr3TcD1wVeGWLFDIhsUaqWn
 peG9oz6Ctdn4OLWs2PMc8SK154Xji0fZ3+kYiRSc8WdSuKwOM9MBgjysSEdGgm7T
 0yTLOAHVTna7DCHn5RIkt8Ree+6vgh9JB03wl+aHosPCbuzWf+AZK8Rn7x5WVubX
 +OhUFxCoLzRUEV4epHttFPWdkj2teeQwijPIy8aJ1h2/NjxMvILfjLM2U6aJW+X5
 ueURaA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjyjprub7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 20:03:00 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5338ff2cf14so6614411cf.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 13:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793131379; x=1793736179; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8Jz4TBwnKhYXI+dr9+L1hGA1ssJY1x79b9/2wqzHwnU=;
 b=hNrfEfUBzWFk4nYO1vZKdyGrO3zEWIlf/QrDlm40AVKSilSdz9rASluTKzupKxFuUk
 yGwVa3CPROO8mf/4kZQ+u8SRO/AHTGyxX/puHaS7IXcp5206+v2HF4lExUyCIeM7+z0w
 fapfWjMqElp+rAkWvDCRKA8hMpZ0XJULnkabC0Un6AEvucS/TJQYVZCNs69tx+rKHqs2
 baHy3BpUUWkL7KHuSha8sHhav72R/gGth6h50pcwYhPZN7dFJ2iOuGnHmbiW2mTNk3AF
 iDFN6GX4BQ+BwYtoyNdgyITlRbWfTekVEXSFn8xLfuoNF2CvtXoolIj7IJMUxXGIwUL9
 KO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793131379; x=1793736179;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8Jz4TBwnKhYXI+dr9+L1hGA1ssJY1x79b9/2wqzHwnU=;
 b=b42FFVbnHB/Rl2PaQeiMOc8828ANSr+G721avFbR2v4hYjfY2oJQe9W4kFr9+ffw3W
 WLauwmuvi4ME6vN7K8bxavSdf7q4z90G1gCISH/LLiDCSFTvDZ4Sswi74CC8QEvxvGai
 YSoMxuN5UhC5isQkEav5sVVDKxAx9qZ1takcra4LkgbJQi3EsGGE2UYWMBdMOYgpcoqY
 KSqhR9DB/FxwNwMihGfIm2blTlVNGCo2dTcoxDIpd/HfRa6w8UQI0KUnMhNcACONMp1l
 VoAPyRegnLpzd/PTS29CMYobeBENOiXfksx5AEsJVhmlKZbFL5hkW6GcrfRNO+Up153p
 1pJw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxysALlaXzqht0eVtWwYOVznVFSkZFbfSi0l51c0rNhoCl/YdWa1bz05++A7aAkxxAjEDfCdKk/ikrp@nongnu.org
X-Gm-Message-State: AFq9FYJ2nV7/qVi9QWI6YsjihBPvQGp+tulXy/ZCAeMUp9cJ136U8uBL
 IrhiJEZQPHqvg/ttVoDEpsqkPPQVp62PT76PNjfno/F4tdnMjqa1t6MjmodwKFnSja/4WJQl/EM
 /6TsZ2w3hrRuSWqgujAl+4Yax6265Vm4KK7vl+QvbhEZ1ZK6tiLqpGC5teg5iOga8WA==
X-Gm-Gg: AYBFou2qF1bko/dvA6y0ASHSdgZ4NXm5xHuqR3t5sTg4mrFxTC9NZaW1fUhtyQ8Nml2
 PYYFk8aTd/lWKrtp1PSCPMF2/r+N81kxTJWlqtZm7JpG0vt43kgzewWwCudR4e3avYwsSvXs9m1
 Efyh/ORTTKonwZ/EEqKu5YPhmZFNB5EQskdGi/wD5yz0edEdmp2PubiZEhhb4992zM8m4f+cOtN
 B4DWTNw7y79dIbhs8fsofrZ07847TR2B+7FLGqdHGuS3/w4rCE2M+gHgkRLOCHhIuWWBAIDAYT5
 JveFhi1YFLfEsm0W7++hJlgC2V0ms/9di5s6iUYz5d1YFkTMy+d1Jelh5NaTQYfEVCdKsCtYR84
 MPqbnOQ+JoEmK9yprq7dfQ6hqYoLSdJ+fWMW9Ew3PnrXKS0gVAXPkq10Rhc8Mu8SY
X-Received: by 2002:a05:622a:14d4:b0:533:39bc:efec with SMTP id
 d75a77b69052e-53fc8cbb723mr7032411cf.2.1793131378961; 
 Tue, 27 Oct 2026 13:02:58 -0700 (PDT)
X-Received: by 2002:a05:622a:14d4:b0:533:39bc:efec with SMTP id
 d75a77b69052e-53fc8cbb723mr7031851cf.2.1793131378279; 
 Tue, 27 Oct 2026 13:02:58 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53c26e27c24sm59703851cf.19.2026.10.27.13.02.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 13:02:57 -0700 (PDT)
Message-ID: <916816a7-a1ff-4c5d-805c-6cacad6c95f2@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 15:02:55 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hw/misc: QUP UART device
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261027183823.383806-1-brian.cain@oss.qualcomm.com>
 <c47cf1a7-15ba-46bb-8579-1b5a2367f2fd@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <c47cf1a7-15ba-46bb-8579-1b5a2367f2fd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA4MCBTYWx0ZWRfXyqApczQf42at
 h6LNjT5RU4WOP8w1/8TwH8uIiuYwE3ZLGsAgmxUbskor2j4bRRc0S3/E3/trKSz4O3G8iD3WI4p
 xHx2z7dXzZfI8bbgiqXEboIobp+XEi12531WbZI0IAyDsaF4lqODsJrcDbKU9U8Styh20ZT3w7Q
 FHAV7ukk5ow4+a3BLBlDERjk1G1DVXx9qM7bb2EEgxso2MRCysDJgElML/1LGA7bi/REIzwIJA+
 mHZaCYOXopgwypGN+MHT7FP1tXr3QqIxYjaD6HMJDwz7C/hLL+JTIDOMIKveokuBrn6Nzmur8tk
 wE4Ioe90q01QEsBhSaiArgePqlg/QxcCFnoLzrUOzFRgyxSdhnOe9kcLJK9TtjrbDF5MN7f0C3C
 /+EHUyq19rmmik5ggvLKHIz695InbwOkNNnKjfupVBrH2KhrYHtlABtVOCyBgQOnuepD0o1K8Wz
 omVvUM7zwUscwWsxvEQ==
X-Proofpoint-ORIG-GUID: aJicESVPr9FMaueagetXH4Pnu-WDNeYt
X-Proofpoint-GUID: aJicESVPr9FMaueagetXH4Pnu-WDNeYt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA4MCBTYWx0ZWRfX9YqlSlBfQxD2
 oha5bntjQcpl9InezJuJPo9rx3TwRxwHRvakmA2/HHDeCJB1UDwHpnOgpjdEwREa/c82SdSTerP
 J5PgK0whP5TSHYOyLPkFssbYOB6WbME=
X-Authority-Analysis: v=2.4 cv=JodkP84C c=1 sm=1 tr=0 ts=6ae10374 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gN3lQdsfpnJrD2Lq6oAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270080
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/27/2026 1:43 PM, Pierrick Bouvier wrote:
> On 10/27/2026 10:38 AM, Brian Cain wrote:
>> Add the QUP + GENI uart device models.  The QUP is a "Universal Peripheral"
>> present on Qualcomm SoCs, with connections for SPI, UART, I2C, I3C.  For
>> now we're only interested in UART.
>>
>> Will follow up with a v2 including wiring into machines + qtest after
>> https://lore.kernel.org/qemu-devel/20261027143721.4125584-1-brian.cain@oss.qualcomm.com/
>> lands.
>>
>> Brian Cain (3):
>>    hw/misc: add the QUP wrapper device
>>    rust/chardev: fix write errors and add write watches
>>    rust/hw/char: add QUP GENI UART device model
>>
>>   MAINTAINERS                                 |    3 +
>>   docs/system/device-emulation.rst            |    1 +
>>   docs/system/devices/qup.rst                 |   10 +
>>   include/hw/misc/qup-wrapper.h               |   27 +
>>   hw/misc/qup-wrapper.c                       |   90 ++
>>   Cargo.lock                                  |   15 +
>>   Cargo.toml                                  |    1 +
>>   hw/misc/Kconfig                             |    3 +
>>   hw/misc/meson.build                         |    3 +
>>   rust/chardev/src/chardev.rs                 |   82 +-
>>   rust/hw/char/Kconfig                        |    4 +
>>   rust/hw/char/meson.build                    |    1 +
>>   rust/hw/char/qup_geni_uart/Cargo.toml       |   27 +
>>   rust/hw/char/qup_geni_uart/meson.build      |   28 +
>>   rust/hw/char/qup_geni_uart/src/device.rs    | 1293 +++++++++++++++++++
>>   rust/hw/char/qup_geni_uart/src/lib.rs       |    9 +
>>   rust/hw/char/qup_geni_uart/src/registers.rs |  160 +++
>>   17 files changed, 1741 insertions(+), 16 deletions(-)
>>   create mode 100644 docs/system/devices/qup.rst
>>   create mode 100644 include/hw/misc/qup-wrapper.h
>>   create mode 100644 hw/misc/qup-wrapper.c
>>   create mode 100644 rust/hw/char/qup_geni_uart/Cargo.toml
>>   create mode 100644 rust/hw/char/qup_geni_uart/meson.build
>>   create mode 100644 rust/hw/char/qup_geni_uart/src/device.rs
>>   create mode 100644 rust/hw/char/qup_geni_uart/src/lib.rs
>>   create mode 100644 rust/hw/char/qup_geni_uart/src/registers.rs
>>
> Any specific reason to have this implemented in Rust?
>
> Not a bad thing in itself, but it means it's only available with rust
> builds, which can be a problem if a machine defined in C wants to use it
> unconditionally. Rust is not (yet) a mandatory dep for QEMU.

A new device model -> a brand new day -> a new frontier?

It was an interesting challenge and seemed appropriate given the nice 
reference pl011 device.  But I will concede it can be impractical.  
Making this device conditionally enabled in the machine that uses it 
felt kinda "lame" and made me long for a day when it *was* a mandatory 
dependency.

Seeing as how we have a pl011 device in C, maybe it's better to start 
with a C version of the QUP?  If so, that's okay with me.

> Regards,
> Pierrick

