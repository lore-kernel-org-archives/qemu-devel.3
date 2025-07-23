Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455B7C83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 13:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueZ5r-0004gV-Ol; Wed, 23 Jul 2025 09:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1ueZ00-0002GB-UR
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 08:55:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1ueYzv-0004KM-QP
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 08:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753275295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Btsz5QenQejzPlNOlJUpEkSjyEdeWx/+jO0MFxpQPEU=;
 b=DSB5M5KBNX3b6JYEckNiB0FYI/0vCy6aV0FmuZba9QBaUdx5ANSRW1teffgIc91cZB3RSy
 ZudSM0O9HYmwMW1KtgPTQywdO7wBk/6j8jemZlazZMDjnlpg3a9j8LUQrjgtWcB63Vjaaz
 NlKOULhvvDeJnWRGRh8EgP4OTEXLuqI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-elDF6YnROT6cubQtC4Z_dQ-1; Wed, 23 Jul 2025 08:54:54 -0400
X-MC-Unique: elDF6YnROT6cubQtC4Z_dQ-1
X-Mimecast-MFC-AGG-ID: elDF6YnROT6cubQtC4Z_dQ_1753275293
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3af3c860ed7so2755700f8f.1
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 05:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753275293; x=1753880093;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Btsz5QenQejzPlNOlJUpEkSjyEdeWx/+jO0MFxpQPEU=;
 b=IlGAsDyRH9J9OkwT+pdl5/M/eOHpFYan7mb3sncJCXC23yl/vrD4hsj53eUTRJNoIY
 Qr8rPE7ayMAug1ZTxHCAfQs4n4IIwJkjbBTjeVJrPVOR49ULipgR0OC2ca7GzFzyzkuL
 PtDeC+yhVHCzMjyRLDpI9Yf8CeQcKtQfBgBE5XgQjf+LreaDFMi9f+A2goE5UHvAR74o
 lgNUCXZS+UhJrRFcBgWkeOtBwrCR5Z69iUbBR98qTCkkFzOe4jW1dSRRnwfAWFRPT5g6
 g+9TgUziMhCe8DhoPKB86BWDAkgAptSVJRUHmIsjR6/DdW5CWlOyAffNU3BcAa7XCuIx
 m+Yg==
X-Gm-Message-State: AOJu0YzfPpAA2fNEcidJmoU4OPDFEyD+gLg2WChcx40zqF1uV2xF7uox
 4qT7c7TiqE/yIYlYIbDIsKtpXcSspR/oTFVYZlmUU32NVDEb4Qp9/IlvxA4ORS9pwYdWgJdQshl
 dX7/PzLzu2mK+dwFV1xPWpKyJcF73sPkfnzYJcnLdgUyJNyEUpLxXpNka
X-Gm-Gg: ASbGnctE/tPy/hv8B0GWQp2ERDaBzXVSNvtAlXEvQPJgnmVDGE9lvyKKdtT3xHhTKtS
 QQLk+gBoxm2syDJv+xeMMDSGyi5s8Yf0eEJb5eQvjaDiU78dEUL6uiZOqO250UmFb+RJ+zADfVh
 YJbxwaTJ0K/kNBrXGiwhG5ZRjcFad8BZqB91rZgL+1s5gBrvZFlLUNqtAQLUESx1v++PLS7u2AM
 IMZyqO2BZD1MzEbjEuYcsF3UBveYudNg5+DhnXtcwMd7Fk4vyUUYhAck8Fa9ZtqQQ5yczT7yLga
 xkIoyt9vUPyc0zumrTSe6e68zvXa89GwVnyDhnyV7xr8Fy1y8qraYFCSlrV6IfbZVAIsNg==
X-Received: by 2002:a05:6000:2911:b0:3b4:9721:2b16 with SMTP id
 ffacd0b85a97d-3b768ef3c9bmr2407861f8f.36.1753275293017; 
 Wed, 23 Jul 2025 05:54:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJKkW/BhnxqiCt1Agfpr0Nf5CE+kgehriLQ5WNRQquMrzmncsRFqJLI++SnHvrBhTvzhPrOw==
X-Received: by 2002:a05:6000:2911:b0:3b4:9721:2b16 with SMTP id
 ffacd0b85a97d-3b768ef3c9bmr2407834f8f.36.1753275292537; 
 Wed, 23 Jul 2025 05:54:52 -0700 (PDT)
