Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CB1606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JdS14I6x
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVStf-0002g9-73; Mon, 23 Nov 2026 07:11:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVStd-0002as-0H
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 07:11:45 -0500
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVStb-0004D6-9A
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 07:11:44 -0500
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-67c0bd676eeso2049133d50.3
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 04:11:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795435902; cv=none;
 d=google.com; s=arc-20260327;
 b=emyfhTlSAg3F5ngg4Li4/elKRKQ9qJrl6w9/FXtimbg7wOZmMYtlEbxLeZNotbViTA
 7H51qKlSbcQKNwt9Wjxt8/1mRQk+fL4cTKTNLBJafzgCG3SwJU73kHLCcxaovMGLgRw+
 ckG0sf7Oupl0ia7KhmOTB8B/OEbAUuYM5jlGN8JxTT2PxCrIEFGbC6ooq7n2qwKm2qPQ
 Z9vYBm5aaG00ENzGWKs8yeE5I6RSzBnn6GJWKH+Z6eDfnk4Ozut2D/rl01jDpfSgYXfh
 eDKwi1f0LrmQ1PVoIMD58kJ6oThJkcpuZxkNGefYIDCBXBJjm9vijqTCm9RLcEkP71tj
 rqpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7bsd6MScyb/Cw9bSouzvpkrUzEybksY5A3VWBFLKcos=;
 fh=2ALTUQ4fM6Vbf5rhGVBfpTVykrqnFQBD6OcN7/kmt8g=;
 b=sh4/Zn9GZmddtCphZvlq0s85Tm2CKVoPreGV+3aIlFuEO7dwidbcwRd5Ew1yjAETTS
 7njlPU+8jfGW4ONE57vfviq4G5IrgiTt4TpZaFojH8qQqJ+hXw1InDtk9r6H4BOLzMw+
 uVbpzrlHm4ZmbOMm0n2YyL7mBnz3xFPQ7H1iTuj2qJduUrv986ugOlHqRtnqvq+kMYy6
 gyZButiqdk7yJUrndTQNmw5T5nEHE0gQPLjlKXpRyELLqBxqIVFlGo/OpYsGakTVTbNT
 MLuMnCHZ7YzgAlz/mx73pLuMBOOQyI26vklATZA5jEpJLQbYoLECEGCWdb8WWGtEu6aD
 P+dg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795435902; x=1796040702; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7bsd6MScyb/Cw9bSouzvpkrUzEybksY5A3VWBFLKcos=;
 b=JdS14I6xMJB7zxtdhvjNFpQ91fpjba3mSA9Jha8GZqLpOeifjht85Y+wKKKrz3xChG
 66OyuoRvC4YC4lLdY06jcO1MDlPG9Yqv985h/KpGEkAT0EUEzTDFIyvBd8Cjv2ezURNQ
 4WMRpMRVDj9OIAXVFQN5v4OXiOlh+BorfHAKp3bKW7caa0T2CoHqp4L8NrT4vAI0Y1cj
 5LDbe+uSvNdbEVsCSmYH7vuE1PeFolS3UaMyo9by0sFPeB7CuNOQkJWbVJoiRHtsorU+
 +a37+G7X5SmmdsPK6z+KbMPEcIVzQaUkem5MdSAxxPlI4+aQ/zPBb2HBXKWNF5hWcrUN
 J9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795435902; x=1796040702;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7bsd6MScyb/Cw9bSouzvpkrUzEybksY5A3VWBFLKcos=;
 b=ENTv/X+/yh6HvfWVmvVkSvk5kD8c4DnhDa8eSpVciy0hnPyPhuvwQVNRfog6rmV8Hm
 WsStMu9Qk7g0RTtk3qT2r0xDy/GeorUaaTO+PgxP+nzMoFMNOzph2byz03zLhMftksXx
 DNzgMv42//HulqHPrYUD372WJh4sT8fSUuj7HvmaGLisEHGkonuJ1TvxCOz0ADnB0AUw
 sec5/9p/IvXLgwrAnn6DFvJbjsUz/+tA0eTS/IZrZCT5O1yAAugKYciz32e1IvNsz60S
 mHeYFbIjP+FZhHsUzIKJDINR7LOpGLcGAt9iq2/mcn0mxLeEKpzRLn0eVx+65g8lM5C+
 vPeQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH0/1qig2GSYHRCMxGaahl1Vx+fsdFFNLyLFoo0aHFC7JE2jEWU3Js66hiTSU9kkF2KpeBCiQbQRwZl@nongnu.org
