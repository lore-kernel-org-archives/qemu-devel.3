Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D7AF46C4E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 15:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9llk-0000X1-Q3; Mon, 06 Apr 2026 11:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1w9lli-0000WW-Bt
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:21:38 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1w9llf-0006JQ-Oe
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:21:38 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 81B29806EB;
 Mon, 06 Apr 2026 18:21:29 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:42::1:21] (unknown [2a02:6bf:8080:42::1:21])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ELidAL1Lu0U0-myDlS1Ty; Mon, 06 Apr 2026 18:21:28 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1775488888;
 bh=SycvOtrVUCJakvGlfWCMCxUbcWuVtwa8ZtbqH+GeFRs=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=VnSQr2GvXIK+6Uk1vF2j9N+/Hhuj2kkIUi9eLGFv3UDPMA4V0pbf++DTm1OBtX66i
 h4EWIGNcmDPIjSApJKF6kLPSZHLS8pXj7hwgpSi1IvkYuEkjdFHUZ0rbOY7xvXNgYR
 MHQGCy1QvgkFcFVUI8+U0y47dOYvjco4Ye/aj1Kk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <0d1ea49e-d9ec-4e94-941c-67681f130fb1@yandex-team.ru>
Date: Mon, 6 Apr 2026 18:21:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] docs/vhost-user: clarify the semantics of
 VHOST_USER_SET_VRING_ENABLE
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20260325113644.175108-1-d-tatianin@yandex-team.ru>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <20260325113644.175108-1-d-tatianin@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

ping :)

On 3/25/26 2:36 PM, Daniil Tatianin wrote:
> Documentation didn't really make it clear that the payload contains any
> sort of desired state field, you could only derive that by looking at
> the QEMU implementation of this request. Add an extra note to make that
> clear.
>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ---
>
> Changes since v0:
> - Remove 'Note that' (suggested by Vladimir)
>
> ---
>   docs/interop/vhost-user.rst | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 137c9f3669d..e29eb291f11 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -1346,6 +1346,8 @@ Front-end message types
>     :reply payload: N/A
>   
>     Signal the back-end to enable or disable corresponding vring.
> +  The ``num`` field contains the target vring state where 0 means disabled,
> +  and any other value means enabled.
>   
>     This request should be sent only when
>     ``VHOST_USER_F_PROTOCOL_FEATURES`` has been negotiated.

