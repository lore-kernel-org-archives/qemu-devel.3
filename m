Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 522EECAC58D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 12:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwgGj-00063H-Qw; Thu, 11 Sep 2025 08:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1uwgGe-00062Z-G9
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 08:19:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1uwgGV-0000tH-50
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 08:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757593138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cw8IjLmyg5f9FnKVMNkRJZWvU9jIxap4POfXNdq7L/4=;
 b=D1F4AxCRG67vDRVQkxRgdMxHd1iJFtW0EEkYDrPMeN3Fcj/7vLNty08C85HHsaQdrPcF8l
 BHZFVpBO5oqSwPVDt0NdTvpAIES1CtH3415DjJbS25gBvs3rq9P7Vrpc9/2Be4jDmInwaV
 QGbmqppdvi2QrGjaecHjBKfnOAcvu5k=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-_UxfqQNgN1uULc4SzJNsdg-1; Thu,
 11 Sep 2025 08:18:55 -0400
X-MC-Unique: _UxfqQNgN1uULc4SzJNsdg-1
X-Mimecast-MFC-AGG-ID: _UxfqQNgN1uULc4SzJNsdg_1757593133
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3BC291977538; Thu, 11 Sep 2025 12:18:53 +0000 (UTC)
Received: from fedora (unknown [10.44.33.231])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 405881800446; Thu, 11 Sep 2025 12:18:46 +0000 (UTC)
Date: Thu, 11 Sep 2025 14:18:43 +0200
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 03/20] system: unconditionally enable thread naming
Message-ID: <aMK-I0lMJg1wo9bB@fedora>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-4-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HTEeGEjMhz7+3flN"
Content-Disposition: inline
In-Reply-To: <20250910180357.320297-4-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jtomko@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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


--HTEeGEjMhz7+3flN
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On a Wednesday in 2025, Daniel P. Berrang=E9 wrote:
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
>Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
>index b2420732e1..7187ea15fa 100644
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

(this time on the latest version of the series, hopefully)

>+''''''''''''''''''''''''''''''''''''''
>+
>+Thread ``debug-threads`` option for the ``-name`` argument is now
>+ignored. Thread naming is unconditionally enabled for all platforms
>+where it is supported.
>+
> QEMU Machine Protocol (QMP) commands
> ------------------------------------
>

--HTEeGEjMhz7+3flN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQT+Rn5j0qdK2hQgnuAU0rOr/y4PvAUCaMK+HwAKCRAU0rOr/y4P
vNTNAQCN1EVYXdsrWmDCwYf/Z/x3JijWL+LIfouzgE7NXxrVVgEAtBJ6RS2idj2i
LMnb/iybcjTfyRDAbtdX5SRloG0mQAo=
=ywwN
-----END PGP SIGNATURE-----

--HTEeGEjMhz7+3flN--


