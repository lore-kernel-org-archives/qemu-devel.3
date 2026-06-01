Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F509CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 19:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU8ES-0000ku-6J; Mon, 01 Jun 2026 15:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wU8EQ-0000ki-N5
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 15:23:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wU8EP-00061K-0t
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 15:23:26 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651FUOlD145069
 for <qemu-devel@nongnu.org>; Mon, 1 Jun 2026 19:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eivEoWUOIolkbWpZznf6zjx2/bkna8k/mL8lyQjc8rI=; b=HhNwFwR+JON6Q9pc
 S8QJl8UPuT8WKUUi5LREMy4iX4I7xNJX7Akq0MhJJ3zeJPCatZKiXFyyfmgZHwjQ
 BVr3RQ6HUzfES3fhe5rfb3ykh16Z4+gmE5LfqS6OsuWceETmGl3HezjJbju6wX0p
 mDJR/aWgESzVYRFEtsAUPQuZxeLeUGLgjmcSLNlK/YAvu93EIWlX3rqDUbnU0lLr
 C3mCdk77cjoa/AKRyZgnlr6axcN2EX4RGWEEGd3YI9jLjFSrRkk7G4LTx4YluzRK
 caOK7nd0nZi6D4AyOi3QAJPRalMKmg3FvT24Hp+Fr1gcCE5jzqOUi4ozuSd9KPTg
 MncInw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6sttmvf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 19:23:23 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304e7fc90b1so3634497eec.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 12:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780341802; x=1780946602; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eivEoWUOIolkbWpZznf6zjx2/bkna8k/mL8lyQjc8rI=;
 b=jQrKccd8NmpTEVgCIpvEqITDXTilHIO6/YvK7y3PCnoS5JJNRVfCSuQHRi/vlN7MVR
 xktkvqE00jnoysMDPilSbzNrgPL607ONn5sHAPp320cBBoVDBow3etJeUwEBEwBimpjm
 0H80V774k1f8gGEp5zl1lW1HkQePzFpXcvFnd7X8csJ4ZBuaag95Xp7RbsL7G93JjyxZ
 vFEO9nQfPi8TnV8J45n89Vo4CDzLufR6FTYP7sNZfRvUO0yydqYXeAGWd+Z5/J2hXfwL
 HXM6S9o2rV5lL/KqsEvhHWZ7qP5G5/ZbejMJbQu4X50Z7x9aueoFsO1mYuvDLSXeZFXL
 UbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780341802; x=1780946602;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eivEoWUOIolkbWpZznf6zjx2/bkna8k/mL8lyQjc8rI=;
 b=g2Qnzoa/sW7U6LgBp4E/yBJbWvxS543JPg35OJZoUVtMc2htp/JNJHwfs+4N1r8YbE
 JFvokI926knzht+xateGZ4ChMA81z6JcdjXuQzjfN81QOshXo3Z5FDHhCSCYuuLeqBRJ
 lgUXqq5yjRYObVwjN5RChHl+XZgK66eoSGIv2o+3Ep8CqenuGLJP8L+sBUmaeb1SDzBl
 YIxJG8cmVEiIjs72Wqu6KHfjVLqR8da0stQlCaUkh4+MGLowP517JnaW9xfMiRqe3cRY
 cNrzvYMMupzTFSn4RHIO8ZpYX/WpyUJiwlsHrHneLHpvEh+cPcyuRmy05xlTFkwbkyzH
 YQyg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ht8NuNiA6ar0w7NReSEnPuXwsfoDcVFNB0/IvoDwtwElkPKJ8rxGEFPm7cmT+sDp2cOjPWSBPe7aG@nongnu.org
X-Gm-Message-State: AOJu0YxHzy/a0jaIIX9mhpjmLW34TsTi1GCJT5gt8yXG+WvVHtamqiax
 OWvdwnSrRnb+aYZqBCvI0XnEgiMVfvMu8xfVCcZTxYh+KvQnnNVG+P9b9nTp3cxGmv8zQRM0hZq
 UG7icQVnoIsczGcL6sjd6Y3Xx0uWdeDJkHn55x06OZIgqSnnw6+xQwovG2w==
