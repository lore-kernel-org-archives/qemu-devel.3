Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF48C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 18:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taIpI-0005kp-W8; Tue, 21 Jan 2025 13:18:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1taIpD-0005kZ-2J
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:18:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1taIpA-0008Ng-GE
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:18:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737483481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ocOHFAZAwjFZIYfocUP33NOuDTCEUHrzSFH0aOCaMiI=;
 b=d109pl3upCy+r7N4kYAcONkYR1NJnMnTRW0EP9XX3PD1kLMAQnEP1vJHUVmUCi2OKDNwUs
 5ty9npPNnIHKNcSWcCKYLVU28irndGubq0Gj4uplkJ8Vam6zSXjrL8wrPE5e8wxmY7OYH1
 5s8y8Q9e/8afE2dbU4d2c2F+/rx2euI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-VQ1hKqqqO0Ou-l1uiNnELw-1; Tue, 21 Jan 2025 13:17:58 -0500
X-MC-Unique: VQ1hKqqqO0Ou-l1uiNnELw-1
X-Mimecast-MFC-AGG-ID: VQ1hKqqqO0Ou-l1uiNnELw
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b6ebe1ab63so1651654585a.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 10:17:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737483478; x=1738088278;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ocOHFAZAwjFZIYfocUP33NOuDTCEUHrzSFH0aOCaMiI=;
 b=aAqRDjQ9pQmQNt2Qry3o3cVIxtlAVxJ0hPrmshtgIy9KCzET4N5yw3Nkr47DETTkN9
 CYt7ctuy5Rgs4aCbg1u41tDUATZgYcyNLSMcN2gfWsC2/tGZhb1dUzkucllwZcoYIReL
 NDORMAsgx+38A2xHx26Bs6ubGxKHEj3gP9DGpf7dEJJ1X0EKBpBOjmYXqGtd4um1oTUF
 gmTimsNySgqCpD07LanrnE5Z4G34GzIHLEzZq9tAL5pG6OyCOh1XPu90AFlNanACS560
 uyMvvLZd+skz5VvHYe6oV9cwF0cOl97eb0DVOkriSdHzLb7Ib2PWlRV0IqJvwPWbUoXr
 dPbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYMR78BZTgme6nrVP+Vpv1S3l8TiaiYOC8kDmPFLxEEO0xn3CcGnm+K0TXfizclFrwp/G0NtJ6QQQK@nongnu.org
X-Gm-Message-State: AOJu0Yyj1RIIR9iNqm3Yp8P0OVu5Yh1jn/j/h+BS/zYHDZxgriWibG6q
 ndE7YLOA9Mk+J3dFUlNq8bdhva91qGVBhVNPX6DLHqVtd3phzeDJT/QLqfO8Fx7ipwoA1jKfZ8t
 ts4J7Jpqbmmp/oiUrm20JO6vei2so1VUUG+r9APR65RTT+QD1L3yY
X-Gm-Gg: ASbGncuoRbOQ9tEBL5TkD04Lk4NrmnXn8TbIGdFpQ87kMNHHCKNzABq/zm7uZ+kBGMg
 tXdIPnMQ+vVKTizON4ujKVFo92yuUqYZP/v9pMg6jnp/uil3pktOKa0AbQFWadhVC5Ke/pOuBrX
 ZlloEOEm0NkElohg+aeFYEk8yXJeG7KNvU8rBZkgay8nOxuqMHmknkMkyKpoUMtTtWep1wF8dvi
 Yy4o5n8aEKrFPh87OtQuedHmNwqLcas2feVPl/kiBbO+OFTmvPMm0EUt8vaCAbjKScrKxIuA9T9
 750xXlXJoBxvXr2abdU8SgQh4YBkc1A=
X-Received: by 2002:a05:620a:2894:b0:7b6:e47a:8e14 with SMTP id
 af79cd13be357-7be6324fb5cmr2791329185a.35.1737483478246; 
 Tue, 21 Jan 2025 10:17:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXbRxKwoRt8zrHI/Un52UwCBfvEkQ7X1i8KsXNExg4qI/3ZlXLKQPT5YwidU3Qtoqrf59LgQ==
X-Received: by 2002:a05:620a:2894:b0:7b6:e47a:8e14 with SMTP id
 af79cd13be357-7be6324fb5cmr2791325885a.35.1737483477913; 
 Tue, 21 Jan 2025 10:17:57 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be6147fb69sm578545585a.33.2025.01.21.10.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 10:17:57 -0800 (PST)
Date: Tue, 21 Jan 2025 13:17:54 -0500
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?=E2=80=9CWilliam?= Roche <william.roche@oracle.com>
Cc: david@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 philmd@linaro.org
Subject: Re: [PATCH 1/1] system/physmem: take into account fd_offset for file
 fallocate
Message-ID: <Z4_k0u7Gdv5OKa3S@x1n>
References: <20250121175956.3030149-1-william.roche@oracle.com>
 <20250121175956.3030149-2-william.roche@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250121175956.3030149-2-william.roche@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jan 21, 2025 at 05:59:56PM +0000, “William Roche wrote:
> From: William Roche <william.roche@oracle.com>
> 
> Punching a hole in a file with fallocate needs to take into account the
> fd_offset value for a correct file location.
> 
> Fixes: 4b870dc4d0c0 ("hostmem-file: add offset option")
> 
> Signed-off-by: William Roche <william.roche@oracle.com>
> ---
>  system/physmem.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index c76503aea8..687ca94875 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3689,18 +3689,20 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
>              }
>  
>              ret = fallocate(rb->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> -                            start, length);
> +                            start + rb->fd_offset, length);
>              if (ret) {
>                  ret = -errno;
>                  error_report("%s: Failed to fallocate %s:%" PRIx64 " +%zx (%d)",
> -                             __func__, rb->idstr, start, length, ret);
> +                             __func__, rb->idstr, start + rb->fd_offset, length,
> +                             ret);
>                  goto err;
>              }
>  #else
>              ret = -ENOSYS;
>              error_report("%s: fallocate not available/file"
>                           "%s:%" PRIx64 " +%zx (%d)",
> -                         __func__, rb->idstr, start, length, ret);
> +                         __func__, rb->idstr, start + rb->fd_offset, length,
> +                         ret);
>              goto err;
>  #endif
>          }

We do have plenty of fd_offset bugs then.. this makes sense to me. Nitpick
is we could use a var to cache the total offset.

> @@ -3748,17 +3750,17 @@ int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t start,
>  
>  #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
>      ret = fallocate(rb->guest_memfd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> -                    start, length);
> +                    start + rb->offset, length);
>  
>      if (ret) {
>          ret = -errno;
>          error_report("%s: Failed to fallocate %s:%" PRIx64 " +%zx (%d)",
> -                     __func__, rb->idstr, start, length, ret);
> +                     __func__, rb->idstr, start + rb->fd_offset, length, ret);
>      }
>  #else
>      ret = -ENOSYS;
>      error_report("%s: fallocate not available %s:%" PRIx64 " +%zx (%d)",
> -                 __func__, rb->idstr, start, length, ret);
> +                 __func__, rb->idstr, start + rb->fd_offset, length, ret);
>  #endif

IIUC the offset doesn't apply to gmemfd, see:

        new_block->guest_memfd = kvm_create_guest_memfd(new_block->max_length,
                                                        0, errp);

So my understanding is no matter how the host offset was specified, it
ignores it at least in the qemu gmemfd code to always offset from 0, which
makes sense to me, as gmemfd is anonymous anyway, and can be created more
than one for each VM, so I don't yet see why a gmemfd needs an offset indeed.

Thanks,

-- 
Peter Xu


