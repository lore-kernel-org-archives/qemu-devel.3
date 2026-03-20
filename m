Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469CE1098793
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3bCj-0007ia-JR; Fri, 20 Mar 2026 10:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3bCh-0007hx-6O
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:51:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3bCd-0007Op-Px
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774018314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B3COhWJ5jtDwlrN37bNLyd+gccFbTsKsvKfu7RFUPys=;
 b=EiqLCc6us4q0p/nFzbV/V0Br18+sHw6ZyOrTaJBY3VQHvw8AGVQqxecrNFgISqgMVWcJgS
 9HtrgQx3tHjzJtAJyjAFHqlasEyMN+zxuMc2TxL/wgQcN6GTMvX394aEjBFqRJrTCbECwG
 oNZFUmD+7cXaTd3ZYtjQ1TSMBrrD6KI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-KU-NbW6fNqGCy2hb8QAJbg-1; Fri, 20 Mar 2026 10:51:52 -0400
X-MC-Unique: KU-NbW6fNqGCy2hb8QAJbg-1
X-Mimecast-MFC-AGG-ID: KU-NbW6fNqGCy2hb8QAJbg_1774018312
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50920055f0aso102200121cf.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 07:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774018312; x=1774623112; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=B3COhWJ5jtDwlrN37bNLyd+gccFbTsKsvKfu7RFUPys=;
 b=QkPopcORz18kKRaDOMueXdNgnLj4OJmpxqX117Z7ZPoPaS4IdQM56Ko5sy95HnAbaM
 c68aVKCn8OB8FmDhyNxY05Dbhy24rNSzGBEN0+8wiW5Wg/CEDf5XMsF7if7Zdrk0WTxx
 cIuT8CmysPsjcZ4Ziv1X7tmcYCBiHTqy+L43mFBLHz030evLRoD9cNFX1Q3+VDvi57JZ
 ZJmVHx43xIr52cslWnmKJf0bT5QMOJ/w+kmy5UCxb96KoA9PJi9z1ecc+vdxNDk8Wc8M
 pliIaGKV1PXWrzXjvaTh6OQoxTRQ2TcreCEDCjc4Pal3+a0rE179SoYztKjtIgeRDWB6
 JwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774018312; x=1774623112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B3COhWJ5jtDwlrN37bNLyd+gccFbTsKsvKfu7RFUPys=;
 b=LYYf9Yd+nPg6FHZxmu/O2MSTGS9QyNdDzmd0HJiDSaUfIr8mJzMwGmOoqMtB7sZlWa
 qppQkugzAGcs9/ZWlBsmicDyZpjhV6Y778d2CrwYmPXTLpK7bldoZc9HXdoaEGE0QjFx
 +zpDbJFjMlw49oQHo9crNe1LQsRxTBSpSscy3WrzO4aBNvIcGcFLTscCG/8mw02dulZ1
 /LKhOU3KNxK4XpjziSwQZ+7GWLihY0Z34GaZURsmr/IWYKW3btNWfF8v3yTbdWo4HVZo
 c+84/NWxoqlZ/Ef3YtXZ8wX8+N9pQA7h2dCMrj+Uop1+6bRXUk2UCa08OTPq6gt5mdSI
 aWkA==
X-Gm-Message-State: AOJu0Ywap5zW/Sd/FkPL51zu5bFXOPGbS/M1Sg1GLFWYLYniRc9I+qjP
 BOEMDz79SSXevbqdLrLv9CI3wQI3//wEj+zhQJx+EXBbJkaCDmQqSoCA8KBlUfqM7sDxylhc5Ft
 MUoWSltWQkfxd/OeBwQr+orpHMkXXmY11IWX2MlLKBHnvKOQaDFjitk3q
X-Gm-Gg: ATEYQzxDL87qvDy7pW9PlFoAAe6vKV5XTNk+El0uLa0GV7IZD3wtMmSD2+9BTvRtNxC
 vY3bE/AH30M+srDHjP8WvKDNBJWm824yHN65vpi+iFodvEPB2u/SgKP1BHfjv+Z9tA6YXePE7yg
 GTqJagovMYCyHEmNmR3c7g4SfIcfE5xP5gsbm8C2b/XUwn9f1an6PTZIisL42bSedlcBrQiJOSI
 OlEO8ri7VSmvdT1KJ8OJidAmGCoLWX0+v2fHgBsxRV/mfjNJZMYEl/HV4FLVTaawJmDJRCvIAst
 ylcKE60kFkFZhRduqsRsClKzSsy6L8CrLrci91roCCcC07Fr1UKCcVev4Ofy3ZY6Mu8leXKf0tI
 KImiCghNLYVtFjQ==
