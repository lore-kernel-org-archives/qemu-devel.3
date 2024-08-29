Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901CFC83F0F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 12:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sje2N-0001Rl-9y; Thu, 29 Aug 2024 08:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sje2K-0001Qh-NS
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 08:14:01 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sje25-0007ix-8y
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 08:14:00 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5becd359800so596194a12.0
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 05:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724933623; x=1725538423; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=29ncSwlLJvd4muFAdEdrcrR0zlcUCd0cUYXQTg8I6gc=;
 b=mEXFOU0qrc5VLpGbx9P5LRHn37Y3J8IOyytQaOLIAewRJTRawzGlhw0IaSF5k599LS
 nxOthGiu2jD6lrL5ovnj1PDHGOuNsP7AqvjJ7iF2+ixZriqaH4Lt0zdA+gVAWCnnaM2w
 /hLSKLlSrkl9vlLHtDRGxBzYFSL2G5WUF8OLg+UvPrc4paGiiOCiZ74Hes3X98S4Q8++
 9LscijvbMmvvYfRpt+EInyCybPi71bywf80p8zWh8x34sZsx1nq3wwFYEWoYuBVfUgLO
 MH3QrcW+bAQ7mdDet3x0zPVa0xYg3S2b/wD0fqYaMzSVcnxgjvTWZfzSisQCw2PuVZDL
 8oyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724933623; x=1725538423;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=29ncSwlLJvd4muFAdEdrcrR0zlcUCd0cUYXQTg8I6gc=;
 b=aFpwX0+UMo38stIpHbh3PwvzSa+J6adVD/FBCiIdYu2RrSr74PuwIjwOIWA4YYFNZr
 yzbhrOi5JRH99hes9WflChhWiywIaX0HZno5Y3PBXy9YOdmFrT942ezm4eBfoIYM8MsE
 3v8QWyoY+S/Z39g1w9XIbrO8GsAAsDSbZntcSlvGet0yGbzAevEEakOrpnS7vLb9hsg0
 AF5vpYNTRirb6jK4OsJ6RexCLN5qCCU3m2nVHRoZKRJXkMtasRhg+9xE81ATHlSVNfG/
 3lbWXUXy30ea8bUPqDnwTYFQhujN7A9evPEniYuFcopoVgoQ4eiKgSr5oFfNF92jaFEX
 +FHA==
X-Gm-Message-State: AOJu0YyLXMXiGU2dYhrLruwXnHqEl5P1Gkqq7+CYCoJV4XYOcp4NCWwo
 M3sv/q4TF+DVA1AqMHjLwQqVz+fFXbFgC6SZZ2gFmZ588FAo3FTZ3vbeJvcBND1gQ6pPZ0FnI/O
 JHArDHEOeHeN+HrOsS70XA2GNnmamxU+5mmOWyw==
X-Google-Smtp-Source: AGHT+IF5vhheMhsc2iEiI98+kE6+pqio1AykOFhCwJzwIhUcCZiTx0owsKaSKIzaqh/GE5s/psqJ/Av2iIe+mYokaZw=
X-Received: by 2002:a05:6402:3586:b0:5a2:68a2:ae57 with SMTP id
 4fb4d7f45d1cf-5c21eda31a1mr2410064a12.31.1724933623128; Thu, 29 Aug 2024
 05:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAAXNugBYhpx249dUWgyXOtGjkxWatRHJSq94LrVFMGP_GjX7aA@mail.gmail.com>
In-Reply-To: <CAAXNugBYhpx249dUWgyXOtGjkxWatRHJSq94LrVFMGP_GjX7aA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Aug 2024 13:13:30 +0100
Message-ID: <CAFEAcA9wFOX+gcaVDmBo2j3Zhd5fUj+3c9MCX=Q7zsXqVjOeXQ@mail.gmail.com>
Subject: Re: [PATCH] hw/misc: Add a virtual PCILeech device
To: Zero Tang <zero.tangptr@gmail.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, marcel.apfelbaum@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 6 Aug 2024 at 10:28, Zero Tang <zero.tangptr@gmail.com> wrote:
>
> This virtual PCILeech device aims to help security researchers attack the guest via DMA and test their IOMMU defenses.
> This device is intended to support any systems with PCI, but I am only able to test x86-based guests.
> For what PCILeech is, check PCILeech GitHub repository: https://github.com/ufrisk/pcileech
> The QEMU-PCILeech plugin is currently awaiting merging: https://github.com/ufrisk/LeechCore-plugins/pull/10
>
> This is my first time contributing to QEMU and I am sorry that I forgot to include a "[PATCH]" prefix in the title from my previous email and that I didn't cc to relevant maintainers.
> If needed, add my name and contact info into the maintainer's list.

Since nobody else has responded yet, I guess I'll make
some initial general remarks.

Firstly, how useful is this to QEMU users in general?
It seems very specific.

Secondly, there's no documentation here that explains
what it is, why users might care about it, or how to use it.

