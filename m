Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB68C0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWcj-0006aX-7T; Mon, 10 Feb 2025 11:27:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thWcb-0006Xf-NX
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:27:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thWcZ-0003Vk-7u
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739204813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aoru83gcaqxDgvnCQwWxab1EQXY6rBggemlTJ7LIrs4=;
 b=X14VWyS4xaGTR6WgV8KgMQR48RuLn2PwQIK8h0WaqbPdoSelEv1cJPAEfqrWk9grbgNkKk
 pnB3caNrENSZkcPxQySn3xf5bZ2OhZr7fVFWKwsi50GwTHeruj03tYkZBCmuHgtyJLYZl9
 n95XBAD7l2Oz92qgctUIjod9WZpQFa4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-IoBcrkMRNXuF3F3_7bR4Sw-1; Mon, 10 Feb 2025 11:26:52 -0500
X-MC-Unique: IoBcrkMRNXuF3F3_7bR4Sw-1
X-Mimecast-MFC-AGG-ID: IoBcrkMRNXuF3F3_7bR4Sw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4393e8738b3so10354325e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:26:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204810; x=1739809610;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aoru83gcaqxDgvnCQwWxab1EQXY6rBggemlTJ7LIrs4=;
 b=Z0XSeBfg6+BH6R/I5I/6PZveL+SGhYO1TKfqmShJYn/uEvaVy0TX+T7kpQP2RCitzh
 HSlKHt6yxCJAecrw9WotlmMdTNhGooOL81xNy2Cm0Kz8kaFsoXfia9QeYUa1/+wih+W0
 JK7hqQZBtFpzeAFR5EmTJQvcvO5YiIdNs5A11TLsT9UhjfWgfW92piou5aEzPuz2b/4c
 TD4rQd+tmPA/MI5I2U282ZGn8B6rrbjmX1Wqqb0i2M9YfFCEikBS3v52yOREx6QIMZus
 BvxdykdWsC27NU0W3+Su+8Yhg7TstlI4nWZ5URfvfetmonlUyhQdNOHSSiEqAt8prEiz
 pzHw==
X-Gm-Message-State: AOJu0Yy8MJ8mNK+yYRdl1UqXyZoFtBEdvsBwUr0E3/+EBpG0bBssVkhv
 tG+Dq+HTMg6d6dKWFNIezKn06O/1y4WsCgLIsm64I0E3SY0XBjQKXAMfL3TRgchhTmT8fb2dVwh
 2Q6lPbF/c/JfREQJNKc9ajaUcuMmiAtTqSI2bsSTLDNTkAELvVW/BAFL1+7BTqdKC0jOmKBKmy3
 6fgRBj1p14+D/Lfqg0p3VjuVnzpXh6Xw==
X-Gm-Gg: ASbGnct2ta04IqFgmClZx6ZiJpuX1/8pXyUWKE3hmmhdqd+ii6iwMFHh5fo+dx2/yb2
 6lcBtnMKUok0rghmGJqjRk5ewt+FA1p/w+uYJ0sSvpK6srUK8LUyA1AcTRQ1+gKHrp4XUc7MPqN
 nbLar7i5PdbwJzfEq+7jcJ6z4j/1ty6FOePp6CzCMr7j3/KfUbktUGqgBCImf7Vw86Q1E04YPaA
 aOSvO+FSd4MxUSvkMOiOcv3AdrVkiDd78GPQT3zVTAMCYRAnAhctntpOLNy+LSPuogvfCb8cy5S
 oRN1CmrjYZ3g/91GBQuwHlxs7XhRnagn/DHtLGjm0F0=
X-Received: by 2002:a05:600c:458e:b0:434:a5d1:9905 with SMTP id
 5b1f17b1804b1-439249c01e6mr96125585e9.26.1739204810274; 
 Mon, 10 Feb 2025 08:26:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF315nze0rudrVTkzKvgHiAtjShZ1gAIxJ6FlgvHHbKErpdotXr/G0Z9M/i4eLcrB+JcocLYw==
X-Received: by 2002:a05:600c:458e:b0:434:a5d1:9905 with SMTP id
 5b1f17b1804b1-439249c01e6mr96125335e9.26.1739204809870; 
 Mon, 10 Feb 2025 08:26:49 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:ecac:5b28:cd98:868a?
 ([2a01:e0a:280:24f0:ecac:5b28:cd98:868a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm52065265e9.21.2025.02.10.08.26.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 08:26:49 -0800 (PST)
Message-ID: <c7ce5f30-ee52-46c8-b968-08ba01214a3e@redhat.com>
Date: Mon, 10 Feb 2025 17:26:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] util/error: Introduce warn_report_err_once()
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20250206131438.1505542-1-clg@redhat.com>
 <20250206131438.1505542-2-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250206131438.1505542-2-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/6/25 14:14, Cédric Le Goater wrote:
> Depending on the configuration of the host and VM, a passthrough
> device may generate recurring DMA mapping errors at runtime. In such
> cases, reporting the issue once is sufficient.
> 
> We have already the warn/error_report_once() routines taking a format
> and arguments. Using the same design pattern, add a new warning
> variant taking an 'Error *' parameter.
> 
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/qapi/error.h | 12 ++++++++++++
>   util/error.c         | 11 +++++++++++
>   2 files changed, 23 insertions(+)

Hello Markus,

Are you ok with this change ? Should we take it through the vfio queue ?

Thanks,

C.





> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index 71f8fb2c50eee9a544992d0c05263c9793956fe1..f5fe2162623e5770d652f7415ebc25172d97616e 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -466,6 +466,18 @@ void warn_reportf_err(Error *err, const char *fmt, ...)
>   void error_reportf_err(Error *err, const char *fmt, ...)
>       G_GNUC_PRINTF(2, 3);
>   
> +/*
> + * Similar to warn_report_err(), except it prints the message just once.
> + * Return true when it prints, false otherwise.
> + */
> +bool warn_report_err_once_cond(bool *printed, Error *err);
> +
> +#define warn_report_err_once(err)                           \
> +    ({                                                      \
> +        static bool print_once_;                            \
> +        warn_report_err_once_cond(&print_once_, err);       \
> +    })
> +
>   /*
>    * Just like error_setg(), except you get to specify the error class.
>    * Note: use of error classes other than ERROR_CLASS_GENERIC_ERROR is
> diff --git a/util/error.c b/util/error.c
> index e5e247209a9e0796074a9794f5598325f22f8d35..673011b89e95f488817b86c31cd389386b2558bb 100644
> --- a/util/error.c
> +++ b/util/error.c
> @@ -247,6 +247,17 @@ void warn_report_err(Error *err)
>       error_free(err);
>   }
>   
> +bool warn_report_err_once_cond(bool *printed, Error *err)
> +{
> +    if (*printed) {
> +        error_free(err);
> +        return false;
> +    }
> +    *printed = true;
> +    warn_report_err(err);
> +    return true;
> +}
> +
>   void error_reportf_err(Error *err, const char *fmt, ...)
>   {
>       va_list ap;


