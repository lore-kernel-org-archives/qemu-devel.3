Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C738AC61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 05:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1d7g-0004rm-JB; Wed, 02 Sep 2026 01:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1d7e-0004rc-UL
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 01:02:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1d7d-000338-5w
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 01:02:54 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68251HWn3108359
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 05:02:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2lf+exKBOn+anAuEgT8YlQtDXXVLiZEtzIszTg2BXkg=; b=pLc7KmVdTEyhpLXC
 vdvqinKJXpKBjImbJ6JS7UBX+bgOe9DFHIQrY2/FY7jXc2tilqJrVNkIdtrrwYvR
 bvMCbkRhtUMcW3lAvlX5HMnAuKMsNaaBH/IqR9sjvwQvAjdUtVFr6zA7oiKrfcNF
 APOStfYf4gWNrMB9C5xztaxMaB5KElc/OjzqM4/mcivJ6ycNZ0yJw5Eu/2HsuQ+V
 eNYECN+HOFYT7/ktX0nS+WNUP7IX0JW+4IWVmuO449CehCaVwQL3sZP+RQ0a04/t
 jollf8PYhmvlP/jelKDvQgvqeOz56GxES4YQT/RkYX5WzOuynuxxhIe9WRZMzhjk
 PiKpcQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge1wpaqc8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 05:02:50 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-939062ecda9so109835085a.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 22:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788325370; x=1788930170; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2lf+exKBOn+anAuEgT8YlQtDXXVLiZEtzIszTg2BXkg=;
 b=d1Aftd0z3vmfKdSe/LrkoUcs8dfHS66AZm+Tm6Yidk4AlthXCgwOdxE6r3zQU73yw6
 zf8HSaZyfUco1oX/WixRRh6yd0VYmdCXghG49GNkIesXIXcm44oHJYMz3d7tfoLla7mh
 NH4duzRwMTt9CsaTR/0zEEIGP7+yPtluWck+zZbwCBVBm5dl0J38jKKvIMYZcVQ2+kLP
 1QxO3icyYr5YOHaiyXuF0ELP4BHWdIpmSa2YC0+ZGv7j0USZrjZAsQJroa7PRZ1mp/Qr
 TXx3QekP27XTI2+DrMdvtyuT5WrRniIpp5y6HdkiAYz8703OeXsNUyZ8Jwji0wt9KqxS
 BN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788325370; x=1788930170;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2lf+exKBOn+anAuEgT8YlQtDXXVLiZEtzIszTg2BXkg=;
 b=HC8/uqcYbknS2oQXymxGLYFdYO9sEaook7pwSEfOjAertVPdp1jc+5uUdCnDBlcO+X
 cGeVq0KZW5buGGZntGS9QHkMcpYVrVbCPY1q8rBfE/9q8jbe5ZhmDvOYNeFh0KxACqgq
 ODkNHSbLKHq2JEL4RacEeo1dclt26LFoUIJu8WBlJJ3M6FoobXQD7b0/YEbb6TqUwaVX
 VHc7bKOuDNVYA+VhFM2vBJ9jITSPr8fWbKyykX9H4z7ypoDLZBqUO46YNgHZXr1GGhbg
 t8g4onlejQK+PpLjzsUXzSBJbz1KZZwoVOTneGjyvZzl6Uq7hXcsYARCt+R1TXgcgcR3
 gzhg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrPS7Uc+bb47I9ueIM0m8YkyKsePkX6ZgWN1z9yOgj4NHODHdSsNZtiP67+JbGlJkqAstbDZbsYClUD@nongnu.org
X-Gm-Message-State: AFuF++mN8P9CCMt0OLY/KHrHe3l5Xq+Zn422OUjqUC9kENHoXeqZmB2C
 aJNShZvPSaVDhovwERr2Nvc9VTpUd6WFdA2IyN0tXu9BI0LyvELIa5Ns4EE7e0krlDXSzImH9Xi
 MaR0vojGxihOyzl1OHpgjWlXGI4gkD7La4sQF3cyqEQLLYVP9oo9Fq6qPew==
X-Gm-Gg: AR+sD10hztklw/Yh20mabOBfMsUUAKILdU2oNEY6Fys6qqfIRD53e1MyHtpgtEpCc6l
 IrgvWHBOrGMxYQq5fdhmleh/mKrhIZNyNFVRUK1YTZFq1gDdnmXBqM6pgmAIesvUQrdvzNWuEDY
 JtHL1aKjAzXhU+sEdCQiDO5ymPFEWab9u5/Kifpo7AhKyqMqFtHVqLE/E/CktfO36DfiUqeIVKx
 +PTNb71fx3jRGNyqYWekjLr6mtfRge+wdzbhxjz4rwEw4K0q1HJzJqyR2MRNVlHS6Kh3uvxRDvb
 fz/9RMGUn/wDqfDasmwe46uWIoeLNE5VrLhhFWM0ApN3fDB3NFSemwL3DH5kIVzPLEXDg6iAstx
 UipNBwiGjzjCG8k6ExZ5BWsBrLZaVK26ddA==
X-Received: by 2002:a05:620a:a190:20b0:939:27b1:66b4 with SMTP id
 af79cd13be357-93960c6c960mr207891685a.6.1788325369681; 
 Tue, 01 Sep 2026 22:02:49 -0700 (PDT)
