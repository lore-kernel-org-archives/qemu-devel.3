Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94E6C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 00:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjpBn-0006bD-1l; Thu, 29 Aug 2024 20:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zero.tangptr@gmail.com>)
 id 1sjpBk-0006S9-Rv
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 20:08:29 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zero.tangptr@gmail.com>)
 id 1sjpBg-0006rq-9P
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 20:08:28 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5bf006f37daso2127057a12.1
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 17:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724976501; x=1725581301; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GXylkMEp7WVc/G1uIFGH16RmKCtqHyJuDCuQ/vkrBy8=;
 b=kiVEeiPV1sVQUwjN3xBxePLIeiKmoZzXinilM1txdkDMSz/kIETkUdfHQxnybGvgkh
 7HZ2GzsiFv5ymGZ5YFjBn2UtWafzLZHSwhqfcNS8VxOeqPl+c/i1VrJ3CtSAaNYNZmCp
 sNnhAlTovU9M/FU3NYk87S1uZvTsZb2itMF/qVobLJIdbmHwpo/mtvsFAAxRzMOMc/Zu
 9xiGrO2/vZ8TBCBEv2CzPDBr5ujmJCrWVyE/NMdcoUhIysNdZqFhyiQwWXaN5dih/q6C
 EFn+xmCQdhpuDYly52bvHVL5HVX2+85JUVPEeXJFV5rJGD4RcHrmUzmZw++129qupeWy
 uicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724976501; x=1725581301;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GXylkMEp7WVc/G1uIFGH16RmKCtqHyJuDCuQ/vkrBy8=;
 b=DhfI/CPgxCKI4ffPLqM1+S9MGhQe3d+u8nd6n9mEM//hg6C4AX8FBBLrhH+7XTtODW
 k7xHDzjbbPqLJCjmkwesMFNBF4PXZZmDdBJowEhrU2I4jRdNpvVPafT5yQG1elIM7jr9
 s4fnQ8URwkUB1Oa7QpolzbSTf1qC6mLp+J7FDr4sMs4ZtXu0O/PhKe/cuo2v64ScKPxk
 B3wmof+YyGY3op+8+FQ9F67aG1sUlVelOxJ3rQrnO9s3EI9xtu5kbT+du9uhzI+U0RU+
 yByqOvTHsmv77urI05+rrYQslfqExqok034hMxfwq30W86jbf99hniEPKjWSddp9ne2C
 hRig==
X-Gm-Message-State: AOJu0YyoU+eISLOpsdsNHnTb/XIHOVkYbXz5nqQ0FGdWv6C6JDx9uCIy
 RUTkKdVaPaOJVezPBedx2JxXFkxfClk6i2VsS632ffUCVpOMVqVTAUIlo2b/wbUul4cq0UUOaSG
 Sg9rxRa2e8CI4JW6qR3PeQ+8zX2E=
X-Google-Smtp-Source: AGHT+IEXd4y8nsebum6ay2NyQAA+VRp/mdj17s60CWk186nkSi+i7wcc6M/t0+/GnhF1XKmh0aTvdtQiMAreeci3+zs=
X-Received: by 2002:a05:6402:5186:b0:5c2:1014:295a with SMTP id
 4fb4d7f45d1cf-5c2200de37dmr3789738a12.2.1724976500397; Thu, 29 Aug 2024
 17:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAAXNugBYhpx249dUWgyXOtGjkxWatRHJSq94LrVFMGP_GjX7aA@mail.gmail.com>
 <CAFEAcA9wFOX+gcaVDmBo2j3Zhd5fUj+3c9MCX=Q7zsXqVjOeXQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9wFOX+gcaVDmBo2j3Zhd5fUj+3c9MCX=Q7zsXqVjOeXQ@mail.gmail.com>
From: Zero Tang <zero.tangptr@gmail.com>
Date: Fri, 30 Aug 2024 08:08:05 +0800
Message-ID: <CAAXNugCzo0fWVcELNYN5D=DztzcX9Ng1qfkGbQb1KeEOKn2S_g@mail.gmail.com>
Subject: Re: [PATCH] hw/misc: Add a virtual PCILeech device
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, mst@redhat.com, marcel.apfelbaum@gmail.com
Content-Type: multipart/alternative; boundary="0000000000008d5eda0620db6392"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=zero.tangptr@gmail.com; helo=mail-ed1-x52d.google.com
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

--0000000000008d5eda0620db6392
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your comments, and let me answer the top-level questions first.

Firstly, how useful is this to QEMU users in general?
> It seems very specific.
>
> Secondly, there's no documentation here that explains
> what it is, why users might care about it, or how to use it.
>
> Thirdly, it looks like it's basically a doorway that some
> external system uses to tell it to do arbitrary DMA
> reads or writes. There's no documentation of what the
> protocol is that it's using.
>

