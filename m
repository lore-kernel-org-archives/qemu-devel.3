Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EF4C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 01:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUziZ-0001jt-20; Tue, 30 Jan 2024 20:48:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUziX-0001jX-4C
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 20:48:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUziV-0004nE-Ln
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 20:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706665722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GwVZOpYWkIv38F4n8QzYkcfzUqxwluEIlAm74d8UUOs=;
 b=cL5HqaR6klM595rgYWDCl/+xTt1EPLzkFCjPCVqKM0oL+TvHNv2J1EgIiSY1E/jXU7tMTO
 APlWY0HicGZWr5D71Rl7hUo1BUXVwcgFOSHNVbXoc2iIw/Od5Uoa8PssMOyh31UgwRgm8C
 lNkGAYau0QgvVL/2zqpH1gAUiol5YSg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-6FdsPWW-N8mYOzYTPdK2Hw-1; Tue, 30 Jan 2024 20:48:40 -0500
X-MC-Unique: 6FdsPWW-N8mYOzYTPdK2Hw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-295b4ab28b5so285105a91.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 17:48:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706665719; x=1707270519;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GwVZOpYWkIv38F4n8QzYkcfzUqxwluEIlAm74d8UUOs=;
 b=UlKTdDwSBS9jVwBimzGGGLz5WkE+A6mH6MYrURjBE647oid5GhjIZ8yrZUrTnlUU/B
 bSSFrv/y/pil357UT5rq4v2tCV2hpXDwiDduY/gwksprQAZel+6LXCPZXQ2gK5OjZYiC
 rfAJspUnWPZhFY7v7eD1eic+Xo92LiSeHObuVrqMB+sRmwRJwOxtpuSp2/PrJOBSO944
 pyQzi765fChrYBGRspiYuwIFGLEsTQs4V8kU6HpZtqBbYXvq5TDHeyxenTQF0NrbeXQs
 vrbwZu3Lye/MoNecmneu9O8fx+aIA977ePlVon+rVW9BwhBos9ModEk3inrFu9/EZLqz
 kV7w==
X-Gm-Message-State: AOJu0Yytvdnzd36bwQZR4J+IUzexowwSIeTFj4svQFSlX5OPQN3QV8Zu
 teMatW26JE38RNObYlJ/zGrGpkgAtXC09h0fKxN4gpIqZ/aCA/GXGECXS6S1vc6Wqi12napl30r
 l/NOC8547m3qXxsYYaFYMXbiMC/k1vJ2/GOgV5KulEI87IeoB37JA
X-Received: by 2002:a17:90a:c906:b0:295:af17:239 with SMTP id
 v6-20020a17090ac90600b00295af170239mr471630pjt.0.1706665719149; 
 Tue, 30 Jan 2024 17:48:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrnReEQLFNfNCsI0SPAhPVJ9QqlA0WJazGBc+mYoOSsrPYYjP9uozjYHnSDXx2RVa/0Oj1MA==
X-Received: by 2002:a17:90a:c906:b0:295:af17:239 with SMTP id
 v6-20020a17090ac90600b00295af170239mr471614pjt.0.1706665718692; 
 Tue, 30 Jan 2024 17:48:38 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 t3-20020a17090b018300b0029564dec437sm71613pjs.6.2024.01.30.17.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 17:48:38 -0800 (PST)
Date: Wed, 31 Jan 2024 09:48:31 +0800
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?=E2=80=9CWilliam?= Roche <william.roche@oracle.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, lizhijian@fujitsu.com,
 pbonzini@redhat.com, leobras@redhat.com, joao.m.martins@oracle.com,
 lidongchen@tencent.com
Subject: Re: [PATCH v1 1/1] migration: prevent migration when VM has poisoned
 memory
Message-ID: <Zbmm74bJ7Zk4HUR3@x1n>
References: <ZUwCZdZj-vZD1NJC@x1n>
 <20240130190640.139364-1-william.roche@oracle.com>
 <20240130190640.139364-2-william.roche@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130190640.139364-2-william.roche@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jan 30, 2024 at 07:06:40PM +0000, “William Roche wrote:
> From: William Roche <william.roche@oracle.com>
> 
> A memory page poisoned from the hypervisor level is no longer readable.
> The migration of a VM will crash Qemu when it tries to read the
> memory address space and stumbles on the poisoned page with a similar
> stack trace:
> 
> Program terminated with signal SIGBUS, Bus error.
> #0  _mm256_loadu_si256
> #1  buffer_zero_avx2
> #2  select_accel_fn
> #3  buffer_is_zero
> #4  save_zero_page
> #5  ram_save_target_page_legacy
> #6  ram_save_host_page
> #7  ram_find_and_save_block
> #8  ram_save_iterate
> #9  qemu_savevm_state_iterate
> #10 migration_iteration_run
> #11 migration_thread
> #12 qemu_thread_start
> 
> To avoid this VM crash during the migration, prevent the migration
> when a known hardware poison exists on the VM.
> 
> Signed-off-by: William Roche <william.roche@oracle.com>

I queued it for now, while it'll always good to get feedback from either
Paolo or anyone else, as the pull won't happen in one week.  If no
objection it'll be included the next migration pull.

Thanks,

-- 
Peter Xu


