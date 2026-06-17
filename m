Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14E3CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 05:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZj8U-00025F-D7; Wed, 17 Jun 2026 01:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZj8N-00024e-RH
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 01:48:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZj8M-0005O2-5b
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 01:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781675296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8FotqOl+TMj2DIFKuqr88Rpbm4E5FrzBjbD8RDHhQho=;
 b=PQd35VuaejwRUcOib+JBXHeIVZSM5dCShXqivuI796uaJR2RortcATdG6jsY9cdsnLmZhz
 4u/br3N1vALtXYNRDNI2M9nTP4uZn09Ddt4vkXaWtKCaKibwVjS3+mocUgC5o4cU7zG8UQ
 cxbU+qcNvSzoyoJ+f/hzwTnTKbjL5mM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-bKypzlkiNOujxzXUvoWHkw-1; Wed,
 17 Jun 2026 01:48:14 -0400
X-MC-Unique: bKypzlkiNOujxzXUvoWHkw-1
X-Mimecast-MFC-AGG-ID: bKypzlkiNOujxzXUvoWHkw_1781675293
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39E5F19539A7; Wed, 17 Jun 2026 05:48:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE9A6195419D; Wed, 17 Jun 2026 05:48:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0A2B221E6A01; Wed, 17 Jun 2026 07:48:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>,  Cleber Rosa <crosa@redhat.com>,
 philmd@oss.qualcomm.com,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@mailo.com>
Subject: Re: [PATCH 1/2] MAINTAINERS: fix entry for 'Python scripts'
In-Reply-To: <20260615201723.2959015-2-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Mon, 15 Jun 2026 13:17:22 -0700")
References: <20260615201723.2959015-1-pierrick.bouvier@oss.qualcomm.com>
 <20260615201723.2959015-2-pierrick.bouvier@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 07:48:10 +0200
Message-ID: <87tsr1pvj9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> Existing entry tests/*.py does not match any file at the moment, the
> semantic is "any py file under tests".
> Kernel MAINTAINERS file supports 'K: regexp' entries to match entries,
> but we don't support it, and I'm not sure it's the right solution here.

I think you mean N:.  K: matches file contents.  From the kernel's
MAINTAINERS file:

	N: Files and directories *Regex* patterns.
	   N:	[^a-z]tegra	all files whose path contains tegra
	                        (not including files like integrator)
	   One pattern per line.  Multiple N: lines acceptable.
	   scripts/get_maintainer.pl has different behavior for files that
	   match F: pattern and matches of N: patterns.  By default,
	   get_maintainer will not look at git log history when an F: pattern
	   match occurs.  When an N: match occurs, git log history is used
	   to also notify the people that have git commit signatures.
	K: *Content regex* (perl extended) pattern match in a patch or file.
	   For instance:
	   K: of_get_profile
	      matches patches or files that contain "of_get_profile"
	   K: \b(printk|pr_(info|err))\b
	      matches patches or files that contain one or more of the words
	      printk, pr_info or pr_err
	   One regex pattern per line.  Multiple K: lines acceptable.

> Instead of adding "yet another generic solution" to this problem, just
> add manual entries matching existing sublevels. The Python scripts
> section is the only one requiring this, and we can always reconsider the
> K: approach later if another use case emerge.

"Only one" is not correct, because ...
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2b5b581e173..61af956ed82 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3472,7 +3472,9 @@ M: John Snow <jsnow@redhat.com>
>  M: Cleber Rosa <crosa@redhat.com>
>  S: Odd Fixes
>  F: scripts/*.py
> -F: tests/*.py
> +F: tests/*/*.py
> +F: tests/*/*/*.py
> +F: tests/*/*/*/*.py

... F: scripts/*.py matches only about a third of the .py under scripts.

I'm not demanding you port over N:, I'm just giving you information :)

The "one F: per directory level" solution is pleasantly stupid, but also
somewhat brittle.

>  
>  Benchmark util
>  M: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>


