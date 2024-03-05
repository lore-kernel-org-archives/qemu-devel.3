Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F38CC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 17:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhYID-0000eS-4T; Tue, 05 Mar 2024 12:09:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rhYIB-0000eE-F6
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 12:09:27 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rhYI9-0006B9-Mr
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 12:09:27 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e5760eeb7aso4674807b3a.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 09:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709658564; x=1710263364; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RMyPSQNoZX6mCJEU1oJOANHIjsrabzXyzk2PurQx6yU=;
 b=PW2N4BtKUHFekYiIhYecm8B6qXGEnlOTMkpAL6OhzFPrDgOucGDItC2wU4YIxMlCVc
 V9c8d2eBuB41B9KrInZpzeiTsmGVxSKq2i9XYmyqChk3OTNFkE7iHaoTnE4lEpcKtMd+
 vCYEw5Ijg+vz69ILQD2zl1RC2ZpQzv3j3wcbPMc9/WHgbJbaiN88uYBHdms9RkWqQiaC
 GuekmOn/JPxOtdTEgQ1UDrlmkx3wCNpQJibSCbYNG7D5aul4Ay6jMBBQF5rVxo52iL+H
 kihr/jX5WS/nD4r5FyRKSqAakWHWJ0Z2EVd2aK4C+Ft15GHQbefHKs9+lh3S9RB+Eqyq
 67Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709658564; x=1710263364;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RMyPSQNoZX6mCJEU1oJOANHIjsrabzXyzk2PurQx6yU=;
 b=ATgdXiVq0iTxWZAfen9bqyElgmOez6vlh3shnhIfw12sYjvC5nNo8x+xqGAtsdOWcq
 P2i/aLMprK1rNyYSpKe4jkp3w+E7FbJYVFKXie79in7VB5DMtdoPmc/ljTSpMLcoS37d
 CmH1zorVNEFMIws9tPoAKVGLM7zuL3kY6oSSgRl5bRsqifsDf2uebpzuJ41OODOwZlHY
 d4Tcoh5H15FZH7bU7e+kMWZVsfGilXeNGmoDSfgs9UzQHdstU7RTpcVXn0k5MC5YYrvL
 BL2WaLJLwO+N8u+U9s60aoZ0GHsa1CHfsNh9zpSWfh0WPJcTLZe1OymF4nRHtD/wCZ9n
 X/Ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCU47V6lwBdrKzKdN/MoxSXZzxXHSjps2T7WuZHnLMGPQ9ERNogNFdCOdx6ARfsPvtfqOsfDmO+umbekajorTvdyta9cKro=
X-Gm-Message-State: AOJu0Yxwpuq5W93IhSnd6wSMmLTsgYYcx1+Fcz+lyygIoQA6GspLqXY2
 WlJG6LPzH39KWNYkPTILfiCvNskGqc95m7+heM+9P7zT5D+YKv9J
X-Google-Smtp-Source: AGHT+IGo9IutGEDzfw88MhEA1IBT1j5jFoOJfB77AyyqYzLqAchDwqAIZpHvJgOCb317KNKTV7WimA==
X-Received: by 2002:a05:6a00:2fd1:b0:6e5:d3b9:2d06 with SMTP id
 fn17-20020a056a002fd100b006e5d3b92d06mr11304820pfb.21.1709658563597; 
 Tue, 05 Mar 2024 09:09:23 -0800 (PST)
Received: from debian ([2601:641:300:14de:8dce:12ff:6983:289])
 by smtp.gmail.com with ESMTPSA id
 w8-20020a056a0014c800b006e622f9175asm3660646pfu.217.2024.03.05.09.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 09:09:23 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 5 Mar 2024 09:09:05 -0800
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, nifan.cxl@gmail.com,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com,
 jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
 Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 13/13] qapi/cxl.json: Add QMP interfaces to print out
 accepted and pending DC extents
Message-ID: <ZedRsZee2WhTi_Nd@debian>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-14-nifan.cxl@gmail.com>
 <20240305160908.000010c5@Huawei.com> <ZedFIp5gK4aXsqD-@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZedFIp5gK4aXsqD-@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Mar 05, 2024 at 04:15:30PM +0000, Daniel P. Berrangé wrote:
> On Tue, Mar 05, 2024 at 04:09:08PM +0000, Jonathan Cameron via wrote:
> > On Mon,  4 Mar 2024 11:34:08 -0800
> > nifan.cxl@gmail.com wrote:
> > 
> > > From: Fan Ni <fan.ni@samsung.com>
> > > 
> > > With the change, we add the following two QMP interfaces to print out
> > > extents information in the device,
> > > 1. cxl-display-accepted-dc-extents: print out the accepted DC extents in
> > >    the device;
> > > 2. cxl-display-pending-to-add-dc-extents: print out the pending-to-add
> > >    DC extents in the device;
> > > The output is appended to a file passed to the command and by default
> > > it is /tmp/dc-extent.txt.
> > Hi Fan,
> > 
> > Is there precedence for this sort of logging to a file from a qmp
> > command?  I can see something like this being useful.
> 
> This is pretty unusual.

Yeah. I cannot find anything similar in existing code, my initial plan
was to print out to the screen directly, however, cannot find out how to
do it nicely, so decided to go with a file. 

Is there a reason why we do not want to go with this approach?

> 
> For runtime debugging information our strong preference is to integrate
> 'trace' probes throughout the code:
> 
>   https://www.qemu.org/docs/master/devel/tracing.html#tracing

I am not familiar with the trace mechanism. However, I think the
approach in this patch may be useful not only for debugging purpose.
Although not tried yet, maybe we can also use the approach to set
some parameters at runtime like what procfs does?
Just a rough thought.

Fan


> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 

