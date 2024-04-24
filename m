Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402E9C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 17:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzgAf-0007Ef-16; Wed, 24 Apr 2024 13:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rzgAa-0007EH-Nm
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:12:33 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rzgAZ-0005vI-3k
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:12:32 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6eced6fd98aso160141b3a.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 10:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713978749; x=1714583549; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PJx7B4fgRPYu09r5fjNBdBPXGt14luISrtxZ4rM/dAA=;
 b=EiBeZV38NtHjBjzR1F1qAuVroX91pdasNWiBkLQutHQCogznp+57ZWTEgeWoBHyXF2
 pQdPQ0ItTwQQKsXVyAzpY3+0JUkCDURMWGl3BYiYjDSdqJlx4QNJyei4XIKDR30YcP6G
 7lbIpIHgpNDdLGHA9YlYQ5oFDIZM4R/73AXaTAVwXl8Lf1WtG6usr6Q8y+dUgur1Hah5
 SuntEikda4+yvzrL7+RGqiTFfKb12RIb3qS9EhkgCFgweYo1Ui2XoQzRpxsqhYX7GQsL
 chdqsCxiHcMnxpFoBA8ZFSGVcMEFlMLKqEaFfd96u9mS80CLncICjvc7s843isjEQyTO
 ZhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713978749; x=1714583549;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PJx7B4fgRPYu09r5fjNBdBPXGt14luISrtxZ4rM/dAA=;
 b=GzaEvxJB/RphWC1gc/OWX60BFkVh+y8TWmtg1CbO3gH8Gg8zQ8AduvJlGEKuacSh2t
 DI5vNGLRe6ibM7DwZEDP7ozxmGQwTXpHbAgUYtrU5GLzZRWUjdJudj3LQb1fKeQ9JItD
 YbviqoEYCoCsNhsM0MJQD8aCn6Fl+bQMk7UHUhF0Qu5R9nHNH1ZmzjCQOdiCsch31kcK
 mRDYcmAfITrkQNPIlOy+SgX6bG11xmFi35fy5I9WPGDK3SNC91mSZUXKy1enILRB0JDj
 azMq6JmqUT/7RFPfr9r4qEVQK383HhLjrFGxi4XIPW+DRTi47QA8fBIlqzH2lIUyuTf3
 hOzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSArUHxD9dvJQpH2TmWqW+n0WHJ7vPz+ReCAWpfWX8x7Ld5E3+UAeQy4t/omtbHHi9GdkFJiSC4Ck7SVETzFOrEsb2S7w=
X-Gm-Message-State: AOJu0Yyf1oL8oG5giiPrtAcF9xCOmfoachv3jFiSKRWKEVbMIUcx7XkA
 MQLlga1eoIr8poVbtEr0xds2yxoqHvjKIWPEZN+IF3rMl4mHLXI1
X-Google-Smtp-Source: AGHT+IEIE1XN1WJXhjD/39WDyRmROHsSznUnr2Qdm0ZdIYmjrfNZpwKAz0Ik5fOx2a0ZGv6qGRjxCw==
X-Received: by 2002:a05:6a20:244d:b0:1a9:11e4:72b6 with SMTP id
 t13-20020a056a20244d00b001a911e472b6mr4112692pzc.57.1713978748469; 
 Wed, 24 Apr 2024 10:12:28 -0700 (PDT)
Received: from debian ([2601:641:300:14de:b318:9476:706a:e82a])
 by smtp.gmail.com with ESMTPSA id
 b1-20020a170902d30100b001e451abffebsm12157336plc.86.2024.04.24.10.12.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 10:12:28 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Apr 2024 10:12:23 -0700
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 fan <nifan.cxl@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com,
 jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
 Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 13/13] qapi/cxl.json: Add QMP interfaces to print out
 accepted and pending DC extents
Message-ID: <Zik9dxGopfrifCzU@debian>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-14-nifan.cxl@gmail.com>
 <20240305160908.000010c5@Huawei.com> <ZedFIp5gK4aXsqD-@redhat.com>
 <ZedRsZee2WhTi_Nd@debian> <ZedTEa8aktb-kKwt@redhat.com>
 <8734ravr99.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8734ravr99.fsf@pond.sub.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Apr 24, 2024 at 03:12:34PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Tue, Mar 05, 2024 at 09:09:05AM -0800, fan wrote:
> >> On Tue, Mar 05, 2024 at 04:15:30PM +0000, Daniel P. Berrangé wrote:
> >> > On Tue, Mar 05, 2024 at 04:09:08PM +0000, Jonathan Cameron via wrote:
> >> > > On Mon,  4 Mar 2024 11:34:08 -0800
> >> > > nifan.cxl@gmail.com wrote:
> >> > > 
> >> > > > From: Fan Ni <fan.ni@samsung.com>
> >> > > > 
> >> > > > With the change, we add the following two QMP interfaces to print out
> >> > > > extents information in the device,
> >> > > > 1. cxl-display-accepted-dc-extents: print out the accepted DC extents in
> >> > > >    the device;
> >> > > > 2. cxl-display-pending-to-add-dc-extents: print out the pending-to-add
> >> > > >    DC extents in the device;
> >> > > > The output is appended to a file passed to the command and by default
> >> > > > it is /tmp/dc-extent.txt.
> >> > > Hi Fan,
> >> > > 
> >> > > Is there precedence for this sort of logging to a file from a qmp
> >> > > command?  I can see something like this being useful.
> >> > 
> >> > This is pretty unusual.
> >> 
> >> Yeah. I cannot find anything similar in existing code, my initial plan
> >> was to print out to the screen directly, however, cannot find out how to
> >> do it nicely, so decided to go with a file. 
> >> 
> >> Is there a reason why we do not want to go with this approach?
> >> 
> >> > 
> >> > For runtime debugging information our strong preference is to integrate
> >> > 'trace' probes throughout the code:
> >> > 
> >> >   https://www.qemu.org/docs/master/devel/tracing.html#tracing
> >> 
> >> I am not familiar with the trace mechanism. However, I think the
> >> approach in this patch may be useful not only for debugging purpose.
> >> Although not tried yet, maybe we can also use the approach to set
> >> some parameters at runtime like what procfs does?
> >
> > Please don't invent something new unless you can show why QEMU's existing
> > tracing system isn't sufficiently good for the problem. QEMU's tracing
> > can dump to the terminal directly, or integrate with a variety of other
> > backends, and data can be turned off/on at runtime per-trace point.
> 
> Seconded.
> 

Thanks. 
This patch is removed from the latest version (v7):
https://lore.kernel.org/linux-cxl/ZiaFYUB6FC9NR7W4@memverge.com/T/#t

Fan

