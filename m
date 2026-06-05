Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588CBCD6E79
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVVqY-0006nh-4M; Fri, 05 Jun 2026 10:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wVVpw-0006fh-7f
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 10:47:56 -0400
Received: from msg-1.mailo.com ([213.182.54.11] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wVVpt-0000mD-5H
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 10:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780670863; bh=bEhPGsHmuIZ/lR5Rzhh9JUZQ8iiPytPoZwFEb10VxfA=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=V9zkQnUuTZr+wRpdRVIk0tlAtjezMPWXE6cS6KOYSjJmEliZMmSDgekU8+JiWV8y4
 HoswpPOAPhj4/AlE6cGkqdGZ5Okt4xeaT1ZDQx4ge53TbhEUObQPORsCeOCs4rgvTN
 pkN/cGYYIHSgIyEdQpLwrIHcVP+a394fOmAEDu7Q=
Received: by be1-2.in.mailobj.net [192.168.91.12] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Fri,  5 Jun 2026 16:47:42 +0200 (CEST)
X-EA-Auth: cx4Po0RElPkL5flKDDu2Ms0lETeqQjeGAWyxI1GyN5SjFfujvFg4jfUBqGsQ6DMIiW9XvT39RPTP5TnWV8SSIVVMGPhdD8Ej
Message-ID: <421abd3d-0e19-4350-b060-5e09494647ec@mailo.com>
Date: Fri, 5 Jun 2026 16:47:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/9] target/hexagon: add build config for softmmu
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260529215937.610229-1-brian.cain@oss.qualcomm.com>
 <20260529215937.610229-8-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260529215937.610229-8-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.182.54.11; envelope-from=philmd@mailo.com;
 helo=mailo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 29/5/26 23:59, Brian Cain wrote:
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   MAINTAINERS                                 |  1 +
>   configs/devices/hexagon-softmmu/default.mak |  7 +++++++
>   configs/targets/hexagon-softmmu.mak         |  7 +++++++
>   target/hexagon/cpu.h                        |  7 +------
>   target/Kconfig                              |  1 +
>   target/hexagon/Kconfig                      |  2 ++
>   target/hexagon/meson.build                  | 13 ++++++++++++-
>   7 files changed, 31 insertions(+), 7 deletions(-)
>   create mode 100644 configs/devices/hexagon-softmmu/default.mak
>   create mode 100644 configs/targets/hexagon-softmmu.mak
>   create mode 100644 target/hexagon/Kconfig


> diff --git a/configs/devices/hexagon-softmmu/default.mak b/configs/devices/hexagon-softmmu/default.mak
> new file mode 100644
> index 00000000000..08e709aea72
> --- /dev/null
> +++ b/configs/devices/hexagon-softmmu/default.mak
> @@ -0,0 +1,7 @@
> +# Default configuration for hexagon-softmmu
> +
> +# Uncomment the following lines to disable these optional devices:
> +
> +# Boards are selected by default, uncomment to keep out of the build.
> +# CONFIG_HEX_DSP=y
> +# CONFIG_L2VIC=y
Please remove that CONFIG_L2VIC line: this symbol is never
defined AFAICT. No need to repost.

Acked-by: Philippe Mathieu-Daudé <philmd@mailo.com>



