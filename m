Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5ED8CFB446
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 15:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxpnK-0001KE-MK; Mon, 07 Oct 2024 11:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxpnG-0001JZ-0t
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 11:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxpnE-0001OR-HO
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 11:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728315423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I3EmyoZuIa6O1GIa/gLxZln6v93q8uF0z0Pjgga43Nk=;
 b=Ms+WLQJFiDxeKC2W3O53MyUOi5rDOIpicO0nrN242G6xCmSkY1DhFrZoRJgnY+vzPk1b6O
 R1od/iSVTqQFTMgFKWm1JokGB7eZ9LTo3la9w36VRR3Ng6IQQIiDG2x/+hWqCGfZSRJbA7
 s1BhvVXMWdu0csyanJIQCUHewV3nvWA=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-EuPwqEwRMZGLBm7cALgqVQ-1; Mon, 07 Oct 2024 11:37:01 -0400
X-MC-Unique: EuPwqEwRMZGLBm7cALgqVQ-1
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-8324396d0abso403121239f.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 08:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728315420; x=1728920220;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I3EmyoZuIa6O1GIa/gLxZln6v93q8uF0z0Pjgga43Nk=;
 b=wujSxME/xBeZzuIf7wReNKvh7yM7FAIDntd8rF8i7ZtPnjzoFTLl6MEOVhKrMe/G7d
 DS+HiSsiGJz0wou7rvQw+Aq/kjSFLDSEbaps3jt8AHAVh0QRa9CfWl3HLnXhirixsMh7
 jUfTde7fPAOx4V9M3Dv60YCfiX1MnzMURoDPakpIHO0GIotYl+VQJG1Lf/A1v+6qx7PT
 TeaavBwypy/S7lDZk2Etx5Ay+P7fQXlhc/uNufkmzLl06o9QUQFkWtx2wlc7AT7vz1kV
 GvC8YsXAjIZdME8OncdSp0YpEV5nxkGTTHkD13IsFrPhtJBX0q1w61HuESyWZDo15mHY
 6UIA==
X-Gm-Message-State: AOJu0YyMHPWIJ4PaO3HbMd46IS8+8HUCTfLr1BNItuCb74Mw4zt2/LGB
 mL07pK+AtNcNVMrb/8Zh3hyJtsht6DeWI/fpvYb3ypkNhYGFjdQnKTH0foepCn8+fidP0gO8+Lz
 8NFWdHYUvi0An4KrLUOUunpYOOFNOHB2vQTeMMyTa8OKvlZuUPoNU
X-Received: by 2002:a05:6602:2c13:b0:82a:3552:6b26 with SMTP id
 ca18e2360f4ac-834f7d9568cmr1033196039f.15.1728315420683; 
 Mon, 07 Oct 2024 08:37:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeJYxH+1PlvMXSXdbQjkm2BoNJoiVq7UNV/l8QYC1GSkTZ28cHWGv5Grz/i9rahqosknzyQA==
X-Received: by 2002:a05:6602:2c13:b0:82a:3552:6b26 with SMTP id
 ca18e2360f4ac-834f7d9568cmr1033193739f.15.1728315420275; 
 Mon, 07 Oct 2024 08:37:00 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4db87b088a0sm494998173.179.2024.10.07.08.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 08:36:59 -0700 (PDT)
Date: Mon, 7 Oct 2024 11:36:57 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 01/13] machine: alloc-anon option
Message-ID: <ZwQAGfeAZqyAqrWy@x1n>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-2-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1727725244-105198-2-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Sep 30, 2024 at 12:40:32PM -0700, Steve Sistare wrote:
> diff --git a/system/trace-events b/system/trace-events
> index 074d001..4669411 100644
> --- a/system/trace-events
> +++ b/system/trace-events
> @@ -47,3 +47,6 @@ dirtylimit_vcpu_execute(int cpu_index, int64_t sleep_time_us) "CPU[%d] sleep %"P
>  
>  # cpu-throttle.c
>  cpu_throttle_set(int new_throttle_pct)  "set guest CPU throttled by %d%%"
> +
> +#physmem.c
> +ram_block_add(const char *name, uint32_t flags, int fd, size_t used_length, size_t max_length) "%s, flags %u, fd %d, len %lu, maxlen %lu"

This breaks 32bit build:

../system/trace-events: In function ‘_nocheck__trace_ram_block_add’:
../system/trace-events:52:22: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 8 has type ‘size_t’ {aka ‘unsigned int’} [-Werror=format=]
   52 | ram_block_add(const char *name, uint32_t flags, int fd, size_t used_length, size_t max_length) "%s, flags %u, fd %d, len %lu, maxlen %lu"
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
......
../system/trace-events:52:22: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 9 has type ‘size_t’ {aka ‘unsigned int’} [-Werror=format=]
   52 | ram_block_add(const char *name, uint32_t flags, int fd, size_t used_length, size_t max_length) "%s, flags %u, fd %d, len %lu, maxlen %lu"
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
......
../system/trace-events:52:22: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 5 has type ‘size_t’ {aka ‘unsigned int’} [-Werror=format=]
   52 | ram_block_add(const char *name, uint32_t flags, int fd, size_t used_length, size_t max_length) "%s, flags %u, fd %d, len %lu, maxlen %lu"
      |                      ^~~~~~~~~~~~~~~~                                                                   ~~~~~~~~~~~
      |                                                                                                         |
      |                                                                                                         size_t {aka unsigned int}
../system/trace-events:52:22: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 6 has type ‘size_t’ {aka ‘unsigned int’} [-Werror=format=]
   52 | ram_block_add(const char *name, uint32_t flags, int fd, size_t used_length, size_t max_length) "%s, flags %u, fd %d, len %lu, maxlen %lu"
      |                      ^~~~~~~~~~~~~~~~                                                                                ~~~~~~~~~~
      |                                                                                                                      |
      |                                                                                                                      size_t {aka unsigned int}

Probably need to switch to %zu for size_t's.

-- 
Peter Xu


