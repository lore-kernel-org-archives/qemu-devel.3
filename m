Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9B91125865
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 18:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0OXH-0008Rh-QU; Wed, 11 Mar 2026 14:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w0OXF-0008RF-5m
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 14:43:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w0OXC-0002kO-JM
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 14:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773254632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bet5g5W+DXet5GwNGNfmZG+uz5s67XoolmwiaROlE4c=;
 b=Bp8XDGfA3BvjcGEhqNPufcNjadgF7Uv40g3mL8OvLCe01eLpgkhrz2a83m/ahzqrUcycMr
 URjDCb4oFV3tdwDj8ycC49Hrl0ZYeKxg7qMEUdb3fBFSQtQvdH2Ju5+OQTg6eWXWGjTX2O
 sn0MJfKXCauhzJLM/DFM4PLRIYSNfOM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-rn3uwxtWPTq28UaodenSyw-1; Wed, 11 Mar 2026 14:43:50 -0400
X-MC-Unique: rn3uwxtWPTq28UaodenSyw-1
X-Mimecast-MFC-AGG-ID: rn3uwxtWPTq28UaodenSyw_1773254630
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5091327215dso21503161cf.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 11:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773254630; x=1773859430; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Bet5g5W+DXet5GwNGNfmZG+uz5s67XoolmwiaROlE4c=;
 b=GPnISVcSb10Iq+VFHKLiV12K9/HzJ0JoBvUe63iKQd7RuUEYNM1LuMtmq9s2glz8Qo
 h45E6MAMGVmuSoEywVtG+IrmuSwim/4Fuw+ESeO+lFHaAwS9yTCA9D40zpTsilf6hC0+
 /d2F/Q2CuostrhIKA8albhYB9q6EX/AlbDLjuBSkulHjc+WODQzEfucScV3zlkGp0kHX
 90YWQyHjopD2E/eRbmPgIY6v3Z9KJr8tvQVEv9LAaCHHW3NH51XTBOnWwVLj5919+C0a
 HR95f6Y3YpuxRk5dS8t7iEQhNRJxxf24wynRoIk5dNhrmRbaM9ZdGPJhAGG83SSgePG5
 ZQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773254630; x=1773859430;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bet5g5W+DXet5GwNGNfmZG+uz5s67XoolmwiaROlE4c=;
 b=lEMPTzVNxY2+bqZZWf3D2NK15OhLY1xqssRa0I8xgG1oYXz55/CXUl+mlH5Qj+0NqM
 Io2UTeT1ebx5C3xOSoVhR48hA6NCZxnM+zD18Dg2CyBdU6ioL6Wi/YihvCh11ns72FtJ
 3EVYC0X3/9Cr3HzgSBwlKra8pAW+wZbd7TfvMD7rGUbrKDl+R87uJeLXJelQhNbod9yV
 EQHIxVAZZewYnnnsiJCy8Knh6kuNgOmhOoAcC2bmKhMrZRYczlpf14hoI9pjJ13OEHHx
 pJYL5LGGusvaHYmXRIiFqn+Fxu2mWVh/deppbiAXVjy+qFQVIe7LzAaMuvH18EV70jKN
 Po3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWscKNwTjyDp+uoN1OqAVBnrDMpiju2YnmMKirNDDHbNpj4yB0eML1qvxM+53SinKZfl/3IUPkvTIY3@nongnu.org
X-Gm-Message-State: AOJu0Yw0mYze+goQo+fNDS7b/7hEtvNDSbPmpnWVfdzx7HzoVi84n5yt
 rIXoRa9JGOCAU0ZzneZY1UYh8crWY8z+UYfwVHzJDz/r8mEA+3uSnydz7XI4ZEy2cEEmkmLJTZe
 YL00R+xGLsk+/q40P+gAdHK9gT71o9qO36on2dGvgxoLc6Tfnt8PeGGdF
X-Gm-Gg: ATEYQzwnXjUhMNQJYmY+73egf6fPdssjmEr0ml9pgmTUAFdj53+/gbYG4Bxps0nJYBM
 Ur+4D474ys+P6TFDWnx58csXCCr8/5fNwKIFE1WJidsV+bBzMNy5mHmKHjsDpKuVJc5aGw/h/kc
 9o0nWuCMM9ws58XZ99Ioh94ANxgewUKKMPEF4+Ccz6AB0O3GaCMvqqi7F/8IuLs7tBJGkryx1SX
 MT43VvcyCWHQrS0VyNYgdErjum6Xh/k8kIRs+R4FhZi4xISzQKSgGt+nEiDxrVan3mpN4EUf8pi
 3lSgz0Upe+/EDhZO3iCf/3zJ96jjq5dfwNR9CE8WiJyT5Zq2KNiWgaP4Bh5raC9rG64LsO0j62r
 xicPSSdkB/0duGA==
