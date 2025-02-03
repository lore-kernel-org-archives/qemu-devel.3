Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89B0C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 10:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tetyz-0000SI-TP; Mon, 03 Feb 2025 05:47:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tetyy-0000Rs-HX
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 05:47:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tetyw-0001Ho-UH
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 05:47:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738579630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lALtSnQtuxlCL/Nlxiz3qM1yAryoIjICgGEw53WZg2U=;
 b=RDBVqS9NXWpL6HLDhZ2j/KsEsRtPmUMk0XsqL3dmSeD5adp3nSBdDGm9fjxYxOQZoXC9of
 ovoVaTNLwr1r/TSr8itH67eZQ2liKt62H2wqeYiG/rmBizPb3XAUaDj6gD6txwQlkQ/Cld
 Sxvp951nvyxMokGS78pGZzXRmhMTYac=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-SjgML0NCNSK8jYhVUQRCVg-1; Mon, 03 Feb 2025 05:47:08 -0500
X-MC-Unique: SjgML0NCNSK8jYhVUQRCVg-1
X-Mimecast-MFC-AGG-ID: SjgML0NCNSK8jYhVUQRCVg
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38c5dcb33a5so2658792f8f.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 02:47:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738579627; x=1739184427;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lALtSnQtuxlCL/Nlxiz3qM1yAryoIjICgGEw53WZg2U=;
 b=A7wXrd3l4ft4ttqtK4oL+YiHRdYwFVN0Qr9TOhYKyc3VY0Y63NgA+oK+qPo8/7dMbc
 rgJzz3SvGAbYrJeIsmVuVomxiaAtrvJB5e578DZ2rzVyK8Fq9svE3ntCDgJetQ3hIXyC
 l9Pn0lDJatwsH9EECIPX6NKdLvuYMLMLLif9ChoFnMS4XifiXD5F+bWIt4IM4ydAFtv6
 e1KFfy5tkN38cTURQ+JDgi5zx+J/sJ9BHUSc2lDTmcxKV10BMumQcX1rUlr9Zr0+pbb/
 28P6wNrrmG52VH/rDqB1mzlHP3HCVKXRCnO9tt5eZZ2jHuN4Ti+13GunVvfOJguAwtPV
 FmPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzh/tSxHOb/db9Z5hm2Rbqi26AOLyWbkdt2425AmBYdcOfhmO+zi3wgzUPQ2c9a26fMwnCHUtvT9eJ@nongnu.org
X-Gm-Message-State: AOJu0Yxk1p/XvS2VhC4F25XvCr1jCsm6E+FSI/PzBVI+0PEM2hGfE2RQ
 /a7y2tqGWGHUjSgn+3kkIk9Ppk09KjECJ6Ae67NzQqIdBsJO+Nas54gvgmkIv1VX84WEWjqZ9rL
 I/F+lizz+Gk5qylYlM6XH68/RoNf1yLUBCeBRX+XWCZOU9zxc4ifm
X-Gm-Gg: ASbGncv0xRdQ+ASAcksukFbAe9bJ/fEpLaxlt0uNiDwqHqiK+drp7lTQmVebQF86bqC
 QgXMW/gF3wtl7teplta5+PwnIOyjB2Jk+ce86vZMpUN+1xCvo50+rJmUAB1MCLDr6li8e6cRiXu
 q9vNtX/WXz7O4NYU+Hl74LDyN1Wi6jJcV4vR4VNqOzewMcQQ46KWfgPXW3c79QP84v30pHKgMUO
 6W+6lO+nSy+DFkfYWneZRjZLjhLZf4qh95Jdc2mzQZRKr57p4w/a3dsnXMkrFeS4zUTj36tEZ+N
 I5IiSQAPDLZTaKhRJpEbmc17Tqxxzg==
X-Received: by 2002:a5d:5f50:0:b0:386:3918:16b1 with SMTP id
 ffacd0b85a97d-38c520906e8mr19703217f8f.39.1738579627612; 
 Mon, 03 Feb 2025 02:47:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2GdISr/1x1b4HTTaeZEXF/UMpASO43vHfj1iQS0oUW9HYh6/2ld+7v1itrOG8yT73jacTkg==
X-Received: by 2002:a5d:5f50:0:b0:386:3918:16b1 with SMTP id
 ffacd0b85a97d-38c520906e8mr19703186f8f.39.1738579627235; 
 Mon, 03 Feb 2025 02:47:07 -0800 (PST)
Received: from [10.33.192.228] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438d755375bsm145503475e9.0.2025.02.03.02.47.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 02:47:06 -0800 (PST)
Message-ID: <fa1367c9-3391-40a0-af49-2d7f4ffb82ea@redhat.com>
Date: Mon, 3 Feb 2025 11:47:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/14] meson: Deprecate 32-bit host support
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <20250203031821.741477-14-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250203031821.741477-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 03/02/2025 04.18, Richard Henderson wrote:
> We deprecated i686 system mode support for qemu 8.0.  However, to
> make real cleanups to TCG we need to deprecate all 32-bit hosts.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   docs/about/deprecated.rst | 7 +++++++
>   meson.build               | 6 ++----
>   2 files changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


