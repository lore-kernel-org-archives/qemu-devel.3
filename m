Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E79606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 00:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cYGsK+Ed;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HwOoZ7PR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMDtV-0004Y4-CD; Wed, 28 Oct 2026 20:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMDtO-0004Xf-2e
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 20:21:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMDtL-0001an-UB
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 20:21:17 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SM9st51512862
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 00:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nkkYXC5p6lGl4uzjt0PXOrSPF/3webam7xmRKJgWzlo=; b=cYGsK+Ed9HF1m4ZS
 nWMypZO2c1YboT9j6uxf2yegEgQXZJgu+LyoyuAezWDLfOqdYuJIFTSFZaByWTMZ
 Mb3seMDVhfu1aAcE16oC6Pm3ctz5bbFcSr5nVOMfrMzdco2nRfMIFjs7PzTA/F3d
 WhLGF46fMiMkuDm/uR31blArsECPXQmd2ne9fa5TqAI039e0wlisqYotovQn6DFS
 z9l7yD4K6gLjSirL27adpdv0XzNKatY0zoCk8MD9aIEAd8JpbP4YtFo6a/HQCk0Q
 AJceL/8e1Cgk7U50vI9zF6LlMYi79NZAkZFcuH5zmlE3HFRxI/kpe4piUeXBzV8P
 wR2DUw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hknb29g8h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 00:21:12 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91c7cb9e267so17798426d6.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 17:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793233271; x=1793838071; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nkkYXC5p6lGl4uzjt0PXOrSPF/3webam7xmRKJgWzlo=;
 b=HwOoZ7PRdfR6XxBH0MArG5ad2yY+gkj14NYOIlCI57MvdsaBFZGUYy3nZ/yx4jPj6Y
 gTxkNFXKkBlJwqNAsDh/2q/GsSxaef1r5noK9H/kjKjnugXyqG7LBUz5F3s9CD/hqhF3
 2bqnsi4sYSg8ZEDqK8xVoethwXDefYap52DWi4L3MNlAS5gdtBWp4NZBSKlk6FIgZlDg
 U6xl1Tk8BHb5kSioeVkbKg2Ms7K4JngHiDUxF5uk04ah8kfu8qVs4yjAhUJai0KF0ywu
 Ycakg1//d9MXXaPThxpegPR/8EHw5RdgwpuU4QRoNJ+fqb0D4dQX1uJGsZVmg9Jp6oFr
 zq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793233271; x=1793838071;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nkkYXC5p6lGl4uzjt0PXOrSPF/3webam7xmRKJgWzlo=;
 b=S1qk8Zb9yPmgy2bWAtCf/MoJnQUbyShlub3a0PITJtNnq5zQR4IYYxAzx36Q86yndW
 WxKdE89LjsY/z5SXmadXGYG3p1Wi5+eDGS0FyoPoHJw7Eb8JVMitrIR5AE2tBQQjjip6
 6GPI/TaLlEqRnupu5Yusk51f+d8H32X1jFuUbSV3jh4msKqRvS9M27eV7LFMcaCSTfi6
 ITJFu7lhy6nWLv7xthus7czw52phHEgrLyg/c3kiv6kQ0R8algE7NzglhHFbls4KV9/2
 1SmFWAyAviNk2PUx7U/2gkrqZVx2hUlp3/3wkuqW/9F7kTxP8GkasZaDpqfaktSPIvIS
 9/fw==
X-Forwarded-Encrypted: i=1;
 AKwUvByAgFhxLN3mMMZVT6PrHZfg+uTf6WARwqK/CXS31TkjXGVdJsS2ZP4ftKm0qqdR5J01xR4s99pLzrPz@nongnu.org
X-Gm-Message-State: AFq9FYK2nnRgvpc5zrLBlYeCupF6TFmYphQN1f7ZRm1mE4DCDnsPUstN
 Ib4uz5Ts4fL52CZucKf3+5p9XEp4XFgwxNcN2PVsU2QegtzsNACxyIfZVPpPjoH0QznuRtVGt31
 dYajNxjO4zEBCOsNG79Kva0HHyBrwpoZTPVzhJ3cRS1UgG5/aCRAr1OpCPw==
