Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC298C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 14:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rixyq-000702-LQ; Sat, 09 Mar 2024 09:47:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rixym-0006zc-On
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 09:47:16 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rixyj-0008N2-Kx
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 09:47:16 -0500
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-55a5e7fa471so2142644a12.1
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 06:47:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709995632; x=1710600432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4uPH9a4ObhHDfLI+80K/3uHZmFh7XwWIeUC6+H7lork=;
 b=MzWXY41Ba6KfcRWqAkBby7JpvwN8wez8A+7EUxk/HLhfam/xeUCVPt2yF4+RXmOWD+
 0axHd89JXSJIaIWGj+3dbm6FISFing9BGDflS27Q4LrceWsjGzsR/BM2hAWWlXaHokAF
 allffgygZvG0xOzm4b8aosutsjgbmkBVSwmryd9eRMH8rwef2EFHrK0I4bcBHyHDWHVF
 bfp2Fx3CP6iIlIGGXIfkkCzXMSa2BXIpNy0h074xx3UQMOOqd7p3zTB79xhJ5N3eLeqc
 MWWgNuz1CNCNDWvYD06ZqlCuSS0lpj8nYX6T1I5mOw4/BtVQzTb3oDi+sNrE0oUYGeuE
 qcKg==
X-Gm-Message-State: AOJu0YwyhN6bxD12TKaiz3T7Z2PT2Z6gZP/WhikeKe5qXUwFPj2y3xLs
 QXhWVDFKjlYozJhr+QwBSg7MIccakkKvoPAayjKNkWvMnB70lkOE
X-Google-Smtp-Source: AGHT+IFnq+VMuBhTVnRe+htrdg6kM13QK+JkCXC/qvonNfonrhxeOjs2qQY9aQuTcPqu/XuLGfmxTA==
X-Received: by 2002:a17:906:3994:b0:a3e:da6:85f8 with SMTP id
 h20-20020a170906399400b00a3e0da685f8mr1149617eje.30.1709995631924; 
 Sat, 09 Mar 2024 06:47:11 -0800 (PST)
Received: from fedora (ip-109-43-178-151.web.vodafone.de. [109.43.178.151])
 by smtp.gmail.com with ESMTPSA id
 n3-20020a170906118300b00a451e507cfcsm953060eja.52.2024.03.09.06.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 06:47:11 -0800 (PST)
Date: Sat, 9 Mar 2024 15:47:10 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Angelo Dureghello <angelo@kernel-space.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3] hw/m68k/mcf5208: add support for reset
Message-ID: <20240309154710.09dfe3e2@fedora>
In-Reply-To: <20240309093459.984565-1-angelo@kernel-space.org>
References: <20240309093459.984565-1-angelo@kernel-space.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.46; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f46.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Am Sat,  9 Mar 2024 10:34:59 +0100
schrieb Angelo Dureghello <angelo@kernel-space.org>:

> Add reset support for mcf5208.
> 
> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
> ---
>  hw/m68k/mcf5208.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 42 insertions(+), 2 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

