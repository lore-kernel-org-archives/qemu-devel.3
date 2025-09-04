Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EAACA1013
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 15:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuBXD-0003BH-MD; Thu, 04 Sep 2025 11:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uuBX9-0003AH-8Z
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 11:05:55 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uuBWw-0005ah-Vw
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 11:05:52 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id C6FC98133A;
 Thu, 04 Sep 2025 18:05:28 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b8f::1:11] (unknown
 [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Q5juWD4FpeA0-RxghCiZF; Thu, 04 Sep 2025 18:05:28 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756998328;
 bh=+ZUgGd0av+sbwkKjvEa4f+LvVZ6462gm6QjCQXiEoB0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=HFbtvJgrfsPrHBYh/F5uL0vW/LYMoZbQC+3gjw/apEY6Z6NPStwsAJTbTEqtyoCAU
 69HO3ybWSovS16YKvmKjxQuZCuWX/Bk2XDSMbPBO0lxI3+e9EcVW1gE7nl4FWjjQ6Z
 1nuuCQoOfVs2NqrUBBoZqBJMXIm9Mzfn5yX2PY0I=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <74b6665c-eefb-46e1-b0ac-2b36916ed092@yandex-team.ru>
Date: Thu, 4 Sep 2025 18:05:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] virtio-net: live-TAP local migration
To: Lei Yang <leiyang@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, steven.sistare@oracle.com,
 yc-core@yandex-team.ru, peterx@redhat.com, mst@redhat.com, farosas@suse.de,
 eblake@redhat.com, armbru@redhat.com, thuth@redhat.com, philmd@linaro.org,
 berrange@redhat.com
References: <20250903133706.1177633-1-vsementsov@yandex-team.ru>
 <CAPpAL=x6FW_5b1mkCjt6j-4BBOaG=Ps5iAPVf+jZnnY8r_uTNQ@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAPpAL=x6FW_5b1mkCjt6j-4BBOaG=Ps5iAPVf+jZnnY8r_uTNQ@mail.gmail.com>
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
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 04.09.25 17:42, Lei Yang wrote:
> Tested the current series of patches, mixed with patches from series
> [1] and [2], and the virtio-net regression tests passed. I also tested
> local VM migration under multiple NIC queues enabled and disabled, it
> also passed.
> 
> [1] https://patchwork.ozlabs.org/project/qemu-devel/cover/20250903094411.1029449-1-vsementsov@yandex-team.ru/
> [2] https://patchwork.ozlabs.org/project/qemu-devel/cover/20250903124934.1169899-1-vsementsov@yandex-team.ru/
> 
> Tested-by: Lei Yang <leiyang@redhat.com>
> 


Thanks a lot for testing!


-- 
Best regards,
Vladimir

