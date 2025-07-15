Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C801C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubc4n-00009b-1j; Tue, 15 Jul 2025 05:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubc4h-0008Lv-Mg
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:35:48 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubc4e-0006Ro-An
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:35:46 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45611a517a4so8331435e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 02:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752572141; x=1753176941; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5YW1ev1i3MJ/wwZjw3ZjpeMc1+T09H9KtFItXufv9I4=;
 b=uyxN/AF+2ibbaUvt+jAzlone30aCOOh+gQhccksxxtWMUGM2bQ/iY8dWYzoQb+OWAv
 RwxXLn5z5CmBhXfNsX9tD2NcH//wbKsnDoNB7imXUuVp/PFml4GpdaXd3CCp+QZ+wHaG
 uXaoi566UZSluwPfZsEz1BXzZcDN41Ehy52CkVSsrzy7aZZneknL34nT+eFwroUw7vcJ
 XY2CDSaE26EjRjelF9JicAYJdMVf95slPVlkaQIJJEcYDayh4WOA8LE1gND6+6BGwasw
 ZpuGxT6BkWi8tvZpoZqwbKUrEY5rdgUoZ2GofOKAC9kDKE8T6Oj/82e5OQxKDg0iFg0j
 ++bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752572141; x=1753176941;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5YW1ev1i3MJ/wwZjw3ZjpeMc1+T09H9KtFItXufv9I4=;
 b=pXNUy0EbOn2OcAAK6UPkUesMEXEn0SVkmWaNyphlqjoR/0HcxlRJswwOlBl6AY2dlA
 SWG7IG9ekVs8Oc5byN6g199VszZ2A3NYBOislW7bFVJ4IpKxISNU+4MkwCOnB/RqIFUx
 cLChMAp1gemyNbwch1EryrgpVZzTwkaj4UMKCYkEWCKmk/90T4MpgpS/fIEfC3So+8+O
 YXVpzeGnfnetP61uWqxja5fxXJPxc6P1dJuv1AdNlWgAosscefSAyiYhufoVLog1xrpn
 bcx680aFL+J+QlOwHMdMlEuhYZfRHANOTqqbco2zNag/fZRD9mKPF5i+CF3U0yUgoLC2
 4HZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF7nw3hoNSR4OlSInq7T/61NgqeTUssLnOBVuQzsLkUCv3eXCjKRV+xXfe4i9As83soGwwX8Zch6Gv@nongnu.org
X-Gm-Message-State: AOJu0Yxf7buaggIsF17ZSrbmiuYlgysDM9D/BCCi17hxS0JcI1EildsW
 vpmVkDKlaSKEeugdoiJNSnX16ZEHyHDWgEbY+txyoCi9zD5Bb77XuJx98McOgNtbDn77APh/zFU
 bv0L3
X-Gm-Gg: ASbGncuGMc+MXtvcu2nDcWKMajC4NBx1NvyhxdjpHwTV7E3T7Wxmn07ldIIOC9MoTxe
 bvxqRrEeKyMrfddbN8GtPqdPXUZ8StF7MTluNGbYz0SEokSJEIwRo+Nx13xzgsogo7qqWYcbtfn
 bo2/frOF+QO1Ib6WQc1aYrIZbDQcPbRGakq4+kFrUFrXhQcu50uwad2vGleDb7Bfj2AoOqEtHwZ
 a9x9c2lhNMJv95/8ZGpU6s3+IpWWMX1fdLf7vPC/05VSD5tNZtmALKjmx5Mny7jIzvkazcfdJlS
 TuqYEAUZdL5no4T46laKCuTC3mrbTWNxGBiqzAZ1At3aOxm7gD2KL4CSS+7LXtt7tU84e8/frEp
 xdeG0mJKaUgEf0EqujMery9qQi1tpBOFvCh0BEX7ka1rSxGJyDkr4iRA4g67dkolUQ8t6gfY=
X-Google-Smtp-Source: AGHT+IFScHTiHZOX56s+AyTKk7+4huiJuPLlQpV86K+aL7Y5GJMXsHhJazndr1LjNqWEvBIgIkn3DA==
X-Received: by 2002:a05:600c:5296:b0:455:f7d5:1224 with SMTP id
 5b1f17b1804b1-45625e60a5dmr26857005e9.9.1752572140634; 
 Tue, 15 Jul 2025 02:35:40 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d5032fcbsm197527745e9.6.2025.07.15.02.35.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 02:35:40 -0700 (PDT)
Message-ID: <854aea22-5ebf-4b40-b433-82959876687a@linaro.org>
Date: Tue, 15 Jul 2025 11:35:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] crypto: remove extraneous pointer usage in gnutls
 certs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20250715092932.1395271-1-berrange@redhat.com>
 <20250715092932.1395271-6-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250715092932.1395271-6-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 15/7/25 11:29, Daniel P. Berrangé wrote:
> The 'gnutls_x509_crt_t' type is already a pointer, not a struct,
> so the extra level of pointer indirection is not needed.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   crypto/tlscredsx509.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


