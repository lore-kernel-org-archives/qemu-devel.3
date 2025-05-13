Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737C2C3ABD7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 13:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEppo-0004gL-Pi; Tue, 13 May 2025 09:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uEppa-0004cS-QD
 for qemu-devel@nongnu.org; Tue, 13 May 2025 09:38:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uEppY-0008Tb-OJ
 for qemu-devel@nongnu.org; Tue, 13 May 2025 09:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747143479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Doja06b4cRZYCQLBQSIpa50Yt9XBNmNbg4YAoASYH+E=;
 b=QMmd0UBdBUTMrtNXtDUCmwgSrdd9OcqsP/+BgdqoipwrBToVBWWkOypENVD9ouybqiYeEj
 x0lHTKvlLk/xUKcyRO3oR2Ql5k8DeV7ASDJNKE+mGP73CppgNLMN/8Y4i39YEuBtbxMXOf
 PFyxIzIo2HGlHNc3g7BwrwC23m14K5k=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-mDBxjVqwMvSTmamsK7DSBQ-1; Tue, 13 May 2025 09:37:57 -0400
X-MC-Unique: mDBxjVqwMvSTmamsK7DSBQ-1
X-Mimecast-MFC-AGG-ID: mDBxjVqwMvSTmamsK7DSBQ_1747143477
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6f53d2613easo106619036d6.0
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 06:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747143476; x=1747748276;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Doja06b4cRZYCQLBQSIpa50Yt9XBNmNbg4YAoASYH+E=;
 b=jdynKYkpjLHozAsJD6TBKMK6Hyvk6nRz4ZIQ+UmPjb3tsqTWP/lzNq0hlyuSohLcYC
 6Tm2obs1O8XjphZiw5gXPXKBdYl0NYASah5l9xwl1UYmyj7GHCRCntkRbiheKaEmfPHM
 B9A2YkTwYHx7Ht4v1uINVXhD/UHq2tsGIEmyEnsBbiJ6B2kfdoay4nCTp6fpteH70Vok
 qys2a+HARUd+EFyjF8ntRxEx3gk6HzzfsAvYprFXKZ0+umQG0bIPWwypOcuoThax4KuH
 EL5Vn7wSV2w9ajX2lsTRYKyYDeEA82SeuC+BFvSZyVtLvIxheBcIxfeGja6v7ngHGdVF
 rVvw==
X-Gm-Message-State: AOJu0YwH1ytLge6dlQbWz17FbFAaeIxDtnsf5n/gfThplbx5yT4vN5Cf
 lOxzrTx4Z7may7SfgkV66QLQdS39/vfV37Lgc++GZfkmsch5UsYAGw75oblVbxPIk+g3Dr4VGfy
 64oG3WZMv9tGI0FKHEB1QqrMNLSjNwJGDvuk/ODhHr9NXsTjS3ZEo8LEqY4Dr
X-Gm-Gg: ASbGncvd316rYoZqHhqEcirNVxCfv9TazNaOiVAMdU7uctp8uK8S06I+OSdafrhRmOc
 UoxGk/xvIxL2QYOrrS+P7DbHvisx+xofjAb4TS7uWXWlNT/qcMRypH+69XpXWqctrMeMk/Nj4Id
 Rm4WngiKrIxQzei6/EzlRqT77aci6H0A2pFUbiyStVHyjnNmEA/OJWU2LibS98ITO64aESGueio
 bJd4SYV5hPXpLvQGi9GK1+GIr4JuAUQpBkeEDs5/Dslxpuug7ogThC9C32s/OFrNa9rR94AecU6
 O3c=
X-Received: by 2002:ad4:5cc5:0:b0:6ed:e3d:a1b1 with SMTP id
 6a1803df08f44-6f85b55957amr47450196d6.10.1747143476624; 
 Tue, 13 May 2025 06:37:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzRx8qYn2V2a76ryXy3CP4OALmThCCcG/CTBUUwYbhl1sVpQkADOs9d0jk1yCbZvsdDgonDA==
X-Received: by 2002:ad4:5cc5:0:b0:6ed:e3d:a1b1 with SMTP id
 6a1803df08f44-6f85b55957amr47450066d6.10.1747143476315; 
 Tue, 13 May 2025 06:37:56 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f6e7aa0bf3sm58647936d6.65.2025.05.13.06.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 06:37:55 -0700 (PDT)
Date: Tue, 13 May 2025 09:37:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/3] migration, ci: Tweaks to migration-compat jobs
Message-ID: <aCNLMQS0ugsnCebq@x1.local>
References: <20250513133353.23022-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250513133353.23022-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, May 13, 2025 at 10:33:50AM -0300, Fabiano Rosas wrote:
> - changed migration-compat job to also check VERSION [peterx]
> 
> v1:
> https://lore.kernel.org/r/20250507155835.31074-1-farosas@suse.de
> 
> A couple of cleanups to the migration jobs, plus a fix for an issue
> that may happen during the QEMU release.
> 
> Fabiano Rosas (3):
>   ci: Re-enable python subtests in qtest migration suite
>   ci: Fix build-previous-qemu when the version tag is absent
>   ci: Reduce the size of artifacts for build-previous-qemu
> 
>  .gitlab-ci.d/buildtest.yml | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)

queued, thanks!

-- 
Peter Xu


