Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB9C10ED655
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 10:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w64dJ-0002YX-5W; Fri, 27 Mar 2026 06:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w64dG-0002Xk-Nu
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 06:41:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w64dF-0006bw-2q
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 06:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774608096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=z+dxqsGHFPM9V9SgtVex1SIfczCoojKl9Qm/q4qGfz0=;
 b=cy8Su0YGBN/LVYJTdAYUpxiuCqai3TnlP0KQfdYnOhann/dQ/CnOtXNGkEUHoYwv+vMe5b
 ydgyWc5KAmdyRPwCTNOdjHFILZHNctRQgD0jpwLGpwq6YbcqxJs0RhRfVhGLolpbFJhORc
 WZ5rfn2FqSbqPnnjZlNEuaWJFP2FkzM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-ZXyRlbtyO-yeGalMOtIV-g-1; Fri, 27 Mar 2026 06:41:34 -0400
X-MC-Unique: ZXyRlbtyO-yeGalMOtIV-g-1
X-Mimecast-MFC-AGG-ID: ZXyRlbtyO-yeGalMOtIV-g_1774608094
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439bab2d095so1638744f8f.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 03:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774608094; x=1775212894; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=z+dxqsGHFPM9V9SgtVex1SIfczCoojKl9Qm/q4qGfz0=;
 b=sFijbtcdmYWF4Yt7fjPqBbnIaQLcwMGjt6dj4OrdsBCHGjFgTDaZKxLbEUShNm7sfQ
 VogW0tJ1nQjtRiJi1F1az6VC5X+Rb8DOCdVun4xmPZSSyDqFcbwSm4Ga2kcZ6BdnJPjG
 dpGzVpFSwwK0aPCX9DebD5mUHEaRa9FHJez7kB/uUeRpVWxY1rEVM/nSdKYSnN41O10x
 EroOO2V0GQrwsbNJwNDqhWFXaWB/utbVNmUgP7Wpz61hQmyIuoOv0mehzdOTnc0XZRH1
 nSWQwVtJ4uegJT2Z7Ar73aKJn/oFOnSQek07KVYtKwt5SbBc+DFPv+gI42TNck3fP2Hr
 ldaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774608094; x=1775212894;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z+dxqsGHFPM9V9SgtVex1SIfczCoojKl9Qm/q4qGfz0=;
 b=o9+/RvxyaH3+r+kgCiA+Z84OZvCsv/7ZSHGrar5YXogFDK5GevEAg+bhgwNEVJjIon
 6IPLhysu5cv20QOByy20QESJj637c3BqFpgITZGkoyLqOiKTfhIhsr9nkswJzh0R0cDq
 e1n903PSicOZCy0Scoohen3iu9TPxJQE+/4nRLEHNrtFQVkZ5/qwo8tHrkLi2N3fncba
 mN1rPBbUhRrY9NjiBEzAuaHYDavGgs6QFijwIIh0adBVi2ax8/yBT5tGY5SFBUi8XRrd
 g12B6x4Rwjp38Ch0AcvpK1QmmT3Zv5t+FmPju8NEAOUn4edzPKmfqAdGTZeFEnPfZ3e3
 iiGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoxlIiVVsJ/RaRE9U4ghV+m1XqwUJbutz2x7VbXScQgoYOSI4HgVmnwUIjTNdf2pXpZRPNVJ3oZFmt@nongnu.org
X-Gm-Message-State: AOJu0YwXkt8sLl+16QyoJ+oQIYUqcbX8WiWZD9znnUPeLaAcZlSg/qIz
 8IcQcWcikgxx7aPAJX+SrdKSuKWXYe6rmhUvx0SUEu5yLPn465RB9A+HkLtR6T4WWfP3OaspXPQ
 mSlao5IBKSW+xzNDNLXTZuoT86fzjoVxtHhWceBG6VJR4+7yPhFRdjPEY
X-Gm-Gg: ATEYQzw74Q0+H66FNuzq9JlgrGv6D9c598JWwB9hRSXryPu9md5P4VA6/kB6PCvxIRy
 mZCvcPbGfSdUdPDxVloWYytIFQMDi/UL+Qe7VCzs1iegkUQv3WIWyrJiAC9Kp9OcPUtzNbZbTTa
 y3yyREk8wknBrNLaQyexidTpwG/82aunHq0SU1HKqSYEoyecTG0omEhHgd/QAYUmVEpSJHa0NU7
 WzYV9njH7dA93GybbQPRAU+z9cGvSU927fQM8MGd/QUC/SEcAqqC5FkjDLuwZ1JK7q4104mcTEQ
 Mra+gSU8/ZKWQUDOQvUt4Im6UdBahCcr7KM+yKmmaRp6NbbDOEVJ9GfKEdKm+W3tqIbxslCQkAS
 zCnr5WvL08rn9S8WR9tQ7Ul3pOfNygZUk9MlePHh0N9UHeZ0nyqlbd7VJTPLY
X-Received: by 2002:a05:6000:4210:b0:439:fd13:5c48 with SMTP id
 ffacd0b85a97d-43b9ea4acb3mr3149788f8f.31.1774608093617; 
 Fri, 27 Mar 2026 03:41:33 -0700 (PDT)
X-Received: by 2002:a05:6000:4210:b0:439:fd13:5c48 with SMTP id
 ffacd0b85a97d-43b9ea4acb3mr3149727f8f.31.1774608093147; 
 Fri, 27 Mar 2026 03:41:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919df85csm19886445f8f.28.2026.03.27.03.41.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 03:41:32 -0700 (PDT)
Message-ID: <57b66b93-1864-4f09-88ba-73bf75d5bc3a@redhat.com>
Date: Fri, 27 Mar 2026 11:41:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 06/21] backends/iommufd: change process ioctl
To: Landon Clipp <landonclipp@gmail.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
References: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
 <1751493538-202042-7-git-send-email-steven.sistare@oracle.com>
 <DHD021CSIBZK.3PZ1A7CQUUBQU@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <DHD021CSIBZK.3PZ1A7CQUUBQU@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,

On 3/26/26 21:34, Landon Clipp wrote:
> Hello,
> 
> I'm running Linux 6.8.12 and when running QEMU 10.1 or above, it segfaults when
> submitting the IOMMU_IOAS_CHANGE_PROCESS ioctl which is not supported on my
> kernel. Here is an example strace:
> 
> 3388260 22:48:30.540879 openat(AT_FDCWD, "/dev/iommu", O_RDWR|O_CLOEXEC) = 25
> 3388260 22:48:30.540942 ioctl(25, IOMMU_IOAS_CHANGE_PROCESS, 0x7ffe91d96490) = -1 ENOTTY (Inappropriate ioctl for device)
> 3388260 22:48:30.541003 close(25)       = 0
> 3388260 22:48:30.541059 close(26)       = 0
> 3388260 22:48:30.541120 --- SIGSEGV {si_signo=SIGSEGV, si_code=SEGV_MAPERR, si_addr=NULL} ---

a QEMU backtrace would be more useful.
  
> I heard through the grapevine that this is a known issue and was fixed. My
> question is what QEMU version should I expect this fix to land and roughly what
> the timeframe for it is (assuming it hasn't been landed already)?

QEMU shouldn't segv. I believe you are using CPR  ?

Please open a gitlab issue on :

   https://gitlab.com/qemu-project/qemu/-/work_items

Thanks,

C.



