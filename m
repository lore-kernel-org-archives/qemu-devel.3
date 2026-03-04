Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC06EF9001
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxpHR-0001CF-Ar; Wed, 04 Mar 2026 11:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxpHK-0001BG-7r
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:40:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxpHG-0008JL-AJ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:40:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772642447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uKawdxcMLVIJLSE+nTHgwjKgNikikOH+ufPQmRckJEc=;
 b=ZALmqu3BjO8TdaqdclR2g3oU0+k9FOgLtsBUGcToXkmKjntWG0vB+fnqXX3PO/zb8ORGMA
 mi40jdW1D8aRVtYuo9E6c1vVSDogX1huroewpYGkbj49xG78pVY8dSGO0vaE3tctlC/4ap
 4eH2D1mM28ivtM1U1/FzwFVqVdtip9E=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-DOai0U-WN4-EY2wS6eFXrg-1; Wed, 04 Mar 2026 11:40:46 -0500
X-MC-Unique: DOai0U-WN4-EY2wS6eFXrg-1
X-Mimecast-MFC-AGG-ID: DOai0U-WN4-EY2wS6eFXrg_1772642446
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-899ea295601so65889036d6.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 08:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772642446; x=1773247246; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uKawdxcMLVIJLSE+nTHgwjKgNikikOH+ufPQmRckJEc=;
 b=lg34PRnW6ttmpIjXNS6U/ptfOA+E9hao35rp3ugoibt/9PYysdnZDeEtmcTYU9c1RQ
 fOO2jupRAufY30LeYRG7A6sccqUsvIkSS6ku8JvCIqN+yxTMnf/w/sLuGKLk9aQKd5AK
 cFxMvqBFnIsjg51HQ47GN0t8nCj8Gc/b4g1gybpRoS2S4IrktHXaXPCCvaFIQQNBWy+U
 ziWSgfqdP2COxdKZMVH7jyAxZj4knjVEVkOoVOnDgWzJCLFPy4W1Dqjgi6oycK+Y8rvU
 bvwvI43NC7CrwV3uku9NH/8Ah3xPd7GY0AWBmRMHsgRbyhVDtayjxf4Lq+KQVcHkAoUr
 44eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772642446; x=1773247246;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uKawdxcMLVIJLSE+nTHgwjKgNikikOH+ufPQmRckJEc=;
 b=FQAE4vG8y2Sa8FLjVwH2LX4yWV4acL7GHeFMrEMnNil/psmFY48PdVpqVjO7p+3c/d
 bR4U5uu1dfNgVulAVihe7IUmF2tDQpjgnOCG4iqlQkaSUFFU+oeLG8MeXt6ypsHqMTam
 Tm5WYsalxvL83boksJBmiAZBx7LTmb/R/wACGYAG3ardW483q41KcWZ/xNDU16JXcqlZ
 ejwAIeGbrJFrk3xNs9ad1zbC1WXvjapoEfe/uhOFrjkxSqLZQBQYrtvBtI9bYJcELh3x
 K/R9I8O182ma17tFPEaJYmuhX+7GWctGzejODBbn3NsIQEioySLzJU5eOjg6VNTjzMbH
 yS/A==
X-Gm-Message-State: AOJu0YzHRxE85CneQkfKepLRrFSMwk9SihkbgYeUrygsZUMYw0Ybc50S
 H3O1FHWb+27RDPL87LKJmtWcBDldDbt403vXnyW133OhlX1x1O9Uf7B/kOBgG4ClEPUfPhU8t0k
 Z8Lf5xnNZfIWJTMTo/oeZjv8P2wyGgJuqIs9L3IadHTiHxO9iSJWm/n7G
X-Gm-Gg: ATEYQzxzw4jqrmuTJ/kfOBfJQj0sJF917wY5v25isnDCjcqPDN2WWxg1LaYBewm8aCg
 0cAVnGo7KU/lraoP8B+DFyb+HMK0lodwXg4D2euC3cYyLGX3xE8i6t1EWuxBSkOkyHnVI/9bkyF
 BhJNavHPeSJIcyyzi1VRYxk68NH0uB0zH87iknhX3s6jzLjLE0c5qthEJA4jqhOAVRrZ/GH7GrQ
 KfgpHzY11VmFG+ECSVDJtBYHPa1hwNDAqfi1IlBTdicP1002/Nl/8ojD5hPKaxDCHC59aS1OvZf
 pdw3YynDn25wfP1H2TkPkPAFFDGnX5WaZYK49dXb1v6umWUOdtE3fVOE7Peoj/rBHFdO2RYkNMP
 nHaLgCvjhWu8FSg==
