Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BA5C98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 16:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9QAt-0007eB-1M; Wed, 23 Sep 2026 12:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9QAr-0007dr-MP
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 12:50:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9QAp-0007CS-SY
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 12:50:25 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NGTqqO3082027
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 16:50:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IiwpiEHow/kT46mIuZNA7mWZKSgveyBMoAIUqvnnmjQ=; b=gTKSaGJFXIAS815p
 4Q0GOmYXu3+47gVr/s5fvVbl2CuIeqrAIDAOVH3IQoCzzY2Q9rRB3AnTBQeGH0PO
 T9AMGLKkTpvQ/fTzxvDcvDWUp1e/QxAlsRU9hL33V1mIHccHiGuwLP32VKvrj5lW
 DmSZ8axRpVn/u0OgwDXVqAMud71E3UJb7EB6kaXQyn0P/tljvCrsClFT+2uaoEMm
 mSR1Eydh4FP5vnalu92URW9PV7FkGLjquuEh7B0SjZzGRbYTAjMwjtHd3fkBgKad
 6GHvYFMtjngdIvPSNQA7XXM6Cq8OVf34mqWKJ1Vj/+Pe4S0IBz5+wFCzQ5CFn1AJ
 J0nKsA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvbx7hxbh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 16:50:21 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9393ac4961fso144995685a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 09:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790182220; x=1790787020; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IiwpiEHow/kT46mIuZNA7mWZKSgveyBMoAIUqvnnmjQ=;
 b=gHg8xa8wzt9d1wcsU/6YzaN+RlKhBcITLzc+Lyhx6FM9r9JQ76aGrfKOFQ+TUUHdBz
 n+5rAA7SOm5ZlCRfi9le2VHLfl3OUdHs8eBg4ddd8dEgc7V/tyqGO5V9F3WuySj29dzB
 KnTNyS4QO/KDrPXmLWS14bk3YqYI39LGuj220l2Eav1GSJHJe8zky9RVniwCDY6q8aB2
 OMlatLi4Z1c0Jtb/3aZYNPLMMhXHTK0zmSrE3OpMML0PgmHaRuqEodF8z7gu4tF9/7LJ
 YCB/URGKvZJXz4Fc1Hw6fqUaLIwPFE6u+2Hzy/qKImbX1siI+R/Yw+h9zj7IjUR0R5oe
 53WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790182220; x=1790787020;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IiwpiEHow/kT46mIuZNA7mWZKSgveyBMoAIUqvnnmjQ=;
 b=EhskBqxzWyzQb1IsNJObS0Yrw5AX1qEwXMcqHANP4YwFkV24ldLyUzgNYfWhawwm20
 dtGFOdr5wjshoa95lfscH5owI3KwOVHhOl/pNoeXWAe7vR/Q6lJNJ6kaH/NSBN8p1aaU
 gt6qVn4soOCHLFH7+WXtigQQE3YQ4OG8y3xRpSejJW3PA8elgk9SFfZUSHTw40TnObJs
 aPuGcjZIrLNuynTVjxNC5mb+8SuS22lwPb/OdssYHe7/71voPc6XbNmhyBJ9/gRCRlJT
 2qrgS56qRnVRc3lpPOYnGWxRhpers07XXGNwg+fYpnZ/8TSPd0XBT/tYmFqNYYqoKJ3z
 559w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxS7dXKq7Eojh+r5ttyl4d73UA4fsZ383RLBCnsOyzTvTwACBsj8fadE1pEAlCPDDEdvYK1yu++S9zq@nongnu.org
X-Gm-Message-State: AFuF++neqkcVpG7vjoWIa/O2JSC6Fv+5OK1MHashAwF9i++0mncfI1eq
 oSje1EB8cMlBuyJZVaAKKyoiILuvODEnk8DEe49JWDiR2WIE3M3QmXntwGhL67L1DujVm/aN0va
 UYsbmepwN3LBjGFRJ/AWVArX738MiuOdjkUpG4VjIZ8QXms0gylT4RhHLmA==
X-Gm-Gg: AYBFou3QkD0EKrTIfM2ClGO1aLChhFt1FhJVLUtYXgTiL13OCHw8FgPtPbCfzbfbk2n
 yI5vRE5pnm+j5HauuTPLfRhGZTMaAWvgzumidX88HmEDZv34awVBChm0MGtoYsHrutx3k+SHfbj
 PlPh36c6diuhMJK45Erl1gXt4UAlg+8A95uqJFjFWc66yNOIdpKdq/mDbJKYR5rMoPzWo1Ml9eJ
 NH8efElTqPrFkmSzIqajYy0OG+QVWaks5wt/TbofaSRny7zdg6wVeSbhUUgB6mCqC3EM10beEr/
 Z7LjWVKRC2nBSvprjqPu+S0rP2GP0KXwO+cKgNAmXj6f7rnnZvIGsqGzNytXpYu8EVUc0cRgTrR
 luBJScAgQTBeyygYMS2Y=
X-Received: by 2002:a05:620a:1725:b0:939:ec25:e58d with SMTP id
 af79cd13be357-93c250822ebmr502240985a.12.1790182219903; 
 Wed, 23 Sep 2026 09:50:19 -0700 (PDT)
X-Received: by 2002:a05:620a:1725:b0:939:ec25:e58d with SMTP id
 af79cd13be357-93c250822ebmr502236785a.12.1790182219346; 
 Wed, 23 Sep 2026 09:50:19 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.52])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe0c4b51bsm56032805e9.4.2026.09.23.09.50.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 09:50:18 -0700 (PDT)
Message-ID: <00c47d89-e4fe-4716-8e2a-3f2b06c553d1@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 18:50:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] target/arm: Extract halt-to-exec transition out of
 arm_cpu_exec_halt()
To: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
 <20260819145649.23439-7-philmd@oss.qualcomm.com>
 <44833559-f73d-4b8c-acec-a3e86b98c393@linaro.org>
 <CAFEAcA8xk8y1W0UvttpVhKYuoMBSQqZoF_15of0Rrq4wKkWDuw@mail.gmail.com>
 <bbe4b7d0-96ad-45d8-a5a9-0be2c5479d51@oss.qualcomm.com>
 <7766d96b-4065-4917-9d7d-094bd6d1f29c@oss.qualcomm.com>
 <5aba99f7-5310-4cd3-a38c-3e9b922c8b05@redhat.com>
 <CAFEAcA9tz=Br3dRe3mN1fPkjm4y36eRSWUMs=bU8zDbKczCCsg@mail.gmail.com>
 <CABgObfZQb8FwDubg=pZk6nRSrUgdMxoDpRwG3Kd=GwpQeccLhg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CABgObfZQb8FwDubg=pZk6nRSrUgdMxoDpRwG3Kd=GwpQeccLhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1SsH9y2rLnp988WOS8a1rwkt_s_dtafj
X-Authority-Analysis: v=2.4 cv=J4s/fwnS c=1 sm=1 tr=0 ts=6ab4034d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=QTt6BuOzr45adi7bDCnRgQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=2JhmitUAJ-Fta_9aMc8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2NyBTYWx0ZWRfX+syG5f8A9eYt
 PHYc3bQoIoznbDGI/4oWhL/+9beoYgGAn/XPmd9nIUQhjETCBd3bn1fZ7XP4XrWDxIgAoOd0S0b
 e/Q1ginRtSwtqTZngf9PVipKO6lNHWsytU9v8LcRWOOyxsBXSDYh5rxxs4+NA6Veg1qAlHzPQqc
 dv7SPWE+/Zwf2WqpGqtu4TcZjLk1NMIpLtB6G9gsbhLMcia1HvsjPX6cWHIflf+O9qFYVl5WnNf
 /rzQ0rZ1EzIxoOcODu5tEdbInGO4bGJEpFB2j8cQX27ZKhMeUPw9mn92kgKepEwritaC0XwpWyd
 166HAzku2qjOxmw11S2tkP4WR2y8fEFpO/jDZZxY/5sWqsK+/FPi6hQJgyKp2VPN+qAM8aNEAX1
 I+ZaiYnTLLNjR/YZ9Mh/erSelPj8cNQBn8qRMSE8QxaD29uyK+OFOVEH19PzdYlsMSWn1ptCFqT
 I7AyeD9b0fmovcPCN2A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2NyBTYWx0ZWRfX71Ur0+xq15bs
 ZwElRLPnhrZO0gLey0oQdjdRw+JjZSmHbcHgW4aHBstVlESh5EcWob6qn+JQKZwOaeMvaIRPH+3
 h/XhPgJUABmJq4jtUb2wFS7uEEKI8w4=
