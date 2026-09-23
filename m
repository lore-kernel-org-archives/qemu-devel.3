Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82BEC98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9OEe-0004d7-Cx; Wed, 23 Sep 2026 10:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3HOazagoKChUDEv86zJ42F19916z.x97Bz7F-yzGz689818F.9C1@flex--stanleyjhu.bounces.google.com>)
 id 1x9OER-0004OJ-Di
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 10:46:02 -0400
Received: from mail-pl1-x645.google.com ([2607:f8b0:4864:20::645])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3HOazagoKChUDEv86zJ42F19916z.x97Bz7F-yzGz689818F.9C1@flex--stanleyjhu.bounces.google.com>)
 id 1x9OEN-0000vE-Eo
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 10:45:57 -0400
Received: by mail-pl1-x645.google.com with SMTP id
 d9443c01a7336-2dd753a52bbso15260615ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 07:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790174749; x=1790779549; darn=nongnu.org;
 h=content-type:cc:to:from:subject:date:message-id:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eZIsXV7APNY0/LNrIPkmT3SkKNqmaGTb59jjgIpzWRo=;
 b=l9mnUTlsTikgSGdiBYHOeYrgHtvnxrhWdEFxsCfw99O7H3pmOhcYDPymUzRAoVhUL6
 /z3Gp6xtjQjbUVHL9aBhQ5OmBgGQJXoYJt5HB45DaQiE9jiN11hFj/tVrcacSNw3FDAt
 /iliXElRacS7/4EJsVsCPPw78j4w1Vb7IzXOhoTqQEsxxS1p05Lyx8mkHtNGisvrPUnM
 rfGohYX1ZyQI/9DAKAgIZLw2bf6A5Zt6zrEOdrvUhsFL89ZpU6KJw/kIJg1kYoZlaXfL
 pqdR1R3Ff0CVUJU+8oyUDEqNVPVwlCrsRysWzuEtTGVZLGzwiBXVzOlJdtiRT5gX+g6n
 F78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790174749; x=1790779549;
 h=content-type:cc:to:from:subject:date:message-id:references
 :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eZIsXV7APNY0/LNrIPkmT3SkKNqmaGTb59jjgIpzWRo=;
 b=fVpEXiTnxbBzhEEYYPmJVZb5Fr18x9CSCLOhW+QHpRJelCQlmBMgcriRxR+HuoHZpG
 0Qvcibh7n/BnTRrOi3KxMdJ4VFcDCUWZdCHDvtnlW/uO7rBEq0Rc7ExTHq8jOeW+C7yK
 jVvyjzn2ml+YlPhKNhR0gjK+YGr2J4G1Usf4HhMnvcOs/33T+KmqANk3jS4n8suoFRor
 OZ81qA+mlBw0fkSQpEj5Ejier8MpyEEswFkjmVIJHDuZaDYFk1KnEzsoTdq524f09lZ5
 uWkRKoy9W5Kb1E1I4KyNIt6DZ7OdsIgYP8RSNuSyVD72qzHg+ADigpcJAA/4bgORyD2q
 2w1g==
X-Gm-Message-State: AFuF++mmKv/ydn0Vg5kgQd8aNLXUBQwQJlDjZQrSGMR+wu9OPVAW9emd
 yfmICBfz7gJVkMmmgOwrKgeXmdbGU+9ZawrSp1zlDXAQOYzgtwKzporP5DIdZ14D5eEdBwUBY5C
 sOSILjoZl7tFK/0OAgLx/NA==
MIME-Version: 1.0
X-Received: from plat13.prod.google.com ([2002:a17:902:e1cd:b0:2df:5c69:498c])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f549:b0:2db:8019:847a with SMTP id
 d9443c01a7336-2df69d24336mr25769755ad.9.1790174748576; 
 Wed, 23 Sep 2026 07:45:48 -0700 (PDT)
In-Reply-To: <179012898121.22786.2441732317511194041.b4-review@b4>
References: <20260909031146.1646684-1-stanleyjhu@google.com>
 <20260909031146.1646684-4-stanleyjhu@google.com>
 <179012898121.22786.2441732317511194041.b4-review@b4>
Message-ID: <18d7fa72f2e6781c.3137322e31362e3131332e313435.2bcce3.0000sendgmr@google.com>
Date: Wed, 23 Sep 2026 14:45:48 +0000
Subject: Re: [PATCH v2 3/3] hw/ufs: Implement Task Management Request (TMR)
 handling
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@gmail.com>, Jeuk Kim <jeuk20.kim@samsung.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Jinyoung Choi <j-young.choi@samsung.com>, Stanley Jhu <stanleyjhu@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Received-SPF: pass client-ip=2607:f8b0:4864:20::645;
 envelope-from=3HOazagoKChUDEv86zJ42F19916z.x97Bz7F-yzGz689818F.9C1@flex--stanleyjhu.bounces.google.com;
 helo=mail-pl1-x645.google.com
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
> > +                if (req) {
> > +                    ufs_clear_req(req);
> > +                    req->state = UFS_REQUEST_IDLE;
> > +                    if (ufs_mcq_req(req)) {
> > +                        QTAILQ_INSERT_TAIL(&req->sq->req_list, req,  
> entry);

> A successful UFS_ABORT_TASK does not complete MCQ host-side cleanup.
> The host driver will next issue SQRTCy.ICU, which must post an OCS =  
> ABORTED CQE.
> Please do not clear and recycle the request before that cleanup completes.

Agreed. In v3, `UFS_ABORT_TASK` in MCQ mode cancels the underlying
`SCSIRequest` and marks the request `UFS_REQUEST_ERROR`, deferring CQE
posting (`OCS = UFS_OCS_ABORTED`) and slot recycling to `SQRTC.ICU`.

> >      case A_UTMRLCLR:
> > +        u->reg.utmrldbr &= ~data;

> UTMRLCLR is clear-on-zero, so this has the polarity backwards: zero  
> clears the
> corresponding UTMRLDBR bit and one leaves it unchanged.  This should be
> `u->reg.utmrldbr &= data`.

Fixed in v3.