X-Gm-Gg: Acq92OEfI5CnEPI5ExHsuEqGLreh+BRcLwwp10KOTYMMFigZnRqkj7BaYI56C9kVExM
 o/klgp8Jf0UHosFIEYWOMFFKJsP2UUfkQ9mEiklv/31yi0GVNMJUwCJywIBrCcrLXEN4QgMxtgD
 PiJjqBjCK3uXQc9moXkdSQPBI6qQifqvbHOu3i04LbNT71RxYDzefQo1V2kjrvKYNZKHEDLceID
 lggxJtEag/7CBNcMh0/YegIbBoIHFrzJxJXU4oMZb8p3s2hx8jS5mI8B8sIcM3q1WWzEvulIBp2
 YoKMOP20ImxUfZKfB7eMsN0Aa9pEpRUKX6uaz444QK1il1c3XhyxknHcaNxrzdi5Hjo3YAbIdIf
 kBF/5jxEQdddjGAMbrpZhuioDxB7wvWVjBSksoOszP875MoTXF0W1+U2xTp9QhtwZQ+UaWCrE1a
 oWRBgDx8mGiIKSMHRjUhgfLVy1
X-Received: by 2002:a05:7022:ff48:b0:133:598c:2b1a with SMTP id
 a92af1059eb24-137d426f3famr5431135c88.41.1780341802306; 
 Mon, 01 Jun 2026 12:23:22 -0700 (PDT)
X-Received: by 2002:a05:7022:ff48:b0:133:598c:2b1a with SMTP id
 a92af1059eb24-137d426f3famr5431119c88.41.1780341801647; 
 Mon, 01 Jun 2026 12:23:21 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137b35a6019sm6682968c88.2.2026.06.01.12.23.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2026 12:23:21 -0700 (PDT)
Message-ID: <1835eaa9-c9ca-45b7-a5de-3ac653aa535e@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 12:23:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/28] target/hexagon: Implement setprio, resched
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
References: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
 <20260529215806.608770-16-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260529215806.608770-16-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE4OSBTYWx0ZWRfXxRpqpzbv0AlW
 w368KzIKb9KQDklx94ZnrvAS7x6k3Fc0ne9EX9Y1SpgfeP/pU59Wr0ZhkSXpdlIGmZn8HKfAw5y
 vtOKdXFtRr10pVH+oqhUWkcXsEafwR9HJLIaS+rOEyNYfrEEcBMT0p+H5SBHrRgnHb130/x8Yp4
 zxgP7ZE/a5bRWRYlKeDEFiQHEU+0/rc5RpM/DGkqs8rFlXxJZaar6+pjYJi0ph/k6xaDMXUUeXe
 HxY+OgfGFXxrIjm0Gz8xYwX8cVZQLFjOBUMVDgG58PM5A0VQQOyEp8PU0yHE36SXMw5tvYJ/4d9
 VZFHQ3mEV8m9gCQDa8Qpx15sqgCWsdWjSYnUIuUAFnur9pR1Qv/oE0yaVvyb4ccBEfBnBcv8CTt
 oVKvF4eDYGV993GolwkckRZTUH2uWRLqQo/BPgG9egxAVvLP7TFa2TwqBre2O4uC4uQy/05Eka1
 49Z3nJuokcaGpdPe1XQ==
