Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCC4CCA490
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIR94-00017f-Ht; Sun, 18 Oct 2026 09:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xIR92-00015U-Mv
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 09:41:48 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xIR90-0002rT-MZ
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 09:41:48 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-8a058f74a54so125367b3a.1
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 06:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792330904; x=1792935704; darn=nongnu.org;
 h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
 :date:message-id:content-type:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WQhwK78wnfJ5eZGrDMcIglkMM9XjuGAgLzw8Lwnd6Vc=;
 b=QEi69kZzU+K3dWox+3u5KMVsc5olGjBQ0E3BAZEEi3Ph+B8xXSwbLmyJDT0h+Tef80
 IJ5LoPf5fPg8FTFzIj+FCwjB43TG1fi0j5A21wgcFxaX2EbpL/l1eGhdLG5AYcFoZmLO
 F1XNRHLo2Xm5p5hvIiloVDTaSIrqNDa83U/52TJftcwe8FSTeEg/8JtMih0EXSE9eASq
 bAj3w508Upq1kNd/Zy8Y8U7hHqv24mhrKd6uT1jb2y0NHiia47SFvO59e1SDnGYC0Miv
 7THTeQ9ZFBjOYs+Szw2eGiCvEo5/J678wEr6i6CZt5mLtwe2DZBPfH/aWParGYbtJsCr
 hq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792330904; x=1792935704;
 h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
 :date:message-id:content-type:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WQhwK78wnfJ5eZGrDMcIglkMM9XjuGAgLzw8Lwnd6Vc=;
 b=xtLVVjk1ODcLt+tUqKqRCE3ClBmM55GF+EspRvxA/9HYlxWs8SBgUDVBZdR3IwjIeY
 drlmr4La5SBjLGJZlygB4rUa6RozeV+unNNpHRIYGf5HHVK3dqOV/5tPfnNKGJppKRSf
 YFrtSIkDZdd6rNbvomk9Sn2xGPm0QvbIBNmtKZMOwuailx3D6Eh2IzRTcaH79p+/BFP7
 VwnPECHXIl+BqByxGBaAQg8zKdnCrUV6lsao5LZZNkPLjumGdG6d69lh5iIQqgua8NIU
 4z+fyHoV5e9NF2myjq169z8UoPdqe/hXWPkVoD0QiSgxQqnEMXNG5H1LLsW7TODBnZ5a
 i6Jg==
X-Forwarded-Encrypted: i=1;
 AKwUvByPpgrSOdejdvnhn06RpjvIfHRLQbYYPRYd67490TQBigIuGsDcmxcpGRRS37BQHNeVTKp9vefV3+Ix@nongnu.org
X-Gm-Message-State: AFq9FYIRO9dnsiiNbhl7c6OpJUWF6ay28o9/JVa6K8SbYntkXUDFAWF6
 433RdQvrsruml9nt/4fz6oFZUCSNo9pmUM62mJp6LG/JCOSvgaNgrrBY
X-Gm-Gg: AYBFou3TVQRginVAonJSRCkZb1or0bjazvTQ8yHksZ6t50Fc9keuwkwpMXiGQUCKkyd
 huDK6ahxM7hsQEBWCL5S/Fxd2uhjg+ot123Wzhxbli66QhKXN9S46+stcMkq1YyhHWdJoUc3iOu
 CkizbCpw6X+4rtzBKpLb8/RT4fyF0UCskckdW0T0EZRqofP1P6KIPp3DdSeemGRtYZ9clRfu3Kq
 tSh7khvABg7adnjRGw2MSG86LK7SzWgSF3zzPV2eHg5imlsi0eIKFCVgJKR5/E0dUJrZbj2RkPU
 m1UtXeYHxr1j9+gf4K5PoQ80NPwzWIepoWPsGsR1gbM4B1EaAMTnIZiZFNdJul2AlqwzP7/OvUQ
 kSVncgV78wkt6pKNTlWtb7cCZzJfhqDRDAJrMgC1+N7fp1guYjisoWelhKlLJD1tXEO8jeDZKzl
 si6QQ4GK/b8ohZNqghDBB3YvklR7PU9BbNsDkpCq4BgT45FaXegc14QzTqZJ25jImgo4WRdMG5x
 R0PCUWhfj1/Pxw=
X-Received: by 2002:a05:6a00:3c91:b0:89e:261c:448b with SMTP id
 d2e1a72fcca58-8a04cb24551mr3730201b3a.34.1792330903641; 
 Sun, 18 Oct 2026 06:41:43 -0700 (PDT)
