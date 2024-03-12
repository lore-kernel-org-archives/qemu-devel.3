Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B5FC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 15:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk4Lu-00028M-Fq; Tue, 12 Mar 2024 11:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk4Lp-00027O-97
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:47:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk4Ln-00035x-19
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710258450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+GsrHeCb2rJLfrftNwdEh81I+ZXPgB/74Hf2r1d16uA=;
 b=dliP2aT1kVZ6bjUqsVnL2HzggDxdQPTPOwex+XYEwuqZ4QhtpuU1etKmIrjkzQighuDnb1
 PQDpb46ozdZkeAGNwt4BLnd0A0yiv9qnbsfl3o/JzHyAA4SAy8MfT0TywaGYYCgx325xcI
 eChsivBahwOpYpiWBJIxqB2RF7kbaJA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-jbaMrMjlP2SICf17DUsbEg-1; Tue, 12 Mar 2024 11:47:28 -0400
X-MC-Unique: jbaMrMjlP2SICf17DUsbEg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33e78c1b314so2349322f8f.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 08:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710258447; x=1710863247;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+GsrHeCb2rJLfrftNwdEh81I+ZXPgB/74Hf2r1d16uA=;
 b=XfjVoB7T9547alZOIYGpGj7J0aV0K/mWebiwyXzqQ+oz1+Tb8BwH4z31/jcCHrcz98
 P++mCTzWPKjFLIxpOer9XteGxsL/S9yqsNI3HjU29pa4BhnEkfVGQXN7PGem9LwaDYW7
 FWJS/IJ5VXI+LSMKSIDvwHu53fkXphshId38QpKUEKL4PnqgMwPEUeSSa0FNnVkwsbwn
 KONnVNOBoXYZUcoDZWAJz1bCtc0dyDrQQS6MTCthMWv1NG+i9weP8QUFKdfIGrohdpGi
 JGTno1MAQnHFB0IkTAat63KORZMof+wPfXDJZg8Usyc6wTGPc7Kka1ZOYleFXtjsutxP
 pQLg==
X-Gm-Message-State: AOJu0YzLb2OPELbPNo+a3OOQ6K0EXeWO1dbvQBBlCgX5jt/Uk5PYK/pj
 Q7XZv2MupBa8G83Eg7M1G+TG02ECamqGgTGBPB2SdHfL79I3nU7UIPQWeEciFLBb/eGBvVa0kPI
 v+J3qVvacsF4wLBvRPbzf4yvD7DVDZzZsc397oZVP0XUwy/R59cJL
X-Received: by 2002:adf:e387:0:b0:33e:6833:8fa9 with SMTP id
 e7-20020adfe387000000b0033e68338fa9mr8207357wrm.44.1710258446783; 
 Tue, 12 Mar 2024 08:47:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTUl82jpdiSLyyj2aINjFFVCK7MD7zFDp6or+eZ6Jkproz0/x74SvVsK7sCFAKr9gZVl5V1w==
X-Received: by 2002:adf:e387:0:b0:33e:6833:8fa9 with SMTP id
 e7-20020adfe387000000b0033e68338fa9mr8207332wrm.44.1710258446290; 
 Tue, 12 Mar 2024 08:47:26 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:532c:5ae4:fce6:76e1:fa1a])
 by smtp.gmail.com with ESMTPSA id
 a11-20020adff7cb000000b0033b48190e5esm9256679wrq.67.2024.03.12.08.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 08:47:25 -0700 (PDT)
Date: Tue, 12 Mar 2024 11:47:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 BALATON Zoltan <balaton@eik.bme.hu>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>
Subject: Re: [PATCH 0/5] Implement port 92 in south bridges
Message-ID: <20240312114548-mutt-send-email-mst@kernel.org>
References: <20240218131701.91132-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218131701.91132-1-shentey@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sun, Feb 18, 2024 at 02:16:56PM +0100, Bernhard Beschow wrote:
> This series attempts to make QEMU's south bridge families PIIX, ICH9, and VIA
> 82xx more self-contained by integrating IO port 92 like the originals do.

Bernhard my understanding is that you agreed with Mark this
needs more work. Dropping for now.


