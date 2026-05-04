Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0086DFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 12:42:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJscf-00011b-Ta; Mon, 04 May 2026 08:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wJsce-000117-5r
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:42:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wJscc-0001zb-F6
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777898521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=K9QBWp5H+ydDasr/z4vN8DMthPHp9zsLZhsnXeEOO6s=;
 b=Fa8bTl8pglbt+W+2k5Uw9y65XfnZCjAnsAC5EJGv7PqiR3KcyXAB8ZM6g8AS39QsW/PkQi
 2ZFZMocpWC7JHVXdLQKTEifgkr/lx3BbduxdsAK08yAeJ6YSQzjI+Taw+Kga+dJUm/WVdE
 dsCrt2ff5RfjAyPMhEOMu8qZ7+jiRBc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-LrCuM6WfMbChSvBUlmH0Eg-1; Mon, 04 May 2026 08:41:59 -0400
X-MC-Unique: LrCuM6WfMbChSvBUlmH0Eg-1
X-Mimecast-MFC-AGG-ID: LrCuM6WfMbChSvBUlmH0Eg_1777898518
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4411a36715dso2859850f8f.2
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 05:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777898518; x=1778503318; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=K9QBWp5H+ydDasr/z4vN8DMthPHp9zsLZhsnXeEOO6s=;
 b=fAXLBG/PsGFVDfQRMHYL4gegZT+SZhRiUr0YNc+lm0brdUbqLUW7f6Y5C0gMDPU8Rv
 AeDf6HLa8sE9fYGKwSZdFU9r8LgMJKK7q4QyIhZ2rAuAeJrrMY7NJkIKMWyKSkmpiY8H
 AdYY2ImGnBwvSymmFpIgqh+AwzQ8o/PAYsJrxXTcK/kTi7PwX5sZJx5qL/NlMuscu96/
 cowpw27AeckhWhEN9VzHpfZe2LLb7lC2uPo9rJRpV3WJOAXT+xAA0BK61Wyz8Jyu38bo
 ob88kiqi3Fx1/eYE1Wyg4pLmqIXOqHtQ6MfdG3JCYadV4mlVtDfOjJRbuFRKt0fFNWkS
 956Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777898518; x=1778503318;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K9QBWp5H+ydDasr/z4vN8DMthPHp9zsLZhsnXeEOO6s=;
 b=lwvDUbJVTwT53H+vOI6tolqoprza2+xLzF2jL3oznvxKveTW1JstAgjLS95vEhz+Sx
 5oSVDQHsmIqYB/vOpe8rpCZxcxZvU7DJWihtoSc6x4YXedn/KbikHuzaU2vsmJuXwLJr
 mw4iNTosKXMwphtxh+kp9OF5lCjD0nRAec6ptLiiGS4r7M4vJIjz0lJxYctIr9dlijPS
 HSDuQcBFtTxb1/GwKsmwpGafgmjNqUvmadu1N8FAYtHEScMkuUAi5w0kPI3YSbrsxPkH
 fysIfMVY1DqbDSjrFXtRNpJ9m6ZjO3nnVnAP1yLalKvWiNjAIagfexjqD94xjfs7s+ng
 dtuQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/07Na74u/gE20GFWw9zID3wFOJt/gNpK0D8DgJu7h0DHyvZWbkh87K/pvSUgtLuT/dF2lArpTYmOH/@nongnu.org
X-Gm-Message-State: AOJu0YyeHGgS8aLg30QIYj7Nm5cHp/QIY5ly6ESJRk4T2qOHDZ2yVd7W
 TK+NxG1w+2DjsAHMwSV9lbKGVyfobpAG+4pNRnuaAzJngIbpDGPmL5aAagaRp0jPLMHgiLt1t/M
 /3jK8ceJPQuLDg+H4COvJoMh+oSwFdo2MIpiQwC13c47w3bp9e42cxAZJ