Received: from [192.168.3.141] (p57a1af43.dip0.t-ipconnect.de. [87.161.175.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b76773a0e3sm3181411f8f.17.2025.07.23.05.54.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jul 2025 05:54:52 -0700 (PDT)
Message-ID: <e5c93bdf-4ee4-400f-ab45-c0869dc47b1e@redhat.com>
Date: Wed, 23 Jul 2025 14:54:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] memory.c: improve refcounting for RAM vs MMIO regions
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250723121920.1184928-1-aesteve@redhat.com>
 <98df482d-c75a-46e7-8c39-5aa26eaf1700@redhat.com>
 <CADSE00KkhKKQBSk_iLo4xCkPRcWQqUUumD_xsNDOk_YoSDoNeQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <CADSE00KkhKKQBSk_iLo4xCkPRcWQqUUumD_xsNDOk_YoSDoNeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.377,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 23.07.25 14:48, Albert Esteve wrote:
> On Wed, Jul 23, 2025 at 2:43 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 23.07.25 14:19, Albert Esteve wrote:
>>> In the last version of the SHMEM MAP/UNMAP [1] there was a
>>> comment [2] from Stefan about the lifecycle of the memory
>>> regions.
>>>
>>> After some discussion, David Hildenbrand proposed
>>> to detect RAM regions and handle refcounting differently
>>> to clear the initial concern. This RFC patch is
>>> meant for gathering feedback from others
>>> (i.e., Paolo Bonzini and Peter Xu).
>>>
>>> [1] https://patchwork.ozlabs.org/project/qemu-devel/list/?series=460121
>>> [2] https://patchwork.ozlabs.org/comment/3528600/
>>>
>>> ---
>>>
>>> This patch enhances memory_region_ref() and memory_region_unref()
>>> to handle RAM and MMIO memory regions differently, improving
>>> reference counting semantics.
>>>
>>> RAM regions now reference/unreference the memory region object
>>> itself, while MMIO continue to reference/unreference the owner
>>> device as before.
>>>
>>> An additional qtest has been added to stress the memory
>>> lifecycle. All tests pass as these changes keep backward
>>> compatibility (prior behaviour is kept for MMIO regions).
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com >
>>> Signed-off-by: Albert Esteve <aesteve@redhat.com>
>>> ---
>>>    system/memory.c            | 22 +++++++++++++----
>>>    tests/qtest/ivshmem-test.c | 50 ++++++++++++++++++++++++++++++++++++++
>>>    2 files changed, 67 insertions(+), 5 deletions(-)
>>
>> Did we discuss extending the doc as well, to clarify which scenario is
>> now supported?
> 
> Not that I remember? But it is a good idea. I will update the docs for
> the next version of this patch.

Maybe I never sent it to you while brainstorming. Here is what I had:

diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
index 57fb2aec76..5c4bc9ced5 100644
--- a/docs/devel/memory.rst
+++ b/docs/devel/memory.rst
@@ -143,11 +143,13 @@ Region lifecycle
  ----------------
  
  A region is created by one of the memory_region_init*() functions and
-attached to an object, which acts as its owner or parent.  QEMU ensures
-that the owner object remains alive as long as the region is visible to
-the guest, or as long as the region is in use by a virtual CPU or another
-device.  For example, the owner object will not die between an
-address_space_map operation and the corresponding address_space_unmap.
+attached to an object, which acts as its owner or parent.
+
+For non-RAM regions, QEMU ensures that the owner object remains alive as
+long as the region is visible to the guest, or as long as the region is in
+use by a virtual CPU or another device.  For example, the owner object will
+not die between an address_space_map operation and the corresponding
+address_space_unmap. For RAM regions, this is not guaranteed.
  
  After creation, a region can be added to an address space or a
  container with memory_region_add_subregion(), and removed using
@@ -174,7 +176,8 @@ callback.  The dynamically allocated data structure that contains the
  memory region then should obviously be freed in the instance_finalize
  callback as well.
  
-If you break this rule, the following situation can happen:
+If you break this rule, the following situation can happen for non-RAM
+regions:
  
  - the memory region's owner had a reference taken via memory_region_ref
    (for example by address_space_map)


-- 
Cheers,

David / dhildenb


