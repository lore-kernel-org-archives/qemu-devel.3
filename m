Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6728CD11DD
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 19:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpv3y-000465-1Q; Thu, 28 Mar 2024 15:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rpv3l-000418-SH
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 15:05:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rpv3i-0005l7-Ti
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 15:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711652701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U+nI2o4YYT/plfQANsIbcVbxhidLfBxR/G6yTKn+xIk=;
 b=EYt5H/KCe+7dmakQPNQaIzNhSp7k9HHVuOy9MbJuzJuLrUE+ZRCzIAQcOEwJMn2Dvhz1nB
 kkgvQaBqg5zaa+l6yImM8I0sofrmQzWzsKrkqWQJJUUkYFlcpCm6CxGnGJmWOuZG6S8GbI
 Y43pT2KfQABrc+xF5nm0W7EdqZhYtAQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-rVDncnxLNHKglC2NbyJIDw-1; Thu, 28 Mar 2024 15:04:57 -0400
X-MC-Unique: rVDncnxLNHKglC2NbyJIDw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-78bc551b234so5026685a.0
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 12:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711652697; x=1712257497;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U+nI2o4YYT/plfQANsIbcVbxhidLfBxR/G6yTKn+xIk=;
 b=GrYrJm/QP6GVW/0o5016PY3ZtaVpjQXZ98p+3FyGlnJxjL/WEQ7FXuEYGgYwqU4DMY
 FB9idvAY7Dne0c02OoffRiEjHClN18wZrldn0AlXXSxH8pm7SN3/C8DSKa9R2wEWcvw/
 s1rNnhZhsfdff/NQap6PN/tSx4WlOn4ShPnjrD2y6xXKtE11uIc3BLuOYp5qQlhHEGol
 nHQ0EyJDiKVpoUOQSw1JOE5G6E1HkXrmCtFXVopdt9d/0+uaWlC1bw+o2z+65QYkpE1O
 ioYMK59i/r+tXRd7xU2Ea9AmLRZRI7Pamcv51orMlyG9n8awxTvKMcAGosnJEZNtKINl
 TyEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXctRIhZgGdRGaFbYbXXobQZA8a1NdfUoj8riZ8MbJr3bk0QPap4f0KfUkgD+8mpiFkIe+/5u1XaNyN3g4dvNQSKwxtP9I=
X-Gm-Message-State: AOJu0Yx9CtwJB7j3z4tiQ/oVidJhhm7JZ5yGRqkR2E2hS15j28i+ooIJ
 T8Kz8WwdE4gcHtKzvtHEhX/EKnrIJUGkmkdT7VO/p5v4yvKWOV+fTp0iQHo0ihnnOLFga/b6cte
 Uiy6H5V9UK4/VX7WVBoIdEXq6F6h0fkt33m1Xg3qPP10c+Y0DHxR6
X-Received: by 2002:a05:620a:462a:b0:78b:bd95:fbf6 with SMTP id
 br42-20020a05620a462a00b0078bbd95fbf6mr489539qkb.2.1711652697194; 
 Thu, 28 Mar 2024 12:04:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcsUAe+GoxZqrVCULWAd54/YKiA2deHo+6keboZVvyiKERmFtHBZAC0PNPWjPWwF748OHWRw==
X-Received: by 2002:a05:620a:462a:b0:78b:bd95:fbf6 with SMTP id
 br42-20020a05620a462a00b0078bbd95fbf6mr489491qkb.2.1711652696497; 
 Thu, 28 Mar 2024 12:04:56 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 c15-20020a05620a164f00b0078a310ae98asm748993qko.77.2024.03.28.12.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 12:04:56 -0700 (PDT)
Date: Thu, 28 Mar 2024 15:04:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Li Zhijian <lizhijian@fujitsu.com>,
 Prasanna Kumar Kalever <prasanna4324@gmail.com>,
 integration@gluster.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 devel@lists.libvirt.org, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Yu Zhang <yu.zhang@ionos.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Message-ID: <ZgW_VF1YUEcefHNw@x1n>
References: <20240328130255.52257-1-philmd@linaro.org>
 <20240328130255.52257-3-philmd@linaro.org> <87frwatp7n.fsf@suse.de>
 <ZgWGMmUTq0jqSUvr@x1n>
 <a6677385-07c7-4b74-bd78-b14c2e80f107@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a6677385-07c7-4b74-bd78-b14c2e80f107@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Thu, Mar 28, 2024 at 04:22:27PM +0100, Thomas Huth wrote:
> Since e9a54265f5 was not very clear about rdma migration code, should we
> maybe rather add a separate deprecation note for the migration part, and add
> a proper warning message to the migration code in case someone tries to use
> it there, and then only remove the rdma migration code after two more
> releases?

Definitely a valid option to me.

So far RDMA isn't covered in tests (actually same to COLO, and I wonder our
position of COLO too in this case..), so unfortunately we don't even know
when it'll break just like before.

From other activities that I can see when new code comes, maintaining RDMA
code should be fairly manageable so far (and whoever will write new rdma
codes in those two releases will also need to take the maintainer's
role). We did it for those years, and we can keep that for two more
releases. Hopefully that can ring a louder alarm to the current users with
such warnings, so that people can either stick with old binaries, or invest
developer/test resources to the community.

Thanks,

-- 
Peter Xu


