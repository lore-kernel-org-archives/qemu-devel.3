Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B218AE87843
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnIjH-0001EB-Qp; Tue, 03 Feb 2026 10:54:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vnIjF-0001DN-7l
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:54:13 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vnIjD-0003ga-5V
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:54:12 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 0B47580C51;
 Tue, 03 Feb 2026 18:54:07 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:52d::1:1f] (unknown
 [2a02:6bf:8080:52d::1:1f])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 5sqUWQ0AECg0-KL8tLvZL; Tue, 03 Feb 2026 18:54:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770134046;
 bh=m9fbE+YFjyn4uyPZzzKwvFsXpTV6a1UGqyUH7nTfXRQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=wZPoanrQ6I+RY1ZIZ8VRtmA9j8qr/rCUt+rrfIDee5sbQ5DV5d6lUjtD38YK6JKKc
 nEC15oV2fvD7WUszAaohAKmeh8yWDyIKc9tQ7r9cymrAK3eRs+i9H9hqJcw1dDCIqK
 JIKYAiS2f+pm7ZGRKCZuewMgHK6M8GW+rkSqw9FI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <3633d0dd-14c1-4445-bcbf-e22db557ec52@yandex-team.ru>
Date: Tue, 3 Feb 2026 18:54:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] tpm_emulator: drop direct use of errno variable
To: Stefan Berger <stefanb@linux.ibm.com>, stefanb@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, armbru@redhat.com, peterx@redhat.com
References: <20260201172746.404481-1-vsementsov@yandex-team.ru>
 <20260201172746.404481-3-vsementsov@yandex-team.ru>
 <6d0b4330-1aba-4f2e-968d-1d64397241de@linux.ibm.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <6d0b4330-1aba-4f2e-968d-1d64397241de@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 03.02.26 18:32, Stefan Berger wrote:
> 
> 
> On 2/1/26 12:27 PM, Vladimir Sementsov-Ogievskiy wrote:
>> The code tends to include errno into error messages after
>> tpm_util_test_tpmdev() and tpm_emulator_ctrlcmd() calls.
>>
>> Both has error paths, where errno is not set, examples:
>>
>> tpm_emulator_ctrlcmd()
>>    qemu_chr_fe_write_all()
>>      qemu_chr_write()
>>        replay_char_write_event_load()
>>          ...
>>          *res = replay_get_dword();
>>          ...
>>
>> tpm_util_test_tpmdev()
>>    tpm_util_test()
>>      tpm_util_request()
>>        ...
>>        if (n != requestlen) {
>>            return -EFAULT;
>>        }
>>        ...
>>
>> Both doesn't document that they set errno.
>>
>> Let's drop these explicit usage of errno. If we need this information,
>> it should be added to errp deeper in the stack.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> ---
> 
>> @@ -539,8 +535,7 @@ static void tpm_emulator_cancel_cmd(TPMBackend *tb)
>>       /* FIXME: make the function non-blocking, or it may block a VCPU */
>>       if (tpm_emulator_ctrlcmd(tpm_emu, CMD_CANCEL_TPM_CMD, &res, 0,
>>                                sizeof(ptm_res), sizeof(res)) < 0) {
>> -        error_report("tpm-emulator: Could not cancel command: %s",
>> -                     strerror(errno));
>> +        error_report("tpm-emulator: Could not cancel command: %s");
> 
> Remove the '%s'.
> 
> I get these build errors now:
> 
> ../backends/tpm/tpm_emulator.c: In function ‘tpm_emulator_cancel_cmd’:
> ../backends/tpm/tpm_emulator.c:538:22: error: format ‘%s’ expects a matching ‘char *’ argument [-Werror=format=]
>    538 |         error_report("tpm-emulator: Could not cancel command: %s");
>        |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../backends/tpm/tpm_emulator.c: In function ‘tpm_emulator_post_load’:
> ../backends/tpm/tpm_emulator.c:958:9: error: unused variable ‘ret’ [-Werror=unused-variable]
>    958 |     int ret;
>        |         ^~~
> cc1: all warnings being treated as errors
> 

ashamed :/ I've checked compilation without tpm in config. Sorry, will resend.


-- 
Best regards,
Vladimir

