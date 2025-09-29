Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5511BCAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 08:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v38rY-0004yo-GE; Mon, 29 Sep 2025 04:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v38rR-0004xF-21
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 04:03:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v38rG-00038q-Vz
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 04:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759133013;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fwBSLuC7VJSNEkCWiqH+5rxz7quWZ501g3zvELQnNM0=;
 b=RMOR3CO3Bs0J3xXNvMPWWXQxV7QgzEIqBCH2m8pohXeX+Jo6W5ldj3unp0oVIxH4M69tGs
 GAl6fl8Z4Dgn6QzV1Jz0Th0L4iW/77jNPjBSexk6ZW0BZjd48VWrjnpW2H0BP71tn61MtM
 F/IuD8Jtx9qpX2Sm4fYs0588pd3DAgI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-ZZEpC6a1NNmQcLRYITzQ2w-1; Mon,
 29 Sep 2025 04:03:29 -0400
X-MC-Unique: ZZEpC6a1NNmQcLRYITzQ2w-1
X-Mimecast-MFC-AGG-ID: ZZEpC6a1NNmQcLRYITzQ2w_1759133008
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B64721800447; Mon, 29 Sep 2025 08:03:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A875330001A4; Mon, 29 Sep 2025 08:03:25 +0000 (UTC)
Date: Mon, 29 Sep 2025 09:03:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, qemu-arm@nongnu.org,
 manos.pitsidianakis@linaro.org, peter.maydell@linaro.org
Subject: Re: [PATCH v4 3/9] tests/functional: Provide GDB to the functional
 tests
Message-ID: <aNo9JmdYGm0XxU-g@redhat.com>
References: <20250926051542.104432-1-gustavo.romero@linaro.org>
 <20250926051542.104432-4-gustavo.romero@linaro.org>
 <a9118adc-f9ac-4df0-8e60-4407945a5908@redhat.com>
 <bd906237-c0fb-4921-a017-a591bc95f31f@linaro.org>
 <599cd42e-0619-4556-ae70-b2d360e6405a@linaro.org>
 <acad2462-9c7a-43e9-a40c-6c3d625684c8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acad2462-9c7a-43e9-a40c-6c3d625684c8@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.539,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Sep 29, 2025 at 08:34:03AM +0200, Thomas Huth wrote:
> On 26/09/2025 20.15, Gustavo Romero wrote:
> > Hi Thomas,
> > 
> > On 9/26/25 15:08, Gustavo Romero wrote:
> > > Hi Thomas,
> > > 
> > > On 9/26/25 07:03, Thomas Huth wrote:
> > > > On 26/09/2025 07.15, Gustavo Romero wrote:
> > > > > The probe of GDB is done in 'configure' and the full path is passed to
> > > > > meson.build via the -Dgdb=option.
> > > > > 
> > > > > Because a single functional test can cover different arches, such as
> > > > > aarch64, ppc64, and x86_64, only a GDB that supports all the arches in
> > > > > the target list is passed to Meson for use in the functional tests. To
> > > > > handle this check, a new shell function, is_target_arch_in_arch_list, is
> > > > > introduced in 'configure'.
> > > > > 
> > > > > Meson then can pass the location of GDB to the test via an environment
> > > > > variable: QEMU_TEST_GDB.
> > > > > 
> > > > > Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> > > > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > > > ---
> > > > >   configure                     | 21 +++++++++++++++++++++
> > > > >   meson_options.txt             |  2 ++
> > > > >   scripts/meson-buildoptions.sh |  2 ++
> > > > >   tests/functional/meson.build  |  6 ++++++
> > > > >   4 files changed, 31 insertions(+)
> > > > > 
> > > > > diff --git a/configure b/configure
> > > > > index 0f7eb95586..20e05d233f 100755
> > > > > --- a/configure
> > > > > +++ b/configure
> > > > > @@ -1142,12 +1142,31 @@ fi
> > > > >   #########################################
> > > > >   # gdb test
> > > > > +# Check if all target arches are in a provided list of arches.
> > > > > +is_target_arch_in_arch_list() {
> > > > > +    arch_list=$1
> > > > > +    for target in $target_list; do
> > > > > +        arch=${target%%-*}
> > > > > +        if test "${arch_list#*$arch}" = "$arch_list"; then
> > > > > +            # Target arch not in arch list
> > > > > +            return 1
> > > > > +        fi
> > > > > +    done
> > > > > +    return 0
> > > > > +}
> > > > > +
> > > > >   if test -n "$gdb_bin"; then
> > > > >       gdb_version_string=$($gdb_bin --version | head -n 1)
> > > > >       # Extract last field in the version string
> > > > >       gdb_version=${gdb_version_string##* }
> > > > >       if version_ge $gdb_version 9.1; then
> > > > >           gdb_arches=$($python
> > > > > "$source_path/scripts/probe-gdb- support.py" $gdb_bin)
> > > > > +
> > > > > +    if is_target_arch_in_arch_list "$gdb_arches"; then
> > > > 
> > > > No TABs, please!
> > > > 
> > > > > +            gdb_multiarch="yes"
> > > > > +        else
> > > > > +            gdb_multiarch=""
> > > > > +    fi
> > > > 
> > > > This unfortunately does not work with the GDB from Fedora - it
> > > > only supports "arch64_be arm riscv64 riscv32 ppc i386 s390x
> > > > ppc64 aarch64 ppc64le x86_64", but if you configured a target
> > > > like "alpha-softmmu", this breaks.
> > > 
> > > argh! ok
> > > 
> > > 
> > > > (BTW, does the gdb-multiarch from Debian/Ubuntu really also
> > > > support exotic QEMU targets like tricore?)
> > > 
> > > No, I've checked GDB upstream and I can't see any trace of tricore.
> > > And I just saw that Alex left a comment in scripts/probe-gdb-support.py
> > > saying "# no tricore in upstream gdb", so nope, it seems that it still holds.
> > > 
> > > 
> > > > I think it would be better to drop this hunk, and rather check
> > > > in the spot where we use GDB if the required target is really
> > > > there (i.e. in the functional test that uses it).
> > > 
> > > OK. I'm also not a big fan of doing it in bash. How do you suggest
> > > to do it? Directly in the code, via a skipIf decorator, or something else?
> > 
> > $gdb_arches, obtained using scripts/probe-gdb-support.py in configure,
> > could be passed to meson and meson sets it in the test env, as we're
> > doing for $gdb_bin and QEMU_TEST_GDB env var. wdyt?
> 
> That might be a possibility, though it's getting a little bit clunky if you
> want to run the test manually, without the meson test runner.
> 
> Maybe it would be nicer to just start gdb in the test and catch the error
> (and skip the test in that case) in the python test code if it fails to set
> the target architecture there?

If you run 'set architecture' with no arguments, it'll return a long list
of supported targets we can match on.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


