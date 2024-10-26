Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC746D10BE5
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 06:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4aK7-0007xF-9f; Sat, 26 Oct 2024 02:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t4aK3-0007wf-Ks
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 02:30:51 -0400
Received: from mail-ej1-f46.google.com ([209.85.218.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t4aK1-0005Q8-S9
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 02:30:51 -0400
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-a9a4031f69fso366854266b.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 23:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729924247; x=1730529047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4jaTXKw2i0ipk8lzCur1bmq2SlTXkYdTAbTPyTU9/Ec=;
 b=shF3+YsnIhrZay6EZJuvON0EJ5CY3/8aO+zO6HH4Jq3desn4Xxk5o0IssDA/ZeCUhR
 Ttb1WNqpzVk9m4Q4rWpWksXoyVT79E3EdElk4qtljtpB3w5+8BsIwrnZyl0D3KTsddHF
 wJcTOOyiXXSYiqPXNUK8Y/4wu+J+ZgM501UH5NYprQBI96ipu0F56zDqlMiOPfqUcGpK
 YTWwKazF2lBbBQ8+MuB9DR6A0BHI8/JSKc6oYT3849MeGdChHPz+RqF3Oh+BV0plFi2i
 FsbOHK5TA2GqIeUQxfvKyLQ73P7ztMGe/BHqDAhNtUXJMBBDtX+c980qvD/7b9G82MBA
 xccQ==
X-Gm-Message-State: AOJu0YxNnNk7dQF8z7hcuE0SXHQvJAOEfEVPz9RYPHeFf8GQ+lcc5Ts8
 wDqTU/HOQFdggXw8IKyFAoVCCmTbgOYls6tMGE1MsJe/KWQz4cmDbG5qXA==
X-Google-Smtp-Source: AGHT+IFEbirEK+LBnBH+sc/4MtWzjl6k6S7ivJ2PSAkUC4HSwdn/CkE/Yk8wDn1iM6iCwpZEs16ssw==
X-Received: by 2002:a17:907:9495:b0:a9a:161:8da4 with SMTP id
 a640c23a62f3a-a9de619f1b6mr113560066b.55.1729924246628; 
 Fri, 25 Oct 2024 23:30:46 -0700 (PDT)
Received: from tpx1 (ip-109-40-241-30.web.vodafone.de. [109.40.241.30])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b1f298db6sm142484466b.131.2024.10.25.23.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 23:30:46 -0700 (PDT)
Date: Sat, 26 Oct 2024 08:30:44 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 01/36] next-cube: fix up compilation when DEBUG_NEXT is
 enabled
Message-ID: <20241026083044.6d53f2aa@tpx1>
In-Reply-To: <20241023085852.1061031-2-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.218.46; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f46.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.17, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am Wed, 23 Oct 2024 09:58:17 +0100
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> These were accidentally introduced by my last series.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

