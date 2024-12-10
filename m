Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC0BE77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 19:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL5XO-0007bt-Gp; Tue, 10 Dec 2024 14:04:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tL5XM-0007bO-A0
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 14:04:48 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tL5XK-0008OG-RT
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 14:04:48 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43618283d48so5564175e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 11:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733857485; x=1734462285; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ljUsKKJFIIMXBs+YOwyJLCz2Wm/jIXRled6ZTXR5qxs=;
 b=jspbeXYdwvsmrC+RiKpW7IFBQqSmtZhAxtZ65xddkS3Fl+0ohwwxyIDEpjOZUMM379
 9hW0A7a9EwxronIAMy/ptRpQ6QFKg725Bvi6piS7BMe1fpJU1gjgcsNiyrqCJsJktxLk
 /KNfxpqH8aIHcqrRBjLzHY8z8txBHm29a/7Xeb/zAZU+QpdVrJ0yIFA7zs1gun6V4Lj4
 d12UM3DIRgCtKPLxHqZaD/nIgmKIGxdQpp/CCjybDTm/Lxx7VsuUXSGB849LdV8ozaw8
 g/6lgPGdxF38AjtN5mAk3vpYNnHYQsoBXyoSqOzPQwOLfjcbBZymu77WJhEUt1U6xpQz
 zZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733857485; x=1734462285;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ljUsKKJFIIMXBs+YOwyJLCz2Wm/jIXRled6ZTXR5qxs=;
 b=si0xHohfqqq+7V0lRw3Mm7J4QR6Jwyo63oAb9MSuunO4sEMcT/xFg5nuAHEJAYB/Ns
 zIBwb9e5jODziZGbpLUghVFOq012vWwPvfbOYut0P82RHftsnIctzGoEGDYvpz1Q5zOU
 RHLyV/RGd5Ga/DxjkeipCcLEDUcQfpq2Xe7uE8qNrAKOw5eSEQRz4hJcIvu+7d+oR8rL
 3PEpEFyrNsr/JnoNV1mPV4+lH8XiWGVODJntSgAtffc4lgJ3Te6UJOez99m3fGY/y+Ow
 WvJmRd1yXtHdsMqprK0lgIoROhc1Oj+CJKslZEcyGOpAKl3vXEpoFn7blmKGulmxSI0f
 vyoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY80bOMfrXMIhEsOjWEXONW0lOdZIvUa5eL39XyJ2vJFzLRi9oNQYRCz+hm+vz8zPewqjbhBAMNQv/@nongnu.org
X-Gm-Message-State: AOJu0Yz+aMY1hnJ4nBQuEiRcDB9GuoWicMTRThYjN4fnWucMpDgKqYXP
 AL55rUHcbWGAc3tqqM92hSMNIuAVO//j7rrZyTVc1Nj+vW+4iL+5FUSf4nbwprY=
X-Gm-Gg: ASbGncuS08Juij/vvqjzJRpziAltyctBAklJurapSRZUtw3TKVujjGynlLo2sY4QkDy
 U8rWzF+sbGjxhZVcRErKYI6vzTDtpLV0M2l0ERYHHgEkwprU8AaRkjEmsfHZD1jzohoSWEBtcNQ
 HNYqWCcQbwkgupAG9S60iO31x5KRXh48JHSUtch6LgA5ZCOdeG3hojtMAEJyETgkMvdq9nfRJqu
 677dPFzAf9Nmjs4JNU4nDJzk6qiaGw4+8Y84nAZA470ewev+M/v
X-Google-Smtp-Source: AGHT+IGI6AglQsZO+TZNGmYOQ3qBudwye4+b2aIDG0eKqoZWMHnPjxC9IUwZ8A/YEZrxYNAhDBklUw==
X-Received: by 2002:a05:6000:471e:b0:386:3213:5b9d with SMTP id
 ffacd0b85a97d-3864cec5c24mr196504f8f.41.1733857484908; 
 Tue, 10 Dec 2024 11:04:44 -0800 (PST)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3862eb06e00sm12872989f8f.99.2024.12.10.11.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 11:04:44 -0800 (PST)
Date: Tue, 10 Dec 2024 19:05:09 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v3 26/26] hw/arm/virt: Add measurement log for
 confidential boot
Message-ID: <20241210190509.GB1212502@myrica>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-28-jean-philippe@linaro.org>
 <edae9f1e-1f80-4f22-9340-c88f440a5523@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <edae9f1e-1f80-4f22-9340-c88f440a5523@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Dec 05, 2024 at 11:23:09PM +0100, Philippe Mathieu-Daudé wrote:
> On 25/11/24 20:56, Jean-Philippe Brucker wrote:
> > Create a measurement log describing operations performed by QEMU to
> > initialize the guest, and load it into guest memory above the DTB.
> > 
> > Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> > v2->v3: New
> > ---
> >   include/hw/arm/boot.h |  3 +++
> >   include/hw/arm/virt.h |  1 +
> >   hw/arm/boot.c         | 47 +++++++++++++++++++++++++++++++++++++++++++
> >   hw/arm/virt.c         | 23 +++++++++++++++++++++
> >   4 files changed, 74 insertions(+)
> > 
> > diff --git a/include/hw/arm/boot.h b/include/hw/arm/boot.h
> > index 5fcbaa2625..f2518c4e81 100644
> > --- a/include/hw/arm/boot.h
> > +++ b/include/hw/arm/boot.h
> > @@ -147,6 +147,9 @@ struct arm_boot_info {
> >        * Confidential guest boot loads everything into RAM so it can be measured.
> >        */
> >       bool confidential;
> > +    /* measurement log location in guest memory */
> > +    hwaddr log_start;
> 
> One expects a stop/end after "start", maybe 'log_paddr'?

Sure

Thanks,
Jean

