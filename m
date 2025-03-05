Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7681AC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 06:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpiFF-0004k9-T6; Wed, 05 Mar 2025 01:28:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tpiFC-0004Zf-Ma
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:28:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tpiFA-0007uy-2S
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741156111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JC0SZyx4iprUlCh/49mHoxDsFZ70sO1odLiJKAeyulE=;
 b=amGKywKgzB4G89bmEBBVWldByUEz6Fxif18s88N/MmUWKxuW9Et3ooTHeWU/g+iSQo3+f8
 CS6lXICrCXZVdO7+ZKSqwafTZgMcEhO8j3BW2S1QAXSszyUAWYIKfTM97nlp8yBqepeaGf
 ZCrCTXzpBHa5g6P9x2stJcOvoHfesuI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-0jsfX9fzMFCPRD0W5enRWw-1; Wed,
 05 Mar 2025 01:28:21 -0500
X-MC-Unique: 0jsfX9fzMFCPRD0W5enRWw-1
X-Mimecast-MFC-AGG-ID: 0jsfX9fzMFCPRD0W5enRWw_1741156100
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D76CC180025B; Wed,  5 Mar 2025 06:28:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6530E1956094; Wed,  5 Mar 2025 06:28:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F07E521E66C1; Wed, 05 Mar 2025 07:28:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 02/57] qapi: shush pylint up
In-Reply-To: <20250305034610.960147-3-jsnow@redhat.com> (John Snow's message
 of "Tue, 4 Mar 2025 22:45:11 -0500")
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-3-jsnow@redhat.com>
Date: Wed, 05 Mar 2025 07:28:16 +0100
Message-ID: <87frjsoutb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

John Snow <jsnow@redhat.com> writes:

> Shhhhh!
>
> This patch is RFC quality, I wasn't in the mood to actually solve
> problems so much as I was in the mood to continue working on the Sphinx
> rework. Plus, I don't think the code I am patching has hit origin/master
> yet ...
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/backend.py |  2 ++
>  scripts/qapi/main.py    | 10 ++++------
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/scripts/qapi/backend.py b/scripts/qapi/backend.py
> index 14e60aa67af..49ae6ecdd33 100644
> --- a/scripts/qapi/backend.py
> +++ b/scripts/qapi/backend.py
> @@ -13,6 +13,7 @@
>  
>  
>  class QAPIBackend(ABC):
> +    # pylint: disable=too-few-public-methods
>  
>      @abstractmethod
>      def generate(self,
> @@ -36,6 +37,7 @@ def generate(self,
>  
>  
>  class QAPICBackend(QAPIBackend):
> +    # pylint: disable=too-few-public-methods
>  
>      def generate(self,
>                   schema: QAPISchema,

I didn't bother to ask for these in my review.  Do they get us to the
point where we can enable automatic pylint?

> diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
> index ff42b43cd68..01155373bd0 100644
> --- a/scripts/qapi/main.py
> +++ b/scripts/qapi/main.py
> @@ -31,15 +31,14 @@ def create_backend(path: str) -> QAPIBackend:
>  
>      module_path, dot, class_name = path.rpartition('.')
>      if not dot:
> -        print(f"argument of -B must be of the form MODULE.CLASS",
> +        print("argument of -B must be of the form MODULE.CLASS",

This one's already in "[PULL v2 0/5] QAPI patches patches for
2025-02-26".  No worries.

>                file=sys.stderr)
>          sys.exit(1)
>  
>      try:
>          mod = import_module(module_path)
>      except Exception as ex:
> -        print(f"unable to import '{module_path}': {ex}", file=sys.stderr)
> -        sys.exit(1)
> +        raise QAPIError(f"unable to import '{module_path}': {ex}") from ex
>  
>      try:
>          klass = getattr(mod, class_name)
> @@ -51,9 +50,8 @@ def create_backend(path: str) -> QAPIBackend:
>      try:
>          backend = klass()
>      except Exception as ex:
> -        print(f"backend '{path}' cannot be instantiated: {ex}",
> -              file=sys.stderr)
> -        sys.exit(1)
> +        raise QAPIError(
> +            f"backend '{path}' cannot be instantiated: {ex}") from ex
>  
>      if not isinstance(backend, QAPIBackend):
>          print(f"backend '{path}' must be an instance of QAPIBackend",

Missed in my review: the caller catches QAPIError, and returns non-zero
exit code on catch.  The caller's caller passes the exit code to
sys.exit().  Leaving the sys.exit() to the callers is cleaner.

However, you convert only two out of five error paths from sys.exit() to
raise.  All or nothing, please.

Maybe split the patch into a "# pylint:" and a "raise QAPIError" part?


