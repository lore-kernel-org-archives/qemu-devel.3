Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C41BC54791
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 19:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjP5Y-0004tz-6m; Sun, 10 Mar 2024 15:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor.prutyanov@phystech.edu>)
 id 1rjP5W-0004tn-6O
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 15:44:02 -0400
Received: from forward502c.mail.yandex.net ([2a02:6b8:c03:500:1:45:d181:d502])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor.prutyanov@phystech.edu>)
 id 1rjP5T-0005V3-UP
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 15:44:01 -0400
Received: from mail-nwsmtp-mxback-production-main-26.sas.yp-c.yandex.net
 (mail-nwsmtp-mxback-production-main-26.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:1f8c:0:640:87b7:0])
 by forward502c.mail.yandex.net (Yandex) with ESMTPS id 1C82F60AF4;
 Sun, 10 Mar 2024 22:43:51 +0300 (MSK)
Received: from mail.yandex.ru (2a02:6b8:c07:109f:0:640:e5c2:0
 [2a02:6b8:c07:109f:0:640:e5c2:0])
 by mail-nwsmtp-mxback-production-main-26.sas.yp-c.yandex.net (mxback/Yandex)
 with HTTP id lhqFxf3O3Gk0-cmWVpMHp; Sun, 10 Mar 2024 22:43:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phystech.edu;
 s=mail; t=1710099830;
 bh=2vj0CyevoylevHuX4Nd5J0vlZfNh7imdfHufES0ppiM=;
 h=Message-Id:References:Date:Cc:Subject:In-Reply-To:To:From;
 b=G0bw859Ajbm2yAjfAOWmfjO5cFFwJ5B63qypXmiWI2Vck/x/FolGlAE2si7+ojp+s
 d05QkizFi3WB4nO32isueKK3R1qvZdKyL3YFeQsMDtAvA+eezc4a8kmg0b0F9salPh
 DzPE8FNQpKwglWvtMIiebxmb4dGJJ+5N1QEfUOxQ=
Authentication-Results: mail-nwsmtp-mxback-production-main-26.sas.yp-c.yandex.net;
 dkim=pass header.i=@phystech.edu
Received: by 2fn25nujxewfskko.sas.yp-c.yandex.net with HTTP;
 Sun, 10 Mar 2024 22:43:50 +0300
From: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
In-Reply-To: <20240307-elf2dmp-v4-15-4f324ad4d99d@daynix.com>
References: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
 <20240307-elf2dmp-v4-15-4f324ad4d99d@daynix.com>
Subject: Re: [PATCH v4 15/19] MAINTAINERS: Add Akihiko Odaki as a elf2dmp
 reviewer
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Sun, 10 Mar 2024 22:43:50 +0300
Message-Id: <736761710099830@2fn25nujxewfskko.sas.yp-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:d502;
 envelope-from=viktor.prutyanov@phystech.edu; helo=forward502c.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> MAINTAINERS | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 65dfdc9677e4..d25403f3709b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3583,6 +3583,7 @@ F: util/iova-tree.c
> 
> elf2dmp
> M: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
> +R: Akihiko Odaki <akihiko.odaki@daynix.com>
> S: Maintained
> F: contrib/elf2dmp/
> 
> --
> 2.44.0

Reviewed-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>

