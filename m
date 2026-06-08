Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F1ECD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWb8K-0002ud-Ma; Mon, 08 Jun 2026 10:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lhestz@163.com>) id 1wWb8B-0002o4-63
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 10:39:14 -0400
Received: from m16.mail.163.com ([220.197.31.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lhestz@163.com>) id 1wWb88-0001Q3-2U
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 10:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
 Content-Type; bh=nBbLOJxJg/UDsza20S8zygdRqNfzX/rqdzBOy98TzEc=;
 b=b33O21rnP6GiXIFLWcOuw5hsbNxOUcm488e0+X2vVqGN/KapMlhCX477FLt6e5
 rHZ7YT5FzAmAqPgR7jLv3VjBBRrx31z0HZbnuaKLvpg+Gg/7m6N2kBzVesuDdB3N
 h0avT2tIfMiHiaNfO40KL2OG5E+yOJLMaMw/guk0TzZtk=
Received: from [IPV6:2409:8a00:18c7:4890:5c16:8947:ceb9:8733] (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wDHA6Ii0yZqhfEaCQ--.2580S2; 
 Mon, 08 Jun 2026 22:35:16 +0800 (CST)
Message-ID: <9b5b6607-13f5-4b61-88be-d8386a0d1b00@163.com>
Date: Mon, 8 Jun 2026 22:35:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] hw/virtio-crypto: add akcipher keylen validation
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com, zhenwei.pi@linux.dev
References: <20260606074756.43804-1-lhestz@163.com>
 <20260606043251-mutt-send-email-mst@kernel.org>
 <392e03eb-63e4-4db0-89d2-b7ddc32b91e8@163.com>
 <20260606102015-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: helei <lhestz@163.com>
In-Reply-To: <20260606102015-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDHA6Ii0yZqhfEaCQ--.2580S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF1Utr1fAr4fWr1UCr4xtFb_yoW5CrWfpa
 yrtFZavF1ktF42k3ZayayaqryYyrWrJr17Jry2qF1xCrs0vr1xZFy7KryY9FyDAFn3A34I
 qr4qqas8Wa9FyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR_b1nUUUUU=
X-Originating-IP: [2409:8a00:18c7:4890:5c16:8947:ceb9:8733]
X-CM-SenderInfo: pokh23r26rljoofrz/xtbC9AQiTWom0ySZbAAA3R
Received-SPF: pass client-ip=220.197.31.2; envelope-from=lhestz@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 6/7/26 10:18, Michael S. Tsirkin wrote:
> On Sun, Jun 07, 2026 at 08:15:19AM +0800, helei wrote:
>>
>> On 6/6/26 16:37, Michael S. Tsirkin wrote:
>>> On Sat, Jun 06, 2026 at 03:47:55PM +0800, helei wrote:
>>>> The virtio-crypto spec does not dictate a maximum length limit for
>>>> asymmetric cipher (akcipher) keys. We added a hard limit which mirrors
>>>> the linux kernels's internal limit for akcipher keys (see
>>>> keyctl framework and the add_key syscall).
>>> We have max_size - doesn't that apply?
>>> backends/cryptodev-builtin.c actually sets it:
>>> backends/cryptodev-builtin.c:#define CRYPTODEV_BUITLIN_MAX_REQUEST_SIZE  (1024 * 1024)
>>> backends/cryptodev-builtin.c:    backend->conf.max_size = CRYPTODEV_BUITLIN_MAX_REQUEST_SIZE;
>>
>> Thanks for your review!  I have verified via testing that all processing
>> requests in the dataq are strictly
>>
>> bounded by max_size, but session creation requests in the ctrlq are not.
> 
> 
> 
> well if we read the spec it's vague
> 
>   max_size is defined as "the maximum size of the variable-length parameters of data operation of
>   each crypto request's content." and
>   The driver SHOULD read max_size to discover the maximum size of the variable-length parameters of
>   data operation of the crypto request's content
> 
> 
>   so data operation.
> 
>   however:
> 
>   "The device MUST set max_size to show the
>   maximum size of crypto request the device supports".
> 
>   seems to cover all requests?
> 
the original architectural intent was almost certainly for max_size to
govern data-plane payloads, while control messages are handled by their
own independent limits (max_cipher_key_len and max_auth_key_len).
both upstream linux guest driver (virtio_crypto_skcipher_algs.c) and
qemu's builtin-backend actually implement it exactly this way:
- data path enforces max_size by checking it against payload length
(note that cryptodev-builtin recently capped this to 1MB via CVE-2025-14876)
- control path completely ignores max_size when creating sessions

> 
> 
> btw vhost user sets max_size to max u64 - is that sane?
> 
this is sane for an out-of-process data plane from a transport
perspective, but it creates a practical catch when backed by a dpdk
implementation:
- in dpdk vhost_crypto.c, vhost_crypto_check_cipher_request() enforces a
strict check: src_data_len <= RTE_MBUF_DEFAULT_BUF_SIZE (2176 bytes)
- the guest kernel driver simply wraps the incoming sg list and passes
it to virtqueue directly.
this creates a tricky situation for users: because vhost-user claims
max_size is max_u64, the users has no way of knowing this 2KB ceiling
exists unless they explicitly know the host backend is dpdk and look at
its source code.

>   
> 
>>>
>>>> Maybe we should update the virtio-spec and add a max_akcipher_key_len
>>>> field for virtio crypto devices.
>>> maybe
>>>
>>>> helei (1):
>>>>    hw/virtio-crypto: enforce max akcipher key length
>>>>
>>>>   hw/virtio/virtio-crypto.c | 13 +++++++++++++
>>>>   1 file changed, 13 insertions(+)
>>>>
>>>> -- 
>>>> 2.43.0
> 


