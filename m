Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64460FCB627
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyY8a-00083H-3s; Fri, 06 Mar 2026 11:34:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vyY8X-00082p-IY
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:34:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vyY8U-0002c7-Hw
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:34:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772814885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=74tyFRJ2aAMHQEgXDu5XHjHRj5wbkcKlw6hPeSj2MD0=;
 b=dbA4DNZcv9k8tgzu2ALrOW7LSN6eFFvBbc1BqtLG6tSEQHWsGOJ8kF9aReTmmBkj4I0lm2
 q9N5IfPag6fJ5p/2MdDXHjmi/kYdtDdvVsSi4lWAhXVqf5djYadQIQ8h41MSot03f45BKQ
 Df6pvAbn5alCIiK5b01qfpGyRfhDa0o=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-Ff8MndMdPU2XDHgtNDYQ0A-1; Fri, 06 Mar 2026 11:34:44 -0500
X-MC-Unique: Ff8MndMdPU2XDHgtNDYQ0A-1
X-Mimecast-MFC-AGG-ID: Ff8MndMdPU2XDHgtNDYQ0A_1772814883
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-89a108d17d2so228368746d6.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 08:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772814883; x=1773419683; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=74tyFRJ2aAMHQEgXDu5XHjHRj5wbkcKlw6hPeSj2MD0=;
 b=ZAJ3WCgQR/JPMd0BeuFiVwa7Jm0MtMTZXMHQ4XISW3XOEGCrLWjdL6AG4dI4XKrW0Y
 Pi+k1Ps32QrsCYyTLXchuAVMxJef1N0O+CFCHX3uFUN/k4HFQc0vO7laepoIBeaNN/Ub
 hd/CixF4t1bAAZHNoDZXLWxbOW4mZsKV4viNJt8HwCd6iDaw1cD7wHA0/KJT4iOxpk7U
 dV7WXzRVTtq5RJkFdnvAufQ9MAetH+FwiOBiFO6t9b6E76yeqmL70mKAjU+lwVz4iwRo
 sYlPEWQ4SaHGKShE/dmnLxKTEQ7YRaOT0owgPwobDS6Q5JPdW9oTK6H6mFsJkfGQo0OC
 f/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772814883; x=1773419683;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=74tyFRJ2aAMHQEgXDu5XHjHRj5wbkcKlw6hPeSj2MD0=;
 b=sJ1xlM95FYFbXt0c4QNTfwD7GVHc81YetRAhgMSm8mvMz4OLJNWTvprIcbMTEUOZ6w
 J11JHFjbTD3+GwKGSNpgcU5aRKy+LIr3cXcLRPk4wz4zMWVM0YjMnfgCaM4mx8ZxAqgF
 JVEsg50mn8CPWs9llWMxJrs/pe3hRRe1OvwWRK7q3ekSssi8Mu2tIM0KxLEKVr9RgIy2
 VBfvPm64pUsFjXS7IWVinMdo1brdkXXhI+W1Aay1I/lwGUuXu0jW8En96KchuyyPvwLS
 HkBAoWtWTJuuCxOoQsMmkscNzCaFpqLEsUb5Xlg0VBZKK2DzMYWX4bsinvVXd5XXSake
 mTnQ==
X-Gm-Message-State: AOJu0YwNsfJ8vrX3D39J2odLvKTRtPNLMUnrwU8TStwi3bfMitfrVBzD
 VPBASufKnHQVA8N6k4AUpANTgo7bCX2Q1d2jKMRTbgHtl/crgiF3NUaYXKdndXR3mVCM6+dcW96
 DjNq78OFuLcC7gMHiauBB5yHE1C8Vwcw/M6Fh5gUEJQNyxXS8SKIcZ7F6
X-Gm-Gg: ATEYQzxO+KR8Wqp8J6K+/56C8GvyDHf1Hads63M5joIjvTgtSk7PXw+KVxu8DgiVrt+
 OcHQm6VY1KJXdwE3xm4cmLghm3yQKyXu3hiGcmAYqvWyy94cY4l2FDmQ0b/VWgaYGTwfp4qCikX
 lCckVEJGkFkNIRWyHdwP8PpMXehdT0X9GE0UgeSyarG11ZkzBBO1D27kj0d5rlz2acyPsnAEFr3
 Mo3b35O0E2dQH+XJu0VH/n2bzR2J4TYwnr6YGld4PayCbqXNto1KzRoK5iDgRZ+PBNq/Wmfx0qD
 ertgAuK8m5Lct5f5u8EFhqk04a8+oXbwsOHJkppxfXe7lnWYpTq693BHNidLii8rCleVxoNhaG+
 QQTLI5YXMbmz3mZ7cBuRiLm+nomroJrET12Pr081c++555UBfN7nshtGi7o3l7oucDgTRHRM6RC
 w69wem4g==
X-Received: by 2002:a05:6214:2604:b0:89a:a01:1c38 with SMTP id
 6a1803df08f44-89a30c1638bmr37156866d6.59.1772814883321; 
 Fri, 06 Mar 2026 08:34:43 -0800 (PST)
X-Received: by 2002:a05:6214:2604:b0:89a:a01:1c38 with SMTP id
 6a1803df08f44-89a30c1638bmr37156266d6.59.1772814882764; 
 Fri, 06 Mar 2026 08:34:42 -0800 (PST)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a316ea3fesm16851766d6.37.2026.03.06.08.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 08:34:42 -0800 (PST)
Date: Fri, 6 Mar 2026 11:34:41 -0500
From: Peter Xu <peterx@redhat.com>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Jesper Devantier <foss@defmacro.it>, Klaus Jensen <its@irrelevant.dk>,
 =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@stgraber.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Fabiano Rosas <farosas@suse.de>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v3 1/6] migration: add
 VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT{8, 32}_ALLOC
Message-ID: <aasCIdpqEQxmYjXu@x1.local>
References: <20260306150342.395923-1-alexander@mihalicyn.com>
 <20260306150342.395923-2-alexander@mihalicyn.com>
 <aar4-DgXbartZY4y@x1.local>
 <CAJqdLroT8j77_0OrE+qOoj1rRsmm0rQ4EgnjtWBush9CL1MFog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJqdLroT8j77_0OrE+qOoj1rRsmm0rQ4EgnjtWBush9CL1MFog@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Mar 06, 2026 at 04:57:56PM +0100, Alexander Mikhalitsyn wrote:
> yes, yes, I'll do this in -v4, sorry for this. I was busy adding a
> test for NVMe migration
> and decided to send -v3 with this new test.
> 
> Sorry about confusing you.

Ahhh, no worries.  Just to say, if you send a patchset without RFC or any
mark, it by default says: "please consider merging it".

Good to know we're still on the same page.

-- 
Peter Xu


