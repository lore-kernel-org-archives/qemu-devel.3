Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9214EC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 09:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh25X-00048E-Ox; Tue, 07 Jul 2026 05:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh25V-00047G-BT
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:27:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh25T-00065D-66
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:27:33 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6678E2bI3070519
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 09:27:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iBP1AxOYEH8JTa5JlqgsLzsFIYJ5VInnvZONiK9C3A4=; b=owId1Oqcui4QmW6R
 kE3kfQeBTIYjva0IYVszoX6weEaBQBKyYFE1GOPo97wBWPy36KGoyqCLFI+cxmBq
 fI0kPPJQuWubEq12Ngblr1WGlmV/kZZcTnPqEYQIWOGah3uRyK0ps7bg+AE7eCoH
 H9jVojqE1yprGDpQS2TknftX5YlKfr/AkVNt8+8QAXTOs5kSeEUfxzBCaKFfqSYB
 DptIwOf+93IxEBtVT7xeqo+ldOhxEyUl6+ThL1mFPW3yhnWP+gSCX/0Mrou9opFX
 oAhG7dEnj/Fc8CVGM3CL7XMAUpsq/qK6ErVn+kfUIQ4rc1bmSV0Qh5VdbAQQBDeV
 tDFUcQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8sm8h9jp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 09:27:29 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51a8c689b5fso40435371cf.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 02:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783416449; x=1784021249; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iBP1AxOYEH8JTa5JlqgsLzsFIYJ5VInnvZONiK9C3A4=;
 b=hajI440elSQmcbH0AKuWSXWlnk+rAyRCM6a9HDrJK2l7b5QdbK7Bfjgr+1ILdmfbys
 dtepZlpVQOtvSItR8vMptwtezmEwiWUCc0EXga2I+pugKCWiLJ9xOK3xqUJYNP8xyfRY
 g9CBdPe3/X4L2loRfnyWnztqEDg25xsAxPFS+P3Xv1Os+dpJjzE+44JarxvD4w7yJn7v
 4kjrv+0PEi5qI1/vfPq8v0Zpf6Ik5xVMPZaGNDT1Eo03aF/J5aFOzTiYpVS0MqJ100nV
 mstAE599Xi55b2k88m/e32Mcid+2jRn0ChPlVLU9D3pJZv5EAcT3upANXYJqpr6UUTGp
 4Wxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783416449; x=1784021249;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iBP1AxOYEH8JTa5JlqgsLzsFIYJ5VInnvZONiK9C3A4=;
 b=oDW3Kek/rUTnl6yamJZSx/hSlCesWQ1UPOjrSzmTpm6ZgynR8wP090tkCLtopwjgBW
 QmAgZPrdyXl3s9zlSGJbSC8fPdRZvNqA6bCKn3NtC1P9ln7CPbLWX3Yls3/H/O8FGDg1
 My/KHshRlAfP9cVdW/pyLxz3UTmXJv8NxQSuwnPdpA+RBDku3FiM7xcCTmpWIeo898VS
 zonZTQRRbtfe2ZA9GqAyqQKJsXtpQ3OxgbTjjAgLoodnRDL0uitHMHexAVOhZXxJ0oKH
 D5OGD12pteg1LYvVNNGf/tdkBDVZf5D5glbDh08yKIArgOp/9CFZY+Uouz74gfhc+nOY
 e+SA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpjSvZOgkzLV6XdHCtli7LHtmsuFR4TQbK9Y3YsZ1q0QPLvDFS1UCSWiU5joZesyDwLyUk019HDz9ua@nongnu.org
X-Gm-Message-State: AOJu0YycE8GWfjJXzjoW3AmOFEdg7A3V6JyUp45sbgFkfeJjPJVtuxnZ
 dNWG23qftkh29pVmqfJo5IJKY7PD4yRDmUv56v36bJH2NzVHfz07DPRrBvWvVCK7Bs7Lf3RM96b
 nlmws+gdLIfDsVQ/ob4cPrzODqmAEyhxwyxohC3qIiwoE+FwtVyhotlTW9g==
X-Gm-Gg: AfdE7clOtUEaj/960ltu2Nt/rvYqw8ta8PzX31ecov77QAVxy+JsKuGruwI8MVKwu/z
 ERRBEVreplzlOuCmmu26uQT3kC/vLMlZtEkp3296k5cKNtqp0m5BkiWeiXNJDMaJrarf+s0izEa
 9WlMxlgSd8FLmaw5U6TKzrLCb7Ek9Nuz5RMAFDwwU4lvnxnXco4hhV0bQcpNs9NR0b/D88wMS/e
 GRXE+GRiJ8Gh+qcloAl1BodLwpoALzY9n8q61oclqClSaBbaE1zw4FjmMIxzPqtC6VKtfMMpjUq
 Vrq/4FMnEHPyoGbArPO4TEKgZM9Fj0qGhhWrDg/4aBI+v8yd0aiXPEHR26pHRSUMBo/giIXzbTk
 Y64IU4Z7Hg9Fz7wpzmZJWDAZ+s5VZlPUccJ8byuEzn2Flh/iqoso4skyD0cNLkA==
X-Received: by 2002:a05:622a:180c:b0:51c:17cd:1fd4 with SMTP id
 d75a77b69052e-51c748b8011mr47337121cf.41.1783416448478; 
 Tue, 07 Jul 2026 02:27:28 -0700 (PDT)
X-Received: by 2002:a05:622a:180c:b0:51c:17cd:1fd4 with SMTP id
 d75a77b69052e-51c748b8011mr47336861cf.41.1783416448064; 
 Tue, 07 Jul 2026 02:27:28 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19cf68f5sm5714948a12.13.2026.07.07.02.27.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 02:27:27 -0700 (PDT)
Message-ID: <5d422df9-b70a-4c9e-8736-25b220c9a92f@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 11:27:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] hw/arm/aspeed_ast27x0: Pass realized PSP SoC to
 SSP/TSP initialization
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260707060919.350637-1-jamin_lin@aspeedtech.com>
 <20260707060919.350637-6-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707060919.350637-6-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA5MCBTYWx0ZWRfX9TxSIJy4PDJZ
 +elWZPD2fOuI6cyKVP+V4YT2QYqlGxSb9IAQxc9pQ3Rwi3yvayrNaqJrKDPHoejeiFtzie5UnVg
 OeSui+Id3GaMOYPn6w/KHS0fR1LuDgihkic9npBAqA7CqNuztkIoYANxqgXEgvh5oIPyZkgpG5i
 Eow0ZUKpqMWVJA4xGPBwRty5cVAOz1jBejU8MnScRqsdbO0yzD1NCqQBaX0cZBaQW2gd4RyTfyv
 ThvC+BqwRMXdSRjE/MUGES4F2z9JaSmhmfI/TDXEmi5FGAmMiBGL1UUypVpgR9AirVEfRoobKF9
 LR8TZUWgebkQI21HDbBm26lunaL/UCcAAwdm7o2Anjl66yzadJUtOEUZLGn+EePOVOnL/L2YEO9
 JTEkP+RwMIMT2tuSTWs1pIXvJLXkwzuwE/x7mIrIpbXWStZ95tlP3aitCYbL6ndIDYPt6MP+XFO
 636IX6OFPgNVTh7un5g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA5MCBTYWx0ZWRfXzQh3ndgEgsls
 GKTcY3lsfHrQOy+AzNTlx6H6d6PtjJ2+hXJq4zO15CXUt/DnZpNkQk5tMlUvXzub++m5S2sHuTz
 eFRmaahy1q+W4zNo5gj19cB3NDYo6nQ=
X-Proofpoint-GUID: lg64dv1I71w6qaIlBU1FdyO9Dr4OmFm6
X-Authority-Analysis: v=2.4 cv=UvdT8ewB c=1 sm=1 tr=0 ts=6a4cc681 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=V2NxCb60AAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-ORIG-GUID: lg64dv1I71w6qaIlBU1FdyO9Dr4OmFm6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070090
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/7/26 08:09, Jamin Lin wrote:
> Pass the realized PSP SoC to the SSP/TSP initialization helpers instead
> of retrieving it from the MachineState.
> 
> This makes the dependency explicit, since the SSP and TSP coprocessors
> use resources owned by the PSP SoC, including the UARTs, SRAM, SCU and
> SCUIO. The PSP SoC must therefore be realized before the coprocessors
> are initialized.
> 
> No functional change.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast27x0-fc.c | 26 ++++++++++++++++----------
>   1 file changed, 16 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

