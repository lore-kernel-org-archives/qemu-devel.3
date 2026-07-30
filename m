Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0F4C55164
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 16:02:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpTC6-0000aA-Jb; Thu, 30 Jul 2026 12:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wpTBb-0000Rb-2h
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 12:00:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wpTBW-0000UR-LD
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 12:00:40 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UFR1HW1475295
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 16:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZZnWUwB8MT+HtKLiz5Zy6bJJBXkfbqKyVQyDUw48AtI=; b=fpAuer8s6RPm3QBh
 YNGiMZY+Svhb7VMaJbJfXtMc1omW7M0s6g8P6ugsdTnhTcXFD5Jljcio0cwbVXfV
 LxVQPl4dx6wyqbzB23vULGcMGdKkZ6B/40VDTOtGtYep8ktNouY1uzsiGWkZIPRd
 wdpuOVVCC8DrXS8d+1mQY6kmByxVSxD5Y2/+hQI6xPDjT2LxrCgSIwzCf0YZ9fbB
 pT7JQPDlXrBEaTe26Yv5qEEliXZ4V8wSCQZk52k4MgfNtnz5XA9ilHCsT6hyO9oo
 ga8nrzTvGRW/OmKNgSAxOzH9cWuGTbLOlcv4bWWDkCpDSIJsIq6Gd9Tjq2HV/WfW
 uTbmtQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr7q3gq99-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 16:00:26 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5174a236220so23301911cf.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 09:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785427226; x=1786032026; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZZnWUwB8MT+HtKLiz5Zy6bJJBXkfbqKyVQyDUw48AtI=;
 b=GkMmgdTC+lhLxJhvOg9e/MXu1OuRZ3bJeLyVTUmuw0E0ZZg3vFWGXBSLMcPwjwGkOF
 r2JVFXIGZz5sbcTVGZs+jbwODQ6+A0wV9xIPmpdCiAiYq/ZBtf/I7qNhuHS2PunNyqBg
 6NPJzurfrQzl7cDWQWzql8GIR9lO2s7tfl6/DFQ0dKbPXdIV+L8lI36uYTln1nRLGOTB
 539OldSSjgFt4Rzrh2ZrnKRyzzjKeRrGbDCAolm/VS2cSKt1diuWe++udA3HF8SFlV9F
 C8eJyN1USxrOESsIEeeYX3at+dxCs098KsdZRsfI0d2RiUdsAOPFwvsDfb+HpQyC1Hi1
 nFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785427226; x=1786032026;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZZnWUwB8MT+HtKLiz5Zy6bJJBXkfbqKyVQyDUw48AtI=;
 b=RbFygK8ggAUIs7fqD1Nh7THoLCpmpiigZhcEHDZE30idIHaOUpAF/ZLG8Z8RRaVJvN
 xhGOMMF+qXVF1tNBqNCUtCdtEK5UdM95HPSOTjfpxgkz4/sHe9R7F1QaQB+4vE6saWmf
 G20JEkC2MqQfesqoTVF1SXffKZlGyOYR5Jm3O0sNDACtb/86EEoJo1X7haEZlf/w2eez
 JTNZ39KALZxDllpB+hTCUUoGq9BkpQEJm+x/1SLKJUVY84AWSLGfsHQrXCBHD5HZV7jd
 2PWmP9Q8uJx33Zl/CPxreQ9BPEUND0v+qSq/giQlWtA0e/xzHtUICnJJrvg/KKFHyRyf
 zDIQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpR3xkC0kLOHE60D0bWth8qLqoHCylts9WzjB77DrbzxsyNLGUg25kXsEMKmFZRlkyS0NUz5AxTNVe2@nongnu.org
X-Gm-Message-State: AOJu0YwmYS7PUYxPep4e2zBYfmXlaaojkkbOS05z3CevMDW+E9Vibzrj
 P+ndIxAD3w8KDpl4q6hbyRBhOXdhS9S4aob7qUZT8bbqawQ3381/R6PJyB3CWoN+e2v+1WXyCZA
 +jdPHgGbo6xdH10ePexfV/D3QJ+ZtTYMbwveejzX7DrmeDS7RfxNWkQ6HdA==
