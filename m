Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B9DCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 18:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC0DP-00009X-H1; Thu, 23 Oct 2025 14:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vC0DK-00008P-Rz
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 14:39:07 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vC0DH-0000yA-V3
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 14:39:06 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 5184080873;
 Thu, 23 Oct 2025 21:38:59 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:538::1:38] (unknown
 [2a02:6bf:8080:538::1:38])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id vcdiOs0bC4Y0-lnONPIwL; Thu, 23 Oct 2025 21:38:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761244738;
 bh=0q3XTLohJb1xFUdZ4FRN1DOGHn6bQnG/L4tTXFbwKJo=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=x1HOVdxSYUtrxvFpli1eNqmHm8NI3+M2h+zR7L0sh+B37+t835pzE/sGfIjLnIE95
 AaCg7pxxc82i+fccrr/9wb4wDKJDZCyzkX2Xiz9+IPPBLJnJNlB9UaecpbmA9ya/cZ
 ZbkONq4/UFhbA44fr6EsFvC/0mO7Ty6ObojscsSU=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f50a620f-29c9-4e89-9ab1-59b725922d80@yandex-team.ru>
Date: Thu, 23 Oct 2025 21:38:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scripts/compare-mt: add confidential computing getter
To: Maksim Davydov <davydov-max@yandex-team.ru>, qemu-devel@nongnu.org
Cc: crosa@redhat.com, jsnow@redhat.com, philmd@linaro.org
References: <20251023165846.326295-1-davydov-max@yandex-team.ru>
 <20251023165846.326295-2-davydov-max@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20251023165846.326295-2-davydov-max@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 23.10.25 19:58, Maksim Davydov wrote:
> "sev-guest" option was added to the 9.0 machines. So, the script has to
> be able to get default values of properties of this type.
> Unfortunatelly, some default values are set during instance
> initialization but not during class initialization. Thus, they can't be
> easily accessed.
> 
> Based on the above, "qom-list-properties" command was choosen for getting
> default values, but now it always returns nothing usefull. Maybe, in the
> future we will have a more appropriate command for "sev-guest".
> 
> Signed-off-by: Maksim Davydov<davydov-max@yandex-team.ru>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir

