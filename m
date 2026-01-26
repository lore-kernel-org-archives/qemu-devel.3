Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7DCD1950F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 19:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkSWC-0003wQ-Aa; Mon, 26 Jan 2026 14:45:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkSW9-0003ul-UA
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 14:44:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkSW7-0006iJ-Pl
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 14:44:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769456694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vZFzgTOU2IZhrfbHmU4fPm3dFzADgPj2kBaQy0vY4nI=;
 b=WiLC3Na1vmbPc9pr8i8s7rkHJkbFNNAwMFB1PsuvXhJKUdNUAYEypBLPkNPfSGzsUpp63W
 rR7LEpHPYO9z/Dsk8UqApH39dq8Ik455Y/SB+TjOSJJDWNAt+YHV0olLj2OeMl/9nBIrOm
 DiPNGKZKlT/dki/FbCSxZX4l0TZkmiI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-Rdq40YY3PhyNBsgOfxe_hw-1; Mon, 26 Jan 2026 14:44:52 -0500
X-MC-Unique: Rdq40YY3PhyNBsgOfxe_hw-1
X-Mimecast-MFC-AGG-ID: Rdq40YY3PhyNBsgOfxe_hw_1769456692
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50142190becso189441521cf.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 11:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769456692; x=1770061492; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vZFzgTOU2IZhrfbHmU4fPm3dFzADgPj2kBaQy0vY4nI=;
 b=a6PItWD4HA/Z4fH9nEx6aeR5VJnV3cy4Gm6FKZfnip4nLw6tqWV8tcroHbVRVss5rM
 7sDIAcPfOjDcrpvhiy5vqqM5Czzkn675tL5roZNgdlrWwyQQAFS1O2zSO3dpFPaRoTKi
 vzzyfasEN48O86pmFGgu4OgKvcqcn7dPC9NI3MVUkKpjHKot695Z5BtiJljNfz7O/qP5
 QlLPbFowXhQTzfvKc99iOqq0INe1GvqbO5VpvOgncuU7hk47IWVheWgDC3zgbe9YXdTK
 h30nwKnLJH+yl1KN7thqFNp6XUPnuTAx/U0g8Oj8GYhADzy5AKKlhLvenuS2hreYJ8TF
 oqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769456692; x=1770061492;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vZFzgTOU2IZhrfbHmU4fPm3dFzADgPj2kBaQy0vY4nI=;
 b=Cxg0FpAW4uPEnb4EK4G1m0fIn53Y8j7KePCVbSzhiK9IoxE17qiayw8TukeCiTDlzW
 Fg27q+nAuAjIYRd+BjHKCOM6kJFFEgm71lM3SIuZ9OsuOknhKtfN561TrQNf42uKU0TL
 1uGuFGOgtK1jFwpkCt/G5asE9A1/BPLWOLu9aUdoI5CMmzwcdsYYwu0PS+WC9h2eLg9V
 Uka6Gt7/TO2feGZ+C4DwfzM70rOftSD0yRFdNcbfS+WpObLP8ZqFGDANieoYENHvA257
 66kJ/fX1TANrtCOFqOiM4THsKVhS/4Sz/Jy7ykAVNWx/aPmtYZL8WG9+IIn8Fz9zlTAS
 VkNg==
X-Gm-Message-State: AOJu0Yyv04Fq0zKRXDukIU6ws8wWQXToZojci7L7XyGGSomQdOeepnuF
 /fWHk+mqJ0OA5CZmvEwmqNiBRTBY7RsvMRqybs8YgXZI22iy1S4AWUSjzGJaQZnbzEka+iu1zcm
 fmTKzXr+tArhemXg7sYEfrRJCBSyXEhQh4PYveXFaAb4fnBleM6/vIAlg
X-Gm-Gg: AZuq6aLruk8VL7HROYgjImk5SB/d9aJShKSEeuOo+f/ZFaBdQSm2/oJ8mFUnd3rgQ1K
 qvMxzQs+4JWx0O6Dk+NF/qcv2Yubt+fAZdRqBPij3CYkBS1qck80c1hcJp3U2x0F/IvQtq2nU+h
 Yke6EaZ24JZjRrkUEQtv700jnHFnU9d+Lll+01MfHEvlgskVtkBJSD3+RM1y+CKQNrwd0RDTK08
 p4HJPsOZAf0v6+H96Z5zEYAlOs89Wf3vhercHXxv/XC/OQYJBncyYHZ64qtLIO0ljN/07MLJmsx
 EG/4AYIwhGq7qcwTBHe48BK/MGP5iiLbQCIMwMRCNssC+DAWDH8PlFAt/xTnpHs0GU4TDgb45hm
 mNJ0=
X-Received: by 2002:a05:622a:a48f:b0:503:2c16:c1f5 with SMTP id
 d75a77b69052e-5032c16c3b4mr452581cf.48.1769456691802; 
 Mon, 26 Jan 2026 11:44:51 -0800 (PST)
