Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5562C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 09:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJTmm-0003BE-Ls; Mon, 26 May 2025 05:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uJTmk-00039t-Nk
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:06:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uJTmi-0000lO-AQ
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748250375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ETfJt7uNoG4312JPyvmiSg2Go85laadRukbqwKIKcNo=;
 b=a+bPj0WzYnfA3FTbpEG6BWRvGVkYCamNXImQIhGzPK7UMxTl/Pihb548zrvvW1mx4spVp0
 eTHixS/pprGjKc+BcMMChxBb8UdPdB0oXVcR4MVunprYr3AdfhLZJryYBDIfV6KU4p6iMF
 62+na9n/Efr4qjngbKl6oOQMCKjD6jg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-345q0XpcNnaLfFPy4_x8ng-1; Mon, 26 May 2025 05:06:14 -0400
X-MC-Unique: 345q0XpcNnaLfFPy4_x8ng-1
X-Mimecast-MFC-AGG-ID: 345q0XpcNnaLfFPy4_x8ng_1748250373
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cf44b66f7so11667705e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 02:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748250373; x=1748855173;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ETfJt7uNoG4312JPyvmiSg2Go85laadRukbqwKIKcNo=;
 b=gRUf1IkrbSSuzXvtZ1/FqwYJFWxwN4oEZopWcL5Fb0uNzO4YQjlWusLUdDKbEiJTkk
 zeiyKntz0eh9IfEXXjoCSzlouAaQyzoLHD+3wfP9EZg1Vx6jYomZSkfQx+U8cRXtQfBK
 LbsJBwNP+GqWvDhRiQuI8nnAiBR5JiHUCgIO9jqhVOIc0SPqw94a4Fto41fQKzcQBDDA
 SEFnPcWmXvhKwYC8ETmHuhdcGe5rA9Ov5xKII9UFcJWgqnPM55Y1IMhmd3+NZSdlCoDq
 D83+0BHaq5HpcRARHlC5QBMGmKCbpOlMg8/P9bR8Tw7REcIZ8tPd/WIUobHljZKJFjPJ
 1ewg==
X-Gm-Message-State: AOJu0YyKRaMcSzU+bOJSFR0Y6lS8BfZYetyW+AkcER/J8vRyp9izxi/c
 k+s8zfw2n/7/Jd+DAXOxRsogL4rPXCGLMMlXtnK7jzbcUwUhHr7bQnOK10n3mKixC8XXJHISDoj
 NolplWAiJ1RGtCXohBhhXf5IRbbdjut0wiepSvwdGujMsrV5uNE0Q6/Rd
X-Gm-Gg: ASbGnct2S0FlQPDMee1UtmYuxAyfvPeYR+E9vHNK/o+D3ZeaGcSp74fc3invsIJ8lbf
 vdhUxwe6bHKTwXscuaMTBGvq7psEDiVPl+AKZYh4ICg+HNBxLdlRwrYuF3GRlNz6vlR80ImLqFm
 zY2CISMxznc43Lp0p9gt+s0q1iA5wJOtL3RebvgNxAvJKHSsAQ8ylg5HdGixcdyDMUWub4GQcjC
 QliWLoKvfwlDFx19GYVtZecTL/3PWxYAhUjF8LWberR5XlOYcd678tL6r9HoKNiVWMGGuC79tCl
 PZ+BUS9OwSoHWODbrHXA+nEOGqJFFz3ZlgzVmZc5Kb1/fLURItArdO1YucfBfnmMsCNjCk/pE6z
 dTX1AdZM3q8qvJsiK6lrREtRgvMS39s9CP9Gw5fc=
X-Received: by 2002:a05:600c:22c1:b0:442:dc6e:b9a6 with SMTP id
 5b1f17b1804b1-44c91dcc104mr58685705e9.17.1748250372649; 
 Mon, 26 May 2025 02:06:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQajF7W8Ky0PnIT7msrygsvDZEux0zYBVRLwzJpWPDsN6a9kDdML90ZGzqQbLcEjqC9qLnlg==
