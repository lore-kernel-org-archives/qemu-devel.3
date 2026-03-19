Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81F81091916
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 21:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3LN9-0003uz-Ii; Thu, 19 Mar 2026 17:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3LN6-0003uq-PL
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 17:57:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3LN4-0000W1-8p
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 17:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773957456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wgqHUiJcvYdLMjjaVW9eK3o7UDSHGms+p0DJcy6Wa9U=;
 b=Hz4380JuJDW1jM1BFcUzlbq5DsQ6C+IyryzrlmJmm4QUgVEjuUpQ7PISBGimnbBxALz4qk
 Mu5qpN/EuR3064GB0AxDO4A2SwZ6VEF1j67cY/rLV6NJsiuja+CRTYVYEFUHQeKQj0dzbO
 pBCjCToAlzk9d6hy9z+39twt8oHYSZ4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-Yn2kWrTTN86gaOGx12G_Ew-1; Thu, 19 Mar 2026 17:57:35 -0400
X-MC-Unique: Yn2kWrTTN86gaOGx12G_Ew-1
X-Mimecast-MFC-AGG-ID: Yn2kWrTTN86gaOGx12G_Ew_1773957454
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cfba9b4eb3so681887585a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 14:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773957454; x=1774562254; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wgqHUiJcvYdLMjjaVW9eK3o7UDSHGms+p0DJcy6Wa9U=;
 b=bFRVu6wYpCU7Qp1rWoQ8yto8cG0ZdFznWcHoGTrv3EI/oJ1N2iI6N/Xt6Hh0sE9YL1
 Xr+Stcsojm2CbbtVEEy10q2XQbIVQpmAOnCe84gJb2/yvkw+oNb/k5sT/3ZSrhCj5pxA
 rG2OqopfzwpiMHXkiVdCIbPhg8cwy42inr6oeA3ZGjml0vecbS6RiofRfhwncHRP0ZQg
 9KxWCZRygzcxVI7VjSca1WrlwVgWK6TQdm6BDdg1t4pRZj44R3MbrVdmGD5jGMZNIIIt
 rnLjbPHh3gpeCt+GJhT49LEne30IM92Y7oR9nZTTLseiOMqs+Ae+JeFRU0+03DMZaH70
 cpTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773957454; x=1774562254;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wgqHUiJcvYdLMjjaVW9eK3o7UDSHGms+p0DJcy6Wa9U=;
 b=d++PAsHnzlB2T0+HIqgQFSPV4aDFhMwB+dI16DBn59E6DewqDHX14LHGeNunKpRrgM
 tug8DPmiCeOwEPWUr/G45vaNpBRXfoFkmCB8dcr9s+rsdE3VftEqgoAb9ATRuesvac3q
 3zt6fxyYGnX7Ygw5PFUZPwVoaOoTVk/ATP/GRVto800a4Mg17w4wZkukMd984zDTz641
 K0773cAIgBlr+vC7oeLA40KYa687PtxvTfApyzNH6q11QtQM5y2vUmC9dcX2yJ64zCYv
 zCk+FhYspOjneOVQELMLqRmZFIZEpjwJNlVa6YQnF3uPw51WLiihqeMBXtHo5KPkWosO
 /3EA==
X-Gm-Message-State: AOJu0YxSu54gHTPLbPw1gWXCRW748XWUOs5DcwnGp3FKDytlylxWYCE1
 f+CVaBuWlkYeas+UX57t0tXHEJbAV9pBIG/JsNuqNML94NWcJ5sPARwooQ85shHTSRAQP54sTWd
 AHHO3nkQDYfcSHPFgNZkQKGOmc1OlQJxTVu9/EoD6WUz2nVhDO1krbWAlpDBtQnNj
X-Gm-Gg: ATEYQzxcodi40OtJ1gKB8YjoXXtbJk4bdA/uC0NuCQPJBpw/qDxL42DZVTXkoATPbQa
 4wMdDVnBOnfA07SOJ3N9iNwrllN3ND71ZcAO6+k0WcWtpnJZJEXd8EXsYoHTNNYKSwTj/7Ehp3L
 arZFHGis3LWwmXeQIOG60m5u/NCIVdVP9w+iR3pJXl+oLxg0WtBNaCe8Cof7mu4PRR0V250qvq/
 EGXWheqBOGLViNJ00xdVdnOl07Ke2iBQws9oPcFlCUXKUULujGoM280EJL9LDNAhslU+caGCX0C
 7lzRDiKFwiteszPDHJv/UiJ4G0zNdxlhHgh58K6DA4GiKYPGF9eMKP+fZq4OrLWL4y+XQdXMU1x
 oqDVUvMTNwF+8JQ==
