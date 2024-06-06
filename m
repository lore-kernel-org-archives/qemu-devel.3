Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14DAC25B76
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 00:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF1GM-0008QS-W2; Wed, 05 Jun 2024 20:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1sF1GK-0008Q2-Ky
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 20:45:52 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1sF1GG-0001Na-2w
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 20:45:52 -0400
Received: from [192.168.68.112]
 (ppp118-210-171-248.adl-adc-lon-bras34.tpg.internode.on.net
 [118.210.171.248])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8C40720154;
 Thu,  6 Jun 2024 08:45:43 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1717634745;
 bh=/6DZXkEyDV6QFASyVdCJg/ppGUn58LwVN64hQO+ETa0=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=Pbn3sYXyHZlAOhYJhUWC7I8vjHOTBGB4EJDgN8wbQ3qnd6QcMnUTp6azxOFcExot1
 4woTAi5Sjz0QgNgd/DxJYqXX55akqUuqrUYLaXWj/vV2pd/jezJslKt2tSr4983LVi
 sKx+Sv1uI9PGS2rolpXm76TOaQwjhWiduGCMlmY6ZyNek2ueTCkMyyB4P3EgQfFQwZ
 gAlFQgreKjT64OXqhaSsdsf3FIRukUuCSUDWrmFQ3gn4v37YdMsoL4EXy2D6cO0nTW
 avgdLJED7K85zM+5RYyWCoy6vpBWvSoRu7W9aJc+stE7GADA8UIHP/8oQEEIV6F+yl
 v0IgVz2SIDq/Q==
Message-ID: <ad40b540d39bcd9e67f8c8b21c356d394eb6770f.camel@codeconstruct.com.au>
Subject: Re: [PATCH] MAINTAINERS: Add reviewers for ASPEED BMCs
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jamin Lin <jamin_lin@aspeedtech.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Thomas Huth
 <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Cc: steven_lee@aspeedtech.com, troy_lee@aspeedtech.com
Date: Thu, 06 Jun 2024 10:15:43 +0930
In-Reply-To: <20240605060310.1946803-1-jamin_lin@aspeedtech.com>
References: <20240605060310.1946803-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=203.29.241.158;
 envelope-from=andrew@codeconstruct.com.au; helo=codeconstruct.com.au
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 2024-06-05 at 14:03 +0800, Jamin Lin via wrote:
> Add ASPEED members "Steven Lee", "Troy Lee" and "Jamin Lin"
> to be reviewers of ASPEED BMCs.
>=20
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>

I'm not very active wrt qemu these days but am still interested in
Aspeed-related patches. For what it's worth:

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 951556224a..0f63bcdc7d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1158,6 +1158,9 @@ F: docs/system/arm/emcraft-sf2.rst
>  ASPEED BMCs
>  M: C=C3=A9dric Le Goater <clg@kaod.org>
>  M: Peter Maydell <peter.maydell@linaro.org>
> +R: Steven Lee <steven_lee@aspeedtech.com>
> +R: Troy Lee <leetroy@gmail.com>
> +R: Jamin Lin <jamin_lin@aspeedtech.com>
>  R: Andrew Jeffery <andrew@codeconstruct.com.au>
>  R: Joel Stanley <joel@jms.id.au>
>  L: qemu-arm@nongnu.org


