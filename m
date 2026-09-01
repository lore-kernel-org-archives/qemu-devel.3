Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68504C624CF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1LBw-0001gb-Ab; Tue, 01 Sep 2026 05:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1LBu-0001UW-Nz
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:54:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1LBs-0007ey-8W
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:54:06 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68179CjC2061542
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 09:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iq9jdgwknAqHi+A61S3waOB2xPWYBPg93iEmiqYW4xU=; b=enpyympL13ZNlNMo
 pxERSDKMHZBh8ai0+6LHqtuwi8jt1oz63ffGRr7mR5xdHuDWoVYfMFzusNixsAiU
 Yghd2TM3C+jfU0Pknheks/ev6ClT5/beaXAus6YNYhQbK9bqcRgFSeh9Q+J5M9Zy
 QZUcVou2nW2bsaBm/MjHdsJefCtpmqv3arALfAOLJxJ8jIWR2gFQMhtEF71K8jcz
 Jga7MDVmAXqTiPPwXuuYValKkm0VRgKv28zWD2++/zioWIcp8LlOMw9+OprKgCvV
 Deoh9q30X+8Y60LOemW+pg15P14K4y/a5jQJBLzvRQEfDkoNwHSUFbp7+pDbZQlg
 4UCuhw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdqbh1dxk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 09:54:03 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-936e393061dso526968485a.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 02:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788256443; x=1788861243; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iq9jdgwknAqHi+A61S3waOB2xPWYBPg93iEmiqYW4xU=;
 b=Eemvjf/oGEi5CGN61r0eDzVsWGK8jz65HLpirSl2j/9XPK3yNzWNc3Db3jVOxNK1+F
 o86yGlzbxPH4IaH/xgfi1BA+Rg0OLfRD62woMdHiUjXYSIlqC3bCQqtJrrMUmRi+3bCZ
 wGoTTr741xliFf63WJUSrC4SkfxRk7x1nM+j2GRfWOJfphYtYGKqpXKE7FFQExgWye0O
 SpLkGb+cdGg1DK1Qic/HfiRwxc040c4Lc+7yCWhoW51bimk49j17ZQb2IWkPUOmZoroC
 j5H1FrqUzCA4Xv9vYO9ZohusWMt64uCaGScR1nf0Ru2TTMQCF45Qm/RxcHTZDlrKA0Rn
 RvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788256443; x=1788861243;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iq9jdgwknAqHi+A61S3waOB2xPWYBPg93iEmiqYW4xU=;
 b=U/NeEsv4jbp4gHmmYLTzynZHOrkyu/8fSYnTRCX9Jld5F9VIEAfe4oU7CgIZaRHbnw
 YURzqoMO9YE75SSgFKot09emNg6u0va8vdCKmwZQ4tgjXV4uWBiH+0PYPuTe0PCLZHmY
 +NhVGNF1k/TfBH9UEmmdQvgkoZbVh4yE1xTR1QKbkaRTCPvEL9UGTRhvSSgHRxra9lMM
 MOdDbnFtAtdr+Mo5/VeGpxx+3wA4DiGtR1sa2kjKTrYLn3WPH3URKCpHqozgB8HrwmuS
 8lVAkNB1mouE3pnkh45IWQgHBq+UmnWgeE0cwyOwhbMgmbr18nXYHtMIjtW2l4cwKJ3i
 sxrg==
X-Gm-Message-State: AFuF++mMSsRIYFFj8Z8nqRKb/IiOUgK0fUEIr7guWAZXHdEUMsNW9WyE
 3RoPpDQyS81c8NtRwQzsVMAFUilkHa4tUZ7UAov6bnA635g4MMe6iH3p9FR2CyFGu+oRBA8Q9N7
 u3sD5AXiA8lS66bu3gSzpmbe1uRBIcTEzBo2orh1wFJfNJvSjxoGcQNLC2Q==
