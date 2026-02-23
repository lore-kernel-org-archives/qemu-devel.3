Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E45EEC2AE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 23:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vufWB-0005hf-4S; Mon, 23 Feb 2026 18:39:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vufW9-0005hL-JV; Mon, 23 Feb 2026 18:39:09 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vufW7-00042S-N5; Mon, 23 Feb 2026 18:39:09 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2B13B5969FD;
 Tue, 24 Feb 2026 00:39:03 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id ZlgYa1VaYIMI; Tue, 24 Feb 2026 00:38:58 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A28465969FC; Tue, 24 Feb 2026 00:38:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9CE6D5969F6;
 Tue, 24 Feb 2026 00:38:58 +0100 (CET)
Date: Tue, 24 Feb 2026 00:38:58 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Thomas Huth <thuth@redhat.com>
cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 QEMU Trivial <qemu-trivial@nongnu.org>
Subject: Re: [PATCH] rtl8139: Remove ineffective parameter
In-Reply-To: <89379aba-1e0f-46d3-834a-2cb7d78c765c@redhat.com>
Message-ID: <864a3c3f-0fab-3909-d513-385bd0c8afdc@eik.bme.hu>
References: <20260127173849.588F25969F0@zero.eik.bme.hu>
 <597883bc-c6a3-cd7f-42dc-1ee7fb8e213c@eik.bme.hu>
 <89379aba-1e0f-46d3-834a-2cb7d78c765c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Mon, 23 Feb 2026, Thomas Huth wrote:
> On 12/02/2026 19.45, BALATON Zoltan wrote:
>> On Tue, 27 Jan 2026, BALATON Zoltan wrote:
>>> The do_interrupt parameter for rtl8139_do_receive was originally added
>>> in commit 6cadb320c7 to avoid generating interrupt when receiving in
>>> loopback mode. Later commit 5311fb805a changed this so that this
>>> parameter became ineffective and now this parameter is unused and
>>> always 1. If this turns out to be a problem maybe there's a better way
>>> to fix this so remove the do_interrupt parameter for now to simplify
>>> code.
>> 
>> Ping?
>
> ... it's not a very complicated patch, so maybe this could also go via 
> qemu-trivial? (now on CC:)
>
> Anyway,
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks but too late, Philippe already took it via his hw misc pull 
request.

Regards,
BALATON Zoltan

