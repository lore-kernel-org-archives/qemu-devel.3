Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2825E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 20:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMByO-00072y-10; Fri, 13 Dec 2024 15:09:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tMByI-00072k-Rc
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 15:09:10 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tMByF-00052n-7p
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 15:09:09 -0500
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-5d414b8af7bso4318694a12.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 12:09:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734120545; x=1734725345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ovX3HD/z/ISDMbQnKRlfqN1MzCpi6H70Lc4sv0T5Nvo=;
 b=vbL1C1dnaDdC+Qn/wenUKl+w1HwLSLOapiuzCT8jwa5C371DCBs/Qr8ZKpCJaambT3
 OKhWKPzDDnMOXoHAwgyVgPw0ttGbhTgEVKi2gTwne5hZl9q66x6koroqM/PLs34X/QXQ
 Ir0TiKzJari5WUzOguk3p9M4e0vz4p52aZVtULBpDwEYNnYjxQzXan3vZqDOF1H4rUL0
 8wvdbFFnM7w42E8vPrQQPItgGIEDvXSsjm47yRB9nXjtSAj8HiTjpG7Lu1/aou1hmJ6y
 gXdB035n1y0rfCJCEqKEijnpYiEe1UV7Jq65gaspLeOtjUd16mT3S5xw6ahUEYCayCKb
 SRog==
X-Gm-Message-State: AOJu0Yz4idEwGoRQeO7WRX34IIqz/QoHO9S4vG8xssS4J9F80Qt23Nse
 ATQ9zyEWh+exEKhy4r9+/WXC6AIWf5ptVGh6F2yo6t0EExzj91d3
X-Gm-Gg: ASbGnctn/aL+ecwVlHAPckZMZ1Fg1pQcg8rhnl502FdGvgFoI7osQ74ay6UJ59bP+ZM
 dIQP/LnUpmaqufKM6j973zIkfEC8uAjWuZ0W4J5PGnat2mmnPJJbfZM3tGqA6JBn7NAGy3p03Gk
 ccYxa6enpnnHMz2SwUciLRJNctZDAKJMEL8b+gFfuamUnJznYW1ptOGxQIRP6puKFXaRvntEa4s
 Srg9mkG8EcVscqwdWdKKSyzHGDpTXoozY+oJWqrQCLvKaBrm5/A9XhAM/rtiysIavUh0G2VjJbo
X-Google-Smtp-Source: AGHT+IEqlfKhM75kzNf2vrpbvvY9WaEcN84Rhp5X2HFVnK8/cJKW0qSZUdt52IxcZabW9xeplmyktA==
X-Received: by 2002:a17:907:3e8d:b0:aa6:c168:8dc8 with SMTP id
 a640c23a62f3a-aab77e827c9mr469765966b.44.1734120545066; 
 Fri, 13 Dec 2024 12:09:05 -0800 (PST)
Received: from tpx1 (ip-109-42-51-17.web.vodafone.de. [109.42.51.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab96068a96sm10072966b.73.2024.12.13.12.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 12:09:04 -0800 (PST)
Date: Fri, 13 Dec 2024 21:09:03 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH 36/71] hw/m68k: Constify all Property
Message-ID: <20241213210903.0b626614@tpx1>
In-Reply-To: <20241213190750.2513964-41-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213190750.2513964-41-richard.henderson@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.53; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f53.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am Fri, 13 Dec 2024 13:07:10 -0600
schrieb Richard Henderson <richard.henderson@linaro.org>:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  hw/m68k/mcf5206.c   | 2 +-
>  hw/m68k/mcf_intc.c  | 2 +-
>  hw/m68k/next-cube.c | 2 +-
>  hw/m68k/q800-glue.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

