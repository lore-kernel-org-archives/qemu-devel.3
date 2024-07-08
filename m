Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317BEC3DA41
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 21:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQvcu-00037I-W5; Mon, 08 Jul 2024 17:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sQvct-00036a-Uw
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 17:10:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sQvcs-0005QU-Ea
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 17:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720473021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TyuEl7qvFUtY6RLTRnWbmnTVtAbyrHw+UWpzY2KNixA=;
 b=OjMhQCvZZEbzBbAYrTTpRBrJg9Px4VYJATlRRC+OpA3C8lFgxcWZDTIb2y2BDjKOwpcH7+
 7zPu3L/uRxjl9eTuj6QhI2cAxVObV8gY3w1z+ayNLfoum44JNhVdtQXyXkhOBfmSU+Jnmk
 r/ovtxO6PnLVckqRus4hLBLJLlVSVlI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-zk4WXM_4NOmYGQCFgm5bhA-1; Mon, 08 Jul 2024 17:10:18 -0400
X-MC-Unique: zk4WXM_4NOmYGQCFgm5bhA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6b60b5b85deso4627666d6.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 14:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720473018; x=1721077818;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TyuEl7qvFUtY6RLTRnWbmnTVtAbyrHw+UWpzY2KNixA=;
 b=fEfEcy7PTiNX1EpWVbw0F7xaO/mm1pM8f5VbSlPYbTo7mkyuH9PJAKI0HRIyZzN1MY
 cc6T1xst0m3ZoAwgg7kz9Q/gd6Zwtr7ac4oXG/Z3y5SbamBBxnhVjUZsZb5J69UcrNoy
 hsBJzUo1s3kkiUL1vhII9OdTAJ9kDOhcNsm3RYr06sXXpllEOz1JfuRtAmPRNQSFIiKO
 ZLKa7GZn9vcp48IUQCKv2JlIFdZO9uAOG08jzBwT71aiJSt4cDbTPrOtc1XuWXcmrTck
 ujyJ5iDjj4Y+EeraRCBzHz1Bfd3DfmbS2jBSbtiP78uoDuoRWxtt5lzZxSYC2xIUXum0
 +phw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLCwmkw80Vqx7JyXLMlde7TSNoVq08c2+4uWmDsXL0+FMJrOTcFF+cqS9XM7lSrabP+lBK2vdmk649mwzmP1Y/lkSje7U=
X-Gm-Message-State: AOJu0YzMgpM9wmUX9upbIRpA4lPDVhEurg/8VIxmOcVMB+BdX23uSElw
 xcatY8d7pnDeEqQoQOI+18TnP1YNTvYJTT5Xxu/sIoW1YDtvuIrLuUzq6c7DE6gidlYljrlMje1
 mHLorjC3F5LbFH+3caYoAgLKotkyLAgIvblvGPJsiVnZsIKhc3h9M
X-Received: by 2002:a37:de0a:0:b0:795:53d0:ce4e with SMTP id
 af79cd13be357-79f19abd662mr59588985a.5.1720473018446; 
 Mon, 08 Jul 2024 14:10:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEcn/FzwYTtXubYouBiYo5IeYv2MRTcKTS0cc7iXMvKC486W1vLBdFwlNO1pj4Syj64kkWeA==
X-Received: by 2002:a37:de0a:0:b0:795:53d0:ce4e with SMTP id
 af79cd13be357-79f19abd662mr59587485a.5.1720473018142; 
 Mon, 08 Jul 2024 14:10:18 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79f190896d4sm27834285a.85.2024.07.08.14.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 14:10:17 -0700 (PDT)
Date: Mon, 8 Jul 2024 17:10:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Yichen Wang <yichen.wang@bytedance.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: Re: [PATCH v4 2/4] migration: Add migration parameters for QATzip
Message-ID: <ZoxVt1NPCu-UFE5c@x1n>
References: <20240705182901.48948-1-yichen.wang@bytedance.com>
 <20240705182901.48948-3-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240705182901.48948-3-yichen.wang@bytedance.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jul 05, 2024 at 11:28:59AM -0700, Yichen Wang wrote:
> +# @multifd-qatzip-sw-fallback: Enable software fallback if QAT hardware
> +#     is unavailable. Defaults to false. Software fallback performance
> +#     is very poor compared to regular zlib, so be cautious about
> +#     enabling this option. (Since 9.1)

Could we avoid this parameter but always have the fallback?

IMHO anyone who is serious with using a HW-accelerated compression method
during migration should make sure that the HWs are properly setup.

If you think such caucious is required, would warn_report_once() works when
the fallback happens?

Thanks,

-- 
Peter Xu


