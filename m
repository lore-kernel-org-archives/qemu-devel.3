Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14633D3C93F
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 05:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2lIt-0005Ya-6w; Mon, 21 Oct 2024 01:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=cGEO=RR=kaod.org=clg@ozlabs.org>)
 id 1t2lIq-0005YF-Ej; Mon, 21 Oct 2024 01:50:04 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=cGEO=RR=kaod.org=clg@ozlabs.org>)
 id 1t2lIo-0004P5-0l; Mon, 21 Oct 2024 01:50:04 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XX4C81rkqz4wcy;
 Mon, 21 Oct 2024 16:49:56 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XX4C52F4xz4wbv;
 Mon, 21 Oct 2024 16:49:53 +1100 (AEDT)
Message-ID: <dbb26fab-8c97-4b8a-a868-3018e182c615@kaod.org>
Date: Mon, 21 Oct 2024 07:49:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] docs/system/arm: Split fby35 out from aspeed.rst
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20241018141332.942844-1-peter.maydell@linaro.org>
 <20241018141332.942844-4-peter.maydell@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20241018141332.942844-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=cGEO=RR=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.17, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/18/24 16:13, Peter Maydell wrote:
> The fby35 machine is not implemented in hw/arm/aspeed.c,
> but its documentation is currently stuck at the end of aspeed.rst,
> formatted in a way that it gets its own heading in the top-level
> list of boards in target-arm.html.
> 
> We don't have any other boards that we document like this; split it
> out into its own rst file. This improves consistency with other
> board docs and means we can have the entry in the target-arm
> list be in the correct alphabetical order.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   MAINTAINERS                |  1 +
>   docs/system/arm/aspeed.rst | 48 --------------------------------------
>   docs/system/arm/fby35.rst  | 47 +++++++++++++++++++++++++++++++++++++
>   docs/system/target-arm.rst |  1 +
>   4 files changed, 49 insertions(+), 48 deletions(-)
>   create mode 100644 docs/system/arm/fby35.rst
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c21d6a2f9e1..dff8073c5bc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1121,6 +1121,7 @@ F: include/hw/*/*aspeed*
>   F: hw/net/ftgmac100.c
>   F: include/hw/net/ftgmac100.h
>   F: docs/system/arm/aspeed.rst
> +F: docs/system/arm/fby35.rst
>   F: tests/*/*aspeed*
>   F: hw/arm/fby35.c
>   
> diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
> index 968ba88b997..63910d382fe 100644
> --- a/docs/system/arm/aspeed.rst
> +++ b/docs/system/arm/aspeed.rst
> @@ -257,51 +257,3 @@ To boot a kernel directly from a Zephyr build tree:
>   
>     $ qemu-system-arm -M ast1030-evb -nographic \
>           -kernel zephyr.elf
> -
> -Facebook Yosemite v3.5 Platform and CraterLake Server (``fby35``)
> -==================================================================
> -
> -Facebook has a series of multi-node compute server designs named
> -Yosemite. The most recent version released was
> -`Yosemite v3 <https://www.opencompute.org/documents/ocp-yosemite-v3-platform-design-specification-1v16-pdf>`__.
> -
> -Yosemite v3.5 is an iteration on this design, and is very similar: there's a
> -baseboard with a BMC, and 4 server slots. The new server board design termed
> -"CraterLake" includes a Bridge IC (BIC), with room for expansion boards to
> -include various compute accelerators (video, inferencing, etc). At the moment,
> -only the first server slot's BIC is included.
> -
> -Yosemite v3.5 is itself a sled which fits into a 40U chassis, and 3 sleds
> -can be fit into a chassis. See `here <https://www.opencompute.org/products/423/wiwynn-yosemite-v3-server>`__
> -for an example.
> -
> -In this generation, the BMC is an AST2600 and each BIC is an AST1030. The BMC
> -runs `OpenBMC <https://github.com/facebook/openbmc>`__, and the BIC runs
> -`OpenBIC <https://github.com/facebook/openbic>`__.
> -
> -Firmware images can be retrieved from the Github releases or built from the
> -source code, see the README's for instructions on that. This image uses the
> -"fby35" machine recipe from OpenBMC, and the "yv35-cl" target from OpenBIC.
> -Some reference images can also be found here:
> -
> -.. code-block:: bash
> -
> -    $ wget https://github.com/facebook/openbmc/releases/download/openbmc-e2294ff5d31d/fby35.mtd
> -    $ wget https://github.com/peterdelevoryas/OpenBIC/releases/download/oby35-cl-2022.13.01/Y35BCL.elf
> -
> -Since this machine has multiple SoC's, each with their own serial console, the
> -recommended way to run it is to allocate a pseudoterminal for each serial
> -console and let the monitor use stdio. Also, starting in a paused state is
> -useful because it allows you to attach to the pseudoterminals before the boot
> -process starts.
> -
> -.. code-block:: bash
> -
> -    $ qemu-system-arm -machine fby35 \
> -        -drive file=fby35.mtd,format=raw,if=mtd \
> -        -device loader,file=Y35BCL.elf,addr=0,cpu-num=2 \
> -        -serial pty -serial pty -serial mon:stdio \
> -        -display none -S
> -    $ screen /dev/tty0 # In a separate TMUX pane, terminal window, etc.
> -    $ screen /dev/tty1
> -    $ (qemu) c		   # Start the boot process once screen is setup.
> diff --git a/docs/system/arm/fby35.rst b/docs/system/arm/fby35.rst
> new file mode 100644
> index 00000000000..742b887d44c
> --- /dev/null
> +++ b/docs/system/arm/fby35.rst
> @@ -0,0 +1,47 @@
> +Facebook Yosemite v3.5 Platform and CraterLake Server (``fby35``)
> +==================================================================
> +
> +Facebook has a series of multi-node compute server designs named
> +Yosemite. The most recent version released was
> +`Yosemite v3 <https://www.opencompute.org/documents/ocp-yosemite-v3-platform-design-specification-1v16-pdf>`__.
> +
> +Yosemite v3.5 is an iteration on this design, and is very similar: there's a
> +baseboard with a BMC, and 4 server slots. The new server board design termed
> +"CraterLake" includes a Bridge IC (BIC), with room for expansion boards to
> +include various compute accelerators (video, inferencing, etc). At the moment,
> +only the first server slot's BIC is included.
> +
> +Yosemite v3.5 is itself a sled which fits into a 40U chassis, and 3 sleds
> +can be fit into a chassis. See `here <https://www.opencompute.org/products/423/wiwynn-yosemite-v3-server>`__
> +for an example.
> +
> +In this generation, the BMC is an AST2600 and each BIC is an AST1030. The BMC
> +runs `OpenBMC <https://github.com/facebook/openbmc>`__, and the BIC runs
> +`OpenBIC <https://github.com/facebook/openbic>`__.
> +
> +Firmware images can be retrieved from the Github releases or built from the
> +source code, see the README's for instructions on that. This image uses the
> +"fby35" machine recipe from OpenBMC, and the "yv35-cl" target from OpenBIC.
> +Some reference images can also be found here:
> +
> +.. code-block:: bash
> +
> +    $ wget https://github.com/facebook/openbmc/releases/download/openbmc-e2294ff5d31d/fby35.mtd
> +    $ wget https://github.com/peterdelevoryas/OpenBIC/releases/download/oby35-cl-2022.13.01/Y35BCL.elf
> +
> +Since this machine has multiple SoC's, each with their own serial console, the
> +recommended way to run it is to allocate a pseudoterminal for each serial
> +console and let the monitor use stdio. Also, starting in a paused state is
> +useful because it allows you to attach to the pseudoterminals before the boot
> +process starts.
> +
> +.. code-block:: bash
> +
> +    $ qemu-system-arm -machine fby35 \
> +        -drive file=fby35.mtd,format=raw,if=mtd \
> +        -device loader,file=Y35BCL.elf,addr=0,cpu-num=2 \
> +        -serial pty -serial pty -serial mon:stdio \
> +        -display none -S
> +    $ screen /dev/tty0 # In a separate TMUX pane, terminal window, etc.
> +    $ screen /dev/tty1
> +    $ (qemu) c		   # Start the boot process once screen is setup.
> diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
> index 3c0a5848453..9c01e66ffa9 100644
> --- a/docs/system/target-arm.rst
> +++ b/docs/system/target-arm.rst
> @@ -90,6 +90,7 @@ undocumented; you can get a complete list by running
>      arm/digic
>      arm/cubieboard
>      arm/emcraft-sf2
> +   arm/fby35
>      arm/musicpal
>      arm/kzm
>      arm/nrf


