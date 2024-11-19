Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349E8D60D0C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 02:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDE2F-0000S7-RJ; Mon, 18 Nov 2024 21:32:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tDE2D-0000RQ-Kc; Mon, 18 Nov 2024 21:32:09 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tDE2C-0003Df-1y; Mon, 18 Nov 2024 21:32:09 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7ed9c16f687so3090568a12.0; 
 Mon, 18 Nov 2024 18:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731983526; x=1732588326; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XXffGWPbwRZvY8gvudf5PzB2IWccqHhsLcPtqdhVsSY=;
 b=J5Kh33cgkv4A5Jdql/jipZN0al7q3bqruJwgooz7A3zGQTE4UylEbSAMdVcuY5laRr
 osSBPXnJbd/tus77Fis6Ax+LBCFGWK4Gs4aywiKjUhZ/jR89y6eM9wH0tGNuovjnoEls
 DWSNJVU0J9XmUV0pUP+CTHd3p5+PjUS6FRsDuZEhtWISB4tNtKcFQ7kakuoRFy9kiQwQ
 9mycBnhbSh8CkEDt83yDwFIXBRwt9disg0oo7KqOFQXWBO4EMIPvuCNqx59ytjPo8oFt
 f+DHDoGEjz3N1dErSDa+8/g3TU2VgeePnxXNuBqakx4m65g4MtXx0OB/d7v8jS5QCB86
 z5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731983526; x=1732588326;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XXffGWPbwRZvY8gvudf5PzB2IWccqHhsLcPtqdhVsSY=;
 b=WHQBrpPBjcQKR/vaj9vypeIAGxw2dDVrJBGWjVpBi5ZmSdsDFzo/NqeMmKc+1qE7AN
 CdwrazrVOpa2Xo0nWjRRSYiLwH/loD9k2zfSkV17QI4wz6pgfvG+6Hk6zDPVBixHOf+p
 yGNeEKjDw2xkdp5+tixKotyQ/nxY49sprGNSE2An/Mvq9kkgHjJet1736od7g2gGvvYk
 xXEomzBRDl7GxyAvQP2yLRLfK+doWWAx/9bF+/Zfjmm6OfRnQVmkKPA3UcvUdv0BxX8A
 mm6wSKvZHu6BH0fbQ0owo0mu0FgXAwZgOuRCmuWr6gPLlkJ2ts5rQQE3CIQ2rlUKIAOO
 fyEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxMSEWroIpz5OdsPmitlTaLxkGOFpcd5kutGjbS1iHpXO7zKwnG5pRVGAyMHlCmOinnwosdhXYZu6p@nongnu.org
X-Gm-Message-State: AOJu0YzkAKRUBgjUOua3cJSnWSKXzQnOkq4GHCFhogiRPsbpYJGIBHGb
 ueP7D2yA/SqdUANdvbZlUZfDhNWuCw7j41n7Af7xyvbHFH9rvPgG
X-Google-Smtp-Source: AGHT+IGXRG8TiSaI4fOwRhdpFHXiNUnT3tCrD9v0KLhueVxlXIyGkgjigUX8T8so+FY9WePWXWIoFg==
X-Received: by 2002:a05:6a21:3291:b0:1dc:c433:144b with SMTP id
 adf61e73a8af0-1dcc433158bmr606345637.27.1731983525872; 
 Mon, 18 Nov 2024 18:32:05 -0800 (PST)
Received: from localhost (124-171-72-210.tpgi.com.au. [124.171.72.210])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724771e18bbsm6936008b3a.135.2024.11.18.18.32.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 18:32:05 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Nov 2024 12:31:59 +1000
Message-Id: <D5PSX0JIIGY8.3CPW5U4P5H5C9@gmail.com>
Cc: <qemu-ppc@nongnu.org>, <clg@kaod.org>, <fbarrat@linux.ibm.com>,
 <milesg@linux.ibm.com>, <danielhb413@gmail.com>,
 <david@gibson.dropbear.id.au>, <harshpb@linux.ibm.com>, <thuth@redhat.com>,
 <lvivier@redhat.com>, <pbonzini@redhat.com>
Subject: Re: [PATCH 11/14] pnv/xive: Only support crowd size of 0, 2, 4 and 16
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Michael Kowal" <kowal@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.18.2
References: <20241015211329.21113-1-kowal@linux.ibm.com>
 <20241015211329.21113-12-kowal@linux.ibm.com>
In-Reply-To: <20241015211329.21113-12-kowal@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed Oct 16, 2024 at 7:13 AM AEST, Michael Kowal wrote:
> From: Glenn Miles <milesg@linux.vnet.ibm.com>
>
> XIVE crowd sizes are encoded into a 2-bit field as follows:
>   0: 0b00
>   2: 0b01
>   4: 0b10
>  16: 0b11
>
> A crowd size of 8 is not supported.

Squash this into patch 9 as a fix? xive2_pgofnext() is introduced in
patch 10, but that's not enough to worry about changing the comment.

Thanks,
Nick

>
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> ---
>  hw/intc/xive.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index d5fbd9bbd8..565f0243bd 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1687,7 +1687,26 @@ static uint8_t xive_get_group_level(bool crowd, bo=
ol ignore,
>      uint8_t level =3D 0;
> =20
>      if (crowd) {
> -        level =3D ((ctz32(~nvp_blk) + 1) & 0b11) << 4;
> +        /* crowd level is bit position of first 0 from the right in nvp_=
blk */
> +        level =3D ctz32(~nvp_blk) + 1;
> +
> +        /*
> +         * Supported crowd sizes are 2^1, 2^2, and 2^4. 2^3 is not suppo=
rted.
> +         * HW will encode level 4 as the value 3.  See xive2_pgofnext().
> +         */
> +        switch (level) {
> +        case 1:
> +        case 2:
> +            break;
> +        case 4:
> +            level =3D 3;
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +
> +        /* Crowd level bits reside in upper 2 bits of the 6 bit group le=
vel */
> +        level <<=3D 4;
>      }
>      if (ignore) {
>          level |=3D (ctz32(~nvp_index) + 1) & 0b1111;


