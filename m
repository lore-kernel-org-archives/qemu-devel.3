Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDDDCAC58D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 12:00:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwfxi-0003mP-Or; Thu, 11 Sep 2025 07:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1uwfxd-0003cu-At
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 07:59:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1uwfxV-0006UA-Rl
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 07:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757591958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3CJWvgw8jXTso7Qw4D/rZViKGHWxwqyUWpC+jQEMaoA=;
 b=Nd8Xj3+3h5vE4f7KB1sKVilTxXww9o6atbdw9Op36ot/GTYn2v/ZJA7dBWQGUJKR6tIO+e
 v7uk7ABVWfJsW0X43GXihNeBAj4msNonRbNX3gb4e7K2O8OrfHK+dHu2PvUEA3s8/s+efv
 R3KiTe/o2v0QH6dlYh9HZq4YZZr6bWU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-vXZ0MX_fN1O5alAnTa3gRA-1; Thu,
 11 Sep 2025 07:59:16 -0400
X-MC-Unique: vXZ0MX_fN1O5alAnTa3gRA-1
X-Mimecast-MFC-AGG-ID: vXZ0MX_fN1O5alAnTa3gRA_1757591955
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB6EE195395B; Thu, 11 Sep 2025 11:59:14 +0000 (UTC)
Received: from fedora (unknown [10.44.33.231])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9F6119560BB; Thu, 11 Sep 2025 11:59:08 +0000 (UTC)
Date: Thu, 11 Sep 2025 13:59:04 +0200
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>, qemu-block@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 03/14] system: unconditionally enable thread naming
Message-ID: <aMK5iGPz5rSV7WC8@fedora>
References: <20250829180354.2922145-1-berrange@redhat.com>
 <20250829180354.2922145-4-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5c2FoizNjCBL97Wh"
Content-Disposition: inline
In-Reply-To: <20250829180354.2922145-4-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jtomko@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--5c2FoizNjCBL97Wh
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On a Friday in 2025, Daniel P. Berrang=E9 wrote:
>When thread naming was introduced years ago, it was disabled by
>default and put behind a command line flag:
>
>  commit 8f480de0c91a18d550721f8d9af969ebfbda0793
>  Author: Dr. David Alan Gilbert <dgilbert@redhat.com>
>  Date:   Thu Jan 30 10:20:31 2014 +0000
>
>    Add 'debug-threads' suboption to --name
>
>This was done based on a concern that something might depend
>on the historical thread naming. Thread names, however, were
>never promised to be part of QEMU's public API. The defaults
>will vary across platforms, so no assumptions should ever be
>made about naming.
>
>An opt-in behaviour is also unfortunately incompatible with
>RCU which creates its thread from an constructor function
>which is run before command line args are parsed. Thus the
>RCU thread lacks any name.
>
>libvirt has unconditionally enabled debug-threads=3Dyes on all
>VMs it creates for 10 years. Interestingly this DID expose a
>bug in libvirt, as it parsed /proc/$PID/stat and could not
>cope with a space in the thread name. This was a latent
>pre-existing bug in libvirt though, and not a part of QEMU's
>API.
>
>Having thread names always available, will allow thread names
>to be included in error reports and log messags QEMU prints
>by default, which will improve ability to triage QEMU bugs.
>
>Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
>Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
>---
> docs/about/deprecated.rst |  7 +++++++
> include/qemu/thread.h     |  1 -
> system/vl.c               | 11 ++++++-----
> util/qemu-thread-posix.c  | 18 +-----------------
> util/qemu-thread-win32.c  | 27 ++++++---------------------
> 5 files changed, 20 insertions(+), 44 deletions(-)
>
>diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>index d50645a071..bd6f865558 100644
>--- a/docs/about/deprecated.rst
>+++ b/docs/about/deprecated.rst
>@@ -81,6 +81,13 @@ kernel since 2001. None of the board types QEMU support=
s need
> ``param_struct`` support, so this option has been deprecated and will
> be removed in a future QEMU version.
>
>+``debug-threads`` option for ``-name``

(since 10.2)

Jano

>+''''''''''''''''''''''''''''''''''''''
>+
>+Thread ``debug-threads`` option for the ``-name`` argument is now
>+ignored. Thread naming is unconditionally enabled for all platforms
>+where it is supported.
>+
> User-mode emulator command line arguments
> -----------------------------------------
>

--5c2FoizNjCBL97Wh
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQT+Rn5j0qdK2hQgnuAU0rOr/y4PvAUCaMK5hQAKCRAU0rOr/y4P
vAjPAP9IH40tEQqmVUeI2r1NnNvrTtDh4Eu4OSX8KyP65orD8QEAmHSoa4Lh0taD
A8tZgqoQiRG3R3QRIthMbL+rbafF8Q8=
=xUIa
-----END PGP SIGNATURE-----

--5c2FoizNjCBL97Wh--


