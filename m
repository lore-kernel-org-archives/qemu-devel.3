Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48CDC7115D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 08:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTcP0-0008ML-53; Mon, 23 Jun 2025 04:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uTcOx-0008Li-Cv
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 04:19:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uTcOv-0007mv-8N
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 04:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750666776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8XX5DDD8hC5pLsDuzu/Mi8zN3wXHrIluVW5N+ZopIaA=;
 b=ipMCCf/UkEn5Tv88kKq+lamfUSLquOC6fyHINy4f2Bl1wsWwQM+4uTQYvJjsgWn+GtlVMn
 7fLsD58UgUHlj5ZHsKRoAK1xyGEQWOct6QYGzSTk7dz4NQGq4GG4FtCzhFQZvRyd3kmAna
 V2a3xt7VqDC3zUTtmjXWB0bhjkkoiXo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-GG5ozJuTPQK7jE4nG6ebaA-1; Mon, 23 Jun 2025 04:19:34 -0400
X-MC-Unique: GG5ozJuTPQK7jE4nG6ebaA-1
X-Mimecast-MFC-AGG-ID: GG5ozJuTPQK7jE4nG6ebaA_1750666773
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a6df0c67a6so669831f8f.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 01:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750666773; x=1751271573;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8XX5DDD8hC5pLsDuzu/Mi8zN3wXHrIluVW5N+ZopIaA=;
 b=kH1MzjF8vW9pag+DXDlic2MyuBhQs9X39kMkGGZz0GgdvWk4deniDFec1jAxkivs1v
 cJvncYq5duiM2FMZjQM6vfFNRvziUsnfT4clTuq2o4Q9buCrq6zPHkbgKAmJ1CL9q+3/
 RyZ2jAYDjVuIVmeAp8PSdWI2tBBmO2Awshtb6WqvceliVcmEziHggPk897vYFmG0eQ/M
 K7F/cr9kaEGq1sWlG82bqm5nJtU1tD2w7fdfuOmJDVyiZvp/XapEMB9FG2UOCIaK3J+6
 qoBY3yiWo6CPRv6ItqT41m9O4kZpnRKh/EKg0fPi8JjK+/8oEDWlwQBZvPEGzqVnpR+S
 2UCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmqKDIKCtaWRbky1E3JFXgn3WE6BMf7X/Ofu57pYlaZ/fqlYpj2uvtw1rnA46vT3xvR/uklMWbP7ZX@nongnu.org
X-Gm-Message-State: AOJu0YxvDeXNlRdKihUbgfmR5Ywd3+k+CzxUFDlE1q2WBw3yA/JoC1Uz
 O55eaxXsLk6zD/hOPGjuMgNesLxtpSAobkYXjfH6rt0l271vZDH50hfd69yxbUaTbvTfnsvcTDK
 R1xFo75PoCKk/HdKUpP2gxgk7HL3iSnLxymnuaW9C7gIoINuH+akh1eHM
X-Gm-Gg: ASbGncuWJeQSGipdJKQDBtm148rCiZoImxVfjyQkijr9pIUUiYOFKIweknDvTUAALSj
 7Mf4lIdejLAKOxH56OEZhtbpculE7sp4qnk0ueGSJtPR9/bOK25qSRIwLwVMsGWKVj/IlXgVNGu
 5QOfYIV1bUoASbTnzLVHf46UB7OXcKXxY1k2FpEBDYnak+t3CAzyZ/kjdDTA3Jydv1sobhGLh4y
 6O7jalZdYPGm8vnm/3ApA08Ft8O/RL9lhNE8oGp5m1Wsg5oL8U13Smz/3zuIneBrs5/jA4mHZrz
 zA0Motz9LH8bBvTcsrD2Zde2ArLwBEYgrwvKOaODPB79eDYy/pfDjpCuq/+tn7I=
X-Received: by 2002:a05:6000:178f:b0:3a4:f038:af76 with SMTP id
 ffacd0b85a97d-3a6d1331ef9mr10090465f8f.53.1750666773233; 
 Mon, 23 Jun 2025 01:19:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHB3OnZIUN6Z1pfd2Ko5M98DIFDS9f+w2C6Oai+OOVuvFK9Bb/v2T9UJg150rrspCRwaQVMtw==
X-Received: by 2002:a05:6000:178f:b0:3a4:f038:af76 with SMTP id
 ffacd0b85a97d-3a6d1331ef9mr10090434f8f.53.1750666772820; 
 Mon, 23 Jun 2025 01:19:32 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-166.pools.arcor-ip.net.
 [47.64.114.166]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f1d902sm8609481f8f.43.2025.06.23.01.19.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 01:19:32 -0700 (PDT)
Message-ID: <3896c4a8-8b25-45e0-978c-1539648ab4cc@redhat.com>
Date: Mon, 23 Jun 2025 10:19:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/26] tests/functional: Require TCG to run Aarch64
 imx8mp-evk test
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Bernhard Beschow <shentey@gmail.com>,
 Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, John Snow <jsnow@redhat.com>
References: <20250620130709.31073-1-philmd@linaro.org>
 <20250620130709.31073-25-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250620130709.31073-25-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 20/06/2025 15.07, Philippe Mathieu-Daudé wrote:
> The imx8mp-evk machine is only built when TCG is available.

The rationale here sounds wrong. If the machine is only built with TCG, then 
the set_machine() should be good enough to check whether it's available.
So I'd rather say:

"The imx8mp-evk machine can only run with the TCG accelerator".

With that update:
Reviewed-by: Thomas Huth <thuth@redhat.com>


> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/functional/test_aarch64_imx8mp_evk.py | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/functional/test_aarch64_imx8mp_evk.py b/tests/functional/test_aarch64_imx8mp_evk.py
> index 638bf9e1310..99ddcdef835 100755
> --- a/tests/functional/test_aarch64_imx8mp_evk.py
> +++ b/tests/functional/test_aarch64_imx8mp_evk.py
> @@ -49,6 +49,7 @@ def setUp(self):
>                        self.DTB_OFFSET, self.DTB_SIZE)
>   
>       def test_aarch64_imx8mp_evk_usdhc(self):
> +        self.require_accelerator("tcg")
>           self.set_machine('imx8mp-evk')
>           self.vm.set_console(console_index=1)
>           self.vm.add_args('-m', '2G',


