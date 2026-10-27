Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B834606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AdUzfnJz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XCHTLfjr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLjXp-0000Fz-Bj; Tue, 27 Oct 2026 11:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLjXc-0008SW-H8
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:56:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLjXa-0005fq-M8
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:56:48 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RFLQbn1522467
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 15:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nnH3rd33EgvTrJPxes51erQWm/HLzu8W4axE4qsk/Dk=; b=AdUzfnJzZTiX5uCU
 rQ7is+VNm406l1AtSrpSD5wki0pM7u1qPQkUJnwVw89H8tGJvVSUtKXcAN+r4B8a
 v2xhH9rzvGlEsnEMwnzXPemiwkjlqRO1uqWh1FQ2venae+dDObY8AKkrG+L3yAtM
 KoAioqMX3/zv2mMQUo65Ww1gx17ccPqraY5kKDWja/yNX9ZNFlYYcMHeDNIgdSAj
 /d8lW3Fpyypoy+Msl3NFuDWuJ37VzpdJsGHlaXV16HI0OGvpwTvfjuwnjAMKeqFc
 Uao65v/lVDWmAHn+MsiumYqIvEe6L1yiyp2/sXdMiQvKZDeSo4rOCOyAJcSq+Q1f
 QUmO5Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjux98x4m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 15:56:44 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f62934ef6so697344385a.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 08:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793116604; x=1793721404; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nnH3rd33EgvTrJPxes51erQWm/HLzu8W4axE4qsk/Dk=;
 b=XCHTLfjraZBKekh2exglaYJRxp/YEaSwEAcesK5q6nFbPI1ZQFzFeZwkKgj2D8p/l3
 e2UAN99En/2zSrObYvjSwIaqYD/abjUbuKPDIXK6tju5dPLXVCooGNQ6KCXntbdvmL1Q
 RU80aTlHAdqA4Fk4vSDGoxuL2vqdfVtSYON1nSBn5sBAAeNgSeGM9aC/wbdUIpasENkX
 DXvCSUp4K4RnPTlTYDSjvPxchT5mkiSVgJ1TmZEJ+sNwNwXRfrEKPG4hTfOX3w7xZiZe
 VmU0D0IpWBLfmbS8emJLpHkcOuPFnL5GPYjo09fe5Gp1WTIPci/qeAOXlYjrv6IAL+HM
 BErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793116604; x=1793721404;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nnH3rd33EgvTrJPxes51erQWm/HLzu8W4axE4qsk/Dk=;
 b=uR9rJiCtT+6pn/QmcdJVASPBu3A9QJL8FKhUgJu/pXu5wFmTvCgbf1hDY9J6ay+QFY
 2AEN/DL4Mk6d48ekGD+xXsdg0tSmDTUpjCkcVPGkEjg63Fb+RZO5HfSC8UcNBxhjJtxR
 sUZCeh2CwAFV5pbAVO1Oj2shaxioRK0vqJZNFJxjg0xznjCPqQY7RSxlNqdtFSWsHvkV
 +PKkuSF+H0VZdVb7HAt0Lh7qjCyWHKxHF1zXMWdTEg7qDwCp2crqUOd6KQ9WpkhdQx0U
 qB/eKvdn1b5ZAKsk8gvrpg+vKCYtDBddz2ia8UK4qcD0YxJnzTn/DXJFjJ2MC6ugYD5d
 Dcbg==
X-Forwarded-Encrypted: i=1;
 AKwUvBys+7Uo3Q/Mkrjv19t6PnrF+ew2inNzS1FR/yDQbJaImJ1tNFjpxNuS7W59jQ4Jjjxm6/DA95rw7T1z@nongnu.org
X-Gm-Message-State: AFq9FYJ+NV7DjTsRcYNJ3BvC7vIsxlFstK/yxW3k/7uaN1paOIHdGqvm
 tJISpn4TQZN5OSpMvtX2nbwlkn7sio6YDK3m2lHmDV5kcOVyNLmwL4xzIZPSg+kM3UH2sQ2AYd/
 IKpLrFBP69ANM9GIsFh2UvTTQer3in6yGj5Obas+B/uQYRJN8Ed1ithy4lw==
