Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B957CC6B0F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 06:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGWSA-0000Vv-8e; Tue, 13 Oct 2026 02:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGWS9-0000Vh-Di
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 02:57:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGWS7-0005sZ-L9
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 02:57:37 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D20cND922844
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 06:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9GdmlAg+r0KBNbesZT5lUmE9s7Gfh3qJj15TaW/3QHM=; b=nVrxRbPNFesXQXte
 z9L5/buQ8gCsPjsFkaFjTfuFG3jkRJtt7fdbqZdpYrLkfvnYeWHEEkWHVrzv2zZv
 0jnESq7oV8s4WsyrHgjAAJcZgXQIyaysSpdabsSCfcArMaGypraJutNOItiH6qFb
 FU89NpJ1cx/CXX18cjAdNWyCp9FkU+sVQmx4iKISoexNcGWVkWrZvsKf24DTzXis
 bzY3YhM/v6aYGMFHCY4hHbQJtQs4Wv5RXEYHKkw6X2MwxKIaeEfA/YSDveIhx7Dy
 bkn2hMdNCnftdn5xpdOmwbR7m12ISicMQnIfW/4emiiZPpGKHbQ2Inz5UNwt+E8X
 JLFfgw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98h1sjjj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 06:57:32 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cbf2fd504so462726585a.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 23:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791874651; x=1792479451; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9GdmlAg+r0KBNbesZT5lUmE9s7Gfh3qJj15TaW/3QHM=;
 b=CxakIhrk8Z9yiVXS3ij7UrMlxV78K5nswMZpE8hpXzh1s5NWdI1fJbGL46x/06MGLs
 /uQ1luefTmjztzLwwz9I9DjQxBKZr1b400JLS30K9DanDMjyNlz+Og5LyPlJoQavEy5m
 mQ+7UEdJIesH4HK2ptX+0YtcRrNBNZ9/Z3n9phVqYfaszYR8gIuMIpq8+d3Tdhxerj5W
 EjkajhEYffZtcArxWN+qEzYt4xpdBS5DpoAobMAc9w2aCUSAZN1JPNLlgHIZjSy1Am/W
 N/wH2lMwrKfuLUu6xqjXOtTwzByB8seA+E+K2W0B6hkSfCuDXjI1VVS3abQFDzthAFhb
 ON7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791874651; x=1792479451;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9GdmlAg+r0KBNbesZT5lUmE9s7Gfh3qJj15TaW/3QHM=;
 b=ViwHjazW1qLHeigxlEWsJhu7do23o/yK97OLkWELBPY2sslDroEWQ8sb99uc1mZDt2
 uhVsCuPuQ4dxPgDa3OH/Xn8kGxl/gL9gETfPL2lvkQIZtsyucYuMPqLd8PcWX2cJuEOR
 StJNRcNxWCPlPHDudnYq/SxaIpQpth01tDURT3zsohkfwFyG+FhATxXyr4oI+98el/RF
 /2M4UfnhBxA+5rHPliATMtXfJ3phWGLodqu/niJRZjQwt+6ShvoGOgxGyJOnCr2UMafV
 qgYeP6juGuT7pHUraNIm+iPYSQSEtP4s1/KkXlZHW5kNLE+tOWViQG40Ww2fb/lzCpSr
 Z6Nw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzpiK48NXctn2Dn+0ckYOE2ehx3/3uVK4b5XUEfK4azGlAsFNgrTmPODDqm0djIwQp6nO0W9zq5I5Vi@nongnu.org
X-Gm-Message-State: AFq9FYKhITOvdImmHH5/tVMf/Mkn4d+PQkp0Vkx76ypYWebAgId7P78X
 fmpi3bt/1ULgOpfNa5s/FTWZ+hZRwZUGAKCypP8DXdTN4lBL+kGuShdcnkxxf1g9TttjE9xZBGB
 nGvuV/zkIAIdIQ6O7+sQIP7g+fkUx6CsZ7XQ356pJPS6YOl2wzn1tmOl/Dw==
