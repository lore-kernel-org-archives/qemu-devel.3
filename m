Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0B3CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 20:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v433d-0002VZ-AR; Wed, 01 Oct 2025 16:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v433a-0002V7-OC
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 16:04:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v433H-0001O8-Da
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 16:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759349015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DSVYggdjWC2lk6CwZ50AUKip82LV9Zg8dMppXKYcb/U=;
 b=QugGLIiuF7vG1hdUwyd9fN3KuA+tev0WFrZlUyeLeme45yB9ZhLg7arPnl1pJ4SoxDbtPx
 IGnEuLOnd73qXB9Sy8wGQXch1j0ii5E6YftxNDi5NYfY+3pJNTR7fOuFQsfhWF26E5NP2z
 9xWjk5vYZSHk9Xm7k0IQVZy//tDmz/4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-HqpEGZVKM9aDVSzssPwDPw-1; Wed, 01 Oct 2025 16:03:34 -0400
X-MC-Unique: HqpEGZVKM9aDVSzssPwDPw-1
X-Mimecast-MFC-AGG-ID: HqpEGZVKM9aDVSzssPwDPw_1759349014
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-86df46fa013so70045585a.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 13:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759349014; x=1759953814;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DSVYggdjWC2lk6CwZ50AUKip82LV9Zg8dMppXKYcb/U=;
 b=IAesOaVPq79sA+XEThCHSmnvyPs3O3PsWO5j95mZPoq2iL9bUm2SstXTHU0Be4Fy69
 rw7KJpFy/nMEWlZAPx0GyT3ep6VyTHbrg0Coccaz/7kFXSRZ21nrSN5NuBVBmqDc4lNL
 VKx24qEkq+TC4kMCiXumHBMhvqFOlY4vEZg6VRE9arOE+opJU5K1MKejpw6bb4G/HSNi
 J+MDscHesKexh6RtNwB0RJqwuADZyt/0qoa61qgdD5OGBpXPO5VwCx8ey7ISzBKjqN3z
 fkm7WtrAq4a/Iz0b+plhKzg2dsq3RQxbtsFdP7/VZXhVQuEt00MtHggOz4vesdRSnpfu
 n9Dg==
X-Gm-Message-State: AOJu0Yzz+A+/AVW0cahD1iUsILuiBr29rQDvWYvT4qClVYn3qxWkloHP
 CqscoCjBgipf6FzV763fwhsINkWaKLTRYUPAmnHlv3FAbBmhj2Xg77u5mdVzhMbckshO6vAMtUj
 u9JWXJG8C/ZEzjupZyidzk49FK01Xsn5AJKqBlw/79tFkSD2accACUnML
X-Gm-Gg: ASbGncsG+ALNV8rtPam+Mc1kXp7kS8I1oXE6Zzd0vCt23PP7DrYIuQQtR0W0oBbE6eK
 oVficfExuksaj2JKbOrXGSN+fPL8qq6ciy+wuUopKsGpkb/a9TcDLNglEuW1u6E6P1QSIJu7deh
 dVK9ORVMJUt7zN8OoSMlRV33ojC3JeqPc0d1MLp8CF922A+N+TrbdzDk1n2d6R6dVL5mA7F3RnX
 rcR409jzSFeo9EbUMjVDgXtVPoiXnlLoYzFXcN+Wia1Ord30TZw/VbsZl4h8YyIOhzwMwiHWmjz
 9ZaIPqMD4ktDr2kTMiZgX7xe0Wzo126vUrfwGA==
X-Received: by 2002:a05:620a:40d6:b0:7fc:e0c1:7d47 with SMTP id
 af79cd13be357-8737021b02cmr646856785a.8.1759349013563; 
 Wed, 01 Oct 2025 13:03:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7Wf1H7I+q5wAiy5DbgF2hbtNevE028rzm4oy+XQh0caqVOM302uwM42Sr60/0UPd8OxwzOg==
X-Received: by 2002:a05:620a:40d6:b0:7fc:e0c1:7d47 with SMTP id
 af79cd13be357-8737021b02cmr646850385a.8.1759349013014; 
 Wed, 01 Oct 2025 13:03:33 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8777aabe9dbsm56127785a.65.2025.10.01.13.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 13:03:32 -0700 (PDT)
Date: Wed, 1 Oct 2025 16:03:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH V5 00/19] Live update: cpr-exec
Message-ID: <aN2JE0D44AdV-qK5@x1.local>
References: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
 <aN15cNEwH4HBt7NU@x1.local>
 <c7ae8d4a-05ee-48fe-8edd-77dffecf2c32@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c7ae8d4a-05ee-48fe-8edd-77dffecf2c32@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Oct 01, 2025 at 03:07:23PM -0400, Steven Sistare wrote:
> That does not make sense.  It already does that, which is why I used it:
> 
> util/memfd.c
> 
> int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
>                       uint64_t hugetlbsize, unsigned int seals, Error **errp)
> {
>     ...
> #ifdef CONFIG_LINUX
>     ...
>     return mfd;
> #else
>     error_setg_errno(errp, ENOSYS, "failed to create memfd");
> #endif
>     return -1;
> }
> 
> Did the windows build fail due to a different error?

https://gitlab.com/peterx/qemu/-/jobs/11566477462

See util/meson.build:

if host_os != 'windows'
  ...
  util_ss.add(files('memfd.c'))
  ...

-- 
Peter Xu


