Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B2D0C41513
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 21:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP7Ro-0003W1-Ju; Wed, 03 Jul 2024 17:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roderickklein@xs4all.nl>)
 id 1sP7AA-00074a-FJ
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 17:05:14 -0400
Received: from ewsoutbound.kpnmail.nl ([195.121.94.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roderickklein@xs4all.nl>)
 id 1sP7A8-0005El-6C
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 17:05:14 -0400
X-KPN-MessageId: ed1f5a0c-397f-11ef-959b-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id ed1f5a0c-397f-11ef-959b-00505699b430;
 Wed, 03 Jul 2024 23:05:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=content-type:subject:from:to:mime-version:date:message-id;
 bh=sbDJ5RFz9jcmmd4RKMYSFp0FIu2I9Rg76DaAeTufIZY=;
 b=PJd87ne982WPhG1nARhBXI750dxiXuqmSFG0WnFaarC5fpo7wNhEzJYO1kRGN/42VWI9WYIZN1y2D
 rk3ts0wSETtmFmrDL5tOKwFuyy4hhEdgoE5IPssqvjxMJKFWCsusFC5xmVV/eOAcAgJZvd4qgWcojq
 1t5ozRNYKGZ8IGuoUa1qD0cN/59y1Suw+/T00sG0XUbWPh4SxEbrDiHhZeYXeVNMTilxsbaFhUFUsj
 yDZalsDp9bCF/z68BOrRGsxSJxwwQQ5D/VdfwB2xdczGEN6841Bmk3eHl5g/3b2sRZ1+RWpp63XA+Q
 lHP56oXvmiaQxHKk1I+W0cNh8jA/oAw==
X-KPN-MID: 33|UzZtm9XzzEJWUkPRbR7Ncw0H9QWN3Xr3OlrtEjxUB6QmHY1aDcIjYgZEYyG45uv
 s0yG9vSC8J8UCCi6UxFxl7aL+5AmunQcswhN72xPBmEk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|U0OB9ReuY3WmvL5709TWQ3alW9t9LwEZzhecZBznpokkOW0K5e2TZdGjMk6WNNm
 TF+Td5l+UbrlIfmZKvHBblQ==
X-Originating-IP: 45.138.54.154
Received: from [192.168.243.144] (smcc.connected.by.freedominter.net
 [45.138.54.154]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id eda1e380-397f-11ef-8b20-00505699d6e5;
 Wed, 03 Jul 2024 23:05:08 +0200 (CEST)
Message-ID: <3de7c42c-575b-4e29-9d4d-85d0d0f67da4@xs4all.nl>
Date: Wed, 3 Jul 2024 23:05:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: nl
To: qemu-devel@nongnu.org
From: Roderick Klein <roderickklein@xs4all.nl>
Subject: Question about OS/2 support under QEMU....
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.121.94.186;
 envelope-from=roderickklein@xs4all.nl; helo=ewsoutbound.kpnmail.nl
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 03 Jul 2024 17:23:27 -0400
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

Hello

Recently a bug was opened to get QEMU to support OS/2 again (newer 
versions of OS/2).
https://gitlab.com/qemu-project/qemu/-/issues/2198

I would like to point out a company from the US supports a current 
version of OS/2 called ArcaOS.  I was trying to help out to figure out 
where I could point the company to contact somebody at QEMU (if the QEMU 
team is interested) to receive a copy a ArcaOS so they could test QEMU ?

BTW where is documentation how to create clipboard and mouse integration 
for QEMU. I recently worked on a project for ESXi and would like to look 
what could be done to get VM integration for ArcaOS done for QEMU.

Best regards,

Roderick Klein
Dutch OS/2 VOICE foundation

