Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AE11125841
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LBE-0007Jq-4Z; Wed, 11 Mar 2026 11:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w0L8I-0002R4-Ew
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:06:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w0L88-0004k0-Rw
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:05:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773241545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lIIqS8ysEuzUqZKlSW5Y4ajtTF4Cn2lMBwuDl4tuulo=;
 b=VCR2Kac3bhp5DLR2Cth0R7u90KasrLUNY4xdi+wskqpxoRR6GHcW8MM0qrZQ/OxRctxh+Y
 rNLBjERJTMsCevRP/yfFBDxkpcnnmN6a9/wFATQe1dNKJfQfpDgrvTU6Guq5ggi4O3CY3x
 bTcXWy18KrTa+9i+qQK7aToJvwfSzE4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-sjsiV7SNM-y_u1rCxi_cVg-1; Wed, 11 Mar 2026 11:05:42 -0400
X-MC-Unique: sjsiV7SNM-y_u1rCxi_cVg-1
X-Mimecast-MFC-AGG-ID: sjsiV7SNM-y_u1rCxi_cVg_1773241541
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cd773dd39bso3053670685a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 08:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773241541; x=1773846341; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lIIqS8ysEuzUqZKlSW5Y4ajtTF4Cn2lMBwuDl4tuulo=;
 b=aJmZQ28522PRnHYlmXz0fmGR5ClohZgwqCKKRygTqC/vT7Agl8Llb+ZWIOlabdCF/q
 UFvyh3/kleJNR5WJtkz8HHT6xSV2Vgfilrt1UnbRDJoJAUKK4AcFnM4nadR+IHo2MiQM
 9aG2kblQ7177c+DkxBz5rmzCvlORMw2fvQQFFPxC0ZBx8X4CVbFpPzBONGgyzHfrZrwF
 YG4t3RoLOQVB3w7LTt6tqaFC40vEr2I8FkmybwFC+OnHS2E9LBNgQvd79ynngNWodkqa
 X0R+yxzjvmrqKkxpATPAjxHBi8e1RTtkusJxDE2qZ4z0rVfXdrGbFeZjVCrLGnNlzZbb
 puYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773241541; x=1773846341;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lIIqS8ysEuzUqZKlSW5Y4ajtTF4Cn2lMBwuDl4tuulo=;
 b=F01LE/Ct7JUXeLQHi4FdVkUZqGMJ7lEzwZd2EgaekKIEj5Rk/m+aSAykRCOWPbKWSC
 Yau0VlRsF71f88U5N2q2SaKnlirUoxY035l4oFr2cMb+tnygvjBeGGSnxlk+gIc5N/jS
 byLojwp5GEb90Uv4Ve20/uCZ2fDW4Lol3ZbgGJjhevAr+OMulQ7mC3uoe4nPrUu0L3Fe
 hTDpb2DV1zjUdD3Qtln96bVdNpGb/Ddsc7uLVDScV4jX87TeBRpGB5BlwGv7TXSirE0R
 1VJ92zucXlE70z7EwwdAuV6wmtp/Z1CmfV/EMjRjYdRwTqdXPUte6dvYCU3Imj17GTab
 GBLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZNxz4Cds5BDcAmuM5Dqzvp2yOPM1CA8DC2/N/grtuS9PlQlpYrsQonNT+PnS8RKuAuibfS5/zsh4F@nongnu.org
X-Gm-Message-State: AOJu0YyGEQ9+QueoTwMul5/jMly8e+iMGJZ8JlN5n9bMQVXg6m5WB05u
 7wjtXYZT3YYO/zfaI4ZDpKYZxBgvkK+EHH7toIKEl6GC014BlrCKvRpJiR5uGi2b+zVUxtNb2+0
 Wo6+dRQTgxa8VyRUldMWK6/phx8KGIxnIs5c4itlrJDDoUfgNJXDu1Ltr
X-Gm-Gg: ATEYQzxcz/HUDuvJ9DVpNI4a3Il28uzuSLRiqT143ZDV9YEfcQWyQSvv0UCAgfcJ+fh
 Jn60LFC190M77ouH+m+eZFmp6ucr7QiTaNuK9CXKj2oZR6dFLWy6EOsu8FWLWeUuc89loE1WtRR
 KE40R8Q0zNRgU/Vlt08PftdKDjZThpKPUf+6MDxKjON/Zu2D6j2U22YltzOPkRY/+na3JxwR6ew
 CVeoj6BRZZIkCPbiUl8HfoooM4QRWhBS/bCIftIYKnWCZiw+1SpQVb7nBFOh9+Qf7rJ462CkTi9
 C9mPpcryYbjjxq2Yvx8JCOkTPuqv2/+u4JVl2nphVhK5AjOQCm6Eoq8yMaKSya6T8d7btqtQluP
 074h0DclCEvhqKw==
X-Received: by 2002:a05:620a:1998:b0:8cb:9fd4:2ecb with SMTP id
 af79cd13be357-8cda1a3fa71mr348745085a.54.1773241540654; 
 Wed, 11 Mar 2026 08:05:40 -0700 (PDT)
X-Received: by 2002:a05:620a:1998:b0:8cb:9fd4:2ecb with SMTP id
 af79cd13be357-8cda1a3fa71mr348736885a.54.1773241539885; 
 Wed, 11 Mar 2026 08:05:39 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cda21484casm147805285a.40.2026.03.11.08.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 08:05:39 -0700 (PDT)
