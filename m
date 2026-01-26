Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5297D19510
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 18:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkRXt-0004rr-S2; Mon, 26 Jan 2026 13:42:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vkRXr-0004rU-4K
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 13:42:39 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vkRXp-0003Dv-2G
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 13:42:38 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47ee4338e01so27647485e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 10:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769452955; x=1770057755; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UznixB6xGxIihSNTuGiSxMjUAQSnZGZAsrU+M4COt5w=;
 b=BtNVP57NAJf2CnzYlHJxYitATMsa/axXgOO3+iPCghb8Z8kku8k/jaQe1mWaneRjaK
 nGZxewA2Sp1sc7S5Z+AvccflGUjUmQMVt+ZX55yudhs7Pl027v1M0zWLYdFU4oYW3TMJ
 eHBEII2hTVAP2mzhGQOj2/uGpiiJpVsTBYrqgkybCNVrlCdDdyMtzzFXwR8cw1ga80RT
 hJzQRYavnLipmPon6UVuoWDR98M07ms1A6ZGCuCnAL1UgGjo62WhBBo3UcXXo0ZzZJeD
 FQFpGAMettni8/2EIm5c1Btrc2G4KPNJ0C2KrJv9b6ZFVniwD3jKyBlUQLki3jvD9d3Z
 Hnkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769452955; x=1770057755;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UznixB6xGxIihSNTuGiSxMjUAQSnZGZAsrU+M4COt5w=;
 b=moU3oC53urGRVVlvxA1rtZZ7hmDrI3Q1rj6ZguXz22dZr/A73r+4GSonV7YJeXNChv
 7sutYDRbQHKvnKIW+PMlQpIbT+XhkhPgxXznt6h/gLCqwPTaYRHbNNeaI9k97KIZhUVN
 bfIY3wRZZauAn9VXybmCQOrWilr7KABiz1ERcLbzb85PzYYfhFzEvzOsUeV7laH8xXvT
 i/NwUHkvXOW7Op2zeYK93javdDW6rLInRDCAMnAKNnzURAWiN56omqT97UGWfSW5cGJ+
 CaGGCVjx4P3s3ehyHMpx7TaEAp59Vmbm9iLYuUTliBd97HMrwYOSZi/9m5K+3Ped7GJy
 pg+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtrjRR6eXZMlYVJi7oyfW7oNV0ZMSgcDFERrlrZ4dYG65ClFgtbG0ulef/lTyPnPl3UXb1grcFqeHU@nongnu.org
X-Gm-Message-State: AOJu0YwxmCDZ7rusSBqH2F8LgPC4DrFb2V4rglgTDW3kCUy1kGl3nvIJ
 6mdltt8wKUJsz0CinvT9w6CrdVFtbVcgcdXqZ+sNR/TQ2kJ1Qye33vw8ScT1dA6xqkc=
X-Gm-Gg: AZuq6aLSkz2BRT9tkuxMCC5n4rSRk/g3zp7e/aoS80A7DTPBDkkYefskcIQ5wrZmFO2
 cgL357PxnxS/ciYdGE0h6P2WTpX4M8Y+RuJUzPP1goPSfdhiYbXCG84+rg7Lk3JC/DKHFlRX1T5
 bBxFEAoha3pd1b767xTisWl9iVdiB90URFimUz1Yf1fyKltAMHyIBMoqdZU6nrplBdf1LowumRW
 s63KFDDX4twFiEjOrjAV8xfI9IVNpJoEEZXCWr0xS2QnCEklKUmypfAymkmJktWlqh5o2HoAkwr
 Vhjz+iA6nCDUrdmd5+3CeSMkpj+umZVHZHzIjSMXipqE6kZSKw3IUs2ySGUS9fNnHz31hvlQO1Q
 V5ElOgqX0xvgdzUiWG1vsxQamJqqv1qbg7OSn8CrxeUPbpNn2tBb0Uqifvrj0pd9/FPZPGGzP01
 TKQs6STL6CUBkq/ct2cEFMlL/hI04bMwOmGnQK8AGuzFz752hHxZSEtw==
X-Received: by 2002:a05:600c:a114:b0:480:1c2f:b003 with SMTP id
 5b1f17b1804b1-4805cf5ee34mr63246555e9.20.1769452955016; 
 Mon, 26 Jan 2026 10:42:35 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066be7704sm8229175e9.1.2026.01.26.10.42.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jan 2026 10:42:34 -0800 (PST)
Message-ID: <f017bee4-1698-4f9b-8874-4cb581d0cbfa@linaro.org>
Date: Mon, 26 Jan 2026 19:42:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 05/16] MAINTAINERS: add maintainer for docs/
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Joe Perches <joe@perches.com>, John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
 <20260123145750.1200879-6-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260123145750.1200879-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 23/1/26 15:57, Alex Bennée wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> I would like to help maintaining qemu documentation and I've been
> invited by Alex to apply as maintainer.
> 
> Files in docs/ that are already maintained will continue to be under
> their respective maintainer. The goal here is to have someone that can
> help on all other files that don't have an official maintainer.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Acked-by: Daniel P. Berrangé <berrange@redhat.com>
> Acked-by: Thomas Huth <thuth@redhat.com>
> Acked-by: Alex Bennée <alex.bennee@linaro.org>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Message-ID: <20260115203529.2713193-1-pierrick.bouvier@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   MAINTAINERS | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