X-Gm-Gg: AYBFou2NtHs3u0VggQJFcy6f/yvIgQqPaLTiOaQjX0SyPHwO05UpuRHf0j+O+PV7E37
 9RrbJqTZD8oVnoSo6g6GD0IbcDWatBf7l1rOBqYNYDtyatmKmleZuU9G463bQb9558ub2ZmvCdF
 +py5e9tvGxGvbEedmwwWv7ThB1efKIn6T389NXPhfMwpv8YkUOjpy2URi971CWKaPQhVb1Im67p
 TrodQQ7Wg0VY4IP/0xIoPOKmyuuiFi8/S25KbmQ1OIonDB0wnd7E0ffNbUoRKd5GUgUCUtWf87c
 dEvCpN0xZMBSd8RY09NwCVi6KHoKrEp1ASUl89r3hPrjVLZvSYca3vd6tLOqqN8sz1Sl4aXmA8F
 Cnq6PVlXv5RTQFsYMpSqNPIOJe2Kt7LWyWBBQ/7FhBvz5zlrFyw==
X-Received: by 2002:a05:620a:801c:b0:93e:c12c:f13e with SMTP id
 af79cd13be357-940ef939986mr1598136285a.72.1793116604097; 
 Tue, 27 Oct 2026 08:56:44 -0700 (PDT)
X-Received: by 2002:a05:620a:801c:b0:93e:c12c:f13e with SMTP id
 af79cd13be357-940ef939986mr1598132685a.72.1793116603623; 
 Tue, 27 Oct 2026 08:56:43 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a00e1b0sm225996585e9.3.2026.10.27.08.56.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 08:56:42 -0700 (PDT)
Message-ID: <7ce4be83-3525-4990-b9e5-88b5b114adcb@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 16:56:42 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/25] target/mips: add Octeon CN73xx CPU model
Content-Language: en-US
To: "Kirill A. Korinsky" <kirill@korins.ky>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
References: <20261027104433.25720-1-kirill@korins.ky>
 <20261027104433.25720-6-kirill@korins.ky>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261027104433.25720-6-kirill@korins.ky>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GYyCDgXL c=1 sm=1 tr=0 ts=6ae0c9bc cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=lyEDu8jB8XPWSK_VkeEA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 3hTBgjiw43EvCTYMsUktwSg3K4Hyc7-5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MyBTYWx0ZWRfXx+Yz2S5426gV
 JbE4JO3ecbNc3trAo6ZZGnSibsSxWU69q9kN7H65xLr5a3WxGSh72lSfDSg9iteriCh3D+xAjIN
 Egc4r169MhWi9oipVVtykSL6YcUxD+t6ixT+VGqcuyERLj4tP3sIzacSesYRYF0g7fzfa9dF2wl
 e2MQlixMdtWaAKYgv+7VF8GbzLRe8HIvp/5xU5TiKWZyGLld5Qq2NQuFq2nCMcfS/ZyuEa+FjIa
 2cKgRyI3x+spue84fCXWWePu/8/mSOxp5HT4VydciS8wLNvIvHMIVsc3knoKjHHQDboJYJcrtj+
 fDbqVvPafia6i7vluVVJCmZH7zCPrt56TMez06IoKVu5qHdz/e838N7itPDtWd7+j0YrKWNaUwz
 I68eb12b5HGrJm7ydojkqACuo1mqZoH926SNSa3eOEIk/6sAKKjEzHcshdA5rMygQRb6o4ecsqm
 AqYNSd10KL/u35jA7KQ==
X-Proofpoint-GUID: 3hTBgjiw43EvCTYMsUktwSg3K4Hyc7-5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA2MyBTYWx0ZWRfXycGbsou6RbkH
 alwi+tpR3CgOxta576I+SzBEV4IutVQ02+TpXUyuvQVpCukVsnlNTftZ4a/pYCpuvnKpO4URZpU
 GsG6m6bnayRpL5mrn9GIACyodF126yM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270063
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 27/10/26 11:41, Kirill A. Korinsky wrote:
> Add a CN73xx CPU definition for the Octeon III machine. The PRId, FPU
> FIR, and L2 cache geometry come from EdgeRouter Infinity ER-8-XG data;
> the remaining CP0 fields come from a Juniper SRX300 CN70xx/CN71xx dump.

