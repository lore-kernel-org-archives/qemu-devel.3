Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3B0C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 15:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU6HS-000248-5n; Wed, 17 Jul 2024 11:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sU6HR-000236-5F
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:09:21 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sU6HP-0004Dd-4H
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:09:20 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2eeb2d60efbso87363901fa.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 08:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721228955; x=1721833755; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bQkNj5pgx13qsMzcdOU0QW0CL854aAv9poMaOUpWJgA=;
 b=Cp4zGnHCCfPxX+nGVawNpgH2OiQXdJJJ4tqcKYWZtJc2zvYQ3+wQIaz6pdV5Jc+Bfj
 dBj9P6Cyt/xIxlESoOYju4WfF9Xp7TfOPFJ5WhQcwjZzCnJnSmIJsLOadAHo3bGWuyHX
 8sJAkOV5gXFTkLo8ZpLzbNic0t0mu6zZqxmkmjYdLuXYjduTvuCT/jKptCrrQ4OGSWzk
 rfjQYfyZFxLPADjwPV6Wl1SQT1H7bQlwBUOr3qOc1FyU6VLcHgwofz8faszTIl8ASbbM
 5TJfjskCaOlzBEhpAmvfNA4snSh80rsgvs+AWmegJOoARRjDVbmRgT6zucwLhZHP9Esc
 p1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721228955; x=1721833755;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bQkNj5pgx13qsMzcdOU0QW0CL854aAv9poMaOUpWJgA=;
 b=jFphY/SkCSOA5F/ziflsWiLC+xIYhF0WrX4CdhHOwzOUmGWlXonJzVI9OG8kp3uzM1
 03ZaPhMFZpjHfFadaeQB6wpZkhJbu3KwLl9hMmOj5Q4A4eOiQnLCCB/+Pr7VAoLDkik5
 oUKvTu4GEwflItFGlgLMDa1WokOKIzEuoMT9AQgk4kyJQcXottiPKbdUvyBp5Nsl0QQh
 wQInjRJQ0oWuphbu3mU8sbWS4gifgyQMRxCU3NssY+7RUzP/+KCSb6VMJaLVK3SW8eSv
 eSGHAVg/ez9OxvyE35gnwQuEn8dHXXkVXPcO1uJyDXO7q6fpgpRaolzQVPL+E5xUHene
 pvpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiphIuNG7F0mIs1OoaVBJMTPGw04YJJ7197kIhe8UvrueXfKIbsygbCZh19ud5eT17zSIRqOxfjCD0QQ4HCZCm6TZvGWI=
X-Gm-Message-State: AOJu0YzFVN+A1PkI6Z9ff7BiRYmIXgMk/vu8Rvh2vNBZIZf7KSpnfV1G
 itmqZ6BhCYhJnO3iir8DJpPFUuse+OIx3L2YU4ATGsEcD0TOW7BbSVAC6TePqY4=
X-Google-Smtp-Source: AGHT+IFdsJovopPtMAmvSHHK05E4ASh1jJbJQfOs70sw1mBeWMSJGO5pkKGwcBPXhUeNIm+33dSQyQ==
X-Received: by 2002:a2e:92c3:0:b0:2ec:5945:6301 with SMTP id
 38308e7fff4ca-2eefd08fe2cmr13105851fa.18.1721228955183; 
 Wed, 17 Jul 2024 08:09:15 -0700 (PDT)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafbb77sm12123183f8f.72.2024.07.17.08.09.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 08:09:14 -0700 (PDT)
Date: Wed, 17 Jul 2024 16:09:31 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v5 00/18] SMMUv3 nested translation support
Message-ID: <20240717150931.GA3988597@myrica>
References: <20240715084519.1189624-1-smostafa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240715084519.1189624-1-smostafa@google.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=jean-philippe@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Jul 15, 2024 at 08:45:00AM +0000, Mostafa Saleh wrote:
> Currently, QEMU supports emulating either stage-1 or stage-2 SMMUs
> but not nested instances.
> This patch series adds support for nested translation in SMMUv3,
> this is controlled by property “arm-smmuv3.stage=nested”, and
> advertised to guests as (IDR0.S1P == 1 && IDR0.S2P == 2)

For the whole series (3-9, 11, 12, 15, 16, 18):

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

(and I think patch 16 is missing Eric's R-b)


