Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F68C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 09:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we8Se-0006HJ-Mo; Mon, 29 Jun 2026 05:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1we8Sa-0006G8-Vb
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 05:39:24 -0400
Received: from smtpout6.mo537.mail-out.ovh.net ([51.210.91.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1we8SZ-0006pM-ED
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 05:39:24 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [152.228.215.222])
 by mo537.mail-out.ovh.net (Postfix) with ESMTPS id 4gph7X5ltKz49Zs;
 Mon, 29 Jun 2026 09:39:20 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <yujun@kylinos.cn>; Mon, 29 Jun 2026 09:39:20 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.118.85])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gph7X0mgjz5x96; Mon, 29 Jun 2026 09:39:20 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.2])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 85F491B43D14;
 Mon, 29 Jun 2026 09:39:19 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-102R0043c2c4c38-78b6-4144-bafb-31ca0c51d823,
 1EEB315DF7D19D59129F6169D62007CD6D44ED18) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <8a638ded-8578-414b-8680-0dc9c61e5305@kaod.org>
Date: Mon, 29 Jun 2026 11:39:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/gpio/pca9552: fix off-by-one in QOM led index
 validation
To: yujun <yujun@kylinos.cn>, Glenn Miles <milesg@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20260629074133.187549-1-yujun@kylinos.cn>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260629074133.187549-1-yujun@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 4415779437036612705
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGaaUsA2lKLNwv6V0WgsXAtC5sIf24AiEL1z76m1rqOxBUI9eOfX035HG+eDTO5dcAU4TJVFYKeqtzvOQI1A5BoLigOKcXEYpu0c/qSqZds7RiF8Hgu0yTofkiSiv58ORAIOHy76SqC5jyY19Bg45muioIKtEZCG3soPdulC2QLsD9bMourj56Cu300pASEvp4suAaowSofLS3rukTfUp5qvMRwxDFG3ftin+XUS8luz+ouq/b8l79ylFzH3jmJTXt3N9jWc2qb0tYPRCOP5WWlq1YHyP06o2Q5Za+1mOGudxonEWiGqPRneT4/HMFfzYvL18RSD86u+CULsn662gbJfPIlWTcA2In3GUHrtZdjZ3c61Oz17Fpwb5SRJpXn5BLLNBVDmAwye8q7q1FSp8tKiILob6rITBXUrMiG7e8ciYd3doi8MfSxLOTjhu8pTNKq6NIUZb8B0EZOxt/pfBtaqrBL7zlyr/SfH4Zvx5I+tQowLfYkdVrrm9ONTdBEjYPof+4id+xrRdqwJ8TeNzzVRDCKU7dyTB8lf4XDtGbmTm32exzGrbNT00EDzsR9vyfvG9u4+mBCraojAWLrZ1D1gkMHMcGrWYjO6I1RjeWdhlzouKAnf22HGufrusgDeshXzdhAiplDXoePS9eh7zWzsxA1O9jJz7Cv7ro6+UAG0Q
DKIM-Signature: a=rsa-sha256; bh=TUQk/s7vB4j9PDWFD6J5Tw7RgBpvFqV9x69upVELpRM=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1782725961; v=1;
 b=sHqRK4GBGpIOZEmdzZuRiB8nttSQN0JJLc/NEInchwJNOFLFNZbFlcwxiKfZ5vH7E78PWq+Y
 5L5KMT01uBea0hWEFecsHKgaqa3yzD8hsJi/HPHX3MZFNYnVVDtvmKlN3sbfvPC5wDKMvK9tBvv
 nF2JdnfUK5QC2Cr+zAtaGYa0z3mfkcxdlHSAWUKAgw9H/sK6U1TYljdDMTjuHIG2mXJGH10Qn1E
 gi+02tBvPB3jrC2E1OMMfE+odBLsO0MUW4g+XddgKQ9bCimkIV/fV3QNTUzIQ6XBwWrhhUKYsza
 bxuAat7Qrypeov5LoDFWqlE7GemEE+2RSnQfb6wP4lgcw==
Received-SPF: pass client-ip=51.210.91.25; envelope-from=clg@kaod.org;
 helo=smtpout6.mo537.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Glenn,

Cc: me if you ack this change. I can take it through the aspeed queue.

Thanks,

C.


On 6/29/26 09:41, yujun wrote:
> pca955x_get_led() and pca955x_set_led() accept led indices equal to
> pin_count, but valid indices are 0..pin_count-1.  For a 16-pin device,
> led16 passes the current check and then accesses an LS register past
> max_reg.
> 
> Use the same >= pin_count bounds check as pca9554_set_pin() and the
> gpio input handler assert in this file.
> 
> Fixes: a90d8f84674 ("misc/pca9552: Add qom set and get")
> Signed-off-by: yujun <yujun@kylinos.cn>
> ---
>   hw/gpio/pca9552.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
> index 472d8ad957..b13ac9fd9c 100644
> --- a/hw/gpio/pca9552.c
> +++ b/hw/gpio/pca9552.c
> @@ -311,8 +311,8 @@ static void pca955x_get_led(Object *obj, Visitor *v, const char *name,
>           error_setg(errp, "%s: error reading %s", __func__, name);
>           return;
>       }
> -    if (led < 0 || led > k->pin_count) {
> -        error_setg(errp, "%s invalid led %s", __func__, name);
> +    if (led < 0 || led >= k->pin_count) {
> +        error_setg(errp, "%s: invalid led %s", __func__, name);
>           return;
>       }
>       /*
> @@ -352,8 +352,8 @@ static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
>           error_setg(errp, "%s: error reading %s", __func__, name);
>           return;
>       }
> -    if (led < 0 || led > k->pin_count) {
> -        error_setg(errp, "%s invalid led %s", __func__, name);
> +    if (led < 0 || led >= k->pin_count) {
> +        error_setg(errp, "%s: invalid led %s", __func__, name);
>           return;
>       }
>   


