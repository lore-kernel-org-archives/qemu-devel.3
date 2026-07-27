Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7C2C531FC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 06:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woFCL-0001Wt-2w; Mon, 27 Jul 2026 02:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woFCI-0001WD-F3
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 02:52:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woFCG-0002WT-Qw
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 02:52:22 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66R1g0vE1768552
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 06:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 P4AqPdOubjMGezsb+ZDGfsh6kbF9dVPJsDS7GTfQLeo=; b=HrumFTcr2Gf/2Jfe
 Rjk4jk57FjFCUAicuP4LxGOvgxmCHTkHCgurlwn0poxXP8mB0IvhI305aA50+1wC
 1t/0UXZ4DhGub3kvqEN+povMm5jkdP4LV9LYhHVoY1c01AUS+ISxkEfx3H5CqhIH
 ec+AxyoaNfTSXzq6nJCVtTj9K3Z20xh+buX6KA9ZOXMwHO4NlQif6WlWAr6svCqo
 GYf2gmGBP47whUdrlSG5qCq/Dza5A0kRXPXt5N10Q0c4NscuPjxLbPX3Wrpl2V1D
 SoAJncZtQMbBMcgES96HuYh9HVe8MnNoxj6fr/5+zC7Nx/0f+JH9A43lIii/ICiB
 ZablDQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmpajmnq8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 06:52:18 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c0199faafso29188561cf.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 23:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785135137; x=1785739937; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=P4AqPdOubjMGezsb+ZDGfsh6kbF9dVPJsDS7GTfQLeo=;
 b=HuGV7m8tO0F4WvrJVoMJ/SuLI1RF87zjpNQDgONfRpd6yIWeIaAe0MvJm6m9s6cJFk
 ZNii3iQrpMy//yxhix15g4kiRITUOheFgFVmVGI+/D9PH3VliOOMflRv8eP/bH6wpyMq
 3RMSxq8xRV/y+71b7O0nSkM7Vc2aaQq/UI3YywUfry0QmVuYQz+DAB8O0FLNb2VrgL2f
 IdEsShv6ausEFOxfskg3L8v4Emx/RRsZjDLVlXGPV2WDQv25DUDLik5XLkiLT3oSmKYL
 XvfUjTUK1sY/CFqYcbAWTqtOCegIf91oSgePoPuQeaKo/bSPjc7+7EQyzGiH07lYVaPb
 jBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785135137; x=1785739937;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P4AqPdOubjMGezsb+ZDGfsh6kbF9dVPJsDS7GTfQLeo=;
 b=s4AVXboz4+JUlXntZhbBgJ30xabsAsm2PorF01bfXpGNp0nHoL3r+JSXOz4FU5GmF9
 NptW6kpvC1jI/4ucouZT4AJO6HmxM0vRme6uu2UHLbtjX5R4By/R8nhnyOHCwm2Dpejo
 njEdYXjHd/A1lzMZ9IC5bEQOIAG54wHUfFxP40kRdL3wxFFJwY2WIjuFUBYWXzF/LLaN
 6bOZkQk+c2k/cCkKKC6pTben1ns0NP6F9QNCFtvj5+w6Rvkky1+hfp4PArTdkOPg+ghZ
 NHClnkb431nlVuLU6aaXe/cCL9GQDrazYuauLu4cv+UXWTBU/d58GDcOHiiCBmh89ZGm
 GvjQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqfqUNUMZGFBUtLfVDwXbOokfJw0zmeGPANrXxJovkxsq0t/mYJpoVlFZtaHeWBkvUJo/3EB/OAq/8e@nongnu.org
X-Gm-Message-State: AOJu0YwFz0deFQ56v1m+TfuQjQe684G/EUxo3Smddbd750y8oSWGE8Jt
 eOAqcL6kCUvHci23R45+AOqoUVRZMyIQzZrtLhFozLsLdg+OerlhSg4kb7vRY/E6qdEowObJLSV
 bvaEez6E2agfLthcZf9sfGpDi8fT2X80+ylVrAGWT230SNaP0GSyWtAjiOw==
X-Gm-Gg: AR+sD10zzADFZ2KwHsifcqoy/ufWzbyDAKhjmhAZThGKqOvoJYgLgv+/++xsvRcWQt5
 mgwAGmw+b2GXIYuiWWC4axt6kwLFiPnZT5xFldCPHdDEnBrBBg48drhAtBg80d3qLWtES/uL493
 C2HoSkjn043aF7rlOa5G7yDqkaMcdzi03DNwmuWQ9Et8GkxidzS1Np8CTGDv1o8MJg96bjbAZye
 76aa/fDLJ0r7ju2OmgBbMTlIqPizFwrJDx99zHyGoCZNHz9Har3glQZVleTjTvzfh0Tl3VZjmV0
 ydRHgHOGk7Z2nw9x2SfyQqnCUp85iqRl5lPxrOvQRJ4vKd/ll58FYm6U8AIDY9ynjmkfdymS1fk
 Y9c5+M9vehrNCer+UfyU2hW6VwRpw24fLHc5ieZfogr/BAr/wLbs=
X-Received: by 2002:ac8:5a09:0:b0:51a:8c97:937c with SMTP id
 d75a77b69052e-529a8713ddfmr72098661cf.68.1785135137111; 
 Sun, 26 Jul 2026 23:52:17 -0700 (PDT)
