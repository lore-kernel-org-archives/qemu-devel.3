Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602B8C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 07:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uENxh-0004Lr-F4; Mon, 12 May 2025 03:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uENxf-0004LN-4W
 for qemu-devel@nongnu.org; Mon, 12 May 2025 03:52:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uENxc-0005iD-Cs
 for qemu-devel@nongnu.org; Mon, 12 May 2025 03:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747036347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Stoqv4oWQAsN4E8qPCy6LX38dhG3tXNvecHxrv7g2O0=;
 b=HglRukLoaLhFza8Mr4M2/zXTJj9iurQ7Qvx6f7yVLQyWWhGM2Yh3r2YAJrWTwPmGi0btlJ
 M6rxwhVoTBWFnfSKlOMCsTfsrYNRIBeW5jNZdDrxhOXFD0p4rEiXFfjCkaCSE0rUcMCu6q
 rlyPYO6ZzPz2qtQBP0HRYV3y0Z3zCnY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-weMLgVVJPiGThih560nZMQ-1; Mon, 12 May 2025 03:52:24 -0400
X-MC-Unique: weMLgVVJPiGThih560nZMQ-1
X-Mimecast-MFC-AGG-ID: weMLgVVJPiGThih560nZMQ_1747036343
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-441d438a9b7so20336595e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 00:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747036343; x=1747641143;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Stoqv4oWQAsN4E8qPCy6LX38dhG3tXNvecHxrv7g2O0=;
 b=tnqeerf1ShtH90Rf2c4wLXcSFJjNmQefK9UqH3BilGOgy8qfKmH+96hr2WndMWQhOE
 5lrWYlB0O4m+fDD0N1iMugcFF8m9UU11B+r/ianzREPtEqT0ifVIInekteIt+msWezAc
 /abNMaGJcN8X6+MuTrSi6Rz40oXUnCjymG4qsj6ZegdCd39XUqrNDYatBR4cICgdej15
 x+YtfgXcQJ4yx7nzf9xG/v10WcIP2ALArMzMohgRjFU0nL5lETAaVoUneo1awMG6IQNT
 yXjhHAPp+vfjVgm1TWuqz876p0r7KXifgiivKTJnTIHcswtUj93XQEgKffvtnfOzQejw
 qtPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIlclXIeVdOIpPm1ilyVL7VynH3N/e12VR9R79dbKjHBTJiwuviGjfq3h7ARfbBs+MlC2/8bwhCbcA@nongnu.org
X-Gm-Message-State: AOJu0YxPL9556hP/AY6VHL21qdCYqzbGnoKQDaCQotsLw9cK5PNq9hMm
 w0YOk6r6M7ORkrvPXMFST8WV9eTeYBFmaFHAWjphadcLsYfwsEL92gOYVioCWVjdp4atkPJywt5
 1hMZCOavOL+vzN20GDkhEHE5Z/n9Zmi4sa8NRQr8pdQJh4e3c5PgX
X-Gm-Gg: ASbGncsSeCy0f+7v+RtBbBmHm5DaphPTj8NzwEw3AK14l9wBwBMjXt1qKPvFE9t6b6F
 ML6kDKxo3WbrbCu03ycFOKdjLbBl64O01d3LIFNiEl3vyGM5Sg5Bi3GOiTcm0z4nFIfAeKbwT7K
 Nh7qXsEsomQ/tDM6kXzDTDslaJP7UMWeMPQonYC7Un808+KoLnvpHH5Afx9Unjd47wDW+5Uebbi
 84Yvdx0k3s8agjw4FSJlpCL7RBRbCSxp0YwLEer//FbW/h5ffzpkbuGlJTrjqpvNke9Jq97RQqF
 nUrE/zDnRdn3HDcIHR2xKAw7+AhRVruH4ojogteU+51xJmrK0Fhq
X-Received: by 2002:a05:600c:a08c:b0:439:9434:4f3b with SMTP id
 5b1f17b1804b1-442d6db89d4mr103475755e9.8.1747036343415; 
 Mon, 12 May 2025 00:52:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKZJxom0xAm6DtI+iUDbrWPkY5Rz1h/l0fZ8VFVlFAWuy6sgb0rFq6y1ITuKovi0XChh7vFg==
X-Received: by 2002:a05:600c:a08c:b0:439:9434:4f3b with SMTP id
 5b1f17b1804b1-442d6db89d4mr103475625e9.8.1747036343076; 
 Mon, 12 May 2025 00:52:23 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-173.pools.arcor-ip.net.
 [47.64.115.173]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d77e4ec3sm77595355e9.1.2025.05.12.00.52.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 00:52:22 -0700 (PDT)
Message-ID: <30df1dfb-7537-41dd-994d-77886698c7c2@redhat.com>
Date: Mon, 12 May 2025 09:52:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel/testing/functional: Fix typo
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20250509152201.19085-1-gustavo.romero@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250509152201.19085-1-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 09/05/2025 17.21, Gustavo Romero wrote:
> Fix the duplication of the word 'run'.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   docs/devel/testing/functional.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
> index 8030cb4299..9e56dd1b11 100644
> --- a/docs/devel/testing/functional.rst
> +++ b/docs/devel/testing/functional.rst
> @@ -274,7 +274,7 @@ speed mode in the meson.build file, while the "quick" speed mode is
>   fine for functional tests that can be run without downloading files.
>   ``make check`` then only runs the quick functional tests along with
>   the other quick tests from the other test suites. If you choose to
> -run only run ``make check-functional``, the "thorough" tests will be
> +run only ``make check-functional``, the "thorough" tests will be
>   executed, too. And to run all functional tests along with the others,
>   you can use something like::

Thanks, queued!

  Thomas


