Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68794CD6E52
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 20:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTmf7-00045Q-9O; Sun, 31 May 2026 16:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wTmf1-000455-OF
 for qemu-devel@nongnu.org; Sun, 31 May 2026 16:21:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wTmf0-0007gB-05
 for qemu-devel@nongnu.org; Sun, 31 May 2026 16:21:27 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64UNe3go201403
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 20:21:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KjeqK4seL66sPDy6/0rSo5ZQXLF9mIMhDvhsnUDjZDE=; b=R4/agwmmCRbKmWjR
 mIkrXrPN39odZ3YxzFd79HAqCccftzoWU1kuFBQ0V10dYPIVqt4O/Ennc1As321i
 Q+2p/8bylTo3uJ5WHux5IOxJgc8IXk4aaW6U4CF+uTkLlBwrgSwr357IPQMORioE
 6c3Dp7fabV+GYDimXyNdMUnltK1dRiQJ3sxYy2CoF0m5slKFpCFTJmiy4DdOPAki
 as3EoHdmGOa1EWCvEtWqgWzWeZs+8DbKrQru3Ftz24jajbMN/UTvYKpMpJGpFx63
 2KIU1Ah09/hwuju+l3KNnN7EBXoxx2JA+/zZQEVd6YpiulXe7nzjIBtwLV9do1VI
 p6C37A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efq7fcka4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 20:21:23 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ccdfe1ff26so39740016d6.1
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 13:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780258883; x=1780863683; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KjeqK4seL66sPDy6/0rSo5ZQXLF9mIMhDvhsnUDjZDE=;
 b=cn2y5EAQZVu9GBhUjBGJlQI4/5lCyXU/PSDw3eQNbjL5ulZS36TU0tbyk4DyURY+3I
 9ghpiTuOvSvDAnpj0W7+GN2CD/2O567SgvFQVuclXrrMdOQqK4GRBsl/Xye5WRR/vlEb
 nXdIUlVxlQo9OinJf3YY++Sm3Svctpbv/G4TDpulxdzEsbdqGh4L7dP1Tl2xQmmUptOw
 FRNA6mlBCCpcGRYjKgOKzW9ArAGnu95dRtHLwMV/IqoSw87SjQqgXXhZupjNQBqXj5MR
 Yta6D6kst8C5PIXqtNo75xVrKlv7CHljApyGQ0iDCrGGEcGBfxLW1m6sITdKIxBv79gG
 Romg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780258883; x=1780863683;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KjeqK4seL66sPDy6/0rSo5ZQXLF9mIMhDvhsnUDjZDE=;
 b=cPrgCbm2o4J2qYVnEyGye8CyTi01uhW9s7bQMFga/scckgd2iyxyjqB6fkH4CPLGnG
 VtyoCHYXTlTmhCe4TzHtrWe9Jxy5by7OARm50WauJn5qiKlPdFIdvd1K6nLwqXdfc6Wo
 eF87ojR7apmuAUXjSGufd7uFKrREasoHrCg5PUXCD8SwJSH3+Eo/1Bfsb5dPKscVg3Gg
 98NQlbpmSJ3eGSklRIPIxjbTfRUxU+tsi6cImCAoCtlCc9isacxsocGvTyxuTP7UE8+j
 WdO28XzneT8ZM73c2Wjdx6Ao7T4GEJS8/fRsmun1CWH0U+eONojf9y6deYabHt5D6TVt
 dZzQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+S7d/+dLIMJFAis5i/4tzISABeoesr7qPeDTUJ2yiz3bh9o03z++VXgqFJCIkrTqaoAEANz1/uGu7H@nongnu.org
X-Gm-Message-State: AOJu0YwcLPVsVNNs5oC6EWkQGUtR0vGEOo8O5OleRAyjB2YuTfZVeBUK
 c22yYpdPKggd4c6SLJ80MRIYijTW5NG372iZx1d9UPVHje/MsbNN+DH1KxsLNKRuoUPMYKWm19f
 24Ynco/sgkpI9GVUusOMwaxlGKmNTrNuoqWnKJNhSdkeE/qC79F3lHxfmdg==
X-Gm-Gg: Acq92OFSDst6kXoD7ZS17E0p/tAKOSaecQZST4SyEHtZbAq3l1QuG3/KdtJgG4552D7
 J6Z71JTZ2Bvu/7pM07Jfr9Sbhq0r2Hln6qXJi+MIkF66N9TUaQj6UrCv2DhKsFHVSvBxlS311Fz
 RjSuLB5la1mDjL7HPRNZB8AYPWX5xLSwRl5cG7NY8JjqSKXVoh2OBU/ZsI59v6D6ynm898/dTEr
 0XhBPfG+/XcTZMe8h2VcIIi1wZbjMktWC9dIbkaVWDd1O06g2dPGJcv7IogUqbS5cn1CQKK2nVQ
 ULxjoVUdfeZtCOwKpGi75BP0Y6IIhPvhoiP8m5Skwu51MSDGJASBRuIZP7gkMhoDq+/6r5qGliZ
 9yPYcLNcHSXja+IWyHLVIs5gsIVlQyp8PZ/raHDwRhcBVG32i0rZtHDLJnFTSR27xMg9u
