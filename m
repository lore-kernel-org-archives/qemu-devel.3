Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED340103A9AD
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 11:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5MTG-0000zg-Pj; Wed, 25 Mar 2026 07:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w5MT9-0000zJ-A3
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 07:32:16 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w5MT5-0002cn-LC
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 07:32:14 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 737DCC0217;
 Wed, 25 Mar 2026 14:32:04 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:749::1:0] (unknown [2a02:6bf:8080:749::1:0])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 2WSkFa0AZqM0-V8Uyvy28; Wed, 25 Mar 2026 14:32:03 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1774438323;
 bh=Okq246JV3M4hqUSizER619YBfGBz/2/gJ/v4TxBf1WQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=rOp4LGeKw9t4VmeeF3qXKhDH0/AHJt6ByL8K+YZfGzajkh5hHo6jcEDwkpc8IBcoK
 thquSGCgpnxVoUoSDFt3hGeG8l+laryi9hdg0JUxmUIowRRvREcnnxj3luyCM0p5Ku
 lWUcWIVB0bAWI0/v0yXbrgPQoJRNCisFSPrNu/oI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <e860a275-973a-4215-97d6-b83329600be0@yandex-team.ru>
Date: Wed, 25 Mar 2026 14:31:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/vhost-user: clarify the semantics of
 VHOST_USER_SET_VRING_ENABLE
To: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru
References: <20260325104329.154875-1-d-tatianin@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260325104329.154875-1-d-tatianin@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

On 25.03.26 13:43, Daniil Tatianin wrote:
> Documentation didn't really make it clear that the payload contains any
> sort of desired state field, you could only derive that by looking at
> the QEMU implementation of this request. Add an extra note to make that
> clear.
> 
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ---
>   docs/interop/vhost-user.rst | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 137c9f3669d..79690c73b25 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -1346,6 +1346,8 @@ Front-end message types
>     :reply payload: N/A
>   
>     Signal the back-end to enable or disable corresponding vring.
> +  Note that the ``num`` field contains the target vring state where 0 means

I'd remove "Note that", as it's actually significant part of the protocol)

> +  disabled, and any other value means enabled.
>   
>     This request should be sent only when
>     ``VHOST_USER_F_PROTOCOL_FEATURES`` has been negotiated.

Anyway:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>


-- 
Best regards,
Vladimir

