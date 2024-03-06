Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C189C54798
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 00:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhfWj-0002bi-Sb; Tue, 05 Mar 2024 19:52:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rhfWg-0002aY-SY
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 19:52:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rhfWf-0000yr-A3
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 19:52:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709686372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SM793RLiry5Pz04P6mkBId83yzcwrqaezLUL62PJWpA=;
 b=DejuH37pfBX4KTHSgquAWk34QDqmmM3QM05G5Sh1pm654nQjVVZcJF8SoUCEXAhbpVJ5tY
 t9fDJ1pvdmMyp9IGHjOGBmthwB4XqpufkHbbDC1jA6M0rTTos48qOJ3N3vFC8hy+DUdwMh
 efvpy8VA9sOSs/3QJPQINeCs9eAg4HU=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-vuX-BjnRP2aShRjU_kCW9w-1; Tue, 05 Mar 2024 19:52:50 -0500
X-MC-Unique: vuX-BjnRP2aShRjU_kCW9w-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5d57b2d2758so1337734a12.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 16:52:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709686369; x=1710291169;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SM793RLiry5Pz04P6mkBId83yzcwrqaezLUL62PJWpA=;
 b=fMavp9bsnGDzYxOnqmHCoCCaZmgncQ4VOGQ65RL2XHHCI4muxoFilSLRkwVZGxlH44
 kqRxEE/rYcjFRc+JEx5mJmOpn42MiOObsxOCH/lFX5NeQ51Ueo9Q3lvBM6+DotqQ4g7j
 kIEu3LWcLFrZjgJZ3bT5LikNJFrF1pxT6MYkj3giqp/XTCLbFeSl3C/0tyBx2HEeVklI
 MjDPAzEuKpkRb48E+OFlw6jKmAENvraO0GYG1BXuF038UVena3+/AjpxExEELg59KRhX
 H6lCFbFF46+xAA1vELJVdZy/ECnFjN9SUeQYCeZH1mF8VaeHbtjXmnLrQZeSrTs5pj2z
 KwlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCjWq3sTgduwE61Z3ihofalg5qpO3uPPUmYxB3gKYGALvPfASZI1EDQS7ZDcRXBtZCS9+KZZqGXFe+J/6aKdRiwEVPOVI=
X-Gm-Message-State: AOJu0Yxm1iHz1JaZ4XSWekYx7tINnnN+F/ZivqzaAoc7eCeEPOUq7je7
 0rZyYNpEdczZg6MUjp7xrdvJIj10SB1U+najiX37bJLiBUFEwdF+KPfID9lYxbhCzktR6bhIWfU
 meGnbrY62DtjuSiHC+tyB0orh4V2mLY+JFWGeyKOQVM1E8LLZWwQw
X-Received: by 2002:a05:6a20:bb9a:b0:1a1:4aa7:b8d0 with SMTP id
 fd26-20020a056a20bb9a00b001a14aa7b8d0mr1654138pzb.5.1709686369581; 
 Tue, 05 Mar 2024 16:52:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8/RSxHVsVaVMs6DwS5rI1yIVecGIDdM+eIPz6j41nU5c1oxIryvLZYr9yXro5SOT5iuTHvA==
X-Received: by 2002:a05:6a20:bb9a:b0:1a1:4aa7:b8d0 with SMTP id
 fd26-20020a056a20bb9a00b001a14aa7b8d0mr1654125pzb.5.1709686369152; 
 Tue, 05 Mar 2024 16:52:49 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 mq12-20020a170902fd4c00b001dc8f1e06eesm11202639plb.291.2024.03.05.16.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 16:52:48 -0800 (PST)
Date: Wed, 6 Mar 2024 08:52:41 +0800
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Subject: Re: [PATCH] migration/multifd: Don't fsync when closing QIOChannelFile
Message-ID: <Zee-WYQg9c19Up-T@x1n>
References: <20240305174332.2553-1-farosas@suse.de>
 <ZedbLT2pFNyRoX90@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZedbLT2pFNyRoX90@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, Mar 05, 2024 at 05:49:33PM +0000, Daniel P. Berrangé wrote:
> I don't think you should be removing this. Calling qio_channel_close()
> remains recommended best practice, even with fdatasync() removed, as
> it provides a strong guarantee that the FD is released which you don't
> get if you rely on the ref count being correctly decremented in all
> code paths.

Hmm, I have the confusion on why ioc->fd is more special than the ioc
itself when leaked.  It'll be a bug anyway if we leak any of them?  Leaking
fds may also help us to find such issue easier (e.g. by seeing stale fds
under /proc).  From that POV I tend to agree on the original proposal.

Now we removed the data sync, IIUC it means the mgmt can always flush the
cache with/without the fd closed in QEMU even if it's leaked.  So I don't
yet see other side effects of leaking the fd which will cause a difference
comparing to leaking the ioc?

Thanks,

-- 
Peter Xu


