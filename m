Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BD6CD5BA4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 08:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPyaa-0007xC-34; Thu, 21 May 2026 04:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wPyaX-0007wT-9N
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:17:05 -0400
Received: from smtpout4.mo533.mail-out.ovh.net ([46.105.32.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wPyaU-0003of-ML
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:17:04 -0400
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net [51.68.80.175])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4gLh8V2KB6z6Cj5;
 Thu, 21 May 2026 08:16:58 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net. [127.0.0.1])
 by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu, 21 May 2026 08:16:58 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.96.243])
 by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gLh8V0K3Zz5vfx; Thu, 21 May 2026 08:16:58 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id E9E0C1B43B67;
 Thu, 21 May 2026 08:16:56 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S0045db06091-436c-4bc1-8187-9b196fbbe8c4,
 155D954443A34AB19E7EFB78D45315E373F1C727) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <a2488d42-8e1e-48a3-99c0-bfbc806296d0@kaod.org>
Date: Thu, 21 May 2026 10:16:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/39] MAINTAINERS: Fix F: typo in "I3C"
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, pierrick.bouvier@oss.qualcomm.com,
 Joe Komlodi <komlodi@google.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Nabih Estefan <nabihestefan@google.com>
References: <20260521080511.999266-1-armbru@redhat.com>
 <20260521080511.999266-33-armbru@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260521080511.999266-33-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 13797340408611122360
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFj3VDDB884fKM7vS95TyyR1GZ2WJx4tvmaNaK5Va2xTuNS90IsXAxtksTCF3w6EJpb8e6OLKlyrnSCO2cHnNsP9nk2RTDPv1+Xr/hIosHz3jaN56gjZQ19x85WspR5VCkt3K8PRIFoGZnV3y52MmC2M3993IQ7G5v2DbkpanFLtBPzEKh7ath9lpYWdotDJCiG83yYubWP3YAYFf1nxJqysSGIbO5xc9Iw0UHlluurvpFKzG1pGSoy7CcbZZBzPS2O7uuOOFojbL6of48j0vibT1hI94cwOdkplLGY5j5Pu2qwMx8UY7XyA1/vwKOLpi4a/UgjhgbHMjK28I0H5gqynfJ/acjCN4rE0o3mcLhP3jALbqF/f/20LbsndoMN62Qc5VeFCMRROwQEG1/BhmXfg/4JXsyEc80+LCgcgqP87RqSbWRVb23QaZ3mr9xicrgekbkNeTPkpZq624zGZUZGipvcB3+2Bti7l96T7/LLQR2vMQwZsPfpdvRkArmpiikgOU1wdx/5umAkl0iZHiNSzAB9mPQ5RjOWTOwtLSZLaKyFgI24JI04DEbE6KBQ3FCdhtmEeMl/4LxcfAPHlkDP95WPTkazh4a9//qszykwRutpMaIDDF7zzbORP65aXQsapqrSgryg8aEp3uJtkXQ+C0TjJGUDWxFdAYPnh91NZA
DKIM-Signature: a=rsa-sha256; bh=VsgKSMrsISpVfEHRgRCO13jcyS9gkskf3KdGCcxqb7c=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1779351418; v=1;
 b=IEyo2txIoM9y3wTfmTqKwl3moiZv2tbzzLtAeYWN8u8l+/tMu2cWugS7oaXPL85VB0EQBk7c
 aMQlYr55wcz1WlJBn4KDYcEJkuMsEnx3R8x6DzS8MyCLp5K8q/igZd5Ilr74SvdkPTOcR7Z6tBj
 Bm64c47Db4qrIrXKpJlYt9EWY9RLCrLlwP588Gh8nb0Y+W+wLaGyNnjKk8OSeKqZZ0PNmb1heu0
 FTV3/FINQM6QdQsk2uhPEZVIJIycXuEJCqTia9La0YIBbIy5ErqimvfuI9ZWUgAk43bJ/i79FCS
 WotCeSXKKwTHAVIQEDLpemR9sW1TukTTjsBA98Gk0RE+g==
Received-SPF: pass client-ip=46.105.32.238; envelope-from=clg@kaod.org;
 helo=smtpout4.mo533.mail-out.ovh.net
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

On 5/21/26 10:05, Markus Armbruster wrote:
> Fixes: 5f682daa65 (MAINTAINERS: Add I3C maintainers and reviewer, 2026-02-25)
> Cc: Joe Komlodi <komlodi@google.com>
> Cc: Cédric Le Goater <clg@kaod.org>
> Cc: Jamin Lin <jamin_lin@aspeedtech.com>
> Cc: Nabih Estefan <nabihestefan@google.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b1b298fb0e..7899b91620 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3965,7 +3965,7 @@ M: Jamin Lin <jamin_lin@aspeedtech.com>
>   R: Nabih Estefan <nabihestefan@google.com>
>   S: Maintained
>   F: hw/i3c/*.c
> -F: hw/i3c/.h
> +F: hw/i3c/*.h
>   F: hw/i3c/Kconfig
>   F: hw/i3c/meson.build
>   F: hw/i3c/trace-events

oops. Sorry.


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


