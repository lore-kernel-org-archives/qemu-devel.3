Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1DEFD4F04
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 16:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w001p-0006i7-SU; Tue, 10 Mar 2026 12:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w001J-0006VR-JG
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:33:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w001G-0002j0-V7
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773160397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lHK2oj7ebPOCZS8OLmlG+rqQcYiZuzCdGTzZEjr3ts8=;
 b=e45yR4wS2C071OzPCGOtzfUW42vVwisdliB52MvuE1xdreyxTeDYoet3mxe25rKOQYfMbp
 2y9af1XB5yQayzxjMFRlXwEZbfvbFmN3vP1cTa5+wHYywemcQ/dznoGHdGPOt+uN2rm//f
 uy3cA4uIu1XJkwzm3O/h4ja1tQ5BDcQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-D_TDcTs6MBywWf--ent-tw-1; Tue, 10 Mar 2026 12:33:16 -0400
X-MC-Unique: D_TDcTs6MBywWf--ent-tw-1
X-Mimecast-MFC-AGG-ID: D_TDcTs6MBywWf--ent-tw_1773160396
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50921f7da6dso17017261cf.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 09:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773160395; x=1773765195; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lHK2oj7ebPOCZS8OLmlG+rqQcYiZuzCdGTzZEjr3ts8=;
 b=OdQmVwE1YQtVN+Qmv1RDBPntZlbybfbgbEMyCpW3rRRpWE8/vNfevNlBz5Kk2dO/9u
 aVtytIpCZNQTEB7PfXYCOZVQtfbErujxCsg3xqFROzevrkEkpa9c5mngVs1zBqketOan
 /unqnlsqPEj9l5VH3HVPMfH0h3p+1OZZ2qaRZJRM0mqMOgUz8ZhlSsZe6/8mdhnV10gY
 O0U9/xyb2B5Pz6qBuvUWRTtGdTtNdCPt/afJowuv/aF8+qWzajk5tZSvrVdugXk/RTZ/
 EBzlMPdYpqWaCDiwo9WjmJDYiUaNcFETsoi0Q+kFtbWwbD1tO8kn8jdrL7I6buy6qL+q
 2mEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773160395; x=1773765195;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lHK2oj7ebPOCZS8OLmlG+rqQcYiZuzCdGTzZEjr3ts8=;
 b=PVbXGynItrmUaswRkViCPyZiaMGlFEwYLP8c+nT52m5elvNIDuO/egJJ7Rf66Ap6Ws
 Mh4K0PgfzabEEXGnh8xWtd/mnVj2eT0x+xpRn0Xt08tv/I9KIfKXVKeRDveesYnTsRCH
 CPZb8TzPilpxTOt5yoQf9mUh9BLyP+5JQqDCqgbLPVsyOSMtYK66wGzHZCzxKgacsXG7
 01Bvs2qhJpGydeRDtwao06Ts/jUy90aGQ/VmDsvItNLGWg7/i8ZKls0iULMLA2u5viXv
 uyRzxx7ja27d10Ap1MB2cGxNzsCAkmKcz4J/aiovNpJEbbX4aQ49V7jdnoEM1Vrqf86M
 Vh2g==
X-Gm-Message-State: AOJu0YxpYxEPW+DR1SyDeJRoImyjnwaAc0bBgTaLdO61fRKbhNx55cKN
 VW9jIKyc4+DbUjCjvq1BTscjIXcNym17pMG1wFHf8lN8WD04GYSw/TnEWUGzEeeb9GVoTjcyDOF
 s1+avZymwrVAmn+w31q1CMFzsXEx1UVRbgxniGb1VR5XMut7XpBTRsDZ31/HToL4H
X-Gm-Gg: ATEYQzzgxTnX6a0ae4VvDhgjUh6c0ucmRfmaN9j3xoaAFMNR5KhJSOt47Ivy1GXmSw/
 7WV2QE101iMUM3485XxYuX4adiyN+QnWU5hsGUECLc2SjYYMmQs/KvRCiSRgDnLK8XRFU7FIDRK
 0OfDgf+ccpulDneOHL1leSfgiLdr7trR6U0rD/KyUinlmRr9IzzLhNXRbuSliga9vC3JTL0ezVD
 jTIR7aKc1YSMQ9vDPRGCSMQKbN4KrdHPTWZ03aXeQTEg1bku9YL/B4NEmPb/HYu3Y/oy0HWbZQQ
 gFXiOOz2JmroIduGWOcOCCox82gtQ+t8Cf9MhgSr/neiVC07XQ7XBszoOqeoglbZ9rJCAQ5gQJ0
 bxFKf0Uj++tCk0g==
X-Received: by 2002:ac8:5815:0:b0:509:2ce4:28d5 with SMTP id
 d75a77b69052e-5092ce43323mr28157331cf.72.1773160395322; 
 Tue, 10 Mar 2026 09:33:15 -0700 (PDT)
X-Received: by 2002:ac8:5815:0:b0:509:2ce4:28d5 with SMTP id
 d75a77b69052e-5092ce43323mr28156891cf.72.1773160394737; 
 Tue, 10 Mar 2026 09:33:14 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-508fcd9e5c8sm80213331cf.26.2026.03.10.09.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 09:33:14 -0700 (PDT)
Date: Tue, 10 Mar 2026 12:33:12 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 qemu-trivial@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] docs: Move xbzrle.txt into the migration folder and
 convert to rst
Message-ID: <abBHyNfxF2zSRhCJ@x1.local>
References: <20260310092822.21232-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310092822.21232-1-thuth@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 10, 2026 at 10:28:22AM +0100, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> xbzrle is a feature of migration and thus this file should go
> into the docs/devel/migration/ folder. While we're at it, turn
> it into proper .rst format, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Thanks!

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


