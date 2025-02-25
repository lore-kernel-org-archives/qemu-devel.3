Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F597C021B8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 09:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmrRi-0005Gp-9p; Tue, 25 Feb 2025 04:41:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tmrRf-0005GT-1d
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 04:41:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tmrRc-0005TP-F3
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 04:41:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740476497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tFkUmkSDtkuHo3J8hZfs90GERVA3Av7WUJFHM1cfhpA=;
 b=dIOxoyxxw80q/22+7k3IzSZP58wrP6g7N5srYuiwqsc6KJ5fqTf1RPxHPef2uG1Tls676L
 vgYDEtt83hOGmE2N3m4hpJKLarpdF+3g10cW/XRe2UPUiOUkDutpHliMwKhMcme1oFQo2P
 5uUIEFmsPwCgpJcaDDeE1QmGVXIqhKw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-AlNNpOWxNi-j2nJ7CnDhtw-1; Tue, 25 Feb 2025 04:41:36 -0500
X-MC-Unique: AlNNpOWxNi-j2nJ7CnDhtw-1
X-Mimecast-MFC-AGG-ID: AlNNpOWxNi-j2nJ7CnDhtw_1740476495
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38f4e6e004fso3980096f8f.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 01:41:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740476494; x=1741081294;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=tFkUmkSDtkuHo3J8hZfs90GERVA3Av7WUJFHM1cfhpA=;
 b=f3Qt/q5ggYTXarjouKkx7cvYsKRuE5ox426L6pj7vACZxkyydyHp1G7DaSuXJacv73
 XMVzEgEwZbtKvVcdPit9ziutdS64eEBNOSF88fDClOu5BfIS5H63bT2QjLPeASKsIExH
 t8wYm7mFjreHTOT6PbnVGiAcK3ZSMGYzC2j2pmb0/CMUhkdnGNKTx1JqyypWEqA+Cju2
 bI2M/VjN6gk7lTQ2Ah258JyfWNQszGtgTSjXNo1N9sMuVkFwM+ngZFc/4WQTxjAjsJYr
 cfeYA8UiLzq2SOk/Y+RK/G49jg62I5wvfNVt2gyfzYSY4BH1Lfr4lFZAUUlU1rBJ/2br
 mBNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHlj+N9b0kITsTvRIXZT8ONN+hMkPlrI58AWX96lNZRVHWeHDmkyDujKy74NdlnevGkyKjjRscxlRx@nongnu.org
X-Gm-Message-State: AOJu0YwvOP6/dg0UwqKDQi46awTObnwoh+DGYzPzdQpX4CQbKyWL26nC
 lIVjBnkkl+E0gRWNmb7NIVFzp9/gwA2ISkr+zPAa8WvbaDztsaKxfRpwvV7wnqUeeB1b5we2uPZ
 ZQ3CoBAbHCqmnEs1tHrpRaKD4VsZv4MYVw50qtU7akaJZMX16jiRz
X-Gm-Gg: ASbGncu/D/xq8xXswSF74KqCHil/2PhtZFhiBcKb7jjlJ87aIAyXRtN7KhsFBkB/GKk
 CIa1f+4cjkhrruhxijlvKD5w3Udiuoranlvdz/OWeD20sGo/bM8yz+hI5FbElKW5Jl0oosJoX7x
 PDQVwyxw7oKJ363Xz7/IrnDZRGCvET1rCImgM+YK0sWtu7uAYJ5e6xa/e0lrlxTSKIauDmfnVNo
 e7WxP1aQw2ixWqThol+iCvtYPyV4Vhbflhh/2MnKhCKJ6/nppdfQBjqKAI2Mmdxc4Ye9r81ZopZ
 EqRLwX8csN+UwU0Sz07NbqKAd+20myIr3+s7ucnqeEKMlnMyjrGw9gUpIDssg2CkW0gZj0K+2QR
 bn5PQzzJkOx0gGkrN6kUGt8W7u4y5/ef5NXgw3XfgyIM=
X-Received: by 2002:a5d:5f87:0:b0:38f:2a49:f6a5 with SMTP id
 ffacd0b85a97d-38f6e9595demr11714579f8f.15.1740476494515; 
 Tue, 25 Feb 2025 01:41:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmlVLcWm6SSbJjgUkriDJi/SEMfUYULpZSF61XhG7i4RIUDqtC4iwzMjI0P1KvlVrxP6/sAw==
