Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D908C25B4F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 18:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s43XQ-0003Ji-1p; Mon, 06 May 2024 14:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1s43XN-0003D9-Dm
 for qemu-devel@nongnu.org; Mon, 06 May 2024 14:58:09 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1s43XK-0004xj-J0
 for qemu-devel@nongnu.org; Mon, 06 May 2024 14:58:07 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6f048a08628so626392a34.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 11:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715021885; x=1715626685; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=t2EkUA9/lTSjw4F/MmwRSMe8EPOOZErqs5N9e+sXW1A=;
 b=WrtyGz/L5V7ZRij9zfJmqYjVfSCcNTd9v3yMBVeSplOyzTB0P1S4W+EaDGySOjVM2H
 ghTvZ5dDachrG1jlSoXkaUUaWimlOlpC2uQmBEF4kQvr1taQc30iOYfQYy5lJJTQ2nwl
 j1/U/teWXfiVVABjEYrsAXPrrruAKuRkCvi/rsVqw3WvfdjArodV3RONSk6cAn4wnLB4
 m8TF/ciQxmpO5ISDIBIJHa7AcpQUZfb2oFfUqU7gsjyiQ89/+5l2ydTpZamhYSOWC1Bt
 ngGGj1t390qitCuYX1NOW/UcmxiNl0NFKuceDFzjx2QxfeA/dXQYjE3bn+21hi4JtgvC
 Vtrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715021885; x=1715626685;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t2EkUA9/lTSjw4F/MmwRSMe8EPOOZErqs5N9e+sXW1A=;
 b=AMuCe1FdNDlMNW/Pcq8EV2WoZLNR2PDoTG2YtVl0wpk+PW/ud+GpFSNtlDHElj2vwX
 oOlV0V/JJrGe2SYxLMA9xud9mTqlpbhnvXOYywiMRBUzt8BChySgde+Vw2X2vHdRI+kw
 +x70rQI8QBQaEBdDx9i6svfAbC8ZfoFI1Uih4x+G4DjdG118LfTbprQgrrmWsNENnnn/
 ZREJD1WGpYDPOv4Tx8D85/EP8P7oDT1/Tg/7L3c4Su2NbQvvo8DXvNR97sNQKHP/uHTS
 KRvqvQjDgr0FNbrP3s6B1cPWaZasRyfkuit+uwpXCwqdlnVtHMmQcygbGY2mXJW0mS0m
 VR3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6uNxxz2sqJC4pf3FRHCO4zbfN5Qj3trrwiTR/AF5FRgBFJsfYJh0KlDKGZ3HDwpaNsVDqG+uf1uBTawsy3kFaBy3HmO8=
X-Gm-Message-State: AOJu0YyAxVlW0NBtwg57nr2CTceCp0yaoY6J+sGDZSecS8ylcnszv4XH
 ihd5ZCx9ZGIf90OhsJwKi/qzOeiN/3rHdFUWNjO5yWGw5lKHuRfg
X-Google-Smtp-Source: AGHT+IHFB4KS84OB6zn3yY+Q6/8zW/bdA/K3CbGd9pRz1HwNFbQ0Mf817FcTerUVr+egtJTdhpb0Hw==
X-Received: by 2002:a05:6830:246a:b0:6f0:4492:4850 with SMTP id
 46e09a7af769-6f08d09b570mr240900a34.11.1715021884685; 
 Mon, 06 May 2024 11:58:04 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:8080:1f00:9c00:b108:eb17:4557:755d])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a4ae849000000b005a4c3d44cadsm2067993oom.38.2024.05.06.11.58.03
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 May 2024 11:58:04 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Anton Johansson'" <anjo@rev.ng>,
	<qemu-devel@nongnu.org>
Cc: <ale@rev.ng>,
	<bcain@quicinc.com>
References: <20240506183117.32268-1-anjo@rev.ng>
 <20240506183117.32268-2-anjo@rev.ng>
In-Reply-To: <20240506183117.32268-2-anjo@rev.ng>
Subject: RE: [PATCH 1/4] target/hexagon: idef-parser remove unused defines
Date: Mon, 6 May 2024 13:58:03 -0500
Message-ID: <068001da9fe7$52f8f4c0$f8eade40$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJLdJdU/DG86JVEEIa8gVqwbMNhjgK5rscQsJMUGxA=
Content-Language: en-us
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-ot1-x32b.google.com
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



> -----Original Message-----
> From: Anton Johansson <anjo@rev.ng>
> Sent: Monday, May 6, 2024 1:31 PM
> To: qemu-devel@nongnu.org
> Cc: ale@rev.ng; ltaylorsimpson@gmail.com; bcain@quicinc.com
> Subject: [PATCH 1/4] target/hexagon: idef-parser remove unused defines
> 
> Before switching to GArray/g_string_printf we used fixed size arrays for
> output buffers and instructions arguments among other things.
> 
> Macros defining the sizes of these buffers were left behind, remove them.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/hexagon/idef-parser/idef-parser.h | 10 ----------
>  1 file changed, 10 deletions(-)

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



