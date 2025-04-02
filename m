Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A6CC36017
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 13:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzxnL-0000MN-7L; Wed, 02 Apr 2025 09:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tzxnG-0000M0-Vt; Wed, 02 Apr 2025 09:06:11 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tzxnB-0005io-Ba; Wed, 02 Apr 2025 09:06:09 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c1c:342e:0:640:ad4e:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id E56CE60E54;
 Wed,  2 Apr 2025 16:05:59 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:1217::1:23] (unknown
 [2a02:6b8:b081:1217::1:23])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id x5Xp1p0FfeA0-EQwTPlw6; Wed, 02 Apr 2025 16:05:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1743599159;
 bh=84qkfdWCmRBzIwMd/j5yzTtYQWgS3xgm+ef2n3KNCtw=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=bmBqso3oRHjluUPcg+QkxJpOSpTx48zLdcsmnc3JNrSkPPU5xdtuyk6lYCWmkApWZ
 uJHCZFGDSl/qL3v4WKRRVVxFk79r/AaUoTAqjcAgR8tc1QSX2UwooiEzZLyMHkl5UZ
 mIpnG/obHUJ1G2L2VeRqVCyaO6GO8lYc+sIxI9tw=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <ebbc334f-43d2-4a06-a3a0-5fa3c1266f52@yandex-team.ru>
Date: Wed, 2 Apr 2025 16:05:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/7] qapi: add blockdev-replace command
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com,
 armbru@redhat.com, eblake@redhat.com, hreitz@redhat.com
References: <20240626115350.405778-1-vsementsov@yandex-team.ru>
 <20240626115350.405778-5-vsementsov@yandex-team.ru>
 <992e1551-6d75-441f-af6e-5df9e6c85c31@yandex-team.ru>
 <256e998c-c0bd-40b4-94bf-de25ac9c1b02@yandex-team.ru>
 <ZxJpx024fRqNsI2E@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <ZxJpx024fRqNsI2E@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 18.10.24 16:59, Kevin Wolf wrote:
> If we want to get rid of the union, I think the best course of action
> would unifying the namespaces (so that nodes, exports and devices can't
> share the same ID) and then we could just accept a universal 'id' along
> with 'child'.

Maybe we can go this way even without explicit restriction (which should
some how go through deprecation period, etc), but simply look for the id
among nodes, devices and exports and if found more than one parent - fail.

And we document, that id should not be ambiguous, should not match more
than one parent object. So, those who want to use new command will care
to make unique ids.

-- 
Best regards,
Vladimir


