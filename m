Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7A010854DE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2nUM-0005lS-Tc; Wed, 18 Mar 2026 05:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2nUH-0005l1-GJ
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 05:46:49 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2nUF-0007i6-G9
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 05:46:49 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4853f2826f7so68779455e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 02:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773827205; x=1774432005; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fdyOOLf5i8Dd0YGruaC4rY66y3fKstXBEGkq6ENOaj0=;
 b=aAcWGtgnv6scg080ZlpYBelPJsxn0YmpeZaNBkpQk0olyq5LpcMfMckF5Y2PGUxP+b
 yA9Mi8jtHTDmJQZdo8UoTWxPpOok3SlY5KEv9locls3utBV/qL4//HNhh5FKQbhOREdA
 8PeFZHPD7qQRTa6Vse136OTaX0QBgJ+1YCCGdZnpE2+2znWoqXMWiGVs7wQr4dXAMnx3
 VWN+3XjOOSiATpxCvoPxHYyeqT4/wNMf7mcoPF6Ab0SIYXJ+e8wiOMOkSinSGrifNksh
 TOAuP+k6NAb3GwM3JsqOtFaftaRI7zUra0MTnIUS+NzyHDwLiB1gJaKaTJVQ1H5awjOV
 BVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773827205; x=1774432005;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fdyOOLf5i8Dd0YGruaC4rY66y3fKstXBEGkq6ENOaj0=;
 b=DEQycp0Ak6vJRk1kUJYx9c8eu1y2VVYkkViWazB7FYRflXuj4xXotXkVsMs0lLXONM
 oHm6xQJmSyJ4dqYe1DbHS5c+SnuXex3bdiOb6BZr9kvPH7Y8p/cW7IKkgAbZfwuBBFzQ
 ZCOBhLsr9fSyzslurY12B8zr/OF1OmLsUsI8xyeBG40qRmL1TuTo3oHpPlJeqCAmUnWZ
 y+JLKz3SmwvMJ/3DHDJBXJc+9oogq24HSx4QRVKIm42qsVKpbQKfTonQZezDMNk6kb5E
 Phay8ZeQvMswcLoCq9Nu49cqv4bWwYAyCxtoCy+6A38T0UazOyNXefqmFtrkCgoHfSCx
 92Xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYR0Actgj2h6EOi5gkmJLgBRLdP+lYD2hmzaB1mXirbbd6e1OHuOWq5ZbCvpkIUPQPN9jo51pzG/07@nongnu.org
X-Gm-Message-State: AOJu0Yzf2j6ZKplwnWT4x4a+UyILN/FzKhS5vgpUuQQJye/sKwkIPYoX
 WG9ZKef3UONG5QutoqaCG9R3f33NE0lpQbgimsdCCACzJ6iLR8keqxqa5UbTjF7BS3U=
X-Gm-Gg: ATEYQzxKdS5dYjDmDWDUfNqVHDqdZBL7gwOSab5qRz63wCAp3m2SioxEb6LOxpzUpsv
 gpnS5AUzW+IZkdZ4GeGBNpfip/9IO3Gr2KW90/ZqWJ3pog93OaLlgsrjm1kKTTasozViGRInJuS
 twl+ExEq2k5v7AKggATqGgCquGP6JapKQwk07jOeJvMLs0qTDdZgmWXkEjaAhPegMNjXYPHi9RR
 NWv3iuTVw30efq5CA5TDJyHFn64NlpMbMeYjTnSaq+JLn0xcnXHBDR+JljdIag2xv0z9lrMYHLp
 l2YVWs87jPVxGeVgG5efhEWJ6h8/z15Xdq3dEf6Fn5lO0eBi6PSiUBNC2uFh4bQ3BHPhr/5JzoX
 CcT1hZ+5iS27AS4L6OjB6vvx2pXnp+qNSLNYWKqOWkcC9DO1u3qOaGA4gBihjh6SGV6osQu1Eep
 LkH82zsfMoY/++40MjWGypU7h1BQ4WhzawC6JkvF1xTInwyW0kxWCn5Bxe0CCtH2S+LM5FHwdSa
 LdS
X-Received: by 2002:a05:600c:698c:b0:485:3ca4:4ef4 with SMTP id
 5b1f17b1804b1-486f4437560mr42510605e9.9.1773827205345; 
 Wed, 18 Mar 2026 02:46:45 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f4b810bcsm15040595e9.15.2026.03.18.02.46.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2026 02:46:44 -0700 (PDT)
Message-ID: <b57f120e-dc8e-4d58-861a-01c2112b7d8a@linaro.org>
Date: Wed, 18 Mar 2026 10:46:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] hw/vfio/pci-quirks.c: remove CONFIG_VFIO_IGD
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20260317194241.869568-1-pierrick.bouvier@linaro.org>
 <20260317194241.869568-4-pierrick.bouvier@linaro.org>
 <40924489-a8bb-4f6f-b85e-6f53cf475304@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <40924489-a8bb-4f6f-b85e-6f53cf475304@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 18/3/26 09:11, Cédric Le Goater wrote:
> On 3/17/26 20:42, Pierrick Bouvier wrote:
>> Add stubs for needed functions.
>>

--->

>> As well, we need to add pixman to qemuutil library dependencies since
>> pixman is transitively included from pci.h header, which is needed to be
>> able to include prototypes for stubs we declared.
>> In file included from include/ui/console.h:4,
>>                   from ../hw/vfio/vfio-display.h:12,
>>                   from ../hw/vfio/pci.h:25,
>>                   from ../hw/vfio/igd-stubs.c:9:
>> include/ui/qemu-pixman.h:10:10: fatal error: pixman.h: No such file or 
>> directory
>>     10 | #include <pixman.h>
>>        |          ^~~~~~~~~~
>>
>> On OpenBSD, opengl headers are not available in default include path,
>> and thus we need to add opengl to list of qemuutil dependencies.
>> In file included from /home/root/qemu/include/ui/console.h:9:
>> /home/root/qemu/include/ui/surface.h:11:11: fatal error: 'epoxy/gl.h' 
>> file not found
>>
>> Finally, 

<---

>> vfio_pci_hot_reset_info must be forwarded declared on non linux
>> platforms:
>> In file included from ../hw/vfio/igd-stubs.c:9:
>> ../hw/vfio/pci.h:265:44: error: 'struct vfio_pci_hot_reset_info' 
>> declared inside parameter list will not be visible outside of this 
>> definition or declaration [-Werror]
>>    265 |                                     struct 
>> vfio_pci_hot_reset_info **info_p);
>>        |
>>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Duplicated Signed-off-by. I can fix when applying.

Actually you can also cut description marked betwwen --->
and <--- because already mentioned in future commit 988499515da:
https://lore.kernel.org/qemu-devel/20260317190250.70506-3-philmd@linaro.org/
which removes [*] below (should disappear on rebase).

(Sorry for that hiccups, I was expecting Pierrick series to
be posted after my PR was merged).

Regards,

Phil.

> 
> Thanks,
> 
> C.
> 
>> ---
>>   meson.build          |  2 +-
>>   hw/vfio/pci.h        |  2 ++
>>   hw/vfio/igd-stubs.c  | 20 ++++++++++++++++++++
>>   hw/vfio/pci-quirks.c |  5 -----
>>   hw/vfio/meson.build  |  1 +
>>   5 files changed, 24 insertions(+), 6 deletions(-)
>>   create mode 100644 hw/vfio/igd-stubs.c
>>
>> diff --git a/meson.build b/meson.build
>> index b2154bb9287..ab726ea1152 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -3781,7 +3781,7 @@ util_ss = util_ss.apply({})
>>   libqemuutil = static_library('qemuutil',
>>                                build_by_default: false,
>>                                sources: util_ss.sources() + 
>> stub_ss.sources() + genh,
>> -                             dependencies: [util_ss.dependencies(), 
>> libm, threads, glib, socket, malloc, rt])
>> +                             dependencies: [util_ss.dependencies(), 
>> libm, threads, glib, socket, malloc, rt, pixman, opengl])

[*]

>>   qemuutil = declare_dependency(link_with: libqemuutil,
>>                                 sources: genh + version_res,
>>                                 dependencies: [event_loop_base])
>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>> index d6495d7f297..c3a1f53d350 100644
>> --- a/hw/vfio/pci.h
>> +++ b/hw/vfio/pci.h
>> @@ -258,6 +258,8 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice 
>> *vdev, Error **errp);
>>   extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
>> +struct vfio_pci_hot_reset_info;
>> +
>>   void vfio_pci_pre_reset(VFIOPCIDevice *vdev);
>>   void vfio_pci_post_reset(VFIOPCIDevice *vdev);
>>   bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name);
>> diff --git a/hw/vfio/igd-stubs.c b/hw/vfio/igd-stubs.c
>> new file mode 100644
>> index 00000000000..f7687d90912
>> --- /dev/null
>> +++ b/hw/vfio/igd-stubs.c
>> @@ -0,0 +1,20 @@
>> +/*
>> + * IGD device quirks stubs
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qapi/qmp/qerror.h"
>> +#include "pci.h"
>> +#include "pci-quirks.h"
>> +
>> +void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>> +{
>> +    return;
>> +}
>> +
>> +bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>> +{
>> +    return true;
>> +}
>> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
>> index 7b907b9360d..ab864048943 100644
>> --- a/hw/vfio/pci-quirks.c
>> +++ b/hw/vfio/pci-quirks.c
>> @@ -11,7 +11,6 @@
>>    */
>>   #include "qemu/osdep.h"
>> -#include CONFIG_DEVICES
>>   #include "exec/memop.h"
>>   #include "qemu/units.h"
>>   #include "qemu/log.h"
>> @@ -1128,11 +1127,9 @@ static void 
>> vfio_probe_rtl8168_bar2_quirk(VFIOPCIDevice *vdev, int nr)
>>    */
>>   bool vfio_config_quirk_setup(VFIOPCIDevice *vdev, Error **errp)
>>   {
>> -#ifdef CONFIG_VFIO_IGD
>>       if (!vfio_probe_igd_config_quirk(vdev, errp)) {
>>           return false;
>>       }
>> -#endif
>>       return true;
>>   }
>> @@ -1179,9 +1176,7 @@ void vfio_bar_quirk_setup(VFIOPCIDevice *vdev, 
>> int nr)
>>       vfio_probe_nvidia_bar5_quirk(vdev, nr);
>>       vfio_probe_nvidia_bar0_quirk(vdev, nr);
>>       vfio_probe_rtl8168_bar2_quirk(vdev, nr);
>> -#ifdef CONFIG_VFIO_IGD
>>       vfio_probe_igd_bar0_quirk(vdev, nr);
>> -#endif
>>   }
>>   void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr)
>> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
>> index f2a7728d3d0..6c00a7f51bb 100644
>> --- a/hw/vfio/meson.build
>> +++ b/hw/vfio/meson.build
>> @@ -17,6 +17,7 @@ vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
>>   vfio_ss.add(when: 'CONFIG_VFIO_CCW', if_true: files('ccw.c'))
>>   vfio_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
>>   vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'))
>> +stub_ss.add(files('igd-stubs.c'))
>>   specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
> 


