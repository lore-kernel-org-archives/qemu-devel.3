Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7660AC531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 08:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpLzG-0003GY-FY; Thu, 30 Jul 2026 04:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wpLzE-0003G1-4m
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 04:19:28 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wpLzB-0002Am-74
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 04:19:27 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 0C77AC0230;
 Thu, 30 Jul 2026 11:19:21 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:484::1:24] (unknown
 [2a02:6bf:8080:484::1:24])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id KJa5mmMWEqM0-q7BU82Yh; Thu, 30 Jul 2026 11:19:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1785399560;
 bh=ZVuMVkrE64wviS/lWMpHP4wMZwQ7czB1hmWn3gNsd5s=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=NJoJDD3jp4NkmKNU7aT28osrchNV904lFN4qBkYcLzYtPBi7LVJWcyURFlIgUTClb
 2HZ27t9wpotfX51KUIDqQyX/NQlUGL5P6jNRJQqZlw3TA709btZPGDrYn4XqS29kUd
 r64wih5TGhos16aaJLED26wjVKMNa+9ju8eu6uyQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <783a90d1-be14-47fc-98ad-da4812b1ccb1@yandex-team.ru>
Date: Thu, 30 Jul 2026 11:19:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] migration: Remove duplicate vmstate macros
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
References: <20260729225227.1170574-1-farosas@suse.de>
 <20260729225227.1170574-5-farosas@suse.de>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260729225227.1170574-5-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 30.07.26 01:52, Fabiano Rosas wrote:
> -#define VMSTATE_STRUCT_VARRAY_INT32(_field, _state, _field_num, _version, _vmsd, _type) { \
> -    .name       = (stringify(_field)),                               \
> -    .num_offset = vmstate_field_offset(_state, _field_num, int32_t), \

Hmm, this int32_t should be dropped in earlier commit.. It doesn't break
compilation because VMSTATE_STRUCT_VARRAY_INT32. Suggest to drop it
completely in patch 01, together with VMSTATE_ARRAY_INT32_UNSAFE.

(interesting, do we have more unused macros?)

> -    .version_id = (_version),                                        \
> -    .vmsd       = &(_vmsd),                                          \
> -    .size       = sizeof(_type),                                     \
> -    .flags      = VMS_STRUCT | VMS_VARRAY,                           \
> -    .offset     = vmstate_offset_varray(_state, _field, _type),      \
> -}
> -


-- 
Best regards,
Vladimir

