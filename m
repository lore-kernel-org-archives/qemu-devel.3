Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6A8CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 15:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNuSY-0004do-Ru; Fri, 15 May 2026 11:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wNuS0-0004Yk-AT
 for qemu-devel@nongnu.org; Fri, 15 May 2026 11:27:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wNuRm-0005vw-Lu
 for qemu-devel@nongnu.org; Fri, 15 May 2026 11:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778858843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QHKRrNT8KAAWbZ/IY+TAFb7TI1pw84R4++vha3oZD/Y=;
 b=Ns96l4/81F+tO6U4nUiFyimgrN0o87YIeRH5LPqCY/9D3t2faFCO5uSWTI2dKdF6fBODgb
 /f1f13ItJCWblfrsgQKSm9h0e0/BxoCXjptgnu0G64jO5gRnc0tsx3hqy3EECa/3b/3KrX
 QTklobyUsw+VKQzhFTmBHOZI+W2uj9Y=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-YvwFcADTP7e-CrByREG1hA-1; Fri, 15 May 2026 11:27:22 -0400
X-MC-Unique: YvwFcADTP7e-CrByREG1hA-1
X-Mimecast-MFC-AGG-ID: YvwFcADTP7e-CrByREG1hA_1778858841
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d8e8c47a3so70383381cf.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 08:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778858841; x=1779463641; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QHKRrNT8KAAWbZ/IY+TAFb7TI1pw84R4++vha3oZD/Y=;
 b=qLMB7F7OGDT0psLB67F0GGulpjXyPnQHwc6tx1KaK924U2yxCd3plx4tBLqzk2r359
 MWvY1MQcW2IYa3YO+ro0IGClDu+MJ98BBCDJvkDdcy0nB+npm8TWjPEP3YCVa8Y0xSeF
 cRXtjED4uABKAtI6UP/UvywKogx5SiI3u6biISwih7m1w6V2egl1V4iE2OIB4HQTfJ99
 ZXN1+8HV7RvGUhmCvoi/djquqtdxSe95jHuBTRLaeZ9ZVIn1Om6xmVwyyjegNe8f+d2u
 L2RNAlFoMI/4dJr0ql9UT17Hcw4S3r5vokbVEdXaiq76fcqEru7hN6YoNpMypcTNwZrq
 mnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778858841; x=1779463641;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QHKRrNT8KAAWbZ/IY+TAFb7TI1pw84R4++vha3oZD/Y=;
 b=NHuKvfrQoElz/XxcEa3j8ST6A32EkTyanlmeVZyfiq6oiyoZLAbaeBBaUmAKNWJY2D
 /biQRvZYsMXJiNnSCqCdJVTkmCBtNFtO/kTrPH7A/+R9JpYnMG4eFM9hshaza3rVjhM7
 EF0pbU8GmeHou9KhucCO4cG3LHTNAXct06+8avML/3rmnYZyfRJ7W9+SvSK6l1IcDJdy
 rDirWCC8ZeFWXlbAG+wmIDB5voxfichjHeZgJec0t9oROzvAU5Wn/pt3vO8TIFG5HCHR
 UWgCgc+4VDvqFCTGTEYryw5z0WHYpk53yhPHa2JpCPy+mSLwbOT/3HNxO1NcuH/6QWCM
 DpNQ==
X-Gm-Message-State: AOJu0YzMIIokMUzKh8Gpkiz9wlqeGjIwdtiNkkV2TzD6JcO/qU4js9Yt
 CQGvhXk4l/0jUPiDpyTdQm8TpENxUf8OpmwbT9TpYQZR8D1Q/RaF6+bBz9UmhEeQaFEEBrBYJfu
 fu+v39MSKDhw0St5mL/ooG15HWj/bHW3/W6iqzrzdhf872hsoXvOK7eoR
X-Gm-Gg: Acq92OHZ3B7/UUcS8m6Vl61iEJSf5MTgf6SFenjjo+6KNqEOdgkh9AwONFYHPQTs7Ui
 3VT+F15tgAaeqN/ZT49wt3GKX9nk6aXMkcpJhJAZtMWmkAP+tk9HT1bd52+nxeiJeBy+3sStBhX
 vJ8yYxc+v1FmYpF0jEBpsBhy4OyDkGLEGCf0Z8+/MwOHMugJgwwFkGhEUUmIa8bSm8bHQdMa6Fh
 i0mfmoxxqO4/o0USkz2HMzvnEtCHcxxW8YGIhIdL6q5iJKCgdi/njmyXvUZJl6U+/O8ao5Mxs2D
 tokaKz7zFQx7UpflgRbyw7wGjcO0ygIBBVVJFN5l5qGVl7jYM4aHaYxgjW0Zm61YFwxaNU4c+V6
 zWsj494krR17WUNIFidP9vGSyW59YNJUd8eBIOhDiPMPNDoKusZ25UDtwEA==
X-Received: by 2002:a05:622a:8c:b0:50e:5e6a:c7da with SMTP id
 d75a77b69052e-5165a1ec44dmr58302261cf.40.1778858841281; 
 Fri, 15 May 2026 08:27:21 -0700 (PDT)
X-Received: by 2002:a05:622a:8c:b0:50e:5e6a:c7da with SMTP id
 d75a77b69052e-5165a1ec44dmr58301881cf.40.1778858840746; 
 Fri, 15 May 2026 08:27:20 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-516514e0b91sm35429901cf.15.2026.05.15.08.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 08:27:20 -0700 (PDT)
Date: Fri, 15 May 2026 11:27:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH 05/14] migration: Replace switchover_ack_needed
 SaveVMHandler
Message-ID: <agc7Vl3LkrtLJI-4@x1.local>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <20260505081423.28326-6-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260505081423.28326-6-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, May 05, 2026 at 11:14:14AM +0300, Avihai Horon wrote:
> A new switchover-ack mechanism that will replace the existing one will
> be added in the following patches. The new mechanism will have a new
> SaveVMHandler and will not use switchover_ack_needed. However, the old
> mechanism must still be kept for backward compatibility.
> 
> To keep things clear and decrease API surface of old code, replace
> switchover_ack_needed SaveVMHandler with a regular function
> migration_request_switchover_ack().
> 
> No functional changes intended.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


