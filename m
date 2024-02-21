Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E26DC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoKy-0002dl-5O; Wed, 21 Feb 2024 10:16:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkhapov@yandex-team.ru>)
 id 1rcoJo-00010D-VY
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:15:33 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkhapov@yandex-team.ru>)
 id 1rcmwz-0002yY-Nc
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 08:47:56 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:9328:0:640:5832:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id AC08A60E52;
 Wed, 21 Feb 2024 16:47:49 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a510::1:2d] (unknown
 [2a02:6b8:b081:a510::1:2d])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id mlSZ730iCiE0-5a3riyI5; Wed, 21 Feb 2024 16:47:48 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1708523268;
 bh=sDtRNk/m1TxEix06v3seKOOwGK8eu44uU2PT0LBSoXs=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=k9EOYR4uT7EBBKePpI6pdFndpSEKQopCnXWSGKqXw6ei2jVVhIfFbTSc5SafOLSYg
 x8QE3cGOKQToCkDlM54LmYi2pDEjLfw7xIiuESAawHIpyqImWxKQWFIFH7RiqgVOQP
 30y8fhMUxzRQGRhfH9kFcqfpe1KABv1xsKAeyMeU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a804edf0-67d4-4752-b79f-c3e1ef3d72ff@yandex-team.ru>
Date: Wed, 21 Feb 2024 18:47:47 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] qapi/migration.json: add reason to MIGRATION event
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, eblake@redhat.com,
 armbru@redhat.com, yc-core@yandex-team.ru
References: <20240215122759.1438581-1-rkhapov@yandex-team.ru>
 <20240215122759.1438581-2-rkhapov@yandex-team.ru> <ZdQ7C5dHIQsTVQE8@x1n>
From: Roman Khapov <rkhapov@yandex-team.ru>
In-Reply-To: <ZdQ7C5dHIQsTVQE8@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=rkhapov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

If I understood you right, you suggest to improve migrate_generate_event 
to accept MigrationState* instead of int* state (which is pointing to 
field MigrationState.state in all usages), and get error reason from 
MigrationState.error, if the new state is MIGRATION_STATE_FAILED, is it?

That sounds reasonable, thanks!

But I'm not sure if I got the idea of changing migrate_set_error 
correctly, can you explain in more details, please?

On 2/20/24 10:39, Peter Xu wrote:
> On Thu, Feb 15, 2024 at 05:27:58PM +0500, Roman Khapov wrote:
>>       migrate_set_state(&mis->state, MIGRATION_STATUS_COLO,
>> -                      MIGRATION_STATUS_COMPLETED);
>> +                      MIGRATION_STATUS_COMPLETED, NULL);
> Instead of enforcing migrate_set_error() to always pass an error, maybe we
> can allow migrate_generate_event() to fetch s->error in FAILED state, if
> that hint ever existed?
>
-- 
Best regards,
Roman Khapov


