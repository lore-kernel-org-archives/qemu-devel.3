Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6945CC5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 17:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj0Q4-0005id-8j; Tue, 27 Aug 2024 13:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sj0Py-0005MO-Nj
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:55:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sj0Pw-0001aI-R6
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724781343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+7FDSigdPhQFBGGYHOIWVAHBn210TIYe7QY6ZLlGEfw=;
 b=R/4PPEJG5E9n0Np6cFVSHAUs50WuPTZRdGz1L1+s/tlxQk2Vrn2aKcTKyoMuiJoDTY15bW
 hNZvjRE0d0JrQRoBabAJP+wEwlRSuVic1kUbYFZ1PuOFS59IKsPAInsOKhTKiNGEQV4jZS
 OMGKa7aZitxY/7GpkHW2VM6OPoSpKuA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-wwkWZo6_PFumEVlKvEmoiw-1; Tue, 27 Aug 2024 13:55:42 -0400
X-MC-Unique: wwkWZo6_PFumEVlKvEmoiw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-428e48612acso63154295e9.3
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 10:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724781341; x=1725386141;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+7FDSigdPhQFBGGYHOIWVAHBn210TIYe7QY6ZLlGEfw=;
 b=DnpEpzjsgNJBPVufJEKZRMcY/vtzl1ykMruWWw6+yTagF+CHe9ePcfRDKBD38UoZ+r
 Eh39EUACy1eVfgks3RtFhR5oDvGdL6Sx/g8GNiHReg0D12s0sqyYjlCc060OkidUozcM
 4f/vvEoAi0phruWPfy64KKqn6s30J5boFE7J53j/AKmWasdB/t6V957DnZGH7vHpoHPu
 FpvwJEjvAPg+NACaqRDq+0tcRoz5lVDmahwfMGNv60h82L4STeKUb6Va9SqNpGERPg5h
 ZWv3gV/A/6ANA3yX9VyYdsCle34KWEwpZP4gm0X3VIBdbHYEfUWTyDCZabX+gk6PhI6W
 xRDA==
X-Gm-Message-State: AOJu0YxqjH1wQJZtzfVOQfC6Pf/5+RKcoJnLh4YjvsUzxNVmlyDUIES5
 7AyURi27/gjr6mkiPinZA6luKFOUpcBOpe8PbUXgy8/ciZiFGaiRjfkSA58bRGp5VJc1coPxdxo
 5TCTDhHvXp5re72up6sB3+rIsQ1PNOmDWpYJ8ILFHlhBJHb0Reuhe
X-Received: by 2002:a05:600c:4f83:b0:426:6ee7:d594 with SMTP id
 5b1f17b1804b1-42acd543423mr104470925e9.7.1724781340850; 
 Tue, 27 Aug 2024 10:55:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3a5W8DRpOdGexU5HDOqnmGONYKtaBiCLHbFopSw233HP+st8Rggmkz9KRIJC7t//53CH6Kw==
