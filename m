Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 933FDC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 18:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdBX2-0004lv-R7; Fri, 26 Jun 2026 14:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wdBWw-0004gR-Ul
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 14:43:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wdBWv-00035F-8E
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 14:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782499436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vO4hv1A6DGjPK9XmLKWac6zUyAZxsIFFNGecu4fSg3Y=;
 b=Gysz6qdbM2dM+M2QWFNUCjQxSYX1Og7H7A4kcFpsMwWNYSD2YpLR+GOfrpox2npDw2Tn4w
 7H47eijKimrAH+tuQ7GsNL7bl9y5SSC1Kw2yD8BvMf2mqkJkPpUpWycyGMx0Zm98EMlA8v
 9X+i1vsAQA4/Pyezu9+dPSkleNBSfdw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-Ryllf21bNjmX9QQEpbBpYg-1; Fri, 26 Jun 2026 14:43:55 -0400
X-MC-Unique: Ryllf21bNjmX9QQEpbBpYg-1
X-Mimecast-MFC-AGG-ID: Ryllf21bNjmX9QQEpbBpYg_1782499434
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490b2f22ea2so10479745e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 11:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782499434; x=1783104234; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=vO4hv1A6DGjPK9XmLKWac6zUyAZxsIFFNGecu4fSg3Y=;
 b=bp3oPepcEmpbqeRdHE030bT0oTQ73r8K+4cXctkI0Rt4H0Q98ShdVUMb6FgDdpFSe6
 eWwipAIAznRUXuHzE7uZWlNWn4N8Rz4ALwX5KqSuA0aDQhe/kuaxae2DTQOjs5RIFGfw
 KmXW1RSjcoqKWk9TTc5XZ00j34qlbkz0SOHIggpWZtbeVZ5/CSjQZ0fyjDKxsKyWPoWn
 PxAKntVfnHm9it3TapH7ym62A7XGlP0a5yh+gQNxl3eeXClGlPVLCvsq1H3sg62nqfxO
 lMfj3KHwPtNgyvoT3khFM5hJuDVYoe4OJdJQvwVSZh5dwOFy31xyPWxQ7oY7IXQe2qid
 DUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782499434; x=1783104234;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vO4hv1A6DGjPK9XmLKWac6zUyAZxsIFFNGecu4fSg3Y=;
 b=LM5jEUteK+dNvtvJ+POnMdw3zO+hxGAtnGgRDQMiQfQ2JAiCVMov7L89+oJju/+4Tk
 mHCJlSr++NXwLDYE224xFCyeO9X7IkXRg8KDQxtOHzMfbE3In/wtEwRnveL0AkxDyNg4
 7Cid5hLb7c84i5NzXYyYY8wINMsIQGn/wiMLAUlbltgSt5bPRADV0Towt2kxd7qMlW8j
 nCajne6qq/RoHagFf2HwbKx5+aMpn+Y6qRbe/nwN8EBkc1b4RAQu5bm2zyC6zyOXDHYF
 hZjiJnct+FBMmkkwVzORl1r3qSABPdDMNQdQgBlRp6AUPfEo3oSX8jg9oPLR2gLeQrpk
 iKzA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ftLv3y/FZNwOa6Ltu69QBSO6wBbq17dZbq1HpxfpOQkvv2fpoQDW17auafT0/+4ycalQj7Qe2379d@nongnu.org
X-Gm-Message-State: AOJu0YxLm74P1o5IefiIefXvqwAi0VIFIKdHIxBRfi4iYYhvjyPZ4Cr6
 BJDb1hDImW5fJ7QyodA72FODHHCjxVpyrJytw8PLc3mGrJZQlGyvLKrnb3fBXlKz4hbSMG8X3Wt
 LF5oxRI+Zr1TfkiwGWqZTrX0NAu5eD36mmAMVpwRsiN2xj3EQXl1bN35+
X-Gm-Gg: AfdE7cnqdQcM4uCnnKk1+ImTwVLx3owa0YVyV7j6E1EP6uHgJP1nVFSQSrIB3l7eJTV
 9l7mMbz/w4ny3T41QgQ1Fm9MLfTRSLJAODWyJdCquXBlEWPxzV4rJwHSjgcPFR3DQ+IvAhaQSkH
 zTZb+XzvIEbM7N7Z2CgrR7J+Mfak+mLGhUa252lEkmmSKdwP43ZLtlmGVqywawICOW+RWNnM+U/
 4P7XLLM2NCSP03sl0JCy/HY2HEgDT8YmfFwibdx9i0ouH8dDG+6ySsC4hrmP+1vmLjNShn6ErdQ
 4/Y74TTbDFScnGECrc6rue6LBGQyXFEO7Q9QsLe9qMi1VcKRcJ0Ovqx6+fP8Ki+pAEgUudwQEVd
 F/MKn44T0ervzJbnjv4OOFZ0itn68tTqX2hK3HjjitLghhug0joxZ
