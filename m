Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CB8C55164
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 17:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpUdd-00075I-Gg; Thu, 30 Jul 2026 13:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wpUdb-000759-FU
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 13:33:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wpUdZ-0008K6-OZ
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 13:33:43 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UGX3NU1525633
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 17:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +QguBwq8LDsi4Cs+WatqKzRpXYHGa0wRzJDGyPPrBgM=; b=EY4jnklNe1kCEH7r
 +as4fAvuegKub1LpHnweHy07cGuU6BQPXJBmIhFPgj5PGOsPE+2sTR30flJaCghS
 HzTB/xatVuvlsvD89GbyqM3DCf4d/pASp49J4JxY7meXIlrgditZJ2/tvQbNOuil
 Cn3dN3kxY2mjhyMnVjQYN7mMRbsrojY13L8pCbhDCA2tHmxo3+jWASmXXE8JucXz
 714N701G0xPpGhbI8rLI8RXAhQMNsNwes8dl6aWQ61CFbW9g6vhxoFtE6fSkd5ch
 5UgiOWz5vJAQ4Io0mcUx1kTRh7AuYyqyZ7sP9cAqbq4PwSaYojB0kCLzF0wnYlNL
 Z4WmFw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr6yfsfuc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 17:33:39 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38fa7b09921so198513a91.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 10:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785432819; x=1786037619; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+QguBwq8LDsi4Cs+WatqKzRpXYHGa0wRzJDGyPPrBgM=;
 b=dmWJZ+pIx+bWgqrp6EbakfvgQmpGirOX/R6Hg/KzOEToIurQFRuEwclAnH/gOPeuth
 pvw9bmB8Ep0l3cqyIF7cC59Suq+HF7UdpT/OlLKpCzqn0g46gra7pRu4lrWt+wRb29Vv
 Prid8yj1GrekgmPeXGw8j2C/gpNGuwg6ayLZgLW0V/HNcWzctHcYzig0396XdlMx0lLA
 LRxv55cNHfRr1kz0W1pGjBNnzQN7KOX0wdBsv2SITI41XkOTVPnAQOZKQZZW1OY5LWch
 djtj/27KH/6Mpepe2S15lzd4n09wHkDDz86/zV4lOuyeQC2PGaOqgiHGrsP6ajyBUWqR
 p1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785432819; x=1786037619;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+QguBwq8LDsi4Cs+WatqKzRpXYHGa0wRzJDGyPPrBgM=;
 b=h7pJe2oEq7STRHQLJWzqCQZPuaxAmMih2KKXYRlQ6AyguvFMApSobcETfNn2XJvsuQ
 +rhl31E5iBYc6TN3nBEqbOZT/cBWrkAi9xHni6VWloOrJQZ+W8523KY7Zjgvtv6J1Z/w
 axrm1HMQuaQU+oBgMFxKJyHXavw70Wk+WwvfcRNuAcZuNw0eqg6a5fMwVNgAxr9lYPlg
 HrHPDasyQfq99a3/XBukM/UwMWV1cXMEtm1zJkFviCPw018yTamsBPJQr65xnItFKfWz
 x1QrrRMRRpjhSXW3aWSg61eArcM8JfTXO1I8cfOgtkEdjpcTdbTVtk6ufSSCpmRsHgiw
 0AZA==
X-Gm-Message-State: AOJu0YypTC1E/xfUmb96pBiGAUH5CRTFdAKrjc404WATHQq/5TzkyT5N
 PiInnNZaC+bzrKv8cbDV4+hXaDIjXoTMcwVzIreS7Q1THCOj5SqXAqlQrvOq5h0vVK1HAPWjrv2
 AA6lyt05hjSH8vYy7miEOErthWvxPGPMHVB9kox58Bhkk/QSw1HRSjhJtQ36P5pbZIQ==
X-Gm-Gg: AR+sD10Mol0Pntv0ocCuIMrh7rUn5xybrHNIsjSUniJ+4iSJsZgo45Xc1PtTxqDNQS8
 lDHGMse30BbHVx5t/AboQRG+Rv3u+Iah7jazCqevhOijVHVMEK78EZc8WjE8VvHGNbougML6oK0
 /NJFyRHZWTVgnirsGQnxCcV976Lv/2JOuRXfemF09hDFG+ESIlaJD5CiGTo5MEDOYTX9mCjHtsf
 LVxmq7dqvCbcjehnvrW9JyJsd1lSIDwUhZkTnpCnQtNywrHAAM/Lph4n0psNPl+tIIe1xtq131V
 CCvoHsqHmRWxotzxnJC1ixWXw6mFccpMt6JF8IZdSYsKoCKCJ4hhUSvEhQlkAzyxRc39B3bifof
 e8djWbJMpULmhYtTP8xOUx/zr2iRG7vpUOtDTUPO2ZYv+H9H7MvoQd6sAL3MqFBI5xUQX
X-Received: by 2002:a17:90b:510f:b0:38e:dc4:3fbb with SMTP id
 98e67ed59e1d1-38fa7f9b10cmr835770a91.43.1785432818713; 
 Thu, 30 Jul 2026 10:33:38 -0700 (PDT)
X-Received: by 2002:a17:90b:510f:b0:38e:dc4:3fbb with SMTP id
 98e67ed59e1d1-38fa7f9b10cmr835735a91.43.1785432818276; 
 Thu, 30 Jul 2026 10:33:38 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e7271f010sm27081967c88.9.2026.07.30.10.33.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 10:33:37 -0700 (PDT)
