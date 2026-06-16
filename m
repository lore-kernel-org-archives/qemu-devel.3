Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C64CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 12:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZT8i-000788-4s; Tue, 16 Jun 2026 08:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lhestz@163.com>) id 1wZT8e-00077q-4N
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:43:32 -0400
Received: from m16.mail.163.com ([220.197.31.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lhestz@163.com>) id 1wZT8Z-0001J7-Jv
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
 Content-Type; bh=RSGF7mdk/lEjcW0UfxlUKWIMHXH7hkN6NczVDjQzuUo=;
 b=eWIi/QHsis+Mkp3aRiLY5l0adZ5Gkrydw4iM+scAM0B6JQTIqCuPndM6Roop+o
 LhlzXC5tJySKEYGgPfSkXGsrqqG+nt3Z5mHg7NwmRx3fp7gnT418zwQa9MUgQvC5
 KZkchswCVtg9v1ohn0MRQYoBp1GRgSFJDLUMf3YxgP39U=
Received: from [IPV6:2409:8a00:18c1:5350:3587:e387:c9c3:2fb] (unknown [])
 by gzsmtp5 (Coremail) with SMTP id QCgvCgDXJxfcRDFqdowTCg--.42374S2;
 Tue, 16 Jun 2026 20:43:08 +0800 (CST)
Message-ID: <d5f1ed9a-aa32-4ba5-8365-5ccb82d164eb@163.com>
Date: Tue, 16 Jun 2026 20:43:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/virtio-crypto: enforce max akcipher key length
To: qemu-devel@nongnu.org
Cc: arei.gonglei@huawei.com, zhenwei.pi@linux.dev, mst@redhat.com
References: <20260616123251.26446-1-lhestz@163.com>
 <20260616123251.26446-2-lhestz@163.com>
Content-Language: en-US
From: helei <lhestz@163.com>
In-Reply-To: <20260616123251.26446-2-lhestz@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: QCgvCgDXJxfcRDFqdowTCg--.42374S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr4fGw1UWFWrtrWfXFyxKrg_yoWDKwb_J3
 yv93yxWws5ZF1vva1UArWrXr1a9a4xAFWv9Fn5X3WxAas7tan8JF1xJws3WF47ArWxJr45
 GF4Fvws5Kw13ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRApntUUUUU==
X-Originating-IP: [2409:8a00:18c1:5350:3587:e387:c9c3:2fb]
X-CM-SenderInfo: pokh23r26rljoofrz/xtbC9B0vWmoxRN1I5AAA3y
Received-SPF: pass client-ip=220.197.31.3; envelope-from=lhestz@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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



On 6/16/26 20:32, helei wrote:
> enforce the global max_size boundary for akcipher session creation
> 
> Signed-off-by: helei <lhestz@163.com>
> ---
>  hw/virtio/virtio-crypto.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
> index 6fceb39681..79e2acb56c 100644
> --- a/hw/virtio/virtio-crypto.c
> +++ b/hw/virtio/virtio-crypto.c
> @@ -216,6 +216,12 @@ virtio_crypto_create_asym_session(VirtIOCrypto *vcrypto,
>          return -VIRTIO_CRYPTO_NOTSUPP;
>      }
>  
> +    if (unlikely(keylen > vcrypto->conf.max_size)) {
> +        error_report("virtio-crypto length of akcipher key is too large: %u",
> +                     keylen);
> +        return -VIRTIO_CRYPTO_ERR;
> +    }
> +
>      if (keylen) {
>          asym_info->key = g_malloc(keylen);
>          if (iov_to_buf(iov, out_num, 0, asym_info->key, keylen) != keylen) {

sorry, i accidentally missed the cover letter, here is the changelog for
this version:
v2:
- dropped the hardcoded limit mirroring the linux kernel.
- enforced the global max_size boundary for akcipher session creation.


