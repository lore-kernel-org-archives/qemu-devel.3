Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3E4C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 14:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4ieD-0007Xk-Rl; Wed, 08 May 2024 10:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4ieA-0007XI-Sl
 for qemu-devel@nongnu.org; Wed, 08 May 2024 10:51:55 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4ie7-0000wH-LN
 for qemu-devel@nongnu.org; Wed, 08 May 2024 10:51:53 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41b5dd5af48so34661065e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 07:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715179910; x=1715784710; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dS34AjRQ4QxoLtZewN4KeD+I/rGZftwoBu9CIf4F920=;
 b=IH/ASRT7AbpNTnJxKKnTYB6x4GynOythS3YlW2KsfnCutF1fVVMtOegBAr/5V9KYL3
 BNivbOPNpatmJtjFGvoe2aiacYq2t2X0S2XgXw+x+EafFb1kI6q4162VfACpMSz7Ajzi
 77tU7kTpntZjcnfyDQj2GbrBJfUcFNx6DWRyJJei0f/Mwy9tbYVEKsGpiSDfYr3qLWlg
 qR5R/ptL9Jx6PNiyPVE/UUp/jo+D5GG/Y76OHQdbwYIEHfFz21RAgKbUuJY3WKBn49VD
 wFfZbTXIH8WaSkL0Z4mQoSrsW62Qot8FU2GVEx1QLwsoB10CdbHRWiVMJf4Q5mkLaboW
 KLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715179910; x=1715784710;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dS34AjRQ4QxoLtZewN4KeD+I/rGZftwoBu9CIf4F920=;
 b=TiB4HSqnACe9v6aaTPi+HrnAYXJkks2mDIOlrg1gxyTfqhJfqNaza6np2BT2hLOMdn
 yZOTQBp0fB6GTtos9JlQMESefhmGu4JR+ciElwEufg+RPIY4XdkPk07Vq2yDoUoU+Gk1
 z7OlZ5sBy2XauKTDrSFsYTRUlgxJTYTM4aZO4x+yLBN273xdEZEj65eawosJhMi4+lLo
 D5aggKcZY6uaqLE8fRpt16kQCEiNVjKABY5VTVoPc9cqvXTGVyRt7/rCM2ptpF8H279V
 3aHYyBKp9a8Nx3hEW0D0sC2QteaX9opDt6pYoLi5LCumdn6zvfmBm0RfF9VZoFkb3jIH
 IdmA==
X-Gm-Message-State: AOJu0YxfA+bUCOgAIKmqdhVjxwwvAHI2lNvZCGyWDmNPGAseXtpfaa34
 QSILLUu9zRPht9M0XX0wn8ilMKudSBrkMif5oM0MDcAOEI0KTJzd418RT+3fXcw=
X-Google-Smtp-Source: AGHT+IHOiZk3zJF69I98k/Xz5NruF24A2d55SO2WDZ0ud3FF8+4rMlvGXDtKinz37gAFAlt36jCBSg==
X-Received: by 2002:a05:600c:1c0f:b0:41b:e6f8:bf31 with SMTP id
 5b1f17b1804b1-41f71309ed6mr26023865e9.15.1715179909708; 
 Wed, 08 May 2024 07:51:49 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 s2-20020a5d4242000000b003472489d26fsm15459170wrr.19.2024.05.08.07.51.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 07:51:49 -0700 (PDT)
Message-ID: <07258bb4-bc8f-4b21-a662-402d3164b68a@linaro.org>
Date: Wed, 8 May 2024 16:51:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] util/iov: Do not assert offset is in iov
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240428-iov-v1-0-7b2dd601d80b@daynix.com>
 <20240428-iov-v1-1-7b2dd601d80b@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240428-iov-v1-1-7b2dd601d80b@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ping?

