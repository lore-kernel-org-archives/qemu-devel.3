Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA494D59F52
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 16:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8iaF-0004Xn-Ls; Wed, 06 Nov 2024 11:08:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1t8iaD-0004Wu-H5
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 11:08:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1t8iaA-0004du-NK
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 11:08:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730909313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EBxiXAH6kqXk75kf6Vjzwv5F23AjO/7czASbo/7Knkg=;
 b=XMcfdtNDN5GslGlO8MeJAwl3Fyx8QIW0X3gTnW5Ess1vEjX9/u2CXnaQ5QV8EZ6v1xXInn
 Whb9Coew/ukc5Gyl1EVUq57Zz5PeUJJy0o6vEJnbjseOLq7JnF4yOzFPGQE3TIllsxAw95
 gJF8sufhasASJrcSIvBYPZr/7EG1nGU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-fW5BJMn8N52pHJ67mi4sww-1; Wed,
 06 Nov 2024 11:07:01 -0500
X-MC-Unique: fW5BJMn8N52pHJ67mi4sww-1
X-Mimecast-MFC-AGG-ID: fW5BJMn8N52pHJ67mi4sww
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99BC91955D65; Wed,  6 Nov 2024 16:07:00 +0000 (UTC)
Received: from fedora (unknown [10.45.225.164])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87B42195607C; Wed,  6 Nov 2024 16:06:58 +0000 (UTC)
Date: Wed, 6 Nov 2024 17:06:55 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, kkostiuk@redhat.com
Subject: Re: [PATCH 2/4] qga: Invert logic on return value in main()
Message-ID: <ZyuUH9SJzvJo72kC@fedora>
References: <cover.1730713917.git.mprivozn@redhat.com>
 <5182ceb139a43aacaab2c8b833bf52b13279dcf0.1730713917.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="otp/kMzgGfjnM3y4"
Content-Disposition: inline
In-Reply-To: <5182ceb139a43aacaab2c8b833bf52b13279dcf0.1730713917.git.mprivozn@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jtomko@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--otp/kMzgGfjnM3y4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On a Monday in 2024, Michal Privoznik wrote:
>Current logic on return value ('ret' variable) in main() is error
>prone. The variable is initialized to EXIT_SUCCESS and then set
>to EXIT_FAILURE on error paths. This makes it very easy to forget
>to set the variable to indicate error when adding new error path,
>as is demonstrated by handling of initialize_agent() failure.
>It's simply lacking setting of the variable.
>
>There's just one case where success should be indicated: when
>dumping the config ('-D' cmd line argument).
>
>To resolve this, initialize the variable to failure value and set
>it explicitly to success value in that one specific case.
>
>Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
>---
> qga/main.c | 6 ++----
> 1 file changed, 2 insertions(+), 4 deletions(-)
>
>diff --git a/qga/main.c b/qga/main.c
>index 4a695235f0..c003aacbe0 100644
>--- a/qga/main.c
>+++ b/qga/main.c
>@@ -1579,7 +1579,7 @@ static void stop_agent(GAState *s, bool requested)
>
> int main(int argc, char **argv)
> {
>-    int ret = EXIT_SUCCESS;
>+    int ret = EXIT_FAILURE;
>     GAState *s;
>     GAConfig *config = g_new0(GAConfig, 1);
>     int socket_activation;
>@@ -1607,7 +1607,6 @@ int main(int argc, char **argv)
>     socket_activation = check_socket_activation();
>     if (socket_activation > 1) {
>         g_critical("qemu-ga only supports listening on one socket");
>-        ret = EXIT_FAILURE;
>         goto end;
>     }
>     if (socket_activation) {
>@@ -1631,7 +1630,6 @@ int main(int argc, char **argv)
>
>         if (!config->method) {
>             g_critical("unsupported listen fd type");
>-            ret = EXIT_FAILURE;
>             goto end;
>         }
>     } else if (config->channel_path == NULL) {
>@@ -1643,13 +1641,13 @@ int main(int argc, char **argv)
>             config->channel_path = g_strdup(QGA_SERIAL_PATH_DEFAULT);
>         } else {
>             g_critical("must specify a path for this channel");
>-            ret = EXIT_FAILURE;
>             goto end;
>         }
>     }
>
>     if (config->dumpconf) {
>         config_dump(config);
>+        ret = EXIT_SUCCESS;
>         goto end;
>     }
>

Below this there's another place that misses an EXIT_SUCCESS, on _WIN32
when config->daemonize is set:

  #ifdef _WIN32
      if (config->daemonize) {
          SERVICE_TABLE_ENTRY service_table[] = {
              { (char *)QGA_SERVICE_NAME, service_main }, { NULL, NULL } };
          StartServiceCtrlDispatcher(service_table);
      } else {
          ret = run_agent(s);
      }
  #else
      ret = run_agent(s);
  #endif

But after patch 4/4 ret is set to EXIT_SUCCESS in all the cases.

Jano

--otp/kMzgGfjnM3y4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQT+Rn5j0qdK2hQgnuAU0rOr/y4PvAUCZyuUGgAKCRAU0rOr/y4P
vCrLAPsGCAHWt/JDLLI3ojnFdio5rCI6QRaZ5xR4f3KbJgTprAD/WGUQNkbWYLtP
7BkaohN0RZTvmqrXHg4fk3eTuXvf4wA=
=Irop
-----END PGP SIGNATURE-----

--otp/kMzgGfjnM3y4--


