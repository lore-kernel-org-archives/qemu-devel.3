Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D23C3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 13:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEpKj-0008RW-HV; Tue, 13 May 2025 09:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=uZst=X5=kaod.org=clg@ozlabs.org>)
 id 1uEpJa-00087v-76; Tue, 13 May 2025 09:05:01 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=uZst=X5=kaod.org=clg@ozlabs.org>)
 id 1uEpJX-0003Ga-8i; Tue, 13 May 2025 09:04:57 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ZxcBj3jtDz4xQW;
 Tue, 13 May 2025 23:04:45 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZxcBd1qWlz4xQN;
 Tue, 13 May 2025 23:04:40 +1000 (AEST)
Message-ID: <e05b8809-3e64-456e-8b88-0026b0e14588@kaod.org>
Date: Tue, 13 May 2025 15:04:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/25] hw/misc/aspeed_hace: Split hash execution into
 helper functions for clarity
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20250513062901.2256865-1-jamin_lin@aspeedtech.com>
 <20250513062901.2256865-6-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250513062901.2256865-6-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=uZst=X5=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Jamin

On 5/13/25 08:28, Jamin Lin wrote:
> Refactor "do_hash_operation()" by extracting hash execution and result handling
> into dedicated helper functions:
> 
> - "hash_write_digest_and_unmap_iov()": Writes the digest result to memory and
>    unmaps IOVs after processing.
> - "hash_execute_non_acc_mode()": Handles one-shot (non-accumulated) hash
>    operations.
> - "hash_execute_acc_mode()": Handles accumulated hashing, including update and
>    finalize logic.
> 
> No functional changes introduced.

This patch is breaking 'check-qtest-arm'

   
   stderr:
   **
   ERROR:../tests/qtest/aspeed_hace-test.c:254:test_sha512: assertion failed (digest == test_result_sha512)


Thanks,

C.

   

> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/misc/aspeed_hace.c | 133 ++++++++++++++++++++++++++----------------
>   1 file changed, 83 insertions(+), 50 deletions(-)
> 
> diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
> index 22eea62693..eb513ba00f 100644
> --- a/hw/misc/aspeed_hace.c
> +++ b/hw/misc/aspeed_hace.c
> @@ -228,26 +228,96 @@ static int hash_prepare_sg_iov(AspeedHACEState *s, struct iovec *iov,
>       return iov_idx;
>   }
>   
> -static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
> -                              bool acc_mode)
> +static void hash_write_digest_and_unmap_iov(AspeedHACEState *s,
> +                                            struct iovec *iov,
> +                                            int iov_idx,
> +                                            uint8_t *digest_buf,
> +                                            size_t digest_len)
> +{
> +    if (address_space_write(&s->dram_as, s->regs[R_HASH_DEST],
> +                            MEMTXATTRS_UNSPECIFIED, digest_buf, digest_len)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Failed to write digest to 0x%x\n",
> +                      __func__, s->regs[R_HASH_DEST]);
> +    }
> +
> +    for (; iov_idx > 0; iov_idx--) {
> +        address_space_unmap(&s->dram_as, iov[iov_idx - 1].iov_base,
> +                            iov[iov_idx - 1].iov_len, false,
> +                            iov[iov_idx - 1].iov_len);
> +    }
> +}
> +
> +static void hash_execute_non_acc_mode(AspeedHACEState *s, int algo,
> +                                      struct iovec *iov, int iov_idx)
>   {
>       g_autofree uint8_t *digest_buf = NULL;
> -    struct iovec iov[ASPEED_HACE_MAX_SG];
> -    bool acc_final_request = false;
>       Error *local_err = NULL;
> -    size_t digest_len = 0;
> -    int iov_idx = -1;
> +    size_t digest_len;
> +
> +    if (qcrypto_hash_bytesv(algo, iov, iov_idx, &digest_buf,
> +                            &digest_len, &local_err) < 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: qcrypto hash bytesv failed : %s",
> +                      __func__, error_get_pretty(local_err));
> +        error_free(local_err);
> +        return;
> +    }
> +
> +    hash_write_digest_and_unmap_iov(s, iov, iov_idx, digest_buf, digest_len);
> +}
> +
> +static void hash_execute_acc_mode(AspeedHACEState *s, int algo,
> +                                  struct iovec *iov, int iov_idx,
> +                                  bool final_request)
> +{
> +    g_autofree uint8_t *digest_buf = NULL;
> +    Error *local_err = NULL;
> +    size_t digest_len;
>   
> -    if (acc_mode && s->hash_ctx == NULL) {
> +    if (s->hash_ctx == NULL) {
>           s->hash_ctx = qcrypto_hash_new(algo, &local_err);
>           if (s->hash_ctx == NULL) {
> -            qemu_log_mask(LOG_GUEST_ERROR, "qcrypto hash failed : %s",
> -                          error_get_pretty(local_err));
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto hash new failed : %s",
> +                          __func__, error_get_pretty(local_err));
>               error_free(local_err);
>               return;
>           }
>       }
>   
> +    if (qcrypto_hash_updatev(s->hash_ctx, iov, iov_idx, &local_err) < 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto hash updatev failed : %s",
> +                      __func__, error_get_pretty(local_err));
> +        error_free(local_err);
> +        return;
> +    }
> +
> +    if (final_request) {
> +        if (qcrypto_hash_finalize_bytes(s->hash_ctx, &digest_buf,
> +                                        &digest_len, &local_err)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: qcrypto hash finalize bytes failed : %s",
> +                          __func__, error_get_pretty(local_err));
> +            error_free(local_err);
> +            local_err = NULL;
> +        }
> +
> +        qcrypto_hash_free(s->hash_ctx);
> +
> +        s->hash_ctx = NULL;
> +        s->total_req_len = 0;
> +    }
> +
> +    hash_write_digest_and_unmap_iov(s, iov, iov_idx, digest_buf, digest_len);
> +}
> +
> +static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
> +                              bool acc_mode)
> +{
> +    struct iovec iov[ASPEED_HACE_MAX_SG];
> +    bool acc_final_request = false;
> +    int iov_idx = -1;
> +
>       /* Prepares the iov for hashing operations based on the selected mode */
>       if (sg_mode) {
>           iov_idx = hash_prepare_sg_iov(s, iov, acc_mode, &acc_final_request);
> @@ -261,48 +331,11 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
>            return;
>       }
>   
> +    /* Executes the hash operation */
>       if (acc_mode) {
> -        if (qcrypto_hash_updatev(s->hash_ctx, iov, iov_idx, &local_err) < 0) {
> -            qemu_log_mask(LOG_GUEST_ERROR, "qcrypto hash update failed : %s",
> -                          error_get_pretty(local_err));
> -            error_free(local_err);
> -            return;
> -        }
> -
> -        if (acc_final_request) {
> -            if (qcrypto_hash_finalize_bytes(s->hash_ctx, &digest_buf,
> -                                            &digest_len, &local_err)) {
> -                qemu_log_mask(LOG_GUEST_ERROR,
> -                              "qcrypto hash finalize failed : %s",
> -                              error_get_pretty(local_err));
> -                error_free(local_err);
> -                local_err = NULL;
> -            }
> -
> -            qcrypto_hash_free(s->hash_ctx);
> -
> -            s->hash_ctx = NULL;
> -            s->total_req_len = 0;
> -        }
> -    } else if (qcrypto_hash_bytesv(algo, iov, iov_idx, &digest_buf,
> -                                   &digest_len, &local_err) < 0) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "qcrypto hash bytesv failed : %s",
> -                      error_get_pretty(local_err));
> -        error_free(local_err);
> -        return;
> -    }
> -
> -    if (address_space_write(&s->dram_as, s->regs[R_HASH_DEST],
> -                            MEMTXATTRS_UNSPECIFIED,
> -                            digest_buf, digest_len)) {
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "aspeed_hace: address space write failed\n");
> -    }
> -
> -    for (; iov_idx > 0; iov_idx--) {
> -        address_space_unmap(&s->dram_as, iov[iov_idx - 1].iov_base,
> -                            iov[iov_idx - 1].iov_len, false,
> -                            iov[iov_idx - 1].iov_len);
> +        hash_execute_acc_mode(s, algo, iov, iov_idx, acc_final_request);
> +    } else {
> +        hash_execute_non_acc_mode(s, algo, iov, iov_idx);
>       }
>   }
>   


