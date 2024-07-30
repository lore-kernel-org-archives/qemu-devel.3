Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010B1C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 15:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpDY-0005UF-3Y; Tue, 30 Jul 2024 11:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sYpDW-0005Td-Lm
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 11:56:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sYpDU-0007Ud-JJ
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 11:56:50 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46UFAAxp003136;
 Tue, 30 Jul 2024 15:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zLD1riq9XDRKJzE/LpxROR+LFrIHboYxJNEv5iOc4ek=; b=bQ3ewgHMWMSNhpQI
 J2MWDz2lQ5zqrBy4Jemz+U9krI+pvrO6wHklJCFx+JVQqY8XVzki+K/9flMJuwnR
 Gi1CPosy4h0ZFIYjdLM/9FrefTnvC3ZlaxYTgS+2BpZgNPLxRWx/EcUI5tOB/EfA
 qDYuoBIzIO9yYbWm6Yx129zGBPGXITyACDszBAxOkgtnN1sttg+UMc4Bgp4CZ8BR
 9YJCMqYxJZSvzHFr7zkh7YxrmYdJWOZqbfkbW7PfLUNfDurdSZH1wz8sPpDU4qZx
 etW111yNWEYGqKPi5jPCx+yRcetWcW+NFnVYERCR4ZvrRn7qXCqzcTPSAYIAUNS3
 N6EReQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40ms96r6mp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jul 2024 15:56:46 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id
 46UFuiMK027604
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jul 2024 15:56:44 GMT
Received: from [10.110.37.171] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Jul
 2024 08:56:43 -0700
Message-ID: <9187550d-369a-4c2f-9499-fa4180a8c13d@quicinc.com>
Date: Tue, 30 Jul 2024 10:56:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Hexagon: lldb read/write predicate registers p0/p1/p2/p3
To: Taylor Simpson <ltaylorsimpson@gmail.com>, <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <tedwood@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mathbern@quicinc.com>, <sidneym@quicinc.com>,
 <quic_mliebel@quicinc.com>, <richard.henderson@linaro.org>,
 <philmd@linaro.org>, <ale@rev.ng>, <anjo@rev.ng>
References: <20240612164239.90276-1-ltaylorsimpson@gmail.com>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <20240612164239.90276-1-ltaylorsimpson@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: E7Aztxi_jONzF_Dx0dyVp15RCZAmqhdh
X-Proofpoint-GUID: E7Aztxi_jONzF_Dx0dyVp15RCZAmqhdh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_13,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300108
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 6/12/2024 11:42 AM, Taylor Simpson wrote:
> hexagon-core.xml only exposes register p3_0 which is an alias that
> aggregates the predicate registers.  It is more convenient for users
> to interact directly with the predicate registers.
>
> Tested with lldb downloaded from this location
> https://github.com/llvm/llvm-project/releases/download/llvmorg-18.1.4/clang+llvm-18.1.4-x86_64-linux-gnu-ubuntu-18.04.tar.xz
>
> BEFORE:
> (lldb) reg read p3_0
>      p3_0 = 0x00000000
> (lldb) reg read p0
> error: Invalid register name 'p0'.
> (lldb) reg write p1 0xf
> error: Register not found for 'p1'.
>
> AFTER:
> (lldb) reg read p3_0
>      p3_0 = 0x00000000
> (lldb) reg read p0
>        p0 = 0x00
> (lldb) reg read -s 1
> Predicate Registers:
>          p0 = 0x00
>          p1 = 0x00
>          p2 = 0x00
>          p3 = 0x00
>
> (lldb) reg write p1 0xf
> (lldb) reg read p3_0
>      p3_0 = 0x00000f00
> (lldb) reg write p3_0 0xff00ff00
> (lldb) reg read -s 1
> Predicate Registers:
>          p0 = 0x00
>          p1 = 0xff
>          p2 = 0x00
>          p3 = 0xff
>
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---


Queued.  Thanks!


>   target/hexagon/gdbstub.c | 19 ++++++++++++++++++-
>   gdb-xml/hexagon-core.xml |  6 +++++-
>   2 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/target/hexagon/gdbstub.c b/target/hexagon/gdbstub.c
> index 502c6987f0..e67e627fc9 100644
> --- a/target/hexagon/gdbstub.c
> +++ b/target/hexagon/gdbstub.c
> @@ -1,5 +1,5 @@
>   /*
> - *  Copyright(c) 2019-2021 Qualcomm Innovation Center, Inc. All Rights Reserved.
> + *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
>    *
>    *  This program is free software; you can redistribute it and/or modify
>    *  it under the terms of the GNU General Public License as published by
> @@ -36,6 +36,14 @@ int hexagon_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>           return gdb_get_regl(mem_buf, env->gpr[n]);
>       }
>   
> +    n -= TOTAL_PER_THREAD_REGS;
> +
> +    if (n < NUM_PREGS) {
> +        return gdb_get_reg8(mem_buf, env->pred[n]);
> +    }
> +
> +    n -= NUM_PREGS;
> +
>       g_assert_not_reached();
>   }
>   
> @@ -56,6 +64,15 @@ int hexagon_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>           return sizeof(target_ulong);
>       }
>   
> +    n -= TOTAL_PER_THREAD_REGS;
> +
> +    if (n < NUM_PREGS) {
> +        env->pred[n] = ldtul_p(mem_buf);
> +        return sizeof(uint8_t);
> +    }
> +
> +    n -= NUM_PREGS;
> +
>       g_assert_not_reached();
>   }
>   
> diff --git a/gdb-xml/hexagon-core.xml b/gdb-xml/hexagon-core.xml
> index e181163cff..b94378112a 100644
> --- a/gdb-xml/hexagon-core.xml
> +++ b/gdb-xml/hexagon-core.xml
> @@ -1,6 +1,6 @@
>   <?xml version="1.0"?>
>   <!--
> -  Copyright(c) 2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
> +  Copyright(c) 2023-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
>   
>     This work is licensed under the terms of the GNU GPL, version 2 or
>     (at your option) any later version. See the COPYING file in the
> @@ -80,5 +80,9 @@
>     <reg name="c29"              bitsize="32" offset="244" encoding="uint" format="hex" group="Thread Registers" dwarf_regnum="61"/>
>     <reg name="utimerlo"         bitsize="32" offset="248" encoding="uint" format="hex" group="Thread Registers" dwarf_regnum="62"/>
>     <reg name="utimerhi"         bitsize="32" offset="252" encoding="uint" format="hex" group="Thread Registers" dwarf_regnum="63"/>
> +  <reg name="p0"               bitsize="8"  offset="256" encoding="uint" format="hex" group="Predicate Registers" dwarf_regnum="64"/>
> +  <reg name="p1"               bitsize="8"  offset="257" encoding="uint" format="hex" group="Predicate Registers" dwarf_regnum="65"/>
> +  <reg name="p2"               bitsize="8"  offset="258" encoding="uint" format="hex" group="Predicate Registers" dwarf_regnum="66"/>
> +  <reg name="p3"               bitsize="8"  offset="259" encoding="uint" format="hex" group="Predicate Registers" dwarf_regnum="67"/>
>   
>   </feature>

