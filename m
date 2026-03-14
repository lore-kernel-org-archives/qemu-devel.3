Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E04B10706EA
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2026 17:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1SZx-00083J-7E; Sat, 14 Mar 2026 13:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1w1SZr-00082t-2u; Sat, 14 Mar 2026 13:15:03 -0400
Received: from m16.mail.163.com ([117.135.210.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1w1SZj-0006EA-Ri; Sat, 14 Mar 2026 13:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Content-Type:Message-ID:Date:MIME-Version:Subject:
 To:From; bh=mKGW4turYlHs3+9fWnsVOo23mn0unnFX6VSdIGSUW6w=; b=RP02
 ag985PsB9SUufMJVuVHb09UXUHKRW5K3L8bY8n1puESWXj5y2XBNiRqLUnUnVf35
 DZ3i5/jseMFkK4/EamLfZkjPCU1EtwbFWdgNiYXxn3hPYIVY/fljwzFLx9nQzty5
 uFcLArGKmewnCkQlvqaHC66aapTWgdRupuP2XlU=
Received: from [IPV6:2408:8266:ba01:23a1:15e5:5eca:524a:ee8b] (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wBXmxpfl7VpYF4OBA--.59565S2; 
 Sun, 15 Mar 2026 01:14:07 +0800 (CST)
Content-Type: multipart/alternative;
 boundary="------------kGAZiZkhmy1U003gKxLaqcCS"
Message-ID: <7e7677f4-9cd9-4d33-995e-f7645786e1ce@163.com>
Date: Sun, 15 Mar 2026 01:14:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] The swidth and dwidth of pl080 are not equal.
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <cover.1773301927.git.dingtao0430@163.com>
 <97c01f634c255f3787ab8a71bfe8ccc03e8d353c.1773301927.git.dingtao0430@163.com>
 <CAFEAcA-kBmfYzpx5WKwhy5M+zAztoMsP6NAhnoJ5S6KdxnWArQ@mail.gmail.com>
From: Tao Ding <dingtao0430@163.com>
In-Reply-To: <CAFEAcA-kBmfYzpx5WKwhy5M+zAztoMsP6NAhnoJ5S6KdxnWArQ@mail.gmail.com>
X-CM-TRANSID: _____wBXmxpfl7VpYF4OBA--.59565S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw4kJF15CFyxtrW8Gr43trb_yoWruw48pF
 95Kr1Skr4DtryIy3saqw40qFyDuF4rWa45Wry3Krn8Aws8Jry2qr1xKFWFkFW5uws3Zw4F
 kw1kurW5uw1qvrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UQNVgUUUUU=
X-Originating-IP: [2408:8266:ba01:23a1:15e5:5eca:524a:ee8b]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC4R-EA2m1l18-SQAA3b
Received-SPF: pass client-ip=117.135.210.5; envelope-from=dingtao0430@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
--------------kGAZiZkhmy1U003gKxLaqcCS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thank you for your valuable review.
﻿
I agree with your suggestion, it is necessary to satisfy that transfersize * swidth is
an integer multiple of dwidth. So, some of the code is actually redundant in this patch.
Before that, swidth,dwidth and transfersize will be checked, and if the conditions are not met,
there will be qemu_log_mask(LOG_GUEST_ERROR).
﻿
Can I modify this patch and submit it as patch v2.

>> ---
>>   hw/dma/pl080.c | 32 ++++++++++++++++++++------------
>>   1 file changed, 20 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
>> index 0979a687aa..4f97943b28 100644
>> --- a/hw/dma/pl080.c
>> +++ b/hw/dma/pl080.c
>> @@ -160,26 +160,34 @@ again:
>>
>>               /* Transfer one element.  */
>>               /* ??? Should transfer multiple elements for a burst request.  */
>> -            /* ??? Unclear what the proper behavior is when source and
>> -               destination widths are different.  */
>>               swidth = 1 << ((ch->ctrl >> 18) & 7);
>>               dwidth = 1 << ((ch->ctrl >> 21) & 7);
>> -            for (n = 0; n < dwidth; n+= swidth) {
>> +            xsize = (dwidth < swidth) ? swidth : dwidth;
> I think this can be more clearly written as
>       xsize = MAX(swidth, dwidth);
> since we're editing the line anyway.
>
>> +            xsize = (xsize < size * swidth) ? xsize : (size * swidth);
>     xsize = MIN(xsize, size * swidth);
>
> So this is handling the case where our destination width is larger
> than the remaining amount the transfer size says we should be reading
> from the source, which is cases like
> "source width = 1, dest width = 4, transfer count not a multiple of 4".
> The TRM is unfortunately very vague about what the hardware does here.
> I think the hardware designers considered this to be a programming error:
> in the "Software considerations" section of the TRM one of the items is:
>
>   * If the source width is less than the destination width, the
>     TransferSize value multiplied by the source width must be an
>     integral multiple of the destination width.
>
>> +            for (n = 0; n < xsize; n += swidth) {
>>                   address_space_read(&s->downstream_as, ch->src,
>>                                      MEMTXATTRS_UNSPECIFIED, buff + n, swidth);
>> -                if (ch->ctrl & PL080_CCTRL_SI)
>> +                if (ch->ctrl & PL080_CCTRL_SI) {
>>                       ch->src += swidth;
>> +                }
>>               }
>> -            xsize = (dwidth < swidth) ? swidth : dwidth;
>> -            /* ??? This may pad the value incorrectly for dwidth < 32.  */
>> -            for (n = 0; n < xsize; n += dwidth) {
>> -                address_space_write(&s->downstream_as, ch->dest + n,
>> -                                    MEMTXATTRS_UNSPECIFIED, buff + n, dwidth);
>> -                if (ch->ctrl & PL080_CCTRL_DI)
>> -                    ch->dest += swidth;
>> +            if (xsize < dwidth) {
>> +                address_space_write(&s->downstream_as, ch->dest,
>> +                                    MEMTXATTRS_UNSPECIFIED, buff, xsize);
>> +                if (ch->ctrl & PL080_CCTRL_DI) {
>> +                    ch->dest += dwidth;
>> +                }
> Here we choose to handle the "swidth and tsize say we should
> read e.g. 2 bytes from the source but dwidth is e.g. 4" case
> by performing a 2 byte write to the destination. I don't think this
> is what the hardware would do.
>
> There is this interesting bit in the "software considerations" section:
>
>   * While writing, the TransferSize bit-field is like a control register
>     because it determines how many transfers the DMAC performs. However,
>     during read-back, TransferSize behaves like a status register because
>     it returns the number of remaining transfers in terms of source width.
>     So when TransferSize is read back, it returns the number of
>     destination-transfer-completed stored in a separate counter called
>     TrfSizeDst multiplied by a factor.
>
> My best guess from stuff like this is that the way the PL080 works
> internally is that for each dest-write it needs to do for the transfer
> it does the appropriate number of source-reads. If the guest
> misprograms it such that that means it reads more than
> (transferwidth * swidth) that will result in reading more data
> from the source than intended, but that would be a software bug.
>
> I would suggest doing something like that, but at any rate
> commenting and doing a LOG_GUEST_ERROR if there's a mismatch in
> swidth/dwidth/tsize such that we wouldn't have enough bytes to
> do a full destination-write.
>
>> +            } else {
>> +                for (n = 0; n < xsize; n += dwidth) {
>> +                    address_space_write(&s->downstream_as, ch->dest,
>> +                                        MEMTXATTRS_UNSPECIFIED, buff + n, dwidth);
>> +                    if (ch->ctrl & PL080_CCTRL_DI) {
>> +                        ch->dest += dwidth;
>> +                    }
>> +                }
>>               }
>>
>> -            size--;
>> +            size -= xsize / swidth;
> This change is correct (the transfer size field in the control register
> is supposed to count down by 1 for each swidth-sized data unit we
> transfer, and our loop can do more than one swidth read), and probably
> the most important bugfix in this patch, because it's the one that
> matters for normal correct use of the PL080.
>
>>               ch->ctrl = (ch->ctrl & 0xfffff000) | size;
>>               if (size == 0) {
>>                   /* Transfer complete.  */
>> --
>> 2.43.0
> thanks
> -- PMM
--------------kGAZiZkhmy1U003gKxLaqcCS
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <pre>Thank you for your valuable review.
﻿
I agree with your suggestion, it is necessary to satisfy that transfersize * swidth is 
an integer multiple of dwidth. So, some of the code is actually redundant in this patch.
Before that, swidth,dwidth and transfersize will be checked, and if the conditions are not met, 
there will be qemu_log_mask(LOG_GUEST_ERROR).
﻿
Can I modify this patch and submit it as patch v2.</pre>
    <div class="moz-cite-prefix"><span style="white-space: pre-wrap">
</span></div>
    <blockquote type="cite"
cite="mid:CAFEAcA-kBmfYzpx5WKwhy5M+zAztoMsP6NAhnoJ5S6KdxnWArQ@mail.gmail.com">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">---
 hw/dma/pl080.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 0979a687aa..4f97943b28 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -160,26 +160,34 @@ again:

             /* Transfer one element.  */
             /* ??? Should transfer multiple elements for a burst request.  */
-            /* ??? Unclear what the proper behavior is when source and
-               destination widths are different.  */
             swidth = 1 &lt;&lt; ((ch-&gt;ctrl &gt;&gt; 18) &amp; 7);
             dwidth = 1 &lt;&lt; ((ch-&gt;ctrl &gt;&gt; 21) &amp; 7);
-            for (n = 0; n &lt; dwidth; n+= swidth) {
+            xsize = (dwidth &lt; swidth) ? swidth : dwidth;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I think this can be more clearly written as
     xsize = MAX(swidth, dwidth);
since we're editing the line anyway.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+            xsize = (xsize &lt; size * swidth) ? xsize : (size * swidth);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
   xsize = MIN(xsize, size * swidth);

So this is handling the case where our destination width is larger
than the remaining amount the transfer size says we should be reading
from the source, which is cases like
"source width = 1, dest width = 4, transfer count not a multiple of 4".
The TRM is unfortunately very vague about what the hardware does here.
I think the hardware designers considered this to be a programming error:
in the "Software considerations" section of the TRM one of the items is:

 * If the source width is less than the destination width, the
   TransferSize value multiplied by the source width must be an
   integral multiple of the destination width.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+            for (n = 0; n &lt; xsize; n += swidth) {
                 address_space_read(&amp;s-&gt;downstream_as, ch-&gt;src,
                                    MEMTXATTRS_UNSPECIFIED, buff + n, swidth);
-                if (ch-&gt;ctrl &amp; PL080_CCTRL_SI)
+                if (ch-&gt;ctrl &amp; PL080_CCTRL_SI) {
                     ch-&gt;src += swidth;
+                }
             }
-            xsize = (dwidth &lt; swidth) ? swidth : dwidth;
-            /* ??? This may pad the value incorrectly for dwidth &lt; 32.  */
-            for (n = 0; n &lt; xsize; n += dwidth) {
-                address_space_write(&amp;s-&gt;downstream_as, ch-&gt;dest + n,
-                                    MEMTXATTRS_UNSPECIFIED, buff + n, dwidth);
-                if (ch-&gt;ctrl &amp; PL080_CCTRL_DI)
-                    ch-&gt;dest += swidth;
+            if (xsize &lt; dwidth) {
+                address_space_write(&amp;s-&gt;downstream_as, ch-&gt;dest,
+                                    MEMTXATTRS_UNSPECIFIED, buff, xsize);
+                if (ch-&gt;ctrl &amp; PL080_CCTRL_DI) {
+                    ch-&gt;dest += dwidth;
+                }
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Here we choose to handle the "swidth and tsize say we should
read e.g. 2 bytes from the source but dwidth is e.g. 4" case
by performing a 2 byte write to the destination. I don't think this
is what the hardware would do.

There is this interesting bit in the "software considerations" section:

 * While writing, the TransferSize bit-field is like a control register
   because it determines how many transfers the DMAC performs. However,
   during read-back, TransferSize behaves like a status register because
   it returns the number of remaining transfers in terms of source width.
   So when TransferSize is read back, it returns the number of
   destination-transfer-completed stored in a separate counter called
   TrfSizeDst multiplied by a factor.

My best guess from stuff like this is that the way the PL080 works
internally is that for each dest-write it needs to do for the transfer
it does the appropriate number of source-reads. If the guest
misprograms it such that that means it reads more than
(transferwidth * swidth) that will result in reading more data
from the source than intended, but that would be a software bug.

I would suggest doing something like that, but at any rate
commenting and doing a LOG_GUEST_ERROR if there's a mismatch in
swidth/dwidth/tsize such that we wouldn't have enough bytes to
do a full destination-write.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+            } else {
+                for (n = 0; n &lt; xsize; n += dwidth) {
+                    address_space_write(&amp;s-&gt;downstream_as, ch-&gt;dest,
+                                        MEMTXATTRS_UNSPECIFIED, buff + n, dwidth);
+                    if (ch-&gt;ctrl &amp; PL080_CCTRL_DI) {
+                        ch-&gt;dest += dwidth;
+                    }
+                }
             }

-            size--;
+            size -= xsize / swidth;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
This change is correct (the transfer size field in the control register
is supposed to count down by 1 for each swidth-sized data unit we
transfer, and our loop can do more than one swidth read), and probably
the most important bugfix in this patch, because it's the one that
matters for normal correct use of the PL080.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">             ch-&gt;ctrl = (ch-&gt;ctrl &amp; 0xfffff000) | size;
             if (size == 0) {
                 /* Transfer complete.  */
--
2.43.0
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
thanks
-- PMM
</pre>
    </blockquote>
  </body>
</html>

--------------kGAZiZkhmy1U003gKxLaqcCS--


