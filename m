Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A941C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9O7u-0001s4-HU; Wed, 23 Sep 2026 10:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9O7p-0001rH-0U
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 10:39:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9O7k-0008No-GF
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 10:39:06 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NDKfEI322165
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 14:38:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QAPNeVaRXknRyms4HxR2TnjgMeCvlo5g9U21YYAAeco=; b=DiXhunMos4Mm+QMd
 vDYmQB2k8FlbBj9hbq4d39Hl7D/YYq1zHCwarWmtfticPsx4U7rMuu+USwj/RN2I
 r9Dsm4zns3S+QyMmlhJyWnX06WlKMIwAxVRcyJ3jMhpxBg7hLuvg27hqLC1tpWrc
 lx42PDWopGo7cuCaPDmg5ieC3TkSbMp0KCM9k1xivJiSzAUSER6ld7BbR4NadH+7
 5+nXS4WlE0k5yVlMhWaF9PCoM3twESyeRayvYzhua/6/FLnKmtvsnP32gRJKggRI
 zzjNoU2qe9CD8ZIL0+71jeOs10xDf7LK36mSUVN/CIx9EEi6N9Of5U3lgIQ9IysW
 XvMggQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfjsgb50-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 14:38:54 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7a5ed2517b7so295300137.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 07:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790174333; x=1790779133; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QAPNeVaRXknRyms4HxR2TnjgMeCvlo5g9U21YYAAeco=;
 b=PGLJOB1n23T3Yu+nuvH2dLmTM3OtWQeAbb8kzde5bFhvlZanoNo4yWUX/qLY+GQ/6y
 h40Q+hbO3IXO9gtMPa4tcZATMYHweYZnfCJlf/LDq1EwOXhPkoDADvAFwa8DwymtQiW9
 gXqE3kiCAdGSRy/OR/tCCBOTTKrNDEIjgjRULgIhXRFCqz7i2ri6gWlFIcIXKzBZasR9
 lHZZHjp18XNnZuyyFV8zgRtJfozBvt68glR+8tGkbNKs6HoCSoL1KPvoiaT19LSn3mLd
 ItviL0glyb5DF9jN+/a3+rdF3thUeYZJLjTGd2G+3EuB0/V5Inh9762ozXwCrZG1hYIA
 40uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790174333; x=1790779133;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QAPNeVaRXknRyms4HxR2TnjgMeCvlo5g9U21YYAAeco=;
 b=JoDRKUB6HBQgUyKsl7jfx4U4zxXAuaRYj5P9yRDxXRfbXDWlJNYkT/EBd0KHXa8BqW
 KxTG5sFHsokb+9Wy5q3eM1zVeb71LVPbx8bclDZWox9sQKLzGdeG9LHc1oI8ODPlZafP
 mQGzeF+Llgm0zmzpogGQ+vLQ0t2Xx5RqmXWgM5huhbU+nJZzqBFZvrd924gMfHjicuNX
 wzlhY9lQi0NK79qm9KpkYR7pMk4KDuH2T638qT7B5iXvc8l2i87LvTgv/T5UwXI8JILa
 ux+FtptVl8ckI2X+VMn3rJTmLbnCKix2ZLHa/FJnwHJVv7a12U4+Y0yBOsWl++NF4p+G
 paDg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwjI5feKH8r01l4lo/aNqLlYSbFJJMfYFJzq9NbXF3ZfhYZrEnTwZeUx8ft3RXOBnBpwPzln35ULTq6@nongnu.org
X-Gm-Message-State: AFuF++n/1RuQT6NLeNVvO1B9xOfX6o5/Q+69TdZwI/FdPL1UIoYTMRZq
 ofDNYkEtgIMTyoH5vDGbWDm1N6XWDp2QYeGNnLuYZMqENVqqRWlmtaEj77H5SigUXmsGqCOA92G
 iXT7/evzRRljq6dVF9lwp3O/3rqaeimJ5x4kmyy8yD9QuQDy1d5E9zhUEmA==
X-Gm-Gg: AYBFou2qe84Wh0+cAyGYF+fzgF6cKsh71fg/sAqPPXXkl6fnJwnMlFRZ65vFrNT9BKz
 jH2O+DLZK9A1Qj4yVWan2gtptZgQe4fAfEkyr/i1tiqC34l0lU68qlya5+yVp8dUFnClBmUvlNz
 dfkiTH85lDvycRW1mz131r0Jz0qx2IdBYqvyzDwiWiuk0roiZcJ94YO7ZrBYCjnpai/gTvBnlnr
 153qvYsiW5pVKIZVWbsL/tBndLynZV1zciAABTn0y56m5mpRrlL1KOzMhLCEl88dei5P6e/sQ/0
 guxTQJrsRbKQYhmP86z20hfMBtIAqepU2sbsHyjdulHrt6usZM2Z4ni8ie4zRpkFXaM7eJDrqT5
 4vC+M/Leyh81s8rYr6c+4SHMQcYytss2LTJhnhXJJFKsqaNE=
