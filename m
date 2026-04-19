Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C45EA7189
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2026 08:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wENkN-0001t5-Ib; Sun, 19 Apr 2026 04:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wENkM-0001ss-04
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 04:43:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wENkJ-000653-Qx
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 04:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776588192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qESMAqD1fY4qO7RbNG5Yb1Mbj+Ze/k8hXFw0imkmHcg=;
 b=H2zx6f5GFqcJMKaqrrKyrjCp1ycfCyl1bDzaUXWNVJxSmt9SKXktYS3Lpmp6aZwCKLaYXP
 RgNCDBqrEc1FU0LFZy5dFrCCUTbHxGz5Kh8FeKVJPwPJEs1rx8AeIJ22uLE/EYqgIE7AL3
 pJgVkHSnyAZ2PAd7QhEN4ZkNccoNcXs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-Ijxla7aaPj6iLmEV4XQnCQ-1; Sun,
 19 Apr 2026 04:43:11 -0400
X-MC-Unique: Ijxla7aaPj6iLmEV4XQnCQ-1
X-Mimecast-MFC-AGG-ID: Ijxla7aaPj6iLmEV4XQnCQ_1776588190
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE963195608F; Sun, 19 Apr 2026 08:43:09 +0000 (UTC)
Received: from [10.44.32.46] (unknown [10.44.32.46])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 92DB21801481; Sun, 19 Apr 2026 08:43:08 +0000 (UTC)
Message-ID: <10f96e1a-dcd9-49f4-aff2-1549f88e50a4@redhat.com>
Date: Sun, 19 Apr 2026 09:43:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] monitor: Add `clear` command
To: "Dr. David Alan Gilbert" <dave@treblig.org>, AlanoSong@163.com
Cc: qemu-devel@nongnu.org
References: <20260418133927.43012-1-AlanoSong@163.com>
 <aeO-IqKqBwtKfW8P@gallifrey>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aeO-IqKqBwtKfW8P@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

On 4/18/26 19:23, Dr. David Alan Gilbert wrote:
> * AlanoSong@163.com (AlanoSong@163.com) wrote:
>> The monitor screen can be cluttered after executing commands
>> like `info qtree`. It is useful to have a command to clear
>> current screen, just like linux `clear` command do.
>>
>> This patch has been tested under monitors using stdio, vc,
>> tcp socket, unix socket and serial interfaces.
>>
>> Signed-off-by: Alano Song <AlanoSong@163.com>
> 
> Does typing ctrl-l not do it for you in your terminal?

Yeah, we should add support for Ctrl-L to the non-terminal backends 
independent of this.  However, backends such as socket do not use 
readline so they also don't support it right now.

Paolo

> Dave
> 
>> ---
>>   hmp-commands.hx       | 14 ++++++++++++++
>>   include/monitor/hmp.h |  1 +
>>   monitor/hmp-cmds.c    |  5 +++++
>>   3 files changed, 20 insertions(+)
>>
>> diff --git a/hmp-commands.hx b/hmp-commands.hx
>> index 5cc4788f12..95f9166732 100644
>> --- a/hmp-commands.hx
>> +++ b/hmp-commands.hx
>> @@ -20,6 +20,20 @@ SRST
>>     Show the help for all commands or just for command *cmd*.
>>   ERST
>>   
>> +    {
>> +        .name       = "clear",
>> +        .args_type  = "",
>> +        .params     = "",
>> +        .help       = "clear the monitor screen",
>> +        .cmd        = hmp_clear,
>> +        .flags      = "p",
>> +    },
>> +
>> +SRST
>> +``clear``
>> +  Clear the monitor screen.
>> +ERST
>> +
>>       {
>>           .name       = "commit",
>>           .args_type  = "device:B",
>> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
>> index e222bea60c..9b66458d21 100644
>> --- a/include/monitor/hmp.h
>> +++ b/include/monitor/hmp.h
>> @@ -165,6 +165,7 @@ void hmp_trace_event(Monitor *mon, const QDict *qdict);
>>   void hmp_trace_file(Monitor *mon, const QDict *qdict);
>>   void hmp_info_trace_events(Monitor *mon, const QDict *qdict);
>>   void hmp_help(Monitor *mon, const QDict *qdict);
>> +void hmp_clear(Monitor *mon, const QDict *qdict);
>>   void hmp_info_help(Monitor *mon, const QDict *qdict);
>>   void hmp_info_sync_profile(Monitor *mon, const QDict *qdict);
>>   void hmp_info_history(Monitor *mon, const QDict *qdict);
>> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
>> index bc26b39d70..3e9485478e 100644
>> --- a/monitor/hmp-cmds.c
>> +++ b/monitor/hmp-cmds.c
>> @@ -218,6 +218,11 @@ void hmp_help(Monitor *mon, const QDict *qdict)
>>       hmp_help_cmd(mon, qdict_get_try_str(qdict, "name"));
>>   }
>>   
>> +void hmp_clear(Monitor *mon, const QDict *qdict)
>> +{
>> +    monitor_printf(mon, "\x1b[3J\x1b[2J\x1b[H");
>> +}
>> +
>>   void hmp_info_help(Monitor *mon, const QDict *qdict)
>>   {
>>       hmp_help_cmd(mon, "info");
>> -- 
>> 2.43.0
>>


