Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C10CA5FD9
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 07:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCXm7-0000yk-97; Fri, 02 Oct 2026 03:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xCXm5-0000xy-LF
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 03:33:45 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xCXm3-0002EN-V1
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 03:33:45 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-39d654f02baso3415716a91.3
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 00:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790926422; x=1791531222; darn=nongnu.org;
 h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
 :date:message-id:content-type:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CLucR6FTSXL97CnIA3BLOwq/lXtjzSeRWKfGw+LqHmI=;
 b=nRUejGtyG4NOSTzCF2Ey3mvK6Txx7MQMKWdZ64dvUKeQ7Rh83tIOKZ4zPrUvDWlwLj
 LFD0JfPYYDgbSld6R1C2LJwQxhxDswKxcMHJBGBGArKFGCC6imY5TkiLd9GX7C7Jwl17
 gQAX5v2V4pXF558ANSdvLnixHsglHzBgqgHEJGajO67/4DK4SoiyHkrL8ogSH4oIe1y/
 EeKWXLscL3uScgSAmiAq/OLSoqoS6LOvwQnmmNOeYDal7s06Q4zxCyuwEpr+VIUYvkI6
 MJMY8oQky/G1UxdrLRPQvUvngQsLAK4nhz9a3vGpTQR785fV2F29w8rpEMAibyyQccZO
 KjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790926422; x=1791531222;
 h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
 :date:message-id:content-type:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CLucR6FTSXL97CnIA3BLOwq/lXtjzSeRWKfGw+LqHmI=;
 b=CL5dtGCtT+O/NYWUV8dxqe3MUJ0gaaSJ6HeHx7D8idLfrkrHrsVYAajwXbF47ZhciP
 L4840IfkINH2n45/X+eLI4CQxKwCWyFHWOvUzodEj3rpR/ggQ/iH3Mmcczcxz1WYjcNq
 Q0J1sAui6gDgcpyD8HaZNf09njAtmwXd4sDAa/DdihXF3s/G6VS0A+bw6nIaxMx6Va38
 p/hlqfKvhqZRe1fxDTSdfqFgX2v1bOAQZ/bgBbXe7KUw9A85x1xpYm5y4dobKV9jM1sU
 2tK+TIndH4FiprUNz9fmBObMLGzXVxWzNN/FyqKJ0EQkXKoAwJAxfvtM0nglIkGT8R/p
 CGpw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwybuprxp2unSP7rcAphzgqua8mwaQNH0agTw5XYTfleTsZe5CyCSLX47c/1A+97urm0QyUqYV9BNC0@nongnu.org
X-Gm-Message-State: AFq9FYLykFlSiWNAOtY5UNVQmgc6vFp6M8VM7BAeYRZGQVWjFtZv/fWU
 dvzVXV9xHlm4oWzctnQRZ6Qy0cGfKVUdFt0zXN2+/L5h0GQ9AornPo9Z
X-Gm-Gg: AYBFou15RV31X0nMhDDTRXeAuT3cEgkEH3rukuJG0hpTeNyrI8Bvopb+umd4LwRGu2r
 u3vgzbiun6pu542St51BKGmhztR58prqdMrDRrSglif52iFHzwvpCVsNK2rnQScpT8vEIYy0wQi
 MhavfSe9eZBqDovH3lbONwIIhowYF+u00fU142A5BotIYR1GYUdDFIBP5NvMR2xlj2sPl7AlwOd
 ArnXN0Ov5CXrRjJozohI37LypnIgV5G5FWMMdK7iioDYj0Obf1Khx91Dw6dnCZrrFHhqDyYpNLH
 c03j7n1EJXsxK07Ner5vss+Dvlw0PkM5LMCSsaeRFMpkxlKjoZwlgnvg6gWqT/CmSC+C7KfIvM0
 71Oj59jMvpllJa80I3xyGNwdhQos2ch683Q1zPXGbDaREYbO01AJzKKUHKjDzlTUjQDaneMw1Ys
 UFupQH1CfedobKKhfAPKEpXr5c5P+KZsRG+FWaGOAHREjHsQX/x6d1TAzRsPifPY6JgOf3cg1DA
 cKMCFCJCKm9iA4eP7U0UrAWKw==
