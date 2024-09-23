Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36622CF9C6F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 16:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sslUI-0001zq-VA; Mon, 23 Sep 2024 12:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sslUB-0001xS-PN
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:00:28 -0400
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sslUA-0006h6-80
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:00:27 -0400
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-49bf3b4d07bso1412257137.1
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2024 09:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727107224; x=1727712024; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CZO6xw2zK+FekRHP0AmCwr1+BY0iBwxezeniLtwBxfA=;
 b=g8GRQpiauZT+Iavr/G2jZKiA8a+eZuHghNMGDGavx/nUGgGjLcBInRt3pE7YbABze/
 F9iSMuCaupHTuMxTmA6nnZw0i+yG4tSUZqyBaCg5zWE/ffQdRdAKJnd6eEO0Jujfc094
 8eHvH6wYu+2BlF+hZUxghwvFb1uQTBkVkJfRlG3daa27VgzU0k2VJOFoKiRekG7YFww8
 lCSlBOcoz62Odo5YmTgkduXVBm+sn3YeyZGSfly3jOPX9R8VZxnwHMoodul6y9bcyPVD
 5k4SXHca2Hj+NJYA4/4FNtDSeyhA5404BiAI+xH/O7PrEl0OhWvzKUvShnv1gxMVI7GC
 5cpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727107224; x=1727712024;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CZO6xw2zK+FekRHP0AmCwr1+BY0iBwxezeniLtwBxfA=;
 b=a2SFlWtAUOjQ7c832Ehq+6r9zYGSnufbxqX5GJ1ejsz+H8bef2IH2uJKlFiVu6nPU5
 U3lMxP9Z+PBvjfawUXm3PbBqytdpR0lIS4a7L9SLbh9XBOc1VKyHbvJYAm0yztldeF2a
 C611xvZ9HF4O6DNf5Koxz36QTtC8vdtP1BdDLQxkLL+7/Ni8qaWr/tW1ipndUCc1vxAV
 pY2hKDaYh0iclPMJUUk/sPKY+EAyNd0NT75kzsYhHAVwGSMrMAc7BS+1SIV0mb1BoT8J
 L5yhyqw1DcEyi7NrMiMqa9iRJK8JSi34/Om8auESts4JW/fl9HhMSrbyq0DWQbutS4S5
 eKcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX59MheH6TpRi6UqzTxcgeR9dbDIKOXWh5LuZDEGH8wbBCaZwqVeKZvIhKJGC2IXpsxLEcUYyRrdsPh@nongnu.org
X-Gm-Message-State: AOJu0Yy4Xpcu5h4pwwf9N0aX6gZ9iYzTYdiBDPD5VNNhnSJfG21B2weW
 9GUudCcGuDpRzCeswABI3FLiAXEgRNTDCS1KYWv5E3lfr9+vhiS3
X-Google-Smtp-Source: AGHT+IENPozg+xVMIWvMBGwR3CYA3qJoZ8EoZAcMqVrMNwVId4uYtFV9S3FOA/RS+nWXEQ9yToaOpQ==
X-Received: by 2002:a05:6102:510b:b0:497:6bb5:398a with SMTP id
 ada2fe7eead31-49fc9554cfbmr7208071137.7.1727107223959; 
 Mon, 23 Sep 2024 09:00:23 -0700 (PDT)
Received: from gmail.com (ip190-5-140-142.intercom.com.sv. [190.5.140.142])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-49e6b47dd80sm3954043137.32.2024.09.23.09.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 09:00:22 -0700 (PDT)
Date: Mon, 23 Sep 2024 18:00:21 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Anthony PERARD <anthony.perard@vates.tech>
Cc: dave@treblig.org, sstabellini@kernel.org, paul@xen.org,
 xen-devel@lists.xenproject.org, qemu-devel@nongnu.org,
 anthony@xenproject.org
Subject: Re: [PATCH] hw/xen: Remove deadcode
Message-ID: <ZvGQleGKoqrz7dkq@zapote>
References: <20240917002212.330893-1-dave@treblig.org> <ZulFy+S9b243+EQy@l14>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZulFy+S9b243+EQy@l14>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2607:f8b0:4864:20::e35;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-vs1-xe35.google.com
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

On Tue, Sep 17, 2024 at 09:03:09AM +0000, Anthony PERARD wrote:
> On Tue, Sep 17, 2024 at 01:22:12AM +0100, dave@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <dave@treblig.org>
> > 
> > xen_be_copy_grant_refs is unused since 2019's
> >   19f87870ba ("xen: remove the legacy 'xen_disk' backend")
> > 
> > xen_config_dev_console is unused since 2018's
> >   6d7c06c213 ("Remove broken Xen PV domain builder")
> > 
> > Remove them.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> 
> Acked-by: Anthony PERARD <anthony.perard@vates.tech>
> 
> Thanks,

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Cheers,
Edgar

