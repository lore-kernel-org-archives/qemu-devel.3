Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49174CD1283
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 17:06:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rptBL-00005g-DO; Thu, 28 Mar 2024 13:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rptBI-00005Q-IV
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 13:04:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rptBH-0007jU-05
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 13:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711645485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v6z80bMi62Ed81e212PC3YT+G1DF0nJcjAjMKhGxc4A=;
 b=AStBiaplrCxUkozHEAGpbpFomIsJKCWqZjpqpUdeo3zPg9PkvK+FboPPfQt1NmFRq810Ym
 fBX/xbyJx8P0axCtN27EzTQ/U2BOoDebHqVjFJXZNBGlxhtP3m3wAWNdB2/x7WsZHEG1Ez
 a2WXsk1AmbSygdT+3KyTbi6b0a3jEdE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-GaBqMaF6MTeUuh3zmVguBg-1; Thu, 28 Mar 2024 13:04:43 -0400
X-MC-Unique: GaBqMaF6MTeUuh3zmVguBg-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4311d908f3cso5321411cf.1
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 10:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711645483; x=1712250283;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v6z80bMi62Ed81e212PC3YT+G1DF0nJcjAjMKhGxc4A=;
 b=CGzfe8F7FTzVIvP2Ix65+YJbK3LqW8xX63/qfCXT8p7chqcNz3n56jGR34mzQ+utaA
 XsccUvr9r1Q9qWkAZf5UtNxNZdkNYl3Pizwast2DZReH+toIyMM+PQTAFx2O5iKifyU3
 ewmQ9BGWbdzS4yrpsHO0TxbKvbTWw21mA1KBozO7ffdcx0ojmSTwu7EWGKBvBoxrcikA
 bGFuGGbIaYZIF32p6IKdQJ+IFZvsQkz0NjBI7wwAo6OzSqZRKe/p6OSScyohKDAbha2j
 aI6Lw7TZmZOaDUgjpkDVuGGppNEzcfIR4t4dAnZtQLxrYZmmwKWIcWQC4/HvHeqVJFAm
 NxBQ==
X-Gm-Message-State: AOJu0Ywj8OwWV8KjH4YZC06jOu1N4/BIPaJU0RlsY3j8urDXsFsJ9w/j
 /KP9npIx4zZmnKc/HE1zaKJ3haaSI86TigmCYEfrKo/L8nalstklqSHFlUyQfPl66iq/WUcS7O8
 QGvjjYl6CI/9glBzBqrv9NvNz2qMc+QFvUA/xx31qpPR379Bec0Uh
X-Received: by 2002:a05:6214:2e0a:b0:698:ec16:a142 with SMTP id
 mx10-20020a0562142e0a00b00698ec16a142mr609387qvb.2.1711645483041; 
 Thu, 28 Mar 2024 10:04:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKrJaFBgJKMdjD73EoK6hDWK24hIwnVMwDGIEEEyovh7MhStxpKhVcmcwJk4uMp0obikvC/A==
X-Received: by 2002:a05:6214:2e0a:b0:698:ec16:a142 with SMTP id
 mx10-20020a0562142e0a00b00698ec16a142mr609346qvb.2.1711645482503; 
 Thu, 28 Mar 2024 10:04:42 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 ld14-20020a056214418e00b006969b7a2234sm798809qvb.88.2024.03.28.10.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 10:04:42 -0700 (PDT)
Date: Thu, 28 Mar 2024 13:04:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH for-9.0 0/2] migration: Two migration bug fixes
Message-ID: <ZgWjKC0W9d9FAD8x@x1n>
References: <20240328140252.16756-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240328140252.16756-1-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Mar 28, 2024 at 04:02:50PM +0200, Avihai Horon wrote:
> Hello,
> 
> This small series fixes two migration bugs I stumbled upon recently.
> Comments are welcome, thanks for reviewing.
> 
> Avihai Horon (2):
>   migration: Set migration error in migration_completion()
>   migration/postcopy: Ensure postcopy_start() sets errp if it fails

queued for 9.0-rc2, thanks.

-- 
Peter Xu