X-Proofpoint-GUID: 1SsH9y2rLnp988WOS8a1rwkt_s_dtafj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230067
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

Hi Paolo,

On 2026-09-08 11:29, Paolo Bonzini wrote:
> On Tue, Sep 8, 2026 at 10:40 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Mon, 7 Sept 2026 at 22:42, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>
>>> On 9/2/26 20:02, Philippe Mathieu-Daudé wrote:
>>>>>> On the other hand, if we do have the BQL in exec_halt
>>>>>> then why is the x86 implementation explicitly taking
>>>>>> the BQL when it calls apic_poll_irq()?
>>>>
>>>> Trying harder, my understanding is apic_poll_irq() only requires
>>>> the BQL for the apic_update_irq() call, not apic_sync_vapic().
>>>>
>>>> So maybe only apic_sync_vapic() belongs to process_async_events(),
>>>> leaving apic_update_irq() to transition_halt_to_exec().
>>>>
>>>> Paolo does that sound like going in the good direction?
>>> Unfortunately not, because apic_update_irq() is needed to call
>>> cpu_interrupt() and break out of halt.
>>>
>>> By the way... cpu_has_work_after_processing_async_events() is a bit
>>> long, what about simply cpu_poll_while_halted()?
>>>
>>> Answering Peter's question above, the way in which the code is protected
>>> against the BQL is basically two-fold: 1) kicking the CPU out of
>>> whatever it's doing, for example in tcg_handle_interrupt, 2) changing
>>> what other conditions affect cpu_has_work() only in the vCPU thread,
>>> e.g. with run_on_cpu.
>>
>> Ah, so it is called without the BQL held? That's quite unusual
>> for CPU methods, so we should clearly document that.
> 
> I agree.
> 
>> I bet also that most targets don't expect it. Picking one at
>> random, the sparc has_work function calls e.g. cpu_interrupts_enabled()
>> which does not look like a function that is expecting to be called
>> without the BQL.
> 
> Why? It only accesses fields for the local CPU. The problem is
> interprocedural communication, and only if it does not use
> cpu_interrupt().

> riscv -> sort of ok, uses BQL for register writes but should use
> qatomic_read/set as well


>> Is it OK for a has_work function to just take the BQL across
>> what it's doing if it doesn't want to be bothered with trying
>> to make the handling truly thread safe without a lock? That
>> seems to me like it would be a lot simpler and more reliable.
> 
> The simplest way to write has_work is to make it use only
> cpu_test_interrupt and checks on local registers. That is, use the
> synchronization provided by common code.
I don't understand well this last comment.

For RISCV "should use qatomic_read/set", should we use them
for all fields accessed by the has_work path?
I.e. riscv_cpu_all_pending() the first function called:

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c6b44e8f9c..597f1853c6 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -913,11 +913,17 @@ int riscv_cpu_pending_to_irq(CPURISCVState *env,
   */
  uint64_t riscv_cpu_all_pending(CPURISCVState *env)
  {
-    uint32_t gein = get_field(env->hstatus, HSTATUS_VGEIN);
-    uint64_t vsgein = (env->hgeip & (1ULL << gein)) ? MIP_VSEIP : 0;
-    uint64_t vstip = (env->vstime_irq) ? MIP_VSTIP : 0;
+    uint64_t hstatus = qatomic_read(&env->hstatus);
+    uint64_t hgeip = qatomic_read(&env->hgeip);
+    uint64_t mip = qatomic_read(&env->mip);
+    uint64_t mie = qatomic_read(&env->mie);
+    bool vstime_irq = qatomic_read(&env->vstime_irq);

-    return (env->mip | vsgein | vstip) & env->mie;
+    uint32_t gein = get_field(hstatus, HSTATUS_VGEIN);
+    uint64_t vsgein = (hgeip & (1ULL << gein)) ? MIP_VSEIP : 0;
+    uint64_t vstip = vstime_irq ? MIP_VSTIP : 0;
+
+    return (mip | vsgein | vstip) & mie;
  }
---

