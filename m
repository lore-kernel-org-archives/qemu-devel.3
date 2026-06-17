Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D372CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 18:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZuhv-0006sh-3B; Wed, 17 Jun 2026 14:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wZuht-0006sX-U6
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 14:09:45 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wZuhs-0004xg-CY
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 14:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1781719782; x=1782324582; i=deller@gmx.de;
 bh=tRW9G7QC759bM/++LZmaMgXvBEeiU8p1J1rO/MF6ufw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Ss3s5XIp+eaaIhdH2V4B9WgxzFsNpNXZGTq/iPJIR7RVlLlfdVPohBPzvVDlFVIN
 HgC7oVM+fWSv+xATqPlpCjrF4wTuVM5RO1U4GuaTtApFjjp8CLkOoQRRhKFH3jH6f
 zi0prGfcCuDRO/Y3U3zOu3NpcyPE28pkR/pQKEdps7GITS7F/PldzkrKzi7AtJ4S+
 QyyxgV9LlAsyC54Thb2icx8gio70boSsHAopHo3f+hrVk3KeTFHXLpR74OA1tLbMc
 ++SW1XVVg/GhL5Yh4GqYh/M8BhlzpcEKwh6BmyLaT3/XkQDWEsyGDnttEybvb5+1h
 mlKlnZkhD1Tppqywhg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mgeo8-1x7u5C0ZGm-00qMWa; Wed, 17
 Jun 2026 20:09:42 +0200
Message-ID: <b1191ab1-53b2-4316-848d-e1130a7f8768@gmx.de>
Date: Wed, 17 Jun 2026 20:09:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] include/user/guest-host: Include missing cpu.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20260616212055.334466-1-richard.henderson@linaro.org>
 <20260616212055.334466-9-richard.henderson@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260616212055.334466-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TJazKk2B7E+5wl8w15zB+oMWxCnlN8b9ai0KKkDjg+DR+HzWeXu
 agkQJPSk9Vto5QWli4PcsMj5G8kZddl9OnY/ddLwJqpc3Vz/KaFUZHKJDSE+K2QB3+30x5m
 zxJ7GLnmFIY6CMq1+qzUbgnP9LZRXnj1G/GA+BSRQ5M7zx4uBC8i+jJLeozzuSpCAJJ0sXm
 u26XMBg7V41nKm8uR8fDA==
UI-OutboundReport: notjunk:1;M01:P0:r43l/UgwUPE=;FXDwleRtfnLgPjcL5YhiWI6ZLz0
 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
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/16/26 23:20, Richard Henderson wrote:
> This file dereferences CPUState without including the required header.
>=20
> Reviewed-by: Warner Losh <imp@bsdimp.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de