X-Received: by 2002:a05:622a:5d3:b0:509:3252:b79a with SMTP id
 d75a77b69052e-5093a1b0847mr45988411cf.59.1773254630112; 
 Wed, 11 Mar 2026 11:43:50 -0700 (PDT)
X-Received: by 2002:a05:622a:5d3:b0:509:3252:b79a with SMTP id
 d75a77b69052e-5093a1b0847mr45987901cf.59.1773254629460; 
 Wed, 11 Mar 2026 11:43:49 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a65bed6ffsm19199116d6.16.2026.03.11.11.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 11:43:48 -0700 (PDT)
Date: Wed, 11 Mar 2026 14:43:47 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Tejus GK <tejus.gk@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 1/1] io: make zerocopy fallback accounting more accurate
Message-ID: <abG349ix_S-CEn8C@x1.local>
References: <aa78gMsQrt1BeXt3@x1.local> <aa8AqKqOa8YhEiF9@redhat.com>
 <0DF1A5F6-E20D-4A3F-9285-9205E87DE641@nutanix.com>
 <aa8IoQOZHzQvacSh@redhat.com> <aa8Pvd5O-OLKIXam@x1.local>
 <abFZvUoinIjfMlNX@redhat.com> <abGKkoFfy1RILXA0@x1.local>
 <abGesQMQuVSYJy1W@redhat.com> <abGmRItAZiiRIeIY@x1.local>
 <abGqkFCoApJv2rT1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abGqkFCoApJv2rT1@redhat.com>
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

