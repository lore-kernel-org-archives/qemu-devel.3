Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58484CD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 14:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNAIM-000819-82; Wed, 13 May 2026 10:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wNAIK-00080r-Uc
 for qemu-devel@nongnu.org; Wed, 13 May 2026 10:10:40 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wNAII-0006MA-Qk
 for qemu-devel@nongnu.org; Wed, 13 May 2026 10:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1778681437; x=1779286237; i=deller@gmx.de;
 bh=XuNKkVDjOBq2swX2W5n7Rb15fnD/w1t2Dc5/9UlWVjg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=AAyhbZzQrHwLwTgiKiR1/q+rMmU7qZDWXkZRLoYBnU8jbdGSFLsm2z0yx//C7gOX
 JPPVM9DEOQkSo9eCetwzOqRgkqt4g5sxPB3jRAF6RCDF2wsTLJt0jV8omKMN0uRln
 k/ZDcDXXL5ZhyZvPfi1stRUgDZz/iFmpHPb19P/qewfU5O3IjTJnWTvPGu7ytTkle
 AcJf0HwODd1fc1wVsbHRQ93mMLspr43HTj+68k02tjGC1DeO+MXH3ytgq8m90MTTt
 1D0SL9xw7VTYVBl8eF5gq130kVRxCxMQCcZWhBAqRJm4qi2JUgCzk6l8ZZx6uNQ+A
 l6btiAI4Gttjv6U0TA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKbkM-1wfw802yMO-00T5qY; Wed, 13
 May 2026 16:10:36 +0200
Message-ID: <5103fb06-9a2d-4306-807f-240f3cc9c5a6@gmx.de>
Date: Wed, 13 May 2026 16:10:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/hppa: Inline UNALIGN() macro
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20260513074323.10616-1-philmd@linaro.org>
 <20260513074323.10616-3-philmd@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260513074323.10616-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1/CjP/TELUxkzXooDEi1LTQ4UK0u9w18iJ1sOeS2H2NnvrVbYWA
 zvcGhrn5zcUvoJBLNIx+XRZQgoLxSJFDt6/fI9mecgYUaYZwJ6XrCx33AdAWtiRVkxILjz4
 GNadtcUCq0RnEvV9biKDBTmSI2m4gwmRxSBbXscQRe95cgXRricnEuIUTw62teOk06IV4Bv
 WF8DgAmAtDXZXdYVeXcvA==
UI-OutboundReport: notjunk:1;M01:P0:VmEgHffn8kg=;GahxrXtl7wNqir1iyFcDiZVtOT5
 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
 wkgI8NFSLfv+e5A==
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/13/26 09:43, Philippe Mathieu-Daud=C3=A9 wrote:
> Directly access DisasContext::mo_align in place.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>   target/hppa/translate.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Helge Deller <deller@gmx.de>

