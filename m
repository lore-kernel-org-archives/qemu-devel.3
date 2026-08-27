Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1FFC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 17:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzdrH-00029J-K2; Thu, 27 Aug 2026 13:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wzdrF-00028F-9h; Thu, 27 Aug 2026 13:25:45 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wzdrC-0007Yu-T8; Thu, 27 Aug 2026 13:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787851535; bh=yZNP57Tup2zXxfMEjj96PQpqVS5Za8MOsH4ICpc5Vxk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=tUB/TC+OhlJaE8FiK9Hu1O0MBCN1y7T2tIhQfW8K+UC/ProSAYC9wLmk0CFhJ+M7A
 7ap5vz+XBBc4OGJLmVG6CgPy0quQqi6XENZ9+WIYT3ZfC8QzYcaWZ+pIqeDt7ApL3Y
 LtOMGzSc8sJDRwYCz3Jjyu+z9zxV3Z0PxOoyuJRBBhUOiHrRUBCVDni6Gl3YEDI541
 IvOH8eUEr5Jj3elFF20mf9mz3VhzwNHl6TZWZ98a4s+4od+rE6qell6D57V/2T8ggO
 h82VcQfzsCj9a743ine/l26IQdgjv956jS6KlYI+/vU1kmpmza/9jvHUy9DQOuE4Bm
 067niEYrzPuGQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 677E31CF2AC;
 Thu, 27 Aug 2026 20:25:35 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A23DD4194E8;
 Thu, 27 Aug 2026 20:25:38 +0300 (MSK)
Message-ID: <ea555c0f-1e4e-4bd0-8aad-a8c0b27b9c17@tls.msk.ru>
Date: Thu, 27 Aug 2026 20:25:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] loongarch queue
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, QEMU Stable <qemu-stable@nongnu.org>
References: <20260827012811.1008381-1-gaosong@loongson.cn>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20260827012811.1008381-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 8/27/26 04:28, Song Gao wrote:

> Bibo Mao (3):
>        hw/loongarch/boot: Check memory boundary in init_boot_rom()
>        hw/loongarch/virt: Add bootargs and initrd to device-tree
>        target/loongarch: Fix SWI interrupt delivery via CSR_ESTAT

Is it qemu-stable material?
(Currently active stable branches: 10.0, 11.0, 11.1).

Thanks,

/mjt

