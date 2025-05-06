Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C93C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 08:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCDPc-00036f-Cb; Tue, 06 May 2025 04:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uCDPa-00035g-Oz
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:12:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uCDPY-0002OK-G5
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746519138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QHkcgapeVW41/Wm10mgZOFbCNxv68aW1y+Puf9VsBQ4=;
 b=bUx95B94w2V7MHUgAK+ZRN/BSopQfd4NWspX5kiXew53KVqC117UT+e8wir3WyjaC3YaoK
 zZgQIkhVP+bwzo+NRpv7jWgWSwBHB0GipX/Zw7NjulU3gExAsxRz/TCOjWOa/aVRueCv0h
 NOYg2hV4uwmQD9kHK+1UaXSjRfJu+ls=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-wGVAKzffPBq4WNnk_-3Qbw-1; Tue, 06 May 2025 04:12:17 -0400
X-MC-Unique: wGVAKzffPBq4WNnk_-3Qbw-1
X-Mimecast-MFC-AGG-ID: wGVAKzffPBq4WNnk_-3Qbw_1746519136
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d5ca7c86aso31032015e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 01:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746519136; x=1747123936;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QHkcgapeVW41/Wm10mgZOFbCNxv68aW1y+Puf9VsBQ4=;
 b=sfxzuiKjjbfJH7XyW017/TWCoS3i4r7cQB+7IjoLS66UiywvXVqpHUkSjuQja9O4Wd
 o5CQZxRFiqhV+dk7+V2mHG3kLeHT2THrRjkwvEovLv0qOo7gsVvs6jvaVoBox7v9m7Wv
 Tkpa/SF8mKpy676Obtr2EJlEcYK4hwe543xjpyooyJ6l7oL9i8wqMJwQLa+VqjoAUjOz
 z/T7uZ/DKHwd1BVyw9z7AA+CE+mV5Yn7EQUbVotl9Mq7Zh8YnBO4TXjXG0Y9KP7zQflp
 7EkbQrR7jvrHEwoCNIVjDOeiJ4VxKMvz4/OgYlm00Z82pkOsGySaIZqkJd0dzWeJNnEl
 P7uQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbiQUsDUR1yGesBcUwiJFqGz+E438XvQs9/HVQFISrB6YxQoWk/t57mQSXdyNdrfT5RzX/sxUtwhOQ@nongnu.org
X-Gm-Message-State: AOJu0YxW4hbxffThwzT+PFfJvBe49w8rgBmqMcp3JcXWIFicZE1rDqwN
 wSI9U+BRbwCAGrkmJomFYzLzJriULGItbk9GiRjMiBUTVcc+rLmVNMYcA6b/IMyM2DNb5Pe2Qyy
 /T7l9l1KMYSNGsdio9NMs5qgIoVJ0AIlgTvdCgV/4Ufr/Xv7OypQC
X-Gm-Gg: ASbGncsh8hQbeT9RZ+tSQL8U7VQWKTMIWqsFNfIzr0LXKg5/EyUCasSywRnaS2eGJlS
 lIzTHOsnjWupSyOlQAqaBZpFztV8mLiHVh5ZReaYj9NmbqQp74zz45HFKWVX+8exRpEObVx4Zeg
 b8ISgPNt5jDPI1GYDmGz+xruypBsxRc7KeYIuLQtN4X1wLQT9w0G9LiigxG2eyo8DtQy8mLRaWY
 bf1rXGGHxiKUVRN3lnpJq+0KmTNuQOHxPIOWWXn3gjpHl/RVg7lWiKNg+FjtsPE38y7eNi3OawF
 YeiLdQ==
X-Received: by 2002:a05:600c:1914:b0:43b:c0fa:f9dd with SMTP id
 5b1f17b1804b1-441bbf33f76mr110821915e9.25.1746519136420; 
 Tue, 06 May 2025 01:12:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlAODpQ2AGOG58bP2sJNW3F785oQYM7SLHD2rbLBY2sS0pl0syAlWslHLsl6mWaROv1SUvAA==
X-Received: by 2002:a05:600c:1914:b0:43b:c0fa:f9dd with SMTP id
 5b1f17b1804b1-441bbf33f76mr110821635e9.25.1746519136071; 
 Tue, 06 May 2025 01:12:16 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b8a2874asm158415125e9.26.2025.05.06.01.12.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 01:12:15 -0700 (PDT)
Date: Tue, 6 May 2025 04:12:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Jonah Palmer <jonah.palmer@oracle.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Jason Wang <jasowang@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH] hw/virtio: Introduce CONFIG_VIRTIO_LEGACY to disable
 legacy support
Message-ID: <20250506040903-mutt-send-email-mst@kernel.org>
References: <20250502132441.64723-1-philmd@linaro.org>
 <aBnCk2WE_SNkRgSH@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aBnCk2WE_SNkRgSH@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Tue, May 06, 2025 at 09:04:50AM +0100, Daniel P. Berrangé wrote:
> On Fri, May 02, 2025 at 03:24:41PM +0200, Philippe Mathieu-Daudé wrote:
> > Legacy VirtIO devices don't have their endianness clearly defined.
> > QEMU infers it taking the endianness of the (target) binary, or,
> > when a target support switching endianness at runtime, taking the
> > endianness of the vCPU accessing the device.
> > 
> > Devices modelling shouldn't really change depending on a property
> > of a CPU accessing it.
> > 
> > For heterogeneous systems, it is simpler to break such dev <-> cpu
> > dependency, only allowing generic device models, with no knowledge
> > of CPU (or DMA controller) accesses.
> > 
> > Therefore we introduce the VIRTIO_LEGACY Kconfig key. We keep the
> > current default (enabled).
> > New binaries can set CONFIG_VIRTIO_LEGACY=n to restrict models to
> > the VirtIO version 1 spec.
> 
> IMHO that isn't acceptable. In order to be able to provide an
> upgrade path from the old binaries, we need the need the new
> binaries to be able to serve the same use cases & disabling
> virtio 0.9 support prevents that. I don't see a compelling
> technical reason why we can't support virtio 0.9 from this
> endian point.
> 
> Yes may be more ugly/messy than we would like, but that's par
> for the course with QEMU emulating arbitrary device models.
> If the new binaries can't cope with messy devices then I think
> we are doing something wrong.
> 
> With regards,
> Daniel


To be more specific, having a kconfig knob modifying the device
without regards for machine types, means it is no longer
enough to inspect the command line to figure out the
compatiblity. That's a problem.

-- 
MST


