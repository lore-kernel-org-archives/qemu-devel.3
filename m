Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 230A4C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 15:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtrCL-00074N-1m; Mon, 08 Apr 2024 11:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1rtrCH-0006zZ-P1
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:46:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1rtrCF-0000Yc-5b
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712591170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HmaTy7RzwiTrzqyQlzFn6u7qAk4tIQ/TPTCqPUj874Q=;
 b=GiFrth/8xQfstKa/aM2OeAouAs4cWlWbkDk3K5ieDAk1Ok4j64+fjDG0RqDoniJoN7qV1B
 ikC/nHLOMRTLKoqPrmT0bvvoo8/9xBiaPrdYZwu6VHMDuVa2AkM//q2YPoNtOnN72cGpu3
 VuPK0w0PB0K6yW82lD0Amnhu0vYw8Eg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-xTA3HP8qPvyqiiXvm-G9jg-1; Mon, 08 Apr 2024 11:46:08 -0400
X-MC-Unique: xTA3HP8qPvyqiiXvm-G9jg-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2a300d6a299so3126637a91.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 08:46:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712591167; x=1713195967;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HmaTy7RzwiTrzqyQlzFn6u7qAk4tIQ/TPTCqPUj874Q=;
 b=MMsHCIA+1Mcs3+j7LXx49eBsXfN5Hpj2zx8AcMX85yKD6hZzC//NH2TB/Iyrxkfikk
 a3b1ZESdybJ0kFwRTIKFxbFzhlwwL3RZWVM0iZzoGIBXv5A8wabDCFmgoT8v9387ataW
 liDwdERCMa1I5AovzqCcXtuPsHwBYKQJvRtvze3o0aMjP8tOXXGkAlNVc7W/0KdrKV74
 sqff1oVXJt3/w9xAlQC+JP6fQSx6PkRJYGwK3foq4bvUW9EM4gacUF+Tf3PZSfzp1jr7
 qjmThTpT1XbJXb4h+H/fly7ImPp0v/VJ63TVI1SpMwEqfWzCq4Ddm6CipbFzZ6cZ87vk
 2riA==
X-Gm-Message-State: AOJu0YzUFLuj1Lp/qLUxVikiqdmswf6gIgpDiBopmfW+neb7RmIxW1I8
 keUbegGt8yPQZTOXgoY+Y/HnS/Dn/iC5PcuiH3EjYgryR5R0EjtqFATAlU9rxwA6AZGyn+3orTE
 L4xRCYtl9j5Sr2KzouUcg1xDQWhKjlMj9LlRy2gEpfqKNoFtje9AxUgx78qgUHZlNf006Hw/sRz
 UMmkxH3jtpHTD37a7ldNwfLBOMhCM=
X-Received: by 2002:a17:90a:7289:b0:2a2:a9af:9197 with SMTP id
 e9-20020a17090a728900b002a2a9af9197mr6754914pjg.3.1712591167413; 
 Mon, 08 Apr 2024 08:46:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErwSfEjBExW7VxSzFCy1NJibXolREfZZOICL3c1PdhBrZO3WsTYoonj/ePWTAuTSwWPnH3hLEtK14vJ10Kgx8=
X-Received: by 2002:a17:90a:7289:b0:2a2:a9af:9197 with SMTP id
 e9-20020a17090a728900b002a2a9af9197mr6754892pjg.3.1712591167141; Mon, 08 Apr
 2024 08:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240408083605.55238-1-philmd@linaro.org>
In-Reply-To: <20240408083605.55238-1-philmd@linaro.org>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Mon, 8 Apr 2024 17:45:56 +0200
Message-ID: <CAA8xKjVPBu2LgsZzJhUM5Yjp1z36=w012-Nea+qPtDopkXeJRw@mail.gmail.com>
Subject: Re: [PATCH-for-9.0? 0/3] hw/block/nand: Fix out-of-bound access in
 NAND block buffer
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Qiang Liu <cyruscyliu@gmail.com>, 
 Kevin Wolf <kwolf@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Apr 8, 2024 at 10:36=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Fix for https://gitlab.com/qemu-project/qemu/-/issues/1446

Does hw/block/nand meet the security requirements for CVE assignment?

=3D> https://www.qemu.org/docs/master/system/security.html

> Philippe Mathieu-Daud=C3=A9 (3):
>   hw/block/nand: Factor nand_load_iolen() method out
>   hw/block/nand: Have blk_load() return boolean indicating success
>   hw/block/nand: Fix out-of-bound access in NAND block buffer
>
>  hw/block/nand.c | 50 +++++++++++++++++++++++++++++++++----------------
>  1 file changed, 34 insertions(+), 16 deletions(-)
>
> --
> 2.41.0
>

--=20
Mauro Matteo Cascella
Red Hat Product Security
PGP-Key ID: BB3410B0


