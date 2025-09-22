Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 729FCCAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 10:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0dye-0002D2-3l; Mon, 22 Sep 2025 06:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0dyY-0002Ce-Hm
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 06:40:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0dyU-0005Nq-5d
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 06:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758537645;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y0AZWxyfSdZzqywxsR3keG7CQjdhGKWL77UGnfcgHsY=;
 b=Sp7xmx9RalLFBNpZOHZbRwjW9xNu3xJiMiT4x/DOfM4+LelCF4YRbuJTTSK4/VRi/LXs5C
 DP5iy5PsyZ/dmPnOFSQ+/iG7XV7H3T6HMVqOEmmppwp97YNuWGwX7zzYVagBZTdGJ7tve3
 2HCX2ph40muALJX50G1E89W/MtcGPhM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-jMDdSjkoO6ma_Z7oGZSC7A-1; Mon,
 22 Sep 2025 06:40:42 -0400
X-MC-Unique: jMDdSjkoO6ma_Z7oGZSC7A-1
X-Mimecast-MFC-AGG-ID: jMDdSjkoO6ma_Z7oGZSC7A_1758537640
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 504FB19560B6; Mon, 22 Sep 2025 10:40:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E63FA3000198; Mon, 22 Sep 2025 10:40:35 +0000 (UTC)
Date: Mon, 22 Sep 2025 11:40:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Warner Losh <imp@bsdimp.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Kyle Evans <kevans@freebsd.org>
Subject: Re: [PATCH 19/24] configure: set the meson executable suffix/ext
Message-ID: <aNEnnyvfqHgF4rq1@redhat.com>
References: <20250919133320.240145-1-marcandre.lureau@redhat.com>
 <20250919133320.240145-20-marcandre.lureau@redhat.com>
 <aM1rj-5Rja1CXqy0@redhat.com>
 <CAMxuvay3zOzcRZBDseDw4UwqTRC5k1Qk1cRomGvVRzR2jV8U3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvay3zOzcRZBDseDw4UwqTRC5k1Qk1cRomGvVRzR2jV8U3w@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Sep 22, 2025 at 02:34:25PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Fri, Sep 19, 2025 at 6:41 PM Daniel P. Berrangé <berrange@redhat.com>
> wrote:
> 
> > On Fri, Sep 19, 2025 at 05:33:13PM +0400, marcandre.lureau@redhat.com
> > wrote:
> > > From: Marc-André Lureau <marcandre.lureau@redhat.com>
> >
> >
> > Please actually the reason why the change is needed. The code
> > change seems related to msys2 / Windows, but our CI is already
> > covering this and so what's broken ?
> >
> 
> It doesn't cover --enable-rust yet:
> 
> ../rust/meson.build:41:2: ERROR: Program
> '/c/Users/User/qemu/build/pyvenv/bin/meson' not found or not executable

So it is is called meson.exe on Windows, even though it is a
script, not an executable ?

Can you put all this info in the commit message.

> 
> 
> >
> >
> > > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  configure | 14 +++++++++++++-
> > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/configure b/configure
> > > index 8d84e3c5c0..7b1795ab29 100755
> > > --- a/configure
> > > +++ b/configure
> > > @@ -1000,7 +1000,19 @@ $mkvenv ensuregroup --dir
> > "${source_path}/python/wheels" \
> > >  # We ignore PATH completely here: we want to use the venv's Meson
> > >  # *exclusively*.
> > >
> > > -meson="$(cd pyvenv/bin; pwd)/meson"
> > > +# for msys2
> > > +get_pwd() {
> > > +    if pwd -W >/dev/null 2>&1; then
> > > +        pwd -W
> > > +    else
> > > +        pwd
> > > +    fi
> > > +}
> > > +
> > > +meson="$(cd pyvenv/bin; get_pwd)/meson"
> > > +if [ -f "$meson$EXESUF" ]; then
> > > +  meson="$meson$EXESUF"
> > > +fi
> > >
> > >  # Conditionally ensure Sphinx is installed.
> > >
> > > --
> > > 2.51.0
> > >
> >
> > With regards,
> > Daniel
> > --
> > |: https://berrange.com      -o-
> > https://www.flickr.com/photos/dberrange :|
> > |: https://libvirt.org         -o-
> > https://fstop138.berrange.com :|
> > |: https://entangle-photo.org    -o-
> > https://www.instagram.com/dberrange :|
> >
> >

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


