Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83384C27C79
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 16:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJya1-0006yi-Uu; Wed, 19 Jun 2024 12:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sJyZz-0006y4-Lv
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 12:54:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sJyZv-0005mN-Nb
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 12:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718816074;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=C1TTZASa76LInDEm4ejv6LNACB07vjvTiD8/3gSOzMo=;
 b=C83EDhPtUhMyw1PLWRERU35XxnbpLaYjx1A4DcP1zS+OrZ4bC+GvTGyu3gliEeH174hLXz
 0FtyyM7AzHIZwirquV+e4yaViyNqIKue1duHZ+10ckTODDVP95qiduyE0BVpOKHV7RsWtx
 j7/2GEXcD4NkSDRrIkhAxmWKZok0a20=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-9fri7DwzPGK2YRF1hf24Qg-1; Wed,
 19 Jun 2024 12:54:31 -0400
X-MC-Unique: 9fri7DwzPGK2YRF1hf24Qg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0864D195609F; Wed, 19 Jun 2024 16:54:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3FE2119560AF; Wed, 19 Jun 2024 16:54:27 +0000 (UTC)
Date: Wed, 19 Jun 2024 17:54:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v2 3/5] rust: add PL011 device model
Message-ID: <ZnMNQJ23hC2OyGtT@redhat.com>
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <0fde311846394e9f7633be5d72cc30b25587d7a1.1718101832.git.manos.pitsidianakis@linaro.org>
 <0841ddd2-d962-4f1d-a818-be9a1ec4d9bf@linaro.org>
 <1c53f8d2-3b33-404c-bb1c-38475087d7ae@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1c53f8d2-3b33-404c-bb1c-38475087d7ae@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Jun 19, 2024 at 06:43:01PM +0200, Paolo Bonzini wrote:
> On 6/19/24 07:34, Richard Henderson wrote:
> > First silly question: how much of this is boiler plate that gets moved
> > the moment that the second rust subdirectory is added?
> 
> If my suggestion at https://lore.kernel.org/qemu-devel/CABgObfaP7DRD8dbSKNmUzhZNyxeHWO0MztaW3_EFYt=vf6SbzA@mail.gmail.com/
> works, we'd have only two directories that have a Cargo.toml in it.  For
> example it could be rust/qemu/ (common code) and rust/hw/ (code that depends
> on Kconfig).
> 
> I think we can also have a rust/Cargo.toml file as in
> https://doc.rust-lang.org/cargo/reference/workspaces.html#virtual-workspace,
> and then the various configuration files under rust/ will be valid for all
> subpackages.
> 
> > > +[build]
> > > +rustflags = ["-Crelocation-model=pic", "-Ctarget-feature=+crt-static"]
> > 
> > It seems certain that this is not specific to pl011, and will be commot
> > to other rust subdirectories.  Or, given the .cargo directory name, is
> > this generated by cargo and committed by mistake?
> 
> -Crelocation-mode should be pie.  But also, I am not sure it works because I
> think it's always going to be overridden by cargo_wrapper.py? See
> https://doc.rust-lang.org/cargo/reference/config.html#buildrustflags.
> 
> (I'm not sure what +crt-static is for).
> 
> I think the generate_cfg_flags() mechanism of cargo_wrapper.py has to be
> rewritten from Python to Rust and moved to build.rs (using
> cargo::rustc-cfg).  By doing this, the cfg flags are added to whatever is in
> .cargo/config.toml, rather than replaced.
> 
> > > diff --git a/rust/pl011/.gitignore b/rust/pl011/.gitignore
> > > new file mode 100644
> > > index 0000000000..28a02c847f
> > > --- /dev/null
> > > +++ b/rust/pl011/.gitignore
> > > @@ -0,0 +1,2 @@
> > > +target
> > > +src/generated.rs.inc
> > 
> > Is this a symptom of generating files into the source directory and not
> > build directory?
> 
> If I understand correctly, Manos considered two possible ways to invoke
> cargo on the Rust code:
> 
> - directly, in which case you need to copy the generated source file to
> rust/pl011/src/generated.rs.inc, because cargo does not know where the build
> tree
> 
> - do everything through meson, which does the right thing because
> cargo_wrapper.py knows about the build tree and passes the information.
> 
> To avoid this, the first workflow could be adjusted so that cargo can still
> be invoked directly, _but from the build tree_, not the source tree.  For
> example configure could generate a .../build/.cargo/config.toml with
> 
>    [env]
>    MESON_BUILD_ROOT = ".../build"
> 
> (extra advantage: -Crelocation-model=pie can be added based on
> --enable-pie/--disable-pie).  configure can also create symlinks in the
> build tree for the source tree's rust/, Cargo.toml and Cargo.lock.
> 
> This allows rust/pl011/src/generated.rs (which probably will become
> something like rust/common/src/generated.rs) to be:
> 
>    include!(concat!(env!("MESON_BUILD_ROOT"), "/generated.rs.inc"));
> 
> when cargo is invoked from the build tree.
> 
> Putting everything together you'd have
> 
>    build/
>      rust/
>        .cargo/
>          config.toml   # generated by configure or meson.build
>        Cargo.toml      # workspace generated by configure or meson.build
>        Cargo.lock      # can be either linked to srctree or generated
>        qemu/           # symlink to srctree/rust/qemu
>        aarch64-softmmu-hw/
>          Cargo.toml    # generated by meson.build (*)
>          src/          # symlink to srctree/rust/hw/
>        i386-softmmu-hw/
>          Cargo.toml    # generated by meson.build
>          src/          # symlink to srctree/rust/hw/
>        generated/      # files generated by rust/generated/meson.build

If we're generating a build tree to invoke cargo on, can we then
avoid creating a completely separate dir hierarchy in the source
tree rooted at /rust, and just have rust source within our existing
hierarchy.

eg

        aarch64-softmmu-hw/
          Cargo.toml    # generated by meson.build (*)
          src/
            pl011/      # symlink to srctree/hw/p1011/


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


