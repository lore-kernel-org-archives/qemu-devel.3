Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDD3FF886F
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2026 20:20:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJdHJ-0001S9-FG; Sun, 03 May 2026 16:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wJdHH-0001PQ-9n
 for qemu-devel@nongnu.org; Sun, 03 May 2026 16:18:59 -0400
Received: from 12.mo533.mail-out.ovh.net ([178.33.248.79])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wJdHD-000320-Lh
 for qemu-devel@nongnu.org; Sun, 03 May 2026 16:18:59 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4g7x1b17g4z5vdC;
 Sun,  3 May 2026 20:18:42 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Sun,  3 May 2026 20:18:42 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.168.27])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4g7x1Z2vm3z1xp6; Sun,  3 May 2026 20:18:42 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.4])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 1EE301B434EB;
 Sun,  3 May 2026 20:18:38 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R0068ca3893e-9cb4-472e-9a4f-378f2dbc8e7f,
 15A2E2FDD32F27586AD59E6AF3E683E8C1C94C55) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <105f9a81-441b-4221-8c04-238780dacd26@kaod.org>
Date: Sun, 3 May 2026 22:18:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/18] hw/usb/hcd-ehci: Add property to advertise
 64-bit addressing capability
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:sPAPR pseries" <qemu-ppc@nongnu.org>,
 "open list:S390 Virtio-ccw" <qemu-s390x@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, "farosas@suse.de" <farosas@suse.de>,
 "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
 <20260424080508.53992-11-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260424080508.53992-11-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 12511562717616188623
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTG4FK8cgzRzvl5GbOb1Gr1v3nH3+vZGVZ9i6Eofxk39mJeOmIF7WxULVXpBgLuq/Yc7ea+Ybd/E5Z5GfOJeEuASuX7EhgZ6FfT+fcXrhMB0pkbgA4+4RH0CUb6CbK1j1TLth/OXJ5y2E/tZKq1MQ6dAcUrhZI1mcwpx3GBe42u3rm1sOUoMWWbsY/DGB+bKYfDBYxQH98lkt1D/5+i2ntdDHwdrqbwEs0Fow/1vhH2lIG+VtLNjycx7V/ZLR7MWzSdMKUFppjVc0JrTYQxA+Ria6++Grpsd5qNs+UTxiAmp4fTjef+ZSmiqAsDGbMmcoxZ+Qyuv991cIInwMx7p4gP6nqaOLmmW3N86g06IIa6eowNjt1xq3mAXmI1NM/njffGj4BMFzERS9V7ZhAtc3zWFMsNa2/QoYIePW/XIMC2paH6M9tXRnaPdB05p02gjkqwPzwExMR/pOU7QncDpDQuREsV0eAyuDkdyeMYECf/JPFK5E+2hHelD8MvH35nKgr+NMOYChGJzGDEs8N/2Iqf5sHu3yStrs9IqR1XSlsayQQW46xgJLvAoUvwHkyxpViC4BP9eJ6ok3nImyQw4L2/7QTO4/2u9YfCpcR8jgkn3nkmme6hCIFMAvvzoEAInUHacCwzo8KjexQ/IKQvnv8kgxT13EsBgOgMd2vu+onn36A
DKIM-Signature: a=rsa-sha256; bh=1pxqGWSczXrd3IoJRGd94WjEpmW2C1R37PLWoeZz9gU=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1777839524; v=1;
 b=NAVClTv0Q+GtR88/zJ++S1164NrGPjJ8UqfVkosKoxcEyTJYFtOGcMqv31OjliKjjXlysac7
 diOi3Px1BwLZ0QMsiqXLywGRxPdyGyPTIBNMkFF5Dn7iOEkNblIuyok1ve7xBV3tz0jSxliXxGh
 1kFfL/k41gpYtapZx1CyjlegqFfWTygLQYEByrGc2he3Cb/AC9yVojV8HEyBHUOOot9efn1pdXP
 etMfz16iOKSuHnOSzoE9CMOADI4Sp1nPJTtKofNHls67yhoGmhVLI/4fm3NT68FuJBaeIaZlR0S
 lZ3vDxXiCx4i0VWYwmK6hzrOw2CVwQhd0awNXvb3fUrBQ==
