Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC60C3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 01:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWQkj-0000jU-9h; Tue, 23 Jul 2024 21:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWQkg-0000iH-K6
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 21:25:10 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWQke-0007fO-O3
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 21:25:10 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fc5296e214so4871325ad.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 18:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721784305; x=1722389105; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9xRqWbOHwUPm6fyXbXbkTNzpkPrKCWETUbO9wuE5Bl4=;
 b=YkLsoxesnuIHUo4jCWfMiFHpRT6PiJGTHddSeRvifmqqXj0LDJOlU++7Ex+qx71Ln1
 ndSGyFMpsBTEyy+lBrvE83LoBjcAYdj9fYo7Gtu7UwPO5S1mClMY1indSeytE6ER2L8G
 tZsNPb5qn28gaHreF3KEIEYinnY0KnTP09JfHUBjs2iI2kJ6fkBlN6LfpFE3gO0Ki8Wn
 cdtUDnF/VHGjq7kVkQh4FOpjvrwFtoKAyrYLggGE3YLGvB/T6T17EKLdOybeBaSaD41f
 lf8eOhsV6UTZMjFfvT7OqI3OUGSFRhHCd48+VcFRc6nsoF+e9tnlXzeXY/M7REI1jqtc
 C1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721784305; x=1722389105;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9xRqWbOHwUPm6fyXbXbkTNzpkPrKCWETUbO9wuE5Bl4=;
 b=l4zd3xtYo4v/t6i7o+nSqERkL1Vsorgv0RrnvKWiNc0rdP77CBiIHKGd+heZmE5aN+
 7j7xIf8UkT8HupupW5sEYijK5c0HmmRFZ7dbel9ohpEuOAVg3vLo9AqK5HtUoPHUuUZf
 OYl3iV+o8BiB6O1T5r2Gk5ixpi5KEMGLoD7GT450S97pX4pCCFGw/Q9FvkXbQNC0x6Oe
 cU+2otNENolDlMPQLHgiHntXdkvjc58N3L48y9tm5jP1qecQMlzan9P/vilhHEBAlCPu
 Wy3ReipydSM50eCJ+haF0GKYkkogvACghXknPe++Kxssi4FzMkdxI/SQl29bR2hp1FOX
 bI+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwDviMhE1k4Yh9lEQ2thOHg9zxoC8Q5bXhBY7hNtWd4aAGtKvi91VKdJ6Aqw9ekdbAQizVkzCPAq4VHAJw88gqu0hWUac=
X-Gm-Message-State: AOJu0Yy531qTCykLJ45zz/ybIAWa2z1s6LOX9lwIMuD0Kfmsj8g55MRk
 KmHVolKd9Q6M3X6lOfX/jgeKUy6YUnszyfwq9tvy+081i6wCJP9+/W8dlbB9Ls0=
X-Google-Smtp-Source: AGHT+IGTBw9RPnaEIGTCwHXLVO6rNhr/bWm8cn3b74svAit8xjc7hLJZi1aFv755Aq3R35wu7rpzvA==
X-Received: by 2002:a17:902:c950:b0:1fd:a942:1558 with SMTP id
 d9443c01a7336-1fda9421858mr70103515ad.40.1721784304405; 
 Tue, 23 Jul 2024 18:25:04 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f487857sm81789165ad.281.2024.07.23.18.25.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 18:25:03 -0700 (PDT)
Message-ID: <cbcda096-252f-4a68-be0a-26db086c091b@linaro.org>
Date: Wed, 24 Jul 2024 11:24:56 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/61] virtio,pci,pc: features,fixes
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <cover.1721731723.git.mst@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/23/24 20:55, Michael S. Tsirkin wrote:
> changes from v1:
>      dropped two patches:
>          hw/pci: Do not add ROM BAR for SR-IOV VF
>          virtio: Always reset vhost devices
>      at author's request
> 
> Akiko, I think the on/off rework is a bit risky so close
> to the release. So pls rework your patch not to depend on that.
> Also pls note you still need to fix s390, if that does
> not happen by say rc1 I'll have to revert all this stuff
> by rc2, and defer to the next release.
> 
> Thanks!
> 
> The following changes since commit a87a7c449e532130d4fa8faa391ff7e1f04ed660:
> 
>    Merge tag 'pull-loongarch-20240719' ofhttps://gitlab.com/gaosong/qemu into staging (2024-07-19 16:28:28 +1000)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> 
> for you to fetch changes up to 4f947b10d525958578002848a92eeb6152ffbf0d:
> 
>    hw/nvme: Add SPDM over DOE support (2024-07-22 20:15:42 -0400)
> 
> ----------------------------------------------------------------
> virtio,pci,pc: features,fixes
> 
> pci: Initial support for SPDM Responders
> cxl: Add support for scan media, feature commands, device patrol scrub
>      control, DDR5 ECS control, firmware updates
> virtio: in-order support
> virtio-net: support for SR-IOV emulation (note: known issues on s390,
>                                            might get reverted if not fixed)
> smbios: memory device size is now configurable per Machine
> cpu: architecture agnostic code to support vCPU Hotplug
> 
> Fixes, cleanups all over the place.


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

