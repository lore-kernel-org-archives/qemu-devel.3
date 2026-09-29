Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F930CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBTK6-0004pK-GE; Tue, 29 Sep 2026 04:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xBTK2-0004p1-Ec
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 04:36:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xBTK0-00037l-Nz
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 04:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790670979;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Gqtm7pvbDR3DVMm/3I6umfW4M8cg0QpNFmxo5XNE9aI=;
 b=e30JTo1BRkp49JqhySSg5zwChmMTxhTpBEoH27FHgC8HSjTpXC4GOaob/TqUtuAabzxaRm
 R/2vg1s83uvf7ZH/sC/Yqw0Q/IhGunzPXxFMNZKpypCEtH7BLqfq4iY0lfoiAl5W78H7z9
 lZtsG+mQrhN5RtMyFbLR1GrcbDWtR/0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-IJcVtuU_MD299Kt-8e9n8Q-1; Tue,
 29 Sep 2026 04:36:18 -0400
X-MC-Unique: IJcVtuU_MD299Kt-8e9n8Q-1
X-Mimecast-MFC-AGG-ID: IJcVtuU_MD299Kt-8e9n8Q_1790670977
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 192CC1955DB5; Tue, 29 Sep 2026 08:36:17 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECB101956045; Tue, 29 Sep 2026 08:36:15 +0000 (UTC)
Date: Tue, 29 Sep 2026 09:36:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roman Bogorodskiy <bogorodskiy@gmail.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: Re: [PATCH] tests/unit/test-qga: enable on FreeBSD
Message-ID: <art4ffKuuVaqF-jC@redhat.com>
References: <20260916165620.56264-1-bogorodskiy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916165620.56264-1-bogorodskiy@gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Sep 16, 2026 at 06:56:20PM +0200, Roman Bogorodskiy wrote:
> FreeBSD has all necessary commands implemented,
> so enable test-qga for it.
> 
> Requires only minimal portability fixes for sockets
> in connect_qga().
> 
> Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> ---
>  tests/unit/meson.build | 2 +-
>  tests/unit/test-qga.c  | 6 +++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/unit/meson.build b/tests/unit/meson.build
> index e47bc7225a..0ca0d8974e 100644
> --- a/tests/unit/meson.build
> +++ b/tests/unit/meson.build
> @@ -169,7 +169,7 @@ if have_system
>    tests += {'test-qdev': [qom, hwcore]}
>  endif
>  
> -if have_ga and host_os == 'linux'
> +if have_ga and host_os in ['freebsd', 'linux']
>    tests += {'test-qga': ['../qtest/libqmp.c', '../qtest/libqtest.c']}
>    test_deps += {'test-qga': qga}
>  endif
> diff --git a/tests/unit/test-qga.c b/tests/unit/test-qga.c
> index 01ccf826e6..dbedfe3d5f 100644
> --- a/tests/unit/test-qga.c
> +++ b/tests/unit/test-qga.c
> @@ -18,7 +18,7 @@ typedef struct {
>  static int connect_qga(char *path)
>  {
>      int s, ret, len, i = 0;
> -    struct sockaddr_un remote;
> +    struct sockaddr_un remote = { 0 };
>  
>      s = socket(AF_UNIX, SOCK_STREAM, 0);
>      g_assert(s != -1);
> @@ -26,7 +26,11 @@ static int connect_qga(char *path)
>      remote.sun_family = AF_UNIX;
>      do {
>          strcpy(remote.sun_path, path);
> +#ifdef SUN_LEN
> +        len = SUN_LEN(&remote);
> +#else
>          len = strlen(remote.sun_path) + sizeof(remote.sun_family);
> +#endif

This conditional shouldn't be needed, as this ought to be written
as

    len = sizeof(remote)

given that sun_path is NUL terminate, there's no reason to try
to calculate a shorter size, only paths in the abstract namespace
need special length handling.

>          ret = connect(s, (struct sockaddr *)&remote, len);
>          if (ret == -1) {
>              g_usleep(G_USEC_PER_SEC);
> -- 
> 2.55.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