X-Received: by 2002:a5d:5f87:0:b0:38f:2a49:f6a5 with SMTP id
 ffacd0b85a97d-38f6e9595demr11714546f8f.15.1740476494055; 
 Tue, 25 Feb 2025 01:41:34 -0800 (PST)
Received: from ?IPV6:2003:cb:c73e:aa00:c9db:441d:a65e:6999?
 (p200300cbc73eaa00c9db441da65e6999.dip0.t-ipconnect.de.
 [2003:cb:c73e:aa00:c9db:441d:a65e:6999])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab14caa5esm20474505e9.0.2025.02.25.01.41.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 01:41:33 -0800 (PST)
Message-ID: <4a589056-b331-4dde-aa77-9129106a14c0@redhat.com>
Date: Tue, 25 Feb 2025 10:41:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] system/memory: Allow creating IOMMU mappings from RAM
 discard populate notifiers
To: Chenyi Qiang <chenyi.qiang@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, philmd@linaro.org,
 peterx@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org,
 Alexey Kardashevskiy <aik@amd.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20250220161320.518450-2-jean-philippe@linaro.org>
 <20250220161320.518450-3-jean-philippe@linaro.org>
 <0d761daf-174d-487f-80fe-09b04902006f@redhat.com>
 <75d90f78-151f-4169-84f5-cc3c13180518@intel.com>
 <ce2306f9-19a4-4979-80e6-29b1e8a92318@redhat.com>
 <108be3a5-cfc1-4268-a913-3a41d1e4451f@intel.com>
 <16cb9605-ba4c-441e-8709-369a37655b4a@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <16cb9605-ba4c-441e-8709-369a37655b4a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 25.02.25 03:00, Chenyi Qiang wrote:
