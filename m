Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27602CD128A
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2024 18:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtX8J-0004Rr-S6; Sun, 07 Apr 2024 14:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rtX8I-0004RQ-9B
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 14:20:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rtX8G-0008BE-6U
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 14:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712514041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=74Rd0RQi0LkvP0zzNbkgBryjNDJuvz2ie9w7BpOS7tI=;
 b=FG9lJjok8KG8mdUKn1BCVMXB9CM+OpIkkmRlqeFS679/nCvm3vh4vJD+f2YP4FeO0a6A5D
 2KTAigyhA6OgS46pBWS4d8BCX6MkgjUWcdaDexGY7rlBahSYOQovkGwuwTZTxUP6Jsq7Zu
 j2tIx2aspmbA9SnQWN+zcjYDZ4cO1kc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-QAtB1MmiM9OkcWTMfDrY8Q-1; Sun, 07 Apr 2024 14:20:37 -0400
X-MC-Unique: QAtB1MmiM9OkcWTMfDrY8Q-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-43470772549so6248691cf.0
 for <qemu-devel@nongnu.org>; Sun, 07 Apr 2024 11:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712514037; x=1713118837;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=74Rd0RQi0LkvP0zzNbkgBryjNDJuvz2ie9w7BpOS7tI=;
 b=m9axVMctZPKbTaOUhtPtZIWMgewfzvr9Z25z+S6Yq8ZwCRpEgAQyrTgjYPC9Vfddx6
 vBfHaXYn2aBDqhT8L/9CxdrgtXgCHAlL9lUE9be9JKwc6e/2RSkfa7XjIvFdqXkHZBIp
 9PLJp6ZRY8Avte55O6fmt40AtroqVe9JDeE074ubES3OJmNLwvJvfKLH3hkMFMz/MeyQ
 40lFmGPZhrsoIuV0SHIGtI+39JFHBsTMygPjt44+8GD8aKIT7uddwcn5X4eeMp9Fcl3Q
 /+hhv0Kzow1nC2jPij5uMCAtRAp7rqqBlhzD9DNx1XHYAOvNNp4rWhTBS8AjOisEwc/M
 dNLQ==
X-Gm-Message-State: AOJu0YyRttCzsqOTl2qP25eTeHo2677Xhv5okA7QIl4dzervyDjY/+oA
 B3MocrV4vxKJoXwRBo5LQgZXUlrctJL2v2PBl6etZ9YCaZ2v5BHHBp81+CKY12nW9myRVenBHo6
 jWHCyqrBxlVlSwX6rYRuS+pFlcWgy0wITq2jdwiQMiELSs5MifBKB
X-Received: by 2002:a05:620a:450e:b0:78b:ea64:e0fa with SMTP id
 t14-20020a05620a450e00b0078bea64e0famr8041494qkp.4.1712514036834; 
 Sun, 07 Apr 2024 11:20:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmVSqr3/uLdmND2mkzSrkB1l+OpYQamCzQi85LnnEwiF/4UKHse8oWxAYxcIKQMQStZp0e3Q==
X-Received: by 2002:a05:620a:450e:b0:78b:ea64:e0fa with SMTP id
 t14-20020a05620a450e00b0078bea64e0famr8041478qkp.4.1712514036136; 
 Sun, 07 Apr 2024 11:20:36 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 z13-20020a05620a100d00b0078812b73ea1sm2440227qkj.28.2024.04.07.11.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Apr 2024 11:20:35 -0700 (PDT)
Date: Sun, 7 Apr 2024 14:20:34 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: Re: [PATCH for-9.0] MAINTAINERS: Adjust migration documentation files
Message-ID: <ZhLj8veRDQ5Zbkaz@x1n>
References: <20240407081125.13951-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240407081125.13951-1-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, Apr 07, 2024 at 11:11:25AM +0300, Avihai Horon wrote:
> Commit 8cb2f8b172e7 ("docs/migration: Create migration/ directory")
> changed migration documentation file structure but forgot to update the
> entries in the MAINTAINERS file.
> 
> Commit 4c6f8a79ae53 ("docs/migration: Split 'dirty limit'") extracted
> dirty limit documentation to a new file without updating dirty limit
> section in MAINTAINERS file.
> 
> Fix the above.
> 
> Fixes: 8cb2f8b172e7 ("docs/migration: Create migration/ directory")
> Fixes: 4c6f8a79ae53 ("docs/migration: Split 'dirty limit'")
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

queued for rc3, thanks.

-- 
Peter Xu


