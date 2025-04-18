Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07265C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 20:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5slW-0004Wt-KF; Fri, 18 Apr 2025 16:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1u5slT-0004WO-Kl
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 16:56:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1u5slR-00013B-UR
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 16:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745009803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0b+/6MWL2aMC0iL+362ZBkgpLWskixH2zftpdQDEeQ=;
 b=apuEGDNbuoEg49ITHVc5TicNqwfjhG+9E2wy9DcuWihyL1xVOedWEC7mAvLT9K82wmNHZ0
 AjJaVQg6iG+kZJw6rteOKo0R0ML+GNilxrPh2NOsjIm8hItLlFnvqwbFiXi/w4DyPPY6vX
 yjbb1EOVrQz9mrKqY0+EY+QZVOfDDuI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-M2Sq_NxlOlSM7svUliWudg-1; Fri, 18 Apr 2025 16:56:39 -0400
X-MC-Unique: M2Sq_NxlOlSM7svUliWudg-1
X-Mimecast-MFC-AGG-ID: M2Sq_NxlOlSM7svUliWudg_1745009798
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-306b51e30ffso1818163a91.1
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 13:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745009798; x=1745614598;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r0b+/6MWL2aMC0iL+362ZBkgpLWskixH2zftpdQDEeQ=;
 b=V49w11iq01YOUilhd/0tVDqfi/pzFFSe9yb7y8XoRCMefHWG8UD6XU76jCK/fU1wy1
 weeq2ajn4jqPYfKL73vm2EB98TgtugQuGL/IM8laQqmQOjXwG7XAOCzOznrHN1CM3NNp
 CU78u2VSXrCz6hKyRZKzZVmDkHg6x1hoYJRQG/k8k0dksDDiw8kit3knlqlQQHvXPm0S
 ULsK2qTKvtuCkyzN0XwIszh2+YXQyJD6zbMZh2eeyCgiVe1YdgJpN0aeGkI2OcIlG2Q3
 NYPZyggkQ7z3lqCnj8mqR4HL77sHKuIzrpOIO0vLx14s1p5DpBE0YPKj9j8/eW4IdR48
 MdSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdT0j058TqSyV+GgByWmHeMdF+OdcELIHoZ2Uhevw/FcqzKrciBrViN6mWHn1dvbsTXcaC/RvzfN41@nongnu.org
X-Gm-Message-State: AOJu0YwDwewGsX7FThludk/Vi3ct1m3ZzAVNLFt69AVpZZsHg3ynlbbh
 fAndBCPX0rsVLOQhsy/q9mWS1yJtA330l4mjkhxOkycG8HHXdcHNTEmaDAIIKRhAh7TzHnbyiiu
 0PxPj89xxqQQjNT8J5l6GKfGD8ma50R1oz9y/m4jh84YczwhAQRFD
X-Gm-Gg: ASbGncvK8r/vdOCo9NExg5covnjj/rZNAO25IO5RMxMbllaOxHgMpazPkVaoCX/7xEB
 TXWbPDgDu8lFxz8dylE0g40eku5YaleTALiP3DIoi6nHCayQoTBI1tQKahmnbksBS9JxcwaESS4
 beA9ohHz0lhAJb1WcVzW9VsxNeGSoTkGTXHB4B+qJJ/bRyn894C2YTaj1RrAApPsOkfBADiALS9
 Qr2ZFAR+k6X7V8/0i9py0EQJ4RVtomhamXHVtVILIXFrN1qayxDac4FSZH63wFTpepSMtHlSXx+
 3Az6KdvZjCoe
X-Received: by 2002:a17:90b:5188:b0:2f9:c144:9d13 with SMTP id
 98e67ed59e1d1-3087bbb7157mr6035929a91.24.1745009798178; 
 Fri, 18 Apr 2025 13:56:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFONWPrWyQ9kH3HGD72gZUaej6RspmjX50IHvX+w2X5hLnK8sHMZ9Q5iGi19JXEnXB+KeBceg==
X-Received: by 2002:a17:90b:5188:b0:2f9:c144:9d13 with SMTP id
 98e67ed59e1d1-3087bbb7157mr6035916a91.24.1745009797913; 
 Fri, 18 Apr 2025 13:56:37 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087dee872dsm1705458a91.10.2025.04.18.13.56.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 13:56:37 -0700 (PDT)
Message-ID: <0e8743d2-ed08-4dec-8689-999abdfd944e@redhat.com>
Date: Fri, 18 Apr 2025 16:56:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] vfio: Move realize() after attach_device()
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, chao.p.peng@intel.com
References: <20250411101707.3460429-1-zhenzhong.duan@intel.com>
 <20250411101707.3460429-3-zhenzhong.duan@intel.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250411101707.3460429-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



On 4/11/25 6:17 AM, Zhenzhong Duan wrote:
> Previously device attaching depends on realize() getting host iommu capabilities to check dirty tracking support. Now we save a caps copy in VFIODevice and check that copy for dirty tracking support, there is no dependency any more, move realize() call after attach_device() call in vfio_device_attach(). Drop vfio_device_hiod_realize() which looks redundant now. Suggested-by: Cédric Le Goater <clg@redhat.com> Suggested-by: Donald Dutile <ddutile@redhat.com> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Donald Dutile <ddutile@redhat.com>


