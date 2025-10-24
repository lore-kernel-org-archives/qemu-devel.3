Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278A7CCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 09:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCDeo-0007jH-1v; Fri, 24 Oct 2025 05:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1vCDel-0007im-CG
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 05:00:19 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1vCDeh-0008Oy-W7
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 05:00:19 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 6A950807EC;
 Fri, 24 Oct 2025 12:00:10 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8011:f00:2dbc:c49f:af56:b499] (unknown
 [2a02:6bf:8011:f00:2dbc:c49f:af56:b499])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id sxUJ1m0Iw0U0-eV3gBy4d; Fri, 24 Oct 2025 12:00:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761296410;
 bh=I7TTy8u/3nqH22ZW7FMstrd2u5IYtCe469x0Lt/gGUw=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=ZpgaX/ZYz3ME3/XPm2jAjK7mLpCWnFdgS7uPO+FjYY9n+KMvKJIE/0SK97acIVE6Z
 xTS7UWwPHeSHZ71GCLGiFPfEOpfow6z+BGLl3M+KH1Pn93pVUM+hT1alp5nppEk2uq
 0ezyScVaerXVYHHvgVixdaGfc+XT2lywsqTqXbPE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <ef02dae2-dcc2-49ca-bfbf-0248947638bf@yandex-team.ru>
Date: Fri, 24 Oct 2025 11:59:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] scripts/compare-mt: stop using global variables
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: crosa@redhat.com, jsnow@redhat.com, philmd@linaro.org,
 qemu-devel@nongnu.org
References: <20251023165846.326295-1-davydov-max@yandex-team.ru>
 <20251023165846.326295-3-davydov-max@yandex-team.ru>
 <f5baf6f3-5b9f-4e12-839b-32d1a269ab5b@yandex-team.ru>
Content-Language: en-US
From: Maksim Davydov <davydov-max@yandex-team.ru>
In-Reply-To: <f5baf6f3-5b9f-4e12-839b-32d1a269ab5b@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=davydov-max@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Thanks for reviewing!

On 10/23/25 21:45, Vladimir Sementsov-Ogievskiy wrote:
> On 23.10.25 19:58, Maksim Davydov wrote:
>> All variables inside the main if-structure are global that can be
>> confusing or be the reason of an issue. So, all code inside this 
>> structure
>> was moved to the separate function to detect all usages of these global
>> variables. All these usages were deleted.
>>
> 
> May be mention, that Configuration._qemu_args was unused.

Yes, I'll add a comment about _qemu_args to the commit message.

> 
>> Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
> 
> 
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
>> ---
>>   scripts/compare-machine-types.py | 19 +++++++++++--------
>>   1 file changed, 11 insertions(+), 8 deletions(-)
>>
>> diff --git a/scripts/compare-machine-types.py b/scripts/compare- 
>> machine-types.py
>> index dba9e03548..e6fcea22e1 100755
>> --- a/scripts/compare-machine-types.py
>> +++ b/scripts/compare-machine-types.py
>> @@ -264,7 +264,6 @@ def __init__(self, vm: QEMUMachine,
>>                    req_mt: List[str], all_mt: bool) -> None:
>>           self._vm = vm
>>           self._binary = vm.binary
>> -        self._qemu_args = args.qemu_args.split(' ')
>>           self._qemu_drivers = VMPropertyGetter(vm)
>>           self.req_mt = get_req_mt(self._qemu_drivers, vm, req_mt, 
>> all_mt)
>> @@ -482,17 +481,17 @@ def fill_prop_table(configs: List[Configuration],
>>   def print_table(table: pd.DataFrame, table_format: str) -> None:
>>       if table_format == 'json':
>> -        print(comp_table.to_json())
>> +        print(table.to_json())
>>       elif table_format == 'csv':
>> -        print(comp_table.to_csv())
>> +        print(table.to_csv())
>>       else:
>> -        print(comp_table.to_markdown(index=False, stralign='center',
>> -                                     colalign=('center',), 
>> headers='keys',
>> -                                     tablefmt='fancy_grid',
>> -                                     disable_numparse=True))
>> +        print(table.to_markdown(index=False, stralign='center',
>> +                                colalign=('center',), headers='keys',
>> +                                tablefmt='fancy_grid',
>> +                                disable_numparse=True))
>> -if __name__ == '__main__':
>> +def main() -> None:
>>       args = parse_args()
>>       with ExitStack() as stack:
>>           vms = [stack.enter_context(QEMUMachine(binary=binary, 
>> qmp_timer=15,
>> @@ -506,3 +505,7 @@ def print_table(table: pd.DataFrame, table_format: 
>> str) -> None:
>>           comp_table = fill_prop_table(configurations, args.raw)
>>           if not comp_table.empty:
>>               print_table(comp_table, args.format)
>> +
>> +
>> +if __name__ == '__main__':
>> +    main()
> 
> 

-- 
Best regards,
Maksim Davydov


