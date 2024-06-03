Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C36C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 19:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sECyQ-0001CP-Mo; Mon, 03 Jun 2024 15:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sECyP-0001Bw-8o
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 15:04:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sECyM-0000BG-E4
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 15:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717441437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oIiKIYqoXDuI7SNFZ0yaPBB1pidC/R7kVVQ0zahjF2U=;
 b=LD5O7KYGe4Wcr8JRuG5slpYfEUtUgPEAS06xaU6jncyQnu0xsR3SWdEHNgY/nfSJ9YQNVi
 WJfS5rWH3KTAb6UuWPBnUcuWpzqTKRocbwP0Q72/QTn4mwOoGOBQT9ONP9lB/EdrkBi677
 vsJpB2mqTpy7x0HS0KoQ/dkGDuIZnek=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-iKtQNwxxNjy3wwBIqeOmUg-1; Mon, 03 Jun 2024 15:03:55 -0400
X-MC-Unique: iKtQNwxxNjy3wwBIqeOmUg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4212abc353dso26720355e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 12:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717441434; x=1718046234;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oIiKIYqoXDuI7SNFZ0yaPBB1pidC/R7kVVQ0zahjF2U=;
 b=mKIA1sRSO+IyhRWM2eH5IAgpnmL0Ij2wo+XfyZ78FSF0TjcGNy8g9KVXqeAmx5FgOy
 /ivF32gTZdbM1g9mngcIHbhwHLr7A1aAxqjXyhaLTD2CvRkWEM0YLWpdmjinR36goFlU
 uExP0OMeDC/FvKZljcswECAm/399yaDJ7Ra+Qe9fC+3xejunQ38Fd0att26KOBZcqKgi
 5Gskq+Ta7/fUAsuFBZcFV889Sbk98bwWq81d3suR4UQAkDUPQ9oVVDiQDM5nM+YLGQ5A
 nc5zWWZUrdhaBLZtDNSDkz3dKvFRYhNhy6eBvVRjImZFzNBaHd5izCX7jmrHGy/eB6h5
 +SWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSd9VtKkmGkUewr8RUUIlGxeCvBVM0LO40+Mkd4Z7n1MnvdqK11QPZR035CAEb3iUn1GiRtg1VeICN9WfnoGrl94ELmzk=
X-Gm-Message-State: AOJu0YyxTO1xXBQzrWIche4GtGThqfcebxTxEMHDFmJt033MfcLzVqjq
 pmyfPBALqO45ilZz1iC59UfOQNpNQE5P8+oKkQ1RUwNDFZr9M2PTtMwx07txy02Zp55Fan2PZLh
 7MBIfWwTAEJVjPNbdp1BVbLjSSs/cod4/hmfPipwwRhk8fZU/lYkwhhk5DLsh
X-Received: by 2002:a05:600c:c09:b0:418:ee2:5911 with SMTP id
 5b1f17b1804b1-4213d3068f9mr33819265e9.28.1717441434340; 
 Mon, 03 Jun 2024 12:03:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHudulg2qHIahDs+ptH0lHO1upBfj7ayKevGb/Hn5D8GVPKLJghxkPiGigYH+w0kT/VbqferA==
X-Received: by 2002:a05:600c:c09:b0:418:ee2:5911 with SMTP id
 5b1f17b1804b1-4213d3068f9mr33819015e9.28.1717441434003; 
 Mon, 03 Jun 2024 12:03:54 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-176-229.web.vodafone.de.
 [109.43.176.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42138c41becsm75522335e9.30.2024.06.03.12.03.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 12:03:53 -0700 (PDT)
Message-ID: <3af8ce36-8010-4aac-a786-a072bed74b99@redhat.com>
Date: Mon, 3 Jun 2024 21:03:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] s390x: Build IPLB chain for multiple boot devices
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com, nsg@linux.ibm.com
References: <20240529154311.734548-1-jrossi@linux.ibm.com>
 <20240529154311.734548-4-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240529154311.734548-4-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 29/05/2024 17.43, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Write a chain of IPLBs into memory for future use.
> 
> The IPLB chain is placed immediately before the BIOS in memory at the highest
> unused page boundary providing sufficient space to fit the chain. Because this
> is not a fixed address, the location of the next IPLB and number of remaining
> boot devices is stored in the QIPL global variable for later access.
> 
> At this stage the IPLB chain is not accessed by the guest during IPL.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
...
> @@ -422,54 +440,51 @@ void s390_ipl_set_loadparm(char *ascii_lp, uint8_t *ebcdic_lp)
>       }
>   }
>   
> -static bool s390_gen_initial_iplb(S390IPLState *ipl)
> +static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>   {
> -    DeviceState *dev_st;
> +    S390IPLState *ipl = get_ipl_device();
>       CcwDevice *ccw_dev = NULL;
>       SCSIDevice *sd;
>       int devtype;
>       uint8_t *lp;
>   
> -    dev_st = get_boot_device(0);
> -    if (dev_st) {
> -        ccw_dev = s390_get_ccw_device(dev_st, &devtype);
> -    }
> -
>       /*
>        * Currently allow IPL only from CCW devices.
>        */
> +    ccw_dev = s390_get_ccw_device(dev_st, &devtype);
>       if (ccw_dev) {
>           lp = ccw_dev->loadparm;
>   
> -        switch (devtype) {
> -        case CCW_DEVTYPE_SCSI:
> +         switch (devtype) {
> +         case CCW_DEVTYPE_SCSI:

Bad indentation?

>               sd = SCSI_DEVICE(dev_st);
> -            ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
> -            ipl->iplb.blk0_len =
> +            iplb->len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
> +            iplb->blk0_len =
>                   cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN - S390_IPLB_HEADER_LEN);
> -            ipl->iplb.pbt = S390_IPL_TYPE_QEMU_SCSI;
> -            ipl->iplb.scsi.lun = cpu_to_be32(sd->lun);
> -            ipl->iplb.scsi.target = cpu_to_be16(sd->id);
> -            ipl->iplb.scsi.channel = cpu_to_be16(sd->channel);
> -            ipl->iplb.scsi.devno = cpu_to_be16(ccw_dev->sch->devno);
> -            ipl->iplb.scsi.ssid = ccw_dev->sch->ssid & 3;
> +            iplb->pbt = S390_IPL_TYPE_QEMU_SCSI;
> +            iplb->scsi.lun = cpu_to_be32(sd->lun);
> +            iplb->scsi.target = cpu_to_be16(sd->id);
> +            iplb->scsi.channel = cpu_to_be16(sd->channel);
> +            iplb->scsi.devno = cpu_to_be16(ccw_dev->sch->devno);
> +            iplb->scsi.ssid = ccw_dev->sch->ssid & 3;
>               break;
>           case CCW_DEVTYPE_VFIO:
> -            ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
> -            ipl->iplb.pbt = S390_IPL_TYPE_CCW;
> -            ipl->iplb.ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
> -            ipl->iplb.ccw.ssid = ccw_dev->sch->ssid & 3;
> +            iplb->len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
> +            iplb->pbt = S390_IPL_TYPE_CCW;
> +            iplb->ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
> +            iplb->ccw.ssid = ccw_dev->sch->ssid & 3;
>               break;
>           case CCW_DEVTYPE_VIRTIO_NET:
> +            /* The S390IPLState netboot is ture if ANY IPLB may use netboot */

Typo: ture --> true

  Thomas


