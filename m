Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4053CC2D0CD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 02:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFkNi-0000j1-JU; Thu, 15 May 2025 22:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uFkNg-0000de-Tt
 for qemu-devel@nongnu.org; Thu, 15 May 2025 22:01:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uFkNf-0005AK-Gu
 for qemu-devel@nongnu.org; Thu, 15 May 2025 22:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747360858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3DNWY/FTBOYs/W2XrBpPzm7RKkTnq/K/cOjVCnmKhbU=;
 b=MHevl+jX1bAWzumTw/LnrmgqeIRy76wDtfkoLqGl5z+0kfMLJsFT2qwOkTsvEzxMwbryYw
 y0TdsP94JUfxqNMbuYX/WeBoyFG1pZpOjp0ZfpCtYWHUKYF4/y56lg6SUE7Aqn8fIw2T1G
 A4+CWWAjyW2TCPfSmj41gE9kS0EMGvw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-pbav8uvBM2yTkWCSUYNzFQ-1; Thu, 15 May 2025 22:00:55 -0400
X-MC-Unique: pbav8uvBM2yTkWCSUYNzFQ-1
X-Mimecast-MFC-AGG-ID: pbav8uvBM2yTkWCSUYNzFQ_1747360854
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-30aab0f21a3so1786369a91.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 19:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747360854; x=1747965654;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3DNWY/FTBOYs/W2XrBpPzm7RKkTnq/K/cOjVCnmKhbU=;
 b=eGQqFzTH5NAFGdJ6lBOKtiaw24UT4AS89SBA+wKpBlN/ZvKrv/awEaG8p0rfAXh0kb
 ihrhZR5xTg72vTy/+J5JdIXqLN149ZhPcte/Jj1KXZD3q7GP0pNLnEMRYRe2UfJXDseM
 mAw2exIJVR5HXHFIIFARQX3gTMDSSJtrd66vpDlZ1WVY9dKzvFJTlJK+Mp0RKyczz0Z8
 FLL6Za66Ime0NWosA6/bEcSuP1XX+Qcaj+CXfkUvtPmdVH+/vusCd+1fi2E9YLXEONck
 /UVaapS+BIqA0OPeGlfDKWXjYMx1W56Eg4QPILKQYT7e7gwMxFP2GjOVCi1F/5kg2Ora
 1X1Q==
X-Gm-Message-State: AOJu0YyXsMSTJcGfMuLEovXhwj3d7yl9wSt8izWOc2MfpXqLocE7y6zl
 34sdYObeIgOtZ/XokPoieIXlhh6CuNY+QKLgB7AGN8phkUAVBtCWIZxxAkdslJLYrRVCVv4uRvC
 EZSCRHr3nlBpTpyaGZRbr9RO53Vcg0+QzeCpSlbOWCvzevimP1cg7WQD2MygrxD2KiDfi+fF6xV
 UW6zqMJeIEc2lTPk0GI6RP8keRiGu9iE4=
X-Gm-Gg: ASbGnctcO62g9hyQNv/r9jYgqhXiZewE/V/hI+lhnhUTkqdekn294zbRMv7Rm8mWwSU
 36D2bSTbHFyh8XsxfnwbeplD+TNKlFYRhexwQxH0iVF8rbg3+mCfiNrvh5cO0wFc/dPQcVw==
X-Received: by 2002:a17:90b:3905:b0:2ea:a9ac:eee1 with SMTP id
 98e67ed59e1d1-30e7d5220e7mr2326877a91.10.1747360854501; 
 Thu, 15 May 2025 19:00:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE51hCUwmbMkm2htJFhtkxWZf6PKYzTGi7RtC6NKa19f5oVPMp97ZtO3joCCtrHdm/Uw0bFhjk2TZwvklE+pHs=
X-Received: by 2002:a17:90b:3905:b0:2ea:a9ac:eee1 with SMTP id
 98e67ed59e1d1-30e7d5220e7mr2326833a91.10.1747360854127; Thu, 15 May 2025
 19:00:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
 <20250507184647.15580-5-jonah.palmer@oracle.com>
In-Reply-To: <20250507184647.15580-5-jonah.palmer@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 16 May 2025 10:00:42 +0800
X-Gm-Features: AX0GCFth9sEHnSKxeOIaJVtrc6LOrZ5fL6dZeCCvQsGWvzTh5F5udKbdUx_Xx-I
Message-ID: <CACGkMEvxacfJFFsXJeQ0NPT_LVFEs_zyzNqR0xxntXD8J5nSpg@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] vdpa: add listener_registered
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, eperezma@redhat.com, peterx@redhat.com, 
 mst@redhat.com, lvivier@redhat.com, dtatulea@nvidia.com, leiyang@redhat.com, 
 parav@mellanox.com, sgarzare@redhat.com, si-wei.liu@oracle.com, 
 lingshan.zhu@intel.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, May 8, 2025 at 2:47=E2=80=AFAM Jonah Palmer <jonah.palmer@oracle.co=
m> wrote:
>
> From: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> Check if the listener has been registered or not, so it needs to be
> registered again at start.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


