Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E33C47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 18:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUWBI-0007cn-Jb; Mon, 29 Jan 2024 13:16:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rUWBH-0007cQ-9m
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 13:16:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rUWBF-0007Bj-AE
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 13:16:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706552183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LWWwC8vNNha78B5htj+pRWAH2bKWh584i9j/V+MCDuQ=;
 b=K5XDA++vObgZYxVhgpOHYnL1IHbz8whT9vaaKcRjGK3AD+qSjhSpJRLkAqfRPVt6Ay6lJw
 uDp6UUwYlLa/yPNmMYvZtpt359RNIQ8HAp011C0qRg3ujEAbnqNARE8x2+uzPPVUKJsA/d
 snIiweSkXeHUd6l7d86BRTHMGW9IFsk=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-sVODhKYSOsWc4gNnKw4gfQ-1; Mon, 29 Jan 2024 13:16:21 -0500
X-MC-Unique: sVODhKYSOsWc4gNnKw4gfQ-1
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-4b78e56d741so531838e0c.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 10:16:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706552181; x=1707156981;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LWWwC8vNNha78B5htj+pRWAH2bKWh584i9j/V+MCDuQ=;
 b=njliSfTxty3y7vS4kQpqH7qEE2TTHSl2gRXqpVRRu0ZnHE7V/VCFhsCqZwNipjOHK2
 WHYwezNuj0YWkwrBMC/P861wzlbRhRxW+rGzovjnV1IlvIUWKKCbFwhMqH340bf/jGhX
 Uvq2x6Scl1NlT5nlJVp7KcDBtaNq586eKPOxUNfY3RaOLFJ3yuMOKiAlAc2lx+3c721B
 a9VMg8wBP5p4cVpqffH6les4oOhBzq89meQbmFYtCVYBSmz3VAV5BGYFvRjRM7kb2Upt
 cY3IOjxGWgiuY4nfGP7/fl8KFGbLvMzqS4WITfLRLXOLTg8yB8BsmNzII60Yz0uywuEK
 CYdA==
X-Gm-Message-State: AOJu0YzQoruM3k6PoMLRkPP0Zyj+F+eV6J5W4I9asAkNSl9o3N7jwOsu
 ymMkPf12ruwJnf5x+tx60aOE86garLnjN6osaK7qLk4eytYZhS7/9fz+fdoZ+ZLXhGKhBje5GS/
 kW1LF++en7CFlsjwUEK+IIp2n6rCt74KQN/Uszlb1kkT5lJE2pAwsAqEe/pv9wFKm8NcYa2GHE9
 TgxspD3Go+VR0HfZMAHp1HoqdkMVg=
X-Received: by 2002:a05:6122:2f8:b0:4bd:3d36:5836 with SMTP id
 b24-20020a05612202f800b004bd3d365836mr2149656vko.2.1706552180869; 
 Mon, 29 Jan 2024 10:16:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFX9dXZI1dN04NFB1ht9AGlb5etyzBw5ScEF1KpeJ6yB3NnpWiX3br7UdU+GIjWeNL2kfR0PRZuOTK+jk0TkI=
X-Received: by 2002:a05:6122:2f8:b0:4bd:3d36:5836 with SMTP id
 b24-20020a05612202f800b004bd3d365836mr2149643vko.2.1706552180571; Mon, 29 Jan
 2024 10:16:20 -0800 (PST)
MIME-Version: 1.0
References: <20240129133751.1106716-1-pbonzini@redhat.com>
 <03B07185-06C2-49E9-8E70-D2499D2238A7@gmail.com>
In-Reply-To: <03B07185-06C2-49E9-8E70-D2499D2238A7@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 29 Jan 2024 19:16:08 +0100
Message-ID: <CABgObfb9+6JeMnEDx8kQOnybiuhmQfc-PpgVpTxf=4C9VCCNbQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] mips: do not list individual devices from configs/
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Jan 29, 2024 at 6:48=E2=80=AFPM Bernhard Beschow <shentey@gmail.com=
> wrote:
> Am 29. Januar 2024 13:37:44 UTC schrieb Paolo Bonzini <pbonzini@redhat.co=
m>:
> >Back when Kconfig was introduced, the individual dependencies for MIPS
> >boards were never added to hw/mips/Kconfig.  Do it now.
>
> There is also: https://patchew.org/QEMU/20230109204124.102592-1-shentey@g=
mail.com/

Oh, that's a pity. Looks like your version doesn't apply anymore, but
we can salvage "[PATCH 2/4] hw/mips/Kconfig: Remove ISA dependencies
from MIPSsim board" which is slightly more complete than my version.

Paolo


