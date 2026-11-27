Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1259A606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P+1RbDIn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWsD5-0000dX-Qp; Fri, 27 Nov 2026 04:25:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xWsD4-0000dA-CN
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 04:25:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xWsD2-0007JX-Pd
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 04:25:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795771535;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i2BHtfgMHDABqTnZG/3Iw38zuQscd04Da+dl4Rvlqqo=;
 b=P+1RbDIn06Q9EQqbS2QgryI2ryHoxQsyL2cqOBYOoP38ur0bSgr/n+z1vh1uOn5djyyvLz
 0JJfNTXAWpFyMojrwiZrPW4rt52W5+t3Cx/jKArg6xyYENkCz7fsEOYADiqnHw0wITZtED
 0TtYZL6HzeCbKibC2Fx/fvVRSCOxKv0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-8fIY5By0OTehfQq1fl8V6Q-1; Fri,
 27 Nov 2026 09:25:32 +0000
X-MC-Unique: 8fIY5By0OTehfQq1fl8V6Q-1
X-Mimecast-MFC-AGG-ID: 8fIY5By0OTehfQq1fl8V6Q_1795771531
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EFC61956088; Fri, 27 Nov 2026 09:25:31 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D9F718004F5; Fri, 27 Nov 2026 09:25:29 +0000 (UTC)
Date: Fri, 27 Nov 2026 09:25:26 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: Re: [PATCH] util/oslib-posix: Have qemu_get_thread_id return the
 thread id on macOS
Message-ID: <awlMhnDkT04Z-AeM@redhat.com>
References: <20261126220001.58932-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261126220001.58932-1-philmd@oss.qualcomm.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 26, 2026 at 11:00:01PM +0100, Philippe Mathieu-Daudé wrote:
> qemu_get_thread_id() fell back to getpid() on macOS, so
> every thread, including each vCPU reported by query-cpus-fast,
> shared the process id. Use pthread_threadid_np(), keeping the
> value positive.
> 
> For example running '-M virt -smp 2 -accel tcg,thread=multi',
> QMP 'query-cpus-fast' returned before:
> 
>   {"return": [{"thread-id": 58412, "cpu-index": 0, ...},
>               {"thread-id": 58412, "cpu-index": 1, ...}]}
> 
> and now:
> 
>   {"return": [{"thread-id": 75188616, "cpu-index": 0, ...},
>               {"thread-id": 75188617, "cpu-index": 1, ...}]}
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  util/oslib-posix.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index dc001da66dd4..71fd369e42f1 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -107,6 +107,10 @@ int qemu_get_thread_id(void)
>      return _lwp_self();
>  #elif defined(__OpenBSD__)
>      return getthrid();
> +#elif defined(__APPLE__)
> +    uint64_t tid;
> +    pthread_threadid_np(NULL, &tid);
> +    return tid & INT_MAX;
>  #else

I wonder how likely it is that a thread ID would exceed 'int' ?
IOW, do  we need to consider changing return type to uint64_t

>      return getpid();

Separately, it is probably worth also adding

   warn_report_once("No qemu_get_thread_id() impl on this platform")

so that we nag people to fix remaining platform gaps they
might care about.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


