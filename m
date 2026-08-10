Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7F2C5AD5A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 02:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtFti-00069V-6I; Sun, 09 Aug 2026 22:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtFtc-000693-7q
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 22:37:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtFta-0002h6-T5
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 22:37:47 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 679LCaE94102320
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 02:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bAaU9A5Dob+pn+N5J3J972yFuLm2QmofQmJPQlMw98I=; b=i5JnKiEbO7rfVEIO
 oMCZJ07dmmh4ZVDLWSy2wFwmmlfLOTRmWrQ+fcVoYGOdRz+osf9QEeEM2Dcg+lDV
 1pTmYDKG0BWOOqKZXTUSlmHKc0lo+WfHCCkDtYZnEkhdho4/WfGCYYFTFkuWI42V
 36nojLbFqlCEz5Ih4x1k7snqPicIBRdWvJzUuPXXV4JuCuQWn3oBP68o1kqX9LQq
 7SD/WRSicMfsqGmGq509qoOrTYXROBpP3LZw70Km8yRaNUkJE+HbRNJd7D7sPYuM
 XMREAV4tAzvimAB2YudG5TDWhoDTKAoTBPI2VnjPQDFlpcwtkIwVrqsFDFDUFwKY
 R8YoZw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy18xrh26-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 02:37:45 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93494cce712so141637085a.3
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 19:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786329460; x=1786934260; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bAaU9A5Dob+pn+N5J3J972yFuLm2QmofQmJPQlMw98I=;
 b=XUfTschePG/9bo4OndK69UOMgwH01eSgSWveYsUtxSbrvoDsSWHTxrisR57TKtgDJH
 mXw7G4paV1srz+PBuhCBfLkPSxy9ksQWRZOopBF8pEEAGNmyqNc8AZ/ok8tg+xIgPFQg
 Ut3tP2W3keb9PHIt537AOmtJ351ZHUIzwUaHgOUWMcyfpdehzbsPNiVQUvX0rc+r6KTA
 A77c9Gux66bhJll5ucCB+fd+l188O43hr7gIvyLLQQBhYJ5ZMd+ke1h7/HNFS+88Z1Kv
 hYZUJcb0RX/XajBCpAw8nvK+5WyVu5Ai2xUGgYUo3ppNwQo6wwnL37Ql9Bdj5CanNHsL
 Tjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786329460; x=1786934260;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bAaU9A5Dob+pn+N5J3J972yFuLm2QmofQmJPQlMw98I=;
 b=jXc3A+uOKlkqWPwqG3rUAYb45gtzkm9C8jur55T/2pExewfAXh/tMfBQnYHCKNR04N
 HusoeznkmfPDKWK5QJACfea7+SNnEa9NWfnU6wdyFb09nRzVpPDUMsAjDjqTzaStDK0t
 xMilLJ1yRB13NLNtZ2MiOXFTjnIVwxGuvlyIoMm94knkxClLa5QwZcY/yZkS1SggzyF2
 2rbTkdMCzw2b/Q8Wb7jpJZzrE6QyfIdTXc1NtW+6cH11SOO9iXNvMOndRM+daGEZ6A4i
 eYPMw+p/skixGg4K9/9tJ2+E092FhPhjT9a2BuRDkh/kcY5K1x7Ej1wb2bmcH6EF5yE0
 Qf2Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RokCLOLptXRz7KwXOl3FNVW+B8Qoi5F9SykiNpRyN8WcZ2mqoMM7fUMfUG/P7Y8u0tLH7FzUTDsSga2@nongnu.org
X-Gm-Message-State: AOJu0Yy4dXQZuHDYuuT95W/+X1WveDs15tL8Ivgt7m8TqqyOdWwieqhx
 i7317j6Gc0kt6ouHQyTX25KF3JDAZTFY4h36j3a44xCzUkC30EZOkELmxCXzV6K4P3+nIATCESv
 C5o7dTvJV32205j4ZVpzWuIVZlqRI9BncFkUjVKRSBfsmHHku7y3y7ngQmA==
X-Gm-Gg: AR+sD12QbrBDFc5wdVeWUqJgdCZDhbfjRFX783DHiuRQa1PTzwP7u7tEhShB+YoeWWR
 kZoiQ2Sz/1fWC9ucu+4ywg3YPcP1sHl3B0zykYK9/UTBSkW39f1vQFVa9JgJMeMNWO9ltxWZI3+
 pZ7TuXrNPjMjMDax08sAUX4ZnJnCJd+9xW0okfRJvFfApgZ1r6yq9RJ3mIk4KOKYmshZTZKWSwl
 qQsaEMnW9brJ+EvRKzN/tvpSi1fY5Ifl5usFs8W6ztl989Wdc9vBOAiqm4g9Lxplf2y2F2r2q2z
 3eLLqBn7KKCiC8kelGHax799cfOqhdT4ABQwtQqK+If28SUgptSnQHKQNxKPB9A+WtDmz/4Kh+R
 JcBT6e0WHpZgxkUBbyIN44RXc5b3AcM/wMZg=
