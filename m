Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40482CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 16:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRv4f-0006c3-7x; Tue, 26 May 2026 12:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wRv4Z-0006bn-Ri
 for qemu-devel@nongnu.org; Tue, 26 May 2026 12:56:08 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wRv4Y-0002dv-6l
 for qemu-devel@nongnu.org; Tue, 26 May 2026 12:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1779814560; x=1780419360; i=deller@gmx.de;
 bh=LepGH1xNGofPS7cb/Pb4QaIbogbR27i2pTkhJsdMdtQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=aWUbrLyOcV9AupDYoFEZPeFPKNxK3offDV+KuiqS+YRH2XgagF8gTl3Y+Wl25KLs
 mGkEOtJcBsiaw3TPHyizHi9wuPHaiIirY3M9iyt2uH7TyeGO8sox0oibTvOcYJEWr
 Ybbcxy3TBo7NxFFrE35SFYV+HTiYMA5fPVC9U1ydBBxfsa2upiVPkr7NVPwFsUrx5
 ARislehwmLUuMekI+aN/r58TAUuBcAVCpFE+tFQ5KY1V5cvVD9eSmjgoCU7PA63Xz
 GBmIcRi0MT7WIf6jDhtrYDpGMuvwLyFsrrPQDVe8lj5VwZcHrR7yz3NZAqsxRHAUl
 48709OxABdD7EtEbwQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mk0JW-1xC1O42yBU-00pqxQ; Tue, 26
 May 2026 18:56:00 +0200
Message-ID: <ec6bc270-660e-41b9-a00a-f6e9e2b984ed@gmx.de>
Date: Tue, 26 May 2026 18:55:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] linux-user: Move cpu_copy() to user-internals.h
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260526151757.2371476-1-peter.maydell@linaro.org>
 <20260526151757.2371476-3-peter.maydell@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260526151757.2371476-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rSQIZ2S1i288bqQdFM+4R9gvkS+zZxVSwPh4Va8OE92aOSAry2+
 h1LvJRDZdhTph/v0e624YcIGWDXJe78Uz6EwJpNwgo6Q6qmRyKISwIabVnZkGGVclbZMdYN
 CQqTkNW+azVGCsfJ0+Elr4J/4K6fFdZVQ7mGxHx/X3BmRUE7+r69GeCS+MwyPU1mBpYOhy7
 DbHxXQYWLFLRfVY5lplew==
UI-OutboundReport: notjunk:1;M01:P0:g1VMzNjCY6M=;HoA9bJpBOA+fsvr0yklA01LsDLx
 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
 3JKCpCc4vavwEurCdF1wBP/Vqzo=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 5/26/26 17:17, Peter Maydell wrote:
> We only use cpu_copy() inside linux-user, so we don't need to have
> the prototype in qemu.h available to code outside linux-user; move it
> to user-internals.h.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   linux-user/qemu.h           | 3 ---
>   linux-user/user-internals.h | 3 +++
>   2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Helge Deller <deller@gmx.de>

