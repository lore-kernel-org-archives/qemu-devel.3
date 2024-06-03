Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D57C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 07:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE2Dg-0005eC-68; Mon, 03 Jun 2024 03:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sE2De-0005dm-1g
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 03:35:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sE2DY-0006Bg-KJ
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 03:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717400093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pzlj60hXJZkSaAHqM9e5SDa65gJbM+9C5zw9Qq6uKBQ=;
 b=Fy3NuhZs/wOnIj1czyAMwVDJtvqmJtBEkfqV5TGA5MN6F+JG3lcHgVkNrsRC2OTGeglo+O
 dyXkf1CjR78xdt6m/YqOPPPx1TjCKGgfEEV3MuGE0uwIFruJWmobhgB+Qe9NmZoSO8+RZ4
 eBQRavNF7Q7q3X+BCefuQJcJtmI1ZWA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-8x9aOaweMFe4ENfcAQPjCQ-1; Mon, 03 Jun 2024 03:34:51 -0400
X-MC-Unique: 8x9aOaweMFe4ENfcAQPjCQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-57a5af3e160so419027a12.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 00:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717400090; x=1718004890;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pzlj60hXJZkSaAHqM9e5SDa65gJbM+9C5zw9Qq6uKBQ=;
 b=TvT7wRRujp1q6pl3F+qKafEHkij5Lru3mMc/Cmlt/Qx0/Z3jlhJmfRPuOk+zBg3ON6
 TXZhsDpOm4qfHNstLUUoupo4PBlHXbhPZVJ4TgTU6Et1rnsc/SfwLXYDfu0BByJgfgzl
 hRVDEuy1DPM4inLbu+MOZGyELvdNr07Lt6o4MfXOouQsw+vWa5qLN46e9omwnRmZ6r46
 1weKoEVQv2jK6phT+2rLiX8BifaTW8m7SDCQDPVAXiw2/GXN/0o/0WkND8ezwEVILZHP
 S53ewlBHgiS+C+d8+yV1Yo3g0cXLDnlgB+PON7Ydjv/a0SQ1BDGk0KgNHJhjLbmuNjmX
 1kVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY6RsCgbQBo+wo6jIODhHh43T14LoTCk0kA3ZC9mukkpmd33IbI+bbB1VLQ3PeIdmRmobICj6kyf4i1VBhjqMUUO0KlzU=
X-Gm-Message-State: AOJu0YyOQ0kMhzO4sPV+8Mg207N7IFcmQfbvnDIGot/qcsjVwdprvmVm
 G+Dig7U3ldbofHrYtEii60w9pN9piupDfwW1Mg0D8U1g7FQzIjlhuv+sZbqf8XF2T1QEJwr/hdx
 w+zQ5zcRzmHW0h9HDeqpP6t9mNILxHOYygVPNfRzitGJuoVTvWggW
X-Received: by 2002:a17:906:56ca:b0:a68:f43f:6f31 with SMTP id
 a640c23a62f3a-a68f43f708fmr171330566b.64.1717400090273; 
 Mon, 03 Jun 2024 00:34:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdbrAKMjNm3cXoAx8tfdafT8nwxKOULWubCmXM0/2YogPhx0R676CBQYJ2znknWNQfhd1h0Q==
X-Received: by 2002:a17:906:56ca:b0:a68:f43f:6f31 with SMTP id
 a640c23a62f3a-a68f43f708fmr171329666b.64.1717400089829; 
 Mon, 03 Jun 2024 00:34:49 -0700 (PDT)
Received: from [192.168.10.81] ([151.81.115.112])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a6903514f26sm148399366b.209.2024.06.03.00.34.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 00:34:49 -0700 (PDT)
Message-ID: <38cded80-7454-4630-a1a0-e92727e127e8@redhat.com>
Date: Mon, 3 Jun 2024 09:34:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: fix memory opsize for Mov to/from Seg
To: lixinyu20s@ict.ac.cn, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, eduardo@habkost.net,
 Xinyu Li <lixinyu@loongson.cn>