X-Received: by 2002:a17:90b:1fc8:b0:39e:6a81:5a98 with SMTP id
 98e67ed59e1d1-3a6f9166840mr176736a91.44.1790926422098; 
 Fri, 02 Oct 2026 00:33:42 -0700 (PDT)
Received: from [192.168.3.23] ([175.152.37.254])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f402dfbbsm7917664a91.0.2026.10.02.00.33.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 00:33:41 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------zyJtQkxNoWDT0xv60slmSsww"
Message-ID: <756e5b29-49e7-4086-bb38-59a62e180d67@gmail.com>
Date: Fri, 2 Oct 2026 15:33:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/misc: fix k230_decomp_gzip integer handling issues
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "dingtao0430@163.com" <dingtao0430@163.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>
References: <20261001022223.8633-1-dingtao0430@163.com>
 <20261001022223.8633-2-dingtao0430@163.com>
 <35b8af2703f942f608f419fef23be6f6429d342b.camel@wdc.com>
From: Tao Ding <dingtaodtdt@gmail.com>
In-Reply-To: <35b8af2703f942f608f419fef23be6f6429d342b.camel@wdc.com>
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=dingtaodtdt@gmail.com; helo=mail-pj2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
--------------zyJtQkxNoWDT0xv60slmSsww
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/2/2026 7:27 AM, Alistair Francis wrote:

> On Thu, 2026-10-01 at 10:22 +0800, Tao Ding wrote:
>> Use hwaddr for address calculations to avoid 32-bit overflow and
>> address truncation.
>>
>> Resolves: Coverity CID 1685515, 1685517
>>
>> Reported-by: Alistair Francis<Alistair.Francis@wdc.com>
>> Signed-off-by: Tao Ding<dingtao0430@163.com>
>> ---
>>   hw/misc/k230_decomp_gzip.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/misc/k230_decomp_gzip.c b/hw/misc/k230_decomp_gzip.c
>> index 0d8a3b2d2e..54303c0e7f 100644
>> --- a/hw/misc/k230_decomp_gzip.c
>> +++ b/hw/misc/k230_decomp_gzip.c
>> @@ -53,13 +53,13 @@ static bool
>> k230_decomp_gzip_write_mem(K230DecompGzipState *s, hwaddr addr,
>>   static hwaddr k230_decomp_gzip_output_addr(K230DecompGzipState *s)
>>   {
>>       return K230_DECOMP_GZIP_SRAM_OUT_BASE +
>> -           s->output.slot * K230_DECOMP_GZIP_BLOCK_SIZE +
>> +           (hwaddr) s->output.slot * K230_DECOMP_GZIP_BLOCK_SIZE +
> Isn't K230_DECOMP_GZIP_BLOCK_SIZE still a 32-bit value, should it be a
> ULL?
>
The cast of |s->output.slot|to |hwaddr|causes the multiplication to be performed as |hwaddr|, so |K230_DECOMP_GZIP_BLOCK_SIZE|does not need a |ULL|suffix.

>>              s->output.current_offset;
>>   }
>>   
>>   static hwaddr k230_decomp_gzip_input_addr(K230DecompGzipState *s)
>>   {
>> -    return s->input.slot * K230_DECOMP_GZIP_BLOCK_SIZE +
>> +    return (hwaddr) s->input.slot * K230_DECOMP_GZIP_BLOCK_SIZE +
>>              K230_DECOMP_GZIP_SRAM_IN_BASE;
>>   }
>>   
>> @@ -102,7 +102,7 @@ static void
>> k230_decomp_gzip_finish(K230DecompGzipState *s, bool crc_ok)
>>   }
>>   
>>   static bool k230_decomp_gzip_load_input(K230DecompGzipState *s,
>> -                                        uint32_t addr, uint32_t
>> size)
>> +                                        hwaddr addr, uint32_t size)
> This should probably be it's own patch

