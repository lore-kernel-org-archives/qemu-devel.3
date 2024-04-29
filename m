Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB802C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 21:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Yeq-0006Do-0A; Mon, 29 Apr 2024 17:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1YeU-0005XQ-8j
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:35:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1YeP-0003uF-Qe
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714426504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hi6DPPPW2Y8F6DlaWvmjHS3TBRFsSBDOI/eK3ak1q3w=;
 b=F3tPkMLMP7UhKRYsDbauxNdDM1rCrTdevem/8u/mea6DZNs1vMnbzaGBdQZOmLi5QUjADa
 KRkOPXmjdyZh5mI8AKYtJLPWMOl7tzueKFYa8yjprDn4bOXiCiJkZumsEO8w7PmcorvRiz
 BayXhyf01a3ZYMkectPQfJP+51k4HMQ=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-AXAFeY5OPduq68I7cyCQFw-1; Mon, 29 Apr 2024 15:51:07 -0400
X-MC-Unique: AXAFeY5OPduq68I7cyCQFw-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1e950a46ee4so1783605ad.2
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 12:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714420267; x=1715025067;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hi6DPPPW2Y8F6DlaWvmjHS3TBRFsSBDOI/eK3ak1q3w=;
 b=lE3yZ94pKCrdcosXads30ZSEwmOF3MtNXP6Cm6Xe8BhcnIbWO40eQSLJds0WNlrwcP
 v+5D8DZCOxDkmfgE2dr47XnA5dhXNwBm4ifVgj+rxKlkkkrpLffZxvNiguHIt4Zy6m64
 AQL5fNE3Kmjo7DFq9SypotbXTcAbl+cizBF8z80Xnb+2z2sHXDd7XGGCny5YT3A+3299
 DRCABFIQhAn7iHuq8+Ot/111zyl4zIWFAWpZRUVx7kbo1OA3Pq26rxOrbmavPYrf3pGk
 PooW8ZZzBvgZmvWYiS73aTNHTsCmC6SC8knLDTr4QcJhZUZ6ex/uoG5csuzbd3PFe7no
 bufQ==
X-Gm-Message-State: AOJu0YzK403x4i3dJSMaOuiuGmuX44gEdt3ZQwRfmiOGEd+jJFLxHW7N
 /xhKFPd82aRvwAYrGZDSQJd+a3EHOBxwP2y3dVfpbpk3GB03mUq2QQJy9yPusBmD8l0icBUAIkq
 85pATZcNLAvjEZkwpSTXYGApWlOL/uFNMQaOEQdjOaRS2JHF8OhLH
X-Received: by 2002:a17:902:d4c6:b0:1e5:1138:e28e with SMTP id
 o6-20020a170902d4c600b001e51138e28emr14096931plg.3.1714420266409; 
 Mon, 29 Apr 2024 12:51:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPKYuSzoNFzu2HReZC34Qfwi/CUMJEdHDruEI5z2b+CpVVyBY0S2e7pkv886Csl4S3A5T7Mg==
X-Received: by 2002:a17:902:d4c6:b0:1e5:1138:e28e with SMTP id
 o6-20020a170902d4c600b001e51138e28emr14096901plg.3.1714420265777; 
 Mon, 29 Apr 2024 12:51:05 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 f21-20020a170902ab9500b001e5119c1923sm20714950plr.71.2024.04.29.12.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 12:51:04 -0700 (PDT)
Date: Mon, 29 Apr 2024 15:51:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 devel@lists.libvirt.org, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 2/6] migration: Remove 'inc' option from migrate command
Message-ID: <Zi_6JhnqkdIJU5Ae@x1n>
References: <20240426131408.25410-1-farosas@suse.de>
 <20240426131408.25410-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240426131408.25410-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

On Fri, Apr 26, 2024 at 10:14:04AM -0300, Fabiano Rosas wrote:
> The block incremental option for block migration has been deprecated
> in 8.2 in favor of using the block-mirror feature. Remove it now.
> 
> Deprecation commit 40101f320d ("migration: migrate 'inc' command
> option is deprecated.").
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