X-Received: by 2002:a05:622a:a48f:b0:503:2c16:c1f5 with SMTP id
 d75a77b69052e-5032c16c3b4mr452351cf.48.1769456691346; 
 Mon, 26 Jan 2026 11:44:51 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8949cde83e8sm85654306d6.11.2026.01.26.11.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 11:44:50 -0800 (PST)
Date: Mon, 26 Jan 2026 14:44:49 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Prasad Pandit <ppandit@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 04/10] migration/savevm: Remove SaveStateEntry.is_ram
Message-ID: <aXfEMcFNL_YPjgzg@x1.local>
References: <20260121223336.3381912-1-peterx@redhat.com>
 <20260121223336.3381912-5-peterx@redhat.com>
 <87fr7wigpt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87fr7wigpt.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Jan 23, 2026 at 10:47:10AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > It's neither accurate nor necessary.  Use a proper helper to detect if it's
> > an iterable savevm state entry instead.
> 
> Could you explain what exactly is_ram was supposed to mean?

IIUC when introduced it was trying to capture the ram only, and that's also
why I said it's inaccurate, because ram is not the only thing that can
provide a save_setup() nowadays..

> 
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/savevm.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 61e873d90c..f1cd8c913d 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -249,7 +249,6 @@ typedef struct SaveStateEntry {
> >      const VMStateDescription *vmsd;
> >      void *opaque;
> >      CompatEntry *compat;
> > -    int is_ram;
> >  } SaveStateEntry;
> >  
> >  typedef struct SaveState {
> > @@ -816,10 +815,6 @@ int register_savevm_live(const char *idstr,
> >      se->ops = ops;
> >      se->opaque = opaque;
> >      se->vmsd = NULL;
> > -    /* if this is a live_savem then set is_ram */
> > -    if (ops->save_setup != NULL) {
> > -        se->is_ram = 1;
> > -    }
> >  
> >      pstrcat(se->idstr, sizeof(se->idstr), idstr);
> >  
> > @@ -1866,6 +1861,12 @@ void qemu_savevm_live_state(QEMUFile *f)
> >      qemu_put_byte(f, QEMU_VM_EOF);
> >  }
> >  
> > +/* Is a save state entry iterable (e.g. RAM)? */
> > +static bool qemu_savevm_se_iterable(SaveStateEntry *se)
> > +{
> > +    return se->ops && se->ops->save_setup;
> 
> So it could be iterable and not have .save_live_iterate?
> 
> Also, what's the deal with slirp? AIUI, it would be considered is_ram?

I guess no. Either in term of when it's introduced, or in theory of how I
understand this piece of code should work.. Because savevm_slirp_state
doesn't provide save_setup().

Note that this patch didn't really change the fact on how it works, even if
I _think_ this is broken..  I want to leave it for later, making sure this
patch (while doing the cleanup) doesn't introduce functional changes.

So I expect things to break if e.g. COLO is used with VFIO devices (that
supports migrations), where it also provides save_setup(), but actually
COLO will not properly sync VFIO states.  Likely nobody is using it anyway.

It's also the same to Xen's xen-save-devices-state QMP command.  It looks
to me Xen is playing some "split savevm" work here, however I don't know
whether it'll always workout these days when there're special devices that
provide save_setup().

> 
> > +}
> > +
> >  int qemu_save_device_state(QEMUFile *f)
> >  {
> >      Error *local_err = NULL;
> > @@ -1876,7 +1877,7 @@ int qemu_save_device_state(QEMUFile *f)
> >      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> >          int ret;
> >  
> > -        if (se->is_ram) {
> > +        if (qemu_savevm_se_iterable(se)) {
> 
> Hmm, qemu_savevm_state_setup has:
> 
>     if (!se->ops || !se->ops->save_setup) {
>             continue;
>     }
> 
> therefore:
> 
>     if (!qemu_savevm_se_iterable(se)) {
>             continue;
>     }
> 
> Maybe it would be more practical to put these in a separate list already
> while registering.

This is a question about performance, my gut feeling is looping over with
one queue would be fine for now, but even if not, it'll be further question
to ask after above (on correctness..).

So I plan to be focused on the cleanup part for now in this series..

> 
> >              continue;
> >          }
> >          ret = vmstate_save(f, se, NULL, &local_err);
> > @@ -2648,7 +2649,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type, Error **errp)
> >      se->load_section_id = section_id;
> >  
> >      /* Validate if it is a device's state */
> > -    if (xen_enabled() && se->is_ram) {
> > +    if (xen_enabled() && qemu_savevm_se_iterable(se)) {
> >          error_setg(errp, "loadvm: %s RAM loading not allowed on Xen", idstr);
> >          return -EINVAL;
> >      }
> 

-- 
Peter Xu