|Agreed. I'll split the k230_decomp_gzip_load_input() parameter type 
change into a separate patch in v2.|

> Alistair
>
>>   {
>>       s->input.current_offset = 0;
>>   
--------------zyJtQkxNoWDT0xv60slmSsww
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
    <pre class="moz-cite-prefix">On 10/2/2026 7:27 AM, Alistair Francis wrote:
</pre>
    <blockquote type="cite"
      cite="mid:35b8af2703f942f608f419fef23be6f6429d342b.camel@wdc.com">
      <pre wrap="" class="moz-quote-pre">On Thu, 2026-10-01 at 10:22 +0800, Tao Ding wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Use hwaddr for address calculations to avoid 32-bit overflow and
address truncation.

Resolves: Coverity CID 1685515, 1685517

Reported-by: Alistair Francis <a class="moz-txt-link-rfc2396E" href="mailto:Alistair.Francis@wdc.com">&lt;Alistair.Francis@wdc.com&gt;</a>
Signed-off-by: Tao Ding <a class="moz-txt-link-rfc2396E" href="mailto:dingtao0430@163.com">&lt;dingtao0430@163.com&gt;</a>
---
 hw/misc/k230_decomp_gzip.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/misc/k230_decomp_gzip.c b/hw/misc/k230_decomp_gzip.c
index 0d8a3b2d2e..54303c0e7f 100644
--- a/hw/misc/k230_decomp_gzip.c
+++ b/hw/misc/k230_decomp_gzip.c
@@ -53,13 +53,13 @@ static bool
k230_decomp_gzip_write_mem(K230DecompGzipState *s, hwaddr addr,
 static hwaddr k230_decomp_gzip_output_addr(K230DecompGzipState *s)
 {
     return K230_DECOMP_GZIP_SRAM_OUT_BASE +
-           s-&gt;output.slot * K230_DECOMP_GZIP_BLOCK_SIZE +
+           (hwaddr) s-&gt;output.slot * K230_DECOMP_GZIP_BLOCK_SIZE +
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Isn't K230_DECOMP_GZIP_BLOCK_SIZE still a 32-bit value, should it be a
ULL?

</pre>
    </blockquote>
    <pre><span>The cast of </span><code dir="ltr">s-&gt;output.slot</code><span> to </span><code
    dir="ltr">hwaddr</code><span> causes the multiplication to be performed as </span><code
    dir="ltr">hwaddr</code><span>, 
so </span><code dir="ltr">K230_DECOMP_GZIP_BLOCK_SIZE</code><span> does not need a </span><code
    dir="ltr">ULL</code><span> suffix.</span></pre>
    <blockquote type="cite"
      cite="mid:35b8af2703f942f608f419fef23be6f6429d342b.camel@wdc.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">            s-&gt;output.current_offset;
 }
 
 static hwaddr k230_decomp_gzip_input_addr(K230DecompGzipState *s)
 {
-    return s-&gt;input.slot * K230_DECOMP_GZIP_BLOCK_SIZE +
+    return (hwaddr) s-&gt;input.slot * K230_DECOMP_GZIP_BLOCK_SIZE +
            K230_DECOMP_GZIP_SRAM_IN_BASE;
 }
 
@@ -102,7 +102,7 @@ static void
k230_decomp_gzip_finish(K230DecompGzipState *s, bool crc_ok)
 }
 
 static bool k230_decomp_gzip_load_input(K230DecompGzipState *s,
-                                        uint32_t addr, uint32_t
size)
+                                        hwaddr addr, uint32_t size)
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
This should probably be it's own patch
</pre>
    </blockquote>
    <br>
    <pre dir="ltr"><code>Agreed. I'll split the k230_decomp_gzip_load_input() parameter type
change into a separate patch in v2.</code></pre>
    <blockquote type="cite"
      cite="mid:35b8af2703f942f608f419fef23be6f6429d342b.camel@wdc.com">
      <pre wrap="" class="moz-quote-pre">
Alistair

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> {
     s-&gt;input.current_offset = 0;
 
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------zyJtQkxNoWDT0xv60slmSsww--

