Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C17CC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpEz-0006YY-0z; Tue, 13 Oct 2026 23:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGpEt-0006YA-61
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:01:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGpEr-00070G-Ka
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:01:10 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69E1iOZ43017736
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 03:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 roPOnuLFzza0JX7vqt2KGNHnYzhpe2iRUCdeWykoZ34=; b=QgYzyQNM9VaqNzzq
 yqovBEwlqOcEJYPEpos+njSyIt9/RV8YS/lmJolgNFqdLpkcsBgg/hutceyuFKgU
 8tNYppTwy/0kRqcGHZjjOvFUYjJDDbIuEmMJK82mqKO5iNRrWNlhL4k0tZBpGGeN
 bW+JhafmJS4vdJgh3Rsq3oxHOaN0FFFcoKcUz7Aex6Ru+nwYnbiq+P4d3QsBwzCu
 UXCjwFUNJis/jgwp2LoEaaKYDng/aVMLGjIO4ItJVlvoQ0ohpMSXbii+hVthzdOl
 /RFLtXkqbNbCS/MI+3ScSVqM2F+mA3koepYDmOP9g+k4AY74e2YNTF/+0zGwpo/Q
 cvmMEg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9s2b22sf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 03:01:06 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93ce7a85f04so821523885a.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791946866; x=1792551666; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=roPOnuLFzza0JX7vqt2KGNHnYzhpe2iRUCdeWykoZ34=;
 b=aMk32vEt5RDJ/amfKqieR057A9S8VznefAEP9I7CX/Y3rlNA8RUa2eX4OCL4kaEAe/
 v5nDM9bONBRn3NyZ1k7L8znvMP/TdqE5NKoXQiV1pRE2wS5ZUV2FTvEN36D7XX7XQmUD
 88wx6bqHo++Nj4Vl/FQiEoyMaS2rUvkcXfCEk7Uv96rcK4I0qM/9mKItbhL3Fcb1wgRd
 uWGcaI4S1tfBLfbyDw1SXSTse35l0iM+i9Sgu99GWgxtdZrG2fjt8eX0nejv6x+nDJRo
 CgjkivkbvJr1iNregQuGzmPelKCfvw84ZCxweL7mp26g51vTdjGQMh4mxomk7+tA3/E6
 R/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791946866; x=1792551666;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=roPOnuLFzza0JX7vqt2KGNHnYzhpe2iRUCdeWykoZ34=;
 b=qjaV5HLpLAe4RFn3g8sQ+4Ndm4L77aVxgasd5CZpjwii7WXuW7SHSAYYH9EpwAf7Xl
 peII0z2NH0yK6QCap+nPBy/i0w+Eb2nREjVsv6b4ipsEMY3Riex0DLAeE0uHvGGo7nEG
 IJ8DMchhMbpsbBFATSRk01O/U/NrlDF/2qiRJn3UnGoD6oJjPrbpDI0wPDwbFB/srFw3
 XzEiUb4eX6dL7gRAFtOJpvQcIAjWRd3r1SUJIJqrrqXkccqySWQceqBusyH+NQGhDVa5
 IgtNpy7BTOrcHgptw7WH925QpFgGofZad5pDWLUUBxQL7PsDhLUWHS0Ml9UwiqYLcuxe
 NXzg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzEJUZtifVr1c78bnlFPkap8yhytKra3fUMtC4UGS5/8iZX+zJHBV/jpc4GpkjBFnSMz5oxz/r/R6fA@nongnu.org
X-Gm-Message-State: AFq9FYKuYqkTb5qR/JDJBdpcroqBv/mIZTWIjR4PEDkgeSWtrRcBDDk+
 z93Ppj5pj/FUIHjKVtM5DdK3zDo1vMakascXpMKMJRegWnwhqICBSdWlJy+UUoZVHoSRAHPHNt9
 rrMJ5AgNJk5BIN4FLNwyGwdwXuRrvTV9sJ22Ekn/aLwHh9mLZdCXnzYBXbw==
X-Gm-Gg: AYBFou1JXar8xHHFyiCKj0e/OcJK5Ku43vfc+D6umbtsaHGkGuX30+dC+0uZJWMtztZ
 mLEfA4oyHd2V97EpOus2Opg7AG9eEnoqCA6h+TcvAUmwVXlMqzV+3yRG68sLks2SnvdACeM4Xi1
 hgZnej/OAhgBUk9WX5KsrTyTpfrD0Hw7hB5UWQ6/HfHewUHoN7Wjm1L6kgunMJSCXTF9nCqH/ZA
 pfh+35pYlEdIPy0muuJLsbYSBWrhtrj/dx1wPfmgEE38p6SAGx1nEf/PqBgijl9utvQZuKpXdL5
 vTHIQ063IiSZyxMH3rr5khkduTkvN7uzI9ecFoffTBs1EHfgXjc/Wx89Jzuep2gZiBgsxDEjgSJ
 9fcU63fW5D9fJPBfhukvg4yzwMN2q7hJFnA==
