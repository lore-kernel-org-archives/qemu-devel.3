Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C4CC98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9OEd-0004b6-SV; Wed, 23 Sep 2026 10:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3GOazagoKChE9Ar42vF0yBx55x2v.t537v3B-uvCv2454x4B.58x@flex--stanleyjhu.bounces.google.com>)
 id 1x9OEN-0004O3-MG
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 10:46:01 -0400
Received: from mail-pj1-x1047.google.com ([2607:f8b0:4864:20::1047])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3GOazagoKChE9Ar42vF0yBx55x2v.t537v3B-uvCv2454x4B.58x@flex--stanleyjhu.bounces.google.com>)
 id 1x9OEJ-0000uq-Ad
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 10:45:52 -0400
Received: by mail-pj1-x1047.google.com with SMTP id
 98e67ed59e1d1-381250979d5so911111a91.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 07:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790174745; x=1790779545; darn=nongnu.org;
 h=content-type:cc:to:from:subject:date:message-id:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+u3WgMDVRdFtrbzjP8geU64YDO6qPHVEqvb3Xo/NBPQ=;
 b=by/xFJQYRoAHSaYIMirUiidmYnMwvw/noh9SDfQg/cfF7mbo2qGdNnjTHmX+QO/gJX
 ZM4HGpJNMDwY8+4L4tDF9E3zbdmRySW5W89lNUY4E0AOSleVYRIhS/BF0/Mte4Kw5W6I
 Fq+mQfaBxsWOmKdZ3zIwxcbM9oLOY+B19sIl2rhUKGSQqdiKrufIj1TK5kv7ruI1dIlh
 eqvVWs+l1B7BK09mgnOg0l1SqWakUfIQcioOgDi7gesxeddui9zGyzmyIb9jeIDUQykr
 SVQs0WoqyL0ZvLYhkHD6iq4yzBFsRjZhnSWc4MIlFv6c+pcI/zpSpHZo0Svf7UxQ1h7M
 q7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790174745; x=1790779545;
 h=content-type:cc:to:from:subject:date:message-id:references
 :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+u3WgMDVRdFtrbzjP8geU64YDO6qPHVEqvb3Xo/NBPQ=;
 b=Row0hDzH4r3SrWvu5sayPAJM1mb69txBQ34RxkP1vmTRpgKd+QD5yHdHxflcEy2cQ3
 gaImDIvdUwTF8ccZ8ilbDTLAz0YlTedrJfA/9kFgWq0AWk9kjPCjP7HBVSGM3IDGOkPD
 87q3iiGlHdv2pxuhQi1tE/FBeZZeZVmR57FH1SW5x/+w2dhqRhpGo2QMHhOsC6guPX3o
 x7sMcJMlIiu8jJ7IXEIDIUR1jNiAz4Dupo1gVXcz7faAV2ghcwY7fk4qHhf1WNrIGlJW
 SMc+OsQ1yZf4MJiDHnZAGKydhQCheaRN9TwPE98boilZIvTxIxnFrCk9je/2gul8kwxT
 JAdQ==
X-Gm-Message-State: AFuF++mDrxy2jkvjD9Tj8uTGOp83ku7EWLG57s4W61YpJVnoxtWZjcQB
 OxeWXbyEVLaQ1Ucb+yRFWeujE1tv2szrh4nATN5V5Bz5BVZwVdTTNwrG5uQuXH2zZBtJQ0jnO1U
 vP5XKyw+3Uv+8OKMaRR6MNA==
MIME-Version: 1.0
X-Received: from pgp25-n2.prod.google.com
 ([2002:a05:6a02:62d9:20b0:cc7:5a0b:44d1])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3985:b0:39e:4c80:f682 with SMTP id
 98e67ed59e1d1-3a07e6be36emr2463762a91.33.1790174744874; 
 Wed, 23 Sep 2026 07:45:44 -0700 (PDT)
In-Reply-To: <179012898120.22786.14112595690493270605.b4-review@b4>
References: <20260909031146.1646684-1-stanleyjhu@google.com>
 <20260909031146.1646684-2-stanleyjhu@google.com>
 <179012898120.22786.14112595690493270605.b4-review@b4>
Message-ID: <18d7fa721639805c.3137322e31362e3131332e313435.2bcb6b.0000sendgmr@google.com>
Date: Wed, 23 Sep 2026 14:45:44 +0000
Subject: Re: [PATCH v2 1/3] hw/ufs: Track SCSIRequest and cancel pending
 requests in ufs_clear_req
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@gmail.com>, Jeuk Kim <jeuk20.kim@samsung.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Jinyoung Choi <j-young.choi@samsung.com>, Stanley Jhu <stanleyjhu@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Received-SPF: pass client-ip=2607:f8b0:4864:20::1047;
 envelope-from=3GOazagoKChE9Ar42vF0yBx55x2v.t537v3B-uvCv2454x4B.58x@flex--stanleyjhu.bounces.google.com;
 helo=mail-pj1-x1047.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

On Wed, 23 Sep 2026 11:03:01 +0900, Jeuk Kim <jeuk20.kim@gmail.com> wrote:
> ufs_clear_req() currently releases request resources; it is not  
> responsible
> for cancelling in-flight SCSI requests. Its existing callers ensure that
> the request is no longer in flight, so the current code does not have the
> UAF described here. Please describe this as preparation for TMF support.

Agreed. Updated the commit message in v3 to frame this as preparation
for TMF support.

> > +    if (!req) {
> > +        return;
> > +    }

> Can we use assert(req != NULL) here? We only clear hba_private in the
> completion and cancellation callbacks, so req should not be NULL here.
> If that invariant is broken, it would be better to catch the bug with
> an assertion than to silently return.

> > @@ -190,6 +196,11 @@ static void ufs_scsi_command_complete(SCSIRequest  
> *scsi_req, size_t resid)
> >
> >  static void ufs_scsi_command_cancelled(SCSIRequest *scsi_req)
> >  {
> > +    UfsRequest *req = scsi_req->hba_private;
> > +
> > +    if (req) {

> Same here: can we use assert(req != NULL)?

Done in v3.

