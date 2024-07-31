Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF300C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 20:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZGNB-0001FA-QA; Wed, 31 Jul 2024 16:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZGN8-0001DQ-IS
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 16:56:36 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZGN5-0006wY-UG
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 16:56:34 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5a79df5af51so2597014a12.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 13:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722459390; x=1723064190; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ynsIRu3xm6xDUc6DxzLKyYsD15E49Rf12GFU47OzIUE=;
 b=VMKxXiCbBwj/+FwZEZSFk/LpvZebPbJZbZh0y4Y2zNK4kRlErXoykzXhHK+jFnRzQA
 3k5p4I+CjgZ/IdfMb7KP/do9opQgNaDoH84mQ02171RBnfB7FvquAMutq0GV/IYvltaO
 4OuKtcLprNqFB+pMWq9n9j33rTfQhRUG3uWfpokYMuVKFMY12482qA32uiQQN3OTSR6V
 BWx/3CgJAoA4PfKa5wnKTP1gS4s2ZVw5BoKfvzvtyheAQzsTWiJEtV2LCp6g4QDUeib0
 Q4lmG7TMVtf2XForM9MY9tUUByX9QR/qdem9xVgo9HemLA8hSLDdCP3uDPgXz3w9+b5A
 Vq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722459390; x=1723064190;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ynsIRu3xm6xDUc6DxzLKyYsD15E49Rf12GFU47OzIUE=;
 b=vbWJnHuPFL7QvrsqK662uguci658futfxM3JMIr7/FcxcsRBVHHHuBTLyL9zMe+Yu+
 ErMuGoYTjhPf0kp77Fsd5Mlhuw29eulxu1oAv1gzVBPPrr7J+uM5tRKdRsYYukBmMI4v
 FRKlQ2ZhXvjQFHZEqxDsZGpJ9TGAtGjQh3NK+xlU0vScvv34DOiw3WcqWYsQsK86EUDs
 /ZTybIVbYlhurfdIH+dVKtlveJ3ZSac8rL+TMtox7BbLglZXkL1rR6qmpvHLqPPxjiRM
 Ee6mVp3D4x/CBKC30h0nTpfpJpp+sg3gbOyvNtAEJgJJXv/ZVDpYbRxqdGqRNyN6tB5r
 RSRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnLS+7tGsvLoS9di8mwhecPBoNc7dH/IcMl2OoCy/bqdN97hUOate+lMyXFgFEyvy2HDFw8zFElFhgcQtNopg5Dycpehs=
X-Gm-Message-State: AOJu0YwvR/az8D4NHCN7XH9KrUZkRG+w38EHX701HcGRUzenuIt22grq
 nFx7nOgNPRLDtYkF+nIYC1pEku26XTWec/eHbpud2QN1vV11jcdn9lpc7M1uJNQ=
X-Google-Smtp-Source: AGHT+IFArZceLkfCdLNUVA7b5RRJhr6ST3tsZFW6VmeT7ZYa3UPWU/c9hfyRm8LpklIb0xDKpUoHzQ==
X-Received: by 2002:a05:6402:1aca:b0:58c:b2b8:31b2 with SMTP id
 4fb4d7f45d1cf-5b6f3f8b05emr283003a12.17.1722459390190; 
 Wed, 31 Jul 2024 13:56:30 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.130.148])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac63b59ccdsm9213628a12.46.2024.07.31.13.56.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 13:56:29 -0700 (PDT)
Message-ID: <4cbb56e2-b29b-4e78-b726-8750875ea172@linaro.org>
Date: Wed, 31 Jul 2024 22:56:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] hw/block/fdc-isa: Assert that
 isa_fdc_get_drive_max_chs() found something
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 "Richard W.M. Jones" <rjones@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20240731143617.3391947-1-peter.maydell@linaro.org>
 <20240731143617.3391947-6-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240731143617.3391947-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

On 31/7/24 16:36, Peter Maydell wrote:
> Coverity complains about an overflow in isa_fdc_get_drive_max_chs()
> that can happen if the loop over fd_formats never finds a match,
> because we initialize *maxc to 0 and then at the end of the
> function decrement it.
> 
> This can't ever actually happen because fd_formats has at least
> one entry for each FloppyDriveType, so we must at least once
> find a match and update *maxc, *maxh and *maxs. Assert that we
> did find a match, which should keep Coverity happy and will also
> detect possible bugs in the data in fd_formats.
> 
> Resolves: Coverity CID 1547663
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/block/fdc-isa.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


