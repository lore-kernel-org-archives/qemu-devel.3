Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73E6FF6E87
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 21:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2c90-0002iD-8T; Tue, 17 Mar 2026 17:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2c8y-0002f0-5W
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 17:40:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2c8v-0000Z9-Eb
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 17:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773783599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ondqLSEaD3OsayJjpMTUiLkpHD87aEx6XFqAAsB0HQw=;
 b=L0NZP2ms+7/ScV90xcTFG4xNYFwXHmQJKB28pGf1cXURgr5JhaEV6+rl57s/uro92/J0YH
 09hI/1tVajciwYT8lek/2DIlXSzZ/xp4fCDxH+bxXV6R7/jtCGoETOWi7bpSXA7fC8ON3V
 /fafGZM6fa3gE+8pasqFTPAvw9M6Fy0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-KbkyEZUTP_yY-Wk3ciIrYw-1; Tue, 17 Mar 2026 17:39:58 -0400
X-MC-Unique: KbkyEZUTP_yY-Wk3ciIrYw-1
X-Mimecast-MFC-AGG-ID: KbkyEZUTP_yY-Wk3ciIrYw_1773783597
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cd7774be64so3648263685a.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 14:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773783597; x=1774388397; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ondqLSEaD3OsayJjpMTUiLkpHD87aEx6XFqAAsB0HQw=;
 b=b9FMru3rQ/A6mJ0Ep+q1wGuuqdvQUtcF9hOttDYiwrFaKom3Q5Tq6oEPUuoIzUCtLx
 A+s4KoyX1OPbmMOChW14qkyyqcIbfs8E/KBZ+77mM2n3lBjpzsiZXXY4NMipCbPR2mDy
 sEu5B2Z0SP6SE66uGAngkvcxHylfYS3vJ3LAfTdX88js/PuW8my8F++xmsIuTeqgjo2p
 3j/Amy+dUWN8FbzSGgCibw5Ctv21HGhrc8PthV3DgBrBxWn1NtfOt4JZfRD9PvhD5Z/3
 Yy43NgKqANkT36VwDU2a5TeWl4Js4RMemSXmA6mDM+Pkd+bzAuH8FHUlqr7mEltehR93
 hzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773783597; x=1774388397;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ondqLSEaD3OsayJjpMTUiLkpHD87aEx6XFqAAsB0HQw=;
 b=T89QrmCqeWDqcxN/ZRGkiszG6LGBOcIcJustXpYIM1RSMGy1hlThH2+Exy4a+tYNV2
 hnxwFFdMl8D/GBBdY6BZcPhgmGt7p56gsnxyvnJTSPE+dC/KyMJXYC3lqQ1mTbUbUi8c
 lgYBxj/G2oZIsjhZkXedrIApIZyfeeahmQMg5WP+nRzY+nBWjxDiVWaW37DFDMqpl0jG
 DnrRhj9aaNd/qDli9+3kNiRvobKfCGgLf7Tlpu67ED1JMO3OvDgMUTXPa8wzQtJTHRDJ
 yU1/Dum2/NxFi+TAR3zuZhms3v64Fx1x17jIQeO2eHQNwekNDy8bwVJdF+eWjnEV7i/p
 7A8A==
X-Gm-Message-State: AOJu0YzgfexSanmL6WLmYLk+2wtnQOlMB3YIgKD47iLmvCbPmLDbtdRi
 u8/9Y6dAfDplqKrObhONtQgHiJdwcWbbjU+ADah9IvTlXcs0aI2NJ5N0nK2CH5WU3tI7IYKz0E4
 SAMOwcLd9dIHpfH9zYyjAGkaLbq69tjWsmu1Vzn7+n67qOy0u6ibV4ule
