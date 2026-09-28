Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C78CA5FA5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 23:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBKjp-0008Nm-0m; Mon, 28 Sep 2026 19:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xBKjl-0008MY-Kr
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 19:26:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xBKjj-0002WV-Jf
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 19:26:21 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SLTeoO1838875
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 23:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uRBYbItNNvBuuWOlETkg0fjWOgiEDzeeZFG8FC3eZ3A=; b=PNSP9y1Pnhxb2JRp
 5xjIMWy8Gc/Ben+DBHGJvIr7pVGX8NLEdvPH5I+iBn9x9/LTwzsNgmjxLi22OJkB
 7FDqKoPrpsb7AaT9zP9tQ5MhtPLGTh3nXEl21hlXzodLyux/DeM1pL7WkHTi3MVP
 rYZDpiSI60Sd3TbjomAJHRt6wA71Jt0z7DkQwsWtxwmDEXs/wuddgRD9STMCSv5x
 cWJPYYIRVeCgc78yml7bBbVZU4PfEacQE9H7AkOUNklk0gT0qFyZi3AZfS1/L8oB
 9mcIB+Oh1IuvlIC3YbHLiJ42TfeqgwFSdYr/A7GNvwGhb2yJayuyuWQsqj0vGRK/
 dMK7bg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyjt13y2s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 23:26:17 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-530d028f779so42870351cf.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 16:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790637977; x=1791242777; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uRBYbItNNvBuuWOlETkg0fjWOgiEDzeeZFG8FC3eZ3A=;
 b=J9QhOmoTk/7Q5Vd9ZByM6/HTZIS3AN6rqzus9q5mCQ0paNJmW5gGg2eeqKIDAOWYz1
 Ggkl6HIiwxWXjw37w6E8U/5yjdbYaFEYhgRWUp77XML7D4v1ICKPNAJqNBeKjlcar2Uk
 gPF0rdL2yTFmgP6QMthbhMQdDstYit1Xpcic7CLJ/ALmdM0W9IpOiIy//EdlrVmQBXYA
 pJD0KYNPE5Nffzv59r4nFdW6rsIf/CQQ1mfJJJFweIMaYiLNbFoSLhzg1qVBtkPeB/wg
 /Z7cDBB1mPBh37qcqTcuUvTi1ihC4BXhfT/KqhRnPcBBXN3T3dHxqo2UVvp8jKAQbqSn
 4vlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790637977; x=1791242777;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uRBYbItNNvBuuWOlETkg0fjWOgiEDzeeZFG8FC3eZ3A=;
 b=okmViKz7vmGmPooFBWkgEwwVjd/xw5Y7JVgcQnZoDVje9lEFxI+3LlGe2bCnqi3jsy
 rA4mACLRmh01fYVISTfR9/R2f4Anp9MeVBJy9NQvnSUIRyWdxpyJoObVzavS9OzLDrwB
 YbBj2sZ/GVOgOerDbTSwR8rAu74b25132ySERWgsCnGnjff1NvMQ7j7iR7wwJulpEscs
 WS+cdublVvz6gz/qe6vy0Tzr1CPNVLq7sAbfVfG9sTV+wETHAtj3LcDemJ6TTRM1NILx
 5BMJE9+MJ7FaD5+ZjXGqGsDLPtiWbVi5dpqHKxtlwHJh6Hbt1ztPWJRFyh4D64QE7LaM
 BBcg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx8rLC9wxUqFq9tVkZZVb54clTPBEyPxzB53F9SHlWCnafItEXSgVIWNMGujPonWe8QAVLCRFVx0FCr@nongnu.org
X-Gm-Message-State: AFuF++nlxOiim1mGlrP3YZxL/zKSlzmvThdv1/xiEqNULOJz4VOtLn3U
 m5pQqu32DQugvNFb6rG1dRsgkmf+zk5eM2I5AdJISrnn/5LKTjGe1n/PS0zkNrUHBj3d1rVtuwT
 vreQpQTR7Ph6hbVj18u5/9AvbuoZIgRjxNlmKOVf2dBR3y+oB9aqfEea7Eg==
