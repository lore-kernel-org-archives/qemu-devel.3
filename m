Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069F7C5AD4E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 18:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wt84r-0001t5-4L; Sun, 09 Aug 2026 14:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guochun.wang@foxmail.com>)
 id 1wt84p-0001sv-Fm
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 14:16:51 -0400
Received: from out203-205-221-155.mail.qq.com ([203.205.221.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guochun.wang@foxmail.com>)
 id 1wt84n-0007Ki-9i
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 14:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1786299383;
 bh=+NGGZ6UchRuKuTozXGraz/27mK+R8qG1NfJzuhy6448=;
 h=From:Subject:Date:To:Cc;
 b=vNZ1t7csD9I9xOWAV9oc8qvSlVe4Hdn1P8fnnmBYNdYwbFf513N9IhCjccBDxJ5ul
 HMNAHu+U+mr0jE089/TRbmL5ZqNqmK2PIevEytpm5Z3TcH4OYgEmue/MuwMqKGfX97
 H+jrSd40VrBMb36Fa9PjWVLOdNk8lz9BlJZzg+pI=
Received: from DESKTOP-8MIQOKD.localdomain ([218.69.78.15])
 by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
 id 413B7E95; Mon, 10 Aug 2026 02:16:19 +0800
X-QQ-mid: xmsmtpt1786299379tclhw1apz
Message-ID: <tencent_EF996EEB2215272639C89FAE1491CEF43908@qq.com>
X-QQ-XMAILINFO: MdrdICwnQFGXK1uA8z6o7LEhI0iHmfZKSDuwlmTZsaC62qDPmB/BDrDMPQaNl3
 kH883+CwW0SP765EXmKJPRQovMFNxt/ffdA5gpzoNLE6j0g5s0lHWDNQdfGCyk5OGxPQRNVL4ClU
 ZsbGJJukEHmjHhUIirDB5q9qG9sOCcdGkrnEXyqNw/aDngof66ivwQB1ZGUPzrOVmQKf8GeLiS4P
 OWyVH2zpCv9YAz4XMrV0kxmVvHwXflKR1sqr7E9nty53DAXt0QuAPM68Zwt7hFYNeofvwyJMZOGW
 MyKEeEpK1MP/ZDArIcGIb/ve+nbziQoxhilEF1Ob3lAR5C61o5MA/hH43956nEaPjvnsv8zp2kZ5
 xm/oeb081YL3c/1iABlAyV2mmBW6NwwdB/jcuwPNDy1+6cIFGeSw3m89fAnjlmiRL37mMoq5fRE7
 9qfrHQ3q95KMcOiF//HE5PqsDLOgSz8a2aHShcp9I2lM1FnVBc4Sg5STtRii74Mxb81r3UXMmORx
 Dhw1rpc+Z/AWrkP9dqMU5D0syubCg2VFJeXS9q4hS3V3G25g9UKlH4bxehDfTKKR3aUv0/BoNYrQ
 4zyD2/GRAZA5fRGTbx0m0LHUeSaOXr9l6/l8AoO7d/a5lieruF3Upp09IEJhnE/aBHl+4k2E6Csk
 EfOHuScnM21eG/wM3XHj6liA5TgRu5gKOvfGVuSnOR7OXDOhRiZ4hReyEtwaKvvMOaUBSuJHSHrJ
 Bo7jACpIDk7+GzgX7ARPyWnH6b4qezHY9jMW0mXGTrzlIHaRcq3Qcjm07PbP1QhkNYA+VKdMsR/e
 aLneCtC4qdbVnddakMWGsRoxt4VxVwBvlbJ3vHD9RVw3q6yXPvHnMYPT2MtTaiN6ry8zXEqOl6ef
 cebr3HIfm8jGVoFkvaXjpIUYAXbrjonX+1F44NII0mXHEeeq6ArcOHbSo6O/finR+FdLz+JWwmg5
 Zm9tId0D9oijfwLPZZVUL3oP2JFAjOWjp7cpmCe65B0ZZfiVmDmjWZCcGOmBt41tZPLLPJWdmXn+
 BQpIMDWiZpumWPitW7HYarhi0/rjvAjJ2/aVtMYp/NmfPyF862+f+YjxuHSEfJM6SBD2/1V7U4Pg
 TEvfw2OgnRljzbbCPtUjqUdLAwLmBGvjsiyIrKE4IW9n9VYSptolUDnfkmvuxbGmZBpBYXKiIg8F
 DZz/1LQ99YJz+YUdDyPXoiss7iCss9d7n0i0aNAdFkqBU1tw==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: guochun wang <guochun.wang@foxmail.com>
Subject: [PATCH v3 0/2] Add K230 SoC GPIO controller support
Date: Mon, 10 Aug 2026 00:31:50 +0800
X-OQ-MSGID: <178629937653.184852.4714437780536986791@foxmail.com>
MIME-Version: 1.0
To: qemu-devel@nongnu.org
Cc: chao.liu@processmission.com, pbonzini@redhat.com, farosas@suse.de,
 lvivier@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, guochun.wang@foxmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=203.205.221.155;
 envelope-from=guochun.wang@foxmail.com; helo=out203-205-221-155.mail.qq.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HELO_STATIC_HOST=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi,

Thanks to Daniel Henrique Barboza for reviewing v2. This v3 addresses
all the comments you raised on patch 1/2; patch 2/2 (the qtest) is
unchanged.

The Kendryte K230 SoC contains two APB GPIO controllers derived from
the Synopsys DesignWare APB GPIO (the Linux gpio-k230 driver is itself
based on gpio-dwapb.c, and shares the same register layout), with a
Canaan-specific compatible ("canaan,k230-apb-gpio") and hardlock
integration. This series implements the device model, wires it into
the K230 SoC, and adds qtest coverage.


Changes in v3 (patch 1/2 only):

* Removed the unused `intstatus` field from the device state, the
  vmstate description and the reset hook.

* Moved `qemu/osdep.h` out of k230_gpio.h and into k230_gpio.c as the
  first include.

* Flattened the nested `if` blocks in the SWPORTA_DDR and SWPORTA_CTL
  write paths with an early `continue`, reducing the indentation by two
  levels. `curr_level` and `pol` are now declared at the top of
  k230_gpio_write() to avoid mid-block declarations after the
  `continue`.

Links to previous versions:
v2 cover: https://lore.kernel.org/qemu-devel/tencent_1EE6F17A514580093D329A6B=
4BA43B7D7506@qq.com/
v2 1/2:   https://lore.kernel.org/qemu-devel/tencent_7080159426F5C824AE07916C=
F4FF9944EB08@qq.com/
v2 2/2:   https://lore.kernel.org/qemu-devel/tencent_76E410D79348037AB2CC8875=
8B8A5B932907@qq.com/
v1 cover: https://lore.kernel.org/qemu-devel/tencent_B90E44EAD06F6676AF9B5728=
98242037BB0A@qq.com/

guochun wang (2):
  hw/gpio: add K230 GPIO controller model
  tests/qtest: add K230 GPIO controller test

 MAINTAINERS                  |   3 +
 hw/gpio/Kconfig              |   3 +
 hw/gpio/k230_gpio.c          | 362 ++++++++++++++++++++++++
 hw/gpio/meson.build          |   1 +
 hw/riscv/Kconfig             |   1 +
 hw/riscv/k230.c              |  27 +-
 include/hw/gpio/k230_gpio.h  |  71 +++++
 include/hw/riscv/k230.h      |   5 +
 tests/qtest/k230-gpio-test.c | 521 +++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build      |   2 +-
 10 files changed, 989 insertions(+), 7 deletions(-)
 create mode 100644 hw/gpio/k230_gpio.c
 create mode 100644 include/hw/gpio/k230_gpio.h
 create mode 100644 tests/qtest/k230-gpio-test.c

--=20
2.43.0



