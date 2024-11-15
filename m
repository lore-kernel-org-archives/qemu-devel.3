Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4E8D68BCD
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 17:55:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC0XT-0003Rt-PR; Fri, 15 Nov 2024 12:55:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tC0XR-0003RW-5d
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:55:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tC0XP-0005O1-QE
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:55:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731693318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HTyfx5lG02yMsCtK/FCeHMzOT6K7fHsSvCf0rbf0PSM=;
 b=ipqlSq36dOPKLCd5nt8ot+t7Re4J7Acj2sNBFlxGxbJ92bxlJlCNINZjD0mR8c4laqRI/m
 LO0J98uiyuE+MJazw2vqOuT19TjsHz0TzJjoBKnu3DFl9htzU8jHFZQK6Ur2KD04SU4lkD
 2gJOKFCsmh70VLSlgXyq9El1WWj02H8=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-SOatWubpMqq7s2iwb9nxAQ-1; Fri, 15 Nov 2024 12:55:17 -0500
X-MC-Unique: SOatWubpMqq7s2iwb9nxAQ-1
X-Mimecast-MFC-AGG-ID: SOatWubpMqq7s2iwb9nxAQ
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-83abb901672so212006739f.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 09:55:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731693316; x=1732298116;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HTyfx5lG02yMsCtK/FCeHMzOT6K7fHsSvCf0rbf0PSM=;
 b=olvrKZ7D5pdearya1jwYMfrUeBxtoWL3qa2PI6Nf/v3QWqqSFE9DJgYvLgG3wXbSsI
 C2mPsY2tb8kkizZRNs6OxupzqdRJIMoMCRVd1f/SkFZNgQMgo39cFQwbiTT+cNbCNKct
 Tn7ELGtDx2ZQmhN/tF67R0/wvnTiONmaBi8CAXZi4dVf7gwYrAoANJuY7z2ZM/UzEXbt
 4CvvEln8ziSNO5tMSLCGKCMcm9G6XMVXw4F9t5nsXjYfChdS8jxkp/kyob/Qo3KlOVkV
 zht5uU0/ZY0eMSqTYzjUDEUcVs9wOmSCIZi3HdK6f5FYv73gQZS6+NqceLpVAkT4FRc6
 zkTg==
X-Gm-Message-State: AOJu0YxCzMPS9YGp7l5da10UnOCC4T5dArU/biPJTRgAt4q371GTs54p
 VJSdRo+/iy6cEKlsbFIo/pHQrvX3HGB1csVyCkgTeHdOt9PoCo8IJkMjFcx2lxe2j81zd8xh+gL
 xFQkqG5oqzta0LGPBOGMCPtxRpOmlhbftzVKKPn/216balwdCohKQ
X-Received: by 2002:a05:6602:1614:b0:83a:7a19:1de0 with SMTP id
 ca18e2360f4ac-83e6c315b31mr451714139f.14.1731693316763; 
 Fri, 15 Nov 2024 09:55:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMULlNFmqcywmlSrVMKkHFtN0LY34Y5NZlzCH626KwS/Kau4GWCD6KkNWmad26jqRc5+FAig==
X-Received: by 2002:a05:6602:1614:b0:83a:7a19:1de0 with SMTP id
 ca18e2360f4ac-83e6c315b31mr451711739f.14.1731693316429; 
 Fri, 15 Nov 2024 09:55:16 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e6dfc8bd2sm41183139f.14.2024.11.15.09.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 09:55:15 -0800 (PST)
Date: Fri, 15 Nov 2024 12:55:13 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 7/9] qom: introduce qdev_new_dynamic()
Message-ID: <ZzeLAYvM0nms3Sxy@x1n>
References: <20241115172521.504102-1-berrange@redhat.com>
 <20241115172521.504102-8-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241115172521.504102-8-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.658,
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

On Fri, Nov 15, 2024 at 05:25:19PM +0000, Daniel P. Berrangé wrote:
> qdev_new() has a failure scenario where it will assert() if given
> an abstract type. Callers which are creating qdevs based on user
> input, or unknown/untrusted type names, must manually check the
> result of qdev_class_is_abstract() before calling qdev_new()
> to propagate an Error, instead of asserting.
> 
> Introduce a qdev_new_dynamic() method which is a counterpart to
> qdev_new() that directly returns an Error, instead of asserting.
> This new method is to be used where the typename is specified
> dynamically by code separate from the immediate caller.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


