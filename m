Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DF7C83F04
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 14:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXLOy-0005Qa-El; Thu, 03 Jul 2025 10:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1uXLOi-0005KE-If
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 10:58:51 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1uXLOb-0000YO-I6
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 10:58:48 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:4a1:0:640:2691:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 6227560CBC;
 Thu,  3 Jul 2025 17:58:34 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:116::1:2d] (unknown
 [2a02:6bf:8080:116::1:2d])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id XwdlTT0FgKo0-E7RFtFBN; Thu, 03 Jul 2025 17:58:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1751554714;
 bh=V2G+lmuSr28EftuZFbE2HyKgEFlMnAVRTPHKCiuVGcc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=XjsCgw+69GeTLYnVSe5bbIwgTWHYAqlilsJ72t0zmjWBJk0no8AZ7Pj5++PmaFURY
 CWq035bLXWav+XFx0+wLjkbRS3cZMefNFXYoqGxAMNKkyWp613oPs+/IoZdae5gtVh
 0yTl3t+aZ3ppQZItTtGmRGkPNnFKRvWoOBkEMdJo=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <d7a66374-12d3-4b4b-975f-90202d83cbdf@yandex-team.ru>
Date: Thu, 3 Jul 2025 17:58:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/tap: drop too small packets
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 jasowang@redhat.com
Cc: qemu-devel@nongnu.org
References: <20250703105508.2380494-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <20250703105508.2380494-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/3/25 1:55 PM, Vladimir Sementsov-Ogievskiy wrote:

> Theoretically tap_read_packet() may return size less than
> s->host_vnet_hdr_len, and next, we'll work with negative size
> (in case of !s->using_vnet_hdr). Let's avoid it.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   net/tap.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/net/tap.c b/net/tap.c
> index ae1c7e39832..20d0dc2eb35 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -172,6 +172,11 @@ static void tap_send(void *opaque)
>               break;
>           }
>   
> +        if (s->host_vnet_hdr_len && size < s->host_vnet_hdr_len) {
> +            /* Invalid packet */
> +            break;
> +        }
> +
>           if (s->host_vnet_hdr_len && !s->using_vnet_hdr) {
>               buf  += s->host_vnet_hdr_len;
>               size -= s->host_vnet_hdr_len;

Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>


