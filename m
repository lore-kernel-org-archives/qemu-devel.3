Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85AE3C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMPiK-0000cp-Ui; Tue, 03 Jun 2025 07:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMPiK-0000cf-3d
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:21:52 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMPiI-0004yE-AF
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:21:51 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-450cfb6a794so33679785e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748949709; x=1749554509; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fK9Vkx75ql6CKJDqu4LEQ8cjFvtUzV/OxFw7PCvmJ+I=;
 b=Kob18t3yp83z7t4R6a6GntHPFI+BWaLCB+0i2zcExStzn9VP0zGQmJDLukOxr4pvUX
 IuAmZe/U9F94SfEp5VqRLBWzJiIUARJs39Yw/b8pB67jyiyLQFKeCe6xKxDpPFanjVfO
 6Nht2ztcLKgFs8ob/st8ZQXpDMY+anclbcg63WvXLURlgJTTkAS3jtx4ERen9GVGFe+i
 +TFwcrkb/w5I19ZWdfxmhfcOCJRQh9qzoaYX53YBgHfWA25RBCgsUgd32lt+H6jEvuVF
 fsQyON2Gwts9o7r/TV4+6aRsmgZLKbFwRWJfnYx4SSptqchucUpyIVvitx2ZFqw8Jmn4
 WY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748949709; x=1749554509;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fK9Vkx75ql6CKJDqu4LEQ8cjFvtUzV/OxFw7PCvmJ+I=;
 b=YQ66KgfoKE7u0TVUpXTzeyr1aZ+VCbZQluVQKJTd9jmnBr6v9ZLvYDfIxUGz/4hviD
 IGR50qIYE+ivxVn4XhjgAagpYQnMlZ9x42wVEtjL2e9NCcep6U7xZM7J69+QzDNeIbqb
 Pw1cvMrk8WihrawuMm4pwqYaAxlWlqkEJPALVvkc6yBqfDvwM8Fg/co4PTtjGqQcqqsc
 8FfFSk1tfCDMb89OgZex9Y51oVrO1aOPyTNwSPrvt20umK9M1+9v87on+UgN9tCH3THT
 QrTtMw9hI7m53VJ9N2ZJBIbr9BMpEBLPJtEWh+HnOTpYlH7k+Dp4jyNmfNXMLOInFq+q
 Bu0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFScVPgE+eNSkJQ/wM/tEb52Upd/FRMpkAdTzJSrg3eaSnTblNRLLCao+MfNfZ7h8QTq9q7aAtuBl2@nongnu.org
X-Gm-Message-State: AOJu0Yz7Q4O71jQnIjRljhuW3IevSTmAXDSnN3w+phNZt+XxsoIs4FRE
 MQlisGloo50nsBrtrh4QBDZ2i8rh3+OIMB6j40NOX6W0WFfMR2ie+TfUzIiCXlsnUX8=
X-Gm-Gg: ASbGncvXTKquyzorxSHlX5QhGL8Wt68XikiciWqvXcnl5D7lIa10C0MDjmbWGXGE1f6
 TfRM2d/pPmQBlNfXrl80GlWrMis8HA7Hsj16epkEUbeGgt+mb5TqClCOP6S5j+7LNwOEx0Uqccc
 auJMawEzVaSTn2B/zoqrD6qIlFrM/MI7FYN2pXTr/IhhZhO1p3GwFCp+6NQSGAndH6Bi22bR6Lr
 5VdcQWTKYvQ/2tryiPolICEryjisXaCI4meF7GK1N5uJE4cy2BbCRv4Qs4XOi4rcELYWJWBF/yk
 Lu2ICfbI4T6c58sBOL7Q4kL5i41pabIFjaBsu3Ji5StR7zyE4gxrFpZh3c9uGsMYFkesQhVQHfT
 oFAjAc4KfnWYdSZ3Ii9xDACGY
X-Google-Smtp-Source: AGHT+IHVHD2zPRq5j59iZRMAVgDbEAZdx5o/8pVEYmjGMKCyX2d94RhZ+mAEhneT92T79rA6fU5Egg==
X-Received: by 2002:a05:6000:2011:b0:3a4:dc42:a0af with SMTP id
 ffacd0b85a97d-3a4f7a711e6mr13133239f8f.33.1748949708651; 
 Tue, 03 Jun 2025 04:21:48 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f00972f3sm18246005f8f.69.2025.06.03.04.21.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 04:21:48 -0700 (PDT)
Message-ID: <1880adb4-9df1-4014-b2e9-35532f89554c@linaro.org>
Date: Tue, 3 Jun 2025 13:21:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Use the 'none' machine for the VNC test
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250603103449.32499-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250603103449.32499-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 3/6/25 12:34, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The VNC test currently fails if the default machine ("pc" for x86)
> has not been compiled into the binary. Since we also can test VNC
> when QEMU just shows the default monitor, let's avoid this problem
> by simply using the "none" machine (which is always available)
> here instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/test_vnc.py | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


