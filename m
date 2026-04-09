Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27774E98FD5
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 06:41:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAj4T-0007t4-3u; Thu, 09 Apr 2026 02:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangruikang@iscas.ac.cn>)
 id 1wAj4N-0007qv-PY; Thu, 09 Apr 2026 02:40:52 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangruikang@iscas.ac.cn>)
 id 1wAj4H-0004PU-DK; Thu, 09 Apr 2026 02:40:50 -0400
Received: from [127.0.0.2] (unknown [36.110.52.2])
 by APP-03 (Coremail) with SMTP id rQCowABnht3aSddpeI91DQ--.34096S2;
 Thu, 09 Apr 2026 14:40:27 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Subject: [PATCH 0/5] hw: Fix unit addresses of FDT CPU nodes
Date: Thu, 09 Apr 2026 14:40:10 +0800
Message-Id: <20260409-fix-unit-address-v1-0-946840930af2@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMpJ12kC/y2N2wrCMBAFf6Xss1u2MXjpr0iFNF11hV7MpkUI/
 Xej9XFgzpwEykFYoS4SBF5EZRwyVLsC/MMNd0bpMoMhcyBLZ7zJG+dBIrquC6yKxnjaW3L2SCf
 Isylwdn7JS7Oxzu2Tffx2/kbg15y/4qZB65TRj30vsS6WqiqpJAzeXNMKzbp+AA5FGqimAAAA
X-Change-ID: 20260409-fix-unit-address-22c0340a4708
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paul Burton <paulburton@kernel.org>, 
 Aleksandar Rikalo <arikalo@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jia Liu <proljc@gmail.com>, Stafford Horne <shorne@gmail.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org, 
 Vivian Wang <wangruikang@iscas.ac.cn>
X-Mailer: b4 0.15.1
X-CM-TRANSID: rQCowABnht3aSddpeI91DQ--.34096S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw4xKw18tw48Cw18KF1kAFb_yoW8CryrpF
 WxCFW5tryDKry7XanrXFsrXrWayFZ5Wa47KrnFkw4Fkw45XF17AFZak345XryYgr18GF4a
 yFnag3WkXFn5ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
 Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
 0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
 zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
 4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
 CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
 nIWIevJa73UjIFyTuYvjTRZDGYDUUUU
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/
Received-SPF: pass client-ip=159.226.251.81;
 envelope-from=wangruikang@iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Apply some pendantry to the node unit addresses of /cpus/cpu@*:

    / {
        cpus {
            cpu@??? /* <- here */ {
                reg = <10>; /* Equivalently, <0xa> */
            }
        };
    };

According to de facto convention, as confirmed by DTSpec maintainers,
these unit addresses should be in hexadecimal [2], i.e. cpu@a instead of
cpu@10. Currently apparently everything uses decimal which is wrong.

hw/arm/{sbsa-ref,virt} have an additional problem where the unit address
doesn't match up with the reg value. Fix that also.

I've tried to use the types of existing variables / return values, hence
the slightly different patterns in these patches:

  int cpu;                       -> "cpu@%x", (unsigned)cpu  [easy case]
  uint64_t mpidr;                -> "cpu@%" PRIx64, mpidr
  uint32_t hartid_base; int cpu; -> "cpu@%" PRIx32, hartid_base + (uint32_t)cpu

[1]: https://github.com/devicetree-org/devicetree-specification/blob/v0.4/source/chapter2-devicetree-basics.rst#devicetree-structure-and-conventions
[2]: https://lore.kernel.org/devicetree-spec/CAL_JsqJFv3+UJ-bjLGk0i7Wc+spsowCrqQZ_s3P4gN8r1W-Q-w@mail.gmail.com/

---
Vivian Wang (5):
      hw/arm: Fix unit addresses of FDT CPU nodes
      hw/loongarch: Use hex unit addresses in FDT CPU nodes
      hw/mips: Use hex unit addresses in FDT CPU nodes
      hw/or1k: Use hex unit addresses in FDT CPU nodes
      hw/riscv: Use hex unit addresses in FDT CPU nodes

 hw/arm/sbsa-ref.c             | 4 ++--
 hw/arm/virt.c                 | 7 +++++--
 hw/loongarch/virt-fdt-build.c | 4 ++--
 hw/mips/boston.c              | 2 +-
 hw/or1k/or1k-sim.c            | 2 +-
 hw/or1k/virt.c                | 2 +-
 hw/riscv/sifive_u.c           | 9 +++++----
 hw/riscv/spike.c              | 4 ++--
 hw/riscv/virt.c               | 4 ++--
 9 files changed, 21 insertions(+), 17 deletions(-)
---
base-commit: b6a7d06213e5d2f7d124d16418bc289c4a8a4b82
change-id: 20260409-fix-unit-address-22c0340a4708

Best regards,
--  
Vivian "dramforever" Wang


