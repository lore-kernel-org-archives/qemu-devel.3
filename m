Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07C2C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 19:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYWP6-0000n1-BA; Fri, 09 Feb 2024 14:19:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1rYWP4-0000mR-0C; Fri, 09 Feb 2024 14:19:14 -0500
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1rYWP1-0007A1-Rj; Fri, 09 Feb 2024 14:19:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1707506347; x=1708111147; i=deller@gmx.de;
 bh=76cOUPQpYX2lz+rHx7nC/M5aC3BBO0gOfWalX9L82HE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=Xro7CSObeCp8GbS5F200AKX3o0I0zEAsjfmhynZ+CjU7auGlyxH+PO2RZ4lTPLFG
 d4LqGYtk5xFCwnbQ2WYNy8yNDHTAf5GMWEwN8OB3Yqg2oQ5ASDMTI65ZRcUvMgGN5
 pyb5UlG1rh32U1o3oUB1c8kBm5Q456b1lqz9Hsha7p+3cCNUdcjGjLHnQRv84koyf
 qXFkxOz7G+gNGDSb/OR9u4Tlr5vIm/kpZ8Htd1SB3lRBSW1Ac8XLbnILQbW/Gt0qQ
 0refsD4DF+qt+3pUqDmUwnaWam8O/yRVpoLOA2Ysn/GcixjWedMJsG09/owfyn8cd
 DrB1wAEZA66MxTfCiw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.148.154]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUXpK-1rPcS23N0S-00QUA6; Fri, 09
 Feb 2024 20:19:06 +0100
Message-ID: <41399ad8-006d-4480-919e-d64395c5cfe9@gmx.de>
Date: Fri, 9 Feb 2024 20:19:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/hppa/Kconfig: Fix building with "configure
 --without-default-devices"
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org,
 qemu-trivial@nongnu.org
References: <20240209185506.248001-1-thuth@redhat.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240209185506.248001-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NGNlqiZi995P1KUzNosLN+laBunFROxEkfal2WhCcW9lLkIallk
 APpeTngNAtoUV9DUYceenW3sqHfdGJ5vOeqp1UPIFoLm7+Nmd8RjHVl/lDn++V44YPVVT/9
 eeSmAzdO87g9iij3OJHid15I2gG+DU9wUVcNJyh6wPlYW03arwvUw8C797WTBMNwbvh6jYI
 DnxVa81Q6lAEpONPi0TlQ==
UI-OutboundReport: notjunk:1;M01:P0:65AAi800ki4=;Vslg0gObrzqCd6YGRfwnZ/v4s6x
 tVhkZO4OCLJ3JaMQrlI8P+15QoQW+nkz+cbs0W0gjZQqMFQk1SP2Q3zBA7bsJkxrTIDVFicq/
 AbeTd37yV0i1JwqO8LGVygFM7eDB780a+VY92vDWTjX8KYWra+NvTzR1wB/A8QwhgjGqzwYaF
 eNhf3mLDYhd9Y7oFA+RqFYAkRGf0Pk2RvZy7uyjASZc1bVrBHlXIjkUVPphmrRhTBgg/3JVmV
 ViDp/Va0oYl9yZZShc8a0lxnvQ/f1wTP3XuBmDt1YjcQVS+l4CiEHi6L/QgDY+LlVaqMRWgnr
 KiNzekeFEaTBuZO+GjKF49TApy+DvBN8ivR4mbFRa2H+W33MnqCQjrnChNIy/NI1MlPb3LIy8
 Ok4BqnbDhe8yaJu8pFk4rM4uoUQSjD1OCCdc5eu8iVNKfapJbrYJOIPNPgFzV2lj/+KHr0Trp
 8cfxYOLBh073vrSPgj2GDLhtQCR6RJ4kzgAJ6t0knijcdZWvwH+spIdsn4jsQPre0OsXxRhlF
 f+thDgVJAFDC4qo5/njgks5Qovdl52PX0H5wvCEDfS3edmFlUFgQ7e2haelaatxsacf4/3yHs
 iEHKRkcfHWNDYxWmBvMzhlUxJOsHrhHMeqQiUCa9LMmAP8/qjvaEfRpLJ08tJc1/f7vk2ePPr
 j/vCmJ5rbNugSTE/94cpgD3DgiUDaL8wakFmjLJtrIOUvcTky0U4UbQ1TBBYwhPE3ZQkEh9JK
 pmBMfajFp6PeaNEtfcgSxPsC079HljGZmC9kZdZs4tQBtRmJe4Zt+IC9FkVbCxtF7WoHswSS3
 UmZlrxU/+gdstapZ0zhIr793afLloGx/BWbMyqxhHih6w=
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

On 2/9/24 19:55, Thomas Huth wrote:
> When running "configure" with "--without-default-devices", building
> of qemu-system-hppa currently fails with:
>
>   /usr/bin/ld: libqemu-hppa-softmmu.fa.p/hw_hppa_machine.c.o: in functio=
n `machine_HP_common_init_tail':
>   hw/hppa/machine.c:399: undefined reference to `usb_bus_find'
>   /usr/bin/ld: hw/hppa/machine.c:399: undefined reference to `usb_create=
_simple'
>   /usr/bin/ld: hw/hppa/machine.c:400: undefined reference to `usb_bus_fi=
nd'
>   /usr/bin/ld: hw/hppa/machine.c:400: undefined reference to `usb_create=
_simple'
>   collect2: error: ld returned 1 exit status
>   ninja: build stopped: subcommand failed.
>   make: *** [Makefile:162: run-ninja] Error 1
>
> And after fixing this, the qemu-system-hppa binary refuses to run
> due to the missing 'pci-ohci' and 'pci-serial' devices. Let's add
> the right config switches to fix these problems.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/hppa/Kconfig | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/hppa/Kconfig b/hw/hppa/Kconfig
> index ff8528aaa8..124d5e9e47 100644
> --- a/hw/hppa/Kconfig
> +++ b/hw/hppa/Kconfig
> @@ -6,7 +6,7 @@ config HPPA_B160L
>       select ASTRO
>       select DINO
>       select LASI
> -    select SERIAL
> +    select SERIAL_PCI

I think the "SERIAL" is needed too for the B160L machine.
Other than that,

Acked-by: Helge Deller <deller@gmx.de>

Thank you!
Helge

>       select ISA_BUS
>       select I8259
>       select IDE_CMD646
> @@ -16,3 +16,4 @@ config HPPA_B160L
>       select LASIPS2
>       select PARALLEL
>       select ARTIST
> +    select USB_OHCI_PCI


