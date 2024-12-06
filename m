Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903A1E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 11:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJWaF-0007CD-Kw; Fri, 06 Dec 2024 06:33:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tJWaD-0007BP-SF
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 06:33:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tJWaA-0004IM-61
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 06:33:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733484792;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=IqC85ippnyJa3upPHjV2P8ua2qM0xUIdKMiOS3w8fZc=;
 b=Qf4IO2U9OEnDhBsoyUOv6SPHM+nV8m5a0XWjDQEmV3XRwIFt1UJb2ttp7HoEJRG23Abk6t
 rJBdAoQkqb0qbV8B1f0DCzuiQp5E4HqFKVm7Fs54uAAxqh6C9vHL84msa73cjKiL9tpz2H
 Zv3Ap+5JdOyQvo3lq6wxN+2e5Ml4iXQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-CAHmOdCDO3ypqJ-MtgmHrA-1; Fri,
 06 Dec 2024 06:32:02 -0500
X-MC-Unique: CAHmOdCDO3ypqJ-MtgmHrA-1
X-Mimecast-MFC-AGG-ID: CAHmOdCDO3ypqJ-MtgmHrA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CCFE195608C; Fri,  6 Dec 2024 11:31:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.160])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 202421955F3F; Fri,  6 Dec 2024 11:31:51 +0000 (UTC)
Date: Fri, 6 Dec 2024 11:31:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 gustavo.romero@linaro.org, Andrew Melnychenko <andrew@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Konstantin Kostiuk <kkostiuk@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 manos.pitsidianakis@linaro.org, qemu-block@nongnu.org
Subject: Re: [PATCH v2 2/6] docs/devel: add git-publish for patch submitting
Message-ID: <Z1LgpKB_J4Df4wcE@redhat.com>
References: <20241205222241.3789437-1-pierrick.bouvier@linaro.org>
 <20241205222241.3789437-3-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241205222241.3789437-3-pierrick.bouvier@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Dec 05, 2024 at 02:22:37PM -0800, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  docs/devel/submitting-a-patch.rst | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
> index 03b2ac298aa..f8b7fc59544 100644
> --- a/docs/devel/submitting-a-patch.rst
> +++ b/docs/devel/submitting-a-patch.rst
> @@ -235,6 +235,25 @@ to another list.) ``git send-email`` (`step-by-step setup guide
>  works best for delivering the patch without mangling it, but
>  attachments can be used as a last resort on a first-time submission.
>  
> +.. _use_git_publish:
> +
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
> +
> +Each time you post a series, git-publish will create a local tag with the format
> +``<branchname>-v<version>`` to record the patch series.

Lets also mention

  "When sending patch emails, 'git publish' will consult the output
   of 'scripts/get_maintainers.pl' and automatically CC anyone listed
   as maintainers of the affected code. Generally you should accept the
   suggested CC list, but there may sometimes be scenarios where it is
   appropriate to cut it down (eg on certain large tree-wide cleanups),
   or augment it with other interested people"

Second, lets say something about pull requests

  "When a subsystem maintainer is ready to send a pull request, the
   'git publish --pull' command will triggering GPG tag signing,
   publish the branch to the git remote name specified by the
   'remote.pushDefault' config option, and send the email series'

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


