Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917C6C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 16:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfNEm-0001Oy-KU; Wed, 28 Feb 2024 11:56:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rfNEk-0001Ny-HZ
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 11:56:54 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rfNEh-0005Bu-MB
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 11:56:54 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id A793A60C9A;
 Wed, 28 Feb 2024 19:56:46 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a519::1:3a] (unknown
 [2a02:6b8:b081:a519::1:3a])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id iucF7t2IjqM0-YIHvOfpd; Wed, 28 Feb 2024 19:56:45 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709139405;
 bh=If09hQ6TZnsBYJin932Eqaia/9FdAbELJM9omVquIPc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=J3NvnEdY9zUWrVZYFXD/C1goMkl0LwYgVKP/6hnSdoZKSSIAK3YDKRxIMDi4mfcVf
 dZ+hyICw/UFFFc6lY5V54nwZD2GbKGdtV6BaOi53cKyPM5v65aiswtigFOOCdM07p7
 8iKCddJoHwQoZK+9jqOnlj31UW/ogZwmVneqNSls=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <2391daee-3b15-43e9-b8c2-383dc5b5df27@yandex-team.ru>
Date: Wed, 28 Feb 2024 19:56:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] virtio: add VIRTQUEUE_ERROR QAPI event
Content-Language: en-US
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: mst@redhat.com, dave@treblig.org, armbru@redhat.com, pbonzini@redhat.com, 
 berrange@redhat.com, eduardo@habkost.net, eblake@redhat.com,
 yc-core@yandex-team.ru, den-plotnikov@yandex-team.ru
References: <20231017123955.803724-1-vsementsov@yandex-team.ru>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20231017123955.803724-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

gently ping again) It still cleanly applies to master branch!

Michael, could you please look at it?

On 17.10.23 15:39, Vladimir Sementsov-Ogievskiy wrote:
> For now we only log the vhost device error, when virtqueue is actually
> stopped. Let's add a QAPI event, which makes possible:
> 
>   - collect statistics of such errors
>   - make immediate actions: take core dumps or do some other debugging
>   - inform the user through a management API or UI, so that (s)he can
>    react somehow, e.g. reset the device driver in the guest or even
>    build up some automation to do so
> ...

-- 
Best regards,
Vladimir


