Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0395E6F096
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3Qn-0005h1-0i; Tue, 23 Dec 2025 09:32:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1vY3QS-00043l-Jn
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:31:48 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1vY3QQ-0004Si-RD
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:31:48 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b7633027cb2so916691766b.1
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 06:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766500304; x=1767105104; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3DItcK8vKiv8QiqSu6wmFdrVmLMlyV3PGhxL9NoOut0=;
 b=MxF9pOkJ+78XQoKcM5zHW1+2HKHVYm22QcybieiCVYIth2FFmStFK/wSUX2g8qU3+x
 N+W0kH+HtPGw4JvasBBZbORlg4YY2tcboAveA2HJ4/p3wDjrmEri08NXVABJqdipCeex
 VESc/KsLFLFP8/ox1t3oMhD/RHbhJs5DlyLZPrOVLCzHuC1Os0ivltEL+3YadGVh6zCj
 SZwX7/7ALQFqOsPUlx9U/eyMxEMPUFz+6A8ssRCJcEKzyhCbJrah3tCxrNl3uJc5CLCL
 8jsh0ekFJ4OrsugvITaA6XE5uDk9nsqX9kcE8E8xOcaMyEPq6Mkii8jkFLgCpyNvFAoR
 gaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766500304; x=1767105104;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3DItcK8vKiv8QiqSu6wmFdrVmLMlyV3PGhxL9NoOut0=;
 b=Xv3xrry0gl/9q3LaAcaq4GBwB+xlFIgkIzP6tHt+XHGfsiFyRPJggk90oAFh6EsnOA
 wz+hsw7OO698rK5yUbshqelmc5yh626qn51hw0ELlpudAfzBDUOZXJwnpdwvqVp9csyY
 HcwL0JyBavXx9NqCqTM3RwhZwqNHpMQweos3jTy1yxg/G7ZfZJufYbWeEwHQoVutPrRO
 aAq6OYOyH7CD8mGAJWgcWDzOZUKS/SZheZFp3sVMF8bpwmW1LY609rdoqHtr1W7oS9GW
 rZeP2ZWxXRguWOjvhqWJYbZt0eLU4QISYOomZKoy7lts6rKgFCsRriVb0YRBzg4ugvKq
 FVcg==
X-Gm-Message-State: AOJu0YznHDz9COKVsRtGZvxusbKJK8kle3oPX6clDjVnGEF31j37KctT
 uAPdA/bu9cRdPDgoFp6wzHDxG1pCnQRBgC9PmlKDt/hQySqYv18TgtIZ
X-Gm-Gg: AY/fxX5cOCOkpO4WIoI9PknvhyB5mDPiJVpuAppgwLuQgt7Zb+A6cmKa2keEc51AD0a
 bnE/Kf7StWE+BiypXd3HMdim1o51T4Mza1e1DkUbvUrkBvuS/0ikCpUYUXW2LeMXFdg1Ou3KmHO
 m7BlnjUGllUyuqxqEW44KHW9jSXVwgYsngpgVqO+vw/t1f1Rq/Q3+LlPjTiXOskSg5z7EpaztS5
 Etj735lFR+DOWGzlF79AUAmYqt+DM4ivwB01P/u5Esy8+CbmMN5JsW15oNJAy6mcmJZO6L86Wqs
 6diAYJ7HwtVhXDgM+fc+H3ScOkbL3p0S4KLMat9AtwDw88GPE3sMIjC6mITpvLcrxreA3Fb6kiL
 rqLVMSU+f3IUyQrXxc0QRwYewC1SnT244hJYYSiCgVPERDk4PC1nj1SMF/ho7pQWfq8pWbMPiSM
 svs8gRwBW2y0zZTqSMbmKAFBe9E8CHDJmZZ56JAMztFHyzQk+UNvAQecvak4LHyaX4riGDT7QT6
 f8=
X-Google-Smtp-Source: AGHT+IGudY7XMFOE+8l7Ey/kZKNqxQa2pmhT6AUouvCRKSnj/f01GDdF/B1Xnf32l+939Du2wY+2Jw==
X-Received: by 2002:a17:907:1c0a:b0:b80:2828:47dd with SMTP id
 a640c23a62f3a-b803725b07amr1664719666b.63.1766500304280; 
 Tue, 23 Dec 2025 06:31:44 -0800 (PST)
Received: from osama (ipservice-092-208-101-212.092.208.pools.vodafone-ip.de.
 [92.208.101.212]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b80426fc164sm1279965666b.30.2025.12.23.06.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 06:31:43 -0800 (PST)
Date: Tue, 23 Dec 2025 15:31:11 +0100
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Subject: Re: [PATCH] hw/core: remove duplicate include
Message-ID: <aUqnr9n_IvFq_zcD@osama>
References: <20251126210832.34011-1-osama.abdelkader@gmail.com>
 <0d6a818e-1007-4e98-8504-b5e88a30b51f@linaro.org>
 <417ec469-91e3-4025-941e-f1587f5ebb15@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <417ec469-91e3-4025-941e-f1587f5ebb15@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=osama.abdelkader@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

On Tue, Dec 23, 2025 at 02:57:34PM +0100, Philippe Mathieu-Daudé wrote:
> Hi Osama,
> 
> On 23/12/25 14:51, Philippe Mathieu-Daudé wrote:
> > On 26/11/25 22:08, Osama Abdelkader wrote:
> > > qemu/target-info.h is included twice.
> > > ---
> > >   system/vl.c | 1 -
> > >   1 file changed, 1 deletion(-)
> > 
> > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > 
> > 
> > And queued, thanks!
> 
> Actually we can not take this because the patch is missing your
> "signed-off" tag, see:
> https://www.qemu.org/docs/master/devel/submitting-a-patch.html#patch-emails-must-include-a-signed-off-by-line
> 
> Replying with "Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>"
> would fix this :)
> 
> Regards,
> 
> Phil.

Hi Philippe,

Thank you, and have a good day :)

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Best regards,
Osama

