Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28848C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 20:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Rk1-0004X0-OZ; Tue, 07 May 2024 16:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1s4Rjz-0004WQ-O2; Tue, 07 May 2024 16:48:47 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1s4Rjy-0003dA-AQ; Tue, 07 May 2024 16:48:47 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1ee7963db64so9146665ad.1; 
 Tue, 07 May 2024 13:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715114924; x=1715719724; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=a3q6f6SISqVPGUV+BbX7YRQ5illX9+egkKOatA/Gv3I=;
 b=Ho+iVYSbFYYcqhb22ZbbV11CaMvVAZmbvR3bIeSN4Tlf8BY4mqPozuy6gDeqfWiCJ7
 A8zp5Go3KNS12X9AHP0xXr7XNq/uts9H7qS0JpTfiuvUQOeLsMMYs91Dt+rnI2RXorj7
 kKwyp8ZcVGUNE/aAvBbjNqdaNQxxYmH8br6wkLukCBMGlf/HOSR2oMMIuOFjmVmKii++
 dRLjpdBplQsQVhZfNOp4Ywirj/bmrulJqxQRRIC49ycKlqZ3MdCrnbWQgu9X2o1WlcoV
 80TlXnScSjeW0KoMzvyh2RTfAWqxC+IKZ1+2A1+rVX2RK881WTNfQ4rWN53PUm6kFIQm
 MbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715114924; x=1715719724;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a3q6f6SISqVPGUV+BbX7YRQ5illX9+egkKOatA/Gv3I=;
 b=geMeAYLFb8AT3pz9wLp9nlCDAlmycQHGUcUs//skqb46KbTEQfQIi7rnhiR4ZVXYCJ
 a88mdDp9OSTvHVuqvWyx+kHyL0KerpWHxqdwuuCrgNuWZ5RhRjdRXCKXhN/0Of16TflP
 tjqudcxbGy2TzEWpgoVy0DkHo+Uhd2fHLIn52Jzpsu3/UiC0DKujxy8oZbszkaAd+Ms8
 JetbEDgMnOwiypSlNrSeDB8NTwrsgoQKvgxi/dK47/TYRIL/XBHDd9Ur+UpIAJflswk7
 k30f76ObzyeeFHAJCkcPRJ0fG0mJGbEcGFw5YlJM2AAfFo0HWhnsHny6klzIQ/VpOM9L
 9ojg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKRWbr6W5b9/utEgmkaI3CjNwezCSmoxsPhlBbOkgYLNC4uj8Gbp60nQSu0osPoipPi+jV6P7uLZmW1rGWMULO4oi0+aqYaNGh12dGIBgdiSCj/KBlML/GmHO8nw==
X-Gm-Message-State: AOJu0YxLyqA/NuqLZe9jk61bx+WYswwsoma9pDddnxBrpF9gxY61FxKT
 ZRM3drM8aYforn7lbGvpAYAG8tgK4Y2YaWEWzGmkC/y0DIv17Rwe
X-Google-Smtp-Source: AGHT+IEbT0zOo5IBbM5klRT0igsR6CSkiFOlXQAOHfohtq2lUvJ/NqQcr3RBB492ZGh7lFloNMFLFw==
X-Received: by 2002:a17:903:2283:b0:1eb:4bba:998b with SMTP id
 d9443c01a7336-1eeb03a3b01mr10714685ad.36.1715114924237; 
 Tue, 07 May 2024 13:48:44 -0700 (PDT)
Received: from minwoo-desktop ([116.121.76.56])
 by smtp.gmail.com with ESMTPSA id
 m10-20020a1709026bca00b001ecc6bd414dsm10403133plt.145.2024.05.07.13.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 13:48:43 -0700 (PDT)
Date: Wed, 8 May 2024 05:48:39 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Keith Busch <kbusch@kernel.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Minwoo Im <minwoo.im@samsung.com>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v2 3/4] hw/nvme: Support SR-IOV VFs more than 127
Message-ID: <ZjqTpyUAEVnBnOnm@minwoo-desktop>
References: <20240331193032.5186-1-minwoo.im.dev@gmail.com>
 <20240331193032.5186-4-minwoo.im.dev@gmail.com>
 <ZjI5r-2lxntCfAGt@cormorant.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZjI5r-2lxntCfAGt@cormorant.local>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pl1-x62e.google.com
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

On 24-05-01 14:46:39, Klaus Jensen wrote:
> On Apr  1 04:30, Minwoo Im wrote:
> > From: Minwoo Im <minwoo.im@samsung.com>
> > 
> > The number of virtual functions(VFs) supported in SR-IOV is 64k as per
> > spec.  To test a large number of MSI-X vectors mapping to CPU matrix in
> > the QEMU system, we need much more than 127 VFs.  This patch made
> > support for 256 VFs per a physical function(PF).
> > 
> 
> With patch 2 in place, shouldn't it be relatively straight forward to
> convert the static array to be dynamic and just use numvfs to size it?
> Then we won't have to add another patch when someone comes around and
> wants to bump this again ;)

Sorry for the late response here.  I will update the 3rd patch to
convert secondary controller list static array to a dynamic array with
making the max_vfs parameter to uint32.

