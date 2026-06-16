Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDA2CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 11:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZSFZ-00086E-61; Tue, 16 Jun 2026 07:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZSFW-00085k-D2
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 07:46:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZSFU-0005KM-CH
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 07:46:34 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GACSp53474684
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DNfi62Po1vvM6rFtKWf14uVzrqotOoWQIrGuWaXe7CY=; b=SH8S34NWNVMJTyRr
 9UWDW3OZhColdh6nYns5BfVAaedFvZWKBr2YUgWkFlkkwtl2SERySjNCRuahUJZD
 LPXJpJRXYGx8/2zIx5dzIGeq8zSKqxdDf8PJI50qfDld9oclAbb3TcoTWI8rATB7
 vM2OD6dnZcRVxf7UWYlkKR0x+KHUUnvGuLMfhhwxskv978hen3mA5yxoIScFcDxm
 KR6miDsI8A6wiIuC1M34mcx16+9F9LenZDczu5qsppX+TLDq9+Iutw12V40bJGDC
 NOuCbqo62U8kEzxdrce/dUPazDwNF9V4YvwfOY+OJUa9MUW5L2WeXa11NpZABuWG
 pdfBvQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ety52su3v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:46:29 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-6c7b5cf8bceso1813822137.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 04:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781610389; x=1782215189; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DNfi62Po1vvM6rFtKWf14uVzrqotOoWQIrGuWaXe7CY=;
 b=NxQ1OvPwnLu3eRCKvMXUWIfj5s8J945zbVjxB79CrXoXD6NjdNgjR/MZTDPembrFJw
 0hbRjW3oDmFW6vEvCeE8CEW0VonqhyqxAjcea3datD9nz+NjV7B2FKhW1B6cI7YVZCnz
 aicmSeoM2tK16CIMzAmyW/Rm84QyArDoouJ/yDzpC12biTVt3DJbW8MYRiTOA67lgAex
 pViJnimQ+i/cQOgPtzrnF3C6Z+En85df/4H1myPAs9Rni222tC3Nt4+oLvFcxCYikZ4R
 7olKW7c3wxVlC5lmgsyrqbSG2BYcUjlJuwhPRo2wXCDV43PicA6NOk+IeRf7a5o8az8H
 Vy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781610389; x=1782215189;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DNfi62Po1vvM6rFtKWf14uVzrqotOoWQIrGuWaXe7CY=;
 b=KMiuokcAj6tXrxUz+dQcPKX5iDaGIPnf+VSI+D7VFg0XnT9raDwAVv2aZZWZcrH56j
 4jn45JIY+wkSaXaa79rz9W+1CgRS43GzAiEzXLcrEoDEGMU2aUoOs8j2AxdTqrgyb37J
 79oduLMQ07hzxn48IoUCATJNsZi8AMKJBRoPoEMO1V9cR7zUOcl/y+JswEDFbEtAovVo
 zzwu0HBZWGh8BSuFI4KnH9YfEdeRaku9i6a/jNHqcF2bnV1qFTh9Hzep3tsqtBtRxUz1
 3N2Ak7JgDFw2ZSBAtrOOUZsrsfDUE1l9NPQBv88tNPE9DF+C0NIkofiZ7DfjCJQ2uLkW
 +v9w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/gw4jXIiXkYMlBJYHgzc30oG1UX+YWeUo4RIsxG17cYVhWgtFakaxsFc63RGcpuFIIqZGuwJ+nBlqs@nongnu.org
X-Gm-Message-State: AOJu0Yxebsb++m5v0sWhuQmSYx5XYUwqFzjNDBIaCiErnBaop/2d8lOr
 wontCkZhIW84Rnn7Gkm3jIJxMqY3PSFusXzPai0ykSgIspw3HrtcfcrYVlTYyGaq6hh675im2RI
 aZHmQy6xKlfb2TLl0kb6LPvmT8KVe2ydSnw+luzgqL5ihf/kAV/Z6VnXt6g==
