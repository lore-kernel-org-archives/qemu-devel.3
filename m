Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7316FC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 16:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5EW-0003Vx-5I; Tue, 12 Mar 2024 12:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk5EU-0003Uz-TW
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:44:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk5ET-0004mM-I9
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710261844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NFZpIIaHFLHWQ3CKSA+QU16wLiPBEnVumhahukR4YQk=;
 b=NgFnwMJBm7vARZDT08/2rsr/6U5BthumxU0Rbxt3171xENIHur0UyVn5cHgFSoKRqFSIkK
 5Mo+kfki3YbZzpN44zwAiqhJdt7JyoAbqXPpphq43BsNMLmX+GokCG7RMT+L5YMx2+oxnm
 T8Oh5lcF1sxqbbhvV2avd93DUxEHcjY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-ev5SCCI1MrKzhYYvwApPnA-1; Tue, 12 Mar 2024 12:44:03 -0400
X-MC-Unique: ev5SCCI1MrKzhYYvwApPnA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-412eeb789d9so740385e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 09:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710261842; x=1710866642;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NFZpIIaHFLHWQ3CKSA+QU16wLiPBEnVumhahukR4YQk=;
 b=VLGvINWaCRpUzDKvYcLoqSW9yIbXUntzBHVC+4Hm4iTm+2UkN+wEcBMwTsfDK8Vjy7
 NHdO1tF2uvy1q7jnWHfSUjEGjMJwWWadGUB9Bs1xvVrwLXkfXsayQcwuALXPjRMYRSep
 ILxIqxOucVPBIFDt3WlSis1de3yWHcQuJliSl4/PHIck2KL5RFhcPXijc+OH7rBfIyyD
 PjsyGz+Q2c6lkro4RDopUXlA9/QyZvcXL0JCIdzGob6Lv1XclHtvr6MxbvlrFQQnY+ja
 S3Iqb30t3/WJHKkiKUJztBMM0qDqbmv3oE10QMdzr4eVW6BT3v+ccNJVsEay8elv4LYH
 SZFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCkbX467vRD4pi77yMnC6ihwWI0MiMq6IuBjFA6gf30oA3hdgrdzEAM2ypmaOxT+/yNzOMLWTX+Mdlv+pSbMdz9sTYnx0=
X-Gm-Message-State: AOJu0YyFiRPqpqbF13JIEDRAWUm3KbR25Gjo9fEONsGKGr2u1PkVoNwj
 YTNwFyR/QrepTlmG5vfMusOBpDVSC7EpirkwlZHkt0QPLRkOWWR3Kd07ce83fQUaf1BvXbHrMuH
 A1S5bL7SqqyRVlo7S9g0OYfErlHfOYDQqmd+nJp2J9ta1hzqRH5Qt
X-Received: by 2002:a05:600c:35cc:b0:412:ed3f:1b4b with SMTP id
 r12-20020a05600c35cc00b00412ed3f1b4bmr3005413wmq.11.1710261842192; 
 Tue, 12 Mar 2024 09:44:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxsOyypDT7GZSd0ybfIpycv9ghyUGncGhAHWtortRBN3JIB5fiFFpykMr0RcUvegM/mxzTZQ==
X-Received: by 2002:a05:600c:35cc:b0:412:ed3f:1b4b with SMTP id
 r12-20020a05600c35cc00b00412ed3f1b4bmr3005387wmq.11.1710261841695; 
 Tue, 12 Mar 2024 09:44:01 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:532c:5ae4:fce6:76e1:fa1a])
 by smtp.gmail.com with ESMTPSA id
 bh25-20020a05600c3d1900b004133365bbc6sm2840627wmb.19.2024.03.12.09.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 09:44:01 -0700 (PDT)
Date: Tue, 12 Mar 2024 12:43:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 0/7] Cleanup and fix @errp dereference
Message-ID: <20240312124339-mutt-send-email-mst@kernel.org>
References: <20240223085653.1255438-1-zhao1.liu@linux.intel.com>
 <Ze5/r5EW9YsqVwtS@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ze5/r5EW9YsqVwtS@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Mar 11, 2024 at 11:51:11AM +0800, Zhao Liu wrote:
> Hi Michael & Philippe,
> 
> Could this series catch the last train of next releases? ;-)
> 
> Thanks,
> Zhao

yes it will be in subject to last minute testing.


