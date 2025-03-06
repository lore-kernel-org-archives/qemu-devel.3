Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE30C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 10:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq8gm-00041Q-5H; Thu, 06 Mar 2025 05:42:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tq8gi-0003kh-DK
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 05:42:49 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tq8gf-00011W-Pp
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 05:42:47 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so256580f8f.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 02:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741257761; x=1741862561; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xaKViYZxdwLecpko1tt8xlUV8OQ9jjP7rcobJLc+Lcg=;
 b=K5dy3gSnWwHpliCOa5I+bw9Da7bEPNbbe8sOqTrgsD/1ESwhH6gE/Qe3713anHsLXo
 fJKYuymYLdwpnGcNZgvQfoLsDvXO1Kuh6NeC7Ede2mJkvtDObLNBQvv8Xih9EDx6d6hb
 UxMvpBh7f+kDbO51KgUiTGSr9Y3zog6MK6Yg/HVLRAcif3UXuFepr+ip/vXIymOobYLh
 M9MWYMzBLE1G2k1TNZWfiFCdCbbm6E5bsy7irm5h5z1rkv9S3mI/plBdiTUEPyUygxgb
 Ma4qHGnWVcUuZbZU983z4u2BEpmGRM5ZcrnMXLMVGQQgBzW/1ik0Fc3R2Cs8hAy6zthn
 Vxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741257761; x=1741862561;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xaKViYZxdwLecpko1tt8xlUV8OQ9jjP7rcobJLc+Lcg=;
 b=UNSdOY3sdkHHt0H8rtt5uCxu6FROB842OJQoCVL5XjqFXek0s+tBQvXvu84+RFyTNh
 9v5t6rUZrw4C5tm8o+iuuC9Rmv9Zf5QxaXDSoU03chNtaULkwgvS5thAk0qBiLiAlcLs
 b7rcVfr8SFHAQweU+pPF6GG23qIbUUtJdBlPw95O9XZoBRFCFvhAtmn3sv0vOf4d8bLX
 aporXD3T705b588CwPqCx+lCgj80m/QphZPrS0QyFI5YdTk3f231jngwF7oYykPtPYij
 iND2dqtyNmJt1OoIzgGt/vtJ2+taWq0Wdpm1qRPujKSvNnYa33ymUTtA9BNpZ1W8Fv17
 0KZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsdkE5RP2tMsoLFo7ZQ+pKImPAIH99DtqaCddPVu6kKCF6e5UkloMrN3fcwIZjaFrQr8QSoEDkA4sv@nongnu.org
X-Gm-Message-State: AOJu0Ywoet7RuxPE2EpsZeJmYpqrTfmVKkekALDQPEfapYX/sZHfxe3C
 5qaKPbF22hTLDgOeo6MQnHLM5bXt4qlTHGWAuZHRi46JcspV0wazgZoLwL4XtgM=
X-Gm-Gg: ASbGncvX+w3if3vfNhZxXKl2SVH3wxrJNucZiTXhZUUfY4IrZanqyti4dDztjEw2QTX
 YKK2goDu16zCbCpVjsTk3CP+7ZunSJtrmYNJ8Xhi1ANY6Jc8icJs+tlGs7XyKwP5RB2uhgdnw8V
 +mImylxsi2LASpu/IijveRzN2yh1wM+iV6WE3vbek0Dx1ONqksDH0G8p31hmw7X6be6kXi1nCan
 rcIIra7v8VcvpEuzqZ5RTclKe64n8ea/cnrszq0QczBjdMcudo5WEbUcaGBquyNlG2zSoVJaBqr
 SF9Q/FiCLOaggBeEteu6I2s08lEGEkEbaxzsMWibXu3uteqoaKqHd7l2l+xrFGl7VnHmhQqaXHl
 GiXUniry3r1Dg
X-Google-Smtp-Source: AGHT+IHRj55Ay85fBiqAkp2KdssrUaWQXE1GtZ7kLXN9Uw703fDO7P+S26h2Z+7vanik5rKW5hlRCg==
X-Received: by 2002:adf:f0c2:0:b0:390:d6ab:6c49 with SMTP id
 ffacd0b85a97d-3911f7bda9amr5516886f8f.35.1741257761010; 
 Thu, 06 Mar 2025 02:42:41 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0193bfsm1651353f8f.55.2025.03.06.02.42.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 02:42:40 -0800 (PST)
Message-ID: <71f7e071-4b60-4f74-aaa2-67796e35631a@linaro.org>
Date: Thu, 6 Mar 2025 11:42:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] hw/hyperv/hyperv-proto: move SYNDBG definition from
 target/i386
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 manos.pitsidianakis@linaro.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 richard.henderson@linaro.org, Marcelo Tosatti <mtosatti@redhat.com>,
 alex.bennee@linaro.org
References: <20250306064118.3879213-1-pierrick.bouvier@linaro.org>
 <20250306064118.3879213-5-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250306064118.3879213-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 6/3/25 07:41, Pierrick Bouvier wrote:
> Allows them to be available for common compilation units.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/hw/hyperv/hyperv-proto.h | 12 ++++++++++++
>   target/i386/kvm/hyperv-proto.h   | 12 ------------
>   2 files changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


