Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52A4606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 00:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Xdg0ilfG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CxwHIAnV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xME3b-0006I7-50; Wed, 28 Oct 2026 20:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xME3Z-0006Hf-LW
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 20:31:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xME3W-0002zI-JV
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 20:31:49 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SMASBV1878002
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 00:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AwWel33/Tt9dp4puUqDsjpaWPFVn4pXe16RXJOMGb6w=; b=Xdg0ilfGP/8hGjJw
 R+gyWuiJmlPYnOv9nz6eYmhl8wfieNWOxM5kmwnCcDCxnY2/8BY9+BMpOI5/Ybko
 1JhS2RXNEr5GNOlUjxWD5PNaeORA5mXFVCoL811coSqEd+bDXY55vZqerSeZPgI0
 nKzqwgoqQi4o63TTz9omE4fEvX61FJIiFTQHdXHsOVVk5tufqPFrswpeAAE2J8ws
 1EgadSLZdUfGXYphPQuB8IwMvziMxujxiIls8gn96nhN7d/jwi1bB0HboalMOquw
 ufv2FjvuKmo8uX56AOjw2O1xslIMs64ybKqFGRaSt5XL7BOo2m98uvKXcBT8OeCC
 EWtPDA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hks3n8jmp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 00:31:43 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-341eff9e381so3226851eec.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 17:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793233903; x=1793838703; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AwWel33/Tt9dp4puUqDsjpaWPFVn4pXe16RXJOMGb6w=;
 b=CxwHIAnVphpummYB3D/KUV1B+JJBUN6QGMXFDjjHgb2fBGgxzhg3ASPAeSmcuEy6Z+
 hMxYLiXKE3TRRqE1tlhN3Y2IkwW/hlcqfM+WsmuRHWU9bK1IIG0my5gwP7r4V47bzWLc
 uA+M6lZlCcBE5IvNCDDY0b6HbOsm8H3kzpzqoowSaRzyTh3iSFhR5D4L2EJnF6MlFHll
 M/WpP9hEB0JWaTWf59DXYgyLoWYJGDGeatYyP6ItJ3Nw4nPXZECLUyZb+eraTHFH8tnq
 e2mWpTr+Ob7+0dcHWFdJRPBJobGMZeGZJvuTr4Zd3F7oJf/d1xj+JaMTylkEWoE2r9eu
 EuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793233903; x=1793838703;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AwWel33/Tt9dp4puUqDsjpaWPFVn4pXe16RXJOMGb6w=;
 b=i2AmIsLlikziDL+7i8Ci+pjFHK2YHUHKTBq35HilMNHjhowOd53H1chSrUzUL1txWk
 AGRGqWDWJlwqi9L9PWZzJY/V3ZLg38zs6aqleq8cvKY+vntjLBRXzVYkquzpK5Smw/aP
 n+5X4sdEey0WM0WNOfoknA0vTqmw2KpAOAt4f19lTaXIVpDeULEYsU6tWMiO9Rp/UgBD
 nQ0xNTAdv4juMJpIbuFLvaIgqEhLXzKaUFGBBPWXnr0Igb5zvRGe4HSunQlSzchfTIdC
 Vihah5RtV9Imlzh++gnoIwpBjJV+zqpZUPxaAIpqJNDmcXyUKvaBeRAMKZfc3QdRg/Kg
 5LJg==
X-Forwarded-Encrypted: i=1;
 AKwUvBytee3fXdkSu7X/D43HlYlCC3fmwtZt6cQhaHknZ4haoxjzRnAcPvjhY/VKn/Kh4OUc6LI8o7O8Hu5F@nongnu.org
X-Gm-Message-State: AFq9FYINi6Um5BTLP/dHTQL7Oxu8JcAGkXiG8ihHLX85o21J01lM6sg5
 6U7m+w2bNhpsTgLoeM+5GyJLUlZaWuD13Sj2wxoM6U76pE5/ne87jZkAgz0261oVimDRhLy1wwS
 XmXP8eL/TE3dj7kk5iFvSjAs6MkRZAtXJzrqROVQwGLNdkgTidyVQrS5Pww==