This is indeed a device with very specific usages. It is trying to
emulate "PCILeech" cards (https://github.com/ufrisk/pcileech-fpga).
The function of such cards is using DMA to attack the machine.

On real machines, these cards have a port (e.g.: USB3.0) which
will transfer memory contents on arbitrary addresses through DMA.
So, you're right that "it's basically a doorway that some external
system use to tell it to do arbitrary DMA reads or writes."

Regarding documentation, I admit I didn't explain it well in the patch.
But I have explained how to use this device on PCILeech:
https://github.com/ufrisk/LeechCore-plugins/blob/master/README.md#leechcore=
_device_qemupcileech

The compiled PCILeech program binaries can be found in:
https://github.com/ufrisk/pcileech/releases/tag/v4.18
The compiled QEMU-PCILeech plugin binaries can be found in:
https://github.com/ufrisk/LeechCore/releases/tag/v2.18

In summary, I believe this device will enable security researchers
and etc. to use DMA attacks and IOMMU defenses more easily with
QEMU at zero cost.

If you have further comments and/or questions please let me know.

Thanks,
Zero Tang

On Thu, Aug 29, 2024 at 8:13=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Tue, 6 Aug 2024 at 10:28, Zero Tang <zero.tangptr@gmail.com> wrote:
> >
> > This virtual PCILeech device aims to help security researchers attack
> the guest via DMA and test their IOMMU defenses.
> > This device is intended to support any systems with PCI, but I am only
> able to test x86-based guests.
> > For what PCILeech is, check PCILeech GitHub repository:
> https://github.com/ufrisk/pcileech
> > The QEMU-PCILeech plugin is currently awaiting merging:
> https://github.com/ufrisk/LeechCore-plugins/pull/10
> >
> > This is my first time contributing to QEMU and I am sorry that I forgot
> to include a "[PATCH]" prefix in the title from my previous email and tha=
t
> I didn't cc to relevant maintainers.
> > If needed, add my name and contact info into the maintainer's list.
>
> Since nobody else has responded yet, I guess I'll make
> some initial general remarks.
>
> Firstly, how useful is this to QEMU users in general?
> It seems very specific.
>
> Secondly, there's no documentation here that explains
> what it is, why users might care about it, or how to use it.
>
> Thirdly, it looks like it's basically a doorway that some
> external system uses to tell it to do arbitrary DMA
> reads or writes. There's no documentation of what the
> protocol is that it's using.
>
> I have some more specific comments below, but overall I'm not
> yet sure that this is worth QEMU upstream having a model of.
> So I think it's probably better if we sort out the top
> level question of "what's the benefit to QEMU of us taking
> on this device" before you spend much time on the code
> part of it.
>
> > +#define TYPE_PCILEECH_DEVICE "pcileech"
> > +
> > +struct LeechRequestHeader {
> > +    uint8_t endianness; /* 0 - Little, 1 - Big */
> > +    uint8_t command;    /* 0 - Read, 1 - Write */
> > +    uint8_t reserved[6];
> > +    /* Variable Endianness */
> > +    uint64_t address;
> > +    uint64_t length;
>
> Why not just specify the protocol endianness (eg
> "always little endian")?
>
> > +};
> > +
> > +struct LeechResponseHeader {
> > +    uint8_t endianness; /* 0 - Little, 1 - Big */
> > +    uint8_t reserved[3];
> > +    MemTxResult result;
>
> MemTxResult is a QEMU-internal enum, which we might change
> the values or size or definition of. It shouldn't appear
> in an external protocol packet.
>
> > +    uint64_t length;    /* Indicates length of data followed by header
> */
> > +};
> > +
> > +/* Verify the header length */
> > +static_assert(sizeof(struct LeechRequestHeader) =3D=3D 24);
> > +static_assert(sizeof(struct LeechResponseHeader) =3D=3D 16);
>
> Use QEMU_BUILD_BUG_ON().
>
> > +struct PciLeechState {
> > +    /* Internal State */
> > +    PCIDevice device;
> > +    QemuThread thread;
> > +    QemuMutex mutex;
> > +    bool endianness;
> > +    bool stopping;
> > +    /* Communication */
> > +    char *host;
> > +    uint16_t port;
> > +    int sockfd;
> > +};
> > +
> > +typedef struct LeechRequestHeader LeechRequestHeader;
> > +typedef struct PciLeechState PciLeechState;
> > +
> > +DECLARE_INSTANCE_CHECKER(PciLeechState, PCILEECH, TYPE_PCILEECH_DEVICE=
)
> > +
> > +static void pci_leech_process_write_request(PciLeechState *state,
> > +                                            LeechRequestHeader *reques=
t,
> > +                                            int incoming)
> > +{
> > +    char buff[1024];
> > +    for (uint64_t i =3D 0; i < request->length; i +=3D sizeof(buff)) {
> > +        struct LeechResponseHeader response =3D { 0 };
> > +        char* response_buffer =3D (char *)&response;
> > +        const uint64_t writelen =3D (request->length - i) <=3D sizeof(=
buff)
> ?
> > +                                         (request->length - i) :
> sizeof(buff);
> > +        ssize_t recvlen =3D 0, sendlen =3D 0;
> > +        while (recvlen < writelen) {
> > +            recvlen +=3D recv(incoming, &buff[recvlen], writelen -
> recvlen, 0);
> > +        }
> > +        response.endianness =3D state->endianness;
> > +        response.result =3D pci_dma_write(&state->device,
> request->address + i,
> > +                                                            buff,
> writelen);
> > +        if (response.result) {
> > +            printf("PCILeech: Address 0x%lX Write Error! MemTxResult:
> 0x%X\n",
> > +                    request->address + i, response.result);
> > +        }
> > +        response.length =3D 0;
> > +        while (sendlen < sizeof(struct LeechResponseHeader)) {
> > +            sendlen +=3D send(incoming, &response_buffer[sendlen],
> > +                            sizeof(struct LeechResponseHeader) -
> sendlen, 0);
> > +        }
> > +    }
> > +}
> > +
> > +static void pci_leech_process_read_request(PciLeechState *state,
> > +                                            LeechRequestHeader *reques=
t,
> > +                                            int incoming)
> > +{
> > +    char buff[1024];
> > +    for (uint64_t i =3D 0; i < request->length; i +=3D sizeof(buff)) {
> > +        struct LeechResponseHeader response =3D { 0 };
> > +        char* response_buffer =3D (char *)&response;
> > +        const uint64_t readlen =3D (request->length - i) <=3D sizeof(b=
uff) ?
> > +                                    (request->length - i) :
> sizeof(buff);
> > +        ssize_t sendlen =3D 0;
> > +        response.endianness =3D state->endianness;
> > +        response.result =3D pci_dma_read(&state->device, request->addr=
ess
> + i,
> > +                                                            buff,
> readlen);
> > +        if (response.result) {
> > +            printf("PCILeech: Address 0x%lX Read Error! MemTxResult:
> 0x%X\n",
> > +                    request->address + i, response.result);
> > +        }
> > +        response.length =3D (request->endianness !=3D state->endiannes=
s) ?
> > +                                            bswap64(readlen) : readlen=
;
> > +        while (sendlen < sizeof(struct LeechResponseHeader)) {
> > +            sendlen +=3D send(incoming, &response_buffer[sendlen],
> > +                            sizeof(struct LeechResponseHeader) -
> sendlen, 0);
> > +        }
> > +        sendlen =3D 0;
> > +        while (sendlen < readlen) {
> > +            sendlen +=3D send(incoming, &buff[sendlen], readlen -
> sendlen, 0);
> > +        }
> > +    }
> > +}
> > +
> > +static void *pci_leech_worker_thread(void *opaque)
> > +{
> > +    PciLeechState *state =3D PCILEECH(opaque);
> > +    while (1) {
> > +        LeechRequestHeader request;
> > +        char *request_buffer =3D (char *)&request;
> > +        ssize_t received =3D 0;
> > +        int incoming;
> > +        struct sockaddr address;
> > +        socklen_t addrlen;
> > +        /* Check if we are stopping. */
> > +        qemu_mutex_lock(&state->mutex);
> > +        if (state->stopping) {
> > +            qemu_mutex_unlock(&state->mutex);
> > +            break;
> > +        }
> > +        qemu_mutex_unlock(&state->mutex);
> > +        /* Accept PCILeech requests. */
> > +        /* Use HTTP1.0-like protocol for simplicity. */
>
> This comment doesn't seem to match what the code thinks
> the protocol looks like.
>
> > +        incoming =3D accept(state->sockfd, &address, &addrlen);
> > +        if (incoming < 0) {
> > +            puts("WARNING: Failed to accept socket for PCILeech!
> Skipping "
> > +                 "Request...\n");
> > +            continue;
> > +        }
> > +        /* Get PCILeech requests. */
> > +        while (received < sizeof(LeechRequestHeader)) {
> > +            received +=3D recv(incoming, &request_buffer[received],
> > +                            sizeof(LeechRequestHeader) - received, 0);
> > +        }
> > +        /* Swap endianness. */
> > +        if (request.endianness !=3D state->endianness) {
> > +            request.address =3D bswap64(request.address);
> > +            request.length =3D bswap64(request.length);
> > +        }
> > +        /* Process PCILeech requests. */
> > +        qemu_mutex_lock(&state->mutex);
> > +        if (request.command) {
> > +            pci_leech_process_write_request(state, &request, incoming)=
;
> > +        } else {
> > +            pci_leech_process_read_request(state, &request, incoming);
> > +        }
> > +        qemu_mutex_unlock(&state->mutex);
> > +        close(incoming);
> > +    }
> > +    return NULL;
> > +}
> > +
> > +static void pci_leech_realize(PCIDevice *pdev, Error **errp)
> > +{
> > +    PciLeechState *state =3D PCILEECH(pdev);
> > +    struct sockaddr_in sock_addr;
> > +    char host_ip[16];
> > +    struct hostent *he =3D gethostbyname(state->host);
> > +    if (he =3D=3D NULL) {
> > +        puts("gethostbyname failed!");
> > +        exit(EXIT_FAILURE);
> > +    }
> > +    /* Initialize the socket for PCILeech. */
> > +    state->sockfd =3D socket(AF_INET, SOCK_STREAM, 0);
> > +    if (state->sockfd < 0) {
> > +        puts("Failed to initialize socket for PCILeech!");
> > +        exit(EXIT_FAILURE);
> > +    }
> > +    sock_addr.sin_family =3D AF_INET;
> > +    sock_addr.sin_addr =3D *(struct in_addr *)he->h_addr;
> > +    sock_addr.sin_port =3D htons(state->port);
> > +    inet_ntop(AF_INET, &sock_addr.sin_addr, host_ip, sizeof(host_ip));
> > +    if (bind(state->sockfd, (struct sockaddr *)&sock_addr,
> sizeof(sock_addr))
> > +                                                                    <
> 0) {
> > +        puts("Failed to bind socket for PCILeech!");
> > +        close(state->sockfd);
> > +        exit(EXIT_FAILURE);
> > +    }
> > +    if (listen(state->sockfd, 10) < 0) {
> > +        puts("Failed to listen to socket for PCILeech!");
> > +        close(state->sockfd);
> > +        exit(EXIT_FAILURE);
> > +    }
>
> Don't roll your own "user specifies a host/port and
> we create a socket" code. Instead have the device take
> a QEMU chardev backend. Then the user can create the
> chardev, which might be "listens on a socket" or
> "uses a file descriptor" or any of the other chardev backends.
>
> This also will let you drop the complexity of manually
> creating an extra thread, because the chardev API
> integrates into QEMU's existing iothread/main loop
> infrastructure and will call you back when it has data
> for you.
>
> > +    printf("INFO: PCILeech is listening on %s:%u...\n", host_ip,
> state->port);
> > +    /* Initialize the thread for PCILeech. */
> > +    qemu_mutex_init(&state->mutex);
> > +    qemu_thread_create(&state->thread, "pcileech",
> pci_leech_worker_thread,
> > +                                            state,
> QEMU_THREAD_JOINABLE);
> > +}
> > +
> > +static void pci_leech_finalize(PCIDevice *pdev)
> > +{
> > +    PciLeechState *state =3D PCILEECH(pdev);
> > +    puts("Stopping PCILeech Worker...");
> > +    qemu_mutex_lock(&state->mutex);
> > +    state->stopping =3D true;
> > +    qemu_mutex_unlock(&state->mutex);
> > +    close(state->sockfd);
> > +    qemu_thread_join(&state->thread);
> > +    qemu_mutex_destroy(&state->mutex);
> > +}
> > +
> > +char pci_leech_default_host[] =3D "0.0.0.0";
> > +
> > +static void pci_leech_instance_init(Object *obj)
> > +{
> > +    int x =3D 1;
> > +    char* y =3D (char *)&x;
> > +    PciLeechState *state =3D PCILEECH(obj);
> > +    /* QEMU's String-Property can't specify default value. */
> > +    /* So we have to set the default on our own. */
> > +    if (state->host =3D=3D NULL) {
> > +        state->host =3D pci_leech_default_host;
> > +    }
> > +    /* Save Our Endianness. */
> > +    state->endianness =3D (*y =3D=3D 0);
>
> Don't try to roll your own host endianness detection.
> Instead use the functions like ldl_le_p() (load little
> endian value from pointer) or le32_to_cpu() and
> cpu_to_le32() (convert little endian to and from host
> order) to convert between what the protocol expects and
> the CPU representation.
>
> > +}
> > +
> > +static Property leech_properties[] =3D {
> > +    DEFINE_PROP_UINT16("port", PciLeechState, port, 6789),
> > +    DEFINE_PROP_STRING("host", PciLeechState, host),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void pci_leech_class_init(ObjectClass *class, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(class);
> > +    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(class);
> > +    k->realize =3D pci_leech_realize;
> > +    k->exit =3D pci_leech_finalize;
> > +    /* Change the Vendor/Device ID to your favor. */
> > +    /* These are the default values from PCILeech-FPGA. */
> > +    k->vendor_id =3D PCI_VENDOR_ID_XILINX;
> > +    k->device_id =3D 0x0666;
> > +    k->revision =3D 0;
> > +    k->class_id =3D PCI_CLASS_NETWORK_ETHERNET;
> > +    device_class_set_props(dc, leech_properties);
> > +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> > +}
> > +
> > +static void pci_leech_register_types(void)
> > +{
> > +    static InterfaceInfo interfaces[] =3D {
> > +        {INTERFACE_CONVENTIONAL_PCI_DEVICE},
> > +        {},
> > +    };
> > +    static const TypeInfo leech_info =3D {
> > +        .name =3D TYPE_PCILEECH_DEVICE,
> > +        .parent =3D TYPE_PCI_DEVICE,
> > +        .instance_size =3D sizeof(PciLeechState),
> > +        .instance_init =3D pci_leech_instance_init,
> > +        .class_init =3D pci_leech_class_init,
> > +        .interfaces =3D interfaces,
> > +    };
> > +    type_register_static(&leech_info);
> > +}
> > +
> > +type_init(pci_leech_register_types)
>
> thanks
> -- PMM
>

--0000000000008d5eda0620db6392
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for your comments, and let me answer the top-level =
questions first.<div><br><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
Firstly, how useful is this to QEMU users in general?<br>It seems very spec=
ific.<br><br>Secondly, there&#39;s no documentation here that explains<br>w=
hat it is, why users might care about it, or how to use it.<br><br>Thirdly,=
 it looks like it&#39;s basically a doorway that some<br>external system us=
es to tell it to do arbitrary DMA<br>reads or writes. There&#39;s no docume=
ntation of what the<br>protocol is that it&#39;s using.<br></blockquote><di=
v><br></div><div>This is indeed a device with very specific usages. It is t=
rying to=C2=A0</div><div>emulate &quot;PCILeech&quot; cards (<a href=3D"htt=
ps://github.com/ufrisk/pcileech-fpga" target=3D"_blank">https://github.com/=
ufrisk/pcileech-fpga</a>).</div></div><div>The function of such cards is us=
ing DMA to attack the machine.</div><div><br></div><div>On real machines, t=
hese cards have a port (e.g.: USB3.0) which=C2=A0</div><div>will transfer m=
emory contents on arbitrary addresses through DMA.</div><div>So, you&#39;re=
 right that &quot;it&#39;s basically a doorway that some external=C2=A0</di=
v><div>system use=C2=A0to tell it to do arbitrary DMA reads or writes.&quot=
;</div><div></div><div><br></div><div>Regarding documentation, I admit I di=
dn&#39;t explain it well in the patch.</div><div>But I have explained how t=
o use this device on PCILeech:</div><div><a href=3D"https://github.com/ufri=
sk/LeechCore-plugins/blob/master/README.md#leechcore_device_qemupcileech" t=
arget=3D"_blank">https://github.com/ufrisk/LeechCore-plugins/blob/master/RE=
ADME.md#leechcore_device_qemupcileech</a><br></div><div><br></div><div>The =
compiled PCILeech program binaries can be found in:</div><div><a href=3D"ht=
tps://github.com/ufrisk/pcileech/releases/tag/v4.18" target=3D"_blank">http=
s://github.com/ufrisk/pcileech/releases/tag/v4.18</a><br></div><div>The com=
piled QEMU-PCILeech plugin binaries can be found in:</div><div><a href=3D"h=
ttps://github.com/ufrisk/LeechCore/releases/tag/v2.18" target=3D"_blank">ht=
tps://github.com/ufrisk/LeechCore/releases/tag/v2.18</a></div><div><br></di=
v><div>In summary, I believe this device will enable security researchers=
=C2=A0</div><div>and etc. to use DMA attacks and IOMMU defenses more easily=
 with=C2=A0</div><div>QEMU at zero cost.</div><div><br></div><div>If you ha=
ve further comments and/or questions please let me know.</div><div><br></di=
v><div>Thanks,</div><div>Zero Tang</div></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 29, 2024 at 8:13=E2=80=
=AFPM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=
=3D"_blank">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On Tue, 6 Aug 2024 at 10:28, Zero Tang =
&lt;<a href=3D"mailto:zero.tangptr@gmail.com" target=3D"_blank">zero.tangpt=
r@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; This virtual PCILeech device aims to help security researchers attack =
the guest via DMA and test their IOMMU defenses.<br>
&gt; This device is intended to support any systems with PCI, but I am only=
 able to test x86-based guests.<br>
&gt; For what PCILeech is, check PCILeech GitHub repository: <a href=3D"htt=
ps://github.com/ufrisk/pcileech" rel=3D"noreferrer" target=3D"_blank">https=
://github.com/ufrisk/pcileech</a><br>
&gt; The QEMU-PCILeech plugin is currently awaiting merging: <a href=3D"htt=
ps://github.com/ufrisk/LeechCore-plugins/pull/10" rel=3D"noreferrer" target=
=3D"_blank">https://github.com/ufrisk/LeechCore-plugins/pull/10</a><br>
&gt;<br>
&gt; This is my first time contributing to QEMU and I am sorry that I forgo=
t to include a &quot;[PATCH]&quot; prefix in the title from my previous ema=
il and that I didn&#39;t cc to relevant maintainers.<br>
&gt; If needed, add my name and contact info into the maintainer&#39;s list=
.<br>
<br>
Since nobody else has responded yet, I guess I&#39;ll make<br>
some initial general remarks.<br>
<br>
Firstly, how useful is this to QEMU users in general?<br>
It seems very specific.<br>
<br>
Secondly, there&#39;s no documentation here that explains<br>
what it is, why users might care about it, or how to use it.<br>
<br>
Thirdly, it looks like it&#39;s basically a doorway that some<br>
external system uses to tell it to do arbitrary DMA<br>
reads or writes. There&#39;s no documentation of what the<br>
protocol is that it&#39;s using.<br>
<br>
I have some more specific comments below, but overall I&#39;m not<br>
yet sure that this is worth QEMU upstream having a model of.<br>
So I think it&#39;s probably better if we sort out the top<br>
level question of &quot;what&#39;s the benefit to QEMU of us taking<br>
on this device&quot; before you spend much time on the code<br>
part of it.<br>
<br>
&gt; +#define TYPE_PCILEECH_DEVICE &quot;pcileech&quot;<br>
&gt; +<br>
&gt; +struct LeechRequestHeader {<br>
&gt; +=C2=A0 =C2=A0 uint8_t endianness; /* 0 - Little, 1 - Big */<br>
&gt; +=C2=A0 =C2=A0 uint8_t command;=C2=A0 =C2=A0 /* 0 - Read, 1 - Write */=
<br>
&gt; +=C2=A0 =C2=A0 uint8_t reserved[6];<br>
&gt; +=C2=A0 =C2=A0 /* Variable Endianness */<br>
&gt; +=C2=A0 =C2=A0 uint64_t address;<br>
&gt; +=C2=A0 =C2=A0 uint64_t length;<br>
<br>
Why not just specify the protocol endianness (eg<br>
&quot;always little endian&quot;)?<br>
<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct LeechResponseHeader {<br>
&gt; +=C2=A0 =C2=A0 uint8_t endianness; /* 0 - Little, 1 - Big */<br>
&gt; +=C2=A0 =C2=A0 uint8_t reserved[3];<br>
&gt; +=C2=A0 =C2=A0 MemTxResult result;<br>
<br>
MemTxResult is a QEMU-internal enum, which we might change<br>
the values or size or definition of. It shouldn&#39;t appear<br>
in an external protocol packet.<br>
<br>
&gt; +=C2=A0 =C2=A0 uint64_t length;=C2=A0 =C2=A0 /* Indicates length of da=
ta followed by header */<br>
&gt; +};<br>
&gt; +<br>
&gt; +/* Verify the header length */<br>
&gt; +static_assert(sizeof(struct LeechRequestHeader) =3D=3D 24);<br>
&gt; +static_assert(sizeof(struct LeechResponseHeader) =3D=3D 16);<br>
<br>
Use QEMU_BUILD_BUG_ON().<br>
<br>
&gt; +struct PciLeechState {<br>
&gt; +=C2=A0 =C2=A0 /* Internal State */<br>
&gt; +=C2=A0 =C2=A0 PCIDevice device;<br>
&gt; +=C2=A0 =C2=A0 QemuThread thread;<br>
&gt; +=C2=A0 =C2=A0 QemuMutex mutex;<br>
&gt; +=C2=A0 =C2=A0 bool endianness;<br>
&gt; +=C2=A0 =C2=A0 bool stopping;<br>
&gt; +=C2=A0 =C2=A0 /* Communication */<br>
&gt; +=C2=A0 =C2=A0 char *host;<br>
&gt; +=C2=A0 =C2=A0 uint16_t port;<br>
&gt; +=C2=A0 =C2=A0 int sockfd;<br>
&gt; +};<br>
&gt; +<br>
&gt; +typedef struct LeechRequestHeader LeechRequestHeader;<br>
&gt; +typedef struct PciLeechState PciLeechState;<br>
&gt; +<br>
&gt; +DECLARE_INSTANCE_CHECKER(PciLeechState, PCILEECH, TYPE_PCILEECH_DEVIC=
E)<br>
&gt; +<br>
&gt; +static void pci_leech_process_write_request(PciLeechState *state,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 LeechRequestHeader *request,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 int incoming)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 char buff[1024];<br>
&gt; +=C2=A0 =C2=A0 for (uint64_t i =3D 0; i &lt; request-&gt;length; i +=
=3D sizeof(buff)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct LeechResponseHeader response =3D {=
 0 };<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 char* response_buffer =3D (char *)&amp;re=
sponse;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const uint64_t writelen =3D (request-&gt;=
length - i) &lt;=3D sizeof(buff) ?<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(request-&gt;length - i) : sizeof(buff);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ssize_t recvlen =3D 0, sendlen =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (recvlen &lt; writelen) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 recvlen +=3D recv(incoming,=
 &amp;buff[recvlen], writelen - recvlen, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 response.endianness =3D state-&gt;endiann=
ess;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 response.result =3D pci_dma_write(&amp;st=
ate-&gt;device, request-&gt;address + i,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buff, wr=
itelen);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (response.result) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;PCILeech: Addr=
ess 0x%lX Write Error! MemTxResult: 0x%X\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 request-&gt;address + i, response.result);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 response.length =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (sendlen &lt; sizeof(struct LeechRe=
sponseHeader)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sendlen +=3D send(incoming,=
 &amp;response_buffer[sendlen],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(struct LeechResponseHeader) - sendlen, =
0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void pci_leech_process_read_request(PciLeechState *state,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 LeechRequestHeader *request,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 int incoming)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 char buff[1024];<br>
&gt; +=C2=A0 =C2=A0 for (uint64_t i =3D 0; i &lt; request-&gt;length; i +=
=3D sizeof(buff)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct LeechResponseHeader response =3D {=
 0 };<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 char* response_buffer =3D (char *)&amp;re=
sponse;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const uint64_t readlen =3D (request-&gt;l=
ength - i) &lt;=3D sizeof(buff) ?<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (request-&gt;lengt=
h - i) : sizeof(buff);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ssize_t sendlen =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 response.endianness =3D state-&gt;endiann=
ess;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 response.result =3D pci_dma_read(&amp;sta=
te-&gt;device, request-&gt;address + i,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buff, re=
adlen);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (response.result) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;PCILeech: Addr=
ess 0x%lX Read Error! MemTxResult: 0x%X\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 request-&gt;address + i, response.result);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 response.length =3D (request-&gt;endianne=
ss !=3D state-&gt;endianness) ?<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 bswap64(readlen) : readlen;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (sendlen &lt; sizeof(struct LeechRe=
sponseHeader)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sendlen +=3D send(incoming,=
 &amp;response_buffer[sendlen],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(struct LeechResponseHeader) - sendlen, =
0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sendlen =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (sendlen &lt; readlen) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sendlen +=3D send(incoming,=
 &amp;buff[sendlen], readlen - sendlen, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void *pci_leech_worker_thread(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 PciLeechState *state =3D PCILEECH(opaque);<br>
&gt; +=C2=A0 =C2=A0 while (1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LeechRequestHeader request;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *request_buffer =3D (char *)&amp;req=
uest;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ssize_t received =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int incoming;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct sockaddr address;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 socklen_t addrlen;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check if we are stopping. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_mutex_lock(&amp;state-&gt;mutex);<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (state-&gt;stopping) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_mutex_unlock(&amp;stat=
e-&gt;mutex);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_mutex_unlock(&amp;state-&gt;mutex);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Accept PCILeech requests. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Use HTTP1.0-like protocol for simplici=
ty. */<br>
<br>
This comment doesn&#39;t seem to match what the code thinks<br>
the protocol looks like.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 incoming =3D accept(state-&gt;sockfd, &am=
p;address, &amp;addrlen);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (incoming &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 puts(&quot;WARNING: Failed =
to accept socket for PCILeech! Skipping &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;R=
equest...\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Get PCILeech requests. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (received &lt; sizeof(LeechRequestH=
eader)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 received +=3D recv(incoming=
, &amp;request_buffer[received],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(LeechRequestHeader) - received, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Swap endianness. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (request.endianness !=3D state-&gt;end=
ianness) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 request.address =3D bswap64=
(request.address);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 request.length =3D bswap64(=
request.length);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Process PCILeech requests. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_mutex_lock(&amp;state-&gt;mutex);<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (request.command) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_leech_process_write_req=
uest(state, &amp;request, incoming);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_leech_process_read_requ=
est(state, &amp;request, incoming);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_mutex_unlock(&amp;state-&gt;mutex);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(incoming);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return NULL;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void pci_leech_realize(PCIDevice *pdev, Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 PciLeechState *state =3D PCILEECH(pdev);<br>
&gt; +=C2=A0 =C2=A0 struct sockaddr_in sock_addr;<br>
&gt; +=C2=A0 =C2=A0 char host_ip[16];<br>
&gt; +=C2=A0 =C2=A0 struct hostent *he =3D gethostbyname(state-&gt;host);<b=
r>
&gt; +=C2=A0 =C2=A0 if (he =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 puts(&quot;gethostbyname failed!&quot;);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 /* Initialize the socket for PCILeech. */<br>
&gt; +=C2=A0 =C2=A0 state-&gt;sockfd =3D socket(AF_INET, SOCK_STREAM, 0);<b=
r>
&gt; +=C2=A0 =C2=A0 if (state-&gt;sockfd &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 puts(&quot;Failed to initialize socket fo=
r PCILeech!&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 sock_addr.sin_family =3D AF_INET;<br>
&gt; +=C2=A0 =C2=A0 sock_addr.sin_addr =3D *(struct in_addr *)he-&gt;h_addr=
;<br>
&gt; +=C2=A0 =C2=A0 sock_addr.sin_port =3D htons(state-&gt;port);<br>
&gt; +=C2=A0 =C2=A0 inet_ntop(AF_INET, &amp;sock_addr.sin_addr, host_ip, si=
zeof(host_ip));<br>
&gt; +=C2=A0 =C2=A0 if (bind(state-&gt;sockfd, (struct sockaddr *)&amp;sock=
_addr, sizeof(sock_addr))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 puts(&quot;Failed to bind socket for PCIL=
eech!&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(state-&gt;sockfd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (listen(state-&gt;sockfd, 10) &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 puts(&quot;Failed to listen to socket for=
 PCILeech!&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(state-&gt;sockfd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
Don&#39;t roll your own &quot;user specifies a host/port and<br>
we create a socket&quot; code. Instead have the device take<br>
a QEMU chardev backend. Then the user can create the<br>
chardev, which might be &quot;listens on a socket&quot; or<br>
&quot;uses a file descriptor&quot; or any of the other chardev backends.<br=
>
<br>
This also will let you drop the complexity of manually<br>
creating an extra thread, because the chardev API<br>
integrates into QEMU&#39;s existing iothread/main loop<br>
infrastructure and will call you back when it has data<br>
for you.<br>
<br>
&gt; +=C2=A0 =C2=A0 printf(&quot;INFO: PCILeech is listening on %s:%u...\n&=
quot;, host_ip, state-&gt;port);<br>
&gt; +=C2=A0 =C2=A0 /* Initialize the thread for PCILeech. */<br>
&gt; +=C2=A0 =C2=A0 qemu_mutex_init(&amp;state-&gt;mutex);<br>
&gt; +=C2=A0 =C2=A0 qemu_thread_create(&amp;state-&gt;thread, &quot;pcileec=
h&quot;, pci_leech_worker_thread,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 state, QEMU_THREAD_JOINABLE);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void pci_leech_finalize(PCIDevice *pdev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 PciLeechState *state =3D PCILEECH(pdev);<br>
&gt; +=C2=A0 =C2=A0 puts(&quot;Stopping PCILeech Worker...&quot;);<br>
&gt; +=C2=A0 =C2=A0 qemu_mutex_lock(&amp;state-&gt;mutex);<br>
&gt; +=C2=A0 =C2=A0 state-&gt;stopping =3D true;<br>
&gt; +=C2=A0 =C2=A0 qemu_mutex_unlock(&amp;state-&gt;mutex);<br>
&gt; +=C2=A0 =C2=A0 close(state-&gt;sockfd);<br>
&gt; +=C2=A0 =C2=A0 qemu_thread_join(&amp;state-&gt;thread);<br>
&gt; +=C2=A0 =C2=A0 qemu_mutex_destroy(&amp;state-&gt;mutex);<br>
&gt; +}<br>
&gt; +<br>
&gt; +char pci_leech_default_host[] =3D &quot;0.0.0.0&quot;;<br>
&gt; +<br>
&gt; +static void pci_leech_instance_init(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int x =3D 1;<br>
&gt; +=C2=A0 =C2=A0 char* y =3D (char *)&amp;x;<br>
&gt; +=C2=A0 =C2=A0 PciLeechState *state =3D PCILEECH(obj);<br>
&gt; +=C2=A0 =C2=A0 /* QEMU&#39;s String-Property can&#39;t specify default=
 value. */<br>
&gt; +=C2=A0 =C2=A0 /* So we have to set the default on our own. */<br>
&gt; +=C2=A0 =C2=A0 if (state-&gt;host =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 state-&gt;host =3D pci_leech_default_host=
;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 /* Save Our Endianness. */<br>
&gt; +=C2=A0 =C2=A0 state-&gt;endianness =3D (*y =3D=3D 0);<br>
<br>
Don&#39;t try to roll your own host endianness detection.<br>
Instead use the functions like ldl_le_p() (load little<br>
endian value from pointer) or le32_to_cpu() and<br>
cpu_to_le32() (convert little endian to and from host<br>
order) to convert between what the protocol expects and<br>
the CPU representation.<br>
<br>
&gt; +}<br>
&gt; +<br>
&gt; +static Property leech_properties[] =3D {<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_UINT16(&quot;port&quot;, PciLeechState, por=
t, 6789),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_STRING(&quot;host&quot;, PciLeechState, hos=
t),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST(),<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void pci_leech_class_init(ObjectClass *class, void *data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(class);<br>
&gt; +=C2=A0 =C2=A0 PCIDeviceClass *k =3D PCI_DEVICE_CLASS(class);<br>
&gt; +=C2=A0 =C2=A0 k-&gt;realize =3D pci_leech_realize;<br>
&gt; +=C2=A0 =C2=A0 k-&gt;exit =3D pci_leech_finalize;<br>
&gt; +=C2=A0 =C2=A0 /* Change the Vendor/Device ID to your favor. */<br>
&gt; +=C2=A0 =C2=A0 /* These are the default values from PCILeech-FPGA. */<=
br>
&gt; +=C2=A0 =C2=A0 k-&gt;vendor_id =3D PCI_VENDOR_ID_XILINX;<br>
&gt; +=C2=A0 =C2=A0 k-&gt;device_id =3D 0x0666;<br>
&gt; +=C2=A0 =C2=A0 k-&gt;revision =3D 0;<br>
&gt; +=C2=A0 =C2=A0 k-&gt;class_id =3D PCI_CLASS_NETWORK_ETHERNET;<br>
&gt; +=C2=A0 =C2=A0 device_class_set_props(dc, leech_properties);<br>
&gt; +=C2=A0 =C2=A0 set_bit(DEVICE_CATEGORY_MISC, dc-&gt;categories);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void pci_leech_register_types(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 static InterfaceInfo interfaces[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {INTERFACE_CONVENTIONAL_PCI_DEVICE},<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {},<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 static const TypeInfo leech_info =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D TYPE_PCILEECH_DEVICE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent =3D TYPE_PCI_DEVICE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .instance_size =3D sizeof(PciLeechState),=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .instance_init =3D pci_leech_instance_ini=
t,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init =3D pci_leech_class_init,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .interfaces =3D interfaces,<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 type_register_static(&amp;leech_info);<br>
&gt; +}<br>
&gt; +<br>
&gt; +type_init(pci_leech_register_types)<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--0000000000008d5eda0620db6392--

