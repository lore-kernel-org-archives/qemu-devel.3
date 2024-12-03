Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A55D7833F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 09:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIPc0-0005Q8-97; Tue, 03 Dec 2024 04:54:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tIPby-0005Pr-Cz
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:54:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tIPbw-0006QZ-Rw
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:54:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733219667;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l3VcSU2FOCO6z2TK0iPyybiLDyV7PIhM+xSHQeNdxLM=;
 b=Kfp5pq/z9Und/9eafakMYKJVASJ+fPNjrrVG40srUvIQu3atY6J96teyAX1Dx68LfD9DpT
 ykSHo6VdtPKcWSLwdvfEB4wr3Xp6VAmPhSBGB5AzFDog59N+RADYBln9P6TlDqG3Jha48c
 BxOHw1mHJOFydiIqpw6B5UaRkcKXRFc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-YxXr4IOQPeeG_3ecYmygPg-1; Tue,
 03 Dec 2024 04:54:22 -0500
X-MC-Unique: YxXr4IOQPeeG_3ecYmygPg-1
X-Mimecast-MFC-AGG-ID: YxXr4IOQPeeG_3ecYmygPg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95DD5195608A; Tue,  3 Dec 2024 09:54:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.37])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39021195608A; Tue,  3 Dec 2024 09:54:18 +0000 (UTC)
Date: Tue, 3 Dec 2024 09:54:15 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 xen-devel@lists.xenproject.org, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 7/7] qemu-options: Remove mentions of legacy '-machine
 foo,accel=bar'
Message-ID: <Z07VR-YvVCxdTua_@redhat.com>
References: <20241203092153.60590-1-philmd@linaro.org>
 <20241203092153.60590-8-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241203092153.60590-8-philmd@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Tue, Dec 03, 2024 at 10:21:53AM +0100, Philippe Mathieu-Daudé wrote:
> Since commit 6f6e1698a68 ("vl: configure accelerators from -accel
> options") we prefer the '-accel bar' command line option.
> 
> The new form started to be documented in commit 8d4e9146b35 ("tcg:
> add options for enabling MTTCG"); it is safe to remove the mentions
> of the legacy option.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  qemu-options.hx | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index dacc9790a4b..11f0aab1470 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -27,8 +27,6 @@ ERST
>  DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>      "-machine [type=]name[,prop[=value][,...]]\n"
>      "                selects emulated machine ('-machine help' for list)\n"
> -    "                property accel=accel1[:accel2[:...]] selects accelerator\n"
> -    "                supported accelerators are kvm, xen, hvf, nvmm, whpx or tcg (default: tcg)\n"
>      "                vmport=on|off|auto controls emulation of vmport (default: auto)\n"
>      "                dump-guest-core=on|off include guest memory in a core dump (default=on)\n"
>      "                mem-merge=on|off controls memory merge support (default: on)\n"
> @@ -59,13 +57,6 @@ SRST
>  
>      Supported machine properties are:
>  
> -    ``accel=accels1[:accels2[:...]]``
> -        This is used to enable an accelerator. Depending on the target
> -        architecture, kvm, xen, hvf, nvmm, whpx or tcg can be available.
> -        By default, tcg is used. If there is more than one accelerator
> -        specified, the next one is used if the previous one fails to
> -        initialize.
> -

I'm not convinced we should be removing documentation for options that
currently exist and remain supported.

The documentation should be updated to say that we prefer use of '-accel'
instead at least.

Beyond that, what is our long term intention with '-machine accel=xxx' ?

Is this a case where we are happy to leave '-machine accel=' as syntax
sugar forever ?  Or is this a case where we want to deprecate it and
eventually remove its impl (and thus the documention here)

>      ``vmport=on|off|auto``
>          Enables emulation of VMWare IO port, for vmmouse etc. auto says
>          to select the value based on accel and i8042. For accel=xen or
> -- 
> 2.45.2
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


