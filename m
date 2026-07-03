Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CD8C43602
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfbVP-0000qW-C7; Fri, 03 Jul 2026 06:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfbVN-0000qB-OO
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 06:52:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfbVM-00017O-0p
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 06:52:21 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663684eg3053370
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 10:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0hx03ZTlsQroyRpYLDQt6RPjcH2dFopl7aH8+SODzlQ=; b=khLA4kDFfaDdhyxv
 MevfE2w2yCdWjVZwkFxQJAQP6A8bGN1gxitTdg0M+eGB1QpSbxG0EY9e0+5AaK0m
 cU4i4aYjfoZoEgY2MEYjnLY6noJic5nLNuGa9ZUba2IarsAIdv1U3npG5+llax9E
 Z61o/fTRezQz4+41pECpyMjaBImlRCocqxlq7iQTpL/Xw2BSk4tlB2Z7dAFqg+no
 9dYRA0AkmfFEztPZkk0GsX0MpH8zGejw57V+TvjbenSDr84EKyvGX+3Ynu3Av53k
 +YG9r3KArTMoVbu74aKWrkQeRdOBbr7Ve5L7Ut2B9UbWz3EEffd9K6F8sflr6JG6
 SFzZhQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f67j011av-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 10:52:17 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-915c364ae3bso40879185a.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 03:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783075937; x=1783680737; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0hx03ZTlsQroyRpYLDQt6RPjcH2dFopl7aH8+SODzlQ=;
 b=Ax800x5Rzx3XBKNTXwtdI7ghEDrgsWUkRPrlsWBeTjIabSK52M9R8Iw6VwzN214aMX
 GRBOUYMgY00kyzfakFwE6WmjsGHwUiiuH4KXeit6+f6+ytClMD3XoB8OI8Y+MvbfDu4Q
 2N1sJHzbwQ3ue/UxD3unBf+skWVZmr7z0PTtI8NRdhojhbTy8As0loRwZ2y5mBJ13Qdu
 tslFScu3RBc6PLxgaHJ2FvMcQBOfzjUbTJnlTPJZP75fiF1LXdOETadj9Orq2NOL6UBQ
 4XSU015btO0ml38FQHlzs2qeDiAcz1qI1gFgII71TEjc5I0WEG7HaxKNhw7JHUvRAeZG
 Yq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783075937; x=1783680737;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0hx03ZTlsQroyRpYLDQt6RPjcH2dFopl7aH8+SODzlQ=;
 b=FASix1cPDqhn5RpWmFXrZuzGd0lTTBUZwnApOt/x1u/pzAZAogsIvUPUrNGalDraFC
 KWk3QWcy1j+pXL5V0OARdn9UucYcaknQ/tAeFNgG+0WGj4qqHOiGgyp09crAVhRqeiOm
 Lu/w9FrF6w0DSpyAXwNvd9koANOycUplwxgG7YTBIDbnyga8oTlyWVHm1wYrrP4NUKMn
 eXoDz2US7VdrvIsrJNrkkdzHRZlC55AOQ8QWbIFtp5I9nZrW5p5GaLsB4V5gKs9A8o6c
 PYm1hMsuX4hCmuGu0t44wjpKU/CajZk4iZW8uouCEUtUgkpDooCuukU4SsLBxEw/F6FJ
 cjbw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+8lOYpjRZ21o9EPJgEEKw+8EZ8H+bOIztW1VP8R00g/H5YBixtosOWjqXDFhf2kLtJPO08GC1hjHa+@nongnu.org
X-Gm-Message-State: AOJu0YxnDzoGY8IuXgHgR1D0SHF2JTUtREwBxWfzI/rjeUjUxmbT8iZG
 TjvOEQeZ1Hrg+9WfVtdxMH1tDNAQ5Z3KM8abhMez3aFU26Z15c6Gca4nH4SWMuVc5bX4dtS4nJg
 aIyQ5GtUfLT/h5f2vIpG+DnsWDslPTiFyGYQWbs3v4LtJzC3wiDwpAkZGQw==
X-Gm-Gg: AfdE7cnJXlPHFdFu4CNLB6V6lMw8z6+fjgZkXhjV+OgRNw/fUt0E/lZdyomHyjyWy1C
 UqCV6EPGzDzFXcdW972IADRQjsQ+gzCfwsTBO1yw4NVTRb/hQgn0qMwl8nUUKFCKUfvqTceRKG+
 SqlFgrtegst/g1VjcfeSq/SU5CS3gR199wAmNQUBYQFfEPRddlykdNyprVQSQy1FA3wloX2v7rU
 YunSFgoAKY5yGwJ0mP4lIbIit+yTW+/UPvwt7jPVJGgiJVH/CLBao9AIAEtZh1mLBq+EAuYUT6+
 EC6XwH5y5CItAdZST3ZefMazdj/XjL/6vaR3V1YV/ejRdyqwj14oiTLWRADJ8rR6tTfZfU+BrYD
 p5HvHpxvdKv2FJ4nLdQtclEPK3cpPV58C42tWGOsKVbIhZxaiHSpvfswht63VRA==
X-Received: by 2002:a05:620a:1a22:b0:92e:4dd2:bb24 with SMTP id
 af79cd13be357-92e784d10d5mr1269974985a.39.1783075936735; 
 Fri, 03 Jul 2026 03:52:16 -0700 (PDT)
