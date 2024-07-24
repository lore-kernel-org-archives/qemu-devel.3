Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6610C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 05:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWUiq-0003fT-9B; Wed, 24 Jul 2024 01:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWUim-0003eH-L4
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 01:39:29 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWUik-00069G-Uq
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 01:39:28 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-651da7c1531so59302837b3.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 22:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721799565; x=1722404365; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wDq0JCXV+a36ED65DiRHf0D+tx6Atx3VuuUum8H3EX4=;
 b=qdyrm0rHC4s7tmklY6HIpx8zWiCgZaqSybJbuAm1RlNj2TZd7xbrSY+g3FM0A+cZjB
 DpHuID21ghyHwlXqheUn69ebyf3HDdmziP+YfGFIR/1R8wyS3Yna6T25iXZNF7JFdnnF
 IeJdbLeO+ZOgD0/mI4K9Fqb93vK5+FCgkvcyBIGM0jFZQB7khDkKxAWJT5sNNbAbrTmh
 GYWXYwydeJ+h1XpO/gRwukTCopnodChUwZmQVQ0YhqLDKNfNVQEWMwm4YXZ2PLkzZ1lG
 Tn95OUuFwcoJEJMbOf0HqzB4s9Hov9XtYDSv0CcjmUh5I5t2k6IZQP2ZH4k53aHooLKW
 Cg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721799565; x=1722404365;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wDq0JCXV+a36ED65DiRHf0D+tx6Atx3VuuUum8H3EX4=;
 b=GBq+b/bdOtWIq8W/BWhG85tGgKzOEN4hm42TSlkW/05+kiHfopQBmXaoKnS/WDgXew
 Jo/KxZQc54t/jJtNT1LsfjDwt58hfZZWGl0cXCFWYBb8YAtJSTuAkzrHHIDhGUxbxLgi
 PM/BT35Uc/VaS3fOenWy9eAloPN2QVTVjyA6w0uL6VqIwwA/Jsoqj5SqzpN0GFhIYp1B
 ZK6F2ch9/SBMXIZppO/BSOHFRyfaFzn8j5PflDwJju/jrvf2iP21Cpx7bHqUqOVTgs1N
 14BXXhRKhqpx4rhmeLBCSqvav3cEz/jcrFRLPezFzcRGM/UhZaNaktlNbffQ01+rCFna
 t3fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHf51mOWQ725h2zI0ZXX7EMuAwHUjOCXH/yZhmOBdJzdIiK9g2IAy9pcD567i7F8aYuivggOGyH0hht3j4lwVM++T2pf0=
X-Gm-Message-State: AOJu0Yzcj9eBu/adxH3i+z9A+0O8BSlP3mzl/6BiDvtQNEveBoNF+U2X
 JYkxoZoEFWahi3pXOALu+MCshXzJMW6aqVbHUxE/akFx1sbQDaskvK0+2CC0OGw=
X-Google-Smtp-Source: AGHT+IHQKiizrpc1D1FX0tKuAb3p06dOeCduiuhau1+N7YZ54i5+jP9UuvGfiyT/CD/xqsHsE1KE5Q==
X-Received: by 2002:a05:690c:110:b0:643:6087:efb8 with SMTP id
 00721157ae682-66ad86ea2cemr127333927b3.3.1721799564981; 
 Tue, 23 Jul 2024 22:39:24 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70cff5526f7sm7834491b3a.118.2024.07.23.22.39.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 22:39:24 -0700 (PDT)
Message-ID: <6ade86bf-ba66-40b0-a55b-1f68ad1f9424@linaro.org>
Date: Wed, 24 Jul 2024 15:39:19 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/16] vfio queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <20240723152035.409000-1-clg@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240723152035.409000-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1129.google.com
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

On 7/24/24 01:20, Cédric Le Goater wrote:
> The following changes since commit 3cce8bd4d737f2ca688bbdcb92cd5cc683245bbd:
> 
>    Merge tag 'ui-pull-request' ofhttps://gitlab.com/marcandre.lureau/qemu into staging (2024-07-23 15:23:05 +1000)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/ tags/pull-vfio-20240723-1
> 
> for you to fetch changes up to 30b9167785177ac43d11b881fe321918124aeb88:
> 
>    vfio/common: Allow disabling device dirty page tracking (2024-07-23 17:14:53 +0200)
> 
> Changes in v2:
> 
>    - Rebased
>    - Fixed bogus email in "vfio/iommufd: Implement
>      VFIOIOMMUClass::query_dirty_bitmap support"
> 
> ----------------------------------------------------------------
> vfio queue:
> 
> * IOMMUFD Dirty Tracking support
> * Fix for a possible SEGV in IOMMU type1 container
> * Dropped initialization of host IOMMU device with mdev devices

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~


