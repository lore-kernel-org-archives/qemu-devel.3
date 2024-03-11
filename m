Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788A3C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 19:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjlMl-0005Mu-2l; Mon, 11 Mar 2024 15:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjlMW-0005Li-JC
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:31:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjlMS-00049E-H2
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710185459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dghpxPpid9a3FQW/vWrfjY0GBwO957rIYOYvXoeh2bU=;
 b=DQdvVC1thyyMtPNsl1TCUX6bqtRO6UsrTS+L6tFpyVtxfV2mWyrUgyMYKTh9EIIORZ4MeH
 Or/eygXxfLr5SSrQplHe3UQs8omu36jypfo2iCf4abK4EicvWor5IgADz2Jdd4UySmq8os
 5ZaPMzgLkhf2bnKMwYXEoqNIKtlx0Qw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-DJ2XrlGRNvCk1xIoiKp3QA-1; Mon, 11 Mar 2024 15:30:55 -0400
X-MC-Unique: DJ2XrlGRNvCk1xIoiKp3QA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-78315f4f5c2so164017585a.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 12:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710185455; x=1710790255;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dghpxPpid9a3FQW/vWrfjY0GBwO957rIYOYvXoeh2bU=;
 b=WuotbrQ4Y37bbRdY2+DZVFxRzTrlqXGoz6hyc8i9HKVW0hjz0pWTcf8sGe5rn6OGY3
 NS8wGrgPbeCPrD7wk8nbZ7yIevCQRoUDo5RkzoUgGA/0umy/vGq7V1U9i+UlEzfcLcVf
 v13BZT40dscAXEYf2qaGzJNlD+ZOASvCgSY8MUxX8IIvP8ZQCqcgm0cRSfhIDCnsmpJk
 /uhhurDiW0z54m6rZFr9NlknMk1eUiwbtT2GWIaEs14WqMImUAFZf7Phn+3gkX+BnBjS
 MrAhkdw6m0euhW9dgcdIbDyfAatK38O3POzYZx5ewFNszCaOUdwMN5k9sg8WYGKUFYL0
 /Ajg==
X-Gm-Message-State: AOJu0YzLeKns7Qtj7QoJKta+xNwqPdezzxflFXbF3DKj9FLoAt31MsfZ
 XqdI4hyFEWElpxIX3IiFtDg9BJcldMfntrYrbStKab7yT6djEjW4mfhW3y6yTtl46UkKfjkDgra
 fDn6UJxcfLT77tz7Kv/hXGgvst43bFaxcZ1hdZOIdxoWPyc0ULZ8H
X-Received: by 2002:a05:620a:1a86:b0:788:7554:e529 with SMTP id
 bl6-20020a05620a1a8600b007887554e529mr1878537qkb.4.1710185455305; 
 Mon, 11 Mar 2024 12:30:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhCp3eaO03LKAtOqMhdote0hm6JAyiTkiP7zIQ94OvuG3O6gYa60waDadQ8wDhsTcJniA9iA==
X-Received: by 2002:a05:620a:1a86:b0:788:7554:e529 with SMTP id
 bl6-20020a05620a1a8600b007887554e529mr1878516qkb.4.1710185454997; 
 Mon, 11 Mar 2024 12:30:54 -0700 (PDT)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 h25-20020a05620a21d900b00788577fcee4sm2964693qka.91.2024.03.11.12.30.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 12:30:54 -0700 (PDT)
Date: Mon, 11 Mar 2024 15:30:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Zhang Chen <chen.zhang@intel.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Jason Wang <jasowang@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>, Song Gao <gaosong@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH V2 00/11] privatize migration.h
Message-ID: <Ze9b7JULHLUoYGgV@x1n>
References: <1710179338-294359-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1710179338-294359-1-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Steve,

On Mon, Mar 11, 2024 at 10:48:47AM -0700, Steve Sistare wrote:
> Changes in V2:
>   * rebase to migration-next, add RB

Not apply even to master branch.  Note that there're >=1 PULLs sent and
merged since my last reply..  Perhaps you rebased to the "old" next?

-- 
Peter Xu