On 28/4/24 13:11, Akihiko Odaki wrote:
> iov_from_buf(), iov_to_buf(), iov_memset(), and iov_copy() asserts
> that the given offset fits in the iov while tolerating the specified
> number of bytes to operate with to be greater than the size of iov.
> This is inconsistent so remove the assertions.
> 
> Asserting the offset fits in the iov makes sense if it is expected that
> there are other operations that process the content before the offset
> and the content is processed in order. Under this expectation, the
> offset should point to the end of bytes that are previously processed
> and fit in the iov. However, this expectation depends on the details of
> the caller, and did not hold true at least one case and required code to
> check iov_size(), which is added with commit 83ddb3dbba2e
> ("hw/net/net_tx_pkt: Fix overrun in update_sctp_checksum()").
> 
> Adding such a check is inefficient and error-prone. These functions
> already tolerate the specified number of bytes to operate with to be
> greater than the size of iov to avoid such checks so remove the
> assertions to tolerate invalid offset as well. They return the number of
> bytes they operated with so their callers can still check the returned
> value to ensure there are sufficient space at the given offset.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   include/qemu/iov.h | 5 +++--
>   util/iov.c         | 5 -----
>   2 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/include/qemu/iov.h b/include/qemu/iov.h
> index 63a1c01965d1..33548058d2ee 100644
> --- a/include/qemu/iov.h
> +++ b/include/qemu/iov.h
> @@ -30,7 +30,7 @@ size_t iov_size(const struct iovec *iov, const unsigned int iov_cnt);
>    * only part of data will be copied, up to the end of the iovec.
>    * Number of bytes actually copied will be returned, which is
>    *  min(bytes, iov_size(iov)-offset)
> - * `Offset' must point to the inside of iovec.
> + * Returns 0 when `offset' points to the outside of iovec.
>    */
>   size_t iov_from_buf_full(const struct iovec *iov, unsigned int iov_cnt,
>                            size_t offset, const void *buf, size_t bytes);
> @@ -66,11 +66,12 @@ iov_to_buf(const struct iovec *iov, const unsigned int iov_cnt,
>   /**
>    * Set data bytes pointed out by iovec `iov' of size `iov_cnt' elements,
>    * starting at byte offset `start', to value `fillc', repeating it
> - * `bytes' number of times.  `Offset' must point to the inside of iovec.
> + * `bytes' number of times.
>    * If `bytes' is large enough, only last bytes portion of iovec,
>    * up to the end of it, will be filled with the specified value.
>    * Function return actual number of bytes processed, which is
>    * min(size, iov_size(iov) - offset).
> + * Returns 0 when `offset' points to the outside of iovec.
>    */
>   size_t iov_memset(const struct iovec *iov, const unsigned int iov_cnt,
>                     size_t offset, int fillc, size_t bytes);
> diff --git a/util/iov.c b/util/iov.c
> index 7e73948f5e3d..a523b406b7f8 100644
> --- a/util/iov.c
> +++ b/util/iov.c
> @@ -36,7 +36,6 @@ size_t iov_from_buf_full(const struct iovec *iov, unsigned int iov_cnt,
>               offset -= iov[i].iov_len;
>           }
>       }
> -    assert(offset == 0);
>       return done;
>   }
>   
> @@ -55,7 +54,6 @@ size_t iov_to_buf_full(const struct iovec *iov, const unsigned int iov_cnt,
>               offset -= iov[i].iov_len;
>           }
>       }
> -    assert(offset == 0);
>       return done;
>   }
>   
> @@ -74,7 +72,6 @@ size_t iov_memset(const struct iovec *iov, const unsigned int iov_cnt,
>               offset -= iov[i].iov_len;
>           }
>       }
> -    assert(offset == 0);
>       return done;
>   }
>   
> @@ -266,7 +263,6 @@ unsigned iov_copy(struct iovec *dst_iov, unsigned int dst_iov_cnt,
>           bytes -= len;
>           offset = 0;
>       }
> -    assert(offset == 0);
>       return j;
>   }
>   
> @@ -337,7 +333,6 @@ size_t qemu_iovec_concat_iov(QEMUIOVector *dst,
>               soffset -= src_iov[i].iov_len;
>           }
>       }
> -    assert(soffset == 0); /* offset beyond end of src */
>   
>       return done;
>   }
> 