Thirdly, it looks like it's basically a doorway that some
external system uses to tell it to do arbitrary DMA
reads or writes. There's no documentation of what the
protocol is that it's using.

I have some more specific comments below, but overall I'm not
yet sure that this is worth QEMU upstream having a model of.
So I think it's probably better if we sort out the top
level question of "what's the benefit to QEMU of us taking
on this device" before you spend much time on the code
part of it.

> +#define TYPE_PCILEECH_DEVICE "pcileech"
> +
> +struct LeechRequestHeader {
> +    uint8_t endianness; /* 0 - Little, 1 - Big */
> +    uint8_t command;    /* 0 - Read, 1 - Write */
> +    uint8_t reserved[6];
> +    /* Variable Endianness */
> +    uint64_t address;
> +    uint64_t length;

Why not just specify the protocol endianness (eg
"always little endian")?

> +};
> +
> +struct LeechResponseHeader {
> +    uint8_t endianness; /* 0 - Little, 1 - Big */
> +    uint8_t reserved[3];
> +    MemTxResult result;

MemTxResult is a QEMU-internal enum, which we might change
the values or size or definition of. It shouldn't appear
in an external protocol packet.

> +    uint64_t length;    /* Indicates length of data followed by header */
> +};
> +
> +/* Verify the header length */
> +static_assert(sizeof(struct LeechRequestHeader) == 24);
> +static_assert(sizeof(struct LeechResponseHeader) == 16);

