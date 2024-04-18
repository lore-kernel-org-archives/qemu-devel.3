Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B725CC04FFE
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 17:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxVhG-0003Wv-3u; Thu, 18 Apr 2024 13:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <josmyers@redhat.com>)
 id 1rxTyE-0000U2-42
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 11:46:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <josmyers@redhat.com>)
 id 1rxTyC-0001uQ-Lo
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 11:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713455199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ov1WXLnemUYaSKFkvhIDkT/3e4WgdUo/19ew4snWUJc=;
 b=bEvVp6i8yvNtmjxelx25rJ2iCWIuBwszmuHng1Zf2Reelz2IDY3p2/MZCXk8jyXmXn7t0P
 v+uA2Km7ChRH6+Z1HA52cBwioYsH96ryWp4pSX+MQb4INu6Gu+mYP/jtrnLEW1DmxoJhYR
 vQS6n0Bc0nf2J7yJHJcU41aODgfrSWU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-_uw_aMFBNnKw0jrOZJLUtA-1; Thu, 18 Apr 2024 11:45:30 -0400
X-MC-Unique: _uw_aMFBNnKw0jrOZJLUtA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3497e65c31bso338889f8f.1
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 08:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713455129; x=1714059929;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ov1WXLnemUYaSKFkvhIDkT/3e4WgdUo/19ew4snWUJc=;
 b=cWDnCDOrNB0A245xU4+rO2n2cjkq2vJYcB0W8hZDXt8D0VYIY4UgRil4LdS8zBBLg+
 LNXHw7n3keIIe7Qkoyw6UsB4gNaZmzQMrpEpIWF64ZWp/UpdfuBIAsAy8eljOr4Hx14V
 TMZ90QLteEwf0NzyTeZhXpsPsRBwI8gjdaLEGoyatiZZwHOelavyRj+BL8UDvmKvOuo/
 GcomfhsFJtcBpv/spVCjDtd3fFlNhh9DHQNSLRmY5QYYHRTLj9tCt43bM4RWZZnT4fZd
 Ma8S+7CGLJ9usJ28+J84To7k+BOdvpsLvX9I1KGk1Dis/4HMcdUXa+oipE8lnDI/iGS+
 JA6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhSp00BjN6HYw6iWfUOs6trNf8ajAfi3AMteiBTqsuMMqZU1kDHkfCWXNfMN6VV2U6P+cHYqugLBkStjJahnU/WDqgpsA=
X-Gm-Message-State: AOJu0YxyQyuqI9yxGt+B6zLT03+UV6A3OOJLAOS7UCnn9KwhV/PDi57G
 2mpQgZgqb0lufEjPNhY0hDuwi88jE4bpog0SF8dmZSI7g8QqTQnGY+WMK1W2z55BTHA8koghuOI
 Y4DEkzwspAtwANEhXcuPTspeqapNqh3Ce7K3VImViQm0ii8IbIFaM
X-Received: by 2002:adf:f450:0:b0:343:78da:9817 with SMTP id
 f16-20020adff450000000b0034378da9817mr2402183wrp.68.1713455129568; 
 Thu, 18 Apr 2024 08:45:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIA835ZoskMaOmxABRMTTi65uy+ZkxlzbTtSQMldO0m9a8qnHQQ62p/Xg8s87wIXaX3dhFgA==
X-Received: by 2002:adf:f450:0:b0:343:78da:9817 with SMTP id
 f16-20020adff450000000b0034378da9817mr2402166wrp.68.1713455129140; 
 Thu, 18 Apr 2024 08:45:29 -0700 (PDT)
Received: from digraph.polyomino.org.uk (digraph.polyomino.org.uk.
 [2001:8b0:bf73:93f7::51bb:e332]) by smtp.gmail.com with ESMTPSA id
 d21-20020adfa415000000b00347cf86dee6sm577194wra.71.2024.04.18.08.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 08:45:28 -0700 (PDT)
Received: from jsm28 (helo=localhost)
 by digraph.polyomino.org.uk with local-esmtp (Exim 4.95)
 (envelope-from <josmyers@redhat.com>) id 1rxTwK-00EFDZ-HH;
 Thu, 18 Apr 2024 15:44:44 +0000
Date: Thu, 18 Apr 2024 15:44:44 +0000 (UTC)
From: Joseph Myers <josmyers@redhat.com>
To: Sandra Loosemore <sloosemore@baylibre.com>
cc: gcc@gcc.gnu.org, binutils@sourceware.org, gdb-patches@sourceware.org, 
 libc-alpha@sourceware.org, Chung-Lin Tang <cltang@baylibre.com>, 
 andrew@reenigne.org, Yao Qi <qiyaoltc@gmail.com>, 
 Dinh Nguyen <dinguyen@kernel.org>, qemu-devel@nongnu.org, 
 newlib@sourceware.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: Deprecation/removal of nios2 target support
In-Reply-To: <55a1bc52-b435-463e-8be1-4b23e44393a0@baylibre.com>
Message-ID: <b5d375ed-283-974a-febf-892760ff855@redhat.com>
References: <55a1bc52-b435-463e-8be1-4b23e44393a0@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=170.10.133.124; envelope-from=josmyers@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 18 Apr 2024 13:37:15 -0400
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

On Wed, 17 Apr 2024, Sandra Loosemore wrote:

> Therefore I'd like to mark Nios II as obsolete in GCC 14 now, and remove
> support from all toolchain components after the release is made.  I'm not sure
> there is an established process for obsoleting/removing support in other
> components; besides binutils, GDB, and GLIBC, there's QEMU, newlib/libgloss,
> and the Linux kernel.  But, we need to get the ball rolling somewhere.

CC:ing Arnd Bergmann regarding the obsolescence in the Linux kernel.

-- 
Joseph S. Myers
josmyers@redhat.com