X-Received: by 2002:a05:622a:180f:b0:509:2053:ab5a with SMTP id
 d75a77b69052e-50b3751c0f1mr43432321cf.57.1774018311472; 
 Fri, 20 Mar 2026 07:51:51 -0700 (PDT)
X-Received: by 2002:a05:622a:180f:b0:509:2053:ab5a with SMTP id
 d75a77b69052e-50b3751c0f1mr43431781cf.57.1774018310703; 
 Fri, 20 Mar 2026 07:51:50 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50b36ebae51sm23336621cf.31.2026.03.20.07.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 07:51:50 -0700 (PDT)
Date: Fri, 20 Mar 2026 10:51:49 -0400
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
Message-ID: <ab1fBQuajmbTNC5I@x1.local>
References: <20260317232332.15209-1-peterx@redhat.com>
 <20260317232332.15209-9-peterx@redhat.com> <87a4w335d7.fsf@suse.de>
 <abxxS10KOBTg6GXH@x1.local> <87wlz61wlh.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wlz61wlh.fsf@suse.de>
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

On Fri, Mar 20, 2026 at 10:03:54AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Mar 19, 2026 at 05:56:52PM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > The loader side of ptr marker is pretty straightforward, instead of playing
> >> > the inner_field trick, just do the load manually assuming the marker layout
> >> > is a stable ABI (which it is true already).
> >> >
> >> > This will remove some logic while loading VMSD, and hopefully it makes it
> >> > slightly easier to read.  Unfortunately, we still need to keep the sender
> >> > side because of the JSON blob we're maintaining..
> >> >
> >> 
> >> /ramble
> >> Is the JSON blob ABI? Can we kill it?
> >
> > Yeah, that's a fair ramble.  I had sometimes the same feeling that I wished
> > it not be there, it'll save quite some work..
> >
> > Per my limited understanding of reading the code in the past, the plan 10
> > years ago was having those blob to always be together with the binary
> > stream so that the stream (especially when causing loading failures..) will
> > be parsable and it's easier to know why the load fail.
> >
> 
> This would only work for a file migration or snapshots. The live
> migration wouldn't have received the blob at the point it fails I
> think. That's ok, and it's not a bad idea, but I think we're not making
> good use of it currently.

Now I do start to question more if it's a good idea to put it into a live
stream, after I read both your reply and Alex's.

I think I might have over-thought it to be "working for any version of
QEMU".  Maybe nobody (or at least less than I was expecting yesterday) that
really needs this functionality.  Likely in 99.9999% cases, we always know
the version of QEMU binary together with the stream.

And when put into the live stream... I want to discuss the possibility of
removing it at least there.  Destination read it and drop it right now: it
not only makes save() slower, and load() slower too..  not too much, just
not necessary.

> 
> > However I also confess in the past few years since I worked on migration, I
> > never used it to debug any real VMSD issues..
> >
> 
> I actually do use it a few times a year, pretty much to diff the stream
> between two different QEMU versions, like Alexander mentioned. From the
> recent mips bug:
> 
> (echo "migrate file:migfile-11"; echo "quit") | ./build/qemu-system-mips64 -monitor stdio
> (echo "migrate file:migfile-10"; echo "quit") | ./build-10.2/qemu-system-mips64 -monitor stdio
> diff -y <(./scripts/analyze-migration.py -f migfile-10)
> <(./scripts/analyze-migration.py -f migfile-11) | less
> 
> As you can see, usability is weird. A QEMU command that dumps a JSON
> already formatted would be a good improvement. -dump-vmstate does it,
> but there it's the dump of all vmstates like they were registered, not
> what's actually migrated and of course it doesn't contain the data.

This is a point almost to say it would be nice we keep this (or some
similar function that do more than -dump-vmstate) to be around.

> 
> > I think one reason might be that when migration was very new and when
> > device emulation developers were easier to mess things up, crash happen
> > more, and at that time this tool helps debugging things.  It'll also almost
> > make the VM dump self-explanatory.
> >
> > Nowadays, we added more codes into migration to help, e.g., I recall we
> > added things like QEMU_VM_SECTION_FOOTER and likely more after the vmdesc,
> > which can also help to identify VMSD issues directly from dest QEMU errors.
> >
> > Let me copy some more people to see if there's any thoughts or inputs on
> > the JSON blobs..
> >
> >> AFAIR, it only serves to add
> >> complexity and to break analyze-script from time to time. We'd be better
> >> off parsing the actual stream from a file. Could maybe even use the same
> >> loadvm code, but mock the .get functions to print instead of actually
> >> loading.
> >
> > The problem might be that direct parsing of the binary stream is almost
> > impossible when without the json blob, due to the fact we have a very
> > condensed VMSD fields in the stream (we have zero headers for fields..), so
> > they're very efficient but compat, I think we won't be able to parse an
> > image if we don't know which version of QEMU it was generated from
> > otherwise.
> >
> 
> I was thinking of using the same QEMU version that produced the binary
> stream indeed. But yeah, it's probably not very useful.