Use QEMU_BUILD_BUG_ON().

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
> +    for (uint64_t i = 0; i < request->length; i += sizeof(buff)) {
> +        struct LeechResponseHeader response = { 0 };
> +        char* response_buffer = (char *)&response;
> +        const uint64_t writelen = (request->length - i) <= sizeof(buff) ?
> +                                         (request->length - i) : sizeof(buff);
> +        ssize_t recvlen = 0, sendlen = 0;
> +        while (recvlen < writelen) {
> +            recvlen += recv(incoming, &buff[recvlen], writelen - recvlen, 0);
> +        }
> +        response.endianness = state->endianness;
> +        response.result = pci_dma_write(&state->device, request->address + i,
> +                                                            buff, writelen);
> +        if (response.result) {
> +            printf("PCILeech: Address 0x%lX Write Error! MemTxResult: 0x%X\n",
> +                    request->address + i, response.result);
> +        }
> +        response.length = 0;
> +        while (sendlen < sizeof(struct LeechResponseHeader)) {
> +            sendlen += send(incoming, &response_buffer[sendlen],
> +                            sizeof(struct LeechResponseHeader) - sendlen, 0);
> +        }
> +    }
> +}
> +
> +static void pci_leech_process_read_request(PciLeechState *state,
> +                                            LeechRequestHeader *request,
> +                                            int incoming)
> +{
> +    char buff[1024];
> +    for (uint64_t i = 0; i < request->length; i += sizeof(buff)) {
> +        struct LeechResponseHeader response = { 0 };
> +        char* response_buffer = (char *)&response;
> +        const uint64_t readlen = (request->length - i) <= sizeof(buff) ?
> +                                    (request->length - i) : sizeof(buff);
> +        ssize_t sendlen = 0;
> +        response.endianness = state->endianness;
> +        response.result = pci_dma_read(&state->device, request->address + i,
> +                                                            buff, readlen);
> +        if (response.result) {
> +            printf("PCILeech: Address 0x%lX Read Error! MemTxResult: 0x%X\n",
> +                    request->address + i, response.result);
> +        }
> +        response.length = (request->endianness != state->endianness) ?
> +                                            bswap64(readlen) : readlen;
> +        while (sendlen < sizeof(struct LeechResponseHeader)) {
> +            sendlen += send(incoming, &response_buffer[sendlen],
> +                            sizeof(struct LeechResponseHeader) - sendlen, 0);
> +        }
> +        sendlen = 0;
> +        while (sendlen < readlen) {
> +            sendlen += send(incoming, &buff[sendlen], readlen - sendlen, 0);
> +        }
> +    }
> +}
> +
> +static void *pci_leech_worker_thread(void *opaque)
> +{
> +    PciLeechState *state = PCILEECH(opaque);
> +    while (1) {
> +        LeechRequestHeader request;
> +        char *request_buffer = (char *)&request;
> +        ssize_t received = 0;
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

This comment doesn't seem to match what the code thinks
the protocol looks like.

> +        incoming = accept(state->sockfd, &address, &addrlen);
> +        if (incoming < 0) {
> +            puts("WARNING: Failed to accept socket for PCILeech! Skipping "
> +                 "Request...\n");
> +            continue;
> +        }
> +        /* Get PCILeech requests. */
> +        while (received < sizeof(LeechRequestHeader)) {
> +            received += recv(incoming, &request_buffer[received],
> +                            sizeof(LeechRequestHeader) - received, 0);
> +        }
> +        /* Swap endianness. */
> +        if (request.endianness != state->endianness) {
> +            request.address = bswap64(request.address);
> +            request.length = bswap64(request.length);
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
> +    PciLeechState *state = PCILEECH(pdev);
> +    struct sockaddr_in sock_addr;
> +    char host_ip[16];
> +    struct hostent *he = gethostbyname(state->host);
> +    if (he == NULL) {
> +        puts("gethostbyname failed!");
> +        exit(EXIT_FAILURE);
> +    }
> +    /* Initialize the socket for PCILeech. */
> +    state->sockfd = socket(AF_INET, SOCK_STREAM, 0);
> +    if (state->sockfd < 0) {
> +        puts("Failed to initialize socket for PCILeech!");
> +        exit(EXIT_FAILURE);
> +    }
> +    sock_addr.sin_family = AF_INET;
> +    sock_addr.sin_addr = *(struct in_addr *)he->h_addr;
> +    sock_addr.sin_port = htons(state->port);
> +    inet_ntop(AF_INET, &sock_addr.sin_addr, host_ip, sizeof(host_ip));
> +    if (bind(state->sockfd, (struct sockaddr *)&sock_addr, sizeof(sock_addr))
> +                                                                    < 0) {
> +        puts("Failed to bind socket for PCILeech!");
> +        close(state->sockfd);
> +        exit(EXIT_FAILURE);
> +    }
> +    if (listen(state->sockfd, 10) < 0) {
> +        puts("Failed to listen to socket for PCILeech!");
> +        close(state->sockfd);
> +        exit(EXIT_FAILURE);
> +    }

Don't roll your own "user specifies a host/port and
we create a socket" code. Instead have the device take
a QEMU chardev backend. Then the user can create the
chardev, which might be "listens on a socket" or
"uses a file descriptor" or any of the other chardev backends.

This also will let you drop the complexity of manually
creating an extra thread, because the chardev API
integrates into QEMU's existing iothread/main loop
infrastructure and will call you back when it has data
for you.

> +    printf("INFO: PCILeech is listening on %s:%u...\n", host_ip, state->port);
> +    /* Initialize the thread for PCILeech. */
> +    qemu_mutex_init(&state->mutex);
> +    qemu_thread_create(&state->thread, "pcileech", pci_leech_worker_thread,
> +                                            state, QEMU_THREAD_JOINABLE);
> +}
> +
> +static void pci_leech_finalize(PCIDevice *pdev)
> +{
> +    PciLeechState *state = PCILEECH(pdev);
> +    puts("Stopping PCILeech Worker...");
> +    qemu_mutex_lock(&state->mutex);
> +    state->stopping = true;
> +    qemu_mutex_unlock(&state->mutex);
> +    close(state->sockfd);
> +    qemu_thread_join(&state->thread);
> +    qemu_mutex_destroy(&state->mutex);
> +}
> +
> +char pci_leech_default_host[] = "0.0.0.0";
> +
> +static void pci_leech_instance_init(Object *obj)
> +{
> +    int x = 1;
> +    char* y = (char *)&x;
> +    PciLeechState *state = PCILEECH(obj);
> +    /* QEMU's String-Property can't specify default value. */
> +    /* So we have to set the default on our own. */
> +    if (state->host == NULL) {
> +        state->host = pci_leech_default_host;
> +    }
> +    /* Save Our Endianness. */
> +    state->endianness = (*y == 0);

Don't try to roll your own host endianness detection.
Instead use the functions like ldl_le_p() (load little
endian value from pointer) or le32_to_cpu() and
cpu_to_le32() (convert little endian to and from host
order) to convert between what the protocol expects and
the CPU representation.

> +}
> +
> +static Property leech_properties[] = {
> +    DEFINE_PROP_UINT16("port", PciLeechState, port, 6789),
> +    DEFINE_PROP_STRING("host", PciLeechState, host),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void pci_leech_class_init(ObjectClass *class, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(class);
> +    PCIDeviceClass *k = PCI_DEVICE_CLASS(class);
> +    k->realize = pci_leech_realize;
> +    k->exit = pci_leech_finalize;
> +    /* Change the Vendor/Device ID to your favor. */
> +    /* These are the default values from PCILeech-FPGA. */
> +    k->vendor_id = PCI_VENDOR_ID_XILINX;
> +    k->device_id = 0x0666;
> +    k->revision = 0;
> +    k->class_id = PCI_CLASS_NETWORK_ETHERNET;
> +    device_class_set_props(dc, leech_properties);
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +}
> +
> +static void pci_leech_register_types(void)
> +{
> +    static InterfaceInfo interfaces[] = {
> +        {INTERFACE_CONVENTIONAL_PCI_DEVICE},
> +        {},
> +    };
> +    static const TypeInfo leech_info = {
> +        .name = TYPE_PCILEECH_DEVICE,
> +        .parent = TYPE_PCI_DEVICE,
> +        .instance_size = sizeof(PciLeechState),
> +        .instance_init = pci_leech_instance_init,
> +        .class_init = pci_leech_class_init,
> +        .interfaces = interfaces,
> +    };
> +    type_register_static(&leech_info);
> +}
> +
> +type_init(pci_leech_register_types)

thanks
-- PMM

