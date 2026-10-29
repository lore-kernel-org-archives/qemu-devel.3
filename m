Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC868606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SgT2Saan;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hexBLpJK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMKKH-0003b2-El; Thu, 29 Oct 2026 03:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMKKC-0003ZL-7z
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 03:13:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMKK9-0007wK-DG
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 03:13:22 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T5H5Kc2244443
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 07:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JVsJu3ntX5M+ci6KQ2El1bzSnMhNgdaRziMK6XmlVPI=; b=SgT2Saan4ZdL1gsP
 NlHlXEE3tRPv8vcGLAAVhlIKi6CEMLl62pz0Lgs8Es/558mRIePTddUcnAOgFHgh
 OyAMKI0Ev5bEUOM2Qy9eP3p+pHxiZa+EvikLWQ19teN6u04V9VudaZRz99H+KKZV
 xEp2hEO5smziJN7tZNFO87Pb7iu5mjdp1lUlV0QagJaJ2bJbfPqbst37LO+o4Sr3
 eQjAVvWjhNXBORY84+aqNj81hypW9nJIoPaeLuMXGJHmm3ksSzykukwhnKoV58J6
 ubg3hCPRzsTBYMFQFHc0Tvvs8urD/9wFMJmKiGQrEwL0MPRvw7zr16uVlvFSVyTl
 jmvlYg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hky5s8gqt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 07:13:19 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93909014c85so320914885a.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 00:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793257997; x=1793862797; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JVsJu3ntX5M+ci6KQ2El1bzSnMhNgdaRziMK6XmlVPI=;
 b=hexBLpJKSANPldS77Calv5q4YglDPndDXHWzXGfbcQ7UzBlddJh++nXNXFE7+sNzjn
 HjzlNglbP9Cq5BcvQ2f9I5UQFOfFpf5XSCkGODQjcfgIv07L95lTD/dGxy2HaiYHmIZi
 GndW2n39yGlhDSTZZ0OPIJcynsJ5ROYDGPi9yRoX6S3qn3PEQJDR/7LoMykpo/wfOv7b
 LzNSsKKFTnHLTPd2lF5bgSCl3gD60zSJ56ORVEB63QesrXl0uGxT6m+2OiZwRibMaHTK
 ktLveiJg8VzMbEn/02b7+ipx3U5mIkLrwsSHZBQ9S7wH16FY3E/EZxWxIEGVQHmdr/c2
 eATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793257997; x=1793862797;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JVsJu3ntX5M+ci6KQ2El1bzSnMhNgdaRziMK6XmlVPI=;
 b=TidTgwCJdydOUmYKGWZjTUAlcCBYv84DMfHamO5tRKmEiDIAKAZh7pKU+rDjavl3I5
 hxW3f0Z28jGKsKQn4/j5TgUmH+enOeLBNKmLOImw4QeW72H7wy9NcwOvqFNNvnCz20Ci
 pgbswk1NsuJJb9MU/LDKv4pUZeJGpMJjWVmwrsp2UpXZaVHSqs1MYZ7FYdaP0k5Yl3ot
 8P3anq5auRUxCOr3B7/TMeMH+v3s/6xtLUcXtZ9FZ+zH3l8ZXX/Cc44zW2kyf6dR2/ut
 /cDi+8TGaZ9FJlQuIPrTCEgVmqkXD8fos085MjeZjJ8VluDiIBknpQo9z1PVRQIoFyxu
 AHeg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwKYui/+nuicOgYdctgU7iuKj2EyCvFRHL7l3PMoYNhxjtDR2E1yfmZTIT0Y3f81NXcnHtFN5cy2IFM@nongnu.org
X-Gm-Message-State: AFq9FYK8YRXRga22aj4gX/amLOfV8qe//UlHMQkuhkMOk1HVdCo9s2zq
 tIiyxhqk7PRjtIyUorGTH1oQbyR7wPPhug0VQdVES2CdWsAzF3PJ6snFu5Ep9xjsVzu/Rm/CZ0l
 fwMSyvUWrW+aB9852FxsbcovHw0Pmx6qdTT6Lugu8h9vkD3nicWfSiXVQCA==
X-Gm-Gg: AYBFou3+nmMDR6ye7yj/2GV/jVBggN6VxbkleGVB/GE4fXHklaVVux/xZEUf7eko3/c
 /yOdq/yfjK42jh5Bead9vsfIrS+V058tR52uA+adiAfKB7WW3bNTRzrtTTEZLrS5Zfp4TsjK7SX
 lL4xzu6VMHZNmTN84OhmEEQKMZKnXhmxlcR3MFqHOWsrAOWa9/5SlgjEhbYPda50H8Z3l0qjf+Y
 OBpo3eQkIor3p8f8kPgGCVKoaAnuOOE6tCU4247F7tjXcC98apL8opIiR5uN+LiZ5tjTQU4+iKo
 ycNXbBZltrbnB5726aJavomPra/C8YHaL+vsKy+qp+uZKrzUruB7/ADWWcm9J02BwtTvbRptJp1
 d7TE2VD8J6Kx8N431n9mCFXSAIjfMK95B4h2eb6lkFkK0sD7WBcfsKrf8u1qYWQvAwcEVK+lWTn
 or6t80LnobflF0abwhsd2wddg=
