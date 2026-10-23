Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E1A606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 13:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oby1/JLL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKEyC-000116-4r; Fri, 23 Oct 2026 09:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1xKEx2-0000lG-6W
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 09:04:56 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1xKEwz-000883-Vk
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 09:04:51 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48dfaa3fa12so1447140f8f.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 06:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792760686; x=1793365486; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VktTnkWg+E5BlUf/8qSwPyFSFRgwKL6T0Abe0MOX3PE=;
 b=oby1/JLLi3wR1IeUy3pydbu2wvKHTLa/gJWb+WXydMGAxEamF4PvjJ9om3v0orw7q6
 2T4owMqDqZvmeqKJrZdCSs/stLO28pMeQtoLLHfCPeomI9MkOY36eNnpYtIF7uCfUmMY
 XKxN40e8mzXoa2hKW7SeDt1Uo5zV7q9CKjmA4/268Sst+vCH4HhGmIZkbSX8vakYERPx
 sD4MmjaIq+G7EK4STy+og7s7PjynC0I0+KPt6raCOIIGOWJaYcTpcOiy47L2jd+ifhot
 yhxIYJP2V1OvNUoXSrl4NuyuTz0JFVb7IxwXaGY8KnZdMKUY+g0k2QIHu7fhq9ir5OQC
 ewDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792760686; x=1793365486;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VktTnkWg+E5BlUf/8qSwPyFSFRgwKL6T0Abe0MOX3PE=;
 b=H2SVsEql9q917jjx5cdX/MZrVS0mxlzJYE5ZahQmRNUx6YDv4ay9yM60wQenQ9wRX9
 YXJ3jNDUQfS8FK3djFsQYEdQJu7SDtPC+seOc1IXJD18NmB5UZzlw0uoPp++78mKvJ1C
 DYG6q5+opksYuOHJaPYd5zkISaqBOBMxFKC4RpFt1KS+IVOHzME4NUcC+CJ6ENv8JgyV
 V4++wwasLUEh3yEIooS162KoRASS5YgmqFKVC6CluCejj0shoIovp/EERQFQKd1Gxn1y
 hi9QoaMgaT8aygY7yE1IAZuhJCqtPfnron6wFaAL3t5xoD4Yd3g8k1AATYZI64qgdPGD
 HUDA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZK7MZH0QTVRvszaKuxyWGsgx/ZNWZoJPAbU04q7QNlwS6plQ8zAioIv/dvrPXSioYgYgKKy0GKMMJ@nongnu.org
X-Gm-Message-State: AFq9FYK09Y2x7PcTfWQl+yY8TPci/bI5UpPzKZiJiuWztvs/ONtEo6Vg
 SOU3c/vcbgGvy9+lPbek3t5dpZDT5RxQnQyCSiEQYmkDb30Lv99mpZHu
X-Gm-Gg: AYBFou0lS6puykPlnfFZRurLcCXEabrOCB0s3aU1gsBgSH8UQtxJr7gKGmy0ZmEgClI
 YPc7tVvDVubafHf2GdFX8tx1sM5/68zDzz/fKDCc96zpaZ5b2bgJ7vj/adwBl4IyTc/CbhG2N+0
 DYp/9h7K9BA+lQHVhxiyZ61U0cW9Z12G6YhlUrNmHTcKYxhyRESFLatyvdAWnD4xnlZ0EuDS2aF
 yqgcDe5TWj/noM1CZGZEvf0LWjA1kpVfS6ZDDouzPRlOvHVJaXhsZGvD8+48OxgqDRmejuCi4L7
 C2M5a6IkMpounosI4+KFCo7/YX3parsfa65Lydr+N2VvcAdVszEUU59wFmjCfPVjfHxdH+f1/7d
 iVZvXEjeNGb/P50vygDdqEaw1qelGCN/iQ4cBI6bCWPOye2nJDZ4x9Y5XWDz57MkJIxn07Xl0Ne
 w8jfOgUcxi4njmjF//R/ks1zebcNH8ac+b4EXJUpwh7+i6G79B0GZu0rBeEMJKERImgf9zlk8Ke
 jmMRKIFvlh+BicDsgh+wkz6UKajuGx175Ab9nsmOt7O9f/86tLmIBUCI0X6ukJDjHAb8S1rFHWC
 nxxv
X-Received: by 2002:a05:6000:2dc2:b0:48d:eac6:5c2c with SMTP id
 ffacd0b85a97d-48e2d2523b3mr11220574f8f.15.1792760686293; 
 Fri, 23 Oct 2026 06:04:46 -0700 (PDT)
Received: from ?IPv6:2001:718:2:1654::1aa? ([2001:718:2:1654::1aa])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38031534sm4993335f8f.25.2026.10.23.06.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 06:04:45 -0700 (PDT)
Message-ID: <dbd7483c4d4d6330f7496d593b102db2efb22a6b.camel@gmail.com>
Subject: Re: [PATCH] hw/net/can/flexcan: Fix FLEXCAN_CRCR_MBCRC definition
From: =?UTF-8?Q?Maty=C3=A1=C5=A1?= Bobek <matyas.bobek@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Francisco Iglesias	
 <francisco.iglesias@amd.com>, Vikram Garhwal <vgarhw@gmail.com>, Jason Wang
 <jasowangio@gmail.com>
Date: Fri, 23 Oct 2026 15:04:44 +0200
In-Reply-To: <20261022195924.672606-1-peter.maydell@linaro.org>
References: <20261022195924.672606-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=matyas.bobek@gmail.com; helo=mail-wr1-x433.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 2026-10-22 at 20:59 +0100, Peter Maydell wrote:
> FLEXCAN_CRC_MBCRC is defined as
> =C2=A0 (((x) & FLEXCAN_CRCR_MBCRC_MASK) << 16)
> but FLEXCAN_CRCRC_MBCRC_MASK is (like the other _MASK values
> in this header) defined to be an in-place mask
> =C2=A0FLEXCAN_GENMASK(22, 16)
> (a value with bits set from 16 to 22).=C2=A0 The mask and shift operation=
s
> are done in the wrong order, and so the result of the macro can only
> ever be zero.
>=20
> Fix the macro to shift first and mask second.
>=20
> Cc: qemu-stable@nongnu.org
> Fixes: 3c4e23cbb597 ("hw/net/can/flexcan: NXP FlexCAN core
> emulation")
> Resolves: Coverity CID 1662973
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Matyas Bobek <matyas.bobek@gmail.com>

Thanks, Matt

