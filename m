Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DEFC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 14:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpUFw-0008Fd-1j; Wed, 27 Mar 2024 10:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rpUFn-0008F5-DQ
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 10:27:48 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rpUFl-0002YI-Oa
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 10:27:47 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-512e4f4e463so7621224e87.1
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 07:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.com; s=cloud; t=1711549663; x=1712154463; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6s9TY9/Cn4vJqrwwNmvG7/hGbs5cbUMGy83r/DdqAYU=;
 b=FJSmS37inbGTkUPLi3exhHThUIkZyHUzf96DJyy2OHKHkWtkZL2e3CaIMLS9ikWu1B
 WxeNvTzNy46meELwy7j8UHvnIPtQ1VdHo01a8vQury5/INBx69y7TsvqPuYgFmVs2KOR
 H/dOS0ETOXb1leWYVZj3SbyQ/On1FTtvfz61A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711549663; x=1712154463;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6s9TY9/Cn4vJqrwwNmvG7/hGbs5cbUMGy83r/DdqAYU=;
 b=kHLeiX9XeRRIaAv46dPsQtlZ3h3q6EAEjzun94rerk7Qf+MfU/TdZmnM6ZPUT4Wvig
 PBEkB3gqhVm/w649OB0zQQDPurzBXj1XWsKu91F2OOMZDtIRoDARPH89Vs+ZLUMEPqN6
 K0GPZ3MpclgLAeQW0sCc/zbJkz9lvKeslmFmGSog44xK7pnishDVbueyIp2i0uJCtZhG
 QQRRIADWpLJ00Utoh4w9ibSh2YzzJ9k1wS/99MN/BfGqvPfzmEHc4Z+0IKSOrXoE4WQC
 cKnDokY48MAWL9FT5vVlu6bohSpcxcw5tD03VcLphQl2XPaUi4j6ubZPlnzASQZCIVDY
 9WAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq7wWgM3GFapjDPhY0vFn9NurBV9nFiY6916rq1W+9o/+Hvc1pBeVJKtZeMOYCjNzPmwIO2fTNtOkpjbdEAjWtj4gPPwY=
X-Gm-Message-State: AOJu0Yzm6Rklj2+8ae/S2/r1WUgJcWiTZdRiOP89ej/T8jd+diHPUTmM
 fma6j0Ig5SUajeBn+3/4LFKZFqj2Oo1pDVnIG7Go8dvSOiGMUrG1AToLSBU2FMk=
X-Google-Smtp-Source: AGHT+IGfOGc5SfDKXbq/6cWQXWrbWdawL9QipNh4y7lGdJ/Uq0Y4kUnfad0T2fo+7kdSA94cBcA4PA==
X-Received: by 2002:a05:6512:6c3:b0:515:ba94:8929 with SMTP id
 u3-20020a05651206c300b00515ba948929mr4374913lff.32.1711549662886; 
 Wed, 27 Mar 2024 07:27:42 -0700 (PDT)
Received: from perard.uk.xensource.com (default-46-102-197-194.interdsl.co.uk.
 [46.102.197.194]) by smtp.gmail.com with ESMTPSA id
 jw24-20020a170906e95800b00a49856ae93asm3739062ejb.198.2024.03.27.07.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 07:27:42 -0700 (PDT)
Date: Wed, 27 Mar 2024 14:27:41 +0000
From: Anthony PERARD <anthony.perard@cloud.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>, qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH-for-9.0 v2 12/19] hw/xen: Merge 'hw/xen/arch_hvm.h' in
 'hw/xen/xen-hvm-common.h'
Message-ID: <8829dd17-308b-45fe-8d48-a980470316e8@perard>
References: <20231114143816.71079-1-philmd@linaro.org>
 <20231114143816.71079-13-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231114143816.71079-13-philmd@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=anthony.perard@cloud.com; helo=mail-lf1-x12c.google.com
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

On Tue, Nov 14, 2023 at 03:38:08PM +0100, Philippe Mathieu-Daudé wrote:
> We don't need a target-specific header for common target-specific
> prototypes. Declare xen_arch_handle_ioreq() and xen_arch_set_memory()
> in "hw/xen/xen-hvm-common.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD

