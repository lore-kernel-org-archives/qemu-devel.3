Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE221C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 18:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg7dh-0005fD-CJ; Fri, 01 Mar 2024 13:29:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1rg7df-0005ew-Ie
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 13:29:43 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1rg7dd-0007b6-RK
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 13:29:43 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5cedfc32250so2087706a12.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 10:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709317780; x=1709922580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F9rBoDsklV4sSaDJ2Nxyv8Sw67xMTR9cFJkVXYHHzGM=;
 b=mFX+Fp/xin1ykNKroxW0qjmYhZ3N9eiU7Rtmi00MAU43Fm5J3kehhhgW+/vNF8wrPZ
 R8MXZhswDrcBwgus0VaT/7B6jkZ2jOm/blbffmc5sCNTC7UsjJiYI/R37BaJGad39JKQ
 2qCdnyN7GzoMPDl8CPeB3bRDRjVRPiZzKOavxui+VygyeMdu5AASQZ3m4lQ9g27x72B6
 bs0IVloym7mFgwe1UlhsizldwFj8EC6I4/2JdpVhIVsHCiJNXbLQBfMNX/j6rPLQMyn+
 s/sYg3lpai0CByr/P9//Azr+tpnGa4TkR1S+e2g4bpggg1UOHdV1RzNLCFM878+4SF97
 N5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709317780; x=1709922580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F9rBoDsklV4sSaDJ2Nxyv8Sw67xMTR9cFJkVXYHHzGM=;
 b=s5O0pxPYpOliShiStMQ9+nwX4IeOcXlWMfrRXqG4PzVpSuVvHtAI+UFsM+T+UW3G1o
 CqhgVxC2fjiLlPPGE36sAGXy1YuE73hngxfSGApobwK7VyD4YoK6ai87+DRCcuByEN4k
 9f7ljpWo1c5DgdivO7Z6BwJJfA2rAFmiO+Cq3iHFNHqfqQgtwlOxVtceiWII0p+/rz7e
 Da8au1CyNnm6zQ/6xoBP0SicW4aHHvXmIUTs7TYm6LPP1eGd1F/x/WxbIiYCYceMyas6
 0tmyxX8AX/QKT8QeF1nttPMxn5HAQCiaKMx7VbCuv5Rn+/xTcLIl0K/G0/k4PILMvuUi
 UThA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpNWwy7l6rx0Nmlg9Xc6IKCm2hLRfK4bIiJ++wKPBSK2Dl4+LntMJBFLELzlXRlz3KRT6R+fDjcbrTt2hjkl7Zm412R00=
X-Gm-Message-State: AOJu0Yy5Ktp/onT8pOVffAIsKkOo/hyvwRwY73mgZKQ1zL1ZASwUTQva
 5yyCsszex4ov5PLsawFllOd1CFm0Efx7Ir4POq39nzEahaQRFeqvknzKSbgKN5U=
X-Google-Smtp-Source: AGHT+IE3cy8gJ+sdyVvdC0m6IVxwdGAhmSCGDsnQdrZBAVC1ZLYXDrIhO+vLQOiZiD+KVsAg0QhPKg==
X-Received: by 2002:a17:90b:23d0:b0:29a:c21c:674d with SMTP id
 md16-20020a17090b23d000b0029ac21c674dmr2483294pjb.14.1709317780255; 
 Fri, 01 Mar 2024 10:29:40 -0800 (PST)
Received: from valdaarhun.localnet ([223.233.80.13])
 by smtp.gmail.com with ESMTPSA id
 gf18-20020a17090ac7d200b0029a45b28d43sm3608260pjb.14.2024.03.01.10.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 10:29:39 -0800 (PST)
From: Sahil <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>
Subject: Re: Intention to work on GSoC project
Date: Fri, 01 Mar 2024 23:59:34 +0530
Message-ID: <6022175.lOV4Wx5bFT@valdaarhun>
In-Reply-To: <CAJaqyWfOaYmX-6qo-O2xWjge5av_2MDLnQVO41XLskLQC6nXsQ@mail.gmail.com>
References: <13625712.uLZWGnKmhe@valdaarhun>
 <CAGxU2F4jx5m5_ijNoWZpVK_MepvtDBY8L70-dSZmRUPmTskCNw@mail.gmail.com>
 <CAJaqyWfOaYmX-6qo-O2xWjge5av_2MDLnQVO41XLskLQC6nXsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=icegambit91@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi,

On Friday, March 1, 2024 1:10:49 PM IST you wrote:
> [...]
> You can add the recently published
> "virtio-live-migration-technical-deep-dive" :) [1].
> 
> [1]
> https://developers.redhat.com/articles/2024/02/21/virtio-live-migration-technical-deep-dive

Thank you. This resource will help me cover a lot of ground.

> [...]
> There are few other tasks pending for QEMU in general and SVQ in
> particular. I'll add them as gitlab issues by today.
> 

That would be nice. I'll keep an eye out for the new issues.

Thanks,
Sahil




