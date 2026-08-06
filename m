Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC151C55ABF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 13:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrxhY-0006ho-8F; Thu, 06 Aug 2026 09:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wrxhR-0006hI-BE
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 08:59:54 -0400
Received: from smtpout7.mo540.mail-out.ovh.net ([51.210.91.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wrxhO-0001Mc-Cf
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 08:59:53 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo540.mail-out.ovh.net (Postfix) with ESMTPS id 4hG6nH2Wb6z3wdN;
 Thu,  6 Aug 2026 12:59:47 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <carenas@gmail.com>; Thu,  6 Aug 2026 12:59:47 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.113.251])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hG6nH1kW4z1y6C; Thu,  6 Aug 2026 12:59:47 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.3])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id ACFA21B43EBC;
 Thu,  6 Aug 2026 12:59:46 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S003fe95eee0-28f9-46f1-af42-7971aa1a7ff8,
 3674F41004D9368A494C832AF9EEF1C5F00DB56D) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <6ab74d7d-d962-46c9-9183-6281a0fa2cec@kaod.org>
Date: Thu, 6 Aug 2026 14:59:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/aspeed: avoid sign mismatch on sscanf for uart
 property
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 qemu-trivial@nongnu.org,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "'qemu-arm@nongnu.org'" <qemu-arm@nongnu.org>
References: <20260802162828.16880-1-carenas@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260802162828.16880-1-carenas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 9602518831953783896
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEuuwlmVkdtrgI2K33GkR1csev/yaLK3UHNtqOgBIO6w7o9+3Az3zuPdz8hqW3FzEyQfZWvEojew/dBwQK81p/Xw9UTpgniG8oaT8D8M8he8xs8m+IVy93Ahh5tpKDf2R94UstW9YP3Du5JCMYizqrOuDW3mCzFwK0fSqZXaWra8zbnUyT5zLC86oQIHcW1CzHewpPg8EVPta2sM61wjRlUc26isK1A0pHsdLeoF+fSTghr/ShzyVybYWaAr19DueZzwWUw/bcG74KiyQZKXAPN37a2kjEdf/n8ta2V4/KhNI3iiaODRHVe4A89dwnk6mlyhdHH1HLKnI+WD59lPrZZZ7Y12VcHGP7mLqkhUgfvoU+Onz3JDCmiCEFL+NcjodUDc58YQ/c9YRJJtvhHd+DrBgAhRWvE4uBTGzONU5kqzWE2m2cg3IlKY/+DsRdRjKg/PuAvVDEiDaN/xQhLwVaGolPREac8t41hb/EgbRiRHp0X4orUWEwbI8WCu5dYNrS6qc3fuQJVMuaxPS3hguQugIU5buIrI5B9dlTIMQDG5xDDFwLgTaLJ0FSYScZfwaZ2cNWhQUohuqjnySWdLDDh+z+ZHgwxbhJ3KR0w6qNDXVI7WQaQ3qjEEmqQG3K8xDNLk46PkLs+0gtsSzWqE4PWbs1VneL9GutymcgxNPKFqg
DKIM-Signature: a=rsa-sha256; bh=HYy6bpBNudWOKjmob/54ZRkdQZDsaupVHVUG3lgSsOA=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1786021187; v=1;
 b=QbzMnqAVskhbRccNZOAK6Q6MuEOc9901A11TK92pWwHfzR56f4qJkDIbjy7NfNyGxD3cLbH/
 80MHTcQ+E9iXAW8f2cX1q+KjFHnd2Ss6s0+OVx3oLK4ZlBdbLoBxII9f/KWkjziG/mPbsEfwLZn
 cOr/SKsXeErEzyCmtxZ0dZlH6eZj1cZzBalTtrXoUe0At2FbH0WjtHZD46P7z1dsdFCtp3KlhyG
 G6uPEgvljR/oSjL5pVBwm8Fseb3Ztn39eRVeALUQtO53J0eOTWZ4xBB8Dti8WdQW39C2dbGiPJz
 KoSBg34wUHRmkvb+cj9CdY0Dh/o9unygIS/h4gxGEwVlg==
Received-SPF: pass client-ip=51.210.91.56; envelope-from=clg@kaod.org;
 helo=smtpout7.mo540.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 8/2/26 18:28, Carlo Marcelo Arenas Belón wrote:
> using "%u" with sscanf() was likely meant to indicate that a
> negative value was unexpected, but with a signed variable it
> could result in undefined behaviour.
> 
> use "%d" and check for a negative input explicitly.
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>   hw/arm/aspeed.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index a48c442058..a9238e6217 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -327,7 +327,7 @@ static void aspeed_set_bmc_console(Object *obj, const char *value, Error **errp)
>       int uart_first = aspeed_uart_first(sc->uarts_base);
>       int uart_last = aspeed_uart_last(sc->uarts_base, sc->uarts_num);
>   
> -    if (sscanf(value, "uart%u", &val) != 1) {
> +    if (sscanf(value, "uart%d", &val) != 1 || val < 0) {
>           error_setg(errp, "Bad value for \"uart\" property");
>           return;
>       }

The following test :

     if (val < uart_first || val > uart_last) {

would have caught the bad value but it's better to return early.

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


