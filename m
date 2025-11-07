Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10665CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 19:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHSWi-0000OP-NX; Fri, 07 Nov 2025 14:53:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vHSWg-0000NZ-Mr
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 14:53:38 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vHSWe-0007CC-36
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 14:53:38 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 1FDE380860;
 Fri, 07 Nov 2025 22:53:30 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d76::1:1a] (unknown
 [2a02:6bf:8080:d76::1:1a])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Srtgtf0F0qM0-f6FwiUIW; Fri, 07 Nov 2025 22:53:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1762545209;
 bh=ZKyCPT2nuxreqT3tHFTiAtCf2SKEBegolHF6HeueOYc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=iRh+o8hrElCLH6QhW8OyobV7pJ4RcSx+FTngCidImgqOZK+UFgaPGhgjktVZW/1ur
 SXuxFvFsW1tQ0H8gc1bYSXbG8lmsHlbJoUU8ULJQddkJ49A/lwfsEtYX2XPg2+GXcg
 luzxd+KwOd8IRzIm0I0iUZnurl3dlrDl3cvd22FI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <45a78ed7-bbe3-4d92-8fde-120f21ecd274@yandex-team.ru>
Date: Fri, 7 Nov 2025 22:53:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] tpm_emulator: drop direct use of errno variable
To: Stefan Berger <stefanb@linux.ibm.com>, stefanb@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, armbru@redhat.com, peterx@redhat.com
References: <20251106194126.569037-1-vsementsov@yandex-team.ru>
 <20251106194126.569037-3-vsementsov@yandex-team.ru>
 <bd855481-a93a-4406-bd0d-a02896b93296@linux.ibm.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <bd855481-a93a-4406-bd0d-a02896b93296@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

On 07.11.25 22:31, Stefan Berger wrote:
> 
> 
> On 11/6/25 2:41 PM, Vladimir Sementsov-Ogievskiy wrote:
>> The code tends to include errno into error messages after
>> tpm_util_test_tpmdev() and tpm_emulator_ctrlcmd() calls.
>>
>> Both has error paths, where errno is not set, examples:
> 
> Both have ...>
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
> 
> Both do not ...
> 
>>
>> Let's drop these explicit usage of errno. If we need this information,
>> it should be added to errp deeper in the stack.
> 
> It's not clear to me why this is an actual problem. Is it better to now not set this error message?
> 

Using errno directly as source of error for internal QEMU functions is rather unusual.
Better pattern is to wrap library functions that uses errno, and return error as
int return code of the function, or even better in errp.
And here, it's at least will have undefined value for some error paths. So, I think,
printing it is wrong.

With this commit, we still may lose some correct error information, on failure paths
where errno is really set. Does it make sense?

Users should never rely on error messages text in any scenarios, it's just a
"best-effort" information. So, I think code cleanness worth the loss of some maybe
useful part of error message.

-- 
Best regards,
Vladimir

