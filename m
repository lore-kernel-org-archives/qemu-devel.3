Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD955CA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 09:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqpgF-0008U2-21; Tue, 26 Aug 2025 05:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1uqpgD-0008TU-A8
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 05:09:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1uqpg6-0004Qq-Ju
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 05:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756199353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/cfDsxZe4qv/ganmSR9RYxMQCiiSFV1f4aPgNcl94gQ=;
 b=bpiujDsDkMLtZze5OZ/+nHu8NCxY/eoPP8dM2U87/Dp3kWZSETM27/0vcACxFuLdVkr7lS
 FCjlIxMUkLCRcLsQd4JlAe7FcSWHomCRs//EXJvpKI8Qi6LGbLar/YVndrdD+4HV0+nudA
 csN6KGThMdzSXTVlbuDOY6jF6gPeFyU=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-pzsREr58M6WrMl9UgOFyDQ-1; Tue, 26 Aug 2025 05:09:12 -0400
X-MC-Unique: pzsREr58M6WrMl9UgOFyDQ-1
X-Mimecast-MFC-AGG-ID: pzsREr58M6WrMl9UgOFyDQ_1756199351
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-7200af345a5so28460137b3.1
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 02:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756199351; x=1756804151;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/cfDsxZe4qv/ganmSR9RYxMQCiiSFV1f4aPgNcl94gQ=;
 b=exBvxUtu0wKpnO0f6cdFEGiylz5DCZi/aOHkpbQC+qh3HJ4RpU2M4sUTK4i/zHP1ni
 l+WHtdzyMzx+fiKO528McgFLEENyX47x9C2tNJUvdGlAf3pdU+S3IQAV1EfmxXSfLZDC
 MuZhcnvmdxpeA1pJr5yV78Njlg4qqWywUokOnEe4JQ8ccLZ0Kqy/EErBP6UKC6SOHW3e
 19C0xZ6OJvJEPiEMkNNB1P/T7h5/Z2cT8Ltrdnf2XToOiI8EYhykVZT2zeGjVepJrPWZ
 VmFsSTK44Eupb6krwYo1WFN41KHzbnI916wcJcNzNTJoQU/VDs5eBsYla7PWk0U3EInp
 GQ9g==
X-Gm-Message-State: AOJu0YzkfxeiY3HNguSP1qUNJLpNamFnOOn4CR3SZc4R7bDPWvspQiS2
 7KSuvfiKG66uIzOhchQwra/pTjcSGaQ0Sf8I+sQ1ZMu1N3fBIxWTSLWzPqpss3hkNxfd+lliAPJ
 qaNLF3YxsOJs+nX0J+tPF7Uga71Y0Lkfce6qDvep2TbOPdW/AmIcniBP7MApX0fX94kGORw08rY
 3cQ5jE6YXVj6bVOHrEehHWX3bFyk+qZY8=
X-Gm-Gg: ASbGncsFQEPDaiuinYiJ/Yj+s3pcIOj2of+2ZjO+LUWjwzUiloisFim0MWBSjiN2MVs
 qWGz7NLEt1SA+8H9HJoD7dJTsQSPrtBjfqG6V+KV+XRwjsNEy9ZjH94s5tnG7Qp+Ir+Ct3CYHdn
 avh1+oNdmF45lFoEJwFOzKfromQhuVJZnMoaJlqvo5zLxRMkaaew==
X-Received: by 2002:a05:690c:6c83:b0:71c:1a46:48f9 with SMTP id
 00721157ae682-71fdc3d0a53mr159842957b3.33.1756199351174; 
 Tue, 26 Aug 2025 02:09:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEP2H6MHG05/HcLrAq14EgMwZwuLDqDTzHVKXgtt61qbR0NPrppYW2ultsz8jz1SRucug3opZ29mP5mZbPWYs=
X-Received: by 2002:a05:690c:6c83:b0:71c:1a46:48f9 with SMTP id
 00721157ae682-71fdc3d0a53mr159842737b3.33.1756199350570; Tue, 26 Aug 2025
 02:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250825145241.170717-1-kkostiuk@redhat.com>
 <20250825145241.170717-2-kkostiuk@redhat.com>
In-Reply-To: <20250825145241.170717-2-kkostiuk@redhat.com>
From: Yan Vugenfirer <yvugenfi@redhat.com>
Date: Tue, 26 Aug 2025 12:08:59 +0300
X-Gm-Features: Ac12FXzVWe7CCrOlRKI7S9yPGPmogN9cIiu8ozzEyokwr1_FEfBk6-sTWlHZUl8
Message-ID: <CAGoVJZwBEJ86fszad4j5AhOwmm_YURNhmYSJZrjGx_bAAbD-Zg@mail.gmail.com>
Subject: Re: [PATCH 1/2] qga-vss: Replace asserts with condition and report
 error
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=yvugenfi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Aug 25, 2025 at 5:52=E2=80=AFPM Kostiantyn Kostiuk <kkostiuk@redhat=
.com> wrote:
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> ---
>  qga/vss-win32/requester.cpp | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
> index 4401d55e3a..bc260abb96 100644
> --- a/qga/vss-win32/requester.cpp
> +++ b/qga/vss-win32/requester.cpp
> @@ -347,7 +347,12 @@ void requester_freeze(int *num_vols, void *mountpoin=
ts, ErrorSet *errset)
>          goto out;
>      }
>
> -    assert(pCreateVssBackupComponents !=3D NULL);
> +    if (!pCreateVssBackupComponents) {
> +        err_set(errset, (HRESULT)ERROR_PROC_NOT_FOUND,
> +                "CreateVssBackupComponents proc address absent. Did you =
call requester_init()?");
> +        goto out;
> +    }
> +
>      hr =3D pCreateVssBackupComponents(&vss_ctx.pVssbc);
>      if (FAILED(hr)) {
>          err_set(errset, hr, "failed to create VSS backup components");
> @@ -579,8 +584,16 @@ void requester_thaw(int *num_vols, void *mountpints,=
 ErrorSet *errset)
>      /* Tell the provider that the snapshot is finished. */
>      SetEvent(vss_ctx.hEventThaw);
>
> -    assert(vss_ctx.pVssbc);
> -    assert(vss_ctx.pAsyncSnapshot);
> +    if (!vss_ctx.pVssbc) {
> +        err_set(errset, (HRESULT)VSS_E_BAD_STATE,
> +                "CreateVssBackupComponents is missing. Did you freeze th=
e volumes?");
> +        return;
> +    }
> +    if (!vss_ctx.pAsyncSnapshot) {
> +        err_set(errset, (HRESULT)VSS_E_BAD_STATE,
> +                "AsyncSnapshot set is missing. Did you freeze the volume=
s?");
> +        return;
> +    }
>
>      HRESULT hr =3D WaitForAsync(vss_ctx.pAsyncSnapshot);
>      switch (hr) {
> --
> 2.50.1
>

Reviewed-by: Yan Vugenfirer <yvugenfi@redhat.com>


