Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C03C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 10:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rncQK-00060X-1a; Fri, 22 Mar 2024 06:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rncQF-0005yO-53
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 06:46:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rncQD-0003zM-Db
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 06:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711104408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NXBVMEl+yr8B/V45S2vmEezcNU1jZzl9rRvfSfEDrKk=;
 b=NjoynEZ8pbna4i6gxrRi9VQyeyTUSK0eRev1Jq8d9fl4t9a7jMxvGYXyCL7QP4uuncZxkf
 DJ8PVErpWQ/lQJwCVqNKZp/9kEQTQo/OAHAyO+tAcSCvers7xJ1M72H3PGn1nYs/82wYJE
 VDqqvDVsSduGD8paoAhjn4dTsSK1Pk0=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-_Ft-5v11OsmRQXXrFDCo1g-1; Fri, 22 Mar 2024 06:46:44 -0400
X-MC-Unique: _Ft-5v11OsmRQXXrFDCo1g-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-dcc05887ee9so2901714276.1
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 03:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711104404; x=1711709204;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NXBVMEl+yr8B/V45S2vmEezcNU1jZzl9rRvfSfEDrKk=;
 b=iOjYTh4EEg+uoU1azoyCIryAdbAQD2WEdicUd8/H0GzsOpJypTCZabSeY35A+h3Fn9
 sKAGx1rkyRf8TZxCGWUxqsu0ESsixQi80ppYkOYjErrG4iwNwm7z1S5K7YhjgJ9f7dSR
 i/cIZORHmpLi2IfrGVC/tc909OzE88SCSI0l5izY8mQCxJIvW/oXuoggUl40SGCGHp8V
 5SAc9AhvrwGkhjQai8tC8iSHlohbCO2OtMkezYBO/clZE5D2lG2L1weCUAJ53QDrpfBs
 E/UBPhoqs2qtckusN8YLRGdgoivwURex0Q6ZMkxzrQU+Oe3MYkDoir9NEzm3ZB0TlVr6
 v5zg==
X-Gm-Message-State: AOJu0Yyrb1IbKHiuf/5heO3r/mMZ73wfPYC+VbL9F7JzpaS1c7lGmceQ
 2fHnTz34Djg2Aeh7lL8Ca2phbmfTaUOEUu6PPVRxpX67gJr+D3+NibAe9p3bIA0fiYPs3ya62HK
 aarn4U0e63B9iEZ2MkKvJN7LIU6eYDQ3l3E7eHoDsXtGSLslhQJJfHNHc4T7Wf9oeZ4ieXMymsg
 Pm7DdtuY5crvO90Q5feVaZ923bX4k=
X-Received: by 2002:a25:9341:0:b0:db5:50ea:d304 with SMTP id
 g1-20020a259341000000b00db550ead304mr1614827ybo.34.1711104403727; 
 Fri, 22 Mar 2024 03:46:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTcw9m52uQHhVzSdcw4E1rvQ2l5P2tTIXeS24Vy1cJzcZntUDX+L244XEM/y8DDeR6TGTaFFu3qj44oGkOU1A=
X-Received: by 2002:a25:9341:0:b0:db5:50ea:d304 with SMTP id
 g1-20020a259341000000b00db550ead304mr1614811ybo.34.1711104403412; Fri, 22 Mar
 2024 03:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240321155717.1392787-1-jonah.palmer@oracle.com>
 <20240321155717.1392787-5-jonah.palmer@oracle.com>