References: <20240602100528.2135717-1-lixinyu20s@ict.ac.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240602100528.2135717-1-lixinyu20s@ict.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 6/2/24 12:05, lixinyu20s@ict.ac.cn wrote:
> From: Xinyu Li <lixinyu@loongson.cn>
> 
> This commit fixes an issue with MOV instructions (0x8C and 0x8E)
> involving segment registers by explicitly setting the memory operand
> size to 16 bits. It introduces a new flag X86_SPECIAL_MovSeg to handle
> this specification correctly.
> 
> Signed-off-by: Xinyu Li <lixinyu20s@ict.ac.cn>
> ---
>   target/i386/tcg/decode-new.c.inc | 12 ++++++++++--
>   target/i386/tcg/decode-new.h     |  2 ++
>   2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
> index 0ec849b003..ab7dbb45f9 100644
> --- a/target/i386/tcg/decode-new.c.inc
> +++ b/target/i386/tcg/decode-new.c.inc
> @@ -202,6 +202,7 @@
>   #define avx_movx .special = X86_SPECIAL_AVXExtMov,
>   #define sextT0 .special = X86_SPECIAL_SExtT0,
>   #define zextT0 .special = X86_SPECIAL_ZExtT0,
> +#define movseg .special = X86_SPECIAL_MovSeg,
>   
>   #define vex1 .vex_class = 1,
>   #define vex1_rep3 .vex_class = 1, .vex_special = X86_VEX_REPScalar,
> @@ -1576,9 +1577,9 @@ static const X86OpEntry opcodes_root[256] = {
>       [0x89] = X86_OP_ENTRY3(MOV, E,v, G,v, None, None),
>       [0x8A] = X86_OP_ENTRY3(MOV, G,b, E,b, None, None),
>       [0x8B] = X86_OP_ENTRY3(MOV, G,v, E,v, None, None),
> -    [0x8C] = X86_OP_ENTRY3(MOV, E,v, S,w, None, None),
> +    [0x8C] = X86_OP_ENTRY3(MOV, E,v, S,w, None, None, movseg),

Indeed this was a mistake, thanks!  The manual doesn't list it
in Table A-2, but the description of the instruction mentions
"r16/r32/m16" which is what you are implementing it.

>       [0x8D] = X86_OP_ENTRY3(LEA, G,v, M,v, None, None, noseg),
> -    [0x8E] = X86_OP_ENTRY3(MOV, S,w, E,v, None, None),
> +    [0x8E] = X86_OP_ENTRY3(MOV, S,w, E,v, None, None, movseg),

This is also wrong, but here the manual is correct.  It can be
written as "S,w, E,w" instead without special casing it.

Therefore the new X86InsnSpecial only needs to cover op[0]...

> +    /* Memory operand size of Mov to/from Seg is MO_16 */
> +    X86_SPECIAL_MovSeg,

... and I would call it Op0_Mw, for consistency with other similar
entries of X86InsnSpecial.

So I queued your patch with a few small changes:

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 51ef0e621b9..d6335597a13 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -203,6 +203,8 @@ typedef enum X86InsnSpecial {
      /* When loaded into s->T0, register operand 1 is zero/sign extended.  */
      X86_SPECIAL_SExtT0,
      X86_SPECIAL_ZExtT0,
+    /* Memory operand size of MOV from segment register is MO_16 */
+    X86_SPECIAL_Op0_Mw,
  } X86InsnSpecial;
  
  /*
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 0ec849b0035..599047df94a 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -202,6 +202,7 @@
  #define avx_movx .special = X86_SPECIAL_AVXExtMov,
  #define sextT0 .special = X86_SPECIAL_SExtT0,
  #define zextT0 .special = X86_SPECIAL_ZExtT0,
+#define op0_Mw .special = X86_SPECIAL_Op0_Mw,
  
  #define vex1 .vex_class = 1,
  #define vex1_rep3 .vex_class = 1, .vex_special = X86_VEX_REPScalar,
@@ -1576,9 +1577,9 @@ static const X86OpEntry opcodes_root[256] = {
      [0x89] = X86_OP_ENTRY3(MOV, E,v, G,v, None, None),
      [0x8A] = X86_OP_ENTRY3(MOV, G,b, E,b, None, None),
      [0x8B] = X86_OP_ENTRY3(MOV, G,v, E,v, None, None),
-    [0x8C] = X86_OP_ENTRY3(MOV, E,v, S,w, None, None),
+    [0x8C] = X86_OP_ENTRY3(MOV, E,v, S,w, None, None, op0_Mw),
      [0x8D] = X86_OP_ENTRY3(LEA, G,v, M,v, None, None, noseg),
-    [0x8E] = X86_OP_ENTRY3(MOV, S,w, E,v, None, None),
+    [0x8E] = X86_OP_ENTRY3(MOV, S,w, E,w, None, None),
      [0x8F] = X86_OP_GROUPw(group1A, E,v),
  
      [0x98] = X86_OP_ENTRY1(CBW,    0,v), /* rAX */
@@ -2514,6 +2515,13 @@ static void disas_insn(DisasContext *s,
          s->override = -1;
          break;
  
+    case X86_SPECIAL_Op0_Mw:
+        assert(decode.op[0].unit == X86_OP_INT);
+        if (decode.op[0].has_ea) {
+            decode.op[0].ot = MO_16;
+        }
+        break;
+
      default:
          break;
      }

Thank you very much!

Paolo


