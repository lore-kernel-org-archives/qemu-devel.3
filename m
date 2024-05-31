Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309F1C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 11:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD06M-0003x6-UZ; Fri, 31 May 2024 07:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sD06M-0003wc-58
 for qemu-devel@nongnu.org; Fri, 31 May 2024 07:07:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sD06K-0000mP-NN
 for qemu-devel@nongnu.org; Fri, 31 May 2024 07:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717153632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KxPgW5AkJNB4ekRDOYHVb71yhNg3xNwdWM1TWklaq1c=;
 b=M6QHFMjHJk0GYJnO6muHSU2fGVA3fBddaA5UjSJDQFncdOAhYhnB+V2/HngPP1wTXKa/XJ
 G5TD1pG+BGV8UyraDZa2E7seN4A8tE4tWzaflMfDtvbqEG2LYequBPO8PrmUMPuBRd30dm
 Zh4v43HgjyOGiP7VPI5MIp2n4DYRylM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-GDApXTA2MseZDujwXK8YAw-1; Fri, 31 May 2024 07:07:10 -0400
X-MC-Unique: GDApXTA2MseZDujwXK8YAw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3564bb7b352so1210667f8f.3
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 04:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717153629; x=1717758429;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KxPgW5AkJNB4ekRDOYHVb71yhNg3xNwdWM1TWklaq1c=;
 b=HbPzJnotKYu5AnCjeJAjDMHqXu5hFkZbZbt2gEqO3vXEbLSHf236+j7P7DeGuvXokw
 MsI8lQeyQ1nnhHn9pqyYBvnDF91FtSP3SRljn7OCWt4lVAYPxrXVIIbTTBrRPlZX6pHK
 G816gfyYpRlop9o4lxs4+c2wcMWE5qlfskoPCAWZhUzQIK6M74FlgzdBQDUrpmVWAN5i
 H+P16DQu8eVROxGrcXy5krlCOvWstK0FJgHRmxnCErIF0/mms4ll7ZRwsIJc2j66pDO8
 0WXwrblpyfdMEaN8HuI5QI/DkRxlXEktn62qwcHHKmuWzqVaxwFQL6DHvURkCEEDiZ1S
 vFOw==
X-Gm-Message-State: AOJu0YxmAkOXAwqXSajIN1GR4R7Zaz7ZV88kIsMzBxmIuQZy06aWP37d
 Iilu/CQs5GE1IS3zafwNDwYc75FDVWPhcWk+1ISGBD8xONp1u8L7VMQ5JwRBfG+R+efMVqBuDAQ
 XtZ/X30mNJ2xZ2gzrmuGXj+G+WKPVQEvDEw8n7Jnly8MKBKysxl9+L6Om/2rMbMAHIA4ivRaHk/
 TTLOxwPl7wLErJZWLoLumrkIzspcDNgoAnmfg=
X-Received: by 2002:adf:f7c4:0:b0:349:8ba8:e26d with SMTP id
 ffacd0b85a97d-35e0f25ade5mr1127937f8f.13.1717153628833; 
 Fri, 31 May 2024 04:07:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKF8DUeAzyTLmkxUc/s/BL3e7Mfc2JhCDsrVEl9JqjeXyX2YUJeVpauWo8dvgyTY6BAjEL7a7hs6T6R7faTFI=
X-Received: by 2002:adf:f7c4:0:b0:349:8ba8:e26d with SMTP id
 ffacd0b85a97d-35e0f25ade5mr1127921f8f.13.1717153628524; Fri, 31 May 2024
 04:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
 <20240530111643.1091816-10-pankaj.gupta@amd.com>
In-Reply-To: <20240530111643.1091816-10-pankaj.gupta@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 31 May 2024 13:06:57 +0200
Message-ID: <CABgObfYvQdLJTv-sc-HfJ1ib6Bsp5=bfgdToWf89s3US3acAnA@mail.gmail.com>
Subject: Re: [PATCH v4 09/31] i386/sev: Add sev_kvm_init() override for SEV
 class
To: Pankaj Gupta <pankaj.gupta@amd.com>
Cc: qemu-devel@nongnu.org, brijesh.singh@amd.com, dovmurik@linux.ibm.com, 
 armbru@redhat.com, michael.roth@amd.com, xiaoyao.li@intel.com, 
 thomas.lendacky@amd.com, isaku.yamahata@intel.com, berrange@redhat.com, 
 kvm@vger.kernel.org, anisinha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

On Thu, May 30, 2024 at 1:17=E2=80=AFPM Pankaj Gupta <pankaj.gupta@amd.com>=
 wrote:
> +    /*
> +     * SEV uses these notifiers to register/pin pages prior to guest use=
,
> +     * but SNP relies on guest_memfd for private pages, which has it's
> +     * own internal mechanisms for registering/pinning private memory.
> +     */
> +    ram_block_notifier_add(&sev_ram_notifier);

"it's" should be "its".

Paolo


