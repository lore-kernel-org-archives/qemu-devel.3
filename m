Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DB9C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 11:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roidM-00035y-J0; Mon, 25 Mar 2024 07:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1roidK-00035a-N6
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 07:36:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1roidJ-0002Hx-6U
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 07:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711366612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bvlAHmHsZxYMsujxyxX8BIGPqcB2ObSkwelUh3Qh5AI=;
 b=efrmSO4mJ736SRbWmJxnBnPgvV9O4Ed65x+KPvypNA8PrP4fK5ADrFejyC5l3iMb4egtAG
 fy/Wu0UNkFL74PcEzhKsekxADV9KsqGKlfYOb7y13XaKSU0uyIrhXl8ywgdI7zL0nEuqyX
 /Sz7ozocN9wsSYqx+tlfCQVlLRW0F14=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-8Dkc2GlSM-eFYixplZcQmw-1; Mon,
 25 Mar 2024 07:36:50 -0400
X-MC-Unique: 8Dkc2GlSM-eFYixplZcQmw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3333328B6934
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 11:36:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 131EC112131D
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 11:36:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0FEA621E669D; Mon, 25 Mar 2024 12:36:45 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] qapi: document leftover members in qapi/run-state.json
In-Reply-To: <20240325104502.1358693-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Mon, 25 Mar 2024 11:45:02 +0100")
References: <20240325104502.1358693-1-pbonzini@redhat.com>
Date: Mon, 25 Mar 2024 12:36:45 +0100
Message-ID: <87o7b2mtki.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  qapi/run-state.json | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/run-state.json b/qapi/run-state.json
> index 789fc34559a..cb4a2b43293 100644
> --- a/qapi/run-state.json
> +++ b/qapi/run-state.json
> @@ -377,9 +377,17 @@
>  ##
>  # @watchdog-set-action:
>  #
> -# Set watchdog action
> +# Set watchdog action.
> +#
> +# @action: @WatchdogAction action taken when watchdog timer expires.
>  #
>  # Since: 2.11
> +#
> +# Example:
> +#
> +#     -> { "execute": "watchdog-set-action",
> +#          "arguments": { "action": "inject-nmi" } }
> +#     <- { "return": {} }
>  ##
>  { 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} }
>  

Appreciate the example!

> @@ -505,6 +513,22 @@
>  #
>  # Hyper-V specific guest panic information (HV crash MSRs)
>  #
> +# @arg1: for Windows, STOP code for the guest crash.  For Linux,
> +#        an error code.
> +#
> +# @arg2: for Windows, first argument of the STOP.  For Linux, the
> +#        guest OS id, which has the kernel version in bits 16-47

Mind if I capitalize ID?

> +#        and 0x8100 in bits 48-63.
> +#
> +# @arg3: for Windows, second argument of the STOP.  For Linux, the
> +#        program counter of the guest.
> +#
> +# @arg4: for Windows, third argument of the STOP.  For Linux, the
> +#        RAX register (x86) or the stack pointer (aarch64) of the guest.
> +#
> +# @arg5: for Windows, fourth argument of the STOP.  For x86 Linux, the
> +#        stack pointer of the guest.
> +#
>  # Since: 2.9
>  ##
>  {'struct': 'GuestPanicInformationHyperV',

Reviewed-by: Markus Armbruster <armbru@redhat.com>


