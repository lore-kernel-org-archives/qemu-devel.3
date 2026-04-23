Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11131FDEE45
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG02f-0007yI-Va; Thu, 23 Apr 2026 15:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wG02T-0007xt-RD; Thu, 23 Apr 2026 15:48:41 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wG02R-0004kw-WD; Thu, 23 Apr 2026 15:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1776973717; x=1777578517; i=deller@gmx.de;
 bh=Amd4EiDWMiSfho0uiXX2cCbOf7bB1BuvW/lLLf4chXI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=syeLbKBwZsQC1e8Ngb8xJMeQtzRj/cweCCNxjVc5Q31BYBAQfu8BAc70F16a46wY
 kqaaA5EPsc3YNpNOc+9NLZRa9v/UXsqhBy4rlxhJhvVazopi1t7NTVzFOc0xvoCW7
 66gnyCOBG1uNH1DBli1pB3nxb3GDChZVafV0P9N0NJaiDtH5mUBxBy3GgOFCzWLRf
 M4BAxWUF9mQO0ck1t/9lCNBLaBVjUs84s0G0Lwje7wwyrzcRdnkzTo2BrQ6vxmXxJ
 K8WPnms+0v3Ebmu2HvSyVMFw+VqxoixKiopHIy1c2QaXCeeAGubMxv3IL9vgQFWYF
 tHFJ3aHqbHV6Wjiy+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKbgE-1vxEjZ2F4e-00SoqK; Thu, 23
 Apr 2026 21:48:37 +0200
Message-ID: <e1c4ece5-4404-4447-8f78-88cdc3e483a2@gmx.de>
Date: Thu, 23 Apr 2026 21:48:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0? 0/3] linux-user/arm: Deprecate nwfpe
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20260413230251.22537-1-richard.henderson@linaro.org>
 <9136e278-f553-4ebb-aed0-ce2e0a2e2a4f@gmx.de>
 <CAFEAcA-7PbOLT=SeMeMeUVbBfv3EEbzBuDWiLyOAgCK6jRWUkw@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAFEAcA-7PbOLT=SeMeMeUVbBfv3EEbzBuDWiLyOAgCK6jRWUkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HVaUBu7QKjBx+sin2+Xp6be4NOCbMH6YtgHRwtkiu//+xOs9IgJ
 KdhWgBSypgV8ubQQJ4STJqqUbXap9QsLSJ1cOmrOICXJfmaYZaDWFeREsWJHL6PjWL2wgKh
 iE3A5bKyL7UEpRmSOdBK+wcovZNZFcxIL99KtGZ+XQzkI339XnKdDSMIBH6Cw458hnGxn+w
 fr0XnB2Aykv4gg2oboFag==
UI-OutboundReport: notjunk:1;M01:P0:j02BUrVQX/A=;B8K0zCRerpvu7/AnFCIJvT3uJm6
 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
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

On 4/23/26 21:02, Peter Maydell wrote:
> On Thu, 23 Apr 2026 at 19:54, Helge Deller <deller@gmx.de> wrote:
>>
>> On 4/14/26 01:02, Richard Henderson wrote:
>>> Deprecate nwfpe emulation.
>>> But while it still exists, fix thread safety.
>>>
>>> r~
>>>
>>> Richard Henderson (3):
>>>     docs: Deprecate linux-user/arm/nwfpe
>>>     linux-user/arm/nwfpe: Replace user_registers with current_cpu
>>>     linux-user/arm/nwfpe: Use thread-local storage for qemufpa
>>>
>>>    linux-user/arm/nwfpe/fpa11.h | 25 ++++++++-----------------
>>>    linux-user/arm/cpu_loop.c    |  2 +-
>>>    linux-user/arm/nwfpe/fpa11.c | 12 ++----------
>>>    docs/about/deprecated.rst    | 12 ++++++++++++
>>>    4 files changed, 23 insertions(+), 28 deletions(-)
>>
>> I've applied this series to the linux-user for-next git tree:
>> https://gitlab.com/hdeller/qemu/-/commits/linux-user-next?ref_type=3Dhe=
ads
>=20
> Please don't take patch 1 -- we put a different version of
> that into git already before 11.0 was released.
Sure. I've dropped the "docs: Deprecate linux-user/arm/nwfpe" patch.

Thanks!
Helge

