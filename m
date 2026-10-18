Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B58CCCA490
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIRE5-0001xD-OE; Sun, 18 Oct 2026 09:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xIRE3-0001wa-Ic
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 09:46:59 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xIRE1-0003Ic-1U
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 09:46:58 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3ad2b3b1c02so79793a91.1
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 06:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792331215; x=1792936015; darn=nongnu.org;
 h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
 :date:message-id:content-type:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=v3WCI1tUGo09VV1rtuj2xXf776KiLDgjfSpYL4m1xtI=;
 b=ZNhLCSoJ0TZZYZ22lRNs4MsRkPmmvHR1rODIq/tGRgwv9M1EexDKgta23Hoz4OBLaz
 SzCu/eROflFnJgf/yN0f7mQRQZf63oV4wZhpmeLYo59NrU/yVRaED8chCiGSodLJYGnE
 /Tqd849Czv1AFW+oeLSBrWU0jB1WCiTsajz5fw2Z7f3Uug3iTgUD4w+XorBuSk1Rb2hB
 LxSLBzUPtbq0p5oeN/kuveliUSJpRSuKjo1XJ3XvDvyKOJn1QkmMkpr5P0EiZhPOw5OW
 owBE7ky3vD3LIvfazKkjekeHpzIaHsUEl5x3amXYfT7etbn+nqxLo/3IY/mzMiU5vKyF
 AGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792331215; x=1792936015;
 h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
 :date:message-id:content-type:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=v3WCI1tUGo09VV1rtuj2xXf776KiLDgjfSpYL4m1xtI=;
 b=OFfCiVZ9kvA9HBjj4/STGRXX926ZcAecU9vvLYDEUK+kccskkoaFSTy9ebVz8Z2h6u
 QbFCNmOJFa4ApvZNX+PEB6mFMnbl/h/yXiGWlvYSFHH5BUm5eT3Fsk2USEsXzkLl4bWC
 0laDhK1AXocon09sYBlTr+gdU8hmEk467QzhrxKVHYYVVIupIyiUQaOCWabevmD0252l
 aKmLAIWLos/ngyF/Xzea/6FQXaNVfwgNYeO4UNcJqEkWJIx7xOLYlnXlyqrv7ktlFmNl
 pvjNB6s1IV1Bx5819+6OpdzPMezJdXoGEuXzM9YA9vofouTMysZfvb3sl/0QMKtNzZUW
 raxA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzcq5sKukPUx5MHdElJ9t5Cbo61KN0pxbzGGOh0uYhPSBLkJ0gKDGBkm+ILK6KIH1XqB/TaTBYAVs1H@nongnu.org
X-Gm-Message-State: AFq9FYLKq3xQJmT8fgoK4IPEJX+Sl0s13MEkxWKO21TWhhpZjwfh+QKw
 c9/FJkx9R8PeLrRFKgTheeWEWhfRADHLA0trJj9TGlil8TXDFmAbxn8j
X-Gm-Gg: AYBFou04XdSIlZhYgBcBrjIVwEKuEd7foQLkcRB+eZutUwAlZ7zYf9rKYP8Z5vHzFkT
 x4xyzbBj2sYEY/UP/2j5lmm5WKx5xSehLgbgcL0WuwdY4RTqcwOKtfgV5Lxa8XBVnzHjvpy61OU
 G1fU8vIsVDTwXn4epsxa2NBKMABZaFqIc3Jr0iLFSX1rxn+d6XfoDZpzQ/qvEZl7GgUvVNZfjnU
 sdeuVf/fPwRFSmU3JXlyrXkxYba/XLRqZpRFzeYfXQl1CIZCyfCTLbrspGeYas5VOkwBvL+OagN
 xG524Cjx3z56W9wZwS2sxrD0kkglCh34YubfPXFnQj9XrCKJOxEkRlSmVu1tW5tEUa8Z5cDYW7x
 9sLHJCo36F9QQGhniKG4HBIpE/BuH1B7ObflwPqzcaWyPd9KMv/bTwxiWUc30cUn2P6RSpm3zBh
 T34+OMCNKV+Mbba130Ds6n6H4sW9DpA/IMjM23nBCtNV+sCeFM/HH7FRlPdmrq8JurstIAd4aHl
 mKdys5vl205BlQ=
X-Received: by 2002:a17:90b:224e:b0:3a8:59d3:530f with SMTP id
 98e67ed59e1d1-3acef596160mr4508914a91.57.1792331215105; 
 Sun, 18 Oct 2026 06:46:55 -0700 (PDT)
