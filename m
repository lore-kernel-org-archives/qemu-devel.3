Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2302FD877E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 14:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2VLE-0003ZJ-9X; Tue, 17 Mar 2026 10:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2VLC-0003Yy-L6
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 10:24:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2VLB-0003Uy-06
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 10:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773757452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4HN12nOb629dL33L2EMtlB4agnyhEyUv71NyBFtHjnE=;
 b=dXw89mW+lKw2uA9yc8bgq1qIDroYCFJsxZgir/5dkuhxCUvEZHRFSUArHB0CSG7DCtieiY
 66Gya9MID6tyuu++kPquW/G5j6hXLEPQQjqqLEC/Oe4AaHJcN2cvNtHMnxxd6AS3YmkoMT
 Y8JJ5l8lcUmd2p1DxZsU81MbJOt3qB8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-2OKzpAGXOeW6Fi1RxvOWNg-1; Tue, 17 Mar 2026 10:24:10 -0400
X-MC-Unique: 2OKzpAGXOeW6Fi1RxvOWNg-1
X-Mimecast-MFC-AGG-ID: 2OKzpAGXOeW6Fi1RxvOWNg_1773757450
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5093b19111fso426986901cf.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 07:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773757450; x=1774362250; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4HN12nOb629dL33L2EMtlB4agnyhEyUv71NyBFtHjnE=;
 b=or5XF4TBfZ6HHcZSyVL9oFiNeShZmtbPzJCXhvjl7oYAHiuwAlS0xwoBb2J/E/XPkY
 5WbarbKBGkjbJrLauMWY7CLCN51EF7eeyAJpKu6HPOT1WFYNj5xZ4/NXHHUF1LGPjbIk
 LTF9yhT1Kc2VJyUegEup6CA8PExPbQ8vH/f8t6REICmvrcJTp9ADDrwz+CRKV+mmPudS
 3K/RPkOZe/gNVwdTcTOmU/GV8PiQshOfJ9akWGMoUAwAIRGm+e5EJyDZq8WXrRsN2poy
 BHgA2vsx5OTVANgIlc15L8HaIkMz8VqqbfvJEE1QyKNa/t8ErDHGuWtB8tB/qyOEYDir
 CtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773757450; x=1774362250;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4HN12nOb629dL33L2EMtlB4agnyhEyUv71NyBFtHjnE=;
 b=TcD0eQYkEeSDbsJMvIPfsVe2vjZhbfk3K/B8c0p8ERJYqmMC4a3Z/QbmTQwqg7Z0Qn
 HhENC4bgp6ysVLKDjoocjYl/0GDSavs7ll90A/miRbqVR8YPaer9XSTyTngoRtDx0Ob0
 ArOtnHjxVjHgM8BugdYCgLBEDzqQrbtbHGQj8Wp62FVde14wMFDrHqimdogE3I7DLT85
 vdpf9WPTiFM0wqAOl9Ck9Sz0nr+Xg+WbRShM8i4Ii3vzJ88gOu4F8h4GlE3vcrRqBdV2
 9c0bsGXxkRBFH9eTUE+CAzoAqCbO06LvAKLmEmBnnEx3n4xczOqsR1ozSzH5MnxbYzk6
 udrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPSRLmN6on1WTNZlj3Mef7ud7Cg1/nZWrp5ZTdz47HC6SKe5wWpzq5Ck21x9LU8wGUgRLfumwosILA@nongnu.org
X-Gm-Message-State: AOJu0Yx1lQVtQPdITeX9Umde6gXYOaMkcmvSLBEgiS9zjEvD7k+g3L5g
 oUsL/t52LLQe8ys++hPJbCEiE9OvV2NWSMCs0rQmQJDY+4GpMB9qFQtTNrB58cvw+LXxPXBrWVI
 K9Q1ff/Yf2YfRq+NuqjXmWFPPC7ywyYPufzAV5X0uI7yOPtv9fSMxpxsv
X-Gm-Gg: ATEYQzwqpe5GUyIPNxnZvC3wX9Yv2FjZneMeGzGIXDezJ1jqHpkcNFIdYSSTv6mOord
 Q2bMeXZ8Pn23La2EyhSuUJ9nUP9oT+Wer6eXGnqogbsIRIF0Brmp2o0scMQGyDeGzGDfXtogEtg
 BLS5/1UQC8P8ZODfmmSdKBzOtFFPLkbYlUcxKWQI4RSVqS37ZngqT5g6tAK0lLPXK06xwHaETUj
 5fSjJEtioiZeeSrOENQzP4noc35AzxKmDwtWsshxc9xba73qRI/bw6+donxCrbplw7QtWwMSMzi
 qPMxGP1gtpcn3+e2EWznF+ZmQa4gmomk8EgRRtTM35wZr95U4z2g5N9CIsL2igmQknFDjIDf8Uk
 pE0OPt5K8jzaSkQ==