X-Received: by 2002:a05:620a:838d:b0:93e:f4f4:346 with SMTP id
 af79cd13be357-94408a96a06mr589685085a.39.1793257997551; 
 Thu, 29 Oct 2026 00:13:17 -0700 (PDT)
X-Received: by 2002:a05:620a:838d:b0:93e:f4f4:346 with SMTP id
 af79cd13be357-94408a96a06mr589682085a.39.1793257997022; 
 Thu, 29 Oct 2026 00:13:17 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94f05f168sm77063065e9.4.2026.10.29.00.13.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 00:13:16 -0700 (PDT)
Message-ID: <17bee10f-084b-4cb9-bbc5-d998e6e58147@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 08:13:15 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] hw/sd: Improve performance of read/write/erase
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, Christian Speich <c.speich@avm.de>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Conor Dooley <conor.dooley@microchip.com>
References: <20260417-sdcard-performance-b4-v4-0-119e66be10c2@avm.de>
 <4985e605-c4cb-4fd3-b48c-b2019fa6ebf7@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <4985e605-c4cb-4fd3-b48c-b2019fa6ebf7@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAyNyBTYWx0ZWRfX1TZw6FX/CsK7
 d0XI/9x3v/QBcKWluRocPg6qutFvw33X95xi21f1TaLrxZQ3IAINvH6pfNE/QvrMQlZoF4WuEX/
 Jve/t8TFG2B96oBXZ5WpfaeZYZUqMZXrjXlELDzGbh4kZWuyKhHgvB7Q5crhY/uImebJktTHWWq
 myu0549MWmCwvRo8punFJ4CaZP2RSSufP5yCHUlW18tTCZlO4CzHGo3Fq1RIjSaz6HLcOq2Ipff
 q6rRMuDW8KqJmvTddv81bUBtXASn6p2cm3y3CIHcSgaZMhZ8FPHS71F+d97WFDcfQl/AenKLBYl
 Ow7XsIJmMNamnn305TzkI3wABraGjdTMlMBQ5YEnw2+9Dvo45Q9oQmrjBAP01O8w66A4AeSj6zD
 Qc6yhd9PBgHzLTJNcz4Nmf16wd6b00ueo4wntoe83uwv9DmYH2Y+ljv7kvnPuFPnLMGw3oLqIAe
 qq+IEGAaJulDSxKzAiQ==
X-Proofpoint-ORIG-GUID: I7uCENlkfTjEFy3Uau-PBBJGP_CwOxUm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAyNyBTYWx0ZWRfX42C3lONYGEZX
 wAdYYdWSNLlp2GyFv0hfwBW2DMH+N4eteMDEcBLlVaH0buRH2bz/JL3/DAU8TZ5GRRDTqpnCKfk
 Jm2l8E4L1G1pL89ZzmxkzETUVgZqxMY=
X-Proofpoint-GUID: I7uCENlkfTjEFy3Uau-PBBJGP_CwOxUm
X-Authority-Analysis: v=2.4 cv=f/vdl+yM c=1 sm=1 tr=0 ts=6ae2f20f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=Ocu2gcipZQTISRmX2HcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290027
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 29/10/26 07:45, Michael Tokarev wrote:
> On 4/17/26 12:51, Christian Speich wrote:
>> This patch series improves the performance of read/write/erase operations
>> on sdcards.
>>
>> This is done by increasing the maximum buffer size that is worked on.
>>  From 1 byte (master) to 512 bytes (commit 1-3) to larger than 512
>> (adma commit).
> ...
>> Christian Speich (7):
>>        hw/sd: Switch read/write primitive to buf+len
>>        hw/sd/sd: Allow multi-byte read/write for generic paths
>>        hw/sd/sd: Use multi-byte/block writes for block path
>>        hw/sd/sdhci: Don't use bounce buffer for ADMA
>>        hw/sd/sdcard: Add erase-blocks-as-zero option.
>>        hw/sd/sdcard: Optimize erase blocks as zero.
>>        hw/sd: Update trace events for buf+len data
> 
> 3 changes from this series landed in the master branch for v11.1.0
> release:
> 
>   468fa450a7e0c hw/sd: Switch read/write primitive to buf+len
>   eff58d3d9681a hw/sd/sd: Allow multi-byte read/write for generic paths
>   d7f3ab9d5a186 hw/sd: Update trace events for buf+len data
> 
> 
> I don't see discussion about the other 4 changes, why these weren't
> applied at the time, but ok.

The rest failed harness test suite.

> 
> Currently I'm picking up another change:
> 
>   b5424abaf8e9a hw/sd/sdcard: Keep high-capacity memory blocks at 512 bytes
> 
> to the current stable qemu series, and it touches the same area.
> But the mentioned-above 3 changes are not included in 10.0 release,
> while 10.0.x is an LTS stable series.  And without the first change
> (switch to buf+len), things in 10.0.x are quite different.
> 
> So I can either pick the above 3 changes for 10.0.x, or I can omit
> b5424abaf8e9a for 10.0.x.
> 
> To me it feels like picking up the above 3 optimization changes is the
> way to go for 10.0.x.
> 
> What do you think?

I'll defer that to Bin, no strong opinion.

> 
> BTW, doesn't b5424abaf8e9a actually fix 468fa450a7e0c, not 2d7adea4fe57?

Likely.

> 
> Thanks,
> 
> /mjt
> 


