Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F4FC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 21:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjnMJ-00083T-BC; Mon, 11 Mar 2024 17:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjnMG-00083F-MT
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:38:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjnME-0000gx-LD
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710193133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BeqaI/RCyv/smkfXMWXGSdkGTYvUsOJ9HlQ2OeHEgc0=;
 b=Ld0y4lPkKK2UhWqjAJv5cQuY4Z5WPXWem0ObYBjFMzjwqg8Pwj8GpxItG5K5MEdJMzRleG
 MN86mqE4G5awXRuRx6RrCHyoTnP2QzOF2DgN2vgkFJ+RoAT4mAON5kFj1lOoJSGl7HLb18
 7VhWaiWhpHQpzOvqaKyuwMAK0Xyxdm0=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586--TAmvr1rO22kc8DNv7Ks0A-1; Mon, 11 Mar 2024 17:38:52 -0400
X-MC-Unique: -TAmvr1rO22kc8DNv7Ks0A-1
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-7dc03020e3bso260458241.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 14:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710193132; x=1710797932;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BeqaI/RCyv/smkfXMWXGSdkGTYvUsOJ9HlQ2OeHEgc0=;
 b=utx+ZQV0h/cWhV5gJIHgY7eCFY2+ogF/vpKYXsSWel/9RK9epND+ZQBTiCsveaW3sA
 zMONQxDUp87O4Ch6lU3+FIBCtQluCNGM7BlNdcEK1ZqHpTVi2dztEaAzK2qBgMwMr/pG
 yh3BfMKWt9TDJX9IenKLRqlAulLB2OyhagWoiGJdi/R48jAvz6/Al+vEIDUqBqFlfFFc
 /z9DfNi0tQnVjCVNjVm1xDlqbgWWHQikEEYZ3XqUWb9xzIwJaCwG4N4SZ6hVdTKV61rr
 9UvHaJdqnyTAt5WIvOlYWUGXZXu6HHzwh3CyFvq3tKoSc/8EPpDhP8+e/B0PVh3u/JjK
 REEA==
X-Gm-Message-State: AOJu0Yz5fXh3eOFEF7oTmFVjsEUOLaXsadCxxLDuWKP2D1CHyzYyGXVp
 djYR1VMNxQrarzuyoghnsMkuSuzrCWRcRZ1cHjkTnrDQt8SQJ5j1koqT4pzKnnAiCpEf+NXAmDv
 dsoq4F2kjb/2LU8WK6vJ6Hjr0uKCCGuyj1njsb6Wih+C1YSwkWXh8
X-Received: by 2002:a05:6102:4187:b0:472:e88d:6839 with SMTP id
 cd7-20020a056102418700b00472e88d6839mr4594778vsb.3.1710193131795; 
 Mon, 11 Mar 2024 14:38:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxYuFLTm1ndlW1mZrjS8c9pScuCs6ywZnSPyqGdwvlJ2fzK4bM2RY/lo26LHqJeDKir16d5g==
X-Received: by 2002:a05:6102:4187:b0:472:e88d:6839 with SMTP id
 cd7-20020a056102418700b00472e88d6839mr4594767vsb.3.1710193131354; 
 Mon, 11 Mar 2024 14:38:51 -0700 (PDT)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 ee17-20020a0562140a5100b00690bdad8097sm2977420qvb.106.2024.03.11.14.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 14:38:51 -0700 (PDT)
Date: Mon, 11 Mar 2024 17:38:49 -0400
From: Peter Xu <peterx@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH v4 0/8] qtest: migration: Add tests for introducing
 'channels' argument in migrate QAPIs
Message-ID: <Ze956ZixU-vaWPbM@x1n>
References: <20240308205951.111747-1-het.gala@nutanix.com>
 <1db9b780-a83d-4794-8ddd-1547615cdd9b@nutanix.com>
 <Ze920doZYn99aLCn@x1n>
 <66416dbd-9038-4762-b39a-9395b778ea56@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <66416dbd-9038-4762-b39a-9395b778ea56@nutanix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Mar 12, 2024 at 03:01:51AM +0530, Het Gala wrote:
> 
> On 12/03/24 2:55 am, Peter Xu wrote:
> > On Sat, Mar 09, 2024 at 01:11:45PM +0530, Het Gala wrote:
> > > Can find the reference to the githab pipeline (before patchset) :
> > > https://urldefense.proofpoint.com/v2/url?u=https-3A__gitlab.com_galahet_Qemu_-2D_pipelines_1207185095&d=DwIBaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=y2xUaOwvRVC5eTpFNEdxb37JYDdxN61W406HlCyx3CWIVyBRgLwjJhAYALZLinoi&s=vZRNX33_DuLO1TsfTpYR_s9bf_EMFm3oHHH_eg57zE0&e=
> > > 
> > > Can find the reference to the githab pipeline (after patchset) :
> > > https://urldefense.proofpoint.com/v2/url?u=https-3A__gitlab.com_galahet_Qemu_-2D_pipelines_1207183673&d=DwIBaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=y2xUaOwvRVC5eTpFNEdxb37JYDdxN61W406HlCyx3CWIVyBRgLwjJhAYALZLinoi&s=C73ka3k3ouAuRJYNVLPIBQiWx3jDFDDvVYDiEYqfE04&e=
> > Het,
> > 
> > Please still copy me for any migration patches.  In this case Fabiano is
> > looking it'll be all fine, but it will still help me on marking the emails.
> > 
> > Thanks,
> So sorry about that Peter. I am aware that you and Fabiano are the go to
> migration
> maintainers. I thought I emailed or cc'd all the stakeholders that should be
> involved
> for this patchset series. Even in earlier series of this patchset, you were
> cc'ed,
> but somehow I just forgot to cc you for this patchset. Sure, will take care
> from next
> time. Again apologies for the mixup :)

No problem at all.  As long as you have at least 1 maintainers copied,
logically nothing will get lost.  It's just that it helps me in the routines.

Are you managing cc list manually for each version?  In that case I suggest
you have a look at Stefan's tool:

https://github.com/stefanha/git-publish

It might help a great deal in patch managements at least to me, and it
definitely covers more than maintaining the cc list for a patchset.

-- 
Peter Xu