X-Received: by 2002:a05:620a:448f:b0:939:b94c:3e85 with SMTP id
 af79cd13be357-93ebd1bb1c2mr2340980985a.24.1791946865827; 
 Tue, 13 Oct 2026 20:01:05 -0700 (PDT)
X-Received: by 2002:a05:620a:448f:b0:939:b94c:3e85 with SMTP id
 af79cd13be357-93ebd1bb1c2mr2340976585a.24.1791946865249; 
 Tue, 13 Oct 2026 20:01:05 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bea1021sm374417355e9.10.2026.10.13.20.01.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 20:01:03 -0700 (PDT)
Message-ID: <5b415e5b-8d35-4f4b-a5c3-09ae631e6670@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 05:01:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] target/hexagon: halt on tlblock when the TLB lock is
 contended
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261009192541.4163758-1-brian.cain@oss.qualcomm.com>
 <20261009192541.4163758-5-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261009192541.4163758-5-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RPQmjIi+ c=1 sm=1 tr=0 ts=6acef072 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=RPsqSLXOHsBJ5lf2698A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: _2nmrWF0ELU0o58XtFkjwObJLRGjPRiS
X-Proofpoint-ORIG-GUID: _2nmrWF0ELU0o58XtFkjwObJLRGjPRiS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAxMSBTYWx0ZWRfX9ROH5MmeThVj
 EZ0biLXCZyWBkQjCilNMw7jSWdU0hfCi7tsXKYGwPW9riA0vwh9mr/1pxLkpEw6B5wYJgWFVQmO
 QFtZdcahfGVeaCTxiMKZlLfvyHC9G8L7N2Xz8yjx9Yc2I5Y416mNEJQPnafthZJNqPdZVEb9j74
 5Q768F82+Ewy39kXK3N6nXv0k35ZeVq39XvfLTcmwZMh4q1+kUm8KR7PBnf+MacNfsaSwcafMdy
 z9S0WRr7Voga2E7NnCkrovGHxr+B208PjKrzT6gJf21ToCcc3bBkU4Bx+UD7GP/vfXywOrzMSts
 ZyYgtaV/zbHucWhzbL7mjhLO2o7a4Z+VoMjtsRCZnCdJ5XEAwzhectf6rrpMq3MCKasaaXmv6C2
 zuwSaaoaMli0Er1g0vLhL2ySRprxyGfneVggw0l7VhcOULxhKEpBdihgg/GyRypbVB0u7UH4xdQ
 hc+T0QtpgtlHGCZqLKw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAxMSBTYWx0ZWRfX4bpPvde8gsXq
 ccQAXf78QM2OIUEHzvQ/XGgXSC/+e8i/QcWepO+3LGj/kIf07jQa/dj7YExu7Kv0DyUZkwrk/1M
 yGQu3SLyJOvFObrIoNd2XRpQcvbPZx8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140011
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

On 9/10/26 21:25, Brian Cain wrote:
> Set PC to the tlblock instruction and leave the CPU loop when the lock is
> contended. This retries tlblock after ownership is passed and prevents
> execution without the lock.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/hex_mmu.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/hexagon/hex_mmu.c b/target/hexagon/hex_mmu.c
> index bdcfa057c21..b9fab949d0f 100644
> --- a/target/hexagon/hex_mmu.c
> +++ b/target/hexagon/hex_mmu.c
> @@ -12,6 +12,7 @@
>   #include "system/cpus.h"
>   #include "internal.h"
>   #include "exec/cpu-interrupt.h"
> +#include "accel/tcg/cpu-loop.h"
>   #include "cpu_helper.h"
>   #include "exec/cputlb.h"
>   #include "hex_mmu.h"
> @@ -185,11 +186,14 @@ void hex_tlb_lock(CPUHexagonState *env)
>               env->next_PC += 4;
>               CPUState *cs = env_cpu(env);
>               cpu_interrupt(cs, CPU_INTERRUPT_HALT);

Pre-existing apparently, is CPU_INTERRUPT_HALT appropriate?

      /*
       * External hardware interrupt pending.
       * This is typically used for interrupts from devices.
       */
      #define CPU_INTERRUPT_HARD        0x0002

or is there a better match from "exec/cpu-interrupt.h" definitions?

> +            cpu_loop_exit(cs);

This call makes sense otherwise.

>               return;
>           }


