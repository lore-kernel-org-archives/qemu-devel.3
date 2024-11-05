Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C6CD12685
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8HQ5-0006Xu-Jy; Tue, 05 Nov 2024 06:08:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1t8HPw-0006XU-AG; Tue, 05 Nov 2024 06:08:13 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1t8HPt-0005mj-4B; Tue, 05 Nov 2024 06:08:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1730804876; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=Pz3NAVUK/wvPZ2kuGJPNNMnq5Rn/TFioD6g1p+hDDk8=;
 b=da+kzeNum7Lrsh8pmL603FW9HSxhwBuz2duHQZVcVGs9IeCf2Nj7H6Q5VXJ5pI+OeqPlMhi7AAFmFREDX8C66QaoCxq0EHAQ4KBIfLQwnktih0+O+1Wu65Uv+NMAhXocx54F1tKiMH+8VTEnulLLnctRs4OaNWbsvDn0FdpDTeI=
Received: from 30.166.64.101(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WImoshZ_1730804873 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 05 Nov 2024 19:07:54 +0800
Message-ID: <3392e1eb-e8e7-48f2-ad25-ed384f13390b@linux.alibaba.com>
Date: Tue, 5 Nov 2024 19:07:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Convert the RV32-on-RV64 riscv test
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-riscv@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20241105103519.341304-1-thuth@redhat.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20241105103519.341304-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=115.124.30.132;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-132.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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


On 2024/11/5 18:35, Thomas Huth wrote:
> A straggler that has been added to the Avocado framework while the
> conversion to the functional framework was already in progress...
> Move it over now, too!
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/avocado/tuxrun_baselines.py       | 16 ----------------
>   tests/functional/test_riscv64_tuxrun.py | 13 +++++++++++++
>   2 files changed, 13 insertions(+), 16 deletions(-)
>
> diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
> index 366c262e32..38064840da 100644
> --- a/tests/avocado/tuxrun_baselines.py
> +++ b/tests/avocado/tuxrun_baselines.py
> @@ -222,19 +222,3 @@ def test_arm64be(self):
>                    "rootfs.ext4.zst" :
>                    "e6ffd8813c8a335bc15728f2835f90539c84be7f8f5f691a8b01451b47fb4bd7"}
>           self.common_tuxrun(csums=sums)
> -
> -    def test_riscv64_rv32(self):
> -        """
> -        :avocado: tags=arch:riscv64
> -        :avocado: tags=machine:virt
> -        :avocado: tags=tuxboot:riscv32
> -        :avocado: tags=cpu:rv32
> -        """
> -        sums = { "Image" :
> -                 "89599407d7334de629a40e7ad6503c73670359eb5f5ae9d686353a3d6deccbd5",
> -                 "fw_jump.elf" :
> -                 "f2ef28a0b77826f79d085d3e4aa686f1159b315eff9099a37046b18936676985",
> -                 "rootfs.ext4.zst" :
> -                 "7168d296d0283238ea73cd5a775b3dd608e55e04c7b92b76ecce31bb13108cba" }
> -
> -        self.common_tuxrun(csums=sums)
> diff --git a/tests/functional/test_riscv64_tuxrun.py b/tests/functional/test_riscv64_tuxrun.py
> index 13501628f9..4e2449539c 100755
> --- a/tests/functional/test_riscv64_tuxrun.py
> +++ b/tests/functional/test_riscv64_tuxrun.py
> @@ -23,6 +23,13 @@ class TuxRunRiscV64Test(TuxRunBaselineTest):
>           'https://storage.tuxboot.com/20230331/riscv64/rootfs.ext4.zst',
>           'b18e3a3bdf27be03da0b285e84cb71bf09eca071c3a087b42884b6982ed679eb')
>   
> +    ASSET_RISCV32_KERNEL = Asset(
> +        'https://storage.tuxboot.com/20230331/riscv32/Image',
> +        '89599407d7334de629a40e7ad6503c73670359eb5f5ae9d686353a3d6deccbd5')
> +    ASSET_RISCV32_ROOTFS = Asset(
> +        'https://storage.tuxboot.com/20230331/riscv32/rootfs.ext4.zst',
> +        '7168d296d0283238ea73cd5a775b3dd608e55e04c7b92b76ecce31bb13108cba')
> +
>       def test_riscv64(self):
>           self.set_machine('virt')
>           self.common_tuxrun(kernel_asset=self.ASSET_RISCV64_KERNEL,
> @@ -34,5 +41,11 @@ def test_riscv64_maxcpu(self):
>           self.common_tuxrun(kernel_asset=self.ASSET_RISCV64_KERNEL,
>                              rootfs_asset=self.ASSET_RISCV64_ROOTFS)
>   
> +    def test_riscv64_rv32(self):
> +        self.set_machine('virt')
> +        self.cpu='rv32'
> +        self.common_tuxrun(kernel_asset=self.ASSET_RISCV32_KERNEL,
> +                           rootfs_asset=self.ASSET_RISCV32_ROOTFS)
> +

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Zhiwei

>   if __name__ == '__main__':
>       TuxRunBaselineTest.main()

