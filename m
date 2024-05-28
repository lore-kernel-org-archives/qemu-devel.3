Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F037C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 12:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBwH1-0006nx-Ht; Tue, 28 May 2024 08:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sBwGs-0006lP-BU; Tue, 28 May 2024 08:49:45 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sBwGk-0000Kb-Ev; Tue, 28 May 2024 08:49:42 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:4495:0:640:1311:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 3672B60BB9;
 Tue, 28 May 2024 15:49:23 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:6512::1:33] (unknown
 [2a02:6b8:b081:6512::1:33])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id LnPhA00Ig4Y0-qN7tPfWg; Tue, 28 May 2024 15:49:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1716900562;
 bh=E1OtZuScMBk5brOqixwm9ex3Lp+S9dily5q6a0kFJ30=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=jI8uURPeEViVamCG0a6CAl25/rIOOOTqqmtDBRBcvoTB5TjsCbyasRdqlQ9+qvKfy
 N/0V4wUdUafIQn6/bOBEM5dtbDIIobSgmSqQLteKXZ8P6m5EERqfXMy6yhtkfiWlyA
 PSa4KVLo02IBQFt8uS1OUKCA2sFmu76vUs2nvSVI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <10070ee3-2ef7-45e6-bd27-5ac74559f192@yandex-team.ru>
Date: Tue, 28 May 2024 15:49:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iotests/pylintrc: allow up to 10 similar lines
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 jsnow@redhat.com, f.ebner@proxmox.com
References: <20240430091329.2365053-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240430091329.2365053-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
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

On 30.04.24 12:13, Vladimir Sementsov-Ogievskiy wrote:
> We want to have similar QMP objects in different tests. Reworking these
> objects to make common parts by calling some helper functions doesn't
> seem good. It's a lot more comfortable to see the whole QAPI request in
> one place.
> 
> So, let's increase the limit, to unblock further commit
> "iotests: add backup-discard-source"
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
> 
> Hi all! That's a patch to unblock my PR
> "[PULL 0/6] Block jobs patches for 2024-04-29"
>    <20240429115157.2260885-1-vsementsov@yandex-team.ru>
>    https://patchew.org/QEMU/20240429115157.2260885-1-vsementsov@yandex-team.ru/
> 
> 
>   tests/qemu-iotests/pylintrc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qemu-iotests/pylintrc b/tests/qemu-iotests/pylintrc
> index de2e0c2781..05b75ee59b 100644
> --- a/tests/qemu-iotests/pylintrc
> +++ b/tests/qemu-iotests/pylintrc
> @@ -55,4 +55,4 @@ max-line-length=79
>   
>   [SIMILARITIES]
>   
> -min-similarity-lines=6
> +min-similarity-lines=10


Hi! I hope it's OK, if I just apply this to my block branch, and resend "[PULL 0/6] Block jobs patches for 2024-04-29" which is blocked on this problem.

Thanks for reviewing,
applied to my block branch

-- 
Best regards,
Vladimir