X-Received: by 2002:ac8:5a09:0:b0:51a:8c97:937c with SMTP id
 d75a77b69052e-529a8713ddfmr72098561cf.68.1785135136637; 
 Sun, 26 Jul 2026 23:52:16 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4866ddbsm231697825e9.7.2026.07.26.23.52.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jul 2026 23:52:16 -0700 (PDT)
Message-ID: <bb57f3db-eb96-4ced-aef3-3546055cad4d@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 08:52:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/arm/raspi4b: fix guest never seeing more than ~1
 GiB of RAM
Content-Language: en-US
To: Marcelo Manzo <marcelomanzo@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260726144112.56321-1-marcelomanzo@gmail.com>
 <20260726144112.56321-2-marcelomanzo@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260726144112.56321-2-marcelomanzo@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2bdcakR8maWVJf_yoWpf9SqkQOMqtzR7
X-Authority-Analysis: v=2.4 cv=A8Bc+aWG c=1 sm=1 tr=0 ts=6a670022 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=sMf9ggfI_TTS4PY1ofMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 2bdcakR8maWVJf_yoWpf9SqkQOMqtzR7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA2NiBTYWx0ZWRfX4T45egijxocD
 4sMN3v9ZmBp7+Z6jwf0dXnnylWv8/EpaAxruT08OFusBa4jyPgm5A2ZeXtV3dWuy1PGDXOHY/n5
 km/NgTT6tocgnPq2SLpLAg44Q9+oQ+3BpByhOM2WZv3HRJHFaT6k3oOEUH2rk+SqLNXafQ5TlcF
 YvPiZSRlGssdl7sN8f0i8TwGnanAf+iSeBZiOPVJ2fs29zlmbY9Y++g9p50Dcn3wLnWaINHLdfB
 ygMt10sNWd4Pd15GT3vFqXLP42nHUTiQmLmwXcLraOwoBjHifDLfNM4FMAzphWpO6+SA5bFG8Qg
 jxWGm3Tijq2cR6TjVUMNUpk5imKlwdfDNsazCzA2XIlEBE7SkM1rlEcmIwv4+ZTaF53qONN89sD
 92zFrlIoD/4G8TzQG58jSKXhCpoCAkz+gyrHtgpibETSE6fa9eTeDBmqQW1Def/1/iWaNHigdxS
 3EA8EfnLnY1txh+h6hQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA2NiBTYWx0ZWRfX7pMlO04hklYT
 3yy/m21lF+ppN6Pb5A7KSHN2D252smR1QJTWfsd0bq5tGU7vg6ZYNBH7TRQcg42IAGiUE5pItPA
 RjeCRK0l5IcK38EBO+q0JI6xiZ6MUyk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270066
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

Hi Marcelo,

On 26/7/26 16:41, Marcelo Manzo wrote:
> raspi4_modify_dtb() decides whether to add a second memory node above
> the 1 GiB peripheral hole by checking info->ram_size -- but that field
> is the boot loader's RAM budget for loading the kernel/initrd/dtb
> image, itself always capped to at most UPPER_RAM_BASE - vcram_size by
> raspi_base_machine_init(). Since that capped value can never exceed
> UPPER_RAM_BASE by construction, the condition was never true for any
> raspi4b configuration, and the second node was never added: the guest
> never saw more than ~1 GiB of its nominal RAM, regardless of the
> machine's actual size.
> 
> board_ram_size(info->board_id), computed one line above in the same
> function, is the value that was actually needed -- the board's real
> total RAM, not the boot loader's own budget for where it's allowed to
> place the kernel image.
> 
> Confirmed via direct measurement inside the guest ("free -h" /
> /proc/meminfo) on raspi4b's default 2 GiB configuration, before and
> after:
> 
>      before: MemTotal:  943524 kB (~921 MiB)
>      after:  MemTotal: 1905824 kB (~1861 MiB)
> 
> Also verified against two real, unmodified Raspberry Pi OS releases
> (Debian 11/Bullseye and Debian 13/Trixie): both now report ~1.8 GiB of
> usable RAM instead of ~900 MiB, with clean boots, working SSH, and no
> kernel errors on either.
> 
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
> ---
>   hw/arm/raspi4b.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
> index b92840e1b6..ca246ebb35 100644
> --- a/hw/arm/raspi4b.c
> +++ b/hw/arm/raspi4b.c
> @@ -64,7 +64,19 @@ static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
>   
>       ram_size = board_ram_size(info->board_id);
>   
> -    if (info->ram_size > UPPER_RAM_BASE) {
> +    /*
> +     * Bug: this used to compare info->ram_size (the boot-loader's RAM
> +     * budget for loading the kernel/initrd/dtb, itself capped to at most
> +     * UPPER_RAM_BASE - vcram_size by raspi_base_machine_init()) rather
> +     * than the board's actual total RAM computed just above. Since that
> +     * capped value can never exceed UPPER_RAM_BASE by construction, this
> +     * condition was never true for any raspi4b configuration -- the
> +     * second memory node was never added, and the guest never saw more
> +     * than ~1 GiB regardless of the machine's nominal RAM size. Confirmed
> +     * via direct measurement: default -m 2G returns ~916 MiB from
> +     * "free -h" inside the guest, not 2 GiB.
> +     */

No need to add this comment in the code, we already have the git
history. With the comment removed:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +    if (ram_size > UPPER_RAM_BASE) {
>           raspi_add_memory_node(fdt, UPPER_RAM_BASE, ram_size - UPPER_RAM_BASE);
>       }
>   }