X-Received: by 2002:a05:6214:2a88:b0:89a:df:164 with SMTP id
 6a1803df08f44-89a19cec302mr34729046d6.39.1772642445605; 
 Wed, 04 Mar 2026 08:40:45 -0800 (PST)
X-Received: by 2002:a05:6214:2a88:b0:89a:df:164 with SMTP id
 6a1803df08f44-89a19cec302mr34728506d6.39.1772642444965; 
 Wed, 04 Mar 2026 08:40:44 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf65921bsm1645467085a.1.2026.03.04.08.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 08:40:44 -0800 (PST)
Date: Wed, 4 Mar 2026 11:40:28 -0500
From: Peter Xu <peterx@redhat.com>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, Jesper Devantier <foss@defmacro.it>,
 Klaus Jensen <its@irrelevant.dk>, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@stgraber.org>
Subject: Re: [PATCH 3/4] migration: add
 VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_ALLOC
Message-ID: <aahgfLaybfjOpsX1@x1.local>
References: <20260217152517.271422-1-alexander@mihalicyn.com>
 <20260217152517.271422-4-alexander@mihalicyn.com>
 <aaYFbKP8o6A2QY8D@x1.local>
 <CAJqdLrqucwgVJA3bFu5ApayGkKiheCxO_tWJnbvpVPpRmrVAfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJqdLrqucwgVJA3bFu5ApayGkKiheCxO_tWJnbvpVPpRmrVAfQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Mar 04, 2026 at 10:43:53AM +0100, Alexander Mikhalitsyn wrote:
> Am Mo., 2. März 2026 um 22:47 Uhr schrieb Peter Xu <peterx@redhat.com>:
> >
> > On Tue, Feb 17, 2026 at 04:25:16PM +0100, Alexander Mikhalitsyn wrote:
> > > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> > >
> > > Add VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_ALLOC, which
> > > helps to save/restore a dynamic array of pointers to
> > > structures.
> 
> Dear Peter,
> 
> >
> > Sorry for the late response.
> 
> No problem at all, thanks for reviewing ;)
> 
> >
> > >
> > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> > > ---
> > >  include/migration/vmstate.h | 21 +++++++++
> > >  migration/vmstate-types.c   | 88 +++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 109 insertions(+)
> > >
> > > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > > index 89f9f49d20a..bc6495a7f67 100644
> > > --- a/include/migration/vmstate.h
> > > +++ b/include/migration/vmstate.h
> > > @@ -265,6 +265,7 @@ extern const VMStateInfo vmstate_info_bitmap;
> > >  extern const VMStateInfo vmstate_info_qtailq;
> > >  extern const VMStateInfo vmstate_info_gtree;
> > >  extern const VMStateInfo vmstate_info_qlist;
> > > +extern const VMStateInfo vmstate_info_ptrs_array_entry;
> > >
> > >  #define type_check_2darray(t1,t2,n,m) ((t1(*)[n][m])0 - (t2*)0)
> > >  /*
> > > @@ -537,6 +538,26 @@ extern const VMStateInfo vmstate_info_qlist;
> > >      .offset     = vmstate_offset_array(_s, _f, _type*, _n),          \
> > >  }
> > >
> > > +/*
> > > + * For migrating a dynamically allocated uint32-indexed array
> > > + * of pointers to structures (with NULL entries and with auto memory allocation).
> > > + *
> > > + * _type: type of structure pointed to
> > > + * _vmsd: VMSD for structure
> > > + * start: size of structure pointed to (for auto memory allocation)
> > > + */
> > > +#define VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_ALLOC(_field, _state, _field_num, _version, _vmsd, _type) { \
> > > +    .name       = (stringify(_field)),                                \
> > > +    .version_id = (_version),                                         \
> > > +    .num_offset = vmstate_offset_value(_state, _field_num, uint32_t), \
> > > +    .info       = &vmstate_info_ptrs_array_entry,                     \
> >
> > I wonder if we need this hard-coded new info structure for this, more
> > below.
> >
> > > +    .vmsd       = &(_vmsd),                                           \
> > > +    .start      = sizeof(_type),                                      \
> > > +    .size       = sizeof(_type *),                                    \
> > > +    .flags      = VMS_VARRAY_UINT32|VMS_POINTER,                      \
> > > +    .offset     = vmstate_offset_pointer(_state, _field, _type *),    \
> > > +}
> > > +
> > >  #define VMSTATE_VARRAY_OF_POINTER_UINT32(_field, _state, _field_num, _version, _info, _type) { \
> > >      .name       = (stringify(_field)),                                    \
> > >      .version_id = (_version),                                             \
> > > diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> > > index 89cb2114721..3335377cd07 100644
> > > --- a/migration/vmstate-types.c
> > > +++ b/migration/vmstate-types.c
> > > @@ -942,3 +942,91 @@ const VMStateInfo vmstate_info_qlist = {
> > >      .get  = get_qlist,
> > >      .put  = put_qlist,
> > >  };
> > > +
> > > +static int put_ptrs_array_entry(QEMUFile *f, void *ppv, size_t unused_size,
> > > +                                const VMStateField *field, JSONWriter *vmdesc)
> > > +{
> > > +    const VMStateDescription *vmsd = field->vmsd;
> > > +    int ret;
> > > +    Error *local_err = NULL;
> > > +    void *pv;
> > > +
> > > +    /*
> > > +     * (ppv) is an address of an i-th element of a dynamic array.
> > > +     *
> > > +     * (ppv) can not be NULL unless we have some regression/bug in
> > > +     * vmstate_save_state_v(), because it is result of pointer arithemic like:
> > > +     * first_elem + size * i.
> > > +     */
> > > +    if (ppv == NULL) {
> > > +        error_report("vmstate: put_ptrs_array_entry must be called with ppv != NULL");
> > > +        return -EINVAL;
> > > +    }
> > > +
> > > +    /* get a pointer to a structure */
> > > +    pv = *(void **)ppv;
> >
> > Here IIUC it's almost what VMS_ARRAY_OF_POINTER should do.  Could we
> > declare the vmsd with VMS_ARRAY_OF_POINTER so as to save this open-coded
> > dereference of pointer?
> 
> Yes, this is something I tried to do in the first place, but this
> didn't work for my use-case.
> 
> Let me explain what I'm doing in detail. I have the following structure:
> 
> typedef struct NvmeCtrl {
>      ...
>      uint32_t num_queues; // < MAX number of elements in sq
>      NvmeSQueue **sq;
>      ...
> } NvmeCtrl;
> 
> Suppose we have variable n with type NvmeCtrl *.
> 
> // somewhere early during initialization of QEMU device:
> n->sq = g_new0(NvmeSQueue *, n->num_queues);
> 
> // then in runtime (depending on what *guest* wants) we might create
> some sq[i], e.g:
> NvmeSQueue *sq;
> sq = g_malloc0(sizeof(*sq));
> n->sq[3] = sq;
> 
> please, note that n->sq[0], n->sq[1], n->sq[2] can still be NULL. So,
> we allow holes in that array.
> 
> What I found is that if I raise VMS_ARRAY_OF_POINTER flag on VMStateField, then
> migration code in vmstate_load_state() will expect to see so-called
> "fake nullptr field" (vmsd_create_fake_nullptr_field() function call).
> 
> But this is a problem, because our array at the time of
> vmstate_load_state() looks like (N == NULL):
> 0     1     2     3     4     5
> N    N    N     N     N    N

Yes, I actually just notice that the old nullptr trick only works if the
dest QEMU will know if the pointer is NULL... that makes that interface
pretty much, useless in most cases.. :(

So it's not source telling dest that "there's a null pointer in the array",
it's just that both sides know that.  Checking the original patch of that,
indeed it mentioned it's used in ChannelSubSys.css in hw/s390x/css.c:

https://lore.kernel.org/all/20170222160119.52771-4-pasic@linux.vnet.ibm.com/

So I guess the qemu cmdline for that s390 guest will make sure the pointers
will be pre-initialized already..  So yes, it won't work for you.  You're
looking for a full dynamic array of pointers.

> 
> while after vmstate_load_state() I expect it to be:
> 0     1     2     3     4     5
> N    N     N   SQ   N    N
> 
> so, somebody should allocate memory for sq[3] and load data from image
> into that memory.
> 
> Probably, it makes sense to somehow implement a combination of
> VMS_ARRAY_OF_POINTER and  VMS_ALLOC,
> but I tried to be as less invasive as I can and decided to introduce a
> new kind of VMStateField instead.

Yes.  We already used VMS_ALLOC for top level allocation.  We may need
another flag for per-array allocation.

> 
> >
> > > +
> > > +    if (pv == NULL) {
> > > +        /* write a mark telling that there was a NULL pointer */
> > > +        qemu_put_byte(f, false);
> > > +        return 0;
> > > +    }
> > > +
> > > +    /* if pointer is not NULL, dump the structure contents with help of vmsd */
> > > +    qemu_put_byte(f, true);
> > > +    ret = vmstate_save_state(f, vmsd, pv, vmdesc, &local_err);
> >
> > This looks really like VMS_STRUCT, except that it also tries to detect if
> > the pointer is NULL, then save some dumps.
> 
> Precisely, I'm mimicking behavior of VMS_STRUCT | VMS_ALLOC and
> VMS_ARRAY_OF_POINTER here.
> 
> >
> > Is it feasible to make both queues to always be available so as to reuse
> > VMS_STRUCT?  Or is it intentional here to avoid dumping queues where the
> > pointer is NULL?
> 
> By "available" you mean to always allocate memory for all n->sq[i] elements?
> 
> >
> > Even if for the latter, I wonder if we can have better way to do it.  For
> > example, if we can integrate this directly into vmstate_save/load_state()
> > to support some new flag, VMS_ARRAY_OF_POINTER_DYNAMIC, then we can declare
> > some more "official" way to say some pointer of an dynamic array is NULL.
> >
> 
> Yeah, I thought about this too, I believe this is a great idea. But
> taking into account that
> this is my first contribution to QEMU and I'm learning code around I tried to be
> very conservative and don't change any generic code ;-)
> 
> I'm happy to do this work in -v3 if you would like me to do it and
> guide me a bit (I have just send a v2 series,
> but there was no changes in migration API part, only NVMe specifics).

Yes, it would be nice if we can use a good base on this part of work.  The
problem with your proposal is even if it doesn't touch vmstate core, we
will then need to maintain that special .info struct, that's also a burden.
So maybe it's better we do it the best we can come up with.

I changed slightly on the name of the new flag, DYNAMIC might be fine but I
wonder if we can choose something clearer on what it does.

Maybe VMS_ARRAY_OF_POINTER_ALLOW_NULL? It should at least imply two things:

(1) The array being migrated can contain NULL pointers anywhere in the
    elements.  We will need to change the nullptr trick a bit for this: we
    must send a byte (even if it's non-NULL) beforehand saying if this
    element is NULL.  We could reuse 0x30 for NULL, but we need e.g. 0x31
    to say it's non-NULL.  Then this will work even if dest QEMU doesn't
    know which pointer is NULL (unlike s390's css).

(2) If it's non-NULL, dest QEMU allocates the array element memory during
    loading the vmsd.  It plays similarly a role of VMS_ALLOC but for the
    array elements.  We could use a separate flag but I don't see a case
    where this flag can be used without being able to migrate NULL
    elements, so maybe we can stick with one flag so far until we see
    another use case.

The new flag must only be used with VMS_ARRAY_OF_POINTER for sure.  It
should likely verify that each pointer on dest is NULL before hand before
allocating that array element too in case we leak things.

We will also need some coverage in test-vmstate.c for this.

It would be great if you will volunteer on this piece of work, I will try
to help whatever way I can on reviews.  You can also consider doing it
separately then migration can collect it in advance when ready on its own
(proven that it'll be 100% useful here for nvme very soon).

But I know it might be too much to ask, so if you want I can also take a
look at this problem.  Let me know.

Thanks,

-- 
Peter Xu


