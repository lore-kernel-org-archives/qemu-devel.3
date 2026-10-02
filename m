Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CE7CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 10:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCa5N-00033J-DB; Fri, 02 Oct 2026 06:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xCa5K-00031n-J4
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 06:01:46 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xCa5I-0001vt-Ny
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 06:01:46 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39d654f02baso3459188a91.3
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 03:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790935303; x=1791540103; darn=nongnu.org;
 h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
 :date:message-id:content-type:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kXTJu+ZKnj51ENSQNSDvDx7/Zmp6Fg9OCW+ZC739jnw=;
 b=UUNrp9quvuF6/Q26+rS9tMwlF6+/Qg8IGWmjucpSGhEWbWxI+qiPiB5792G0ufZHQA
 DS+e2LEvEyNgzovOc7NDjaQ6N0FTiSvcgvVJFnIrmuHQnbXYQjk98+J25gXPEU7/Idaq
 qA+iZ2GT4tLb1q7XP38uHjl1YhUgQWq3ugrl57C6vLp5bRIULYelWtpnfYIuYuNaYx+/
 PQmlgJUmkGmDMNok/g7iO96f5HHtePQC/hcJI3/bM1LhT4ghAujJypDzbWV3IaQtlTHv
 NziVPzKJnMxuRCl8Bx/6pNag4eS/Jcd4JGYSa8onp4/obUlSCV97ZmUvHh3a7hspDrsE
 Nr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790935303; x=1791540103;
 h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
 :date:message-id:content-type:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kXTJu+ZKnj51ENSQNSDvDx7/Zmp6Fg9OCW+ZC739jnw=;
 b=C+WlUseRSVh8wU45BSGK8kwR9WSAVyoXHzgTzPXc9PVUcnfEzalCMrXFBk8H8yrr0J
 7dXpiNqnzfpv025BFpHcthqDojeU6i2s3F1WddVDKiJwvenoRl7suqyzXWCaLF7sc3ci
 /XnPFn1xEpXnPicPu24Kif4LgBylv3a0oZ3HlEFezEvtRns8Rh2m3dkBJnn4bbUyH2sy
 WzngHyVL/0V8Hkfx5Dr4OWza+ipZi8JQ1QS7AlGES/2rD7QdGXYA/R0PsI5rQx0xIfib
 dHOTe1JsyUPnz2z/IyTapSjsVFPVao6ZmWYjrHKVb+rh3WfkGQuntGbqEquC/CF6vpkg
 kEFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy+z4/JFSfdr211InNRdcbC07PleIOc10Io4DnYSXkPaTcKcxmYwW8DNnuWY7+3OPEvZxk4b/uzKH1q@nongnu.org
X-Gm-Message-State: AFq9FYKFJxdSpDX1tGAoxDPnq7XArSIoe2Y7I1TcA45GzHk1GdBkWmMu
 TKEFo/8XjXCWFpdgYQizWSfsd8zRJjY5b+AGFFxiQU9XkkVPn7xTo7Cj
X-Gm-Gg: AYBFou3soBi1CQzOXSuYhmZSuQWfmsSW2wf+OsKYgeWx3E56y3lWtJDiBMqYwv5XQL/
 5V7IuQtAuxrdtqpvwazoiYKi2H0YbrSZ369ETl7zaUO1L7RQdvgdjqhLYSVv8oz/blCXxGUNcJm
 KHsV/CqwjPl/+k+ityaXGgttKupL7Wd66lVOmU3Y3qDP17bF77GtDXJoVR9PbNRyH88f7vXBLO4
 Zf+aNb/S5fhhyKF/GkP0ZFdD0DV52Bg0AWbvEAx9qdn/OXQ4DpYWdSE8LtoWCFrnGU+jhISXWzX
 Jd+lQHkMqFzQ2TaoDZPJq9oCdXBNBv6DkIrvJKsogpSy2OX+XdsvkNwTYrae17JPakZLhXaJcwS
 Ik/kYhmyMfOR8Lu8r7+27isStQVHYM5F/tPQ76UqBdibYePt08aNu+bJguznpsO/YJ5KJbO/T7i
 L3asWQKHmoM69nfCsWPUAlC2KUwgLCEoA7sZNWL65kVrbtB7VGuQL5gY76V79GfkENLich89hvw
 Ucy4UqRnq2LO5Ey8KcFy0IWhw==
