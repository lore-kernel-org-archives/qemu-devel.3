Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298D4FCA16E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzfFB-0001y4-JB; Mon, 09 Mar 2026 14:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzfEv-0001wu-2g
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:22:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzfEq-0000zL-0z
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773080514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wZoqVQ9p1M4/FSeTynDH4kDE6l45iwPwO8kRNhzfePo=;
 b=WEljMeGY5Lg6HltUNm9wo09qZvc2evNoGKTA2vX6YIm+pDj2LgoDLOpA4mNENtRT61l8Br
 a1+NehiXOR4zuZtNU6Ec1ATm8po9a3fAFD/nbH+EbIj5HbXJsz9w5GXurw6E32iYdPseDi
 R37j0McWuiCig/fdLg8w9Cw8Tj94s9Q=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-PH5_BVIwPr6r_bS0b6m8ig-1; Mon, 09 Mar 2026 14:21:53 -0400
X-MC-Unique: PH5_BVIwPr6r_bS0b6m8ig-1
X-Mimecast-MFC-AGG-ID: PH5_BVIwPr6r_bS0b6m8ig_1773080513
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-89463017976so834960286d6.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 11:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773080513; x=1773685313; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wZoqVQ9p1M4/FSeTynDH4kDE6l45iwPwO8kRNhzfePo=;
 b=AZD9ePizd+BLWKcxAj3Vz7H0AU9mPXZhi950T4s6JP6C45GyxxOjRfS4cZm5gKSg3e
 fYpS09PRsMBOenHWMqKSWNTlMKOvMC62hao9unJR80LUJyWpUbdGO6bkjgNxi1edGROX
 Vi3VbsMGtXPCGXtaMq8tCICRQo3wxEqwUVG6Mh9Ltg5Z8n5188qB+VhqJuQuKfzdRDP8
 +dk+6ao6xZiiP66eu27g79O6lxI6EcUgyRzpeziFut+fz66ooo0m3dCatyTaYD+Lm1Ng
 b4uq4t5cpUk1j3O0ZJQYHR2BBPkGPre9STzqBLCpJeMHCcAlbi6TNTJ+OLvlLVL+jPd9
 mCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773080513; x=1773685313;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wZoqVQ9p1M4/FSeTynDH4kDE6l45iwPwO8kRNhzfePo=;
 b=xS+jMtGLkgOfdYVbZRxjUaeySc/Pfmvui1KyhiKwTJLU227R2cJKS8tXFZfuuvydY6
 KMUNW7a84BJuscvapdTurfWPGqgn1Egn947awyI4ReHiDSfiOHKhu44th9yGFaDPtUQA
 2Oc5Xz0umnO7sMbmaRVvq727E1IsvM6Sqog6bqAb6gmCLWSvfFmUNMyjLxlX5dgAYxOL
 c0CdhckOyTnmtzBCirJ5tcH6gv46swGV1GbBDDjx3Th1aG+jNlNvmEwlkt+dHTaynl+T
 Nu20JvQg+JvhkmDGn13T1ijJGv/rL/HeTziGz4eomUnT8/lXUxqZDDgWzKgHZiSINebw
 vuig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLwcirAKkdpqnlcwalMrQclLoIqu/ZDGA9POju42ChDJGavkU/eR6rWtquxod7flh+6cZKa0uZ9qhq@nongnu.org
X-Gm-Message-State: AOJu0YyXy1cF//tyuUSTSvkAWitgiCrbu1wwAfp/pa0sY9U9nqDYypXK
 3lbKOlYpsLwg1KoKy5P37XWUdwf3zrkYbSup+edO8GCa3rHsWxXMEzgFEHul/YzBYnYRV2ZSyaU
 X60FwJshqgwHbrbZGuMGC2AB+yNTmRqtPMCdNyGftzlECztz3sDPZHa7o
X-Gm-Gg: ATEYQzyvSeEMxrqU6A6t0F2LWLQBRFiX6LXnIfXeDK9ruOnKpMUncqhXgbLP7kDC1Ol
 2Fx5DjILF3BDvUnKmwMnfzRD5kd6d1LmUNeIOJcQq9iY6+XKcBOXeNMWZbgWf7xb9UThBJ3683C
 Y5vMhRmVqlMhpseOnorLmAoRKv7clZtHBmrxrGZRTJT1VgEv6HoUVBmf7hM5KuADfL3Dh2Lb5/J
 DPRbdT9A/f9EzrupPNEfI7TiMpMKtL7LLyoQ19jkoEys5oFS39i7IyW0ew7CMZZcfEDkKWwbvnN
 2+Xw9evmGPQOFm4OeGyxtfgZXpxuxjXi/0eQGDtFxTV1sMRs9cZtca9vp1hdg8mBPhHuTRGODvK
 qE6+NWzk5MFjZ4KTon+yX8sX2CVlh3yEQhoLsmsO/Zp/Zj6k0h/L35fQ8FCwlssW/5wy6pRJIsl
 4ZapCYDw==
