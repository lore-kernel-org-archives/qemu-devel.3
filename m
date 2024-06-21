Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B862C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZND-00043w-Cj; Fri, 21 Jun 2024 04:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9ak7=NX=kaod.org=clg@ozlabs.org>)
 id 1sKZNB-00040E-0G
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:11:53 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9ak7=NX=kaod.org=clg@ozlabs.org>)
 id 1sKZN8-0000up-Rf
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:11:52 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W59756NJyz4wyg;
 Fri, 21 Jun 2024 18:11:45 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W597245G7z4wcq;
 Fri, 21 Jun 2024 18:11:42 +1000 (AEST)
Message-ID: <20260ac8-035c-404f-8aef-27fd6eb63ef8@kaod.org>
Date: Fri, 21 Jun 2024 10:11:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bswap: Add st24_be_p() to store 24 bits in big-endian
 order
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Joel Stanley <joel@jms.id.au>, 
 Fan Ni <fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ira Weiny <ira.weiny@intel.com>
References: <20240621075607.17902-1-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240621075607.17902-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=9ak7=NX=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/21/24 9:56 AM, Philippe Mathieu-Daudé wrote:
> Commit 14180d6221 ("bswap: Add the ability to store to an
> unaligned 24 bit field") added st24_le_p() for little
> endianness, add st24_be_p() equivalent for bit one.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Some SD card registers are 3 bytes wide stored MSB first.
> ---


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


>   include/qemu/bswap.h | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index bd67468e5e..ad22910a5d 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -38,12 +38,14 @@ static inline void bswap64s(uint64_t *s)
>   #if HOST_BIG_ENDIAN
>   #define be_bswap(v, size) (v)
>   #define le_bswap(v, size) glue(__builtin_bswap, size)(v)
> +#define be_bswap24(v) (v)
>   #define le_bswap24(v) bswap24(v)
>   #define be_bswaps(v, size)
>   #define le_bswaps(p, size) \
>               do { *p = glue(__builtin_bswap, size)(*p); } while (0)
>   #else
>   #define le_bswap(v, size) (v)
> +#define be_bswap24(v) bswap24(v)
>   #define le_bswap24(v) (v)
>   #define be_bswap(v, size) glue(__builtin_bswap, size)(v)
>   #define le_bswaps(v, size)
> @@ -357,6 +359,11 @@ static inline void stw_be_p(void *ptr, uint16_t v)
>       stw_he_p(ptr, be_bswap(v, 16));
>   }
>   
> +static inline void st24_be_p(void *ptr, uint32_t v)
> +{
> +    st24_he_p(ptr, be_bswap24(v));
> +}
> +
>   static inline void stl_be_p(void *ptr, uint32_t v)
>   {
>       stl_he_p(ptr, be_bswap(v, 32));