X-Received: by 2002:a05:620a:3705:b0:8cd:c079:fdae with SMTP id
 af79cd13be357-8cfc809732dmr142836785a.73.1773957453999; 
 Thu, 19 Mar 2026 14:57:33 -0700 (PDT)
X-Received: by 2002:a05:620a:3705:b0:8cd:c079:fdae with SMTP id
 af79cd13be357-8cfc809732dmr142832685a.73.1773957453398; 
 Thu, 19 Mar 2026 14:57:33 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cfc9089bebsm26008285a.27.2026.03.19.14.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 14:57:32 -0700 (PDT)
Date: Thu, 19 Mar 2026 17:57:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>, Alexander Graf <graf@amazon.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Juan Quintela <quintela@trasno.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH RFC 08/10] vmstate: Implement load of ptr marker in
 vmstate core
Message-ID: <abxxS10KOBTg6GXH@x1.local>
References: <20260317232332.15209-1-peterx@redhat.com>
 <20260317232332.15209-9-peterx@redhat.com> <87a4w335d7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a4w335d7.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

On Thu, Mar 19, 2026 at 05:56:52PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > The loader side of ptr marker is pretty straightforward, instead of playing
> > the inner_field trick, just do the load manually assuming the marker layout
> > is a stable ABI (which it is true already).
> >
> > This will remove some logic while loading VMSD, and hopefully it makes it
> > slightly easier to read.  Unfortunately, we still need to keep the sender
> > side because of the JSON blob we're maintaining..
> >
> 
> /ramble
> Is the JSON blob ABI? Can we kill it?

Yeah, that's a fair ramble.  I had sometimes the same feeling that I wished
it not be there, it'll save quite some work..

Per my limited understanding of reading the code in the past, the plan 10
years ago was having those blob to always be together with the binary
stream so that the stream (especially when causing loading failures..) will
be parsable and it's easier to know why the load fail.

However I also confess in the past few years since I worked on migration, I
never used it to debug any real VMSD issues..

I think one reason might be that when migration was very new and when
device emulation developers were easier to mess things up, crash happen
more, and at that time this tool helps debugging things.  It'll also almost
make the VM dump self-explanatory.

Nowadays, we added more codes into migration to help, e.g., I recall we
added things like QEMU_VM_SECTION_FOOTER and likely more after the vmdesc,
which can also help to identify VMSD issues directly from dest QEMU errors.

Let me copy some more people to see if there's any thoughts or inputs on
the JSON blobs..

> AFAIR, it only serves to add
> complexity and to break analyze-script from time to time. We'd be better
> off parsing the actual stream from a file. Could maybe even use the same
> loadvm code, but mock the .get functions to print instead of actually
> loading.

The problem might be that direct parsing of the binary stream is almost
impossible when without the json blob, due to the fact we have a very
condensed VMSD fields in the stream (we have zero headers for fields..), so
they're very efficient but compat, I think we won't be able to parse an
image if we don't know which version of QEMU it was generated from
otherwise.

But again, I'm not sure we strictly need this in each VM image we send,
especially right now on dest QEMU we explicitly allocates that buffer, load
this vmdesc dump and then drop it.. There's also that postcopy won't dump
this (pretty much because we know it's an active QEMU instance so JSON blob
may not really help..), so it's just a bit weird to not be able to see how
it helps besides debugging a "migrate to file" case with unknown QEMU
versions, for example.  When I know the version of QEMU on src side when
something wrong happened (normally we do..), it may not be very needed.

> 
> Having separate code that parses a "thing" that's not the stream, but
> that should reflect the stream, but it's not the stream, but pretty
> close it's a bit weird to me. I recently had to simply open the raw
> stream on emacs and navigate through it because the file: stream was
> somehow different from the stream on the qcow2, for the same command
> line.

Do you mean snapshot-save v.s. live migrate to file URIs when all caps off?

> 
> (that's another point, parsing from the qcow2 would be cool, which the
> JSON blob doesn't provide today I think)
> ramble/
> 
> > This paves way for future processing of non-NULL markers as well.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/vmstate-types.c | 12 ++++--------
> >  migration/vmstate.c       | 40 ++++++++++++++++++++++++---------------
> >  2 files changed, 29 insertions(+), 23 deletions(-)
> >
> > diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> > index b31689fc3c..ae465c5c2c 100644
> > --- a/migration/vmstate-types.c
> > +++ b/migration/vmstate-types.c
> > @@ -363,14 +363,10 @@ static bool load_ptr_marker(QEMUFile *f, void *pv, size_t size,
> >                              const VMStateField *field, Error **errp)
> >  
> >  {
> > -    int byte = qemu_get_byte(f);
> > -
> > -    if (byte == VMS_MARKER_PTR_NULL || byte == VMS_MARKER_PTR_VALID) {
> > -        /* TODO: process PTR_VALID case */
> > -        return true;
> > -    }
> > -
> > -    error_setg(errp, "%s: unexpected ptr marker: %d", __func__, byte);
> > +    /*
> > +     * Load is done in vmstate core, see vmstate_ptr_marker_load().
> > +     */
> > +    g_assert_not_reached();
> >      return false;
> >  }
> >  
> > diff --git a/migration/vmstate.c b/migration/vmstate.c
> > index a3a5f25946..d65fc84dfa 100644
> > --- a/migration/vmstate.c
> > +++ b/migration/vmstate.c
> > @@ -142,6 +142,21 @@ static void vmstate_handle_alloc(void *ptr, const VMStateField *field,
> >      }
> >  }
> >  
> > +static bool vmstate_ptr_marker_load(QEMUFile *f, bool *load_field,
> > +                                    Error **errp)
> > +{
> > +    int byte = qemu_get_byte(f);
> > +
> > +    if (byte == VMS_MARKER_PTR_NULL) {
> > +        /* When it's a null ptr marker, do not continue the load */
> > +        *load_field = false;
> > +        return true;
> > +    }
> > +
> > +    error_setg(errp, "Unexpected ptr marker: %d", byte);
> > +    return false;
> > +}
> > +
> >  static bool vmstate_pre_load(const VMStateDescription *vmsd, void *opaque,
> >                               Error **errp)
> >  {
> > @@ -264,30 +279,25 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
> >              }
> >  
> >              for (i = 0; i < n_elems; i++) {
> > -                bool ok;
> > +                /* If we will process the load of field? */
> > +                bool load_field = true;
> 
> maybe valid_ptr would be more clear?

I don't think we can?  Note, that we will only update this field iff the
field used the new VMS_ARRAY_OF_POINTER_AUTO_ALLOC, otherwise it simply
should be true always and it says "let's load this VMSD".  IOW, in most
cases there's no ptr, hence "valid_ptr=true" will be weird on its own I
think..

> 
> > +                bool ok = true;
> >                  void *curr_elem = first_elem + size * i;
> > -                const VMStateField *inner_field;
> >  
> >                  if (field->flags & VMS_ARRAY_OF_POINTER) {
> >                      curr_elem = *(void **)curr_elem;
> >                  }
> >  
> >                  if (!curr_elem && size) {
> > -                    /*
> > -                     * If null pointer found (which should only happen in
> > -                     * an array of pointers), use null placeholder and do
> > -                     * not follow.
> > -                     */
> > -                    inner_field = vmsd_create_ptr_marker_field(field);
> > -                } else {
> > -                    inner_field = field;
> > +                    /* Read the marker instead of VMSD itself */
> > +                    if (!vmstate_ptr_marker_load(f, &load_field, errp)) {
> > +                        trace_vmstate_load_field_error(field->name, -EINVAL);
> > +                        return false;
> > +                    }
> >                  }
> >  
> > -                ok = vmstate_load_field(f, curr_elem, size, inner_field, errp);
> > -
> > -                /* If we used a fake temp field.. free it now */
> > -                if (inner_field != field) {
> > -                    g_clear_pointer((gpointer *)&inner_field, g_free);
> > +                if (load_field) {
> > +                    ok = vmstate_load_field(f, curr_elem, size, field, errp);
> >                  }
> >  
> >                  if (ok) {
> 

-- 
Peter Xu


