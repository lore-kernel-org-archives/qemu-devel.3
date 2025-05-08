Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0207CC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 07:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCvxD-0007Fk-PI; Thu, 08 May 2025 03:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCvxB-0007FI-SX
 for qemu-devel@nongnu.org; Thu, 08 May 2025 03:46:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCvx9-0002mJ-FK
 for qemu-devel@nongnu.org; Thu, 08 May 2025 03:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746690356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aCBdMoUtDKce4pWy3oUb1Rhy+9aEtvCMv90ZcUfQqXo=;
 b=Qf3GRU4hrlMZ3nJoc8Uk8h3HQWBTtdp/ISbCZAOeTDAqn42zDwuLkPig+Gv9Hf/hR8rf4u
 ZJIsz0dydlKwT5inLzi8RdMP6pdS0+H5jfUB4Th8R4JWasvsAaOb1FjeBBaLGcpiBu0pZq
 kvum6T7jzLyNO0LDLtOjm9Y2qGRodVU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-02yrTJznPGSLlX5POSL1Lw-1; Thu, 08 May 2025 03:45:54 -0400
X-MC-Unique: 02yrTJznPGSLlX5POSL1Lw-1
X-Mimecast-MFC-AGG-ID: 02yrTJznPGSLlX5POSL1Lw_1746690353
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43e9a3d2977so4362605e9.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 00:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746690353; x=1747295153;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aCBdMoUtDKce4pWy3oUb1Rhy+9aEtvCMv90ZcUfQqXo=;
 b=NrgDBM9qup9IZFynD3C8qU+aSS2bW541b4Y231kekMg3VSWAeiXViJ//5YdQd28gPk
 AmwpCnZUrZPI7K9uGEdwijwVlNlhDxmKK5gFtTtnckVefJlU3LsaDFzivCE2jtRJMmME
 SQ++1qvJrjx9eQqZWe6guMMiio5FVZATqpNHs6tNrLH1Vr9wfNPW8YISvnEKqwJFlrjm
 YeR78RxIGwDxmcaPjjH8wJwqLpLGMLhpamCcaR3TuNurDYCHLt8dNy5rlo0YE2Es1OMY
 IbmuEU+zlgmJJ3y5iQUTM/KOqKPiPYRYdAUIeBeBKsjzxSgo/Eg6nL+KA4IW6UBXUZ/E
 WxfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoWkrqpTD//pl0qKYq3PUad19DrjYnIdtdxgMW600k/KQ8Ewz7WjWIodOpqj5e6Z31uOsCrJPU/XXu@nongnu.org
X-Gm-Message-State: AOJu0YzBQ6jvpXSXzsZ9AHi4m3ci1dvoCmY5zPRMb2pPdeb33cslSKCI
 8BB1np0gwVe5Cfwf6Z5QMPwFYsmVKtIupnuKRPB80jUxBl6kKW3bhlwNI+ax0Lfzz4eNtcFVPEx
 2JKBLS+Sb2cb5C2DvONVIj8ihHGRaPm9fsa/D80crk7e/WzUd7ZdJ
X-Gm-Gg: ASbGncseKnhRrb1JhP4rhgJk/UXsl41zDmSGJYGrtiXuvLXZvSZR2ahzWD2d947nniZ
 5+Cy9iTvKdZf3gTEukQ5NWG07G5aUCLi1gaOBnwrRx1MO3XwEg69mfUSDG1VHGZVFpwCKA+5Eqn
 l15dgbgjz9IAPKndRYtgJ+iUjNEpXHIRc/+5Y8vv6RP4c/hnKA/oWB+jgrojeID8ZJR/PLelVJf
 O0HnVPkpJD1O6iRwjfUF943kmZTHzMMAOBOTEQL9dx68SoqMFyo6ULnlMl79Xsuhgu0MGueYRcQ
 4nYVLRd7LNy6hVHI+2xNHtBGXr+BEwxYC4N8y0G3Q/NjtInNH/tp
X-Received: by 2002:a05:600c:4f01:b0:43c:f64c:447f with SMTP id
 5b1f17b1804b1-442d034bbf3mr16896155e9.29.1746690353391; 
 Thu, 08 May 2025 00:45:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHn4zfh7mD1aF/ScKAo5yPXaXzSgwS8VVN2MAXBLqq6MRtXI0OzVoMN9hUzt2oBDCW5Hfx1qw==
X-Received: by 2002:a05:600c:4f01:b0:43c:f64c:447f with SMTP id
 5b1f17b1804b1-442d034bbf3mr16895895e9.29.1746690353018; 
 Thu, 08 May 2025 00:45:53 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-173.pools.arcor-ip.net.
 [47.64.115.173]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441d1266624sm45590685e9.2.2025.05.08.00.45.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 00:45:51 -0700 (PDT)
Message-ID: <09b0a1cf-afac-4308-89a2-cc22aba5699d@redhat.com>
Date: Thu, 8 May 2025 09:45:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] include/hw/boards: cope with dev/rc versions in
 deprecation checks
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, devel@lists.libvirt.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu
 <zhao1.liu@intel.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
References: <20250506160024.2380244-1-berrange@redhat.com>
 <20250506160024.2380244-3-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250506160024.2380244-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On 06/05/2025 18.00, Daniel P. Berrangé wrote:
> When VERSION is set to a development snapshot (micro >= 50), or a release
> candidate (micro >= 90) we have an off-by-1 in determining deprecation
> and deletion thresholds for versioned machine types. In such cases we need
> to use the next major/minor version in threshold checks.
> 
> This adapts the deprecation macros to do "next version" prediction when
> seeing a dev/rc version number.
> 
> This ensures users of release candidates get an accurate view of machines
> that will be deprecated/deleted in the final release.
> 
> This requires hardcoding our current release policy of 3 releases per
> year, with a major bump at the start of each year, and that dev/rc
> versions have micro >= 50.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   include/hw/boards.h | 33 ++++++++++++++++++++++++++++++++-
>   1 file changed, 32 insertions(+), 1 deletion(-)

FYI, this causes a failure in the CI now:

  https://gitlab.com/thuth/qemu/-/jobs/9965651507#L163

Looks like we have to remove the related subtest now?

  Thomas


