Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C28CC5321E
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2024 21:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siKgE-0000ry-Hp; Sun, 25 Aug 2024 17:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1siKgC-0000rF-MH
 for qemu-devel@nongnu.org; Sun, 25 Aug 2024 17:21:44 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1siKgB-0007bQ-6A
 for qemu-devel@nongnu.org; Sun, 25 Aug 2024 17:21:44 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2d69e2a88e8so255423a91.2
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2024 14:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schmorgal.com; s=google; t=1724620900; x=1725225700; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0Q1HKYlPdVd+kD2vbvO333cPyV2R+ntK+UqltjWvjMg=;
 b=L1A+fUs99E/yxtYtZ7SYwYt7CW0fux6SQqI4C0qTLXBhQHWavhUS28g75LuLkTOSEA
 7tSxqRRlM+jrweZqypa4cW+6Acyv8JZGYENumcmMPlfhtNXd9C8sXdHg24e8O2WpIw9M
 WfdVftkGmylsknFgCBO4e2sljmIvQe5T8zbas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724620900; x=1725225700;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0Q1HKYlPdVd+kD2vbvO333cPyV2R+ntK+UqltjWvjMg=;
 b=RZEESWy1UsU9iJY/oDz4UjCosegRgHSQYTx84W1Wvx3qZUB0XSFWdF63BV12W/uRRh
 hcA9YmzP/5l/FnII2vw8VD6o474CxtSUMJDRfA58CNXT25Hz2Lj6qCGgmt2GHcFpFzG8
 jGCuFcfcy7iazJ0Y1cZ/fFoxS6FEWKvnEJooHQAKpkisF83qbyAQNk/SgPuEdw8EaU5c
 m/YEAZL55UTUU3glHDAKyUp4E9HDe0dwYrBry04oTA4JXa6ttckOu2/di296KHbf7l06
 gDXDToU5JF659hTohFLzCD98/cFqRUCPuQ/OKcWg/I7IXs5yR2NC1m9lI31u231o4txq
 omWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJ7CLlNPB5InxpWp6D+gwQ4A+LBvYlbuYQ7Y7Lo/vbm6xIwfxvY+XuSy4zOGlOo+0euT9BEQBKEGu8@nongnu.org
X-Gm-Message-State: AOJu0YwgZfdw325zVnhqiwDpQyY8urzwW24JNWdXXDCNrxxLrUamidH5
 MYVB3oPyJA7k5s+GPwCuFnfugRDG7C1l1IfXV3GsZeAJzT/kq9Vpr3KzZgKEnPY=
X-Google-Smtp-Source: AGHT+IFPkslyIoumcvCJeHr/A8UqK7jTy0guzh8BiOT4GZCjhhkHS1aNqR7Zzr/crFZEyL5Aw58FDg==
X-Received: by 2002:a17:90a:7802:b0:2c9:6a38:54e4 with SMTP id
 98e67ed59e1d1-2d646d767b0mr6618389a91.41.1724620899982; 
 Sun, 25 Aug 2024 14:21:39 -0700 (PDT)
Received: from [192.168.1.33] ([50.37.200.153])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-2d61391fe09sm8411227a91.19.2024.08.25.14.21.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Aug 2024 14:21:39 -0700 (PDT)
Message-ID: <d13a4f65-26d9-4e66-9e79-3843bd2f61ab@schmorgal.com>
Date: Sun, 25 Aug 2024 14:21:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] hw/net/can/xlnx-versal-canfd: Fix CAN FD flag check
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Pavel Pisa <pisa@fel.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
References: <20240816163504.789393-1-doug@schmorgal.com>
 <202408210857.20254.pisa@fel.cvut.cz>
 <fdce5258-59f7-486c-bfd1-a4befdf72e3e@schmorgal.com>
 <202408220311.01551.pisa@fel.cvut.cz>
 <5aef262f-b1a7-4317-802e-8681451ac54f@schmorgal.com>
 <CAFEAcA-G1JocxSfs=bcNFqECPGZ6M=RrJ7vipqjg4CCNWYMRzQ@mail.gmail.com>
Content-Language: en-US
From: Doug Brown <doug@schmorgal.com>
In-Reply-To: <CAFEAcA-G1JocxSfs=bcNFqECPGZ6M=RrJ7vipqjg4CCNWYMRzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=doug@schmorgal.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Peter and Pavel,

On 8/25/2024 10:30 AM, Peter Maydell wrote:

> We're currently still in codefreeze for the upcoming 9.1 release,
> so I would recommend sending a v2 with the extra patches. Nothing
> except critical bugfixes is going to be applied upstream for
> the next week or two.

Thanks, that makes sense. Will do.

Doug

