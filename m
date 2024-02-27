Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A007C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 15:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rezWo-0000PA-N5; Tue, 27 Feb 2024 10:37:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rezWn-0000Op-Nx
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 10:37:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rezWk-0006B4-5l
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 10:37:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709048272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F86J17vv4CKEVZZck6UnyKWk8eMHZXN+as5XYbkbljw=;
 b=ASIQhHW89ZtvKwt8A+6WWiJN1esHcXm5cg6RDEfjlqq6fIsOEygBrVdgzhEvipSk2S2uuX
 XpUwCVmfsDUpGJOdkGA+aRg/X3db4LEbWILi6W+5XstB2DX1SuYM+usEpWWKSTtiVNyC+S
 Z8R+8sxC/nig+ovhjB5PstZiyORa5qI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-r85HtGJINgCYxNs9t_GqKA-1; Tue,
 27 Feb 2024 10:37:50 -0500
X-MC-Unique: r85HtGJINgCYxNs9t_GqKA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D8A51C29EBB
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 15:37:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C33AA2026D06
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 15:37:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CD38621E66F4; Tue, 27 Feb 2024 16:37:48 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com
Subject: Re: [PATCH 1/2] docs/devel/writing-monitor-commands: Repair a
 decade of rot
In-Reply-To: <zhvqwgl7rgg54gdjcnygx3pmlsimhyxu4j73l254kcmehkh66s@6jvrzmhgupum>
 (Eric Blake's message of "Tue, 27 Feb 2024 08:53:35 -0600")
References: <20240227115617.237875-1-armbru@redhat.com>
 <20240227115617.237875-2-armbru@redhat.com>
 <zhvqwgl7rgg54gdjcnygx3pmlsimhyxu4j73l254kcmehkh66s@6jvrzmhgupum>
Date: Tue, 27 Feb 2024 16:37:48 +0100
Message-ID: <87r0gxapf7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Eric Blake <eblake@redhat.com> writes:

> On Tue, Feb 27, 2024 at 12:56:16PM +0100, Markus Armbruster wrote:
>> The tutorial doesn't match reality since at least 2013.  Repairing it
>> involves fixing the following issues:
>> 
>> * Update for commit 6d327171551 (aio / timers: Remove alarm timers):
>>   replace the broken examples.  Instead of having one for returning a
>>   struct and another for returning a list of structs, do just one for
>>   the latter.  This resolves the FIXME added in commit
>>   e218052f928 (aio / timers: De-document -clock) back in 2014.
>> 
>> * Update for commit 895a2a80e0e (qapi: Use 'struct' instead of 'type'
>>   in schema).
>> 
>> * Update for commit 3313b6124b5 (qapi: add qapi2texi script): add
>>   required documentation to the schema snippets, and drop section
>>   "Command Documentation".
>> 
>> * Update for commit a3c45b3e629 (qapi: New special feature flag
>>   "unstable"): supply the required feature, deemphasize the x- prefix.
>> 
>> * Update for commit dd98234c059 (qapi: introduce x-query-roms QMP
>>   command): rephrase from "add new command" to "examine existing
>>   command".
>> 
>> * Update for commit 9492718b7c0 (qapi misc: Elide redundant has_FOO in
>>   generated C): hello-world's message argument no longer comes with a
>>   has_message, add a second argument that does.
>> 
>> * Update for moved and renamed files.
>> 
>> While there, update QMP version output to current output.
>
> Nice cleanups.

Thanks!

>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  docs/devel/writing-monitor-commands.rst | 460 ++++++++++--------------
>>  1 file changed, 181 insertions(+), 279 deletions(-)
>
>>  
>> -The "type" keyword defines a new QAPI type. Its "data" member contains the
>> -type's members. In this example our members are the "clock-name" and the
>> -"next-deadline" one, which is optional.
>> +The "struct" keyword defines a new QAPI type. Its "data" member
>> +contains the type's members. In this example our members are
>> +"filename" and "bootindex".  The latter is optional.
>
> Is there any rhyme or reason behind one vs. two spaces after sentences here?

Accident.  I habitually use two spaces, but this document uses just one.
I tried to be locally consistent, but habit won in this case.  I'll fix
it.

>>  
>>  The HMP command
>>  ~~~~~~~~~~~~~~~
>>  
>> -Here's the HMP counterpart of the query-alarm-clock command::
>> +Here's the HMP counterpart of the query-option-roms command::
>>  
>> - void hmp_info_alarm_clock(Monitor *mon)
>> + void hmp_info_option_roms(Monitor *mon, const QDict *qdict)
>>   {
>> -     QemuAlarmClock *clock;
>>       Error *err = NULL;
>> +     OptionRomInfoList *info_list, *tail;
>> +     OptionRomInfo *info;
>>  
>> -     clock = qmp_query_alarm_clock(&err);
>> +     info_list = qmp_query_option_roms(&err);
>>       if (hmp_handle_error(mon, err)) {
>> -         return;
>> +	 return;
>
> Was the change to TAB intentional?

Another accident.

>
>>       }
>>  
>> -     monitor_printf(mon, "Alarm clock method in use: '%s'\n", clock->clock_name);
>> -     if (clock->has_next_deadline) {
>> -         monitor_printf(mon, "Next alarm will fire in %" PRId64 " nanoseconds\n",
>> -                        clock->next_deadline);
>> +     for (tail = info_list; tail; tail = tail->next) {
>> +	 info = tail->value;
>> +	 monitor_printf(mon, "%s", info->filename);
>> +	 if (info->has_bootindex) {
>> +	     monitor_printf(mon, " %" PRId64, info->bootindex);
>> +	 }
>> +	 monitor_printf(mon, "\n");
>>       }
>
> More TABs.

Will expand them all.

>>  Writing a debugging aid returning unstructured text
>>  ---------------------------------------------------
> ...
>> -The ``HumanReadableText`` struct is intended to be used for all
>> -commands, under the ``x-`` name prefix that are returning unstructured
>> -text targeted at humans. It should never be used for commands outside
>> -the ``x-`` name prefix, as those should be using structured QAPI types.
>> +The ``HumanReadableText`` struct is defined in qapi/common.json as a
>> +struct with a string member. It is intended to be used for all
>> +commands that are returning unstructured text targeted at
>> +humans. These should all have feature 'unstable'.  Note that the
>> +feature's documentation states why the command is unstable.  WE
>
> We

Will fix.

>> +commonly use a ``x-`` command name prefix to make lack of stability
>> +obvious to human users.
>>  
>
> Cleanups are trivial enough that I'm fine with you making them before
> including:
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!


