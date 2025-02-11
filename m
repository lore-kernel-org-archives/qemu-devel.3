Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF04C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 17:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thu8X-0006UJ-Pt; Tue, 11 Feb 2025 12:33:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thu8R-0006O6-Q8
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 12:33:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thu8Q-0008In-93
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 12:33:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739295200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=15l0gEW7iL6v/0ADwVzP8dueSuIReFWpPf5vCTkEojA=;
 b=XQ86CNjWOd+NtaFJTgf56K3vsCAp9jOjEBWOE9g0QLHA8WW7jOnOzmu2seDlEzhF18Oa3K
 LaXF+9FRDM/iP0djNCRmylgTgFL3cAlwGccv1p0PD3EcasV2BleO/lQfP7Yu5UFgIouiLP
 W9ewZPwhV9hfpiWCExAZJHEy4P0tUWw=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-aPhu-dVuME2o19n_MquVAw-1; Tue, 11 Feb 2025 12:33:19 -0500
X-MC-Unique: aPhu-dVuME2o19n_MquVAw-1
X-Mimecast-MFC-AGG-ID: aPhu-dVuME2o19n_MquVAw
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5fc7340efadso3896332eaf.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 09:33:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739295198; x=1739899998;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=15l0gEW7iL6v/0ADwVzP8dueSuIReFWpPf5vCTkEojA=;
 b=LA4Mp+03AvZa5yQ5KfRAgEeAgfnQBsn4RLIs218IeSbE2az4ki3q4MiIQ2jqv4yW+8
 it3Rr/vCk0bVPdkVZJingboRKc4WFIljTYCI0W5LSwk544efGw8zAdXeuE3F/ulWOp47
 NxJ/57AwTghsGfZfp/vayku4V2CWhjxPMmLn/47luQaeQ+fGup4SryOFipUJINF6Dj5f
 VZRG+pXc626LtjJMxl0vZZHTE5zC/KxSxcw/XsUdTp1yi0zwOtGe1HXMjz3dm8PwTSNH
 Hn3xVV/S1D6A92TBftyS414E8VQ5BYQ8ITtmLXN6LsFe1lJaOAwtH7bNKrzxfBQsps1Q
 G2Uw==
X-Gm-Message-State: AOJu0YxBQvk31HDmvV7K6AcW458WIp0/fy8gWvM9azdR+7EVrBZMi3Jq
 /Xr4daKWOqqTSO7Bj32y5HOHx2cYBeDxgZKcpNI95uzwW61MuxziWJuIlWuNrL5nkzqtzJbf4yP
 D53B+Hh0RT3OPrrQg3/Vw8wFgxtEyYQO7QZPNvlsVRFKge9Ij1yF4
X-Gm-Gg: ASbGncuL2rqZmsFTdVo+/tYlAmbzOhDULo23pKUCT/ZGsJyYsEnZ3BMa5CuQbw74Wp6
 aYAVg1SeF3uCmCyz06EqZCgHfZxk/EHC3tRiM3lpUadUmY3uOSgnZCxcuHRBZq+usN85SovTPhb
 XzloaCWIroQhlfmfpyeAN2Pj2YRu53OOOOOViOEwtebcVDP7PUGLgxYO3xIAtyw65W/ZbkyMRch
 sDVjWSDnODiB3e2YSkkFZRuMpLFBE+UrtmwpCFq11lj+bC9/Fr3crVVbz0=
X-Received: by 2002:a05:6820:2614:b0:5fc:9e6f:35b with SMTP id
 006d021491bc7-5fca18ce0c0mr201564eaf.6.1739295198490; 
 Tue, 11 Feb 2025 09:33:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSQzEGNx79kZpGHfAnPXelM0ySXqh2irhB+WC9eCeNqSStBMcYVtQ7WZtz+KV2858WOMHQkw==
X-Received: by 2002:a05:6820:2614:b0:5fc:9e6f:35b with SMTP id
 006d021491bc7-5fca18ce0c0mr201543eaf.6.1739295198205; 
 Tue, 11 Feb 2025 09:33:18 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc80565fccsm1740516eaf.25.2025.02.11.09.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 09:33:17 -0800 (PST)
Date: Tue, 11 Feb 2025 12:33:14 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v2 4/9] migration: Fix hang after error in destination
 setup phase
Message-ID: <Z6uJ2gg_RiIez6Gv@x1.local>
References: <20250211150136.6781-1-farosas@suse.de>
 <20250211150136.6781-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250211150136.6781-5-farosas@suse.de>
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

On Tue, Feb 11, 2025 at 12:01:31PM -0300, Fabiano Rosas wrote:
> If the destination side fails at migration_ioc_process_incoming()
> before starting the coroutine, it will report the error but QEMU will
> not exit.
> 
> Set the migration state to FAILED and exit the process if
> exit-on-error allows.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2633
> Reported-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


