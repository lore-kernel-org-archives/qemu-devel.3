Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF579C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 06:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7qMG-0000Ho-4K; Thu, 24 Apr 2025 02:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7qME-0000HM-Kz
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 02:46:50 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7qMB-00007h-HI
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 02:46:49 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39c1ee0fd43so538622f8f.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 23:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745477206; x=1746082006; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ayUlrntd8YogjAz6aievzR1bhk1Rtq5sOfM23w1iP2Q=;
 b=epIwihQ8OI9UNYRQGehxqbVYAYjRkiOw2hW1tWBFqcE7PvaSB29I5yP5BDPHL+BwG+
 9RxYssabrtDKTJA+0y1xGrdRxHHu0xIqrV301aSM+OUzSlxFdzCK11aceoaev3KU55UW
 1zlIvGj0ub7Avuxzw6m4wAYFEvFjtyFAecZCWGius9uEhZNdYbojfaISscbFYXBD41D6
 3ueHrvL+SD9IJnaCJoq6lXOeNenFMMUMq885WziaPAyyp9FWDiayj5Yj6dU0WopVBcib
 gmg93EuGYi6l9c4Nfr6cUK0dpR16g02VRk9coTY0SzYWaLbNouudXZ2YEIdIsMDr5h8x
 iQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745477206; x=1746082006;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ayUlrntd8YogjAz6aievzR1bhk1Rtq5sOfM23w1iP2Q=;
 b=FuJPxOTQA5MJW7rwaJFHm/Uq2CNW2IJPzcTjsLlYdr2n9pqiAYPWNsMDDl2hmS5ttI
 fOA0KskhY3CJJfVMH3xPS9tapybYq48e2SHCF2Vh41s2N1mOW8Z1+1/CaS/kO0epv2/+
 Hhp5m56PGCTQdcvmbQyMiFUXog9uvkB70Or4VmnfoKBdYK2hv06eNQTnUSeORNx7XpRN
 W5GCNEtbkqW7CQHDRsQNtz7QyWqwM55sAUDpX3UUcdzMSlxWm0xG4qk+m4m91RDIXL1V
 xktswlQQtpqtUclLn41HZHFy+ks+nZQLU0ZxVPrZPUkC0SRmq95/ENXRsNoCsqYtQjZh
 N5lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzR06zpmOSOPAWGqMS/ibUNXFl330JEPEP01h6pz0jlp77gDnWnzDDeDl01si+RAfZB1P2Mr/PCjrx@nongnu.org
X-Gm-Message-State: AOJu0YyF4xEzHZdwIRZFghnJOZNTEEIka5dHXkwl/u4wkJzDXw0YMXW4
 x7/q4lBZcKjabZ3Ybv9g1p0iz0yZMNx2btQUHb6HOXfGONtzDLeL3xASpMuF8PQi/1Wi22owoNu
 d
X-Gm-Gg: ASbGncvKqvpzl0QdDqAmLk+nnVsKripygbGvg0z90QeLfreGw0K0r1URvqXBa3swDT6
 a7YZJ+rs15Hn3Wy48pej72S/u5IJ0okRNxXJRDA5wO6HybX0KkygOZnmZ7K2S703XAE7JjrD6wD
 RiP4b3jCsgz4/DfiKCG/eXexdTaI73R/8lkGPr9t+QaxZXpHO4+xI9YGwTXLr+pNsAP9FkMPbAH
 IGRyUuP+AaQhSJBDd6mbTahSU7Hd5niwWcksETqg7Uj0LzNyyBLGoIGzbvCCzTrJ3xEVExk/e51
 f6DP2ksWZ1BYCzxJdwUVT2mDiNxGqS352IoKKBod7i/hFB7TGGxsgPODiwxl5ObS4ZEPG2D5hgP
 qfhOKC2qgHCWm1A==
X-Google-Smtp-Source: AGHT+IEhm9qbPavkKl45aKPN3JrxYNoVc9W/TJS2rnLjuCxUtogaZc/AbqrWYfoYLH4G0wSzil5VmQ==
X-Received: by 2002:a5d:5983:0:b0:39b:fa24:950a with SMTP id
 ffacd0b85a97d-3a06cfa9e95mr813448f8f.36.1745477205956; 
 Wed, 23 Apr 2025 23:46:45 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d4a812bsm1052911f8f.17.2025.04.23.23.46.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 23:46:45 -0700 (PDT)
Message-ID: <b37f8073-bde2-4da4-a159-9cd01eab91dc@linaro.org>
Date: Thu, 24 Apr 2025 08:46:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] meson: Use osdep_prefix for strchrnul()
To: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 devel@daynix.com
References: <20250424-buildsys-v1-0-97655e3b25d7@daynix.com>
 <20250424-buildsys-v1-4-97655e3b25d7@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250424-buildsys-v1-4-97655e3b25d7@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 24/4/25 06:50, Akihiko Odaki wrote:
> macOS SDK may have the symbol of strchrnul(), but it is actually
> available only on macOS 15.4 or later and that fact is codified in
> string.h. Include the header file using osdep_prefix to check if the
> function is available on the deployment target.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   meson.build | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


