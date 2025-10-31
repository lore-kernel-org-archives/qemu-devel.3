Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9EECCF9FE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmN0-0003Ap-7A; Fri, 31 Oct 2025 06:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEmMy-000374-7U
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 06:28:32 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEmMt-0005qT-TY
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 06:28:31 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 0B8AA807F9;
 Fri, 31 Oct 2025 13:28:25 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:546::1:17] (unknown
 [2a02:6bf:8080:546::1:17])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id NSdbXi0FnGk0-ImwP7skr; Fri, 31 Oct 2025 13:28:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761906504;
 bh=6xI7XoavUSp9uC8NmPf7tEvSbmvSH7/np36KTdwo1NA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=CkLqO3K+7+zzgLA3KoYxGU6zaPWIJGZcWuhMvAsFL/gUdaPzQsQZol6H+NiVYhgMK
 Cm4umvr2oqHr9dV0f5zyPtNpFw/eIADhU+QFqSjTkrFLPXnJF5kK3SkaT3fApyR9tb
 LbnUDs3vgk+MwyG/K3QnxZS1ymigDqBuMmGMmPyY=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <96fec676-1b73-4731-9c41-3c67d6b5ae97@yandex-team.ru>
Date: Fri, 31 Oct 2025 13:28:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] qga/qapi-schema: Refill doc comments to conform to
 conventions
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, thuth@redhat.com,
 berrange@redhat.com, philmd@linaro.org, kchamart@redhat.com, mst@redhat.com,
 sgarzare@redhat.com
References: <20251031094751.2817932-1-armbru@redhat.com>
 <20251031094751.2817932-5-armbru@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20251031094751.2817932-5-armbru@redhat.com>
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

On 31.10.25 12:47, Markus Armbruster wrote:
> Sweep the entire documentation again.  Last done in commit
> 7270819384c (qga/qapi-schema: Refill doc comments to conform to
> current conventions).
> 
> To check the generated documentation does not change, I compared the
> generated HTML before and after this commit with "wdiff -3".  Finds no
> differences.  Comparing with diff is not useful, as the reflown
> paragraphs are visible there.
> 
> Signed-off-by: Markus Armbruster<armbru@redhat.com>

git show --color-words='[^#[:space:]]+'

shows no difference.

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir

