Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82581C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 10:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRUnh-0005IE-BP; Wed, 10 Jul 2024 06:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRUnf-00059l-2i
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 06:43:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRUnd-0006oQ-BS
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 06:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720608227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MxsKH5X82ourv44/KesYvrt5B+mdgW8yxKBv7u0QmDs=;
 b=TJOpGGorb9Ry3xdbkGt+ovKnTlXL3DqwIuMX/5WxkG399GrcN8+XDUSEK/maYuL1iuwJS6
 h6WfWUik9hEYBoPPuIFiiBpaFxyIrwwGEjKQ8Uw1IDktKJ/pb0fb8joVYoudewRWw90yA6
 TVb0GQEzT+EqKHAAbJGsuQwKzGKrmC0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-zJjJBikVNYaKyL6TSwy7BQ-1; Wed, 10 Jul 2024 06:43:45 -0400
X-MC-Unique: zJjJBikVNYaKyL6TSwy7BQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52e969d34bbso6667887e87.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 03:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720608224; x=1721213024;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MxsKH5X82ourv44/KesYvrt5B+mdgW8yxKBv7u0QmDs=;
 b=B9Fd0ZB+0EkNhYkQ4OJKk5/28hhwwl+BC/50fU1m93D9UDsFGuU3Pp2N6wVLaFKy9A
 7DSqIEgd30w5WAQMu55G+Qlf+1IPxd5JXcIVGDj+bFxN1jhfn05tQ8eeNtYPL0X6+rse
 MK+5KmiUaa8ceabdY12ntjft0W9DmbDnEh+e9TTmXPRd7aXtjd+STyckO/4gGogzZLkj
 8cCPFbZdW/rGvrxi2QAaB/RdnABzf1v0wu2iSTneZME+pqSL4yqT24Zm8XUqd9rAxKZ7
 5J/0RAgeLwWISdkm4HMQnAvrCZGQH37GLo+1pk9Y3tNcoLsixUmiqqkiluqjbW2Ioo6o
 MUcw==
X-Gm-Message-State: AOJu0YzfSuUvIDKO6wxk4zYxcgCj5SHHj5y8Mwn4zyXUsEDCk21ojaoA
 u4hnSDSvPXYkMNxsafFpGhJkjD8n50kqXyawcbIFz2olHniaZiBHsOzsBedvU+MDI1mW87cuAIj
 Y4/6m8FDY2u+NLjJiNobP3KfeMxCfYUywpKL5+bW0I2CIvd4gLLuV
X-Received: by 2002:a19:f811:0:b0:52c:daac:bfba with SMTP id
 2adb3069b0e04-52eb99da0d8mr2071499e87.67.1720608224313; 
 Wed, 10 Jul 2024 03:43:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY16ffKb/QSL3Dl0SkWSJnbsITik2c88WtdqLO6CyKFdRwJfhW7E59FxlDF5DFo/mSVM6dQQ==
X-Received: by 2002:a19:f811:0:b0:52c:daac:bfba with SMTP id
 2adb3069b0e04-52eb99da0d8mr2071409e87.67.1720608219187; 
 Wed, 10 Jul 2024 03:43:39 -0700 (PDT)
Received: from [192.168.10.47] ([151.95.101.29])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4266f6f1138sm76106745e9.19.2024.07.10.03.43.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jul 2024 03:43:38 -0700 (PDT)
Message-ID: <0a94f7e1-611f-42bd-8fea-d3c940a26647@redhat.com>
Date: Wed, 10 Jul 2024 12:43:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 13/42] target/i386: use gen_writeback() within gen_POP()
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
References: <20240608083415.2769160-1-pbonzini@redhat.com>
 <20240608083415.2769160-14-pbonzini@redhat.com>
 <CAJ307EhO9MEk7=w62CGjYn9J3YGOPk0e7gRKMUGk57Wh0y75rg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAJ307EhO9MEk7=w62CGjYn9J3YGOPk0e7gRKMUGk57Wh0y75rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/10/24 11:42, Clément Chigot wrote:
> Hi Mark,
> 
> This patch introduces regressions in our x86_64 VxWorks kernels
> running over qemu. Some page faults are triggered randomly.
> 
> Earlier to this patch, the MemOp `ot` passed to `gen_op_st_v` was the
> `gen_pop_T0` created a few lines above.
> Now, this is `op->ot` which comes from elsewhere.
> 
> Adding `op->ot = ot` just before calling `gen_writeback` fixes my
> regressions. But I'm wondering if there could be some unexpected
> fallbacks, `op->ot` possibly being used afterwards.

Mark's patch is correct and the (previously latent) mistake is in
the decoding table.

The manual correctly says that POP has "default 64-bit" operand;
that is, it is 64-bit even without a REX.W prefix.  It must be
marked as "d64" rather than "v".

Can you test this patch?

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 0d846c32c22..d2da1d396d5 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1717,7 +1717,7 @@ static const X86OpEntry opcodes_root[256] = {
      [0x8C] = X86_OP_ENTRYwr(MOV, E,v, S,w, op0_Mw),
      [0x8D] = X86_OP_ENTRYwr(LEA, G,v, M,v, nolea),
      [0x8E] = X86_OP_ENTRYwr(MOV, S,w, E,w),
-    [0x8F] = X86_OP_GROUPw(group1A, E,v),
+    [0x8F] = X86_OP_GROUPw(group1A, E,d64),
  
      [0x98] = X86_OP_ENTRY1(CBW,    0,v), /* rAX */
      [0x99] = X86_OP_ENTRYwr(CWD,   2,v, 0,v), /* rDX, rAX */
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index fc7477833bc..36bb308e449 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -2788,6 +2788,8 @@ static void gen_POP(DisasContext *s, X86DecodedInsn *decode)
      X86DecodedOp *op = &decode->op[0];
      MemOp ot = gen_pop_T0(s);
  
+    /* Only 16/32-bit access in 32-bit mode, 16/64-bit access in long mode.  */
+    assert(ot == op->ot);
      if (op->has_ea || op->unit == X86_OP_SEG) {
          /* NOTE: order is important for MMU exceptions */
          gen_writeback(s, decode, 0, s->T0);

Thanks (and it's reassuring that everything else has worked fine
for you!),

Paolo

> Thanks,
> Clément
> 
> On Sat, Jun 8, 2024 at 10:36 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>
>> Instead of directly implementing the writeback using gen_op_st_v(), use the
>> existing gen_writeback() function.
>>
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Message-ID: <20240606095319.229650-3-mark.cave-ayland@ilande.co.uk>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   target/i386/tcg/emit.c.inc | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
>> index ca78504b6e4..6123235c000 100644
>> --- a/target/i386/tcg/emit.c.inc
>> +++ b/target/i386/tcg/emit.c.inc
>> @@ -2580,9 +2580,9 @@ static void gen_POP(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
>>
>>       if (op->has_ea) {
>>           /* NOTE: order is important for MMU exceptions */
>> -        gen_op_st_v(s, ot, s->T0, s->A0);
>> -        op->unit = X86_OP_SKIP;
>> +        gen_writeback(s, decode, 0, s->T0);
>>       }
>> +
>>       /* NOTE: writing back registers after update is important for pop %sp */
>>       gen_pop_update(s, ot);
>>   }
>> --
>> 2.45.1
>>
>>
> 
> 