In-Reply-To: <20240321155717.1392787-5-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 22 Mar 2024 11:46:07 +0100
Message-ID: <CAJaqyWedsT+0DT-SCAH7SMFnuWHazTsbe1kNC+PENDSxvu3W0A@mail.gmail.com>
Subject: Re: [RFC 4/8] virtio: Implement in-order handling for virtio devices
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
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Implements in-order handling for most virtio devices using the
> VIRTIO_F_IN_ORDER transport feature, specifically those who call
> virtqueue_push to push their used elements onto the used ring.
>
> The logic behind this implementation is as follows:
>
> 1.) virtqueue_pop always enqueues VirtQueueElements in-order.
>
> virtqueue_pop always retrieves one or more buffer descriptors in-order
> from the available ring and converts them into a VirtQueueElement. This
> means that the order in which VirtQueueElements are enqueued are
> in-order by default.
>
> By virtue, as VirtQueueElements are created, we can assign a sequential
> key value to them. This preserves the order of buffers that have been
> made available to the device by the driver.
>
> As VirtQueueElements are assigned a key value, the current sequence
> number is incremented.
>
> 2.) Requests can be completed out-of-order.
>
> While most devices complete requests in the same order that they were
> enqueued by default, some devices don't (e.g. virtio-blk). The goal of
> this out-of-order handling is to reduce the impact of devices that
> process elements in-order by default while also guaranteeing compliance
> with the VIRTIO_F_IN_ORDER feature.
>
> Below is the logic behind handling completed requests (which may or may
> not be in-order).
>
> 3.) Does the incoming used VirtQueueElement preserve the correct order?
>
> In other words, is the sequence number (key) assigned to the
> VirtQueueElement the expected number that would preserve the original
> order?
>
> 3a.)
> If it does... immediately push the used element onto the used ring.
> Then increment the next expected sequence number and check to see if
> any previous out-of-order VirtQueueElements stored on the hash table
> has a key that matches this next expected sequence number.
>
> For each VirtQueueElement found on the hash table with a matching key:
> push the element on the used ring, remove the key-value pair from the
> hash table, and then increment the next expected sequence number. Repeat
> this process until we're unable to find an element with a matching key.
>
> Note that if the device uses batching (e.g. virtio-net), then we skip
> the virtqueue_flush call and let the device call it themselves.
>
> 3b.)
> If it does not... stash the VirtQueueElement, along with relevant data,
> as a InOrderVQElement on the hash table. The key used is the order_key
> that was assigned when the VirtQueueElement was created.
>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  hw/virtio/virtio.c         | 70 ++++++++++++++++++++++++++++++++++++--
>  include/hw/virtio/virtio.h |  8 +++++
>  2 files changed, 76 insertions(+), 2 deletions(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 40124545d6..40e4377f1e 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -992,12 +992,56 @@ void virtqueue_flush(VirtQueue *vq, unsigned int co=
unt)
>      }
>  }
>
> +void virtqueue_order_element(VirtQueue *vq, const VirtQueueElement *elem=
,
> +                             unsigned int len, unsigned int idx,
> +                             unsigned int count)
> +{
> +    InOrderVQElement *in_order_elem;
> +
> +    if (elem->order_key =3D=3D vq->current_order_idx) {
> +        /* Element is in-order, push to used ring */
> +        virtqueue_fill(vq, elem, len, idx);
> +
> +        /* Batching? Don't flush */
> +        if (count) {
> +            virtqueue_flush(vq, count);

The "count" parameter is the number of heads used, but here you're
only using one head (elem). Same with the other virtqueue_flush in the
function.

Also, this function sometimes replaces virtqueue_fill and other
replaces virtqueue_fill + virtqueue_flush (both examples in patch
6/8). I have the impression the series would be simpler if
virtqueue_order_element is a static function just handling the
virtio_vdev_has_feature(vq->vdev, VIRTIO_F_IN_ORDER) path of
virtqueue_fill, so the caller does not need to know if the in_order
feature is on or off.

> +        }
> +
> +        /* Increment next expected order, search for more in-order eleme=
nts */
> +        while ((in_order_elem =3D g_hash_table_lookup(vq->in_order_ht,
> +                        GUINT_TO_POINTER(++vq->current_order_idx))) !=3D=
 NULL) {
> +            /* Found in-order element, push to used ring */
> +            virtqueue_fill(vq, in_order_elem->elem, in_order_elem->len,
> +                           in_order_elem->idx);
> +
> +            /* Batching? Don't flush */
> +            if (count) {
> +                virtqueue_flush(vq, in_order_elem->count);
> +            }
> +
> +            /* Remove key-value pair from hash table */
> +            g_hash_table_remove(vq->in_order_ht,
> +                                GUINT_TO_POINTER(vq->current_order_idx))=
;
> +        }
> +    } else {
> +        /* Element is out-of-order, stash in hash table */
> +        in_order_elem =3D virtqueue_alloc_in_order_element(elem, len, id=
x,
> +                                                         count);
> +        g_hash_table_insert(vq->in_order_ht, GUINT_TO_POINTER(elem->orde=
r_key),
> +                            in_order_elem);
> +    }
> +}
> +
>  void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
>                      unsigned int len)
>  {
>      RCU_READ_LOCK_GUARD();
> -    virtqueue_fill(vq, elem, len, 0);
> -    virtqueue_flush(vq, 1);
> +    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_IN_ORDER)) {
> +        virtqueue_order_element(vq, elem, len, 0, 1);
> +    } else {
> +        virtqueue_fill(vq, elem, len, 0);
> +        virtqueue_flush(vq, 1);
> +    }
>  }
>
>  /* Called within rcu_read_lock().  */
> @@ -1478,6 +1522,18 @@ void virtqueue_map(VirtIODevice *vdev, VirtQueueEl=
ement *elem)
>                                                                          =
false);
>  }
>
> +void *virtqueue_alloc_in_order_element(const VirtQueueElement *elem,
> +                                       unsigned int len, unsigned int id=
x,
> +                                       unsigned int count)
> +{
> +    InOrderVQElement *in_order_elem =3D g_malloc(sizeof(InOrderVQElement=
));
> +    in_order_elem->elem =3D elem;
> +    in_order_elem->len =3D len;
> +    in_order_elem->idx =3D idx;
> +    in_order_elem->count =3D count;
> +    return in_order_elem;
> +}
> +
>  static void *virtqueue_alloc_element(size_t sz, unsigned out_num, unsign=
ed in_num)
>  {
>      VirtQueueElement *elem;
> @@ -1626,6 +1682,11 @@ static void *virtqueue_split_pop(VirtQueue *vq, si=
ze_t sz)
>          elem->in_sg[i] =3D iov[out_num + i];
>      }
>
> +    /* Assign key for in-order processing */
> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_IN_ORDER)) {
> +        elem->order_key =3D vq->current_order_key++;

Since you're adding this in both split_pop and packed_pop, why not add
it in virtqueue_pop?

> +    }
> +
>      vq->inuse++;
>
>      trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
> @@ -1762,6 +1823,11 @@ static void *virtqueue_packed_pop(VirtQueue *vq, s=
ize_t sz)
>          vq->last_avail_wrap_counter ^=3D 1;
>      }
>
> +    /* Assign key for in-order processing */
> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_IN_ORDER)) {
> +        elem->order_key =3D vq->current_order_key++;
> +    }
> +
>      vq->shadow_avail_idx =3D vq->last_avail_idx;
>      vq->shadow_avail_wrap_counter =3D vq->last_avail_wrap_counter;
>
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index f83d7e1fee..eeeda397a9 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -275,6 +275,14 @@ void virtio_del_queue(VirtIODevice *vdev, int n);
>
>  void virtio_delete_queue(VirtQueue *vq);
>
> +void *virtqueue_alloc_in_order_element(const VirtQueueElement *elem,
> +                                       unsigned int len, unsigned int id=
x,
> +                                       unsigned int count);
> +
> +void virtqueue_order_element(VirtQueue *vq, const VirtQueueElement *elem=
,
> +                             unsigned int len, unsigned int idx,
> +                             unsigned int count);
> +
>  void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
>                      unsigned int len);
>  void virtqueue_flush(VirtQueue *vq, unsigned int count);
> --
> 2.39.3
>


