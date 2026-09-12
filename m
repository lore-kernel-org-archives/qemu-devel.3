Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA00C88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5KyH-00049d-Lq; Sat, 12 Sep 2026 06:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x5KyG-00049H-27
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:28:32 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x5KyD-0006Z0-Sw
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1789208905; x=1789813705; i=deller@gmx.de;
 bh=HrB+q22BuJTtFblByS1frmlR+89TfJtbfTU/dZe7q38=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=PnMZkJYIevwWmqNSowHIHh1Mqh18pR9hcKphXvVEus2JDkxuIINsVhPLMfaUW5hk
 IYvRo+Z6hz1O5ehAEK+0+RFm9wPyaP4Qzf58SFw1jfDNu+TTJpCT0qncwuA52WNIy
 +Ps/appS49x35KVbTBFFIrEyodaedarmMFoE+J4Fs95jC4Um0F2O8K7PFV7bb34LQ
 Bjh4cq8s42qEJXvfa8IQXhh4E00+OV70uDNOVsbeVKF4asi0+3O1SAzIuwcB3sSYD
 nqGhZ7m0dZ1hvmvKv3bceKsb0A0qGPyvPF5skWg64DLUV7qWXsWIEU1qmEu1JLwzO
 xPB74gHsd8LBvVga3Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MatRT-1wYkEs1Owd-00if86; Sat, 12
 Sep 2026 12:28:25 +0200
Message-ID: <e3d8379c-34f7-450d-a53a-b0594f4ffdb5@gmx.de>
Date: Sat, 12 Sep 2026 12:28:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/sparc: Enable variable page size for user-only
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260912102250.597582-1-richard.henderson@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260912102250.597582-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:XJKNOEQpyhCo5Xi+RP/7hWiLIoAjdRFY5U1shsf7+VwTd0iMlvK
 ZubMGOdx7WQQNtjWEvIqLlNzzWqIB2Eh63yg2CBBRlMN3to6rwKYU01Mfir3571+0P2z/Fm
 MbGmF/DAdppj+p+SRqU3yEW5shpaKdQhzKXvcHGVDmym31BiHteoUqh6TJYU+OU0Cb+3bQm
 /8UGWEGDWrNx/+0TH1qrg==
UI-OutboundReport: notjunk:1;M01:P0:HlVWReNrLQU=;92XNFhOl3IDAotJZoZ1SYRizD/z
 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
 02ZpUvfd0BGKQi3KnFue2b
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
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

On 9/12/26 12:22, Richard Henderson wrote:
> Sparc v8 has 4k pages, while Sparc v9 has 8k pages.  Because of this,
> userland does not assumed a fixed page size (at least true for glibc
> and musl).  Allowing the guest to follow the host page size avoids
> a variety of emulation problems.

True!

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>


