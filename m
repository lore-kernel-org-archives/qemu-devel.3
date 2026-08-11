Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24116C5CFED
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtn8T-0003pC-HU; Tue, 11 Aug 2026 10:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wtn8Q-0003or-Fp
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 10:07:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wtn8N-0006Bs-GK
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 10:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786457232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eanlrWvrfR6lOMT0GmoHtHFQzwC/tPo0LsUZeWkiV/I=;
 b=Ng/VIw2u3XH6tLqIXc3q0DzGIv29h2PecwQC27oxiDcMdhUzFcE85x4NnTDtZGBoFvJvLX
 ghy//BMaUZ3GsDev5HYPvMA195qmCKiYqrALef+kxRlGrWPPxN0NhcL3WcrVoW7/VzC5JO
 iy9Hzn/KUXulPN9u3ZrsXgL7N47A2dA=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-tEYj7IchMNCSRd2zToJoRw-1; Tue, 11 Aug 2026 10:07:08 -0400
X-MC-Unique: tEYj7IchMNCSRd2zToJoRw-1
X-Mimecast-MFC-AGG-ID: tEYj7IchMNCSRd2zToJoRw_1786457228
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-73883529f72so2904491137.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 07:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786457228; x=1787062028; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eanlrWvrfR6lOMT0GmoHtHFQzwC/tPo0LsUZeWkiV/I=;
 b=J8Nqle3Pyo1GPcOEZFxqZ7Yb14iSUjxamifjIQPuQSmfmaYSagXEJPvoNilmKYAMg9
 TuDBVj9uxcqiC9/AtBA9FlrJ28B8yFsm5LusdEdBfZGgbxzsGRihVBnSc0uUigSKkoDx
 YAdd53WbZVmh7jcq67RuLD77C9Lfx8x870Ndo4rioh9jJCwdefwqdSmAUrtesfdjRF4X
 rWewNNv+6fCKWqPcqaIaP1lOBtw6U7GSEdY7Bzum2MHcCPzLbzzTspqur+KN+wwVSUDM
 S6Lq83gyUEBy+hEBRQe8vRubwuk1sdr9Y/ApcSewhx2rEQCN3qWlJ5Qg9zO0fBQQdnGj
 sPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786457228; x=1787062028;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eanlrWvrfR6lOMT0GmoHtHFQzwC/tPo0LsUZeWkiV/I=;
 b=nY4SGiFTT2ordNVBwDbDmWJAOuLlIYTsQhbl6RDlxzFscX/p87BildpJV7/U8FN3RS
 9LuTZvD8tcFI9/mo1H8xF16pY39EuyPRZV3k+r8GIbYjxLIqXkHiprmj8Zh9hHyt2YQU
 ngVwhhUJ6FpW2qJVRTsz6Ys3k1Q36KW/d15W9zZ2co9XJqm0tdL2PN21sXFIhr8HIx0e
 uuuw9yHPa6AKZ11oyNhynBAKyMd+xXjjNSLS10Gow30lTeqhIIdOM1Q0ByraWyDH5jBZ
 IKn6Bn3ic9qLcW9BJYAc2ALV3scR5Bt/UKgugS75NdFxzb5PXvWvaxcOXhg2iPUwzhPo
 QHcg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoRW304l+/J8x2PwlDaKdn5SeTFXnv5gq9O6ByDrOm9+sU/toZutV970njGWgz+1/AgSTlomsZOuPgi@nongnu.org
X-Gm-Message-State: AOJu0YyGTUopj+fhXmLlVZoYFRjWPip8BT4eszGCA7k04kQ3NaTIU1+n
 fmIAkKtigbfAMwkImAFgSQrZ8EScz/JnuzA3bpilHYR3YsYN/OPHyhJCWWbm2B1nvgeJGgBlasT
 qWWe/F40E4oh5FLPEuk3zv6t0SIOfA/k6FHXxumv+E/AnjnMS6mCo62C3
