Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE36AC36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 17:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2ZZa-0006y3-Sb; Wed, 09 Apr 2025 13:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u2ZZS-0006x3-VC
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 13:50:44 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u2ZZP-00055Y-NY
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 13:50:42 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:381b:0:640:f69d:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 0B015613D2;
 Wed,  9 Apr 2025 20:50:29 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:7304::1:2d] (unknown
 [2a02:6b8:b081:7304::1:2d])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id RoiPL40Fda60-svC8wGu0; Wed, 09 Apr 2025 20:50:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1744221028;
 bh=ydVzw7GhyfIxm6CVGHipSY6ZJX9EDwBW4fpge4tri/g=;
 h=In-Reply-To:Cc:Date:References:To:From:Subject:Message-ID;
 b=nwfir+wxUWvZKVvp4G9WAdCCWgblhBZpdlz4X9iiMpwFyvrurP0jbKE4ssrhqFnsM
 ZO/M9Vem8ut4LKclxjpNxR4AmFDxEdh2dAAXN7yUf3dSwohe/3TOxdOgyWSa2HWl5x
 FCKvUow1hWboAzqfbqoOk1+vCwDir4MuAYWzUvEE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <da10f71b-d07e-4304-8be7-6fc1f389daa6@yandex-team.ru>
Date: Wed, 9 Apr 2025 20:50:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 00/24] Live update: cpr-transfer
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1736967650-129648-1-git-send-email-steven.sistare@oracle.com>
 <631d25f6-b37a-480e-a178-06f66033018b@yandex-team.ru>
Content-Language: en-US
In-Reply-To: <631d25f6-b37a-480e-a178-06f66033018b@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 09.04.25 19:22, Vladimir Sementsov-Ogievskiy wrote:
> [offlist]

Hah, decided to send offlist, but forget to clear CC. Sorry. However, nothing secret here.

Moreover, interesting, what do all think about a cpr-exec variant with loading QEMU as library instead of doing exec.

> 
> On 15.01.25 22:00, Steve Sistare wrote:
>> This patch series implements a minimal version of cpr-transfer.  Additional
>> series are ready to be posted to deliver the complete vision described
>> above, including
>>    * vfio
>>    * chardev
>>    * vhost and tap
>>    * blockers
>>    * cpr-exec mode
> 
> Hi Steve. First, great congratulations with finally landed cpr-transfer! I saw the history of Live Update series was started overly five years ago.
> 
> I've some questions, hope it's not much trouble for you.
> 
> 1. We consider porting cpr-transver + vfio part of your "Live update: vfio and iommufd" to our downstream QEMU, based on v7.2. What do you think? I mean, may be you may quickly answer "don't try, you'll have to bring more than 100 commits from different series", or visa-versa "we have downstream based on 7.2 too, so it's possible" (OK, seems the latter answer is not possible, as iommufd code just absent in v7.2).
> 
> 
> 2. About cpr-exec. Do you plan resending it in future? The solution is interesting for us, as it simplifies management a lot. I read the discussion on cpr-exec, seems the main problem was the security constraint, that we don't want to allow exec call in seccomp profile. Didn't you consider a variant with loding the library instead of exec?
> 
> I mean:
> 
> - turn the whole QEMU into library, which may be dynamically loaded. Recently there was a question how to do it, and the answer contained an example patch: https://github.com/pbo-linaro/qemu/commit/fbb39cc64f77d4bf1e5e50795c75b62735bf5c5f
> 
> - and make a simple wrapper process for that library, which also is a container for migration state (including file descriptors), during live update.
> 
> Benefits:
> 
> - no execve, and we just need to add pattern for "qemu library" paths to apparmor profile
> 
> - probably, we can load new library _before_ starting the migration, reducing freeze-time of migration - more like migration with two processes
> 

-- 
Best regards,
Vladimir


