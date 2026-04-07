Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A33FF5134
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wACHW-00034q-GN; Tue, 07 Apr 2026 15:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1wACHD-0002l0-Bi
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:40:04 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1wACHA-00018A-3I
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:39:53 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2b299b3c739so11582605ad.3
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 12:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775590790; x=1776195590; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JP6Cf+2hyjjPrK+aCpBGS2twEctXU6+AB24rOaNiPzI=;
 b=q+uBw3XfLHEFxyJWEHc46WFCBJQqEzu6qaWnZGw27z/7vvyNg2ENr15L9eekCz20WS
 9J8YrViuOOfxhXUq5wc1SbZRm+D04JdzGLMtaoQpm//VXNJrwaiboqhvUCgi55xp2SMq
 isM7W4xOmbCCwi6+gWo0fBpz+sH6MPoa/CGvLV11xzstVYLZ4gpBD5inBn8WJmUp9C/y
 7n3rbCmnErHOIfDD2VlThyxzSX331nvRTkogqFgVrgxCMPE0wGxNaG0RvuiwHH6mjwW1
 utKjQPU2vAI8Oaq8FLUf+MLYOkhy0yFSotOYMmHDlyD+9azmE4YMlUBIkyYDJVteYPHb
 U4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775590790; x=1776195590;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JP6Cf+2hyjjPrK+aCpBGS2twEctXU6+AB24rOaNiPzI=;
 b=PpZ3vYQkYHpYCevf1cJ2E5XvE0n32FvKolYyjj53gFfdDB2U08vZ895ScRDVJ6Dn32
 OaBGxFYUS2fi71PIr8+haMzEKXvy2TRhpsGWn9Ti/qzshB9P8GrsIzk5XPzmNp3EJ2uA
 QkJ8LkZCgPZoKe4NRITC8KPuztSSLzx64DH0UiofvHizUpoKZehGGj27Gf6O5QlFwmef
 cune4j3N+gqV3W4KTSQmp42LB89Lk+w0lz3c8sWluxA2qs96C1IDQCWFaQ6smpef+MGm
 hQ0pIATEs/VWSuShWMUjwfzUxV1wj/rLI/rxt8bW+awAbEAaujCb+qt2LKOPDTKIHtoa
 REVg==
X-Gm-Message-State: AOJu0YwlNcdGSd1obFZgV8zPfsVnKkyK1nrtGN3MR5jGpNHLWzSy5h1J
 SeWLdwV6CWvGYlKhBM0qJZ6OoK/vWXw5+zM3NwSKED11p+yLYOpNkml/
X-Gm-Gg: AeBDietaPdsl79PD82eYgXgPeOxLmbmTAUIQrCvoFIiBoI6rHc3/S2uqy+GqoPXauFt
 g3USPqWLqO7HhqigIPFP/x94okvzNe2i79KaRZx3zZCAz2JBgmZ6V4ti+mydJqWDltpH6C4vykX
 olfYYfMPgTUOiF057G9BkliogB2FexgSEXyst4gPCLWRe2jdCv3GG0AXNv3Mr0TtHstGSurtU0R
 TK/FOqptwFciyhdM97PHpxiJymReMfCAvLBZr2ShYziUFlIxApUJdEXlQe+Cn2wYQiJvxmSZsSp
 FecoRzHcJV4w+Tn5nxLUZb6oEegyLg5wb34VbUR8kYWhob/jOgmKtfF6TtvRONAXUFrSpDIshbL
 m8v2ORdfPHiN3LdwfAp4GEYg+bttAa6Z2XeFTaQ8Ufl+a5MJSVhiLV9i064iFPVV2tnLhXQY05d
 w+f/ouru3d/Vyr6qXpF8zza8De2HeUCVY=
X-Received: by 2002:a17:903:37ce:b0:2b2:481b:de5f with SMTP id
 d9443c01a7336-2b28163b27dmr187430855ad.5.1775590790592; 
 Tue, 07 Apr 2026 12:39:50 -0700 (PDT)
Received: from localhost ([42.118.191.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27472d688sm184123575ad.8.2026.04.07.12.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:39:50 -0700 (PDT)
Date: Wed, 8 Apr 2026 02:39:45 +0700
From: Trieu Huynh <vikingtc4@gmail.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] runstate: allow inmigrate -> debug transition on
 snapshot restore
Message-ID: <cz3radrceni4lvapbtimzgtukbcuhr3omgldlgvnw4dsowagrj@ehyqdhilbc56>
References: <20260402194314.20104-1-viking4@gmail.com> <87ecks5hdv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ecks5hdv.fsf@suse.de>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=vikingtc4@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Apr 06, 2026 at 10:48:44AM -0300, Fabiano Rosas wrote:
> Trieu Huynh <vikingtc4@gmail.com> writes:
> 
> > From: Trieu Huynh <vikingtc4@gmail.com>
> >
> > When a VM snapshot is taken while the guest is paused by a gdbstub
> > (RUN_STATE_DEBUG), the saved runstate is 'debug', for instance:
> >   (gdb) monitor info status
> >   VM status: paused (debug)
> >
> > On restore, the destination starts in 'inmigrate' and transitions
> > to the saved runstate, but the 'inmigrate -> debug' transition
> > was missing from the table, causing an abort:
> >
> >   $ ./qemu-system-x86_64 -machine pc,accel=kvm:tcg  -m 128M
> >   -display none -gdb tcp::1235 -incoming "exec:cat /tmp/snap.img"
> >   > /tmp/qemu-restore.log 2>&1
> >   Aborted (core dumped)
> >   $ cat /tmp/qemu-restore.log
> >   qemu-system-x86_64: invalid runstate transition: 'inmigrate'
> >   -> 'debug'
> >
> > Fix it by adding the missing one (Point out by the author
> > Dustin Spicuzza)
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1231
> 
> (note to self: stop giving time estimates)
> 
> >
> > Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> 
> I think this is reasonable as a standalone change:
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> 
Thanks for the review.
> As I mentioned in the Gitlab issue, it raises the question of whether
> there's more to be done in terms of migrating the gdbstub
> connection. Probably too niche of an use-case?
> 
Agreed that it's a niche use-case. The immediate pain point was the
hard abort on restore, which this patch addresses. Migrating the
actual gdbstub connection state across snapshots would be a separate
and considerably more involved effort. Since the restored VM would
still need the user to re-attach gdb manually anyway, so the practical
value is limited.
> > ---
> >  system/runstate.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/system/runstate.c b/system/runstate.c
> > index 2d4e95a216..97a6a1c736 100644
> > --- a/system/runstate.c
> > +++ b/system/runstate.c
> > @@ -94,6 +94,7 @@ static const RunStateTransition runstate_transitions_def[] = {
> >      { RUN_STATE_INMIGRATE, RUN_STATE_PRELAUNCH },
> >      { RUN_STATE_INMIGRATE, RUN_STATE_POSTMIGRATE },
> >      { RUN_STATE_INMIGRATE, RUN_STATE_COLO },
> > +    { RUN_STATE_INMIGRATE, RUN_STATE_DEBUG },
> >  
> >      { RUN_STATE_INTERNAL_ERROR, RUN_STATE_PAUSED },
> >      { RUN_STATE_INTERNAL_ERROR, RUN_STATE_FINISH_MIGRATE },

