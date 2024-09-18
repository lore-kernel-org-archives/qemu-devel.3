Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7377FCDD560
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 23:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr4B7-0001QM-AQ; Wed, 18 Sep 2024 19:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <somlo@andrew.cmu.edu>)
 id 1sr4B5-0001P6-8v
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 19:33:43 -0400
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <somlo@andrew.cmu.edu>)
 id 1sr4Ay-0008Jd-7K
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 19:33:38 -0400
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6c36ff6e981so1452626d6.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 16:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cmu.edu; s=google-2021; t=1726702414; x=1727307214; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l9ZZOxBSwiK+focarcZDB2xmpZzEuW+pm+kWGXSRSRc=;
 b=UrL4OLjrQBkbygEZLt92Vr7xsUCuwugZkwkpDjLu0eLmzBJv1nvat381hFHvfGgmbp
 fU0s1nC2tIcthWoXVE0oxkG2mM7ZncFDRMq/USFCWNQkjGPguhj8auAof9bW/U695HyA
 YIVVeFU6pA6c0rRsIqzs9YDmvT3VASDtcfFBvNFzBTH5MN0zIFAMmZ381nPXUaaMgTA1
 y5QhvskzPy74PJm1lg5CjKsxqHe0DvcBcoGgMf2NvvwtkxKz1Fr85bgc6cInIBezTSqn
 SnoYZep/3jxIjevv3c+Wfm/Io6jHXz1TWj0zbwaSca2oENdYZjF5ShSr0XUvpVzhvaHj
 NPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726702414; x=1727307214;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l9ZZOxBSwiK+focarcZDB2xmpZzEuW+pm+kWGXSRSRc=;
 b=eMz1h7+OyHKd4TQ/lQMc/nr9FrRGPzs1obtA8rTMN525ndoO/xYaKmKfFjhWdgUGTQ
 v1sH+HUF24dbu0PcOvTzCP3Yp+AyI5yOPpzZMSRL8G0ergxEEiLQChUJInesaZJuR+rm
 qmUAoFsVApGNjs2Zckd/gorI2Rbp+n/RWeDstzaasLwgfjKi1YdTJ5f48x81Wa1oEj6v
 EyLp9WRJEE7tK7+BEoA54uYaRE4hg2apUElKdFRQChTT2GZNmhmf2NaOm9l3j58iRA2C
 0LWuj+TQB2y/rzdAVkU2IJgLTtmF6KmtMAUTHY53kMyke6DTreMegGoyr01Bo8Hspnai
 bj2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6ubh4onPJDC4uz5zHvK3z0O9PwQVgAdmeHx4ou+opWJNZabFKhCv/rAprFv4gjpPu/JfZ3aA6ElGw@nongnu.org
X-Gm-Message-State: AOJu0Yz0Jha8l92glmvfUNogHDO3TS5UkRKBkWqDasAdHRPZzkqmzfQV
 z7Sy7ZI5NGXDKYv5xWbJ4L0Gj05WQQmPr1/1HXbKn3gWMsHTW9Z6eA1uKDKRXw==
X-Google-Smtp-Source: AGHT+IHbfvCmLCw+rsvw7Mih8RiFqMsle4MsouE7A55zzVUKmVfQwNj/2st9pFZy/rNGwt68Tgid2g==
X-Received: by 2002:a05:6214:451d:b0:6c3:6e36:eff5 with SMTP id
 6a1803df08f44-6c57357a441mr440082656d6.22.1726702413668; 
 Wed, 18 Sep 2024 16:33:33 -0700 (PDT)
Received: from errol.ini.cmu.edu (pool-108-39-141-40.pitbpa.fios.verizon.net.
 [108.39.141.40]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c75e57a4acsm1858256d6.116.2024.09.18.16.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 16:33:32 -0700 (PDT)
Date: Wed, 18 Sep 2024 19:33:29 -0400
From: "Gabriel L. Somlo" <somlo@cmu.edu>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH -next] fw_cfg: Constify struct kobj_type
Message-ID: <ZutjSVLNyBYRjIgg@errol.ini.cmu.edu>
References: <20240904011743.2010319-1-lihongbo22@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904011743.2010319-1-lihongbo22@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Received-SPF: pass client-ip=2607:f8b0:4864:20::f32;
 envelope-from=somlo@andrew.cmu.edu; helo=mail-qv1-xf32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Sep 04, 2024 at 09:17:43AM +0800, Hongbo Li wrote:
> This 'struct kobj_type' is not modified. It is only used in
> kobject_init_and_add() which takes a 'const struct kobj_type *ktype'
> parameter.
> 
> Constifying this structure and moving it to a read-only section,
> and this can increase over all security.
> 
> ```
> [Before]
>    text   data    bss    dec    hex    filename
>    5974   1008     96   7078   1ba6    drivers/firmware/qemu_fw_cfg.o
> 
> [After]
>    text   data    bss    dec    hex    filename
>    6038    944     96   7078   1ba6    drivers/firmware/qemu_fw_cfg.o
> ```
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Acked-by: Gabriel L. Somlo <somlo@cmu.edu>

Thanks,
--Gabriel

> ---
>  drivers/firmware/qemu_fw_cfg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
> index 5f43dfa22f79..85c525745b31 100644
> --- a/drivers/firmware/qemu_fw_cfg.c
> +++ b/drivers/firmware/qemu_fw_cfg.c
> @@ -452,7 +452,7 @@ static void fw_cfg_sysfs_release_entry(struct kobject *kobj)
>  }
>  
>  /* kobj_type: ties together all properties required to register an entry */
> -static struct kobj_type fw_cfg_sysfs_entry_ktype = {
> +static const struct kobj_type fw_cfg_sysfs_entry_ktype = {
>  	.default_groups = fw_cfg_sysfs_entry_groups,
>  	.sysfs_ops = &fw_cfg_sysfs_attr_ops,
>  	.release = fw_cfg_sysfs_release_entry,
> -- 
> 2.34.1
> 

