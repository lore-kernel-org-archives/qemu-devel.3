Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C95C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 10:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu5qf-0007d5-Ib; Wed, 12 Aug 2026 06:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wu5qd-0007Vy-Nt
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:06:11 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wu5qc-0007wy-8n
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:06:11 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49978908b35so5704005e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 03:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786529168; x=1787133968; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nMQE7h14I36wZ3ZY1gsp8GABRi2+3PAMdZl+kwnqt4c=;
 b=s24xY5p+foAfRRIAMmzR0GZ8ejUX59544K5FXeNEELUCu3CSrdjtxFKdmkvhbgIOu9
 1/5GUrdocHMg7sGCI0QJ7Vz6+wMW0LnUOrtqihGyYltgLPWEGsWncuN5jKX6HfWoChAt
 xsVsSo/VW6L1uZXm6bdWMkFoz4iaEkEuvsbwaM+vQOnFhaONbp3VmRRaICc1YOEc2dOv
 9IWXemt4j9YmDeLgzPBXbGxOaS39hI9UM1gzA4pED3R5CyBbkHiq5jLOVMsupII4Q+ku
 gRkCRukfino+5vRK9goD1sMYpgpY+JoC/rPMBmvp+4ebi2EKZQJcDnZVZBxWwHeDMdze
 cHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786529168; x=1787133968;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nMQE7h14I36wZ3ZY1gsp8GABRi2+3PAMdZl+kwnqt4c=;
 b=o51YnnrOFkKdnRbt3FkSVXcFj1IzYjuD7oFOWJfbg8HB2vir9moooGd9vQ9DRvgKpK
 JgYAXFHHDCgIbtPAn7wzUu7rBDF5pHdXcRwMFsCf0Ivo7JofiIW+J6unYHsgz+FIZTJl
 fxrrldUqVPB8k8UqVvohoMa27A7REJ0nxV/omnE1ozDDNpBs9mA/9a39I495wBIFxJw5
 ImAyAp4sVR6rGRClNWlplHkBbLGGF5zzLQ6n+gxedJX3csBYS6mC5AWsnCsNXYf+vJL2
 SYg3C8M67QZ/SGmWoN1CClW+EAOQdi891ZLyNiikO/5J84oJUZaEAJBQmy8clLwuTo3P
 Qk5Q==
X-Gm-Message-State: AOJu0YzWfeX2q6FQdnTsDZaCFwjLGvvqnogp6xRdltf+guLL4/dFrTt/
 zTh+cmJ0TYsDI20wtgNV2cBne03fmKssUvu4fKGvScpt5uHCmQEoLoXphU5rDabPhjU=
X-Gm-Gg: AR+sD10BZz3J25WsPmTUhFA1TcjygxbKYhg60VZbsymNlFFVWUKf4cyHIx/lGdTblGd
 SSqyz7cJLseYhpISzzflENBRUnhRwsTpq8UK3ob9VzbYTMC9dyoALCLfHNHmiieRtljFDrqysv9
 w3WcZnkhQpc57Z3/YQDqvxgzQjIeZdEhMhWn1m0tHnHR6bAN1GKO36sO8lvHboytUmPO69KsSaw
 MokAp4svi+69yAr2/BAi/Doyoy2GaUSPuKHwIqaBzWHDS54MP429/cxkliuAzzNeUVuqfG22Wvc
 SNQpSbROnNufMd/XqpKRxWNggAyXFB2DfPTA7isHJVok+I/pCjUSdHaBszDdo0LUCwEV9dLF4Af
 7QM/wCI9myG721OEVQmtEA+9Bq0KzEyJkbO7rP7BVG/BKGIeny9eG09IQrIz0KgQcYSMhD4VfRt
 FBEvw6xAveqNKQZ11XFeituPaagl5c75Cffs4tLpB5efH1GZSuhfQzKMWUC5gTFBtqGTsFe5c=
X-Received: by 2002:a05:600c:4314:b0:499:521d:bff1 with SMTP id
 5b1f17b1804b1-4997c0e6fbdmr35955665e9.2.1786529168336; 
 Wed, 12 Aug 2026 03:06:08 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997aabab7asm60773175e9.6.2026.08.12.03.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 03:06:07 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 37EEA5F886;
 Wed, 12 Aug 2026 11:06:06 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Thomas Huth <thuth@redhat.com>,  Ilya
 Leoshkevich <iii@linux.ibm.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Helge Deller <deller@gmx.de>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v6 096/103] tests: remove tcg tests machinery
In-Reply-To: <20260728044248.137626-97-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Mon, 27 Jul 2026 21:42:40 -0700")
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-97-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.3-pre5; emacs 30.1
Date: Wed, 12 Aug 2026 11:06:06 +0100
Message-ID: <87ik5f1wmp.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> It's now built-in meson, which offers targets check-tcg and check-tcg-*.
>
> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