On Wed, Mar 11, 2026 at 05:46:56PM +0000, Daniel P. Berrangé wrote:
> On Wed, Mar 11, 2026 at 01:28:36PM -0400, Peter Xu wrote:
> > On Wed, Mar 11, 2026 at 04:56:17PM +0000, Daniel P. Berrangé wrote:
> > > On Wed, Mar 11, 2026 at 11:30:26AM -0400, Peter Xu wrote:
> > > > On Wed, Mar 11, 2026 at 12:02:05PM +0000, Daniel P. Berrangé wrote:
> > > > > On Mon, Mar 09, 2026 at 02:21:49PM -0400, Peter Xu wrote:
> > > > > > On Mon, Mar 09, 2026 at 05:51:29PM +0000, Daniel P. Berrangé wrote:
> > > > > > > On Mon, Mar 09, 2026 at 05:42:08PM +0000, Tejus GK wrote:
> > > > > > > > 
> > > > > > > > 
> > > > > > > > > On 9 Mar 2026, at 10:47 PM, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > > > > > > > 
> > > > > > > > > !-------------------------------------------------------------------|
> > > > > > > > >  CAUTION: External Email
> > > > > > > > > 
> > > > > > > > > |-------------------------------------------------------------------!
> > > > > > > > > 
> > > > > > > > > On Mon, Mar 09, 2026 at 12:59:44PM -0400, Peter Xu wrote:
> > > > > > > > >> On Mon, Mar 09, 2026 at 04:48:37PM +0000, Daniel P. Berrangé wrote:
> > > > > > > > >>>> @@ -881,8 +881,8 @@ static int qio_channel_socket_flush_internal(QIOChannel *ioc,
> > > > > > > > >>>>         sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
> > > > > > > > >>>> 
> > > > > > > > >>>>         /* If any sendmsg() succeeded using zero copy, mark zerocopy success */
> > > > > > > > >>>> -        if (serr->ee_code != SO_EE_CODE_ZEROCOPY_COPIED) {
> > > > > > > > >>>> -            sioc->new_zero_copy_sent_success = true;
> > > > > > > > >>>> +        if (serr->ee_code == SO_EE_CODE_ZEROCOPY_COPIED) {
> > > > > > > > >>>> +            sioc->zero_copy_fallback++;
> > > > > > > > >>> 
> > > > > > > > >>> ...this is counting the number of MSG_ERRQUEUE items, which is not
> > > > > > > > >>> the same as the number of IO requests. That's why we only used it
> > > > > > > > >>> as a boolean marker originally, rather than making it a counter.
> > > > > > > > >> 
> > > > > > > > >> Would the logic still work and better than before?  Say, it's a counter of
> > > > > > > > >> "messages" rather than "IOs" then.
> > > > > > > > > 
> > > > > > > > > IIUC it is a counter of processing notifications which is not directly
> > > > > > > > > correlated to any action by QEMU - neither bytes nor syscalls.
> > > > > > > > 
> > > > > > > > Please correct me if I'm wrong about this, isn’t each notification an information 
> > > > > > > > about what happened to an individual IO?
> > > > > > > 
> > > > > > > If userspace hasn't read a queued notification yet, the kernel will
> > > > > > > merge new notifications with the existing queued one.
> > > > > > > 
> > > > > > > The line above your change
> > > > > > > 
> > > > > > >   serr->ee_data - serr->ee_info + 1;
> > > > > > > 
> > > > > > > records how many notifications were merged, so we now how many
> > > > > > > syscalls were processed.
> > > > > > > 
> > > > > > > If ee_code is  SO_EE_CODE_ZEROCOPY_COPIED though it means at least
> > > > > > > one syscall resulted in a copy, but that doesn't imply that *all*
> > > > > > > syscalls resulted in a copy.
> > > > > > > 
> > > > > > > AFAICT, it could be 1 out of a 1000 syscalls resulted in a copy,
> > > > > > > or it could be 1000 out of 1000 resulted in a copy. We don't know.
> > > > > > > 
> > > > > > > IIUC the kernel's merging of notifications appears lossy wrt this
> > > > > > > information. It could be partially mitigated by doing a flush for
> > > > > > > notifications really really frequently but that feels like it would
> > > > > > > have its own downsides
> > > > > > 
> > > > > > IMHO what this change does is removing the false negatives.
> > > > > > 
> > > > > > Before this patch, if QEMU reports fallback=0, it doesn't mean all the
> > > > > > MSG_ZEROCOPY requests were all fulfilled by zerocopy.  It's because we
> > > > > > justify it with one boolean over "a period of time" between two flushes, we
> > > > > > set the boolean to TRUE as long as there is _one_ successful report of
> > > > > > MSG_ZEROCOPY.  So even if every flush reports TRUE it only means "there is
> > > > > > at least one MSG_ZEROCOPY request that didn't fallback".  It has no
> > > > > > implication of whether a fallback happened.
> > > > > > 
> > > > > > Hence, before this v2 patch, there can be false negative reported by QEMU,
> > > > > > assuming there's no fallback (reflected in stats) but it actually happened.
> > > > > > 
> > > > > > After this patch, if QEMU reports fallback=0, it guarantees that _all_
> > > > > > MSG_ZEROCOPY requests are fulfilled with zerocopy.  It's because we monitor
> > > > > > all messages and accumulate any fallback cases.  Even if the messages can
> > > > > > be merged, when "fallback" shows anything non-zero would imply some
> > > > > > fallback happened.  Here, the counter value doesn't really matter much
> > > > > > IMHO, as long as it becomes non-zero.
> > > > > 
> > > > > AFAICT, the v1 of this patch was sufficient to address the original
> > > > > bug and maintain the current intended semantics of the migration
> > > > > counter. This v2 is mixing a bug fix with functional change in
> > > > > behaviour and I don't think the latter is justified.
> > > > 
> > > > It's just that when it cannot report all fallback cases, I don't yet see
> > > > how it would help much even if we fix the previous behavior with v1..
> > > > 
> > > > OTOH, the new behavior will be deemed to have no issue on the problem v1
> > > > was fixing.
> > > > 
> > > > So IIUC v2's behavior is the one we want, and helps identify fallback
> > > > happened.
> > > 
> > > I don't consider v2 acceptable as the value its returning is an
> > > meaningless counter that doesn't correlate to any quantity that
> > > is used by QEMU, nor visible to users of QEMU.
> > 
> > It can be a boolean if we want showing "if any fallback happened", that'll
> > at least make it accurate and avoid false negatives. But IMHO a counter is
> > always better, e.g. when we dump it from time to time we know if any more
> > fallback happened.
> > 
> > In that case, no matter how that counter is defined in granularity that'll
> > help, as long as it get boosted when fallback happened.
> > 
> > I also don't expect this value to be consumed by an user, but only reported
> > by an user and should only be consumed by a developer.
> 
> Ok, so the problem is that we've got a design inversion between what
> the kernel is reporting and what the io channel is reporting.
> 
> With the kernel notifications we can determine
> 
>  * All syscalls successfully used zero copy
>  * At least one syscall failed to use zero copy
> 
> whereas what the io channel flush is (claiming) to report is
> 
>  * 1 => all syscalls failed to use zero copy
>  * 0 => at least one syscall successfully used zero copy
> 
> and you cannot infer the latter from the former, as we have missing
> information due to merging of notifications.
> 
> So we need to invert the return values semantics of the flush method
> to account for the missing information:
> 
>  * 1 => at least one syscall failed to use zero copy
>  * 0 => all syscalls successfully used zero copy

Yep, this should be one good way to nail this problem.  Maybe Tejus, as a
real consumer of this counter, will have a preference on how it looks the
best.

Thanks,

-- 
Peter Xu


