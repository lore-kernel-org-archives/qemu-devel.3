Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB09CD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 12:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRUsw-00071V-Qk; Mon, 25 May 2026 08:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>)
 id 1wRUst-0006zB-Uk; Mon, 25 May 2026 08:58:19 -0400
Received: from m16.mail.163.com ([117.135.210.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>)
 id 1wRUso-00022w-Js; Mon, 25 May 2026 08:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Content-Type:Message-ID:Date:MIME-Version:Subject:
 To:From; bh=UuhAfviNyHHAQuUgqGspjn2cXHNvRpSHEtkCAQvfOro=; b=WY0b
 qd2u+Vi/lNaKg84cmfwtf5T4ZYY5Ab2vGA8yKMQ7/JfBSj9y1f23qLb/DDIk7+hq
 t6sIF+I6ZZ5DXJM9GIyfZMgaAF70HAcCT7vQfv5iGd1ECYmRI+8figSWVTZGmp6v
 8HA7nc3eeWWBwDSPYwHE9S70b31aE0/OfR/2emE=
Received: from [192.168.31.205] (unknown [])
 by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id
 _____wCncNMDRxRqH0NbDQ--.17386S2; 
 Mon, 25 May 2026 20:56:35 +0800 (CST)
Content-Type: multipart/alternative;
 boundary="------------KTpc07WXpBc20tDB8Y7eNpyT"
Message-ID: <44176a21-48fb-4404-9039-9b0b07d2b0ba@163.com>
Date: Mon, 25 May 2026 20:56:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/10] hw/i2c: Add DesignWare I2C Controller
To: Nicholas Piggin <npiggin@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Chris Rauer <crauer@google.com>, Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Corey Minyard <cminyard@mvista.com>
References: <20260516004206.169035-1-npiggin@gmail.com>
 <20260516004206.169035-9-npiggin@gmail.com>
Content-Language: en-US
From: Alano Song <AlanoSong@163.com>
In-Reply-To: <20260516004206.169035-9-npiggin@gmail.com>
X-CM-TRANSID: _____wCncNMDRxRqH0NbDQ--.17386S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFyfWF4xJr1UGryfCr48JFb_yoW8ZrWxpF
 4DCF45tr48XF1I9anxur1IvrWrWa1kGrnxWay7X34UZrZxK34UZr17KFs0vas8Ar4vkF1S
 kFyakF1vkws5Ja7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zE189_UUUUU=
X-Originating-IP: [171.83.94.97]
X-CM-SenderInfo: xdod00pvrqwqqrwthudrp/xtbC9QRyhmoURwToLAAA38
Received-SPF: pass client-ip=117.135.210.4; envelope-from=alanosong@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

This is a multi-part message in MIME format.
--------------KTpc07WXpBc20tDB8Y7eNpyT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> From: Chris Rauer<crauer@google.com>
>
> Add a model for the Synopsys DesignWare Advanced I2C/SMBus Controller
> with sufficient functionality to be used by the Linux Designware I2C
> platform driver.
>
> This IP is used in the Tenstorrent Atlantis RISC-V SoC and will be
> added to the QEMU tt-atlantis machine.
>
> Reviewed-by: Hao Wu<wuhaotsh@google.com>
> Signed-off-by: Chris Rauer<crauer@google.com>
> Link:https://lore.kernel.org/qemu-devel/20220110214755.810343-2-venture@google.com
> [jms: rebase and minor build fixes for class_init and reset callback]
> [npiggin: changelog, code cleanups and fixes as-per below link]
> Link:https://lore.kernel.org/qemu-devel/20260507120524.111056-1-npiggin@gmail.com
> Signed-off-by: Joel Stanley<joel@jms.id.au>
> Signed-off-by: Nicholas Piggin<npiggin@gmail.com>
> Acked-by: Alistair Francis<alistair.francis@wdc.com>
> Reviewed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Acked-by: Corey Minyard<cminyard@mvista.com>
> ---
> This is a re-submission of the model with Chris' permission, with
> changes to rebase, update to QEMU register API, several other
> code improvements, fixes, and cleanups from reviews from Alistair,
> Phil, and others.
>
> Thanks,
> Nick
> ---
>   MAINTAINERS                     |   8 +
>   hw/i2c/Kconfig                  |   5 +
>   hw/i2c/designware_i2c.c         | 742 ++++++++++++++++++++++++++++++++
>   hw/i2c/meson.build              |   1 +
>   hw/i2c/trace-events             |   4 +
>   include/hw/i2c/designware_i2c.h |  56 +++
>   roms/seabios-hppa               |   2 +-
>   7 files changed, 817 insertions(+), 1 deletion(-)
>   create mode 100644 hw/i2c/designware_i2c.c
>   create mode 100644 include/hw/i2c/designware_i2c.h

