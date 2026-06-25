Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83FFCDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcl8s-00050I-Ac; Thu, 25 Jun 2026 10:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wcl8q-0004zp-1U; Thu, 25 Jun 2026 10:33:20 -0400
Received: from m16.mail.163.com ([117.135.210.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wcl8m-0003Ox-H8; Thu, 25 Jun 2026 10:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
 Content-Type; bh=UqOTxwkPZyqYAro8tEkdRyi9MAnqsiVPaDJ951YHNlU=;
 b=LFAYo3yAXf8UP2drbKLXtw/xDf6WeY95JIY1OQ8AjhBQsFm/Ah6FW9hRLvFw7z
 Kj5ZHW7P0zgftE41h6vOze0sE8OoHNmhjDtK1eHhc2X+EktUawrIXBCKN5jZPT+H
 A1OncsdQiJgs8fsw20UEeWN/8z5PM5FzIh+p/TdfO49p4=
Received: from [IPV6:2408:8266:ba01:4163:7477:269:8b28:4336] (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wBXJOUpOz1qEOqkFw--.46829S2; 
 Thu, 25 Jun 2026 22:28:57 +0800 (CST)
Message-ID: <c6e40af8-977d-494c-b408-c8d9dd220a1a@163.com>
Date: Thu, 25 Jun 2026 22:28:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] sdhci: fix SDMA boundary bug
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
References: <20260617155857.7451-1-dingtao0430@163.com>
From: Tao Ding <dingtao0430@163.com>
In-Reply-To: <20260617155857.7451-1-dingtao0430@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _____wBXJOUpOz1qEOqkFw--.46829S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RXl19UUUUU
X-Originating-IP: [2408:8266:ba01:4163:7477:269:8b28:4336]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC4QnCAWo9OymDwAAA3t
Received-SPF: pass client-ip=117.135.210.2; envelope-from=dingtao0430@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


ping

> Hi all,
>
> Booting Linux from SD card on Xilinx Zynq with SDMA (MMC_SDHCI_SDMA=y) currently hangs during image load.
>
> This patch fixes the hang and enables successful image loading.
>
> Thanks!
>
> Tao Ding (1):
>    fixed sdma boundary bug
>
>   hw/sd/sdhci.c | 2 ++
>   1 file changed, 2 insertions(+)
>
>
> base-commit: 608ad9307d5b4797d2254ee3a4bad2bc8c8bcbae