Date: Wed, 11 Mar 2026 11:05:37 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2] vmstate: fix subsection load name check
Message-ID: <abGEwf-AG1rZ3kam@x1.local>
References: <20260302070626.613396-1-dtalexundeer@yandex-team.ru>
 <87y0k5136i.fsf@suse.de>
 <714e4329-6001-4c77-b004-ed7beb11c154@yandex-team.ru>
 <e81360d5-cab4-47a4-840b-7d948b51a5c0@yandex-team.ru>
 <CAFEAcA-m+CZPUchGsh6QU4gm1dO-FP0m1w5gu6sn56wUXBbRAQ@mail.gmail.com>
 <abBcN2B4QNBT_Oh9@x1.local>
 <f37dc7af-7ffd-4a7b-b4fa-552c2d2eb888@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f37dc7af-7ffd-4a7b-b4fa-552c2d2eb888@yandex-team.ru>
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

On Wed, Mar 11, 2026 at 09:53:07AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 10.03.26 21:00, Peter Xu wrote:
> > On Tue, Mar 10, 2026 at 01:39:04PM +0000, Peter Maydell wrote:
> > > On Tue, 10 Mar 2026 at 13:28, Alexandr Moshkov
> > > <dtalexundeer@yandex-team.ru> wrote:
> > > > Hi, this breaks migration for s390x and ppc64:
> > > > 
> > > > qemu-system-s390x: Missing section footer for qemu-s390-flic
> > > > 
> > > > Thanks for reply! It happens because "qemu-s390-flic" vmsd has "qemu-s390-flic-full" subsection. I'm not sure if we can change the names of the existing subsections. Peter, what do you think?
> > > > 
> > > > It seems to be a bigger problem that the migration framework does not document the names for subsections in any way. At the same time, the code implies that at least the names should be a substring with its parent. There is even such a code comment `subsection name has to be "section_name/a"`, that seems to imply the presence of /.
> > > > 
> > > > Also I tried to put together a list of devices whose separator in subsections is not /:
> > > 
> > > > or-irq
> > > 
> > > This one and probably some of the others are my mistake, I think.
> > > I think this is because:
> > >   * the migration code imposes a constraint on the subsection names
> > >   * the migration documentation does not mention this constraint
> > >   * the migration code does not effectively enforce this constraint
> > >     (e.g. by asserting when the vmstate with a bad name is registered)
> > > 
> > > My assumption when writing that code was very likely that the
> > > name of the subsection didn't have to have any relation to
> > > the name of its parent subsection (after all, the migration
> > > code knows it is a subsection, so if it needed to have the
> > > name on the wire be "parentname/subsectionname" it could construct
> > > that itself), and since it all just worked I never noticed the
> > > mistake...
> > 
> > Indeed, we can do better on the 2nd/3rd bullets.. so we should document it
> > in struct VMStateDescription definition, and enforce it when registering
> > new VMSDs.
> > 
> > One thing to double check with Alexandr on this one:
> > 
> > > They using `_`, `-` or `.` as separator
> > 
> > Does it mean we also can't simply whitelist all these characters (including
> > "/"), because it won't always work?
> > 
> > For example in your case, it's "virtio-blk" being the parent VMSD, "virtio"
> > being the child VMSD, followed with a subsection belongs to virtio-blk.
> > We want to make that subsection be recognizable as virtio-blk's.
> > 
> > Then if we treat "-" also to be a separator, then "virtio" will still
> > mis-recognize virtio-blk's as its own (because its name is "virtio-blk/..."
> > hence it also satisfies the "virtio" check)?
> > 
> 
> I have an idea. What if we simply change the order, instead of
> 
> 1. check prefix (with '/' at the end). and stop the loop if it doesn't match
> 2. call vmstate_get_subsection(vmsd->subsections, idstr)
> 
> do
> 
> 0. Document, and check, that starting from 11.0 any new subsections must follow <section name>/<subsection name> notation
> 
> in vmstate_subsection_load():
> 
> 1. call vmstate_get_subsection, if it succeeded we are done
> 2. check prefix with '/' at the end. If match - it's a new subsection, added after 11.0 point, in correct notation. If does not match - it's subsection of another state, stop the loop.

Yep, this sounds working.

But I wonder do we need (2) at all?  Say, can we sololy rely on
vmstate_get_subsection() to identify if we should take it or just leave it
for upper layers?  So we will never fail a subsection lookup, only either
(1) load it if owned, or (2) ignore it and pop the VMSD stack.

It means in code we don't restrict subsection name to be "$PARENT_NAME/*".

However we should likely still suggest that in doc of subsections, so we at
least avoid one parent VMSD having subsection S1, then its field having
subsection S2, and by accident S1 and S2 has the same name..

> 
> 
> Possible problems:
> 
> 1. may be some subsections (with wrong notation), which were added before 11.0, but then removed (we break migration from old version to new).

If a subsection with wrong notation got removed, then it should require a
machine compat property otherwise migration should be broken anyway?

> 
> This can be checked by git-grepping for subsections through qemu releases.
> 
> 2. may be some downstream subsections (we may break migration from some downstream versions to upstream).
> 
> Should we care of it? Probably not.

Not sure if this is an issue if we drop (2) directly above.

There seems to have a 3rd possible "issue": the failure will be more
obscure on a subsection that nobody recognizes; we used to try our best say
"VM subsection '...' in '...' does not exist", but then it'll always pop
the VMSD stack then the upper layer may read the SUBSECTION byte anywhere.
So debugging a stream with an extra subsection can be slightly more
awkward, but I'm not sure how much.  Meanwhile for a compatible / normal
migration it'll be all fine.  It just means when seeing a subsection will
try to pick it up from the inner VMSD and fallback to outter VMSD every
time.

-- 
Peter Xu


