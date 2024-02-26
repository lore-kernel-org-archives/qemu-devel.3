Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DC3C54798
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 02:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reQvh-0006Ue-Ud; Sun, 25 Feb 2024 21:41:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reQva-0006T3-4u
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 21:41:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reQvX-0006ZA-RR
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 21:41:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708915270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eoofAYijOL8YBISYNDds+unuKIFoklNvnsyAHSekqgM=;
 b=SRwtYkJodWf/77Hc4Wf8RYqqQstmKEu53h3nCl36RGM0xEFKAsPi8VNYFA3sILFuD3BAPT
 hONoO7eWw3XwWuodeeRXPMMxqL8GmI8+4z9Pf54Bg+fY18yk73bmCxupfyFGaybKkk2Ey1
 6p+75Ff/uT6VrTp2WwGS4bi16n+mXGE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-XuuCVSEXOKGXAZ_fxJkYSA-1; Sun, 25 Feb 2024 21:41:09 -0500
X-MC-Unique: XuuCVSEXOKGXAZ_fxJkYSA-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1da0dd1dec4so9577755ad.1
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 18:41:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708915268; x=1709520068;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eoofAYijOL8YBISYNDds+unuKIFoklNvnsyAHSekqgM=;
 b=pgejNQFF15VIz2QhSn8N23EA9Z8Ljf8IwWU590SBTTULI6cVYYAOTsJAhCSSFhwfzJ
 bDudMNTaMJi/rBuv3yYvqiKwbvSbMa98Kz6K/SCbeg3rsrHPmWDhWmaETi6ZdfeqkGsg
 lgv/7iLPi06m6GsLFHz8Xa0yeBeoiZtTMuXpuNzVlEdiLjLNTZ9S6SrJXm2WO9xZcmiE
 7x2KWKjxOfmNHPP81YenCPkOLq468sFOU0LPtXVg84mw2drY4N8ufrgXvPHMOdjRXopy
 zEQX3IuWAbMr91g/tmFmYbif6+b/2VBfjmJjsX7aecOtNVEaiLuGhT3RLnvFD1kh9kmw
 eP8Q==
X-Gm-Message-State: AOJu0YzOqgA0REflFDoQ8p0rbq3u0EDbjDsJgUNfphhCDVgcFT0PVQr6
 19NLkFNBOepv0nUiklEzJ+Vu0C1yGIn/C8V6PNFWN9jwQzlvtgilgvNaxQxiLAKKzfBx44Ytoq2
 jsGMAomVi5JxbDB9azW5sK+mPseVOYbaS+B9mIjQc1IbMgwqzk0rd
X-Received: by 2002:a17:902:8d85:b0:1db:3ee6:e432 with SMTP id
 v5-20020a1709028d8500b001db3ee6e432mr6634219plo.3.1708915268041; 
 Sun, 25 Feb 2024 18:41:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkst81wg/uvFA5PSPMP23zDSKYB1G6vmRV/JPgppoqPGf4gPAlCZXTvTcQISssjSPNxjIokg==
X-Received: by 2002:a17:902:8d85:b0:1db:3ee6:e432 with SMTP id
 v5-20020a1709028d8500b001db3ee6e432mr6634206plo.3.1708915267716; 
 Sun, 25 Feb 2024 18:41:07 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 ks14-20020a170903084e00b001db93340f9bsm2829155plb.205.2024.02.25.18.41.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 18:41:07 -0800 (PST)
Date: Mon, 26 Feb 2024 10:40:59 +0800
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V1] migration: export fewer options
Message-ID: <Zdv6OyvFG98siqc2@x1n>
References: <1708708404-197951-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1708708404-197951-1-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Fri, Feb 23, 2024 at 09:13:24AM -0800, Steve Sistare wrote:
> A small number of migration options are accessed by migration clients,
> but to see them clients must include all of options.h, which is mostly
> for migration core code.  migrate_mode() in particular will be needed by
> multiple clients.
> 
> Refactor the option declarations so clients can see the necessary few via
> misc.h, which already exports a portion of the client API.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Sounds reasonable, queued, thanks.

> ---
> I suggest that eventually we should define a single file migration/client.h
> which exports everything needed by the simpler clients: blockers, notifiers,
> options, cpr, and state accessors.

What's the difference v.s. current migration/misc.h?

-- 
Peter Xu


