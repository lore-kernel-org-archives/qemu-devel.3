Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90FF1CD3447
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 16:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLkG7-0008OT-BM; Sat, 09 May 2026 12:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wLkG5-0008NY-2w
 for qemu-devel@nongnu.org; Sat, 09 May 2026 12:10:29 -0400
Received: from 12.mo534.mail-out.ovh.net ([46.105.38.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wLkG1-00034e-LL
 for qemu-devel@nongnu.org; Sat, 09 May 2026 12:10:28 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4gCWDG2V5fz6MDY;
 Sat,  9 May 2026 16:10:22 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Sat,  9 May 2026 16:10:22 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.43.51])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4gCWDG1dPVz200j;
 Sat,  9 May 2026 16:10:22 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.3])
 (Authenticated sender: clg@kaod.org)
 by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 36EB812E34F9;
 Sat,  9 May 2026 16:10:20 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-108S002c68a5bf1-407c-4564-a768-4dd38e4b2a28,
 3D272E53171ADE400D76652CEA3707ABC032970B) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <64286966-b1bc-42df-ad16-371176161611@kaod.org>
Date: Sat, 9 May 2026 18:10:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] hw/usb/hcd-ehci: Rename migration compatibility
 fetch address fields
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "peterx@redhat.com" <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, "farosas@suse.de" <farosas@suse.de>,
 "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260506032643.2510575-1-jamin_lin@aspeedtech.com>
 <20260506032643.2510575-2-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260506032643.2510575-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 6660260903105375277
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFLT1Dm4ev9JPY/SOfsQGwECvAWhER0+8o7+JB7nBRj8gx5llPQEqT2WUqaSfEZYUOYc9bHiy4YoWai++/uSJ1qKC4zPcY+i8uFx5icHjaxIGWyvOHRtcjvljGXMfbr2bLxREVTRvVroXqRxSevt00Y9c7+qv3ep2F87ZK4476A4ng9TX7QA5IdFRv9KfD1IWSNdulfG6cT+g7/U85aW2sQPbFYyef4P6WitVammXysUC5Pnnb1R9Ey9cEhDwJe+ewVQZeXS/izfN6GJwpMN9C5MH4m+xtUmfAAJMwaoqo8uEMM/DVgHI0PpzBB340eCGMILigo5LuWd7WAtoi64ftls6YtVfI8iN4TukTIofXrMw6D+Pah2cA3aMZZt0i8kjrFJK1+39UjYJtsbCXND1OUvHNeW83Dx7NIZja3USvA9Oe4X9BOZ4MgV10yo7lfVaB5snnM9giJYMu8nmJLaDRo7XVBfDcP2qh2EembuBGD/n6Psa2mf/sLmvp1/56Gf+fNl5K93fhb2NrOn13wG1/ieaRQPO2/Eq6NlpKkWuJGl0DzFaLozcEKbKK1bQAMRqW72OkECT2HXn6Bkn4UjyZPYa9kcxoP3NJSQFogG4Fz984d0hckHHs1Py8X3fNnoLObBSaqkR80IY+u1acT+cVYKbU9wkWeuHNWPPwgnbZpaQ
DKIM-Signature: a=rsa-sha256; bh=bYHKcbYH1Sejv7FNDRvnOZSGv3OFcYGMzyxbVufrpG8=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1778343022; v=1;
 b=odKOLmjZC+TpoVJaz/+qAI+V+Y5ixUDL28nLRAab2y832SdYVJaitc94T92HKSRsV5J3Corr
 5tCtw8XGmlNiC5bNg5E4y+meTNhruyf58S/M74UBFNZGjAKLZn/nTyLdiCFsGd7/d+bRfOaemZ7
 oJCaEkS3MLfXVpUyK5KQ6Q4iram1HwKPi2Vaa1AJsKQXfntlayxUTsBa7JpG1w72IFDJpbFnnBv
 kB4tAtoZoJJsZTC+cnbsU6pQqPp5pssVTURokZlIDeaUoN/So8VKYxsRPRQcAkhXvmKZlIlrN0N
 9pLnt8LY1bD424gZH3D0mQu+xR5RJdJldOqlyRI/VDQYw==
