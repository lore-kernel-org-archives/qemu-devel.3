Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028BCC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 12:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2s2Z-0003zz-4u; Fri, 03 May 2024 08:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2s2Q-0003rx-QO
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:29:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2s2L-0001XZ-M8
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714739352;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Ms7KOLc610IguIGEZ+xLTOpDmJ2AzI4o1W+WTbshkBU=;
 b=WP1HR3OQ5kAOHYmYR59xlc/qPBAciiVqv+rNQN3Vr+SqLye3WwaJ8k3qAdB3J5VVH1ZSuF
 bKli1JSeHHD9qVp9FrZsB90UhCwvTdmjfa2kcJFX67qBAlJziKtL5/rrNPR14q3JiBFbFn
 J6H03ZaP+N/7u+r4l/HL9Bdi9EVH6yc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-StdHo7nIPHS0Jw2FZiu9Ag-1; Fri, 03 May 2024 08:29:11 -0400
X-MC-Unique: StdHo7nIPHS0Jw2FZiu9Ag-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B76D8032FA
 for <qemu-devel@nongnu.org>; Fri,  3 May 2024 12:29:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CDCE1C01595;
 Fri,  3 May 2024 12:29:10 +0000 (UTC)
Date: Fri, 3 May 2024 13:29:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] gitlab-ci: adjust msys2-64bit to be able to run qtest
Message-ID: <ZjTYlDXkLXNtGgGR@redhat.com>
References: <20240503121509.219567-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240503121509.219567-1-pbonzini@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, May 03, 2024 at 02:15:09PM +0200, Paolo Bonzini wrote:
> sparc-softmmu is able to run a subset of qtests when compiled --without-default-devices,
> so use it instead of x86_64-softmmu for the msys2 run.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  .gitlab-ci.d/windows.yml | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
> index 94834269ec7..d26dbdd0c0d 100644
> --- a/.gitlab-ci.d/windows.yml
> +++ b/.gitlab-ci.d/windows.yml
> @@ -24,10 +24,7 @@ msys2-64bit:
>      # changed to compile QEMU with the --without-default-devices switch
>      # for this job, because otherwise the build could not complete within
>      # the project timeout.
> -    CONFIGURE_ARGS:  --target-list=x86_64-softmmu --without-default-devices -Ddebug=false -Doptimization=0
> -    # qTests don't run successfully with "--without-default-devices",
> -    # so let's exclude the qtests from CI for now.
> -    TEST_ARGS: --no-suite qtest
> +    CONFIGURE_ARGS:  --target-list=sparc-softmmu --without-default-devices -Ddebug=false -Doptimization=0

We have compile coverage of x86_64-softmmu on the cross-win64 mingw
job. So we're not loosing any compile coverage in aggregate with
this change, in fact we improve it by compiling sparc here.

The msys2-64bit job currently takes 50mins wallclock just to compile
and run unit tests though, which is quite long already.

What's the new running time when you enable qtest too ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


