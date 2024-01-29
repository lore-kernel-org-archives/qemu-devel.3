Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24072C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 07:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUMCQ-0002aF-Gc; Mon, 29 Jan 2024 02:36:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUMCO-0002a4-49
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 02:36:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUMCL-0000tM-PE
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 02:36:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706513812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d8APqq1E9+6HzzUFhKPKSUlS43TI0xQN1ne3tS0m8ZE=;
 b=gcuc7PABKKmTa4ZjBun7Jjf3UkSt3NsLJbQy3sFdPl5eyVxTjpEsGiK2uKbaRXjfvrrrvX
 wOm2nyVJ39a599mnx/3pn55MGPqP12uz1B/79QN3jLt6kRj/iyna2KgEyIy+6/4WdQjfLg
 AxyjiDt11QhZdAU0hcZv7FWwmIQpRKQ=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-Rxp0dJjzMiG78QZD-WyIXA-1; Mon, 29 Jan 2024 02:36:48 -0500
X-MC-Unique: Rxp0dJjzMiG78QZD-WyIXA-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5d57b2d2758so663590a12.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jan 2024 23:36:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706513807; x=1707118607;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d8APqq1E9+6HzzUFhKPKSUlS43TI0xQN1ne3tS0m8ZE=;
 b=P8zAxx5GJL4T0AWOPQIDzlETR6EHFEHcTy7b6GIcN8CI4NSdHQZb5vpVDLuE1YvMz6
 7XvLb53cMkRKoUCKZeB2Qq4qFH8aFVbTCG7ygY3492DirNNx5D/mDSLBwtjBzEltt8Hj
 zJO0SXrGpJ4doENywUcGY/udsp89vGFZSsWuuo6MeilOs3YJhwFizPGpkfVnCpboCX37
 T5howuVL+kvFWM3LwGWfUsRUbt88a01m/8Mb4Wako2QyF5vJSiL/wTLTaK/58Pz/lW7g
 jY988e++XE0mAfLRDN7p3CkHfzMkGp3CgK0Ogsnyujh84lbXf4Km9i4rJezqAd2VZ4me
 YQEQ==
X-Gm-Message-State: AOJu0YxqRl5xLiUjGm7JNjZ9x9kDWs4ov2Gqhp7jsZppf5zAhf0uUDtw
 CONv/kv8q2QyamGidcsxhOxE3ertizoLVCNqzLei4ZWN58fWo7N+Nv/Tsy26P1+kyM6W2A1qpHi
 MDJGstyQU5k7oSpaZ1D+qyKAJDrtNZwbZ34dvQXcl+kAPlTI4zs4B
X-Received: by 2002:a05:6a20:da87:b0:19c:a1b4:e52e with SMTP id
 iy7-20020a056a20da8700b0019ca1b4e52emr6269389pzb.0.1706513807603; 
 Sun, 28 Jan 2024 23:36:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHw3+ajwp/Sk0Tyb7nLARbKN18sAXHqQxRpE+aEtrphDoUBduXtM+Amo80qFoRTJm2Um6kW6A==
X-Received: by 2002:a05:6a20:da87:b0:19c:a1b4:e52e with SMTP id
 iy7-20020a056a20da8700b0019ca1b4e52emr6269376pzb.0.1706513807172; 
 Sun, 28 Jan 2024 23:36:47 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 sh9-20020a17090b524900b0028c5585fb41sm5531063pjb.45.2024.01.28.23.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jan 2024 23:36:45 -0800 (PST)
Date: Mon, 29 Jan 2024 15:36:36 +0800
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yuan1" <yuan1.liu@intel.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Hao Xiang <hao.xiang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: Re: [PATCH 0/5] migration/multifd: Prerequisite cleanups for ongoing
 work
Message-ID: <ZbdVhLTLo5udNfeL@x1n>
References: <20240126221943.26628-1-farosas@suse.de>
 <PH7PR11MB5941BDAB9743C53A9E08CC3CA37E2@PH7PR11MB5941.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH7PR11MB5941BDAB9743C53A9E08CC3CA37E2@PH7PR11MB5941.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.485,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Jan 29, 2024 at 01:41:01AM +0000, Liu, Yuan1 wrote:
> Because this change has an impact on the previous live migration 
> With IAA Patch, does the submission of the next version needs 
> to be submitted based on this change?

I'd say hold off a little while until we're more certain on the planned
interface changes, to avoid you rebase your code back and forth; unless
you're pretty confident that this will be the right approach.

I apologize on not having looked at any of the QAT/IAA compression / zero
detection series posted on the list; I do plan to read them very soon too
after Fabiano.  So I may not have a complete full picture here yet, please
bare with me.

If this series is trying to provide a base ground for all the efforts,
it'll be great if we can thoroughly discuss here and settle an approach
soon that will satisfy everyone.

Thanks,

-- 
Peter Xu


