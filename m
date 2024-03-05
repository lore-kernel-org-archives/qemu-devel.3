Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1B0C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 08:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhPpR-0008Jd-Ha; Tue, 05 Mar 2024 03:07:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rhPpP-0008JL-Mw
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 03:07:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rhPpO-00037N-5p
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 03:07:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709626028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KKeITFfCj1Qf2jgbp/wq30l5utzI/B6cK+lHlDTXtwc=;
 b=NAPWcDl36415BhsQMWLv9cQjEpYkEoAQjES5fpRxbf/okZufaEWarFHXAesKi6PQhMZk2X
 4YOY2k0+mc8ZQGMaQnwSnraMs3sEabhi3bZbtf7GuR4gurZKUWv6BxHpQTreUjikms68t7
 dnNf5oCbmhE92IDgq2LC2DhIUZ6QV4s=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-6MDT12k-PBaNOCsxtef2ZA-1; Tue, 05 Mar 2024 03:07:04 -0500
X-MC-Unique: 6MDT12k-PBaNOCsxtef2ZA-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3c195ba7031so1376776b6e.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 00:07:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709626022; x=1710230822;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KKeITFfCj1Qf2jgbp/wq30l5utzI/B6cK+lHlDTXtwc=;
 b=Y7No8Bdu1R1ifcu7cIQNJY+PFACkozc3nSczU36FaR6bEv0taBl2B/5dfIPY0QOcdn
 8EXuZXWccwuIVh0clqxSEILEy+MetHn6HsgFySyoO8qwlVMEHI7defbzwyZPCxJnIaw2
 11DLEcnAVd9po7cAWfTys2M3lRC2EZWnMtO6TAiiB9GOOTU+WmppsQ/uuc5OYye7V8zJ
 yjw1nneYOVRrUM65is2Gx0dqgzjjgn/ZUhgL2LoQXDONOKXolOXXKge8Slgpm+iwj1Kf
 Xub9hDInJADGCGg8+mWDRog/wM8+dfY8d8jFolUPTE5SifH8xCVOPxUnQiIStZoB4RMp
 yuRA==
X-Gm-Message-State: AOJu0Yw1M6+KWVssRYifU/eXyYy6xQh4VmzqXiW5SyGwbMpiPEZU9Oh+
 F5tEpzqDcWInsli6kYQ+d4CtGGSPUYW22giRenFUFTl6+PaCyJpjc8fUDpDLsCZp0Ug6iYd4iiA
 J6DeO+LLSVCFX8kXKR86CA9xt9AtsN77p0p2Ww6sY72UTxaO6azCX
X-Received: by 2002:a05:6808:2005:b0:3c1:e998:2ff5 with SMTP id
 q5-20020a056808200500b003c1e9982ff5mr7508941oiw.0.1709626021906; 
 Tue, 05 Mar 2024 00:07:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWKo+zhBkDwIbVagTlOxl0lko1mAAWJfL3H/fa967+fDYaDuOyMnpPnWBdgAUlG2QR32ygOg==
X-Received: by 2002:a05:6808:2005:b0:3c1:e998:2ff5 with SMTP id
 q5-20020a056808200500b003c1e9982ff5mr7508925oiw.0.1709626021600; 
 Tue, 05 Mar 2024 00:07:01 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 f19-20020a656293000000b005dc816b2369sm7422289pgv.28.2024.03.05.00.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 00:07:01 -0800 (PST)
Date: Tue, 5 Mar 2024 16:06:54 +0800
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 00/26] migration: Improve error reporting
Message-ID: <ZebSnrfmy0_0GKwu@x1n>
References: <20240304122844.1888308-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240304122844.1888308-1-clg@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, Mar 04, 2024 at 01:28:18PM +0100, Cédric Le Goater wrote:
>   migration: Report error when shutdown fails
>   migration: Remove SaveStateHandler and LoadStateHandler typedefs
>   migration: Add documentation for SaveVMHandlers
>   migration: Do not call PRECOPY_NOTIFY_SETUP notifiers in case of error

These four patches seem to be pretty standalone ones and got at least 1
ACKs.  I queued them for 9.0, thanks.

-- 
Peter Xu


