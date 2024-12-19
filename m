Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F808E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 21:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOON1-0006df-HB; Thu, 19 Dec 2024 16:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tOOMo-0006dX-Jg
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 16:47:35 -0500
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tOOMl-0003un-Fv
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 16:47:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1734644831; x=1735249631; i=deller@gmx.de;
 bh=6o9/WGskCt3hm4mxk2VupzQmbeZtrivKHZ+WmsHCQuM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=abC8y7hjvN5y6ieKLqwkXUxFvctV6PeJDahU8DCl2cUHX3wZ22fz4OoPUmZb24Uz
 0CTnv+YwIhzbcJxajztQGopdjQJOSLxbGbnk2XU7SPBoVyMVw2dwFKKr1iEnS/bsP
 cwhTQO0Tf7knSHbv6A47oWxFxJhoksh2onnpDD9V8GOOTGeHxRXXqqzLLYz2jk73v
 cBhseIQZbooIRxaUlHkJqNhnZMgKSRw7xfe11XW8vlwrh1lVUp9I3zKEDKj05+dKd
 VD75rl/RghDA27axksYvG3mwlgUAWjb7w/WqPlzMjWg7yhH/Z0MkzYoXIpN9WTHhG
 AtZLKMyPJqMrKjG89g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.172] ([109.250.63.155]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmDEm-1toghj2fw0-00mNvd; Thu, 19
 Dec 2024 22:47:11 +0100
Message-ID: <299f897a-e5a7-4055-86f6-2106a0aaec0d@gmx.de>
Date: Thu, 19 Dec 2024 22:47:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] Linux user fix gupnp patches
To: Stefan Hajnoczi <stefanha@redhat.com>, deller@kernel.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>
References: <20241218195247.5459-1-deller@kernel.org>
 <20241219200138.GA722208@fedora>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20241219200138.GA722208@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Gz5BiOvijDoeyx4X132Ld4AICVRh0ySabFoXUDGukikI5jTkUaQ
 nJt0PmMMMRjuWuqLcsqbnR7ZOxsLYndQmH3mjcYL3+lbyp+KaeVD0w9owszQzKvKJ/qR+SD
 mAJ+GmpTHrxizAELc0LvJElg0wZ1xjs2L4VNBwkrabaYF1jEfkv98nO4/P4pumEwarGHi+J
 H2WofXNxtqXiI8Rn51ZGA==
UI-OutboundReport: notjunk:1;M01:P0:uUUUmw7G1zs=;bKxk72xcXdfny8haORNQV9qc5Ig
 unQl0QwKKChJcdnT9naSPmdqzTaYfUaOwvkvgfs5u1qUu1G3cxzWAGQYA8j8vdFpAJ9SK4F1j
 yV0+r8ihxzMWjKEki52VeivxtDnWOeRloSU8CbfOhgoBsqgb3NASWWOhT46uAJaw2n7zUozQ8
 Qfg/nxw4ElCfnwSSihTOM9hqt5IvHZxstTvQUVfkeCF1RwoEVJVvt3kGtj5Ixp00YAoo/klpJ
 N4jxUHJbzYgnvPUltQsIosCBVT8zVp7bU+18V/qVMQKiRZJNo2qBq9Y5hDl8tsQoJmIUgm7ws
 ihj31mSwRwEPTlP1+zAiVoc7HCI5MPgz0U5WADCeAqWr7qeQXu9//6PlO+XNaTxaz6VcM3bnx
 b6LD8BNhH0TvBcL+ms6c3GAVl7vRcMGTHcAgynsbN1JsOVq7GfbxdHJVBl9U5S6+Kw2LrQ8e6
 jHLFjVgH0ponquXkzJ3G1k/Jg2K/yo3dHh5Abs3tKMOAhz5hLk4KNDRtGBx/9el9trFGrw3Ag
 PrOgmRu8QduqsCO0vsAoqNXGmORIavKgVTaYpNtjSyiADMSSNl5g2Hs3Ert7zQac9aFOoLnGu
 8gwxTbKlgBZt85Mby7B+gX1SemElycUDhWtyIfIhDy+4DlqG7CvQd/6zugyhljubpS4VW84pj
 51G4shqvUqzbTrhIF+hAsehLs0JCKdDbNfYnOYWhteUVEgc63z86G1rtVe0KWystzIt0+IKd+
 1Lr4erUGDxk3YlupzgFcvA2Y3VL/uZZCRCjEe6oXoaSXHBThBt7ES/6XAyRzjGNmWE5NZqeiu
 WnEOWEL3bJfgy9l5oAy+CJdszH+/hf4dCZDqVyc2K/JzFg4FNDPatgngRmJsSciWq8bjSHmGl
 q5DD+NpuYY9EIwa6QnUZta7gjF6v1AVk77afbf/wyIU8SKTtbWNfu9JIYcywxCV+EINpeprzY
 U4CwAopIfQZbPyTUznU+PEyAQIkK6TbinudDmuSv4/Iwq0DEa8G6DgsMugqucSBVmkgn3B8f1
 REAZfKp0dutVEEHl64oI3Ncdb5lylxhUCBImSfobcuMzBTvMxb5xev2MS8fa530REOsAq4FXd
 BfK1LIcXRN1tAv23lxB8OKLM3Lt+NL
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Stefan,

On 12/19/24 21:01, Stefan Hajnoczi wrote:
> Will this go through Laurent or did you send a pull request to have it
> merged into qemu.git/master directly?

Actually, I'm fine with either one.
I do understand that reviewing this patchset is somewhat
challenging as this area is quite complex and rarely touched.
That's probably why it didn't received much review yet, so
I decided to send the direct pull request to not bother others too much :-)

But if Laurent want to take it through his tree I'm fine with it,
same if someone merges it directly into git head.

Thanks!
Helge

