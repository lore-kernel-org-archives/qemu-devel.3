Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E55C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 08:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taVgG-0006fd-R1; Wed, 22 Jan 2025 03:01:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1taVgE-0006eh-PU
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 03:01:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1taVgC-0004t3-8V
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 03:01:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737532898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=U5SjpLJak5xg8W1AObFEHkF1f7RoZnmhJF8xeU6ymRk=;
 b=RKjks8Iufhwm+hiqg7h7bVutcfq7dfzLKny+iuMDmhU36nHzn0BeqIfwTw3O0pypqmmSCE
 1U+2gyOnCnU4+LukOFEP1t1vE1LrYiYtB5D++fOET4tb+2QAOtHKyIJ5ZnWyLsyICCNj0I
 O9gtm9P2SMSIgGzKDUGUyvgmaebymc4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-Yjk39fQ9OWC85nvXhc2S8w-1; Wed, 22 Jan 2025 03:01:36 -0500
X-MC-Unique: Yjk39fQ9OWC85nvXhc2S8w-1
X-Mimecast-MFC-AGG-ID: Yjk39fQ9OWC85nvXhc2S8w
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4359206e1e4so51496665e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 00:01:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737532895; x=1738137695;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U5SjpLJak5xg8W1AObFEHkF1f7RoZnmhJF8xeU6ymRk=;
 b=MHWrNOd39VObtFDoExuzqTXHJ5N85L1zz7oA2qqfSeMUmg0In4W9thklmvpH2nBV1f
 CXtYkxrloGVUeA0WLeyR46+gtkeSB6cUxiEuHZ0/3099ReyROzqTDB+SCZ+it0jwQtdc
 OsQYFKcw2XrFouQIV0WHPM3IDfvkbF8qcH9qcLtzg7Rd3hRN3+auRFnyNbJqZVE8YM7w
 GJ32gpDHtHAbP1CHXaA4XHmmHQcXN6THDnA6+hMVyky85K6exg6X2kNfJF1yUsvClxlt
 ptw1NTAI20UsnfEC/MjHc57CP1mS6UBhFWBupOSkOFILA+hQ8wWlQes/hsAE06FmpUZI
 SNHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfLv+UEA+jP1VcpUEYzqIPZK9L2edY2K9+nFpWRJvsNu0GhxoBjG2M/JKS/jiHh784wOcBXlm2iaWV@nongnu.org
X-Gm-Message-State: AOJu0YzWOtVGgxzGWJtwNQgo1q8gqqUSZ7zwq1I+X1DnF1zZPwkx5ZHe
 YXTQqF6V2Tcv1QwHxTRAp74FQ+Ct6NscpR3FVM7exFVLkgr4p9CoMzvQO9WhrqrAP2AoiejLEsF
 r2BFupmAAtrAqr65KjwHCX2aox/NF4nSsnQh4yQfwzHaYsD5khhSH
X-Gm-Gg: ASbGncsGjjxQE7RD2TOV3D7K6YgBo6bLEofEUZ/llc/XPT8KhP2hxDaX0ThtDPdFu8E
 lupFSrtfzpq3y3ZyqH5IOXoB0TQtSOOg5Fft4oyqSN68prKLErpycwB44MB76wrhjl36LorSxnx
 eQHRVTdcGIAo25E99Hwuio7fYBpsX0CfSCv7vEf+QCgsB/OHTfePu6p1QB+BTfP1A0WQ2zrJkmC
 2rquh5syZJ/Mz4caQYV5M/0YIq1IwXLNUdQmBZP7dfG2u/WoRCNwZ/n4stjn3auOB0uGA2Qt36n
 U3AU68FbDvIB+GRGa471PRNUD5mDzk7wzk7Ll9GqS3dOMTeKUUkmSbUefKThG0+80kNfWDSiA8p
 Pdatg8nr1nenqyu2iZ/UcKw==
X-Received: by 2002:a05:600c:35c3:b0:434:f131:1e71 with SMTP id
 5b1f17b1804b1-438913cf2e0mr191278645e9.8.1737532895591; 
 Wed, 22 Jan 2025 00:01:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENZzXk3+dPtPC6KzbPY4yI8gUddKVCCen8hS8JautCgDLYbENwoRTIztMrqxNHvqMBQNrItg==
X-Received: by 2002:a05:600c:35c3:b0:434:f131:1e71 with SMTP id
 5b1f17b1804b1-438913cf2e0mr191278175e9.8.1737532895114; 
 Wed, 22 Jan 2025 00:01:35 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:db00:724d:8b0c:110e:3713?
 (p200300cbc70bdb00724d8b0c110e3713.dip0.t-ipconnect.de.
 [2003:cb:c70b:db00:724d:8b0c:110e:3713])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b31c1662sm14154015e9.31.2025.01.22.00.01.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2025 00:01:33 -0800 (PST)
Message-ID: <4f40dace-0f06-4e15-9cf1-d191621d080f@redhat.com>
Date: Wed, 22 Jan 2025 09:01:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] system/physmem: take into account fd_offset for
 file fallocate
To: =?UTF-8?Q?=E2=80=9CWilliam_Roche?= <william.roche@oracle.com>,
 peterx@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 philmd@linaro.org
References: <20250121225426.3043160-1-william.roche@oracle.com>
 <20250121225426.3043160-2-william.roche@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250121225426.3043160-2-william.roche@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.086,
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

On 21.01.25 23:54, “William Roche wrote:
> From: William Roche <william.roche@oracle.com>
> 
> Punching a hole in a file with fallocate needs to take into account the
> fd_offset value for a correct file location.
> But guest_memfd internal use doesn't currently consider fd_offset.
> 
> Fixes: 4b870dc4d0c0 ("hostmem-file: add offset option")
> 
> Signed-off-by: William Roche <william.roche@oracle.com>
> ---
>   system/physmem.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index c76503aea8..7e4da79311 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3655,6 +3655,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
>           need_madvise = (rb->page_size == qemu_real_host_page_size());
>           need_fallocate = rb->fd != -1;
>           if (need_fallocate) {
> +            uint64_t file_offset = start + rb->fd_offset;

Taking another closer look ...

Could likely be "off_t".

>               /* For a file, this causes the area of the file to be zero'd
>                * if read, and for hugetlbfs also causes it to be unmapped
>                * so a userfault will trigger.
> @@ -3689,18 +3690,18 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
>               }
>   
>               ret = fallocate(rb->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> -                            start, length);
> +                            file_offset, length);
>               if (ret) {
>                   ret = -errno;
>                   error_report("%s: Failed to fallocate %s:%" PRIx64 " +%zx (%d)",
> -                             __func__, rb->idstr, start, length, ret);
> +                             __func__, rb->idstr, file_offset, length, ret);
>                   goto err;
>               }
>   #else
>               ret = -ENOSYS;
>               error_report("%s: fallocate not available/file"
>                            "%s:%" PRIx64 " +%zx (%d)",
> -                         __func__, rb->idstr, start, length, ret);
> +                         __func__, rb->idstr, file_offset, length, ret);
>               goto err;
>   #endif

Thinking again, both error_report() should likely not have the offset 
replaced?

We are printing essentially the parameters to ram_block_discard_range() 
-- range in the ramblock -- just like in the "Failed to discard range" 
range.

So maybe just leave it like is or print the file offset additionally? 
(which might only make sense in the "Failed to fallocate" case).


Thanks!


-- 
Cheers,

David / dhildenb


