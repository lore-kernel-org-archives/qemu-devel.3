Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2881E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 22:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTTKP-0003m0-Bm; Thu, 02 Jan 2025 17:06:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tTTKJ-0003lT-34
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 17:05:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tTTKH-00072H-PH
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 17:05:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735855554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wMlq/1GSMu9/VYrTL5O/zrXFHbMl3StzXyqetKzGB4Q=;
 b=Hmw2YWCgkf90lGO7Tf58IVxiwwmUFrpuwJpvnmkvq+sa3S6apYaZ8oewXw+Ao5L2c+p8wu
 7gxGn4jzrRjsMtGaNcfYBu0CN636Jhp/U3u9gPbaEPvKZJcVeXbYgWU0LAOHFGSm03wBVh
 NK6xeH2RogfFUWFP7dOyBq4NGSv51vs=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-7taYNPA1NUWLbBIf12r2Fg-1; Thu, 02 Jan 2025 17:05:52 -0500
X-MC-Unique: 7taYNPA1NUWLbBIf12r2Fg-1
X-Mimecast-MFC-AGG-ID: 7taYNPA1NUWLbBIf12r2Fg
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-51610d5f436so1410142e0c.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 14:05:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735855552; x=1736460352;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wMlq/1GSMu9/VYrTL5O/zrXFHbMl3StzXyqetKzGB4Q=;
 b=E7c0+Z0uYSCGAJibOKneKHvfdZk+tOzh9tm9ONsnfEC+4E7spoROBTVFXltN2tSIws
 0afVYAi/uHmvLkbpK3sZh95PglKlDE54ClzKGDMw+TPYih/Sf2v0aWEirK2bNRwb76LO
 hzebUKDWevorK2RzFkoAc+5xETUXizgKF672wuZS8MU/U6A72yuaAbHESRXBg8uIWBRL
 EEzc3qtV9KKgQYiirqZzfXXH0GoBUZaNGJLd9yQCe3+qgExmkgpwT6i7j3sQ76ForiWk
 xfLRL9XJOlu2gmvr3kF/TG5EnG1ii9aNmwqfbfBteyEaXsrHSwTqswea6hj7hXjcPfmG
 bOyQ==
X-Gm-Message-State: AOJu0Yx28lbb9TOWAqduh0vgtL9kZMdqS0chG+T9FEVm/3F+g9Pcm/9g
 qunK7p6RgIgKaeR83VpyZPGerW8+/LzKfLhYgBL0A3yU0wrMNGUau7uBYeiSb0XSYtS+ycLcluZ
 vB9aIQuN9iZMW1MDnAjhvja54UjDivijSGaRhCf2l53sBKBvONJT7
X-Gm-Gg: ASbGncv1VmnhMilVqvlfAGASzZ+LEq0WXFcxSi/jwCe4qHbY19m2c+bZWxh/1IoRa7O
 N8j4moO/rtavJ4AJGXfo8XR5tiHxR6OurNqj8ZWLl1y5ufluVfxY8AX/iEW2/dNKSYF+IyT/RRo
 fixpun/pMFE7Dh4vH5VJaSwcqypMo9BebCMcGOysMeNzbhH0v2VXACgUZvoyhiRvn9M+jJ3etCk
 d4cK64UZhFtqgT4I/D2k813HYRODSTrZN3Y2S9JcZ9yqn429aelgHk19E3OU17Z5BZY094CrGtU
 nzXX+UA4lUsZlV8fdQ==
X-Received: by 2002:a05:6122:3209:b0:518:d26a:a819 with SMTP id
 71dfb90a1353d-51b75ab8554mr33807631e0c.0.1735855552243; 
 Thu, 02 Jan 2025 14:05:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWffsqIKjnrGV+mh39CT6kwMEGtLQOL+mPZ1tsBxwhK8X6oeVkO7srN2IBdmAJQPT/xB1gIg==
X-Received: by 2002:a05:6122:3209:b0:518:d26a:a819 with SMTP id
 71dfb90a1353d-51b75ab8554mr33807600e0c.0.1735855551844; 
 Thu, 02 Jan 2025 14:05:51 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-51b68d08e7esm3260652e0c.44.2025.01.02.14.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 14:05:50 -0800 (PST)
Date: Thu, 2 Jan 2025 17:05:47 -0500
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v4 1/8] qdev: Implement qdev_create_fake_machine() for
 user emulation
Message-ID: <Z3cNu3ieQ6688QYR@x1n>
References: <20250102211800.79235-1-philmd@linaro.org>
 <20250102211800.79235-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250102211800.79235-2-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jan 02, 2025 at 10:17:53PM +0100, Philippe Mathieu-Daudé wrote:
> When a QDev instance is realized, qdev_get_machine() ends up called.
> In the next commit, qdev_get_machine() will require a "machine"
> container to be always present. To satisfy this QOM containers design,
> Implement qdev_create_fake_machine() which creates a fake "machine"
> container for user emulation.
> 
> On system emulation, qemu_create_machine() is called from qemu_init().
> For user emulation, since the TCG accelerator always calls
> tcg_init_machine(), we use it to hook our fake machine creation.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


