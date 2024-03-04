Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B801AC54E49
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 07:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh2dE-0005Gi-LF; Mon, 04 Mar 2024 02:21:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rh2dA-0005G2-56
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 02:21:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rh2d7-0007io-Ft
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 02:20:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709536855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NoaWI+2GAwjVHvAGq2Q0BGtqc1u6WEv158TkR0kkcik=;
 b=QirsoovZ/2akhmXqNqvYjkysMuQEX8vpQQyOhwT9/seRkoOwG1lPKSzhQCneOoQ5D74tqK
 n5sykI4N2sFJLrX45+Kd4o4F81MOXBDpSjE/0koWqzEt9EN70DKpBJ+p05hTayA9bzDUrl
 0WcvdBA8KpyqXN+Em0dFxnD7tVwM7p0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-R8TipcUsNLCr1ksK7gmNnQ-1; Mon, 04 Mar 2024 02:20:53 -0500
X-MC-Unique: R8TipcUsNLCr1ksK7gmNnQ-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5dc97ac2facso1754421a12.0
 for <qemu-devel@nongnu.org>; Sun, 03 Mar 2024 23:20:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709536852; x=1710141652;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NoaWI+2GAwjVHvAGq2Q0BGtqc1u6WEv158TkR0kkcik=;
 b=rlHC5H0XvA8uo80TJv6moaHOrZyQJeT1qI8sFTRKMyShZDQabwACe8eQATc7qV2Vih
 dCgEqSB4y6/SOsEUWRL6dTK4AK2QXhg7cvAz8iaAhOScQs0bEcKPuXQTyAoylLLCef3g
 QMrfyc+NqPI5ZKfR/GtyZtpDLkDrWjgPDR9FOHw9HcpPiaYtP2cRoVcXxfybYGVfJqq/
 YN+PeEb3oORKiiEU/yEJOyRtCtfaj/gQGhfurmGpk6aap2w+QAxqeLYG8ELbNPUe06yw
 uCiVE3i78gz6Vyboj5SRzPpeg2xGEl1m+FyrMnZ7wt8W/EzmzzdT2oM8bzWXZ8vJzudf
 Z5uQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOVQdckA+eia2V1FA5c+s/ytCW64fhupAsqrT2N1CrRHpytsMFtMBAyUNN5lK8GyZoH7b1oKxW1/t5ADngKxEzIQvh/0Y=
X-Gm-Message-State: AOJu0YwzUhd+oluJJAFfT5FZjEpAdBQvevBVL9B9k2ypUal/zmAy+GuR
 YzrWz4tmLjSQX8QrHNpRw2VO/JbPql3b7ETyH786ldhp0EDgJZk5SET94bMLIbA1vP5CxjHMNac
 v4HjEgUm9ag3AbUa5/+K7+G8FLVU7owOLZQssuD+Gs4Khojs0g9m/
X-Received: by 2002:a05:6a20:409c:b0:1a1:4793:b6f7 with SMTP id
 a28-20020a056a20409c00b001a14793b6f7mr4809361pzf.6.1709536852776; 
 Sun, 03 Mar 2024 23:20:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFoP6qg94mkxzqKuCP5X2B0UzTR2CWJ22Y5iaaHytOaaveywcoHCpyiT6EDUZFh1Zne7/veg==
X-Received: by 2002:a05:6a20:409c:b0:1a1:4793:b6f7 with SMTP id
 a28-20020a056a20409c00b001a14793b6f7mr4809350pzf.6.1709536852503; 
 Sun, 03 Mar 2024 23:20:52 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 b3-20020a170902650300b001dcf7c2939csm4113596plk.105.2024.03.03.23.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Mar 2024 23:20:52 -0800 (PST)
Date: Mon, 4 Mar 2024 15:20:40 +0800
From: Peter Xu <peterx@redhat.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 4/7] migration/multifd: Enable multifd zero page
 checking by default.
Message-ID: <ZeV2SDWF2skToUoX@x1n>
References: <20240301022829.3390548-1-hao.xiang@bytedance.com>
 <20240301022829.3390548-5-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240301022829.3390548-5-hao.xiang@bytedance.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Mar 01, 2024 at 02:28:26AM +0000, Hao Xiang wrote:
> Set default "zero-page-detection" option to "multifd". Now zero page
> checking can be done in the multifd threads and this becomes the
> default configuration. We still provide backward compatibility
> where zero page checking is done from the migration main thread.
> 
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>

Either this patch can be squashed into patch 2, or you can move
hw_compat_8_2[] changes from patch 2 into this patch.  The change itself
looks good.

-- 
Peter Xu


