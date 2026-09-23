Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AA0C98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 02:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9CKV-0006x2-LU; Tue, 22 Sep 2026 22:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1x9CKT-0006wV-Vy
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 22:03:26 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1x9CKS-0005QD-7u
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 22:03:25 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 d2e1a72fcca58-86e6d007703so288832b3a.0
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 19:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790129002; x=1790733802; darn=nongnu.org;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:content-type:mime-version:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tT3XcpteHL1qFMRKmef4INGwugBufELoSPJJ4W9iP9w=;
 b=KLkPuo1yPZQiLtyHFFygiq+7VYVTNvv8trP5R4Ubugk9qBX5psMQ67rrVGXd1fUAAs
 Gm4zTyTK5jw27dj14QX37kYvrL5d83IeNIHyqE3GdiWRxygHGDinlslGeEeZaep2cUng
 IJcKSP4Ix0KyeTzW/EVACFwubOC0D9mU9m096LPl6d6twYT6nxAJ6yi6TLaet9DY6IBU
 T3SSnIN1EhF2nzM+GL0TD+ZS+AjjkIWUVnxElFDQnxuFSaoRABhWRggP34Zo7H7p7WIY
 /6T5lYaU9FenI+jBKsCNJBuW2MXRDbh6Ydjjxft+rMrFTnjZ2VWxHaM0OIRid+eDfYkQ
 +zIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790129002; x=1790733802;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:content-type:mime-version:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tT3XcpteHL1qFMRKmef4INGwugBufELoSPJJ4W9iP9w=;
 b=g/pL/Hs0y5jzWdfkMoU3ZNHwKK1/NMBdHKwE9BEFYtf1oNN2hNLfEP15zyCcP9T0K2
 RTlrAvrjrNlwe/WqO4YJltutOfDbRBOoJWBTUlzdKUXuPNhGiDwZxSC/Z1tQviSOnxy1
 MnqnitjxwA3z2MaP1D8fVP4maBwxUh0QZdKkVemckHGC9r1VPC5+TKxI0pFrpS2e/9SF
 Hba+az4NL927/HQuIrJ515xRobj2+WG2IJwwz/FfOaVpX1AOpgYKpIXrkf35KdmPIEwF
 J6ASxIlaAxalTdVxZ+/BLGFldefgGx24GNgVHKiTRi9wKrGH1EpibP9iCxgKTldKR9PB
 zHRg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzfOMHLwCch3HZ2EQATbs8bmdPB/jCqhvycmOe2NX/q+hnDjzV1yR0UMPUogKQDX0d3Bhtozc5qz34m@nongnu.org
X-Gm-Message-State: AFuF++kPSvz97X1nguLe3RMTctAuD32YYWeYKzywaKz9MXYCxk0wYLPd
 rYwW0pujvloMQFWUqFFkeHL/Qthyj5m2J1E4P2rqhiIEHkmB/1GprMVO
X-Gm-Gg: AYBFou2J6MPJtami6uqi3K3JXsuYFAfOMGaC29xIbOaO4WXkgINafR7quYJlF++UPjy
 eCdL3FOUNWVHam5GXUKJYz1Xx2QGXaciH4YiuF2IA5PdLoDd07OYJnqNVNWtD8ZTbHEnnwJORPv
 EdrU/xYiKNMOAVNoyEft5tb+VJph8rflVEF6TaA+DWv+TpeREgB7J7L49Ef7jw0t463wlaYnU+X
 6TBrGmcHl9vFEJZt8DD9+8IVyvN6+In52Flcm+N1vHAT7W87FxNPCvKgXkMKF92u1RbzC2TMnsU
 1i8NW3Hd0P0qWUIHtViP3qwfAgewuky5c4lyqyFg77Hw9S7WvLOF+ZJoY3QGCs9rgoS6SLKp+W2
 8HO/FIHrZHq0+zIzxaOWwUCeAMtbVuYSH2Js5SA0NN30cCRgfyJEjmOHJ7kpLnS05u2XNzdVhbO
 TpkC57DVy8rqLpkjz8PH6NfPCDy6TjPJ/B7wIq2cqx8EzOUPBcxh+9rgOD3jN7S+TVV3hF+MunY
 A==
X-Received: by 2002:a05:6a20:914b:b0:3b2:a809:1000 with SMTP id
 adf61e73a8af0-3ddf7cfc09cmr1324054637.3.1790129002060; 
 Tue, 22 Sep 2026 19:03:22 -0700 (PDT)
Received: from [127.0.1.1] ([211.226.54.223]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc75f3f0915sm299988a12.21.2026.09.22.19.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 19:03:20 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/3] hw/ufs: Track SCSIRequest and cancel pending
 requests in ufs_clear_req
To: Jeuk Kim <jeuk20.kim@samsung.com>, qemu-devel@nongnu.org, 
 Stanley Jhu <stanleyjhu@google.com>
Cc: Brian Kao <powenkao@google.com>, jeuk20.kim@gmail.com, 
 j-young.choi@samsung.com
In-Reply-To: <20260909031146.1646684-2-stanleyjhu@google.com>
References: <20260909031146.1646684-1-stanleyjhu@google.com>
 <20260909031146.1646684-2-stanleyjhu@google.com>
Date: Wed, 23 Sep 2026 11:03:01 +0900
Message-Id: <179012898120.22786.14112595690493270605.b4-review@b4>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pz2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 09 Sep 2026 11:11:44 +0800, Stanley Jhu <stanleyjhu@google.com> wrote:
> In the UFS emulator, outstanding SCSI requests are dispatched asynchronously
> to the block layer via scsi_req_enqueue(). When requests are cleared or
> aborted (e.g. during HCE reset or TMR aborts), ufs_clear_req() releases the
> scatter-gather list without cancelling the pending SCSIRequest. If an
> asynchronous AIO callback completes afterwards, ufs_scsi_command_complete()
> dereferences stale or freed request state, resulting in use-after-free
> hazards.

ufs_clear_req() currently releases request resources; it is not responsible
for cancelling in-flight SCSI requests. Its existing callers ensure that
the request is no longer in flight, so the current code does not have the
UAF described here. Please describe this as preparation for TMF support.

>
>
> diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
> index bdb1650851..a62ebb51fd 100644
> --- a/hw/ufs/lu.c
> +++ b/hw/ufs/lu.c
> @@ -173,6 +173,12 @@ static void ufs_scsi_command_complete(SCSIRequest *scsi_req, size_t resid)
>      int16_t status = scsi_req->status;
>      uint32_t transfered_len = scsi_req->cmd.xfer - resid;
>  
> +    if (!req) {
> +        return;
> +    }

Can we use assert(req != NULL) here? We only clear hba_private in the
completion and cancellation callbacks, so req should not be NULL here.
If that invariant is broken, it would be better to catch the bug with
an assertion than to silently return.

> @@ -190,6 +196,11 @@ static void ufs_scsi_command_complete(SCSIRequest *scsi_req, size_t resid)
>  
>  static void ufs_scsi_command_cancelled(SCSIRequest *scsi_req)
>  {
> +    UfsRequest *req = scsi_req->hba_private;
> +
> +    if (req) {

Same here: can we use assert(req != NULL)?

-- 
Jeuk Kim <jeuk20.kim@samsung.com>