X-Gm-Gg: AR+sD10vOVUSkWVV8P67n2ZBexD7PFvBnnhZhafamucjO3bmgPB7YdLPrHV+qcB7T/p
 9F5gtajb2IGArCjrJSipovLEYv1vqAnEFxtl4L65ukYtZfJeIMR6TUxENIqqAsmYqNJE9oOpot9
 BZZhbngLrzMfkRwwGqys4CWrgCvt4rnTTdCSinE1e8+tkb+HrLnWKamRAWGHgPpVHp+JeuCib8z
 LQlbNbojawiFgCvI/I9FjnzOrrd7e7d+cE8iMeam3bvcb3ofEN8fIJWgLmpTKCShBiUxeTvVc3R
 8PiUPg/fDi8CX1LY4KN2hmqx668UC7QXNQgzqr1AS8qLm52ywUEsARQLsxXn1SOxTZgGCH6g8Pu
 zzwEOCotiTeGYWHXesXnES7+tLHQl1rj64ZSKKYcQITnjAp2pkis=
X-Received: by 2002:ac8:5d45:0:b0:517:78c7:d93a with SMTP id
 d75a77b69052e-52b42b14b70mr9187211cf.16.1785427225103; 
 Thu, 30 Jul 2026 09:00:25 -0700 (PDT)
X-Received: by 2002:ac8:5d45:0:b0:517:78c7:d93a with SMTP id
 d75a77b69052e-52b42b14b70mr9185801cf.16.1785427224215; 
 Thu, 30 Jul 2026 09:00:24 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49801216694sm64868195e9.13.2026.07.30.09.00.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 09:00:23 -0700 (PDT)
Message-ID: <d4dba8be-4982-4125-b447-cdb2de1ad060@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 18:00:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/19] hvf: Simplify post reset/init/loadvm hooks
To: Alexander Graf <agraf@csgraf.de>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 qemu-arm <qemu-arm@nongnu.org>, Frank Yang <lfy@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Collingbourne <pcc@google.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20210519202253.76782-1-agraf@csgraf.de>
 <20210519202253.76782-13-agraf@csgraf.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20210519202253.76782-13-agraf@csgraf.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfX8Dp7zjtqHjRB
 d/DMBndQrUTYWVuG93qZ1Ti5/p2xyvkMpHKmEUTC1qh7Ov94n3LSr+eIco82A3xc2P4ofs0S+V0
 xMrXlGKDTf89LGdDG7hbIiXQb2G/gAbgBxV7HHzlVSUuaxSx8bRLmPb+zFYMjgEBF9Ew1rQb6qd
 1GIfsAaTkdwWcsfwhgwflwbUuu/EZto4TG5Fg2rIUrKA1b9iQqm/d/ZnS++m7WllIX49u9j0DyD
 D/1Y/jgieDGUGMVt6hAgnacySBUp18ARMC6e1/sXgjCtr7yjpEr3H1gAjCo+mHSaa7S2FH5uUEZ
 QX3oBnNZhmwdjZXZzz5Uzio6gODE0hSPtM7P+4WbU8pLnm0aieWVxfz/GV+VyfYBH30UrUeKJWV
 i4O8KyUW0GyXS4P4sFmYxrx9waR/3UMUs88x5envZbcKIuakfMw1rLlTxPy4JY0XV5Y1PApzXyE
 +KrfxfLSzKFdxPHEJKA==
X-Proofpoint-GUID: QYc-F5dk9wk4FhTbe56jnxjbeg-aHNo6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfX4EXddVM4eDMY
 GnFtDAzj4I0USvOdrAibU4cjB/YwCPrP7nLn25ZzBvMzfoBY/svh6n2LUvK/1D10ec1Ky9LnuI3
 a0sWBRaCPAcBvUqjWF7MX13sWEapkgU=
