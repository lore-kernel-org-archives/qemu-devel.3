Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957CACAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 14:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvz2k-000065-Tb; Tue, 09 Sep 2025 10:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uvz2h-00005L-Ap
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 10:09:55 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uvz2a-000763-5S
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 10:09:55 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1621:0:640:12d9:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id CA6C780857;
 Tue, 09 Sep 2025 17:09:40 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b64::1:1] (unknown [2a02:6bf:8080:b64::1:1])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id d9KWqV2GvCg0-ZdVEwEEK; Tue, 09 Sep 2025 17:09:40 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757426980;
 bh=KXXkdrzRLIdt7L7eVthhcbZXHIa+ZIf8mHNhyGLTzSo=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=0dHkAjJaH8GoQFCbsS15KdI/hmuXU4Mv3mGdhpf/ET5Yofx3VnyCLTEy3Ee4UyUib
 ub6A73HvaLQ/xLab5FIvyHM1eSp+Sn78t+kOju1lXf89dyGBAVFFysnkiEAfycR8eL
 dqkDlmLPFcQwM8dOs90U+TDmMG8bIlJBJQU8tG8o=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <6add10c2-4613-4e5d-b01e-3ec0d8692a0e@yandex-team.ru>
Date: Tue, 9 Sep 2025 17:09:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] tests/functional:
 exec_command_and_wait_for_pattern: add vm arg
To: Thomas Huth <thuth@redhat.com>, jasowang@redhat.com
Cc: qemu-devel@nongnu.org, leiyang@redhat.com, steven.sistare@oracle.com,
 yc-core@yandex-team.ru, peterx@redhat.com, mst@redhat.com, farosas@suse.de,
 eblake@redhat.com, armbru@redhat.com, philmd@linaro.org, berrange@redhat.com
References: <20250905135039.2202924-1-vsementsov@yandex-team.ru>
 <20250905135039.2202924-8-vsementsov@yandex-team.ru>
 <91a01e52-4ede-4317-b7ef-fc555d3e6825@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <91a01e52-4ede-4317-b7ef-fc555d3e6825@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 09.09.25 17:03, Thomas Huth wrote:
> On 05/09/2025 15.50, Vladimir Sementsov-Ogievskiy wrote:
>> Allow to specify non default vm for the command.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/functional/qemu_test/cmd.py | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
>> index dc5f422b77..28b36a3a54 100644
>> --- a/tests/functional/qemu_test/cmd.py
>> +++ b/tests/functional/qemu_test/cmd.py
>> @@ -172,7 +172,8 @@ def exec_command(test, command):
>>       _console_interaction(test, None, None, command + '\r')
>>   def exec_command_and_wait_for_pattern(test, command,
>> -                                      success_message, failure_message=None):
>> +                                      success_message, failure_message=None,
>> +                                      vm=None):
>>       """
>>       Send a command to a console (appending CRLF characters), then wait
>>       for success_message to appear on the console, while logging the.
>> @@ -184,9 +185,11 @@ def exec_command_and_wait_for_pattern(test, command,
>>       :param command: the command to send
>>       :param success_message: if this message appears, test succeeds
>>       :param failure_message: if this message appears, test fails
>> +    :param vm: the VM to use (defaults to test.vm if None)
>>       """
>>       assert success_message
>> -    _console_interaction(test, success_message, failure_message, command + '\r')
>> +    _console_interaction(test, success_message, failure_message, command + '\r',
>> +                         vm=vm)
> 
>   Hi,
> 
> FYI, there was another patch on the list that does something very similar, and I picked it for my pull request today (since it fixed some more spots):
> 
>   https://lore.kernel.org/qemu-devel/20250909135147.612345-20-thuth@redhat.com/
> 
> ... so once that got merged, you can likely drop this patch from your series.
> 

Good, thanks!


-- 
Best regards,
Vladimir

