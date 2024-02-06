Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2E3C4829B
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 15:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXN3T-0001Ct-B3; Tue, 06 Feb 2024 10:08:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rXN3R-0001CX-Nf
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:08:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rXN3B-0003Ij-LX
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:08:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707232071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k6fupP0PnCv/HLRh5tbcMjkUvymwzNuGK1n19M7tC1U=;
 b=ZyXSFf5nArzhnzfF/4xDDE8FveqldbCwZCHYEElrPdPaVuZxcWsHg0l2NIZene8kr5M6PA
 gtA1XPRwOWaQ9c/eIV2FLhF/MjroIE4qLmtLtCNf+RhiqL2QPcAbBrHUKXr2qb8nOBSCDc
 QWxB7LHgHEmrc0ua56C3zPosXz3qQ4k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-7lbkRZ85OCiHsWEw6hfH3A-1; Tue, 06 Feb 2024 10:07:49 -0500
X-MC-Unique: 7lbkRZ85OCiHsWEw6hfH3A-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33b17a50104so2216004f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 07:07:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707232068; x=1707836868;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k6fupP0PnCv/HLRh5tbcMjkUvymwzNuGK1n19M7tC1U=;
 b=huvfJZS5aUJ8GJ7qBAwEAahCFn8Zhz7neQUERyQPR9RR2mhQ2YT4G3EygwIMX/nEfB
 Yzy08Sa9XrBhqBc7n7VcximmuItXG1LLnRAoT2nzUvRKMlvlHcaZSijhm/YXJiK9E2vc
 ogABho2xxpgivdIpDSayiCj91JoPhTrw33ow0squxwx9dmMYaceLNza0Pfk7Q1y4oxga
 TRYO2jlT/HMjhNwlEoO+ytKOqtRNCJ/L+tWHrJKOpydsUdsezBaqfHmuPFdRmHp72jV0
 KWoGjfOAEGYifX+qaTTyAoJlALss7xBdqCsBxHVbmfCUvm6Pj7FQFzkCNDUOHV9psFM9
 gTpg==
X-Gm-Message-State: AOJu0YyuaMhH2YGA4NPyForz5ZN88wXFY8uy4cpndbZdGtxzCdB3Pf28
 4XXjniXBuy5CJ+p4ACXRKoBjjV5yQu+T6HVbM3MzJlN9PaN1Psd0XwYXYLEbCN1IM0Wi6rXwjmd
 OscqXO2AivCohVIK8U2aMJK4PIe8nx2s5ufC2nAI6XpqtJYAlHKmM
X-Received: by 2002:a5d:5106:0:b0:33b:436f:29db with SMTP id
 s6-20020a5d5106000000b0033b436f29dbmr1316403wrt.43.1707232068053; 
 Tue, 06 Feb 2024 07:07:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAcEOXBiPur8+sZeAlU2VBbh31rKHsF8yCV2eJjb+LBWPwgyiy+WmqDXTVzr/X0s2POvQIIw==
X-Received: by 2002:a5d:5106:0:b0:33b:436f:29db with SMTP id
 s6-20020a5d5106000000b0033b436f29dbmr1316392wrt.43.1707232067697; 
 Tue, 06 Feb 2024 07:07:47 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUjM6EBOSj4D/6HilIc+xuKnCkisSkX26QNVWuJM+hg28A/7sYRL2h29X/S+QszVplUzr/TVYnuNqh8C6b/VnWnoWW8M5Bpvf/v8YaYtBulZIxPBocLhhn+Qgey1cghh9vhMOnjlEHq6w4deiXJn/QdBSzvwpR449/IdcM5+eKj11HDPvs+FzqK6xxg1RgX+YmwyRWd+A==
Received: from ?IPV6:2003:cf:d740:65ef:7c9f:a118:b826:ff5f?
 (p200300cfd74065ef7c9fa118b826ff5f.dip0.t-ipconnect.de.
 [2003:cf:d740:65ef:7c9f:a118:b826:ff5f])
 by smtp.gmail.com with ESMTPSA id
 cp10-20020a056000400a00b0033b4a2f13e6sm969398wrb.72.2024.02.06.07.07.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 07:07:46 -0800 (PST)
Message-ID: <4025b499-ba74-4e86-9203-b7650573efb8@redhat.com>
Date: Tue, 6 Feb 2024 16:07:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] virtio-blk: enforce iothread-vq-mapping validation
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
References: <20240205172659.476970-1-stefanha@redhat.com>
 <20240205172659.476970-2-stefanha@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20240205172659.476970-2-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
> Hanna Czenczek <hreitz@redhat.com> noticed that the safety of
> `vq_aio_context[vq->value] = ctx;` with user-defined vq->value inputs is
> not obvious.
>
> The code is structured in validate() + apply() steps so input validation
> is there, but it happens way earlier and there is nothing that
> guarantees apply() can only be called with validated inputs.
>
> This patch moves the validate() call inside the apply() function so
> validation is guaranteed. I also added the bounds checking assertion
> that Hanna suggested.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   hw/block/virtio-blk.c | 192 +++++++++++++++++++++++-------------------
>   1 file changed, 107 insertions(+), 85 deletions(-)
>
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 227d83569f..e8b37fd5f4 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c

[...]

> @@ -1660,6 +1681,14 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
>       BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
>       VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
>   
> +    if (conf->iothread && conf->iothread_vq_mapping_list) {
> +        if (conf->iothread) {

This inner condition should probably be dropped.  With that done:

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>

> +            error_setg(errp, "iothread and iothread-vq-mapping properties "
> +                             "cannot be set at the same time");
> +            return false;
> +        }
> +    }
> +
>       if (conf->iothread || conf->iothread_vq_mapping_list) {
>           if (!k->set_guest_notifiers || !k->ioeventfd_assign) {
>               error_setg(errp,


