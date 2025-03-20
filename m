Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3119C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 08:01:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvApH-0006md-S1; Thu, 20 Mar 2025 04:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tvApB-0006mE-1F
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 04:00:21 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tvAp6-0005Iz-Ox
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 04:00:20 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:4c7:0:640:d178:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id A756E60C35;
 Thu, 20 Mar 2025 11:00:11 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8106::1:23] (unknown
 [2a02:6b8:b081:8106::1:23])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id B0FYD30FYmI0-5PbLrsRY; Thu, 20 Mar 2025 11:00:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1742457611;
 bh=8jI6t/K8MtOv0QTuriW8iEp2gEE06qpr/XL+BENZ1nw=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=j/eurAeTsywdNZjAR6O0UQqQmO3brZF2XT1KAw4ZOST6BF48Lyo7fUnke+gKHJFNY
 66jhR4AEvBafmqX1+5VkmgwYhJF0TEhLh1918faun73EW7Ut792WUuxEu5brAbHsRs
 1FsT9+8WnRlmSBmldUDncDJ1q2f6LcZG8zWwGI58=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <6a3ddcca-c458-4d73-bd40-e2c31ee937be@yandex-team.ru>
Date: Thu, 20 Mar 2025 11:00:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] utils/qemu-sockets: Introduce
 keep-alive-idle-period inet socket option
To: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250319163638.456417-1-jmarcin@redhat.com>
 <20250319163638.456417-3-jmarcin@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250319163638.456417-3-jmarcin@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 19.03.25 19:36, Juraj Marcin wrote:
> From: Juraj Marcin<jmarcin@redhat.com>
> 
> The default idle period for TCP connection could be even 2 hours.
> However, in some cases, the application needs to be aware of a
> connection issue much sooner.
> 
> This is the case, for example, for postcopy live migration. If there is
> no traffic from the migration destination guest (server-side) to the
> migration source guest (client-side), the destination keeps waiting for
> pages indefinitely and does not switch to the postcopy-paused state.
> This can happen, for example, if the destination QEMU instance is
> started with '-S' command line option and the machine is not started yet
> or if the machine is idle and produces no new page faults for
> not-yet-migrated pages.
> 
> This patch introduces a new inet socket parameter on platforms where
> TCP_KEEPIDLE is defined and passes the configured value to the
> TCP_KEEPIDLE socket option when a client-side or server-side socket is
> created.
> 
> The default value is 0, which means system configuration is used, and no
> custom value is set.
> 
> Signed-off-by: Juraj Marcin<jmarcin@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir


