Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24134C5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 02:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfWA8-0007fS-8H; Wed, 28 Feb 2024 21:28:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfWA6-0007eu-9z
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 21:28:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfWA4-00054B-Ru
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 21:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709173719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XTyA4OZb0B4UYkQAu38+eY+E85H3nCKeHw/oZpwohDE=;
 b=cJklQIiHo8eG262WqkRzE16n255G+q3U2fPUSG/g61VgouOJdDTL0NCVhymR0pxXODtPk8
 G+SnyIE3kkOP+ezDwzNTCAF3D9u4MuiLmmIOQNRCQKSzR6ii+R3LWAS0F+0ulrOMZg12JG
 xFpYT/Izfw8io9PtNwf7YAUPuY+VlK0=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-yFeUJZfnNFGpK4UmFZNjYw-1; Wed, 28 Feb 2024 21:28:38 -0500
X-MC-Unique: yFeUJZfnNFGpK4UmFZNjYw-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5cfccde4a54so66706a12.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 18:28:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709173717; x=1709778517;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XTyA4OZb0B4UYkQAu38+eY+E85H3nCKeHw/oZpwohDE=;
 b=hyTBo3LgjNP3k2Zpb77V58YTW6SIFsWFgp0j1mZAW5S9w1SaMbv83Z8rAenR+xoIUc
 qjSTbAr7fTFTnVD5hLtmicM4/Ki+VLYJK32Lf/i/855vvohbckGb/SKio3tUj8JEyexo
 EhUghPgsI8cuvfM3EPY5L3o+kPXoBYorYhaMxfLBnkmB1KOkPFhb+fNS7MmMI/ys5eII
 2dnw6eryohURBcB8oFjdY3hdPsjbpgXnGaWemdYdL3EOAGuDgvCU4j2TS22aViN8ZUiT
 3lFMoiIXnyaEDrM/8TjYCxjuqpkQyRkQWCNdFMl1xd3YezBG21yQJHaRQwsZf9kWShZv
 XH3A==
X-Gm-Message-State: AOJu0YwSpTAxQ/92TgjRR/OmGTHMrTnrC+KHNTXrk0HmutW1MyQepxuP
 yO3tM1mJchTK3/Y3ghF1dtxrYuusD/u3TOfl4tmGAb580bf+RgPXkmDuocPy9lf0SMbns3HRDA3
 OlewsZ3DhjqSulMO+tX8hy3gALqfQhLXPRIOLpG4EVfPV3IbAJnPL
X-Received: by 2002:a17:90b:3014:b0:298:cc02:4fd2 with SMTP id
 hg20-20020a17090b301400b00298cc024fd2mr930252pjb.2.1709173717354; 
 Wed, 28 Feb 2024 18:28:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGayQ0mNfdgNshTVrDPhb2qhHLAULQ37fg18pt2TfwUyoP9fWKO7Wx/VGHnJmJ1nZ88TkXQpA==
X-Received: by 2002:a17:90b:3014:b0:298:cc02:4fd2 with SMTP id
 hg20-20020a17090b301400b00298cc024fd2mr930241pjb.2.1709173716962; 
 Wed, 28 Feb 2024 18:28:36 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 qi17-20020a17090b275100b0029ad1df1661sm2363853pjb.52.2024.02.28.18.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 18:28:36 -0800 (PST)
Date: Thu, 29 Feb 2024 10:28:28 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v5 15/23] migration/multifd: Allow receiving pages
 without packets
Message-ID: <Zd_rzCMiNqAMyGI-@x1n>
References: <20240228152127.18769-1-farosas@suse.de>
 <20240228152127.18769-16-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240228152127.18769-16-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Feb 28, 2024 at 12:21:19PM -0300, Fabiano Rosas wrote:
> Currently multifd does not need to have knowledge of pages on the
> receiving side because all the information needed is within the
> packets that come in the stream.
> 
> We're about to add support to mapped-ram migration, which cannot use
> packets because it expects the ramblock section in the migration file
> to contain only the guest pages data.
> 
> Add a data structure to transfer pages between the ram migration code
> and the multifd receiving threads.
> 
> We don't want to reuse MultiFDPages_t for two reasons:
> 
> a) multifd threads don't really need to know about the data they're
>    receiving.
> 
> b) the receiving side has to be stopped to load the pages, which means
>    we can experiment with larger granularities than page size when
>    transferring data.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


