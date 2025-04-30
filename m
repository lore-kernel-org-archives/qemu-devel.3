Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037D9C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 08:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA2Nn-0001uX-Vn; Wed, 30 Apr 2025 04:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uA2Nk-0001tq-D5
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 04:01:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uA2Ni-00005h-Lw
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 04:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746000084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=j9nr8TESjgfGun1eC6o/X3NJTioY9/DFLe1eC77nVsk=;
 b=EDXDJ9WgYDM8doBTVuj67M1GclXv030blkHn18YBH7uINDzJGA6yVBnfu+XLTPLnUa2CNI
 zu2LGzA9qMJ5Cgjtaey5v02fDhG+fuD9+rcT9F/yt42cfACu5wpkR8mC0pk2Va3cBb5kz2
 dNFBz6lpmigzp+KYW3UuqUE9zxgHjtc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-CeJA8_fVND6A9cCBv5J66A-1; Wed, 30 Apr 2025 04:01:22 -0400
X-MC-Unique: CeJA8_fVND6A9cCBv5J66A-1
X-Mimecast-MFC-AGG-ID: CeJA8_fVND6A9cCBv5J66A_1746000082
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cf446681cso40323045e9.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 01:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746000082; x=1746604882;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=j9nr8TESjgfGun1eC6o/X3NJTioY9/DFLe1eC77nVsk=;
 b=ddPpMLOVDyb0mqeDEzypVRDc8IH2eAF4xojXmGihJQoasVldOIRV5IrL6gnWaEedUc
 gtpUpFSKJ1pT2HRhuxJQhlaMEtS+BF0FYBn7K72yGEsuYdQOQGTA7CeCi35dl+dxPPXT
 cXl6ng74+KIFxYFbziAtP1ni9lDFVeDJa22QuEhtIcCCWeOTUxlGtLQ5IgaRoSFf/THs
 O5cnL38yT9Nbv7l+NP34ZF61zFsBC3bxiUe3oXZOBcD2cIOoJQsfPMqw6xhKHaxWn/EM
 KTYfOAaYNeK8rdcmlpJO8hEdPr/Z1LRwEY6cOlbDQVl9yEwxH0U3zoZ3GhdFzBl9RJJj
 FfIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXUSjN1kwhk/rAC9mXT8eXzgnq/u7nZsOLTDK26ehL1tMbZ7pkl1l2vHx0aJ3gtn15WB+Bod/FQY32@nongnu.org
X-Gm-Message-State: AOJu0Yz7dPkkvpm03SJ6a/Ri9TsDphnFsDL74aX2U6y701FDfFnSNfBB
 vPo8ZAhWmUU0IrywE4ujxlaVlre1POk6iyAcquNmcMNkNyhMtOpX3MI2v2d+I2lG0MdaayalwW8
 B+qH0k5BGcsIYJnerfYuVv7rv5n4X/gTGt6FR37aNwAtHGTls3D9j
X-Gm-Gg: ASbGncszdmFHQ2ZqRTxD6bgxRNvtp4VC9yZCWDix5v385634CxG+oGkE2viRQF5LxB4
 PGA5W43a+D/VH9SOMH4uvngqd2/FjitO2JBSNKT9qt/E6QMb7J/M2tLgJL+hnG9UYAbMlT0ip5b
 bxAAT2gM1QPjsdXt7Du107itOVpE7D3Bo/FpXr6Q9ZHQ+qjBN0RxVB7aNt1+IdYmO0SBLOXWRMw
 tbq/qsKKMYH8i0P0rJCl15ZPh1AgPFMNhXdalVVs8uAyUEUB8JU0VBvROXLAFLukMzpEFtDvXAU
 y0cEkec9VHJZkWPimKVxTByFbqjfOwBAS8gP4BbRhw==
X-Received: by 2002:a05:600c:4e8e:b0:43d:fa59:cc8f with SMTP id
 5b1f17b1804b1-441b1f61e4bmr12972105e9.33.1746000081683; 
 Wed, 30 Apr 2025 01:01:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvEJ1bCiJtcGWbXSqZtnkq35+DKSD4dqlX7ilzrQ9NkWVFzNuXSvT1P3dkLdDN337XPW3Z2A==
