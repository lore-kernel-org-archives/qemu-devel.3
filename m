Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D306CE8347
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 13:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svGtV-0005QL-GO; Mon, 30 Sep 2024 09:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1svGtT-0005J5-80
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 09:56:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1svGtQ-0004n9-BX
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 09:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727704610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7PZNPHLGDw47whbBuLRy3nhKuXnJ3gdH98nZ/NejBOA=;
 b=EisFiYEr84CJVRDDk0J223pofzr7xpdFIaU6Bq4b58xMJRvmX5v8W+877DG6iI4kXvMwrI
 GCKa973hvgeRi+h+wyEKPXB3xrcUcgdGGn3MzhxM/1QcRj/znbt2p8L8QJr53eWBaDk5x2
 TsbLtYOVi7Ff2B9NtF5EOoQusGc5ziQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386--5rF-kLnPZ2fQPTdydarYQ-1; Mon, 30 Sep 2024 09:56:47 -0400
X-MC-Unique: -5rF-kLnPZ2fQPTdydarYQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb830ea86so29259335e9.3
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 06:56:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727704606; x=1728309406;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7PZNPHLGDw47whbBuLRy3nhKuXnJ3gdH98nZ/NejBOA=;
 b=nlhByKHSpmhcnPl9qhEzhRCtM1TUZ6HVPNVEXJjqyQT2yqiU0iYmGudBr7bSI7dhFC
 J67nosQS7rm9kGQUh0YpX4DRi4IIk9ry7gzdXmjVLyM0qAe64NCf0FhT9uXL0+JHtrhZ
 MbzdxYMKgdElPhpPx37qm4Yta9G0RgB2bv3LRpePy0noasE0z9oD/N53NeVINrHjuX9c
 a3/E773uzzF4rvp0L0z20/l8n5N0l3CowFNc/aP+xX+J4BIwQm5bRnc+SBt8N3HZgcXy
 zw320QKnALUd2fB4tZtm6vU6bRT1ncDJUFU6rZbWX0iYF4x9mB4t87mar/K7aMzDCHIE
 iJjw==
X-Gm-Message-State: AOJu0YxxSI//U4WD+FBhDHA0e8yqEhs7ot/nf0jvfiyEG+POrYLw2u52
 NrVswIZy11TfEvb2UFq3j1d3lBHqBGQ48UPRAkSziITQZGxnvIw3MrAhPWmtAxJaOHzk+o0iyoI
 fVp8BsddtqiFeXbjtysbuQp8WYw7HGxN62YzUJcDJWSweO0K5cvZV/2DoAP9eCtbMcFMFw3E9XW
 nsKOuEtB9CDqxYVj8rLD6j0X5dMOZkODTws4t+1C4=
X-Received: by 2002:a05:600c:cc8:b0:428:1965:450d with SMTP id
 5b1f17b1804b1-42f58439cdcmr89510725e9.17.1727704606416; 
 Mon, 30 Sep 2024 06:56:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEluwHOdRLNMJvRmZC5daaTKR2nLti2FYBLfATMXnyN1a9kbyj19FHKUSe/JonW61Mu6tX/oA==
X-Received: by 2002:a05:600c:cc8:b0:428:1965:450d with SMTP id
 5b1f17b1804b1-42f58439cdcmr89510455e9.17.1727704605951; 
 Mon, 30 Sep 2024 06:56:45 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f57e303dcsm105115485e9.44.2024.09.30.06.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 06:56:45 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH RESEND v4 0/4] target/i386: Various Hyper-V related fixes
In-Reply-To: <20240917160051.2637594-1-vkuznets@redhat.com>
References: <20240917160051.2637594-1-vkuznets@redhat.com>
Date: Mon, 30 Sep 2024 15:56:44 +0200
Message-ID: <87y139jlcz.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

> Changes since '[PATCH RESEND v3 0/3] i386: Fix Hyper-V Gen1 guests stuck 
> on boot with 'hv-passthrough':
>
> - Added "target/i386: Make sure SynIC state is really updated before KVM_RUN" 
>   to the set.
>  
> This is a long pending collection of fixes for various Hyper-V related 
> issues, mostly detected by tests. On top of that, the patchset updates
> Hyper-V related documentation adding recommendations.
>
> Vitaly Kuznetsov (4):
>   target/i386: Fix conditional CONFIG_SYNDBG enablement
>   target/i386: Exclude 'hv-syndbg' from 'hv-passthrough'
>   target/i386: Make sure SynIC state is really updated before KVM_RUN
>   docs/system: Add recommendations to Hyper-V enlightenments doc
>
>  docs/system/i386/hyperv.rst | 43 +++++++++++++++++++++++++++++++++----
>  target/i386/cpu.c           |  2 ++
>  target/i386/kvm/hyperv.c    |  1 +
>  target/i386/kvm/kvm.c       | 18 ++++++++++------
>  4 files changed, 54 insertions(+), 10 deletions(-)

Ping) Some of these patches are really getting old :-)

-- 
Vitaly