I revoke my demand on "it needs to work on unknown QEMU version" now.

> 
> Now, if QEMU can load the binary stream, it could dry-load it
> somehow. We currently have the vmstate-walking code tightly coupled with
> the actual loading of the data, I can see a scenario where these things
> are separated and we can decided what operation to perform on a walk.

Am I the only one who thinks this might be a very good idea? :)

> 
> Would walking the vmstates and generating the JSON beforehand be useful?
> We could then move it to the start of the binary stream, could have a
> QEMU command that dumps it, could even use that set of data structures
> in JSON format to then guide a second walk which either calls the
> devices VMStateInfo or prints the data to a file for debugging. Thinking
> out loud here...

I think it won't work: the migration stream has dependency on device states
(including ram).  It may dump different things when done at the beginning
v.s. when done at switchover, because the VM is running and device states
can change.

Consider one .needed() of a VMSD field that report different things from
time to time (say, the guest driver enabled some device feature during
migration running).

> 
> > But again, I'm not sure we strictly need this in each VM image we send,
> > especially right now on dest QEMU we explicitly allocates that buffer, load
> > this vmdesc dump and then drop it.. There's also that postcopy won't dump
> > this (pretty much because we know it's an active QEMU instance so JSON blob
> > may not really help..), so it's just a bit weird to not be able to see how
> > it helps besides debugging a "migrate to file" case with unknown QEMU
> > versions, for example.  When I know the version of QEMU on src side when
> > something wrong happened (normally we do..), it may not be very needed.
> >
> 
> Well, putting it on the binary stream for TCP migration might be useless
> because we never do anything with it. And it's usually migrating live,
> so we don't even get to it if anything fails. Putting it on the .qcow2
> file is also useless because there's no tooling to inspect the binary
> stream, although we could adapt analyze-migration to take an offset and
> read from the middle of the file. And hexdump'ing it is not super hard
> as well, but it's less likely anyone will do it.
> 
> Even the migrate to file approach is frail because depending on the
> changes between the QEMU that produced the stream and the one we took
> analyze-migration from, the script might not be able to parse the JSON
> at all. Such as with this series.

I agree. So I think we can discuss two separate things:

(1) removal of JSON blob in TCP live streaming

(2) removal of JSON blob in file migration, and replace it with the vmsd
    walker idea you proposed above

One thing funny about (1) is, since (please anyone correct me otherwise..)
all QEMU binaries in the past expect QEMU_VM_VMDESCRIPTION to be present,
but drop the data all the time, we may even consider breaking the ABI
immediately, by sending some fake strings inside without generating the
real JSON..  Old QEMUs migration shouldn't be broken because they'll just
read less and drop less.

I had a feeling (2) should be able to fully replace the current analyze
script, meanwhile we can remove the script completely, and meanwhile remove
all the tricks we have done with the json writer like commit 9867c3a7ced,
35049eb0d2fc, etc., which affects production code paths very much...

> 
> >> 
> >> Having separate code that parses a "thing" that's not the stream, but
> >> that should reflect the stream, but it's not the stream, but pretty
> >> close it's a bit weird to me. I recently had to simply open the raw
> >> stream on emacs and navigate through it because the file: stream was
> >> somehow different from the stream on the qcow2, for the same command
> >> line.
> >
> > Do you mean snapshot-save v.s. live migrate to file URIs when all caps off?
> >
> 
> I was trying to ensure migration to file was producing the same binary
> stream as snapshot-save. For a same command line, the migration was
> succeeding, but the loadm was failing. So I resorted to opening the
> binaries and searching for the QEVM marker.

OK. I hope I'm right we're all moving towards the file: URIs and maybe some
day we can obsolete the old snapshots.

