Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BA2C36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 08:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twzHt-0002Xi-3c; Tue, 25 Mar 2025 04:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1twzHo-0002V9-6n
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 04:05:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1twzHl-00036Q-JJ
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 04:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742889919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IMA2I6a6fX/tIYLx1OaKkKfCFgCUauy6VS4Y865aUK4=;
 b=feh8efiwREQ8QzCM7dfSvq5Ljm1iV3otVNigdvxQU8j2Iny2BVpuR0tFlU3/FpnOoEjk1t
 SrprvEInWbmJAd62AzQeNvLoeOSXS4n5sVwKM0f+VGOMXEssOXNHBnlzkIMfLmibUIjEhJ
 Qg/aJiGFVkAdGaKqCX6zX0C1UjPdTo0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-FMgH2eiuMP2wbUgWTgo9dA-1; Tue,
 25 Mar 2025 04:05:17 -0400
X-MC-Unique: FMgH2eiuMP2wbUgWTgo9dA-1
X-Mimecast-MFC-AGG-ID: FMgH2eiuMP2wbUgWTgo9dA_1742889916
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44D431800266; Tue, 25 Mar 2025 08:05:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF42A1801756; Tue, 25 Mar 2025 08:05:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D86CC21E6773; Tue, 25 Mar 2025 09:05:11 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Cleber Rosa <crosa@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 5/5] qapi: delete un-needed python static analysis configs
In-Reply-To: <20250321222347.299121-6-jsnow@redhat.com> (John Snow's message
 of "Fri, 21 Mar 2025 18:23:47 -0400")
References: <20250321222347.299121-1-jsnow@redhat.com>
 <20250321222347.299121-6-jsnow@redhat.com>
Date: Tue, 25 Mar 2025 09:05:11 +0100
Message-ID: <871pulpmbs.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

John Snow <jsnow@redhat.com> writes:

> The pylint config is being left in place because the settings differ
> enough from the python/ directory settings that we need a chit-chat on
> how to merge them O:-)
>
> Everything else can go.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/.flake8    | 3 ---
>  scripts/qapi/.isort.cfg | 7 -------
>  scripts/qapi/mypy.ini   | 4 ----
>  3 files changed, 14 deletions(-)
>  delete mode 100644 scripts/qapi/.flake8
>  delete mode 100644 scripts/qapi/.isort.cfg
>  delete mode 100644 scripts/qapi/mypy.ini
>
> diff --git a/scripts/qapi/.flake8 b/scripts/qapi/.flake8
> deleted file mode 100644
> index a873ff67309..00000000000
> --- a/scripts/qapi/.flake8
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -[flake8]
> -# Prefer pylint's bare-except checks to flake8's
> -extend-ignore = E722

python/setup.cfg has:

   [flake8]
   # Prefer pylint's bare-except checks to flake8's
   extend-ignore = E722
   exclude = __pycache__,

Good.

> diff --git a/scripts/qapi/.isort.cfg b/scripts/qapi/.isort.cfg
> deleted file mode 100644
> index 643caa1fbd6..00000000000
> --- a/scripts/qapi/.isort.cfg
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -[settings]
> -force_grid_wrap=4
> -force_sort_within_sections=True
> -include_trailing_comma=True
> -line_length=72
> -lines_after_imports=2
> -multi_line_output=3

python/setup.cfg has:

   [isort]
   force_grid_wrap=4
   force_sort_within_sections=True
   include_trailing_comma=True
   line_length=72
   lines_after_imports=2
   multi_line_output=3

Good.

> diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
> deleted file mode 100644
> index 8109470a031..00000000000
> --- a/scripts/qapi/mypy.ini
> +++ /dev/null
> @@ -1,4 +0,0 @@
> -[mypy]
> -strict = True
> -disallow_untyped_calls = False
> -python_version = 3.8

python/setup.cfg has:

   [mypy]
   strict = True
   python_version = 3.8
   warn_unused_configs = True
   namespace_packages = True
   warn_unused_ignores = False

Also a bunch of [mypy-FOO] sections that don't apply here.

You explained the differences in review of a prior iteration.  Recap:

} warn_unused_configs: Catches config values that aren't actually recognized
} or used. Was helpful once upon a time when re-arranging the Python
} directory to behave like a package to ensure that the conf files were
} working correctly.

Could this be culled now?

Hmm, according to mypy(1), strict implies warn-unused-configs.

The question does not block this patch.

} namespace_packages: Needed for the python/ directory structure (nested
} packages under a namespace, "qemu"). Doesn't impact scripts/qapi at all.
} Read up on PEP420 if you are curious. Details in commit message, see below
} if you're still curious.

mypy(1) makes me suspect this is the default.  If that's true across the
versions we care for, this could be culled.

Also does not block this patch.

} warn_unused_ignores: Needed once upon a time for cross-version mypy support
} where some versions would warn in some cases and others would not. Adding
} an ignore would effectively just invert which versions complained. Probably
} still needed, but it's hard to measure.

Harmless enough.

} python_version: Changes mypy behavior regardless of the invoking python
} interpreter to check the file as if it were to be executed by Python 3.8. I
} actually want to remove this value from setup.cfg but haven't yet. I
} removed it from the python-qemu-qmp repo and never added it for qapi.
} Removing it is actually probably correct as it will catch errors specific
} to various python versions we support, but there are some nits to iron out
} in my neck of the woods. This is a case where scripts/qapi/ is stricter
} than python/ :)
} (Not reasonable to solve for this series.)

Also present in the deleted file, so no change.

} lack of disallow_untyped_calls = False: I think this might be a remnant
} from when we gradually typed qapi; it's evidently no longer needed since
} qapi still checks fine without this affordance. The default under strict is
} True.

Fair enough.

Let's mention the differences in the commit message.  Here's my try:

    Since the previous commit, python/setup.cfg applies to scripts/qapi/
    as well.  Configuration files in scripts/qapi/ override
    python/setup.cfg.

    scripts/qapi/.flake8 and scripts/qapi/.isort.cfg actually match
    python/setup.cfg exactly, and can go.

    The differences between scripts/qapi/mypy.ini and python/setup.cfg
    are harmless: [list the differences, explain why they're harmless as
    long as you can keep it brief, and if not, fall back to "trust me"].
    So scripts/qapi/mypy.ini can go, too.

    The pylint config is being left in place because the settings differ
    enough from the python/ directory settings that we need a chit-chat on
    how to merge them O:-)

With something like that
Reviewed-by: Markus Armbruster <armbru@redhat.com>


