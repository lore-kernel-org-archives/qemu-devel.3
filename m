Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E5960A383A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AIUFI9kt;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=C8D82H2N
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWwJq-0008Np-Dh; Fri, 27 Nov 2026 08:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1xWwJn-0008N5-RV
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 08:48:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1xWwJm-0007vk-HS
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 08:48:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795787329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nCc8MABMNyKp6Mjoi5V4GBvR6fhKrELn1MILJrh59gk=;
 b=AIUFI9kthqbzaWpldbWjxFg2FjcRQwQcnDvriTFwUm/SW196f7Hfdji3XKPAjy3FCr+/0t
 NNRz/kDdBp6eLuwS0VgMPne7fRPhzlxXpVqAl4Rf6uLpXPKKBYRhUiihdTW/OMdRMuD30B
 zYjfYacuTlU7eC9DqM8+4mugR6LXWmg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-9FHjchPVOXeR9weCHxZGfg-1; Fri, 27 Nov 2026 13:47:42 +0000
X-MC-Unique: 9FHjchPVOXeR9weCHxZGfg-1
X-Mimecast-MFC-AGG-ID: 9FHjchPVOXeR9weCHxZGfg_1795787261
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4bba856092dso19332585e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 05:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795787261; x=1796392061; darn=nongnu.org;
 h=content-type:mime-version:user-agent:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nCc8MABMNyKp6Mjoi5V4GBvR6fhKrELn1MILJrh59gk=;
 b=C8D82H2NIwPpdVhdRrBX2mpDkH1P5niBcwz0VvWAPU620DDgulDEdMlARnNTUqedNc
 RlFGa6XkdFdzzfJfKBDHUJvJ6rdWPSXeZ0vzBP237kji1L8XlhtEmKAkZlYvQpSvnJHB
 Kv14awHEvz/4vugNaEkcJG5teDgywcjsK6PqnL6BPEmiZ9Gm+MyUk4S7GbkJ//v5MN4w
 I6It50hgy64z+X530UQgq54ydON9uOrKEOmw5c5AT0MVblXgJKU2MDq19puN1KrAzeB3
 90+zTyhRLMnUu0vuWgWF2pTYwYMPJohAm2AfafRasPv01C4LVX5/rp7ZeBAtGRZiKsLC
 qqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795787261; x=1796392061;
 h=content-type:mime-version:user-agent:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nCc8MABMNyKp6Mjoi5V4GBvR6fhKrELn1MILJrh59gk=;
 b=FlKHuxJjsef45f0rLPtYqx6raWAD6BkC9LeNMn6dijyrhnsI1o5ZVxpuEZqWbYafnB
 DTT+gErvotU1uiafXP+00MLEeQN8NWSU9hiUW0sVgfYfyLlSc5i8Ygj8ExmvjBOlteNy
 ahhFIrGGQcNQxvMNU5ftZ+hGT6cecfADzPpmPwvu59dB/Wo1n5/eBuY3ouR6zS813DRg
 TZOaKfDpG26iwip/NF3e1W4+LZ+5e4NlkKo41ZAH3XJ4XDvGOVhgyoPDJZzeMd8/LokO
 L39s5ZMnydva36xPzM9RQ7aJ8qQ4Qk2c01WOBpWoZG/E7VQz8FaCKuXt9vJbx9n+rdBV
 jE9A==
X-Gm-Message-State: APuU4Z/fojjdEHbEWeHZtchRFuUFg5TYVMA079ao5Ec65MJjSawQOEjq
 5SLReKFFeZJsyoqhoto+fCBo1/chs8aKLxEdxdun9FKbcJq+tKQNWsom3zxGfbPZXVJ7QmIxOpQ
 IgdGzbBV4H9E4U10jS8NFa0KfzrO2XYY41ZgUO0sUcG5O7o3MW3ejl+y8
