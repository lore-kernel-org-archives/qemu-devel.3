Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4B7C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9OEe-0004f8-PC; Wed, 23 Sep 2026 10:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3GuazagoKChMBCt64xH20Dz77z4x.v759x5D-wxEx4676z6D.7Az@flex--stanleyjhu.bounces.google.com>)
 id 1x9OER-0004OK-Dg
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 10:46:02 -0400
Received: from mail-pj1-x1046.google.com ([2607:f8b0:4864:20::1046])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3GuazagoKChMBCt64xH20Dz77z4x.v759x5D-wxEx4676z6D.7Az@flex--stanleyjhu.bounces.google.com>)
 id 1x9OEN-0000v4-Dq
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 10:45:56 -0400
Received: by mail-pj1-x1046.google.com with SMTP id
 98e67ed59e1d1-39deb05ef51so1074394a91.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 07:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790174747; x=1790779547; darn=nongnu.org;
 h=content-type:cc:to:from:subject:date:message-id:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BZEgnHFYjL9Mxvpmoi/S4k6U75jXGsS+g1CGHQoADY8=;
 b=lLPl1pQYCaOm3rZImaYrLTFI0OvbA9ZNtO4bBj+vBlVWnY9PSC9SLzAAW8F7zkXeeR
 I8LZY1lPN5mG1n+qhyKguIqrxWGeUzV3bkNU4Ye6kcQCJ90xCDUbT+ZyBv4Za2XAOECe
 jzYvKFuqT+0l8gxRrX+wlO1zDsPzmovHQYmIXGft7vCUntScoLQCyWFXhO09BUWWZhRB
 l9AwBJ8W3uMmEBaqfbUV7TGmX6F6v1jFgzD70+l5MmHH7luoObp46DlN1qYL7398JorE
 StokPWDVDeMD0OK95p1KbA/ibSJJRTUlm3rMY3yNlRqDa3P81iC3ClnHmyd0hCmuFB6V
 r6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790174747; x=1790779547;
 h=content-type:cc:to:from:subject:date:message-id:references
 :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BZEgnHFYjL9Mxvpmoi/S4k6U75jXGsS+g1CGHQoADY8=;
 b=Oo3SvYPBbn+hvRn6f1X41eBFQOHhENunMEVEhkQRNhAO6oAxGAfU+XOs3UkQBwOwIC
 VUv2GOUsSoeaHS2wTdv5viknQZgDQdfNxHUVYvq3qqElMDxw6PEqiRnvaY9SEkmtkvtT
 F29cSozyoHckX6kfudfMybsv+4f3p1iEhhGx3n2xk/TokB70QeeNUeJYYGojODb1yGOi
 KiV7sbtTQrnji5/Ya+SPR3yYiHXN1d8izAZ+8kfMZX4A1zesYx5RpgzuDlHDMe2qvfPT
 FId4SbhpfhHpwBy+mDBrAd8vXhnepZzbHifVk5F5VK9z/pbd6qPnV7iqLuOQSNbyEyWr
 8BwQ==
X-Gm-Message-State: AFuF++kirBE1zaFmazrwHrKPegi7g5HKPQX/znOP6bccNxgrFywq9YnH
 OXTXttp8BM17Bga/QDx2RNzJ9hDT0vomkXksckx+2zQ06lOum/2nfHd6ScRUKQlNgQ5qrYAuCnK
 efZULi7n03+9v6SU8j6uXIQ==
MIME-Version: 1.0
X-Received: from pjzc22.prod.google.com ([2002:a17:90a:e116:b0:3a0:6f00:2a50])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1346:b0:398:a145:5d3d with SMTP id
 98e67ed59e1d1-3a07e4ee828mr2509133a91.6.1790174746756; 
 Wed, 23 Sep 2026 07:45:46 -0700 (PDT)
In-Reply-To: <179012898120.22786.2623487845191822676.b4-review@b4>
References: <20260909031146.1646684-1-stanleyjhu@google.com>
 <20260909031146.1646684-3-stanleyjhu@google.com>
 <179012898120.22786.2623487845191822676.b4-review@b4>
Message-ID: <18d7fa72867e0326.3137322e31362e3131332e313435.2bcc0b.0000sendgmr@google.com>
Date: Wed, 23 Sep 2026 14:45:46 +0000
Subject: Re: [PATCH v2 2/3] hw/ufs: Support MCQ runtime interrupt and queue
 status registers
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@gmail.com>, Jeuk Kim <jeuk20.kim@samsung.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Jinyoung Choi <j-young.choi@samsung.com>, Stanley Jhu <stanleyjhu@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Received-SPF: pass client-ip=2607:f8b0:4864:20::1046;
 envelope-from=3GuazagoKChMBCt64xH20Dz77z4x.v759x5D-wxEx4676z6D.7Az@flex--stanleyjhu.bounces.google.com;
 helo=mail-pj1-x1046.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_PDS_OTHER_BAD_TLD=0.01,
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
> > - Store queue configuration for interrupt aggregation (CQnIACR) and  
> completion
> >   timeout intervals (SQnCTI).

> SQnCTI is Submission Queue Cleanup Task Information, not a completion
> timeout interval.

Fixed in v3.

> > +    case offsetof(UfsMcqOpReg, sq.rtc):
> > +        opr->sq.rtc = data;
> > +        if (FIELD_EX32(data, SQRTC, ICU)) {
> > +            /* SQ_ICU: Initiate Cleanup (SQ_CUS = 1, RTC = 0) */
> > +            opr->sq.rts = FIELD_DP32(opr->sq.rts, SQRTS, CUS, 1);
> > +            opr->sq.rts = FIELD_DP32(opr->sq.rts, SQRTS, RTC, 0);

> SQRTC.ICU reports successful cleanup without using SQCTI or changing any
> request state. Is the actual cleanup expected to be handled by the TMR  
> path?

Implemented actual cleanup in v3: `SQRTC.ICU` now matches the target
request via `SQCTI`, cancels any pending `SCSIRequest`, posts a CQE
with `OCS = UFS_OCS_ABORTED`, and recycles the request slot.