X-Received: by 2002:a17:90b:5346:b0:3a6:f800:446f with SMTP id
 98e67ed59e1d1-3a6f8004901mr551094a91.64.1790935303057; 
 Fri, 02 Oct 2026 03:01:43 -0700 (PDT)
Received: from [192.168.3.23] ([101.207.27.235])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f47cbd1dsm8720773a91.16.2026.10.02.03.01.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 03:01:42 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------vyzbcUZ0Yeda7QB7MWSD994j"
Message-ID: <ddd49a29-d510-4291-9d02-723fca81f755@gmail.com>
Date: Fri, 2 Oct 2026 18:01:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/dma: fix k230_gsdma integer handling issues
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "dingtao0430@163.com" <dingtao0430@163.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>
References: <20261001022223.8633-1-dingtao0430@163.com>
 <20261001022223.8633-4-dingtao0430@163.com>
 <0e009c8e861279afcb9344eff6a8b083089ff074.camel@wdc.com>
From: Tao Ding <dingtaodtdt@gmail.com>
In-Reply-To: <0e009c8e861279afcb9344eff6a8b083089ff074.camel@wdc.com>
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=dingtaodtdt@gmail.com; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
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

This is a multi-part message in MIME format.
--------------vyzbcUZ0Yeda7QB7MWSD994j
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/2/2026 7:33 AM, Alistair Francis wrote:
> On Thu, 2026-10-01 at 10:22 +0800, Tao Ding wrote:
>> Validate the address before subtracting the channel base and use
>> hwaddr
>> for channel calculations to prevent unsigned underflow and
>> truncation.
> Thanks for sending fixes. You are missing a cover letter for a multi-
> patch series
>
>> Resolves: Coverity CID 1685516
> Should be 1685514

Yes

>> Reported-by: Alistair Francis<Alistair.Francis@wdc.com>
>> Signed-off-by: Tao Ding<dingtao0430@163.com>
>> ---
>>   hw/dma/k230_gsdma.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/dma/k230_gsdma.c b/hw/dma/k230_gsdma.c
>> index 7635cd19e8..e9a7877e54 100644
>> --- a/hw/dma/k230_gsdma.c
>> +++ b/hw/dma/k230_gsdma.c
>> @@ -300,7 +300,7 @@ static const VMStateDescription
>> vmstate_k230_gsdma = {
>>   static uint64_t k230_gsdma_read(void *opaque, hwaddr addr, unsigned
>> int size)
>>   {
>>       K230GSDMAState *s = K230_GSDMA(opaque);
>> -    unsigned int ch;
>> +    hwaddr ch;
>>       hwaddr ch_off;
>>       uint64_t ret = 0;
>>   
>> @@ -329,6 +329,9 @@ static uint64_t k230_gsdma_read(void *opaque,
>> hwaddr addr, unsigned int size)
>>           break;
>>       }
>>   
>> +    if (addr < K230_GSDMA_CH_BASE) {
>> +        goto out;
>> +    }
> Why add the complexity of a goto? You already have a `addr <
> K230_GSDMA_CH_BASE` check (which will never trigger after this change)
> where you log an error, just return there.

The use of goto here is intended to skip the following code,
which deals with addresses greater than K230_GSDMA_CH_SASE.
Another way, the trace function can also be called here and returned.

>>       ch = (addr - K230_GSDMA_CH_BASE) / K230_GSDMA_CH_STRIDE;
>>       ch_off = (addr - K230_GSDMA_CH_BASE) % K230_GSDMA_CH_STRIDE;
>>       if (ch < K230_GSDMA_NUM_SDMA_CHANNELS) {
>> @@ -355,6 +358,7 @@ static uint64_t k230_gsdma_read(void *opaque,
>> hwaddr addr, unsigned int size)
>>           }
>>       }
>>   
>> +out:
>>       trace_k230_gsdma_read(addr, size, ret);
> Why do you want to log a failed read as successful?

