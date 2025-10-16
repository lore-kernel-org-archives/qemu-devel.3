Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05630CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 13:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9O6v-0000nE-1J; Thu, 16 Oct 2025 09:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v9O6s-0000mt-MC
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 09:33:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v9O6l-0002GT-Go
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 09:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760621607;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2cfh+bAJWryN8oAisretTBKkasC3SYusnf0ZAZ+p8Yo=;
 b=K5zyPq2+1jnQw9MrB3KblR9pEK5/leE3BX9VgafHsTWViMk3R2YDDkNzadirljyBwRW5da
 LN3HmP2IK2Dpoo/Gs5dnC8KVSbM4nZDSqD5rLYGqJIgGIULtIyR+Z9XmXnsENr/t8rzhzX
 CpHCD9hpjrGVUd68xTvpgd6VLiC1Tzk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-X8wIP_BsOUOYHrf8jIZoPg-1; Thu,
 16 Oct 2025 09:33:24 -0400
X-MC-Unique: X8wIP_BsOUOYHrf8jIZoPg-1
X-Mimecast-MFC-AGG-ID: X8wIP_BsOUOYHrf8jIZoPg_1760621603
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95EFA19560AD; Thu, 16 Oct 2025 13:33:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9BE71800577; Thu, 16 Oct 2025 13:33:22 +0000 (UTC)
Date: Thu, 16 Oct 2025 14:33:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] tests: use macros for registering char tests for sockets
Message-ID: <aPD0H_iryWnvtYYn@redhat.com>
References: <20251016132548.1654627-1-berrange@redhat.com>
 <CAFEAcA8J+ELMCdVBuqTTDg=seO4h4q9LdtXBya421Z3FH6__wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA8J+ELMCdVBuqTTDg=seO4h4q9LdtXBya421Z3FH6__wg@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Oct 16, 2025 at 02:30:47PM +0100, Peter Maydell wrote:
> On Thu, 16 Oct 2025 at 14:27, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > The test-char.c has a couple of helper macros for registering tests that
> > need to be repeated for both IP and UNIX sockets. One test case was not
> > using the macro though.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  tests/unit/test-char.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
> > index f30a39f61f..3c9f0a68e8 100644
> > --- a/tests/unit/test-char.c
> > +++ b/tests/unit/test-char.c
> > @@ -1969,19 +1969,17 @@ int main(int argc, char **argv)
> >      g_test_add_data_func("/char/socket/client/reconnect-error/" # name, \
> >                           &client7 ##name, char_socket_client_test);     \
> >      g_test_add_data_func("/char/socket/client/dupid-reconnect/" # name, \
> > -                         &client8 ##name, char_socket_client_dupid_test)
> > +                         &client8 ##name, char_socket_client_dupid_test); \
> > +    g_test_add_data_func("/char/socket/server/two-clients/" # name,     \
> > +                         addr, char_socket_server_two_clients_test)
> >
> >      if (has_ipv4) {
> >          SOCKET_SERVER_TEST(tcp, &tcpaddr);
> >          SOCKET_CLIENT_TEST(tcp, &tcpaddr);
> > -        g_test_add_data_func("/char/socket/server/two-clients/tcp", &tcpaddr,
> > -                             char_socket_server_two_clients_test);
> >      }
> >  #ifndef WIN32
> >      SOCKET_SERVER_TEST(unix, &unixaddr);
> >      SOCKET_CLIENT_TEST(unix, &unixaddr);
> > -    g_test_add_data_func("/char/socket/server/two-clients/unix", &unixaddr,
> > -                         char_socket_server_two_clients_test);
> >  #endif
> 
> This is a "server" test, but it looks like you've added it to
> the SOCKET_CLIENT_TEST macro instead of the SOCKET_SERVER_TEST macro ?

Opps, yes, though it raises the question of why we have separate
macros for server vs client tests instead of one.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