Received: from [192.168.3.23] ([101.204.150.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89f56c8b922sm2939138b3a.11.2026.10.18.06.41.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Oct 2026 06:41:42 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------uyKehUpbyQKH8SDP20PfNHxn"
Message-ID: <b969dd01-6ed5-4a29-a112-b5f00dd78642@gmail.com>
Date: Sun, 18 Oct 2026 21:41:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] hw/dma: fix k230_gsdma integer handling issues
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "dingtao0430@163.com" <dingtao0430@163.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>
References: <20261002140245.30214-1-dingtao0430@163.com>
 <20261002140245.30214-6-dingtao0430@163.com>
 <621efd0cf2f709dd9cc0491a7955d21bd0f7f09b.camel@wdc.com>
From: Tao Ding <dingtaodtdt@gmail.com>
In-Reply-To: <621efd0cf2f709dd9cc0491a7955d21bd0f7f09b.camel@wdc.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=dingtaodtdt@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This is a multi-part message in MIME format.
--------------uyKehUpbyQKH8SDP20PfNHxn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/16/2026 10:05 AM, Alistair Francis wrote:

> On Fri, 2026-10-02 at 22:02 +0800, Tao Ding wrote:
>> Validate the address before subtracting the channel base and use
>> hwaddr
>> for channel calculations to prevent unsigned underflow and
>> truncation.
>>
>> Resolves: Coverity CID 1685514
>>
>> Reported-by: Alistair Francis<Alistair.Francis@wdc.com>
>> Signed-off-by: Tao Ding<dingtao0430@163.com>
>> ---
>> Compared to patchv1, the modification of ch has been removed.
>> Because ch is an unsigned int, it is sufficient.
>>
>>   hw/dma/k230_gsdma.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/dma/k230_gsdma.c b/hw/dma/k230_gsdma.c
>> index 7635cd19e8..e422b436a2 100644
>> --- a/hw/dma/k230_gsdma.c
>> +++ b/hw/dma/k230_gsdma.c
>> @@ -329,6 +329,9 @@ static uint64_t k230_gsdma_read(void *opaque,
>> hwaddr addr, unsigned int size)
>>           break;
>>       }
>>   
>> +    if (addr < K230_GSDMA_CH_BASE) {
>> +        goto out;
>> +    }
> This isn't right, you already have a `if (addr < K230_GSDMA_CH_BASE)`
> check above, just use that but return.
>
> That way we don't log a read that doesn't actually happen, and can
> avoid a goto
>
> Alistair

Yes, we can return in the if in the default above.
But some addresses arrive here through other branches of the switch, and these addresses are smaller than K230_SSDMA_CH_SASE.
If there is no goto, overflow errors will occur when calculating "ch".
The next patch will use conditional judgment to avoid using goto.

>
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
>>       return ret;
>>   }
--------------uyKehUpbyQKH8SDP20PfNHxn
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
    <pre class="moz-cite-prefix">On 10/16/2026 10:05 AM, Alistair Francis wrote:
</pre>
    <blockquote type="cite"
      cite="mid:621efd0cf2f709dd9cc0491a7955d21bd0f7f09b.camel@wdc.com">
      <pre wrap="" class="moz-quote-pre">On Fri, 2026-10-02 at 22:02 +0800, Tao Ding wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Validate the address before subtracting the channel base and use
hwaddr 
for channel calculations to prevent unsigned underflow and
truncation.

Resolves: Coverity CID 1685514

Reported-by: Alistair Francis <a class="moz-txt-link-rfc2396E" href="mailto:Alistair.Francis@wdc.com">&lt;Alistair.Francis@wdc.com&gt;</a>
Signed-off-by: Tao Ding <a class="moz-txt-link-rfc2396E" href="mailto:dingtao0430@163.com">&lt;dingtao0430@163.com&gt;</a>
---
Compared to patchv1, the modification of ch has been removed. 
Because ch is an unsigned int, it is sufficient.

 hw/dma/k230_gsdma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/dma/k230_gsdma.c b/hw/dma/k230_gsdma.c
index 7635cd19e8..e422b436a2 100644
--- a/hw/dma/k230_gsdma.c
+++ b/hw/dma/k230_gsdma.c
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
This isn't right, you already have a `if (addr &lt; K230_GSDMA_CH_BASE)`
check above, just use that but return.

That way we don't log a read that doesn't actually happen, and can
avoid a goto

Alistair
</pre>
    </blockquote>
    <pre>Yes, we can return in the if in the default above.
But some addresses arrive here through other branches of the switch, and these addresses are smaller than K230_SSDMA_CH_SASE.
If there is no goto, overflow errors will occur when calculating "ch".
The next patch will use conditional judgment to avoid using goto.</pre>
    <blockquote type="cite"
      cite="mid:621efd0cf2f709dd9cc0491a7955d21bd0f7f09b.camel@wdc.com">
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
     return ret;
 }
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------uyKehUpbyQKH8SDP20PfNHxn--

