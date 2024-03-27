Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BB3CD11DD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 12:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpSVw-0008WI-Jj; Wed, 27 Mar 2024 08:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rpSVu-0008VY-AV
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 08:36:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rpSVp-0001Os-9F
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 08:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711542972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6oeI+azAxAF+MfufA51kXocZyEHU598GMoGT5Y6a7q0=;
 b=T7ZLi/kq34W9XxFxjtgAv6z1bRFGRmnxxybqhqoQFw4NbRX+s19P4Fla8D7kR+DInBoy/x
 lIruwyR58M2Dph5VRrEOOHAtE2CODGVLgz+NL2eFFt9u2N7Z6jXufizZ9YGPjSYRSFys5i
 1bUiW9te+dYZgq2iDMC3xWHPnH2adYk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-SV7KFPHtOEarDJ_meYPdAg-1; Wed, 27 Mar 2024 08:36:10 -0400
X-MC-Unique: SV7KFPHtOEarDJ_meYPdAg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4140f58ac00so34516335e9.3
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 05:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711542969; x=1712147769;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6oeI+azAxAF+MfufA51kXocZyEHU598GMoGT5Y6a7q0=;
 b=WtnsKQcgvGXHheofvf5DIVZNrEjQR4d4lxAdWZtcuLGjwdtB0JOgDlxAzf7OFyaiv+
 pxbl/HgqnU1KMhufMvoFKyNmVfkmjNiEofQJXV8jn/GQLpwKXZJnW5rDipeVulAphrpo
 ENdtMM665bDF6hOFWxryFn6bZ7y7dOXEvVkiyIYG7tabN62YQ4q1G6XnEyKxsztvaSax
 KS+vIGH1XmGhYmx73x1EePqcaaAriPZyS9d69s3ziqc8+klh7eXL38Z3u6MUfp6nYw11
 mvU3yihMIvnCegyE2WyAANw2UhecOz5T7Tnl+sbiM9KgnO84jSwNpSd/spGuo3TXoDaQ
 g6SA==
X-Gm-Message-State: AOJu0Yw2rpWVKOSiYpRYliNnMngHQsuuOV4Fak7R6+8yV9t4TWcNyXlM
 VYJ3bly9dZzJB0/3JT/2v0s5pf7ZBp3XfWUuDi5nnIZueXOcCI2Qy1ZXuS5sFuSdtkSpXKT76lz
 CYFTlJqiN/xmgT7L6fPzbXUcVoTblvkPZ538USjFB4FD8GZLz0ott
X-Received: by 2002:a05:600c:3ba7:b0:414:3713:e9a2 with SMTP id
 n39-20020a05600c3ba700b004143713e9a2mr1056006wms.3.1711542969110; 
 Wed, 27 Mar 2024 05:36:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVflpo6EGE/59QLVXEXMKdbdW7ilhVJb2iMAUALrww2VJcEOko9vuWHBz6p88KC6grQpwU7A==
X-Received: by 2002:a05:600c:3ba7:b0:414:3713:e9a2 with SMTP id
 n39-20020a05600c3ba700b004143713e9a2mr1055994wms.3.1711542968733; 
 Wed, 27 Mar 2024 05:36:08 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-177-37.web.vodafone.de.
 [109.43.177.37]) by smtp.gmail.com with ESMTPSA id
 f6-20020a05600c4e8600b004148ff6ef54sm2031338wmq.29.2024.03.27.05.36.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 05:36:08 -0700 (PDT)
Message-ID: <a2d13494-aec2-427b-af9b-e8c41f7057f1@redhat.com>
Date: Wed, 27 Mar 2024 13:36:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] util/error-report: Add "error: " prefix for error-level
 report
