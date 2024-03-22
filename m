Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9F1C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 09:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnbTc-0002Po-2C; Fri, 22 Mar 2024 05:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rnbTR-0002NB-0Y
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 05:46:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rnbTG-0001K4-QV
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 05:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711100751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rqv0Ih3p6mM1Wn/JDdbC+a4FAYEJ7eUWQ2B+dNDwiWU=;
 b=gg7QRCbsrrCeskytMQoUKd08nNOl7qgpJ2gc6xuH8cb55Fn9BEiD9N2uKpgNjCEc6glZ5i
 3q6Oa0q9kF7M1yU8+8qmLVuinKZ73kuxMhg/jAbNPLyhao9WoFHpRs3tmWW6CM5hDxA+nr
 uob/NvwLNq1a0QRopnAuTzwjA+5z5oY=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-qtvOMDB-NsWEoFT_oIklaA-1; Fri, 22 Mar 2024 05:45:49 -0400
X-MC-Unique: qtvOMDB-NsWEoFT_oIklaA-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-60a54004e9fso35498177b3.3
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 02:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711100749; x=1711705549;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rqv0Ih3p6mM1Wn/JDdbC+a4FAYEJ7eUWQ2B+dNDwiWU=;
 b=cUENNB15y1EQCGGJtgbrnxHfcmYFlA0BSewZ7cGaIsrEiSOPj24UMh5xOmImtTUMaC
 7mukew4aPIPDn2Lz6kCW2UoT4lGfj1pFUJNo5JQD27tY+40D6x5oH7XkqfTHZFZeQv6r
 hVbfYlz5defPwtIU27LvXIJmktgwDeClwEvCrmpXIJwRSJorMECvutCHIQhjO+8dIMMw
 wrch62p8OPbIQaMFCwBYE3EPmqYgXoPZle6291bZHBJRwcyBl0jPIdwB4YXnY1MMO9NH
 77xHkgXC7V3wrWcbvR7a3gD56uQMSiqDY2LdnB1qumtnf5bueYq4PxAkrQyvdsDIWDLp
 MMSA==
X-Gm-Message-State: AOJu0Yz1C+r26kZQVA7EGeR+UP+FpXSylwkJ1ql3LXHuxP9QflT8Ic0P
 4Cnh8dJEGooxkkBvNoBtqwrjRuj/FSUJXHfv6sx36a04p9heoWGSbhyO/WvHr/IrvWvtl/cm2lF
 1Lt6ax469XNqy/V8jhDD50XHVXmQ5xzPU8FYsrNzgm/v5efPC7oN5ILXtvykFnEiDtaTeLbPih/
 zfywcuri9QMJS3EnvB5fvuukJwPcA=
X-Received: by 2002:a25:8704:0:b0:dcc:4b44:3377 with SMTP id
 a4-20020a258704000000b00dcc4b443377mr1451963ybl.25.1711100749044; 
 Fri, 22 Mar 2024 02:45:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVVzkEt+R26j4vuk4WtWuOqtCU20DjLTZdkkjE8KzC8PqZnPKfSPNU6cjSA1ojoPIfQ6jHULLIrliyiMQJq1A=
X-Received: by 2002:a25:8704:0:b0:dcc:4b44:3377 with SMTP id
 a4-20020a258704000000b00dcc4b443377mr1451942ybl.25.1711100748789; Fri, 22 Mar
 2024 02:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240321155717.1392787-1-jonah.palmer@oracle.com>
 <20240321155717.1392787-2-jonah.palmer@oracle.com>
In-Reply-To: <20240321155717.1392787-2-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 22 Mar 2024 10:45:12 +0100
Message-ID: <CAJaqyWdg5tg1XR43bHkMRnqvkTZVvrqXMKM__YD6t-xGBOXdYg@mail.gmail.com>
Subject: Re: [RFC 1/8] virtio: Define InOrderVQElement
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, raphael@enfabrica.net, 
 kwolf@redhat.com, hreitz@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, 
 fam@euphon.net, stefanha@redhat.com, qemu-block@nongnu.org, 
 schalla@marvell.com, leiyang@redhat.com, virtio-fs@lists.linux.dev, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.372,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Mar 21, 2024 at 4:57=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
> Define the InOrderVQElement structure for the VIRTIO_F_IN_ORDER
> transport feature implementation.
>
> The InOrderVQElement structure is used to encapsulate out-of-order
> VirtQueueElement data that was processed by the host. This data
> includes:
>  - The processed VirtQueueElement (elem)
>  - Length of data (len)
>  - VirtQueueElement array index (idx)
>  - Number of processed VirtQueueElements (count)
>
> InOrderVQElements will be stored in a buffering mechanism until an
> order can be achieved.
>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  include/hw/virtio/virtio.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index b3c74a1bca..c8aa435a5e 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -77,6 +77,13 @@ typedef struct VirtQueueElement
>      struct iovec *out_sg;
>  } VirtQueueElement;
>
> +typedef struct InOrderVQElement {
> +    const VirtQueueElement *elem;

Some subsystems allocate space for extra elements after
VirtQueueElement, like VirtIOBlockReq. You can request virtqueue_pop
to allocate this extra space by its second argument. Would it work for
this?

> +    unsigned int len;
> +    unsigned int idx;
> +    unsigned int count;

Now I don't get why these fields cannot be obtained from elem->(len,
index, ndescs) ?

> +} InOrderVQElement;
> +
>  #define VIRTIO_QUEUE_MAX 1024
>
>  #define VIRTIO_NO_VECTOR 0xffff
> --
> 2.39.3
>


