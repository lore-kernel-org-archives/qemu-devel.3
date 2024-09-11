Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683D6EE57C8
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 17:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soRCu-0005An-Gz; Wed, 11 Sep 2024 13:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3k+6=QJ=kaod.org=clg@ozlabs.org>)
 id 1soRCt-0005AJ-6q
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 13:32:43 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3k+6=QJ=kaod.org=clg@ozlabs.org>)
 id 1soRCr-0001SG-1K
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 13:32:42 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4X3nhJ4FBnz4x2J;
 Thu, 12 Sep 2024 03:32:32 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4X3nhH0Bqtz4wx5;
 Thu, 12 Sep 2024 03:32:30 +1000 (AEST)
Message-ID: <943ff9ca-92db-44d4-939c-eb52cc678735@kaod.org>
Date: Wed, 11 Sep 2024 19:32:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] hw/sensor/tmp105: OS (one-shot) bit in config
 register always returns 0
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>, qemu-devel@nongnu.org
References: <20240906154911.86803-1-philmd@linaro.org>
 <20240906154911.86803-5-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240906154911.86803-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=3k+6=QJ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/6/24 17:49, Philippe Mathieu-Daudé wrote:
> Per datasheet, "ONE-SHOT (OS)", the OS bit always returns 0 when reading
> the configuration register.
> 
> Clear the ONE_SHOT bit in the WRITE path. Now than the READ path is
> simpler, we can also simplify tmp105_alarm_update().
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   hw/sensor/tmp105.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
> index 6740200aea..f5101af919 100644
> --- a/hw/sensor/tmp105.c
> +++ b/hw/sensor/tmp105.c
> @@ -42,12 +42,8 @@ static void tmp105_interrupt_update(TMP105State *s)
>   
>   static void tmp105_alarm_update(TMP105State *s, bool one_shot)
>   {
> -    if (FIELD_EX8(s->config, CONFIG, SHUTDOWN_MODE)) {
> -        if (one_shot) {
> -            s->config = FIELD_DP8(s->config, CONFIG, ONE_SHOT, 0);
> -        } else {
> -            return;
> -        }
> +    if (FIELD_EX8(s->config, CONFIG, SHUTDOWN_MODE) && !one_shot) {
> +        return;
>       }
>   
>       if (FIELD_EX8(s->config, CONFIG, THERMOSTAT_MODE)) {
> @@ -166,7 +162,7 @@ static void tmp105_write(TMP105State *s)
>           if (FIELD_EX8(s->buf[0] & ~s->config, CONFIG, SHUTDOWN_MODE)) {
>               printf("%s: TMP105 shutdown\n", __func__);
>           }
> -        s->config = s->buf[0];
> +        s->config = FIELD_DP8(s->buf[0], CONFIG, ONE_SHOT, 0);
>           s->faults = tmp105_faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
>           tmp105_alarm_update(s, FIELD_EX8(s->buf[0], CONFIG, ONE_SHOT));
>           break;


