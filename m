Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03024C53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 12:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woKEW-0006PO-2i; Mon, 27 Jul 2026 08:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1woKEJ-0006Nu-Tj
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 08:14:49 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1woKEH-0007YR-I2
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 08:14:47 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.99.1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1woKE4-00000001OT8-1hf0; Mon, 27 Jul 2026 14:14:32 +0200
Message-ID: <793f2d27-cf2e-4e27-ac4e-e94fa6db0e05@maciej.szmigiero.name>
Date: Mon, 27 Jul 2026 14:14:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] migration/cpr: Add HMP support for cpr-transfer
To: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de,
 mark.kanda@oracle.com, bchaney@akamai.com
References: <20260724094119.90581-1-dongli.zhang@oracle.com>
 <amaqaePN2wAWoUCN@gallifrey>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <amaqaePN2wAWoUCN@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
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

On 27.07.2026 02:46, Dr. David Alan Gilbert wrote:
> * Dongli Zhang (dongli.zhang@oracle.com) wrote:
>> Currently the cpr-transfer source QEMU instance cannot be driven entirely
>> via HMP.  The source must use QMP in order to specify both the
>> main migration channel and the CPR channel.
>>
>> Extend the HMP migrate command with an optional CPR channel URI. When the
>> migration mode is cpr-transfer, HMP uses this URI to build a
>> CPR MigrationChannel in addition to the main migration channel. The new
>> option is rejected unless the migration mode is cpr-transfer, so existing
>> HMP migrate usage is unchanged.
>>
>> For example, source QEMU HMP commands can be something like below. The
>> "-c unix:/tmp/cpr.sock" is for CPR URI.
>>
>> (qemu) migrate_set_parameter mode cpr-transfer
>> (qemu) migrate -c unix:/tmp/cpr.sock tcp:0:50002
>>
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>> ---
>> v1->v2:
>>    - Use the '-c' option in the HMP command reference.
>>    - Use "a second uri can only be used in cpr-transfer mode" as error
>>      message.
> 
> Thanks for making those changes; minor note below.
> 
>>   hmp-commands.hx                | 12 ++++++++----
>>   migration/migration-hmp-cmds.c | 19 +++++++++++++++++++
>>   2 files changed, 27 insertions(+), 4 deletions(-)
>>
>> diff --git a/hmp-commands.hx b/hmp-commands.hx
>> index 7ae2468a3d..7f43cf537f 100644
>> --- a/hmp-commands.hx
>> +++ b/hmp-commands.hx
>> @@ -928,16 +928,17 @@ ERST
>>   
>>       {
>>           .name       = "migrate",
>> -        .args_type  = "detach:-d,resume:-r,uri:s",
>> -        .params     = "[-d] [-r] uri",
>> +        .args_type  = "detach:-d,resume:-r,uri-cpr:-cs,uri:s",
>> +        .params     = "[-d] [-r] [-c uri-cpr] uri",
>>           .help       = "migrate to URI (using -d to not wait for completion)"
>> -		      "\n\t\t\t -r to resume a paused postcopy migration",
>> +		      "\n\t\t\t -r to resume a paused postcopy migration"
>> +		      "\n\t\t\t -c to specify a CPR URI for cpr-transfer mode",
>>           .cmd        = hmp_migrate,
>>       },
>>   
>>   
>>   SRST
>> -``migrate [-d] [-r]`` *uri*
>> +``migrate [-d] [-r] [-c uri-cpr]`` *uri*
>>     Migrate the VM to *uri*.
>>   
>>     ``-d``
>> @@ -945,6 +946,9 @@ SRST
>>       query an ongoing migration process, use "info migrate".
>>     ``-r``
>>       Resume a paused postcopy migration.
>> +  ``-c`` *uri-cpr*
>> +    Specify the CPR URI for cpr-transfer mode. It must be a UNIX domain
>> +    socket.
>>   ERST
>>   
>>       {
>> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
>> index b04fc4489f..4ca2c962c2 100644
>> --- a/migration/migration-hmp-cmds.c
>> +++ b/migration/migration-hmp-cmds.c
>> @@ -837,9 +837,11 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>>       bool detach = qdict_get_try_bool(qdict, "detach", false);
>>       bool resume = qdict_get_try_bool(qdict, "resume", false);
>>       const char *uri = qdict_get_str(qdict, "uri");
>> +    const char *uri_cpr = qdict_get_try_str(qdict, "uri-cpr");
>>       Error *err = NULL;
>>       g_autoptr(MigrationChannelList) caps = NULL;
>>       g_autoptr(MigrationChannel) channel = NULL;
>> +    g_autoptr(MigrationChannel) channel_cpr = NULL;
>>   
>>       if (!migrate_uri_parse(uri, &channel, &err)) {
>>           hmp_handle_error(mon, err);
>> @@ -847,6 +849,23 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>>       }
>>       QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
>>   
>> +    if (uri_cpr) {
>> +        if (migrate_mode() != MIG_MODE_CPR_TRANSFER) {
>> +            error_setg(&err,
>> +                       "a second uri can only be used in cpr-transfer mode");
> 
> That should probably be changed to something like
>    "-c can only be used in cpr-transfer mode"
> 
> but other than that,
> 
> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> (Feel free to take it via cpr or migration).

Acked-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com> # for CPR

I am fine with this going in through migration tree if that's not
a problem since there's currently nothing else for CPR.
> Dave

Thanks,
Maciej


