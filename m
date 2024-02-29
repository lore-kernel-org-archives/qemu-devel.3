Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79D0C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 09:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfcpF-000591-6L; Thu, 29 Feb 2024 04:35:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfcpC-00057s-W2
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 04:35:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfcp9-0005JZ-EA
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 04:35:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709199329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3a2ciMxSgcnuQof6zbJQOdIZu3T1nChKA+xWpQP27IU=;
 b=C0d6zTtWtwuxMdfTDcsvp6KnhuVosVJzZGZzf4G4ujJtp3vcjwNiPbZB738E2h6kN5FIPn
 mkNxcKFOKTRVG//XACbheCk6NAa5r1I6k75oegfiWz3BGWhvZsrumLfv7h0y0V2jRVOCSE
 ye0kJJSGk+2Bc5aim7T+T7MJVmTFNa0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-_kQHvkhHP62TbxEQ3Qk9gw-1; Thu, 29 Feb 2024 04:35:28 -0500
X-MC-Unique: _kQHvkhHP62TbxEQ3Qk9gw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a3e42733561so48322566b.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 01:35:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709199327; x=1709804127;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3a2ciMxSgcnuQof6zbJQOdIZu3T1nChKA+xWpQP27IU=;
 b=XLs0dh2VcM/GWx8arb6fd3RGOaOe4ZXUEc3e9gqUYgQ9RhBc8gf9NaqwWv+FWVf1aq
 lNLQYbMEZ2/K207TKNMCuriVWfRpZTuUOMw4S1rqgGIN8tTGhmzAX2m5K7Y0sYeChSCW
 6rg1JLi8o+hmWQwq+5MGnqRlKxB7kT7M65X29RuFkh6BTjNYnS8dEzr0COyN+iwIRMup
 mU70925YvwBPebMJLzzMyAxaz+j+vGGg5ad3wiSEnFYGpQxUK+Fmv1bMmOAjGXpAsdop
 MLACIuzobR6xqThIIBS0bXJ5vCE6b968fbarLeBNMZ6UHsRdyZlpxEi6KhBD8zJa/l68
 3Y0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiRrwXmOXWJi2T6xYbkhzmEh/kXGb35LuP8wzYO6AMWTm7aWlCnpOaI1Slmlv/rKl7pndPtabMB9ZKNYI4S3zV4uhWQgo=
X-Gm-Message-State: AOJu0YwsLlRN2HQJXmBv07GnQ20dj1ZoDJNl/3p3PBEhQq+Ihn1uvK04
 FzxCTk7iNjDuXUF2H7Ml8UwTw73Fi9s9VpcBXqxXKQmOQD4m3Drci+ZizmSyk1h/vBZ42EGlo+e
 PnMphGzIrny4/rJTgiTXsUn21AcXTWJtNXOSs1z6EfspDUHuAXYkz
X-Received: by 2002:a50:cbc1:0:b0:566:5897:b3ba with SMTP id
 l1-20020a50cbc1000000b005665897b3bamr933238edi.3.1709199326910; 
 Thu, 29 Feb 2024 01:35:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFHFgrqpI5EA/y/BC2pGipYwU2YDCqvi06nC3v+7hf17uU5WRcGNy2uJhSd6UzjVDZt7e1ow==
X-Received: by 2002:a50:cbc1:0:b0:566:5897:b3ba with SMTP id
 l1-20020a50cbc1000000b005665897b3bamr933224edi.3.1709199326544; 
 Thu, 29 Feb 2024 01:35:26 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e?
 ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.googlemail.com with ESMTPSA id
 a10-20020a50ff0a000000b005665a6e07fcsm439543edu.30.2024.02.29.01.35.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 01:35:26 -0800 (PST)
Message-ID: <8c623e70-80ab-4058-b898-8eb38e95f1e3@redhat.com>
Date: Thu, 29 Feb 2024 10:35:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] tcg/optimize: optimize TSTNE using smask and zmask
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240228111151.287738-1-pbonzini@redhat.com>
 <20240228111151.287738-5-pbonzini@redhat.com>
 <4362aeec-ae18-4515-a3ec-6aba811e17d1@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <4362aeec-ae18-4515-a3ec-6aba811e17d1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/29/24 00:10, Richard Henderson wrote:
> On 2/28/24 01:11, Paolo Bonzini wrote:
>> -    /* TSTNE x,sign -> LT x,0 */
>> -    if (arg_is_const_val(*p2, (ctx->type == TCG_TYPE_I32
>> -                               ? INT32_MIN : INT64_MIN))) {
>> +    /* TSTNE x,i -> LT x,0 if i only includes sign bit copies */
>> +    if (arg_is_const(*p2) && (arg_info(*p2)->val & ~i1->s_mask) == 0) {
> 
> This is a good idea, but s_mask isn't defined like you think -- it is 
> *repetitions* of the sign bit, but not including the sign bit itself.  
> For INT64_MIN, s_mask == 0.
> 
> So for TSTNE min,min, (min & ~0) != 0, so the test won't pass.

Oh! So I have to squash:

diff --git a/tcg/optimize.c b/tcg/optimize.c
index ab976a5bbe7..44d1b1a6d8a 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -140,6 +140,12 @@ static inline bool arg_is_const_val(TCGArg arg, uint64_t val)
      return ts_is_const_val(arg_temp(arg), val);
  }
  
+/* Calculate all the copies of the sign bit, both redundant and not. */
+static inline uint64_t all_sign_bit_copies(TempOptInfo *info)
+{
+    return (info->s_mask >> 1) | INT64_MIN;
+}
+
  static inline bool ts_is_copy(TCGTemp *ts)
  {
      return ts_info(ts)->next_copy != ts;
@@ -825,7 +831,7 @@ static int do_constant_folding_cond1(OptContext *ctx, TCGOp *op, TCGArg dest,
      }
  
      /* TSTNE x,i -> LT x,0 if i only includes sign bit copies */
-    if (arg_is_const(*p2) && (arg_info(*p2)->val & ~i1->s_mask) == 0) {
+    if (arg_is_const(*p2) && (arg_info(*p2)->val & ~all_sign_bit_copies(i1)) == 0) {
          *p2 = arg_new_constant(ctx, 0);
          *pcond = tcg_tst_ltge_cond(cond);
          return -1;


I tested with

    movq $0xffffffff80000000, %rbx
    test %ebx, %ebx
    js y

and I get

  brcond_i64 cc_dst,$0x80000000,tstne,$L1

which works and matches your explanation:

  i1.s_mask == 0xffffffff00000000
  i2.val == 0x80000000
  all_sign_bit_copies(i1) == 0xffffffff80000000
  u2.val & ~all_sign_bit_copies(i1) == 0

Thanks!

Paolo


