Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05627C021A2
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 17:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thu2J-0003Cf-4N; Tue, 11 Feb 2025 12:27:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thu2D-0003CJ-L1
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 12:26:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thu2B-0006RT-Uq
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 12:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739294815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YhZNYi9qk+Yl7KFEuWMSTQFxteWyLILNamARf8ul/w4=;
 b=I60xsDnJIBj2UjM+P5wYeZOJF0Ncnu77Yzq51b6RWbGnPSxmohHSXbMs5eq7U7jEa0llhx
 my7Ru5B+H9b/psNQjFY+Xyqkg4x/qOOccwlPhFcHUtnbe6H8kQVOY5llGbI0Sypud0Yyz5
 upQkLaGW3svWy2H8WPm5g06+SgoaT7w=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-gYFQvfs2PiaMGJO7mZq61A-1; Tue, 11 Feb 2025 12:26:53 -0500
X-MC-Unique: gYFQvfs2PiaMGJO7mZq61A-1
X-Mimecast-MFC-AGG-ID: gYFQvfs2PiaMGJO7mZq61A
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-29e8124e922so9042466fac.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 09:26:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739294812; x=1739899612;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YhZNYi9qk+Yl7KFEuWMSTQFxteWyLILNamARf8ul/w4=;
 b=Dj754HYqAc/w1rQwWmgvNMter53J7/4SG390PELtr/EoiwL2p0eW/pgYGLRkTJrq2v
 04XdoLnhlGK3ZnNaAfCuxsohu758KHBsQwc9Iq8WmdkTsMCcWFqZHheYSZ1igz/Z8VVm
 zgYrCTIgFE9ELz3pVchDl1XzPRd/AHLs47Td0l0KNGDA/0Mfny+hvF3iRlRgmq61xkX3
 BstEEqXaHu5i1EecebAVykHqyS17ORsJyWK8UCybG7etG6rT3QtR3Q8q4ws6U/Rh4qY0
 P3uap/DWohVpF8ma59FAMasNyQzm2FZLX0wg9LDdSj841g4LPSeToyMqFOh50wV+wcPp
 clgw==
X-Gm-Message-State: AOJu0YzlEUqjPW0BsvAlV7xQIWumOW8q4QP6jwY2TiR4zgHrVFJo+Gvd
 FXvg0rv3ilZ5TFjhKai3Xu8zrmcalmne1eyyczyYIImI0hGcmBOp4ewLZD+XKOK8CRkexISrH2F
 PQBZJRXSl6goKDooFCATQJL1nuZ4XFTgbQDSFJj7p8isxh4fwkNRe
X-Gm-Gg: ASbGncvwrBRzmec1PEVOOW0RTNHGcegv6GuHcNjHmP/0BL/A/4F5SRXvB0grHb+3MUI
 9uCGbjEoEMhx/U1HQUIB8oakI1g5RPie/aXKstX0dQa9VfLwdFVhNV2cjwD5PsXWEFm6+0ytvrV
 l6ALiYvM3KkrIeT9d46VQ6tZxYPfzD2/10X3FiJbiIFXap+dIPCuM/ZX3jTyHWWGrk5H+qpB0bo
 9I3Q/teZ6kL9BNBAfruacIjBjVBlGskiH+CfIWxoiRVq04LQ8Ub4/dAysE=
X-Received: by 2002:a05:6870:2107:b0:2b8:306f:c5ad with SMTP id
 586e51a60fabf-2b8d65155a8mr177547fac.13.1739294812549; 
 Tue, 11 Feb 2025 09:26:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsacYHPy+VB/5GQ8sJWE3q6My8Sdsbd3+KoNKAHadhdwvf3l8plr+Y6EfAa8bNBQsClLe6ig==
X-Received: by 2002:a05:6870:2107:b0:2b8:306f:c5ad with SMTP id
 586e51a60fabf-2b8d65155a8mr177532fac.13.1739294812283; 
 Tue, 11 Feb 2025 09:26:52 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-726af951a22sm3486104a34.37.2025.02.11.09.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 09:26:51 -0800 (PST)
Date: Tue, 11 Feb 2025 12:26:48 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v2 2/9] migration: Unify migration_cancel and
 migrate_fd_cancel
Message-ID: <Z6uIWLJOxG0HUvjI@x1.local>
References: <20250211150136.6781-1-farosas@suse.de>
 <20250211150136.6781-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250211150136.6781-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Feb 11, 2025 at 12:01:29PM -0300, Fabiano Rosas wrote:
> There's no need for two separate functions and this _fd_ is a historic
> artifact that makes little sense nowadays.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


