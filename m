Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3733ACA0EED
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 07:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqRvH-000415-Lj; Mon, 25 Aug 2025 03:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uqRv7-0003zd-48
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 03:47:13 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uqRv4-0004C5-8N
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 03:47:12 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1a8c:0:640:7006:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 73F2CC0487;
 Mon, 25 Aug 2025 10:46:59 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a99::1:22] (unknown
 [2a02:6bf:8080:a99::1:22])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id vkRMsU1GweA0-INUPA14J; Mon, 25 Aug 2025 10:46:58 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756108018;
 bh=ChreZX2+JYmukXEkrgBNYlrOdT4ISkpTB52pxR4wRXs=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=sSuFjZD6MG4rUFqAc5b9fm/Aymn4gJ2NhAJ/VyrMWK/SiMQGW8KjG2xW8b7Beydy7
 r7GrvHqSk4bkgwNHieAEM1bxPom4FL6tR729GrYi/EOEJKCW5lsNP08HHx1yQoadVh
 9edhvfkxqfLUYho2CHb2rkgQXAil+x3vFN3wG5WM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c73f4300-71c7-4c97-8ef2-b56d7a7e9569@yandex-team.ru>
Date: Mon, 25 Aug 2025 10:46:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 7/7] RFC: add python/tap-migration-stand.py
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, leiyang@redhat.com, steven.sistare@oracle.com,
 peterx@redhat.com, mst@redhat.com, farosas@suse.de, yc-core@yandex-team.ru
References: <20250823214821.48342-1-vsementsov@yandex-team.ru>
 <20250823214821.48342-8-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250823214821.48342-8-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 24.08.25 00:48, Vladimir Sementsov-Ogievskiy wrote:
> How to use:

(this patch 7/7 is not for commit)


-- 
Best regards,
Vladimir

