Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFEEC4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkM0e-0003Ru-6T; Thu, 16 Jul 2026 09:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkM0c-0003Ra-Vb
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 09:20:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkM0b-0004VA-53
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 09:20:14 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GDJdeu2946548
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 13:20:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 quGU/oli+WnqTpslmTOghalXx6uOih3oPXOtRW1dWb8=; b=MR5X1W/aIshj6DhZ
 cmnF14dR0Iw0RdKEvA9exT1TQACE2t8L6odJLS88rEuMzFckCaHrHsFdO/YdHHQm
 tLYXzGrKW+stBjFCcrlo+Za8AaYGHVYLiuSn8vogxU2Uq7di3+5O1NvmU4TOEW0x
 nbiivPz5sk3MJYd7LZMUkr3KkdV95olk8fS5g5qLTX3v6QrYXdeNw2jMJ0AcpsjE
 9nFtdNsSDkJFZ3OsLPr+BadWBjCxu5N3m9vaF/MdwBZhHU8bPfFcztC1Ogd+UER5
 G/i5qX6Rvnt14rFVmbT3DlPq+xMsdjaYAuumr12XTsyVkP/vTJIduCagGpw+cUim
 GQFFMg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fen4wak6f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 13:20:09 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e4f946461so1115547085a.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 06:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784208008; x=1784812808; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=quGU/oli+WnqTpslmTOghalXx6uOih3oPXOtRW1dWb8=;
 b=RRyKAnlPQEiemfGkDTxV4aLqYuMUahdEJKaKwehqPrDrFqa2qd31QdT9rqGTMw/W04
 WknmDsf1Ik98jCiCJzUjQFDbCxNICDEGHtTryTh24WfXBaDD1/Dj+3IOy4omVcqDyGo0
 sY5+MgLyPHBGJMyo+F7SJp9rWMyl0E4+Od1410XwOBU5zm7kxv+YRecEUqIrRA1G9RO1
 q9fXY0d6ZpoqsirRjTlI9y/w9DJdGHiXSBkzKeow5cxo3hMCj1ObePhkIxzaVo/4wHoH
 LnxePPqiv8V8h/W3N8fBEbl2huAMmBPR/Akps5u/uYKkYAy1zac8m7Dc9Q/DswtEDqgJ
 8nng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784208008; x=1784812808;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=quGU/oli+WnqTpslmTOghalXx6uOih3oPXOtRW1dWb8=;
 b=rOuT5IWfLPN74RvKv3D3si82uBvGo0hTMRkRkqUhc315uwk1e0WtZi0TURSGtNzicx
 FCETide3wI+0GCrVDmYF1DYBAZu51jZM36nqn0cNVrihqIc2S1DVOl8CwpIl1C+klX2f
 K2EgZH6lDc3R9jS9HeLXoynGUtkZXR8rVzY0gzDIQjo5d1N2XIAJL0MdbqePlOs9MKI8
 ljnJ29LR800AdoOlmRqJ5ZQHJXNlFuMKtsqlGXDAraFRpXCYeLHOmwznCOCZbiDtD52J
 VbSnM7lDz6rw1/oZYxLOT89UF0cPQ2GyQeuw0YMOxLTyJGMThQz8KbStn1L2H0rR9Gj5
 dH8g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rom1CEz7KtGWK9c3nR0NsT0GQjK31dggUh10pcgOV+nVpDKcPnBQwpVQEcigxig8PKIw1Ygp7zbK3yd@nongnu.org
X-Gm-Message-State: AOJu0Yzc+PF6mUONLZVLL5Yja07Y0AMjDsSlNLdZ8HQYLmYmuVuhVN0d
 PWmrNIOiGD8ugOxymq2kdVxINi6B3u9b4O3+JRXTVuO0JY6VZ8eWqLBrnoO/J6GUAyizyuByqfk
 jKYzaCuNqj2JjwhsooXrTmL7Bp55z7fhFK0clF3cBz9cMibWlDFkebcl1TQ==
X-Gm-Gg: AfdE7cmSQnI+Uv4kWzT0Da7fEn1YZ4Qj8ld15uwiw30yhcwJ6WM8RdYnjyT2EsxpEkx
 6cUtPA9DkJqJ4we7lEqP8m73SP9GTL0USf4X681bciil2vsLc59Q9umXwx03B+97V7qFSx2V0kz
 yMcdCVS5BAEMKp0utHNolLnRUXBFVEndjMhIzNn9UGXESNrSw5q2y3sPwT2PcGxNhnd3MU8TpMK
 iuph/mo8P+Olz59AoVx1fLNMvNtdpDhlP9StuCyqbcno4vbD0k/8TcDqwtTeVfpzjnhlhgjDQPP
 OhA3hUyLWdS2M4oLm7/kHedgf+smFKxAjX1axbAl0uCt/WPy1OvwT1DHbuCTfFBtGcQMX6ydkiJ
 nuCb3dBpOfNTJfvWWRViuBfKvvAgQUnRGAA==
X-Received: by 2002:a05:620a:81d:b0:92e:ee51:e9cf with SMTP id
 af79cd13be357-93083d41dbbmr1014073985a.61.1784208007889; 
 Thu, 16 Jul 2026 06:20:07 -0700 (PDT)
X-Received: by 2002:a05:620a:81d:b0:92e:ee51:e9cf with SMTP id
 af79cd13be357-93083d41dbbmr1014069685a.61.1784208007259; 
 Thu, 16 Jul 2026 06:20:07 -0700 (PDT)
Received: from [192.168.68.105] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92ee5d61fb9sm1911037285a.41.2026.07.16.06.20.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 06:20:06 -0700 (PDT)
Message-ID: <2090a46a-7936-470a-9624-06d873c4a9ff@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 10:20:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] disas/riscv.c: Correct disasm of lq
To: frederic.petrot@univ-grenoble-alpes.fr, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: julien.thillard@univ-grenoble-alpes.fr
References: <20260715190737.1381701-1-frederic.petrot@univ-grenoble-alpes.fr>
 <20260715190737.1381701-3-frederic.petrot@univ-grenoble-alpes.fr>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260715190737.1381701-3-frederic.petrot@univ-grenoble-alpes.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PsejqQM3 c=1 sm=1 tr=0 ts=6a58da89 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=xgo6v3CxWvHGKzMUA_0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: qnM8b0yxOdMMJDxVZpX7yIoUd1WGG_mS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEzNyBTYWx0ZWRfX/FSM8cnBYJsg
 p7l3+mc39FJ/HrqQgT9IslLSirZSZXXxAmnCxmy8w0Gm/+hc20ibJDm425/FKdjzJUmVrllKXGO
 A7V3PaA0IbcCKxNppOerunandGhCyec=
X-Proofpoint-ORIG-GUID: qnM8b0yxOdMMJDxVZpX7yIoUd1WGG_mS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEzNyBTYWx0ZWRfX/nN9sclChOcy
 lv32ZrS8ydzQ6HRQ73JdFCak84N2WIewBkAbGQG78IpnOlePcyd78XeSUp8ma/Ji8WCiABi9jPQ
 LyL4iZfYNMoSdY8eUru7CugYJiVX0gKNDsp25HFduv8aaEHvYgqxKOKvUxnt6Gka5MsZ+QZLnAA
 KRtXJ5Nj6lQiqTNOKjjrzMK1ag4GG0ofJGsCu7n0bDYAola9nzD052svinDqRpqZ6aHGMUcEzuR
 LAiSj1rWu0bAOGHTLnNXr5A6EeBr2uSsNq1ODB1LYZ5npKNuQbZXkyLCdrNxmiph6sjDK6vayWU
 2BGKRaNgdzixiOrT344hQ3ora2lKMf8v+PAkI8momqNnl0HpwwJSMYC9MsJhqKsLeNTLsoQ7CeA
 hzAK0o85Io5nBzU7yYS5D5C3uWAVCSeeuj1k4x6mqTO+tsexRPjiB3useyJsBR/SdoLD/QJ1DFl
 iFf9jsXXf2IDGYWIqQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160137
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 7/15/2026 4:07 PM, frederic.petrot@univ-grenoble-alpes.fr wrote:
> From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
> 
> Lq shares the cmo opcode space, but the cbos must have rd = 0.
> Now ensure that they are matched only in that case.
> This implies that lq can be recognized as such only when rd != 0.
> Update the decoder file accordingly.
> 

Fixes: 9273cda722 ("disas/riscv.c: add 'cbo' insns to disassembler")

> Reported-by: Julien Thillard <julien.thillard@univ-grenoble-alpes.fr>
> Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
> ---

This patch adds style issues that you're fixing with patch 3:

$ ./scripts/checkpatch.pl 0002-disas-riscv.c-Correct-disasm-of-lq.patch
ERROR: suspect code indent for conditional statements (15, 18)
#46: FILE: disas/riscv.c:2899:
+               if ((inst >> 7) & 0b11111) {
+                  op = rv_op_lq;

ERROR: trailing statements should be on next line
#50: FILE: disas/riscv.c:2903:
+                  case 0: op = rv_op_cbo_inval; break;

ERROR: trailing statements should be on next line
#51: FILE: disas/riscv.c:2904:
+                  case 1: op = rv_op_cbo_clean; break;

ERROR: trailing statements should be on next line
#52: FILE: disas/riscv.c:2905:
+                  case 2: op = rv_op_cbo_flush; break;

ERROR: trailing statements should be on next line
#53: FILE: disas/riscv.c:2906:
+                  case 4: op = rv_op_cbo_zero; break;

total: 5 errors, 0 warnings, 39 lines checked


What we want to do is to squash patch 3 into this patch to not have the style
issues being added in the first place.


Assuming patch 3 is squashed into this one:


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>



>   disas/riscv.c              | 19 ++++++++++---------
>   target/riscv/insn32.decode |  2 ++
>   2 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 490bda8e56..831ff526ad 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -2889,21 +2889,22 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
>               case 2:
>                  /*
>                   * 'lq' shares the "(...) 010 ..... 0001111" opcode space
> -                * with 'cbo' insns.
> +                * with 'cbo' insns, but assumes rd != 0.
>                   *
>                   * cbo_inval  0000000 00000 ..... 010 00000 0001111
>                   * cbo_clean  0000000 00001 ..... 010 00000 0001111
>                   * cbo_flush  0000000 00010 ..... 010 00000 0001111
>                   * cbo_zero   0000000 00100 ..... 010 00000 0001111
> -                *
> -                * Anything that doesn't match these will default to 'lq'.
>                   */
> -               switch (inst >> 20) {
> -               case 0: op = rv_op_cbo_inval; break;
> -               case 1: op = rv_op_cbo_clean; break;
> -               case 2: op = rv_op_cbo_flush; break;
> -               case 4: op = rv_op_cbo_zero; break;
> -               default: op = rv_op_lq; break;
> +               if ((inst >> 7) & 0b11111) {
> +                  op = rv_op_lq;
> +               } else {
> +                  switch (inst >> 20) {
> +                  case 0: op = rv_op_cbo_inval; break;
> +                  case 1: op = rv_op_cbo_clean; break;
> +                  case 2: op = rv_op_cbo_flush; break;
> +                  case 4: op = rv_op_cbo_zero; break;
> +                  }
>                  }
>               }
>               break;
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 21272fdb50..aa02dae3c9 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -216,6 +216,8 @@ ldu      ............   ..... 111 ..... 0000011 @i
>     ]
>   
>     # *** RVI128 lq ***
> +  # *** Catches an lq with rd = 0, which we disallow
> +  illegal  ------------   ----- 010 00000 0001111
>     lq       ............   ..... 010 ..... 0001111 @i
>   }
>   sq       ............   ..... 100 ..... 0100011 @s