X-Gm-Gg: AR+sD11bGaMXAwPhxWjIrB8UEqKR2rqib26i38Qvp1lnkH/N1480Coo4jEfO87xWuBI
 ZdJHHn9ZVNdDvOgS+/cj85oosYFZfKff71TLY8ewmWzYN4sY1aUypCe2Ae8maA4SVtmKA8zv4Mp
 46z4MB/hh6zHZzJqUXOIdbaIGak8kUdi3qJF/zip8aMHj0WVoIDXWDeYPc4CucSCmzuCG3QVTTI
 iA07pkrwYSVm34elCfPh73/NGOfjGg9ZDsPD1hiNUcvNKRJ1wgF2P3S/2ImFKGad+g/dDhk/rcy
 szTZ32VVzc0tCbpkOJcy+0S/cM832nt4OlGG/TLAljn+9gdrbp27clBcg8Fm/TZW8UGARmKj3y+
 GU1oDYqC7NrOqW6HAFTWmCt2s7qsqiHhhqQ==
X-Received: by 2002:a05:620a:319f:b0:939:1d86:94aa with SMTP id
 af79cd13be357-9391d869669mr3087066285a.39.1788256442466; 
 Tue, 01 Sep 2026 02:54:02 -0700 (PDT)
X-Received: by 2002:a05:620a:319f:b0:939:1d86:94aa with SMTP id
 af79cd13be357-9391d869669mr3087059585a.39.1788256441712; 
 Tue, 01 Sep 2026 02:54:01 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce3e04csm50466335e9.10.2026.09.01.02.54.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 02:54:00 -0700 (PDT)
Message-ID: <c4520ad1-fed0-4778-8986-423894484dda@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 11:53:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] target/arm: Extract halt-to-exec transition out of
 arm_cpu_exec_halt()
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
 <20260819145649.23439-7-philmd@oss.qualcomm.com>
 <44833559-f73d-4b8c-acec-a3e86b98c393@linaro.org>
 <CAFEAcA8xk8y1W0UvttpVhKYuoMBSQqZoF_15of0Rrq4wKkWDuw@mail.gmail.com>
 <bbe4b7d0-96ad-45d8-a5a9-0be2c5479d51@oss.qualcomm.com>
In-Reply-To: <bbe4b7d0-96ad-45d8-a5a9-0be2c5479d51@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfX3Ichr+XBeg6y
 EBZ1qQmEYjvbUOc/EOAA2bQla44TAxul/Qi2mjEIBZaXTgscwBdbJCSQypekcMuSCFgk6Pih5iP
 oTjD+BURzQpNIH2okXo3IFDDPfod88c=
