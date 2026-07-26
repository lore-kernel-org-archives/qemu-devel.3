Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B88C53200
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 14:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnzph-0005xO-9Y; Sun, 26 Jul 2026 10:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnzpf-0005x8-TL
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 10:27:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnzpe-0003CM-67
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 10:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785076077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5GNNicGx7F8rwzekaPRknWFX6uDT0/mtTL5sZsGF1P4=;
 b=hR0xiTVX6Q/+wqIZu7fxs6K5GhwuOZIjLm67vx++TrySDVkCrNWBcaWZdu0kF9CQKRvr2H
 MeWg6FVLpNFYnzQS56oaJ3jrhlX2c7ugUNIc7DF8QmnrX5Oqp/+7YXNWqW3ZqmikuTPO46
 XE7lz+12G3qhDNQ/30w1ZYtBOoe0mzw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-2wDjmBwuMP-keDw0fFTzvg-1; Sun, 26 Jul 2026 10:27:55 -0400
X-MC-Unique: 2wDjmBwuMP-keDw0fFTzvg-1
X-Mimecast-MFC-AGG-ID: 2wDjmBwuMP-keDw0fFTzvg_1785076074
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490a767c7dcso16488355e9.2
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 07:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785076074; x=1785680874; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5GNNicGx7F8rwzekaPRknWFX6uDT0/mtTL5sZsGF1P4=;
 b=MODYd9fSbPp8oZyM1wPmRZDp9BX2JVvYhAYI6KDZgwItcaxe40ITw/deax0hWGZie9
 XQA0xxXjGYQodEBzuyHB4LHmpMhnQIBv+g4iELlxJB2+e484XA7i70kfaFGcuj3VbOXd
 YlPIBE1T43br1W/Qd8H+ThBGHi7kpKkIEjMKrM1FJOd7qZmEmOyeenlLhWwJJCq2Z2AO
 hTzrL998qQu9EkgJxzhcXo1NuGizD2hKnWWIlFkAbTpWNUoYgDqWSwJdrDlWBQIQV7dl
 LENkRM15IBPjwDKjbqas3RkIoixhboiqxMSjmRc8mdHQ1CS5z48CTFzZMntZZXvryKWx
 w0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785076074; x=1785680874;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5GNNicGx7F8rwzekaPRknWFX6uDT0/mtTL5sZsGF1P4=;
 b=GyInH1s7eH/L9N+9JC1vIurAn0Xbu37KIR8JjvZ8+RKiQDYJKOSb9sFaPVcvouPgxr
 sbK/MhLBJkZSN/MSF2LmPLxVYcVnDEiemo90r7GiWlR1Fc2UemhIVFfE6TcR6hMm8D5t
 TVZQPGBz+nwVu1IuN1xAcUH2qkvAxL+b++Rlc4nwwj0B5bhTVp7uO6yNwzSZ1oEJShVF
 vAq+vzusaBNuNshISYK7TN8rGuBWLbvrZLRFwzbeqjswz+wWNysnkPYcF/T0Gp8v4op0
 B9zioEHEOFBAk55jmfafaqDn0IPxDM3U5QBJ3uyK2ykH4VvZwSvSDrUna6oy5XO9gMKO
 USgg==
X-Gm-Message-State: AOJu0YzGgEZa4czSgfcWr/EJGRyYDtKUmWN5D4fVf02RrXefmPMQX9SX
 bUQVNLRyqoPRy53cQfFA6PI00XVLbh/nIUQLcJSATvaSSHfnbfUePzpKHLhqD1aCvs3jwAiqF3i
 DbAMSRW9elp0BGj01ai7d1iIONs0LDjT37uBvIFU+AzrxItCkX480SVy1h+s+V18e
X-Gm-Gg: AR+sD13niRYkzNs2U7zTTVUx2X6h3zxXy9DDuofzs02+joP+jq6Kj7rZUwq64/pKcp8
 +EFQ1mc+9C/qA1+PEPS4vZotaHupze1wBzrNVdNAB2Gxar3zgWrCP/bOWV798GUWWeGz7DZP1zA
 eD0gBJpT/gshh8etOcweooT8C/tiQbMAQjSo6k0yjA7+lvaUCpEc/mWg/ICOQ8sougr7su59E2H
 SEtaxssksl5MSDqa1gwdLNcq8/WyY5o6dSdf/KU5nA33Z4Rgiha6izE8d+xzkhnmL4ddBFNYo1+
 Vqs1QFkCwZI/23zAM0piYwnJB99CkJcRHT5IiHU3lpvBNru2htCxJlWEcsET+XP2C9JDsZr/N4K
 GCwKVb09hd6gSJGX0R3GYLQ==
X-Received: by 2002:a05:600c:19c8:b0:495:7888:281c with SMTP id
 5b1f17b1804b1-496b5689b16mr74021175e9.0.1785076073721; 
 Sun, 26 Jul 2026 07:27:53 -0700 (PDT)
X-Received: by 2002:a05:600c:19c8:b0:495:7888:281c with SMTP id
 5b1f17b1804b1-496b5689b16mr74020785e9.0.1785076073058; 
 Sun, 26 Jul 2026 07:27:53 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957f9928fdsm176111175e9.1.2026.07.26.07.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 07:27:52 -0700 (PDT)
Date: Sun, 26 Jul 2026 10:27:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] virtio: fail early on bad config_len in migration
Message-ID: <20260726102716-mutt-send-email-mst@kernel.org>
References: <cfbefa358af5885eb386637216552bfeba5e7bbc.1784898922.git.mst@redhat.com>
 <amUiUdfC2kpx1qLq@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amUiUdfC2kpx1qLq@gallifrey>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Jul 25, 2026 at 08:53:37PM +0000, Dr. David Alan Gilbert wrote:
> * Michael S. Tsirkin (mst@redhat.com) wrote:
> > virtio_load() attempts to load config_len bytes from the migration
> > stream. If that's huge (e.g. 4g) this will uselessly spin
> > beyond the end of the stream for seconds. Not nice.
> > Check qemu_file_get_error() and bail out early, instead.
> > 
> > Also note that config_len is int32_t but is coerced to unsigned when
> > used. Switch it to uint32_t to make this clearer.
> 
> That in a way feels like the more important fix (I hate to
> think what that MIN(int32_t, size_t) does.

Nothing, int32_t is coersed to uint32_t.


> > Fixes: 2f5732e964 ("Allow mismatched virtio config-len")
> > Cc: Dr. David Alan Gilbert <dave@treblig.org>
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3891
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> 
> > ---
> >  hw/virtio/virtio.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 8add4d5d99..72d828d33f 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -3516,7 +3516,7 @@ int coroutine_mixed_fn
> >  virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
> >  {
> >      int i, ret;
> > -    int32_t config_len;
> > +    uint32_t config_len;
> >      uint32_t num;
> >      uint32_t features;
> >      BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
> > @@ -3564,6 +3564,9 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
> >      qemu_get_buffer(f, vdev->config, MIN(config_len, vdev->config_len));
> >  
> >      while (config_len > vdev->config_len) {
> > +        if (qemu_file_get_error(f)) {
> > +            return -1;
> > +        }
> >          qemu_get_byte(f);
> >          config_len--;
> >      }
> > -- 
> > MST
> > 
> -- 
>  -----Open up your eyes, open up your mind, open up your code -------   
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/