X-Proofpoint-ORIG-GUID: QYc-F5dk9wk4FhTbe56jnxjbeg-aHNo6
X-Authority-Analysis: v=2.4 cv=WuQb99fv c=1 sm=1 tr=0 ts=6a6b751a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=-c9VzbpeAAAA:8 a=S-XO_F0Q7lEhHcZk_GEA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=WAq88MDkwfy8HpmZFCM0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300120
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hi Alex,

(old patch committed as bac969ef30e8a8b73acbeb6d68abff6f68b2056c)

On 19/5/21 22:22, Alexander Graf wrote:
> The hooks we have that call us after reset, init and loadvm really all
> just want to say "The reference of all register state is in the QEMU
> vcpu struct, please push it".
> 
> We already have a working pushing mechanism though called cpu->vcpu_dirty,
> so we can just reuse that for all of the above, syncing state properly the
> next time we actually execute a vCPU.
> 
> This fixes PSCI resets on ARM, as they modify CPU state even after the
> post init call has completed, but before we execute the vCPU again.
> 
> To also make the scheme work for x86, we have to make sure we don't
> move stale eflags into our env when the vcpu state is dirty.
> 
> Signed-off-by: Alexander Graf <agraf@csgraf.de>
> Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
> Tested-by: Roman Bolshakov <r.bolshakov@yadro.com>
> ---
>   accel/hvf/hvf-accel-ops.c | 27 +++++++--------------------
>   target/i386/hvf/x86hvf.c  |  5 ++++-
>   2 files changed, 11 insertions(+), 21 deletions(-)
> 
> diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
> index ded918c443..d1691be989 100644
> --- a/accel/hvf/hvf-accel-ops.c
> +++ b/accel/hvf/hvf-accel-ops.c
> @@ -205,39 +205,26 @@ static void hvf_cpu_synchronize_state(CPUState *cpu)
>       }
>   }
>   
> -static void do_hvf_cpu_synchronize_post_reset(CPUState *cpu,
> -                                              run_on_cpu_data arg)
> +static void do_hvf_cpu_synchronize_set_dirty(CPUState *cpu,
> +                                             run_on_cpu_data arg)
>   {
> -    hvf_put_registers(cpu);
> -    cpu->vcpu_dirty = false;
> +    /* QEMU state is the reference, push it to HVF now and on next entry */
> +    cpu->vcpu_dirty = true;
>   }
>   
>   static void hvf_cpu_synchronize_post_reset(CPUState *cpu)
>   {
> -    run_on_cpu(cpu, do_hvf_cpu_synchronize_post_reset, RUN_ON_CPU_NULL);
> -}
> -
> -static void do_hvf_cpu_synchronize_post_init(CPUState *cpu,
> -                                             run_on_cpu_data arg)
> -{
> -    hvf_put_registers(cpu);
> -    cpu->vcpu_dirty = false;
> +    run_on_cpu(cpu, do_hvf_cpu_synchronize_set_dirty, RUN_ON_CPU_NULL);
>   }
>   
>   static void hvf_cpu_synchronize_post_init(CPUState *cpu)
>   {
> -    run_on_cpu(cpu, do_hvf_cpu_synchronize_post_init, RUN_ON_CPU_NULL);

Since we are not calling hvf_put_registers() anymore, any reason to keep
using run_on_cpu()? I think it is safe to update the field out of the
vCPU thread context, it will be consumed by the thread during the next
inner loop run, no need to schedule to the vCPU work queue. But I'm out
of my confort zone here so might be wrong.

> -}
> -
> -static void do_hvf_cpu_synchronize_pre_loadvm(CPUState *cpu,
> -                                              run_on_cpu_data arg)
> -{
> -    cpu->vcpu_dirty = true;
> +    run_on_cpu(cpu, do_hvf_cpu_synchronize_set_dirty, RUN_ON_CPU_NULL);
>   }
>   
>   static void hvf_cpu_synchronize_pre_loadvm(CPUState *cpu)
>   {
> -    run_on_cpu(cpu, do_hvf_cpu_synchronize_pre_loadvm, RUN_ON_CPU_NULL);
> +    run_on_cpu(cpu, do_hvf_cpu_synchronize_set_dirty, RUN_ON_CPU_NULL);
>   }

