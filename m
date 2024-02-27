Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AAE8C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 18:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf2M8-0000rA-2I; Tue, 27 Feb 2024 13:39:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rf2M4-0000pv-8b
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:39:04 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rf2Lz-0007wm-MQ
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:39:04 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33d754746c3so3083936f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 10:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709059138; x=1709663938; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eTvfs6Hf1kva311HDQ0PdqO/o4vGHdyy7W7BIEnAHUQ=;
 b=DSZTeby2c1rZFmIeohkVFfVM2YiiZOOT+BRxgT8aSP2yn/LGLJlYXu3ZyFLU/PjPWz
 dVxbvjLsZHSdD90T3irqQLQ3g10zdfLG1iwDER9s4EAvjaibw1viMZmDrhFoBq7ev3wA
 xjFM87cz/Xxxl3izTjMreS2l1DQ5E453lZpkqyvaMvvOUo0nqKqqi2NnrBJGQuQ76/+4
 IONgunXjsgVe31/af2MYt5SMY0/Fe5DwtZdeALY8UkOmgTv979XHTl11HGzNbuXBUMmt
 D4BajcgKarQvOqh7M1M/+L5E/DAXO3cns6z4yG60VUlp8kU6Jp5QixuFJrJDbd2tQ+/e
 W/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709059138; x=1709663938;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eTvfs6Hf1kva311HDQ0PdqO/o4vGHdyy7W7BIEnAHUQ=;
 b=b6a+JIHOI+IIaqa3FFiTAVe3Q+27U/uzSkZZkAEFSWE83P910maI/D5GoyHQu0TfFs
 9tXUBkm5+LBr9w7mxUCBJbhXMX6I3+tFxNXiuQA8N1eDLucjbq5fgYSeaeMm36JNkThT
 MysiG8qmfRe9UtJCiyIRDB5Mt0IGWZbxXwGPRI4A6NMn8w5oBcYXXM+/Nx6nsStPJ6UB
 LIfguiwgk70ujwm0wwRkjXJFl0YoCoJuwJ/sMKi2XxkeHb5lqPYQZofx7cPWhJVhTF1z
 cv69rxZCCS7VmlXhL19uIdn5XJ/ejMeYGOv24jZxJjApSDQOZnh/W2qHUUnhgbI+1Sj2
 d6oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJfIJ/PJ6Q353xP/IZSnQUSRD+LEmBOdv/m6zIzI8NO891+uMNoIuIMfiVJXBxBYb4zpUJ93FC8NGP6RPclqrrAw2MJVk=
X-Gm-Message-State: AOJu0Yw5vm1MBejfeEGiAa0FqQeLnxiiQSPRJiUVlxISmj6EC2IqLs8X
 MmP0RaAMXWoI1CFtihnnRChohHzq9PT8VsnVLm1RRz6JxcyfBCyTmGqONAQIOpI=
X-Google-Smtp-Source: AGHT+IHH5qJT7IAmZLobN2okFpSppnF/LLJSvuv2fpvoiEYR86iaRwJbO8Ey5ZTJnhbpX5raX3/4eA==
X-Received: by 2002:adf:e10f:0:b0:33d:5350:774a with SMTP id
 t15-20020adfe10f000000b0033d5350774amr7547461wrz.11.1709059137881; 
 Tue, 27 Feb 2024 10:38:57 -0800 (PST)
Received: from [192.168.69.100] ([176.176.160.23])
 by smtp.gmail.com with ESMTPSA id
 r2-20020adff702000000b0033b60bad2fcsm11931658wrp.113.2024.02.27.10.38.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 10:38:57 -0800 (PST)
Message-ID: <d67e127a-43b7-4991-8217-6acd177a9a75@linaro.org>
Date: Tue, 27 Feb 2024 19:38:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 02/10] migration: export migration_is_setup_or_active
Content-Language: en-US
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Zhang Chen <chen.zhang@intel.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Jason Wang <jasowang@redhat.com>, Hyman Huang <yong.huang@smartx.com>,
 Song Gao <gaosong@loongson.cn>, Alistair Francis <alistair.francis@wdc.com>
References: <1709055807-315099-1-git-send-email-steven.sistare@oracle.com>
 <1709055807-315099-3-git-send-email-steven.sistare@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1709055807-315099-3-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 27/2/24 18:43, Steve Sistare wrote:
> Delete the MigrationState parameter from migration_is_setup_or_active
> and move it to the public API in misc.h.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/common.c         |  2 +-
>   include/migration/misc.h |  1 +
>   migration/migration.c    | 12 ++++++------
>   migration/migration.h    |  1 -
>   migration/ram.c          |  5 ++---
>   net/vhost-vdpa.c         |  3 +--
>   6 files changed, 11 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