> 
> 
> On 2/21/2025 6:04 PM, Chenyi Qiang wrote:
>>
>>
>> On 2/21/2025 4:09 PM, David Hildenbrand wrote:
>>> On 21.02.25 03:25, Chenyi Qiang wrote:
>>>>
>>>>
>>>> On 2/21/2025 3:39 AM, David Hildenbrand wrote:
>>>>> On 20.02.25 17:13, Jean-Philippe Brucker wrote:
>>>>>> For Arm CCA we'd like the guest_memfd discard notifier to call the
>>>>>> IOMMU
>>>>>> notifiers and create e.g. VFIO mappings. The default VFIO discard
>>>>>> notifier isn't sufficient for CCA because the DMA addresses need a
>>>>>> translation (even without vIOMMU).
>>>>>>
>>>>>> At the moment:
>>>>>> * guest_memfd_state_change() calls the populate() notifier
>>>>>> * the populate notifier() calls IOMMU notifiers
>>>>>> * the IOMMU notifier handler calls memory_get_xlat_addr() to get a VA
>>>>>> * it calls ram_discard_manager_is_populated() which fails.
>>>>>>
>>>>>> guest_memfd_state_change() only changes the section's state after
>>>>>> calling the populate() notifier. We can't easily invert the order of
>>>>>> operation because it uses the old state bitmap to know which pages need
>>>>>> the populate() notifier.
>>>>>
>>>>> I assume we talk about this code: [1]
>>>>>
>>>>> [1] https://lkml.kernel.org/r/20250217081833.21568-1-
>>>>> chenyi.qiang@intel.com
>>>>>
>>>>>
>>>>> +static int memory_attribute_state_change(MemoryAttributeManager *mgr,
>>>>> uint64_t offset,
>>>>> +                                         uint64_t size, bool
>>>>> shared_to_private)
>>>>> +{
>>>>> +    int block_size = memory_attribute_manager_get_block_size(mgr);
>>>>> +    int ret = 0;
>>>>> +
>>>>> +    if (!memory_attribute_is_valid_range(mgr, offset, size)) {
>>>>> +        error_report("%s, invalid range: offset 0x%lx, size 0x%lx",
>>>>> +                     __func__, offset, size);
>>>>> +        return -1;
>>>>> +    }
>>>>> +
>>>>> +    if ((shared_to_private && memory_attribute_is_range_discarded(mgr,
>>>>> offset, size)) ||
>>>>> +        (!shared_to_private && memory_attribute_is_range_populated(mgr,
>>>>> offset, size))) {
>>>>> +        return 0;
>>>>> +    }
>>>>> +
>>>>> +    if (shared_to_private) {
>>>>> +        memory_attribute_notify_discard(mgr, offset, size);
>>>>> +    } else {
>>>>> +        ret = memory_attribute_notify_populate(mgr, offset, size);
>>>>> +    }
>>>>> +
>>>>> +    if (!ret) {
>>>>> +        unsigned long first_bit = offset / block_size;
>>>>> +        unsigned long nbits = size / block_size;
>>>>> +
>>>>> +        g_assert((first_bit + nbits) <= mgr->bitmap_size);
>>>>> +
>>>>> +        if (shared_to_private) {
>>>>> +            bitmap_clear(mgr->shared_bitmap, first_bit, nbits);
>>>>> +        } else {
>>>>> +            bitmap_set(mgr->shared_bitmap, first_bit, nbits);
>>>>> +        }
>>>>> +
>>>>> +        return 0;
>>>>> +    }
>>>>> +
>>>>> +    return ret;
>>>>> +}
>>>>>
>>>>> Then, in memory_attribute_notify_populate(), we walk the bitmap again.
>>>>>
>>>>> Why?
>>>>>
>>>>> We just checked that it's all in the expected state, no?
>>>>>
>>>>>
>>>>> virtio-mem doesn't handle it that way, so I'm curious why we would have
>>>>> to do it here?
>>>>
>>>> I was concerned about the case where the guest issues a request that
>>>> only partial of the range is in the desired state.
>>>> I think the main problem is the policy for the guest conversion request.
>>>> My current handling is:
>>>>
>>>> 1. When a conversion request is made for a range already in the desired
>>>>     state, the helper simply returns success.
>>>
>>> Yes.
>>>
>>>> 2. For requests involving a range partially in the desired state, only
>>>>     the necessary segments are converted, ensuring the entire range
>>>>     complies with the request efficiently.
>>>
>>>
>>> Ah, now I get:
>>>
>>> +    if ((shared_to_private && memory_attribute_is_range_discarded(mgr,
>>> offset, size)) ||
>>> +        (!shared_to_private && memory_attribute_is_range_populated(mgr,
>>> offset, size))) {
>>> +        return 0;
>>> +    }
>>> +
>>>
>>> We're not failing if it might already partially be in the other state.
>>>
>>>> 3. In scenarios where a conversion request is declined by other systems,
>>>>     such as a failure from VFIO during notify_populate(), the helper will
>>>>     roll back the request, maintaining consistency.
>>>>
>>>> And the policy of virtio-mem is to refuse the state change if not all
>>>> blocks are in the opposite state.
>>>
>>> Yes.
>>>
>>>>
>>>> Actually, this part is still a uncertain to me.
>>>>
>>>
>>> IIUC, the problem does not exist if we only convert a single page at a
>>> time.
>>>
>>> Is there a known use case where such partial conversions could happen?
>>
>> I don't see such case yet. Actually, I'm trying to follow the behavior
>> of KVM_SET_MEMORY_ATTRIBUTES ioctl during page conversion. In KVM, it
>> doesn't reject the request if the whole range isn't in the opposite
>> state. It just uses xa_store() to update it. Also, I don't see the spec
>> says how to handle such case. To be robust, I just allow this special case.
>>
>>>
>>>> BTW, per the status/bitmap track, the virtio-mem also changes the bitmap
>>>> after the plug/unplug notifier. This is the same, correct?
>>> Right. But because we reject these partial requests, we don't have to
>>> traverse the bitmap and could just adjust the bitmap operations.
>>
>> Yes, If we treat it as a guest error/bug, we can adjust it.
> 
> Hi David, do you think which option is better? If prefer to reject the
> partial requests, I'll change it in my next version.

Hi,

still scratching my head. Having to work around it as in this patch here is
suboptimal.

Could we simplify the whole thing while still allowing for (unexpected) partial
conversions?

Essentially: If states are mixed, fallback to a "1 block at a time" handling.

The only problem is: what to do if we fail halfway through? Well, we can only have
such partial completions for "populate", not for discard.

Option a) Just leave it as "partially completed populate" and return the error. The
bitmap and the notifiers are consistent.

Option b) Just discard everything: someone tried to convert something "partial
shared" to "shared". So maybe, if anything goes wrong, we can just have "all private".

The question is also, what the expectation from the caller is: can the caller
even make progress on failure or do we have to retry until it works?

Both options would be compatible with "the caller must retry either way until it works".

a) is probably easiest. Something like the following on top of your code:



 From 40c001a57c3c1350f3a44288ccb013d903d300cf Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Tue, 25 Feb 2025 09:55:38 +0100
Subject: [PATCH] tmp

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  system/memory-attribute-manager.c | 66 +++++++++++++++++--------------
  1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/system/memory-attribute-manager.c b/system/memory-attribute-manager.c
