Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFD9CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 16:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRv2n-0005Tx-6V; Tue, 26 May 2026 12:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wRv2k-0005PM-PX
 for qemu-devel@nongnu.org; Tue, 26 May 2026 12:54:14 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wRv2j-0001z5-0m
 for qemu-devel@nongnu.org; Tue, 26 May 2026 12:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1779814450; x=1780419250; i=deller@gmx.de;
 bh=sXev5Eml93xEuRXjlz5vNrKuq8Ih9YB0kOE2gY21b7I=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=VW95naJy8qeacdh9ccQQkUTBh7CwMd4Xuz4knTNcizTQqI0ceCUvjFVPnm02E0th
 SsbvFdsZSdqeL/rKPeYi5bXGIDKi/syaad8cmLJPxsgQWAi/JztFEL8zf67qk1WaY
 e3KCCw/wGQc/3zRpa9Wbr+tVS8xOGFrztHCfNzVk4C1GszjeSqFKR8MOuiyHsxn64
 HAVFqzVmfmix4UdpKuag12KuYk9OK08GrcmHwFSYhul/XMt1hB0hLNylz5t7Bn5/p
 tEb54nfkmx+8t0K0EQc96IG+gRD7rTVVU56NBnwBNba+gDNtdZ/XwcK7MZZQJTMF6
 W54uynxnSusC3DZf0g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MowKi-1x73sK1yzG-00ZdYV; Tue, 26
 May 2026 18:54:10 +0200
Message-ID: <595ed781-6aea-4fd6-8108-f157aad2e275@gmx.de>
Date: Tue, 26 May 2026 18:54:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] linux-user: Move init_main_thread() prototype to
 user-internals.h
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260526151757.2371476-1-peter.maydell@linaro.org>
 <20260526151757.2371476-2-peter.maydell@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260526151757.2371476-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lqqHe/cf7VNsX7MOxt28+iEGUtst5Ig74ECY8wihSjfoZd5bdaf
 hrBzOTjGjjMllTEn0zXlIseKS5FUZbSUOOVH4Sp5lw+oNwgaDUA5aLpyRQIqG3sSrkLda8s
 lMMaoZ4U6VvTClBJXfqUCZIpxZpIsujqUf+IkJLsUR5KacmmnFiBmmsCq8OAgG8jzFy6ben
 MCzgbhcE/ewDAkeZI/B0Q==
UI-OutboundReport: notjunk:1;M01:P0:G8z1AGbaTzo=;hntJBm0gBYIYSrH1bGEysI1SudJ
 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
 7rQkMNQEXvN96Ajqpk=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
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

On 5/26/26 17:17, Peter Maydell wrote:
> The init_main_thread() prototype is needed only by code internal to
> linux-user/, so it doesn't need to be in qemu.h (which is also pulled
> in by various files outside linux-user/).
>=20
> Move the prototype to user-internals.h, and give it a documentation
> comment.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   linux-user/qemu.h           |  2 --
>   linux-user/user-internals.h | 15 +++++++++++++++
>   2 files changed, 15 insertions(+), 2 deletions(-)

Reviewed-by: Helge Deller <deller@gmx.de>

