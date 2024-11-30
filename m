Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4451D735FC
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2024 09:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHKCO-0008Lw-Q0; Sat, 30 Nov 2024 04:55:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tHKCA-0008KF-Iq
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 04:55:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tHKC8-0007aI-KS
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 04:55:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732960517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XlYy4UL1FzJmOtVbC4eHpG9OBhhofcf3ZZXPjwJfRrI=;
 b=JtXAGav5hPRAIc97KQDwFCbGkmtYAgeb/ZKK5YUKG3TO+Jnh6sYyf3WyKFsRbaeRxsSMPj
 3NgzfYho2/Bh4wpOY0d447r6V3Rdsk6XFzBoyRadI5/SJecjl6wDwmo7aT+gNYrS9VagTp
 i9xvyltipvXwSVFHicuFcft/73k7fuE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-z_Bhl71jNxqDhuCEiWRQUQ-1; Sat, 30 Nov 2024 04:55:16 -0500
X-MC-Unique: z_Bhl71jNxqDhuCEiWRQUQ-1
X-Mimecast-MFC-AGG-ID: z_Bhl71jNxqDhuCEiWRQUQ
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5d0b61f9d3cso379500a12.1
 for <qemu-devel@nongnu.org>; Sat, 30 Nov 2024 01:55:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732960515; x=1733565315;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XlYy4UL1FzJmOtVbC4eHpG9OBhhofcf3ZZXPjwJfRrI=;
 b=lJSdJHo8m9/0OPi1u7Q0cOOgE5HILAs5u7wpxUa4hTjyXUpnuNVpG/In2aqWAlVF7j
 9Q+rwuqtx31l7jaDGIsr4Mcc17wmkBc4m/+gCoqB5BJamyyKFLFgYyqYBe8TKTroWRzO
 yLSlDidGdjRIEvd5V16322uvtmbFW2/DC+CdSgLvigpgZY9aVp2Zrx5KJl1Gth5lhCbx
 XsI69nAwTNe/W36yYKOArkZKOfH2utQVM+0fFU0VB2Hy1ZdA7HVWeh6UdhFUmdJ2mwo/
 GWpC/7zFjcnjO5zx2TJYuF23RGno/qc2ugDueg5/UTMNC48adokjVCzpw8pZNunKgTbA
 df2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbzZxYuE+VU71ALTHn2X7fD5g6fgadp6IP/aSEtz4d0oXE/2oIcK330QPQa2yleOB+TniYDHIBVFHA@nongnu.org
X-Gm-Message-State: AOJu0Yy1Ejr7+FvVpeji7Xp0SCPZ0Kdx3WxOkE9qAC6ruClTERyxt3UV
 K0xyy/aUBfAqhxoVq8iC8/rroBqxOuzWfvQ983FC5dJLgN1sGK21OTGhaaWouu1kS5XhzbZ22r/
 apW1EqRbDhX9pcOS14DApQpXWntQTJXoRG4DB2smMat2w+WIGRi86
X-Gm-Gg: ASbGncvVvbVAVXmMXZfCxNfLb9Hipy3DEQhR3+f4xiB3IzV5Zhd5zNg6wQ90t5sv2Ou
 1t6LuqECp90QGy7N6GwjvYORRtJkYQ16+QUQ4mIPcS/mWTclTuL8jn4dRzpgF2XDbHjzM+WuzqY
 vRqi6f29LD1C0MAQDiDGaHUUY8+ItCDR38Kz38DFPC72Y8sWE4VRjyVUUcuSR6dGP5ex2GeJyz+
 3ZkBP0gaKFqDf3OJF1cnIHQZ3wEuTI74F+/nRIt4eemnUKK5NslfYZsYn9ObSoF7Vpi09lfw3+k
 DXjmDQ==
X-Received: by 2002:aa7:d889:0:b0:5d0:c697:1f02 with SMTP id
 4fb4d7f45d1cf-5d0c6971f0dmr4422326a12.17.1732960515025; 
 Sat, 30 Nov 2024 01:55:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8P1VfraNCXx3GvM5YfCOdIwOgFBTcw81RbABtX97E6fI1R2FTKrWaEQpPJBYC5HxeBv95ww==
X-Received: by 2002:aa7:d889:0:b0:5d0:c697:1f02 with SMTP id
 4fb4d7f45d1cf-5d0c6971f0dmr4422303a12.17.1732960514680; 
 Sat, 30 Nov 2024 01:55:14 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-143.web.vodafone.de.
 [109.42.48.143]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5999734ccsm262752466b.204.2024.11.30.01.55.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Nov 2024 01:55:14 -0800 (PST)
Message-ID: <1620ec63-7f79-4248-8aa1-785ba65a2f28@redhat.com>
Date: Sat, 30 Nov 2024 10:55:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/22] tests/functional: increase timeouts for arm sx1 test
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-2-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241129173120.761728-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 29/11/2024 18.30, Daniel P. Berrangé wrote:
> When under high load the test VM does not complete running in the
> default 30 second timeout. Double it to give more headroom.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/test_arm_sx1.py | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/functional/test_arm_sx1.py b/tests/functional/test_arm_sx1.py
> index 2d86405831..2292317946 100755
> --- a/tests/functional/test_arm_sx1.py
> +++ b/tests/functional/test_arm_sx1.py
> @@ -44,7 +44,7 @@ def test_arm_sx1_initrd(self):
>           self.vm.add_args('-no-reboot')
>           self.launch_kernel(zimage_path,
>                              initrd=initrd_path)
> -        self.vm.wait()
> +        self.vm.wait(timeout=60)
>   
>       def test_arm_sx1_sd(self):
>           self.set_machine('sx1')
> @@ -55,7 +55,7 @@ def test_arm_sx1_sd(self):
>           self.vm.add_args('-snapshot')
>           self.vm.add_args('-drive', f'format=raw,if=sd,file={sd_fs_path}')
>           self.launch_kernel(zimage_path)
> -        self.vm.wait()
> +        self.vm.wait(timeout=60)
>   
>       def test_arm_sx1_flash(self):
>           self.set_machine('sx1')
> @@ -66,7 +66,7 @@ def test_arm_sx1_flash(self):
>           self.vm.add_args('-snapshot')
>           self.vm.add_args('-drive', f'format=raw,if=pflash,file={flash_path}')
>           self.launch_kernel(zimage_path)
> -        self.vm.wait()
> +        self.vm.wait(timeout=60)

Ah! I think I've seen this test sometimes failing, too, good to know that it 
was likely just this simple reason!

Reviewed-by: Thomas Huth <thuth@redhat.com>


