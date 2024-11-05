Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8323CD3E772
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 21:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8QrA-00064g-La; Tue, 05 Nov 2024 16:12:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1t8Qr8-00062G-Qv
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 16:12:54 -0500
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1t8Qr7-0007YP-4l
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 16:12:54 -0500
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e28fea0f5b8so5064308276.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 13:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730841171; x=1731445971; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NAcu8Ypdd9R2EX1w/g4oTXgSQUNI6rVdLhXAOpIdn/I=;
 b=BGmsp2yH4Pof3F36tLsDPixf/LvNl98+ctv6qmUtBQ06RxgF6Orge95EwHTdG7hEVZ
 JQot05nGK56qqYdgBop0bGMG855AsOHkWKMYQQHLj2Lo5ltglEtGzDuFqqYsxceZ3HYB
 5/7oKa+15fDZpJnqYoixoSJXgR2GBIlMAfoCS0i3C17M83z7sneOnUWCxhv8VBAorV53
 91kJ9tzALAbcx3CcdX/AcYFd8cMg8+MBEXnW46lnykq4tWKpnx40N5zgPghxr61bdTdi
 ABXBuf+DRZk+QZdjVBd28crQa9eY7riQkGwu1nP3uDO9ykoZRsLEGkkhkGG2pQD8L3PA
 Arkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730841171; x=1731445971;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NAcu8Ypdd9R2EX1w/g4oTXgSQUNI6rVdLhXAOpIdn/I=;
 b=D7lg32VJmm/7YvfW6N+C3PnMC9pOiwGv/iIBRBOhdj4DWcNwjRsNtc0OTIsulCSnrL
 VHgIP/phnvIKj4g4Kp5zRo6vf55zlFo2wqke7mYT+H8PhFn1HFBbuvqi8XCFRI0dFieJ
 SomZv0zIcnuqVXstj4HRGZ7LHsfs294eDfiWMkndLzFY6Zj+k+V6AdB/CHvHtCQUO0F+
 kqi9BgK5SosqMvhKGw+H0OsUNveIaCLBWfmtwEltfExFbWUN+w4Gpd7n4Di7M5mGUiN3
 GnBj4fwychadlsi8gJQpXVbdglH/6+U9HS3uEbes71oXt6gYewQSpqAm08NLdgtRL7zG
 fyXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsdG4sCkSt1Eya9x31y7mgQgt5JX5be7v/YqHyxBLhh6nFhO8VmZnhUH50sKCUIXFF26vSJ76m6FST@nongnu.org
X-Gm-Message-State: AOJu0Yy4YjGrwSeoQiByRy7Hhp7vWsjZnvSoomcFUgqKahyW9hMhi/9Z
 jTcRrZbCT4TojdkZSQlE4M1rCVgoRmRbhv9ZJxo8KEfptuYIeLMX
X-Google-Smtp-Source: AGHT+IFk643dklQFhj2PXQ9UbLSeLqFDjFC19MXl/L7de9yPXDAtuUl1fwSB/pyOuxrtrSUj0sYtkA==
X-Received: by 2002:a0d:cd85:0:b0:6ea:4d3f:dfa6 with SMTP id
 00721157ae682-6ea4d3fe2d6mr177261587b3.0.1730841171026; 
 Tue, 05 Nov 2024 13:12:51 -0800 (PST)
Received: from fan ([50.205.20.42]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6ea55ac9d29sm24582367b3.11.2024.11.05.13.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 13:12:50 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 5 Nov 2024 13:12:49 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org,
 Esifiel <esifiel@gmail.com>, linuxarm@huawei.com
Subject: Re: [PATCH qemu 05/10] hw/cxl: Check the length of data requested
 fits in get_log()
Message-ID: <ZyqKUSddpuukhrW1@fan>
References: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
 <20241101133917.27634-6-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101133917.27634-6-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yb1-xb2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Nov 01, 2024 at 01:39:12PM +0000, Jonathan Cameron wrote:
> Checking offset + length is of no relevance when verifying the CEL
> data will fit in the mailbox payload. Only the length is is relevant.
s/is is/is/
> 
> Note that this removes a potential overflow.
> 
> Reported-by: Esifiel <esifiel@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 27fadc4fa8..2aa7ffed84 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -947,7 +947,7 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
>       * the only possible failure would be if the mailbox itself isn't big
>       * enough.
>       */
> -    if (get_log->offset + get_log->length > cci->payload_max) {
> +    if (get_log->length > cci->payload_max) {

If offset is beyond the size of cel_log, will it be a problem?

There is a comment just above saying "
 * The CEL buffer is large enough to fit all commands in the emulation, so
 * the only possible failure would be if the mailbox itself isn't big
 * enough.
 "

Not sure how it avoids the case when the offset is too large.

Fan

>          return CXL_MBOX_INVALID_INPUT;
>      }
>  
> -- 
> 2.43.0
> 

-- 
Fan Ni

