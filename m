Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E71C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 14:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWzdz-0005uH-Od; Thu, 25 Jul 2024 10:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWzdw-0005rx-14
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 10:40:32 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWzds-0006pI-8C
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 10:40:31 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4279c924ca7so7242275e9.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 07:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721918420; x=1722523220; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BBxz+yrHbB28ElK3odkOn6nP//maMAIfieOQZI+uRXg=;
 b=TRC2TArirzkDX1J6wUxZKTrcHICdeu2qRF8QP64HrHDf427cfH2Ajhudrrwy8JwJsJ
 v+1/D5bxW/JxzrhHxR+ssnwtkNLxwCG2DbVTsyt8iDT9YgEE/e/dowxf3f0DV4nN/v76
 q1HQAOtEDnT9FPxqGXr998S06WXSbEKvgSgLfu2nm+KIyOZXbrGEnrnRr9/8VWlrKc+I
 keFVGtC4ySeWtpg6X0v38fbO2V9DF9n2ziljx9Ntu02jDDghYMcYT4KyvSriKDuCYtX8
 xMvDgabS72JiNAAoE89nSuhU8ED2R5P3VGpmMgb40bW96Rx5NykFaLiVT2KyobRW2RX2
 TjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721918420; x=1722523220;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BBxz+yrHbB28ElK3odkOn6nP//maMAIfieOQZI+uRXg=;
 b=gl1JZKmoxhi8oE2Hiowy8+hYPbuFIgQcPz1euexHa6iMxXq7dIk+g8ElTPb4gFvaQw
 9zvYeJew1uGtJfRNkSt6dgwedZGLN9StOv/L8zxbrRDbuAv2IVnZUtunoA/CWvjKo1fn
 MICQT6c8Umg1JQR7vtHdEOOMF/LtydOYA439jp0bIIHXpY0vjL6tymiA7uILDMkgXth+
 vNaHcmE0Xi9gkKg5akpqUr5TQf3vsmt6GoAHLODignzO+8POMna7utxWqi/2nxJesEW6
 A2CjE0jMKPB4nEpxCJEivpUmQIcu8X7LiBmGTZ0SfGYZJjbIN49u1hhy5J6n64Egq1wd
 rcaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+QXIUbFaSHiZAjVf27uCInrHjBNRMZwNJwnSk5oAC5FGv6axjwMOepVr9S3bnr21uOaKj5vxxeR6o77895s4zgFgcncM=
X-Gm-Message-State: AOJu0Ywz52I+DSXzcbQjqYq2jnVOAnpOKoWI49KPT2Xf4Xc0RDtUXgtK
 sjo02OMxPDfIRO5wUkjeHUhSHM5bn2ltmYbcbWpzLA5rFJ8VXbFXeU6j0pjj0fXB5+gTyirIIzz
 He5ojsx7YkPadWAaYVaV9NOljkG5O9NLFhpqGew==
X-Google-Smtp-Source: AGHT+IF09T53YF9yqGvPD1ZpIVuh9vasJ5qrFQA7jgf7POlnTktentMCcnzzbMJ5LCrfkP+Ez9NJSpzjT33uY2V8HOA=
X-Received: by 2002:adf:e744:0:b0:368:6562:9024 with SMTP id
 ffacd0b85a97d-36b3638a0b1mr1526073f8f.18.1721918420023; Thu, 25 Jul 2024
 07:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240722103531.2377348-1-smostafa@google.com>
In-Reply-To: <20240722103531.2377348-1-smostafa@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jul 2024 15:40:08 +0100
Message-ID: <CAFEAcA8cM59E3RiUD7vXa8ca2fbQues3HqaQzwOV3_-RUXsdug@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/smmuv3: Assert input to oas2bits() is valid
To: Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, eric.auger@redhat.com, qemu-devel@nongnu.org, 
 jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

On Mon, 22 Jul 2024 at 11:35, Mostafa Saleh <smostafa@google.com> wrote:
>
> Coverity has spotted a possible problem with the OAS handling
> (CID 1558464), where the error return of oas2bits() -1 is not
> checked, which can cause an overflow in oas value.
>
> oas2bits() is only called with valid inputs, harden the function
> to assert that.
>
> Reported-By: Peter Maydell <peter.maydell@linaro.org>
> Link: https://lore.kernel.org/qemu-devel/CAFEAcA-H=n-3mHC+eL6YjfL1m+x+b+Fk3mkgZbN74WNxifFVow@mail.gmail.com/
> Signed-off-by: Mostafa Saleh <smostafa@google.com>



Applied to target-arm.next, thanks.

-- PMM

