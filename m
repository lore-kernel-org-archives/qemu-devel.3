Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1338D6007E
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 09:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDKAo-0001Jh-Rn; Tue, 19 Nov 2024 04:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tDKAi-0001J9-Pp
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 04:05:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tDKAf-0007C2-Kb
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 04:05:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732007116;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=mooMlD0pIlqcZLKDjgL039YzMY3ZU9oDqNhg4YVBfH8=;
 b=PIJPJfks1/gcOXvB6MeMt9LgWq+Ml6qFlt3976k2F8wlSkvnSD2XMYlhoZT+BKJEs0c2fE
 Jg7SlGUsxaIIxXciAzRzBsgUX2yPk4bATVLiDJQ1Z/xbGK+HdFDRgS3VyBUFWD6tgcdSX2
 AI/643KbSGBfp9UvcI2yFH2Ldmr0NTc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-DTlWtZE8P4CLlW1lEvm9Tw-1; Tue,
 19 Nov 2024 04:05:12 -0500
X-MC-Unique: DTlWtZE8P4CLlW1lEvm9Tw-1
X-Mimecast-MFC-AGG-ID: DTlWtZE8P4CLlW1lEvm9Tw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B470C1955F43; Tue, 19 Nov 2024 09:05:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.110])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7243F1956086; Tue, 19 Nov 2024 09:04:56 +0000 (UTC)
Date: Tue, 19 Nov 2024 09:04:53 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andrew Melnychenko <andrew@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Thomas Huth <thuth@redhat.com>,
 alex.bennee@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 manos.pitsidianakis@linaro.org, qemu-block@nongnu.org,
 Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 gustavo.romero@linaro.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/7] docs/devel: add git-publish for patch submitting
Message-ID: <ZzxUeTxHBHKlEhwN@redhat.com>
References: <20241118172357.475281-1-pierrick.bouvier@linaro.org>
 <20241118172357.475281-3-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241118172357.475281-3-pierrick.bouvier@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Nov 18, 2024 at 09:23:52AM -0800, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  docs/devel/submitting-a-patch.rst | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
> index 349c32ee3a9..953682f20cb 100644
> --- a/docs/devel/submitting-a-patch.rst
> +++ b/docs/devel/submitting-a-patch.rst
> @@ -237,6 +237,20 @@ attachments can be used as a last resort on a first-time submission.
>  
>  .. _if_you_cannot_send_patch_emails:

This needs to remain associated with the heading that is *after*
your new block of text, while here you need to add a new anchor

   .. _use_git_publish:

>  
> +Use git-publish
> +~~~~~~~~~~~~~~~
> +
> +If you already configured git send-email, you can simply use `git-publish
> +<https://github.com/stefanha/git-publish>`__ to send series.
> +
> +::
> +
> +    $ git checkout master -b my-feature
> +    $ # work on new commits, add your 'Signed-off-by' lines to each
> +    $ git publish
> +    $ ... more work, rebase on master, ...
> +    $ git publish # will send a v2

Also add a note

 "Each time you post a series, git-publish will create a local tag
  with the format ``<branchname>-v<version>`` to record the patch
  series."

> +
>  If you cannot send patch emails
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> -- 
> 2.39.5
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


