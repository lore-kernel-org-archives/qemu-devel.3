Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5AB606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 11:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F+Mjvo4/;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=BGWRAMBf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMOmm-0008JQ-QV; Thu, 29 Oct 2026 07:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seott@redhat.com>) id 1xMO0i-0007JK-IW
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 07:09:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seott@redhat.com>) id 1xMO0h-0001Vb-2l
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 07:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793272170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bIz7miHbxqX0pgfFFTv1SvuBSW0W9lMwHcNxY+f0UxI=;
 b=F+Mjvo4/CMZFWZ9MIBSBiFYeGBXbqNgtpFV/bXA9V5kAzxPL206LExfxLAS6G5xr3sbVBU
 iGCxlBAWynIqApkWay54k60uazmTtOeuxUWa/TYpvdo5gZ60w/MWAvCOlZF4jVX9DewoLX
 uEFfSMtBD7SnXs8yzl1PJcQ8W+EBYeI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-Kk6E9qOINRik-EswZOsyLA-1; Thu, 29 Oct 2026 07:09:28 -0400
X-MC-Unique: Kk6E9qOINRik-EswZOsyLA-1
X-Mimecast-MFC-AGG-ID: Kk6E9qOINRik-EswZOsyLA_1793272167
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48e0ef019a4so1578034f8f.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 04:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793272167; x=1793876967; darn=nongnu.org;
 h=content-type:mime-version:references:message-id:in-reply-to:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bIz7miHbxqX0pgfFFTv1SvuBSW0W9lMwHcNxY+f0UxI=;
 b=BGWRAMBfaKfaTIWE2aaZv7+i2zqN/B8O2zJ9XsApRxBj/Otti3FaClG8Pe/QxXcZXp
 crEAdGriOePvyC0DELdTQh9uyCU3YfCVKBhiKi0L0qkeP/S6J998vCXq2AKamy0sMM8P
 6r8DYwTPuq1Hlu8iXQjZZu1nxhmX/TLLLE9w9pY9wgBtBFyR8hSeUOZzpdsq0Bzl9FWQ
 YYuydgnX8B/MCL2O+CLBFzGBd/GoF7sipUZRZ7QSEw7usdyuN1POhHN9gAP/XOQNiNBE
 OXbLdPrJCpzTilPGS6dA1JMWpNsZCF1WWcSmJW7p5KZLLqkJAb7KS3peKgszwVaTpbIs
 HTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793272167; x=1793876967;
 h=content-type:mime-version:references:message-id:in-reply-to:subject
 :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bIz7miHbxqX0pgfFFTv1SvuBSW0W9lMwHcNxY+f0UxI=;
 b=0t/YlDiPZUNtzH2KX1Z1tBWhcHCbhycU4ObSpaUIHJP+IKhc679GYg+PNMeibt4Ubl
 c9VaqPcmEhgqo0qxF9rNyf38HLGUrv6qreGesmZKy/6GGRjwPsdaUxtZIO4CeZbaqEpO
 XjU+Gx9J1XuKcq4AcCHJnZqAxelovdNbiCHK8eeeU84flLp8qq9IhY3RQxIrwoICm3B9
 EmfMxi8+E5ASfxIBF1spe20MO+gDjlYOlzWRsb4GAUUAAWHHFok1Ywz3wXSaEN45HFDq
 dJKGO70Dt3fuIwmFlLqGg+AoiJ5ZIw8fSQRFavZ9LtmZmoLzfU+7qoDlmZXALEbG3jax
 g+jQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAvy1MyneTvgp8W6NmygPxUZK2PX9EdxvpdYg0ljEfsJcqZHXLExZE0jSloMg6U17jal+fXXyXCrgN@nongnu.org
X-Gm-Message-State: AFq9FYIn82UDsVad1fshZV7gtD2BoE2zoCti4+B3BtWHuOndBfMnWU2S
 7swfHEFdIek+bA5332VfmgcJADcoXJpUBNAUjSI+cFj0fmudg2gAqOOcxg8MDR6ygoX25mAYGID
 nCNFTwrhguF7xmQQxukXSRL1+PwL6SL24hqIETs2Yu9kEovmUAE5l8uwD
X-Gm-Gg: AYBFou0B6Nj2Pzu03eOcI2Zwo2PbiyDqYupDm/In4Jc7XeL4TOH55RUhgvfhI6wanPg
 RQ7moq4Qz5zP1G15WxqvST3ZzK9KtyQ2fg2jhCmRWtXVugRyJ5/FMR3CuwmIsDEhXhlu+gi9Z6Z
 zZtafB6Vm5Kt/NCVOoeQovYrvSMBD/d6EDa3E2mfYLahnZp00UixAVRhpW7jAMgFohubWWPyPL7
 sggw4EXtG1iDkWLa+C01PxPzlqVBrBxL664eXQ8svWJ0ho8xQEAKTR+TpjqihQQ2fUc1PvAqrmf
 /Y7VyydDgSBXsa/dfQG+3pBWQhNYV5Gp23jhuoKJZmK/EQA05g5sqqKHFBA3EG/+LR+WhCbN9BJ
 OZsDzKRAxfLtkfj7VyZqS3s83kjsGHy8UqguXUn5qMKatPzM+0tm7x5dMhCQ/NKeC/yXA8j+KgS
 Unvb1uK6roro/sWa9ESpgfqWWrb1VjdwwHY0vZLak=
X-Received: by 2002:a05:6000:606:b0:48b:2a2:31dc with SMTP id
 ffacd0b85a97d-48e5d3126abmr11850025f8f.49.1793272167368; 
 Thu, 29 Oct 2026 04:09:27 -0700 (PDT)
X-Received: by 2002:a05:6000:606:b0:48b:2a2:31dc with SMTP id
 ffacd0b85a97d-48e5d3126abmr11849965f8f.49.1793272166893; 
 Thu, 29 Oct 2026 04:09:26 -0700 (PDT)
Received: from seott-rh (p200300f6af1574019b2c5947d8ec139e.dip0.t-ipconnect.de.
 [2003:f6:af15:7401:9b2c:5947:d8ec:139e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd8ddasm36749700f8f.48.2026.10.29.04.09.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 04:09:26 -0700 (PDT)
Date: Thu, 29 Oct 2026 12:09:25 +0100 (CET)
From: Sebastian Ott <seott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, shaju.abraham@nutanix.com, 
 khushit.shah@nutanix.com, richard.henderson@linaro.org, 
 pbonzini@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com, 
 7746591750@163.com, maobibo@loongson.cn, harshpb@linux.ibm.com, 
 amachhiw@linux.ibm.com, daniel.barboza@oss.qualcomm.com, 
 milesg@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com, 
 armbru@redhat.com, mbawa@redhat.com
Subject: Re: [PATCH for-11.2 8/9] target/arm/kvm: Introduce
 kvm_arm_vcpu_prepare_init_features helper
In-Reply-To: <20261029092307.281287-9-eric.auger@redhat.com>
Message-ID: <c5186422-1631-cce9-9ec8-62b109da2675@redhat.com>
References: <20261029092307.281287-1-eric.auger@redhat.com>
 <20261029092307.281287-9-eric.auger@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.133.124; envelope-from=seott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:59:09 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026, Eric Auger wrote:

> Factorize the code that initializes the kvm init features from the
> cpu settings in a helper. Use it kvm_arch_init_vcpu(). Soon it will
                                   ^
                                in / for ?

> be used by another function.
>
> The only change in the code relates to the check of kvm_state. The
> future caller won't have the VM created when calling the helper and
> for this caller it is OK ignoring PSCI version setting.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Sebastian Ott <sebott@redhat.com>