Received-SPF: pass client-ip=178.33.248.79; envelope-from=clg@kaod.org;
 helo=12.mo533.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/24/26 10:05, Jamin Lin wrote:
> Introduce a new boolean property, "caps-64bit-addr", to control
> HCCPARAMS[0] (64-bit Addressing Capability).
> 
> When enabled, the EHCI controller advertises support for 64-bit
> address memory pointers as defined in the EHCI specification
> (Table 2-7, HCCPARAMS). This allows software to use the 64-bit
> data structure formats described in Appendix B.
> 
> When disabled (default), the controller reports 32-bit addressing
> capability and uses the standard 32-bit data structures.
> 
> The EHCI CTRLDSSEGMENT register provides the upper 32 bits [63:32] used to
> form 64-bit addresses for EHCI control data structures. Per EHCI 1.0
> spec section 2.3.5, when the HCCPARAMS 64-bit Addressing Capability bit
> is zero, CTRLDSSEGMENT is not used: software cannot write it and reads
> must return zero.
> 
> Add a capability check in the operational register write handler and
> reject guest writes to CTRLDSSEGMENT when 64-bit addressing is
> not enabled.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/usb/hcd-ehci.h |  5 ++++-
>   hw/usb/hcd-ehci.c | 14 +++++++++++++-
>   2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
> index 3acbddfc5c..f1f2fde578 100644
> --- a/hw/usb/hcd-ehci.h
> +++ b/hw/usb/hcd-ehci.h
> @@ -257,6 +257,7 @@ struct EHCIState {
>       /* properties */
>       uint32_t maxframes;
>       bool migrate_fetch_addr_64bit;
> +    bool caps_64bit_addr;
>   
>       /*
>        *  EHCI spec version 1.0 Section 2.3
> @@ -313,7 +314,9 @@ struct EHCIState {
>   #define DEFINE_EHCI_COMMON_PROPERTIES(_state) \
>       DEFINE_PROP_UINT32("maxframes", _state, ehci.maxframes, 128), \
>       DEFINE_PROP_BOOL("x-migrate-fetch-addr-64bit", _state, \
> -                     ehci.migrate_fetch_addr_64bit, true)
> +                     ehci.migrate_fetch_addr_64bit, true), \
> +    DEFINE_PROP_BOOL("caps-64bit-addr", _state, \
> +                     ehci.caps_64bit_addr, false)
>   
>   extern const VMStateDescription vmstate_ehci;
>   
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index 0c8bdb48ad..b23ff92e12 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -1109,6 +1109,15 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,
>           }
>           break;
>   
> +    case CTRLDSSEGMENT:
> +        if (!s->caps_64bit_addr) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "ehci: write to CTRLDSSEGMENT while "
> +                          "      64-bit addressing capability is disabled\n");

Please remove the extra spaces at the beginning of line.

Thanks,

C.



> +            return;
> +        }
> +        break;
> +
>       case ASYNCLISTADDR:
>           if (ehci_async_enabled(s)) {
>               qemu_log_mask(LOG_GUEST_ERROR,
> @@ -2554,6 +2563,9 @@ void usb_ehci_realize(EHCIState *s, DeviceState *dev, Error **errp)
>                      s->maxframes);
>           return;
>       }
> +    if (s->caps_64bit_addr) {
> +        s->caps[0x08] |= BIT(0);
> +    }
>   
>       memory_region_add_subregion(&s->mem, s->capsbase, &s->mem_caps);
>       memory_region_add_subregion(&s->mem, s->opregbase, &s->mem_opreg);
> @@ -2613,7 +2625,7 @@ void usb_ehci_init(EHCIState *s, DeviceState *dev)
>       s->caps[0x05] = 0x00;        /* No companion ports at present */
>       s->caps[0x06] = 0x00;
>       s->caps[0x07] = 0x00;
> -    s->caps[0x08] = 0x80;        /* We can cache whole frame, no 64-bit */
> +    s->caps[0x08] = 0x80;        /* We can cache whole frame */
>       s->caps[0x0a] = 0x00;
>       s->caps[0x0b] = 0x00;
>   


