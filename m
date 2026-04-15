Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB794F4199E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 12:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCzPG-0002cO-Rg; Wed, 15 Apr 2026 08:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wCzOv-0002aj-Vs
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 08:31:26 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wCzOt-0000Dp-Rn
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 08:31:25 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8C27B596A47;
 Wed, 15 Apr 2026 14:31:15 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id iKfVNWbqK2hA; Wed, 15 Apr 2026 14:31:13 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 83254596A23; Wed, 15 Apr 2026 14:31:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 816E15969EC;
 Wed, 15 Apr 2026 14:31:13 +0200 (CEST)
Date: Wed, 15 Apr 2026 14:31:13 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Feifan Qian <bea1e@proton.me>
cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Chad Jablonski <chad@jablonski.xyz>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/2] hw/display/ati: guard HOST_DATA accumulator index
 before write
In-Reply-To: <Czyl6yVfL6sHl_o1kRk8N_LpwXMMRVhO9vgz1qCVJFagn9D4nHSKuiux39iOLty0Q3acxQq_FeovPhTQvSKus2htwjI9lTajLZmqovr0Wxs=@proton.me>
Message-ID: <fe1f6e2b-bf9a-1e9e-8ab3-aa9e3f3da973@eik.bme.hu>
References: <Czyl6yVfL6sHl_o1kRk8N_LpwXMMRVhO9vgz1qCVJFagn9D4nHSKuiux39iOLty0Q3acxQq_FeovPhTQvSKus2htwjI9lTajLZmqovr0Wxs=@proton.me>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-553946917-1776256273=:97186"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-553946917-1776256273=:97186
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 15 Apr 2026, Feifan Qian wrote:
> The HOST_DATA write handler stores guest-supplied dwords into a
> 4-element accumulator array (host_data.acc[0..3]) and calls
> ati_host_data_flush() once four entries are collected. When
> ati_host_data_flush() returns early without resetting next (e.g.
> for unsupported 24-bpp or direction modes), next remains >= 4.
> Because the write acc[next++] occurs before the next >= 4 check,
> the subsequent HOST_DATA dword is stored at acc[4] — one element
> past the end of ATIHostDataState, the last field of the
> heap-allocated ATIVGAState object. The payload is guest-controlled
> and the overflow is repeatable.
>
> Confirmed with AddressSanitizer: heap-buffer-overflow WRITE of
> 4 bytes at ati.c:1032 on QEMU 11.0.0-rc3 via QTest.
>
> Add an explicit bounds check on next before indexing acc[]; log a
> guest error and break without writing if next is out of range.
>
> Signed-off-by: Feifan Qian <bea1e@proton.me>
> ---
> hw/display/ati.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 88a5bbbf07..3039606202 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -1029,6 +1029,11 @@ static void ati_mm_write(void *opaque, hwaddr addr,
> if (!s->host_data.active) {
> break;
> }
> + if (s->host_data.next >= ARRAY_SIZE(s->host_data.acc)) {
> + qemu_log_mask(LOG_GUEST_ERROR,
> + "HOST_DATA: accumulator overflow, ignoring\n");
> + break;
> + }
> s->host_data.acc[s->host_data.next++] = data;
> if (addr == HOST_DATA_LAST) {
> ati_host_data_finish(s);
> --2.43.0

Patch seems to have been mangled. But this does not fix the issue of not 
resetting the next counter in some cases and this just discards data. 
Maybe resetting the s->host_data.next should be done here instead of in 
ati_host_data_flush() so it's not missed even if flush failed? Or the 
error patch might need to be changed in ati_host_data_flush() instead?

Regards,
BALATON Zoltan
--3866299591-553946917-1776256273=:97186--

