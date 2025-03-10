Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DBBC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 10:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1traRb-0004to-6H; Mon, 10 Mar 2025 06:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1traRY-0004r2-EE
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 06:33:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1traRO-0001yc-B1
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 06:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741602776;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=urVswYkb7uc3bzDsrY/2lrg8k7Gch4I6qKq47q5Mmt4=;
 b=dp80/0JUvCD/TcHJAav7DhkQaJ3ZJ9+c/cIjmXET7MHnSnouC2I3R8Aa4RS7Z8qHNdjqnj
 GruH7hYbl1N6XcCuo3BZ3X/sBJC6GLmKbzVx4J6JmiRfTa/JWxGzR84FJSA33DyK/nhcKp
 Iyk3aQNFJVatjaoI6pgPNxV7QO6DKF8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-OFi_5wpOOQWsYiLJTtEahA-1; Mon,
 10 Mar 2025 06:32:53 -0400
X-MC-Unique: OFi_5wpOOQWsYiLJTtEahA-1
X-Mimecast-MFC-AGG-ID: OFi_5wpOOQWsYiLJTtEahA_1741602772
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A7FE180049D; Mon, 10 Mar 2025 10:32:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 017A91800373; Mon, 10 Mar 2025 10:32:49 +0000 (UTC)
Date: Mon, 10 Mar 2025 10:32:46 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] meson.build: Set RUST_BACKTRACE for all tests
Message-ID: <Z86_ztnZlROnQJOR@redhat.com>
References: <20250310102950.3752908-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310102950.3752908-1-peter.maydell@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Mar 10, 2025 at 10:29:50AM +0000, Peter Maydell wrote:
> We want to capture potential Rust backtraces on panics in our test
> logs, which isn't Rust's default behaviour.  Set RUST_BACKTRACE=1 in
> the add_test_setup environments, so that all our tests get run with
> this environment variable set.
> 
> This makes the setting of that variable in the gitlab CI template
> redundant, so we can remove it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  meson.build                         | 9 ++++++---
>  .gitlab-ci.d/buildtest-template.yml | 1 -
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 8b9fda4d95e..2f373dc675f 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -5,9 +5,12 @@ project('qemu', ['c'], meson_version: '>=1.5.0',
>  
>  meson.add_devenv({ 'MESON_BUILD_ROOT' : meson.project_build_root() })
>  
> -add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_default: true)
> -add_test_setup('slow', exclude_suites: ['thorough'], env: ['G_TEST_SLOW=1', 'SPEED=slow'])
> -add_test_setup('thorough', env: ['G_TEST_SLOW=1', 'SPEED=thorough'])
> +add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_default: true,
> +              env: ['RUST_BACKTRACE=1'])

Indent off-by-1

> +add_test_setup('slow', exclude_suites: ['thorough'],
> +               env: ['G_TEST_SLOW=1', 'SPEED=slow', 'RUST_BACKTRACE=1'])
> +add_test_setup('thorough',
> +               env: ['G_TEST_SLOW=1', 'SPEED=thorough', 'RUST_BACKTRACE=1'])
>  
>  meson.add_postconf_script(find_program('scripts/symlink-install-tree.py'))

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