X-Gm-Gg: AYBFou32odwx2tnyPwxpygcXE4nlPLVRLKrGlLLD4VSmA12tepeiR/y0ZXhu22/Q8Ci
 cXiYjFZvh23LfTkdd41wWZSHVmw+ArZULcLQOwqB7yuEBIuOyNEXm9j4J07tm5PmTIQhkxGS4sZ
 KQQplUIz4PUvPqvY5aEgJJWiLChnqekKSaRXMjKZ7DUgb/MJbGaDQntOEbKMtjS5HLUoE618YBa
 MY3FcPhjk517Gfwab/Mv4iWCr4WSq7smbuFQpU7EjBtwtao8kW4fVUQ3vv7PmXKBpgcLLx3/UHB
 BR9GvqLTKwWOzRkIMwqKJ1eCVRuY/7ewamicGq/xcO4GyZTfJu4dJsacU6sbC1wUAdwchtlAlQJ
 W5Xz66mfVn1UJADaefdkc9g/D315CO3yVR+EcDcQFOfrJ3+f+lKXDDEm0Ib1nXnhdXCFQ72R160
 TOx0PgMKQpzVj6GiaTj6teK77bIrZCfKacZ7Qm3Gm+lhk=
X-Received: by 2002:a05:7301:1407:b0:35e:6eae:c01a with SMTP id
 5a478bee46e88-36a203febbdmr5970843eec.19.1793233903066; 
 Wed, 28 Oct 2026 17:31:43 -0700 (PDT)
X-Received: by 2002:a05:7301:1407:b0:35e:6eae:c01a with SMTP id
 5a478bee46e88-36a203febbdmr5970798eec.19.1793233902347; 
 Wed, 28 Oct 2026 17:31:42 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a238d9a21sm11814767eec.4.2026.10.28.17.31.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 17:31:41 -0700 (PDT)
Message-ID: <bac9f630-139e-4b8a-831b-e395665aa77f@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 16:31:40 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hw/misc: QUP UART device
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261027183823.383806-1-brian.cain@oss.qualcomm.com>
 <c47cf1a7-15ba-46bb-8579-1b5a2367f2fd@oss.qualcomm.com>
 <916816a7-a1ff-4c5d-805c-6cacad6c95f2@oss.qualcomm.com>
 <59fa861d-a909-4b60-b1a2-c6f6eebc51fc@oss.qualcomm.com>
 <c980adde-e156-42b2-8cd2-3dae45e54feb@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <c980adde-e156-42b2-8cd2-3dae45e54feb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: LWqXIJXHt53GDXmTa57wrfra4iC-mXda
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAwMSBTYWx0ZWRfXwK/2sO6iW5+b
 SEi9VN6vuOCTd/35Wa0LuxScq9E4AHYZ4yXuIsm8CImUKQVmyrnidjOXE9XpSigFYmQ35iOsWTn
 PO4VxvTygfDLnAOw8d+CzqkWPJPOKWspmKsIi5/QAiX6iDCVSKYbJl/wE3SXeHj1mQo2Bk2P7CY
 iFkP0V9CYA2qI/CKxMwPmCkMFXoT/nJDJXBi4NfmZNID5baUC5nB9yphg3NNcO2yXgH9bpa4l9b
 FAjk6pHk1zjJTzbbdDcbkUtQ5MkhmAJ7dJpjQ/QQa1T6ka7L+oGO7RhlwUR9wh1skG64Xs6eFgf
 c25j4JLCQ+ylR8D5Q/gyvKxzh1g318J2UiX7ToJ/Xbqz7Wb6UHvsGZqbJJtZiT92Gb5BVJsGQBQ
 8loCGFLPFzzjni+HGJsPr9fmYYHnOLhInwz5koTXOPyDozJ4xpqgu812ETwVl90hvkxeNxsSxos
 bwJFJPV5hOipO1flMkw==