> 
> >> 
> >> (that's another point, parsing from the qcow2 would be cool, which the
> >> JSON blob doesn't provide today I think)
> >> ramble/
> >> 
> >> > This paves way for future processing of non-NULL markers as well.
> >> >
> >> > Signed-off-by: Peter Xu <peterx@redhat.com>
> >> > ---
> >> >  migration/vmstate-types.c | 12 ++++--------
> >> >  migration/vmstate.c       | 40 ++++++++++++++++++++++++---------------
> >> >  2 files changed, 29 insertions(+), 23 deletions(-)
> >> >
> >> > diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> >> > index b31689fc3c..ae465c5c2c 100644
> >> > --- a/migration/vmstate-types.c
> >> > +++ b/migration/vmstate-types.c
> >> > @@ -363,14 +363,10 @@ static bool load_ptr_marker(QEMUFile *f, void *pv, size_t size,
> >> >                              const VMStateField *field, Error **errp)
> >> >  
> >> >  {
> >> > -    int byte = qemu_get_byte(f);
> >> > -
> >> > -    if (byte == VMS_MARKER_PTR_NULL || byte == VMS_MARKER_PTR_VALID) {
> >> > -        /* TODO: process PTR_VALID case */
> >> > -        return true;
> >> > -    }
> >> > -
> >> > -    error_setg(errp, "%s: unexpected ptr marker: %d", __func__, byte);
> >> > +    /*
> >> > +     * Load is done in vmstate core, see vmstate_ptr_marker_load().
> >> > +     */
> >> > +    g_assert_not_reached();
> >> >      return false;
> >> >  }
> >> >  
> >> > diff --git a/migration/vmstate.c b/migration/vmstate.c
> >> > index a3a5f25946..d65fc84dfa 100644
> >> > --- a/migration/vmstate.c
> >> > +++ b/migration/vmstate.c
> >> > @@ -142,6 +142,21 @@ static void vmstate_handle_alloc(void *ptr, const VMStateField *field,
> >> >      }
> >> >  }
> >> >  
> >> > +static bool vmstate_ptr_marker_load(QEMUFile *f, bool *load_field,
> >> > +                                    Error **errp)
> >> > +{
> >> > +    int byte = qemu_get_byte(f);
> >> > +
> >> > +    if (byte == VMS_MARKER_PTR_NULL) {
> >> > +        /* When it's a null ptr marker, do not continue the load */
> >> > +        *load_field = false;
> >> > +        return true;
> >> > +    }
> >> > +
> >> > +    error_setg(errp, "Unexpected ptr marker: %d", byte);
> >> > +    return false;
> >> > +}
> >> > +
> >> >  static bool vmstate_pre_load(const VMStateDescription *vmsd, void *opaque,
> >> >                               Error **errp)
> >> >  {
> >> > @@ -264,30 +279,25 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
> >> >              }
> >> >  
> >> >              for (i = 0; i < n_elems; i++) {
> >> > -                bool ok;
> >> > +                /* If we will process the load of field? */
> >> > +                bool load_field = true;
> >> 
> >> maybe valid_ptr would be more clear?
> >
> > I don't think we can?  Note, that we will only update this field iff the
> > field used the new VMS_ARRAY_OF_POINTER_AUTO_ALLOC, otherwise it simply
> > should be true always and it says "let's load this VMSD".  IOW, in most
> > cases there's no ptr, hence "valid_ptr=true" will be weird on its own I
> > think..
> >
> 
> Ah I see. I was looking at the save side and thinking we can maybe
> simplify the inner_field logic a bit, but it doesn't apply here. I'll
> try to write a patch on top of your series with my ideas.

Sure, I'll read it when it comes.  Or if you think I'm adding code will be
removed soon, just shoot and we discuss to see if we can avoid adding it in
the first place.

> 
> >> 
> >> > +                bool ok = true;
> >> >                  void *curr_elem = first_elem + size * i;
> >> > -                const VMStateField *inner_field;
> >> >  
> >> >                  if (field->flags & VMS_ARRAY_OF_POINTER) {
> >> >                      curr_elem = *(void **)curr_elem;
> >> >                  }
> >> >  
> >> >                  if (!curr_elem && size) {
> >> > -                    /*
> >> > -                     * If null pointer found (which should only happen in
> >> > -                     * an array of pointers), use null placeholder and do
> >> > -                     * not follow.
> >> > -                     */
> >> > -                    inner_field = vmsd_create_ptr_marker_field(field);
> >> > -                } else {
> >> > -                    inner_field = field;
> >> > +                    /* Read the marker instead of VMSD itself */
> >> > +                    if (!vmstate_ptr_marker_load(f, &load_field, errp)) {
> >> > +                        trace_vmstate_load_field_error(field->name, -EINVAL);
> >> > +                        return false;
> >> > +                    }
> >> >                  }
> >> >  
> >> > -                ok = vmstate_load_field(f, curr_elem, size, inner_field, errp);
> >> > -
> >> > -                /* If we used a fake temp field.. free it now */
> >> > -                if (inner_field != field) {
> >> > -                    g_clear_pointer((gpointer *)&inner_field, g_free);
> >> > +                if (load_field) {
> >> > +                    ok = vmstate_load_field(f, curr_elem, size, field, errp);
> >> >                  }
> >> >  
> >> >                  if (ok) {
> >> 
> 

-- 
Peter Xu