X-Gm-Gg: ATEYQzwBHQ/UQ29mkHC6wLKqW59ya3zg8+NIY5J5PKOZhYo+KenzhqDP0uF/jJzEH5R
 Xn1yEOvbLRykBiR0HMT8xdPawY3u/onuIgkSIw40vZdMy6x6sjkZdel2dLRsBZ3hvQtCA/J55b6
 AZ7wPVf2Gi7hJLvkhuzk0b8SVPxUcuu5bhklFr0YHfrXH2GxBO2eAz+97lWjAPJY+ZxuyCRRGNZ
 uxXiCc+5wAiLdgi8HXt6xhcI5B5TfEFn3Iqb/IJgnYiMLOFccj2OCV1ka1QrJTYWviCLc9shvIf
 7PVsYnBUdKSfryV4PIZ5FyH6+NPfWSFjUPw49lT2q2y3Bd5SEOz2T4kpV+gggfNx6x/vmY94d39
 MVoJZxCFk1aQ7xg==
X-Received: by 2002:a05:620a:4108:b0:8cd:96e5:f7be with SMTP id
 af79cd13be357-8cfad3ae02fmr167020085a.69.1773783597472; 
 Tue, 17 Mar 2026 14:39:57 -0700 (PDT)
X-Received: by 2002:a05:620a:4108:b0:8cd:96e5:f7be with SMTP id
 af79cd13be357-8cfad3ae02fmr167014685a.69.1773783596938; 
 Tue, 17 Mar 2026 14:39:56 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cfacde286bsm71691985a.14.2026.03.17.14.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 14:39:56 -0700 (PDT)
Date: Tue, 17 Mar 2026 17:39:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Jesper Devantier <foss@defmacro.it>, Klaus Jensen <its@irrelevant.dk>,
 =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@stgraber.org>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v5 2/8] migration: add
 VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT{8, 32}_ALLOC
Message-ID: <abnKKguESqlptJdp@x1.local>
References: <20260317102708.126725-1-alexander@mihalicyn.com>
 <20260317102708.126725-3-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260317102708.126725-3-alexander@mihalicyn.com>
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

On Tue, Mar 17, 2026 at 11:27:02AM +0100, Alexander Mikhalitsyn wrote:
> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> 
> Add VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT{8, 32}_ALLOC, which
> helps to save/restore a dynamic array of pointers to
> structures.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> v2:
> - added VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT8_ALLOC
> v4:
> - almost completely reworked, new flag VMS_ARRAY_OF_POINTER_ALLOW_NULL
>   was introduced as suggested by Peter
> v5:
> - rebased on top of https://lore.kernel.org/all/20260304212303.667141-1-vsementsov@yandex-team.ru/
> ---
>  include/migration/vmstate.h | 77 ++++++++++++++++++++++++++++++-
>  migration/savevm.c          | 26 +++++++++++
>  migration/vmstate-types.c   | 91 +++++++++++++++++++++++++++++++++++++
>  migration/vmstate.c         | 54 ++++++++++++++++++----
>  4 files changed, 236 insertions(+), 12 deletions(-)

Hi, Alexander,

Sorry for a late reply, I didn't reply to your previous version on patch 2
because I didn't yet get time to really review this patch. It took me some
time to figure out what's the best way to do this.  I still think it'll be
good to avoid introducing yet another info like what this patch did.  In
general, I want to see if we can reduce get()/put()/save()/load() rather
than adding more.

Meanwhile, there're small issues here and there I saw.

E.g. reusing ->start to cache the object size sounds too tricky.  I am
trying to figure out if we can always stick with ->size to store the object
size; I'll need some even pre-requisite patches though to convert some
existing VMS_ARRAY_OF_POINTER users to reserve the ->size field for that,
though.

The other thing is I had a gut feeling this patch may have issue on the
JSON blob dumped in the migration stream, via the JSONWriter* object passed
into vmstate_save_vmsd_v().

All these made me feel like I'd better go prepare some RFC patches, because
commenting will be too slow.

I'll likely send something very soon just to show what I meant, it'll be
good if you can have a look at that when it comes.

Thanks,

-- 
Peter Xu


