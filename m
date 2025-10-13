Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258D5CCD185
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 07:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Ce8-00043N-JC; Mon, 13 Oct 2025 03:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8Ce4-00042s-JA
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 03:07:00 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8Ce1-0002yL-FG
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 03:07:00 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:9297:0:640:61e7:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 193A280857;
 Mon, 13 Oct 2025 10:06:52 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a50::1:2a] (unknown
 [2a02:6bf:8080:a50::1:2a])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id p6IwH21FrCg0-8sAqqGsL; Mon, 13 Oct 2025 10:06:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760339211;
 bh=tTrtTrEM5aYZDSI6Xj37lTqz457MacaAsUClbPQEWOM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=rLn/3b9SWjLdtye3fWn7n8fMBdl6AkzsucGLNljd2fljYsJrWFTxCTZ/hOohsJYTB
 zxgQIf9+CKn/s6H9VJrCx6l0em4sP9GZ39JZFbFhxDOohvIcGZYJl9Dqa5sYVDkexU
 M/hgdEGcQuLlCeSZbWfQAc4ExUZVUz7XU/qBPFJ4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <133494d1-da28-4c56-937a-94d6756f3e33@yandex-team.ru>
Date: Mon, 13 Oct 2025 10:06:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/33] qapi: docs: width=70 and two spaces between
 sentences
To: Thomas Huth <thuth@redhat.com>, armbru@redhat.com
Cc: qemu-devel@nongnu.org, eblake@redhat.com
References: <20251011135754.294521-1-vsementsov@yandex-team.ru>
 <2e4da035-4996-4d1e-b3e1-9285a9c880e3@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <2e4da035-4996-4d1e-b3e1-9285a9c880e3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

On 13.10.25 09:11, Thomas Huth wrote:
> That's confusing and will always cause mistakes in the future, I guess...

No, that will not, look at first commit.

   [PATCH 01/33] qapi: Add documentation format validation

it adds a check into QAPI generator.

-- 
Best regards,
Vladimir

