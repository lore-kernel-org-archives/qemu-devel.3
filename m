Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F66C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 10:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3va5-0004Kt-O7; Mon, 06 May 2024 06:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s3va4-0004Kg-P9
 for qemu-devel@nongnu.org; Mon, 06 May 2024 06:28:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s3va2-0001po-OZ
 for qemu-devel@nongnu.org; Mon, 06 May 2024 06:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714991299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oW7IKre/xs/qaypuWaYViF3GcjX3hhASnrSDYZhr9N8=;
 b=QmRcNYbCWd16Lej1agVWTryc1Xfh9yqg1rqaZ1stc+l1gr3blm23ULbaiEQKahTkuFk0Cd
 RxTEPu7oOxbIb1dztIulaJDJvuOW+glm4noBx6Tht2lZJd45TaZoQUYyXwK5a9Nq2x0unc
 RvSE3PQoAbkCPtD0SHwgO251kIdJ9Zs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-kAAY3LfaOyKAAGdDPRJY8Q-1; Mon, 06 May 2024 06:28:17 -0400
X-MC-Unique: kAAY3LfaOyKAAGdDPRJY8Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-41b37ce2160so5892475e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 03:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714991297; x=1715596097;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oW7IKre/xs/qaypuWaYViF3GcjX3hhASnrSDYZhr9N8=;
 b=cjC0OtuaFp/vlx6Ao53+Z687fZayegYIgLdBnlbNq+9qbFjtkx4g3SAARFXdiy5HnC
 wi9xa7h/SZ1ydwyAWtGklIzNXE03shaPwT/DpMf9ntGtP/4K1lKI/LFcMXa8uKy93PqG
 urpTjj6HduktaOCYaSEdX2cwn6Na339I7Hct7JkDO69YHrnXmfI6tPOzuSAFgg+Ff4/e
 tIJx/uPYnwdsyabMF+xSDkFUyl2FLb/NqwOFfPPsrxMhy/Ri5EW8laJAddkO2CKmt5A8
 hvCGfeizUAsdSvUeKNpPrhDnRI5ONHC5E6CWikAKstw4pf287EopTkh0t0tsNuQmFk84
 TYPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/i+mWjhMCiZgk275w+bEtOC5ehzP2f+l8s2aNZJyopY9nMZEozmYUVF4/vvZttpafAYayGaMi1DNFwVQNkZDOKup5xmY=
X-Gm-Message-State: AOJu0YzbmsA/XcOXzFLcJzTA3L2bku54lawF/6tpFDsvKerthKKzxZFG
 pHVZrSw9yAXd0aaHQovAk+GzCO+di/qQlUZKDXolOCV+OsT0V+gquqLtXLidhiv9MuqyGMlhJIU
 F+Y0OJR40Tgr5we3ysUnGbT5wpE2DZ/DjxBCJFycHsFKN/Zmb8IyU
X-Received: by 2002:a05:600c:358d:b0:418:6138:6777 with SMTP id
 p13-20020a05600c358d00b0041861386777mr7836665wmq.31.1714991296779; 
 Mon, 06 May 2024 03:28:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtsfidu3EMlLMAtQCDyZy91U4GY7kGjDg+JEz7csS7QvilA7eY6Sp1lEnjOw3AOXvI+vFppA==
X-Received: by 2002:a05:600c:358d:b0:418:6138:6777 with SMTP id
 p13-20020a05600c358d00b0041861386777mr7836649wmq.31.1714991296446; 
 Mon, 06 May 2024 03:28:16 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-179-34.web.vodafone.de.
 [109.43.179.34]) by smtp.gmail.com with ESMTPSA id
 m18-20020adfa3d2000000b0034dfede0071sm10418658wrb.46.2024.05.06.03.28.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 03:28:16 -0700 (PDT)
Message-ID: <508dbc7d-a8d5-4828-b824-b66e2a984bbf@redhat.com>
Date: Mon, 6 May 2024 12:28:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [qemu-web PATCH] blog: KVM Forum 2024 CFP
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
References: <20240506101348.30469-1-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240506101348.30469-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
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

On 06/05/2024 12.13, Paolo Bonzini wrote:
> Add a new post linking to the KVM Forum 2024 Call for Presentations.
> Thanks to Stefan Hajnoczi for providing a draft of this post!
> 
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   _posts/2024-05-06-kvm-forum-cfp.md | 36 ++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
>   create mode 100644 _posts/2024-05-06-kvm-forum-cfp.md
> 
> diff --git a/_posts/2024-05-06-kvm-forum-cfp.md b/_posts/2024-05-06-kvm-forum-cfp.md
> new file mode 100644
> index 0000000..23398fe
> --- /dev/null
> +++ b/_posts/2024-05-06-kvm-forum-cfp.md
> @@ -0,0 +1,36 @@
> +---
> +layout: post
> +title:  "KVM Forum 2024: Call for presentations"
> +date:   2024-05-06 07:00:00 +0100
> +categories: [presentations, conferences]
> +---
> +
> +The [KVM Forum 2024](https://kvm-forum.qemu.org/2024/) conference will take
> +place in Brno, Czech Republic on September 22-23, 2024. KVM Forum brings
> +together the Linux virtualization community, especially around the KVM stack,
> +including QEMU and other virtual machine monitors.
> +
> +The Call for Presentations is open until June 1, 2024.

In the "Call for Presentations" mail that you send to the qemu-devel mailing 
list in parallel, you wrote: "The deadline for submitting presentations is 
June 8" ... so what's the correct date now?

Apart from that, the blog post looks fine to me.

  Thomas

> You are invited to
> +submit presentation proposals via the [KVM Forum CfP
> +page](https://kvm-forum.org/2024/cfp). All presentation slots will be
> +25 minutes + 5 minutes for questions.
> +
> +Suggested topics include:
> +
> +* Scalability and Optimization
> +* Hardening and security
> +* Confidential computing
> +* Testing
> +* KVM and the Linux Kernel
> +  * New Features and Architecture Ports
> +  * Device Passthrough: VFIO, mdev, vDPA
> +  * Network Virtualization
> +  * Virtio and vhost
> +* Virtual Machine Monitors and Management
> +  * VMM Implementation: APIs, Live Migration, Performance Tuning, etc.
> +  * Multi-process VMMs: vhost-user, vfio-user, QEMU Storage Daemon, SPDK
> +  * QEMU without KVM: Hypervisor.framework, Windows Hypervisor Platform, etc.
> +  * Managing KVM: Libvirt, KubeVirt, Kata Containers
> +* Emulation
> +  * New Devices, Boards and Architectures
> +  * CPU Emulation and Binary Translation


