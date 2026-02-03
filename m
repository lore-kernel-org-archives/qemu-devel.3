Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC26FE87845
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 16:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnJKd-0003Wc-EZ; Tue, 03 Feb 2026 11:32:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnJKW-0003V8-R6
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 11:32:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnJKV-0005oE-Ex
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 11:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770136361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=owGj0OJ2wCHGfsqeNdhXTREIrZPWZ7iLe7nJQieUIZI=;
 b=RIlx7ISOFKuipIj9d0aSnSgCFqkYW7b35dnes9u0ivR1boMLx2mONyMooP+PsEhoU/RD3z
 DUtBbfLPlpLRPUR4T95G62/9YvbrBybUFqSPle6yYun1zgdyhEqY7Iajv3C5N156keN8ya
 xuCmMVqnnHVloTpDqrM3bgz5IZ765Io=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458--xIdUjsmNQea0TLexarIiA-1; Tue, 03 Feb 2026 11:32:39 -0500
X-MC-Unique: -xIdUjsmNQea0TLexarIiA-1
X-Mimecast-MFC-AGG-ID: -xIdUjsmNQea0TLexarIiA_1770136358
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48069a43217so64581805e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 08:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770136358; x=1770741158; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=owGj0OJ2wCHGfsqeNdhXTREIrZPWZ7iLe7nJQieUIZI=;
 b=eq89xzHvNXoSZCxbpRFwdBfhCOBJjXJt3rsl6DJDEHSDErPfisGBcgZ/MWK08AsNLf
 kokxjjA0TZlQiA25BlAgmSR1wt1B8uGnSZhmdDuIfFhYyWaMqVtaCnGYbuvBdE3XphnZ
 dOyhmVJGS7hwNV+0+tAQXudw/NDtcL48nrT6IMsQeE+i73Wc1c2x0zkvou+Q9efP/NVp
 QG9EBDxH8WYQCj0QaHqOg73MUMPjwkSpCs0C7sMtAIGbpapTExfuRymsxJ8rGJ6dMYVo
 yzgyCOc5jbAXs2GVhJ6qKye/i5yYoiscGDRs4XNC5uKAFVWLbl7W3GcGtuTHz0GH6acO
 YHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770136358; x=1770741158;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=owGj0OJ2wCHGfsqeNdhXTREIrZPWZ7iLe7nJQieUIZI=;
 b=pPIhzwyXP0lnG3BJgdBCYL4MFfdJWrZxEb+uXbsHPO/ZX+wYA+oD6Tqa1EFhoixII4
 T6amEeoXd/L5MZLyNfMuTTplYYKcvoNQfmI9FORvLrzqgjW68kBF601cr0AZ/KhKf3av
 8F8Ee4orLbxTq+Mnu1LRxHbFq7qv7EAErpt78RxAl+l3sWPEZIaXZjkrhFET7U7a61b7
 zUFO8rM6WKGuuVJiuv8F4mlZuB5V5LMGIHgMEljmoSBIyQppTVtqIuZQexb1B4TOW7Gl
 p1XHDY/FiR9/yhVs40jlaWgBdpoenvIWHqPEhZ/jJEPHeLQtjez1EU3xJOQ/1BaKSGGB
 MPew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMHRi0OGWZZirrd8nE8FE4YR63MIl0/cjkyEzfYe6u+TpFznuyLcfec9APM82CryCDiM8orrVWN5Wo@nongnu.org
X-Gm-Message-State: AOJu0YyUfnnLOCKmolc9SDNxEzYkfT+avHXFNOtCPzyN4W/HoDOd69P7
 I9Aa3NlmVYPW3UE/9lIGC25Jq4ZHQ75xueEZEGO5Ba9T/g2xaJEra0jmtklVw5B4JVNSgMdLKVg
 R20KQ5m3HIlhVnxNpLih3gunCC/p2uGzvNab2GjDiCcNEUi4pBPXFK47q
X-Gm-Gg: AZuq6aJ+kti1G/55qSqM0SjwStNLwjOUDhCVgvugs0W+zimdIgf2WfBOf/mEWNwzJ2p
 +rDjdkLFlw6pPNhtIbjWv6su4CZUspC07Nfy7p5QKVLZcRZMLzPvU12IYnCZ6B/0mnGyzdA/qqU
 Y3uI+mn3jO3fNum+MpQvx7HjhKUkk/VGyVCjPDOtFud1cwmFcn2I2xECkLNqQJyYvmL2ajNlLEO
 w/hu7zONL0PnFioT1JNBfAcMX8CW9B/xSFlYjWOakBYh4m8uCOZ+/PPHAiiJRF+E+pItzyFyx9v
 /29DxA1P43BLWx4VIdM5Ss1nGlQuEdwFtYOrQDjwLBIFOvAXMnmkyBeVhdDAmnECCXjSvYVZdPP
 fdkfWC8Paw5Txjop16i0wJdnJBdz8qIUmuw==
X-Received: by 2002:a05:600c:1f08:b0:480:68ed:1e73 with SMTP id
 5b1f17b1804b1-4830e98fa7fmr2683675e9.36.1770136358279; 
 Tue, 03 Feb 2026 08:32:38 -0800 (PST)
X-Received: by 2002:a05:600c:1f08:b0:480:68ed:1e73 with SMTP id
 5b1f17b1804b1-4830e98fa7fmr2683215e9.36.1770136357850; 
 Tue, 03 Feb 2026 08:32:37 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830ead1973sm515725e9.5.2026.02.03.08.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 08:32:37 -0800 (PST)
Date: Tue, 3 Feb 2026 11:32:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marc Morcos <marcmorcos@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH 0/4] Clean up TSAN warnings
Message-ID: <20260203113137-mutt-send-email-mst@kernel.org>
References: <20251213001443.2041258-1-marcmorcos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251213001443.2041258-1-marcmorcos@google.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, Dec 13, 2025 at 12:14:39AM +0000, Marc Morcos wrote:
> When running several tests with tsan, thread races were detected when reading certain variables. This should allieviate the problem.
> Additionally, the apicbase member of APICCommonState has been updated to 64 bit to reflect its 36 bit contents.


Doing a sweep over old threads, Paolo iiuc you will be
fixing it all up differently, yourself?

> Marc Morcos (4):
>   apic: Resize APICBASE
>   thread-pool: Fix thread race
>   qmp: Fix thread race
>   apic: Make apicbase accesses atomic to fix data race
> 
>  hw/i386/kvm/apic.c              | 12 ++++++++----
>  hw/intc/apic_common.c           | 24 ++++++++++++++----------
>  include/hw/i386/apic_internal.h |  2 +-
>  monitor/monitor.c               | 11 ++++++++++-
>  monitor/qmp.c                   |  6 ++++--
>  util/thread-pool.c              | 30 ++++++++++++++++--------------
>  6 files changed, 53 insertions(+), 32 deletions(-)
> 
> -- 
> 2.52.0.239.gd5f0c6e74e-goog


