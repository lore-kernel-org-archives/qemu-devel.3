Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95CAAD49797
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 09:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIPMS-0007bQ-G1; Tue, 03 Dec 2024 04:38:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tIPMQ-0007Za-FD
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:38:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tIPMO-0004Vb-Sx
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733218704;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ny4xWTBcN9ksCKY3sFHa4wfhsqLLtBnjJ3TxutDRXU=;
 b=L2C1G4sT01kd5upDvOmAo54MAfo8oMtpNhpRfKGfPcWBUNK3PmDK92zTnEWzSPIxlPSxiu
 PQ8tBUI07FYwOH727iyFzZhcO3estSeJrC6+/KDzxeW8wzFhuFnffMm0ELfG7YgXGrhwx7
 yVqMxmljMUeHvxapdGzG6PLG/oy0ksg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-4W2OJDnoPW6sgWszQLdNtg-1; Tue,
 03 Dec 2024 04:38:21 -0500
X-MC-Unique: 4W2OJDnoPW6sgWszQLdNtg-1
X-Mimecast-MFC-AGG-ID: 4W2OJDnoPW6sgWszQLdNtg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 001021944DD3; Tue,  3 Dec 2024 09:38:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.37])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A4731956064; Tue,  3 Dec 2024 09:38:16 +0000 (UTC)
Date: Tue, 3 Dec 2024 09:38:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 xen-devel@lists.xenproject.org, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 4/7] scripts/device-crash-test: Remove legacy '-machine
 foo,accel=bar'
Message-ID: <Z07RhQE8UOdWlzFS@redhat.com>
References: <20241203092153.60590-1-philmd@linaro.org>
 <20241203092153.60590-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241203092153.60590-5-philmd@linaro.org>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Dec 03, 2024 at 10:21:50AM +0100, Philippe Mathieu-Daudé wrote:
> Since commit 6f6e1698a68 ("vl: configure accelerators from -accel
> options") we prefer the '-accel bar' command line option.
> 
> Replace '-machine foo,accel=bar' -> '-machine foo -accel bar' in
> the device-crash-test script.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  scripts/device-crash-test | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/device-crash-test b/scripts/device-crash-test
> index da8b56edd99..2b139e29ba0 100755
> --- a/scripts/device-crash-test
> +++ b/scripts/device-crash-test
> @@ -295,7 +295,10 @@ class QemuBinaryInfo(object):
>          self._machine_info = {}
>  
>          dbg("devtype: %r", devtype)
> -        args = ['-S', '-machine', 'none,accel=kvm:tcg']
> +        args = ['-S',
> +                '-machine', 'none',
> +                '-accel', 'kvm:tcg',

-accel doesn't work this way - that is legacy syntax sugar from -machine

You need multiple args:

   -accel kvm -accel tcg

> +               ]
>          dbg("querying info for QEMU binary: %s", binary)
>          vm = QEMUMachine(binary=binary, args=args)
>          vm.launch()
> @@ -358,7 +361,9 @@ def checkOneCase(args, testcase):
>  
>      dbg("will test: %r", testcase)
>  
> -    args = ['-S', '-machine', '%s,accel=%s' % (machine, accel),
> +    args = ['-S',
> +            '-machine', machine,
> +            '-accel', accel,

I've not checked what 'accel' value is - if that's another compound
value like 'kvm:tcg', it'll need to be turned into an array, and
expanded to multiple '-accel' args.

>              '-device', qemuOptsEscape(device)]
>      cmdline = ' '.join([binary] + args)
>      dbg("will launch QEMU: %s", cmdline)
> -- 
> 2.45.2
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


