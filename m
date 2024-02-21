Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDB5C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 22:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcuyj-0002Ih-HP; Wed, 21 Feb 2024 17:22:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rcuyi-0002IY-EZ
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 17:22:12 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rcuyc-0005pQ-UG
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 17:22:11 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e3ffafa708so4376505b3a.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 14:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708554125; x=1709158925; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Q/PnaOwqVbcHGb/A3Q8ZzkQufGjjKSkGSQi76MFXAs0=;
 b=Y+bnNoW8IR9WPS11A7KC8t9WHO7jw/xikhnLoZY8X8Qg+JPenxySK7qTfSxmg1D+b8
 PZDkrTLhUZ+RyexVyEadugQvLNqmkWZl+C56ngu8uAbnK/jDIyQMry3PF1yPSJb40UKj
 pHS3VKdLgBV8pVD8o7tWwwYJBUr5QiQ7bcTudTJzE89cqW8sJrUWswtuXSF4GCaONjjE
 DREwyG5lEU7LvKV/Zd48rYeNOJKxQeafcrKKkIcCqLJ/xMEX7O6KLluh9wcHIlUedVrs
 Pnwx6y8KZQzoMHQRMmlWXzRRR9LDtaEitxtmea/jrJ0D1OQnQmrebohJSAGBqC7ehm08
 dXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708554125; x=1709158925;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q/PnaOwqVbcHGb/A3Q8ZzkQufGjjKSkGSQi76MFXAs0=;
 b=tT5vqD+37n3DILJvxbS/Mzj6Ewu3PAoFM3nZ3pTzd3eyMQGNbiv59jhtLEBIHoqCol
 axH5owrfj53slYdQRAZrx0DIQoGB5uF5LIcLswoRczajW1yEgwHUBoABgB1gPzUjhxSf
 dVJGhIeBgOCfv65SPf9CJy7CIhmd0wMB2kabrytHzHFcLaOaYc+M3PXNp9765E2pBeeE
 lSaS+TCGyG8ZlumutEUt7EswguTFOFKIAikkSXA0CRxPKpDzuhyX3oN6977wf/rJ6S3O
 +ZMDzewNoFpBGqNxgouQEyszn3/S+9djQvnax6dPlGAabYuw4vvSAsjyfpdoeeuoyeJM
 JDJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9mRtKUrF+kudlhKu8gtHmWSlFCh3eotyK0B7XPSZAV+Wn8zrtuvWcLSgrYzZ5hqxc7LHZQ5S2KIX7rRI43KF1Zk99DRU=
X-Gm-Message-State: AOJu0Yy9WJ6xg0GrjO6ExQCyRvoXm+Ad3V6nBxlDYynlu4v3MGDQ/i/R
 kw7/KksezoMIHowIEmZubMv7b2uVX/z05iIPnLzyhoNw36ysTLxGwsYYt4oT
X-Google-Smtp-Source: AGHT+IHwURnOx6QyZcZrkDLAflwFBQLraM1k3g9+2oQZu9DUxd+ecXDo6UBD9GZ2wROSr9YhnDCdUQ==
X-Received: by 2002:a05:6a21:9102:b0:1a0:b05d:2d04 with SMTP id
 tn2-20020a056a21910200b001a0b05d2d04mr7815249pzb.26.1708554125276; 
 Wed, 21 Feb 2024 14:22:05 -0800 (PST)
Received: from debian ([2601:641:300:14de:11c8:8961:5acd:73dd])
 by smtp.gmail.com with ESMTPSA id
 t33-20020a056a0013a100b006e3635c5641sm8708717pfg.25.2024.02.21.14.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 14:22:05 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 21 Feb 2024 14:21:54 -0800
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 linux-cxl@vger.kernel.org, gregory.price@memverge.com,
 ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net,
 nmtadam.samsung@gmail.com, jim.harris@samsung.com,
 Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH] hw/cxl/cxl-mailbox-utils: remove unneeded mailbox output
 payload space zeroing
Message-ID: <ZdZ3gvK-ExEYkNSI@debian>
References: <20240221185425.1088766-1-nifan.cxl@gmail.com>
 <5c0bbc43-b5bb-41b8-8c4c-3d58efb687ce@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c0bbc43-b5bb-41b8-8c4c-3d58efb687ce@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 21, 2024 at 09:59:49PM +0100, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 21/2/24 19:53, nifan.cxl@gmail.com wrote:
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > The whole mailbox output payload space is already zeroed after copying
> > out the input payload, which happens before processing the specific mailbox
> > command:
> > https://elixir.bootlin.com/qemu/latest/source/hw/cxl/cxl-device-utils.c#L204
> 
> Since "latest" isn't stable, this link won't be accurate in 6 months.
> 
> Please use the current release:
> https://elixir.bootlin.com/qemu/v8.2.1/source/hw/cxl/cxl-device-utils.c#L204
> 

Thanks, Philippe. 

Just sent out v2 as you suggested.
https://lore.kernel.org/linux-cxl/20240221221824.1092966-1-nifan.cxl@gmail.com/T/#u

Fan

> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > ---
> >   hw/cxl/cxl-mailbox-utils.c | 7 -------
> >   1 file changed, 7 deletions(-)
> 

