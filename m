Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7338CA100B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 06:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uthSI-000191-O3; Wed, 03 Sep 2025 02:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uthSG-00018c-Iu
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 02:58:52 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uthSE-000316-45
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 02:58:52 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 74AAA8084D;
 Wed, 03 Sep 2025 09:58:45 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b8f::1:11] (unknown
 [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id iwZZqn3GlmI0-SSd1KZRI; Wed, 03 Sep 2025 09:58:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756882725;
 bh=diUGG/xz06gvBYA4/T9IrGKjsmtSStv8oIIpyGI03is=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=UBb9FERSBljfVmf/XFlAfSBGE0y+sq9xscpX+HuH9bpZYZOl+10+kagtrDM/hwn0A
 +XUKjQ0b5OrxxPemt/0aY0P/SHjLmNw4p1g46CWgn/fjCypCWIUdWDvN++qrcoE8aS
 pebdMj61eRI0o1HzieKSePXcOkrKmkjJTp27yaJY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <7417f93a-22a7-4733-9065-100342d8f05a@yandex-team.ru>
Date: Wed, 3 Sep 2025 09:58:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/20] net/tap: net_init_tap_one(): add return value
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, leiyang@redhat.com, steven.sistare@oracle.com
References: <20250823160323.20811-1-vsementsov@yandex-team.ru>
 <20250823160323.20811-2-vsementsov@yandex-team.ru>
 <CACGkMEt0Dr0VZke58_93Cfqskrw3E2YuJDJC7d9bg+qjAqabRA@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CACGkMEt0Dr0VZke58_93Cfqskrw3E2YuJDJC7d9bg+qjAqabRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

On 03.09.25 07:04, Jason Wang wrote:
> On Sun, Aug 24, 2025 at 12:03 AM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> To avoid error propagation, let's follow common recommendation to
>> use return value together with errp.
> 
> It would be better to have some words or links to explain why we need
> to avoid error propagation.

In short with additional return value we get:

- less code to handle error
- don't create and set Error object when it's not required (when passed errp=NULL)

More details in commit message of e3fe3988d7851cac3 "error: Document Error API usage rules".

I'll add this information here.

> 
>>
>> Probably, it would also be good to use bool as a return type
>> (switching to true/false as success/failure instead of 0/-1). But
>> seems almost all functions (including a lot of them with errp
>> argument) have 0/-1 semantics in net/, so making exclusions doesn't
>> seem good. If we want such a switch, we should update the whole
>> net/ directory.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
> 
> Thanks
> 


-- 
Best regards,
Vladimir

