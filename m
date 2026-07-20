Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19A9C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 20:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wluYi-0004Z4-W0; Mon, 20 Jul 2026 16:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wluYh-0004Yl-4R
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 16:25:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wluYe-0000we-W1
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 16:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784579146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zdxueYVCrxO7Zm4pDjamE0fe7ZZ8bDM4JZXDR73Ad1E=;
 b=UtLD7gRlGSagvFsZ/Hu11RqwaAlkRtagT2cJ2CV02IrFXgwnljj1ks1UV9xVIcp7sk0Pdx
 O8/JEL038YBQGe//6gEda7bZHORH96iYyYub2zDGHJU0x2cUr0BVPkS12YqqrINlFleJXQ
 NCWY/dMHioHPyfP0QKce7lq5OK3M8qE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-isddzXxMPumB_YeA3WZFfA-1; Mon, 20 Jul 2026 16:25:44 -0400
X-MC-Unique: isddzXxMPumB_YeA3WZFfA-1
X-Mimecast-MFC-AGG-ID: isddzXxMPumB_YeA3WZFfA_1784579143
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8f000e221d7so155593136d6.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 13:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784579143; x=1785183943; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zdxueYVCrxO7Zm4pDjamE0fe7ZZ8bDM4JZXDR73Ad1E=;
 b=YTRvi2Xs3164J5Nza58QioZ3HvhCK0oF7SU/3q2+inNjeZLZMCYEQFZYtnh2MZR9Ra
 505bbbeL4xDsG/6yY3n+90pC2itin1aMTc3TxQFGPdZEqE/VORy25YHeGAZU41xI2534
 imvX5sQYyJC7iWo69pgkb2rTuEE4MmbDKf+cNsKJxlsPdjv3PM2bclLdZ5Vmp9jotvqf
 A/DoeK+tTMmvQRFySeQl3H2nrgYvnHibiaDEj+OXqCfYaNFopCMygpZIIEoBsW/U4+Z+
 9PJ4hZ0sFbOush2Q4Sx/QW98KWYzU/MqjWV7WlORZytzES6IK6ulJy2SQVWLoAuUkwO4
 LWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784579143; x=1785183943;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zdxueYVCrxO7Zm4pDjamE0fe7ZZ8bDM4JZXDR73Ad1E=;
 b=BDHP3YYcxevGs0sNPmkewKY6duICq9croxp3Kxk6LRQ30cVHMN4z+a2zy3IF1+qxOt
 VVCylZJ/dqoYsytvVW9/7LUxL8QXNujCGqzLVXC45JOqPGEXxwKHAfBaDaauiCQrBoF6
 IckY4VBLrOliKUa+57LfIp2ruEm0wuIW3kiIuy6XQ2dz3tLXYp3CfiFKnPtxGFikJhNU
 KxaH1Xsb637Fr/inLF/gWDaI+2ItTbzY5A0U6lKjhXSzPisSy+DLdKR7BB/xVD69GKo0
 AQ/OD4vXKR1/TLtxc6PPopdnUfXCp75ewGY9AZawMqD69M58vQH8KREWR1YQuW+dlUGU
 MQ8Q==
X-Gm-Message-State: AOJu0Yw5RixyJ6cqEy5CwXHSUhKbeaY2sj6y9H15IbIrPrNlIol3YcLK
 p6o5iiP1k6jf/Q7V8IC9zaNR1nolmo0yy3BbpZEA8DNsz1UX1dZeqJx6L3dSN3gY2lYNUlDpoL5
 yG7xA8k0I4Psdf/Mrc3rCd/jo9MYz06Fu9QNFfgRVhoLndP79tqe1l+s3
X-Gm-Gg: AfdE7cl7Q7J3UwxekIf5b4SrPbMPrYHjenaNb6KIeSJ8H/wbxBOInaiBkPnbJKe7376
 ZRy4rCdM9k/Cdt08SzvGZU9b/XJplrAJoUhxKBcFMNvpFiy6CYTFiOaqBmPGBr6/v1WR347T0Cb
 8K2jpVmusXQotQWFeop6cqtnr/eYQCmwnJYCjuC6JclPBPqtnQ1bPm643gZVFYx7hawrOeQbUgq
 XsHgKOBbBp96Ke6SevyoWGLsZvjCNWmRGnDobLxD8VF6C8JNn6ZuPuU2bFQMf9aEktFvxM98Azb
 HSUUvMXfwEPM5auVkvU3okqHtJxC07xwrCwrJI6QXYyVO2s4K/RZV91sQgVW07BYcItX
X-Received: by 2002:a05:620a:2246:10b0:930:bb30:6921 with SMTP id
 af79cd13be357-930bb30701dmr1011901885a.29.1784579143203; 
 Mon, 20 Jul 2026 13:25:43 -0700 (PDT)
X-Received: by 2002:a05:620a:2246:10b0:930:bb30:6921 with SMTP id
 af79cd13be357-930bb30701dmr1011899285a.29.1784579142619; 
 Mon, 20 Jul 2026 13:25:42 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-930b542dd27sm951715185a.29.2026.07.20.13.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 13:25:42 -0700 (PDT)
Date: Mon, 20 Jul 2026 16:25:29 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] docs: Add security considerations for migration
Message-ID: <al6EOUnd-zddRNSJ@x1.local>
References: <20260720182750.3029289-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260720182750.3029289-1-farosas@suse.de>
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=peterx@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Jul 20, 2026 at 03:27:50PM -0300, Fabiano Rosas wrote:
> Add the security considerations that are unique to migration and that
> do not already fall into one of the other categories. Some aspects are
> better framed as security architecture considerations, so extend that
> section to mention TLS and clarify that disk images and guest network
> also need to be isolated from other processes, not just other guests.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


