Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3A8606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 21:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=ilande.co.uk header.i=@ilande.co.uk header.a=rsa-sha256 header.s=20220518 header.b=ZebkrLV+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMBON-0007Au-1w; Wed, 28 Oct 2026 17:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xMBOK-0007Ah-IT
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 17:41:04 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xMBOI-0001Xw-MD
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 17:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=qJibm9C1lT7q454A0y69Uw4GD1tljW5Wa2G+N46XAdw=; b=ZebkrLV+RSwzc+/Zrpj4wPt++v
 WXT0qH6+Ejsj/6Ds9JcwS8ysQaHt0jH5Yp4E1eu2Xiu1adtD2FsYBrqi+UR44QmawGL75r05W11yh
 lItuuC/MJKliKwKgsBpp+vTcRU3nAiS8NBzWGPy9kEy/HifdvkwRQVMfZpQFqyC0PENVhQrrVVWL/
 PU68wvSVyKa4PaoQTtQ6DmQqDiUO324gwjmoNjahmD2cFERgB0pbOWqCxpvPnZDMtqY0KcU1h4D41
 XBHHxhKEEAJ+ClsdMut9rLzWBSbbZvRGRUeeXRk+uhd/VWJli7n+2VKlYISHEksKyCAIFV+eEt3fm
 83XqXr/RM6IY5eZZZb9DxQNPa28ZGFuXKQ9s3gb78DTc6JPy43ES8IkAIvf+BRQXJXBJf39QEXFlr
 aQZAjM6SxbmBBH5NvtBTCAvqgRbdHulcrhs44/cUlT5ZoIf8RVa0FVXV1qUTu4zpHYNv8q3NtHk6p
 emPbFOv0FHkHkB3MSJrDdJItLleM8xiejXHSV926q3GJaDvUr7qMS3V+YwOqYLCGzganVYH28eG9X
 PpdWzyNW9GYt4f0Gb0hdTnH8dttGk6Kvua0K/pza4nADInNAlRmbdNwLpAPO/9F0X2BD3qz+vBtiA
 p1gdzxTZrfxKl8Y3HfWFjbOq+wvV3Qn/qbc0sILOE=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xMBNX-004QMg-BZ; Wed, 28 Oct 2026 21:40:15 +0000
Message-ID: <3efb52aa-d2c4-490a-9da4-91f9e0e7c7eb@ilande.co.uk>
Date: Wed, 28 Oct 2026 21:40:58 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Stian Halseth <stian@itx.no>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>
References: <20261028113816.1651212-1-stian@itx.no>
 <4173affc2593f5f5b432f6e2146ad33a25d924a0.camel@itx.no>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <4173affc2593f5f5b432f6e2146ad33a25d924a0.camel@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 0/2] target/sparc: Block-init stores for the crypto
 feature
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 28/10/2026 18:22, Stian Halseth wrote:

> Hi Mark,
> 
> Would it be possible to get these two patches into your next sparc pull
> request, before the soft freeze on Monday?
> 
> They complete the crypto series for linux-user, so it would be good to have
> them in 11.2 together with patches 1-6.
> 
> Thanks!
> 
> /Stian
Hi Stian,

I'll do my best to look at these patches over the weekend.


ATB,

Mark.


