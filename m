Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EE8CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 20:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v435Z-0003yc-4y; Wed, 01 Oct 2025 16:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v435W-0003xh-NZ
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 16:06:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v434y-0001l5-45
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 16:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759349119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZJ75Cu/wj7+W8+nfOfxPjtivE/KfeDoRRkISzmvcnx0=;
 b=KM0GjNzffhUqbDwaf0JP7ICEqjvvxrSpEV5lo6xRqoE0Rk9ogMBKVMAV/uiYe3ZpG7HiJM
 OcGGZTzxxuAM1NPwYyekY/zrNMJA1+UydyClJshSf7lscxnNF+4IddQNcOxsSlwkLD0NgR
 KkxCVzomiHBM8ZpB4QadUKeSKzy+n3I=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-F6Tt6TvpNBS-bVO4qdZhDQ-1; Wed, 01 Oct 2025 16:05:18 -0400
X-MC-Unique: F6Tt6TvpNBS-bVO4qdZhDQ-1
X-Mimecast-MFC-AGG-ID: F6Tt6TvpNBS-bVO4qdZhDQ_1759349118
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-856c1aa079bso45586785a.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 13:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759349118; x=1759953918;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZJ75Cu/wj7+W8+nfOfxPjtivE/KfeDoRRkISzmvcnx0=;
 b=Dlt0qI9DQmddCZV9gSQBNdpLFbPiupjpJhfvpjJSEyDZQKlya9ZOj9h8xNvQRUNuZA
 m5V35Spwda4A4UcLvUDdB/TNnlW8YM3ll5lOy2AChRugJLT7n1lLK31eWICPMkOBGD6j
 2dXjD2hxJ7mtDRm3wQrfyxjUt5bNhOgR2e7l8B2wOlDGrFkyxE2+S+G62821RTJr8e8W
 P7/RU9vMJ2AVO5jlaEULpL+n/Vdg3fLCbt1zO8aUxJBKZqiWi7Z+fAXdIuROWBaIHlzV
 QlEElQE4jq0vHFNBYiGWC2I5YPfNAy+MsVG/0YtWrGN6xXKIz9tFJxTbMKq79s4zF55j
 BIQg==
X-Gm-Message-State: AOJu0Yzlwp7ky1/mVEqXZeR+orcXR+lAZTk2ZnozzBaKT3SU7V/oNKN5
 DS008QFngsKZIC2UJ3rJrzjoL13jgj57xCNAXw/YTRnAXfgKZ5UelhfeadXgn5jELHP511yWclQ
 wLbiqhQZwq6x8j2DpUSHBs+WBeAlh5RxZ4p2VYBhzdqdqfQ47VISQyW0r
X-Gm-Gg: ASbGnctW51WvNWzG5HHMJOUETU6jeDIaqLb7+y1pG2FzMpg0uyaJTxWDII66uOc1NUI
 rSMLbWuJgE5VN5if5PajvWGgNvBf8M7dlFQo9UQS/9L/ehryAJ3IRgu1JlVRvsgWvzFiB+62frB
 CoUuqrzY55UpYHcFUd9FAzCHu09XZFWZZUZ4ixWUZFtIQdSovm915nTm8dVn61a64jkt/g0j+ja
 HkyMNDinUaOqQAlYqXznm6ASVvlbi+v8H6QkyAJyF4lYPBiqzJ7LKD3RwiUnNr9NBh0E2OhQzgY
 cZQH7zVT8ZmYlwq6tvZ0fUviKX9Tn6e3yf8UEw==
X-Received: by 2002:a05:620a:2985:b0:827:ed1d:a2d1 with SMTP id
 af79cd13be357-8776a2f75fbmr140675285a.20.1759349117690; 
 Wed, 01 Oct 2025 13:05:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUPdLjHG180rA5rk0FX4hSJTUTcy73tSN0qt3RO7SA7Zf1/7LHnvvs1Bs3vn0X5nnuUEjuvg==
X-Received: by 2002:a05:620a:2985:b0:827:ed1d:a2d1 with SMTP id
 af79cd13be357-8776a2f75fbmr140670385a.20.1759349117178; 
 Wed, 01 Oct 2025 13:05:17 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-87771129f41sm55751885a.3.2025.10.01.13.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 13:05:16 -0700 (PDT)
Date: Wed, 1 Oct 2025 16:05:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH V5 00/19] Live update: cpr-exec
Message-ID: <aN2Je6JssrN1otuQ@x1.local>
References: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
 <aN15cNEwH4HBt7NU@x1.local>
 <c7ae8d4a-05ee-48fe-8edd-77dffecf2c32@oracle.com>
 <d91186b6-24d9-4b3a-a4c5-d68445c267bb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d91186b6-24d9-4b3a-a4c5-d68445c267bb@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 01, 2025 at 03:24:44PM -0400, Steven Sistare wrote:
> Actually that was easy to resolve, not worth a V6?
> 
> In patch "vfio: cpr-exec mode", drop the change in container.c, and instead
> add MIG_MODE_CPR_EXEC to container-legacy.c here:
> 
>         if (migrate_add_blocker_modes(&vbasedev->cpr.mdev_blocker, errp,
>                                       MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC,
>                                       -1) < 0) {

If that's the only conflict, could I request to send that new vfio patch
only, by replying it to this email or that vfio patch?

I can fix the win build.

-- 
Peter Xu


