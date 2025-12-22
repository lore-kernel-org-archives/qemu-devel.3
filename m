Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E8AE6ADF9
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 22:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXoGQ-0001pV-Fp; Mon, 22 Dec 2025 17:20:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vXoGO-0001pI-LP
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 17:20:24 -0500
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vXoGM-00032W-VH
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 17:20:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1766442019; x=1767046819; i=deller@gmx.de;
 bh=w9//1PZ2vMKJkF3ODfWa71Paf49fI/U4gn6h3yTZhqA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=jUSUJVp6yuNrk/HbWZ144t4OiIANA5hWrk8ibzRZafFF7a+Gv178OF4Q82mxClfz
 VaWi1Bl8vaoON+unmqNKCADDUPoMhztNzrtWexjypSH9W/61c4N3MgaMK0QhHc/rt
 aWRljbRro9I0vEyzDdR4sdJA7qrU82n0Q8E9GLomC5W9wkS4axVSfSaOPkPD80lBE
 OvhP0eC+Sa3oP2cACgN6W+rIsi8+cz3ZKHE3qRbjaSmfOEw6kKYH761uT1zhNucRs
 Nji4t5gtV1I4GMVl3jWEtmvlmblwDyny6rRcTXEfEyPbaXbu3AjW4hUbmE/YLPrHT
 hL4xPYI0361VtzZrmQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.229]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M42jQ-1vXoGJ0LuS-003v2A; Mon, 22
 Dec 2025 23:20:19 +0100
Message-ID: <5979a61b-adaa-466f-a8dc-50f2ce2f9462@gmx.de>
Date: Mon, 22 Dec 2025 23:20:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] target/hppa: add 64 bit support to gdbstub
To: Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20251113044857.67290-1-svens@stackframe.org>
 <20251113044857.67290-2-svens@stackframe.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20251113044857.67290-2-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:E3BgOBNIp5a7aryaZRtjWUXMhMK+FqBCJJHJ56VHAOiWcLJ7jRs
 VEDXySvFLDv1B252QArGK/7TTnYan3dtFMEedSheSxkclb7nbxOIAtgQr2SZer6ftu7VywZ
 gQmRAP4n0WnOtDlEwhzOkBs4NpILoBHa9Zqh/v9SUbGAUGAmWM68C1L2xYkTgNyJwJZEfjS
 Lcn+eF/FxSmbVDpIVlTqg==
UI-OutboundReport: notjunk:1;M01:P0:n9PTZdNqQ/k=;SOvqcFui9rvLXWfshq5wvNduyle
 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
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/13/25 05:48, Sven Schnelle wrote:
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>   target/hppa/gdbstub.c | 62 ++++++++++++++++++++++++++++---------------
>   1 file changed, 41 insertions(+), 21 deletions(-)

Reviewed-by: Helge Deller <deller@gmx.de>


