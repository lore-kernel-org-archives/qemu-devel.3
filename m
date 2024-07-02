Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0181EC3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 21:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOkhP-0002AN-Pc; Tue, 02 Jul 2024 17:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOkhO-00025c-LC
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 17:06:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOkhK-0007lb-UL
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 17:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719954358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=13t9nyOidNN3/uVoCD03S1xUrAuLxGj+RAM9Gv91l70=;
 b=MnqiZlbom+D6PjVQ+xk7aKHzRgkkVZOblFXemz+JTv+EJWadMUoTAeHv90rFcJg7F+KLOZ
 ifcf68k+z6Oxt8WwtukIn1V4RBkUisgkBNCtnWvhV5OAY5x5fwq5z0VetG8mjQs5zjZ1AM
 b1exkAKvyIY0OwlxTrGFcA8S2wKvZVA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-4ZI31M5gMR6R0m-RHYfpTA-1; Tue, 02 Jul 2024 17:05:56 -0400
X-MC-Unique: 4ZI31M5gMR6R0m-RHYfpTA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4256718144dso42483295e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 14:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719954355; x=1720559155;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=13t9nyOidNN3/uVoCD03S1xUrAuLxGj+RAM9Gv91l70=;
 b=PCpwUSBdK6s/uIfI910O4imd7kksX+tYw1n9AL5cfr+P/C3zpOmh9ERWoCUpCCfiMa
 R0dUzaUgkQkyQAL65tpswAklbmraQlOxZHvbs+K8doAMLWEkNhQNOia2zW3ENQYD/pJY
 RdL1TR1j04VZbUz0F/zohGohQW4YCrdFivb1jNKN9MHF0HXPBS4hot8UcaeBjKiTcyaM
 QaCKVaHlYuilihZMX7qsohqFeCzkzaTyQLddjel/8Sa8Jf5tYLedh6xM8H8+euxrieTV
 PE3BnPJVaTd2ap0wFNHPPxkuehHNNWp6s7H3OPj1J7u8ltjmLE6fx6rYhwS5Bzk9YEwu
 ozDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS1Old4FNx7DNYhUVvyqghzwsr8wRhKby+8RJclO/j2GCSEaDwbHDA7trQg0V/SX+WB7RWwfWJv9Rox9SkXhqx0Uc8Hvs=
X-Gm-Message-State: AOJu0YyQv3KY4pBjQtRhLv5UJhRW81cMvPt7jjpjc9tOp37t1VwDzlIi
 XTbE49Q4PRNRELzJsZP08iDqmTBVfxFYCiCsvZ+tBCXVf6hVO7POOrU1KVmoEpjAyCR4vYiozSX
 6L3BMf0SSBeiC0yPS337945HJv9EAnSNkc+TMpnPB2KE1SakXXYd4
X-Received: by 2002:a05:600c:1907:b0:425:80e1:a6b4 with SMTP id
 5b1f17b1804b1-42580e1a721mr64623065e9.19.1719954355669; 
 Tue, 02 Jul 2024 14:05:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjyqDEqgsIu1k+lDAWPLPnGS+aSWaKcM+1zF8Nt7/N6ZaE1Xb9eZMj2AEswzjPOYX0QmOYnw==
X-Received: by 2002:a05:600c:1907:b0:425:80e1:a6b4 with SMTP id
 5b1f17b1804b1-42580e1a721mr64622965e9.19.1719954355160; 
 Tue, 02 Jul 2024 14:05:55 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-425787f32ffsm84208525e9.1.2024.07.02.14.05.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 14:05:54 -0700 (PDT)
Date: Tue, 2 Jul 2024 17:05:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zheyu Ma <zheyuma97@gmail.com>
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH]  hw/virtio/virtio-crypto: Fix op_code assignment in
 virtio_crypto_create_asym_session
Message-ID: <20240702170539-mutt-send-email-mst@kernel.org>
References: <20240702210443.3060881-1-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702210443.3060881-1-zheyuma97@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 02, 2024 at 11:04:43PM +0200, Zheyu Ma wrote:
> The assignment of the op_code in the virtio_crypto_create_asym_session
> function was moved before its usage to ensure it is correctly set.
> Previously, if the function failed during the key_len check, the op_code
> did not have a proper value, causing virtio_crypto_free_create_session_req
> to not free the memory correctly, leading to a memory leak.
> 
> By setting the op_code before performing any checks, we ensure that
> virtio_crypto_free_create_session_req has the correct context to
> perform cleanup operations properly, thus preventing memory leaks.
> 
> ASAN log:
> ==3055068==ERROR: LeakSanitizer: detected memory leaks
> Direct leak of 512 byte(s) in 1 object(s) allocated from:
>     #0 0x5586a75e6ddd in malloc llvm/compiler-rt/lib/asan/asan_malloc_linux.cpp:129:3
>     #1 0x7fb6b63b6738 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5e738)
>     #2 0x5586a864bbde in virtio_crypto_handle_ctrl hw/virtio/virtio-crypto.c:407:19
>     #3 0x5586a94fc84c in virtio_queue_notify_vq hw/virtio/virtio.c:2277:9
>     #4 0x5586a94fc0a2 in virtio_queue_host_notifier_read hw/virtio/virtio.c:3641:9
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>


why did you send 2 copies?

> ---
>  hw/virtio/virtio-crypto.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
> index bbe8aa4b99..5034768bff 100644
> --- a/hw/virtio/virtio-crypto.c
> +++ b/hw/virtio/virtio-crypto.c
> @@ -205,6 +205,7 @@ virtio_crypto_create_asym_session(VirtIOCrypto *vcrypto,
>      int queue_index;
>      uint32_t algo, keytype, keylen;
>  
> +    sreq->info.op_code = opcode;
>      algo = ldl_le_p(&sess_req->para.algo);
>      keytype = ldl_le_p(&sess_req->para.keytype);
>      keylen = ldl_le_p(&sess_req->para.keylen);
> @@ -224,7 +225,6 @@ virtio_crypto_create_asym_session(VirtIOCrypto *vcrypto,
>          iov_discard_front(&iov, &out_num, keylen);
>      }
>  
> -    sreq->info.op_code = opcode;
>      asym_info = &sreq->info.u.asym_sess_info;
>      asym_info->algo = algo;
>      asym_info->keytype = keytype;
> -- 
> 2.34.1


