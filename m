Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC805C531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 13:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnz6U-0005dh-O1; Sun, 26 Jul 2026 09:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wnz6S-0005dN-W4; Sun, 26 Jul 2026 09:41:17 -0400
Received: from m16.mail.163.com ([117.135.210.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wnz6O-00064r-Sp; Sun, 26 Jul 2026 09:41:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Content-Type:Message-ID:Date:MIME-Version:Subject:
 To:From; bh=JiXyN3AM2zGEa4b3xq3EXzMr40W951LJ0l1kXWm48vc=; b=GSXL
 fKaeuEY0D5UbmRARa7sTVE9/6utp2a2QLSlrDY1INjKA//z9dky1Neu6bF2LfDjd
 nQdDU2pTfOGWGVlsdNjEAoctSSLRVCHnXNncJ9NZgC9ydRsT0ARTogcycDMPKyRv
 rRAI2YtpmoE/bd3ersPSDGcZgvWPiYWjzlR5V+k=
Received: from [IPV6:2408:8266:ba01:5541:f862:fcef:372b:3496] (unknown [])
 by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id
 _____wAHhdlgDmZquY57MA--.19850S2; 
 Sun, 26 Jul 2026 21:40:48 +0800 (CST)
Content-Type: multipart/alternative;
 boundary="------------WPfMADm9LVBV7VF0omcZVp7w"
Message-ID: <f50ef53b-4efc-4dd4-93e4-1e35f499f79c@163.com>
Date: Sun, 26 Jul 2026 21:40:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] hw/dma: add K230 gsdma
To: Junze Cao <caojunze424@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com
References: <20260721161335.73872-1-dingtao0430@163.com>
 <20260721161335.73872-2-dingtao0430@163.com>
 <178504345275.903105.7911994626854937851.b4-review@b4>
From: Tao Ding <dingtao0430@163.com>
In-Reply-To: <178504345275.903105.7911994626854937851.b4-review@b4>
X-CM-TRANSID: _____wAHhdlgDmZquY57MA--.19850S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFWxZFW5Aw47Kry5Jr18Krg_yoW8KFyDpF
 W5GF1DGr97Xa1a9Fs7Ww4UuFyF9wn5GF4q9rn5W397Zw45WF1IqrWSgan0qry0kr4DA345
 X3W2qr90934DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_ku4UUUUUU=
X-Originating-IP: [2408:8266:ba01:5541:f862:fcef:372b:3496]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC4gHPDmpmDmE40AAA3p
Received-SPF: pass client-ip=117.135.210.2; envelope-from=dingtao0430@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
--------------WPfMADm9LVBV7VF0omcZVp7w
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/26/2026 1:24 PM, Junze Cao wrote:

> On Wed, 22 Jul 2026 00:13:29 +0800, Tao Ding<dingtao0430@163.com> wrote:
>> diff --git a/hw/dma/k230_gsdma.c b/hw/dma/k230_gsdma.c
>> new file mode 100644
>> index 0000000000..1f76f62fa0
>> --- /dev/null
>> +++ b/hw/dma/k230_gsdma.c
>> @@ -0,0 +1,532 @@
>> [ ... skip 75 lines ... ]
>> +    /* Stride line size required for 2d mode */
>> +    uint32_t line_space = extract32(line_cfg, 16, 16);
>> +
>> +    bool dat_mode = c->cfg & K230_GSDMA_CH_CFG_DAT_MODE;
>> +    bool src_fixed = c->cfg & K230_GSDMA_CH_CFG_SRC_FIXED;
>> +    bool dst_fixed = c->cfg & K230_GSDMA_CH_CFG_DST_FIXED;
> The handling for chx_dat_endian is completely missing here. Could you please check this register field in the TRM and implement its functionality?

It will be added in the next patch.

>> [ ... skip 39 lines ... ]
>> +            remaining -= chunk;
>> +        }
>> +
>> +        if (!dat_mode) {
>> +            if (llt_cfg & K230_GSDMA_LLT_2D_MODE) { /*2d mode*/
>> +                src += line_size + line_space;
> The 2D mode semantics here don't match the TRM.
> According to the TRM, when in 2D mode and SRC_FIXED equals 1, the correct behaviour is that SRC_ADDR should not increment.
> There is currently no check here to determine whether SRC_FIXED is set to 1.

yes, it's a bug.

>> [ ... skip 62 lines ... ]
>> +            return;
>> +        }
>> +
>> +        addr = next;
>> +    }
>> +
> When CHx_CTL.START is written via MMIO, the entire llt is processed synchronously. During this period, the vCPU is unable to stop, resume, or reset command. This could potentially cause QEMU to be blocked here for an indefinite amount of time.
>
> For the implementation, please refer to the reference in i8257.c.