X-Gm-Gg: AYBFou3NZzfHLkNWAFrrV+lJ3tKqT+WK1M+CBUbEKkJGpRDlxeBcgGMhTo8L1n/hH+F
 YjX9drTljCQBaIdSkXHJ+XmTbndFRt0TZ/0iEIcpG1DNyFuhydqz1tFCQ3Fkg0vD67+n5V+PQ9E
 0jpHuYjTJ7wNNm06ddQTgj7LEpIQ38e394HFwbzrZbS/3UoOc0UtaTl9D6OfX4pCwLYABqNxA3B
 NamnbSRZvGuCsbdLOsyzHcWktGGP4zt8as5qgeYHWrneEi/4aUiQHYND5dN36q3Ykmee5E7Ksh7
 eG512NXtWA2mFGwRUqKKWGAKNTWva8hDLzZognmWe0vsKXj5zk92ZTOwuzFLNBCJG87Lbmg8pJn
 c++lPB/9G9o55bF6W7a7F16iCHXDa5GD4VQ==
X-Received: by 2002:a05:620a:2a14:b0:93e:4d74:68fd with SMTP id
 af79cd13be357-93ebd2ab63bmr2029141185a.65.1791874642909; 
 Mon, 12 Oct 2026 23:57:22 -0700 (PDT)
X-Received: by 2002:a05:620a:2a14:b0:93e:4d74:68fd with SMTP id
 af79cd13be357-93ebd2ab63bmr2029138985a.65.1791874642429; 
 Mon, 12 Oct 2026 23:57:22 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf15691sm335604325e9.6.2026.10.12.23.57.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 23:57:21 -0700 (PDT)
Message-ID: <e883fd2c-db22-4f29-8df0-acd5a5e9d9d9@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 08:57:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] target/sparc64: expose system registers via GDB
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>
References: <20261013-query-reg-v2-0-6f95a2e139a9@redhat.com>
 <20261013-query-reg-v2-7-6f95a2e139a9@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261013-query-reg-v2-7-6f95a2e139a9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VqC2kO2n c=1 sm=1 tr=0 ts=6acdd65c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=rB_AC_PIbXsWsa49W_MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: YPebGC9DGr7qiosyPpy_d8fNaoA3rkiV
