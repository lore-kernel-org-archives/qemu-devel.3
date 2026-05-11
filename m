Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C32ECD37B5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 10:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMO6v-0007L0-JU; Mon, 11 May 2026 06:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wMO6s-0007Jt-K6
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:43:39 -0400
Received: from smtpout2.mo533.mail-out.ovh.net ([51.210.94.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wMO6o-0001sz-S1
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:43:38 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [51.255.22.22])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4gDXdB3wdVz5yQ5;
 Mon, 11 May 2026 08:17:02 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Mon, 11 May 2026 08:17:02 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.254.225])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gDXdB2QDXz7tj2; Mon, 11 May 2026 08:17:02 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.4])
 (Authenticated sender: clg@kaod.org)
 by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id F418B12E350F;
 Mon, 11 May 2026 08:17:00 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-102R0040c6e6aa8-b39d-4bbf-ad1c-e8e7652c2436,
 AF0BFEC086191C1369F7EC03D32B7A83D87952B1) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <341d0267-cb81-4612-99d1-c1edd5a395dd@kaod.org>
Date: Mon, 11 May 2026 10:16:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] aspeed/hace: Fix mapped address may not be
 unmapped issue
To: Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260508051619.3887383-1-kane_chen@aspeedtech.com>
 <20260508051619.3887383-2-kane_chen@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260508051619.3887383-2-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 10411759392575433739
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGldI8fmkgJ64pQ9oZxHmO9XEPW154H/16oFcRHjR8kczsz6zpdNQYZyF+RS+DvUfe6t/jAYGmNxXc3ydr1Q+msZI1uZHtRjLCweS0WKW/8e/QjII4OQ0NpyDZF8zS6wCRTFQYb76Ws6UsQ4dqVKtTE4xAWf1h2XD/Tk56MBwk/OGHgR6Eh/dQBgJj/78CCFbe3t0V2LpVqxH87DalwQq4YLZCCvEWWPgtcaoFDaPl031F+64JD7mDD6q0AyKuBWZXqYtiUstjNqtVTOvOzVXX1D+TfaofHzcQy7fQjn5538f/5AvFO7pKSBfZJbow+csSPvdznbUDHXVGkEFwdZI16emm0ud76CugFXmv64ajCWf5ZaAtFylHte+CRWT7KJ4g6jjYdo3G5Q0o+X1oO20okYA1kZ500tPlnvT/oPDMUd2iRd8O7VqCc6Joz7rMkbpyDA21RsLp7gILh2Vj9NfbZig4bLC891yrYpoo+RGgBRoeNDjrwGY9kyLQZRf4xfO8mWIdR4RgOQij57NLn9ohQZVFRoVD6b3w1Ug0pUkarg7Sv7SQYcRh4IyPJcbkCWUTsyE1icXORLmD4wRz6NtUrM43HzHzlsdno5LS4xCNrw51RQN8Z2M+7cSQ+qv6ui25ayQ+Jt0B1x8KgonrizlP0l66FYjrADUAW8+bnTayqBw
DKIM-Signature: a=rsa-sha256; bh=/koEqog9QmxZByxsKfzKjoToGrfm76/vp/Z8F41GZMg=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1778487423; v=1;
 b=RWRoKSbbHFWBGl6uZptIEbsK3fTRGW3q0oqJKvZBpbFr9x3gtf4dUqnmb/SJTKjOTNytMg4l
 OKHSNBKh2PtydhoYBpDzRgmFowrWPfFpUtyckY6vpEqTld8f1kms9zy0QoWG+Sx0p0CcFHEYGNz
 freCqwTFanJCs8LHjVHxHT4iG8T5wzpW+gMQ8u5COMibNuUNa0VfMKQXBMFLxy32zuvx97ApH9T
 o+dn62JwWybI1qiVLxTClW372HLXApeZtUhWyO642T5DpL9DIqHi7wG7HO3km54s+X9KFcXvP1F
 mwUNBF9H76fzu0B9LuJEG7U3kATyVoIgtGMGIWm5HMftw==
Received-SPF: pass client-ip=51.210.94.139; envelope-from=clg@kaod.org;
 helo=smtpout2.mo533.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 5/8/26 07:16, Kane Chen wrote:
> In the do_hash_operation, the code may be returned earlier because
> hash_prepare_sg_iov or hash_prepare_direct_iov may return a failure.
> When this condition is happened, current code flow doesn't go through
> later code segments. Finally, it causes the mapped address isn't
> unmapped properly.
> 
> This change is intended to unmap the mapped address if there is any
> error is occurred. Thus, it could prevent a reasoure leak situation.

May be change that last paragraph to :

   This change unmaps any mapped addresses when an error occurs,
   preventing a resource leak.

The change looks correct. An hack from an HACE-aware engineer would
be appreciated.

Thanks,

C.

> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>   hw/misc/aspeed_hace.c | 63 ++++++++++++++++++++++++++++++-------------
>   1 file changed, 45 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
> index 0504d61cbf..a322905cb3 100644
> --- a/hw/misc/aspeed_hace.c
> +++ b/hw/misc/aspeed_hace.c
> @@ -218,8 +218,19 @@ static bool hash_accumulate_len(AspeedHACEState *s, hwaddr plen)
>       return true;
>   }
>   
> +static void hash_iov_unmap(AspeedHACEState *s, struct iovec *iov,
> +                           hwaddr *mapped_lens, int iov_count)
> +{
> +    for (; iov_count > 0; iov_count--) {
> +        address_space_unmap(&s->dram_as, iov[iov_count - 1].iov_base,
> +                            mapped_lens[iov_count - 1], false,
> +                            mapped_lens[iov_count - 1]);
> +    }
> +}
> +
>   static int hash_prepare_direct_iov(AspeedHACEState *s, struct iovec *iov,
> -                                   bool acc_mode, bool *acc_final_request)
> +                                   bool acc_mode, bool *acc_final_request,
> +                                   hwaddr *mapped_lens)
>   {
>       uint32_t total_msg_len;
>       uint32_t pad_offset;
> @@ -243,9 +254,11 @@ static int hash_prepare_direct_iov(AspeedHACEState *s, struct iovec *iov,
>   
>       iov[0].iov_base = haddr;
>       iov_idx = 1;
> +    mapped_lens[0] = plen;
>   
>       if (acc_mode) {
>           if (!hash_accumulate_len(s, plen)) {
> +            hash_iov_unmap(s, iov, mapped_lens, 1);
>               return -1;
>           }
>   
> @@ -265,7 +278,8 @@ static int hash_prepare_direct_iov(AspeedHACEState *s, struct iovec *iov,
>   }
>   
>   static int hash_prepare_sg_iov(AspeedHACEState *s, struct iovec *iov,
> -                               bool acc_mode, bool *acc_final_request)
> +                               bool acc_mode, bool *acc_final_request,
> +                               hwaddr *mapped_lens)
>   {
>       uint32_t total_msg_len;
>       uint32_t pad_offset;
> @@ -275,6 +289,7 @@ static int hash_prepare_sg_iov(AspeedHACEState *s, struct iovec *iov,
>       int iov_idx;
>       hwaddr plen;
>       void *haddr;
> +    int iov_mapped = 0;
>   
>       src = hash_get_source_addr(s);
>       for (iov_idx = 0; !(len & SG_LIST_LEN_LAST); iov_idx++) {
> @@ -282,7 +297,7 @@ static int hash_prepare_sg_iov(AspeedHACEState *s, struct iovec *iov,
>               qemu_log_mask(LOG_GUEST_ERROR,
>                             "%s: Failed to set end of sg list marker\n",
>                             __func__);
> -            return -1;
> +            goto fail;
>           }
>   
>           len = address_space_ldl_le(&s->dram_as, src,
> @@ -307,15 +322,17 @@ static int hash_prepare_sg_iov(AspeedHACEState *s, struct iovec *iov,
>                             "%s: Unable to map address, sg_addr=0x%x, "
>                             "plen=0x%" HWADDR_PRIx "\n",
>                             __func__, sg_addr, plen);
> -            return -1;
> +            goto fail;
>           }
>   
>           src += SG_LIST_ENTRY_SIZE;
>   
>           iov[iov_idx].iov_base = haddr;
> +        iov_mapped = iov_idx + 1;
> +        mapped_lens[iov_idx] = plen;
>           if (acc_mode) {
>               if (!hash_accumulate_len(s, plen)) {
> -                return -1;
> +                goto fail;
>               }
>   
>               if (has_padding(s, &iov[iov_idx], plen, &total_msg_len,
> @@ -332,6 +349,10 @@ static int hash_prepare_sg_iov(AspeedHACEState *s, struct iovec *iov,
>       }
>   
>       return iov_idx;
> +
> +fail:
> +    hash_iov_unmap(s, iov, mapped_lens, iov_mapped);
> +    return -1;
>   }
>   
>   static uint64_t hash_get_digest_addr(AspeedHACEState *s)
> @@ -350,6 +371,7 @@ static uint64_t hash_get_digest_addr(AspeedHACEState *s)
>   static void hash_write_digest_and_unmap_iov(AspeedHACEState *s,
>                                               struct iovec *iov,
>                                               int iov_idx,
> +                                            hwaddr *mapped_lens,
>                                               uint8_t *digest_buf,
>                                               size_t digest_len)
>   {
> @@ -369,15 +391,12 @@ static void hash_write_digest_and_unmap_iov(AspeedHACEState *s,
>           hace_hexdump("digest", (char *)digest_buf, digest_len);
>       }
>   
> -    for (; iov_idx > 0; iov_idx--) {
> -        address_space_unmap(&s->dram_as, iov[iov_idx - 1].iov_base,
> -                            iov[iov_idx - 1].iov_len, false,
> -                            iov[iov_idx - 1].iov_len);
> -    }
> +    hash_iov_unmap(s, iov, mapped_lens, iov_idx);
>   }
>   
>   static void hash_execute_non_acc_mode(AspeedHACEState *s, int algo,
> -                                      struct iovec *iov, int iov_idx)
> +                                      struct iovec *iov, int iov_idx,
> +                                      hwaddr *mapped_lens)
>   {
>       g_autofree uint8_t *digest_buf = NULL;
>       Error *local_err = NULL;
> @@ -389,15 +408,17 @@ static void hash_execute_non_acc_mode(AspeedHACEState *s, int algo,
>                         "%s: qcrypto hash bytesv failed : %s",
>                         __func__, error_get_pretty(local_err));
>           error_free(local_err);
> +        hash_iov_unmap(s, iov, mapped_lens, iov_idx);
>           return;
>       }
>   
> -    hash_write_digest_and_unmap_iov(s, iov, iov_idx, digest_buf, digest_len);
> +    hash_write_digest_and_unmap_iov(s, iov, iov_idx, mapped_lens,
> +                                    digest_buf, digest_len);
>   }
>   
>   static void hash_execute_acc_mode(AspeedHACEState *s, int algo,
>                                     struct iovec *iov, int iov_idx,
> -                                  bool final_request)
> +                                  bool final_request, hwaddr *mapped_lens)
>   {
>       g_autofree uint8_t *digest_buf = NULL;
>       Error *local_err = NULL;
> @@ -411,6 +432,7 @@ static void hash_execute_acc_mode(AspeedHACEState *s, int algo,
>               qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto hash new failed : %s",
>                             __func__, error_get_pretty(local_err));
>               error_free(local_err);
> +            hash_iov_unmap(s, iov, mapped_lens, iov_idx);
>               return;
>           }
>       }
> @@ -419,6 +441,7 @@ static void hash_execute_acc_mode(AspeedHACEState *s, int algo,
>           qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto hash updatev failed : %s",
>                         __func__, error_get_pretty(local_err));
>           error_free(local_err);
> +        hash_iov_unmap(s, iov, mapped_lens, iov_idx);
>           return;
>       }
>   
> @@ -438,22 +461,25 @@ static void hash_execute_acc_mode(AspeedHACEState *s, int algo,
>           s->total_req_len = 0;
>       }
>   
> -    hash_write_digest_and_unmap_iov(s, iov, iov_idx, digest_buf, digest_len);
> +    hash_write_digest_and_unmap_iov(s, iov, iov_idx, mapped_lens,
> +                                    digest_buf, digest_len);
>   }
>   
>   static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
>                                 bool acc_mode)
>   {
>       QEMU_UNINITIALIZED struct iovec iov[ASPEED_HACE_MAX_SG];
> +    hwaddr mapped_lens[ASPEED_HACE_MAX_SG] = { 0 };
>       bool acc_final_request = false;
>       int iov_idx = -1;
>   
>       /* Prepares the iov for hashing operations based on the selected mode */
>       if (sg_mode) {
> -        iov_idx = hash_prepare_sg_iov(s, iov, acc_mode, &acc_final_request);
> +        iov_idx = hash_prepare_sg_iov(s, iov, acc_mode, &acc_final_request,
> +                                      mapped_lens);
>       } else {
>           iov_idx = hash_prepare_direct_iov(s, iov, acc_mode,
> -                                          &acc_final_request);
> +                                          &acc_final_request, mapped_lens);
>       }
>   
>       if (iov_idx <= 0) {
> @@ -468,9 +494,10 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
>   
>       /* Executes the hash operation */
>       if (acc_mode) {
> -        hash_execute_acc_mode(s, algo, iov, iov_idx, acc_final_request);
> +        hash_execute_acc_mode(s, algo, iov, iov_idx, acc_final_request,
> +                              mapped_lens);
>       } else {
> -        hash_execute_non_acc_mode(s, algo, iov, iov_idx);
> +        hash_execute_non_acc_mode(s, algo, iov, iov_idx, mapped_lens);
>       }
>   }
>   


