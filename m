Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94333CD5BC5
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 11:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJVcE-0002a9-Jc; Thu, 13 Nov 2025 06:35:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vJVbz-0002Wa-B8
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 06:35:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vJVbx-0007tm-Ip
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 06:35:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763033732;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pdv9t1hgezQbjJOwln6Vfm752vqT4y2n6Ad6ZvoHRHg=;
 b=P/0YROB/By7LpLQxkTgc1xs7qslkvw3+JFVtEKWduSCY08a+nZWTbttkkfVdYqSA8HKg7s
 fQe8X3Mwv97lcx/EZCSvHe4M692MNhTc85Yq7mzbVfHiQ7Xjuwbc7dpThRDCDd0Na5PScN
 kLEpKAZ3QEuMahtVzEZkR2zQz5vVoFk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-KWTuhIsOONOgpg56p26tlw-1; Thu,
 13 Nov 2025 06:35:31 -0500
X-MC-Unique: KWTuhIsOONOgpg56p26tlw-1
X-Mimecast-MFC-AGG-ID: KWTuhIsOONOgpg56p26tlw_1763033730
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 23149180047F; Thu, 13 Nov 2025 11:35:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C473F300018D; Thu, 13 Nov 2025 11:35:27 +0000 (UTC)
Date: Thu, 13 Nov 2025 11:35:22 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org, philmd@linaro.org
Subject: Re: [PATCH v3] tests/unit: add unit test for qemu_hexdump()
Message-ID: <aRXCes0Y2xMPYfS2@redhat.com>
References: <20251113064935.342018-1-vsementsov@yandex-team.ru>
 <aRWgdCWsEr3cCSNl@redhat.com>
 <84b8a084-d8f3-4515-a6f8-23aaca080b37@yandex-team.ru>
 <aRWz63pC5fsdYRsq@redhat.com>
 <CAFEAcA8433bHWqbb0cC2myY=7NKqPb1M3r+y3_mXH=QQuCoYJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA8433bHWqbb0cC2myY=7NKqPb1M3r+y3_mXH=QQuCoYJQ@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Nov 13, 2025 at 10:46:42AM +0000, Peter Maydell wrote:
> On Thu, 13 Nov 2025 at 10:33, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Thu, Nov 13, 2025 at 01:20:15PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > On 13.11.25 12:10, Daniel P. Berrangé wrote:
> > > > On Thu, Nov 13, 2025 at 09:49:35AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > > Test, that fix in previous commit make sense.
> > > > >
> > > > > To not break compilation when we build without
> > > > > 'block', move hexdump.c out of "if have_block"
> > > > > in meson.build.
> > > > >
> > > > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > > > > ---
> > > > >
> > > > > v3: change meson.build to compile hexdump.c always
> > > > >
> > > > >   tests/unit/test-cutils.c | 43 ++++++++++++++++++++++++++++++++++++++++
> > > > >   util/meson.build         |  2 +-
> > > > >   2 files changed, 44 insertions(+), 1 deletion(-)
> > > >
> > > > > +static void test_qemu_hexdump_alignment(void)
> > > > > +{
> > > > > +    /*
> > > > > +     * Test that ASCII part is properly aligned for incomplete lines.
> > > > > +     * This test catches the bug that was fixed in previous commit
> > > > > +     * "util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic".
> > > > > +     *
> > > > > +     * We use data that is not aligned to 16 bytes, so last line
> > > > > +     * is incomplete.
> > > > > +     */
> > > > > +    const uint8_t data[] = {
> > > > > +        /* First line: 16 bytes */
> > > > > +        0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f,  /* "Hello Wo" */
> > > > > +        0x72, 0x6c, 0x64, 0x21, 0x20, 0x54, 0x68, 0x69,  /* "rld! Thi" */
> > > > > +        /* Second line: 5 bytes (incomplete) */
> > > > > +        0x73, 0x20, 0x69, 0x73, 0x20                     /* "s is " */
> > > > > +    };
> > > > > +    char *output = NULL;
> > > >
> > > > Could be  g_autofree, and avoid the later 'free()' call.
> > >
> > > I'm not sure that it's correct to replace free() by g_free()..
> > >
> > > Documentation says "bad things can happen" https://docs.gtk.org/glib/memory.html
> >
> > Note where it says:
> >
> >   "Since GLib 2.46, g_malloc() is hardcoded to always use the system
> >    malloc implementation."
> >
> > I added that guarantee to glib docs specifically so apps no longer
> > have to match free with g_free.  You should still not mix up the
> > C free vs C++ delete, or  free vs g_slice_free, but that's not an
> > issue for QEMU.
> 
> I think for this specific case (the buffer allocated by
> open_memstream()) it's probably better to use explicit
> free(), because the criterion for "when is it OK to free
> this?" is not "when the pointer goes out of scope" but
> "when we have called fclose() on the stream". Auto-freeing
> the buffer by returning without closing the file would
> be a bug.

Oh good point, lets just leave this as-is.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


