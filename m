Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F3BCAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 14:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4K2e-0001na-L0; Thu, 02 Oct 2025 10:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v4K2W-0001jV-Oh
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 10:12:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v4K2I-0001Gs-TV
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 10:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759414307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4sGRdRuOyyivfnn+8H0fkWxGsTPt5iOxzHuw6hrltic=;
 b=cnJVlFY2npzPCtii917wLh4EG4Qft/vjfzQwckKbU4Vb2HhcLgPeLimE/7bdvnc1pwzg7T
 ibOYDIkwxe8lkwgAm8KnVoBIPY24fJzYRxupPx1e+654/qMYIjMAaxDMqgEjK2Nub0kILR
 OXVm7Xy5DlV1Zth3aI6G2bkejQlVPVU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-qt-pyCKqNVWVvyDfcNqvFw-1; Thu, 02 Oct 2025 10:11:46 -0400
X-MC-Unique: qt-pyCKqNVWVvyDfcNqvFw-1
X-Mimecast-MFC-AGG-ID: qt-pyCKqNVWVvyDfcNqvFw_1759414305
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e375dab7dso4562865e9.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 07:11:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759414305; x=1760019105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4sGRdRuOyyivfnn+8H0fkWxGsTPt5iOxzHuw6hrltic=;
 b=w7ywuHkfzU6oWOzKy/iadriHJcll5588GB+BCjTc8lJ2iLTBRBNECHhu0HGfiyiQ0p
 NljwujTVfPcJvdK9NgC1LsPoF0FHpiMNbEiYAmpYeeF5PiERH2Elutmc9lz+ZYEhwbZy
 3tDcBjCrsHYhU7v+bka1G6rfWuarpBws9gkPw7p5IEwbF3pyHB8/6VdErIWIzDdSrBtp
 G9SzPsi869tlvabc4BIAjJ7yCB8bk5YL/JlmggEibMjx/r4ccFZoaKSrGhXpcvM4DbY1
 Z1SJBhushBtSv6lxRGuWy+5ohg6kuPAP8j/+L3ZnlVDWw2lxC6QcsqwIHr+3+ybsHQQ7
 WEuw==
X-Gm-Message-State: AOJu0YwIte/hhQS8/xbBo6RYBRBEFAGiqdkD4wneSHOrNI4i5UwzCj/l
 mtCN88CEKAo+z7ho/TbkMreThMX+8S9RHMBOznW5mh3saP6d1Qj7CoIHlbtjmBrgGjSh1vbjsmU
 dJLdCvwP38V3PqZcxr8WvEPvz2t7X1ED+PNSs8lFLw+R2zqXdvXA02ric
X-Gm-Gg: ASbGncsWyqY5wyYcql5DvR5rBDYaEJ93ljx9ndT7TXTBACd9KkdjM507I9t/2PY0fnL
 ljgynD0RNUocrwI0ZmvELViQTtm8VavWGKwu0Mew/ui/qiQve/9K7PjCOFQzyMfoK4ffh2+Bhn7
 idw8Q172+BESRyOwz6QaXh2//2q36QBq6wiw2cWfrG0sFreTRlWkyB2Ph4CcMrGMbt4eL85Ib2M
 xvDWFtIPFhoPOkvjCiYPI2A5/cOHRdqih5KcoiSI4pS1ZMUG4kWr62whFcTajNRdJYgU96NBHAT
 Wv/RhwBlPHvkGH8QE4MaqdC+VGqYqGRABq0o
X-Received: by 2002:a05:600c:83c7:b0:46e:27fb:17f0 with SMTP id
 5b1f17b1804b1-46e612195bcmr58072435e9.9.1759414304751; 
 Thu, 02 Oct 2025 07:11:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQ4qoXVKaHjD95KV660c4M6u1LSb8CMqCkFmjg6QE44YncZ5rWYcOj+BvTV+L/c5nFpi3J/A==
