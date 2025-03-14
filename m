Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42540C35FF1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 14:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt5yu-0000cY-Nu; Fri, 14 Mar 2025 10:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tt5yn-0000bw-8u
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 10:25:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tt5yi-0006Gs-My
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 10:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741962335;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+xvRoz2JYv6R8s8B5mXelLQkaL2BQG6zzy3TgTatQCE=;
 b=XNIjmwXYO8ED2F7i0JM9oebMEq4dSrchIzoMsuLsulWAHMAFqJXB/G14TlJWWHJlPLUAl3
 n939hWiUHTinTZmpZHTyA5RoOCqzpnA/r0Eao4ONGZzcZ8bivrVw9jViKjvG2eezN6D2JL
 ha0Nc/1IflJJGkElwlO+/h+Ub2D+Pcw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-c3lkxEToNcafx4TmODGWYw-1; Fri,
 14 Mar 2025 10:25:33 -0400
X-MC-Unique: c3lkxEToNcafx4TmODGWYw-1
X-Mimecast-MFC-AGG-ID: c3lkxEToNcafx4TmODGWYw_1741962332
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C2D319560B7; Fri, 14 Mar 2025 14:25:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.99])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BBCE71954B32; Fri, 14 Mar 2025 14:25:28 +0000 (UTC)
Date: Fri, 14 Mar 2025 14:25:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Konstantin Kostiuk <kkostiuk@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yan Vugenfirer <yvugenfi@redhat.com>
Subject: Re: Cross-compilation artifact is broken
Message-ID: <Z9Q8VafDI_Ntdnu_@redhat.com>
References: <CAPMcbCquaBmWhx3jWBKMC1oLrMZBUVhfWFcW=_5uhVqOep4NWw@mail.gmail.com>
 <Z9GUldol1IQT1uiY@redhat.com> <Z9GY3l2pTkbpMV8L@redhat.com>
 <ad3cacce-cfc2-4855-b7a4-a972745508b4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad3cacce-cfc2-4855-b7a4-a972745508b4@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Mar 14, 2025 at 03:21:49PM +0100, Paolo Bonzini wrote:
> On 3/12/25 15:23, Daniel P. Berrangé wrote:
> > > > My question is, is this expected behavior or is this a bug?
> > > 
> > > Your configure args don't include "--enable-debug", so I would
> > > not have expected -gsplit-dwarf to have been enabled, so I'm
> > > surprised that commit casued a problem.
> > 
> > Hmm it appears that the meson  "get_option('debug')" is entirely
> > unconnected to QEMU's --enable-debug configure flag, which I did
> > not realize.
> 
> Indeed get_option('debug') is connected to --enable-debug-info (which is
> default-enabled).
> 
> > IOW, we've got -gsplit-dwarf enabled by default for everyone
> > building QEMU, which feels dubious. IMHO only an explicit
> > --enable-debug configure arg should have triggered it.
> 
> I didn't realize that you meant to attach it to --enable-debug.  The
> reason why meson.build checks get_option('debug') is simply because
> -gsplit-dwarf implies turning on debug info.
> 
> Maybe it could use something like
> 
> diff --git a/configure b/configure
> index 5d19d0036a1..18fd82a187e 100755
> --- a/configure
> +++ b/configure
> @@ -1873,6 +1873,10 @@ if test "$skip_meson" = no; then
>        { test "$host_os" = linux || test "$host_os" = "windows"; }; then
>        echo 'werror = true' >> $cross
>    fi
> +  if test -e "$source_path/.git" && test "$host_os" != "windows"; then
> +      echo 'split_debug = true' >> $cross
> +  fi
> +
>    echo "[project options]" >> $cross
>    if test "$SMBD" != ''; then
>      echo "smbd = $(meson_quote "$SMBD")" >> $cross
> diff --git a/meson_options.txt b/meson_options.txt
> index 809d0b42ef7..751dc39d22f 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -360,7 +360,7 @@ option('debug_mutex', type: 'boolean', value: false,
>         description: 'mutex debugging support')
>  option('debug_stack_usage', type: 'boolean', value: false,
>         description: 'measure coroutine stack usage')
> -option('split_debug', type: 'boolean', value: true,
> +option('split_debug', type: 'boolean', value: false,
>         description: 'split debug info from object files')
>  option('qom_cast_debug', type: 'boolean', value: true,
>         description: 'cast debugging support')
> 
> similar to --enable-werror... by the way I'm not sure if checking
> for .git still works - I think recent RPM creates a fake git repo
> to be able to run "git am", does it get rid of the .git directory
> before starting the build?

The .git dir will always exist in the RPM build, but generally we pass
--disable-XXX for everything and then turn back on what we want.



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


