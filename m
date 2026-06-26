Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A88DC43327
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd8T9-00023b-Ji; Fri, 26 Jun 2026 11:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wd8T5-00023P-Pg
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 11:27:48 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wd8T4-0001Px-6k
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 11:27:47 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-691c5776f95so1893736a12.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 08:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782487664; x=1783092464; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lMPVR7Op+BmRgHjHA1P9WAiI5PBKvk1TaK+nPnyJ/LE=;
 b=FvyigFO2OQQB0mt3Qz0yyt6voFTVaWKvEVwx3s4YRtuc1THcVJS5hlm9f2FyAs2Lh9
 YYH/ghf3sXUPYHTOizunSGDWGb518vOVyUQ+1N9nV4O1378Bxa/fMsWlCbSiaNgOaWOz
 fccITnGa4R1JuVOTnNFGXKYVk/yXqYIFDBDioCmaNaMZGaT6aTMN6byCkJ6VijzoLRf4
 eLtY1vbFS0CY5FO0muUD+QwxzOwkqiKXF7NYh/2wfxVBk5S0nZm0fE1U8VZWsElaP0F1
 ON2uaUvZmxMx6EDfQwE0QXC4DGw/92k3XGmu4m3U0TLfk6G4HHtzsDc889ZUNVQeg02F
 mD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782487664; x=1783092464;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lMPVR7Op+BmRgHjHA1P9WAiI5PBKvk1TaK+nPnyJ/LE=;
 b=TSXz+xTI62B9L3UCYKOn1Y73RnbhL44K1UqXEDwcxuoQ4GxC4i41KR8lBtuU9k57mf
 o8tZANRSZZS3kyKiSZXGwOddsV86XG33v1pVhrZRE5QyzjnH5GKcaGI7ybRa3pXUZBHF
 thnNWuhaR+s9oo5DxNnM5H2GYAaCE7FtJh62bC0EaodNKLjDVwbevcdOt9VuzZ/ABxl0
 oyVhx2Y6i2YpM3PqEcp/jTrScHd045hwq3/OyNN6NXb/KMDfhaKHAzhr2+5ELy2ClEu0
 smHEldmnTykaBncXt7Rm6GWiy8WtZ4JjUff+o3hrYtxRoXPYeoz7iuCBNtJYXuBGJD4c
 YizA==
X-Gm-Message-State: AOJu0Yzj8OkNBTN1OwpzLXBJswnSDzVomLXXhu8uMNtwOUrVUFWBEJMw
 jdeCpbYPc6tfcNJvo0uvWFwiMd64zK7aQnxbZLB+81fCUcO1n06a2PLGkOVSRaSy3I8=
X-Gm-Gg: AfdE7clCT6qLCbyTjRwHW/GOdL5e4JN0TcadJ7xlb8kDodlAL21Y4xWSmpuhPdEYf4c
 Fkgr/tfPOgWVjffqT4fuPjYkGVw1eTSzVZF0tWaYya6JbltMKpgXKnHA3NEV5AbitmoI8UUpn2R
 diWZXEfot5suTjI1Qos8FCiSxrWGU15y6PH/n4jGpYBXn1Huu0317/d6/Jg2v+5TY5zoNgWQ+wC
 X8qr8Ig2jivvNGBq984R4Tiut5xAbo/Qn9iubZxkCH5CYlmYMy5WGUZP6H96awD/y40VoGWvozR
 gGKl2jUZ+U4ORS/KpYqlW8ZivgSMGupjEVINZH9v6YNWNumXcYE0eLmTJD540ZAJsIPK9/+LvPl
 jHhzho0N0vK2dkWxb5K099c89WEa4P4f7MeAgVkwDVDlZYE0dSv7qeeFFyDPY5xmYcB8pbschYR
 O1GkvuUNYZaWgsMUlchYyrAlNB
X-Received: by 2002:a17:906:6a16:b0:c12:34ed:da11 with SMTP id
 a640c23a62f3a-c1234ede0edmr52615866b.61.1782487663689; 
 Fri, 26 Jun 2026 08:27:43 -0700 (PDT)
Received: from linaro.org ([2a10:d582:31e:0:6643:9f34:1033:9e22])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c11fbba9730sm362302966b.13.2026.06.26.08.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 08:27:43 -0700 (PDT)
Date: Fri, 26 Jun 2026 16:27:41 +0100
From: Jim MacArthur <jim.macarthur@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/6] target/arm/tcg: Implement new instructions for
 FPRCVT
Message-ID: <aj6abXmFzY3McY5g@linaro.org>
References: <20260624-jmac-fprcvt-v2-0-dc6cf8e512b6@linaro.org>
 <20260624-jmac-fprcvt-v2-1-dc6cf8e512b6@linaro.org>
 <4c5c2c64-34a5-4d60-a199-c31a837e38d1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c5c2c64-34a5-4d60-a199-c31a837e38d1@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=jim.macarthur@linaro.org; helo=mail-ed1-x531.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jun 24, 2026 at 08:34:23AM -0700, Richard Henderson wrote:
> > +/*
> > + * Floating point to int conversion, but puts the result
> > + * in a SIMD register.
> > + */
> > +static bool do_fcvt_simd(DisasContext *s, arg_fcvt *a,
> > +                      ARMFPRounding rmode, bool is_signed)
> > +{
> > +    TCGv_i64 tcg_int;
> > +    int check = fp_access_check_scalar_hsd(s, a->esz);
> > +
> > +    if (check <= 0) {
> > +        return check == 0;
> > +    }
> > +    /*
> > +     * a->sf should specify destination size (64 bit or 32 bit)
> > +     * a->esz specifies source size
> > +     */
> > +    tcg_int = tcg_temp_new_i64();
> > +    do_fcvt_scalar(s, (a->sf ? MO_64 : MO_32) | (is_signed ? MO_SIGN : 0),
> > +                   a->esz, tcg_int, a->shift, a->rn, rmode);
> > +
> > +    if (!s->fpcr_nep) {
> > +        clear_vec(s, a->rd);
> > +    }
> > +    write_vec_element(s, tcg_int, a->rd, 0, (a->sf ? MO_64 : MO_32));
> > +    return true;
> > +}
> 
> I had suggested that the same MemOp change be done to do_fcvt_f, for the destination.

Yes you did, apologies. It'll be in the next version.

(Resent due to missing mailing list CC)

Jim

