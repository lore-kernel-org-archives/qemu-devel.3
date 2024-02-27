Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD16C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 14:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reyqI-0006Gn-5v; Tue, 27 Feb 2024 09:54:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1reyq2-00063X-Gw
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:53:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1reyq0-00050X-92
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:53:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709045622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mpVDZyDJrUMXiTSCzIO1eszD+qEu7UdkAZXTqcegNCY=;
 b=SO2EPDwchSgDzgOa5fl8nvqTMTcAkICZCbYaCNr5qrBrD4wEZk/FjpV5AQncnKGiC40BKT
 1RnWAWE+eZd8hyO9i5SrdGM2nDEpCJSaIhhyYXQWLUcKKHDeNe38YArG665ILxtkAu4JRN
 1C3lmRhIIvMSaWJ3r1yIwT2ItRKfdhQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-ezdkG5Q-PiCvYP2jblNyoA-1; Tue,
 27 Feb 2024 09:53:38 -0500
X-MC-Unique: ezdkG5Q-PiCvYP2jblNyoA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 243C03812000
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 14:53:38 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F84F2166B33;
 Tue, 27 Feb 2024 14:53:37 +0000 (UTC)
Date: Tue, 27 Feb 2024 08:53:35 -0600
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com
Subject: Re: [PATCH 1/2] docs/devel/writing-monitor-commands: Repair a decade
 of rot
Message-ID: <zhvqwgl7rgg54gdjcnygx3pmlsimhyxu4j73l254kcmehkh66s@6jvrzmhgupum>
References: <20240227115617.237875-1-armbru@redhat.com>
 <20240227115617.237875-2-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227115617.237875-2-armbru@redhat.com>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 27, 2024 at 12:56:16PM +0100, Markus Armbruster wrote:
> The tutorial doesn't match reality since at least 2013.  Repairing it
> involves fixing the following issues:
> 
> * Update for commit 6d327171551 (aio / timers: Remove alarm timers):
>   replace the broken examples.  Instead of having one for returning a
>   struct and another for returning a list of structs, do just one for
>   the latter.  This resolves the FIXME added in commit
>   e218052f928 (aio / timers: De-document -clock) back in 2014.
> 
> * Update for commit 895a2a80e0e (qapi: Use 'struct' instead of 'type'
>   in schema).
> 
> * Update for commit 3313b6124b5 (qapi: add qapi2texi script): add
>   required documentation to the schema snippets, and drop section
>   "Command Documentation".
> 
> * Update for commit a3c45b3e629 (qapi: New special feature flag
>   "unstable"): supply the required feature, deemphasize the x- prefix.
> 
> * Update for commit dd98234c059 (qapi: introduce x-query-roms QMP
>   command): rephrase from "add new command" to "examine existing
>   command".
> 
> * Update for commit 9492718b7c0 (qapi misc: Elide redundant has_FOO in
>   generated C): hello-world's message argument no longer comes with a
>   has_message, add a second argument that does.
> 
> * Update for moved and renamed files.
> 
> While there, update QMP version output to current output.

Nice cleanups.

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  docs/devel/writing-monitor-commands.rst | 460 ++++++++++--------------
>  1 file changed, 181 insertions(+), 279 deletions(-)

>  
> -The "type" keyword defines a new QAPI type. Its "data" member contains the
> -type's members. In this example our members are the "clock-name" and the
> -"next-deadline" one, which is optional.
> +The "struct" keyword defines a new QAPI type. Its "data" member
> +contains the type's members. In this example our members are
> +"filename" and "bootindex".  The latter is optional.

Is there any rhyme or reason behind one vs. two spaces after sentences here?

>  
>  The HMP command
>  ~~~~~~~~~~~~~~~
>  
> -Here's the HMP counterpart of the query-alarm-clock command::
> +Here's the HMP counterpart of the query-option-roms command::
>  
> - void hmp_info_alarm_clock(Monitor *mon)
> + void hmp_info_option_roms(Monitor *mon, const QDict *qdict)
>   {
> -     QemuAlarmClock *clock;
>       Error *err = NULL;
> +     OptionRomInfoList *info_list, *tail;
> +     OptionRomInfo *info;
>  
> -     clock = qmp_query_alarm_clock(&err);
> +     info_list = qmp_query_option_roms(&err);
>       if (hmp_handle_error(mon, err)) {
> -         return;
> +	 return;

Was the change to TAB intentional?

>       }
>  
> -     monitor_printf(mon, "Alarm clock method in use: '%s'\n", clock->clock_name);
> -     if (clock->has_next_deadline) {
> -         monitor_printf(mon, "Next alarm will fire in %" PRId64 " nanoseconds\n",
> -                        clock->next_deadline);
> +     for (tail = info_list; tail; tail = tail->next) {
> +	 info = tail->value;
> +	 monitor_printf(mon, "%s", info->filename);
> +	 if (info->has_bootindex) {
> +	     monitor_printf(mon, " %" PRId64, info->bootindex);
> +	 }
> +	 monitor_printf(mon, "\n");
>       }

More TABs.

>  Writing a debugging aid returning unstructured text
>  ---------------------------------------------------
...
> -The ``HumanReadableText`` struct is intended to be used for all
> -commands, under the ``x-`` name prefix that are returning unstructured
> -text targeted at humans. It should never be used for commands outside
> -the ``x-`` name prefix, as those should be using structured QAPI types.
> +The ``HumanReadableText`` struct is defined in qapi/common.json as a
> +struct with a string member. It is intended to be used for all
> +commands that are returning unstructured text targeted at
> +humans. These should all have feature 'unstable'.  Note that the
> +feature's documentation states why the command is unstable.  WE

We

> +commonly use a ``x-`` command name prefix to make lack of stability
> +obvious to human users.
>  

Cleanups are trivial enough that I'm fine with you making them before
including:

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