X-Gm-Gg: AeBDieve3T/kqu4dlITiAoLW5MKnbo4z8OTrqbT4+sNLYMCPxjHpxS3FUOj3uWx5BRL
 u7mE2S1JlW1VRhCOLVw7rAP7KI5fxpeVpyXdiaK96UweZil/wPuEN7StUDVC0gHTY9OOv2yM1cl
 nqGhA1NkVAPmHHjJ8P2K5EP+8AHSEQ8MWHMHmuNpCbYtLX4pTIGbj6fruCRkB9BA0grKI+EEb2J
 FuLyNOVdJtACh8eq8xHQsuQ0aqmYKt41xSZS/QJUdyDebwJUQYW6cN4GbXP+o07CwbVjzQIE2zv
 sQtFfEFeMBKswu7Ia8DNR2J7EMKF4JNcFefGntGNO9DYXuxDk+cp2qQlrfysQyf75IdjJ1yFi0t
 49eq62tntLS8/JUfGwGVnrSvqW5wNAJY+eib5e4LNtAxBKimd/H5mVJZ2ig9BhyqGhp7zZSA=
X-Received: by 2002:a05:600c:3e07:b0:489:201c:dc46 with SMTP id
 5b1f17b1804b1-48a98640536mr153644625e9.12.1777898518392; 
 Mon, 04 May 2026 05:41:58 -0700 (PDT)
X-Received: by 2002:a05:600c:3e07:b0:489:201c:dc46 with SMTP id
 5b1f17b1804b1-48a98640536mr153644295e9.12.1777898517999; 
 Mon, 04 May 2026 05:41:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8fe3cae3sm111879025e9.0.2026.05.04.05.41.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 05:41:57 -0700 (PDT)
Message-ID: <619bc62d-49c4-4c86-bb12-7412cad1ff65@redhat.com>
Date: Mon, 4 May 2026 14:41:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 34/46] hw/fsi: move OPBus qbus_init() to instance_init
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
 <20260504-qom-tests-v2-34-ef7e3dc94f7a@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260504-qom-tests-v2-34-ef7e3dc94f7a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/4/26 13:35, Marc-André Lureau wrote:
> Remove the TODO comment that documented the workaround, as it is
> no longer needed.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/fsi/aspeed_apb2opb.c | 13 +------------
>   1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/hw/fsi/aspeed_apb2opb.c b/hw/fsi/aspeed_apb2opb.c
> index 36092468391..058abc86452 100644
> --- a/hw/fsi/aspeed_apb2opb.c
> +++ b/hw/fsi/aspeed_apb2opb.c
> @@ -273,6 +273,7 @@ static void fsi_aspeed_apb2opb_init(Object *o)
>       for (i = 0; i < ASPEED_FSI_NUM; i++) {
>           object_initialize_child(o, "fsi-master[*]", &s->fsi[i],
>                                   TYPE_FSI_MASTER);
> +        qbus_init(&s->opb[i], sizeof(s->opb[i]), TYPE_OP_BUS, DEVICE(s), NULL);

nice !

>       }
>   }
>   
> @@ -282,18 +283,6 @@ static void fsi_aspeed_apb2opb_realize(DeviceState *dev, Error **errp)
>       AspeedAPB2OPBState *s = ASPEED_APB2OPB(dev);
>       int i;
>   
> -    /*
> -     * TODO: The OPBus model initializes the OPB address space in
> -     * the .instance_init handler and this is problematic for test
> -     * device-introspect-test. To avoid a memory corruption and a QEMU
> -     * crash, qbus_init() should be called from realize(). Something to
> -     * improve. Possibly, OPBus could also be removed.
> -     */
> -    for (i = 0; i < ASPEED_FSI_NUM; i++) {
> -        qbus_init(&s->opb[i], sizeof(s->opb[i]), TYPE_OP_BUS, DEVICE(s),
> -                  NULL);
> -    }
> -
>       sysbus_init_irq(sbd, &s->irq);
>   
>       memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_apb2opb_ops, s,
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


