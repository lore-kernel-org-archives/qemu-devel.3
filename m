Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4008CC02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 04:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tftvW-00067Z-9N; Wed, 05 Feb 2025 23:55:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1tftvU-00066x-6F; Wed, 05 Feb 2025 23:55:44 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1tftvR-0003NZ-O6; Wed, 05 Feb 2025 23:55:43 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ab777352df4so7969466b.2; 
 Wed, 05 Feb 2025 20:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1738817739; x=1739422539; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XLVmGnTu9QcBFDGargltYNSyfitpcqPUI3TFnWJ4wsE=;
 b=DMnV9E16TQzu6VP5+jHZ3VKrziyMjUoOukI5ASXdl2a5frOTrCw9LsH+yvA2Fk+OFm
 3NQyJJ7AnbpcXhHfP7X7xfzKSMRNlf4kKo1RQm+sdsOqo7cWpjJR4wFHGePIT2xG5OxJ
 GMwz4TJN4QhBlL9KCzRmFjwaEv2XljNhqgBnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738817739; x=1739422539;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XLVmGnTu9QcBFDGargltYNSyfitpcqPUI3TFnWJ4wsE=;
 b=HhAzRY2BrH7e+XF1lTjTCAztBCt8/whfEbexsqNS0PcVZltlVC0diBbB3nBGBuVgaE
 L3jM6VGx8m3eBl2SCbAGjw25PmYYZbF+xTUc7rSkdF9seDr0Hz1R4J2oHHyMql+szVx8
 bCrpTxMFe5lIyhQOzBh17LaUrrNEa4jTTTBDdwrXcXxw9w7Twf05Zk0JGa4EqmtMP8C4
 Uz5wKmsVE1RYLgD2Cclyi9Om5l/yZsdduYWtoJd+Yktyxfu21ybSD6l688nkkErZvKDo
 eYpY++fBZXCedh5FYvr/UBRYR2grLx3O9dcfIpVkmOCNBghAP59CkZ5Rym6BvHwiQ7hb
 oaCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDAYFNLV58k5EGmJYxL9FsI6p1pQIXmfSrB8nmAJTaNEi3Hzet9kYq/LsWyRvW7vXleObtcqLLbA==@nongnu.org,
 AJvYcCXkI/3TOJLOtj2E+oo483HgROwHlRlJTpnVJyknANCRsyERx2MKWWGMnM1ZM8DE8TUiZ/2i3ysR5ZkHtw==@nongnu.org
X-Gm-Message-State: AOJu0YwxGdhCA5tJZdnatAZMOh4JdrujgAR2Ork5cvFzROutA6+25vGF
 ntlPtZ2HS04zJfzsI//EgjW1f8TXhxA+q5yRukLx9WGe1oXgMEXrYtTV7pZtb+B1S3NbmV47GZO
 FJGlkz8sQSmRB9DB8Pkn6OzQ13n0=
X-Gm-Gg: ASbGncvapUPG7e2VLUjcFaf9/E1Q/Ph4N4cS3tfAjhAv/280tXryLGznZUYDgi0emn/
 N+E0fN1RsF+HLKKXf2MuWrJ1ZCHLYjM3YyLKHP4ONfZeO2i0iL/kJnH9wPx9Cx3ouEU6msvNJ
X-Google-Smtp-Source: AGHT+IGyUIBbwnSb5RhqFzcfB5a8C3Jh3RX2GnJHDpsFi8moBC5oKb7nbpk96spQX/j8bcRYjRohmPuToOY2/ypX/28=
X-Received: by 2002:a17:907:3f8c:b0:ab7:b7d:62b with SMTP id
 a640c23a62f3a-ab75e212fb0mr566031766b.6.1738817739270; Wed, 05 Feb 2025
 20:55:39 -0800 (PST)
MIME-Version: 1.0
References: <20250121070424.2465942-1-jamin_lin@aspeedtech.com>
 <20250121070424.2465942-13-jamin_lin@aspeedtech.com>
 <cb18b72dbfce3a606a4bd7ea41732d451fbea0f1.camel@codeconstruct.com.au>
 <SI2PR06MB50414F9067112317161AD907FCF42@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <ad26f753de3648a2b238514ac7136847a2ae3a71.camel@codeconstruct.com.au>
 <SI2PR06MB50410511510D84B854672E8CFCF72@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <64d943d2e53c70ca55b33ec7a9b103368d72acc0.camel@codeconstruct.com.au>
In-Reply-To: <64d943d2e53c70ca55b33ec7a9b103368d72acc0.camel@codeconstruct.com.au>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 6 Feb 2025 15:25:27 +1030
X-Gm-Features: AWEUYZnCHO-LLNOyeq040VPSELTy8l87Av9SDnLykQ3kVM1c_Vx7fRyp1WcgJbM
Message-ID: <CACPK8XfaJKPObz+FuRQhP7SSxPCV+KNaeFgT+U0id6HhYQ0Fdw@mail.gmail.com>
Subject: Re: [PATCH v1 12/18] hw/arm/aspeed_ast27x0: Support two levels of
 INTC controllers for AST2700 A1
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>, 
 Yunlin Tang <yunlin.tang@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.069,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Jamin,

On Thu, 6 Feb 2025 at 10:09, Andrew Jeffery <andrew@codeconstruct.com.au> wrote:
> Thanks, I'll consider this updated diagram as well while I put my own
> together from the other pieces of info you've provided.

When you send the next version, please try to separate your code
cleanups and minor renames into a different patch. It makes it easier
to see what you're adding.

Thanks,

Joel