X-Received: by 2002:a05:620a:1a22:b0:92e:4dd2:bb24 with SMTP id
 af79cd13be357-92e784d10d5mr1269972185a.39.1783075936182; 
 Fri, 03 Jul 2026 03:52:16 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63ba97csm122391185e9.12.2026.07.03.03.52.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 03:52:15 -0700 (PDT)
Message-ID: <34076b45-fbb7-4b08-8a6c-04b903d3e2d1@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 12:52:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/24] target/riscv/gdbstub.c: isolate TCG only checks
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
 <20260702135128.1188021-20-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260702135128.1188021-20-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: eriCXz6zVE67xVDLONyPCmOpBC26m8jd
X-Proofpoint-ORIG-GUID: eriCXz6zVE67xVDLONyPCmOpBC26m8jd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEwNSBTYWx0ZWRfXxp0imIHsJx0f
 yJHf+YANrCGFhJzO1p27F+ccX1AZq4T3I5Esm7PcmYs5+bZwl4qb/qx1pzd+K2trqB5xM1oCake
 I3DdiFOgJhjvakPT/wdSba7KBD+BKG8=
X-Authority-Analysis: v=2.4 cv=Yuc/gYYX c=1 sm=1 tr=0 ts=6a479461 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=5xwS0rAgYOzje1glQ3AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEwNSBTYWx0ZWRfXxFA1XJymzQvh
 67gemFkqfZc02gdv7EAoXr0DkI3ZgBU1F7l1lcOmEQ+75C4fC0/8oNqQOuj8rDKvxGnkWHtANBF
 Nhx8tL4aLCG6Fpkd/Y/4hWlMmB3cI8/TOXVmfj0qqLbEy4VxqMBxpGiTY2Ec31KQPOA6LvYVQ8W
 lOct6uHyyfFwiPUor3ZbG9eYmyavBH1i96ceDFQlFluPQpcxBs3w+8z2M1It1rZMVj4cxWnIefv
 zywRSWIa5lQ2lS3JTtiDOQ7+a7SM7b4GJQ/CFQZNb9JS4OskGD4RpmulPZkkPAGtEfpNq8WO+FP
 y8Dkby0F/kHXGDFVd0jFnW0dyk4YAeYTIfE3cZ56v3+hnpf8DwwiJGoTx6FHGWmPxyrTIdwzgZx
 ZjDDM9KjHLiS8gBiW3DWPxAHPxByfNOzKVIAQFMhlc23hGS521yzQM5pijKgIycOrG53lmZWpVE
 DdwtCTtonK/3hmJwv8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030105
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

On 2/7/26 15:51, Daniel Henrique Barboza wrote:
> The following functions are TCG only and are broken, if they were ever
> usable in the first place, with KVM:
> 
> - riscv_gdb_(get|se)t_csr
> - riscv_gdb_(get|set)_virtual
> - riscv_gen_dynamic_csr_feature
> 
> Gate everything with TCG enabled to at least get them out of the way to
> enable --disable-tcg.
> 
> As a note for the future: other archs have distincts gdbstub files for
> each accelerator.  There's a strong case for RISC-V to do the same.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   target/riscv/gdbstub.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index f0a5e0d86f..9abbf5bcdf 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -164,6 +164,7 @@ static int riscv_gdb_set_vector(CPUState *cs, uint8_t *mem_buf, int n)
>       return 0;
>   }
>   
> +#ifdef CONFIG_TCG
>   static int riscv_gdb_get_csr(CPUState *cs, GByteArray *buf, int n)
>   {
>       RISCVCPU *cpu = RISCV_CPU(cs);
> @@ -294,6 +295,7 @@ static GDBFeature *riscv_gen_dynamic_csr_feature(CPUState *cs, int base_reg)
>   
>       return &cpu->dyn_csr_feature;
>   }
> +#endif /* CONFIG_TCG */
>   
>   static GDBFeature *ricsv_gen_dynamic_vector_feature(CPUState *cs, int base_reg)
>   {
> @@ -336,7 +338,6 @@ static GDBFeature *ricsv_gen_dynamic_vector_feature(CPUState *cs, int base_reg)
>   
>   void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
>   {
> -    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
>       RISCVCPU *cpu = RISCV_CPU(cs);
>       CPURISCVState *env = &cpu->env;
>       if (env->misa_ext & RVD) {
> @@ -351,6 +352,10 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
>                                    riscv_gdb_set_vector,
>                                    ricsv_gen_dynamic_vector_feature(cs, cs->gdb_num_regs));
>       }
> +
> +#ifdef CONFIG_TCG
> +    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
> +
>       switch (mcc->def->misa_mxl_max) {
>       case MXL_RV32:
>           gdb_register_coprocessor(cs, riscv_gdb_get_virtual,
> @@ -371,4 +376,5 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
>           gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
>                                    riscv_gen_dynamic_csr_feature(cs, cs->gdb_num_regs));
>       }

I wonder if it wouldn't be safer to extract as a new
riscv_cpu_register_tcg_gdb_regs_for_features(); but indeed moving
the TCG specific code to a new target/riscv/gdb/gdbstub.c is even
cleaner. Can be done later surely:

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +#endif
>   }


