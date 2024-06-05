Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA8CC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 23:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF0Uc-0007Of-V1; Wed, 05 Jun 2024 19:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sF0Uc-0007OP-2M
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:56:34 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sF0Ua-0000x0-Cb
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:56:33 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f32a3b9491so3280965ad.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 16:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717631791; x=1718236591; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yg0HxI3SUDSNBfzoISO+f/Qq9JEwkF9/P965VqAPEX4=;
 b=IJpQsksw6mkfel21fIz9xxuDklOl3GL6SGCoKLB3ygd1xUIMdBErFMh5N7O7mFjTEK
 fJp3Qwp9cUyO6brbXFtbuFcIvaLKZeCrEGLpQkQdWuo0QnewxwgKHaJwfD7r1ck8Z5X5
 bQIZiVt2vp9Ufo1yFfhq9jvuwSwLcQGhsnnDrq2NaTYGbxghIDOPaeKY5gSdBqTNRR/l
 z7gvmW/eSrLMySQbkk46fF7NJTblomg/+Ua1QR8kKxGAmjnY4cxnuJ+s7VW/0+UEvxc3
 UweUeJe6JfcNS84Aycz9Q52RqYvNBIbJi85cJqiXi1FkB9IYyqZNBVjykHpJUvCCPsRh
 nmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717631791; x=1718236591;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yg0HxI3SUDSNBfzoISO+f/Qq9JEwkF9/P965VqAPEX4=;
 b=X1wkp6ZKaiHa+5K7vy6986mYAjvz7jyumQg3fDVPRlNAjfpkFLcvX6FtVDylDmPRC4
 MDM98WMvGrh7+A2pfnrr65mZa16l9TLhN1xV5KzGZDL79m9gGp3izF7UYRGZNrSc8Ee8
 zbSiAytLXj3oOo3cGAWfzdG+OxDAqJVpX1hzowiGyopaCvIwenRvIJCJdE3F+v8e9qEn
 J1tq9JY29aqwOGmAN4XY3k7pzp8gWtuOxCdH8taW7H8tXE56W1UyYylRsU3nawLu65Sf
 VZaGpyDinPIpVVIeAmi4HwaXRXKjuF5hfL2Cr7GM+zq0XaB4PRPCkvTQh8d34eCMTVNT
 8hZw==
X-Gm-Message-State: AOJu0YwZHxgZp/BiqmvJ7smoNjc2YGOXEYKdpChw0SMlFRwH4RrTLj2K
 jvzCmmCDdY3LVCi0s/dR8ozDEx04UFlTcRSaJvO4KY/n+6sP7hinKLsiw0egB2C0233haGFZbg8
 X
X-Google-Smtp-Source: AGHT+IHTgGLxmfRmPe4Cz6rF7BvLLeFjUUwnFjkLroUfPuK7lcnwzSWyk72HSfGOupNQoTvWjdHYZA==
X-Received: by 2002:a17:902:ec83:b0:1f4:ac56:3d15 with SMTP id
 d9443c01a7336-1f6a5a0e83dmr54566105ad.15.1717631790229; 
 Wed, 05 Jun 2024 16:56:30 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6bd81dfd9sm1089505ad.309.2024.06.05.16.56.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 16:56:29 -0700 (PDT)
Message-ID: <4f924ddc-bd55-4e6c-8935-c187ce258864@linaro.org>
Date: Wed, 5 Jun 2024 16:56:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v3 00/41] virtio: features,fixes
To: qemu-devel@nongnu.org
References: <cover.1717630437.git.mst@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cover.1717630437.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 6/5/24 16:34, Michael S. Tsirkin wrote:
> Dropped acpi patches that had endian-ness issues.
> 
> The following changes since commit 60b54b67c63d8f076152e0f7dccf39854dfc6a77:
> 
>    Merge tag 'pull-lu-20240526' of https://gitlab.com/rth7680/qemu into staging (2024-05-26 17:51:00 -0700)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> 
> for you to fetch changes up to d23bc95d390a1800198c92a0177240d9e1a1eb66:
> 
>    hw/cxl: Fix read from bogus memory (2024-06-05 19:33:01 -0400)
> 
> ----------------------------------------------------------------
> virtio: features,fixes
> 
> A bunch of improvements:
> - vhost dirty log is now only scanned once, not once per device
> - virtio and vhost now support VIRTIO_F_NOTIFICATION_DATA
> - cxl gained DCD emulation support
> - pvpanic gained shutdown support
> - beginning of patchset for Generic Port Affinity Structure
> - new tests
> - bugfixes
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sorry to have to require a v4, but

merging...
Auto-merging hw/misc/pvpanic-isa.c
CONFLICT (content): Merge conflict in hw/misc/pvpanic-isa.c
Auto-merging hw/misc/pvpanic-pci.c
CONFLICT (content): Merge conflict in hw/misc/pvpanic-pci.c
Auto-merging hw/misc/pvpanic.c
CONFLICT (content): Merge conflict in hw/misc/pvpanic.c

Looks like Paolo's pull induced the conflict.


r~

