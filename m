Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC6EC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 09:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rogdn-0005Nw-8A; Mon, 25 Mar 2024 05:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1rogdl-0005Kg-7h
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 05:29:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1rogdj-0004vN-PB
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 05:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711358950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zmXV4SiLYQYWMbWbHcdvJ8rcpu+p+khce/OBkImO5wc=;
 b=hVWkjYp+yMMtnU2EzZyMhVU4bLuSyzEeSOP8zwmOoxHc3n2QVwLdpwImIXEFP5SXTV4Pl+
 buNV0BwmM/JcZu++xraA+jW5jE+syJQid3Ap923Lh7uYe191RzWloJTFyYrOQ8khrN3WB1
 rXR+eh+U6RxCIIig7AIeTNW9z947uDA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-9-3WzrfINMOa4eRbldDRDA-1; Mon, 25 Mar 2024 05:29:02 -0400
X-MC-Unique: 9-3WzrfINMOa4eRbldDRDA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a4734b06d63so197219966b.3
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 02:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711358941; x=1711963741;
 h=mime-version:message-id:date:references:in-reply-to:subject:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zmXV4SiLYQYWMbWbHcdvJ8rcpu+p+khce/OBkImO5wc=;
 b=uZU1PWajD0mK/zcPmr35YsiTlUCHCnRZ9NJ2rU1PhG2WB79AeCmU0w+fnzw0enMIxG
 g/s6gxdBNns0mx6Z/tuYu2nGhB5ofYpX2j2PhPCGSNFBPKM4skw6oSio74/RW56fX6ho
 LPJHckQtxko9sBvfCe+ektZq4pwbQu8W3ekQd7gSK74LmTpDcm1dTGu/+Ouxtv3Xsd8T
 DXWHKfw69xJ/iKX+RIOwmwYuZh6yReRsQS4ykTANMXaFSQlU8+wlepeduSK2NrnKXaes
 pgPQ1PE1K4uUGCu+21CsLsvsIlzCZbQoc1JmqMQISnQViQzVgHOzu4PknGTmXaGMxYJG
 0Dig==
X-Gm-Message-State: AOJu0YxZAM7O4OTn8Fvx1Nc2S71c/DEs0nBa9Mmmvf1+aUHUciZNki/d
 A1Z5/UsamSTBg4BJH6mFtYCoMIl/PIXKfC1Z1BNkT2GlfSw6LLYic6usfPPUKY3loHiAnbvSaYX
 5fY4tQGHpzzKr/w6f3cYYky5/yLZQqu+lsFctsg5QQq5WapcacFve
X-Received: by 2002:a17:906:d1ce:b0:a46:e81e:5543 with SMTP id
 bs14-20020a170906d1ce00b00a46e81e5543mr4344268ejb.39.1711358941370; 
 Mon, 25 Mar 2024 02:29:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZYO5aeJ/7J8m2XUUvTGrXm3KRJInu/P18Hyzht51cIvPKXevWXSBiYj5T0SclKLh3mSVVQQ==
X-Received: by 2002:a17:906:d1ce:b0:a46:e81e:5543 with SMTP id
 bs14-20020a170906d1ce00b00a46e81e5543mr4344263ejb.39.1711358941063; 
 Mon, 25 Mar 2024 02:29:01 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
 by smtp.gmail.com with ESMTPSA id
 ao11-20020a170907358b00b00a4a377ee13asm727054ejc.218.2024.03.25.02.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 02:29:00 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RESEND v3 0/3] i386: Fix Hyper-V Gen1 guests stuck on
 boot with 'hv-passthrough'
In-Reply-To: <20240305164204.525575-1-vkuznets@redhat.com>
References: <20240305164204.525575-1-vkuznets@redhat.com>
Date: Mon, 25 Mar 2024 10:28:59 +0100
Message-ID: <87ttkuk6ck.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Changes since 'RESEND v2':
> - Included 'docs/system: Add recommendations to Hyper-V enlightenments doc'
>   in the set as it also requires a "RESEND")

Ping)

>
> Hyper-V Gen1 guests are getting stuck on boot when 'hv-passthrough' is
> used. While 'hv-passthrough' is a debug only feature, this significantly
> limit its usefullness. While debugging the problem, I found that there are
> two loosely connected issues:
> - 'hv-passthrough' enables 'hv-syndbg' and this is undesired.
> - 'hv-syndbg's support by KVM is detected incorrectly when !CONFIG_SYNDBG.
>
> Fix both issues; exclude 'hv-syndbg' from 'hv-passthrough' and don't allow
> to turn on 'hv-syndbg' for !CONFIG_SYNDBG builds. 
>
> Vitaly Kuznetsov (3):
>   i386: Fix conditional CONFIG_SYNDBG enablement
>   i386: Exclude 'hv-syndbg' from 'hv-passthrough'
>   docs/system: Add recommendations to Hyper-V enlightenments doc
>
>  docs/system/i386/hyperv.rst | 43 +++++++++++++++++++++++++++++++++----
>  target/i386/cpu.c           |  2 ++
>  target/i386/kvm/kvm.c       | 18 ++++++++++------
>  3 files changed, 53 insertions(+), 10 deletions(-)

-- 
Vitaly


