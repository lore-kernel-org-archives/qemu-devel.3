Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE0ECD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPjaW-0004J7-Jx; Wed, 20 May 2026 12:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPjaS-0004IP-CZ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:16:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPjaQ-0005iY-B4
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:15:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779293757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RtXDf3up/9Zr1bG/7ZSVkrtdqNbIa2q14BpyIFjUkLQ=;
 b=YCoBa+/NS/RYgVM4m19IoaqYtchHqMdlkUZXbF+5CFd7eKCGyr4E6r02DPGK8XIMs15UY6
 VSSkwHbxXWa70TmhtbxYW1HEChJ/ZEvoJOYhXzd8hvdW7YxljGmccmmuen6o4TRv1+vcIH
 j6957/XUixVT6tMObkjiF/1xB1F3CN4=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-7FaC1YlANQ-aHCb_TtRhBA-1; Wed, 20 May 2026 12:15:55 -0400
X-MC-Unique: 7FaC1YlANQ-aHCb_TtRhBA-1
X-Mimecast-MFC-AGG-ID: 7FaC1YlANQ-aHCb_TtRhBA_1779293755
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-6313385ca1bso3065783137.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 09:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779293755; x=1779898555; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RtXDf3up/9Zr1bG/7ZSVkrtdqNbIa2q14BpyIFjUkLQ=;
 b=mTSwQMmsGWwgWJQ+EhQR3GTaIH1h1bLC3AqKzNDiILO3aGH8H+2916YrdlTuJXYQUp
 9vEExlIU3ngR4TWgTIkVCYIyCBWyiGk2TS3JmymTUqzrci7LuU9Xtd5CDOAHPKLSAkXr
 wMZfyVkDr7ToEkLaUh/zQBH472bMVWDAj1cpCXVxtfwU1xTDN1dsXL0o+NO4I9FYB9zu
 8PlWO/JYu96r/sJy2HlTiHh6jaQiDifIORH2N/NPp19nOwOSCRLjZasyRclxaSBE2/S9
 kLf+uf6w14K3rogVeESeljqRP/OIhiRSKunGRVcfCo37wX1Cp7JskEMxcH3Uxznshtx8
 lAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779293755; x=1779898555;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RtXDf3up/9Zr1bG/7ZSVkrtdqNbIa2q14BpyIFjUkLQ=;
 b=OXygKrulhs/z+YH7mMLNxPv4S1iA0Ftwtt//r974Y/keWwFOYh6ko5E4OIROf7UoMI
 Nfz7taLgDy4pwFT1KLjOzn/uIax+ExulyTi3S+HnJE4RVppTWGfy0jPvSvRePfRrWWis
 rt1pF8gOavjTRA0Wn5w0domyaMZbH/5kI0ulwJp3fBGtWRN4gDwcJJyiKZLwEfu8sExe
 FSILlHN0T0iK1UZ4Q94+KqdctTb2XlOY7ZDuKkA4CM+ZCKTp5wqpphy6+1OGAP5mpDUJ
 ne1uaJVJRDIUZlfowfrQx/BUAUUrbAAx/0wTDoH++s7gKubK702W0qY1riTEo0eIvA3n
 dnXw==
X-Gm-Message-State: AOJu0YzaAhPXHcnoTc/UylOUC5WafgO8EfSlaqt1eKqE8NBp4oedy65i
 ZG7pnF9hoGAd61bzAYwA8QBJbFbTwn8xTe5wu6KxqW7eTHAg6NeKdsDgPus4oP95547E1aUSvGq
 0Jd/z8mjhtAeRieCRxlSWLkbcQA2YtqUIzie4KblwGhv5ZgR454yW254B
X-Gm-Gg: Acq92OGYWvIto3GaffVwKFl8RP9eg1aN9NW+x1iGYbHyolZRh4TJLUnhkTkXWHbh0lL
 FIIFmCDS+BKsDnjqHp3Kal0Q5QnAIANxFblPPomiDTvFs8o51i2s0uTpQ1JHTBuJtmiF64bvocu
 uadKsWbTQ9Gjl7NptODnIxuHeFQlhEbZRfYMBH+S5FNOhlBHAO+3Jca94U7PcHrXX7i0km4w7Lt
 sE8bOAfZYE261CehFphc9EAAZVFGIaURIimYyWCtgQ0uOBxmeGrzRE6+KtgnOZL7dyCfLY+5u/y
 H6vQeyvMDu/GQHCxQWC5PS/Vfq2nxE9W0STgbOnWjpEWLaibkEafgfdSSep2ROxCB43wEyXIMTu
 uV3uoZqZ4vKI0+DsicUeohO64uGw+0NlkhAJ8T/t7Kd/aadZdu5QkiK07NA==
X-Received: by 2002:a05:6102:956:b0:612:21f8:5afd with SMTP id
 ada2fe7eead31-63a3d94e0ebmr12687812137.12.1779293754953; 
 Wed, 20 May 2026 09:15:54 -0700 (PDT)
X-Received: by 2002:a05:6102:956:b0:612:21f8:5afd with SMTP id
 ada2fe7eead31-63a3d94e0ebmr12687711137.12.1779293754316; 
 Wed, 20 May 2026 09:15:54 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9114edfd3ebsm2055444685a.23.2026.05.20.09.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 09:15:53 -0700 (PDT)
Date: Wed, 20 May 2026 12:15:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 08/15] tests/qtest/migration: Set compression method
 in compression-tests
Message-ID: <ag3eOIWx9_62UQba@x1.local>
References: <20260505160915.25558-1-farosas@suse.de>
 <20260505160915.25558-9-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260505160915.25558-9-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, May 05, 2026 at 01:09:07PM -0300, Fabiano Rosas wrote:
> Stop calling a common function to set the multifd compression
> method. The default method is "none", so the common function is not
> necessary for tests that don't set compression and will be removed.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


