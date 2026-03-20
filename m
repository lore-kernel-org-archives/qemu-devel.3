Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDC51098783
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ZWI-0002AP-4h; Fri, 20 Mar 2026 09:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w3ZWF-0002A4-48
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:04:03 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w3ZWC-0004LB-S5
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:04:02 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5EF8F4D274;
 Fri, 20 Mar 2026 13:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774011837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=krBbo/og5k478kDJtE31TR5J/04vonl02+zf3VqYzTw=;
 b=mSOKe5t1zAzXNt0eNiQqbUm7f8rqIJNjIRCXip20U2ResoOGN1Z2QZNucBG/f2FOJnu+kX
 3BHCB5df+dIzRHLDidy0ZAdzF/q6E6hUcJ63szo6mpJ5HPV+3bHRWrEoWmyzggrn8vUBx6
 wfiCUvYlSG0uiUKk8yuDBUypmTag5X0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774011837;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=krBbo/og5k478kDJtE31TR5J/04vonl02+zf3VqYzTw=;
 b=fbMYG5R8O61VaSdN2cJXoMb9jc/guGYm9Ecs2A4MF3n4SaY99HMRd2SvTknbmHXzkeSifF
 n4V5czbbOwcbcBAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mSOKe5t1;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fbMYG5R8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774011837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=krBbo/og5k478kDJtE31TR5J/04vonl02+zf3VqYzTw=;
 b=mSOKe5t1zAzXNt0eNiQqbUm7f8rqIJNjIRCXip20U2ResoOGN1Z2QZNucBG/f2FOJnu+kX
 3BHCB5df+dIzRHLDidy0ZAdzF/q6E6hUcJ63szo6mpJ5HPV+3bHRWrEoWmyzggrn8vUBx6
 wfiCUvYlSG0uiUKk8yuDBUypmTag5X0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774011837;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=krBbo/og5k478kDJtE31TR5J/04vonl02+zf3VqYzTw=;
 b=fbMYG5R8O61VaSdN2cJXoMb9jc/guGYm9Ecs2A4MF3n4SaY99HMRd2SvTknbmHXzkeSifF
 n4V5czbbOwcbcBAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAA67427EF;
 Fri, 20 Mar 2026 13:03:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6EvJKLxFvWn/YAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 20 Mar 2026 13:03:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>, Alexander Graf <graf@amazon.com>,
 Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert"
 <dave@treblig.org>, Juan Quintela <quintela@trasno.org>, Peter Maydell
 <peter.maydell@linaro.org>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH RFC 08/10] vmstate: Implement load of ptr marker in
 vmstate core
In-Reply-To: <abxxS10KOBTg6GXH@x1.local>
References: <20260317232332.15209-1-peterx@redhat.com>
 <20260317232332.15209-9-peterx@redhat.com> <87a4w335d7.fsf@suse.de>
 <abxxS10KOBTg6GXH@x1.local>
Date: Fri, 20 Mar 2026 10:03:54 -0300
Message-ID: <87wlz61wlh.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[10];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5EF8F4D274
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> On Thu, Mar 19, 2026 at 05:56:52PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > The loader side of ptr marker is pretty straightforward, instead of playing
>> > the inner_field trick, just do the load manually assuming the marker layout
>> > is a stable ABI (which it is true already).
>> >
>> > This will remove some logic while loading VMSD, and hopefully it makes it
>> > slightly easier to read.  Unfortunately, we still need to keep the sender
>> > side because of the JSON blob we're maintaining..
>> >
>> 
>> /ramble
>> Is the JSON blob ABI? Can we kill it?
>
> Yeah, that's a fair ramble.  I had sometimes the same feeling that I wished
> it not be there, it'll save quite some work..
>
> Per my limited understanding of reading the code in the past, the plan 10
> years ago was having those blob to always be together with the binary
> stream so that the stream (especially when causing loading failures..) will
> be parsable and it's easier to know why the load fail.
>

This would only work for a file migration or snapshots. The live
migration wouldn't have received the blob at the point it fails I
think. That's ok, and it's not a bad idea, but I think we're not making
good use of it currently.

> However I also confess in the past few years since I worked on migration, I
> never used it to debug any real VMSD issues..
>

I actually do use it a few times a year, pretty much to diff the stream
between two different QEMU versions, like Alexander mentioned. From the
recent mips bug:

