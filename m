Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809D3C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 09:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUkiC-0005E0-3Y; Tue, 30 Jan 2024 04:47:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rUki5-00055V-I0
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 04:47:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rUki1-0000T4-CT
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 04:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706608031;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MhTHN8PYFAsb3npHnfohYhyC+U4Wx4SfRG1S/v7Lxgw=;
 b=Fn0Acj69j5zsP8pGqaGkHVyvaJwhX2x5yQfNXo4JC3Wwuvr+JC6I0Z1OtVkJ1HoS8c/vmO
 A197XkGC2ww9AyPkR4GbGToi+G9BcjnjWtb77a6oVT2p0X4gJTfoE+A0da2rHBSpPDb+1x
 amr5YaWKoMZQsdYgs0SGWor1qhEY0jg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-QrnuFLb0NE6kM7KYVgR1Nw-1; Tue,
 30 Jan 2024 04:47:08 -0500
X-MC-Unique: QrnuFLb0NE6kM7KYVgR1Nw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F17AA3C2E0AB;
 Tue, 30 Jan 2024 09:47:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 020331121306;
 Tue, 30 Jan 2024 09:47:06 +0000 (UTC)
Date: Tue, 30 Jan 2024 09:47:05 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v1] scripts/checkpatch.pl: check for placeholders in
 cover letter patches
Message-ID: <ZbjFmQNrq3zVb5l6@redhat.com>
References: <20240130075615.181040-1-manos.pitsidianakis@linaro.org>
 <ZbivaYQ1rC6AgHbU@redhat.com>
 <CAAjaMXaxqEGDY3RwSPns-Rr67-RV-9CL35XkKMyEhrryYAqsfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAjaMXaxqEGDY3RwSPns-Rr67-RV-9CL35XkKMyEhrryYAqsfQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jan 30, 2024 at 10:51:58AM +0200, Manos Pitsidianakis wrote:
> On Tue, 30 Jan 2024 at 10:12, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Tue, Jan 30, 2024 at 09:56:15AM +0200, Manos Pitsidianakis wrote:
> > > Check if a file argument is a cover letter patch produced by
> > > git-format-patch --cover-letter; It is initialized with subject suffix "
> > > *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***". If they
> > > exist, warn the user.
> > >
> > > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > > ---
> > >  scripts/checkpatch.pl | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > index 7026895074..34f12c9848 100755
> > > --- a/scripts/checkpatch.pl
> > > +++ b/scripts/checkpatch.pl
> > > @@ -1650,6 +1650,20 @@ sub process {
> > >                       $non_utf8_charset = 1;
> > >               }
> > >
> > > +# Check if this is a cover letter patch produced by git-format-patch
> > > +# --cover-letter; It is initialized with subject suffix
> > > +# " *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***"
> > > +             if ($in_header_lines &&
> > > +                 $rawline =~ /^Subject:.+[*]{3} SUBJECT HERE [*]{3}\s*$/) {
> > > +        WARN("Patch appears to be a cover letter with uninitialized subject" .
> > > +             " '*** SUBJECT HERE ***'\n$hereline\n");
> > > +             }
> > > +
> > > +             if ($rawline =~ /^[*]{3} BLURB HERE [*]{3}\s*$/) {
> > > +        WARN("Patch appears to be a cover letter with leftover placeholder " .
> > > +             "text '*** BLURB HERE ***'\n$hereline\n");
> > > +             }
> >
> > Indentation here is totally off
> 
> It only seems that way because the pre-existing lines use tabs, while
> I used spaces, according to the QEMU Coding style:

It is more important to be consistent within a single function.

Regardless of that though, the indent is still broken because the body
of the 'if' condition is indented /less/ than the 'if' condition itself.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