X-Proofpoint-ORIG-GUID: 1qxLHJYNpQZadbsnzTIni6JQvzdOlBlL
X-Authority-Analysis: v=2.4 cv=HrNG3UTS c=1 sm=1 tr=0 ts=6a1ddc2b cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=1smrgXH-ueQkYea9A80A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 1qxLHJYNpQZadbsnzTIni6JQvzdOlBlL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606010189
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 5/29/2026 2:57 PM, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> The hardware-assisted scheduler helps manage tasks on the run queue
> and interrupt steering.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/op_helper.c | 77 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 64f1fb2043f..82062a2f802 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -1589,6 +1589,64 @@ static void hexagon_wait_thread(CPUHexagonState *env, uint32_t PC)
>      cpu_interrupt(cs, CPU_INTERRUPT_HALT);
>  }
>  
> +static inline QEMU_ALWAYS_INLINE void resched(CPUHexagonState *env)
> +{
> +    uint32_t schedcfg;
> +    uint32_t schedcfg_en;
> +    int int_number;
> +    CPUState *cs;
> +    uint32_t lowest_th_prio = 0; /* 0 is highest prio */
> +    uint32_t bestwait_reg;
> +    uint32_t best_prio;
> +    HexagonCPU *cpu;
> +
> +    BQL_LOCK_GUARD();
> +    qemu_log_mask(CPU_LOG_INT, "%s: check resched\n", __func__);
> +    cpu = env_archcpu(env);
> +    schedcfg = cpu->globalregs ?
> +        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_SCHEDCFG,
> +                               env->threadId) : 0;
> +    schedcfg_en = GET_FIELD(SCHEDCFG_EN, schedcfg);
> +    int_number = GET_FIELD(SCHEDCFG_INTNO, schedcfg);
> +
> +    if (!schedcfg_en) {
> +        return;
> +    }
> +

Is that really a noop in this case?
Or should it trigger an exception if sched is not enabled?

> +    CPU_FOREACH(cs) {
> +        HexagonCPU *thread = HEXAGON_CPU(cs);
> +        CPUHexagonState *thread_env = &(thread->env);
> +        uint32_t th_prio = GET_FIELD(
> +            STID_PRIO, thread_env->t_sreg[HEX_SREG_STID]);
> +        if (!hexagon_thread_is_enabled(thread_env)) {
> +            continue;
> +        }
> +
> +        lowest_th_prio = (lowest_th_prio > th_prio)
> +            ? lowest_th_prio
> +            : th_prio;
> +    }
> +
> +    bestwait_reg = cpu->globalregs ?
> +        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_BESTWAIT,
> +                               env->threadId) : 0;
> +    best_prio = GET_FIELD(BESTWAIT_PRIO, bestwait_reg);
> +
> +    /*
> +     * If the lowest priority thread is lower priority than the
> +     * value in the BESTWAIT register, we must raise the reschedule
> +     * interrupt on the lowest priority thread.
> +     */
> +    if (lowest_th_prio > best_prio) {
> +        qemu_log_mask(CPU_LOG_INT,
> +                "%s: raising resched int %u,"
> +                " cur PC 0x%" PRIx32 "\n",
> +                __func__, (unsigned)int_number, env->gpr[HEX_REG_PC]);
> +        SET_SYSTEM_FIELD(env, HEX_SREG_BESTWAIT, BESTWAIT_PRIO, ~0);
> +        hex_raise_interrupts(env, 1 << int_number, CPU_INTERRUPT_SWI);
> +    }
> +}
> +
>  void HELPER(wait)(CPUHexagonState *env, uint32_t PC)
>  {
>      BQL_LOCK_GUARD();
> @@ -1697,8 +1755,27 @@ uint64_t HELPER(greg_read_pair)(CPUHexagonState *env, uint32_t reg)
>      g_assert_not_reached();
>  }
>  
> +/*
> + * setprio/resched - hardware-assisted scheduler helpers for managing
> + * the run queue and interrupt steering.
> + */
>  void HELPER(setprio)(CPUHexagonState *env, uint32_t thread, uint32_t prio)
>  {
> +    CPUState *cs;
> +
> +    BQL_LOCK_GUARD();
> +    CPU_FOREACH(cs) {
> +        HexagonCPU *found_cpu = HEXAGON_CPU(cs);
> +        CPUHexagonState *found_env = &found_cpu->env;
> +        if (thread == found_env->threadId) {
> +            SET_SYSTEM_FIELD(found_env, HEX_SREG_STID, STID_PRIO, prio);
> +            qemu_log_mask(CPU_LOG_INT,
> +                          "%s: tid %" PRIu32 " prio = 0x%" PRIx32 "\n",
> +                          __func__, found_env->threadId, prio);
> +            resched(env);
> +            return;
> +        }
> +    }
>      g_assert_not_reached();
>  }
>  


