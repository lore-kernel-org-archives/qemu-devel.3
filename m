Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49075C47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 05:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVPj1-0002gc-In; Thu, 01 Feb 2024 00:34:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVPj0-0002gQ-07
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 00:34:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVPix-0003Ir-Gk
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 00:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706765693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FZ+ozppOFlVx9VlGBQV2rxON8c56uCMfQhMUIJe85FM=;
 b=dmnpR77RnXoJgY2H1nXy6YUQuOeb6GCDHVuoq0Y0DlpwkKPK7hPpJj80Xt3bfCm2pvZSSH
 KaYFZfcbT0BukLT12loSRlV4d+HV0HFTFYBQOuw4oNIm1l7Ol4eREaQdOdROf/Ps+QTXEH
 QPXjstgxrbhNQgyE3xSMVsYMOJOjvxk=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-BgUtgX-iNN6pFpOWm1UgtQ-1; Thu, 01 Feb 2024 00:34:52 -0500
X-MC-Unique: BgUtgX-iNN6pFpOWm1UgtQ-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6dbd919aba8so131391b3a.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 21:34:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706765691; x=1707370491;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FZ+ozppOFlVx9VlGBQV2rxON8c56uCMfQhMUIJe85FM=;
 b=FTaIovEnYoZ6ltoTUcErdnzV9z4/1QmxS7hK9tdtUaHjwU/96BTUvAu0tCS+xdOfLl
 NfT2HEj2IadiNtiU5JMTaTPbqIstiaZEfduIjv+cW/VXrCP81ivzH3GoA/ZmJknLmNNf
 rEX3kBK2Eu4mUvSnysY1miWziwBXnbgmkQLvbDcCHm73AnZQkkbii3r91JW55V7ke/2q
 dVJsj8KWPxuYoXg/qkhxlPFzhfR9vvCgPQ0EQCK6oL+i0NYLndXpmGot5wmKOPwW1r5d
 EGv1bMiKldXbaCrcLNcAjXwxQiimKdJBAzbrSJ/V1YJEHQRbfYSUY+fixPGeYJs4mHdE
 igwA==
X-Forwarded-Encrypted: i=0;
 AJvYcCWL3bzD+88H+GRCPCELjsHGyHEawyol2vru3YdK9/3xFHZVoNNi2W/iyOifMLyRPnVuZJBPNRo+eUBYz0JwCBiYsc338QI=
X-Gm-Message-State: AOJu0YxQo6Jhpm+fekIob3KmaUoRlSKZDeBz+JbQ1deMskCMV8IsqClx
 qTULDC3LOtcNFc2bO56USM9bMdbyYDvuMYmIk284AqeG4uh96oTpMyndjbiaOEfTFN9Xyj65rWt
 z/iZVt/oZ5kaD5VIVHnT5s89dpjQo1pqX9lmOPzOTpdky+/mh3IP0
X-Received: by 2002:a05:6a21:33aa:b0:19e:35a3:af6b with SMTP id
 yy42-20020a056a2133aa00b0019e35a3af6bmr3894382pzb.2.1706765691196; 
 Wed, 31 Jan 2024 21:34:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7rnYTZnueoRtKmVzKhOT9AY3XVLR90zBXeBuAjR/IOBYAdGCCs17G2PZqD7xEiknLavg+xQ==
X-Received: by 2002:a05:6a21:33aa:b0:19e:35a3:af6b with SMTP id
 yy42-20020a056a2133aa00b0019e35a3af6bmr3894371pzb.2.1706765690924; 
 Wed, 31 Jan 2024 21:34:50 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUpOdS6x4OlML4EQvxaT7j1yE9XqVx9w2LJZL6NdBOSzDA+P4w4oQDUn0WvzVxfWIRXqKM9ixcDHLFmc00G6qdwhNXaZOv2Vf8WROxLVJDrDgaRTxxeCvmiZnQzxrWC7pNlBRe8UAS5Pz8a6OfJqwzfVqg8PN5E+Unq+O+IJ6fPAJNuim5qpEi9lNaQBRmNBm021WcxI3zT
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 v12-20020a1709029a0c00b001d7164acf5csm4602216plp.120.2024.01.31.21.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 21:34:50 -0800 (PST)
Date: Thu, 1 Feb 2024 13:34:44 +0800
From: Peter Xu <peterx@redhat.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: farosas@suse.de, peter.maydell@linaro.org, marcandre.lureau@redhat.com,
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 06/20] util/dsa: Add dependency idxd.
Message-ID: <ZbstdD8N5XD_X0e-@x1n>
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
 <20240104004452.324068-7-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240104004452.324068-7-hao.xiang@bytedance.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Jan 04, 2024 at 12:44:38AM +0000, Hao Xiang wrote:
> Idxd is the device driver for DSA (Intel Data Streaming
> Accelerator). The driver is fully functioning since Linux
> kernel 5.19. This change adds the driver's header file used
> for userspace development.
> 
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> ---
>  linux-headers/linux/idxd.h | 356 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 356 insertions(+)
>  create mode 100644 linux-headers/linux/idxd.h

This can be addressed and posted separately.  I see that we already updated
it to v6.7-rc5.

Did you check scripts/update-linux-headers.sh?  Please check and see the
usage.  If idxd.h is not pulled in for some reason, we may want to address
that.

-- 
Peter Xu


