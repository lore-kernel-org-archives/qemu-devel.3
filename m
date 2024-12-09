Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E60E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 20:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKkGW-0002rk-9a; Mon, 09 Dec 2024 15:22:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tKkGS-0002qf-EV
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:21:56 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tKkGN-0001UT-Ju
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:21:54 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9HeQrs002578
 for <qemu-devel@nongnu.org>; Mon, 9 Dec 2024 20:21:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DzU/888Y3udSultLPyrm+yf2mrvpaOySiovY0AzyR7U=; b=FIPz2Pgy09zaU9mt
 MQdrQHGDsUjm/xEUVMt2jpkO5EAPCXhbsTxc8tttkrAKzXCm4k+xl31u+wzss8Px
 zQdG0J4r9k46xFThnph06w3hfWLdnDERSKIdhWTPgDcehYj/JR/xxQKYdOqssYf/
 7dUCS4h/bHnN+iBB1wv4UqNBknR/bByTFJBPzEZthTnoZzWs+7Cjyv9sXRPjh40q
 YwHIHUP7O6yz8UajYmCJO3jYKbjJU+d15xSE4miZoalTpEE1mXSlqAX0PI9w+Kae
 O/9zInB/BztN3QwkxKVf8144iAscFcyjtDWgzhpNmUYyvSeha1ufdSq43g9XKZ/v
 cCwS7g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43dxw41vg2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 20:21:49 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4674f8cc639so57521811cf.1
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 12:21:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733775709; x=1734380509;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DzU/888Y3udSultLPyrm+yf2mrvpaOySiovY0AzyR7U=;
 b=TQpFU+MMgfSiytB2TLA9hmGKphQjVrbLBTB27dLT4uaUhoXYfnfpBn9yMJJUGhus7K
 7KyeiPC23QbEuSN4Z9OT88AJFiztkgmZ4ljg8DAnJBELDPKuWWDJlDUpJ0z6wkE2XUDO
 N8H6rfAJTBFnEnxTbqjD9XtdRbzqJXNKC5l9EQqm20cWKRpgzcv/HHhIEkFVK8gtq592
 2R6a89EQ7a0eaP9Avsp/WYGw7/07p2L0rj5FPNHE3HRfEEYu24E+cwW612pY8j3sF+6D
 2LleEuN8CxmGE/6NDs2s6+6z7Ao+RIfcGdRUNImAIB9p6Cs3XRAM1XgzLs4xvT3c1/Eo
 A3Ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3tqOgFGVcwkUDgtBeo0CCmQj6U/HzAh3sQ6wJVDOHpllgdYjAUtrfG9z7Ksm82SVfZ4AdLJYDu3HK@nongnu.org
X-Gm-Message-State: AOJu0YxvCNLnfV2GId9HDtfHjX+nwWykkp8wi5azpj5bTQYJCBkjYsYj
 RbByiZZpwjrDTXLUSuEnIHsXn6YDSRTxmtiIsiw6K+7CQmB8YUKlX/3SPSQKZT5oil3m5Ue3u5P
 Qqy+8XuKWomRJeZXRr0Qk/+GoDvqmxBWap/Y1NCYu2csH5eKkoqDBNw==
X-Gm-Gg: ASbGncvmbJxGzM1+PI1bR3ElIBdTuZ0aYkg+HpUgNZ4PiP556S7QbC2Q8lURSPVlcby
 Y6urOsXTS4C2xHArwq+FsgRYZt9aUpCIcIxM6McYqMlBPHVVG8quVJv3wRkxBhUQ4xTz3cNzLK+
 kwRJnQJO5T0ZFsguKN8lUA3pGX5bQp00JrWw14LPv+TffTlcGDV16seBGKeWpTSR9MUPnRUPFaN
 CvvhEtzF7KKR1PSbzneYAGYmQ0q57qHbXoVSewXxSWo0DaSjJ3e1lyCRS82A52lmcecbp+Ec3/9
 GPa0ukH24FR6TmbQ5xIb8cdr2thsjQkipiO0
X-Received: by 2002:a05:622a:60e:b0:466:a51b:6281 with SMTP id
 d75a77b69052e-46771efb88amr26917821cf.26.1733775709095; 
 Mon, 09 Dec 2024 12:21:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFySbay1kQ0chmDDUysJLDryRhcXxoFZeJBWPYj5IXssLYqn/0Z6VW+NtlLZd0vmlvOjx2hGw==
X-Received: by 2002:a05:622a:60e:b0:466:a51b:6281 with SMTP id
 d75a77b69052e-46771efb88amr26917381cf.26.1733775708684; 
 Mon, 09 Dec 2024 12:21:48 -0800 (PST)
Received: from [10.222.168.90] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46768b530f0sm11175221cf.64.2024.12.09.12.21.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 12:21:48 -0800 (PST)
Message-ID: <3fb7853c-a04e-46ba-9b69-f36012f25e26@oss.qualcomm.com>
Date: Mon, 9 Dec 2024 14:21:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/20] target: Implement CPUClass::datapath_is_big_endian
 (big-endian)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier
 <lvivier@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair.francis@wdc.com>,
 Anton Johansson <anjo@rev.ng>, Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair@alistair23.me>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20241204202602.58083-1-philmd@linaro.org>
 <20241204202602.58083-16-philmd@linaro.org>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20241204202602.58083-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 92JW9vFJfht1dLe10VN6bExHV38Cet6t
X-Proofpoint-GUID: 92JW9vFJfht1dLe10VN6bExHV38Cet6t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 clxscore=1015 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090158
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


