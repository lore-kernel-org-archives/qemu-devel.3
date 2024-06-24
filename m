Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18732C2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 19:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLp3b-0007wd-Vt; Mon, 24 Jun 2024 15:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sLp3a-0007wV-ES
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 15:08:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sLp3Y-0008W1-Nb
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 15:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719256126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5NbdlxVDsDJNiLI0hi7LNVf7vYEbAEAD6zDxIr15Ueo=;
 b=StV9MLaDgd9eB7gBEr1Z6kLPhiG7Z0SHlY2+VAEBQAPJiBO0RoB8NZg0dRin3yARPHAmRm
 I55nIJ6jng932+81NmwMVOgqnpWdr/gB2UC+7FkAIHgAOodCVmTETB7jlwI+yQB2vPojWi
 uMehoa2dyasyjt14FYwv5D/hTccnKFI=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-tO6HiBQZMOOq64UY_cCRPA-1; Mon, 24 Jun 2024 15:08:44 -0400
X-MC-Unique: tO6HiBQZMOOq64UY_cCRPA-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6f908f002c2so921817a34.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 12:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719256123; x=1719860923;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5NbdlxVDsDJNiLI0hi7LNVf7vYEbAEAD6zDxIr15Ueo=;
 b=ulmMFoWH10kgYwjA8q2UX+puqpRBE89O2+QcvPJlIvvWlz7EFTNZUSzSP5LkQ7ihHc
 0/eNTGpMWVBA+37Y51xxBIax6TtottYWc5/f4I3Es1uo+Z3oizobrOPXghPQ+ASj4pJ7
 kf/Im5Z5VgQXQjbXCR63jdBtxUUFCR53BdQDJbFMVgzPZeiMjqtWjzotHMY3gwlkpvah
 mXgkEB+t9d95lGNx04pgSW1FjvvgyC6/VAZ7QQyB/tgRj6qtKDjxNLRuygOMr1edfBJM
 1J0js/SGNDMOVAOl3T4QDTfA4C4Q1HngucJaRk4swYB0YdUN6h1lpRXjPxvxY7dvQaaE
 903A==
X-Gm-Message-State: AOJu0Yyih3oUUnYCr0OeE77abJxo0KyezRARXHOCAwyV7+ziRcHAzD0B
 Qi7QI0yXK5bP5XTjNFfFLD4konyrLrt0SLZIGSR1rmwtnKRIPs4UK6cQzwjODDI4WwDgD5qpklg
 5rMeoogYmDR0LuHlatjfgw1Ts5OLg/h7ivgi9pem+h+GncFrsvOTT
X-Received: by 2002:a05:6830:461e:b0:6f9:7760:522e with SMTP id
 46e09a7af769-700a8f34d5cmr7234229a34.1.1719256123474; 
 Mon, 24 Jun 2024 12:08:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYbURRoiDZVM4JlbuHnHRwsvKTN4Lm3lmzkoYnqE+znABiUKIk/UWEHozU+pkJQhjE83FP1w==
X-Received: by 2002:a05:6830:461e:b0:6f9:7760:522e with SMTP id
 46e09a7af769-700a8f34d5cmr7234204a34.1.1719256123025; 
 Mon, 24 Jun 2024 12:08:43 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79bce8b2ba2sm339923085a.49.2024.06.24.12.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 12:08:42 -0700 (PDT)
Date: Mon, 24 Jun 2024 15:08:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Shota Imamura <cosocaf@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 "open list:Overall KVM CPUs" <kvm@vger.kernel.org>
Subject: Re: [PATCH 1/2] migration: Implement dirty ring
Message-ID: <ZnnEOJSSsjG0D009@x1n>
References: <20240620094714.871727-1-cosocaf@gmail.com>
 <20240620094714.871727-2-cosocaf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240620094714.871727-2-cosocaf@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
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

Hi, Shota,

On Thu, Jun 20, 2024 at 06:47:13PM +0900, Shota Imamura wrote:
> This commit implements the dirty ring as an alternative dirty tracking
> method to the dirty bitmap.
> 
> While the dirty ring has already been implemented in accel/kvm using KVM's
> dirty ring, it was designed to set bits in the ramlist and ramblock bitmap.
> This commit introduces a new dirty ring to replace the bitmap, allowing the
> use of the dirty ring even without KVM. When using KVM's dirty ring, this
> implementation maximizes its effectiveness.

It looks like this patch will introduce a ring but still it keeps the
bitmaps around.

Could you elaborate your motivation of this work?  It'll be interesting to
know whether you did any kind of measurement around it.

> 
> To enable the dirty ring, specify the startup option
> "-migration dirty-logging=ring,dirty-ring-size=N". To use the bitmap,
> either specify nothing or "-migration dirty-logging=bitmap". If the dirty
> ring becomes full, it falls back to the bitmap for that round.

I remember adding such option is not suggested.  We may consider using
either QMP to setup a migration parameter, or something else.

Thanks,

-- 
Peter Xu