X-Received: by 2002:a05:6214:419f:b0:8cc:f882:2564 with SMTP id
 6a1803df08f44-8ccf8822883mr99000646d6.40.1780258883037; 
 Sun, 31 May 2026 13:21:23 -0700 (PDT)
X-Received: by 2002:a05:6214:419f:b0:8cc:f882:2564 with SMTP id
 6a1803df08f44-8ccf8822883mr99000346d6.40.1780258882667; 
 Sun, 31 May 2026 13:21:22 -0700 (PDT)
Received: from [192.168.68.106] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ccea042bb5sm75710756d6.8.2026.05.31.13.21.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 13:21:22 -0700 (PDT)
Message-ID: <e9481765-c3dd-4ce5-87a3-a35736c5444c@oss.qualcomm.com>
Date: Sun, 31 May 2026 17:21:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: fix invalid sstc predicate in gdbstub
To: Abhigyan Kumar <314abh@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260530053200.902591-1-314abh@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260530053200.902591-1-314abh@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: UlY_cejgCQ2nNFWeXOZTl658xm5_zXIv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMxMDIyMSBTYWx0ZWRfX9oMTKqf5rtz1
 PuUiwqdKmqpWvQyXDfoe7x95lAaWCpskd9sXpW25wBxIKEGTMtE4DpXlHlrRf8gnc+KpZtBfQE1
 n7wXh/Uv9WwlL8iZp/bh9Na0mIGaH+cZJjjnfhVTy4XGdRQKrpmKB5GvfQ6gC1XGrT9VL/g3rFO
 Ir0T8VG3RQIAZUCsoERoL6kyOuypAZ/pPGIB5iO9C1TCKRNaqlMNj0IKtAaSM2JlaOcPDVDGQoP
 9KBJZXVV8t0BR93OINIvXpKenrQ5UYA1nhf4tzPoexfndRfIPwwcgfixzsemyaRZpHcqauWwwLg
 wrlym8/mtxI27Oe8oyZhK7iscLkz2IhIduL7UKFJBC/stJJwA1/+A3QpjTHKEZ+ZWrjPvtkka+c
 7XKjJVOCq1NU23wInvT0ZMq0TcPdb+YKr3CxIhhisMJPB7JMLnuGsLpUbZrFCxO/EDZ/Amycobp
 lHJ87XF1HXp156na8WA==
X-Proofpoint-GUID: UlY_cejgCQ2nNFWeXOZTl658xm5_zXIv
X-Authority-Analysis: v=2.4 cv=XqzK/1F9 c=1 sm=1 tr=0 ts=6a1c9843 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=wd-fH7nAH_oVZBzBhrcA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-31_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605310221
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



On 5/30/2026 2:32 AM, Abhigyan Kumar wrote:
> sstc function incorrectly checks for avaibility of env->rdtime_fn.
> This causes it to fail each time it's called because rdtime_fn is setup
> later in the procedure (when timer devices are created). This prevents
> stimecmp's addition to gdb.
> 
> This change ensures only the riscv_cpu_cfg(env) check is done. rdtime_fn
> will always be NULL otherwise and fail.

I am not sure we can do that - there are several boards that don't create
the timer that implements rdtime_fn (e.g. spike).  If we just remove the
check we'll break the sstc check for them.

I suggest using the 'env->debugger' flag to skip the rdtimer check if
we're running the gdbstub:

$ git diff
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5514e0f455..63f4795ac7 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -590,7 +590,8 @@ static RISCVException sstc(CPURISCVState *env, int csrno)
  {
      bool hmode_check = false;

-    if (!riscv_cpu_cfg(env)->ext_sstc || !env->rdtime_fn) {
+    if (!riscv_cpu_cfg(env)->ext_sstc
+        || (!env->debugger && !env->rdtime_fn)) {
          return RISCV_EXCP_ILLEGAL_INST;
      }

Testing with gitlab 3496 this seems to work:


$ riscv64-unknown-elf-gdb
(gdb) target extended-remote :1234
(gdb)  p $stimecmp
$1 = 0
(gdb)


Thanks,
Daniel

> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3496
> Signed-off-by: Abhigyan Kumar <314abh@gmail.com>
> ---
>   target/riscv/csr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index f5b0895fd..d72df945f 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -590,7 +590,7 @@ static RISCVException sstc(CPURISCVState *env, int csrno)
>   {
>       bool hmode_check = false;
>   
> -    if (!riscv_cpu_cfg(env)->ext_sstc || !env->rdtime_fn) {
> +    if (!riscv_cpu_cfg(env)->ext_sstc) {
>           return RISCV_EXCP_ILLEGAL_INST;
>       }
>   


