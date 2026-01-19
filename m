Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF45CD29C36
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 14:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhqf2-0006vO-Tb; Mon, 19 Jan 2026 09:55:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vhqes-0006kb-4s
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 09:55:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vhqeo-0001Kt-2J
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 09:55:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768834504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wCvzM6if4FwMrH8BPo2Q3oswj4biU34qldpwKxLgbz0=;
 b=GuNZfRmcCUypjbmFQJoWgZiz7V/K3kB+dw7XpFHXHcnUGRW3+K8rZYu0PrkEBZfync4bmD
 3HisKGkRctR6406l5xDTTpZtpbUQLYdrzR4Y20ncX4sn8TbWMl0U4rcmyw1/R9aCiBp/l7
 o4Z8DwdOiALbbrOhQHSCqayWFDwoTJk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-ilD-PKr5O3GQilP7Fi0hgQ-1; Mon,
 19 Jan 2026 09:55:00 -0500
X-MC-Unique: ilD-PKr5O3GQilP7Fi0hgQ-1
X-Mimecast-MFC-AGG-ID: ilD-PKr5O3GQilP7Fi0hgQ_1768834499
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E59E1956050; Mon, 19 Jan 2026 14:54:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EF5619560AB; Mon, 19 Jan 2026 14:54:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D0A6F21E692D; Mon, 19 Jan 2026 15:54:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>,  Alistair Francis <alistair@alistair23.me>,
 Zhang Chen <zhangckid@gmail.com>,  Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH 3/4] qemu-options.hx: Drop uses of @var
In-Reply-To: <20260115142629.665319-4-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 15 Jan 2026 14:26:28 +0000")
References: <20260115142629.665319-1-peter.maydell@linaro.org>
 <20260115142629.665319-4-peter.maydell@linaro.org>
Date: Mon, 19 Jan 2026 15:54:55 +0100
Message-ID: <87o6mplkjk.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> A few entries in qemu-options.hx use the syntax "my-option=@var{name}"
> when documenting an option that takes an argument. This syntax isn't
> consistently used, and the documentation generation has no support for
> it: it just appears literally in the HTML output.

TexInfo leftovers?

> Switch these uses to the more common "my-option=<name>". This also
> doesn't have any particular support in the documentation generation
> and so appears literally in the output, but it is a little less odd
> looking to the end-user.

Note for later: rewrite 1 is from KEY=@var{VALUE} to KEY=<VALUE>.

> The other common pattern we have is "my-option=name" with no marking
> at all that the right hand side of the '=' is not literal text;
> using <> seems preferable to me, as it makes it more distinct from
> cases where the right hand side is documenting that only certain
> values are permitted, as in "my-option=on|off".

Rewrite 2 is from KEY=VALUE to KEY=<VALUE>.

> We don't change the uses of @var in the colo-compare documentation,
> as that part deserves a slightly more wide-ranging overhaul that
> is better in its own commit.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  qemu-options.hx | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index ec92723f10..aca9dba8b9 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -36,7 +36,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>      "                dea-key-wrap=on|off controls support for DEA key wrapping (default=on)\n"
>      "                suppress-vmdesc=on|off disables self-describing migration (default=off)\n"
>      "                nvdimm=on|off controls NVDIMM support (default=off)\n"
> -    "                memory-encryption=@var{} memory encryption object to use (default=none)\n"
> +    "                memory-encryption=<id> memory encryption object to use (default=none)\n"

This is rewrite 1, except you additionally make up a missing VALUE.

>      "                hmat=on|off controls ACPI HMAT support (default=off)\n"
>      "                spcr=on|off controls ACPI SPCR support (default=on)\n"
>  #ifdef CONFIG_POSIX
> @@ -100,7 +100,7 @@ SRST
>      ``nvdimm=on|off``
>          Enables or disables NVDIMM support. The default is off.
>  
> -    ``memory-encryption=``
> +    ``memory-encryption=<id>``
>          Memory encryption object to use. The default is none.

This is rewrite 2, except you additionally make up a missing VALUE.

>  
>      ``hmat=on|off``
> @@ -180,7 +180,7 @@ SRST
>  
>              -machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=128G,cxl-fmw.0.interleave-granularity=512
>  
> -    ``sgx-epc.0.memdev=@var{memid},sgx-epc.0.node=@var{numaid}``
> +    ``sgx-epc.0.memdev=<memid>,sgx-epc.0.node=<numaid>``
>          Define an SGX EPC section.

This is rewrite 1.

>  
>      ``smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel``
> @@ -4530,7 +4530,7 @@ DEF("compat", HAS_ARG, QEMU_OPTION_compat,
>      "                Policy for handling unstable management interfaces\n",
>      QEMU_ARCH_ALL)
>  SRST
> -``-compat [deprecated-input=@var{input-policy}][,deprecated-output=@var{output-policy}]``
> +``-compat [deprecated-input=<input-policy>][,deprecated-output=<output-policy>]``

Rewrite 1.

>      Set policy for handling deprecated management interfaces (experimental):
>  
>      ``deprecated-input=accept`` (default)
> @@ -4546,7 +4546,7 @@ SRST
>  
>      Limitation: covers only syntactic aspects of QMP.
>  
> -``-compat [unstable-input=@var{input-policy}][,unstable-output=@var{output-policy}]``
> +``-compat [unstable-input=<input-policy>][,unstable-output=<output-policy>]``

Rewrite 1.

>      Set policy for handling unstable management interfaces (experimental):
>  
>      ``unstable-input=accept`` (default)

This patch and the next apply rewrite 1 exhaustively.

Not the case for rewrite 2, e.g. there's still

    "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n"

where the value size is not literal.  Many more.

So, what this patch actually does is rewrite 1 plus add missing values.
Could be separate patches, up to you.  Regardless, the commit message
should match what the patch does.


