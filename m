Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91455C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Av7-0005BQ-50; Wed, 15 May 2024 05:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7Aux-0005As-9z
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:27:23 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7Aut-0000jG-Tu
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:27:21 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-51f1bf83f06so8260602e87.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715765238; x=1716370038; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bw6hWLPAs2oyOTTeBO49FQmjxhOx2swaYxkpsAWphGg=;
 b=xA5P/+25xLm2y+Qw/v64rxmoQB9kjC0iSjjqNFV5/rdJA9PsTunjoYHa2EO1ek87Oq
 GDiqlZSbpCI12yjs+fuXUBANtwe9kF0TX7lFwHvSUh5WohBXtA/Ov+y1HkjwCjaWLJzn
 mF8JEjcK0mjl56w3nVHFhRc35Q07ZzZtg0PKJh5euUWWW23BkxqKoCiKDcf5TDE9+US6
 qq4enCQRaicQL4C/QCDC2YULhViZlD1Yj7MQwfAnOE172+lvAlBlxrf6zC7UnT5N3bvO
 vUQfEH/Siefcp1DRyZl5Q+ZLklKWmESGQqZwBZUNCL/IJMBPrpVgn65wUq3IADXSdfF7
 uF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715765238; x=1716370038;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bw6hWLPAs2oyOTTeBO49FQmjxhOx2swaYxkpsAWphGg=;
 b=ncyXLJJKkyuCt9heRCgDOy8UZ7Jbfjr6fZtFnJrL1paCaXGPRqZIs0Ga4bYc4r7gRo
 RrdqIlzGRDf2kCe6ryjb2zCi7Wn+vC1pZMsjyPyzL/sxSth9QeaMo3sfMAVSbKfZz08e
 T9JmgGvw1ZU6DJgD5BHkOlb0UfBON5dYzBbneyvtA7i/T3MdfM6f48pmFE0wQ7HjvbOF
 dWHkSk/aYKQZeGAUzcuF+Lrf+xgjmOkEmz4XmSDhdMAU/2CQE04cm4p7wg71tO+kWhrl
 xAdi4Brh06YbvSWlaN7j1rLuPlLn7uTqpkoubLv2cC5DoRJH8ZMuBXpDD8u5V8V4c4ce
 D1hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT7aXgnkt4N/74uHXfDqmKof/NE1vCgRLRYddtC6wDBmig5L9afMfuORpLTS31+HDt9wipoa93TG/E5BcKfYA9rCCwrQ4=
X-Gm-Message-State: AOJu0YwvVbPXk+DQ698QGyVkeE8fOONG52TfcetZSf2gePlW7lKyRT+G
 Q02HdJ5ZffFisqdWjf56x/NbZPDU4Snsa66m0o+X8S2pGEcqH/PDHlPGbCAht1RDKTLeVTWIUyB
 figg=
X-Google-Smtp-Source: AGHT+IHZbtTVMjuHI7C+1VPIPQs0//ypwawz37jej1aKdFWvAPThTr5Dklbeb9/l6QsxMH3+yFDZDQ==
X-Received: by 2002:ac2:48ac:0:b0:523:8d05:1608 with SMTP id
 2adb3069b0e04-5238d0517a9mr995704e87.24.1715765237517; 
 Wed, 15 May 2024 02:27:17 -0700 (PDT)
Received: from [10.91.1.91] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502baacfc6sm16010327f8f.72.2024.05.15.02.27.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 02:27:17 -0700 (PDT)
Message-ID: <caa5851c-466e-42e4-96e0-5b34dbdc306e@linaro.org>
Date: Wed, 15 May 2024 11:27:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/11] Ui patches
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20240514131725.931234-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240514131725.931234-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x130.google.com
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

On 5/14/24 15:17, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau<marcandre.lureau@redhat.com>
> 
> The following changes since commit 9360070196789cc8b9404b2efaf319384e64b107:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu  into staging (2024-05-12 13:41:26 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/marcandre.lureau/qemu.git  tags/ui-pull-request
> 
> for you to fetch changes up to 2e701e6785cd8cc048c608751c6e4f6253c67ab6:
> 
>    ui/sdl2: Allow host to power down screen (2024-05-14 17:14:13 +0400)
> 
> ----------------------------------------------------------------
> UI: small fixes and improvements

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