X-Received: by 2002:a05:6214:242a:b0:899:e621:eac8 with SMTP id
 6a1803df08f44-89a30ad1c83mr178024986d6.39.1773080512931; 
 Mon, 09 Mar 2026 11:21:52 -0700 (PDT)
X-Received: by 2002:a05:6214:242a:b0:899:e621:eac8 with SMTP id
 6a1803df08f44-89a30ad1c83mr178024496d6.39.1773080512257; 
 Mon, 09 Mar 2026 11:21:52 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a57c31483sm2917326d6.44.2026.03.09.11.21.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 11:21:51 -0700 (PDT)
Date: Mon, 9 Mar 2026 14:21:49 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Tejus GK <tejus.gk@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 1/1] io: make zerocopy fallback accounting more accurate
Message-ID: <aa8Pvd5O-OLKIXam@x1.local>
References: <20260309090907.956330-1-tejus.gk@nutanix.com>
 <aa755Yc6t_bBzM_u@redhat.com> <aa78gMsQrt1BeXt3@x1.local>
 <aa8AqKqOa8YhEiF9@redhat.com>
 <0DF1A5F6-E20D-4A3F-9285-9205E87DE641@nutanix.com>
 <aa8IoQOZHzQvacSh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa8IoQOZHzQvacSh@redhat.com>
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

On Mon, Mar 09, 2026 at 05:51:29PM +0000, Daniel P. Berrangé wrote:
> On Mon, Mar 09, 2026 at 05:42:08PM +0000, Tejus GK wrote:
> > 
> > 
> > > On 9 Mar 2026, at 10:47 PM, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > 
> > > !-------------------------------------------------------------------|
> > >  CAUTION: External Email
> > > 
> > > |-------------------------------------------------------------------!
> > > 
> > > On Mon, Mar 09, 2026 at 12:59:44PM -0400, Peter Xu wrote:
> > >> On Mon, Mar 09, 2026 at 04:48:37PM +0000, Daniel P. Berrangé wrote:
> > >>>> @@ -881,8 +881,8 @@ static int qio_channel_socket_flush_internal(QIOChannel *ioc,
> > >>>>         sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
> > >>>> 
> > >>>>         /* If any sendmsg() succeeded using zero copy, mark zerocopy success */
> > >>>> -        if (serr->ee_code != SO_EE_CODE_ZEROCOPY_COPIED) {
> > >>>> -            sioc->new_zero_copy_sent_success = true;
> > >>>> +        if (serr->ee_code == SO_EE_CODE_ZEROCOPY_COPIED) {
> > >>>> +            sioc->zero_copy_fallback++;
> > >>> 
> > >>> ...this is counting the number of MSG_ERRQUEUE items, which is not
> > >>> the same as the number of IO requests. That's why we only used it
> > >>> as a boolean marker originally, rather than making it a counter.
> > >> 
> > >> Would the logic still work and better than before?  Say, it's a counter of
> > >> "messages" rather than "IOs" then.
> > > 
> > > IIUC it is a counter of processing notifications which is not directly
> > > correlated to any action by QEMU - neither bytes nor syscalls.
> > 
> > Please correct me if I'm wrong about this, isn’t each notification an information 
> > about what happened to an individual IO?
> 
> If userspace hasn't read a queued notification yet, the kernel will
> merge new notifications with the existing queued one.
> 
> The line above your change
> 
>   serr->ee_data - serr->ee_info + 1;
> 
> records how many notifications were merged, so we now how many
> syscalls were processed.
> 
> If ee_code is  SO_EE_CODE_ZEROCOPY_COPIED though it means at least
> one syscall resulted in a copy, but that doesn't imply that *all*
> syscalls resulted in a copy.
> 
> AFAICT, it could be 1 out of a 1000 syscalls resulted in a copy,
> or it could be 1000 out of 1000 resulted in a copy. We don't know.
> 
> IIUC the kernel's merging of notifications appears lossy wrt this
> information. It could be partially mitigated by doing a flush for
> notifications really really frequently but that feels like it would
> have its own downsides

IMHO what this change does is removing the false negatives.

Before this patch, if QEMU reports fallback=0, it doesn't mean all the
MSG_ZEROCOPY requests were all fulfilled by zerocopy.  It's because we
justify it with one boolean over "a period of time" between two flushes, we
set the boolean to TRUE as long as there is _one_ successful report of
MSG_ZEROCOPY.  So even if every flush reports TRUE it only means "there is
at least one MSG_ZEROCOPY request that didn't fallback".  It has no
implication of whether a fallback happened.

Hence, before this v2 patch, there can be false negative reported by QEMU,
assuming there's no fallback (reflected in stats) but it actually happened.

After this patch, if QEMU reports fallback=0, it guarantees that _all_
MSG_ZEROCOPY requests are fulfilled with zerocopy.  It's because we monitor
all messages and accumulate any fallback cases.  Even if the messages can
be merged, when "fallback" shows anything non-zero would imply some
fallback happened.  Here, the counter value doesn't really matter much
IMHO, as long as it becomes non-zero.

Thanks,

-- 
Peter Xu