X-Gm-Gg: Acq92OG/CgdeeCU7HLp5x2dhxsM93i8PiNMIjXZ/Zjpt3TSgWRvUp/FHVhwsdHFRadY
 ZgjHfvwx3AuMDysLXtKu3lQIGFvdxaLL3thPrQWMLpXecTcuKn6ot8auaaQHekgv9wqqUY4r9Qk
 1Vu+2+4wnmp34IKTdPcARcDQXOjBdsi5tkGoYEsBYghKnWfldDirgd1ehCjX+pwWg2eHDeStW3+
 3U9XGzhtz39ruqApH9gwQOz/ZeNSKVuKLaFbUY02zIMlr5cyt7/n4C2SkkTloqZepNTpY9STqSm
 hXpeCca6284XHd8FXhtVwDZoEyxCcnt2a12geQUj+TuFuUPIikNKKhIpqVSZbewLyI029TwP0nV
 oDIXo2c9FuO/DyLV3saVZA88imVvphRlHpXsgOVutdLcFSsJChrO7JgsG+8Ur/0gFf+Ggw0wx
X-Received: by 2002:a05:6102:1611:b0:6c6:74d:e090 with SMTP id
 ada2fe7eead31-722d8362b43mr1437787137.9.1781610388816; 
 Tue, 16 Jun 2026 04:46:28 -0700 (PDT)
X-Received: by 2002:a05:6102:1611:b0:6c6:74d:e090 with SMTP id
 ada2fe7eead31-722d8362b43mr1437777137.9.1781610388339; 
 Tue, 16 Jun 2026 04:46:28 -0700 (PDT)
Received: from [192.168.69.214] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea9563b8sm273627805e9.2.2026.06.16.04.46.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 04:46:27 -0700 (PDT)
Message-ID: <dac37988-c69e-4915-84cc-2072901a9321@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 13:46:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] target/loongarch: clear the registers when cpu is reset
To: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
References: <20260616092554.1704380-1-lixianglai@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260616092554.1704380-1-lixianglai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDExOSBTYWx0ZWRfX0j3n5ChowbuY
 IPh2fBual825R6wJSSHNzBH8rEaRaOvyCXpMKlYi/jHuweHnkCRS3XvlJhpY89uqOVyZJXSVukN
 XvrTM1k0pI6g3kkpC4x1a7YAHRq8ykQ=
X-Authority-Analysis: v=2.4 cv=FJwrAeos c=1 sm=1 tr=0 ts=6a313795 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=Z4_oO1Wf4vQ4007CZn0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDExOSBTYWx0ZWRfX4DSgwjkzqfyG
 bJtmJwBNkBFuQhCLe9iw7mQm2H4U4dA7h1rc1QEriw8lHxit/+G8r0od7DHWhu8Qh+OUJUgquu5
 +xmZqFMAPMutCsmJ5k/By/rqwP6zGrsd1aVJ4CRTiwcrurABga82JX6/HNL+MOVSv6tJdnuSIME
 CWepmEKN5+Zdpn/xdsg040BC24H1aFzMZlbMpue3xTHINMCBdp5uiB0yS+VuKJszLIbX07pf+f4
 WCXgf58rSE3YQToGZMxA6nUTHbBU7bY9rSDU+zqLMKt5sBRQVBFAGOxc0ZwSMLytOmyiq3rVW+P
 mE72vVBNiGijwVt26gDG5h7HZvQZxGrS0ZErOnJXkHYGrSiUjK74MvWOi3rWRbtJ5T1iIUvyawQ
 zc85P46KsJGgaMQW9nkWzENGns2UlsNOwHqSi0gNNjxDzI64xc2SJaOIzGMweHdDzoDP6fEXZ+v
 tffIK9BKoAA1aiO8ZXA==