X-Gm-Gg: AYBFou0o7oIIindYyf52uOo4MKcwGdFRQEltnjUEjSqOMBZOe57tnaGfotl76mOXYpw
 DU2csx9DP+lqNVk5r+9XTS/EaluZwDVWrMfYutLAoI22WpWYsXtf2iMEWfh6VUMHWRj9qpgh0mT
 Pu00dfGEZK9xD4ZzkXkOOY2+4QElfELpDVkDafqSta6t/8DxkVfOb8e78EYA4vZasH6Qtboyw8U
 WiHTmI3XHtylYRWtYRMjhfx9FcC6PmbS8iAPjflY0IlaEi1FqEjonm9r8nhGrTEPi2M2ankEdUX
 CJBL8m/IWMU81/TIfetCrDHaGoPTFBXKb9UnmkdBJ9h7PO3z+Kvde4pEfW8gL1LX+VhNA1QEk3B
 gjL3Jn5Dp/q0QFPFY78vxdNuztHPj0jdNCA==
X-Received: by 2002:ac8:5a12:0:b0:532:9b14:96c5 with SMTP id
 d75a77b69052e-5330b706380mr244407741cf.60.1790637977183; 
 Mon, 28 Sep 2026 16:26:17 -0700 (PDT)
X-Received: by 2002:ac8:5a12:0:b0:532:9b14:96c5 with SMTP id
 d75a77b69052e-5330b706380mr244407371cf.60.1790637976584; 
 Mon, 28 Sep 2026 16:26:16 -0700 (PDT)
Received: from [192.168.68.100] ([187.10.234.20])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-533223d1ad0sm74997081cf.23.2026.09.28.16.26.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 16:26:16 -0700 (PDT)
Message-ID: <0abd8b75-8fd5-465f-9b67-5fdc161cc14f@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 20:26:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/virt: only describe PLIC contexts that exist
To: Ralf Ramsauer <ralf@vmexit.de>, qemu-devel@nongnu.org
Cc: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Bin Meng <bmeng.cn@gmail.com>
References: <20260927231838.236616-1-ralf@vmexit.de>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260927231838.236616-1-ralf@vmexit.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA5MyBTYWx0ZWRfX2qftuSlpO+VJ
 ZKEdmX2HQeE2hgEOnUeOIJTRY4e8kN/5+yGglTAVnJkOpmibBqSpsJuXNjVhpDkrDvjo/A7Hw8a
 ixktK/3bzJKf28FvgS/JdGh3dGCHloZwOpJ7YSqtaTATU3fWTeytNt7RbOtJx19ipplZspcFuzC
 YwT6knvidplIqpSV2aY4MYKVsq6LeE83jf3URJX4h17AbUW7uUB08Y5PY7fiRua36D1k0+orwef
 Z4lsGqgsG7OSb5QaaQSMif97TJNg/6ocaikVo85AAOP59LPjPQBytdBxUzA8F2/9CtzI1iC/MyA
 tImDHAB9z/gbEiehN7vidrpZsWWNg9rN6PwOqk5RJwl4bTr+thVad+edUAHVbdS+pUPAeDqxys8
 xNxU76oc8MmssFggY6ZIeSn8SwEb0e4XDvVx0KR5S8nRF5IyGuQq0vQTcfN2s411XidYU85sZou
 l9yElcWmlB9q0HaljhQ==
X-Authority-Analysis: v=2.4 cv=V8foQuni c=1 sm=1 tr=0 ts=6abaf799 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=jbqyKmyYbxlRs/MVMa3Ccg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=TqtECITn0xDTAHAp4AAA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: G0Ful_2ydZOUqhquQL8Hm8oyav-Gjhr6
X-Proofpoint-GUID: G0Ful_2ydZOUqhquQL8Hm8oyav-Gjhr6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA5MyBTYWx0ZWRfX1w5+NNg55Kez
 oW9tbUZ6Q/R+38uIt2pJLcsReStqllguwfPuOU6eBLX05pzoxPapwHLt7yhC46Mbb6kWSyJ/6mO
 YG46HsmiwMM7/EbpwyptwO9l5Co9M8k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280093
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

Hello,

