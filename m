Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF406CD3427
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 09:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNMY-0007cX-Av; Mon, 11 May 2026 05:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMNL5-0006hA-QK
 for qemu-devel@nongnu.org; Mon, 11 May 2026 05:54:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMNL2-0004py-KR
 for qemu-devel@nongnu.org; Mon, 11 May 2026 05:54:14 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B9TXap018395
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 09:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yXDqI7zBKCEC6wm4cZnF77dfAcw0mkE3J4dFXgYY7Kc=; b=eV3RmHBxwUVqizBq
 StmQoly5UOX6ojdPk+i/i5sxs55EXDrzfZ+iXNScOfTabtxMzH78aCSyILI0EkNL
 UMoXhJpx1gpczbYtD88XgxQO2+d5FmheGo5c/T+ReEmW4TrMkqIZjPS4L2Bfxsfh
 lTK7Innhhm2PubWW5sokJmY+VbKfToimgZmMweqvhnHdDByMBiZiEE8DjppZyOqa
 sjYkbKgl9QVq4nmp1tgFwBBw/KZlO9RMCDP8ZqOQRciND9VEAeOc55yY4sA4+d7v
 g8nhC9Gnv3aCj0iTrqEo1I1sNDLJvUeuqjR7i3uODwoXZEOl4rAIbWb/TYBhhGBv
 eHdZpQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e37xfs5sk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 09:54:11 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8acafc224a8so97066066d6.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 02:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778493251; x=1779098051; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yXDqI7zBKCEC6wm4cZnF77dfAcw0mkE3J4dFXgYY7Kc=;
 b=DiIHD50Wrohk6mJUAM9wbeYEDlJAa3vAuinp8me0hps8qoGOm4YpER+i16zB5FgFAn
 PF7W8kVV/oguJdUiJ4wH+//smbvOzFRUT+UinsHl7CckRSkH+5PrJG/rX1PjI4uFwJHU
 ER0idUkKMEekRenZVK8ELJHHsLRWyDxzCGJLA9GATFtIDOZ6N+ilWPtno8i+HzwQb1vA
 9ZBC0UM5nAR/QC/LOFXTEyFvqMIASFoTpvTwj4Bml7iBkvHnnYrijlo49V7vD0FGQCIQ
 YXkHJry55aAaQvBXOTK7HwavLDL2DlTNCzqputIjQtxNaxZfgzIRlOGNW3yBgtC+2aWX
 3LVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778493251; x=1779098051;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yXDqI7zBKCEC6wm4cZnF77dfAcw0mkE3J4dFXgYY7Kc=;
 b=O/hNjEZ+pDv4rr3XGPb6EqRcSZA6gv56vX9g1dt9kxzCTQIBbkEUczgIudZBTw3DOa
 mI2Mw8jCK2iFOQPKPvFefCTh3BkgoRnKVTaim1vkyGIRR55dpRefCbjlPRuCmw9uWdWT
 wbKsx9YYQhsAoPUWQNDeo6Kmp++8ra4o4PYN8GntwkCr/QC/zE3rVTZx33WFzR4UodAY
 r7XkJTNCKO1SQLLAHAEj3SrvubnCIN7Gb/aF3Sin1bbMblbiWMB/2dfu1nJ4ZQmqNU/k
 1dp4ibqu+evCBOrTHCSMGf1mo94OVqZ4GbVxaNIIO9bJ1jM1+SgjwG1k7Kaxc09Wuqhg
 Xp4g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ecF2D4XBgO6Oq0h/X/cpjGfr7qz7XQj5v/U5n8hA9Is5p33I5+BnmVA16jyQc6uWA9tk9jWWYpWB8@nongnu.org
X-Gm-Message-State: AOJu0YzH8YZdYZwlz6PPScFW90HPdRXvdbuFujQgFPHzhOldhM3BHgxa
 UNI7Lu1R/kBRTbFE/KKWv+wkVacbuVAAhLRtyL3BwX5422OUlxErQo8V4RIZiHvjqFWkE6pmW/I
 Y+ffGytPCG/nX4SCVMZ3gymTeMrPmZOaq25iSvO8V36KYgcN2hTAP3U0+Zg==
X-Gm-Gg: Acq92OFJ617LYvnFk/cAxAWCCF6wIan9PW4FDofgyb/gwDjnApLj5qQGa75JuQxXm2z
 CkrdzME8dBWtqKtIDwvX/eKuU9cU5ZeQHi0Vz/BNfLlu7a4vSo1vRksRyz2HJV1S8lQxzU6AU3K
 ND2UkYWjMw6N38eLy0UPNsEo4DTbN75WKsyVl1x56BW9Zw7WuWZ6GOOTgTMgtUumAP+86rIGrKV
 gBCNM7cJ8eoQk0CvvhNqumkE2VFYYDDMiIV5p//P1n6FewhNIW0JuWp/ddoZBcwcvVGwz4EaPrZ
 t8S15Im8hDibIW+FXouJ7EejqlhEVJQFsZWuUgQLJ+k+8sj2ArMHr31QAOOum7P1NK942Cb182F
 Qzdy7HmxVIFkGstZorbT3lEsLE9iZVxGA/N6aVBYwldl+uBAKogopLyF4vj7wzeVsKiZ6Qw==
X-Received: by 2002:a05:6214:2301:b0:8ac:a3fe:b94f with SMTP id
 6a1803df08f44-8bf442b79e8mr185681026d6.44.1778493250703; 
 Mon, 11 May 2026 02:54:10 -0700 (PDT)
X-Received: by 2002:a05:6214:2301:b0:8ac:a3fe:b94f with SMTP id
 6a1803df08f44-8bf442b79e8mr185680796d6.44.1778493250293; 
 Mon, 11 May 2026 02:54:10 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf3a33fab4sm89264526d6.23.2026.05.11.02.54.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 02:54:09 -0700 (PDT)
Message-ID: <7dc52ffd-97e3-4c41-8cde-e79dd4bd2485@oss.qualcomm.com>
Date: Mon, 11 May 2026 06:54:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv/pmp: Fix integer overflow in TOR and NA4
 address computation
To: Zishun Yi <vulab@iscas.ac.cn>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20260511071347.3000476-1-vulab@iscas.ac.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260511071347.3000476-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TqXWQjXh c=1 sm=1 tr=0 ts=6a01a743 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=7WufM6Q2AAAA:20 a=cSz7ndj2-xvwmBH7_3AA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: j5Sbe_IIfENFCSvnkBIh6UlyymQhu2PE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDEwOCBTYWx0ZWRfX7iNSMVV6kQiM
 YKAatZGSHk/UI9ksYhiDFgZySbwEgOva66+OnTsZfb9mZ1rZKygYA9bCKkTiRZZmdN+CjytUoZg
 OPpsnmHwCqLgldCN8AZD+ydzmOCl4hUkIqyaqut4KlG46hndr4mNHselaYg2XVQP6GLfdZh5E86
 khAF96/fotQjsR/l5Ad1egBp+4lDdTp9nsBrH/CBmL8n8zAsFU9esfy06r8jNrqfsN12X/C0u0q
 kCX3SauUOOPG9f/vhcIuIpsWuGzGyJfpok3VU0AbLcUbhQevlEbpILbFEuVPAahyayoxyR/Rz8H
 xqoci/i6jccENhHzzTeiQkOqCb7VNSJoytZ+Ui4wCfD0BV9vFHFtU1WbA+AkLE9Ec3aNYXrKaXl
 Xzq5t+gH0YLl+L6Y/c0WKNj6A0LlMIuuk3mW04rsheHB6EN4z72qq1TMVLVYWfzm0HzgmSUY5X1
 YvgXBOBBMDcDc7UamHQ==
X-Proofpoint-ORIG-GUID: j5Sbe_IIfENFCSvnkBIh6UlyymQhu2PE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110108
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 5/11/2026 4:13 AM, Zishun Yi wrote:
> According to the RISC-V Privileged Manual: "The Sv32 page-based
> virtual-memory scheme described in sv32 supports 34-bit physical
> addresses for RV32, so the PMP scheme must support addresses wider than
> XLEN for RV32."
> 
> However, the current QEMU implementation uses `target_ulong` (which
> resolves to `uint32_t` on RV32) for PMP address variables.  When
> shifting these addresses left (e.g., `this_addr << 2`), an integer
> overflow occurs, truncating the high bits of the 34-bit physical
> address.
> 
> Fix this issue by casting the `target_ulong` variables to `hwaddr`
> before performing the left shift operation.
> 
> This issue was discovered and reported by SpecHunter, an AI-driven
> architecture specification analysis tool.
> 
> Link:https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-isa-manual/pr-2472/qemu.txt
> Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
> ---
>   target/riscv/pmp.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 5391caa59c7d..dfddafcbcb48 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -253,12 +253,12 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
>               sa = ea = 0u;
>               break;
>           }
> -        sa = prev_addr << 2; /* shift up from [xx:0] to [xx+2:2] */
> -        ea = (this_addr << 2) - 1u;
> +        sa = (hwaddr)prev_addr << 2; /* shift up from [xx:0] to [xx+2:2] */
> +        ea = ((hwaddr)this_addr << 2) - 1u;


Instead of casting 'hwaddr' I'd rather change both to 'hwaddr' type.  The
new type suits both variables, and in fact pmp_decode_napot() expects a
hwaddr:

pmp_decode_napot(this_addr, &sa, &ea);



Thanks,
Daniel


>           break;
>   
>       case PMP_AMATCH_NA4:
> -        sa = this_addr << 2; /* shift up from [xx:0] to [xx+2:2] */
> +        sa = (hwaddr)this_addr << 2; /* shift up from [xx:0] to [xx+2:2] */
>           ea = (sa + 4u) - 1u;
>           break;
>   


