Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4649C25B7A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 14:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAVeF-0002Xc-Uj; Fri, 24 May 2024 10:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAVeD-0002VO-S5
 for qemu-devel@nongnu.org; Fri, 24 May 2024 10:11:53 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAVeC-0007Wd-4u
 for qemu-devel@nongnu.org; Fri, 24 May 2024 10:11:53 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1f44b5b9de6so6693595ad.3
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 07:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716559910; x=1717164710; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uO9ayR70098jL1SdbcPD2xB8sM3m3q+pUdd79AEgrM4=;
 b=Ivt13vkexsMdzngN/j2+xBjvsJ+pLSzV/GA4XrgUfEbBEWve1eX85kiUYipgEbJpaU
 5u/xPmy0zrCUKkQJwyU/REQUH4tPZnUqs8ciGrF4eF4F2jtW4bmLabukcaIm1cNRYWli
 ODEbWseUljQG6BYOci37cT7rTYYtlw1EfkSSCK7sRKF2SDNj/32Vg8xAj5EYa2DolTTP
 9PvBTyf7DwOMWezF5RuAgWsSoIGtUZfnwzEZxWw3EUU5Yh2ctwPcYoDV+GUW+NapnHMW
 fqRrQkBWrmOGw6e9Scmzeoo6TFdzMmevyNA9xX7tmGoqoftWhcUtiJ+SD9fUuFEkfgz6
 yP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716559910; x=1717164710;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uO9ayR70098jL1SdbcPD2xB8sM3m3q+pUdd79AEgrM4=;
 b=e7ql+CJAUDkyzPt3A8wUYHsV8+A4sTDSNInyeMNLunakSdu55p0SVH3HdoaNLNU0Oo
 V3fv1hSdPe1juItrQTviLy3f/OkgsTpPnbvmU9QN/uA/9nRhrcz3rxTyaslgMaGZbhG+
 Dpz/Bh++KE0IxU6e5b4kfjFSC0LiVrQ/u4zOJxynVWjCURDgVhevKq/ridd2g3lzdkWn
 ZN9KVJ4Kgubu3CBLZXsF+33wZLqC93AaUzVy0Bf0sX9Q1mwfmxfIu+v78wNsQFtoUsp5
 VEmoQHHDW+7IaeZAzJKlMRgHk8z5aOjm5EEx+d/qdPdIdLBpeI14aUwn4zT8Zc95pm31
 Wg4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXT/H12mqerp9S33U9sYPr95iDosYUlC57BFFV7I4RdSTYPiEskSGmbaakUn997kQYF39Y4QZH7qy3giiydAu9vCzg6CXQ=
X-Gm-Message-State: AOJu0YyByPvEh5VTNnMRh9uDTlM76t2sWBIIAuG02JUXgkDMN4OdjjQr
 L2t06/9iQLKC51vfY7tAbkj45TLfPT86KVqS309Ik7OYgJ1sx5NJ0ywe2Wcfh9I=
X-Google-Smtp-Source: AGHT+IG6RE4ckUl6nly+e/tb/g1B1GhlcY/mpF3oEALzAeSg8aTbcOq01tMZay66KU3oxAnjfm1v/g==
X-Received: by 2002:a17:902:cf0e:b0:1f2:f784:97a3 with SMTP id
 d9443c01a7336-1f4497d6abamr28169805ad.51.1716559910636; 
 Fri, 24 May 2024 07:11:50 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f450b4a52esm12905115ad.213.2024.05.24.07.11.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 07:11:50 -0700 (PDT)
Message-ID: <71f257cc-d2ad-4b33-acf3-51f6959efe48@linaro.org>
Date: Fri, 24 May 2024 07:11:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] target/i386: remove unnecessary gen_update_cc_op
 before gen_eob*
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240524081019.1141359-1-pbonzini@redhat.com>
 <20240524081019.1141359-2-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240524081019.1141359-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 5/24/24 01:10, Paolo Bonzini wrote:
> This is already handled in gen_eob().  Before adding another DISAS_*
> case, remove the double calls.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 2 --
>   1 file changed, 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

