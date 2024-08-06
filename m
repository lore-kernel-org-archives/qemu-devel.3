Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE5DC52D6D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 07:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbEzV-0004B0-1r; Tue, 06 Aug 2024 03:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbEzQ-0003xB-G6
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 03:52:17 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbEzO-0006oY-Si
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 03:52:16 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a7ab5fc975dso14506566b.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 00:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722930733; x=1723535533; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7PdkskWn9cxxIFtpEDmbr02VE7ggSAA3JWm/2RuISdo=;
 b=S6QayyoSIRDbVYgzCQuKAwdD068iyMleP67Xb3QowGINRJmoOexkk5eABwUCuVbbMT
 7lezJshZPqnCB6s50QiglxShQ7B3chFtdq5YQdUOGEFOZ/u28I37VFcnR+rr5yf/9OZe
 o61rEHr6kxz9OuhztbIdhaXsD55W/9s3pkgVQQjKHJGgUWGUnox+gOL8J8qOxQqy9bRH
 JF6N3rxY4+nTDjqUJPlEcWMBEimKihcM+obulEe0oFUzqsVjiEnN9/O9tyWGA3hIvUx4
 XyyDPb2Ji+rGs92DTMbfOPLy7QgKBq5CSwY+O1Uwsv9txTup9MaE8QXsRt7J1ZcTLHzM
 UySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722930733; x=1723535533;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7PdkskWn9cxxIFtpEDmbr02VE7ggSAA3JWm/2RuISdo=;
 b=MQODaG1fo63MvBBzQJO/2JzKcbIIh9v1LGp7GbUEWmOWEkD9MgSfNU7q89kN5cjo9G
 gvVYpjVAW8w75/jURtlqEKwEMS1HctFmIyuSIBtDuR0sxyh+VGiNEPn4kgUdzxVRfDqy
 6QLoXNTqbBqKKVkzNFpjII1Hxx8hqFbDwqppjYy/diR5ifLtxIiJUI0OqpnYUtH9f9i9
 fE7UfuSGZgGFkE5V8uuYrk3b/2JSk9KS+uHcnWOhEZNF6BrnVuLb/+kdJqifhMxPZfLm
 c6/cpXaF02u0iLOLJKydC39zPbCRSA64Ap4LbN/vEsEHlQnOeE22H/fcTWaALR/vGA4F
 uDaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWymwGP0J48Go14vZ7Y4TkkC0Ok8nuTGPBH/Ds8mbAs5UMKXN3JpgSpzF9eKDR2siXRbdJ9+1FC41Ezr0PaKF+UYblXvPI=
X-Gm-Message-State: AOJu0YyXZqje394XQRx1i4ckky3jrjpNfPOvljhvUeLIhWdXG5Lp2hQt
 VinzA50VtDE6hrGfvC6Y2vjIv5jkSIJCo30FdbfAzQzEGlKhaUAGKwmxpUaQJaA=
X-Google-Smtp-Source: AGHT+IEHcfyuBQP0wfWSqzlhqxcg/6zNcVAUv7JBAGFyB+Fdui90tiL4Gt2QdB6myckm5ofK9Tx7tw==
X-Received: by 2002:a17:907:eab:b0:a7a:b0a0:ebdb with SMTP id
 a640c23a62f3a-a7dc4e282f4mr1146223166b.22.1722930733130; 
 Tue, 06 Aug 2024 00:52:13 -0700 (PDT)
Received: from [192.168.69.100] (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9bc3be2sm528793266b.38.2024.08.06.00.52.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 00:52:12 -0700 (PDT)
Message-ID: <87c18c11-436f-4044-87bf-748fe6330032@linaro.org>
Date: Tue, 6 Aug 2024 09:52:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] docs/specs/pci-ids: Fix markup
To: George Matsumura <gorg@gorgnet.net>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, mst@redhat.com, marcel.apfelbaum@gmail.com
References: <20240805031012.16547-2-gorg@gorgnet.net>
 <20240805031012.16547-4-gorg@gorgnet.net>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240805031012.16547-4-gorg@gorgnet.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On 5/8/24 05:10, George Matsumura via wrote:
> This fixes the markup of the PCI and PCIe Expander Bridge entries to be
> consistent with the rest of the file.
> 
> Signed-off-by: George Matsumura <gorg@gorgnet.net>
> ---
>   docs/specs/pci-ids.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



