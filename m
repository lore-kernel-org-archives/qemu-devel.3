Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857FDC369DC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 10:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA4q8-0006Qw-OL; Wed, 30 Apr 2025 06:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uA4q2-0006QR-9N
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 06:38:50 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uA4q0-0003sa-HN
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 06:38:50 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-54addb5a139so7758100e87.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 03:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746009526; x=1746614326; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KqpgIjnifoW3KTq2w8UtdfsVzBFr74RiQYEWhFDmqLI=;
 b=eAxvzCfToHz7aIUEbvy8Yvxc0aW7C2l7YdtjcY4fsqPJ46O5oA5wN1TCNfr4az4f4N
 LJs8UbgnlKA6uGzJE6DFPmrZQDNcrjYPDSahEP+aWooVhRQCnpYWrdqZA9qbK3rOD//2
 UDVoBr6X7kIW4pSTFDYMtVuGgqfQ7rcZk6boeXrebijhJQ6Yzcl4q3BIFxSGW5iEs902
 EogmVKuATSCNU6wuMtzuOHrAiDEdLCg2FE9PkoKKvJmccrnFbCeJpvnyAlSEsNp5R8ec
 gJyqp+4+Coq6PqfsNc5OngualnVU4fGz6moL+hoXd5rLhROElbIhlTq6iPbEdGWoHI83
 fcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746009526; x=1746614326;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KqpgIjnifoW3KTq2w8UtdfsVzBFr74RiQYEWhFDmqLI=;
 b=cxAc0Z+pyRaDvsD4857JUjw4mtCUqkZO7NlrnhUWOLnS359rdrHCCvKwDc8KWj02/K
 s5nWwOCJ453MUCx84Yyo9jPXj2MENSFiRdcQV9/6wA4Ci2g/Rf2x2ExNOjtbihRUmN5D
 YqaK3CbAqqY7Rcu8WHMyNI/xQkM6NH8ivxC6X7G8HwRirv1lwCgqsJLH8hYguUi29Arz
 ISq4177BzARoElNryejyYkyuyD1xwiP16YbS6Gfz+q4DTGRm+RmQeLbl+ov+Mq7t6Mhc
 g8rroJWgup2wUYZiMu07qpavs8g0P9OP2EyzQYmyQiEhuWn8qKLHjRvprw2YLt3xiUla
 Vp2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8s0EgK01/k86VVEtKk/+Sje5PnFvzdOdh47c8nslchdq00Z+UpgDlO3IHDeRz00hQlLbmFrPQAzIV@nongnu.org
X-Gm-Message-State: AOJu0YwJH0N5lKf05V7QQOLexj2rO13xzyU1H6tv7gKRhj3jvJ7jbrwu
 Ol3Msz9gKAtuW6bxS7X9XI8/TQUQ4ZFbbOK4QOofCLZI/Np1cn4v
X-Gm-Gg: ASbGncuDKzshLQMGlTpt65jW6XsEzLBdaGvSoORvfTxvjVYPQUeexeyxdmIG2U8eBco
 5g8NS1uOE5ypPUzAs8YJ1fzy9saOaQ2DnnN5fyemehNcioxWXV/VtaK8HTsUC9oTsjtWwUFpR6b
 MqALUBc+uTuf2xW8f19aJ7/gGZHu76xzAaik0ysn2oNPFdFNH9nQQNJJgrIw8kgUE8QTsa5Q8Yj
 HDGlzQnMrWJcdbQz9XMYRubS6B+g/751bSYWnNh254ux/n7u+MHGwcQuk4l9vo3R/jRTLYwM9s/
 TqfQr5p0LgrRPRb82gcf6zoG9bfDjkxWT5r1C3JuUxaQkPn3N+702Q8QnOVrxbobjNjMI+6RgkL
 FJsgtc9I4pKki
X-Google-Smtp-Source: AGHT+IGQK0sv0TmiClwpeaCeqdwqAterH2DFYgsF//fQPKRNyz91VEejZkPcehVzOH0hYopbfG2M7w==
X-Received: by 2002:ac2:593c:0:b0:54b:ed9:2cf6 with SMTP id
 2adb3069b0e04-54ea3ace05cmr602716e87.32.1746009526092; 
 Wed, 30 Apr 2025 03:38:46 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54e7cb3bddfsm2128021e87.95.2025.04.30.03.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 03:38:45 -0700 (PDT)
Date: Wed, 30 Apr 2025 12:38:45 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Luc Michel <luc.michel@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH 0/9] target/microblaze: Always use TARGET_LONG_BITS == 32
Message-ID: <aBH9tQyUQH6ucVBE@zapote>
References: <20250212220155.1147144-1-richard.henderson@linaro.org>
 <ad364fce-f73d-4dde-b890-0ea86d9c4674@linaro.org>
 <d57e4f5c-a677-4cba-bbe6-85b997a3b57a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d57e4f5c-a677-4cba-bbe6-85b997a3b57a@linaro.org>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Apr 30, 2025 at 08:26:23AM +0200, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 13/2/25 13:37, Philippe Mathieu-Daudé wrote:
> > +AMD folks
> > 
> > On 12/2/25 23:01, Richard Henderson wrote:
> > > Use out-of-line helpers to implement extended address memory ops.
> > > With this, we can reduce TARGET_LONG_BITS to the more natural 32
> > > for this 32-bit cpu.
> > 
> > I thought about something similar 2 months ago, but then realized
> > MicroBlaze cores can be synthetized in 64-bit, and IIRC there is
> > not much missing (I'd say effort would be to add 20% more of what
> > we currently have). Just wanted to mention before taking the
> > decision to restrict to 32-bit. OTOH if there are no plan for
> > adding 64-bit support at AMD, then I'm more than happy to simplify
> > by considering only 32-bit.
> 
> I gave this series another go, and figured the microblaze target
> addition was done way before the 64-bit. C_DATA_SIZE value was fixed
> as 32, and C_ADDR_SIZE was not mentioned. Later C_DATA_SIZE became
> configurable as [32, 64] and C_ADDR_SIZE appeared.
> 
> Indeed what this series does is correctly implement the current
> target as C_DATA_SIZE=32 (C_ADDR_SIZE=32 implied).
> 
> I had a quick look at what is missing for C_DATA_SIZE > 32 and it
> is more than the 20% I first roughly estimated. So with the current
> implementation, this series is doing the right thing IMHO.
>


Hi,

Seems I lost track of this series. I agree that Richard's series looks good.

At the time I may have had some idea of prepping for full 64bit support,
I don't remember. If we ever add full 64bit support we can have have
another look and see how it makes sense to change things.

Cheers,
Edgar

