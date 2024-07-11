Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC6EDC3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 19:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRzaz-00076q-3s; Thu, 11 Jul 2024 15:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRzay-00076L-1s
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 15:36:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRzaw-0005bH-2X
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 15:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720726604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Df/MuKUcoERlt6Uy5SVzdhorEuzI7UjhOeklVPZs+n8=;
 b=IfeJHzw7PRApykHuPd3SnzZi3/BMuKfn16b3j74TfEkbEDvvw2jnXSEy3rWWYPGdqlV9hJ
 Ud4VGzm8HbRz/JZ8nAM7o/6JIg2GKdDokg6vVQjoDcetyz6fNGudCEwhrFv08GYSBtDlHE
 G8ojCCBkKqbf7KbS+Wu5FNjnwUhuwzQ=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-MD3up6IvPV-DrC9s0WQhlQ-1; Thu, 11 Jul 2024 15:36:41 -0400
X-MC-Unique: MD3up6IvPV-DrC9s0WQhlQ-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3d8546c138fso150177b6e.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 12:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720726600; x=1721331400;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Df/MuKUcoERlt6Uy5SVzdhorEuzI7UjhOeklVPZs+n8=;
 b=v7GanNUC3b/PgOvM7NOBHx7qTR7CNXzDq2bMy1hEYrFW6y74GOt0JKHdMn+jkRMjEp
 LqhrvEXT11Vw6RS4R7rGDd2ARtt0kvfVj2h/DKKODFSXKa8GADg2y1glDE8sQMF3kjQN
 ZDz6Zx4ETLf7pIczR8Y7FJimzsiRL+bYp4z3/IZoaizcBW+upsX/Z3W/gPE5/p6aftRz
 34wqo4OXj4Ag4HCNK2qLY+yrNZ0rsKok2HOFmzKVRvFQzrvb+apiWpV87/YG3TOSATgz
 hI5i34wPgVQUkYtUlWUH9mZ3b7T906j0BB+dP6/rCvjDeEBtC4cIg/R5EaDE+10QstZG
 Gy8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPA75z/rrBvyPLEWhpsTOIWzJ2OhdD48jLAFT7SVaFgGM4UZnxItd3Qlb/Ua9kQGSPcvfzqDzq2iBNplCmYSSeH4L8s9c=
X-Gm-Message-State: AOJu0YxrDQ68okzH9DTdQ5Wmo4E6Owz0MoTO9EfdTQMeYOgzhCN4Qwwo
 Fb/tq1peRESuh0Anumr2A/zTyIXF/2C0qCNRdaHFq4VTmPE5On3M65J6ltBQTN+DqTpFPNjwAmA
 Jc2QpINfzpunsM4384rSqVDv54OcF9GL4bdvHCh9ZEsX6EbO8qBTd
X-Received: by 2002:a05:6808:1391:b0:3d9:3521:afe9 with SMTP id
 5614622812f47-3daa0d6f50cmr3281250b6e.5.1720726600489; 
 Thu, 11 Jul 2024 12:36:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/xyZvPt7fcQrs18AwytpTSrhvSq3snMXgNDG9Qp4PRCIg65G5Q2zP/WC5l2ZnT3y4EpfaKA==
X-Received: by 2002:a05:6808:1391:b0:3d9:3521:afe9 with SMTP id
 5614622812f47-3daa0d6f50cmr3281237b6e.5.1720726600177; 
 Thu, 11 Jul 2024 12:36:40 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79f190b2fa9sm322395085a.127.2024.07.11.12.36.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 12:36:39 -0700 (PDT)
Date: Thu, 11 Jul 2024 15:36:36 -0400
From: Peter Xu <peterx@redhat.com>
To: Yichen Wang <yichen.wang@bytedance.com>
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Subject: Re: [External] Re: [PATCH v5 0/5] Implement QATzip compression method
Message-ID: <ZpA0RBfDTkZlT0A2@x1n>
References: <20240711025229.66260-1-yichen.wang@bytedance.com>
 <Zo_98z3zmbDM1H40@x1n>
 <CAHObMVYkwyNHSsQuN_bQKSrM4SvwPW1NU_G0Xvs3GD_LTy=7=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHObMVYkwyNHSsQuN_bQKSrM4SvwPW1NU_G0Xvs3GD_LTy=7=A@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On Thu, Jul 11, 2024 at 09:48:02AM -0700, Yichen Wang wrote:
> On Thu, Jul 11, 2024 at 8:45 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Wed, Jul 10, 2024 at 07:52:24PM -0700, Yichen Wang wrote:
> > > v5:
> > > - Rebase changes on top of 59084feb256c617063e0dbe7e64821ae8852d7cf
> > > - Add documentations about migration with qatzip accerlation
> > > - Remove multifd-qatzip-sw-fallback option
> >
> > I think Yuan provided quite a few meaningful comments, did you address all
> > of them?
> Yes. I do.
> >
> > You didn't reply in the previous version, and you didn't add anything in
> > the changelog.  I suggest you at least do one of them in the future so that
> > reviewers can understand what happen.
> They are all very good comments, and instead of replying I just fix
> them all and include it in my next patch. In my changelog I do include
> all the changes and comments we discussed in v4. Sorry I am new to the
> community, so I will reply "fixed" in the previous email before
> pushing the next version. Thanks a lot, and sorry for that.

That's all fine!  You can definitely mention them too here in the changelog
if you think that's easier.

One last nitpick is in the major patch you duplicated part of the comment
when I was requesting a movement (the part explaining why you used a buffer
rather than submit compression for each page without memcpy), I suggest you
can simply move that whole comment above, rather than copying.

I don't have any further questions on this series.

Thanks,

-- 
Peter Xu