X-Gm-Gg: AR+sD10fdjK67aFahN/fo1mcqD3Qv3RmstUoH+oKLX3VQI0AC+5w5SuAQG9xfFzHvqs
 +RFC13lCso9AouGbcw2aPbvzOZxcUL41vgGND8oDogeBjBeJLcHLvrqZZL79c/usXdyOj9wEkRH
 UrRJ3M0jx6j2+JWtkm0Dq/lQUe7j/a6FSTa903wtQim7BvAXCP1mE4ngUrD4l4NVkgh56zlgW6T
 ioG31+3DFE9WD+T37dIx+viRSi2g+VWbzYYujbpxXf43aM0FyGZZa4IbO/bDmAx8vbC85Tutglx
 FUVks88zMtGLxC6+0SznVVsQPBlIKG2OcxT3zHIxJAPq9le/yDaej4NPw1htxxIAdTAL
X-Received: by 2002:a05:6102:1588:b0:739:5cfb:50f6 with SMTP id
 ada2fe7eead31-76b570bd5demr1080422137.11.1786457227566; 
 Tue, 11 Aug 2026 07:07:07 -0700 (PDT)
X-Received: by 2002:a05:6102:1588:b0:739:5cfb:50f6 with SMTP id
 ada2fe7eead31-76b570bd5demr1080392137.11.1786457226938; 
 Tue, 11 Aug 2026 07:07:06 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-97a3c16629csm2906241.4.2026.08.11.07.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 07:07:06 -0700 (PDT)
Date: Tue, 11 Aug 2026 10:06:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: Re: [PATCH 2/4] migration: Introduce VMStateOffset
Message-ID: <anssfjna-uNi7bqR@x1.local>
References: <20260729225227.1170574-1-farosas@suse.de>
 <20260729225227.1170574-3-farosas@suse.de>
 <3166925a-0456-42b6-80d3-8154e3e66825@yandex-team.ru>
 <87o6fnmf4c.fsf@suse.de> <amzGTh3DXvX9ovJQ@x1.local>
 <87ldarm8rp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ldarm8rp.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
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

On Fri, Jul 31, 2026 at 01:19:38PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Fri, Jul 31, 2026 at 11:02:27AM -0300, Fabiano Rosas wrote:
> >> Hi Vladimir, I've been looking at this, could you clarify which vmstates
> >> do you think we could merge? I don't see it, either VARRAY vs. VBUFFER
> >> or VARRAY vs. BUFFER, also ARRAY vs. BUFFER doesn't seem to work.
> >> 
> >> One main point of difference is the size_offset/num_offset variants are
> >> only known at load-time, so we can't convert them between each other at
> >> build time because the either the total size or num will not be know.
> >
> > Something like this?
> >
> > NOTE: I hid a fix to a comment that is irrelevant.. which I mentioned @size
> > and @size_offset can't co-exist, but it can when VMS_MULTIPLY is set.  I
> > had a vague feeling we can further clean vmstate flags.
> 
> Is there a reason we cannot use .num for MULTIPLY instead of .size?

.num decides not only the size for allocation when needed, but also how
many times we'll invoke the vmstate_save|load_field(), so maybe not
directly replaceable.

