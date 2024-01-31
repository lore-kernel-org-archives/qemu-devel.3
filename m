Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FF9C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 09:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV6ui-0006md-31; Wed, 31 Jan 2024 04:29:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rV6ue-0006mG-5N
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 04:29:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rV6uY-0000Io-W5
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 04:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706693376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j5BgPZB3DcHE5xi3YsK0Kp2E7kwJsLWXuW/xZHvP6Fc=;
 b=hhjNd7hm+5pgly01G3kAjpx+SofRJGkL4ABBPhA6EJoN2RwGTpZMVS0qbW1vImhceak7W1
 4Vc6bzxBQ4psJq9pnoXDtA1B/YXfyxJWCfwgz8pIJWdEmCulDzSox9hDwfqUHhoyV4EbrM
 8XzWX30MCunpRWOoWgWZ7/vAtc1kiiE=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-v0DjqaHDO16jnYcSNCdbZQ-1; Wed, 31 Jan 2024 04:29:35 -0500
X-MC-Unique: v0DjqaHDO16jnYcSNCdbZQ-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5c683944ab0so1368771a12.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 01:29:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706693374; x=1707298174;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j5BgPZB3DcHE5xi3YsK0Kp2E7kwJsLWXuW/xZHvP6Fc=;
 b=weOrs4a6rCAuL81+g8W0xsauRMc4dxxEGWxSRB2Pqm+ssWoRkPBnx4Qc+qzNxM8sMd
 XvMB1c7YcnlYEXS4NSZ+liU0UgmOrRuk8dc1FDkv3+36Nlogxb/HNmahbl0VF7UXbusG
 WQEyTcoaE0fyhahAW0T1aBtsAgLv1acJTbCmnsMVfKvnLnR1LYHUNrNNL5eck1Kcvt1l
 UqXSTkULd3UFUTi6nwf0SgFmVPKmRTV11D5cD0rlabAczFhy5kf1aHFX5ma6HO1YPUzX
 PcKopndNLZ+hzMe2w16REhnrrgt97P0xYTou+yG21E4colGNjXrMrvUujY+MPkgs2DUP
 vJeQ==
X-Gm-Message-State: AOJu0YyeCaIH4JYZPLCE6z9XzUgXpvexxSZEhYfmf3Nk20suL8jKeefj
 nBKuB0zRVpMj5m90KSzc7KwDEWpp1AqQL3EJIcx68S3lRET98cZFgRlYzrC9lzGu0XkMXCDeSMD
 FjolNm6l3QRPQp6BzNu70s/ZlT50I1uigI+9/5DR1B57arlabnOXq
X-Received: by 2002:a05:6a20:6a1c:b0:19c:9da4:dc9e with SMTP id
 p28-20020a056a206a1c00b0019c9da4dc9emr1148171pzk.1.1706693374415; 
 Wed, 31 Jan 2024 01:29:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGk9K2eLNRWFpW2Oma/iKuosy3ecUSB48GkRzzxedObcaP0CtY2WwuLX9yGQDMWBo8KNBI2ag==
X-Received: by 2002:a05:6a20:6a1c:b0:19c:9da4:dc9e with SMTP id
 p28-20020a056a206a1c00b0019c9da4dc9emr1148156pzk.1.1706693374030; 
 Wed, 31 Jan 2024 01:29:34 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 ph11-20020a17090b3bcb00b00295f1aa0a68sm471086pjb.7.2024.01.31.01.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 01:29:33 -0800 (PST)
Date: Wed, 31 Jan 2024 17:29:24 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: "Liu, Yuan1" <yuan1.liu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Hao Xiang <hao.xiang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: Re: [PATCH 0/5] migration/multifd: Prerequisite cleanups for ongoing
 work
Message-ID: <ZboS9CPIuxIc9PTf@x1n>
References: <20240126221943.26628-1-farosas@suse.de>
 <PH7PR11MB5941BDAB9743C53A9E08CC3CA37E2@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZbdVhLTLo5udNfeL@x1n> <87jznse211.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jznse211.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
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

On Mon, Jan 29, 2024 at 09:51:06AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Jan 29, 2024 at 01:41:01AM +0000, Liu, Yuan1 wrote:
> >> Because this change has an impact on the previous live migration 
> >> With IAA Patch, does the submission of the next version needs 
> >> to be submitted based on this change?
> >
> > I'd say hold off a little while until we're more certain on the planned
> > interface changes, to avoid you rebase your code back and forth; unless
> > you're pretty confident that this will be the right approach.
> >
> > I apologize on not having looked at any of the QAT/IAA compression / zero
> > detection series posted on the list; I do plan to read them very soon too
> > after Fabiano.  So I may not have a complete full picture here yet, please
> > bare with me.
> >
> > If this series is trying to provide a base ground for all the efforts,
> > it'll be great if we can thoroughly discuss here and settle an approach
> > soon that will satisfy everyone.
> 
> Just a summary if it helps:
> 
> For compression work (IAA/QPL, QAT) the discussion is around having a
> new "compression acceleration" option that enables the accelerators and
> is complementary to the existing zlib compression method. We'd choose
> those automatically based on availability and we'd make HW accelerated
> compression produce a stream that is compatible with QEMU's zlib stream
> so we could migrate between solutions.
> 
> For zero page work and zero page acceleration (DSA), the question is how
> to fit zero page detection into multifd and whether we need a new hook
> multifd_ops->zero_page_detect() (or similar) to allow client code to
> provide it's own zero page detection methods. My worry here is that
> teaching multifd to recognize zero pages is one more coupling to the
> "pages" data type. Ideallly we'd find a way to include that operation as
> a prepare() responsibility and the client code would deal with it.

Thanks Fabiano.

Since I'm preparing the old series to post for some fundamental cleanups
around multifd, and when I'm looking around the code, I noticed that
_maybe_ it'll also be eaiser to apply such a series if we can cleanup more
things then move towards a clean base to add more accelerators.

I agree many ideas in your this series, but I may address it slightly
different (e.g., I want to avoid send(), but you can consider that in the
fixed-ram series instead), also it'll be after some other cleanup I plan to
give a stab at which is not yet covered in this series.  I hope I can add
your "Co-developed-by" in some of the patches there.  If you haven't spend
more time on new version of this series, please wait 1-2 days so I can post
my thoughts.

-- 
Peter Xu


