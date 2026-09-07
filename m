Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67276C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Wu1-0005wA-FV; Mon, 07 Sep 2026 06:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x3Wu0-0005vn-Eq
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:48:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x3Wtx-0007U5-S6
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788778116;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=voO72DVQBKGRJBJ5zS5+DP6mGUc7H80SfaLOP8+tFPc=;
 b=PAswB445SCvXiQKDq/UUAVA2z67s/tl4DIpyCMgCz2qYQTp1IIRwuR2oj0hr3JlkFtJlpx
 s6aMTWIHXvbUOOJOo5P9dPE+bE/78LWWKY8oYBUfGcRgoe/ZHzQCwqf60+snT1mWO0wC0p
 vPcHrl+qRdighnxA4NCzOkxiDzEVcZY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-CCmudLdUMmyxjgr80XdJGg-1; Mon,
 07 Sep 2026 06:48:31 -0400
X-MC-Unique: CCmudLdUMmyxjgr80XdJGg-1
X-Mimecast-MFC-AGG-ID: CCmudLdUMmyxjgr80XdJGg_1788778110
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99BF71954AC8; Mon,  7 Sep 2026 10:48:29 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 036A2180034F; Mon,  7 Sep 2026 10:48:27 +0000 (UTC)
Date: Mon, 7 Sep 2026 11:48:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PULL v2 12/13] configure: correctly honour --disable-containers
Message-ID: <ap6WeRef7qEAyR8Q@redhat.com>
References: <20260904160643.353833-1-berrange@redhat.com>
 <20260904160643.353833-13-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260904160643.353833-13-berrange@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

I'm dropping this patch from the PULL refresh, since Pierrick's
merged patches remove the container engine probing from configure,
so the bug this fixed appears to not exist any more.

On Fri, Sep 04, 2026 at 05:06:42PM +0100, Daniel P. Berrangé wrote:
> The configure script originally only probed for 'runc' command
> in order to handle cross-compilation containers. The Makefile
> under tests/docker would then probe again when used.
> 
> In order to eliminate the additional probeing, we changed
> configure in commit c4ce04cfb7460d46c0262d437a7f35bb5c5fc449
> to always probe for 'runc', so the result could be passed
> along to tests/docker make rules.
> 
> That commit overlooked that the 'probe_target_compiler' func
> was relying on '$runc' == 'no' as a proxy for the state of
> the --disable-containers arg.
> 
> When we started unconditionally probing, that short cut no
> longer works and we must explicitly check "$use_containers"
> too.
> 
> Fixes: c4ce04cfb7460d46c0262d437a7f35bb5c5fc449
> Reported-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Tested-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  configure | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configure b/configure
> index 46cbcc085b..d3ad7d4062 100755
> --- a/configure
> +++ b/configure
> @@ -1414,6 +1414,7 @@ probe_target_compiler() {
>    esac
>  
>    for host in $container_hosts; do
> +    test "$use_containers" = "yes" || continue
>      test "$container_command" != "" || continue
>      test "$host" = "$cpu" || continue
>      case $target_arch in
> -- 
> 2.55.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


