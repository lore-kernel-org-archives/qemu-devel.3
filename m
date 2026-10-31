Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC05E606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=comstyle.com header.i=@comstyle.com header.a=rsa-sha256 header.s=default header.b=jAPi5xtZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNGVY-0006Aa-0o; Sat, 31 Oct 2026 17:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1xNGVW-0006AP-FJ
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 17:20:58 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1xNGVU-0007Hj-NX
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 17:20:58 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4jH9qq14Bdz8Pbj;
 Sat, 31 Oct 2026 17:20:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=default;
 bh=E15AUcnI/H2ByM8R3jPI8uhJK9HeRxJJKolF3G4F2P0=; b=jAPi5xtZOXTd
 URT817z7JXhzBT0FGcgNQuffC3lc0K2xDYmN+en8VJFRPsUg+y1YXw1fiI3b/OJZ
 MeGki4Pc99WHos0op82UG44UA5mfNR3VgcUZi72TdiGsbRO6IC1164uAMqVn9/No
 0SjLwCYLoJXLidfr11uDHSfjxy0WtBY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=message-id
 :date:mime-version:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding; q=dns; s=default; b=AuN
 X8JVTnVN/DMcKy7gkTfhaNzZLbuSdudALQlJrU7yvHYHuq5iy1+BIOPp00x4GP5s
 +wSz9IyxXdIDd0rDLZ8V5WeSsCCs+TRTMfDX+B5H0E/rGnd39CofeagU1BBP/rux
 1B0fbQswUoIDuQaRCc5uKnUHpIgy0CRCFHwQAEt8=
Received: from [192.168.6.99] (66-49-215-17.cpe.distributel.net [66.49.215.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4jH9qq0DjRz8Pbg;
 Sat, 31 Oct 2026 17:20:55 -0400 (EDT)
Message-ID: <90b3b643-56af-4b43-9df6-e7481030c95f@comstyle.com>
Date: Sat, 31 Oct 2026 17:20:53 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/unit/test-qga: only run tests for commands the host
 provides
To: Roman Bogorodskiy <bogorodskiy@gmail.com>
Cc: Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org
References: <auUjhZW4dqR63oA3@humpty.home.comstyle.com> <auXnOpeNx5eToSWA@tulp>
Content-Language: en-US
From: Brad Smith <brad@comstyle.com>
In-Reply-To: <auXnOpeNx5eToSWA@tulp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f938:3000:8::2;
 envelope-from=brad@comstyle.com; helo=mail.comstyle.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-31 9:03 a.m., Roman Bogorodskiy wrote:
>    Brad Smith wrote:
>
>> tests/unit/test-qga: only run tests for commands the host provides
>>
>> guest-fsfreeze-status is only implemented when CONFIG_FSFREEZE is
>> set (Linux and FreeBSD), and guest-get-users is only built on POSIX
>> hosts when HAVE_UTMPX is set, so neither command exists on hosts such
>> as OpenBSD. Only build and register these tests where the commands
>> are available.
> Does that also need something like:
>
> --- a/tests/unit/meson.build
> +++ b/tests/unit/meson.build
> @@ -170,7 +170,7 @@ if have_system
>     tests += {'test-qdev': [qom, hwcore]}
>   endif
>
> -if have_ga and host_os in ['freebsd', 'linux']
> +if have_ga and host_os in ['freebsd', 'linux', 'openbsd']
>     tests += {'test-qga': ['../qtest/libqmp.c', '../qtest/libqtest.c']}
>     test_deps += {'test-qga': qga}
>   endif
>
> Otherwise it's not clear how to spot these issues if the test never runs
> on OpenBSD.
There are multiple patches pending. Once they're in then I'll send the 
proper patch.
>> Signed-off-by: Brad Smith <brad@comstyle.com>
>> ---
>>   tests/unit/test-qga.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/tests/unit/test-qga.c b/tests/unit/test-qga.c
>> index b1c84c188b..ef796f2f7d 100644
>> --- a/tests/unit/test-qga.c
>> +++ b/tests/unit/test-qga.c
>> @@ -787,6 +787,7 @@ static void test_qga_config(gconstpointer data)
>>       g_free(env[0]);
>>   }
>>   
>> +#ifdef CONFIG_FSFREEZE
>>   static void test_qga_fsfreeze_status(gconstpointer fix)
>>   {
>>       const TestFixture *fixture = fix;
>> @@ -800,6 +801,7 @@ static void test_qga_fsfreeze_status(gconstpointer fix)
>>       status = qdict_get_try_str(ret, "return");
>>       g_assert_cmpstr(status, ==, "thawed");
>>   }
>> +#endif
>>   
>>   static QDict *wait_for_guest_exec_completion(int fd, int64_t pid)
>>   {
>> @@ -1028,6 +1030,7 @@ static void test_qga_guest_get_timezone(gconstpointer fix)
>>       g_assert(qdict_haskey(val, "offset"));
>>   }
>>   
>> +#ifdef HAVE_UTMPX
>>   static void test_qga_guest_get_users(gconstpointer fix)
>>   {
>>       const TestFixture *fixture = fix;
>> @@ -1042,6 +1045,7 @@ static void test_qga_guest_get_users(gconstpointer fix)
>>       val = qdict_get_qlist(ret, "return");
>>       g_assert_nonnull(val);
>>   }
>> +#endif
>>   
>>   static void test_qga_guest_get_osinfo(gconstpointer data)
>>   {
>> @@ -1133,8 +1137,10 @@ int main(int argc, char **argv)
>>       g_test_add_data_func("/qga/invalid-oob", &fix, test_qga_invalid_oob);
>>       g_test_add_data_func("/qga/invalid-cmd", &fix, test_qga_invalid_cmd);
>>       g_test_add_data_func("/qga/invalid-args", &fix, test_qga_invalid_args);
>> +#ifdef CONFIG_FSFREEZE
>>       g_test_add_data_func("/qga/fsfreeze-status", &fix,
>>                            test_qga_fsfreeze_status);
>> +#endif
>>   
>>       g_test_add_data_func("/qga/blockedrpcs", NULL, test_qga_blockedrpcs);
>>       g_test_add_data_func("/qga/allowedrpcs", NULL, test_qga_allowedrpcs);
>> @@ -1152,8 +1158,10 @@ int main(int argc, char **argv)
>>                            test_qga_guest_get_host_name);
>>       g_test_add_data_func("/qga/guest-get-timezone", &fix,
>>                            test_qga_guest_get_timezone);
>> +#ifdef HAVE_UTMPX
>>       g_test_add_data_func("/qga/guest-get-users", &fix,
>>                            test_qga_guest_get_users);
>> +#endif
>>   
>>       ret = g_test_run();
>>   
>> -- 
>> 2.56.0
>>
>>

