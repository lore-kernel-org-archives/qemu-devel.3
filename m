Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A239CD4846
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 04:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smnBi-00046O-If; Sat, 07 Sep 2024 00:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smnBe-00045g-Fu
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 00:36:39 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smnBc-0003nh-Vo
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 00:36:38 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c3cdba33b0so3116720a12.1
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 21:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725683795; x=1726288595; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tvGDLEekcc5DcmibzkZ9IDHe42XincguEy02AtZrGLk=;
 b=gCTPYp3eXcwm0Xf1nfJWzjeYB9v/bJDUS/wjyzvM9UOxj2eNPGCTEYKHVamUtNqeUQ
 NfeH/N8I5fIqkFpcNqVy2f3VRFCVj8NCtZamrQ1ZP/di8YMfIRk54mpjD0Id9aC8i48I
 EjWoq+ksbccPlTtvNVzlQTAcmdiOEjVs0hiRtOj1UccitJq6T2o5f+69GMmKj3eEgFso
 YpCijbLQiLv/s3GR53eNzznTY7ujGjz5R3RQI07NWI5ZqygDcFQzEGqX4lMQqjMcsJB/
 Q7olEYZthHctf+r2jzZxvBdzoRwf2snyPQmHQG6j7/NZ1uwrF5WxyjuyLrrIxgQ9aQzI
 n37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725683795; x=1726288595;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tvGDLEekcc5DcmibzkZ9IDHe42XincguEy02AtZrGLk=;
 b=N8FmFYbd9pTlemSm6zbXJit/wS52J4a1CbOxEs1axTcCunctt0D23TSItW9PKR2RfD
 LJFdqD5j2xIfwBZDGxA5XAtMecvHx1o6zMLe0+/WyJvzGaDAsjmohrK540q0PRaSBmSv
 n+1DAIPR7VGvfYB20Z0DywjOSBOX4YqC0YTAiYOPqQKWQOEIShkmtXI0qNaR8uDOSPc+
 K+lp47ckA2SmAeUpdWCz/4k3vjYzHZG579AKXAc57JNxdJT60sPrTnXctkVNQH2iuKeO
 Thy7QXhHo6yfXfDDS/9KH2AK5Qgriy2PtMHpX/ZC2DxJH+liO9LBM7im1weBpHqNV2ag
 Vq7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQoFMUtVBz0dov1X2gLN5hzBq8Kdi5xbjHB6wS0gUXI0gitKW0c0grhvanoeiK1VcGJ9qQa/e3P4Lx@nongnu.org
X-Gm-Message-State: AOJu0Yy8BV73jwf3wyX00npabSPPh/Ob4UHuNm0dCQafoPZSNJNON9Jv
 72CZ9dfkD4sjKtwW4tKsgc5JkR2idAK0YypYQVysi/iApADbNLqinis3v/EYPXI=
X-Google-Smtp-Source: AGHT+IENWN6eMzuak4s4d9BLP8RUCQOMh0pypS9NMzbIbdoAvtj6mFLIUmhR+BYNRO+UYJ0gnWws3g==
X-Received: by 2002:a17:907:5007:b0:a8a:926a:d02a with SMTP id
 a640c23a62f3a-a8a926ad4f5mr215102966b.49.1725683794629; 
 Fri, 06 Sep 2024 21:36:34 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.197.174])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d2583179csm26526066b.42.2024.09.06.21.36.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 21:36:34 -0700 (PDT)
Message-ID: <50abc171-5ce6-467e-bbee-038b4e6a156a@linaro.org>
Date: Sat, 7 Sep 2024 06:36:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] tests/functional: Convert the m68k Q800 Avocado
 test into a functional test
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
References: <20240906180549.792832-1-thuth@redhat.com>
 <20240906180549.792832-3-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240906180549.792832-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/9/24 20:05, Thomas Huth wrote:
> Just had to update the asset checksum to use SHA256 instead of SHA1,
> but apart from that it is a pretty much straightforward conversion.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                         |  1 +
>   tests/avocado/boot_linux_console.py | 24 -------------------
>   tests/functional/meson.build        |  3 ++-
>   tests/functional/test_m68k_q800.py  | 37 +++++++++++++++++++++++++++++
>   4 files changed, 40 insertions(+), 25 deletions(-)
>   create mode 100755 tests/functional/test_m68k_q800.py

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