X-Received: by 2002:a05:600c:22c1:b0:442:dc6e:b9a6 with SMTP id
 5b1f17b1804b1-44c91dcc104mr58685415e9.17.1748250372190; 
 Mon, 26 May 2025 02:06:12 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f19:6500:e1c1:8216:4c25:efe4?
 (p200300d82f196500e1c182164c25efe4.dip0.t-ipconnect.de.
 [2003:d8:2f19:6500:e1c1:8216:4c25:efe4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f7d975f4sm228362635e9.39.2025.05.26.02.06.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 02:06:11 -0700 (PDT)
Message-ID: <d22512b9-d5f0-4e0f-9a4c-530767953f3c@redhat.com>
Date: Mon, 26 May 2025 11:06:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/10] memory: Attach RamBlockAttribute to
 guest_memfd-backed RAMBlocks
To: Chenyi Qiang <chenyi.qiang@intel.com>, Alexey Kardashevskiy
 <aik@amd.com>, Peter Xu <peterx@redhat.com>,
 Gupta Pankaj <pankaj.gupta@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Williams Dan J <dan.j.williams@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Baolu Lu <baolu.lu@linux.intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
References: <20250520102856.132417-1-chenyi.qiang@intel.com>
 <20250520102856.132417-7-chenyi.qiang@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250520102856.132417-7-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 20.05.25 12:28, Chenyi Qiang wrote:
> A new field, ram_shared, was introduced in RAMBlock to link to a
> RamBlockAttribute object, which centralizes all guest_memfd state
> information (such as fd and shared_bitmap) within a RAMBlock.
> 
> Create and initialize the RamBlockAttribute object upon ram_block_add().
> Meanwhile, register the object in the target RAMBlock's MemoryRegion.
> After that, guest_memfd-backed RAMBlock is associated with the
> RamDiscardManager interface, and the users will execute
> RamDiscardManager specific handling. For example, VFIO will register the
> RamDiscardListener as expected. The live migration path needs to be
> avoided since it is not supported yet in confidential VMs.
> 
> Additionally, use the ram_block_attribute_state_change() helper to
> notify the registered RamDiscardListener of these changes.
> 
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> ---
> Changes in v5:
>      - Revert to use RamDiscardManager interface.
>      - Move the object_new() into the ram_block_attribute_create()
>        helper.
>      - Add some check in migration path.
> 
> Changes in v4:
>      - Remove the replay operations for attribute changes which will be
>        handled in a listener in following patches.
>      - Add some comment in the error path of realize() to remind the
>        future development of the unified error path.
> 
> Changes in v3:
>      - Use ram_discard_manager_reply_populated/discarded() to set the
>        memory attribute and add the undo support if state_change()
>        failed.
>      - Didn't add Reviewed-by from Alexey due to the new changes in this
>        commit.
> 
> Changes in v2:
>      - Introduce a new field memory_attribute_manager in RAMBlock.
>      - Move the state_change() handling during page conversion in this patch.
>      - Undo what we did if it fails to set.
>      - Change the order of close(guest_memfd) and memory_attribute_manager cleanup.
> ---
>   accel/kvm/kvm-all.c |  9 +++++++++
>   migration/ram.c     | 28 ++++++++++++++++++++++++++++
>   system/physmem.c    | 14 ++++++++++++++
>   3 files changed, 51 insertions(+)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 51526d301b..2d7ecaeb6a 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -3089,6 +3089,15 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
>       addr = memory_region_get_ram_ptr(mr) + section.offset_within_region;
>       rb = qemu_ram_block_from_host(addr, false, &offset);
>   
> +    ret = ram_block_attribute_state_change(RAM_BLOCK_ATTRIBUTE(mr->rdm),
> +                                           offset, size, to_private);
> +    if (ret) {
> +        error_report("Failed to notify the listener the state change of "
> +                     "(0x%"HWADDR_PRIx" + 0x%"HWADDR_PRIx") to %s",
> +                     start, size, to_private ? "private" : "shared");
> +        goto out_unref;
> +    }
> +
>       if (to_private) {
>           if (rb->page_size != qemu_real_host_page_size()) {
>               /*
> diff --git a/migration/ram.c b/migration/ram.c
> index c004f37060..69c9a42f16 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -890,6 +890,13 @@ static uint64_t ramblock_dirty_bitmap_clear_discarded_pages(RAMBlock *rb)
>   
>       if (rb->mr && rb->bmap && memory_region_has_ram_discard_manager(rb->mr)) {
>           RamDiscardManager *rdm = memory_region_get_ram_discard_manager(rb->mr);
> +
> +        if (object_dynamic_cast(OBJECT(rdm), TYPE_RAM_BLOCK_ATTRIBUTE)) {
> +            error_report("%s: Live migration for confidential VM is not "
> +                         "supported yet.", __func__);
> +            exit(1);
> +        }
>

These checks seem conceptually wrong.

I think if we were to special-case specific implementations, we should 
do so using a different callback.

But why should we bother at all checking basic live migration handling 
("unsupported for confidential VMs") on this level, and even just 
exit()'ing the process?

All these object_dynamic_cast() checks in this patch should be dropped.

-- 
Cheers,

David / dhildenb