X-Proofpoint-GUID: LWqXIJXHt53GDXmTa57wrfra4iC-mXda
X-Authority-Analysis: v=2.4 cv=XZEcX455 c=1 sm=1 tr=0 ts=6ae293ef cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=lzC1xbRnt52T0FqQe7UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAwMSBTYWx0ZWRfX6anLgHITgu0S
 mbuxzLCxA7aY3q3kukN8XO+8d+C2uM/Kygn44JzJucgCHcUfcqJHkcs6rEW5wSRq8wJLEWG7Ina
 6r3ZIiWeMEojLPRzl2n2Y9gFtkaPEPI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290001
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/28/2026 4:21 PM, Brian Cain wrote:
> 
> On 10/27/2026 3:12 PM, Pierrick Bouvier wrote:
>> On 10/27/2026 12:02 PM, Brian Cain wrote:
>>> On 10/27/2026 1:43 PM, Pierrick Bouvier wrote:
>>>> On 10/27/2026 10:38 AM, Brian Cain wrote:
>>>>> Add the QUP + GENI uart device models.  The QUP is a "Universal
>>>>> Peripheral"
>>>>> present on Qualcomm SoCs, with connections for SPI, UART, I2C,
>>>>> I3C.  For
>>>>> now we're only interested in UART.
>>>>>
>>>>> Will follow up with a v2 including wiring into machines + qtest after
>>>>> https://lore.kernel.org/qemu-devel/20261027143721.4125584-1-
>>>>> brian.cain@oss.qualcomm.com/
>>>>> lands.
>>>>>
>>>>> Brian Cain (3):
>>>>>     hw/misc: add the QUP wrapper device
>>>>>     rust/chardev: fix write errors and add write watches
>>>>>     rust/hw/char: add QUP GENI UART device model
>>>>>
>>>>>    MAINTAINERS                                 |    3 +
>>>>>    docs/system/device-emulation.rst            |    1 +
>>>>>    docs/system/devices/qup.rst                 |   10 +
>>>>>    include/hw/misc/qup-wrapper.h               |   27 +
>>>>>    hw/misc/qup-wrapper.c                       |   90 ++
>>>>>    Cargo.lock                                  |   15 +
>>>>>    Cargo.toml                                  |    1 +
>>>>>    hw/misc/Kconfig                             |    3 +
>>>>>    hw/misc/meson.build                         |    3 +
>>>>>    rust/chardev/src/chardev.rs                 |   82 +-
>>>>>    rust/hw/char/Kconfig                        |    4 +
>>>>>    rust/hw/char/meson.build                    |    1 +
>>>>>    rust/hw/char/qup_geni_uart/Cargo.toml       |   27 +
>>>>>    rust/hw/char/qup_geni_uart/meson.build      |   28 +
>>>>>    rust/hw/char/qup_geni_uart/src/device.rs    | 1293 +++++++++++++
>>>>> ++++++
>>>>>    rust/hw/char/qup_geni_uart/src/lib.rs       |    9 +
>>>>>    rust/hw/char/qup_geni_uart/src/registers.rs |  160 +++
>>>>>    17 files changed, 1741 insertions(+), 16 deletions(-)
>>>>>    create mode 100644 docs/system/devices/qup.rst
>>>>>    create mode 100644 include/hw/misc/qup-wrapper.h
>>>>>    create mode 100644 hw/misc/qup-wrapper.c
>>>>>    create mode 100644 rust/hw/char/qup_geni_uart/Cargo.toml
>>>>>    create mode 100644 rust/hw/char/qup_geni_uart/meson.build
>>>>>    create mode 100644 rust/hw/char/qup_geni_uart/src/device.rs
>>>>>    create mode 100644 rust/hw/char/qup_geni_uart/src/lib.rs
>>>>>    create mode 100644 rust/hw/char/qup_geni_uart/src/registers.rs
>>>>>
>>>> Any specific reason to have this implemented in Rust?
>>>>
>>>> Not a bad thing in itself, but it means it's only available with rust
>>>> builds, which can be a problem if a machine defined in C wants to
>>>> use it
>>>> unconditionally. Rust is not (yet) a mandatory dep for QEMU.
>>> A new device model -> a brand new day -> a new frontier?
>>>
>>> It was an interesting challenge and seemed appropriate given the nice
>>> reference pl011 device.  But I will concede it can be impractical.
>>> Making this device conditionally enabled in the machine that uses it
>>> felt kinda "lame" and made me long for a day when it *was* a mandatory
>>> dependency.
>>>
>>> Seeing as how we have a pl011 device in C, maybe it's better to start
>>> with a C version of the QUP?  If so, that's okay with me.
>>>
>> If it's a mandatory device as part of a machine definition, it would
>> probably be better to stick to C for now.
>> I hope we can get Rust as a main dep at some point. I'm not sure what is
>> the criteria to do this change, out of deciding "let's do this".
> 
> Hmm - so ... can I put in a vote for this, then?  Can "at some point" be
> now?  What are the criteria?
>

@Manos, Paolo: any idea on this?
Could 12.0 be the first version to make rust a mandatory dep?

Regards,
Pierrick