(echo "migrate file:migfile-11"; echo "quit") | ./build/qemu-system-mips64 -monitor stdio
(echo "migrate file:migfile-10"; echo "quit") | ./build-10.2/qemu-system-mips64 -monitor stdio
diff -y <(./scripts/analyze-migration.py -f migfile-10)
<(./scripts/analyze-migration.py -f migfile-11) | less

As you can see, usability is weird. A QEMU command that dumps a JSON
already formatted would be a good improvement. -dump-vmstate does it,
but there it's the dump of all vmstates like they were registered, not
what's actually migrated and of course it doesn't contain the data.

> I think one reason might be that when migration was very new and when
> device emulation developers were easier to mess things up, crash happen
> more, and at that time this tool helps debugging things.  It'll also almost
> make the VM dump self-explanatory.
>
> Nowadays, we added more codes into migration to help, e.g., I recall we
> added things like QEMU_VM_SECTION_FOOTER and likely more after the vmdesc,
> which can also help to identify VMSD issues directly from dest QEMU errors.
>
> Let me copy some more people to see if there's any thoughts or inputs on
> the JSON blobs..
>
>> AFAIR, it only serves to add
>> complexity and to break analyze-script from time to time. We'd be better
>> off parsing the actual stream from a file. Could maybe even use the same
>> loadvm code, but mock the .get functions to print instead of actually
>> loading.
>
> The problem might be that direct parsing of the binary stream is almost
> impossible when without the json blob, due to the fact we have a very
> condensed VMSD fields in the stream (we have zero headers for fields..), so
> they're very efficient but compat, I think we won't be able to parse an
> image if we don't know which version of QEMU it was generated from
> otherwise.
>

I was thinking of using the same QEMU version that produced the binary
stream indeed. But yeah, it's probably not very useful.

Now, if QEMU can load the binary stream, it could dry-load it
somehow. We currently have the vmstate-walking code tightly coupled with
the actual loading of the data, I can see a scenario where these things
are separated and we can decided what operation to perform on a walk.

Would walking the vmstates and generating the JSON beforehand be useful?
We could then move it to the start of the binary stream, could have a
QEMU command that dumps it, could even use that set of data structures
in JSON format to then guide a second walk which either calls the
devices VMStateInfo or prints the data to a file for debugging. Thinking
out loud here...

> But again, I'm not sure we strictly need this in each VM image we send,
> especially right now on dest QEMU we explicitly allocates that buffer, load
> this vmdesc dump and then drop it.. There's also that postcopy won't dump
> this (pretty much because we know it's an active QEMU instance so JSON blob
> may not really help..), so it's just a bit weird to not be able to see how
> it helps besides debugging a "migrate to file" case with unknown QEMU
> versions, for example.  When I know the version of QEMU on src side when
> something wrong happened (normally we do..), it may not be very needed.
>

Well, putting it on the binary stream for TCP migration might be useless
because we never do anything with it. And it's usually migrating live,
so we don't even get to it if anything fails. Putting it on the .qcow2
file is also useless because there's no tooling to inspect the binary
stream, although we could adapt analyze-migration to take an offset and
read from the middle of the file. And hexdump'ing it is not super hard
as well, but it's less likely anyone will do it.

Even the migrate to file approach is frail because depending on the
changes between the QEMU that produced the stream and the one we took
analyze-migration from, the script might not be able to parse the JSON
at all. Such as with this series.

>> 
>> Having separate code that parses a "thing" that's not the stream, but
>> that should reflect the stream, but it's not the stream, but pretty
>> close it's a bit weird to me. I recently had to simply open the raw
>> stream on emacs and navigate through it because the file: stream was
>> somehow different from the stream on the qcow2, for the same command
>> line.
>
> Do you mean snapshot-save v.s. live migrate to file URIs when all caps off?
>

I was trying to ensure migration to file was producing the same binary
stream as snapshot-save. For a same command line, the migration was
succeeding, but the loadm was failing. So I resorted to opening the
binaries and searching for the QEVM marker.

