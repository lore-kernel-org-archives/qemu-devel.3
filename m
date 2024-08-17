Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5E3C52D7F
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2024 17:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfNGH-0003v6-4i; Sat, 17 Aug 2024 13:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zero.tangptr@gmail.com>)
 id 1sfNGF-0003uZ-9o
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 13:30:43 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zero.tangptr@gmail.com>)
 id 1sfNGA-0001kX-7u
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 13:30:41 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5b8c2a61386so3819171a12.2
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2024 10:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723915835; x=1724520635; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Zy2+GwPw0ceK0vnsRd8bZOnfACJqtSwGb89LOz68H9E=;
 b=O+1j1y75K2LuiARm8OXFqLdbCYdJ2bnfiLpg6fsQAsqBDh9sAZvC8I4L0ONHzUE2af
 iHVAWMZQV+7Dpv7v0uBqIC3k6jNWVHYj5fj1LWZyOR8VRfSbAwDyov2gvW2E8ecS4SiF
 Nb8Vj+TcWFoLYoL/cxgMECJknlC1FmmJ6w1J56Fk8eWrxcGWiqItGhMuA6td2y7VnIT0
 DQpMXAtDt+7iahlb8oYLreTqVsOQozdK0lRtZcewE+6iMSX+AwRT9gkyJ4zUT9QocFfJ
 kNE1SMk2kfsUhX1y5E7bPjHfyAyaXL4fNbWGslonQ67wAMo/3TxNyJSzVErU3FYooDmN
 O7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723915835; x=1724520635;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zy2+GwPw0ceK0vnsRd8bZOnfACJqtSwGb89LOz68H9E=;
 b=Th+Ft2ZHo2A7MDk9BV5ecf0lwO+4p7+3EcxODSz/BmQ4Olo0FqIaCGbDMFYiAj+dqj
 msFTpTPmap2FfsrfoxuVdjBcCv0JIcnAm6xrJxE5SXPs/MX886/d7Vfsd0UjY22ZXJIr
 xA1JQ/g/hY+t4JKtz6ZtV0FAlAVlUQhDbQ9zwqYSQ6OvG/GsgdFTXCDYZqUCEXRIcg8u
 TzzvbzE1XiOJtEMBg3wbB6RvLoqBRSOU6rS6mFPgDf3oBzBG3jCwOB4ZzQEvNVCtp/ey
 Quak76F9/cSlQU/HyGmzZSuWNyYoLCTukLkWr5LwO+0IgUshdf/vODVnSIe/sZd4w+bu
 Qg9A==
X-Gm-Message-State: AOJu0Yy7kVAHjBzpnysSU3XUN9IWmCamX5pKeWtXS1EQVYTjjZ9MfdbV
 ciOFXEkZRZuGqgeE1bYAk9TtucBlGM3Tu0sDr2q/QubkqtoN/w6d8Kv4rGAOuLTk4tH7vvSm4za
 EMYDurhFlc4ISbsy1hbOh85o1M7VnXESX
X-Google-Smtp-Source: AGHT+IHR+7eyaJqx+Hi8/EA/DbSKFH2kPcvBQiZq8VVYb1X/8sxtWE+EeGeiWlOIQqrA3XHmobdDOSYP4UZ7+yGiaeQ=
X-Received: by 2002:a05:6402:5190:b0:5a2:84e2:c895 with SMTP id
 4fb4d7f45d1cf-5bedb7578edmr1778628a12.34.1723915834669; Sat, 17 Aug 2024
 10:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAAXNugBYhpx249dUWgyXOtGjkxWatRHJSq94LrVFMGP_GjX7aA@mail.gmail.com>
In-Reply-To: <CAAXNugBYhpx249dUWgyXOtGjkxWatRHJSq94LrVFMGP_GjX7aA@mail.gmail.com>
From: Zero Tang <zero.tangptr@gmail.com>
Date: Sun, 18 Aug 2024 01:30:22 +0800
Message-ID: <CAAXNugCTpOOeEv_FvjZqV_H_55FYm-Vqx4WC6pCEb4e7C2NTXA@mail.gmail.com>
Subject: Re: [PATCH] hw/misc: Add a virtual PCILeech device
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com
Content-Type: multipart/alternative; boundary="000000000000f2c454061fe46e9c"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=zero.tangptr@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000f2c454061fe46e9c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I'd like to ping this patch in that the QEMU-PCILeech plugin is now merged
into the PCILeech repository:
https://github.com/ufrisk/LeechCore-plugins/pull/10
The Patchew link is:
https://patchew.org/QEMU/CAAXNugBYhpx249dUWgyXOtGjkxWatRHJSq94LrVFMGP._5FGj=
X7aA@mail.gmail.com/

Kind Regards,
Zero Tang

On Tue, Aug 6, 2024 at 5:28=E2=80=AFPM Zero Tang <zero.tangptr@gmail.com> w=
rote:

> This virtual PCILeech device aims to help security researchers attack the
> guest via DMA and test their IOMMU defenses.
> This device is intended to support any systems with PCI, but I am only
> able to test x86-based guests.
> For what PCILeech is, check PCILeech GitHub repository:
> https://github.com/ufrisk/pcileech
> The QEMU-PCILeech plugin is currently awaiting merging:
> https://github.com/ufrisk/LeechCore-plugins/pull/10
>
> This is my first time contributing to QEMU and I am sorry that I forgot t=
o
> include a "[PATCH]" prefix in the title from my previous email and that I
> didn't cc to relevant maintainers.
> If needed, add my name and contact info into the maintainer's list.
>
> Signed-off-by: Zero Tang <zero.tangptr@gmail.com>
> ---
>  hw/misc/Kconfig     |   5 ++++
>  hw/misc/meson.build |   1 +
>  hw/misc/pcileech.c  | 291
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
>  3 files changed, 297 insertions(+)
>
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 1e08785b83..6c3ea7bf74 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -30,6 +30,11 @@ config EDU
>      default y if TEST_DEVICES
>      depends on PCI && MSI_NONBROKEN
>
> +config PCILEECH
> +    bool
> +    default y
> +    depends on PCI
> +
>  config PCA9552
>      bool
>      depends on I2C
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 2ca8717be2..e79931b9a6 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -1,5 +1,6 @@
>  system_ss.add(when: 'CONFIG_APPLESMC', if_true: files('applesmc.c'))
>  system_ss.add(when: 'CONFIG_EDU', if_true: files('edu.c'))
> +system_ss.add(when: 'CONFIG_PCILEECH', if_true: files('pcileech.c'))
>  system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('vmcoreinfo.c'))
>  system_ss.add(when: 'CONFIG_ISA_DEBUG', if_true: files('debugexit.c'))
>  system_ss.add(when: 'CONFIG_ISA_TESTDEV', if_true: files('pc-testdev.c')=
)
> diff --git a/hw/misc/pcileech.c b/hw/misc/pcileech.c
> new file mode 100644
> index 0000000000..252a570161
> --- /dev/null
> +++ b/hw/misc/pcileech.c
> @@ -0,0 +1,291 @@
> +/*
> + * QEMU Virtual PCILeech Device
> + *
> + * Copyright (c) 2024 Zero Tang
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the
> "Software"),
> + * to deal in the Software without restriction, including without
> limitation
> + * the rights to use, copy, modify, merge, publish, distribute,
> sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
> SHALL THE
> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHE=
R
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG
> + * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> + * DEALINGS IN THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "hw/pci/pci.h"
> +#include "hw/hw.h"
> +#include "hw/pci/msi.h"
> +#include "qemu/timer.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
> +#include "qom/object.h"
> +#include "qemu/main-loop.h" /* iothread mutex */
> +#include "qemu/module.h"
> +#include "qapi/visitor.h"
> +
> +#define TYPE_PCILEECH_DEVICE "pcileech"
> +
> +struct LeechRequestHeader {
> +    uint8_t endianness; /* 0 - Little, 1 - Big */
> +    uint8_t command;    /* 0 - Read, 1 - Write */
> +    uint8_t reserved[6];
> +    /* Variable Endianness */
> +    uint64_t address;
> +    uint64_t length;
> +};
> +
> +struct LeechResponseHeader {
> +    uint8_t endianness; /* 0 - Little, 1 - Big */
> +    uint8_t reserved[3];
> +    MemTxResult result;
> +    uint64_t length;    /* Indicates length of data followed by header *=
/
> +};
> +
> +/* Verify the header length */
> +static_assert(sizeof(struct LeechRequestHeader) =3D=3D 24);
> +static_assert(sizeof(struct LeechResponseHeader) =3D=3D 16);
> +
> +struct PciLeechState {
> +    /* Internal State */
> +    PCIDevice device;
> +    QemuThread thread;
> +    QemuMutex mutex;
> +    bool endianness;
> +    bool stopping;
> +    /* Communication */
> +    char *host;
> +    uint16_t port;
> +    int sockfd;
> +};
> +
> +typedef struct LeechRequestHeader LeechRequestHeader;
> +typedef struct PciLeechState PciLeechState;
> +
> +DECLARE_INSTANCE_CHECKER(PciLeechState, PCILEECH, TYPE_PCILEECH_DEVICE)
> +
> +static void pci_leech_process_write_request(PciLeechState *state,
> +                                            LeechRequestHeader *request,
> +                                            int incoming)
> +{
> +    char buff[1024];
> +    for (uint64_t i =3D 0; i < request->length; i +=3D sizeof(buff)) {
> +        struct LeechResponseHeader response =3D { 0 };
> +        char* response_buffer =3D (char *)&response;
> +        const uint64_t writelen =3D (request->length - i) <=3D sizeof(bu=
ff) ?
> +                                         (request->length - i) :
> sizeof(buff);
> +        ssize_t recvlen =3D 0, sendlen =3D 0;
> +        while (recvlen < writelen) {
> +            recvlen +=3D recv(incoming, &buff[recvlen], writelen - recvl=
en,
> 0);
> +        }
> +        response.endianness =3D state->endianness;
> +        response.result =3D pci_dma_write(&state->device, request->addre=
ss
> + i,
> +                                                            buff,
> writelen);
> +        if (response.result) {
> +            printf("PCILeech: Address 0x%lX Write Error! MemTxResult:
> 0x%X\n",
> +                    request->address + i, response.result);
> +        }
> +        response.length =3D 0;
> +        while (sendlen < sizeof(struct LeechResponseHeader)) {
> +            sendlen +=3D send(incoming, &response_buffer[sendlen],
> +                            sizeof(struct LeechResponseHeader) - sendlen=
,
> 0);
> +        }
> +    }
> +}
> +
> +static void pci_leech_process_read_request(PciLeechState *state,
> +                                            LeechRequestHeader *request,
> +                                            int incoming)
> +{
> +    char buff[1024];
> +    for (uint64_t i =3D 0; i < request->length; i +=3D sizeof(buff)) {
> +        struct LeechResponseHeader response =3D { 0 };
> +        char* response_buffer =3D (char *)&response;
> +        const uint64_t readlen =3D (request->length - i) <=3D sizeof(buf=
f) ?
> +                                    (request->length - i) : sizeof(buff)=
;
> +        ssize_t sendlen =3D 0;
> +        response.endianness =3D state->endianness;
> +        response.result =3D pci_dma_read(&state->device, request->addres=
s +
> i,
> +                                                            buff,
> readlen);
> +        if (response.result) {
> +            printf("PCILeech: Address 0x%lX Read Error! MemTxResult:
> 0x%X\n",
> +                    request->address + i, response.result);
> +        }
> +        response.length =3D (request->endianness !=3D state->endianness)=
 ?
> +                                            bswap64(readlen) : readlen;
> +        while (sendlen < sizeof(struct LeechResponseHeader)) {
> +            sendlen +=3D send(incoming, &response_buffer[sendlen],
> +                            sizeof(struct LeechResponseHeader) - sendlen=
,
> 0);
> +        }
> +        sendlen =3D 0;
> +        while (sendlen < readlen) {
> +            sendlen +=3D send(incoming, &buff[sendlen], readlen - sendle=
n,
> 0);
> +        }
> +    }
> +}
> +
> +static void *pci_leech_worker_thread(void *opaque)
> +{
> +    PciLeechState *state =3D PCILEECH(opaque);
> +    while (1) {
> +        LeechRequestHeader request;
> +        char *request_buffer =3D (char *)&request;
> +        ssize_t received =3D 0;
> +        int incoming;
> +        struct sockaddr address;
> +        socklen_t addrlen;
> +        /* Check if we are stopping. */
> +        qemu_mutex_lock(&state->mutex);
> +        if (state->stopping) {
> +            qemu_mutex_unlock(&state->mutex);
> +            break;
> +        }
> +        qemu_mutex_unlock(&state->mutex);
> +        /* Accept PCILeech requests. */
> +        /* Use HTTP1.0-like protocol for simplicity. */
> +        incoming =3D accept(state->sockfd, &address, &addrlen);
> +        if (incoming < 0) {
> +            puts("WARNING: Failed to accept socket for PCILeech! Skippin=
g
> "
> +                 "Request...\n");
> +            continue;
> +        }
> +        /* Get PCILeech requests. */
> +        while (received < sizeof(LeechRequestHeader)) {
> +            received +=3D recv(incoming, &request_buffer[received],
> +                            sizeof(LeechRequestHeader) - received, 0);
> +        }
> +        /* Swap endianness. */
> +        if (request.endianness !=3D state->endianness) {
> +            request.address =3D bswap64(request.address);
> +            request.length =3D bswap64(request.length);
> +        }
> +        /* Process PCILeech requests. */
> +        qemu_mutex_lock(&state->mutex);
> +        if (request.command) {
> +            pci_leech_process_write_request(state, &request, incoming);
> +        } else {
> +            pci_leech_process_read_request(state, &request, incoming);
> +        }
> +        qemu_mutex_unlock(&state->mutex);
> +        close(incoming);
> +    }
> +    return NULL;
> +}
> +
> +static void pci_leech_realize(PCIDevice *pdev, Error **errp)
> +{
> +    PciLeechState *state =3D PCILEECH(pdev);
> +    struct sockaddr_in sock_addr;
> +    char host_ip[16];
> +    struct hostent *he =3D gethostbyname(state->host);
> +    if (he =3D=3D NULL) {
> +        puts("gethostbyname failed!");
> +        exit(EXIT_FAILURE);
> +    }
> +    /* Initialize the socket for PCILeech. */
> +    state->sockfd =3D socket(AF_INET, SOCK_STREAM, 0);
> +    if (state->sockfd < 0) {
> +        puts("Failed to initialize socket for PCILeech!");
> +        exit(EXIT_FAILURE);
> +    }
> +    sock_addr.sin_family =3D AF_INET;
> +    sock_addr.sin_addr =3D *(struct in_addr *)he->h_addr;
> +    sock_addr.sin_port =3D htons(state->port);
> +    inet_ntop(AF_INET, &sock_addr.sin_addr, host_ip, sizeof(host_ip));
> +    if (bind(state->sockfd, (struct sockaddr *)&sock_addr,
> sizeof(sock_addr))
> +                                                                    < 0)=
 {
> +        puts("Failed to bind socket for PCILeech!");
> +        close(state->sockfd);
> +        exit(EXIT_FAILURE);
> +    }
> +    if (listen(state->sockfd, 10) < 0) {
> +        puts("Failed to listen to socket for PCILeech!");
> +        close(state->sockfd);
> +        exit(EXIT_FAILURE);
> +    }
> +    printf("INFO: PCILeech is listening on %s:%u...\n", host_ip,
> state->port);
> +    /* Initialize the thread for PCILeech. */
> +    qemu_mutex_init(&state->mutex);
> +    qemu_thread_create(&state->thread, "pcileech",
> pci_leech_worker_thread,
> +                                            state, QEMU_THREAD_JOINABLE)=
;
> +}
> +
> +static void pci_leech_finalize(PCIDevice *pdev)
> +{
> +    PciLeechState *state =3D PCILEECH(pdev);
> +    puts("Stopping PCILeech Worker...");
> +    qemu_mutex_lock(&state->mutex);
> +    state->stopping =3D true;
> +    qemu_mutex_unlock(&state->mutex);
> +    close(state->sockfd);
> +    qemu_thread_join(&state->thread);
> +    qemu_mutex_destroy(&state->mutex);
> +}
> +
> +char pci_leech_default_host[] =3D "0.0.0.0";
> +
> +static void pci_leech_instance_init(Object *obj)
> +{
> +    int x =3D 1;
> +    char* y =3D (char *)&x;
> +    PciLeechState *state =3D PCILEECH(obj);
> +    /* QEMU's String-Property can't specify default value. */
> +    /* So we have to set the default on our own. */
> +    if (state->host =3D=3D NULL) {
> +        state->host =3D pci_leech_default_host;
> +    }
> +    /* Save Our Endianness. */
> +    state->endianness =3D (*y =3D=3D 0);
> +}
> +
> +static Property leech_properties[] =3D {
> +    DEFINE_PROP_UINT16("port", PciLeechState, port, 6789),
> +    DEFINE_PROP_STRING("host", PciLeechState, host),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void pci_leech_class_init(ObjectClass *class, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(class);
> +    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(class);
> +    k->realize =3D pci_leech_realize;
> +    k->exit =3D pci_leech_finalize;
> +    /* Change the Vendor/Device ID to your favor. */
> +    /* These are the default values from PCILeech-FPGA. */
> +    k->vendor_id =3D PCI_VENDOR_ID_XILINX;
> +    k->device_id =3D 0x0666;
> +    k->revision =3D 0;
> +    k->class_id =3D PCI_CLASS_NETWORK_ETHERNET;
> +    device_class_set_props(dc, leech_properties);
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +}
> +
> +static void pci_leech_register_types(void)
> +{
> +    static InterfaceInfo interfaces[] =3D {
> +        {INTERFACE_CONVENTIONAL_PCI_DEVICE},
> +        {},
> +    };
> +    static const TypeInfo leech_info =3D {
> +        .name =3D TYPE_PCILEECH_DEVICE,
> +        .parent =3D TYPE_PCI_DEVICE,
> +        .instance_size =3D sizeof(PciLeechState),
> +        .instance_init =3D pci_leech_instance_init,
> +        .class_init =3D pci_leech_class_init,
> +        .interfaces =3D interfaces,
> +    };
> +    type_register_static(&leech_info);
> +}
> +
> +type_init(pci_leech_register_types)
>

--000000000000f2c454061fe46e9c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><div><br></div>I&#39;d like to ping this =
patch in that the QEMU-PCILeech plugin is now merged into the PCILeech repo=
sitory:=C2=A0<a href=3D"https://github.com/ufrisk/LeechCore-plugins/pull/10=
">https://github.com/ufrisk/LeechCore-plugins/pull/10</a><div>The Patchew l=
ink is:=C2=A0<a href=3D"https://patchew.org/QEMU/CAAXNugBYhpx249dUWgyXOtGjk=
xWatRHJSq94LrVFMGP._5FGjX7aA@mail.gmail.com/">https://patchew.org/QEMU/CAAX=
NugBYhpx249dUWgyXOtGjkxWatRHJSq94LrVFMGP._5FGjX7aA@mail.gmail.com/</a></div=
><div><br></div><div>Kind Regards,</div><div>Zero Tang</div></div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 6, =
2024 at 5:28=E2=80=AFPM Zero Tang &lt;<a href=3D"mailto:zero.tangptr@gmail.=
com">zero.tangptr@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex"><div dir=3D"ltr"><div><font face=3D"arial, sans-=
serif">This virtual PCILeech device aims to help security researchers attac=
k the guest via DMA and test their IOMMU defenses.</font></div><div><font f=
ace=3D"arial, sans-serif">This device is intended to support any systems wi=
th PCI, but I am only able to test x86-based guests.</font></div><div><font=
 face=3D"arial, sans-serif">For what PCILeech is, check PCILeech GitHub rep=
ository:=C2=A0</font><a href=3D"https://github.com/ufrisk/pcileech" target=
=3D"_blank">https://github.com/ufrisk/pcileech</a></div><div>The QEMU-PCILe=
ech plugin is currently awaiting merging:=C2=A0<a href=3D"https://github.co=
m/ufrisk/LeechCore-plugins/pull/10" target=3D"_blank">https://github.com/uf=
risk/LeechCore-plugins/pull/10</a></div><div><br></div><div>This is my firs=
t time contributing to QEMU and I am sorry that I forgot to include a &quot=
;[PATCH]&quot; prefix in the title from my previous email and that I didn&#=
39;t cc to relevant maintainers.</div><div>If needed, add my name and conta=
ct info into the maintainer&#39;s list.</div><div><br></div><div>Signed-off=
-by: Zero Tang &lt;<a href=3D"mailto:zero.tangptr@gmail.com" target=3D"_bla=
nk">zero.tangptr@gmail.com</a>&gt;</div><font face=3D"monospace"><div><font=
 face=3D"monospace">---</font></div>=C2=A0hw/misc/Kconfig =C2=A0 =C2=A0 | =
=C2=A0 5 ++++<br>=C2=A0hw/misc/meson.build | =C2=A0 1 +<br>=C2=A0hw/misc/pc=
ileech.c =C2=A0| 291 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++<br>=C2=A03 files changed, 297 insertions(+)<br><br>=
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig<br>index 1e08785b83..6c3ea7b=
f74 100644<br>--- a/hw/misc/Kconfig<br>+++ b/hw/misc/Kconfig<br>@@ -30,6 +3=
0,11 @@ config EDU<br>=C2=A0 =C2=A0 =C2=A0default y if TEST_DEVICES<br>=C2=
=A0 =C2=A0 =C2=A0depends on PCI &amp;&amp; MSI_NONBROKEN<br>=C2=A0<br>+conf=
ig PCILEECH<br>+ =C2=A0 =C2=A0bool<br>+ =C2=A0 =C2=A0default y<br>+ =C2=A0 =
=C2=A0depends on PCI<br>+<br>=C2=A0config PCA9552<br>=C2=A0 =C2=A0 =C2=A0bo=
ol<br>=C2=A0 =C2=A0 =C2=A0depends on I2C<br>diff --git a/hw/misc/meson.buil=
d b/hw/misc/meson.build<br>index 2ca8717be2..e79931b9a6 100644<br>--- a/hw/=
misc/meson.build<br>+++ b/hw/misc/meson.build<br>@@ -1,5 +1,6 @@<br>=C2=A0s=
ystem_ss.add(when: &#39;CONFIG_APPLESMC&#39;, if_true: files(&#39;applesmc.=
c&#39;))<br>=C2=A0system_ss.add(when: &#39;CONFIG_EDU&#39;, if_true: files(=
&#39;edu.c&#39;))<br>+system_ss.add(when: &#39;CONFIG_PCILEECH&#39;, if_tru=
e: files(&#39;pcileech.c&#39;))<br>=C2=A0system_ss.add(when: &#39;CONFIG_FW=
_CFG_DMA&#39;, if_true: files(&#39;vmcoreinfo.c&#39;))<br>=C2=A0system_ss.a=
dd(when: &#39;CONFIG_ISA_DEBUG&#39;, if_true: files(&#39;debugexit.c&#39;))=
<br>=C2=A0system_ss.add(when: &#39;CONFIG_ISA_TESTDEV&#39;, if_true: files(=
&#39;pc-testdev.c&#39;))<br>diff --git a/hw/misc/pcileech.c b/hw/misc/pcile=
ech.c<br>new file mode 100644<br>index 0000000000..252a570161<br>--- /dev/n=
ull<br>+++ b/hw/misc/pcileech.c<br>@@ -0,0 +1,291 @@<br>+/*<br>+ * QEMU Vir=
tual PCILeech Device<br>+ *<br>+ * Copyright (c) 2024 Zero Tang<br>+ *<br>+=
 * Permission is hereby granted, free of charge, to any person obtaining a<=
br>+ * copy of this software and associated documentation files (the &quot;=
Software&quot;),<br>+ * to deal in the Software without restriction, includ=
ing without limitation<br>+ * the rights to use, copy, modify, merge, publi=
sh, distribute, sublicense,<br>+ * and/or sell copies of the Software, and =
to permit persons to whom the<br>+ * Software is furnished to do so, subjec=
t to the following conditions:<br>+ *<br>+ * The above copyright notice and=
 this permission notice shall be included in<br>+ * all copies or substanti=
al portions of the Software.<br>+ *<br>+ * THE SOFTWARE IS PROVIDED &quot;A=
S IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR<br>+ * IMPLIED, INCLUD=
ING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,<br>+ * FITNESS FO=
R A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE<br>+ * AU=
THORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER<br>+ *=
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING<br=
>+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER<br=
>+ * DEALINGS IN THE SOFTWARE.<br>+ */<br>+<br>+#include &quot;qemu/osdep.h=
&quot;<br>+#include &quot;qemu/units.h&quot;<br>+#include &quot;hw/pci/pci.=
h&quot;<br>+#include &quot;hw/hw.h&quot;<br>+#include &quot;hw/pci/msi.h&qu=
ot;<br>+#include &quot;qemu/timer.h&quot;<br>+#include &quot;hw/qdev-proper=
ties.h&quot;<br>+#include &quot;hw/qdev-properties-system.h&quot;<br>+#incl=
ude &quot;qom/object.h&quot;<br>+#include &quot;qemu/main-loop.h&quot; /* i=
othread mutex */<br>+#include &quot;qemu/module.h&quot;<br>+#include &quot;=
qapi/visitor.h&quot;<br>+<br>+#define TYPE_PCILEECH_DEVICE &quot;pcileech&q=
uot;<br>+<br>+struct LeechRequestHeader {<br>+ =C2=A0 =C2=A0uint8_t endiann=
ess; /* 0 - Little, 1 - Big */<br>+ =C2=A0 =C2=A0uint8_t command; =C2=A0 =
=C2=A0/* 0 - Read, 1 - Write */<br>+ =C2=A0 =C2=A0uint8_t reserved[6];<br>+=
 =C2=A0 =C2=A0/* Variable Endianness */<br>+ =C2=A0 =C2=A0uint64_t address;=
<br>+ =C2=A0 =C2=A0uint64_t length;<br>+};<br>+<br>+struct LeechResponseHea=
der {<br>+ =C2=A0 =C2=A0uint8_t endianness; /* 0 - Little, 1 - Big */<br>+ =
=C2=A0 =C2=A0uint8_t reserved[3];<br>+ =C2=A0 =C2=A0MemTxResult result;<br>=
+ =C2=A0 =C2=A0uint64_t length; =C2=A0 =C2=A0/* Indicates length of data fo=
llowed by header */<br>+};<br>+<br>+/* Verify the header length */<br>+stat=
ic_assert(sizeof(struct LeechRequestHeader) =3D=3D 24);<br>+static_assert(s=
izeof(struct LeechResponseHeader) =3D=3D 16);<br>+<br>+struct PciLeechState=
 {<br>+ =C2=A0 =C2=A0/* Internal State */<br>+ =C2=A0 =C2=A0PCIDevice devic=
e;<br>+ =C2=A0 =C2=A0QemuThread thread;<br>+ =C2=A0 =C2=A0QemuMutex mutex;<=
br>+ =C2=A0 =C2=A0bool endianness;<br>+ =C2=A0 =C2=A0bool stopping;<br>+ =
=C2=A0 =C2=A0/* Communication */<br>+ =C2=A0 =C2=A0char *host;<br>+ =C2=A0 =
=C2=A0uint16_t port;<br>+ =C2=A0 =C2=A0int sockfd;<br>+};<br>+<br>+typedef =
struct LeechRequestHeader LeechRequestHeader;<br>+typedef struct PciLeechSt=
ate PciLeechState;<br>+<br>+DECLARE_INSTANCE_CHECKER(PciLeechState, PCILEEC=
H, TYPE_PCILEECH_DEVICE)<br>+<br>+static void pci_leech_process_write_reque=
st(PciLeechState *state,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LeechRequestHeader *request,<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in=
t incoming)<br>+{<br>+ =C2=A0 =C2=A0char buff[1024];<br>+ =C2=A0 =C2=A0for =
(uint64_t i =3D 0; i &lt; request-&gt;length; i +=3D sizeof(buff)) {<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0struct LeechResponseHeader response =3D { 0 };<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0char* response_buffer =3D (char *)&amp;respo=
nse;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0const uint64_t writelen =3D (request-&=
gt;length - i) &lt;=3D sizeof(buff) ?<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (request-&gt;length - i) : sizeof(buff);=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t recvlen =3D 0, sendlen =3D 0;<br>+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (recvlen &lt; writelen) {<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0recvlen +=3D recv(incoming, &amp;buff[recvle=
n], writelen - recvlen, 0);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0response.endianness =3D state-&gt;endianness;<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0response.result =3D pci_dma_write(&amp;state-&gt;de=
vice, request-&gt;address + i,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0buff, writelen);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if=
 (response.result) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&=
quot;PCILeech: Address 0x%lX Write Error! MemTxResult: 0x%X\n&quot;,<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reques=
t-&gt;address + i, response.result);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0response.length =3D 0;<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0while (sendlen &lt; sizeof(struct LeechResponseHeader)) {<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sendlen +=3D send(incoming, &amp;r=
esponse_buffer[sendlen],<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(struct LeechResp=
onseHeader) - sendlen, 0);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =
=C2=A0}<br>+}<br>+<br>+static void pci_leech_process_read_request(PciLeechS=
tate *state,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0LeechRequestHeader *request,<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int incoming)=
<br>+{<br>+ =C2=A0 =C2=A0char buff[1024];<br>+ =C2=A0 =C2=A0for (uint64_t i=
 =3D 0; i &lt; request-&gt;length; i +=3D sizeof(buff)) {<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0struct LeechResponseHeader response =3D { 0 };<br>+ =C2=A0=
 =C2=A0 =C2=A0 =C2=A0char* response_buffer =3D (char *)&amp;response;<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0const uint64_t readlen =3D (request-&gt;length -=
 i) &lt;=3D sizeof(buff) ?<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(request-&gt;length - i) : sizeof(buff);<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ssize_t sendlen =3D 0;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0response.e=
ndianness =3D state-&gt;endianness;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0respons=
e.result =3D pci_dma_read(&amp;state-&gt;device, request-&gt;address + i,<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buff, rea=
dlen);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (response.result) {<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;PCILeech: Address 0x%lX Read=
 Error! MemTxResult: 0x%X\n&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0request-&gt;address + i, response.result)=
;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0respons=
e.length =3D (request-&gt;endianness !=3D state-&gt;endianness) ?<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0bswap64(readlen) : readlen;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0while (sendl=
en &lt; sizeof(struct LeechResponseHeader)) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0sendlen +=3D send(incoming, &amp;response_buffer[sendlen],=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(struct LeechResponseHeader) - sendlen, 0=
);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0sendle=
n =3D 0;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0while (sendlen &lt; readlen) {<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sendlen +=3D send(incoming, &amp=
;buff[sendlen], readlen - sendlen, 0);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br=
>+ =C2=A0 =C2=A0}<br>+}<br>+<br>+static void *pci_leech_worker_thread(void =
*opaque)<br>+{<br>+ =C2=A0 =C2=A0PciLeechState *state =3D PCILEECH(opaque);=
<br>+ =C2=A0 =C2=A0while (1) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0LeechRequest=
Header request;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0char *request_buffer =3D (c=
har *)&amp;request;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t received =3D 0;=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0int incoming;<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0struct sockaddr address;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0socklen_t ad=
drlen;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Check if we are stopping. */<br>+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_mutex_lock(&amp;state-&gt;mutex);<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if (state-&gt;stopping) {<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0qemu_mutex_unlock(&amp;state-&gt;mutex);<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<=
br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_mutex_unlock(&amp;state-&gt;mutex);<br=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Accept PCILeech requests. */<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* Use HTTP1.0-like protocol for simplicity. */<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0incoming =3D accept(state-&gt;sockfd, &amp;addre=
ss, &amp;addrlen);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (incoming &lt; 0) {<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0puts(&quot;WARNING: Failed to =
accept socket for PCILeech! Skipping &quot;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Request...\n&quot;);<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<=
br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Get PCILeech requests. */<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0while (received &lt; sizeof(LeechRequestHeader)) {<br>+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0received +=3D recv(incoming, &amp=
;request_buffer[received],<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(LeechRequestH=
eader) - received, 0);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0/* Swap endianness. */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (re=
quest.endianness !=3D state-&gt;endianness) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0request.address =3D bswap64(request.address);<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0request.length =3D bswap64(request.length=
);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Pro=
cess PCILeech requests. */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_mutex_lock(=
&amp;state-&gt;mutex);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (request.command)=
 {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_leech_process_write_re=
quest(state, &amp;request, incoming);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0} els=
e {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_leech_process_read_re=
quest(state, &amp;request, incoming);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_mutex_unlock(&amp;state-&gt;mutex);<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0close(incoming);<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0=
 =C2=A0return NULL;<br>+}<br>+<br>+static void pci_leech_realize(PCIDevice =
*pdev, Error **errp)<br>+{<br>+ =C2=A0 =C2=A0PciLeechState *state =3D PCILE=
ECH(pdev);<br>+ =C2=A0 =C2=A0struct sockaddr_in sock_addr;<br>+ =C2=A0 =C2=
=A0char host_ip[16];<br>+ =C2=A0 =C2=A0struct hostent *he =3D gethostbyname=
(state-&gt;host);<br>+ =C2=A0 =C2=A0if (he =3D=3D NULL) {<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0puts(&quot;gethostbyname failed!&quot;);<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0exit(EXIT_FAILURE);<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0=
/* Initialize the socket for PCILeech. */<br>+ =C2=A0 =C2=A0state-&gt;sockf=
d =3D socket(AF_INET, SOCK_STREAM, 0);<br>+ =C2=A0 =C2=A0if (state-&gt;sock=
fd &lt; 0) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0puts(&quot;Failed to initializ=
e socket for PCILeech!&quot;);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(EXIT_FA=
ILURE);<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0sock_addr.sin_family =3D AF_I=
NET;<br>+ =C2=A0 =C2=A0sock_addr.sin_addr =3D *(struct in_addr *)he-&gt;h_a=
ddr;<br>+ =C2=A0 =C2=A0sock_addr.sin_port =3D htons(state-&gt;port);<br>+ =
=C2=A0 =C2=A0inet_ntop(AF_INET, &amp;sock_addr.sin_addr, host_ip, sizeof(ho=
st_ip));<br>+ =C2=A0 =C2=A0if (bind(state-&gt;sockfd, (struct sockaddr *)&a=
mp;sock_addr, sizeof(sock_addr))<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt; 0) {<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0puts(&quot;Failed to bind socket for PCILeech!&quot=
;);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0close(state-&gt;sockfd);<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0exit(EXIT_FAILURE);<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=
=A0if (listen(state-&gt;sockfd, 10) &lt; 0) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0puts(&quot;Failed to listen to socket for PCILeech!&quot;);<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0close(state-&gt;sockfd);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0exit(EXIT_FAILURE);<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0printf(&quot;I=
NFO: PCILeech is listening on %s:%u...\n&quot;, host_ip, state-&gt;port);<b=
r>+ =C2=A0 =C2=A0/* Initialize the thread for PCILeech. */<br>+ =C2=A0 =C2=
=A0qemu_mutex_init(&amp;state-&gt;mutex);<br>+ =C2=A0 =C2=A0qemu_thread_cre=
ate(&amp;state-&gt;thread, &quot;pcileech&quot;, pci_leech_worker_thread,<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0state, QEMU_THREAD_JOINABLE);<br>+}<br>+<br>+static void pci_leec=
h_finalize(PCIDevice *pdev)<br>+{<br>+ =C2=A0 =C2=A0PciLeechState *state =
=3D PCILEECH(pdev);<br>+ =C2=A0 =C2=A0puts(&quot;Stopping PCILeech Worker..=
.&quot;);<br>+ =C2=A0 =C2=A0qemu_mutex_lock(&amp;state-&gt;mutex);<br>+ =C2=
=A0 =C2=A0state-&gt;stopping =3D true;<br>+ =C2=A0 =C2=A0qemu_mutex_unlock(=
&amp;state-&gt;mutex);<br>+ =C2=A0 =C2=A0close(state-&gt;sockfd);<br>+ =C2=
=A0 =C2=A0qemu_thread_join(&amp;state-&gt;thread);<br>+ =C2=A0 =C2=A0qemu_m=
utex_destroy(&amp;state-&gt;mutex);<br>+}<br>+<br>+char pci_leech_default_h=
ost[] =3D &quot;0.0.0.0&quot;;<br>+<br>+static void pci_leech_instance_init=
(Object *obj)<br>+{<br>+ =C2=A0 =C2=A0int x =3D 1;<br>+ =C2=A0 =C2=A0char* =
y =3D (char *)&amp;x;<br>+ =C2=A0 =C2=A0PciLeechState *state =3D PCILEECH(o=
bj);<br>+ =C2=A0 =C2=A0/* QEMU&#39;s String-Property can&#39;t specify defa=
ult value. */<br>+ =C2=A0 =C2=A0/* So we have to set the default on our own=
. */<br>+ =C2=A0 =C2=A0if (state-&gt;host =3D=3D NULL) {<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0state-&gt;host =3D pci_leech_default_host;<br>+ =C2=A0 =C2=A0=
}<br>+ =C2=A0 =C2=A0/* Save Our Endianness. */<br>+ =C2=A0 =C2=A0state-&gt;=
endianness =3D (*y =3D=3D 0);<br>+}<br>+<br>+static Property leech_properti=
es[] =3D {<br>+ =C2=A0 =C2=A0DEFINE_PROP_UINT16(&quot;port&quot;, PciLeechS=
tate, port, 6789),<br>+ =C2=A0 =C2=A0DEFINE_PROP_STRING(&quot;host&quot;, P=
ciLeechState, host),<br>+ =C2=A0 =C2=A0DEFINE_PROP_END_OF_LIST(),<br>+};<br=
>+<br>+static void pci_leech_class_init(ObjectClass *class, void *data)<br>=
+{<br>+ =C2=A0 =C2=A0DeviceClass *dc =3D DEVICE_CLASS(class);<br>+ =C2=A0 =
=C2=A0PCIDeviceClass *k =3D PCI_DEVICE_CLASS(class);<br>+ =C2=A0 =C2=A0k-&g=
t;realize =3D pci_leech_realize;<br>+ =C2=A0 =C2=A0k-&gt;exit =3D pci_leech=
_finalize;<br>+ =C2=A0 =C2=A0/* Change the Vendor/Device ID to your favor. =
*/<br>+ =C2=A0 =C2=A0/* These are the default values from PCILeech-FPGA. */=
<br>+ =C2=A0 =C2=A0k-&gt;vendor_id =3D PCI_VENDOR_ID_XILINX;<br>+ =C2=A0 =
=C2=A0k-&gt;device_id =3D 0x0666;<br>+ =C2=A0 =C2=A0k-&gt;revision =3D 0;<b=
r>+ =C2=A0 =C2=A0k-&gt;class_id =3D PCI_CLASS_NETWORK_ETHERNET;<br>+ =C2=A0=
 =C2=A0device_class_set_props(dc, leech_properties);<br>+ =C2=A0 =C2=A0set_=
bit(DEVICE_CATEGORY_MISC, dc-&gt;categories);<br>+}<br>+<br>+static void pc=
i_leech_register_types(void)<br>+{<br>+ =C2=A0 =C2=A0static InterfaceInfo i=
nterfaces[] =3D {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{INTERFACE_CONVENTIONAL_P=
CI_DEVICE},<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{},<br>+ =C2=A0 =C2=A0};<br>+ =
=C2=A0 =C2=A0static const TypeInfo leech_info =3D {<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.name =3D TYPE_PCILEECH_DEVICE,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.=
parent =3D TYPE_PCI_DEVICE,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.instance_size =
=3D sizeof(PciLeechState),<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.instance_init =
=3D pci_leech_instance_init,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.class_init =
=3D pci_leech_class_init,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.interfaces =3D i=
nterfaces,<br>+ =C2=A0 =C2=A0};<br>+ =C2=A0 =C2=A0type_register_static(&amp=
;leech_info);<br>+}<br>+<br>+type_init(pci_leech_register_types)</font><br>=
</div>
</blockquote></div>

--000000000000f2c454061fe46e9c--