X-Proofpoint-ORIG-GUID: rKO8dzAiorcl0Vg8crJOAp4wjfhnfnx9
X-Proofpoint-GUID: rKO8dzAiorcl0Vg8crJOAp4wjfhnfnx9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0
 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160119
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 16/6/26 11:25, Xianglai Li wrote:
> Use virt-manager to start a virtual machine, and then use the following
> command to manually trigger the crash of the virtual machine:
> echo c > /proc/sysrq-trigger
> 
> After the VM is abnormal, the ESTAT register has a certain probability of
> remaining interrupted. Then the VM is forced to restart and the VM is
> suspended in the interrupt handling function during startup.
> 
> In order to clear the remaining interrupt information in the ESTAT
> register, we carried out the operation and checked the status of other
> registers during the reset process:
> 
> Set the CSR_CRMD, CSR_ESTAT, CSR_MSGIS and CSR_PERFCTRL registers to the
> reset state when the CPU is reset.
> 
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> ---
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Bibo Mao <maobibo@loongson.cn>
> Cc: Song Gao <gaosong@loongson.cn>
> 
> changelog:
> V1->V2:
> 1.Add a description of the issues related to this patch
> 2.Replace the macro definition MAX_PERF_EVENTS with the variable
> perf_event_num as the condition for the for loop.
> 3.Rebase against the latest codebase.
> 4.Refer to the usage of end_reset_fields on ARM and other architectures,
> and modify the current implementation accordingly.
> 
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> ---
>   target/loongarch/cpu-csr.h |  7 +++++++
>   target/loongarch/cpu.c     | 41 +++++++++++++++++---------------------
>   target/loongarch/cpu.h     | 22 +++++++++++---------
>   3 files changed, 38 insertions(+), 32 deletions(-)
> 
> diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
> index d860417af2..d936af8e57 100644
> --- a/target/loongarch/cpu-csr.h
> +++ b/target/loongarch/cpu-csr.h
> @@ -211,6 +211,13 @@ FIELD(CSR_DMW_64, VSEG, 60, 4)
>   #define LOONGARCH_CSR_PERFCTRL(N)    (0x200 + 2 * N)
>   #define LOONGARCH_CSR_PERFCNTR(N)    (0x201 + 2 * N)
>   
> +FIELD(CSR_PERFCTRL, EV, 0, 10)
> +FIELD(CSR_PERFCTRL, PLV0, 16, 1)
> +FIELD(CSR_PERFCTRL, PLV1, 17, 1)
> +FIELD(CSR_PERFCTRL, PLV2, 18, 1)
> +FIELD(CSR_PERFCTRL, PLV3, 19, 1)
> +FIELD(CSR_PERFCTRL, PMIE, 20, 1)
> +
>   /* Debug CSRs */
>   #define LOONGARCH_CSR_DBG            0x500 /* debug config */
>   FIELD(CSR_DBG, DST, 0, 1)
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index fb03424ffa..aa6ecd9da2 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -623,44 +623,39 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
>       env->fcsr0 = 0x0;
>   
>       int n;
> -    /* Set csr registers value after reset, see the manual 6.4. */
> -    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, PLV, 0);
> -    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, IE, 0);
> -    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DA, 1);
> -    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, PG, 0);
> -    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DATF, 0);
> -    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DATM, 0);
>   
> -    sys->CSR_EUEN = FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, FPE, 0);
> -    sys->CSR_EUEN = FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, SXE, 0);
> -    sys->CSR_EUEN = FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, ASXE, 0);
> -    sys->CSR_EUEN = FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, BTE, 0);
> +    memset(sys, 0, offsetof(CPUSysState, end_reset_fields));
>   
> -    sys->CSR_MISC = 0;
> -
> -    sys->CSR_ECFG = FIELD_DP64(sys->CSR_ECFG, CSR_ECFG, VS, 0);
> -    sys->CSR_ECFG = FIELD_DP64(sys->CSR_ECFG, CSR_ECFG, LIE, 0);
> +    /* Set csr registers value after reset, see the manual 6.4. */
> +    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DA, 1);
>   
> -    sys->CSR_ESTAT = sys->CSR_ESTAT & (~MAKE_64BIT_MASK(0, 2));
> -    sys->CSR_RVACFG = FIELD_DP64(sys->CSR_RVACFG, CSR_RVACFG, RBITS, 0);
>       sys->CSR_CPUID = cs->cpu_index;
>       sys->CSR_TCFG = FIELD_DP64(sys->CSR_TCFG, CSR_TCFG, EN, 0);
>       sys->CSR_LLBCTL = FIELD_DP64(sys->CSR_LLBCTL, CSR_LLBCTL, KLO, 0);
>       sys->CSR_TLBRERA = FIELD_DP64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 0);
>       sys->CSR_MERRCTL = FIELD_DP64(sys->CSR_MERRCTL, CSR_MERRCTL, ISMERR, 0);
>       sys->CSR_TID = cs->cpu_index;
> +
> +    sys->CSR_DBG = FIELD_DP64(sys->CSR_DBG, CSR_DBG, DST, 0);
> +    for (n = 0; n < env->perf_event_num; n++) {
> +        sys->CSR_PERFCTRL[n] = FIELD_DP64(sys->CSR_PERFCTRL[n], CSR_PERFCTRL,
> +                                          PLV0, 0);
> +        sys->CSR_PERFCTRL[n] = FIELD_DP64(sys->CSR_PERFCTRL[n], CSR_PERFCTRL,
> +                                          PLV1, 0);
> +        sys->CSR_PERFCTRL[n] = FIELD_DP64(sys->CSR_PERFCTRL[n], CSR_PERFCTRL,
> +                                          PLV2, 0);
> +        sys->CSR_PERFCTRL[n] = FIELD_DP64(sys->CSR_PERFCTRL[n], CSR_PERFCTRL,
> +                                          PLV3, 0);
> +        sys->CSR_PERFCTRL[n] = FIELD_DP64(sys->CSR_PERFCTRL[n], CSR_PERFCTRL,
> +                                          PMIE, 0);
> +    }
> +
>       /*
>        * Workaround for edk2-stable202408, CSR PGD register is set only if
>        * its value is equal to zero for boot cpu, it causes reboot issue.

Is this comment still accurate?

>        *
>        * Here clear CSR registers relative with TLB.
>        */
> -    sys->CSR_PGDH = 0;
> -    sys->CSR_PGDL = 0;
> -    sys->CSR_PWCH = 0;
> -    sys->CSR_EENTRY = 0;
> -    sys->CSR_TLBRENTRY = 0;
> -    sys->CSR_MERRENTRY = 0;
>       /* set CSR_PWCL.PTBASE and CSR_STLBPS.PS bits from CSR_PRCFG2 */
>       if (sys->CSR_PRCFG2 == 0) {
>           sys->CSR_PRCFG2 = 0x3fffff000;
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index ad30c73167..2576239b31 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -325,22 +325,30 @@ typedef struct CPUSysState {
>       uint64_t CSR_MISC;
>       uint64_t CSR_ECFG;
>       uint64_t CSR_ESTAT;
> +    uint64_t CSR_PGDL;
> +    uint64_t CSR_PGDH;
> +    uint64_t CSR_EENTRY;
> +    uint64_t CSR_PWCH;
> +    uint64_t CSR_RVACFG;
> +    uint64_t CSR_TLBRENTRY;
> +    uint64_t CSR_MERRENTRY;
> +    /* Msg interrupt registers */
> +    uint64_t CSR_MSGIS[N_MSGIS];
> +
> +    /* Fields up to this point are cleared by a CPU reset */
> +    struct {} end_reset_fields;
> +
>       uint64_t CSR_ERA;
>       uint64_t CSR_BADV;
>       uint64_t CSR_BADI;
> -    uint64_t CSR_EENTRY;
>       uint64_t CSR_TLBIDX;
>       uint64_t CSR_TLBEHI;
>       uint64_t CSR_TLBELO0;
>       uint64_t CSR_TLBELO1;
>       uint64_t CSR_ASID;
> -    uint64_t CSR_PGDL;
> -    uint64_t CSR_PGDH;
>       uint64_t CSR_PGD;
>       uint64_t CSR_PWCL;
> -    uint64_t CSR_PWCH;
>       uint64_t CSR_STLBPS;
> -    uint64_t CSR_RVACFG;
>       uint64_t CSR_CPUID;
>       uint64_t CSR_PRCFG1;
>       uint64_t CSR_PRCFG2;
> @@ -354,7 +362,6 @@ typedef struct CPUSysState {
>       uint64_t CSR_LLBCTL;
>       uint64_t CSR_IMPCTL1;
>       uint64_t CSR_IMPCTL2;
> -    uint64_t CSR_TLBRENTRY;
>       uint64_t CSR_TLBRBADV;
>       uint64_t CSR_TLBRERA;
>       uint64_t CSR_TLBRSAVE;
> @@ -365,7 +372,6 @@ typedef struct CPUSysState {
>       uint64_t CSR_MERRCTL;
>       uint64_t CSR_MERRINFO1;
>       uint64_t CSR_MERRINFO2;
> -    uint64_t CSR_MERRENTRY;
>       uint64_t CSR_MERRERA;
>       uint64_t CSR_MERRSAVE;
>       uint64_t CSR_CTAG;
> @@ -375,8 +381,6 @@ typedef struct CPUSysState {
>       uint64_t CSR_DBG;
>       uint64_t CSR_DERA;
>       uint64_t CSR_DSAVE;
> -    /* Msg interrupt registers */
> -    uint64_t CSR_MSGIS[N_MSGIS];
>       uint64_t CSR_MSGIR;
>       uint64_t CSR_MSGIE;
>   } CPUSysState;


