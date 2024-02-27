Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C31C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1resXt-0002PN-EK; Tue, 27 Feb 2024 03:10:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1resXn-0002OS-SX
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:10:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1resXi-000082-9L
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:10:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709021424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sD9MbxZdVRrNa9Pji69aJcEVK0hIDwQp91XyTP892Tc=;
 b=hfYvp+6OSjVlYDup9eRL3XyNK5Beunso5ZBA0pniVilZkWBptXDCvWiFpC6CsTXXTUDUZS
 mOZxeXMOONt8hWigzuK5F7/D6mYzKoOBp4+pY4fM9ca+VUxDr4dx9fNd6RV6fQt3f/5EC+
 +NoqPtYW8AC5fmCR9ciSWVMum0tjfpA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-7teePlejMlKvQ1_Phex_AQ-1; Tue, 27 Feb 2024 03:10:21 -0500
X-MC-Unique: 7teePlejMlKvQ1_Phex_AQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-29a0b097af4so402897a91.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 00:10:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709021420; x=1709626220;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sD9MbxZdVRrNa9Pji69aJcEVK0hIDwQp91XyTP892Tc=;
 b=V4NRgJBdVtSf0fbT/qs6/BhhAgfHsYUoKjj2jZs1dydsRTjcJTX+FK6JrNLGlD04HR
 2BlEN8ZROIWEn/hzf4PqNAHOiZEtEQXzQGL6FhLRtkXns+wrYuYsL38/8Eb+AO3yUfcP
 uyWA+e7l61LyP1FMp2FKIxvsxJ9PF8EDvQ0Vqb+MUn4kfRdpqQdgvODEunMHol9pWxsB
 inIhDF2XJrwYq1L/pPrm5Hg504kp0tNVL8Eh39jcZtiT5tRgyBGvVUGBfwk2cCPIYABS
 OqUTYwXebZHsYtLN2At8uJw225PCUnPWumROajljC00uBlf/Txv+uMDM1cjbXK3X2ml5
 u2JA==
X-Gm-Message-State: AOJu0YxhObuupQqI47QjNCnyl2ipuFocn7dy8qOSkmOWJEG50oHhEjl3
 agyxFW94viWJ5n1GyuvKAD9PTctwGo34Jnr5XM/l6s/1zcS4audX3xuSVYSWaT3EZlTXwYlEhNj
 6ytQtqHZ0nZSj5EAYZZ/7FzGUnnj3kBTWGLuOvhRh7sOdiKLzb6qBmwojNKEV9VE=
X-Received: by 2002:a17:90a:6787:b0:298:c3b4:f6ab with SMTP id
 o7-20020a17090a678700b00298c3b4f6abmr7572267pjj.2.1709021420334; 
 Tue, 27 Feb 2024 00:10:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrRUFH2Cl5PXEW32dfoMb8Sh9soJS1lG8d2uHYBZG83B3Oj3v/uBupCcZE00rknZqZsbq6iQ==
X-Received: by 2002:a17:90a:6787:b0:298:c3b4:f6ab with SMTP id
 o7-20020a17090a678700b00298c3b4f6abmr7572256pjj.2.1709021419959; 
 Tue, 27 Feb 2024 00:10:19 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 r7-20020a17090b050700b00298dd684b8csm5809493pjz.32.2024.02.27.00.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 00:10:19 -0800 (PST)
Date: Tue, 27 Feb 2024 16:10:11 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] migration: Fix qmp_query_migrate mbps value
Message-ID: <Zd2Y4zwoBaKRSqnZ@x1n>
References: <20240226143335.14282-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240226143335.14282-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Feb 26, 2024 at 11:33:35AM -0300, Fabiano Rosas wrote:
> The QMP command query_migrate might see incorrect throughput numbers
> if it runs after we've set the migration completion status but before
> migration_calculate_complete() has updated s->total_time and s->mbps.
> 
> The migration status would show COMPLETED, but the throughput value
> would be the one from the last iteration and not the one from the
> whole migration. This will usually be a larger value due to the time
> period being smaller (one iteration).
> 
> Move migration_calculate_complete() earlier so that the status
> MIGRATION_STATUS_COMPLETED is only emitted after the final counters
> update. Keep everything under the BQL so the QMP thread sees the
> updates as atomic.
> 
> Rename migration_calculate_complete to migration_completion_end to
> reflect its new purpose of also updating s->state.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

queued, thanks.

-- 
Peter Xu