Yes, the transmission is processed synchronously after startup.
Only when the software is set incorrectly, such as LLT being a circular linked list.
DMA may fall into a dead loop, in which case stop and other operations cannot be performed.
I think we can add a limit on the maximum number of LLT processing times.
For example, when transmitting 1GB, assuming that LLT is performed every 4KB, the number of LLTs is 1GB/4KB=0x40000.


>> [ ... skip 315 lines ... ]
>> +static void k230_gsdma_class_init(ObjectClass *klass, const void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +
>> +    dc->realize = k230_gsdma_realize;
>> +    device_class_set_legacy_reset(dc, k230_gsdma_reset);
> This interface is no longer recommended for use. For further details, please refer to the comments for this interface in qdev.h.
>
--------------WPfMADm9LVBV7VF0omcZVp7w
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <pre class="moz-cite-prefix">On 7/26/2026 1:24 PM, Junze Cao wrote:
</pre>
    <blockquote type="cite"
      cite="mid:178504345275.903105.7911994626854937851.b4-review@b4">
      <pre wrap="" class="moz-quote-pre">On Wed, 22 Jul 2026 00:13:29 +0800, Tao Ding <a class="moz-txt-link-rfc2396E" href="mailto:dingtao0430@163.com">&lt;dingtao0430@163.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">diff --git a/hw/dma/k230_gsdma.c b/hw/dma/k230_gsdma.c
new file mode 100644
index 0000000000..1f76f62fa0
--- /dev/null
+++ b/hw/dma/k230_gsdma.c
@@ -0,0 +1,532 @@
[ ... skip 75 lines ... ]
+    /* Stride line size required for 2d mode */
+    uint32_t line_space = extract32(line_cfg, 16, 16);
+
+    bool dat_mode = c-&gt;cfg &amp; K230_GSDMA_CH_CFG_DAT_MODE;
+    bool src_fixed = c-&gt;cfg &amp; K230_GSDMA_CH_CFG_SRC_FIXED;
+    bool dst_fixed = c-&gt;cfg &amp; K230_GSDMA_CH_CFG_DST_FIXED;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
The handling for chx_dat_endian is completely missing here. Could you please check this register field in the TRM and implement its functionality?</pre>
    </blockquote>
    <pre>It will be added in the next patch.</pre>
    <blockquote type="cite"
      cite="mid:178504345275.903105.7911994626854937851.b4-review@b4">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">[ ... skip 39 lines ... ]
+            remaining -= chunk;
+        }
+
+        if (!dat_mode) {
+            if (llt_cfg &amp; K230_GSDMA_LLT_2D_MODE) { /*2d mode*/
+                src += line_size + line_space;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
The 2D mode semantics here don't match the TRM. 
According to the TRM, when in 2D mode and SRC_FIXED equals 1, the correct behaviour is that SRC_ADDR should not increment. 
There is currently no check here to determine whether SRC_FIXED is set to 1.
</pre>
    </blockquote>
    <pre>yes, it's a bug.</pre>
    <blockquote type="cite"
      cite="mid:178504345275.903105.7911994626854937851.b4-review@b4">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">[ ... skip 62 lines ... ]
+            return;
+        }
+
+        addr = next;
+    }
+
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
When CHx_CTL.START is written via MMIO, the entire llt is processed synchronously. During this period, the vCPU is unable to stop, resume, or reset command. This could potentially cause QEMU to be blocked here for an indefinite amount of time.

For the implementation, please refer to the reference in i8257.c.
</pre>
    </blockquote>
    <pre>Yes, the transmission is processed synchronously after startup. 
Only when the software is set incorrectly, such as LLT being a circular linked list.
DMA may fall into a dead loop, in which case stop and other operations cannot be performed.
I think we can add a limit on the maximum number of LLT processing times.
For example, when transmitting 1GB, assuming that LLT is performed every 4KB, the number of LLTs is 1GB/4KB=0x40000.


</pre>
    <blockquote type="cite"
      cite="mid:178504345275.903105.7911994626854937851.b4-review@b4">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">[ ... skip 315 lines ... ]
+static void k230_gsdma_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc-&gt;realize = k230_gsdma_realize;
+    device_class_set_legacy_reset(dc, k230_gsdma_reset);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
This interface is no longer recommended for use. For further details, please refer to the comments for this interface in qdev.h.

</pre>
    </blockquote>
  </body>
</html>

--------------WPfMADm9LVBV7VF0omcZVp7w--