On 12/4/2024 2:25 PM, Philippe Mathieu-Daudé wrote:
> For all targets which have endianness architecturally
> predefined as big endian (built using TARGET_BIG_ENDIAN=y),
> their datapath_is_big_endian() handler simply returns %true.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/hexagon/cpu.c  | 6 ++++++
>   target/hppa/cpu.c     | 6 ++++++
>   target/m68k/cpu.c     | 6 ++++++
>   target/openrisc/cpu.c | 6 ++++++
>   target/s390x/cpu.c    | 6 ++++++
>   5 files changed, 30 insertions(+)
>
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 020038fc490..6407ed80c59 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -245,6 +245,11 @@ void hexagon_debug(CPUHexagonState *env)
>       hexagon_dump(env, stdout, CPU_DUMP_FPU);
>   }
>   
> +static bool hexagon_cpu_datapath_is_big_endian(CPUState *cs)
> +{
> +    return true;
> +}
> +
>   static void hexagon_cpu_set_pc(CPUState *cs, vaddr value)
>   {
>       cpu_env(cs)->gpr[HEX_REG_PC] = value;
> @@ -342,6 +347,7 @@ static void hexagon_cpu_class_init(ObjectClass *c, void *data)
>                                          &mcc->parent_phases);
>   
>       cc->class_by_name = hexagon_cpu_class_by_name;
> +    cc->datapath_is_big_endian = hexagon_cpu_datapath_is_big_endian;
>       cc->has_work = hexagon_cpu_has_work;
>       cc->dump_state = hexagon_dump_state;
>       cc->set_pc = hexagon_cpu_set_pc;


For hexagon:

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> index c38439c1800..8ccd224f2a4 100644
> --- a/target/hppa/cpu.c
> +++ b/target/hppa/cpu.c
> @@ -203,6 +203,11 @@ static void hppa_cpu_initfn(Object *obj)
>       cpu_hppa_put_psw(env, PSW_W);
>   }
>   
> +static bool hppa_cpu_datapath_is_big_endian(CPUState *cs)
> +{
> +    return true;
> +}
> +
>   static ObjectClass *hppa_cpu_class_by_name(const char *cpu_model)
>   {
>       g_autofree char *typename = g_strconcat(cpu_model, "-cpu", NULL);
> @@ -245,6 +250,7 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
>                                       &acc->parent_realize);
>   
>       cc->class_by_name = hppa_cpu_class_by_name;
> +    cc->datapath_is_big_endian = hppa_cpu_datapath_is_big_endian;
>       cc->has_work = hppa_cpu_has_work;
>       cc->mmu_index = hppa_cpu_mmu_index;
>       cc->dump_state = hppa_cpu_dump_state;
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index 5fe335558aa..52f8db41d5a 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -24,6 +24,11 @@
>   #include "migration/vmstate.h"
>   #include "fpu/softfloat.h"
>   
> +static bool m68k_cpu_datapath_is_big_endian(CPUState *cs)
> +{
> +    return true;
> +}
> +
>   static void m68k_cpu_set_pc(CPUState *cs, vaddr value)
>   {
>       M68kCPU *cpu = M68K_CPU(cs);
> @@ -571,6 +576,7 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
>                                          &mcc->parent_phases);
>   
>       cc->class_by_name = m68k_cpu_class_by_name;
> +    cc->datapath_is_big_endian = m68k_cpu_datapath_is_big_endian;
>       cc->has_work = m68k_cpu_has_work;
>       cc->mmu_index = m68k_cpu_mmu_index;
>       cc->dump_state = m68k_cpu_dump_state;
> diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
> index b96561d1f26..16e39b43ec4 100644
> --- a/target/openrisc/cpu.c
> +++ b/target/openrisc/cpu.c
> @@ -25,6 +25,11 @@
>   #include "fpu/softfloat-helpers.h"
>   #include "tcg/tcg.h"
>   
> +static bool openrisc_cpu_datapath_is_big_endian(CPUState *cs)
> +{
> +    return true;
> +}
> +
>   static void openrisc_cpu_set_pc(CPUState *cs, vaddr value)
>   {
>       OpenRISCCPU *cpu = OPENRISC_CPU(cs);
> @@ -257,6 +262,7 @@ static void openrisc_cpu_class_init(ObjectClass *oc, void *data)
>                                          &occ->parent_phases);
>   
>       cc->class_by_name = openrisc_cpu_class_by_name;
> +    cc->datapath_is_big_endian = openrisc_cpu_datapath_is_big_endian;
>       cc->has_work = openrisc_cpu_has_work;
>       cc->mmu_index = openrisc_cpu_mmu_index;
>       cc->dump_state = openrisc_cpu_dump_state;
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 514c70f3010..eda1e3b286f 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -44,6 +44,11 @@
>   #define CR0_RESET       0xE0UL
>   #define CR14_RESET      0xC2000000UL;
>   
> +static bool s390_cpu_datapath_is_big_endian(CPUState *cs)
> +{
> +    return true;
> +}
> +
>   #ifndef CONFIG_USER_ONLY
>   static bool is_early_exception_psw(uint64_t mask, uint64_t addr)
>   {
> @@ -390,6 +395,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
>                                          &scc->parent_phases);
>   
>       cc->class_by_name = s390_cpu_class_by_name,
> +    cc->datapath_is_big_endian = s390_cpu_datapath_is_big_endian;
>       cc->has_work = s390_cpu_has_work;
>       cc->mmu_index = s390x_cpu_mmu_index;
>       cc->dump_state = s390_cpu_dump_state;

