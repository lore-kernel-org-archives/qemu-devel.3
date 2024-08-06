Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED59C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 14:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbKuG-0001cx-7O; Tue, 06 Aug 2024 10:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbKuB-0001PC-2Q
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 10:11:15 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbKu9-0003OZ-DP
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 10:11:14 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5bb8e62570fso1093790a12.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 07:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722953471; x=1723558271; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j8eprkCb+5u1QCZPBdw5EVhuGugytSUaxmCaHRPhoEs=;
 b=tQqCCZUzST4/cXRSkt1ddnl8YvsczUa722G352vPFXp9szXuZbaYFGHvJrYiWy5j5a
 EOzFhbyAXMp4Aj9f/sSdtyz+oG7M5o7AQjFKKhm4k5C/+EqpMvBkSzjKasozjZN+LChm
 YLREabT8BCfFeC99eWZcGuitCu834PvY5DcjbtabDXXgRwyYBkVfFGd71ZnGvSe7yVdC
 Kg5QRjLKVq/94gfIcKmQCf4Sc0T5sEejhxSdNDxF0Vv+ff90Wvym8j+EXyVLmI9WSCPX
 B03F9ELMLW4JKM0TQCdZKPbxt9+eTAA4Hobn+PqOstcas23UateEmO4lLHAMT3UzPwQo
 AD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722953471; x=1723558271;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j8eprkCb+5u1QCZPBdw5EVhuGugytSUaxmCaHRPhoEs=;
 b=ShNDfZ5FuwbsFg6LpvM+jK4Sq4MduAXwQi2aXNd5JNczHD0wf17grR0AUkqVuHOLy8
 nrBC2mSjiIWj/9r0sUhaTVdwGAcDOaYcW+DEwLxwShzQipbiZuwWWaL4L1p0Peq4DBdT
 TBV9YjDqFIk/floaYBcav/knEm7RxH8QbT/9CtKkznE/h3jtCcQtYe83pCsYohdNZn2o
 YtuyIFRy9RmAFreBS/LmgnGcJRXvj46gVmYOyZZmyLdRQ2IxTIuhqAzrPjvNrKzDOgvM
 gZkUF0yFBbDhnhbB6Iqfqyh1YkeT7AYLfXYfRv5h0dwwjvwcFy5mXUG6GCjBqBevJ5vX
 BBHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa8geK2aHJmx+0TkG4HbGgy11A4EwMrcOrjsqBLzo290eHyAFW3l3vNcpfSmcMzsXThnqdf1Kqlqt9cTlTqJsGm185cbA=
X-Gm-Message-State: AOJu0Ywbs5JTWgetOqzkCAIf40LA5s/k9gMF/Q5cZdb4ikDNOMRAaU8F
 S3A98uplb7eeYvoIgX6H4Uc7nkWIB4BzbSmXT042hExLtNdkpzePtmcDJyuxZRc=
X-Google-Smtp-Source: AGHT+IGTJbRHjxGfSJuesdkgbT/CGnC65EhQVCUP9vOpKDYctEiTkXVWhnDDsGzg7TJugrN3qXk3mg==
X-Received: by 2002:aa7:d5c1:0:b0:5a3:283d:b05a with SMTP id
 4fb4d7f45d1cf-5b7f40a72d0mr10831854a12.17.1722953470644; 
 Tue, 06 Aug 2024 07:11:10 -0700 (PDT)
Received: from [192.168.69.100] (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5b839c24028sm5974243a12.24.2024.08.06.07.11.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 07:11:10 -0700 (PDT)
Message-ID: <535b48e2-65b7-4cee-9bff-4fb0140d0d04@linaro.org>
Date: Tue, 6 Aug 2024 16:11:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] Fixes: Coverity CID 1558831
To: Chalapathi V <chalapathi.v@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@linux.ibm.com, chalapathi.v@ibm.com,
 saif.abrar@linux.ibm.com, dantan@us.ibm.com, milesg@linux.ibm.com
References: <20240806134829.351703-1-chalapathi.v@linux.ibm.com>
 <20240806134829.351703-3-chalapathi.v@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240806134829.351703-3-chalapathi.v@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

On 6/8/24 15:48, Chalapathi V wrote:
> In this commit the following coverity scan defect has been fixed
> CID 1558831:  Resource leaks  (RESOURCE_LEAK)
>    Variable "rsp_payload" going out of scope leaks the storage it
>    points to.
> 
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> ---
>   hw/ssi/pnv_spi.c | 1 +
>   1 file changed, 1 insertion(+)

Fixes: b4cb930e40 ("hw/ssi: Extend SPI model")


