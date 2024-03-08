Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717CEC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riW3q-0001bE-83; Fri, 08 Mar 2024 03:58:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1riW3d-0001Yn-RV
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:58:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1riW3c-0000ZF-Ds
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:58:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709888303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/T6iFMZP1/3l2P+JZenx53zF9mkbqgaCFlVX2Aoohe4=;
 b=EIOoE5796eLDw8DYVWi/8awlDdslTupsKZo0+fAO2UppSzelSo2flaeFNafA1LCpD6d3qn
 OyWmATxdnMeni53xEMfC7WCDMpkSlPD8spyi9TMhgvRzFZYiYe1ODS2WOCElCJPhB3fZxb
 Xcn6atwPnufNjeai6nkPrjENCUFvgmI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-yfyxMmtSNTq71q7xEPtAYQ-1; Fri, 08 Mar 2024 03:58:21 -0500
X-MC-Unique: yfyxMmtSNTq71q7xEPtAYQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-412de861228so3535275e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 00:58:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709888300; x=1710493100;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/T6iFMZP1/3l2P+JZenx53zF9mkbqgaCFlVX2Aoohe4=;
 b=SBnmdEYOSkG1S0ckCVNcMf/hBg0YMPFBwXR03OoqW3mMLDQufbzo/H0UNjcsJL3dGj
 SvcU1zAW3mCvg3pExvkX8kHgvavQ5IiIjUVBHg47FjJhXZ4H8z2ZOF4/xmr3z49LZV1N
 CPFUtJaLex5DAb6WLBVEZOyS1nudPvqdeFS/heHorDfP3V+UI7uBKst1ch/dxTFq/Mvs
 PyHnb6mB32NqczH4Fc+Q0QNY7awtG4ENz2j3hpWHAONUeb7WBlDdVJQAToCEpZRAJyZO
 uo+kpJzjxAJT1sYFWnYlT4/rR2+YvOO0VxtiqC0mlMXCzo9sncHWNJ/frZkbOTn0/12e
 MDGg==
X-Gm-Message-State: AOJu0YwBIAwza1+M6AAngL4jTHnovqTxHJ3S9g+rE4LfXgqkHhDvrgbT
 ssvGtjOXD+jFDZAbY2CpXuxx/dsmQ0foWa7Lkr+L3u49CW0UzUDZPWcu9cYbg4Onmivz+EJfXtN
 F89sfOwNvUtU+G3hIHMDd1UmJg1e+w/aVFOvkd+sv/UYmnglngvCEG9E3HjGR9APlMIyPESTTFk
 xD30qon+GwFUSUC284gnHzburCS7xYKY5q580=
X-Received: by 2002:a05:600c:5488:b0:412:d493:19a3 with SMTP id
 iv8-20020a05600c548800b00412d49319a3mr13072141wmb.12.1709888300113; 
 Fri, 08 Mar 2024 00:58:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtxPiv4cKTTMwQ4ZS0H78X8PB3IfFhdUcTXXJzzgwpJK51raRSbnFk2oQcsVzCXNGj/JIjdQ==
X-Received: by 2002:a05:600c:5488:b0:412:d493:19a3 with SMTP id
 iv8-20020a05600c548800b00412d49319a3mr13072128wmb.12.1709888299699; 
 Fri, 08 Mar 2024 00:58:19 -0800 (PST)
Received: from [192.168.100.30] ([82.142.8.70])
 by smtp.gmail.com with ESMTPSA id
 t14-20020a05600c198e00b0041312c4865asm3555242wmq.2.2024.03.08.00.58.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 00:58:19 -0800 (PST)
Message-ID: <a7da540b-495b-4cb6-85aa-3b122e71356f@redhat.com>
Date: Fri, 8 Mar 2024 09:58:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] e1000e: fix link state on resume
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
References: <20240308085643.1264964-1-lvivier@redhat.com>
 <20240308085643.1264964-2-lvivier@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <20240308085643.1264964-2-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 3/8/24 09:56, Laurent Vivier wrote:
> On resume e1000e_vm_state_change() always calls e1000e_autoneg_resume()
> that sets link_down to false, and thus activates the link even
> if we have disabled it.
> 
> The problem can be reproduced starting qemu in paused state (-S) and
> then set the link to down. When we resume the machine the link appears
> to be up.
> 
> Reproducer:
> 
>     # qemu-system-x86_64 ... -device e1000e,netdev=netdev0,id=net0 -S
> 
>     {"execute": "qmp_capabilities" }
>     {"execute": "set_link", "arguments": {"name": "net0", "up": false}}
>     {"execute": "cont" }
> 
> To fix the problem, merge the content of e1000e_vm_state_change()
> into e1000e_core_post_load() as e1000 does.
> 
> Buglink: https://issues.redhat.com/browse/RHEL-21867
> Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   hw/net/e1000e_core.c | 56 +++-----------------------------------------
>   hw/net/e1000e_core.h |  2 --
>   2 files changed, 3 insertions(+), 55 deletions(-)

v3:
   - remove e1000e_autoneg_pause()



