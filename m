Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A44C04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 18:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5rD5-0004TX-HD; Sat, 11 May 2024 14:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cyy@cyyself.name>)
 id 1s5rD1-0004TJ-Ul; Sat, 11 May 2024 14:12:36 -0400
Received: from ec2-54-164-151-162.compute-1.amazonaws.com ([54.164.151.162]
 helo=qq.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cyy@cyyself.name>)
 id 1s5rCu-0002ST-LJ; Sat, 11 May 2024 14:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1715451142; bh=ptDqAh+JyrxoTyU7jiEQOt6FQ3DkmM4RRxl41YjMsuQ=;
 h=Subject:From:In-Reply-To:Date:Cc:References:To;
 b=PPT3EDlKwsewtkP2//M0FhOa/XWcmA+gzxqiGJ9o8tRDDNm2OvgGw5oF1tjUZ1QPK
 u+zq48ndFSzmi3qy7BcZuke/m7Acv00KcTyzI4dCX6424TW9wZIG2jbjLGJbWLRng9
 HfZg98+ayZYr6fCwTI8fsw7BPGpNNksUiqbZ/4fU=
Received: from smtpclient.apple ([114.253.253.76])
 by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
 id EC62B8B7; Sun, 12 May 2024 01:59:06 +0800
X-QQ-mid: xmsmtpt1715450346tsfzjzgsz
Message-ID: <tencent_15B0A3132E564C6D8851A33F9F9360A8F606@qq.com>
X-QQ-XMAILINFO: NvH2zBBgt3uTeVHmaSVjEgATpQzdvoHk9yzssfnb8ytJ7LHXhrm43LozF1xxDC
 s7rIqooNm1a193/eYrnBRnBuW2qGsi1X2YfB55VKnvcKtKqy+Q5e39r99mf8nRl6MdNpyfNunOo8
 mrANejJhqhoKz67N09/Ue4Gud+fBap39PPgCQfqABwyLbIUAhvB4xBkT3P4Tt+vLxwkn3eNvtiRt
 KQgi8E8SbdTMCLm8XvMU/cluy4B/tRXoHy9S95A0/P9NXnCbP27T77w8nu/0N5mS3D90jdZPU4bT
 8MnvW5m2RUt2rufa5szxnQTdZ0c/t5t1/guY1EbyAO/LQP2E6CnAWKbyMJrZN3RyHf3lN5eJHhny
 Pk7bSJtOe3O6MD4jEADifk26QhrC4seO0BY60h9C3RXALLan1Ueom4WHoa6Pr2LuyDkqD7liZ/u8
 5QPRcGllC7DcskAU9LqNflTuaHvx4YSCUoLCPTfcJlgYbf8z4ZqsJ40CiwWDLxQH+xbtKBC9BjW0
 +Po7gyAImgLtqROW1wQEhh3xBHa2UUQcLnL9GnNtBSf0df9dDVBB4fziBjSUfoMXi/uzpj4vwV0+
 s9vY3vLWfG1MXlNSP8xBjmZxCxB/qhzUVfNiPi2NkQSyB6LdGLaeqe8aUVQa/3yCJRqn5aiJPQK0
 Ge5ikD0t5EPWEmJ3Smq/sHm90DaCgAciriWn1yeq9CwTVrTY0uPIKz5yspMVt33E5sBzmmCqYU0k
 uoxddFYAVqVXmHIMrddsz9cqyEphha2pgFpwonAB3EC3M0s0sZbwKYiQ22cHo7uhaQjlV9x+JhTq
 OmbzYfj3DT8g39IzoRZAtBSrHMLXrU40v5qy0At1uyuqBIMzGwtKmQwjnACK/JerrfxqDpTSXuGR
 5iZxmzcPFXskJCkpeBBAnSCG1CYsu65J1fC3Klj9sQ4+Hlm09oNK0HQfRrxnf/vqTMUq94ArR0EF
 V4ADLd5i/bhR0F4EI69g==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH RESEND] target/riscv/cpu.c: fix Zvkb extension config
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <tencent_7E34EEF0F90B9A68BF38BEE09EC6D4877C0A@qq.com>
Date: Sun, 12 May 2024 01:58:56 +0800
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <D1676BE2-3962-4FC5-AAB0-32A89C8B50DC@cyyself.name>
References: <tencent_7E34EEF0F90B9A68BF38BEE09EC6D4877C0A@qq.com>
To: qemu-riscv@nongnu.org
X-Mailer: Apple Mail (2.3774.500.171.1.1)
Received-SPF: none client-ip=54.164.151.162; envelope-from=cyy@cyyself.name;
 helo=qq.com
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 FORGED_SPF_HELO=1, RDNS_DYNAMIC=0.982, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Note: This patch should also backport to stable-v8.2.

> On May 11, 2024, at 19:26, Yangyu Chen <cyy@cyyself.name> wrote:
>=20
> This code has a typo that writes zvkb to zvkg, causing users can't
> enable zvkb through the config. This patch gets this fixed.
>=20
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> Fixes: ea61ef7097d0 ("target/riscv: Move vector crypto extensions to =
riscv_cpu_extensions")
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
> target/riscv/cpu.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index eb1a2e7d6d..13cd34adbd 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1535,7 +1535,7 @@ const RISCVCPUMultiExtConfig =
riscv_cpu_extensions[] =3D {
>     /* Vector cryptography extensions */
>     MULTI_EXT_CFG_BOOL("zvbb", ext_zvbb, false),
>     MULTI_EXT_CFG_BOOL("zvbc", ext_zvbc, false),
> -    MULTI_EXT_CFG_BOOL("zvkb", ext_zvkg, false),
> +    MULTI_EXT_CFG_BOOL("zvkb", ext_zvkb, false),
>     MULTI_EXT_CFG_BOOL("zvkg", ext_zvkg, false),
>     MULTI_EXT_CFG_BOOL("zvkned", ext_zvkned, false),
>     MULTI_EXT_CFG_BOOL("zvknha", ext_zvknha, false),
> --=20
> 2.43.0
>=20