X-Received: by 2002:a05:600c:83c7:b0:46e:27fb:17f0 with SMTP id
 5b1f17b1804b1-46e612195bcmr58072175e9.9.1759414304277; 
 Thu, 02 Oct 2025 07:11:44 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e6917a577sm36898845e9.1.2025.10.02.07.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 07:11:43 -0700 (PDT)
Date: Thu, 2 Oct 2025 16:11:40 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: fanhuang <FangSheng.Huang@amd.com>
Cc: <qemu-devel@nongnu.org>, <david@redhat.com>, <Zhigang.Luo@amd.com>,
 <Lianjie.Shi@amd.com>
Subject: Re: [PATCH] numa: add 'spm' option for special purpose memory
Message-ID: <20251002161140.5b908e06@fedora>
In-Reply-To: <20250924103324.2074819-1-FangSheng.Huang@amd.com>
References: <20250924103324.2074819-1-FangSheng.Huang@amd.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, 24 Sep 2025 18:33:23 +0800
fanhuang <FangSheng.Huang@amd.com> wrote:

> Hi David,
> 
> I hope this email finds you well. It's been several months since Zhigang last discussion about the Special Purpose Memory (SPM) implementation in QEMU with you, and I wanted to provide some background context before presenting the new patch based on your valuable suggestions.
> 
> Previous Discussion Summary
> ===========================
> Back in December 2024, we had an extensive discussion regarding my original patch that added the `hmem` option to `memory-backend-file`. During that conversation, you raised several important concerns about the design approach:
> 
> Original Approach (December 2024)
> ----------------------------------
> - Zhigang's patch: Added `hmem=on` option to `memory-backend-file`
> - QEMU cmdline example:
>   -object memory-backend-file,size=16G,id=m1,mem-path=/dev/dax0.0,prealloc=on,align=1G,hmem=on
>   -numa node,nodeid=1,memdev=m1
> 
> Your Concerns and Suggestions
> -----------------------------
> You correctly identified some issues with the original approach:
> - Configuration Safety: Users could create problematic configurations like:
>    -object memory-backend-file,size=16G,id=unused,mem-path=whatever,hmem=on
> 
> - Your Recommendation: You proposed a cleaner approach using NUMA node configuration:
>    -numa node,nodeid=1,memdev=m1,spm=on

that seems to me a bit backwards,
aka it's just a particular case where node would have SPM memory only,
which (spm) is not a property of numa node, but rather of memory device attached to it.
 
> Project Context
> ===============
> To refresh your memory on the use case:
> - Objective: Pass `EFI_MEMORY_SP` (Special Purpose Memory) type memory from host to QEMU virtual machine
> - Application: Memory reserved for specific PCI devices (e.g., VFIO-PCI devices)

could you elaborate on this some more /maybe with examples (assume I know nothing about it)?

> - Guest Behavior: The SPM memory should be recognized by the guest OS and claimed by hmem-dax driver
> 
> Complete QEMU Configuration Example:
> -object memory-backend-ram,size=8G,id=m0
> -object memory-backend-file,size=16G,id=m1,mem-path=/dev/dax0.0,prealloc=on,align=1G
> -numa node,nodeid=0,memdev=m0
> -numa node,nodeid=1,memdev=m1,spm=on  # <-- New approach based on your suggestion
> 
> New Patch Implementation
> ========================
> Following your recommendations, I have completely redesigned the implementation:
> 
> Key Changes:
> 1. Removed `hmem` option from `memory-backend-file`
> 2. Added `spm` (special-purpose) option to NUMA node configuration
> 
> I would appreciate your review of the new patch implementation. The design now follows your suggested approach of using NUMA node configuration rather than memory backend options, which should resolve the safety and scope issues we discussed.
> Thank you for your time and valuable guidance on this implementation.
> 
> Please note that I'm located in UTC+8 timezone, so there might be some delay in my responses to your emails due to the time difference. I appreciate your patience and understanding.
> 
> Best regards,
> FangSheng Huang
> 
> 


