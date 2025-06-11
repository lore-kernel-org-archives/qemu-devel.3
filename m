Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E091C61CE7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 13:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPL9y-0003No-Tm; Wed, 11 Jun 2025 09:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uPL9v-0003NX-EG
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 09:06:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uPL9t-0005QJ-HG
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 09:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749647179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fG6IPyaBwfU9Ynqfua7se+8r7xvL/Sudy5TbowxPWHk=;
 b=bldCH2DljfwwppucM2UL1oXRok10wI/Wz834/zeAydyk3BwALldg6v2+2PJSEje2YJ1TY2
 gTYoH6QcdkzG6HkqtcAKf0TOirBCNbo2OsdFGa3jR4QtH3gEGJ0hd9RcJi9YlrmM9LBE7x
 zoUN9vHmU3AWBAAuPiizdJUlGy6w450=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-7hd4xut_OTeF2TO479tzAA-1; Wed, 11 Jun 2025 09:06:17 -0400
X-MC-Unique: 7hd4xut_OTeF2TO479tzAA-1
X-Mimecast-MFC-AGG-ID: 7hd4xut_OTeF2TO479tzAA_1749647177
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4a46163297eso177782531cf.1
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 06:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749647177; x=1750251977;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fG6IPyaBwfU9Ynqfua7se+8r7xvL/Sudy5TbowxPWHk=;
 b=QGPQrIGNd6cC7EOJFqI39ROsHPaamtw21JbLaeod+rlMA7DZ/tw0+E4FWxEfozREeu
 Tkyh21e4D1jrOqIDXjeXxWNsQQnUDIeovWxs2a+DTOOPMOmhibatzpciTJH0b8xnj1S/
 cbcD5nXfm0VkYzuAtiDiBOK3T4HpQAqXRs3YrwiV6SyNEMgvYEcRgycId1KiShTC+D0n
 /xtuQ9SB+C4UI/y8qsmfTqwjKx4KfqNv1ikXn8hwHp1y0A96q8YOSJguUyvNehOD72xC
 GThAW8Gzi8XKwYZuQ6AoPOKhImUaq6PVKNI8LGidNohasULAGGqUqrY+E7KHtPdxBtLa
 IAmQ==
X-Gm-Message-State: AOJu0YwIwCYr5zljd/KsGQ51KeMPAbbef55PsGLX4lS3h0LatVaeIMTL
 24ghf/1ZWNBVue/bxMmxiAfEhMnoBunhMHkFBUs+uATHpJkgZwg47yRGT7tGVIk/ZBGK1RHUPzw
 P8bESPKtcIZkXiliv04R3UTqqdyNJUReXc57icAElEPg4u4eOqycu7yXj
X-Gm-Gg: ASbGncu2UPZ1+x3Y7Bk9iMY8xjAzk4/fnZyswDcb3/f2qmug4PQuNg+Gecv1zoDyWvT
 AbqsUDbu9jUm0ISqZaKT6Hseh9ToKZFOqbWdnhPGAiQ5jIZpFth+G0uHBRXcaRhbdAvs7zH5qhr
 gTPOcA7AoHhhxDVemzIP5VeYW3IeT3/nEb4cedFLQuoFStRzulO6AyPmUGMjNzj0RWTnad80fGX
 IfP1fLZoRSl8BRiqQdGvlSu3CLrACO551UxSiqSxY/oxGWhndA6an9SHniZfxM7zxOBZNIm/YWm
 gRTmiyf4ZAAhjw==
X-Received: by 2002:a05:622a:5510:b0:4a5:a632:2888 with SMTP id
 d75a77b69052e-4a714dc4634mr52149911cf.47.1749647177075; 
 Wed, 11 Jun 2025 06:06:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5mZ3lqC308/6xOduUKk+KoPVSaaWyUwcPNcy2Wc705rwnelH9jr5VuPvEkOqeDO1O+DSCTQ==
X-Received: by 2002:a05:622a:5510:b0:4a5:a632:2888 with SMTP id
 d75a77b69052e-4a714dc4634mr52149341cf.47.1749647176482; 
 Wed, 11 Jun 2025 06:06:16 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a6f7a786a3sm55836581cf.81.2025.06.11.06.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 06:06:16 -0700 (PDT)
Date: Wed, 11 Jun 2025 09:06:12 -0400
From: Peter Xu <peterx@redhat.com>
To: Mario Casquero <mcasquer@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 00/11] migration: Some enhancements and cleanups for
 10.1
Message-ID: <aEl_RESZhLS56pv2@x1.local>
References: <20250609161855.6603-1-peterx@redhat.com>
 <CAMXpfWtGPUDGtn40tkZYNMhntp48BbMRHnZqQkrBKokyMyEXyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMXpfWtGPUDGtn40tkZYNMhntp48BbMRHnZqQkrBKokyMyEXyQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Jun 11, 2025 at 08:15:55AM +0200, Mario Casquero wrote:
> This series has been successfully tested. The information displayed
> from the HMP info migrate command is more user-friendly, with the
> possibility of displaying the globals with info migrate -a.
> (qemu) info migrate -a
> Status: active
> Sockets: [
> tcp::::8888
> ]
> Globals:
>   store-global-state: on
>   only-migratable: off
>   send-configuration: on
>   send-section-footer: on
>   send-switchover-start: on
>   clear-bitmap-shift: 18
> 
> Tested-by: Mario Casquero <mcasquer@redhat.com>

Hey, Mario,

Thanks for doing this!

This is a specific HMP dump test on recv side, just to mention the major
change will be on the src side, so feel free to try that too.  That's what
patch 1 does.

Patch 2 changed recv side report for blocktime, but in your case you didn't
enable it, to cover tests on patch 2, you can enable postcopy-blocktime
feature and kickoff a postcopy migration.

And just to mention, the real meat in this series is actually the last
patch. :) If you want to test that, you'd likely want to apply another of
my series:

https://lore.kernel.org/r/20250609191259.9053-1-peterx@redhat.com

Then invoke postcopy test with some loads, then check the blocktime reports
again.  The other series added latency tracking to blocktime.  With that
extra series applied, you should be able to observe average page fault
latency reduction after the last patch, aka, the meat.

Note that this is not a request to have you test everything!  Just to
mention the bits from test perspective, so just take it as FYI.  I
appreciate your help already to test on the recv side!

Thanks,

-- 
Peter Xu


