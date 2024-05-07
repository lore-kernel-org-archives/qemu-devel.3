Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55612C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 08:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Fur-0007fg-17; Tue, 07 May 2024 04:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s4Fuf-0007f7-1U
 for qemu-devel@nongnu.org; Tue, 07 May 2024 04:11:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s4Fud-0007Ci-A5
 for qemu-devel@nongnu.org; Tue, 07 May 2024 04:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715069456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YjnIcSH+FqrxPgOAE7MG8E1vh4FRj51/wDvPzDiTdK4=;
 b=VGQ7vF6JjjnXN2k4kx2c6dR5lg1KPqdWXFYcu4sncsFes38oyQOfi/Cx6mMkwAKRogwjVB
 rAdvGeu8qSXUCGUEHA3Mz9fdJB14zzUehZE7TY2wywRg5u1NwrQ5km8V/GuzszVmNqGXlH
 FnR6nKTwF6znelIZvMcJN7nqYI188PQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-yM8Jy_PyNBSYQGU31J8eOw-1; Tue, 07 May 2024 04:10:55 -0400
X-MC-Unique: yM8Jy_PyNBSYQGU31J8eOw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-572f3859ff2so728513a12.3
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 01:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715069454; x=1715674254;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YjnIcSH+FqrxPgOAE7MG8E1vh4FRj51/wDvPzDiTdK4=;
 b=dRFthSQ+5BR4t8UYslCAeGHWPOQikPAPePpJ0yNeiUpC8DIWYLeoIVnCJLg5jLeU17
 fQAdvuqU5oklWpbJx82GkhMicyHUH5kLIzGsgL41i8ltgED6nggfsnpVsAMDsC9d8dkB
 dYaMAOGWk1y3FRAG7VN4PtgFNMX35ofA2OBuOo8sAfmvIxDbRymvCLd4cGjYAdOGRs8y
 dpMe0FZ13qoGlNiSb+BoDmmH3bVy1HxhwrhVO4r9k1rOzZqggk5kmesVH77jhXCaMaKd
 SX0qrv0LdurNdf23qjBF61XI9bFt7b22SHUfU1S55mBsbY34FbUXij4HtU29jyZtfWgi
 PpNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURAG0PpKX/IROvdsdjUFGpIAlF3x3xXTIhfD5R82wP1SJShMQ1qnc5dDkVMWdYGodDxR/IxSa6iBgeF9vLhklIlheNpEo=
X-Gm-Message-State: AOJu0YxcqT5pg1TRreStXIpCN4m0PwH+s+STrADg0heiHVeIRY05O+Nb
 apG+iDfklXOF0paSIs/eYeXkOnFsm/RjafhjFt4G/+O8fX/6g4ZYIgHXPJlB9H0pEdbAlCNUWZ5
 Ya3dFuKq/Eha0KqvpxOsz8hOFgW9UP0a5yikc7hPrD/Y4dnTTETFu
X-Received: by 2002:a50:d503:0:b0:572:9a99:cae6 with SMTP id
 u3-20020a50d503000000b005729a99cae6mr7533000edi.15.1715069454298; 
 Tue, 07 May 2024 01:10:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH57vlvbblu5vV+KoeH+A3xZfmCPatx5vhDvMY1CCrw2nZ17LHMq7gJpGlr7o1yN6zdyJF9bQ==
X-Received: by 2002:a50:d503:0:b0:572:9a99:cae6 with SMTP id
 u3-20020a50d503000000b005729a99cae6mr7532983edi.15.1715069453961; 
 Tue, 07 May 2024 01:10:53 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-56.business.telecomitalia.it.
 [87.12.25.56]) by smtp.gmail.com with ESMTPSA id
 p7-20020aa7d307000000b005722d871e4csm6060358edq.90.2024.05.07.01.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 01:10:53 -0700 (PDT)
Date: Tue, 7 May 2024 10:10:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Roman Kiryanov <rkir@google.com>, 
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 QEMU Developers <qemu-devel@nongnu.org>, 
 JP Cottin <jpcottin@google.com>, Erwin Jansen <jansene@google.com>, 
 Mehdi Alizadeh <mett@google.com>
Subject: Re: Hermetic virtio-vsock in QEMU
Message-ID: <nga2k5uuvpqm2sovguofglw6u3reiqqurbn7vbdexanzrhmw42@vuje72e57egu>
References: <CAOGAQeqOVAHJ4VxQNKqO43hmLJdxpA6E_JEQrfL380SwT4Y73w@mail.gmail.com>
 <Zh0NiI9ZfS5uzs5Z@redhat.com>
 <CAOGAQerx0DmHvJNf05wuJFOtXVwDFTt7fy0-GmBZ7xKoLAHTKQ@mail.gmail.com>
 <ZiDpM7ZusU0SvH7K@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZiDpM7ZusU0SvH7K@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

Hi,
sorry for the delay, but I have been away most of last month.

On Thu, Apr 18, 2024 at 10:34:43AM GMT, Daniel P. Berrangé wrote:
>On Wed, Apr 17, 2024 at 12:31:41PM -0700, Roman Kiryanov wrote:
>> Hi Daniel,
>>
>> thank you for looking into this. I checked how VHOST_USER_VSOCK and it
>> refers to the vhost-user protocol. It is implemented in the
>> subprojects/libvhost-user library, but this library depends on poll.h
>> and linux/vhost.h files. Do you know if it builds/works on Windows?
>
>Stefano recently ported it to work on any POSIX platform,
>but obviously that still excludes Windows:
>
>  https://lists.nongnu.org/archive/html/qemu-devel/2024-04/msg00388.html
>
>I'm unclear what blockers there are wrt Windows, but perhaps
>Stefano (CC'd) can advise.

I have no experience with Windows, but what we need for vhost-user is:

- AF_UNIX and be able to send file descriptors using ancillary data
   (i.e. SCM_RIGHTS)
- share memory via an fd associated with it (i.e. shm_open(),
   memfd_create(), etc.)
- eventfd or pipe/pipe2 to exchange events (irq and kick)

>
>Personally, while I think vhost-user is a good option for the
>vast majority of cases, I believe QEMU ought to natively
>implement a simple self contained AF_UNIX backend for vsock,
>avoiding need to depend on 3rd party software for its use.

I was already planning to extrapolate the code that handles this from
vhost-user-vsock to implement a library, this might be a good reason.
Next GSoC?

Thanks,
Stefano


