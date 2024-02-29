Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D888C54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 08:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfbq7-0000tF-Ar; Thu, 29 Feb 2024 03:32:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=c5Gn=KG=kaod.org=clg@ozlabs.org>)
 id 1rfbq5-0000sm-R6; Thu, 29 Feb 2024 03:32:25 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=c5Gn=KG=kaod.org=clg@ozlabs.org>)
 id 1rfbq2-00030C-EH; Thu, 29 Feb 2024 03:32:25 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Tlkwn55Vkz4wyj;
 Thu, 29 Feb 2024 19:32:09 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tlkwk4JZfz4wxs;
 Thu, 29 Feb 2024 19:32:05 +1100 (AEDT)
Message-ID: <d6e7d67f-7498-4817-8586-8af216f9d739@kaod.org>
Date: Thu, 29 Feb 2024 09:32:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 8/8] aspeed: Add an AST2700 eval board
Content-Language: en-US, fr
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
 "joel@jms.id.au" <joel@jms.id.au>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>,
 Yunlin Tang <yunlin.tang@aspeedtech.com>
References: <20240229074234.976164-1-jamin_lin@aspeedtech.com>
 <20240229074234.976164-9-jamin_lin@aspeedtech.com>
 <SI2PR06MB5041B1EA856220BB77B8809DFC5F2@SI2PR06MB5041.apcprd06.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <SI2PR06MB5041B1EA856220BB77B8809DFC5F2@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=c5Gn=KG=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hello Jamin,

> I tried to send the patch series to support AST2700 but I encountered some patches
> were rejected by server IP 211.20.114.70.
> 
> Error Log:
> qemu-devel@nongnu.org
> eggs.gnu.org
> Remote Server returned '550-[SPF] 211.20.114.70 is not allowed to send mail from aspeedtech.com. 550 Please see http://www.openspf.org/Why?scope=mfrom;identity=jamin_lin@aspeedtech.com;ip=211.20.114.70'
> qemu-arm@nongnu.org
> eggs.gnu.org
> Remote Server returned '550-[SPF] 211.20.114.70 is not allowed to send mail from aspeedtech.com. 550 Please see http://www.openspf.org/Why?scope=mfrom;identity=jamin_lin@aspeedtech.com;ip=211.20.114.70

$ host -t txt aspeedtech.com
aspeedtech.com descriptive text "google-site-verification=77FsedIzGqFvs3bFfy5L2lT_AGEWVecyoJwZN7KDVnM"
aspeedtech.com descriptive text "v=spf1 ip4:211.20.114.72 include:spf.protection.outlook.com -all"
aspeedtech.com descriptive text "google-site-verification=sBPPFeYyix6oWeC3GRJ64zQNFLJpN6SFBMT8RX8ZuME"

May be try using 211.20.114.72 (mail.aspeedtech.com) as an SMTP server ?

> Did you encounter the same errors before?

I received the full series 4 times.

But the mailing lists only have 4 :

   https://lore.kernel.org/qemu-devel/20240229080014.1235018-1-jamin_lin@aspeedtech.com/
   https://lore.kernel.org/qemu-devel/20240229072315.743963-1-jamin_lin@aspeedtech.com/

or

   https://patchew.org/QEMU/20240229080014.1235018-1-jamin._5Flin@aspeedtech.com/
   https://patchew.org/QEMU/20240229072315.743963-1-jamin._5Flin@aspeedtech.com/


> My send email command as following.
> git send-email
> --cc troy_lee@aspeedtech.com
> --cc jamin_lin@aspeedtech.com
> --cc yunlin.tang@aspeedtech.com
> --to-cmd "./scripts/get_maintainer.pl ../v1-patch/*.patch" ../v1-patch/*.patch

The command line above is sending twice the same series, you should remove
one of the  "../v1-patch/*.patch" command arguments. the rest looks correct.

Thanks,

C.



