Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E61CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 15:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8h2t-00053U-Fb; Tue, 14 Oct 2025 11:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8h2o-0004y2-0A; Tue, 14 Oct 2025 11:34:34 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8h2f-0000Qf-R8; Tue, 14 Oct 2025 11:34:33 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 7DEDBC0165;
 Tue, 14 Oct 2025 18:34:19 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a8a::1:35] (unknown
 [2a02:6bf:8080:a8a::1:35])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id IYRWfq2FleA0-keVMbbm9; Tue, 14 Oct 2025 18:34:19 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760456059;
 bh=pzdUHr3UjexanxqjagVhXGlOK0biSP0q2Y6DDOTsJSQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=OX5oXhmdJFmP2dZk5xY0TUy6ChYG+lvihDS1R1IYBMf4j7y8ZnNEFqgEGoxAhMs45
 KRsJZ3AMgFNPfEWg2T62IRFiNpUkJidaHVwMswWoa/wUAEoKDXocu4VIvbfj7lG19W
 xQWypKLjlRvoAI68G62l4lr1xN6VYYpshXzU76/Y=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <bb5c5652-1d6f-440f-ad9f-c9ebfdc7283e@yandex-team.ru>
Date: Tue, 14 Oct 2025 18:34:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/23] vhost: drop backend_features field
To: Michael Tokarev <mjt@tls.msk.ru>, mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 raphael.s.norwitz@gmail.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, qemu-stable@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
References: <20251011232404.561024-1-vsementsov@yandex-team.ru>
 <20251011232404.561024-3-vsementsov@yandex-team.ru>
 <6176d689-ff2f-42c8-a0c6-38f3f87e7da8@tls.msk.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <6176d689-ff2f-42c8-a0c6-38f3f87e7da8@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 14.10.25 18:28, Michael Tokarev wrote:
> On 10/12/25 02:23, Vladimir Sementsov-Ogievskiy wrote:
>> This field is mostly unused and sometimes confusing (we even have
>> a TODO-like comment to drop it). Let's finally do.
>>
>> The field is used to held VHOST_USER_F_PROTOCOL_FEATURES for vhost-user
>> and/or VHOST_NET_F_VIRTIO_NET_HDR for vhost-net (which may be
>> vhost-user-net). But we can simply recalculate these two flags in place
>> from hdev->features, and from net-client for VHOST_NET_F_VIRTIO_NET_HDR.
>>
>> Note: removing field from x-query-virtio-status result is incompatible
>> change. We can do it because the command is unstable.
>>
>> Cc: qemu-stable@nongnu.org
> 
> Why do you think this change deserves qemu-stable?  Does it fix a bug or
> is it just a clean-up?
> 

Oops, it's a mistake (working too late).

I wanted to write

Cc: devel@lists.libvirt.org

:)

Seems, v3 is needed anyway, will fix it.

-- 
Best regards,
Vladimir