>> 
>> (that's another point, parsing from the qcow2 would be cool, which the
>> JSON blob doesn't provide today I think)
>> ramble/
>> 
>> > This paves way for future processing of non-NULL markers as well.
>> >
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >  migration/vmstate-types.c | 12 ++++--------
>> >  migration/vmstate.c       | 40 ++++++++++++++++++++++++---------------
>> >  2 files changed, 29 insertions(+), 23 deletions(-)
>> >
>> > diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
>> > index b31689fc3c..ae465c5c2c 100644
>> > --- a/migration/vmstate-types.c
>> > +++ b/migration/vmstate-types.c
>> > @@ -363,14 +363,10 @@ static bool load_ptr_marker(QEMUFile *f, void *pv, size_t size,
>> >                              const VMStateField *field, Error **errp)
>> >  
>> >  {
>> > -    int byte = qemu_get_byte(f);
>> > -
>> > -    if (byte == VMS_MARKER_PTR_NULL || byte == VMS_MARKER_PTR_VALID) {
>> > -        /* TODO: process PTR_VALID case */
>> > -        return true;
>> > -    }
>> > -
>> > -    error_setg(errp, "%s: unexpected ptr marker: %d", __func__, byte);
>> > +    /*
>> > +     * Load is done in vmstate core, see vmstate_ptr_marker_load().
>> > +     */
>> > +    g_assert_not_reached();
>> >      return false;
>> >  }
>> >  
>> > diff --git a/migration/vmstate.c b/migration/vmstate.c
>> > index a3a5f25946..d65fc84dfa 100644
>> > --- a/migration/vmstate.c
>> > +++ b/migration/vmstate.c
>> > @@ -142,6 +142,21 @@ static void vmstate_handle_alloc(void *ptr, const VMStateField *field,
>> >      }
>> >  }
>> >  
>> > +static bool vmstate_ptr_marker_load(QEMUFile *f, bool *load_field,
>> > +                                    Error **errp)
>> > +{
>> > +    int byte = qemu_get_byte(f);
>> > +
>> > +    if (byte == VMS_MARKER_PTR_NULL) {
>> > +        /* When it's a null ptr marker, do not continue the load */
>> > +        *load_field = false;
>> > +        return true;
>> > +    }
>> > +
>> > +    error_setg(errp, "Unexpected ptr marker: %d", byte);
>> > +    return false;
>> > +}
>> > +
>> >  static bool vmstate_pre_load(const VMStateDescription *vmsd, void *opaque,
>> >                               Error **errp)
>> >  {
>> > @@ -264,30 +279,25 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
>> >              }
>> >  
>> >              for (i = 0; i < n_elems; i++) {
>> > -                bool ok;
>> > +                /* If we will process the load of field? */
>> > +                bool load_field = true;
>> 
>> maybe valid_ptr would be more clear?
>
> I don't think we can?  Note, that we will only update this field iff the
> field used the new VMS_ARRAY_OF_POINTER_AUTO_ALLOC, otherwise it simply
> should be true always and it says "let's load this VMSD".  IOW, in most
> cases there's no ptr, hence "valid_ptr=true" will be weird on its own I
> think..
>

Ah I see. I was looking at the save side and thinking we can maybe
simplify the inner_field logic a bit, but it doesn't apply here. I'll
try to write a patch on top of your series with my ideas.

>> 
>> > +                bool ok = true;
>> >                  void *curr_elem = first_elem + size * i;
>> > -                const VMStateField *inner_field;
>> >  
>> >                  if (field->flags & VMS_ARRAY_OF_POINTER) {
>> >                      curr_elem = *(void **)curr_elem;
>> >                  }
>> >  
>> >                  if (!curr_elem && size) {
>> > -                    /*
>> > -                     * If null pointer found (which should only happen in
>> > -                     * an array of pointers), use null placeholder and do
>> > -                     * not follow.
>> > -                     */
>> > -                    inner_field = vmsd_create_ptr_marker_field(field);
>> > -                } else {
>> > -                    inner_field = field;
>> > +                    /* Read the marker instead of VMSD itself */
>> > +                    if (!vmstate_ptr_marker_load(f, &load_field, errp)) {
>> > +                        trace_vmstate_load_field_error(field->name, -EINVAL);
>> > +                        return false;
>> > +                    }
>> >                  }
>> >  
>> > -                ok = vmstate_load_field(f, curr_elem, size, inner_field, errp);
>> > -
>> > -                /* If we used a fake temp field.. free it now */
>> > -                if (inner_field != field) {
>> > -                    g_clear_pointer((gpointer *)&inner_field, g_free);
>> > +                if (load_field) {
>> > +                    ok = vmstate_load_field(f, curr_elem, size, field, errp);
>> >                  }
>> >  
>> >                  if (ok) {
>> 

