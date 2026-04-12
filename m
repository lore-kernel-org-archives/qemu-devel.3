Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFE3E937EE
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 16:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBy3b-0005ck-DB; Sun, 12 Apr 2026 12:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wBy3Z-0005c6-DZ
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:53:09 -0400
Received: from smtpout1.mo533.mail-out.ovh.net ([51.210.94.138])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wBy3X-00075g-5j
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:53:09 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4ftxRz4mrXz5wvM;
 Sun, 12 Apr 2026 16:53:03 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Sun, 12 Apr 2026 16:53:03 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.37.242])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4ftxRz3lzrz1xp5; Sun, 12 Apr 2026 16:53:03 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.4])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 0A1E52403A3F; Sun, 12 Apr 2026 16:53:01 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S0035231a40e-642e-43f5-bae3-854c91ce17b7,
 24D929EF98A9C54707A36CFD348010E9E2578269) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <b26ce316-dcd0-44f3-a5be-86c0767da640@kaod.org>
Date: Sun, 12 Apr 2026 18:53:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/13] hw/usb/hcd-ehci: Add property to advertise
 64-bit addressing capability
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
 <20260311072614.1095587-6-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSBDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQGthb2Qub3JnPsLBeAQTAQIAIgUCW7yjdQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AACgkQUaNDx8/77KGRSxAAuMJJMhJdj7acTcFtwof7CDSfoVX0owE2FJdd
 M43hNeTwPWlV5oLCj1BOQo0MVilIpSd9Qu5wqRD8KnN2Bv/rllKPqK2+i8CXymi9hsuzF56m
 76wiPwbsX54jhv/VYY9Al7NBknh6iLYJiC/pgacRCHtSj/wofemSCM48s61s1OleSPSSvJE/
 jYRa0jMXP98N5IEn8rEbkPua/yrm9ynHqi4dKEBCq/F7WDQ+FfUaFQb4ey47A/aSHstzpgsl
 TSDTJDD+Ms8y9x2X5EPKXnI3GRLaCKXVNNtrvbUd9LsKymK3WSbADaX7i0gvMFq7j51P/8yj
 neaUSKSkktHauJAtBNXHMghWm/xJXIVAW8xX5aEiSK7DNp5AM478rDXn9NZFUdLTAScVf7LZ
 VzMFKR0jAVG786b/O5vbxklsww+YXJGvCUvHuysEsz5EEzThTJ6AC5JM2iBn9/63PKiS3ptJ
 QAqzasT6KkZ9fKLdK3qtc6yPaSm22C5ROM3GS+yLy6iWBkJ/nEYh/L/du+TLw7YNbKejBr/J
 ml+V3qZLfuhDjW0GbeJVPzsENuxiNiBbyzlSnAvKlzda/sBDvxmvWhC+nMRQCf47mFr8Xx3w
 WtDSQavnz3zTa0XuEucpwfBuVdk4RlPzNPri6p2KTBhPEvRBdC9wNOdRBtsP9rAPjd52d73O
 wU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhWpOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNL
 SoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZKXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVU
 cP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwpbV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+
 S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc
 9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFUCSLB2AE4wXQkJbApye48qnZ09zc929df5gU6
 hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iSYBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616d
 tb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6gLxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/
 t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1c
 OY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0SdujWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475
 KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/JxIqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8
 o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoX
 ywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjKyKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0
 IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9jhQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Ta
 d2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yops302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it
 +OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/pLHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1n
 HzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBUwYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVIS
 l73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lUXOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY
 3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfAHQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4Pls
 ZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQizDiU6iOrUzBThaMhZO3i927SG2DwWDVzZlt
 KrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gDuVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260311072614.1095587-6-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 14839079298058857483
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFnnWxY2A1ZcYYKxv+HLvH3XGK9dbVY5gE5ZTKt8D4sAqHz8IvTg29T8h0pxuHMaX42LYH/10Zv81g2plTFzax1Ji6Pf7CJV0o1GM/2BLpMwZMUuzP1kZwwVVaHqIGhQBpQmA5xALKTffIsLFH6PtFtUa1jKMPb+5TMu9cAte24IeqJjTRGhqlronUM3HmLdyv9kW2zL/+qLmnHBnx5J0ywcczCl3Rvt38dZNWXQXQY05KCA1AXKN/4HJrkcqtKJxYKGD7kL1mxjZiSK/6swG6S2mmueRSbPqBfESOEZOvVY/iZ2DEwYaMwaCK9q+1X3uIJolhHPdXbOzIqbzLU0Ba5KarEnVKJZ7sEh4OX7bH0w1RazwqaE2Rkl8c9NzUTTQdMY2zy6t79ATPYTbUEkiW5uK2QCBCxBSGG0P0f6dzwJjRJFwk4jxM6wpK4xcv3wSC8YnsV4xPYFsmwJCHs75vfJXJmATafj8gNn9OTyFeSMHDmuCqPAtd9K2aHgIzd+iFTddS8BtETmL8Y6itUZnMlZF6EasH+Bvcfta2E/Zkzt4tuj2xiJwQo6UVFHmRjZyipaM9Yqg9Cziq63PrpRNgDbuIojusnDXNV59Y2YSC+69QSsYY9CgtTIQ9Px/b8Caz0Pi6/E0nuKg4H53S6RFB5N8uhHKvXvOBJfIUCdU3wdQ
DKIM-Signature: a=rsa-sha256; bh=gLfVo4yOMyf1U6xBbDZwKJsVi1bSh1SphtrJq5OJfRU=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1776012783; v=1;
 b=eY6/G0HlmMvRhYIs3neAhl8JZhIof7u390zHuMq2eTEZlmYAomlEfFHEVYwqV/BLm6EpQQc3
 DI+fCMjxje2FoAHS+Gv9J9GtZI6kCJhUCTFfa3sPtUX5/sALtrc6EJRZYraBP0Ny+SUChz4zmZ6
 MJkZcWV4Wdr4iAbxkQ6AsGgKyDK03x9UN/TSRxxoYC4IZArRf+jexc0QlI4m8Wch8gzy9UioVtR
 p/JrKE0mzQBsAZITrhVwvnmjdAc0ynuJ+HesZ/wLpGG5AccI5ieqdf+12BNKnRCVOwoVNHpsqdF
 hQwMFNfdvtKEE1Bdp3UNQD6Qua4xRd99KpTsNFD/upYyw==