index 17c70cf677..31960e4a54 100644
--- a/system/memory-attribute-manager.c
+++ b/system/memory-attribute-manager.c
@@ -274,9 +274,7 @@ static void memory_attribute_notify_discard(MemoryAttributeManager *mgr,
          if (!memory_region_section_intersect_range(&tmp, offset, size)) {
              continue;
          }
-
-        memory_attribute_for_each_populated_section(mgr, &tmp, rdl,
-                                                    memory_attribute_notify_discard_cb);
+        rdl->notify_discard(rdl, &tmp);
      }
  }
  
@@ -292,9 +290,7 @@ static int memory_attribute_notify_populate(MemoryAttributeManager *mgr,
          if (!memory_region_section_intersect_range(&tmp, offset, size)) {
              continue;
          }
-
-        ret = memory_attribute_for_each_discarded_section(mgr, &tmp, rdl,
-                                                          memory_attribute_notify_populate_cb);
+        ret = rdl->notify_populate(rdl, &tmp);
          if (ret) {
              break;
          }
@@ -311,9 +307,7 @@ static int memory_attribute_notify_populate(MemoryAttributeManager *mgr,
              if (!memory_region_section_intersect_range(&tmp, offset, size)) {
                  continue;
              }
-
-            memory_attribute_for_each_discarded_section(mgr, &tmp, rdl2,
-                                                        memory_attribute_notify_discard_cb);
+            rdl2->notify_discard(rdl2, &tmp);
          }
      }
      return ret;
@@ -348,7 +342,10 @@ static bool memory_attribute_is_range_discarded(MemoryAttributeManager *mgr,
  static int memory_attribute_state_change(MemoryAttributeManager *mgr, uint64_t offset,
                                           uint64_t size, bool shared_to_private)
  {
-    int block_size = memory_attribute_manager_get_block_size(mgr);
+    const int block_size = memory_attribute_manager_get_block_size(mgr);
+    const unsigned long first_bit = offset / block_size;
+    const unsigned long nbits = size / block_size;
+    uint64_t cur_offset;
      int ret = 0;
  
      if (!memory_attribute_is_valid_range(mgr, offset, size)) {
@@ -357,32 +354,41 @@ static int memory_attribute_state_change(MemoryAttributeManager *mgr, uint64_t o
          return -1;
      }
  
-    if ((shared_to_private && memory_attribute_is_range_discarded(mgr, offset, size)) ||
-        (!shared_to_private && memory_attribute_is_range_populated(mgr, offset, size))) {
-        return 0;
-    }
-
      if (shared_to_private) {
-        memory_attribute_notify_discard(mgr, offset, size);
-    } else {
-        ret = memory_attribute_notify_populate(mgr, offset, size);
-    }
-
-    if (!ret) {
-        unsigned long first_bit = offset / block_size;
-        unsigned long nbits = size / block_size;
-
-        g_assert((first_bit + nbits) <= mgr->bitmap_size);
-
-        if (shared_to_private) {
+        if (memory_attribute_is_range_discarded(mgr, offset, size)) {
+            /* Already private. */
+        } else if (!memory_attribute_is_range_populated(mgr, offset, size)) {
+            /* Unexpected mixture: not completely shared. */
+            for (cur_offset = 0; cur_offset < offset; cur_offset += block_size) {
+               memory_attribute_state_change(mgr, cur_offset, block_size,
+                                             true);
+            }
+        } else {
+            /* Completely shared. */
              bitmap_clear(mgr->shared_bitmap, first_bit, nbits);
+            memory_attribute_notify_discard(mgr, offset, size);
+        }
+    } else {
+        if (memory_attribute_is_range_populated(mgr, offset, size)) {
+            /* Already shared. */
+        } else if (!memory_attribute_is_range_discarded(mgr, offset, size)) {
+            /* Unexpected mixture: not completely private. */
+            for (cur_offset = 0; cur_offset < offset; cur_offset += block_size) {
+               ret = memory_attribute_state_change(mgr, cur_offset, block_size,
+                                                   false);
+               if (ret) {
+                   break;
+               }
+            }
          } else {
+            /* Completely private. */
              bitmap_set(mgr->shared_bitmap, first_bit, nbits);
+            ret = memory_attribute_notify_populate(mgr, offset, size);
+            if (ret) {
+                bitmap_clear(mgr->shared_bitmap, first_bit, nbits);
+            }
          }
-
-        return 0;
      }
-
      return ret;
  }
  
-- 
2.48.1


-- 
Cheers,

David / dhildenb