On 9/27/2026 8:18 PM, Ralf Ramsauer wrote:
> From: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
> 
> The PLIC device is created from the topology string built by
> riscv_plic_hart_config_string(), which gives a hart a supervisor context
> only if that hart actually has supervisor mode.  The device tree, in
> contrast, lists a machine and a supervisor context for every hart,
> unconditionally.
> 
> The two have disagreed since commit 7d10ff8a4d ("hw/riscv: virt: Use the
> PLIC config helper function") taught the device about harts without
> S-mode and left the device tree behind.  Boot with
> 
>      -cpu rv64,s=false,u=false -smp 4
> 
> and the PLIC implements four contexts while the device tree advertises
> eight.  Contexts are numbered by their position in 'interrupts-extended',
> so a guest that takes its context number from the property gets it wrong
> for every hart but the first: hart 1 drives the context of hart 2, and
> the upper harts address contexts the PLIC never created.  This is what an
> M-mode kernel on the virt machine runs into; sifive_u already omits the
> supervisor entry for its management hart.
> 
> Emit the supervisor entry only for the harts that have supervisor mode.
> 
> Fixes: 7d10ff8a4d ("hw/riscv: virt: Use the PLIC config helper function")
> Signed-off-by: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
> ---
>   hw/riscv/virt.c | 21 +++++++++++++++------
>   1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index d4b501802f..d0ce9dc862 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -165,14 +165,23 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
>               plic_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_S_EXT);
>           }
>      } else {
> -        cells_length = s->soc[socket].num_harts * 4;
> -        plic_cells = g_new0(uint32_t, cells_length);
> +        plic_cells = g_new0(uint32_t, s->soc[socket].num_harts * 4);
> +        cells_length = 0;
>   
>           for (cpu = 0; cpu < s->soc[socket].num_harts; cpu++) {
> -            plic_cells[cpu * 4 + 0] = cpu_to_be32(intc_phandles[cpu]);
> -            plic_cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_EXT);
> -            plic_cells[cpu * 4 + 2] = cpu_to_be32(intc_phandles[cpu]);
> -            plic_cells[cpu * 4 + 3] = cpu_to_be32(IRQ_S_EXT);
> +            CPURISCVState *env = &s->soc[socket].harts[cpu].env;

There are a few things to consider here.  First is that we have a very similar PLIC
code in the sifive_u.c board.  I believe we want this fix also applied there.

Second, we should avoid accessing CPU internals in board code.  In an ideal world
the board would be completely oblivious to what the CPU is about, e.g. its extensions
and accelerator mode.  In practice we have to account for accelerator differences since
KVM and TCG requires different stuff w.r.t irq controllers and timers and so on, and
at least for now this code is being open coded in the boards.

For the problem you're addressing here I would like to avoid making the board accessing
the CPU env and checking for RVS.  My suggestion here is:

- we need a pre-patch that adds a helper in cpu.c that tells whether a CPU has supervisor
mode.  Something like:

(cpu.c, could be right after "riscv_cpu_is_vendor")

bool riscv_cpu_has_supervisor_mode(RISCVCPU *cpu)
{
#ifndef CONFIG_USER_ONLY
     if (kvm_enabled()) {
         return true;
     }

     return riscv_has_ext(&cpu->env, RVS);
#else
    return false;
#endif
}

same thing in cpu.h.  The justification for this helper in a separated patch is that
"next patch needs to verify supervisor mode for CPUs in hw/riscv board code", or
something around those lines.


- in this patch you can then do:


 > +            if (riscv_cpu_has_supervisor_mode(s->soc[socket].harts[cpu])) {
 > +                plic_cells[cells_length++] = cpu_to_be32(intc_phandles[cpu]);
 > +                plic_cells[cells_length++] = cpu_to_be32(IRQ_S_EXT);
 > +            }

And we're at least trying to obfuscating the CPU internals from the board a bit.


And please do the same in sifive_u.c.  Don't need to be in this same patch, so feel
free to add another patch  just for the sifive_u board.


Thanks,
Daniel

> +
> +            plic_cells[cells_length++] = cpu_to_be32(intc_phandles[cpu]);
> +            plic_cells[cells_length++] = cpu_to_be32(IRQ_M_EXT);
> +
> +            /*
> +             * The PLIC implements a supervisor context only for harts that
> +             * have supervisor mode, see riscv_plic_hart_config_string().
> +             */
> +            if (riscv_has_ext(env, RVS)) {
> +                plic_cells[cells_length++] = cpu_to_be32(intc_phandles[cpu]);
> +                plic_cells[cells_length++] = cpu_to_be32(IRQ_S_EXT);
> +            }
>           }
>       }
>   
> 
> base-commit: 81ce3a87737aa50716c42db8886082d12783e0a1


