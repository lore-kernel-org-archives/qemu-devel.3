Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B527BC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 22:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9XPo-0001wc-Jw; Mon, 28 Apr 2025 18:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kevans@FreeBSD.org>)
 id 1u9XPm-0001vi-8k
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 18:57:30 -0400
Received: from mx2.freebsd.org ([96.47.72.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kevans@FreeBSD.org>)
 id 1u9XPg-0004Hp-Dr
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 18:57:29 -0400
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4Zmf3M0LVqz4xwx;
 Mon, 28 Apr 2025 22:57:19 +0000 (UTC)
 (envelope-from kevans@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org
 [IPv6:2610:1c1:1:606c::24b:4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "R11" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4Zmf3L5xxfz3SSL;
 Mon, 28 Apr 2025 22:57:18 +0000 (UTC)
 (envelope-from kevans@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1745881038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qJNDogvNyKuUIlvJwhKuoG+9u9Z5JNQVlxA5mQ1dCQI=;
 b=YlDARHWaIlNcZt4KI3IxJHNBlGd7to/nrHu3A/w+hv84pPTi5+QzJ+oMCBkOxch43Ffnxl
 vafuXcs8z1K0RzKsqYeDxReRX2JUV4fA/7+fryBpmh5w4WVZH1jOtNOcsAfdKJhg4HF2Lq
 3JL2aypbY0V/wECujJa7nfddWd7DbfiC5P9lSyf+WC0t6+Upm9sy+Va+dq2KKGOecvfA+9
 EEOPT45Lc227blgpWL0euMLhbCXsngUAWBQmXe3OGabkEqaQcRPN6jkWDE6CFcmOIJJ9Fi
 vGNkJ50d0+eZuJeex7XVpL8zUjb3OUZk07lpONJ6VHi46bFMriMlZoyibUJUoA==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1745881038; a=rsa-sha256; cv=none;
 b=CiJik9KiEZnWZ+kmvUciU1iCwTGqcckOAXwa9tlYEJPA1BX9GsxQpXY1EY067dA5vLdudT
 lirPQn8ltJwdwzxWXwF0c7AFf7x7Lzw5J5/QUqdS0ig+ulMldx6kHSw2jaTAeQz4nK8eMR
 qUpB84q44A8/560PxhdyKE9AQ+hSWbq/e+Z/98rWGS28+r3FvNANMoP3E61vRLywFEw8J5
 VgdX/USUbP11e1RA1jGDlgXBGPys9I9dDDtNoMyUkeoNctFzXhswQWvNqBHQUCVkwxVOXi
 sL8N/jUClgkODxJUuv3TF5/g7fbJyxzzepTRIfSkMNpxyD6C1wFdF2q7QQQFGg==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1745881038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qJNDogvNyKuUIlvJwhKuoG+9u9Z5JNQVlxA5mQ1dCQI=;
 b=ZpfLOtTww7PqeT9Z2H3WGT72RQCCviOrzcByc3KYbKhe39FlNPj/p7jJ6ru2f2+LrYy7w/
 g1jtV5g9PSfzdhOY9VzaQHVnfzxyrdtJ3ZY6OXONTLDPmk1Yb9GT/rMu3oCeFYrTnsN0Dl
 L50F7/DGZg7sikyVO2qnAYkIpKxQuI4wOo9QqUaIxSDnDRF4XuGOqysjs+C+YJDOP4u6Sr
 xVwXHHPcK5HDrunNzskJoDZDAK+VcaKr5yGb7tXCCI9Fwp+kaWPIComNA/gIsqklFHL0Yy
 OUrCm90JXAMheKqd41Il/6IWoggNAjoLD9IJbP6vQ9jlrdlB+AN+0GsgP27iQw==
Received: from [10.9.4.95] (unknown [209.182.120.176])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 (Authenticated sender: kevans/mail)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4Zmf3L2MvSz2hs;
 Mon, 28 Apr 2025 22:57:18 +0000 (UTC)
 (envelope-from kevans@FreeBSD.org)
Message-ID: <a7cc7e54-b84d-44e1-8c75-df39b44dd28f@FreeBSD.org>
Date: Mon, 28 Apr 2025 17:57:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bsd-user: add option to enable plugins
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, richard.henderson@linaro.org,
 alex.bennee@linaro.org
References: <20250331234228.3475706-1-pierrick.bouvier@linaro.org>
 <0a39e805-eb75-4b88-b316-189acad38efa@linaro.org>
Content-Language: en-US
From: Kyle Evans <kevans@FreeBSD.org>
In-Reply-To: <0a39e805-eb75-4b88-b316-189acad38efa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=96.47.72.81; envelope-from=kevans@FreeBSD.org;
 helo=mx2.freebsd.org
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/28/25 14:36, Pierrick Bouvier wrote:
> On 3/31/25 4:42 PM, Pierrick Bouvier wrote:
>> Nothing prevent plugins to be enabled on this platform for user
>> binaries, only the option in the driver is missing.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   bsd-user/main.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/bsd-user/main.c b/bsd-user/main.c
>> index fdb160bed0f..329bd1acc02 100644
>> --- a/bsd-user/main.c
>> +++ b/bsd-user/main.c
>> @@ -175,6 +175,9 @@ static void usage(void)
>>              "-strace           log system calls\n"
>>              "-trace            [[enable=]<pattern>][,events=<file>] 
>> [,file=<file>]\n"
>>              "                  specify tracing options\n"
>> +#ifdef CONFIG_PLUGIN
>> +           "-plugin           [file=]<file>[,<argname>=<argvalue>]\n"
>> +#endif
>>              "\n"
>>              "Environment variables:\n"
>>              "QEMU_STRACE       Print system calls and arguments 
>> similar to the\n"
>> @@ -225,6 +228,8 @@ static void init_task_state(TaskState *ts)
>>       };
>>   }
>> +static QemuPluginList plugins = QTAILQ_HEAD_INITIALIZER(plugins);
>> +
>>   void gemu_log(const char *fmt, ...)
>>   {
>>       va_list ap;
>> @@ -307,6 +312,7 @@ int main(int argc, char **argv)
>>       cpu_model = NULL;
>>       qemu_add_opts(&qemu_trace_opts);
>> +    qemu_plugin_add_opts();
>>       optind = 1;
>>       for (;;) {
>> @@ -399,6 +405,11 @@ int main(int argc, char **argv)
>>               do_strace = 1;
>>           } else if (!strcmp(r, "trace")) {
>>               trace_opt_parse(optarg);
>> +#ifdef CONFIG_PLUGIN
>> +        } else if (!strcmp(r, "plugin")) {
>> +            r = argv[optind++];
>> +            qemu_plugin_opt_parse(r, &plugins);
>> +#endif
>>           } else if (!strcmp(r, "0")) {
>>               argv0 = argv[optind++];
>>           } else {
>> @@ -433,6 +444,7 @@ int main(int argc, char **argv)
>>           exit(1);
>>       }
>>       trace_init_file();
>> +    qemu_plugin_load_list(&plugins, &error_fatal);
>>       /* Zero out regs */
>>       memset(regs, 0, sizeof(struct target_pt_regs));
> 
> Gentle ping on this series.
> As we didn't have any feedback from BSD side, could we consider to 
> enable this upstream?
> 

Sorry- I have no strong opinion on plugins, but the diff looks 
incredibly reasonable and non-invasive.  I'm not really seeing any 
reason we'd object, but I don't personally feel qualified to review this 
(except as a basic human C linter- I can't imagine the added calls 
breaking anything we rely on).

Thanks,

Kyle Evans

