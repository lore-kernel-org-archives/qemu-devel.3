Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84E4E7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOCE4-0000J3-RB; Thu, 19 Dec 2024 03:49:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+19b9ca6417e46fbfa303+7788+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1tOCDz-0000Gd-2J
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:49:39 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+19b9ca6417e46fbfa303+7788+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1tOCDw-0008UX-Ox
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:49:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
 :MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=Zx9ZVH8lYakQYgupEXZARF58RM1vcjoPete++dWs5IU=; b=MEvKwlDXNBBe1Lyap8Cx4C0Vqe
 w0DhfI14tx97c/LPt5x6zn/AsRAU9OcsbEH/2Rx1JutT1BRLf97xWoFZ2GbCysqeUxwhr1/Fb+Xjk
 Ib5qHjrMC8Qku4dvKGlqC3222PB+1Zj39l7ibgbZiMvZvDUtH+fHQpnP6+TFbcJYWvn+wdmF5X0ZM
 NT9ntBKJZGZDMVXYUIndlwDS30pafFoxBoZ+S+QQAdZ+/CEKCQF4+BfD6noQqF6ni5pv9s6/I0Il0
 +AKmRxTEP5tGnN8BDpQyBTE64dX5Lcmovc4wlUYg1AXW+vOWvHaSqSkwdOPEUsWT/g8t6wBSAtK7v
 hbkSxILg==;
Received: from [89.27.170.32] (helo=[127.0.0.1])
 by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tOCDp-00000005Pv3-1YnX; Thu, 19 Dec 2024 08:49:29 +0000
Date: Thu, 19 Dec 2024 09:49:29 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
CC: Paul Durrant <paul@xen.org>
Subject: Re: [PATCH] tests/functional: Convert the kvm_xen_guest avocado test
User-Agent: K-9 Mail for Android
In-Reply-To: <7e6fd4ed-ee93-48eb-ab12-fd9aa30e6898@redhat.com>
References: <20241218113255.232356-1-thuth@redhat.com>
 <9B5DDDDB-769B-4654-BEF1-D3F853EA05E5@infradead.org>
 <1d4faf8e-b2cd-42b8-a6a7-9034b9512b86@redhat.com>
 <8cef1bf9ffde6779ad322534c4469e6687b9c9d7.camel@infradead.org>
 <7e6fd4ed-ee93-48eb-ab12-fd9aa30e6898@redhat.com>
Message-ID: <72B07F94-036B-4789-B5DF-103CA913278C@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+19b9ca6417e46fbfa303+7788+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 19 December 2024 09:35:13 CET, Thomas Huth <thuth@redhat=2Ecom> wrote:
>On 18/12/2024 23=2E14, David Woodhouse wrote:
>> On Wed, 2024-12-18 at 16:54 +0100, Thomas Huth wrote:
>>> On 18/12/2024 12=2E48, David Woodhouse wrote:
>>>> On 18 December 2024 12:32:49 CET, Thomas Huth <thuth@redhat=2Ecom> wr=
ote:
>>>>> Use the serial console to execute the commands in the guest instead
>>>>> of using ssh since we don't have ssh support in the functional
>>>>> framework yet=2E
>>>>>=20
>>>>> Signed-off-by: Thomas Huth <thuth@redhat=2Ecom>
>>>>=20
>>>> Hm, but serial is lossy and experience shows that it leads to flaky t=
ests if the guest (or host) misses bytes=2E While SSH would just go slower=
=2E
>>>=20
>>> I now noticed some issue with the serial console in this test, too=2E
>>> Looks like the "Starting dropbear sshd: OK" is not print in an atomic =
way by
>>> the guest, sometimes there are other kernel messages between the ":" a=
nd the
>>> "OK"=2E It works reliable when removing the "OK" from the string=2E
>>=20
>> Nah, that still isn't atomic; you just got lucky because the race
>> window is smaller=2E It's not like serial ports are at a premium; can't
>> you have a separate port for kernel vs=2E userspace messages?
>
>Maybe easiest solution: Simply add "quiet" to the kernel command line, th=
en it does not write the kernel messages to the serial console anymore=2E

Want to resend the bug report about that test failing again? But without t=
he kernel messages this time=2E=2E=2E :)