X-Authority-Analysis: v=2.4 cv=R9wz39RX c=1 sm=1 tr=0 ts=6a96a0bb cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=wJeXnacMAHlAobrEISUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: no86Ul4ZHTQhEyTVZK3MUyu0_bYEfMS6
X-Proofpoint-ORIG-GUID: no86Ul4ZHTQhEyTVZK3MUyu0_bYEfMS6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfXxd9rYXEh7Yxd
 VPuwLBuBDvlDHex/PLUm2MfnnXrwsCiyOqfsS5ckIaeqnvLX8DHeC2nW6La1zGukPdz4nEM7fR2
 YwrB1owxFRGvxBZd5E6jSm/bw3wmMAyaxJDlsEv9esNl8J208bYG761Fu4bdcCgt94uF3PkDODU
 YBMyb34XMGTrTTwyaxaGH0D9EkBhfbKrnrmE0/fpQGkdebV4DYzQ19GLP1WyLvbdIeFFfuWEajP
 H4mS0EBFYMpaVFCPnxLHWWYwQc4KyKcFMKnOW+HPODcp4KbUv/Z5cPcf7cNUvQCMWis9SzksDK8
 IrWtDkT5izYe9JuDRDWXNvwlWJFei8Erjs9FQdDi7IP8I3/mAwR9PTsjMjc/R1PZEXSlfx1WPMq
 6tavfklDcqi12gNkxKGlDHIZieKGE8iPZUmlDJYx2iSG4BkQ8gqUACkqtTM4aVFMJlT+VoS/eib
 9rsTBoyQCof+p+VlKIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010087
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 20/8/26 09:29, Philippe Mathieu-DaudÃ© wrote:
> On 2026-08-19 23:40, Peter Maydell wrote:
>> On Wed, 19 Aug 2026 at 21:14, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>>
>>> On 8/19/26 07:56, Philippe Mathieu-Daudé wrote:
>>>> Refactor the target-specific halt-to-execution transition
>>>> logic (disable WFE/WFI timers, clear the halt_reason flag)
>>>> into a separate arm_cpu_transition_halt_to_exec() function.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>>> ---
>>>>    target/arm/cpu.c | 22 +++++++++++++++-------
>>>>    1 file changed, 15 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>>>> index 77aa78f00e2..8e9b584559d 100644
>>>> --- a/target/arm/cpu.c
>>>> +++ b/target/arm/cpu.c
>>>> @@ -870,18 +870,26 @@ static bool 
>>>> arm_cpu_internal_is_big_endian(CPUState *cs)
>>>>    }
>>>>
>>>>    #ifdef CONFIG_TCG
>>>> +static void arm_cpu_transition_halt_to_exec(CPUState *cs)
>>>> +{
>>>> +    ARMCPU *cpu = ARM_CPU(cs);
>>>> +
>>>> +    assert(cpu_has_work(cs));
>>>
>>> In reply to patch 11 you suggest removing this.
>>> I wonder why you added it in the first place.
>>
>> Does the accel loop enforce that we hold the BQL when
>> arm_cpu_exec_halt() is called?
> 
> For MTTCG:
> 
> mttcg_cpu_thread_fn()
> {
>    bql_lock();
>    while (1)
>      qemu_process_cpu_events(cpu);
>      if (cpu_can_run(cpu)) {
>        bql_unlock();
>        tcg_cpu_exec(cpu);
>          cpu_exec(cpu);
>            if (cpu->halted) {
>              cpu_has_work_after_processing_async_events(cpu);
>                process_async_events(cpu);
>                  x86_cpu_process_async_events(); // APIC takes BQL
>                cpu_has_work(cpu);
>                transition_halt_to_exec(cpu);
>                  arm_cpu_transition_halt_to_exec(); // timer_lock
>                  x86_cpu_transition_halt_to_exec();
>          ...
>        bql_lock();
>        ...
> }
> 
> void x86_cpu_process_async_events()
> {
>      /* (BQL not held) */
>      if (cpu_test_interrupt()) {
>          bql_lock();
>          apic_poll_irq();
>            apic_sync_vapic();
>            apic_update_irq();
>              cpu_interrupt();
>          cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
>          bql_unlock();
>      }
> }
> 
> void arm_cpu_transition_halt_to_exec()
> {
>      /* (BQL not held) */
>      timer_del();
>        qemu_mutex_lock();
>        timer_del_locked();
>        qemu_mutex_unlock();
> }
> 
> void x86_cpu_transition_halt_to_exec()
> {
>      /* (BQL not held) */
>      do_interrupt_all();
>        handle_even_inj();
>        x86_ldl_phys(VMCB);
>          address_space_ldl_le(VMCB);
>            device MMIO?
>        x86_stl_phys(VMCB);
>          address_space_stl_le(VMCB);
>            device MMIO?
> }
> 
> VMCB address is guest-controlled, it comes from the guest %EAX
> register passed to the VMRUN instruction (see helper_vmrun).
> (I'm not looking further at the SVM specification).
> 
>> If not then the assertion
>> is racy, because something might get in and e.g. lower
>> an IRQ line so that cpu_has_work() is no longer true
>> (which would be fine -- it just means we made the decision
>> to wake up and that won vs the incoming interrupt).
>>
>> On the one hand, if we don't have the BQL in has_work and
>> exec_halt then we should be a lot more careful about how
>> we code them (e.g. use of the right kind of atomics, and
>> there's no way the call to do_interrupt_all() in the x86
>> exec_halt can be safe without the BQL, surely).
>>
>> On the other hand, if we do have the BQL in exec_halt
>> then why is the x86 implementation explicitly taking
>> the BQL when it calls apic_poll_irq()?
> 
> This analysis is similar before this series applied.
> I don't have any idea how to proceed, I suppose from
> here you expect Paolo / Richard to provide their feedback.

This seems to be a non-blocking comment that can be
clarified and addressed later.

