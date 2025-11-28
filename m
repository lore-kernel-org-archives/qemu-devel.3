Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 679D8D116E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 17:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vP25O-0000Ie-Df; Fri, 28 Nov 2025 12:16:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vP25D-0000FZ-Bi
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 12:16:37 -0500
Received: from m228-31.mailgun.net ([159.135.228.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vP25B-00010Q-15
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 12:16:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=yodel.dev; q=dns/txt;
 s=pdk1; t=1764350186; x=1764357386; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: From:
 References: Cc: To: To: Subject: Subject: MIME-Version: Date: Message-ID:
 Sender: Sender; 
 bh=kVPqIWbAQVzj3HJ6TPE2Ta1uUY3xaDUfApM6tKVANEI=;
 b=yZt1goJ9Ul9PrMIiFJL5wcyVufM3VhXqE/+il8DM5RJG8nAqdvhsREHdf73XZQWuNxOdwenW/mMYtXbN5qr4ORmqdZ9h9ZATGxjQWhcP0KD02QnJqQG47I1G316BRp3o5vAka+0UDTJBHZsjS1FPdzSBf76ISqxn4g2OWC2KPVLyltcNHChBBqJ28/QS4QHMpIOxENC1MUuidKoGWOobyqikA5+huruUobNBZRKo9ipCdPYqOwJTF2XZ8Udi9xCg4MJCuzQz/wfDY7zE8upEjX+IiJ9X/AHsE2vw5sqGtu6dsMksC5usC5zgnQjZWseG0DlcCEk8cBc79ZENjyrPuA==
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 fed2b422af59685bb39c1d89339d1a5d87bcb5909889464ce16ce832d4c3fb2c with SMTP id
 6929d8ea92080432d8436894; Fri, 28 Nov 2025 17:16:26 GMT
X-Mailgun-Sending-Ip: 159.135.228.31
Message-ID: <1a92fec0-4dcb-43e7-9748-a0a9fbb01cfb@yodel.dev>
Date: Fri, 28 Nov 2025 11:16:24 -0600
MIME-Version: 1.0
Subject: Re: [RFC PATCH] plugins: shorten aggressively long name
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20251121130317.2874416-1-alex.bennee@linaro.org>
 <7b2af00b-b188-43ab-bb0c-f041ab45ebb0@yodel.dev>
Content-Language: en-US
Autocrypt: addr=yodel.eldar@yodel.dev; keydata=
 xjMEZxqXdhYJKwYBBAHaRw8BAQdAkletQdG3CLyANZyuf2t7Z9PK4b6HiT+DdSPUB2mHzmPN
 I1lvZGVsIEVsZGFyIDx5b2RlbC5lbGRhckB5b2RlbC5kZXY+wpkEExYKAEECGwMFCQOcG00F
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQTTzRjNQG27imap+N+V7k+3NmVNrAUCaNWASwIZ
 AQAKCRCV7k+3NmVNrNnSAPoDjQXa6v7ZzdQSaLdRfAQy/5SsUucv+zp3WAP4pXdgJQEAzMMC
 Ctx4l6b13Fs2hZdRXEnF/4BZ9t1K68nwzZOV3QnOOARnGpd2EgorBgEEAZdVAQUBAQdAKPIy
 3W/DKFsm1e+31zoqmOY0pqz8vjIM846wM6lEY2QDAQgHwn4EGBYIACYCGwwWIQTTzRjNQG27
 imap+N+V7k+3NmVNrAUCaNWG7QUJA5wi9wAKCRCV7k+3NmVNrPusAQCQDQwETy7VT6UhHPho
 TkrQnsNqQfFU3tXqCTiViToktQD7B/U2/to97hQIJCWbK6yd3T+KPZJPMcHMg2XRyedUvgA=
In-Reply-To: <7b2af00b-b188-43ab-bb0c-f041ab45ebb0@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=159.135.228.31;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=m228-31.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Yodel Eldar <yodel.eldar@yodel.dev>
From:  Yodel Eldar via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 28/11/2025 10:40, Yodel Eldar via wrote:
> Hi, Alex!
> 
> On 21/11/2025 07:03, Alex Bennée wrote:
>> The old name comes in at a 51 characters, contains at least one
>> redundant token and exec is arguably implied by inline as all inline
>> operations occur when instructions are executing.
>>
>> By putting the name on a substantial diet we can reduce it by 15% and
>> gain valuable white-space in the process.
> 
> Thanks for proposing this: 51 characters does seem rather excessive!
> 
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>   include/qemu/qemu-plugin.h    |  4 ++--
>>   contrib/plugins/cflow.c       | 22 +++++++++++-----------
>>   contrib/plugins/howvec.c      |  2 +-
>>   contrib/plugins/stoptrigger.c | 10 ++++++----
>>   plugins/api.c                 |  2 +-
>>   tests/tcg/plugins/discons.c   | 18 +++++++++---------
>>   tests/tcg/plugins/inline.c    |  6 +++---
>>   tests/tcg/plugins/insn.c      |  5 +++--
>>   8 files changed, 36 insertions(+), 33 deletions(-)
>>
>> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
>> index 60de4fdd3fa..29663591ebf 100644
>> --- a/include/qemu/qemu-plugin.h
>> +++ b/include/qemu/qemu-plugin.h
>> @@ -516,7 +516,7 @@ void qemu_plugin_register_vcpu_insn_exec_cond_cb(
>>       void *userdata);
>>   /**
>> - * qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu() - insn exec 
>> inline op
>> + * qemu_plugin_register_inline_per_vcpu() - insn exec inline op
>>    * @insn: the opaque qemu_plugin_insn handle for an instruction
>>    * @op: the type of qemu_plugin_op (e.g. ADD_U64)
>>    * @entry: entry to run op
>> @@ -525,7 +525,7 @@ void qemu_plugin_register_vcpu_insn_exec_cond_cb(
>>    * Insert an inline op to every time an instruction executes.
>>    */
>>   QEMU_PLUGIN_API
>> -void qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
>> +void qemu_plugin_register_inline_per_vcpu(
>>       struct qemu_plugin_insn *insn,
>>       enum qemu_plugin_op op,
>>       qemu_plugin_u64 entry,
> 
> Could we preserve naming consistency with its sibling functions, tb and 
> mem, by, say, removing the "_per_vcpu" thereby implying thread-safety
> instead? I.e.,
> 
> qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu ->
> qemu_plugin_register_vcpu_insn[_exec]_inline
> 
> qemu_plugin_register_vcpu_mem_inline_per_vcpu ->
> qemu_plugin_register_vcpu_mem_inline
> 
> qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu ->
> qemu_plugin_register_vcpu_tb[_exec]_inline
> 
> Since the series, 20240304130036.124418-1-pierrick.bouvier@linaro.org,
> that introduced the cycle also removed the non-thread-safe versions in
> fba3b490a, perhaps we could recycle the retired names sans the arguably
> redundant "exec."
> 
> If we do remove the "exec" tokens, we should probably do the same for
> the corresponding callback functions, too:
> 
> qemu_plugin_register_vcpu_insn_exec_cb ->
> qemu_plugin_register_vcpu_insn_cb ->
> 
> qemu_plugin_register_vcpu_tb_exec_cb ->
> qemu_plugin_register_vcpu_tb_cb
> 

Nevermind about the callbacks: these don't enjoy implication via 
"inline." Sorry about the noise.


> Thanks,
> Yodel
> 
>> diff --git a/contrib/plugins/cflow.c b/contrib/plugins/cflow.c
>> index b5e33f25f9b..cef5ae2239f 100644
>> --- a/contrib/plugins/cflow.c
>> +++ b/contrib/plugins/cflow.c
>> @@ -320,14 +320,14 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, 
>> struct qemu_plugin_tb *tb)
>>        * check where we are at. Do this on the first instruction and not
>>        * the TB so we don't get mixed up with above.
>>        */
>> -    qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(first_insn,
>> -                                                      
>> QEMU_PLUGIN_INLINE_STORE_U64,
>> -                                                      end_block, 
>> qemu_plugin_insn_vaddr(last_insn));
>> -    qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(first_insn,
>> -                                                      
>> QEMU_PLUGIN_INLINE_STORE_U64,
>> -                                                      pc_after_block,
>> -                                                      
>> qemu_plugin_insn_vaddr(last_insn) +
>> -                                                      
>> qemu_plugin_insn_size(last_insn));
>> +    qemu_plugin_register_inline_per_vcpu(first_insn,
>> +                                         QEMU_PLUGIN_INLINE_STORE_U64,
>> +                                         end_block, 
>> qemu_plugin_insn_vaddr(last_insn));
>> +    qemu_plugin_register_inline_per_vcpu(first_insn,
>> +                                         QEMU_PLUGIN_INLINE_STORE_U64,
>> +                                         pc_after_block,
>> +                                         
>> qemu_plugin_insn_vaddr(last_insn) +
>> +                                         
>> qemu_plugin_insn_size(last_insn));
>>       for (int idx = 0; idx < qemu_plugin_tb_n_insns(tb); ++idx) {
>>           struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, 
>> idx);
>> @@ -355,9 +355,9 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, 
>> struct qemu_plugin_tb *tb)
>>           }
>>           /* Store the PC of what we are about to execute */
>> -        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(insn,
>> -                                                            
>> QEMU_PLUGIN_INLINE_STORE_U64,
>> -                                                            last_pc, 
>> ipc);
>> +        qemu_plugin_register_inline_per_vcpu(insn,
>> +                                             
>> QEMU_PLUGIN_INLINE_STORE_U64,
>> +                                             last_pc, ipc);
>>       }
>>   }
>> diff --git a/contrib/plugins/howvec.c b/contrib/plugins/howvec.c
>> index 42bddb6566d..c60737d57f1 100644
>> --- a/contrib/plugins/howvec.c
>> +++ b/contrib/plugins/howvec.c
>> @@ -321,7 +321,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, 
>> struct qemu_plugin_tb *tb)
>>           if (cnt) {
>>               if (do_inline) {
>> -                qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
>> +                qemu_plugin_register_inline_per_vcpu(
>>                       insn, QEMU_PLUGIN_INLINE_ADD_U64,
>>                       qemu_plugin_scoreboard_u64(cnt), 1);
>>               } else {
>> diff --git a/contrib/plugins/stoptrigger.c b/contrib/plugins/ 
>> stoptrigger.c
>> index b3a6ed66a7b..68c0ed432af 100644
>> --- a/contrib/plugins/stoptrigger.c
>> +++ b/contrib/plugins/stoptrigger.c
>> @@ -73,10 +73,12 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, 
>> struct qemu_plugin_tb *tb)
>>           if (exit_on_icount) {
>>               /* Increment and check scoreboard for each instruction */
>> -            qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
>> -                insn, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, 1);
>> -            qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
>> -                insn, QEMU_PLUGIN_INLINE_STORE_U64, current_pc, 
>> insn_vaddr);
>> +            qemu_plugin_register_inline_per_vcpu(insn,
>> +                                                 
>> QEMU_PLUGIN_INLINE_ADD_U64,
>> +                                                 insn_count, 1);
>> +            qemu_plugin_register_inline_per_vcpu(insn,
>> +                                                 
>> QEMU_PLUGIN_INLINE_STORE_U64,
>> +                                                 current_pc, 
>> insn_vaddr);
>>               qemu_plugin_register_vcpu_insn_exec_cond_cb(
>>                   insn, exit_icount_reached, QEMU_PLUGIN_CB_NO_REGS,
>>                   QEMU_PLUGIN_COND_EQ, insn_count, icount + 1, NULL);
>> diff --git a/plugins/api.c b/plugins/api.c
>> index eac04cc1f6b..267fa2fd503 100644
>> --- a/plugins/api.c
>> +++ b/plugins/api.c
>> @@ -154,7 +154,7 @@ void qemu_plugin_register_vcpu_insn_exec_cond_cb(
>>                                          cond, entry, imm, udata);
>>   }
>> -void qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
>> +void qemu_plugin_register_inline_per_vcpu(
>>       struct qemu_plugin_insn *insn,
>>       enum qemu_plugin_op op,
>>       qemu_plugin_u64 entry,
>> diff --git a/tests/tcg/plugins/discons.c b/tests/tcg/plugins/discons.c
>> index 2e0e664e823..1348d6e5020 100644
>> --- a/tests/tcg/plugins/discons.c
>> +++ b/tests/tcg/plugins/discons.c
>> @@ -156,15 +156,15 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, 
>> struct qemu_plugin_tb *tb)
>>           uint64_t next_pc = pc + qemu_plugin_insn_size(insn);
>>           uint64_t has_next = (i + 1) < n_insns;
>> -        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(insn,
>> -                                                            
>> QEMU_PLUGIN_INLINE_STORE_U64,
>> -                                                            last_pc, 
>> pc);
>> -        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(insn,
>> -                                                            
>> QEMU_PLUGIN_INLINE_STORE_U64,
>> -                                                            from_pc, 
>> next_pc);
>> -        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(insn,
>> -                                                            
>> QEMU_PLUGIN_INLINE_STORE_U64,
>> -                                                            has_from, 
>> has_next);
>> +        qemu_plugin_register_inline_per_vcpu(insn,
>> +                                             
>> QEMU_PLUGIN_INLINE_STORE_U64,
>> +                                             last_pc, pc);
>> +        qemu_plugin_register_inline_per_vcpu(insn,
>> +                                             
>> QEMU_PLUGIN_INLINE_STORE_U64,
>> +                                             from_pc, next_pc);
>> +        qemu_plugin_register_inline_per_vcpu(insn,
>> +                                             
>> QEMU_PLUGIN_INLINE_STORE_U64,
>> +                                             has_from, has_next);
>>           qemu_plugin_register_vcpu_insn_exec_cb(insn, insn_exec,
>>                                                  
>> QEMU_PLUGIN_CB_NO_REGS, NULL);
>>       }
>> diff --git a/tests/tcg/plugins/inline.c b/tests/tcg/plugins/inline.c
>> index 73dde995781..35307501105 100644
>> --- a/tests/tcg/plugins/inline.c
>> +++ b/tests/tcg/plugins/inline.c
>> @@ -244,15 +244,15 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, 
>> struct qemu_plugin_tb *tb)
>>           void *insn_store = insn;
>>           void *mem_store = (char *)insn_store + 0xff;
>> -        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
>> +        qemu_plugin_register_inline_per_vcpu(
>>               insn, QEMU_PLUGIN_INLINE_STORE_U64, data_insn,
>>               (uintptr_t) insn_store);
>>           qemu_plugin_register_vcpu_insn_exec_cb(
>>               insn, vcpu_insn_exec, QEMU_PLUGIN_CB_NO_REGS, insn_store);
>> -        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
>> +        qemu_plugin_register_inline_per_vcpu(
>>               insn, QEMU_PLUGIN_INLINE_ADD_U64, count_insn_inline, 1);
>> -        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
>> +        qemu_plugin_register_inline_per_vcpu(
>>               insn, QEMU_PLUGIN_INLINE_ADD_U64, insn_cond_track_count, 
>> 1);
>>           qemu_plugin_register_vcpu_insn_exec_cond_cb(
>>               insn, vcpu_insn_cond_exec, QEMU_PLUGIN_CB_NO_REGS,
>> diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
>> index 0c723cb9ed8..b337fda9f13 100644
>> --- a/tests/tcg/plugins/insn.c
>> +++ b/tests/tcg/plugins/insn.c
>> @@ -147,8 +147,9 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, 
>> struct qemu_plugin_tb *tb)
>>           struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
>>           if (do_inline) {
>> -            qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
>> -                insn, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, 1);
>> +            qemu_plugin_register_inline_per_vcpu(insn,
>> +                                                 
>> QEMU_PLUGIN_INLINE_ADD_U64,
>> +                                                 insn_count, 1);
>>           } else {
>>               qemu_plugin_register_vcpu_insn_exec_cb(
>>                   insn, vcpu_insn_exec_before, QEMU_PLUGIN_CB_NO_REGS, 
>> NULL);
> 
> 


