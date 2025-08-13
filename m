Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6C9CA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 20:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umIOq-0001Pj-Bz; Wed, 13 Aug 2025 16:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umIOo-0001PJ-7X
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 16:48:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umIOj-0006xO-C5
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 16:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755118110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=adJM2qwZjYrI3yB7kjTVVIu6lo9rE/k5ihF+BhXpQrE=;
 b=ZVrdHqBaJbXKgIOdIDKZX9wsIdtMoEBQpg7BP9nHl4mM3AqnLi/l/rHCV8+kVRucISTHgV
 7qhkWGS+86382dnp48y1zVOSNv9dFYRKj1JlJsZDgdM4VzSwgncTgg37rwNsdlxxZWrtwU
 f/K27UYUOCx9guxgqKr5bPUKUlIbKfk=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-s-LbhNFQMsCneQ4eNUYmHg-1; Wed, 13 Aug 2025 16:48:29 -0400
X-MC-Unique: s-LbhNFQMsCneQ4eNUYmHg-1
X-Mimecast-MFC-AGG-ID: s-LbhNFQMsCneQ4eNUYmHg_1755118108
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-71d603c7e05so5057897b3.1
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 13:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755118108; x=1755722908;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=adJM2qwZjYrI3yB7kjTVVIu6lo9rE/k5ihF+BhXpQrE=;
 b=Y8Fbipxhe8AUl8L9lmuFobIGRIaSMn/TWXfdt74MzW700Kr3cNpRLkLvgtX1mfly23
 gJjr7pFRsmEzxvHEPDYHXXE8NtAX8o1gzE1n+uFQoyFbCo9LDrP0u/3ACTjtz8Lt4+o8
 7C6U5JseWmn627dCy3KVijB5MvWmgBnppBdYohrOJpRzFwcra+wdtvgUzjLDiRkmPmZw
 Uukzpf8uoD/1uzFzZbAWp8lx8OzZxuEK4fwcmfLtdADYfpYI76A2k4DN0cUyo4FEotPj
 NQnSNmFngDmTJRzvT2Mk1khxwJbaFK57xTtS3jI+5noGYYbIxctwUHU+nSdDwWUPlBsZ
 zKRQ==
X-Gm-Message-State: AOJu0Yzgq8A/fSr/n9ke1tXHl7sIjdfNx32Rpq1/FKbb/vWPCUUhSmmG
 5Lf301E+weix1GDFCSJg8KsZHX4kRtBteJxN6ONZXXgucWZTjBUu7ssI9EG5Itk2EQmuLN5dHtz
 CDCnbyOKabE+OA4EF5D5GNlktWCw4gcUHV6sptOX0RT0cFDPTSUvkyalM
X-Gm-Gg: ASbGnctF6WjuzJaa1H+1fdpBZ1ix6g+nmSGEvkKP+b/+ZVULzHAl/hJMJ5M+3dvmuNK
 NBheL1oZUcr3GqenulfabyG+s7hHizP3zdg8thfbovZgydrAXZVXp7iZMOQ8LhbNJvDltNQ7cRS
 3a+yUmsPh3ilRkAU3ZFOXzAz11D1QYHmAOYgCJYgm4ikKFfaDOu4VL1STt5WIFNMO5eyI+hMeKF
 4LkfrTMBlXX9RGCqBEIGrGUbnRutRyDdHoRNEviROyG3XwdlKJ3YkjEqNfuUSxa/ohOPgfH88l3
 iMeqJjuaprYTCmdSsKatVMP+dq4TJpgocg/YgrcUQ/YREz2GMUzTjo3nPAuwTG4CN5FD6HX8mtT
 lRQm6GX6SCj0kN8bs+0WSRw==
X-Received: by 2002:a05:6902:4301:b0:e90:6d7d:aada with SMTP id
 3f1490d57ef6-e931e152032mr576636276.14.1755118108464; 
 Wed, 13 Aug 2025 13:48:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2rXZxXqvMTCrhta16UraB06FmmfmURkR4LX30/nVeFWB2tc6PFPNVxIH7xbji9KhsUCVhHA==
X-Received: by 2002:a05:6902:4301:b0:e90:6d7d:aada with SMTP id
 3f1490d57ef6-e931e152032mr576622276.14.1755118108155; 
 Wed, 13 Aug 2025 13:48:28 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-171.dsl.bell.ca. [174.89.135.171])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e931d56d5d1sm155917276.24.2025.08.13.13.48.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 13:48:27 -0700 (PDT)
Date: Wed, 13 Aug 2025 16:48:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com
Subject: Re: [PATCH v2 17/24] migration: Remove s->capabilities
Message-ID: <aJz6GFBx683GtkWY@x1.local>
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-18-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630195913.28033-18-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jun 30, 2025 at 04:59:06PM -0300, Fabiano Rosas wrote:
> Last patch added capabilities to s->parameters. Now we can replace all
> instances of s->capabilities with s->parameters:
> 
> - The -global properties now get set directly in s->parameters.
> 
> - Accessors from options.c now read from s->parameters.
> 
> - migrate_caps_check() now takes a MigrationParameters object. The
>   function is still kept around because migrate-set-capabilities will
>   still use it.
> 
> - The machinery for background-snapshot compatibility check goes
>   away. We can check each capability by name (if s->parameters.cap ...)
> 
> - savevm uses the helper functions introduced in the last patch to do
>   validation of capabilities found on the migration stream.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


