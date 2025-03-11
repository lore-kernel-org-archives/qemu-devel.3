Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD7BC28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 07:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trtaZ-0003So-FQ; Tue, 11 Mar 2025 02:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trtaV-0003QK-LM
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 02:59:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trtaQ-0002bu-VS
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 02:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741676371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iJ0VHSHF8dtHF+DStUOmDEmuvu8n8fcjK0pWNi7HbGI=;
 b=O7COQJjzME4UAEckVXFIVZ6vYzPdP2+lOjtsJPe2r8QLjzBJD9SOiu/+fRrohOYIQ5CSS0
 ZgXaY0Qbx57l27rqCKcGB6rYVC4fBBFMLYORsGDsk8EmKPOrcq8iIZLOQkfT5lXGkT+9hE
 Qij70y2EH0UkZgoPp19O8D7SeML5viA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-0OKM8DXDMGqx3vV4VvkJkQ-1; Tue,
 11 Mar 2025 02:59:30 -0400
X-MC-Unique: 0OKM8DXDMGqx3vV4VvkJkQ-1
X-Mimecast-MFC-AGG-ID: 0OKM8DXDMGqx3vV4VvkJkQ_1741676369
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4CDB18004A9; Tue, 11 Mar 2025 06:59:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AA3C1800373; Tue, 11 Mar 2025 06:59:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 61EC721E675E; Tue, 11 Mar 2025 07:59:23 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Thomas Huth
 <thuth@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v3 02/63] qapi: shush pylint up
In-Reply-To: <20250311034303.75779-3-jsnow@redhat.com> (John Snow's message of
 "Mon, 10 Mar 2025 23:42:00 -0400")
References: <20250311034303.75779-1-jsnow@redhat.com>
 <20250311034303.75779-3-jsnow@redhat.com>
Date: Tue, 11 Mar 2025 07:59:23 +0100
Message-ID: <87o6y8833o.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

John Snow <jsnow@redhat.com> writes:

> Shhhhh!
>
> This patch can be dropped from the PR and I'll clean it up later. It's
> just here to help me establish a linting baseline. It isn't really
> needed for the series itself.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Okay, I'll drop this patch.

Note that I just posted "[PATCH] scripts/qapi/backend: Clean up
create_backend()'s failure mode", and ...

> ---
>  scripts/qapi/backend.py | 2 ++
>  scripts/qapi/main.py    | 8 +++-----
>  2 files changed, 5 insertions(+), 5 deletions(-)
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

... when you rebase on top of my patch, the hunk above stays, and the
hunk below goes.

> diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
> index 5b4679abcf1..01155373bd0 100644
> --- a/scripts/qapi/main.py
> +++ b/scripts/qapi/main.py
> @@ -38,8 +38,7 @@ def create_backend(path: str) -> QAPIBackend:
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


