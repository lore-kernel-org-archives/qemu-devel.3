Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F49AE677F8
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 09:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7Ali-0002Ao-5P; Sat, 02 Nov 2024 05:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t7Alf-00027s-7W
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 05:50:04 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t7Ald-00055k-Ry
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 05:50:02 -0400
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4314c452180so22224175e9.0
 for <qemu-devel@nongnu.org>; Sat, 02 Nov 2024 02:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730541000; x=1731145800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZkxudDt9DCi2euq6VgGz2vqtqV/mVwI4tQbZ8GHCz1A=;
 b=gf1hUIMk1YzYkKgsW+HXVx1+58UmVCptVEsRod1Awk6Uyi3dwfscleUfpIzIwzI6OB
 WDM7bTCcDTlBf5ciXZcvW0NDKURswO2f0tUPA9xrU8vjL6zzWzjnqSBUI436LB35mF0i
 RSTu04pnv7eYfldnMtp9FBDSc/KfI7NBxKT/Qt10vwEpS9v4rtdsRWrbjCTiJ9FIG/xA
 Nruf+5bqs1zSTdNR7fwuyzX7yMEdfS4jbqZSOMckJahIbFO4u2HTyOETVpibezATs92M
 WVi9aJbsAs41di5DXskb7CZ33GBPsems5RCB3cIczOJ0it8iIqxqYC2WZ6XvBTIgsRGN
 sVsQ==
X-Gm-Message-State: AOJu0YwiW8pJYBjeqDi664zfJhxy8nW8bUfa6z07fubImza1zJhoZQqx
 Vhi9S0+1EiryorsVAoScGBe2C7fyZxScKr3/dVqNRkwDW2AN8EVEFYeNxQ==
X-Google-Smtp-Source: AGHT+IE8E1hfEZU9zutO8ca1tu5jcQrGDDQVvjYCPH2swssWJgoL+dOBYDRYVwbeNTVCStz1bIn3ZA==
X-Received: by 2002:a05:6000:718:b0:37c:f561:1130 with SMTP id
 ffacd0b85a97d-381c149f129mr7070198f8f.18.1730540999996; 
 Sat, 02 Nov 2024 02:49:59 -0700 (PDT)
Received: from tpx1 (ip-109-42-48-251.web.vodafone.de. [109.42.48.251])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10d42adsm7553700f8f.40.2024.11.02.02.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 02:49:59 -0700 (PDT)
Date: Sat, 2 Nov 2024 10:49:58 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 20/36] next-cube: rename typedef struct NextRtc to NeXTRTC
Message-ID: <20241102104958.38413d31@tpx1>
In-Reply-To: <20241023085852.1061031-21-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-21-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.128.45; envelope-from=th.huth@gmail.com;
 helo=mail-wm1-f45.google.com
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

Am Wed, 23 Oct 2024 09:58:36 +0100
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> This brings the capitalisation in line with the other NeXTCube definitions.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

