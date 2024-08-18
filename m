Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C86CC52D7C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2024 11:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfeRb-0001fy-8E; Sun, 18 Aug 2024 07:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sfeRW-0001f6-6t
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 07:51:30 -0400
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sfeRT-0002UZ-Bl
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 07:51:29 -0400
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-4f6b67d9608so1278515e0c.2
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2024 04:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723981886; x=1724586686; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AR9tSyrBESGhFcbSvwbRNxfkXu0DF+aO60UM50Pu3n4=;
 b=WMoehorPfqV4+oxuBZtL3msiL9y4EQqIlPKC0O43qf2rnaf8umjcepq+WRsf+AWf0i
 bppCrsbIxuWpO4VIVapz3ugnxXMdyoohRy4u7bweixKUnvncDiPQYUXeg55vkDmeCZru
 XbA4fS3C1rlSr7KT4GdrxLcaE+E+3YS7arxVawXmAJW2BLKTSiTNGASIy+uY0dtzfWmQ
 kdnVl1Dmf/b7AIoojseRxNZn2EvgC8bMP3pyPuPYMszYumvhaQE/AslYoD/3KRStA4U4
 gGI6GPN1kR/70Iqias+5oOvxpIN1AFBo3sI5qA0Xy2/Uj0jdO+nsNRsKyiYe8KXJSZla
 UHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723981886; x=1724586686;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AR9tSyrBESGhFcbSvwbRNxfkXu0DF+aO60UM50Pu3n4=;
 b=MfgWE7L9MTrWMX5+BQYN2qwA5DI5jsY1Yx/GaPAUBCT3vvlAE9F5zZMnsnl2Xam+Ir
 kySz9SArD1NXefGBCmLcecV0kY+FnpZg3VAhyM0f5L3iTjfpW43JMraZnmZD012sdk+s
 ZnKJv6DLZhdbGnakHHkJ3BrYSOmmRN95fZfj9qQokWFINN3CixcooYJOF4n7sW8yvZcz
 yJRgo8DKdCBfPwbfmzkMwVKs1xPxjA1wv9V5jPQaiqAPdvDj14QKtPU86f1Ca1Bur1LC
 gbbgLOWC/Db9xuB2v7W/+/0i4+m85NWEvpSMOeA1t5H2sSr34lSinHfFjc10VOQSJ8Vi
 SYcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPAjVbSq/dQpVL6vxthyv1g9PUNx/Z/8bgo9PMlD43lNiPKTD5JkKAL4bGYj1m9bGmdsaod6oOibv0lxvJvKTuEXf+pWw=
X-Gm-Message-State: AOJu0Yx+/3bg0mh7I481RrYZiENy2irHr7RXtyr2UFsHb+1eH1Q7aKyP
 n5v8lcHqpMBdIvbCippxR1PBv6yGl3y3ihG39w1r/k8i3lsi5rsSIgTl/R4QCCvPmr2/Dw1l1/e
 8jK9xDH8y+3QBQD01uGWAbCX3CdQ=
X-Google-Smtp-Source: AGHT+IG6+RTPhb4h7Av46E0+CP/ev7FBWxmx6zFUk4/GzKgxXOoCOwyDB6CzFxUqr69DpKmwqaJIcqTVrRNq+dOr7lk=
X-Received: by 2002:a05:6122:3189:b0:4f5:cd00:e492 with SMTP id
 71dfb90a1353d-4fc6c981e94mr9237445e0c.7.1723981886016; Sun, 18 Aug 2024
 04:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240810164502.19693-1-dorjoychy111@gmail.com>
In-Reply-To: <20240810164502.19693-1-dorjoychy111@gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 18 Aug 2024 17:51:19 +0600
Message-ID: <CAFfO_h7+z9ByNykXNSs=dj+EcP1a+DtU8DG5VopcWq0DChTBMg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] AWS Nitro Enclave emulation support
To: graf@amazon.com, berrange@redhat.com
Cc: agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com, slp@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, qemu-devel@nongnu.org, 
 mst@redhat.com, marcel.apfelbaum@gmail.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=dorjoychy111@gmail.com; helo=mail-vk1-xa2c.google.com
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

Thanks for the reviews. I have now posted a v4 at:
https://mail.gnu.org/archive/html/qemu-devel/2024-08/msg02675.html

Regards,
Dorjoy