X-Gm-Gg: AYBFou0dRSnqj30vs/FBq9r0m09MRYtbIdNhfmofwuvXxlzWIFmnmFRMbtfjhoKiqD0
 W7jBW3Ig5EpPkzFGLfUfCBTY7hMNvQcW7OBjGNSWPMkf+3aewo451aSRZ3NSLX52/uNTNWBTmmr
 JgGuaQZj4IzyB9Qob/guon9l/Iah60UrHdk2ILfa5EZ6bAbGsvr/QH4R/EhywBBdK8ms6qjl+Qa
 GcVEFhPaFaSAs081J4uopSGVsIrO0ZjG2l976DOgy4s1DZ+8aQsCvkbX2ws/wEJeCW+grrMS4Zp
 cNOojSEcOFfTbTE2CBewN2jtAcFuS6UcvQ4rg8FsYQm5XWbGbDAkN4D13XpIyAqlal/lyCUWlmX
 CKC2L+gr7ChE5edjdZOmjOH75tt248qGJphfWIV5fKSvweCVkxI76PFOQvkJSzxFvq6PwTjLfLZ
 Fw1dj1LGEAgoVJgPu/fVl/by89FaoGEqi8tA==
X-Received: by 2002:a05:6214:8617:b0:91c:711c:27f3 with SMTP id
 6a1803df08f44-91c7cf4a0eemr68083756d6.21.1793233270901; 
 Wed, 28 Oct 2026 17:21:10 -0700 (PDT)
X-Received: by 2002:a05:6214:8617:b0:91c:711c:27f3 with SMTP id
 6a1803df08f44-91c7cf4a0eemr68083436d6.21.1793233270328; 
 Wed, 28 Oct 2026 17:21:10 -0700 (PDT)
Received: from [10.248.104.162] (208.sub-174-237-64.myvzw.com.
 [174.237.64.208]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c7db3dbcfsm32896346d6.38.2026.10.28.17.21.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 17:21:09 -0700 (PDT)
Message-ID: <c980adde-e156-42b2-8cd2-3dae45e54feb@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 19:21:06 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hw/misc: QUP UART device
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261027183823.383806-1-brian.cain@oss.qualcomm.com>
 <c47cf1a7-15ba-46bb-8579-1b5a2367f2fd@oss.qualcomm.com>
 <916816a7-a1ff-4c5d-805c-6cacad6c95f2@oss.qualcomm.com>
 <59fa861d-a909-4b60-b1a2-c6f6eebc51fc@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <59fa861d-a909-4b60-b1a2-c6f6eebc51fc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Yu2a1IYX c=1 sm=1 tr=0 ts=6ae29178 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=jff3rsGav0cYookgkwt1wQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=DHpt-Luc1n_jbodHyxMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: RnterXsWCN9FsgS2LpZpdgcTR7OkXquk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAwMSBTYWx0ZWRfX74ZzQs8deXMP
 Zw9QiwxFMaAVP87zNKvsLOqQe34PUg9gMBSl8NWbFKRPURvM0LbsDwFyH+e7ke4cVYYPnwXRQU2
 eL10lZdKqo13o9JDxJiUo1a12j87UfI=
X-Proofpoint-GUID: RnterXsWCN9FsgS2LpZpdgcTR7OkXquk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAwMSBTYWx0ZWRfX2hzOqk5Pgxfp
 eKB4I7ahbuWKnnckZO7ME80HEclCAxbHJBMX35+uReWgp8mWACb/Gh+dR0odNqHRpL7c3tBJDj9
 NGJearRAl3tuIO/Clo5SFsEl838sLOqBtKazJCbtqVtYhWCTuCQ7e+u3pgpWqX3Ufxg4/M4uAtE
 VLKj2qR8aM5fv+mqvq7bIXOIxu3hklaAyZDjNV4zGwOSBpCTR2Fcj7HqqYjFjOTR8fG7g8TolK0
 6juE7N8+AT+FqjjVqShZ7ANnliMKjnI3+sCd7Lv2+FV8nVg4yN2ZqYpj5nTg1vxHpdrTusEPmIs
 TUh/UNVz80IF/kUS9cR33lisqFic+DHb+CTZRT9Y4v8VXdw1v5WFOdFulA1qdgN0UsO/JCdNG28
 a43r+5vfP/nn7HtskEckH6Ref2HAjzp4qg/4SLctXVmaj6v1I6IAm5ThzNr4U5y0wq1NwjpvjxA
 FidQATbVBatKfWt/71Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290001
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


On 10/27/2026 3:12 PM, Pierrick Bouvier wrote:
> On 10/27/2026 12:02 PM, Brian Cain wrote:
>> On 10/27/2026 1:43 PM, Pierrick Bouvier wrote:
>>> On 10/27/2026 10:38 AM, Brian Cain wrote:
>>>> Add the QUP + GENI uart device models.  The QUP is a "Universal
>>>> Peripheral"
>>>> present on Qualcomm SoCs, with connections for SPI, UART, I2C, I3C.  For
>>>> now we're only interested in UART.
>>>>
>>>> Will follow up with a v2 including wiring into machines + qtest after
>>>> https://lore.kernel.org/qemu-devel/20261027143721.4125584-1-
>>>> brian.cain@oss.qualcomm.com/
>>>> lands.
>>>>
>>>> Brian Cain (3):
>>>>     hw/misc: add the QUP wrapper device
>>>>     rust/chardev: fix write errors and add write watches
>>>>     rust/hw/char: add QUP GENI UART device model
>>>>
>>>>    MAINTAINERS                                 |    3 +
>>>>    docs/system/device-emulation.rst            |    1 +
>>>>    docs/system/devices/qup.rst                 |   10 +
>>>>    include/hw/misc/qup-wrapper.h               |   27 +
>>>>    hw/misc/qup-wrapper.c                       |   90 ++
>>>>    Cargo.lock                                  |   15 +
>>>>    Cargo.toml                                  |    1 +
>>>>    hw/misc/Kconfig                             |    3 +
>>>>    hw/misc/meson.build                         |    3 +
>>>>    rust/chardev/src/chardev.rs                 |   82 +-
>>>>    rust/hw/char/Kconfig                        |    4 +
>>>>    rust/hw/char/meson.build                    |    1 +
>>>>    rust/hw/char/qup_geni_uart/Cargo.toml       |   27 +
>>>>    rust/hw/char/qup_geni_uart/meson.build      |   28 +
>>>>    rust/hw/char/qup_geni_uart/src/device.rs    | 1293 +++++++++++++++++++
>>>>    rust/hw/char/qup_geni_uart/src/lib.rs       |    9 +
>>>>    rust/hw/char/qup_geni_uart/src/registers.rs |  160 +++
>>>>    17 files changed, 1741 insertions(+), 16 deletions(-)
>>>>    create mode 100644 docs/system/devices/qup.rst
>>>>    create mode 100644 include/hw/misc/qup-wrapper.h
>>>>    create mode 100644 hw/misc/qup-wrapper.c
>>>>    create mode 100644 rust/hw/char/qup_geni_uart/Cargo.toml
>>>>    create mode 100644 rust/hw/char/qup_geni_uart/meson.build
>>>>    create mode 100644 rust/hw/char/qup_geni_uart/src/device.rs
>>>>    create mode 100644 rust/hw/char/qup_geni_uart/src/lib.rs
>>>>    create mode 100644 rust/hw/char/qup_geni_uart/src/registers.rs
>>>>
>>> Any specific reason to have this implemented in Rust?
>>>
>>> Not a bad thing in itself, but it means it's only available with rust
>>> builds, which can be a problem if a machine defined in C wants to use it
>>> unconditionally. Rust is not (yet) a mandatory dep for QEMU.
>> A new device model -> a brand new day -> a new frontier?
>>
>> It was an interesting challenge and seemed appropriate given the nice
>> reference pl011 device.  But I will concede it can be impractical.
>> Making this device conditionally enabled in the machine that uses it
>> felt kinda "lame" and made me long for a day when it *was* a mandatory
>> dependency.
>>
>> Seeing as how we have a pl011 device in C, maybe it's better to start
>> with a C version of the QUP?  If so, that's okay with me.
>>
> If it's a mandatory device as part of a machine definition, it would
> probably be better to stick to C for now.
> I hope we can get Rust as a main dep at some point. I'm not sure what is
> the criteria to do this change, out of deciding "let's do this".

Hmm - so ... can I put in a vote for this, then?  Can "at some point" be 
now?  What are the criteria?


> Regards,
> Pierrick

