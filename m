Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC37C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 16:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2uiF-00014B-NN; Thu, 10 Apr 2025 12:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u2ui4-00012I-7p
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 12:25:02 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u2ui2-0005Qv-7n
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 12:24:59 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:921:0:640:f23d:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 2D90E60ACF;
 Thu, 10 Apr 2025 19:24:56 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:7307::1:35] (unknown
 [2a02:6b8:b081:7307::1:35])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id sOifOK0FZKo0-Tz8mt5RV; Thu, 10 Apr 2025 19:24:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1744302295;
 bh=7w5a6aaG0QCLNSr0Fj29DaHF8VpMwyZNumgEudMHVpQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=aLa5/vN/CCNp1N7rgqX2GkymH34IgczxerAGi4EgZ5j2MCc6xxfOEk2VW519zapZ3
 vP9y1yHqlOVmZ4SKl29cl49lDMpeWGdm0YdhmRbhqudDP4osnigR1TJNbN2BKAiohJ
 ghN33e/yuc7cl5MO9u20yMi7ORp3p872319Ag5Vo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <3cb0e046-99b4-4f75-86fe-739df57b858a@yandex-team.ru>
Date: Thu, 10 Apr 2025 19:24:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [for-10.1] qtest: introduce qtest_init_ext
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, lvivier@redhat.com,
 farosas@suse.de, Steve Sistare <steven.sistare@oracle.com>
References: <20250410162250.329941-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250410162250.329941-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10.04.25 19:22, Vladimir Sementsov-Ogievskiy wrote:
> Merge qtest_init_with_env_and_capabilities() and qtest_init_with_env()
> into one qtest_init_ext().

CC Steve

-- 
Best regards,
Vladimir