Message-ID: <56625144-c2fe-4017-90ed-473e570fa35d@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 10:33:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/27] single-binary: implement dynamic filtering for
 machine types
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEzMSBTYWx0ZWRfX5ddn5SWAblZX
 RrHA3tNH53qteIiprZw+0tJi1FgeoaigL1RcHKLFeESzQJxrzePQbtH9WNiFgQ9dJVNh8Q2MR5z
 2BBMqD0iL5DEb7iC7O6UyXa9ScUGqnwJ104py23KesMCrSjh+IbrKO+WHXl+UqhYLnvtUOSh9j0
 P7IsX8rlhCq237EQY6xngusOhEITDqw058f1HN8A+VZ3jYlCN1y/e1qu3OMjE8AUpM3zErGodeE
 9OOt1nnVHFgcFBC4jV+fRuT/Ff3UFjPPTs1gWdMsTmbrf6C68K81dAYIXK1/SNgrWifstxJrZBP
 7wY8EQHxSOZJi9kqJOBS314L99l21NponGjOB4Uz2LAeW9psuMzLXZTZtRga1QZglkkyrHnIFGl
 0zseED0thur9pp4nH9z1b6/w4WOeW/nxmc3STtGESC5rkN8tWt9VD/UQP4NvbeHdFyfiDRXyeih
 TwgD+XzOd3PofhMYuRw==
X-Proofpoint-GUID: BmMZVoyVfgm0WoKc_P2UFlNkPiY8U6ML
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEzMSBTYWx0ZWRfX7KxL7tdQioJt
 tuiZHgBe07m+BwLg3zahxcNnDma9b2/GTXNBqDbDfLvEPdMMVgfcxtt78ikO0po+gk23EVhTgWS
 nj8pbYHFCDS3RQjFjOmc858dDwHNfQM=
X-Authority-Analysis: v=2.4 cv=Tv3WQjXh c=1 sm=1 tr=0 ts=6a6b8af3 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=BIMoBbIzgqyw9w_Ie0IA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: BmMZVoyVfgm0WoKc_P2UFlNkPiY8U6ML
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300131
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/23/2026 5:09 PM, Pierrick Bouvier wrote:
> Now that we can link a single-binary with at least two targets (arm, aarch64),
> we want to make sure that we expose the same set of machines (later devices and
> cpus) than target binaries. For that, we implemented a static filtering based on
> target interfaces that each machine will implement to declare which targets have
> this machine.
> 
> However, we discovered that this static filtering is not enough. Indeed, some
> machines and devices do not depend only on target, and their presence can depend
> on Kconfig or host/target combination. Thus, our static approach can't work, and
> we need something more flexible.
> 
> This series adds a new TYPE_TARGET_SPECIFIC, that declare a single function
> bool is_available(void). From there, any machine type (and later devices and
> cpus) can implement it to override their presence for each target.
> We first replace the existing static mechanism with this, and once done, we
> cleanup all the old interface. One nice benefit is that we can get rid of
> config/targets/*.c files, which saves duplication.
> 
> This series was tested by comparing list of machines for all qemu system
> binaries, before and after this change, to make sure we don't introduce a
> regression.
> 
> Pierrick Bouvier (27):
>   include/qemu/target-info-qom.h: declare TYPE_TARGET_SPECIFIC interface
>   hw/arm: implement TYPE_TARGET_SPECIFIC
>   target-info: add target_riscv32 and target_base_riscv
>   hw/riscv: implement TYPE_TARGET_SPECIFIC
>   target-info: add target_config_multiprocess
>   hw/remote/machine: remove unsupported arm target
>   hw/remote/machine: implement TYPE_TARGET_SPECIFIC
>   target-info: add target_config_xen
>   hw/arm/xen-pvh: implement TYPE_TARGET_SPECIFIC
>   hw/xenpv/xen_machine_pv: implement TYPE_TARGET_SPECIFIC
>   target-info: add target_config_nitro
>   hw/nitro/machine: implement TYPE_TARGET_SPECIFIC
>   target-info-qom: implement new machine filtering per target
>   target-info-qom: use TYPE_MACHINE instead of target_machine_typename
>   target-info: remove target_machine_typename
>   target-info-qom: add type_target_specific
>   hw/arm: remove TYPE_TARGET_{AARCH64,ARM}_MACHINE
>   hw/arm: remove {arm,arm_aarch64,aarch64}_machine_interfaces
>   include/hw/core/boards.h: add DEFINE_MACHINE_TARGET_SPECIFIC
>   hw/arm: remove DEFINE_MACHINE_{AARCH64,ARM}
>   hw/arm: remove machines-qom.h
>   hw/riscv: remove TYPE_TARGET_{RISCV32,RISCV64}_MACHINE
>   hw/riscv: remove {riscv32,riscv32_64,riscv64}_machine_interfaces
>   hw/riscv: remove DEFINE_MACHINE_{RISCV32,RISCV64}
>   hw/riscv: remove machines-qom.h
>   configs/targets: remove target info definitions
>   target-info: rename target-info-stub.c in target-info-def.c
> 

Gentle ping after a week.
You're welcome to review only your architecture if time is limited, and
validate the global approach.

Regards,
Pierrick

