Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E56606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.eu header.i=@posteo.eu header.a=rsa-sha256 header.s=1984.8680eb header.b=Oj9jnZYi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqs2-00010k-Es; Fri, 30 Oct 2026 13:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1xMqqy-0008R0-1h
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:57:31 -0400
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1xMqqv-0008Ja-O9
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:57:23 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id E3664240027
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:57:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu;
 s=1984.8680eb; t=1793383036;
 bh=A4WecCnFQA/P+0BPirHilDysal/q/G8LGyUaFI46FYA=;
 h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:From;
 b=Oj9jnZYiVtUix3ExovW+nMmfQivpw4men1QoR1Iq9xAjKg6gQ/WUYK2jiv8Ey1tVg
 hY4unvwnTmXCvgls3AeybQF1mQe6NO6MZPtHiYS0zD3lk7K0oJh6TOXfsNCShM0fro
 CrMr8rcaJFpPh15vavHW2GJvDNJHCSuepRRVNDCKP4xsouUT5VKIoGgYLYq8deTfjz
 YHZWDlDp4/bGgiMIdFttav10vRcrZeyaACNi5k7R2/Yf2QVKifLhcckkL362XyVVAI
 0g9R0kCNTu0+G0lO1dvSDZ96XoD/3/ozSvCckykM6v5AlAR4QhH6JZ+6C7VsWGYRIJ
 nQbEkBIx9z8VA==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4jGTMJ1DTGz6v1C;
 Fri, 30 Oct 2026 18:57:15 +0100 (CET)
Date: Fri, 30 Oct 2026 17:57:16 +0000
From: Thomas Huth <th.huth@posteo.eu>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@oss.qualcomm.com>
Subject: Re: [PATCH] hw/m68k/next-cube: Show deprecation notice to users
Message-ID: <20261030185714.54a47d25@tpx1>
In-Reply-To: <20261030100659.781819-1-peter.maydell@linaro.org>
References: <20261030100659.781819-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.67.36.65; envelope-from=th.huth@posteo.eu;
 helo=mout01.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am Fri, 30 Oct 2026 10:06:59 +0000
schrieb Peter Maydell <peter.maydell@linaro.org>:

> In commit 5d3333e12a034 we deprecated the next-cube machine, but
> forgot to set its MachineClass::deprecation_reason. Add that, so
> that anybody running the machine is shown the warning that it's
> now deprecated.
> 
> Fixes: 5d3333e12a034 ("docs/about: Deprecate the 'next-cube' m68k machine")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/m68k/next-cube.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> index d8cb4a8c23d..0d927c7b485 100644
> --- a/hw/m68k/next-cube.c
> +++ b/hw/m68k/next-cube.c
> @@ -1370,6 +1370,7 @@ static void next_machine_class_init(ObjectClass *oc, const void *data)
>      mc->default_ram_id = "next.ram";
>      mc->default_cpu_type = M68K_CPU_TYPE_NAME("m68040");
>      mc->no_cdrom = true;
> +    mc->deprecation_reason = "machine is incomplete and cannot boot a kernel";
>  }

Reviewed-by: Thomas Huth <th.huth@posteo.eu>

