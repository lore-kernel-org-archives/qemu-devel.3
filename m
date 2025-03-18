Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE7FC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 10:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuUIv-0003sJ-Oi; Tue, 18 Mar 2025 06:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tuUIt-0003rL-OP
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 06:36:12 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tuUIp-0005eR-2V
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 06:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1742294164; x=1742898964; i=deller@gmx.de;
 bh=7D7qNXxZCh96d0fkV3uxzb/K6O9UBQFIJ0u1tNQVD50=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=kfGU6TaB2S+NOYHMLvR5WURX+wLiXc3cm2lcqxTFcd4o85M0wtw1YWPFYZNUtRmy
 1TqIGNo72SyEQnpr2cbLf4RK/oGZsRcIUdd/XiwcpPjpQjh+HgC07DDw3DZkV6DlH
 fDGoG66/zmB3mYj0oeUTIoAH295hDNYHKB2El9IK6Cbv6iTaZLJ0CyHH2ueXDSdVN
 edsVdvAAdnbY0cfwL9LIRpVDlNCGVlcY4S9SFGW1SBM2Mx8SMhLhV5G9x03Yivj8j
 oHRefCX0PhMiqnHjjBgtwyCfc3wRwZwbnrbwKXU0eK4sGzAdOYsXdK1hm+Zj8d7R7
 WaP0slxngmcDde/DtA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.173] ([109.250.63.121]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6ll8-1tpXor3WmM-00E3hJ; Tue, 18
 Mar 2025 11:36:03 +0100
Message-ID: <ff0cde0c-67d7-4fc3-8996-ad0e8645deed@gmx.de>
Date: Tue, 18 Mar 2025 11:36:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Generic way to detect qemu linux-user emulation
To: Andreas Schwab <schwab@suse.de>, qemu-devel@nongnu.org
References: <mvm1puuiqvu.fsf@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <mvm1puuiqvu.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k+p/468A+kClM0rNLq9CAXnNrHq9lMyl3x+upXPUQEeLqyUcxhv
 d2VMhEHfVBEm0ZZRwtrtDLck+kZTKSetjseyOblhl/TGt8nKo00pVKYrSpKNdb78ti0ViaP
 u/hq4JgmKfxmpL7eIp+WpDYRem0MGNSwKMacHYZcFZq5LOL0yCv1GgUy6Yp3F9VxN64siSQ
 I5SfLNFYZv3HL8utE520g==
UI-OutboundReport: notjunk:1;M01:P0:Opum/f79SZA=;cLw185jjl+wBFbOL+utZARRT0J7
 jekO6548hOlDJ6Wx8xSmsJCIJimuRcG7m6/BzGdPk7I2b9MdBRCo4enIM4oFwUmoJTDoyAevh
 BBzK1U8QOJ6cRUQ1a4qFn7h7W/3dVvZqYG9w0h9Drzque80mF7Jbl8pe/n0RNEDy3J+2Q1JSG
 fOnXc3+kkSvomLHGOZPBdAU7SK4pLOEgr1uKmH6B2S7fqYqm+DBAG08cjUcxHm1gMO6yT+DXI
 oKU5rmozOh3oMa5rdav4rxsIJKdz09iLZhMgFXwOxeBpOHmQ4CUI711s56fVoPM5Dl0ZXy13Q
 2ReKu5gI3GA4jR7lEFXVDvupBxjY4oWF2WcaOgpZWuQn59wyfPw/Zb4QTZq/uvJve1Ewt1fge
 3mNIfohYKfwZd6Vrt6Z5HrPe1/xq3pYWVWUP01LGJGRnMa8yfg55Ws9ArHl7wLluXMNHNZWOi
 yUq+gberYjCQt7txPYdF2w8aYm17q/wlWZ6SwPiGu/BzlmFTX8VQGgpdXxCdsdzbuuyXgO9qa
 eLwRmK6+4z0G5YDYSLC1NLXcYDBAZeksJlpSJ3RFnXWizp4DSpsknECW8/y2KDXJATrt1Obaj
 WB2ncJab3ZaVf+6lwOd1ziZ9rzQOZrSmx+4QZQ/W1AS2uJD4leakCOGBrC1l3uLMZ6t9SGkQ9
 UuIkh0HedyzyA0bELsO6lTVDZW7btCeA2krkUKxKNeGtrAd/s1j6IIIyo+ZjCn5hsDbxzQNm4
 P9F1B1UrA4L+1BwtPNl22Cq713uZ4uVjD9/EeT9u1tAsfg0ctXU/yOKanGN5If1tC0FnxFmlU
 Vcwl6h8jILbXJpc1V6l4gLKqwcMSWkK4V4fzo2Z+k0UsqVJ9ozGwK+Rd7MBe/89nP4yw6aYUG
 tkqw9/6wk0xsQ7W5AWadGYxAz3BHl3cgTF0VZDLPO1DoJPCkGIZCBfe+q6EygwLDRKGs8D/xa
 GzygfuJuxdZyt8GyXbCHmRCNCChCRTgIba50jpw4Kx7VzO6ABt3O6XQ9PBeayBGjEDD32oWOl
 /0IdAULDAtFRhRwk+qWDzN8kkwpsq80tndK84zAmHPUHEvUzJ25n8HLAzh+6sIAPjeGGd+Hyo
 QUNl4DMusgRmR81BuTPhkm8fgEWu276qgTkRx7AAS0Q2iqLPYYKUU6k5SKdoRHIXnQPiST/nj
 VNz8iLq3acLBz+2uMR2XDRuCE54ihLqYj3vW0gXsPFKaTh69OH3r/aUllAI6VzGaDw7S62O9F
 24oEqNnXcRbrBazLclaMS194jypOuLYykjnBq6HGljLvzWts4wQhI/rUeYfZiGFflB7jy8rbs
 MSuXTOMPC0pwHXR7wA+QmmFd2Ai/xDD2RwFZDoyx0zAUx0YMSOe1eXhkez8oyc1V/93E450Pj
 G+KYTuyxsCawste9NvaxH4GSX3yyOBAk3CznAY22kS6JjYgUUh3cf7aC6dufaXPfEOwwNxVMK
 zmuxtlRDFhnZQl/Mb+S5ZVR/ZEr8cm0xeOTtsRn+1RWvNDRnS
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On 3/18/25 11:18, Andreas Schwab wrote:
> Is there a generic way for a program to detect that is it being run
> inside the linux-user emulation?

Yes, having a reliable way to detect it would be good.

My current (unreliable) way to detect it is using uname.
The kernel string and arch name don't match:

(sid_hppa)root@paq:/# uname -a
Linux paq 6.1.0-31-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.128-1 (2025-02-=
07) parisc GNU/Linux

(sid_hppa)root@paq:/# uname -r
6.1.0-31-amd64

(sid_hppa)root@paq:/# uname -m
parisc

This is a qemu-linux-user parisc(hppa) emulation running on x86-64.

> The purpose for that would be to work around limitations of the
> emulation, like CLONE_VFORK being unsupported.

yes, and robust futexes aren't supported either.

>  For example, python >=3D
> 3.13 needs to avoid using posix_spawn in that case, because the
> emulation of CLONE_VFORK as a true fork makes it impossible for it to
> report errors back to the parent process.

