Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DFDF3D331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 16:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyC05-00050P-AI; Thu, 05 Mar 2026 11:56:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vyC00-00050F-N9
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:56:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vyBzu-0003Jm-LI
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:56:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772729784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WS8C1gUVzGeAwUjG4krS1ILLCRQKCr+JAuzOV+DQ0gU=;
 b=YHzCRNwozTmubR9xvT+aoZN49uG4sFQDup0YG7lfzBNyUuDT/rPi/jH5LEFHRIrYHI5pEy
 hedL4LAVFC6CPv/mhz15kdnwXJw6G42IkxdF3YNw7aNKNQXmRhX7+gy8greNbfAAb7LWIb
 4r2fYaaBx86ERKt1v3Xh4a4Ex0Y6OJI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-MdYvIGbENj6prTy7jjkr-g-1; Thu, 05 Mar 2026 11:56:22 -0500
X-MC-Unique: MdYvIGbENj6prTy7jjkr-g-1
X-Mimecast-MFC-AGG-ID: MdYvIGbENj6prTy7jjkr-g_1772729782
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-506bac14430so153792331cf.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 08:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772729782; x=1773334582; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WS8C1gUVzGeAwUjG4krS1ILLCRQKCr+JAuzOV+DQ0gU=;
 b=SFXlVp+YsW6l2bMrUDe12CJTtYf3x6O424PGsDip99LLqa3iZ2kvYm8VPp0qkJsAZv
 uLnMdqAhViWFgTs9EJ+iXXp0EOlKMFOwmRVNg3NSx3YC6t+hRP/CBFwcLanqbzt/IVjZ
 FHeMmkaLWcW0+fxjBzdnll4/TF74dcevpG5A5Uj2/I8PiNFtSfiXlVSBqYqzbkMSpw36
 a0bBbQmY4MBLG4wCUkxWtC2uMwst3R7c5Z2J/x/GtoTGmpzjIRrl093WQqPIYsV0vbxR
 BDfJIfa1nyqEfb5K/7Sm6iJhtd17HuBilVrNDvmZZBlRLk+TAoBSGz3jx6F3cAVffYJ2
 XubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772729782; x=1773334582;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WS8C1gUVzGeAwUjG4krS1ILLCRQKCr+JAuzOV+DQ0gU=;
 b=Dsl52h9wc2K+lADCX2wSZarM5C2CclKrBDSDPRqp6pCYFGp/ZRUZ7/hR5ufg8klILv
 G9X7NvuFSbzr8/qG8AtQut8QxmBteySxATVjqgkkLXXwMc9wfRJPCiZJjXGyLQjMBVKR
 i0WzNKeK4Nv1tuC9XBw9lHtMPCi4BOrZ7lj9FGxJhNQebjxYhrtXdz1QcBKVD/eDmXZy
 VPnflVgpljwfIqfgaQLw5qQ9VD3k63EtArQDNR84BcIL7OWBHTgzwyCDaYxdvypK2H+K
 0vhK8Gq598OIfGkwtfuQzHnV9TrHUgVdkrCG5Aa+6zT6Nr3m3+8qzmsnG6H+FmLCjpJj
 SEZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnFzbnrVMnaEFcQJXtIdoFh4w8ZdxvE8Sh47mTgpOVR/PcQqj5yh8fP6yK2tXJlm8IpRGCaviwavVl@nongnu.org
X-Gm-Message-State: AOJu0YxAkUUukL+iAqv4Nd1IKemxHXyEa9Wj/lByPk1vulOcLo4/n1PM
 8Z01b/LFg2JCgfp9qqR890M9Vb6Y/BCzFxMImAQ+juTSxT4V/+UNhxTfNQUWoX0VfbRtVDi0dh5
 xJhfSjeLc4P+uomhP9kzKo8TUKKgzTRelWjTBECjCcsC13C2FoCRotSHF
X-Gm-Gg: ATEYQzzLFHvK3U9u5ldPXU9Nfait+BGG0zd43Ucdk5X/pk/89QWAG0BXR98xiTlEgf9
 vindccK3Dlmv7ZmsTKNBpDvzwOwjrxhPISb+gY5MhpGE5igne/RvS6izuugklijaBxR7J6133GE
 bKpMqnMJTFoI3KzPojJ0CGZbXwcV2hXZEQMAwJzbjlufp3feEOzd8ERNb3+lnMPBmlz8odiyJNN
 owCjjZJBUsQIoSBGnYzN/Rpxrvh4gZHC0OE3KFIBlJb1OmqoiTa0uISZhGRab25gJBNu8uBZIwR
 jIW+GJxkPnfQo0mjAovULV93z/As7TCWAKb2Zidb/tQIATZ9pwJ1WI/yVseSDWTY1nWwuSoPJw4
 Wx5YFN6NTZ3KK1w==
X-Received: by 2002:ac8:5d0d:0:b0:4ed:b441:d866 with SMTP id
 d75a77b69052e-508db394a83mr89938931cf.65.1772729782158; 
 Thu, 05 Mar 2026 08:56:22 -0800 (PST)
X-Received: by 2002:ac8:5d0d:0:b0:4ed:b441:d866 with SMTP id
 d75a77b69052e-508db394a83mr89938571cf.65.1772729781673; 
 Thu, 05 Mar 2026 08:56:21 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a20471119sm41171626d6.40.2026.03.05.08.56.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 08:56:21 -0800 (PST)
Date: Thu, 5 Mar 2026 11:56:09 -0500
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v6 5/8] memory: Factor out common ram region initialization
Message-ID: <aam1qabqTPDEf6CV@x1.local>
References: <cover.1772572714.git.balaton@eik.bme.hu>
 <3122a5855dffd8df81f7552d4a11190c4d0a0403.1772572714.git.balaton@eik.bme.hu>
 <3fd2bad5-5df3-463d-a12b-c3a61ca1c4ab@rsg.ci.i.u-tokyo.ac.jp>
 <4b9a2efc-905a-335d-940b-a2d89e330689@eik.bme.hu>
 <420d013c-8cf3-447a-84b0-58f0f0f04a87@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <420d013c-8cf3-447a-84b0-58f0f0f04a87@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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

On Thu, Mar 05, 2026 at 10:57:19AM +0900, Akihiko Odaki wrote:
> But looking at the code, the functions generating errors (e.g.,
> qemu_ram_alloc()) return values that indicate failures (NULL), so I now
> think we should use the first pattern I cited (i.e., check the returned
> value instead of err) and remove the err variable and error_propagate()
> altogether instead of factoring them out with
> memory_region_error_propagate() or ERRP_GUARD().

I agree, this looks better.

-- 
Peter Xu


