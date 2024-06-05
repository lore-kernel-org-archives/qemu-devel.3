Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22B1C27C53
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 13:50:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEr0x-0008Fc-9H; Wed, 05 Jun 2024 09:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sEr0w-0008FI-8b
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 09:49:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sEr0u-0006SL-JS
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 09:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717595355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KcsTVxe7VUKYfyT3ArKLCmyHlqdueGzwZGo7mFbW06s=;
 b=hfxUs3VsnIPEBqa0x8Bw6KwUIJ7b+ozFuAqixLQ7gFu4410I6vWvNr1do64MzkW8sI48ES
 JXZSFaNNsqAnbTIfdGFUdFEFblYTys1AyBQqh2hFfefXU+4kJGJpmHsCs+NXnKXe+jAiAM
 nidlIDM/z5MtqyuuRqLlTNIQ/+FRbHg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-C4KnF5nvN_Co3Kxx4PIUnw-1; Wed, 05 Jun 2024 09:49:12 -0400
X-MC-Unique: C4KnF5nvN_Co3Kxx4PIUnw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42159936ec2so2971305e9.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 06:49:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717595350; x=1718200150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KcsTVxe7VUKYfyT3ArKLCmyHlqdueGzwZGo7mFbW06s=;
 b=VGdDn34Q5aakLSnt99K7NFVvlBxKIIQLL8EFc8PiR/zzPfyee8nwzfgph9RWsVhjKQ
 VtcOCiGJRdK5aGn3USyWw7qM2F6eX4Qch8kzStYK36z5f+uYqcSBBenMucbiAI2oGHq3
 B9diJX+VjAvsFJ+d2ltHcMYicNs1zJVbFNRLbgrMArY8wDIi9Dx9/zY5V76rBeHCWSf9
 PaKj7S0EbUv20jgXtE4nQBWBpJ81vm6nhN9Jdp+1Ko84PKYugaWUbY9efr501nqapqXK
 gsChxc/B9NqWS3ouV1xZRezUmcPNT/OKRG+I4dkl/SpVvlU7epJfMoaGfNY+hAMxFGit
 zLtQ==
X-Gm-Message-State: AOJu0YzJ1CrcbWt/7qAbQsPcbo6MRM5MWusZD0ONNDvjowNrfS4/0wRO
 igj3+2QGUFSOpBtzvmuzYXmvvA/MbJpKp7d0hRsIZr03n3i6EImNZi7FuDfEpuwm71tI76D/EzO
 2QULoYGUxqf3N8lL9RCBrGjDZJDkJIPKCzJkgn0hgrnVB5OO+0AQP
X-Received: by 2002:a05:600c:5491:b0:420:1551:96a9 with SMTP id
 5b1f17b1804b1-4215633a321mr20299055e9.39.1717595350011; 
 Wed, 05 Jun 2024 06:49:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZnuKComjtyYd4hJD9oCfU5bhmTbTrUV9epijVg02/y8t1dwcD2TsT4TXw6APJIAs4gBkh/g==
X-Received: by 2002:a05:600c:5491:b0:420:1551:96a9 with SMTP id
 5b1f17b1804b1-4215633a321mr20298845e9.39.1717595349672; 
 Wed, 05 Jun 2024 06:49:09 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42158101772sm22846205e9.6.2024.06.05.06.49.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 06:49:09 -0700 (PDT)
Date: Wed, 5 Jun 2024 15:49:08 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Zide Chen <zide.chen@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com,
 thuth@redhat.com, cfontana@suse.de, xiaoyao.li@intel.com,
 qemu-trivial@nongnu.org, seanjc@google.com, zhao1.liu@intel.com
Subject: Re: [PATCH V3 0/2] improve -overcommit cpu-pm=on|off
Message-ID: <20240605154908.54c65d26@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240604000222.75065-1-zide.chen@intel.com>
References: <20240604000222.75065-1-zide.chen@intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon,  3 Jun 2024 17:02:20 -0700
Zide Chen <zide.chen@intel.com> wrote:

> Currently, if running "-overcommit cpu-pm=on" on hosts that don't
> have MWAIT support, the MWAIT/MONITOR feature is advertised to the
> guest and executing MWAIT/MONITOR on the guest triggers #UD.
> 
> Typically #UD takes priority over VM-Exit interception checks and
> KVM doesn't emulate MONITOR/MWAIT. This causes the guest fail to
> boot.
> 
> V2:
> - [PATCH 1]: took Thomas' suggestion for more generic fix
> - [PATCH 2/3]: no changes
> 
> V3:
> - dropped [PATCH 1/3]. Took the simpler approach not to re-order
>   cpu_exec_realizefn() call.
> - changed patch title in [PATCH V3 1/2]
> - don't set CPUID_EXT_MONITOR in kvm_cpu_realizefn() 

on top of above we should make make
  -overcommit cpu-pm=on
to error out if KVM_X86_DISABLE_EXITS_MWAIT is not supported/failed

if we don't do this user gets false assumption that cpu-pm=on
works as expected, and instead of effective CPU usage/IPI delivery
all they get is a storm of mwait exits.

> 
> Zide Chen (2):
>   vl: Allow multiple -overcommit commands
>   target/i386: Advertise MWAIT iff host supports
> 
>  system/vl.c               |  4 ++--
>  target/i386/host-cpu.c    | 12 ------------
>  target/i386/kvm/kvm-cpu.c | 11 +++++++++--
>  3 files changed, 11 insertions(+), 16 deletions(-)
> 