I also a bit confused here, whether trace can only record successful reads and writes.
I think it's better to use trace to record all accesses,
otherwise we would need -d guest_errors to record failed accesses.


> Alistair
>
>>       return ret;
>>   }
--------------vyzbcUZ0Yeda7QB7MWSD994j
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/2/2026 7:33 AM, Alistair Francis
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:0e009c8e861279afcb9344eff6a8b083089ff074.camel@wdc.com">
      <pre wrap="" class="moz-quote-pre">On Thu, 2026-10-01 at 10:22 +0800, Tao Ding wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Validate the address before subtracting the channel base and use
hwaddr 
for channel calculations to prevent unsigned underflow and
truncation.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Thanks for sending fixes. You are missing a cover letter for a multi-
patch series

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Resolves: Coverity CID 1685516
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Should be 1685514
</pre>
    </blockquote>
    <pre>Yes</pre>
    <blockquote type="cite"
      cite="mid:0e009c8e861279afcb9344eff6a8b083089ff074.camel@wdc.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Reported-by: Alistair Francis <a class="moz-txt-link-rfc2396E" href="mailto:Alistair.Francis@wdc.com">&lt;Alistair.Francis@wdc.com&gt;</a>
Signed-off-by: Tao Ding <a class="moz-txt-link-rfc2396E" href="mailto:dingtao0430@163.com">&lt;dingtao0430@163.com&gt;</a>
---
 hw/dma/k230_gsdma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/dma/k230_gsdma.c b/hw/dma/k230_gsdma.c
index 7635cd19e8..e9a7877e54 100644
--- a/hw/dma/k230_gsdma.c
+++ b/hw/dma/k230_gsdma.c
@@ -300,7 +300,7 @@ static const VMStateDescription
vmstate_k230_gsdma = {
 static uint64_t k230_gsdma_read(void *opaque, hwaddr addr, unsigned
int size)
 {
     K230GSDMAState *s = K230_GSDMA(opaque);
-    unsigned int ch;
+    hwaddr ch;
     hwaddr ch_off;
     uint64_t ret = 0;
 
@@ -329,6 +329,9 @@ static uint64_t k230_gsdma_read(void *opaque,
hwaddr addr, unsigned int size)
         break;
     }
 
+    if (addr &lt; K230_GSDMA_CH_BASE) {
+        goto out;
+    }
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Why add the complexity of a goto? You already have a `addr &lt;
K230_GSDMA_CH_BASE` check (which will never trigger after this change)
where you log an error, just return there.
</pre>
    </blockquote>
    <pre>The use of goto here is intended to skip the following code, 
which deals with addresses greater than K230_GSDMA_CH_SASE.
Another way, the trace function can also be called here and returned.</pre>
    <blockquote type="cite"
      cite="mid:0e009c8e861279afcb9344eff6a8b083089ff074.camel@wdc.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">     ch = (addr - K230_GSDMA_CH_BASE) / K230_GSDMA_CH_STRIDE;
     ch_off = (addr - K230_GSDMA_CH_BASE) % K230_GSDMA_CH_STRIDE;
     if (ch &lt; K230_GSDMA_NUM_SDMA_CHANNELS) {
@@ -355,6 +358,7 @@ static uint64_t k230_gsdma_read(void *opaque,
hwaddr addr, unsigned int size)
         }
     }
 
+out:
     trace_k230_gsdma_read(addr, size, ret);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Why do you want to log a failed read as successful?
</pre>
    </blockquote>
    <pre>I also a bit confused here, whether trace can only record successful reads and writes.
I think it's better to use trace to record all accesses, 
otherwise we would need -d guest_errors to record failed accesses.</pre>
    <p><br>
    </p>
    <blockquote type="cite"
      cite="mid:0e009c8e861279afcb9344eff6a8b083089ff074.camel@wdc.com">
      <pre wrap="" class="moz-quote-pre">
Alistair

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">     return ret;
 }
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------vyzbcUZ0Yeda7QB7MWSD994j--

