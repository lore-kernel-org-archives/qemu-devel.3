Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18792F30955
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 12:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy7eg-00024b-6R; Thu, 05 Mar 2026 07:18:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy7ee-00024R-8j
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 07:18:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy7ec-0008RO-9U
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 07:18:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772713088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=I8psiQYKQFFhGrkmBypawiCDhMk+ZWDeimBLO7VAEis=;
 b=UhnUyPLtPP7AFQfqqUs6F48Tf+nz92bG2MJ/Ty382IOE1Fdxt1SzOdNn/tuEB547Em9bNS
 lZIo9/XIUp1XROtFsPqD1PiccaNzbUKTWMnZCyF5RdkkfXoP3LTnS4K3Hc7zwzTuT8ulVT
 f9BT6cAEzl8PC3ib0fmxxlKNERip34Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-xryfRfwuMbKUdVZgSACyUQ-1; Thu,
 05 Mar 2026 07:18:05 -0500
X-MC-Unique: xryfRfwuMbKUdVZgSACyUQ-1
X-Mimecast-MFC-AGG-ID: xryfRfwuMbKUdVZgSACyUQ_1772713084
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E453A195605C; Thu,  5 Mar 2026 12:18:03 +0000 (UTC)
Received: from [10.45.224.75] (unknown [10.45.224.75])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 91C743003E9C; Thu,  5 Mar 2026 12:18:01 +0000 (UTC)
Message-ID: <363d2abf-0e7a-4f1b-bd27-59b3e276e300@redhat.com>
Date: Thu, 5 Mar 2026 13:17:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/rtl8319: Work around GCC sanitizer /
 -Wstringop-overflow bug
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Yodel Eldar <yodel.eldar@yodel.dev>
References: <20260305111832.1068093-1-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260305111832.1068093-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 05/03/2026 12.18, Peter Maydell wrote:
> If you compile QEMU with GCC with -fsanitize=address and
> -Wstringop-overflow, this causes GCC to produce a false-positive
> warning which it does not produce when the sanitizer is not enabled
> (and which makes compilation fail if you're using -Werror, as we do
> by default for builds from git):
> 
> ../../hw/net/rtl8139.c: In function ‘rtl8139_io_writeb’:
> ../../hw/net/rtl8139.c:2264:17: error: writing 8 bytes into a region of size 0 [-Werror=stringop-overflow=]
>   2264 |                 memcpy(data_to_checksum, saved_ip_header + 12, 8);
>        |                 ^
> In file included from ../../hw/net/rtl8139.c:62:
> /home/pm215/qemu/include/net/eth.h:50:14: note: at offset [8, 48] into destination object ‘ip_ver_len’ of size 1
>     50 |     uint8_t  ip_ver_len;     /* version and header length */
>        |              ^~~~~~~~~~
> ../../hw/net/rtl8139.c:2192:21: error: writing 8 bytes into a region of size 0 [-Werror=stringop-overflow=]
>   2192 |                     memcpy(data_to_checksum, saved_ip_header + 12, 8);
>        |                     ^
> /home/pm215/qemu/include/net/eth.h:50:14: note: at offset [8, 48] into destination object ‘ip_ver_len’ of size 1
>     50 |     uint8_t  ip_ver_len;     /* version and header length */
>        |              ^~~~~~~~~~
> ../../hw/net/rtl8139.c:2192:21: error: writing 8 bytes into a region of size 0 [-Werror=stringop-overflow=]
>   2192 |                     memcpy(data_to_checksum, saved_ip_header + 12, 8);
>        |                     ^
> /home/pm215/qemu/include/net/eth.h:50:14: note: at offset [8, 48] into destination object ‘ip_ver_len’ of size 1
>     50 |     uint8_t  ip_ver_len;     /* version and header length */
>        |              ^~~~~~~~~~
> In file included from /home/pm215/qemu/include/system/memory.h:21,
>                   from /home/pm215/qemu/include/hw/pci/pci.h:4,
>                   from /home/pm215/qemu/include/hw/pci/pci_device.h:4,
>                   from ../../hw/net/rtl8139.c:54:
> In function ‘stl_he_p’,
>      inlined from ‘stl_be_p’ at /home/pm215/qemu/include/qemu/bswap.h:371:5,
>      inlined from ‘rtl8139_cplus_transmit_one’ at ../../hw/net/rtl8139.c:2244:21,
>      inlined from ‘rtl8139_cplus_transmit’ at ../../hw/net/rtl8139.c:2345:28,
>      inlined from ‘rtl8139_io_writeb’ at ../../hw/net/rtl8139.c:2728:17:
> /home/pm215/qemu/include/qemu/bswap.h:284:5: error: writing 4 bytes into a region of size 0 [-Werror=stringop-overflow=]
>    284 |     __builtin_memcpy(ptr, &v, sizeof(v));
>        |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /home/pm215/qemu/include/net/eth.h: In function ‘rtl8139_io_writeb’:
> /home/pm215/qemu/include/net/eth.h:50:14: note: at offset [24, 64] into destination object ‘ip_ver_len’ of size 1
>     50 |     uint8_t  ip_ver_len;     /* version and header length */
>        |              ^~~~~~~~~~
> 
> This has been triaged as a bug in GCC:
>   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=114494
>   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99673
> (the sanitizer pass rewrites the IR in a way that conflicts with its
> use by the warning pass that runs afterwards).
> 
> Since this is the only place in our code where we hit this, work
> around it by rewriting the relevant bit of code, and noting in a
> comment why we do so.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3006
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Here's a patch that takes the "just work around this one problem"
> approach to the gcc sanitizer compile failure.
> 
> On the fence about whether this is worth backporting to stable.
> ---
>   hw/net/rtl8139.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
> index 2ad6338ebe..eb4dfcfbe0 100644
> --- a/hw/net/rtl8139.c
> +++ b/hw/net/rtl8139.c
> @@ -2092,7 +2092,20 @@ static int rtl8139_cplus_transmit_one(RTL8139State *s)
>               eth_payload_data = saved_buffer + ETH_HLEN;
>               eth_payload_len  = saved_size   - ETH_HLEN;
>   
> -            ip = (struct ip_header*)eth_payload_data;
> +            /*
> +             * It would be more natural to write this as
> +             *   ip = (struct ip_header *)eth_payload_data;
> +             * (the IP header is at the start of the ethernet payload).
> +             * However, writing it that way triggers a GCC bug where an
> +             * interaction between -fsanitize=address and -Wstringop-overflow
> +             * results in a false-positive stringop-overflow warning that is
> +             * only emitted when the address sanitizer is enabled:
> +             *     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=114494
> +             *     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99673
> +             * So we work around this by writing the expression in an equivalent
> +             * way that doesn't run into this bug.
> +             */
> +            ip = (struct ip_header *)saved_buffer + ETH_HLEN;

Uh, isn't that a different pointer location? I mean, this first casts to 
struct ip_header*, then does the math on that pointer type, i.e. it adds 
ETH_HLEN * sizeof(struct ip_header) bytes?

I think you need this instead:

         ip = (struct ip_header *)(saved_buffer + ETH_HLEN);

But is the warning still gone in that case?

  Thomas