X-Received: by 2002:a05:600d:8445:10b0:492:649d:9b96 with SMTP id
 5b1f17b1804b1-4926683fb58mr97111825e9.9.1782499433851; 
 Fri, 26 Jun 2026 11:43:53 -0700 (PDT)
X-Received: by 2002:a05:600d:8445:10b0:492:649d:9b96 with SMTP id
 5b1f17b1804b1-4926683fb58mr97111585e9.9.1782499433412; 
 Fri, 26 Jun 2026 11:43:53 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:8426:ae00:a924:b4e0:1ee:f5c5?
 ([2a01:cb19:8426:ae00:a924:b4e0:1ee:f5c5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49269020266sm95023555e9.15.2026.06.26.11.43.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2026 11:43:52 -0700 (PDT)
Message-ID: <07b33ce7-d73e-4d9a-adae-6cd3f4d03615@redhat.com>
Date: Fri, 26 Jun 2026 20:43:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] vfio/pci: Propagate errors in vfio_pci_load_rom()
 using Error API
To: Mario Casquero <mcasquer@redhat.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, philmd@mailo.com
References: <20260625094307.148542-1-mcasquer@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260625094307.148542-1-mcasquer@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/25/26 11:43, Mario Casquero wrote:
> Updates vfio_pci_load_rom() to use Error API for error propagation
> instead of error_report(), improving error handling consistency.
> 
> Signed-off-by: Mario Casquero <mcasquer@redhat.com>
> ---
> v4:
>    - Use error_append_hint() instead of error_printf()
>    - Reset rom_size and rom_offset to 0 in the error case
>    - Update error message to "Device ROM size is zero", different from read errors
> v3:
>    - Use error_setg_errno() instead of error_setg() with strerror()
>    - Reset rom_size and rom_offset to 0 when freeing rom on error
>    - Use local_err with error_report_err() instead of passing NULL errp
> 
>   hw/vfio/pci.c | 32 +++++++++++++++++++++-----------
>   1 file changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 9df04fa2d7..61b4a6a5a3 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1027,7 +1027,7 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
>       }
>   }
>   
> -static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
> +static bool vfio_pci_load_rom(VFIOPCIDevice *vdev, Error **errp)
>   {
>       VFIODevice *vbasedev = &vdev->vbasedev;
>       struct vfio_region_info *reg_info = NULL;
> @@ -1040,7 +1040,7 @@ static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
>                                         &reg_info);
>   
>       if (ret != 0) {
> -        error_report("vfio: Error getting ROM info: %s", strerror(-ret));
> +        error_setg_errno(errp, -ret, "vfio: Error getting ROM info");
>           return false;
>       }
>   
> @@ -1052,10 +1052,13 @@ static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
>       vdev->rom_offset = reg_info->offset;
>   
>       if (!vdev->rom_size) {
> -        error_report("vfio-pci: Cannot read device rom at %s", vbasedev->name);
> -        error_printf("Device option ROM contents are probably invalid "
> -                    "(check dmesg).\nSkip option ROM probe with rombar=0, "
> -                    "or load from file with romfile=\n");
> +        vdev->rom_size = 0;
> +        vdev->rom_offset = 0;
> +        error_setg(errp, "vfio-pci: Device ROM size is zero at %s",
> +                   vbasedev->name);
> +        error_append_hint(errp, "Device option ROM contents are probably "
> +                          "invalid (check dmesg).\nSkip option ROM probe "
> +                          "with rombar=0, or load from file with romfile=\n");
>           return false;
>       }
>   
> @@ -1076,10 +1079,12 @@ static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
>               if (bytes == -EINTR || bytes == -EAGAIN) {
>                   continue;
>               }
> -            error_report("vfio: Error reading device ROM: %s",
> -                         strreaderror(bytes));
> -
> -            break;
> +            error_setg_errno(errp, -bytes, "vfio: Error reading device ROM");
> +            g_free(vdev->rom);
> +            vdev->rom = NULL;
> +            vdev->rom_size = 0;
> +            vdev->rom_offset = 0;
> +            return false;
>           }
>       }
>   
> @@ -1147,7 +1152,12 @@ static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
>   
>       /* Load the ROM lazily when the guest tries to read it */
>       if (unlikely(!vdev->rom && !vdev->rom_read_failed)) {
> -        vdev->rom_read_failed = !vfio_pci_load_rom(vdev);
> +        Error *local_err = NULL;
> +
> +        vdev->rom_read_failed = !vfio_pci_load_rom(vdev, &local_err);
> +        if (vdev->rom_read_failed) {
> +            error_report_err(local_err);
> +        }
>       }
>   
>       memcpy(&val, vdev->rom + addr,


Applied to

     https://github.com/legoater/qemu vfio-next

Thanks,

C.