Received-SPF: pass client-ip=46.105.38.145; envelope-from=clg@kaod.org;
 helo=12.mo534.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 5/6/26 05:26, Jamin Lin wrote:
> Rename the 32-bit fetch address migration helper fields to make
> their purpose clearer.
> 
> These fields are only used for migration compatibility with older
> machine types that transfer 32-bit fetch addresses in the migration
> stream. They are not runtime fetch address state.
> 
> Also add comments to clarify the relationship between the migration
> compatibility fields and the runtime 64-bit fetch address fields.
> 
> No functional change.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Thanks for the extra comments,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

C.


> ---
>   hw/usb/hcd-ehci.h | 17 ++++++++++++++---
>   hw/usb/hcd-ehci.c | 12 ++++++------
>   2 files changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
> index 3d57e1de5f..b5ac9c8670 100644
> --- a/hw/usb/hcd-ehci.h
> +++ b/hw/usb/hcd-ehci.h
> @@ -262,6 +262,10 @@ struct EHCIState {
>   
>       /* properties */
>       uint32_t maxframes;
> +    /*
> +     * Controls migration stream compatibility for old machine types.
> +     * Old machine types only transfer 32-bit fetch addresses.
> +     */
>       bool migrate_fetch_addr_64bit;
>       bool caps_64bit_addr;
>       uint32_t ctrldssegment_default;
> @@ -302,9 +306,16 @@ struct EHCIState {
>       EHCIQueueHead aqueues;
>       EHCIQueueHead pqueues;
>   
> -    /* which address to look at next */
> -    uint32_t a_fetch_addr_32;
> -    uint32_t p_fetch_addr_32;
> +    /*
> +     * which address to look at next
> +     *
> +     * Migration compatibility fields for old machine types that only
> +     * support 32-bit fetch addresses in the migration stream.
> +     *
> +     * New machine types migrate the full 64-bit runtime fetch address.
> +     */
> +    uint32_t migrate_a_fetch_addr;
> +    uint32_t migrate_p_fetch_addr;
>       uint64_t a_fetch_addr;
>       uint64_t p_fetch_addr;
>   
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index 62c3770ac5..56ac8f6ae5 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -2482,8 +2482,8 @@ static int usb_ehci_pre_save(void *opaque)
>       ehci->frindex = new_frindex;
>   
>       if (!ehci->migrate_fetch_addr_64bit) {
> -        ehci->a_fetch_addr_32 = ehci->a_fetch_addr;
> -        ehci->p_fetch_addr_32 = ehci->p_fetch_addr;
> +        ehci->migrate_a_fetch_addr = ehci->a_fetch_addr;
> +        ehci->migrate_p_fetch_addr = ehci->p_fetch_addr;
>       }
>   
>       return 0;
> @@ -2507,8 +2507,8 @@ static int usb_ehci_post_load(void *opaque, int version_id)
>       }
>   
>       if (!s->migrate_fetch_addr_64bit) {
> -        s->a_fetch_addr = s->a_fetch_addr_32;
> -        s->p_fetch_addr = s->p_fetch_addr_32;
> +        s->a_fetch_addr = s->migrate_a_fetch_addr;
> +        s->p_fetch_addr = s->migrate_p_fetch_addr;
>       }
>   
>       return 0;
> @@ -2571,9 +2571,9 @@ const VMStateDescription vmstate_ehci = {
>           /* schedule state */
>           VMSTATE_UINT32(astate, EHCIState),
>           VMSTATE_UINT32(pstate, EHCIState),
> -        VMSTATE_UINT32_TEST(a_fetch_addr_32, EHCIState,
> +        VMSTATE_UINT32_TEST(migrate_a_fetch_addr, EHCIState,
>                               ehci_fetch_addr_32_needed),
> -        VMSTATE_UINT32_TEST(p_fetch_addr_32, EHCIState,
> +        VMSTATE_UINT32_TEST(migrate_p_fetch_addr, EHCIState,
>                               ehci_fetch_addr_32_needed),
>           VMSTATE_UINT64_TEST(a_fetch_addr, EHCIState,
>                               ehci_fetch_addr_64_needed),


