Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9C0C83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 13:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uclWI-0001Fj-Bf; Fri, 18 Jul 2025 09:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uclS6-0005Qs-SX
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 09:48:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uclS4-0007pa-VQ
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 09:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752846519;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r1/Tl6PGKJ8ohQdM7yFmIJObbKa7UnBHPnNAfVDUhKQ=;
 b=jGm9TSWsHDPNkfiIH+kSzLlJAys+8Hha4WOXhutPUXCmS4QN7stxczoNwnISNyo3K89MnB
 gdiAjcFHSFO3GodTr/8LhkhXYVfIcUkIRMDLylvhx7PHvrtdCwyZLwtVVfMB5I0EKs6E7n
 P01Ke/sSmWc9LNKq9upkeJL7relhGi4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-386-r4ARqO6WM-Woo_kVxU_GAg-1; Fri,
 18 Jul 2025 09:41:30 -0400
X-MC-Unique: r4ARqO6WM-Woo_kVxU_GAg-1
X-Mimecast-MFC-AGG-ID: r4ARqO6WM-Woo_kVxU_GAg_1752846089
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6CF1E18004A7; Fri, 18 Jul 2025 13:41:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.137])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69774180170E; Fri, 18 Jul 2025 13:41:27 +0000 (UTC)
Date: Fri, 18 Jul 2025 14:41:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] net/passt: Fix build failure due to missing GIO dependency
Message-ID: <aHpPBCiuUBJxqHyx@redhat.com>
References: <20250718133110.1510978-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250718133110.1510978-1-lvivier@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jul 18, 2025 at 03:31:10PM +0200, Laurent Vivier wrote:
> The passt networking backend uses functions from the GIO library,
> such as g_subprocess_launcher_new(), to manage its daemon process.
> So, building with passt enabled requires GIO to be available.
> 
> If we enable passt and disable gio the build fails during linkage with
> undefined reference errors:
> 
>   /usr/bin/ld: libsystem.a.p/net_passt.c.o: in function `net_passt_start_daemon':
>   net/passt.c:250: undefined reference to `g_subprocess_launcher_new'
>   /usr/bin/ld: net/passt.c:251: undefined reference to `g_subprocess_launcher_take_fd'
>   /usr/bin/ld: net/passt.c:253: undefined reference to `g_subprocess_launcher_spawnv'
>   /usr/bin/ld: net/passt.c:256: undefined reference to `g_object_unref'
>   /usr/bin/ld: net/passt.c:263: undefined reference to `g_subprocess_wait'
>   /usr/bin/ld: net/passt.c:268: undefined reference to `g_subprocess_get_if_exited'
>   /usr/bin/ld: libsystem.a.p/net_passt.c.o: in function `glib_autoptr_clear_GSubprocess':
>   /usr/include/glib-2.0/gio/gio-autocleanups.h:132: undefined reference to `g_object_unref'
>   /usr/bin/ld: libsystem.a.p/net_passt.c.o: in function `net_passt_start_daemon':
>   net/passt.c:269: undefined reference to `g_subprocess_get_exit_status'
> 
> Fix this by adding an explicit weson dependency on GIO for the passt
> option.
> The existing dependency on linux is kept because passt is only available
> on this OS.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  meson.build | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


