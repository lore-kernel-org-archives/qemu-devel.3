Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5612C02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 08:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYL2c-0002vY-Rk; Thu, 16 Jan 2025 03:15:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tYL2O-0002uk-56
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 03:15:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tYL2L-0002Jy-QZ
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 03:15:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737015330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=weTwTYIz2yhpXnmwTK+tEHXkmKb/g8sy0E66UfcVH7I=;
 b=i+s5cDAuqPhBMgyzA7CFvLiNffuX1tG5XhTkeAJRq2aNK1priqs2VwrPxh0FifwveSDA+p
 hCt4f/7wxcwa3jTPjO2/OdjXQMAm3R5GFb5HKANCDH1I7I8Ig22IREEjhSlSIJsZRl2sRc
 uwF/M4D1hJ4ucYtrGHxpJPXi8umaEMo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-hSL9RkXnOpSWlY-PuI8pSQ-1; Thu, 16 Jan 2025 03:15:27 -0500
X-MC-Unique: hSL9RkXnOpSWlY-PuI8pSQ-1
X-Mimecast-MFC-AGG-ID: hSL9RkXnOpSWlY-PuI8pSQ
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4362552ce62so2574735e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 00:15:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737015325; x=1737620125;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=weTwTYIz2yhpXnmwTK+tEHXkmKb/g8sy0E66UfcVH7I=;
 b=BLLr6C5Pu+WFdghUdHQfQwiTgSXpfnoOQQMaEcbLm69P7s0Cntf6N4SIWxSGQE67Us
 aQa83iEi02IOQaC0NnVvaZEvXTfAfW+6s/WJl2jr3TpeWQTyIy1oB5rCbr8qsFEI7Hp3
 NGRkvYlqMeu0njFUG70mI1ubGGe8Ey9JLI3mnY9GZk4Dvt/MY0k4/iMMBOrutRG5+wNT
 s5NT3OMAnGEDjobcsGi1iCy0s88eUExadlk45oTwp4AUvmvbHjdJppxvwAkgymHt85UV
 VwH33j3wOcAbJebq0uFie7n3obqyJrUWr1Vrpd8vU49BTnfQWyMfmXRqBLFf/CPS5NqV
 TPLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCpQsHODQFiSd04Td9u3xscXTmPZKW/b20e8xI3THOhPLZi96Rka4Zm2vALhJWhrlKFl2kVVJOMjbq@nongnu.org
X-Gm-Message-State: AOJu0YxBPc1oxH1Zium49Nd0h/oUHooZHi3oBQBiH7fG+mB1AVZk0BgE
 RWEDdx0jsoHxJGhNGSDDFAJTvUFNqrZBD8d++FeBPqxns0q1MZoBCPVJpW/1WtJOUhumAQSa/c9
 ZITUrnuRWY40+RSa76gR0r1nhaAZgjuUzdKlgDKK4vqUkrNkmQlEG
X-Gm-Gg: ASbGnctebE+h9RcKkwHmLkfnC8n3P49xiuqmasQiud+2Qt01dxd+v2T5tVzAlUtvX0o
 EF/vqLWUXNUMmAiZQsDjKRuaKDN9lH+P5Xrk7opaUPtIKpTlIZzwMK+ODMDG48rNbOLNOy1wB1r
 ERVlOKKxwHZ6kYA9GWiIDPBjBuloniobMtm+LhxtWTqv5vJr/HJbOP9SknW2tCtxM6S2eL7WAV3
 4D/3Gf2THMuu7LZgv+VslT8WfaLBPyraFFiEFkBWriLrEHf75D4
X-Received: by 2002:a05:6000:719:b0:385:e879:45cc with SMTP id
 ffacd0b85a97d-38a873045d9mr24381362f8f.19.1737015325579; 
 Thu, 16 Jan 2025 00:15:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGimk/Aihf6evbwdWU/Nhj5k4t/+X/4NMOaE3XhbUkvoOP29Y2uSPLQT9Pi8OYtRe/om41oyg==
X-Received: by 2002:a05:6000:719:b0:385:e879:45cc with SMTP id
 ffacd0b85a97d-38a873045d9mr24381343f8f.19.1737015325241; 
 Thu, 16 Jan 2025 00:15:25 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74c5bb5sm51715175e9.22.2025.01.16.00.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 00:15:24 -0800 (PST)
Date: Thu, 16 Jan 2025 03:15:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Gabriel Somlo <somlo@cmu.edu>, qemu-devel@nongnu.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: qemu_fw_cfg: constify 'struct bin_attribute'
Message-ID: <20250116031512-mutt-send-email-mst@kernel.org>
References: <20250114-sysfs-const-bin_attr-qemu_fw_cfg-v1-1-76f525a3ee72@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250114-sysfs-const-bin_attr-qemu_fw_cfg-v1-1-76f525a3ee72@weissschuh.net>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
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

On Tue, Jan 14, 2025 at 10:50:20PM +0100, Thomas Weiﬂschuh wrote:
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

why not

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/firmware/qemu_fw_cfg.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
> index d58da3e4500a5e230b7da9a75e4d70df7c38c542..2615fb780e3c4500db36d4746880455f05479f1f 100644
> --- a/drivers/firmware/qemu_fw_cfg.c
> +++ b/drivers/firmware/qemu_fw_cfg.c
> @@ -460,7 +460,7 @@ static const struct kobj_type fw_cfg_sysfs_entry_ktype = {
>  
>  /* raw-read method and attribute */
>  static ssize_t fw_cfg_sysfs_read_raw(struct file *filp, struct kobject *kobj,
> -				     struct bin_attribute *bin_attr,
> +				     const struct bin_attribute *bin_attr,
>  				     char *buf, loff_t pos, size_t count)
>  {
>  	struct fw_cfg_sysfs_entry *entry = to_entry(kobj);
> @@ -474,9 +474,9 @@ static ssize_t fw_cfg_sysfs_read_raw(struct file *filp, struct kobject *kobj,
>  	return fw_cfg_read_blob(entry->select, buf, pos, count);
>  }
>  
> -static struct bin_attribute fw_cfg_sysfs_attr_raw = {
> +static const struct bin_attribute fw_cfg_sysfs_attr_raw = {
>  	.attr = { .name = "raw", .mode = S_IRUSR },
> -	.read = fw_cfg_sysfs_read_raw,
> +	.read_new = fw_cfg_sysfs_read_raw,
>  };
>  
>  /*
> 
> ---
> base-commit: 7f5b6a8ec18e3add4c74682f60b90c31bdf849f2
> change-id: 20250114-sysfs-const-bin_attr-qemu_fw_cfg-fa4a95934904
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <linux@weissschuh.net>
> 