To: Zhao Liu <zhao1.liu@linux.intel.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
References: <20240327114609.3858483-1-zhao1.liu@linux.intel.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240327114609.3858483-1-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 27/03/2024 12.46, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> When vreport() was introduced, there was no prefix for error-level
> (REPORT_TYPE_ERROR) report. The original reason is "To maintain
> compatibility we don't add anything here" as Alistair said in his
> RFC v3 series [1].
> 
> This was done in the context of inheriting the original error_report()
> interface without the prefix style. And it was also useful to have a
> means of error handling, such as exit(), when error occurs, so that the
> error message - the most serious level - can be noticed by the user.
> 
> Nowadays, however, error_report() and its variants have a tendency to be
> "abused": it is used a lot just for the sake of logging something more
> noticeable than the "warn" or "info" level, in the absence of
> appropriate error handling logic.
> 
> But, in the use case above, due to the lack of a prefix, it is in fact
> less informative to the user than warn_report()/info_report() (with
> "warn:" or "info: " prfix), which does not match its highest level.
> 
> Therefore, add "error: " prefix for error-level report.
> 
> [1]: https://lore.kernel.org/qemu-devel/87r2xuay5h.fsf@dusky.pond.sub.org/#t
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   util/error-report.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/util/error-report.c b/util/error-report.c
> index 6e44a5573217..e981c0b032f0 100644
> --- a/util/error-report.c
> +++ b/util/error-report.c
> @@ -213,6 +213,7 @@ static void vreport(report_type type, const char *fmt, va_list ap)
>   
>       switch (type) {
>       case REPORT_TYPE_ERROR:
> +        error_printf("error: ");
>           break;
>       case REPORT_TYPE_WARNING:
>           error_printf("warning: ");

Sounds like a good idea to me, but I think you should then also remove
the hard-coded "error:" strings in the various error_reports():

$ grep -ri 'error_report.*"error:'
migration/block-dirty-bitmap.c:        error_report("Error: block device name is not set");
migration/block-dirty-bitmap.c:                error_report("Error: Unknown bitmap alias '%s' on node "
migration/block-dirty-bitmap.c:                error_report("Error: unknown dirty bitmap "
migration/block-dirty-bitmap.c:        error_report("Error: block device name is not set");
target/i386/kvm/kvm.c:        error_report("error: failed to set MSR 0x%" PRIx32 " to 0x%" PRIx64,
target/i386/kvm/kvm.c:        error_report("error: failed to get MSR 0x%" PRIx32,
util/vhost-user-server.c:        error_report("Error: too big message request: %d, "
accel/hvf/hvf-all.c:        error_report("Error: HV_ERROR");
accel/hvf/hvf-all.c:        error_report("Error: HV_BUSY");
accel/hvf/hvf-all.c:        error_report("Error: HV_BAD_ARGUMENT");
accel/hvf/hvf-all.c:        error_report("Error: HV_NO_RESOURCES");
accel/hvf/hvf-all.c:        error_report("Error: HV_NO_DEVICE");
accel/hvf/hvf-all.c:        error_report("Error: HV_UNSUPPORTED");
accel/hvf/hvf-all.c:        error_report("Error: HV_DENIED");
monitor/hmp-cmds.c:        error_reportf_err(err, "Error: ");
hw/arm/xlnx-zcu102.c:        error_report("ERROR: RAM size 0x%" PRIx64 " above max supported of "
hw/block/dataplane/xen-block.c:        error_report("error: unknown operation (%d)", request->req.operation);
hw/block/dataplane/xen-block.c:        error_report("error: write req for ro device");
hw/block/dataplane/xen-block.c:            error_report("error: nr_segments too big");
hw/block/dataplane/xen-block.c:            error_report("error: first > last sector");
hw/block/dataplane/xen-block.c:            error_report("error: page crossing");
hw/block/dataplane/xen-block.c:        error_report("error: access beyond end of file");
hw/rdma/rdma_backend.c:            rdma_error_report("Error: Not a MAD request, skipping");
hw/s390x/s390-skeys.c:        error_report("Error: Setting storage keys for pages with unallocated "
hw/s390x/s390-skeys.c:        error_report("Error: Getting storage keys for pages with unallocated "
hw/usb/bus.c:        error_report("Error: no usb bus to attach usbdevice %s, "
gdbstub/gdbstub.c:            error_report("Error: Bad gdb register numbering for '%s', "

  Thomas



