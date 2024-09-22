Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEC4CF9C64
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 09:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssJG7-0000gt-JI; Sun, 22 Sep 2024 05:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1ssJG4-0000gO-SX
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 05:52:01 -0400
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1ssJG2-0006aZ-1X
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 05:51:59 -0400
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-49bbf14d309so989564137.1
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2024 02:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726998716; x=1727603516; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9/BiY8ohPZmD2qmM641wpIeFyIt1x85ygmPnoUSz4Fc=;
 b=CATGXdtlY6wyFx5Jma0ffcXNP9nTBPkhk+/UL6ZO/rccG0mlBzemAOcE8toCvfaXyH
 v0Sv6V0bPM/n13NxtLCY9qeYC+/7SVKGcfXRkgQrEQ4pqteEIR6FWjOG6/bGWw7EUQQn
 7RiWmU+5I7SAQRtEIWFJUiCnUyYTtHF/OixKCRs5cJaOWgoWxVKZeBD68X+cybjZzezY
 1+ba9ZZ0veVmohWw3a/7f+/wXfTR+TVyzfVRbV9Oy+MEPUzw/8e1/UJjbiXXYi3Rx3hK
 xc1EX5lg8vhuXMpOtTvnyS1tqBbzbvGFtlBRlNszAZEFMGoQrtRH7QIU99fXF208ouOX
 haFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726998716; x=1727603516;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9/BiY8ohPZmD2qmM641wpIeFyIt1x85ygmPnoUSz4Fc=;
 b=S3wp4+wC3pyqVKro/mPj9zEpa6ombTWf3tkR/zl9XZp23sMO3nf0OGc+GhLqVRz+gJ
 GTCSkBSr3Fp2bLTyMJ4MC9Jsbj2ylY0MuIxcnqEzZObGPpfnBZLwJOqyh0gY+HOEWBih
 uhq+2wyms2O2E0xq2SecCpz9ZMvru1HANtH3LTZjPwN4TNgwbal6QclyeSCpdwdOZONt
 2H2O9qDL52J0QuCn0E5Fp6fbJ5u99LYKPFs5v+kHFBuanoJINEpthSCHNDEKT9JRLVYE
 CzYRi42TsTwFCwbMLrHA3DWILJXYzjhi4HnIYP3cxlmtArES+RJMvhulxBjA7LazNAf0
 E+wQ==
X-Gm-Message-State: AOJu0Yyss586yTK3RnRfit6eJSMjBz0wT+/mgasnirKfDLAvBPe9c/xF
 rLBy85DMRLrugh26ZNB+X3ioDjS0HIK08YU9Gsdn8Saq9hI83MScgDaJrFCPIKWioQBqL9gcTKj
 WL2qbDJVtPJEJgOYBRPsLv5JW2KQ+IEDr
X-Google-Smtp-Source: AGHT+IHQdvV1UqcL/WNO/VM3ep+9vqmPmSOywY7ovk/G7t7bagHTlryqN3tEXDOaO4xFjDwMani0CASlrndgoHeGPoU=
X-Received: by 2002:a05:6102:32d5:b0:49d:4812:913f with SMTP id
 ada2fe7eead31-49fc7650257mr4484924137.23.1726998715803; Sun, 22 Sep 2024
 02:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240905195735.16911-1-dorjoychy111@gmail.com>
 <CAFfO_h76PocPsyZhD-gKPoLQjeOaPc6cwsNU=u=APGbKOZG=aw@mail.gmail.com>
In-Reply-To: <CAFfO_h76PocPsyZhD-gKPoLQjeOaPc6cwsNU=u=APGbKOZG=aw@mail.gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 22 Sep 2024 15:51:52 +0600
Message-ID: <CAFfO_h6oJk9PhkJixCQcXcThs30B8oZkO8EPfptRzGmObh5Wtg@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] AWS Nitro Enclave emulation support
To: qemu-devel@nongnu.org, mst@redhat.com, berrange@redhat.com
Cc: graf@amazon.com, agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2c;
 envelope-from=dorjoychy111@gmail.com; helo=mail-vs1-xe2c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Thanks for reviewing. I have now submitted a v7 :
https://lore.kernel.org/qemu-devel/20240922094441.23802-1-dorjoychy111@gmail.com/T/#t

Regards,
Dorjoy

