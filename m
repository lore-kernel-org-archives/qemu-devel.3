Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13ABAC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 20:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW03q-0001YU-3t; Mon, 22 Jul 2024 16:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sW03o-0001Y1-RV
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 16:55:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sW03l-00033c-D4
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 16:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721681700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=40ZQOUc4Dy5IGVOmpipBD4z/LqJvoDY/nAE5uh6Qvv8=;
 b=OM+UBxy+bnfLdfezVGS/+TIfXJDhjwpASCdF3p830Hq2G6HApMrOiRO3YRyI8Ew03+FrDq
 K10V0dReytzVum2LawB64lXBLbLGvsxZbljzRlxJkejXzQUrGfRYyW/mjdcu88fCS8JJv6
 Cx+vaAILU23jOoQSqeZYq/1Urb3lTJQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-M4Fl2gM4ORKI5Ft-4Jij1g-1; Mon, 22 Jul 2024 16:54:59 -0400
X-MC-Unique: M4Fl2gM4ORKI5Ft-4Jij1g-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-447e6ac9852so2146381cf.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 13:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721681699; x=1722286499;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=40ZQOUc4Dy5IGVOmpipBD4z/LqJvoDY/nAE5uh6Qvv8=;
 b=cZkAI5v1uXt66zqC1vjK2w6DdoQNPRqJQBHw6zQPkIWa/f3E69Lui/IgYyhtrj3/fA
 mcupQxIU1vqYXit8O6g7gtsCdLFnkZerV4/DebN/c33PqpdYMECQbHaeOtc8d83teQvM
 o5NdeiYnyyD401yc60YfwQ7Y7Cgxmpx4m5jXJGs+q24nw59BD4IzxucWDIOX4ySUkpO0
 lIamw/tpegwQhCPeFpRAD6eYXWZ86D/l0g+p+jM6slMdAzdWUrfI3NO4WKwjnWIXOvcn
 eM6Ljn2MzmwLbR0jfuUkdx3DOes0Xe+EMWL547EmzWhruw+L2A1ykpWWguNCakcQD4zh
 a0/A==
X-Gm-Message-State: AOJu0YxatcYcnDMgbMnpqlDBHtqiIIKN/ll8tvVZU/XqH+ulIUeCnbev
 iSalXpG0tr/cXIKPziCGaPh7Aj+Sz5HGNJEyyosOOlZzDGFCfmFBYTAn2lcrhxxPgNJ7+5ltxLZ
 iZmhUXgacbmekvE8nXwrQTMLakCXTZCEnALIaGyS6qpvyVJ1K+9HP
X-Received: by 2002:ac8:5808:0:b0:447:e013:755c with SMTP id
 d75a77b69052e-44fa525dfc1mr72602501cf.4.1721681698626; 
 Mon, 22 Jul 2024 13:54:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKGDQWi0qDnur/c4lCkfMAYCSNPPjNl/elkrJdnJbHBNNRyJdcF0DjvJXxEZA0jT30UARC4Q==
X-Received: by 2002:ac8:5808:0:b0:447:e013:755c with SMTP id
 d75a77b69052e-44fa525dfc1mr72602441cf.4.1721681698224; 
 Mon, 22 Jul 2024 13:54:58 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44f9cd02cf7sm36885301cf.22.2024.07.22.13.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 13:54:57 -0700 (PDT)
Date: Mon, 22 Jul 2024 16:54:55 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH v2 0/9] migration/multifd: Remove
 multifd_send_state->pages
Message-ID: <Zp7HH6-WeYKXQ-fy@x1n>
References: <20240722175914.24022-1-farosas@suse.de> <Zp65zvb9oy9my-qY@x1n>
 <87msm9yy77.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87msm9yy77.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

On Mon, Jul 22, 2024 at 05:21:48PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Jul 22, 2024 at 02:59:05PM -0300, Fabiano Rosas wrote:
> >> Hi,
> >> 
> >> In this v2 I took Peter's suggestion of keeping the channels' pointers
> >> and moving only the extra slot. The major changes are in patches 5 and
> >> 9. Patch 3 introduces the structure:
> >> 
> >> typedef enum {
> >>     MULTIFD_PAYLOAD_NONE,
> >>     MULTIFD_PAYLOAD_RAM,
> >> } MultiFDPayloadType;
> >> 
> >> struct MultiFDSendData {
> >>     MultiFDPayloadType type;
> >>     union {
> >>         MultiFDPages_t ram;
> >>     } u;
> >> };
> >> 
> >> I added a NONE type so we can use it to tell when the channel has
> >> finished sending a packet, since we'll need to switch types between
> >> clients anyway. This avoids having to introduce a 'size', or 'free'
> >> variable.
> >
> > This at least looks better to me, thanks.
> >
> >> 
> >> WHAT'S MISSING:
> >> 
> >> - The support for calling multifd_send() concurrently. Maciej has this
> >>   in his series so I didn't touch it.
> >> 
> >> - A way of adding methods for the new payload type. Currently, the
> >>   compression methods are somewhat coupled with ram migration, so I'm
> >>   not sure how to proceed.
> >
> > What is this one?  Why compression methods need new payload?  Aren't they
> > ram-typed?
> 
> The data we transport is MultiFDPages_t, yes, but the MultiFDMethods are
> either nocomp, or the compression-specific methods
> (e.g. zlib_send_prepare).
> 
> How do we add methods for the upcoming new payload types? I don't expect
> us to continue using nocomp and then do "if (ram)... else if
> (device_state) ..." inside of them. I would expect us to rename
> s/nocomp/ram/ and add a new set of MultiFDMethods for the new data type
> (e.g. vfio_send_prepare, vmstate_send_prepare, etc).
> 
> multifd_nocomp_ops -> multifd_ram_ops // rename
> multifd_zlib_ops   // existing
> multifd_device_ops // new
> 
> The challenge here is that the current framework is nocomp
> vs. compression. It needs to become ram + compression vs. other types.

IMHO we can keep multifd_ops[] only for RAM.  There's only send_prepare()
that device state will need, and so far it's only (referring Maciej's
code):

static int nocomp_send_prepare_device_state(MultiFDSendParams *p,
                                            Error **errp)
{
    multifd_send_prepare_header_device_state(p);

    assert(!(p->flags & MULTIFD_FLAG_SYNC));

    p->next_packet_size = p->device_state->buf_len;
    if (p->next_packet_size > 0) {
        p->iov[p->iovs_num].iov_base = p->device_state->buf;
        p->iov[p->iovs_num].iov_len = p->next_packet_size;
        p->iovs_num++;
    }

    p->flags |= MULTIFD_FLAG_NOCOMP | MULTIFD_FLAG_DEVICE_STATE;

    multifd_send_fill_packet_device_state(p);

    return 0;
}

None of other multifd_ops are used.

I think we can directly invoke this part of device state code in
multifd_send_thread() for now.  So far I think it should be ok.

-- 
Peter Xu