Received: from [192.168.3.23] ([101.204.150.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acddc37958sm10094382a91.14.2026.10.18.06.46.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Oct 2026 06:46:54 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------f7XP9C0ic0mTre50cVJYPPGR"
Message-ID: <1ab73f47-b18c-4e6f-86e1-749d2cc066d1@gmail.com>
Date: Sun, 18 Oct 2026 21:46:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Fix integer handling issues in k230_gsdma and
 k230_decomp_gzip
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "dingtao0430@163.com" <dingtao0430@163.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>
References: <20261002140245.30214-1-dingtao0430@163.com>
 <e0d56fe8e8d4286bfead76189dad550ed5b7db7b.camel@wdc.com>
From: Tao Ding <dingtaodtdt@gmail.com>
In-Reply-To: <e0d56fe8e8d4286bfead76189dad550ed5b7db7b.camel@wdc.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=dingtaodtdt@gmail.com; helo=mail-pj1-x1029.google.com
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
--------------f7XP9C0ic0mTre50cVJYPPGR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

CID 1685513 appears to be an existing issue rather than one introduced by my patch.
I’m also not familiar with this part of the code, so it may be better handled by the relevant maintainer.

On 10/16/2026 10:06 AM, Alistair Francis wrote:

> On Fri, 2026-10-02 at 22:02 +0800, Tao Ding wrote:
>> Hi, all
>>
>> This series fixes integer overflow, truncation, and underflow issues
>> reported by Coverity in the K230 GZIP decompressor, its qtest, and
>> GSDMA.
>> https://lore.kernel.org/qemu-devel/5fc57f49cea0ac3542128d0e2208edd6d7484f7e.camel@wdc.com/
> What about 1685513?
>
> Alistair
>
>> Thanks.
>>
>> The patchv1 series is posted in:
>> https://lore.kernel.org/qemu-devel/20261001022223.8633-1-dingtao0430@163.com/T
>>
>> Changes in v1->v2:
>> - Split the original k230_decomp_gzip patch into three patches, one
>> for
>>    each integer handling issue.
>> - Remove the modifications "ch" in patchv1 3/3, which is now patchv2
>> 5/5.
>>
>> Tao Ding (5):
>>    hw/misc: fix calculating output address overflow in
>> k230_decomp_gzip
>>    hw/misc: fix calculating input address overflow in k230_decomp_gzip
>>    hw/misc: use hwaddr for the k230_decomp_gzip input address
>>    qtest: fix k230_decomp_gzip test integer handling issues
>>    hw/dma: fix k230_gsdma integer handling issues
>>
>>   hw/dma/k230_gsdma.c                 | 4 ++++
>>   hw/misc/k230_decomp_gzip.c          | 6 +++---
>>   tests/qtest/k230-decomp-gzip-test.c | 2 +-
>>   3 files changed, 8 insertions(+), 4 deletions(-)
>>
>>
>> base-commit: 0a1ebd448b38afaa118597cbb633dbec24ef74d3
--------------f7XP9C0ic0mTre50cVJYPPGR
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <pre>CID 1685513 appears to be an existing issue rather than one introduced by my patch. 
I’m also not familiar with this part of the code, so it may be better handled by the relevant maintainer.</pre>
    <pre class="moz-cite-prefix">On 10/16/2026 10:06 AM, Alistair Francis wrote:
</pre>
    <blockquote type="cite"
      cite="mid:e0d56fe8e8d4286bfead76189dad550ed5b7db7b.camel@wdc.com">
      <pre wrap="" class="moz-quote-pre">On Fri, 2026-10-02 at 22:02 +0800, Tao Ding wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Hi, all

This series fixes integer overflow, truncation, and underflow issues
reported by Coverity in the K230 GZIP decompressor, its qtest, and
GSDMA.
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/5fc57f49cea0ac3542128d0e2208edd6d7484f7e.camel@wdc.com/">https://lore.kernel.org/qemu-devel/5fc57f49cea0ac3542128d0e2208edd6d7484f7e.camel@wdc.com/</a>
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
What about 1685513?

Alistair

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Thanks.

The patchv1 series is posted in:
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/20261001022223.8633-1-dingtao0430@163.com/T">https://lore.kernel.org/qemu-devel/20261001022223.8633-1-dingtao0430@163.com/T</a>

Changes in v1-&gt;v2:
- Split the original k230_decomp_gzip patch into three patches, one
for
  each integer handling issue.
- Remove the modifications "ch" in patchv1 3/3, which is now patchv2
5/5.

Tao Ding (5):
  hw/misc: fix calculating output address overflow in
k230_decomp_gzip
  hw/misc: fix calculating input address overflow in k230_decomp_gzip
  hw/misc: use hwaddr for the k230_decomp_gzip input address
  qtest: fix k230_decomp_gzip test integer handling issues
  hw/dma: fix k230_gsdma integer handling issues

 hw/dma/k230_gsdma.c                 | 4 ++++
 hw/misc/k230_decomp_gzip.c          | 6 +++---
 tests/qtest/k230-decomp-gzip-test.c | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)


base-commit: 0a1ebd448b38afaa118597cbb633dbec24ef74d3
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------f7XP9C0ic0mTre50cVJYPPGR--

