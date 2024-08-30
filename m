Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC4DCA0FE0
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 11:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjzVk-0008TQ-MS; Fri, 30 Aug 2024 07:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sjzVi-0008MY-TF
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:09:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sjzVh-0006A8-5i
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725016184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DpjWAwdb5eu614IE2JNHDUVoIEtOE4xOlPhLq2YxT8o=;
 b=PgTKr4ykrZ00dO6kHpohdH0WfJWSH4TS2U8HhB4WKZPrvrarIiA7aQMMo4T2cehZ+r/A3j
 Qmm8aL+LCqUsHecGqE5aD6b69TlOVEb1qu6yZq6Lhj5Z/OzbIw4fXPmDbRS01q15h/4Pal
 8DsnjmIxphqp/0zQJKqfvd+ZD+NkNtc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-jcNMiDlTOv-7dB0DBYlnAw-1; Fri,
 30 Aug 2024 07:09:40 -0400
X-MC-Unique: jcNMiDlTOv-7dB0DBYlnAw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8963019560B4; Fri, 30 Aug 2024 11:09:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17B9219560AA; Fri, 30 Aug 2024 11:09:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 88E8721E6A28; Fri, 30 Aug 2024 13:09:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Cleber Rosa <crosa@redhat.com>,  =?utf-8?Q?Mar?=
 =?utf-8?Q?c-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,  Beraldo Leal
 <bleal@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 2/8] python/qapi: change "FIXME" to "TODO"
In-Reply-To: <20240820002318.1380276-3-jsnow@redhat.com> (John Snow's message
 of "Mon, 19 Aug 2024 20:23:11 -0400")
References: <20240820002318.1380276-1-jsnow@redhat.com>
 <20240820002318.1380276-3-jsnow@redhat.com>
Date: Fri, 30 Aug 2024 13:09:36 +0200
Message-ID: <87ikvicln3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> qemu.git/python/setup.cfg disallows checking in any code with "XXX",
> "FIXME" or "TODO" in the comments. Soften the restriction to only
> prohibit "FIXME", and change the two occurrences of "FIXME" in qapi to
> read "TODO" instead.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

I don't like forbidding FIXME comments.  It's as futile as forbidding
known bugs.  All it can accomplish is making people use other, and
likely less clear ways to document them.

Perhaps projects exist that use FIXME comments only for known bugs in
uncommitted code.  To me, that feels *nuts*.  I commit all kinds of crap
in my tree.  I don't need silly "make check" failures while I develop,
the non-silly ones cause enough friction already.

In fact, we're quite happy to use FIXME comments even in merged code:

    $ git-grep FIXME | wc -l
    494

I can't see why python/ should be different.

> ---
>  python/setup.cfg         | 5 +++++
>  scripts/qapi/commands.py | 2 +-
>  scripts/qapi/events.py   | 2 +-
>  3 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/python/setup.cfg b/python/setup.cfg
> index 3b4e2cc5501..72b58c98c99 100644
> --- a/python/setup.cfg
> +++ b/python/setup.cfg
> @@ -169,6 +169,11 @@ ignore-signatures=yes
>  # TODO: Remove after we opt in to Pylint 2.8.3. See commit msg.
>  min-similarity-lines=6
>  
> +[pylint.miscellaneous]
> +
> +# forbid FIXME/XXX comments, allow TODO.
> +notes=FIXME,
> +      XXX,
>  
>  [isort]
>  force_grid_wrap=4
> diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
> index 79951a841f5..cffed6cd3ba 100644
> --- a/scripts/qapi/commands.py
> +++ b/scripts/qapi/commands.py
> @@ -385,7 +385,7 @@ def visit_command(self,
>                        coroutine: bool) -> None:
>          if not gen:
>              return
> -        # FIXME: If T is a user-defined type, the user is responsible
> +        # TODO: If T is a user-defined type, the user is responsible
>          # for making this work, i.e. to make T's condition the
>          # conjunction of the T-returning commands' conditions.  If T
>          # is a built-in type, this isn't possible: the
> diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
> index d1f639981a9..36dc0c50c78 100644
> --- a/scripts/qapi/events.py
> +++ b/scripts/qapi/events.py
> @@ -84,7 +84,7 @@ def gen_event_send(name: str,
>                     boxed: bool,
>                     event_enum_name: str,
>                     event_emit: str) -> str:
> -    # FIXME: Our declaration of local variables (and of 'errp' in the
> +    # TODO: Our declaration of local variables (and of 'errp' in the
>      # parameter list) can collide with exploded members of the event's
>      # data type passed in as parameters.  If this collision ever hits in
>      # practice, we can rename our local variables with a leading _ prefix,

Starting a comment with TODO tells me there's work to do.

Starting it with FIXME tells me there's a bug to fix.  That's more
specific.  Replacing FIXME by TODO loses information.