X-Received: by 2002:a05:622a:1ba6:b0:509:238f:ad92 with SMTP id
 d75a77b69052e-50957db172emr223517691cf.24.1773757450098; 
 Tue, 17 Mar 2026 07:24:10 -0700 (PDT)
X-Received: by 2002:a05:622a:1ba6:b0:509:238f:ad92 with SMTP id
 d75a77b69052e-50957db172emr223517031cf.24.1773757449538; 
 Tue, 17 Mar 2026 07:24:09 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50939e8e14esm136952251cf.6.2026.03.17.07.24.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 07:24:09 -0700 (PDT)
Date: Tue, 17 Mar 2026 10:24:08 -0400
From: Peter Xu <peterx@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] hw/display/tcx: Init memory regions in realize
Message-ID: <ablkCJNrVAWoA31s@x1.local>
References: <20260316130651.5C8735968DE@zero.eik.bme.hu>
 <abgqjKVFHKxuKupP@x1.local>
 <812f2a8d-f6bb-f127-a3f9-4629de5a03e5@eik.bme.hu>
 <abh2ZdpzQNepUTIy@x1.local>
 <ebd251c9-a1d1-4956-af11-ae9858e76254@eik.bme.hu>
 <afa7d52b-7087-4256-996a-b8ca7b2bfb95@redhat.com>
 <035415da-97a1-4929-8e7f-f982acd8d044@redhat.com>
 <3e9fddbc-2a2c-4163-09b2-8c29048bfc9e@eik.bme.hu>
 <a6e7e27c-5fe7-5451-d793-e746719014d8@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6e7e27c-5fe7-5451-d793-e746719014d8@eik.bme.hu>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

On Tue, Mar 17, 2026 at 11:24:16AM +0100, BALATON Zoltan wrote:
> On Tue, 17 Mar 2026, BALATON Zoltan wrote:
> > On Tue, 17 Mar 2026, Thomas Huth wrote:
> > > On 17/03/2026 06.41, Thomas Huth wrote:
> > > > On 16/03/2026 23.30, BALATON Zoltan wrote:
> > > > > On Mon, 16 Mar 2026, Peter Xu wrote:
> > > > > > On Mon, Mar 16, 2026 at 07:10:05PM +0100, BALATON Zoltan wrote:
> > > > > > > On Mon, 16 Mar 2026, Peter Xu wrote:
> > > > > > > > On Mon, Mar 16, 2026 at 02:06:51PM +0100, BALATON Zoltan wrote:
> > > > > > > > > Due to aux-ram-share property qemu_ram_alloc_internal dereferences
> > > > > > > > > current_machine which is not set during init when inspecting the
> > > > > > > > > device. This causes the qtest/device-introspect-test to fail since a
> > > > > > > > 
> > > > > > > > Does it has anything to do with aux-ram-share? 
> > > > > > > > I thought it's because the
> > > > > > > > qom introspect test will create yet another
> > > > > > > > sun-tcx device, causing double
> > > > > > > > registration?
> > > > > > > 
> > > > > > > I could reproduce it like this:
> > > > > > 
> > > > > > I would treat this one a separate bug, because it
> > > > > > doesn't look special to
> > > > > > sparc systems.
> > > > > 
> > > > > I thought this is the issue Thomas has reported. I found
> > > > > this command by looking at what the test does but looks like
> > > > > this gets a different error but the fix is the same.
> > > > 
> > > > It's slightly different. The bug that I found via the device
> > > > introspection test is using "-M SS-20" and then it's crashing
> > > > when a second sun-tcx device is instantiated.
> > > > The bug that you found is crashing because using "-device
> > > > sun-tcx,help" instantiates the device for introspection before
> > > > the machine has been created, so code that dereferences
> > > > current_machine is running into a NULL pointer related
> > > > segmentation fault.
> > > 
> > > By the way, "qemu-system-sparc -device cgthree,help" crashes in the
> > > same way.
> > 
> > OK, I'll send a v2 fixing that and updating the commit message to
> > mention both issues.
> 
> Looks like you were faster, Then I won't do it.

Note that I've queued this patch with amended commit message.  If anyone
thinks I should drop it please say so.. otherwise I'll keep it to make sure
it is fixed in 11.0 (as it fixes a qtest failure introduced in the previous
mem pull).

Thanks,

-- 
Peter Xu