X-Gm-Message-State: APuU4Z9SFkaL/B5sgzNxF4Squuv/w9tdLo9Qi2Lrm7sfrBT6Gk3fsrlA
 pGzCXWOxPpW4MupNUNs337c+VemmfTAGHH5CR4t0mXxG+s8wCNJyWUQsFXM+E/jCkUkaadZPhOb
 DfCIaa+H3L/1siyIZG3yxGlwVwEBUOW058Ygsl6VYBg==
X-Gm-Gg: AZFdTZcBjQdl9ab9E5GkSkKpMoFgOvTKai2h0XD+G3U0F8tqRqK57mSA6gNUbxWIZ+x
 OU4+nM0Eg0GmSrTqHMiNQvhcmW83Snm85DhmG97H3rcAdsaCHHbK50I3+P3m1dgJ3ch0wJwal4h
 tHQ20iheb003fmmRsjW58zlJFju6ndxtXm/3RjlsPX4yxjo4EyBCGuX31NNy6tx7tftsme+HHnl
 MEc3FlHUtrbdgZHTCdjR8rhbzUZ9zUhoT07p8HpHrdd9QBeHc46kfiJa2kTThTDjPNKQvXbaqz+
 iz/iJc8QFgKMIcjZ5dj/7qWsn16lQA61QAnVRnvZgVnnOFSrDy+RSai+hwHd8QlPFrL3LRt+r/B
 p5QFacASwwQfN+jD3DRJ3QjN6WdwiJfsnvfKDEqcYLwkmL9YA/UL/ZbTMW85MaqLfR6gS3vUzGt
 M9hQJFrJ0V2M4SEr8NzRkU
X-Received: by 2002:a05:690e:13cb:b0:66f:c1be:a64f with SMTP id
 956f58d0204a3-67df4444c30mr5051365d50.65.1795435901705; Mon, 23 Nov 2026
 04:11:41 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119091922.1380805-1-fuad.tabba@linux.dev>
In-Reply-To: <20261119091922.1380805-1-fuad.tabba@linux.dev>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Nov 2026 12:11:29 +0000
X-Gm-Features: Aa3M54rpluT39izReyFJiIZcPDUpABTDZz_S3j63cL7aubt1aEvxAtxAxp_Umg8
Message-ID: <CAFEAcA9mkWC5re8NfCPQzgB5de+0DYC5TbQV9TXweEtMKzdi7Q@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/arm_gicv3_cpuif: Don't count a virtual EOI in
 EOImode 1
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 tabba@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 19 Nov 2026 at 09:19, Fuad Tabba <fuad.tabba@linux.dev> wrote:
>
> icv_eoir_write() increments ICH_HCR_EL2.EOIcount for a virtual EOI with
> no matching list register, in either EOImode. The VirtualWriteEOIR0()
> and VirtualWriteEOIR1() pseudocode in the GICv3 architecture
> specification only does so in EOImode 0 (ICH_VMCR_EL2.VEOIM clear),
> since in EOImode 1 the DIR write increments EOIcount instead.
>
> In EOImode 1 an interrupt with no list register is therefore counted
> twice, and KVM running under TCG deactivates an interrupt that its guest
> has yet to deactivate.
>
> Increment EOIcount on EOIR only when EOImode is 0.
>
> Fixes: b3b48f529fe8 ("hw/intc/arm_gicv3: Implement ICV_ registers EOIR and IAR")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
> ---
>
> Notes:
>     Tested with a local reproducer that runs a KVM guest in EOImode 1
>     under TCG, with more interrupts pending than list registers. Without
>     this patch the guest sees an interrupt deactivated before its DIR,
>     and with it the reproducer passes.
>
>  hw/intc/arm_gicv3_cpuif.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)



Applied to target-arm.next, thanks.

-- PMM

