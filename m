Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C84C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 14:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTjUA-00052Q-5h; Tue, 16 Jul 2024 10:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTjTq-0004PT-Kk
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:48:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTjTj-0004H7-Eh
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721141309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yv/he6kSdfWA9ox/1K0866EPQziI3Z7o94CZyEviW7g=;
 b=MrNuC2cCI3cAzsuKA2MEQiurcsV72gkL+GJ1trgA+ApUFIfKF/BEtvSXiqj9UlaGiDUWV1
 Lkj3J/u4ajjk3/xfqrBPBrruGyjFDk5mSPDUGpzGtf+EVim9U7MAFliMknQWHc/NNWRFZl
 JAS103/w2WClRo1xkg8+zscCn/zI8i8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-LayDxbcqNGWwqEjJIydBlg-1; Tue, 16 Jul 2024 10:48:27 -0400
X-MC-Unique: LayDxbcqNGWwqEjJIydBlg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42725ec6e0aso41633845e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 07:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721141306; x=1721746106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yv/he6kSdfWA9ox/1K0866EPQziI3Z7o94CZyEviW7g=;
 b=FXlE7QG8w5SqMUat5bAhM2FE4N7rew5bANkPA/8yv0APcNp641rrV2qYjP7lfWMPDh
 vSqbSnOY/SWYdZthX+T4DlgRXQjc4e+N+izgAtBunvGZWCTNf+ZiSDtmJj++pqkroJGH
 DATeGPb4mqPnmzEEDGUHeALI0y6X6o+p8DblnWgXUq42usujvxo/Ol2tx8wnAaFuG6wL
 X721W8K0NLJIwn8sjQBjcfIoMkoxvpag04iUQPLhon5Km1knOEHTKNyuP5py+T04TOAX
 Gee4aTd1oORjsjwq0ZtXps0Vv6QJRp9mgK2bBw4JUI6Kpo7Ha0xIpgpJcVJiB8m/aB1g
 d4Xg==
X-Gm-Message-State: AOJu0YzQOsqzhewh8gqEfbH3I0bm/5h7+yewscqBGkuNN7K3xSMCFkcJ
 V6ZiLj8kgBJ4yn/j1jgJbR1ZfYMohYCwjEI1SFZsMbubAc0E4H4qJfnwP7wXbO2ag7xBs9ELUMQ
 lYfbvGfP4LWgnyu+x9ZL1ggLAauMEK8lF5uFPxeWxQNmKhTiU/s77
X-Received: by 2002:a5d:5265:0:b0:367:83e9:b4a5 with SMTP id
 ffacd0b85a97d-3682631f714mr1608234f8f.49.1721141306724; 
 Tue, 16 Jul 2024 07:48:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQXe31laLHVBszqoxU7Cqjw+mBkkC1F6/dzKxOubqc9BehIgrr5POKv2Up9Bkw4Rgp+Cne0g==
X-Received: by 2002:a5d:5265:0:b0:367:83e9:b4a5 with SMTP id
 ffacd0b85a97d-3682631f714mr1608215f8f.49.1721141306378; 
 Tue, 16 Jul 2024 07:48:26 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3681c30a024sm4990652f8f.96.2024.07.16.07.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 07:48:25 -0700 (PDT)
Date: Tue, 16 Jul 2024 16:48:25 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] tests: increase timeout per instance of bios-tables-test
Message-ID: <20240716164825.5e374077@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240716090554-mutt-send-email-mst@kernel.org>
References: <20240716125930.620861-1-imammedo@redhat.com>
 <20240716090554-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 16 Jul 2024 09:06:59 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Jul 16, 2024 at 02:59:30PM +0200, Igor Mammedov wrote:
> > CI often fails 'cross-i686-tci' job due to runner slowness
> > Log shows that test almost complete, with a few remaining
> > when bios-tables-test timeout hits:
> > 
> >   19/270 qemu:qtest+qtest-aarch64 / qtest-aarch64/bios-tables-test
> >     TIMEOUT        610.02s   killed by signal 15 SIGTERM
> >   ...
> >   stderr:
> >   TAP parsing error: Too few tests run (expected 8, got 7)
> > 
> > At the same time overall job running time is only ~30 out of 1hr allowed.
> > 
> > Increase bios-tables-test instance timeout on 5min as a fix
> > for slow CI runners.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> 
> We can't just keep increasing the timeout.
in this case I'm following precedent
https://gitlab.com/qemu-project/qemu/-/commit/a1f5a47b60d119859d974bed4d66db745448aac6
I'm not saying that the right approach (though seems to work for now)

> The issue is checking wall time on a busy host,
> isn't it? Let's check CPU time instead.
It likely won't help as we still racing with wallclock
overall job timeout (which sometimes triggers failure too,
I guess it depends on stars alignment and load on the host).

Anyways, I don't have know-how when it comes to meson,
to do more than this patch.

with this patch 'cross-i686-tci' job passes for me,
but we have msys2-64bit failing atm due timeouts as well
(seems to be limited to sparc tests)

> 
> > ---
> >  tests/qtest/meson.build | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> > index 6508bfb1a2..ff9200f882 100644
> > --- a/tests/qtest/meson.build
> > +++ b/tests/qtest/meson.build
> > @@ -1,6 +1,6 @@
> >  slow_qtests = {
> >    'aspeed_smc-test': 360,
> > -  'bios-tables-test' : 610,
> > +  'bios-tables-test' : 910,
> >    'cdrom-test' : 610,
> >    'device-introspect-test' : 720,
> >    'migration-test' : 480,
> > -- 
> > 2.43.0  
> 


