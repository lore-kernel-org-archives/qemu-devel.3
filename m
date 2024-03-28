Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA10C54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rprOs-0007SA-DN; Thu, 28 Mar 2024 11:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rprOn-0007Oo-Jz
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:10:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rprOm-0002Ow-2B
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711638635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HmYG6VdBs/kVFZHkiC6a2zC8zBLYWmlY4UY9C4Qz+CM=;
 b=bqPKyixhYIHCvPbg6kokwvuPKP16oMJn9FshziHd9IEfhbfK7seoeHKM4FI9VKP8tAZZ06
 NAvSmvBKK5RpjGHUVdkXcon31cVy9lDWFl5OMTKoHrNMGQxCDaA8jAFnZzTaZnwUvDrZ5i
 sS+U4ylXtg8nrh1I2Oisd0YLvZ8bTJ4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-_Gtm6pRpMSKSwcXojwCKgw-1; Thu, 28 Mar 2024 11:10:33 -0400
X-MC-Unique: _Gtm6pRpMSKSwcXojwCKgw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7830635331bso25552285a.1
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:10:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711638633; x=1712243433;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HmYG6VdBs/kVFZHkiC6a2zC8zBLYWmlY4UY9C4Qz+CM=;
 b=PzsQ8bJNw2hhYixNhR68opp7o/sLOFy9wPLIGK0JUNmZ1vW7viJ2vak7zSK4udxv0I
 Ts4pLAq3v7mxMOP0ylwB6iKLJ5xjuIWFEzGPqAZVQ7plD2f9SJfM+MoXxD2tZTdyjMpv
 EBywUH8EBjr/Foswh7XLTTUD/TTOgDUczwCWeWHs8yp6D28I6CHdR/gyRIn3JrRBb2Sr
 rAw/psnEv0dMF2n9fx8QCRSFsseZORiekiPTJxaHLrFlGmFb0T7XUoKyHJ9yIjj4onsE
 YBq9s2HLRCq3grFjpg/tTSH51XVpPDocWitmM+bGYS9SBUrp92sys5ge3f3Lg1034H3a
 Ixig==
X-Gm-Message-State: AOJu0YwS5lmqE1CAqu1ddXRERkDfpnAS9pUcfS5pspsrnDm5o1TvtTC1
 P2O2QEePC7Zw+u2F63OrofkrlQc/4eGa1bLR9q/c4AC0oC3Bj5LqLUe+sq5YN5hzEjxG9D1NEdc
 9IujagnC7EoXw3qtJytXTSuMBZ8xwczxErmqzsXAGdwEMYbiqQsz6d6mhwH7W
X-Received: by 2002:a05:620a:4103:b0:78b:babc:9dbd with SMTP id
 j3-20020a05620a410300b0078bbabc9dbdmr2768548qko.7.1711638632680; 
 Thu, 28 Mar 2024 08:10:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNZv4PcHYt0posgDYThsucbQGFDJNynqeAf57sQ8dmt+RAEN+5/HXwzhTzusI14uaWqllawg==
X-Received: by 2002:a05:620a:4103:b0:78b:babc:9dbd with SMTP id
 j3-20020a05620a410300b0078bbabc9dbdmr2768497qko.7.1711638632149; 
 Thu, 28 Mar 2024 08:10:32 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 o4-20020ae9f504000000b0078a001f7fd8sm593259qkg.6.2024.03.28.08.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 08:10:31 -0700 (PDT)
Date: Thu, 28 Mar 2024 11:10:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH for-9.0 2/2] migration/postcopy: Ensure postcopy_start()
 sets errp if it fails
Message-ID: <ZgWIZn5OSbyERUx5@x1n>
References: <20240328140252.16756-1-avihaih@nvidia.com>
 <20240328140252.16756-3-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240328140252.16756-3-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Mar 28, 2024 at 04:02:52PM +0200, Avihai Horon wrote:
> There are several places where postcopy_start() fails without setting
> errp. This can cause a null pointer de-reference, as in case of error,
> the caller of postcopy_start() copies/prints the error set in errp.
> 
> Fix it by setting errp in all of postcopy_start() error paths.
> 
> Fixes: 908927db28ea ("migration: Update error description whenever migration fails")

I think this should need:

Cc: qemu-stable <qemu-stable@nongnu.org>

> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