X-Proofpoint-ORIG-GUID: YPebGC9DGr7qiosyPpy_d8fNaoA3rkiV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyNyBTYWx0ZWRfX+nWRDKA8tG7V
 QI5TVWI/bI67n5UzNUbuQ59bW1VPn9RhR42LZWIldOc8Y46NQxTkODUOUP0T4xizIUzh3JoRQWJ
 WdCITz9um+cs/sh/a3ryRr/PG32S6og=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyNyBTYWx0ZWRfXztBLYJwDatWI
 BPJCYuJKY7kzSgVSP3TFpYIkESUPSx6fFMfsR3n/exvKAOqhTAIgrN4a4x+ZHJ++RH7721u2BmU
 tgbIWlqWU2j21kcaR1xaZkL2z0Lkt+lxdEqdHdOGOXZxJYi0Q2zUNhV46Fgx/P6y931yAxRkjB3
 7y+bwdzMP+WvED64L+2m2svPWqxMkE6Q70TFiIV0p2Wsk7xOdmSrcDyi/X7rx/VyfXKKFglLqzy
 tRMoyU5iApGAt0WH4yUNC7SDF88VrjW490TPrbvmHebuVzus4CZux2iiLoZskOfJA9R71PxFQ/o
 lRbm/3APrwS18V/m2v/Ptg/7g8i3eIS5pZGExcqekKqf5im2/yRqDS/bM3cevBoRitkHd+LH/MF
 A4cWkysJXIUd3BxstcRkMjaQRaYNzO659pukcbJgZl1YnAZejHb3VGyrefBFtrPOFMeSXsGmMpz
 uudMY39he/3C6tOUnyw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130027
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 12/10/26 22:34, Marc-AndrÃ© Lureau wrote:
> Add a sparc64-system.xml GDB feature that exposes asi, pstate,
> cansave, canrestore, otherwin, wstate, and cleanwin as read-only
> system registers through the GDB coprocessor interface.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   configs/targets/sparc64-softmmu.mak |  2 +-
>   gdbstub/gdb-xml/sparc64-system.xml  | 22 +++++++++++++++++++++
>   target/sparc/gdbstub.c              | 38 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 61 insertions(+), 1 deletion(-)
> 
> diff --git a/configs/targets/sparc64-softmmu.mak b/configs/targets/sparc64-softmmu.mak
> index 4e621fb8e39e..7f2789136653 100644
> --- a/configs/targets/sparc64-softmmu.mak
> +++ b/configs/targets/sparc64-softmmu.mak
> @@ -1,7 +1,7 @@
>   TARGET_ARCH=sparc64
>   TARGET_BASE_ARCH=sparc
>   TARGET_BIG_ENDIAN=y
> -TARGET_XML_FILES=sparc64-cpu.xml sparc64-fpu.xml sparc64-cp0.xml
> +TARGET_XML_FILES=sparc64-cpu.xml sparc64-fpu.xml sparc64-cp0.xml sparc64-system.xml
>   TARGET_LONG_BITS=64
>   TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
>   TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
> diff --git a/gdbstub/gdb-xml/sparc64-system.xml b/gdbstub/gdb-xml/sparc64-system.xml
> new file mode 100644
> index 000000000000..e00baedb467e
> --- /dev/null
> +++ b/gdbstub/gdb-xml/sparc64-system.xml
> @@ -0,0 +1,22 @@
> +<?xml version="1.0"?>
> +<!--
> +  SPDX-License-Identifier: GPL-2.0-or-later
> +-->
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<!-- System-register values are read-only; writes are ignored. -->
> +<feature name="org.qemu.gdb.sparc.system">
> +  <reg name="asi" bitsize="32" type="uint32"
> +       group="qemu-debug" save-restore="no"/>
> +  <reg name="pstate" bitsize="32" type="uint32"
> +       group="qemu-debug" save-restore="no"/>
> +  <reg name="cansave" bitsize="32" type="uint32"
> +       group="qemu-debug" save-restore="no"/>
> +  <reg name="canrestore" bitsize="32" type="uint32"
> +       group="qemu-debug" save-restore="no"/>
> +  <reg name="otherwin" bitsize="32" type="uint32"
> +       group="qemu-debug" save-restore="no"/>
> +  <reg name="wstate" bitsize="32" type="uint32"
> +       group="qemu-debug" save-restore="no"/>
> +  <reg name="cleanwin" bitsize="32" type="uint32"
> +       group="qemu-debug" save-restore="no"/>
> +</feature>
> diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
> index 2874ce1b3501..efbe16f38aa9 100644
> --- a/target/sparc/gdbstub.c
> +++ b/target/sparc/gdbstub.c
> @@ -266,6 +266,39 @@ static int sparc_cp0_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>   #endif
>   }
>   
> +#if defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
> +static int sparc64_gdb_read_system_register(CPUState *cs, GByteArray *buf,
> +                                           int n)
> +{
> +    CPUSPARCState *env = cpu_env(cs);
> +
> +    switch (n) {
> +    case 0:
> +        return gdb_get_reg32(buf, env->asi);
> +    case 1:
> +        return gdb_get_reg32(buf, env->pstate);
> +    case 2:
> +        return gdb_get_reg32(buf, env->cansave);
> +    case 3:
> +        return gdb_get_reg32(buf, env->canrestore);
> +    case 4:
> +        return gdb_get_reg32(buf, env->otherwin);
> +    case 5:
> +        return gdb_get_reg32(buf, env->wstate);
> +    case 6:
> +        return gdb_get_reg32(buf, env->cleanwin);
> +    default:
> +        return 0;
> +    }
> +}

Why not remove the sparc64_monitor_defs[] array at the same time?
If doable that would ease logical review.