Received-SPF: pass client-ip=51.210.94.138; envelope-from=clg@kaod.org;
 helo=smtpout1.mo533.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/11/26 08:26, Jamin Lin wrote:
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
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/usb/hcd-ehci.h        | 1 +
>   hw/usb/hcd-ehci-pci.c    | 2 ++
>   hw/usb/hcd-ehci-sysbus.c | 2 ++
>   hw/usb/hcd-ehci.c        | 5 ++++-
>   4 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
> index df87f8145f..7dc6d151cc 100644
> --- a/hw/usb/hcd-ehci.h
> +++ b/hw/usb/hcd-ehci.h
> @@ -274,6 +274,7 @@ struct EHCIState {
>   
>       /* properties */
>       uint32_t maxframes;
> +    bool caps_64bit_addr;
>   
>       /*
>        *  EHCI spec version 1.0 Section 2.3
> diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
> index 9febcc1031..2ea8549db9 100644
> --- a/hw/usb/hcd-ehci-pci.c
> +++ b/hw/usb/hcd-ehci-pci.c
> @@ -137,6 +137,8 @@ static void usb_ehci_pci_write_config(PCIDevice *dev, uint32_t addr,
>   
>   static const Property ehci_pci_properties[] = {
>       DEFINE_PROP_UINT32("maxframes", EHCIPCIState, ehci.maxframes, 128),
> +    DEFINE_PROP_BOOL("caps-64bit-addr", EHCIPCIState, ehci.caps_64bit_addr,
> +                     false),
>   };
>   
>   static const VMStateDescription vmstate_ehci_pci = {
> diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
> index b31032bbf3..61215e9f3d 100644
> --- a/hw/usb/hcd-ehci-sysbus.c
> +++ b/hw/usb/hcd-ehci-sysbus.c
> @@ -34,6 +34,8 @@ static const Property ehci_sysbus_properties[] = {
>       DEFINE_PROP_UINT32("maxframes", EHCISysBusState, ehci.maxframes, 128),
>       DEFINE_PROP_BOOL("companion-enable", EHCISysBusState, ehci.companion_enable,
>                        false),
> +    DEFINE_PROP_BOOL("caps-64bit-addr", EHCISysBusState, ehci.caps_64bit_addr,
> +                     false),
>   };
>   
>   static void usb_ehci_sysbus_realize(DeviceState *dev, Error **errp)
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index 87c3991313..9e82328116 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -2538,6 +2538,9 @@ void usb_ehci_realize(EHCIState *s, DeviceState *dev, Error **errp)
>                      s->maxframes);
>           return;
>       }
> +    if (s->caps_64bit_addr) {
> +        s->caps[0x08] |= BIT(0);
> +    }
>   
>       memory_region_add_subregion(&s->mem, s->capsbase, &s->mem_caps);
>       memory_region_add_subregion(&s->mem, s->opregbase, &s->mem_opreg);
> @@ -2597,7 +2600,7 @@ void usb_ehci_init(EHCIState *s, DeviceState *dev)
>       s->caps[0x05] = 0x00;        /* No companion ports at present */
>       s->caps[0x06] = 0x00;
>       s->caps[0x07] = 0x00;
> -    s->caps[0x08] = 0x80;        /* We can cache whole frame, no 64-bit */
> +    s->caps[0x08] = 0x80;        /* We can cache whole frame */
>       s->caps[0x0a] = 0x00;
>       s->caps[0x0b] = 0x00;
>   

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