X-Gm-Gg: AZFdTZcUpvDiVYmyZO0FUStcp8r7B8OjslgFXuX51Jmhic4eDDaAIJ2W6CG1AHUHUQi
 yNzeQ33n7SGqzPkXQu1jlNRrJfD5Y4mRsCCTkTcrUxE1aT6h/dpJBxvnK0v5/yn3/UCCg+taFzh
 iVGL3vIWNAKt43L3E43DtRk4mI24OYS752KtCJDg3bzQ2XDoiyeat3ZqtqT03bHcDEAeY6qYu3o
 xtxiWE80Nx1vQMkh3ifHL5XwPyYaym8eVDFiHdbM2Mp+Il8Hgo6x5n/JNRPKwitWj05N6J5tNzb
 bGt5do9fWTmq2uX5668GoMm0vSlGfhr1SypTj8UBEMvBhZE7a3llesuO7U88aCVpSCd7QZfCnrJ
 hqle/Eh9MGNN7nvvspLmVGdRsKMtvr88kfWj74UdbQSheAecfpyfwt8pXVypdoAfEiw34sX0UrV
 PXelYLCpOxZqo/uLk8W9DiKpGI2ggpHZ0=
X-Received: by 2002:a05:600c:4f10:b0:4a1:88de:9e8b with SMTP id
 5b1f17b1804b1-4bb88807909mr549208415e9.5.1795787261186; 
 Fri, 27 Nov 2026 05:47:41 -0800 (PST)
X-Received: by 2002:a05:600c:4f10:b0:4a1:88de:9e8b with SMTP id
 5b1f17b1804b1-4bb88807909mr549207765e9.5.1795787260681; 
 Fri, 27 Nov 2026 05:47:40 -0800 (PST)
Received: from mzamazal-thinkpadp1gen7.tpbc.csb
 (ip-77-48-47-176.net.vodafone.cz. [77.48.47.176])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b7515sm949915425e9.13.2026.11.27.05.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 05:47:40 -0800 (PST)
From: Milan Zamazal <mzamazal@redhat.com>
To: zhaoguohan@kylinos.cn
Cc: qemu-devel@nongnu.org,  "Michael S . Tsirkin" <mst@redhat.com>,  Stefano
 Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] hw/virtio/vhost-user-scmi: propagate startup errors
In-Reply-To: <20261127055424.79483-1-zhaoguohan@kylinos.cn>
 (zhaoguohan@kylinos.cn's message of "Fri, 27 Nov 2026 13:54:24 +0800")
References: <20261127055424.79483-1-zhaoguohan@kylinos.cn>
Date: Fri, 27 Nov 2026 14:47:39 +0100
Message-ID: <85a4mu75dw.fsf@mzamazal-thinkpadp1gen7.tpbc.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mzamazal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

zhaoguohan@kylinos.cn writes:

> From: Khan Zhao <zhaoguohan@kylinos.cn>
>
> Return errors from vu_scmi_start() through vu_scmi_set_status() so
> device startup failures reach the caller.
>
> Remove the duplicate error message after vhost_dev_init(), which
> already reports initialization errors through errp.
>
> Signed-off-by: Khan Zhao <zhaoguohan@kylinos.cn>

Reviewed-by: Milan Zamazal <mzamazal@redhat.com>

> ---
>  hw/virtio/vhost-user-scmi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/hw/virtio/vhost-user-scmi.c b/hw/virtio/vhost-user-scmi.c
> index ad5c176c1e2..1dd29ff0008 100644
> --- a/hw/virtio/vhost-user-scmi.c
> +++ b/hw/virtio/vhost-user-scmi.c
> @@ -125,7 +125,7 @@ static int vu_scmi_set_status(VirtIODevice *vdev, uint8_t status)
>      }
>  
>      if (should_start) {
> -        vu_scmi_start(vdev);
> +        return vu_scmi_start(vdev);
>      } else {
>          int ret;
>          ret = vu_scmi_stop(vdev);
> @@ -260,8 +260,6 @@ static void vu_scmi_device_realize(DeviceState *dev, Error **errp)
>      ret = vhost_dev_init(&scmi->vhost_dev, &scmi->vhost_user,
>                           VHOST_BACKEND_TYPE_USER, 0, errp);
>      if (ret < 0) {
> -        error_setg_errno(errp, -ret,
> -                         "vhost-user-scmi: vhost_dev_init() failed");
>          do_vhost_user_cleanup(vdev, scmi, vhost_vqs);
>          return;
>      }


