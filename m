Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02842C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 08:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA45R-0002cA-Ib; Thu, 23 May 2024 04:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sA45P-0002T2-KZ
 for qemu-devel@nongnu.org; Thu, 23 May 2024 04:46:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sA45M-0006iW-CY
 for qemu-devel@nongnu.org; Thu, 23 May 2024 04:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716453963;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=nCtRWTjpdTJQOeuPtzDQ4Ky+FaIK+pLQfeEkTMOw9Vg=;
 b=EF1OtgpwDhi2P1z4+irqCXqPz/alcflRsJxVCyzJPiqimgPFosNRapch4yjeY1tTNoHl2U
 WJpDJch9eUfa03WrGCwEBrSXA37IJzxlYw4cy9uSke/OIyGJm1Xd+LTnUoTHhDYdJISDWa
 VtEeSi1ML+mbJsO/+rYmQ5EgDpb04HY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-1DJjOnfMNheNMERJS0RfbQ-1; Thu,
 23 May 2024 04:45:59 -0400
X-MC-Unique: 1DJjOnfMNheNMERJS0RfbQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A73833C000A8;
 Thu, 23 May 2024 08:45:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9422CC15BED;
 Thu, 23 May 2024 08:45:58 +0000 (UTC)
Date: Thu, 23 May 2024 09:45:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Artyom Kunakovsky <artyomkunakovsky@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] meson.build: add -mcx16 flag for x86_64 host
Message-ID: <Zk8CQ0uORPtlJI8v@redhat.com>
References: <20240523051118.29367-1-artyomkunakovsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523051118.29367-1-artyomkunakovsky@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, May 23, 2024 at 08:11:18AM +0300, Artyom Kunakovsky wrote:
> Fix linker error if the project was configured by the './configure --cpu=unknown --target-list=riscv64-softmmu' command

As with v1, why are you intentionally passing a bogus CPU target
name to the --cpu arg ?  QEMU already correctly sets '-mcx16' if
you omit --cpu, or pass a correct "x86_64" target name to --cpu.


> 
> Signed-off-by: Artyom Kunakovsky <artyomkunakovsky@gmail.com>
> ---
>  meson.build | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index a9de71d450..e68fbfc662 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -336,6 +336,12 @@ if host_arch == 'i386' and not cc.links('''
>    qemu_common_flags = ['-march=i486'] + qemu_common_flags
>  endif
>  
> +
> +if host_arch == 'x86_64'
> +  qemu_common_flags = ['-mcx16'] + qemu_common_flags
> +endif
> +
> +
>  if get_option('prefer_static')
>    qemu_ldflags += get_option('b_pie') ? '-static-pie' : '-static'
>  endif
> -- 
> 2.25.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


