Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C989AC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 03:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm1F3-0005wp-J3; Mon, 20 Jul 2026 23:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wm1F1-0005w6-LG
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 23:33:59 -0400
Received: from fhigh-b1-smtp.messagingengine.com ([202.12.124.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wm1Ez-0003J6-Jo
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 23:33:59 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 987E67A00C3;
 Mon, 20 Jul 2026 23:33:55 -0400 (EDT)
Received: from phl-imap-18 ([10.202.2.89])
 by phl-compute-02.internal (MEProxy); Mon, 20 Jul 2026 23:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1784604835;
 x=1784691235; bh=0rBA7C7JYOi+JyzwEqJw54kvjQDXEYmCjvNGEb8B2qY=; b=
 Fuqeovn6U9WkD3HL0NlqAiWRQ4Yf0wuQ8gva7N0DQysq6I3gOHhXYQK0OGMn71yo
 z4JoftQtx3Irb9rQaO9CMF+sTuvmVpfwgeQmU/xIs5Gfll2CJ9A4+k28UeqQ5EX2
 w8kTDbnwZOfbFYALNxLDJAa/NZy0tbEnMtUpsUiB67C+0mbWTt2JRgK+np51wMfD
 Pp/PT77WQk3XDjJh5FRHTdapiB/JGaSFJQ45bvfLc0EXLBGEjcU/bSLqOVet1QE3
 IGn3zyI2wfwzVHtKvM1cIxJ/glySLWlvb1is+lSN3mheCY7cYx4DLLEnmckc6Nzg
 zHmxCAXWucHaeGDEmjHpFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784604835; x=
 1784691235; bh=0rBA7C7JYOi+JyzwEqJw54kvjQDXEYmCjvNGEb8B2qY=; b=K
 UymdMwdw6O4TwNf2q/yI8nNrsGVx2zgwR0M8XGlVqkO1nP+KhkIChHzLK568W5m1
 hv+xPLWqxMFUfVK2F2yookAIulUc6rZEeV1jsy0oPGFC3hQ2gJMz+bzp9cPUCgWr
 OOH9ExkkavqGMBLfLdVyaTNJz3ZizdOjntJHWqgvDlD+3YeyVs9FioAAPz/mEawr
 AybeHyicArDb8HxiDfSbTmgARb/OBoaDsavM0lvHqIN4JR+f2dwniqjEpnIzFlrF
 F+ThAyhRqv88p8ur2Knm4OOgwrqM7XbbTt43b1rW3c3jTE0GgNaqWJupHIsopawY
 c0/XpjFjBGFVmslih6l0w==
X-ME-Sender: <xms:ouheatjLp8nxq5mv3Z650iICHlNeYZ9rdetGxE7YQDJvxozz97-ddg>
 <xme:ouheas2uRLSkpq2jXKKQY7X--jzeslP-opPybMz5XZzY0JGwAid_PP51i7XaJayyk
 pEN7_GkFZVVE_vJ_U_f0to8Bbkuo6_ymaNZdagxv-YNW3CRrHU3Yg>
X-ME-Proxy-Cause: dmFkZTFiaqLW/WwGATC5zb4UtrgYzCdPt1sVQ4+nct/zF0tTmGk/IYM8D0NToFfYkA0W41
 jKMPo3EE20jDBvT2cXNTx6PT/GJs3PmZtnLTELJUJEkri/RWnuDY5rjuI/77bHRv5uIXfL
 ln9bBrIaVuGwjk8A2FpB5FowBsacvH45tqgV/+NoiCCdZhBWORIv8zzAwzUdd5O82Jy0N7
 gEzIOsdmRFYYCOFvo3e2ktCbXbarh6EtA/BUvjNhwkQkxebw9WbWa+0YTeRCWZzSTSzhaS
 I4F82/zpg15oE7WLklaUkdE3PJ5JfuUcGr9Xi0v3IZ2JcrrvfSYMRXVrTDoW00RDVR/sli
 7gthAy/LLMgSN897erj5Won6iJCsteQWgTEVpARkI0fcIkoUZkjd6RK6cCxdm+0MXmkCNs
 DgdoTzJ0PH//TVezCyz7+WEbuxj4kABEzAFckSPzeJSzH9dKQSjVSSKw/0B1ZWSDkL2oq2
 YFEAOGBLvYKSQ7Ou/fnoOc6Gn0XDcDzU7opTnWFhfRD0r4LteB2DsEluK50LD8aC6Pjx+l
 hQpSYPlWEfihN4GMZY0f/XidTZXr+HYWpnEliMCeCq//K+W8oKhmvpvl1kwkZssC5mVspv
 SL58TEiAKM2b5FPm0UFn1d7fRJzOLkkqknFhIH458fsvFke1U1RRexqjOO5w
X-ME-Proxy: <xmx:ouheaui-qRRdY08pI6f6lVZ-33ol4MAM24gXJTc6Zc5ZfXxA4pgpTg>
 <xmx:ouhearC2Yly4D3CFsRNiO1cXi2qVuVw_xaDK8zXTV2YvFCDAsmEV3w>
 <xmx:ouheaoQ5LZPcFHTXWNK9D5yQz-GfZZi2yRcd_0ZCq-FmuJ51vE0IHg>
 <xmx:ouheaoX1UfwjXlP-4pZeJ7REtatBgQdEugVwAi2PMIWhC3yDxV8ZXg>
 <xmx:o-heavDObDxrZirlVVJIMuaeLhSfTkRtpvKAkyLfAS3dsPnEvtUbbwLz>
Feedback-ID: i03f14258:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 6FD3515C008E; Mon, 20 Jul 2026 23:33:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AlFAPmPmZ1Jo
Date: Mon, 20 Jul 2026 21:33:34 -0600
From: "Alex Williamson" <alex@shazbot.org>
To: "Pierrick Bouvier" <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, mjt@tls.msk.ru,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Message-Id: <a2273203-403c-4da1-b3dd-0933dd70faf0@app.fastmail.com>
In-Reply-To: <089649f0-b677-4c1a-a42b-eb9853f4fc7a@oss.qualcomm.com>
References: <20260720221715.27108-1-pierrick.bouvier@oss.qualcomm.com>
 <20260720171031.259f590e@shazbot.org>
 <089649f0-b677-4c1a-a42b-eb9853f4fc7a@oss.qualcomm.com>
Subject: Re: [PATCH 0/2] build: fix sparc64 host
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=202.12.124.152; envelope-from=alex@shazbot.org;
 helo=fhigh-b1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

On Mon, Jul 20, 2026, at 8:48 PM, Pierrick Bouvier wrote:
> On 7/20/2026 4:10 PM, Alex Williamson wrote:
>> On Mon, 20 Jul 2026 22:17:13 +0000
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>> 
>>> It was reported that build on sparc64 host is currently broken, due to inclusion
>>> of asm/kvm.h, which is not present on this platform:
>>> https://lore.kernel.org/qemu-devel/c3a7cd83-7666-40c5-9baa-ebe64edacab6@tls.msk.ru/
>> 
>> Isn't is sufficient just to remove the stale <linux/kvm.h> include?
>> 
>> I don't know of a case that fails, platforms that support vfio might
>> actually be a sub-set of those that support KVM, but being dependent on
>> a KVM supported host has no technical basis.  KVM and VFIO are
>> independent features where neither should have a hard dependency on the
>> other.  Thanks,
>>
>
> It's related to a recent change that was made to get rid of CONFIG_KVM
> in the file to deduplicate hw/vfio/listener.c between targets. So it's
> now unconditionally included, thus the regression.

I understand.  I'm suggesting the fix is simply:

diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index c19600e980a8..008f488a3e7d 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -20,7 +20,6 @@
 
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
-#include <linux/kvm.h>
 #include <linux/vfio.h>
 
 #include "exec/target_page.h"

This builds in both a native amd64 environment and a cross-compiled sparc64 environment.

> Limit inclusion from the build system is the right way to deal with
> this, thus CONFIG_VFIO, thus why we need to do something to control
> through Kconfig.

The right way to deal with the regression is to fix the regression, as done above.  If you further want to avoid building vfio on sparc64, that's a separate discussion and should have nothing whatsoever to do with whether the host supports KVM.  Thanks,

Alex

>>> Problem is that we assumed in Kconfig that VFIO is available for all linux
>>> hosts, which is wrong. It is limited to linux hosts having kvm support.
>>> Since we already have a meson.build section identifying those hosts, just define
>>> a new CONFIG_KVM_HOST in host configuration.
>>>
>>> Pierrick Bouvier (2):
>>>   meson.build: define CONFIG_KVM_HOST
>>>   hw/vfio: restrict to kvm hosts
>>>
>>>  Kconfig.host    | 3 +++
>>>  hw/vfio/Kconfig | 8 ++++----
>>>  meson.build     | 4 ++++
>>>  3 files changed, 11 insertions(+), 4 deletions(-)
>>>
>>

