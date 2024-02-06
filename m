Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2106C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 15:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXN4r-0002WJ-Hs; Tue, 06 Feb 2024 10:09:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rXN4q-0002Vy-AL
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:09:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rXN4o-0003kg-O1
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:09:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707232173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ws5QndHjooqOXW2Ls4VZeNIJ4DSYyFfbPsxBobs7VB0=;
 b=YBLKZ/KgF8l8yUQV2wkEjZcsQc8SUVlUPYD8JOUW8GXLWHfhooM+XqRIqItUC6XrDmVVkd
 e+qB8LdODxNGVtgZDX0P4iw5iYzN/C5aMjUtaWPbP9aNbHQuuNFaHwD6GCU/2nMcgHo/wo
 108dHS4tYP3prt8fyh+fvOObwfNQYZM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-lldN7QwNODqKVfegtjWyiQ-1; Tue, 06 Feb 2024 10:09:32 -0500
X-MC-Unique: lldN7QwNODqKVfegtjWyiQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33b2238ceceso495391f8f.3
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 07:09:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707232171; x=1707836971;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ws5QndHjooqOXW2Ls4VZeNIJ4DSYyFfbPsxBobs7VB0=;
 b=F9SgDJWlXFIIQQUQKXt6FiuCz+iHYKCFt1EJYN4SsQDalPD7EK7hcFleYScuYpRh0+
 0EyHQyaRK2t3bLy6ZRaX+uYTuRiLyy204tPOslbwAGGd+ZfAxH0DaXB8q3V9yjApvh3o
 9QphXDGXRVK1TLF5chzdMzoiv+OpdQ+Pvyd9y4UlxG6UKDUG8Jz+dwHQnmPoR/IiIgxY
 AE9kL3eHNIy9DOqWVLUK16wngC1Vo3eH9M6RJ0OUvnc12pIO+CammV/6V3w946jht+pU
 +2rU0kylAulYEd8u0ZMc/EKoesSay5vXNmu+Ptj0idwcVOdEWNQ7C9R8wCk2vQcOvpzu
 Yjbg==
X-Gm-Message-State: AOJu0YxkTOW2FEgx7INYI3NyiqTNhp3hC/MrEZFHp2oQW8YnHJh2Ww08
 k/8wlLDsQ+b0dACQZvG8KWIkz3yvg1MlnlkUMVSv8cdMnz/V6NFotO/fc6QvuZmrQoX5/V+M8uV
 34mZ4Ou3qlRyCjw5ILFJua4tKkqbDMcTcvR23DYR4KFbs9zwV3cKw
X-Received: by 2002:adf:f0c3:0:b0:33b:2300:9cdc with SMTP id
 x3-20020adff0c3000000b0033b23009cdcmr1505342wro.46.1707232170556; 
 Tue, 06 Feb 2024 07:09:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcbLY4Bb87xlYRTy3fuNCTGF3+7E9QiwvOkmzWskLq2TT92EDWyK56vaPAf4Gmsblvlt+epA==
X-Received: by 2002:adf:f0c3:0:b0:33b:2300:9cdc with SMTP id
 x3-20020adff0c3000000b0033b23009cdcmr1505331wro.46.1707232170262; 
 Tue, 06 Feb 2024 07:09:30 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVdfRTLJojtc5mlji+zOqgSw3koBq+o3N0rVjoEC1BlaCRonxXJLZVDTxL6CmPKsiZ+XG5G0mGuKaS4nRM2sgn/WMGJo/9a/LeMLvbsl0OPIojAYIE8ZRK9R7A8VKmM4nkbGBHvWajuW4m6cfx8w6vffDzJuiQOUYOR5DIwTVtZDYyQ5aLtkhO4LNhr9k8FyKyLj/vm8A==
Received: from ?IPV6:2003:cf:d740:65ef:7c9f:a118:b826:ff5f?
 (p200300cfd74065ef7c9fa118b826ff5f.dip0.t-ipconnect.de.
 [2003:cf:d740:65ef:7c9f:a118:b826:ff5f])
 by smtp.gmail.com with ESMTPSA id
 cp10-20020a056000400a00b0033b4a2f13e6sm969398wrb.72.2024.02.06.07.09.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 07:09:29 -0800 (PST)
Message-ID: <8d2043e5-698c-464b-a63c-5f1cb187ff6e@redhat.com>
Date: Tue, 6 Feb 2024 16:09:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] virtio-blk: add vq_rq[] bounds check in
 virtio_blk_dma_restart_cb()
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
References: <20240205172659.476970-1-stefanha@redhat.com>
 <20240205172659.476970-4-stefanha@redhat.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20240205172659.476970-4-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 05.02.24 18:26, Stefan Hajnoczi wrote:
> Hanna Czenczek <hreitz@redhat.com> noted that the array index in
> virtio_blk_dma_restart_cb() is not bounds-checked:
>
>    g_autofree VirtIOBlockReq **vq_rq = g_new0(VirtIOBlockReq *, num_queues);
>    ...
>    while (rq) {
>        VirtIOBlockReq *next = rq->next;
>        uint16_t idx = virtio_get_queue_index(rq->vq);
>
>        rq->next = vq_rq[idx];
>                   ^^^^^^^^^^
>
> The code is correct because both rq->vq and vq_rq[] depend on
> num_queues, but this is indirect and not 100% obvious. Add an assertion.
>
> Suggested-by: Hanna Czenczek <hreitz@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   hw/block/virtio-blk.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