Why add the OcteonCN73XX and not a OcteonCN7[0,1]XX first?

> ---
>   target/mips/cpu-defs.c.inc | 42 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
> 
> diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
> index b2ddfa1e82..5afc589a20 100644
> --- a/target/mips/cpu-defs.c.inc
> +++ b/target/mips/cpu-defs.c.inc
> @@ -1023,6 +1023,48 @@ const mips_def_t mips_defs[] =
>           .insn_flags = CPU_MIPS64R2 | INSN_OCTEON,
>           .mmu_type = MMU_TYPE_R4000,
>       },
> +    {
> +        /*
> +         * Minimal Octeon CN73xx model for EBB7304 firmware. PRId, FPU FIR,
> +         * and L2 cache geometry match a Ubiquiti EdgeRouter Infinity
> +         * ER-8-XG; the remaining CP0 values are a placeholder Octeon III
> +         * model derived from a Juniper SRX300 CN70xx/CN71xx dump.
> +         */
> +        .name = "OcteonCN73XX",
> +        .CP0_PRid = 0x000D9702,
> +        .CP0_Config0 = MIPS_CONFIG0 | (0x1 << CP0C0_AR) | (0x2 << CP0C0_AT) |
> +                       (MMU_TYPE_R4000 << CP0C0_MT) | (1 << CP0C0_VI),
> +        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) |
> +                       (0x3F << CP0C1_MMU) |
> +                       (0 << CP0C1_IS) | (6 << CP0C1_IL) | (7 << CP0C1_IA) |
> +                       (0 << CP0C1_DS) | (0 << CP0C1_DL) | (7 << CP0C1_DA) |
> +                       (1 << CP0C1_C2) | (1 << CP0C1_PC) |
> +                       (1 << CP0C1_WR) | (1 << CP0C1_EP),
> +        .CP0_Config2 = MIPS_CONFIG2 | (5 << CP0C2_SS) | (6 << CP0C2_SL) |
> +                       (15 << CP0C2_SA),
> +        .CP0_Config3 = MIPS_CONFIG3 | (1U << CP0C3_M) |
> +                       (1 << CP0C3_BP) | (1 << CP0C3_BI) |
> +                       (1 << CP0C3_VZ) | (1 << CP0C3_ULRI) |

Mainstream QEMU does not implement VZ. Having the chip config is OK,
but we should at least clear that bit in mips_cpu_reset_hold().

> +                       (1 << CP0C3_RXI) | (1 << CP0C3_LPA),
> +        .CP0_Config4 = MIPS_CONFIG4 | (1U << CP0C4_M) |
> +                       (0x3c << CP0C4_KScrExist),
> +        .CP0_Config7 = 1 << CP0C7_WII,
> +        .CP0_LLAddr_rw_bitmask = 0,
> +        .CP0_LLAddr_shift = 4,
> +        .CP0_PageGrain = (1 << CP0PG_ELPA),
> +        .SYNCI_Step = 32,
> +        .CCRes = 1,
> +        .CP0_Status_rw_bitmask = 0x36F8FFFF,
> +        .CP1_fcr0 = (1 << FCR0_F64) | (1 << FCR0_L) | (1 << FCR0_W) |
> +                    (1 << FCR0_D) | (1 << FCR0_S) |
> +                    (0x97 << FCR0_PRID) | (0x0 << FCR0_REV),
> +        .CP1_fcr31 = 0,
> +        .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
> +        .SEGBITS = 42,
> +        .PABITS = 49,
> +        .insn_flags = CPU_MIPS64R2 | INSN_OCTEON,
> +        .mmu_type = MMU_TYPE_R4000,
> +    },
>   
>   #endif
>   };


