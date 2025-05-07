Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8D4C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 19:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCk80-0000O8-QJ; Wed, 07 May 2025 15:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uCk7y-0000JA-QV
 for qemu-devel@nongnu.org; Wed, 07 May 2025 15:08:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uCk7x-0007Sn-9o
 for qemu-devel@nongnu.org; Wed, 07 May 2025 15:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746644900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0n34yfTvuz08b49CJHJtkWP/oG+fiGSiAab94kQ6H3w=;
 b=EIOpb7uuqmCxIAjGjw1X0M9z9UwEQDFFqPHwclEaDNAE/tYnSehpipXuMjabGZgUIVlJg3
 amj9hpipZCWnuN3XZ8G/o9n+7N+VLSy8fINCMT3GkgcfivDG2yA6JV6zVJndxpsaM2b6Ga
 3a1cuXttDbIfX6gobaTBgH5fTA5mB8A=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-Apx1fsQcMtudtWkyyTT1Bg-1; Wed, 07 May 2025 15:08:18 -0400
X-MC-Unique: Apx1fsQcMtudtWkyyTT1Bg-1
X-Mimecast-MFC-AGG-ID: Apx1fsQcMtudtWkyyTT1Bg_1746644898
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c5750ca8b2so26558485a.0
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 12:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746644898; x=1747249698;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0n34yfTvuz08b49CJHJtkWP/oG+fiGSiAab94kQ6H3w=;
 b=hss6VSo/aNajhfBQSX5RIQJ7RNErLnC3DHP3KIcYimlz0kFGe3U7Ia3qiiZVMB9G6L
 wN8TPHoldn8po19N4eLRtnPw00FhtKUB2l8FcdeZNEKt4V53eSt2hORTYrTfY3Y9jRvT
 D8wRMSaUYxjFyds2C33uwQyks4JDbIpFJ0krEWNr7UweOV/fcobcse6/3zqoiGAnnLb5
 qz8qaGzuv+Wj/xFZR/GJirGfcQA8dw37lkNTJTpVebf3zz5laIw+x7zwaCH6TvNHDO4T
 1/3kDgVU34zVU2oX/Unsapb4VGz5UXH9DU01GeyiLLdiS3ccoEVZYljn6DxU3MJSNkZB
 71hQ==
X-Gm-Message-State: AOJu0YwSOCkb7leDUqh7BS3EuQxlL/edhVNy0PEqh2k9//ap3MOPltcb
 exYYLVxLCCNymLQAfXJuMmLGMlo5fanmWBaaSPzVV6Vb2UHGvkz8CcucVEZk3nYXooYdsXB1g0r
 Wiwms7m9fej7zLZCCvSRzratS3vKRpLzUSZSPGXD3Bf5Bh/FY5ZrD
X-Gm-Gg: ASbGncscbLvZXfsZxwOb8OWCxwPdXZjh36/ONLO+tKbPNdZcVN2ve+MnnxQzdZTpxjr
 pUW91mSUZSodMzMLLme1oGuJe/lG2bpxwF4M0yGJveUgCHoltW7uYQAmKrhsif6YEekirV+kHPP
 Fs2DbdGzyashgzLL+46GJa0rjPHN1Q31byYBzH1x8GZON5ic6b/t4qtvXJOJ44J5QZUbyiTZgN7
 ze92KpQohC3luA1lexcvqD1c0WHWYFv7Z9CxOgsl0O12nbGWmQ5h5S8utzJm97CN7f14pt+mOey
 rPU=
X-Received: by 2002:a05:620a:4081:b0:7ca:ee7d:87c6 with SMTP id
 af79cd13be357-7caf739a20dmr618290985a.15.1746644897954; 
 Wed, 07 May 2025 12:08:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3EclioFCJDJjTWYk4r7w6c9xBD+gM3tQEIL+GPPMnyijjZX6mNbhNnjFdXb42ykHWa6ad3Q==
X-Received: by 2002:a05:620a:4081:b0:7ca:ee7d:87c6 with SMTP id
 af79cd13be357-7caf739a20dmr618288485a.15.1746644897694; 
 Wed, 07 May 2025 12:08:17 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7caf75b8741sm194747785a.73.2025.05.07.12.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 12:08:17 -0700 (PDT)
Date: Wed, 7 May 2025 15:08:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] ci: Reduce the size of artifacts for
 build-previous-qemu
Message-ID: <aBuvnw_GfmkhkKnY@x1.local>
References: <20250507155835.31074-1-farosas@suse.de>
 <20250507155835.31074-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250507155835.31074-4-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 07, 2025 at 12:58:35PM -0300, Fabiano Rosas wrote:
> The build-previous-qemu job is intented to produce a build of the
> previous QEMU release for consumption by the migration-compat-*
> jobs. Keep only the pieces of the build that are necessary.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

The other thing I'm thinking is maybe we could create migration.yml and
move all migration stuff over, having buildtest.yml include that..

-- 
Peter Xu