X-Received: by 2002:a05:622a:5905:b0:517:7e26:36a9 with SMTP id
 d75a77b69052e-52ce62036d0mr472184071cf.39.1786329460271; 
 Sun, 09 Aug 2026 19:37:40 -0700 (PDT)
X-Received: by 2002:a05:622a:5905:b0:517:7e26:36a9 with SMTP id
 d75a77b69052e-52ce62036d0mr472183871cf.39.1786329459871; 
 Sun, 09 Aug 2026 19:37:39 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4800220aa83sm25238954f8f.36.2026.08.09.19.37.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Aug 2026 19:37:39 -0700 (PDT)
Message-ID: <380deb38-062a-4208-b8e1-aca8b1e3b19e@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 04:37:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] target/sh4: Enable disassembly via capstone
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: 17746591750@163.com, laurent@vivier.eu, philmd@mailo.com,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
References: <20260809013343.664966-1-richard.henderson@linaro.org>
 <20260809013343.664966-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260809013343.664966-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDAyMSBTYWx0ZWRfX37YDuxOXwaD+
 PxJ0Pl/JP9H+Gn2bfRu64GXreB0y4OQHa1y+qrTTi9z554Lv3NbmzFQPYOh1WEzW2GDRcCBlBT0
 h7D8GJsCiJma+DiVMfUtEW14jwT2Qb0=
X-Proofpoint-ORIG-GUID: IvZvdwgwCp1bmzkuu_4pxolf47TmQx6F
X-Proofpoint-GUID: IvZvdwgwCp1bmzkuu_4pxolf47TmQx6F
X-Authority-Analysis: v=2.4 cv=bfZbluPB c=1 sm=1 tr=0 ts=6a793979 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=5i7MnQJ1OzotH2LNuDwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDAyMSBTYWx0ZWRfX33OWtVA/Q8kY
 kuuYfkeFXfoILZY4ikDDZNkmyBoHkIeWTbMtwd8cY4u2mOd03L/G57hxnsD4KxyT0Ux4wqeCAy+
 gBNHEF7X0MuIKtVE17xMf+scueXR2lUlcVTkmR0lujk3bxbaij0/td/QXncZP1iS7WoxYJNXusT
 ctmcNHJGs8/dVCZopmDp/NUDJ8KhajsT+oz9RYUkXIld7Rk0yr5Q7IruDnyUPhGYuXO95Zv+nwb
 1ZQ/vBJy12da6CNNnV5jkCiq0uB0/1r1weB4rMyvlr0DkZdpRnsmlwcqMRm8pl2c3kSJzeeEY4t
 Jly+BZ2Oaz0aReiu1dtSZgUyeiADuxBT5rq0Hd6sydeE1c1+ODkcR9Xls93a7KR+TQxtNH0zJ6F
 ZIsevo/VPaAl/3XZjsmYACahrlnwLilfwRuOCDKKpvz/hHm6ZFfj6rDpE5emoRcS/SHZy7rPJ9A
 bIEdsQDy5GCX/AwFkJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100021
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 9/8/26 03:33, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/disas/capstone.h |  7 +++++++
>   target/sh4/cpu.c         | 14 ++++++++++++++
>   2 files changed, 21 insertions(+)


> @@ -167,10 +168,23 @@ static void superh_cpu_reset_hold(Object *obj, ResetType type)
>   static void superh_cpu_disas_set_info(const CPUState *cpu,
>                                         disassemble_info *info)
>   {
> +    const CPUSH4State *env = cpu_env((CPUState *)cpu);
> +
>       info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_BIG
>                                        : BFD_ENDIAN_LITTLE;
>       info->mach = bfd_mach_sh4;
>       info->print_insn = print_insn_sh;
> +
> +    info->cap_arch = CS_ARCH_SH;
> +    info->cap_insn_unit = 2;
> +    info->cap_insn_split = 2;
> +    /*
> +     * Possible capstone bug: the isa levels are not additive:
> +     * least significant bit wins, so SH4 overrides SH4A.
> +     * Work around by settiing one or the other but not both.

"setting"

> +     */
> +    info->cap_mode = CS_MODE_SHFPU
> +        | (env->features & SH_FEATURE_SH4A ? CS_MODE_SH4A : CS_MODE_SH4);
>   }

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