> 
> >
> > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > index 24631fd678..3a02709650 100644
> > --- a/include/migration/vmstate.h
> > +++ b/include/migration/vmstate.h
> > @@ -69,17 +69,15 @@ enum VMStateFlags {
> >       * }). Dereference the pointer before using it as basis for
> >       * further pointer arithmetic (see e.g. VMS_ARRAY). Does not
> >       * affect the meaning of VMStateField.num_offset or
> > -     * VMStateField.size_offset; see VMS_VARRAY and VMS_VBUFFER for
> > -     * those.
> > +     * VMStateField.size_offset; see VMS_VARRAY for those.
> >       */
> >      VMS_POINTER          = 0x002,
> >  
> >      /* The field is an array of fixed size. VMStateField.num contains
> >       * the number of entries in the array. The size of each entry is
> >       * given by VMStateField.size and / or opaque +
> > -     * VMStateField.size_offset; see VMS_VBUFFER and
> > -     * VMS_MULTIPLY. Each array entry will be processed individually
> > -     * (VMStateField.info.get()/put() if VMS_STRUCT is not set,
> > +     * VMStateField.size_offset. Each array entry will be processed
> > +     * individually (VMStateField.info.get()/put() if VMS_STRUCT is not set,
> >       * recursion into VMStateField.vmsd if VMS_STRUCT is set). May not
> >       * be combined with VMS_VARRAY.
> >       */
> > @@ -108,18 +106,10 @@ enum VMStateFlags {
> >       */
> >      VMS_ARRAY_OF_POINTER = 0x040,
> >  
> > -    /* The size of the individual entries (a single array entry if
> > -     * VMS_ARRAY or VMS_VARRAY are set, or the field itself if
> > -     * neither is set) is variable (i.e. not known at compile-time),
> > -     * but the same for all entries. Use the int32_t at opaque +
> > -     * VMStateField.size_offset (subject to VMS_MULTIPLY) to determine
> > -     * the size of each (and every) entry. */
> > -    VMS_VBUFFER          = 0x100,
> > -
> >      /* Multiply the entry size given by the int32_t at opaque +
> > -     * VMStateField.size_offset (see VMS_VBUFFER description) with
> > -     * VMStateField.size to determine the number of bytes to be
> > -     * allocated. Only valid in combination with VMS_VBUFFER. */
> > +     * VMStateField.size_offset with VMStateField.size to determine the
> > +     * number of bytes to be allocated.
> > +     */
> >      VMS_MULTIPLY         = 0x200,
> >  
> >      /* Fail loading the serialised VM state if this field is missing
> > @@ -181,8 +171,8 @@ struct VMStateField {
> >  
> >      /*
> >       * @size or @size_offset specifies the size of the element embeded in
> > -     * the field.  Only one of them should be present never both.  When
> > -     * @size_offset is used together with VMS_VBUFFER, it means the size is
> > +     * the field.  Only one of them should be present never both, except
> > +     * VMS_MULTIPLY.  When @size_offset is used, it means the size is
> >       * dynamic calculated instead of a constant.
> >       *
> >       * When the field is an array of any type, this stores the size of one
> > @@ -696,7 +686,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
> >      .size_offset  = vmstate_field_offset(_state, _field_size),       \
> >      .size         = (_multiply),                                      \
> >      .info         = &vmstate_info_buffer,                            \
> > -    .flags        = VMS_VBUFFER|VMS_POINTER|VMS_MULTIPLY,            \
> > +    .flags        = VMS_VARRAY|VMS_POINTER|VMS_MULTIPLY,              \
> >      .offset       = offsetof(_state, _field),                        \
> >  }
> >  
> > @@ -706,7 +696,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
> >      .field_exists = (_test),                                         \
> >      .size_offset  = vmstate_field_offset(_state, _field_size),       \
> >      .info         = &vmstate_info_buffer,                            \
> > -    .flags        = VMS_VBUFFER|VMS_POINTER,                         \
> > +    .flags        = VMS_VARRAY|VMS_POINTER,                          \
> >      .offset       = offsetof(_state, _field),                        \
> >  }
> >  
> > @@ -720,7 +710,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
> >      .field_exists = (_test),                                         \
> >      .size_offset  = vmstate_field_offset(_state, _field_size),       \
> >      .info         = &vmstate_info_buffer,                            \
> > -    .flags        = VMS_VBUFFER|VMS_POINTER|VMS_ALLOC,               \
> > +    .flags        = VMS_VARRAY|VMS_POINTER|VMS_ALLOC,                \
> >      .offset       = offsetof(_state, _field),                        \
> >  }
> >  
> > @@ -798,7 +788,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
> >      .version_id   = (_version),                                      \
> >      .size_offset  = vmstate_field_offset(_state, _field_size),       \
> >      .info         = &vmstate_info_bitmap,                            \
> > -    .flags        = VMS_VBUFFER|VMS_POINTER,                         \
> > +    .flags        = VMS_VARRAY|VMS_POINTER,                          \
> >      .offset       = offsetof(_state, _field),                        \
> >  }
> >  
> > @@ -1200,9 +1190,6 @@ extern const VMStateInfo vmstate_info_g_byte_array;
> >  #define VMSTATE_BUFFER_START_MIDDLE(_f, _s, _start) \
> >      VMSTATE_BUFFER_START_MIDDLE_V(_f, _s, _start, 0)
> >  
> > -#define VMSTATE_PARTIAL_VBUFFER(_f, _s, _size)                        \
> > -    VMSTATE_VBUFFER(_f, _s, 0, NULL, _size)
> > -
> >  #define VMSTATE_PARTIAL_VBUFFER_UINT32(_f, _s, _size)                        \
> >      VMSTATE_VBUFFER_UINT32(_f, _s, 0, NULL, _size)
> >  
> > diff --git a/migration/vmstate.c b/migration/vmstate.c
> > index bc8eb3d3ca..f7363a8776 100644
> > --- a/migration/vmstate.c
> > +++ b/migration/vmstate.c
> > @@ -102,7 +102,7 @@ static uint64_t vmstate_n_elems(void *opaque, const VMStateField *field)
> >  
> >      if (field->flags & VMS_ARRAY) {
> >          n_elems = field->num;
> > -    } else if (field->flags & VMS_VARRAY) {
> > +    } else if (field->num_offset.size) {
> 
> Hmm, is it better to infer from the data rather than having the explicit
> flag? And if so, can't we remove VMS_VARRAY flag altogether?

Yes, looks like we can drop it too.

> 
> From Vladimir's message I though the intent was not only to remove the
> flag, but to remove the definition of VMSTATE_VBUFFER entirely and
> somehow fit that case into VMSTATE_VARRAY, removing size_offset along
> with it.

I may have messed up one thing in my prior quick patch, that I replaced
VMS_VBUFFER with VMS_VARRAY, but in reality I don't think we need .num for
VBUFFER case.. so maybe VMS_VARRAY isn't needed either.

Or say, we should have two ways to get rid of VBUFFER: either treat it as
one buffer (.size non-zero, .num not needed), or multiple chars (.size = 1
which is a byte, .num to be size of buffer).

> 
> >          n_elems = vmstate_read_from_offset(opaque,
> >      &field->num_offset); }
> >  
> > @@ -114,17 +114,17 @@ static uint64_t vmstate_size(void *opaque, const VMStateField *field)
> >  {
> >      uint64_t size;
> >  
> > -    if (field->flags & VMS_VBUFFER) {
> > -        size = vmstate_read_from_offset(opaque, &field->size_offset);
> > -        if (field->flags & VMS_MULTIPLY) {
> > -            size *= field->size;
> > -        }
> > -    } else if (field->flags & VMS_ARRAY_OF_POINTER) {
> > +    if (field->flags & VMS_ARRAY_OF_POINTER) {
> >          /*
> >           * For an array of pointer, the each element is always size of a
> >           * host pointer.
> >           */
> >          size = sizeof(void *);
> > +    } else if (field->size_offset.size) {
> > +        size = vmstate_read_from_offset(opaque, &field->size_offset);
> > +        if (field->flags & VMS_MULTIPLY) {
> > +            size *= field->size;
> > +        }
> >      } else {
> >          size = field->size;
> 
> Since we're talking about flags, I'd like to be able to assert(size) at
> this point, but there is some weirness with vmstate_msix and
> vmstate_scsi_device that have no state at all. I'm thinking of
> introducing a new flag to identify those cases:

Your patch below looks ok to me, I'll wait for you to repost with all the
things.  There seems to be quite something we can explore in vmstate code
to clean it up..

Just to say, IIUC there're better way to impl both.  It looks like both of
them came from 10+ years ago so vmstate code was rough.  Now we have more
facilities and I think we can do better on them, I suspect,

- vmstate_msix can be replaced with two VBUFFER plus some post_load hooks,

- vmstate_scsi_device might be replaced with VMSTATE_QTAILQ_V, but this one
  is trickier to make sure ABI compatible.

These can be future items to explore even if applicable..  Let's fix the
security / hardening issues first that your series addresses.

Thanks,

> 
> -- >8 --
> From: Fabiano Rosas <farosas@suse.de>
> Subject: [PATCH] migration: Add VMS_NO_STATE flag
> 
> There are a few special cases of vmstate usage:
> 
> The vmstate_msix and vmstate_scsi_device have fields that contain no
> data, only a vmstate_info structure.
> 
> The VMSTATE_VALIDATE macro serves only to invoke the .field_exists
> routine for validation.
> 
> Regardless whether these scenarios are valid, add a separate flag to
> identify them so we can enforce common constraints for the normal
> vmstates such as having a size greater than zero.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  hw/pci/msix.c               | 6 +-----
>  hw/scsi/scsi-bus.c          | 6 +-----
>  include/migration/vmstate.h | 9 +++++++--
>  migration/savevm.c          | 3 +--
>  4 files changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/pci/msix.c b/hw/pci/msix.c
> index 1b23eaf1007..adf76b5bccc 100644
> --- a/hw/pci/msix.c
> +++ b/hw/pci/msix.c
> @@ -711,12 +711,8 @@ const VMStateDescription vmstate_msix = {
>      .fields = (const VMStateField[]) {
>          {
>              .name         = "msix",
> -            .version_id   = 0,
> -            .field_exists = NULL,
> -            .size         = 0,   /* ouch */
>              .info         = &vmstate_info_msix,
> -            .flags        = VMS_SINGLE,
> -            .offset       = 0,
> +            .flags        = VMS_SINGLE | VMS_NO_STATE,
>          },
>          VMSTATE_END_OF_LIST()
>      }
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index deb43d5560e..aa02ff631b7 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -1980,12 +1980,8 @@ const VMStateDescription vmstate_scsi_device = {
>          VMSTATE_UINT32(sense_len, SCSIDevice),
>          {
>              .name         = "requests",
> -            .version_id   = 0,
> -            .field_exists = NULL,
> -            .size         = 0,   /* ouch */
>              .info         = &vmstate_info_scsi_requests,
> -            .flags        = VMS_SINGLE,
> -            .offset       = 0,
> +            .flags        = VMS_SINGLE | VMS_NO_STATE,
>          },
>          VMSTATE_END_OF_LIST()
>      },
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 09b2e535645..ada1625f5b6 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -108,6 +108,12 @@ enum VMStateFlags {
>       */
>      VMS_ARRAY_OF_POINTER = 0x040,
>  
> +    /*
> +     * The field contains no data. Used for special cases such as
> +     * invoking a custom VMStateInfo.
> +     */
> +    VMS_NO_STATE = 0x080,
> +
>      /* The size of the individual entries (a single array entry if
>       * VMS_ARRAY or VMS_VARRAY are set, or the field itself if
>       * neither is set) is variable (i.e. not known at compile-time),
> @@ -451,8 +457,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>  #define VMSTATE_VALIDATE(_name, _test) { \
>      .name         = (_name),                                         \
>      .field_exists = (_test),                                         \
> -    .flags        = VMS_ARRAY | VMS_MUST_EXIST,                      \
> -    .num          = 0, /* 0 elements: no data, only run _test */     \
> +    .flags        = VMS_ARRAY | VMS_MUST_EXIST | VMS_NO_STATE,       \
>  }
>  
>  #define VMSTATE_POINTER(_field, _state, _version, _info, _type) {    \
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 3e5cce6520d..160c0f2d97d 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -617,8 +617,7 @@ static void dump_vmstate_vmsd(FILE *out_file,
>          fprintf(out_file, ",\n%*s\"Fields\": [\n", indent, "");
>          first = true;
>          while (field->name != NULL) {
> -            if (field->flags & VMS_MUST_EXIST) {
> -                /* Ignore VMSTATE_VALIDATE bits; these don't get migrated */
> +            if (field->flags & VMS_NO_STATE) {
>                  field++;
>                  continue;
>              }
> -- 
> 2.53.0
> 

-- 
Peter Xu