X-Received: by 2002:a05:620a:a190:20b0:939:27b1:66b4 with SMTP id
 af79cd13be357-93960c6c960mr207888485a.6.1788325369227; 
 Tue, 01 Sep 2026 22:02:49 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce4780f0dsm35743035e9.12.2026.09.01.22.02.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 22:02:48 -0700 (PDT)
Message-ID: <9823f67f-bfc6-40e2-ba3e-cb02e53a4004@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 07:02:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hexagon: add OPEN/READ/CLOSE DIR semihosting
 operations
Content-Language: en-US
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com
References: <c186b1bbca79df01c96ffb1f21e1dadf83e01698.1788290677.git.matheus.bernardino@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <c186b1bbca79df01c96ffb1f21e1dadf83e01698.1788290677.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=F8JnsKhN c=1 sm=1 tr=0 ts=6a97adfa cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=FDxNVLuhD_PW-LiT_qQA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: JsDUPy5ImgxR-V2Z5qydHloeteZAyVw4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA0MyBTYWx0ZWRfX2dmKTERgCeei
 qDa0Duf67eu+Mfe2TBkc9ow7B/Nf45unhSNhrpTHhHeuniLeF+6BEY1j9tNWTr045jAxPdgNSwH
 6QZluJ71Z6nATko7PMcEc78Nby+R6q4=
X-Proofpoint-ORIG-GUID: JsDUPy5ImgxR-V2Z5qydHloeteZAyVw4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA0MyBTYWx0ZWRfX6tnU+oCaSl5e
 tc8wNJgTvNr2hg4pqLMVvHWGdy7iNQbyMuikEM+7Pou+J3zEeSvsEzpAeqOj6AzEkVuBxKruaEf
 IhHijxKpyF7FtIWi+r4icbspju6ebd+WS3A5yqwitBpqBqLo3WVpeX1OLHQ70Xro9Cea2K7AljS
 Hzo+S2Lzoa8PEfV/UtflOort/x22RF6DbOiqM3CRyQqmFxc3dmX92AsAv4i1MT2wB4bbHatUmIJ
 GWGJOiJsF4KD1wDN00MkYUURoWiaNflLhZHlbK768bsJ49JD65SLn5bHoDENF5amuiILanslQsJ
 MtgZBtGqf+/0+OU+aRh38lluVTX09iQdZ6PgHeFQSf2B1z5M8prANvBkfVewlAcP132hJQldiOX
 W4QZzs0hJDwlmGr6rP68v15iyJk9qyYlxI/iP+PNGmWeXjV2TvYFa8/A9wwT/v+yH2NfWGlcPJp
 ZFBQ6PcrQqosKNfktDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020043
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

Hi Matheus,

On 1/9/26 21:27, Matheus Tavares Bernardino wrote:
> Baremetal Hexagon programs use semihosting to enumerate host
> directories via OPENDIR, READDIR, and CLOSEDIR calls. The list of
> open directory handles are global to all CPUs, so that guest
> index values map back to host DIR pointers across calls.
> 
> Also add functional tests for the new semihosting ops.
> 
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
> 
> Note: based on https://lore.kernel.org/qemu-devel/cover.1787586642.git.matheus.bernardino@oss.qualcomm.com/
> The added test was verified on Ubuntu x86-64, Debian PowerPC
> (big-endian) and Windows.
> 
>   hw/hexagon/hexagon_dsp.c                  |  7 ++
>   hw/hexagon/virt.c                         |  7 ++
>   target/hexagon/cpu.h                      |  1 +
>   target/hexagon/hexswi.c                   | 83 +++++++++++++++++++++++
>   tests/functional/hexagon/test_systests.py |  9 +++
>   5 files changed, 107 insertions(+)
> 
> diff --git a/hw/hexagon/hexagon_dsp.c b/hw/hexagon/hexagon_dsp.c
> index 2198436a44..4c6aad886e 100644
> --- a/hw/hexagon/hexagon_dsp.c
> +++ b/hw/hexagon/hexagon_dsp.c
> @@ -141,6 +141,13 @@ static void hexagon_common_init(MachineState *machine, Rev_t rev,
>   
>       for (int i = 0; i < machine->smp.cpus; i++) {
>           hex_subsys_realize_cpu(hms, DEVICE(cpus[i]), (i == 0));
> +        CPUHexagonState *env = &cpus[i]->env;
> +        if (i == 0) {
> +            env->g_dir_list = g_malloc0(sizeof(GList *));
> +        } else {
> +            CPUHexagonState *env0 = cpu_env(qemu_get_cpu(0));
> +            env->g_dir_list = env0->g_dir_list;

                env->g_dir_list = &cpus[0]->env->g_dir_list;

> +        }
>       }
>   }


> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index c50fbb3f72..fd2cb96cd2 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -145,6 +145,7 @@ typedef struct CPUArchState {
>       uint32_t tlb_lock_count;
>       uint32_t k0_lock_count;
>       uint64_t t_cycle_count;
> +    GList **g_dir_list;

But I'd rather the QOM layout to be:

   struct HexagonClusterState {
       CPUClusterState parent_obj;

       struct {
           GList **g_dir_list;
       } semihosting;
   };

   struct HexagonCommonMachineState {
       MachineState parent_obj;

       MemoryRegion ram;
       MemoryRegion cfgtable_rom;
       MemoryRegion vtcm;
       HexagonClusterState cluster;
       ...
   };

Regards,

Phil.

