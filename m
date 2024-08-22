Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E1DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 15:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh9b8-0008C6-Hj; Thu, 22 Aug 2024 11:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sh9b6-00084R-2n
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 11:19:36 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sh9b3-0006RZ-UO
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 11:19:35 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2702ed1056bso665043fac.3
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 08:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724339972; x=1724944772; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TsMdpxkuhC8XBJ3hoEtUYst7PwCzC+6DXa/tFoxw18I=;
 b=hpgr/1X1CIwkJQxZXUtZWW2yz9PN0VlKC4HEo7WMa9w4MX/5tdYTQENm9KeRrN04Zn
 DcFBV6XTr54+k8UUCgFi/pRRnconekqXaEOBTy0H8XJ7jsUwQ8+gcZqrprKlQ652tJlM
 nQfLzcvpZHSRAyL0D099gwKbArB8RZNWFhv+tdXN0/c8Rb9p8jD2BvRpVyg8g7xiRxLD
 uG8k0N3lwPaU+CFvOrdZZG6/Wbn8pMzevaxf+clu0jhSLafJw4+oKinshvvMD0xcQwIC
 A+8ixxH74c0m7D9RADPJonHWHPXneoeoc/ks83eJyKcsKifgMDcbghrvkl8ZUPAZkxbi
 S0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724339972; x=1724944772;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TsMdpxkuhC8XBJ3hoEtUYst7PwCzC+6DXa/tFoxw18I=;
 b=vOFWKsn8hmJIKASmSnITb6ns5i6WDd8YMMXx+OPGv3MDgjycOUsOKq30edIlfJ9n2Z
 YbP3E94MUhq4ROHZ7hiPkkeuoUiUCGC1AOhe+kt68C1LZ7H7pn/7I6Wna7hSqpda93jO
 +MNRpzAAMUj2HJvAiHMt+4JkBdytCRS5BaFhIdB6ldC3wACQmZly7aA3ptNOoq65f/mt
 LVo/pULZzUuXdh9gXKKbC0Pt/ajNzHaIhcvF6vm9V8EUVq2k1GdbjnJIwqBMaDln1UvY
 BOwITNbXKvCsSas9nFeomOar5Y34UWNf0MMWOONrV2hi+pMkgvH0w27YB/Fo4llLTJdC
 t4xw==
X-Gm-Message-State: AOJu0YzFC+cWZIy1m4jks3cfZ7uRohJrl/LfaVc3u2C8nhmRWbGXR5n6
 NdwlvFkYc6gIKqP8azRFwRcb1PI6xPhx+EAs7f/9/WoGT2T7bW+qt3UuLXr0hemHgOmemtGjGEK
 PZiVPMYmU+sJYehmmFFdXc32ev2Q=
X-Google-Smtp-Source: AGHT+IFpcX3Bf2K8EUBlYUtunMre7FiGNMCJFzmu59qJXrSwm2XH7/42QeaW7NExyeo8qLYs1DBsZSnAU4ZYcAgTs/w=
X-Received: by 2002:a05:6358:75a8:b0:1aa:9fdd:af89 with SMTP id
 e5c5f4694b2df-1b59fbede87mr752800655d.20.1724339972417; Thu, 22 Aug 2024
 08:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240818114257.21456-1-dorjoychy111@gmail.com>
In-Reply-To: <20240818114257.21456-1-dorjoychy111@gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 22 Aug 2024 21:19:25 +0600
Message-ID: <CAFfO_h633OizznL2D6LbFSZfvZav6qyFBRGu0+GKRnaUBefJiA@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] AWS Nitro Enclave emulation support
To: graf@amazon.com, berrange@redhat.com
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, stefanha@redhat.com, 
 pbonzini@redhat.com, slp@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, mst@redhat.com, marcel.apfelbaum@gmail.com, 
 philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=dorjoychy111@gmail.com; helo=mail-oa1-x2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Thanks for taking the time to review. v5 posted now:
https://lists.gnu.org/archive/html/qemu-devel/2024-08/msg03251.html

Regards,
Dorjoy