X-Received: by 2002:a05:600c:4e8e:b0:43d:fa59:cc8f with SMTP id
 5b1f17b1804b1-441b1f61e4bmr12971765e9.33.1746000081213; 
 Wed, 30 Apr 2025 01:01:21 -0700 (PDT)
Received: from [192.168.3.141] (p4ff231f0.dip0.t-ipconnect.de. [79.242.49.240])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2ad781csm15556045e9.8.2025.04.30.01.01.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 01:01:20 -0700 (PDT)
Message-ID: <210c69d9-803e-41a5-b40c-bc8372e582fa@redhat.com>
Date: Wed, 30 Apr 2025 10:01:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] system: optimizing info mtree printing for monitors
To: Chao Liu <lc00631@tecorigin.com>, pbonzini@redhat.com, peterx@redhat.com, 
 philmd@linaro.org
Cc: zhangtj@tecorigin.com, zqz00548@tecorigin.com, qemu-devel@nongnu.org
References: <cover.1745894489.git.lc00631@tecorigin.com>
 <8b29b86a9af84edba54cc53aec017224478312bf.1745894489.git.lc00631@tecorigin.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <8b29b86a9af84edba54cc53aec017224478312bf.1745894489.git.lc00631@tecorigin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 30.04.25 06:02, Chao Liu wrote:
> Make the hierarchical relationship between nodes clearer by adding characters
> 
You should probably move most of your cover letter, including the example, in here.

> Signed-off-by: Chao Liu <lc00631@tecorigin.com>
> ---
>   system/memory.c | 34 +++++++++++++++++++++++++++-------
>   1 file changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/system/memory.c b/system/memory.c
> index 71434e7ad0..e723928068 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -3296,6 +3296,22 @@ typedef QTAILQ_HEAD(, MemoryRegionList) MemoryRegionListHead;
>                              int128_sub((size), int128_one())) : 0)
>   #define MTREE_INDENT "  "
>   
> +#define PRINT_MTREE_COL(level) do { \
> +    if (level == 0) {               \
> +        qemu_printf("│  ");         \
> +    } else {                        \
> +        qemu_printf("│   ");        \
> +    }                               \
> +} while (0)
> +
> +#define PRINT_MTREE_NODE(is_tail) do { \
> +    if (is_tail) {                     \
> +        qemu_printf("└── ");           \
> +    } else {                           \
> +        qemu_printf("├── ");           \
> +    }                                  \
> +} while (0)
Just make these static inline functions.

> +
>   static void mtree_expand_owner(const char *label, Object *obj)
>   {
>       DeviceState *dev = (DeviceState *) object_dynamic_cast(obj, TYPE_DEVICE);
> @@ -3335,9 +3351,9 @@ static void mtree_print_mr_owner(const MemoryRegion *mr)
>   static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
>                              hwaddr base,
>                              MemoryRegionListHead *alias_print_queue,
> -                           bool owner, bool display_disabled)
> +                           bool owner, bool display_disabled, bool is_tail)


The growing number of input booleans is a bit suboptimal, and the hard-coded
"false" in the caller doesn't necessarily make the code easier to read.

We could consider switching to a single flags variable, or maybe convert the
"bool is_tail" into an enum like.

enum mtree_node_type {
     MTREE_NODE_T_INNER,
     MTREE_NODE_T_TAIL,
}

e.g.

mtree_print_mr(mr, 1, 0, asi->ml_head, asi->owner, asi->disabled,
                MTREE_NODE_T_INNER);


and

enum mtree_node_type mtree_node_type = MTREE_NODE_T_INNER;

...

if (ml == QTAILQ_LAST(&submr_print_queue)) {
     mtree_node_type = MTREE_NODE_T_TAIL;
}

-- 
Cheers,

David / dhildenb


