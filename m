Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3D7C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ragAA-0002Iw-SG; Thu, 15 Feb 2024 13:08:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1ragA4-0001zU-6b
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:08:41 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1ragA1-0004b4-5x
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:08:39 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e0f5934813so983391b3a.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708020516; x=1708625316; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vkhWEcATpjd0JyArKV0zT5GO4Ya9CWDNjFR6I4NE9CI=;
 b=AAwtLrRFe9OfkRunO531KZlpKrV57raISkF8GnyPaCUDh8PFEYF0hvUIyQv11WbOkk
 jou5/CHgTaEjL2DHABY84XBqO35+37jdbnqhELXD2j5DmotREsdsq33ACg2BtfqKwLNw
 F2pT4OV75jsHGWrZmUHHos/jPF7FM2EIV6I87T+OozmevyCluT/QgtO1siduhnQhIfJp
 lIc2b78pW7EbO8NZ66EfIC5Xporj1w5KSzB2m+xhp4LJBuR/cvUtFQ6GedaJ5i2nZqjB
 DB+ikxw7cYIcpmzWcjKXZytQAAK06vJQ/RqUffWmmyhLrt+zJrWSeVKT5WgxE4DH0ZQR
 6Bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020516; x=1708625316;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vkhWEcATpjd0JyArKV0zT5GO4Ya9CWDNjFR6I4NE9CI=;
 b=G9wQtNB8dRzuwoevinnpm0J+LX+4/mKzAie7WwaSCyXiGjMqVuSyOUEKvIJvDAYEKf
 UhwsTXzQwytbq3a2r2IzB+OppwGplXtySvEPRNFwDgDZGBQnzhP/U10/yJuVxm0MicE2
 YXyjjNwA9VeewAclDamkTeVgQmCLmGaixFgSA6BfFsZbVG90/rNu9ujskwf+BvBiASFQ
 GlwhRLx4CRKWccwuMWbqUHeAmJbJZ1dtkQCAqR0DD+K5rkZ0UbDJrtiwcAzoLNFxgyDU
 lOObsacvt2qJy6mGii/yCoMuHINl2tXHY05Ta0xTxxiqybSujNghMINkhd0CLEq59gE4
 gJ3w==
X-Gm-Message-State: AOJu0YwD3bn8ivCLgT6zVZ+zK7Bjx0QpYV2sxx1RqjPACckrXO3UPEDZ
 e02d+dAtyKYvtxnqydklKxjR3togL8y6zWDahmPm9dwF6mqRdvMy
X-Google-Smtp-Source: AGHT+IHjUt/euppS4Vd2r5fZl4bAznuh0HSPey8NrtFnRZP/Yf4hJdWquREd8W09/MUbawooZwT/fg==
X-Received: by 2002:a05:6a21:3982:b0:19e:a1a3:b14 with SMTP id
 ad2-20020a056a21398200b0019ea1a30b14mr3897878pzc.1.1708020515607; 
 Thu, 15 Feb 2024 10:08:35 -0800 (PST)
Received: from debian ([2601:641:300:14de:5279:cdf6:aaf1:e09c])
 by smtp.gmail.com with ESMTPSA id
 m189-20020a633fc6000000b005bdbe9a597fsm1707740pga.57.2024.02.15.10.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 10:08:35 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Thu, 15 Feb 2024 10:08:33 -0800
To: shiju.jose@huawei.com
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 jonathan.cameron@huawei.com, tanxiaofei@huawei.com,
 prime.zeng@hisilicon.com, linuxarm@huawei.com
Subject: Re: [PATCH v2 0/3] hw/cxl/cxl-mailbox-utils: Add feature commands,
 device patrol scrub control and DDR5 ECS control features
Message-ID: <Zc5TId-xVNl82xbJ@debian>
References: <20231124135338.1191-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124135338.1191-1-shiju.jose@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Nov 24, 2023 at 09:53:34PM +0800, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support for the feature commands, device patrol scrub control and
> DDR5 ECS control features.
> 
> CXL spec 3.0 section 8.2.9.6 describes optional device specific features.
> CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub control
> feature.
> CXL spec 3.1 section 8.2.9.9.11.2 describes the DDR5 Error Check Scrub (ECS)
> control feature.
> 
> The patches are available here,
> https://gitlab.com/shiju.jose/qemu/-/tree/cxl-scrub-2023-11-14
> and is based on Jonathan's branch
> https://gitlab.com/jic23/qemu/-/tree/cxl-2023-10-16
> 
> Changes
> v1 -> v2
> 1. Changes for Davidlohr comments. Thanks.
>  - Changed CXL SET feature data transfer flags as enum.
>  - Modified pointer supported_feats to get_feats_out.
>  - Removed an unnecessary branch.
>  - Use MIN().
>  - Move setting of hdr.nsuppfeats further down.
>  - Return CXL_MBOX_UNSUPPORTED if non-zero selection flag is passed.
>  - Add more IMMEDIATE_*.* flags set_feature.  
>  - Corrected a spelling error.
> 
> Shiju Jose (3):
>   hw/cxl/cxl-mailbox-utils: Add support for feature commands (8.2.9.6)
>   hw/cxl/cxl-mailbox-utils: Add device patrol scrub control feature
>   hw/cxl/cxl-mailbox-utils: Add device DDR5 ECS control feature
> 
>  hw/cxl/cxl-mailbox-utils.c | 360 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 360 insertions(+)
> 
> -- 
> 2.34.1
> 

Recently, Jonathan has updated all the specification references to align
with cxl spec r3.1, so for the next version, we may want to also do
that.

Fan

