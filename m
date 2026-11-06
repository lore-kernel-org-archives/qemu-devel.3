Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F3B606A329
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D7YJvcDN;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RZhM5UZF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPJFg-0003KA-JL; Fri, 06 Nov 2026 07:41:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xPJFd-0003HZ-7G
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 07:41:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xPJFa-0001Pn-MG
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 07:41:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793968857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DhS/s7uC1pGNGesALLVYG9keRGJslnH4ZOt3DYjeF0E=;
 b=D7YJvcDN35vEJ3AnHOkzuYJQ9aKs1n0rqI0p/pYf1aXdxIyBD4x5In7K5VTVLU44R3Vlcr
 ztFlA6KUWk/dqu2qgdZvDqsdC9pW4xUryQYOEHuG37xdoQUFhDrpwEjT8wKMJkUJcrZAA9
 WIcNTRfxFfOKf6HKe3l5OslEIlQB/9M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-VYCl6dTiPo6gtmRff6r9wg-1; Fri, 06 Nov 2026 07:40:56 -0500
X-MC-Unique: VYCl6dTiPo6gtmRff6r9wg-1
X-Mimecast-MFC-AGG-ID: VYCl6dTiPo6gtmRff6r9wg_1793968855
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-490c1867460so331097f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 04:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793968855; x=1794573655; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DhS/s7uC1pGNGesALLVYG9keRGJslnH4ZOt3DYjeF0E=;
 b=RZhM5UZFjEJFw+Cc4u2U7jUW4tc5tUcuYym/oiylDFcT8LyecaH9STZUfD39M5Gewp
 duWZrCSQUfvLsO7/mdYwYpdbmBG40FAneB6MeYTH222C+pb+08i/VOPuyfQkbwrohRP3
 qXxwELseAnLQqC7tB6LoY9aCwN9NihmVU+ntPwW5CkSNlfJaGE4svqt6cqfznKOxLXoP
 qxsKvhO7ebuuTgJmUGakEB51gD6j7PQfV//t0bLzOjoKyKPP7Oh38k0Ud6E8oyRpKZtJ
 jhwBaJjHNm9uOJg+X8zCr9pfkWvhNf0enzipXiqEwVCC5sRmAoZ5R8et1AGFNw/gkfzO
 RFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793968855; x=1794573655;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DhS/s7uC1pGNGesALLVYG9keRGJslnH4ZOt3DYjeF0E=;
 b=CFp+cI/Y+EzeMCpE9+1TPO2pI1F8q3AvC+8+ugZIK8/aS9yI28Udh0VdzWlQx/o+AK
 74M2yIHzISMPGdFecoxD7oU3Bd+3qi5g3XqDRNGiAj5ou6rHoHEplwqDUjSpAYIPRj/w
 nI8ZmusIS9rJKTPqZ+kIhMfy/Hngfum2W/Ovabm9m1s3yb8M0N1jZw5n8ilbrRSL23Kw
 PQfZiKopfaNbjk7OzjLNMzmrIPgO/IViVhNR0ths3fG96vfpUrdZpAIVqwVnkEBJeup2
 zm1Ne8bzj/amNl58uBs3zd7wVEpAcP7X/mOcMHLnNUf/q7c7Jhi6YkhWdcvm2O9E2xP8
 GiNA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxqT3Gua3S3bBxxzHfP9D1HXthrjNZKx73Tj9ewShJfBdr6TdlpJHl0zXdzwmJXy6FzFXHt+QCPITMb@nongnu.org
X-Gm-Message-State: APuU4Z8JYnA3524SPLoY5Fohk444mfRDEWnVJc93/lPWrEaeEbzEnu/f
 B6BSwN2bSBTV4/uruqQ5DbEYwmUPkQr/BLqPtMVU+pb3qeD7MvKBNrpQEcYEJmH6TOh/G3dCN5n
 1PlU2S05m849TMyYjwf9S0AGPQGuEXsuzy0gaKRmZudWTkyviPfPdqjCz
X-Gm-Gg: AYBFou3PHIUVF32EokUc/mDIpN108UY+cIw1Ql801fdNwE+cZLgXmwwUpFlpNZOOIXt
 eDuodRiGJqJx472k7CtqpP1VQ+7QJ30oZarLfLXcqSYaiSbyu7mR8AU4ViNFbjAI0iyIpHsuz7f
 rp6M32+XEhHmIwX61HqH/cl6Ufwi5si9AKSdNIZz+wfwgTPs3/cKljXxRCBnyHTgEsBeLhVCYHH
 UN7qAlPrxLrVWijPRlrPds2vfY4YCQWmMnQO5AmppIMzqaKrZLdcqn3CrLXo+neIVTr2nc6RzOG
 gp+6zOuAZB+XI8eE5w2KENr+EAFQUyDMpnqj72z7Q1QrcZKQh1dU3uO8vZtcLN5bytExXRRep2R
 7mbeH/rt3PLoRxF+b/wwoC1SddEJoHtUaahNa6rvfRqFrkcdalhuoNE7m2pfxgTqF0nWVZLg=
X-Received: by 2002:a05:600c:3ba0:b0:4a7:a5db:a93e with SMTP id
 5b1f17b1804b1-4b6db1c5f48mr44604845e9.4.1793968855417; 
 Fri, 06 Nov 2026 04:40:55 -0800 (PST)
X-Received: by 2002:a05:600c:3ba0:b0:4a7:a5db:a93e with SMTP id
 5b1f17b1804b1-4b6db1c5f48mr44604525e9.4.1793968855107; 
 Fri, 06 Nov 2026 04:40:55 -0800 (PST)
Received: from ?IPV6:2a01:599:b03:7322:436f:1f3:b26e:91b8?
 ([2a01:599:b03:7322:436f:1f3:b26e:91b8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d837e3f5sm3588201f8f.56.2026.11.06.04.40.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 04:40:54 -0800 (PST)
Message-ID: <94d2368c-efaa-4e9f-875f-f390d9183eac@redhat.com>
Date: Fri, 6 Nov 2026 13:40:53 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/28] hw/mem: mark nvdimm, pc-dimm & spapr-nvdimm
 devices as secure
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
References: <20261029131241.2275706-1-berrange@redhat.com>
 <20261029131241.2275706-21-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20261029131241.2275706-21-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 29/10/2026 14.12, Daniel P. Berrangé wrote:
> These devices are used in virutalization scenarios to support memory
> hotplug and other uses cases.
> 
> Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/mem/nvdimm.c       | 1 +
>   hw/mem/pc-dimm.c      | 1 +
>   hw/ppc/spapr_nvdimm.c | 1 +
>   3 files changed, 3 insertions(+)
Reviewed-by: Thomas Huth <thuth@redhat.com>


