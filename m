Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B38FD6C294
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 20:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDUmv-0004eT-94; Tue, 19 Nov 2024 15:25:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDUmq-0004dv-RM
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 15:25:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDUmp-0004B5-Bf
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 15:25:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732047920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/1ZZ6e02j6ZS5J6UleabGV52y+wq9Vr2rXECJQVaXWI=;
 b=Nus71h+9DWE3FlHAfvxWu6YtpXT2CrvjH2JcNvU94kiBpUtbvxn0/ammPHsboasCmMZdSx
 /bLDGnGdAJDzz7/vEfMF/vYf5CWQxFYiP07gHFJRirSc4k3NR7yoqNNGBLm0LpXd0YJxsX
 oKZeApKEnTqhWoWzAGrbOlSqJ1q9NL0=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-k8K0aSjBNIaVAkxf2ineGg-1; Tue, 19 Nov 2024 15:25:17 -0500
X-MC-Unique: k8K0aSjBNIaVAkxf2ineGg-1
X-Mimecast-MFC-AGG-ID: k8K0aSjBNIaVAkxf2ineGg
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-71819a87993so2941434a34.0
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 12:25:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732047914; x=1732652714;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/1ZZ6e02j6ZS5J6UleabGV52y+wq9Vr2rXECJQVaXWI=;
 b=NkkqLReYmN1v+f74lAHdJK755w+ISAnqrSyC5KNUu/mXNRpSV/OwZo0khQQVy/zqjI
 hNKLm9R4FOQ2TGeXrZxuAMwEQoGK+BTtvreDYjALRV0sjierhVjvFKF1ya0Z0BQtq75y
 reYqH1vexJbg5YmhRNMioQmlj8vVcQ8fkP/p4n6sqqB+PBC0aXk2mo3QPkTUHMr38Tb9
 IEvBSkg7fYIFJgkmEAQ+ItLiIHdQ2HX8mOEp7VL4IvtBMxtpUHbmbzHHtm53FbpVt3UI
 uUZiGvYpXf6TfUncK6dcEIO2asm4TYS8cYACRe7yO0a+R4DVeujPVOMJOLu8ERr47Xds
 BiKQ==
X-Gm-Message-State: AOJu0YyKOo1jTgGIg4oKfQUoG7Sa+Xlobk85TG0pq2oItCmKtaHGERN8
 ABLCH3Ud09WGgkbPoIDQPIaP5qoIivH6VqV1gINcqSf2ap2WBXq27T1GZe0XvaUmsjzCgMxnb+t
 J2QhVfaFxUxJ1jJMmH4mJ7+2ZTb401E++9sii8MXKLONtyKBlSHz9
X-Received: by 2002:a05:6359:390b:b0:1c6:2907:e040 with SMTP id
 e5c5f4694b2df-1ca664d9936mr34624955d.17.1732047914298; 
 Tue, 19 Nov 2024 12:25:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjx5zjpIDRRTsxrqfZ/eNByRjSvln9CrHmB4imgkxK+ZfAUFfzjED62VKUaeQvinHNN4TQ7w==
X-Received: by 2002:a05:6359:390b:b0:1c6:2907:e040 with SMTP id
 e5c5f4694b2df-1ca664d9936mr34620955d.17.1732047913969; 
 Tue, 19 Nov 2024 12:25:13 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-464685d00c2sm231621cf.27.2024.11.19.12.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 12:25:13 -0800 (PST)
Date: Tue, 19 Nov 2024 15:25:10 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 5/5] qom: Make container_get() strict to always walk or
 return container
Message-ID: <Zzz0Jt_BbkJyzbzB@x1n>
References: <20241118221330.3480246-1-peterx@redhat.com>
 <20241118221330.3480246-6-peterx@redhat.com>
 <ZzxianGKK71p0yA1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzxianGKK71p0yA1@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Nov 19, 2024 at 10:03:22AM +0000, Daniel P. Berrangé wrote:
> The docs are a welcome addition, but at the same time the docs won't get
> read most of the time.
> 
> With this in mind, IMHO, it is a conceptually *terrible* design for us to
> have a method called "get" which magically *creates* stuff as a side-effect
> of its calling. We'd be well served by fixing that design problem.
> 
> If I look in the code at what calls we have to container_get, and more
> specifically what "path" values we pass, there are not actually that many:
> 
>   /objects
>   /chardevs
>   /unattached
>   /machine
>   /peripheral
>   /peripheral-anon
>   /backend
>   /dr-connector
>   
> 
> Ignoring the last one, those other 7 containers are things we expect
> to exist in *every* system emulator.
> 
> Second, every single one of them is a single level deep. IOW, the for()
> loop in container_get is effectively pointless.
> 
> We can fix this by having a single method:
> 
>  void container_create_builtin(Object *root)
> 
> which creates the 7 built-in standard containers we expect
> everywhere, with open coded object_new + add_child calls. 
> 
> Then all current users of container_get() can switch over
> to object_resolve_path, and container_get() can be eliminated.
> 
> The 'dr-connector' creation can just be open-coded using
> object_new() in the spapr code.

Yes I think this could make sense, also after I noticed that the assert I
added may not always work..  Please ignore this series then, I'll prepare
something else soon.

-- 
Peter Xu


