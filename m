Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F92C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMQm4-00008K-Ky; Wed, 26 Jun 2024 07:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMQlm-0008RY-6P
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:25:00 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMQli-0000jB-PS
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:24:57 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c16:1680:0:640:d42f:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 0C02C60F68;
 Wed, 26 Jun 2024 14:24:52 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b645::1:29] (unknown
 [2a02:6b8:b081:b645::1:29])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id oOOVbe0IXiE0-6SQoM7FD; Wed, 26 Jun 2024 14:24:51 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719401091;
 bh=2lhcCixQPIQZZ9rY1Ojo1T2V4TfWr7nPa245ncW/e3Q=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=rZ5W01gfVBw4VPEGT2ELZuyWQEZtcf4I4n/v8puVWqsxAucZ7kJfhlZHmarw7zb83
 JyOP+ErLcN76DcqET5QBaVGsHcxjvdDOJ8J0qkN/JgGwEUo4GaG7iluIZF78BjBqtP
 PWka6qt0xlztyQ60yN5lIo14WEbPhqL4uMkC0hR0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <572519cc-88c3-4433-b4df-f9f6c43c2a7a@yandex-team.ru>
Date: Wed, 26 Jun 2024 14:24:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] virtio: add VIRTQUEUE_ERROR QAPI event
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, dave@treblig.org, armbru@redhat.com, pbonzini@redhat.com, 
 berrange@redhat.com, eduardo@habkost.net, eblake@redhat.com,
 yc-core@yandex-team.ru, den-plotnikov@yandex-team.ru
References: <20231017123955.803724-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20231017123955.803724-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

ping4

On 17.10.23 15:39, Vladimir Sementsov-Ogievskiy wrote:
> For now we only log the vhost device error, when virtqueue is actually
> stopped. Let's add a QAPI event, which makes possible:
> 
>   - collect statistics of such errors
>   - make immediate actions: take core dumps or do some other debugging
>   - inform the user through a management API or UI, so that (s)he can
>    react somehow, e.g. reset the device driver in the guest or even
>    build up some automation to do so
> 
> Note that basically every inconsistency discovered during virtqueue
> processing results in a silent virtqueue stop.  The guest then just
> sees the requests getting stuck somewhere in the device for no visible
> reason.  This event provides a means to inform the management layer of
> this situation in a timely fashion.
> 
> The event could be reused for some other virtqueue problems (not only
> for vhost devices) in future. For this it gets a generic name and
> structure.
> 
> We keep original VHOST_OPS_DEBUG(), to keep original debug output as is
> here, it's not the only call to VHOST_OPS_DEBUG in the file.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Denis Plotnikov <den-plotnikov@yandex-team.ru>
> Acked-by: Markus Armbruster <armbru@redhat.com>


-- 
Best regards,
Vladimir