Hi,

I tested this series with i2c-tools under the v6.18 kernel driver.

All basic I2C operations work correctly, including:
- i2cdetect
- i2cset (single and multiple byte mode)
- i2cget (single and multiple byte mode)
- i2ctransfer (single and multiple mode)

Best Regards,
Alano.

Tested-by: Alano Song<AlanoSong@163.com>


--------------KTpc07WXpBc20tDB8Y7eNpyT
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <blockquote type="cite"
      cite="mid:20260516004206.169035-9-npiggin@gmail.com">
      <pre wrap="" class="moz-quote-pre">From: Chris Rauer <a class="moz-txt-link-rfc2396E" href="mailto:crauer@google.com">&lt;crauer@google.com&gt;</a>

Add a model for the Synopsys DesignWare Advanced I2C/SMBus Controller
with sufficient functionality to be used by the Linux Designware I2C
platform driver.

This IP is used in the Tenstorrent Atlantis RISC-V SoC and will be
added to the QEMU tt-atlantis machine.

Reviewed-by: Hao Wu <a class="moz-txt-link-rfc2396E" href="mailto:wuhaotsh@google.com">&lt;wuhaotsh@google.com&gt;</a>
Signed-off-by: Chris Rauer <a class="moz-txt-link-rfc2396E" href="mailto:crauer@google.com">&lt;crauer@google.com&gt;</a>
Link: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/20220110214755.810343-2-venture@google.com">https://lore.kernel.org/qemu-devel/20220110214755.810343-2-venture@google.com</a>
[jms: rebase and minor build fixes for class_init and reset callback]
[npiggin: changelog, code cleanups and fixes as-per below link]
Link: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/20260507120524.111056-1-npiggin@gmail.com">https://lore.kernel.org/qemu-devel/20260507120524.111056-1-npiggin@gmail.com</a>
Signed-off-by: Joel Stanley <a class="moz-txt-link-rfc2396E" href="mailto:joel@jms.id.au">&lt;joel@jms.id.au&gt;</a>
Signed-off-by: Nicholas Piggin <a class="moz-txt-link-rfc2396E" href="mailto:npiggin@gmail.com">&lt;npiggin@gmail.com&gt;</a>
Acked-by: Alistair Francis <a class="moz-txt-link-rfc2396E" href="mailto:alistair.francis@wdc.com">&lt;alistair.francis@wdc.com&gt;</a>
Reviewed-by: Philippe Mathieu-Daudé <a class="moz-txt-link-rfc2396E" href="mailto:philmd@linaro.org">&lt;philmd@linaro.org&gt;</a>
Acked-by: Corey Minyard <a class="moz-txt-link-rfc2396E" href="mailto:cminyard@mvista.com">&lt;cminyard@mvista.com&gt;</a>
---
This is a re-submission of the model with Chris' permission, with
changes to rebase, update to QEMU register API, several other
code improvements, fixes, and cleanups from reviews from Alistair,
Phil, and others.

Thanks,
Nick
---
 MAINTAINERS                     |   8 +
 hw/i2c/Kconfig                  |   5 +
 hw/i2c/designware_i2c.c         | 742 ++++++++++++++++++++++++++++++++
 hw/i2c/meson.build              |   1 +
 hw/i2c/trace-events             |   4 +
 include/hw/i2c/designware_i2c.h |  56 +++
 roms/seabios-hppa               |   2 +-
 7 files changed, 817 insertions(+), 1 deletion(-)
 create mode 100644 hw/i2c/designware_i2c.c
 create mode 100644 include/hw/i2c/designware_i2c.h</pre>
    </blockquote>
    <pre id="b">Hi,

I tested this series with i2c-tools under the v6.18 kernel driver.

All basic I2C operations work correctly, including:
- i2cdetect
- i2cset (single and multiple byte mode)
- i2cget (single and multiple byte mode)
- i2ctransfer (single and multiple mode)

Best Regards,
Alano.

<span class="q">Tested-by:</span> Alano Song <a class="moz-txt-link-rfc2396E" href="mailto:AlanoSong@163.com">&lt;AlanoSong@163.com&gt;</a></pre>
    <p><br>
    </p>
  </body>
</html>

--------------KTpc07WXpBc20tDB8Y7eNpyT--