X-Received: by 2002:a05:600c:4f83:b0:426:6ee7:d594 with SMTP id
 5b1f17b1804b1-42acd543423mr104470715e9.7.1724781339863; 
 Tue, 27 Aug 2024 10:55:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c742:a100:9dd2:c523:f5fd:da19?
 (p200300cbc742a1009dd2c523f5fdda19.dip0.t-ipconnect.de.
 [2003:cb:c742:a100:9dd2:c523:f5fd:da19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ac514e04dsm193768945e9.6.2024.08.27.10.55.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Aug 2024 10:55:39 -0700 (PDT)
Message-ID: <fe612a16-8626-40be-81a2-2e8287b20fa2@redhat.com>
Date: Tue, 27 Aug 2024 19:55:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] softmmu/physmem: fix memory leak in
 dirty_memory_extend()
To: Peter Xu <peterx@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240827083715.257768-1-david@redhat.com>
 <CAJSP0QX+NiO7An468cKMFja3TGmgGzyNcPZjEtpPrfi3Q_1xgw@mail.gmail.com>
 <36402f8f-dc97-4eaf-8197-1df2bc01720b@redhat.com>
 <CAJSP0QWed1ZjRZ2pkUgx0j+9bepKg1hfaWXQLzP613xsiHtwyw@mail.gmail.com>
 <Zs4SA8CYxK15CG_5@x1n>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zs4SA8CYxK15CG_5@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 27.08.24 19:50, Peter Xu wrote:
> On Tue, Aug 27, 2024 at 01:28:02PM -0400, Stefan Hajnoczi wrote:
>> On Tue, 27 Aug 2024 at 13:24, David Hildenbrand <david@redhat.com> wrote:
>>>
>>> On 27.08.24 18:52, Stefan Hajnoczi wrote:
>>>> On Tue, 27 Aug 2024 at 04:38, David Hildenbrand <david@redhat.com> wrote:
>>>>>
>>>>> As reported by Peter, we might be leaking memory when removing the
>>>>> highest RAMBlock (in the weird ram_addr_t space), and adding a new one.
>>>>>
>>>>> We will fail to realize that we already allocated bitmaps for more
>>>>> dirty memory blocks, and effectively discard the pointers to them.
>>>>>
>>>>> Fix it by getting rid of last_ram_page() and simply storing the number
>>>>> of dirty memory blocks that have been allocated. We'll store the number
>>>>> of blocks along with the actual pointer to keep it simple.
>>>>>
>>>>> Looks like this leak was introduced as we switched from using a single
>>>>> bitmap_zero_extend() to allocating multiple bitmaps:
>>>>> bitmap_zero_extend() relies on g_renew() which should have taken care of
>>>>> this.
>>>>>
>>>>> Resolves: https://lkml.kernel.org/r/CAFEAcA-k7a+VObGAfCFNygQNfCKL=AfX6A4kScq=VSSK0peqPg@mail.gmail.com
>>>>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>>>>> Fixes: 5b82b703b69a ("memory: RCU ram_list.dirty_memory[] for safe RAM hotplug")
>>>>> Cc: qemu-stable@nongnu.org
>>>>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>>>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>>>> Cc: Peter Xu <peterx@redhat.com>
>>>>> Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>> ---
>>>>>    include/exec/ramlist.h |  1 +
>>>>>    system/physmem.c       | 44 ++++++++++++++----------------------------
>>>>>    2 files changed, 16 insertions(+), 29 deletions(-)
>>>>>
>>>>> diff --git a/include/exec/ramlist.h b/include/exec/ramlist.h
>>>>> index 2ad2a81acc..f2a965f293 100644
>>>>> --- a/include/exec/ramlist.h
>>>>> +++ b/include/exec/ramlist.h
>>>>> @@ -41,6 +41,7 @@ typedef struct RAMBlockNotifier RAMBlockNotifier;
>>>>>    #define DIRTY_MEMORY_BLOCK_SIZE ((ram_addr_t)256 * 1024 * 8)
>>>>>    typedef struct {
>>>>>        struct rcu_head rcu;
>>>>> +    unsigned int num_blocks;
>>>>
>>>> The maximum amount of memory supported by unsigned int is:
>>>> (2 ^ 32 - 1) * 4KB * DIRTY_MEMORY_BLOCK_SIZE
>>>> = ~32 exabytes
>>>>
>>>
>>> True, should we simply use ram_addr_t ?
>>
>> Sounds good to me. In practice scalability bottlenecks are likely with
>> those memory sizes and it will be necessary to change how guest memory
>> is organized anyway. But it doesn't hurt to make this counter
>> future-proof.
> 
> IMHO it'll be nice to only use ram_addr_t when a variable is describing the
> ramblock address space (with an offset, or a length there).  In this case
> it is a pure counter for how many bitmap chunks we allocated, so maybe
> "unsigned long" or "uint64_t" would suite more?
> 
> Though I'd think "unsigned int" is good enough per the calculation Stefan
> provided.

Likely best, "ram_addr_t" requires including "exec/cpu-common.h".

So let's stick to "unsigned int" for now. Likely best to also include for consistency:

diff --git a/system/physmem.c b/system/physmem.c
index fa48ff8333..e1391492fd 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1789,14 +1789,14 @@ void qemu_ram_msync(RAMBlock *block, ram_addr_t start, ram_addr_t length)
  /* Called with ram_list.mutex held */
  static void dirty_memory_extend(ram_addr_t new_ram_size)
  {
-    ram_addr_t new_num_blocks = DIV_ROUND_UP(new_ram_size,
-                                             DIRTY_MEMORY_BLOCK_SIZE);
+    unsigned int new_num_blocks = DIV_ROUND_UP(new_ram_size,
+                                               DIRTY_MEMORY_BLOCK_SIZE);
      int i;
  
      for (i = 0; i < DIRTY_MEMORY_NUM; i++) {
          DirtyMemoryBlocks *old_blocks;
          DirtyMemoryBlocks *new_blocks;
-        ram_addr_t old_num_blocks = 0;
+        unsigned int old_num_blocks = 0;
          int j;
  
          old_blocks = qatomic_rcu_read(&ram_list.dirty_memory[i]);


> 
> Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks!

-- 
Cheers,

David / dhildenb


