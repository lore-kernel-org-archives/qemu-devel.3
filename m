Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6DCC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 09:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjc1G-0000vl-IN; Mon, 11 Mar 2024 05:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rjc1C-0000vH-Uf
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 05:32:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rjc1A-0002d3-BD
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 05:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710149543;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kex39lFy9ANnPpgQCEfEpdhJf5dk/xsaSoZC/D5Cndk=;
 b=L4D313PignpfGo3twV5OeGUWIjC7BiWF1UzNcWagGtdxgGDpTU34vxq18AdiRSUi50sG2d
 0uArYrlq9nGWkJ5/yPI8G7OAuaf6DUZaQtzHYGRXGdA34KNRgx1cHBknjEAfjfh9d6zEhX
 PVZ3dlLx1Pewr41csTuzaSQMqh8/cEU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-ingLQzF7PLmlVQ5quK0f6g-1; Mon, 11 Mar 2024 05:32:21 -0400
X-MC-Unique: ingLQzF7PLmlVQ5quK0f6g-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33e7ef51078so1313068f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 02:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710149540; x=1710754340;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kex39lFy9ANnPpgQCEfEpdhJf5dk/xsaSoZC/D5Cndk=;
 b=M0lpDd2v97K7ESIhAlh7dOMhop3FwxA6g6+RFgNpDPgF0pVFmLZvkSC3QWAb5ZgV7Z
 5iOUaThawmmjxvx9GR6Wz/Q2pVOSCnIP9DfosHYfd49f2jxqOIBjzcguHthlXX5vWGIj
 aQJ4yhy2dim+8JLjwY2FJx/mMPivZZ2vD19sF+W3yS/HCwyJT1pBezs70ImPPhT0S7DT
 hfy1a0xpd45Rd5CBGmALchwX+/pjvVjvpL5fbIZ7K4toFNvN9DMpjGb/W9QrkUvx+q2y
 Prb+I1K+iQBoY6LW/DcZHppMOExkHOPNu/ATWF0Mh7YhmCRlgVaYmwrHz1EGQg383rRS
 ae7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkGJP0AlflCF1VDXtOCuVOMMEywCsP/bPTK1hARUVTGkJetjRVoeLfjm+e3Is1hSdhbOtsnY3CDGOnZDFhSg06gIv0q5A=
X-Gm-Message-State: AOJu0YxMFL8VIAIASsTdoTYIfq2rtY7azv2rEsZqTgU8SWxin6vw5FiW
 bsKWLh6PBTUI8tZ7psnqaJf4L8u4OKFeN4gHUlmSZo4W4dp2QPVe16yU+mK2J8cp65L5nfMIUnt
 X/f6QkmbYiPboIaOnoFPVCxbJjpra1PpWdwKhBogaqiFa8oiYknM0
X-Received: by 2002:a05:600c:474b:b0:413:15f2:21da with SMTP id
 w11-20020a05600c474b00b0041315f221damr4450726wmo.17.1710149539978; 
 Mon, 11 Mar 2024 02:32:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmEmuO6uMehVFchu3SzMe9Hs8lnbPRPYbfJrPMUbhFHus6bDIIeqyMW3SKS3IsOqoHob2yxg==
X-Received: by 2002:a05:600c:474b:b0:413:15f2:21da with SMTP id
 w11-20020a05600c474b00b0041315f221damr4450716wmo.17.1710149539666; 
 Mon, 11 Mar 2024 02:32:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 m15-20020a05600c3b0f00b00413218ca719sm7564874wms.4.2024.03.11.02.32.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 02:32:19 -0700 (PDT)
Message-ID: <66aae0d0-982a-4533-989f-cb53d9df6854@redhat.com>
Date: Mon, 11 Mar 2024 10:32:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/29] backends/iommufd: Fix missing ERRP_GUARD() for
 error_prepend()
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20240311033822.3142585-1-zhao1.liu@linux.intel.com>
 <20240311033822.3142585-3-zhao1.liu@linux.intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240311033822.3142585-3-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/11/24 04:37, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
>
> As the comment in qapi/error, passing @errp to error_prepend() requires
> ERRP_GUARD():
>
> * = Why, when and how to use ERRP_GUARD() =
> *
> * Without ERRP_GUARD(), use of the @errp parameter is restricted:
> ...
> * - It should not be passed to error_prepend(), error_vprepend() or
> *   error_append_hint(), because that doesn't work with &error_fatal.
> * ERRP_GUARD() lifts these restrictions.
> *
> * To use ERRP_GUARD(), add it right at the beginning of the function.
> * @errp can then be used without worrying about the argument being
> * NULL or &error_fatal.
>
> ERRP_GUARD() could avoid the case when @errp is &error_fatal, the user
> can't see this additional information, because exit() happens in
> error_setg earlier than information is added [1].
>
> The iommufd_backend_set_fd() passes @errp to error_prepend(), to avoid
> the above issue, add missing ERRP_GUARD() at the beginning of this
> function.
>
> [1]: Issue description in the commit message of commit ae7c80a7bd73
>      ("error: New macro ERRP_GUARD()").
>
> Cc: Yi Liu <yi.l.liu@intel.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  backends/iommufd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 1ef683c7b080..62a79fa6b049 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -43,6 +43,7 @@ static void iommufd_backend_finalize(Object *obj)
>  
>  static void iommufd_backend_set_fd(Object *obj, const char *str, Error **errp)
>  {
> +    ERRP_GUARD();
>      IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
>      int fd = -1;
>  