X-Received: by 2002:a05:6102:f85:b0:7a7:198a:c2c4 with SMTP id
 ada2fe7eead31-7ac1ea9919bmr2646810137.34.1790174333604; 
 Wed, 23 Sep 2026 07:38:53 -0700 (PDT)
X-Received: by 2002:a05:6102:f85:b0:7a7:198a:c2c4 with SMTP id
 ada2fe7eead31-7ac1ea9919bmr2646789137.34.1790174333130; 
 Wed, 23 Sep 2026 07:38:53 -0700 (PDT)
Received: from [10.21.17.122] (161.170.88.92.rev.sfr.net. [92.88.170.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488684863d9sm7433840f8f.12.2026.09.23.07.38.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 07:38:52 -0700 (PDT)
Message-ID: <f890177a-4322-4207-93a0-7f690cae6b2d@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 16:38:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/3] target/riscv: Add vstimecmp support
Content-Language: en-US
To: Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Bin Meng <bin.meng@processmission.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <20220824221357.41070-1-atishp@rivosinc.com>
 <20220824221357.41070-4-atishp@rivosinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20220824221357.41070-4-atishp@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1OCBTYWx0ZWRfX/gtEkwQ9pqEU
 0oV6sL/0Yfo2Rx7RO6W8goE/o7b7G4rqQ7EzPIcoywQ131mG92kgMD9S6j4viK2hOXmAquuWFQ4
 03hUlOQwP8FKsA/6c1dylHYhRLotaqq5rXVoIX9HdaCv4sjNvEX8OuENKhJC0DQvDpmVMQGob/C
 eqLgG9ro9VZ/Idmd1R7JIxWJZvBvwqxi5V6B+TqWtC+RKb14LPd3vkqtjJVzIkLsdyNMh2eG4oO
 mm+WaTCPqVqX8/9KX8ThjY69lBbfcVB+47o3OlelWAY74h3pUP84Q21PwFRmWYTH8v/k+ZHisSZ
 FMjLojY8pCBGUAhIQTa+JyT9xshrWTGULbqwmg5kEquHbrPwc6wuTUYq5PSi/oqG9NX9OCYwf2w
 1Wk4zDjkYaGP2BHJzBVNyvyTLH1bdwzhQ1OQez12nVApg6X6UtvauyxdXB1ybZ8GgsPkE711JUq
 t2mGLlhv1ZdR9kGzMxQ==
X-Proofpoint-GUID: uOvpviAdnMijyZIlSIvH--QBWGcBP4gf
X-Proofpoint-ORIG-GUID: uOvpviAdnMijyZIlSIvH--QBWGcBP4gf
X-Authority-Analysis: v=2.4 cv=K4+3jCWI c=1 sm=1 tr=0 ts=6ab3e47e cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=XFFLIW5kwC1urAZS/mNkYQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=JF9118EUAAAA:8 a=h0uksLzaAAAA:8 a=8eR_iU2aUeOL-paLwokA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22 a=xVlTc564ipvMDusKsbsT:22 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1OCBTYWx0ZWRfX36F5qFo9U7LN
 BZBr22lajtftZcLKW2mv4XPAfDiT31c09Hm+MCAaFfG/QJU9xWyN0HIS8AYdLx42oCVTWc/vhpw
 VnZwq2IXWeq+HdGEbUGZN1ZswbS34ao=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230058
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Hi,

(now committed as 3ec0fe18a31fabfe999b480e4c21847ac0d51560)

On 25/8/22 00:13, Atish Patra wrote:
> vstimecmp CSR allows the guest OS or to program the next guest timer
> interrupt directly. Thus, hypervisor no longer need to inject the
> timer interrupt to the guest if vstimecmp is used. This was ratified
> as a part of the Sstc extension.
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>   target/riscv/cpu.h         |  4 ++
>   target/riscv/cpu_bits.h    |  4 ++
>   target/riscv/cpu_helper.c  | 11 +++--
>   target/riscv/csr.c         | 88 ++++++++++++++++++++++++++++++++++++--
>   target/riscv/machine.c     |  1 +
>   target/riscv/time_helper.c | 16 +++++++
>   6 files changed, 118 insertions(+), 6 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index d2529b757aab..d895a0af2c6d 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -311,6 +311,8 @@ struct CPUArchState {
>       /* Sstc CSRs */
>       uint64_t stimecmp;
>   
> +    uint64_t vstimecmp;
> +
>       /* physical memory protection */
>       pmp_table_t pmp_state;
>       target_ulong mseccfg;
> @@ -365,6 +367,8 @@ struct CPUArchState {
>   
>       /* Fields from here on are preserved across CPU reset. */

         ^^^

>       QEMUTimer *stimer; /* Internal timer for S-mode interrupt */
> +    QEMUTimer *vstimer; /* Internal timer for VS-mode interrupt */
> +    bool vstime_irq;

Shouldn't vstime_irq be reset upon vCPU reset?

>   
>       hwaddr kernel_addr;
>       hwaddr fdt_addr;

