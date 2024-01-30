Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E77C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 10:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUlfB-0003GU-R4; Tue, 30 Jan 2024 05:48:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUlfA-0003Fe-53
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:48:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUlf8-0004Oi-LI
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:48:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706611697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9gB2J6kr4easvAjJIYGK7lfO3I88bpiGgWZo27L07pM=;
 b=EdWEirsPtD/jmC7jNrCaIiioDoQn17QyRAnmzY5CUqq3jtipAGCGSj0OH3XbGDgIZO5ZKz
 VW+Q1tUdlUy2h40+5EQtmCgGTtFTubCUSRDn4c4W8SP3ISZw2ehMY0IYeis1NgcX/qXVgz
 DO0eyQr7BL5DPZzGdE4BjNuUI+n/SS8=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-O6Vv47FWPEC_oaWXdSKsnQ-1; Tue, 30 Jan 2024 05:48:15 -0500
X-MC-Unique: O6Vv47FWPEC_oaWXdSKsnQ-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-59a44d084edso413765eaf.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 02:48:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706611695; x=1707216495;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9gB2J6kr4easvAjJIYGK7lfO3I88bpiGgWZo27L07pM=;
 b=ZUgHQhOm1H5L4b0ltnx9+Zo/MDH92mFgXHN2OaZO+Q/7IZXjNbPJW/mfaojJPQhhCF
 H8l2FU3UOFOfbcaFw82Rw3lXowCbrqh+gCumVPIKkO5JKelRS8hF2DntrbXDAlqyVc5+
 yOTIW/EgkF6i27oCdFz377IxtDCgKktHIHpDHeyZdBONgFXJ+35AByMOu6zK4WPTRNAO
 FkvHnQB2aeavn4m05ukd3Mt7fuo6PEmQc0itdrMBEIl8+obcDoHHn54Kh+Y8yLiWEPkj
 TBaT924lbnAr6O77LoDWFqzSl/8AzNcXWHA2URnSc8aNWuy2bxrUjBhoAZajOhIreYTz
 yQwg==
X-Forwarded-Encrypted: i=0;
 AJvYcCWo3NBj4PS7MLNKf5o9Z6R7DGXybyA4trtgHyr2TQBBX29mGfTpTW9jn5pz8Dt9aPQm5hYyTX/tiZk+QQH9lfWbxQr69FA=
X-Gm-Message-State: AOJu0Yw0BqOF4mLzXxisp8iqHlETn+7DZBfoTVoLiZ8R+ZVTePwc6GGT
 +mE6I8G9BSd3BSH1bzohcy/9xE03SkHvAkDWnS+/RzZBrwZf0SLdhOq0X0XQ+DBl8Laxx8snHzc
 QX3K6oBm4lPSCCBd8m2faa3ZAqgFrgw0/rQdV0u+C9Kkq+p2pIPdf
X-Received: by 2002:a05:6359:459d:b0:176:c1e1:7556 with SMTP id
 no29-20020a056359459d00b00176c1e17556mr8958944rwb.0.1706611694847; 
 Tue, 30 Jan 2024 02:48:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHweTCsPMU4oT4XVDKME2sgT0o+KvoPz5nRqnbFrTnusnXnfhbbL7uII4y25Q/RHWnar1SDKw==
X-Received: by 2002:a05:6359:459d:b0:176:c1e1:7556 with SMTP id
 no29-20020a056359459d00b00176c1e17556mr8958927rwb.0.1706611694478; 
 Tue, 30 Jan 2024 02:48:14 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 ld10-20020a056a004f8a00b006ddce8e110bsm7448000pfb.128.2024.01.30.02.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 02:48:14 -0800 (PST)
Date: Tue, 30 Jan 2024 18:48:04 +0800
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Subject: Re: [PULL 06/15] tests/qtest/migration: Don't use -cpu max for aarch64
Message-ID: <ZbjT5OYpzNJjkMw9@x1n>
References: <20240126041725.124562-1-peterx@redhat.com>
 <20240126041725.124562-7-peterx@redhat.com>
 <87le8c6u1d.fsf@suse.de>
 <CAFEAcA-x4WqvPsN-KZOA3SPN0F=vvYi=NFZ2qom2iT7-CN0RSg@mail.gmail.com>
 <87il3g6t7b.fsf@suse.de> <ZbcSqyGNLGu7ugBb@x1n>
 <87sf2ge3qu.fsf@suse.de> <87y1c7ogze.fsf@suse.de>
 <CAFEAcA_BPf4LSh-JF1NVVVdaLoKgUcsnGeP7sHt-f73r4zyh7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_BPf4LSh-JF1NVVVdaLoKgUcsnGeP7sHt-f73r4zyh7g@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jan 30, 2024 at 10:18:07AM +0000, Peter Maydell wrote:
> On Mon, 29 Jan 2024 at 23:31, Fabiano Rosas <farosas@suse.de> wrote:
> >
> > Fabiano Rosas <farosas@suse.de> writes:
> >
> > > Peter Xu <peterx@redhat.com> writes:
> > >
> > >> On Fri, Jan 26, 2024 at 11:54:32AM -0300, Fabiano Rosas wrote:
> > > The issue that occurs to me now is that 'cpu host' will not work with
> > > TCG. We might actually need to go poking /dev/kvm for this to work.
> >
> > Nevermind this last part. There's not going to be a scenario where we
> > build with CONFIG_KVM, but run in an environment that does not support
> > KVM.
> 
> Yes, there is. We'll build with CONFIG_KVM on any aarch64 host,
> but that doesn't imply that the user running the build and
> test has permissions for /dev/kvm.

I'm actually pretty confused on why this would be a problem even for
neoverse-n1: can we just try to use KVM, if it fails then use TCG?
Something like:

  (construct qemu cmdline)
  ..
#ifdef CONFIG_KVM
  "-accel kvm "
#endif
  "-accel tcg "
  ..

?

IIUC if we specify two "-accel", we'll try the first, then if failed then
the 2nd?

-- 
Peter Xu


