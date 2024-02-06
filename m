Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C858CC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 22:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXU0X-0004XC-Hr; Tue, 06 Feb 2024 17:33:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rXU0S-0004WZ-K0
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 17:33:32 -0500
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rXU0P-0006b1-3f
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 17:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1707258801; x=1707863601; i=deller@gmx.de;
 bh=9mEiWUE2/eUSAIpRjYxTQyo2y4FgdNq1ROS/9zQFRPA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=d23LuIw0vZIYulJrEqC8rtmlm2MaX2+YZCkEUVHwLQfk7D9h5J8fpVQiFcfyouyl
 q7sC434eAo0KMT1n0hTjYEY+UMqDbKR+N5NeYKYt7+3wxEDKxPpKw2cLkRMkp+fLx
 NF1fnUwwLEGOFRzVXNWSRA/vPaxkpwT0VD3UBFKz1OkGnyYe+krYQx3rItn3yAmBy
 x0yYUmeSolAeX1CHKVlcBjqdlus46aDaWZT2wl7sUpNpOqPHBtYNuwh2Es0OsXRtM
 SmKLGZH6AKM7jb7zgSpad/VkkUZjNswJm/FEClrJ3tSxbNmPnZlXczisU6HXR1XAa
 AFmocCIl9jq+dFNRbQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.150.94]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFbRs-1rnOIh0zok-00H86s; Tue, 06
 Feb 2024 23:33:21 +0100
Message-ID: <9ac454b1-a49a-4d57-ad3b-c0849bd789ea@gmx.de>
Date: Tue, 6 Feb 2024 23:33:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/tulip: add chip status register values
Content-Language: en-US
To: Sven Schnelle <svens@stackframe.org>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240205194717.2056026-1-svens@stackframe.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240205194717.2056026-1-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:djp1+z4L31aoFm5OwpzsynNpie2lW7nsBEtBMpA/GJob0EIuPnx
 Vg1s2PCBZYn3igrNPXFjh/XcEUMyrN9UEYv/7Q12SFjw9hZEnihuFOwzn/ure29Av2L5c0o
 Z6cWJYsxLEueux4uzzSP5MR79O+08vpLy986MhefnHXlQIQxneISYdz9jr6pyxn494Ma4DP
 dXBsjoPZuRksqa7tt7tPw==
UI-OutboundReport: notjunk:1;M01:P0:s4f9wvL8DD8=;h9za5nLClU1LAq7O3RHcb4qbUQL
 FiCVgPZ5Hn/Qys1LxfguE8B89jLsOYOwRVzNPbLkMTRA8ArSDZCF1f78Z6f57G/iCr7xl3eA0
 zOoT+04eqTPe+3f6bAT5XYLV4PzZHdS4P0rQYFI68ote7xdnjIekIO8Du3yXBdpu4J1W/m5wa
 eyBXUfI70Q+LDeOQyD095Hj/GojAQZnowctLcp0CTRGJGPW9IkoZe87PzCbZEEAF2soUP53/5
 nBjkVWSt9KYTaoWNr8olrcL1euh9aQ7SxCynWZAS2hvMwEBNTsGx3dK26dx6J7fefhRY57eby
 swHRf73fDaITsiOaK9SH+E9VMHpI3F7XtKq04dB+IhG/Q45T/VF2LCgXGcWYUK/X2itQXxJCG
 2VKLrwACSKLGGCdWrauvFdY3G0OaLIy/00VM9eBttCcbdyyeIKDBDKaaEVy9ILZ/YlcTFBTft
 8K9KVHntR4nGq/ytTfuBeCOWtDW2NPxGyiruqlNKq9L4JpYQViYvFiSRKrN2qQAbyLwoYGNWj
 uF4FLV/q3sZ/x3z+XIFyo28mMhdJ/7SS9s4yAWnS02rfXZ5GunfJgvM0qZWyZp1hRZZeKCpHB
 NEU3WJI16gjcBIHbJ5b5gc7BixVir6xxfyGa0uHrYPfYe1iqyqmJLMLtV2ycziIUNPU03nHVG
 m5HFfB+L0ol5uFu3sR6ZecGAksCXOngL6wyV399nNwMYPNCmcaiBKJP0F+0QzlBjbkoa5Su4Q
 hulvddy9Fk/JQ8mXofGGdi+VUaR2qt19pCC568XfC9mLKnlwVxXBpy3hFEDQtEMFqIrA2GXUD
 mq6owgfblMEc7VbAZy9vwyq4xuJ3vypcoj51CNYggeo98=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/5/24 20:47, Sven Schnelle wrote:
> Netbsd isn't able to detect a link on the emulated tulip card. That's
> because netbsd reads the Chip Status Register of the Phy (address
> 0x14). The default phy data in the qemu tulip driver is all zero,
> which means no link is established and autonegotation isn't complete.
>
> Therefore set the register to 0x3b40, which means:
>
> Link is up, Autonegotation complete, Full Duplex, 100MBit/s Link
> speed.
>
> Also clear the mask because this register is read only.
>
> Signed-off-by: Sven Schnelle <svens@stackframe.org>

Reviewed-by: Helge Deller <deller@gmx.de>
Tested-by: Helge Deller <deller@gmx.de>

Can be easily tested without installation:
Download: wget https://cdn.netbsd.org/pub/NetBSD/NetBSD-9.3/iso/NetBSD-9.3=
-hppa.iso
Run: ./qemu-system-hppa -cdrom NetBSD-9.3-hppa.iso -nographic
-> a) Installation on English
-> e) Utility Menu
-> c) configure network

Helge

> ---
>   hw/net/tulip.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/net/tulip.c b/hw/net/tulip.c
> index 6d4fb06dad..1f2ef20977 100644
> --- a/hw/net/tulip.c
> +++ b/hw/net/tulip.c
> @@ -421,7 +421,7 @@ static uint16_t tulip_mdi_default[] =3D {
>       /* MDI Registers 8 - 15 */
>       0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
>       /* MDI Registers 16 - 31 */
> -    0x0003, 0x0000, 0x0001, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
> +    0x0003, 0x0000, 0x0001, 0x0000, 0x3b40, 0x0000, 0x0000, 0x0000,
>       0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
>   };
>
> @@ -429,7 +429,7 @@ static uint16_t tulip_mdi_default[] =3D {
>   static const uint16_t tulip_mdi_mask[] =3D {
>       0x0000, 0xffff, 0xffff, 0xffff, 0xc01f, 0xffff, 0xffff, 0x0000,
>       0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
> -    0x0fff, 0x0000, 0xffff, 0xffff, 0xffff, 0xffff, 0xffff, 0xffff,
> +    0x0fff, 0x0000, 0xffff, 0xffff, 0x0000, 0xffff, 0xffff, 0xffff,
>       0xffff, 0xffff, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
>   };
>


