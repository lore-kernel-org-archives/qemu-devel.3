Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259F6C83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 12:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueYq6-000337-Q1; Wed, 23 Jul 2025 08:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1ueYpP-00028l-64
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 08:44:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1ueYp8-0007re-DE
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 08:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753274623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EBZuQo9IDS8b/fCPdhX2V5bDf33heTWEX/2lXXoiCPk=;
 b=cRZbnN6NSpIIeOmOvMVA4tzkPLZ5PL92oDPO3la39me7im+nlX2DQCJXj3uze2Ll9LADNg
 EpQ4Zy5fAS6iaeA008aAnyBh4xqL68V7eHom2NLiZ7ISFq0WY9rM1ZZtvJG/NsU5MEWoK0
 ijLFub3Dr0AJj2sppJfeuGKcCTh02R4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-lLW03Rh2MoG8RitRZ6-Bkg-1; Wed, 23 Jul 2025 08:43:39 -0400
X-MC-Unique: lLW03Rh2MoG8RitRZ6-Bkg-1
X-Mimecast-MFC-AGG-ID: lLW03Rh2MoG8RitRZ6-Bkg_1753274618
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45626532e27so44327145e9.1
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 05:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753274618; x=1753879418;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=EBZuQo9IDS8b/fCPdhX2V5bDf33heTWEX/2lXXoiCPk=;
 b=qAT8sn10H+Dra8yqISIS3CM2Cespf4NIynLn5mYF++PzVh4mlQkCUbx0dfG8DW04IB
 kQD8aOK6NYyxtp/iSA1CqTod8XyQjoYLsb7u2CNEPvfbOMOKgFXORV3dWX89Y6zIMvUu
 5e7H7HirkVh7bbHhTxI1oVJnEPE/YCjuxdagIs8KRGTxvQtQ3f7CgX01X74G7rTik42T
 k44AvAxYTVujGFllcHPpDx+UonxDpPjT3ERJlZe1C9Pk9yj4iJi0LlJBEcdWmC49TXkK
 9HuqBu3xIy9f98wajlf1YqF+eoPtQF4mpRnJbXU/+w0uzmczrPb9s3hGPbprTaGf3QZs
 6Lbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrxMLFnOQ99ZYRwENnnDrmH18k1PwQfgxZtlGiabFXxwBIhW8f5SmGiyBRFOyhGKwGDHkC89Bc6PFp@nongnu.org
X-Gm-Message-State: AOJu0YyT7kONdy3PReNBAKXGbTUCYJyj+4ry7PO2Ph2k5NDBWy6SuVKd
 j4dHS8ZqBtHfJVol81Oq4c9eEXSXUtbP1TJYvA3/eSIxEkym6avkb2sw72uNW+M1V82onTwtdAQ
 2pnXtGSKkifbQYa731m+mMFykxvqhpf9LUMY0IgWq1cFi7onLquQ+VPWG
X-Gm-Gg: ASbGncsC/xT2+1s/ZpSfTxQ0bdaegYO9En4LafDaTDS2E4qWck19RiTatWO0wcaepUk
 QCMhqSE6DDJSc/DdBNX6Hr6OG1kORWq+TSaqYo7qxG4wsq0LlsL/zH4LCuXPqZKaYAhuzPC+dUs
 fLbxpROg20ONMj4KP112zPUXtDdyUJoVkT9MBY6BZbJVsjMvAI1mkCKro+xYR9qhNqhQCUkCh60
 72EUaWtR+1zKnWGgZj24mvFnJq1Gh+uP+CXzeNiFmFm7D7+KQfqmFw2Zf10iP6x2xH2VyYzlFNv
 0zFSKns2HARNoeXvZHyfEGSfSf80+zC+Wg/bUrpakBdG2NAczWu5Y1uqOsq1KnkgG97GvxkpZur
 mVVpLvzv+uk8xzhp86mcXwOk1O0zn1jDqlWbfe2Pq1OJl/+Lk5c0gl/SQz0lmG5rgDdM=
X-Received: by 2002:a05:600c:358f:b0:456:2347:3f01 with SMTP id
 5b1f17b1804b1-45868d4efb1mr23779055e9.20.1753274618373; 
 Wed, 23 Jul 2025 05:43:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1EqADQsTBeJOTll9/VfA/AnO0haPvhqi9PWvkU84QzHIaEFT1sHLuxzE2TesXqyQfF/EmHQ==
X-Received: by 2002:a05:600c:358f:b0:456:2347:3f01 with SMTP id
 5b1f17b1804b1-45868d4efb1mr23778715e9.20.1753274617822; 
 Wed, 23 Jul 2025 05:43:37 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f00:4000:a438:1541:1da1:723a?
 (p200300d82f004000a43815411da1723a.dip0.t-ipconnect.de.
 [2003:d8:2f00:4000:a438:1541:1da1:723a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4586918306dsm22804355e9.7.2025.07.23.05.43.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jul 2025 05:43:37 -0700 (PDT)
Message-ID: <98df482d-c75a-46e7-8c39-5aa26eaf1700@redhat.com>
Date: Wed, 23 Jul 2025 14:43:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] memory.c: improve refcounting for RAM vs MMIO regions
To: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 peterx@redhat.com, Laurent Vivier <lvivier@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250723121920.1184928-1-aesteve@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250723121920.1184928-1-aesteve@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
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

On 23.07.25 14:19, Albert Esteve wrote:
> In the last version of the SHMEM MAP/UNMAP [1] there was a
> comment [2] from Stefan about the lifecycle of the memory
> regions.
> 
> After some discussion, David Hildenbrand proposed
> to detect RAM regions and handle refcounting differently
> to clear the initial concern. This RFC patch is
> meant for gathering feedback from others
> (i.e., Paolo Bonzini and Peter Xu).
> 
> [1] https://patchwork.ozlabs.org/project/qemu-devel/list/?series=460121
> [2] https://patchwork.ozlabs.org/comment/3528600/
> 
> ---
> 
> This patch enhances memory_region_ref() and memory_region_unref()
> to handle RAM and MMIO memory regions differently, improving
> reference counting semantics.
> 
> RAM regions now reference/unreference the memory region object
> itself, while MMIO continue to reference/unreference the owner
> device as before.
> 
> An additional qtest has been added to stress the memory
> lifecycle. All tests pass as these changes keep backward
> compatibility (prior behaviour is kept for MMIO regions).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com >
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>   system/memory.c            | 22 +++++++++++++----
>   tests/qtest/ivshmem-test.c | 50 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 67 insertions(+), 5 deletions(-)

Did we discuss extending the doc as well, to clarify which scenario is 
now supported?

-- 
Cheers,

David / dhildenb


