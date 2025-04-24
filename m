Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0658C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 09:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7t3D-0004Hx-Fz; Thu, 24 Apr 2025 05:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7t36-0004HD-Gz
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:39:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7t34-0001Zn-MI
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745487552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1XiX7+rwBWSMZ9C2Kx2DUC4ePTwc31zM1986s8QJ/Gc=;
 b=HaOuv/B7RrGEJ9pQIoTiy3GgbIZwWlJie4G0n9RWQ67L2Wrn/oqfX80dze/XDDF25rXts2
 PT6I5Ze0KDsUrZi2THC1O5jLE8UE74zFzH+bhgDUCaz4AcjIFFN8xFikoWqcG/wXEIhR29
 mQYbYrRq6LbCeXhLKRp3Wl0g7jyKswc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-TWNQinpmPxGHlM0J2L9n_w-1; Thu, 24 Apr 2025 05:39:07 -0400
X-MC-Unique: TWNQinpmPxGHlM0J2L9n_w-1
X-Mimecast-MFC-AGG-ID: TWNQinpmPxGHlM0J2L9n_w_1745487546
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cf5196c25so3879455e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 02:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745487546; x=1746092346;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1XiX7+rwBWSMZ9C2Kx2DUC4ePTwc31zM1986s8QJ/Gc=;
 b=YkJTAtWRm1e3EVtguA9sO2NzAINij3wopgPGmlcrF+lg7PJZ8OCpShP1dydvGFvG7e
 LKQVpX9reobycTsM7NFD8JMTq8IjkhP08wukVYahvYufwWVNKdhJsfsO4TO5/bc9iCPS
 dKE757nArooR4mS8EejAhRdX1L5ItIHj4mlpLrqNZzs5tM9VyEDkSKI7lLbtVEKtFp5a
 icSU7GRzGn+1rIKIPSVEqYUZoinpXx0sy4pQcRqIvq/BOAbMmuroDYSdhPPBCT0DejUC
 fQrVUpOavPuXcZEqrwIdXjBN4rOy+mx+oI4wd55i0wFwrDjbFgn6Zxd24wLM2VIyPaNE
 xQeQ==
X-Gm-Message-State: AOJu0Yzw6SsG7cGZrUDPlmOej0ARah8gk99X9iPB+6MXu1yvVoh3HMuE
 JkaUjiM3Eyail3WS802idDCJoQl8PToHWA4ty+sPCpeL0ykG/FJPlNJi3glr1KzqlED0+dhgrsF
 LuU16Ds4Fxz5kPN+oK+gXTAR+R4DZKTpGcUYmIoQS1y+m1GIosx4o
X-Gm-Gg: ASbGnctwXQsu9o5Hi68fTEFUqbL8cZiZnJLShv4xH9voroiQo6lH15N0cfLNR3UoFtb
 +p/T1NyXI5y5BVgh+zuIJBnvgLVrTMdtK7QqhQJiZDAzSyupieJ5PRdL0aaGeK0PBFm9ib1hIYn
 zwB9XbsJlgQJTq0otVLNKT3sSYYCI5jmwtAgA2owdF2sUsvNfoao0Fi2XM/uzcfLnqz6/5tKJDi
 c/HTW6SawPNciae+OuJR51MBWmHVODk7vm4g86wBBPtRSMcFgk6kYs5Eu3ltHK4FehrzQogFUSm
 67chSIZn0Jd2iGd0SbW6x9vDjv097D+ysZYypUOGLrrOjA==
X-Received: by 2002:a05:6000:1e48:b0:391:3cb7:d441 with SMTP id
 ffacd0b85a97d-3a06cf5f657mr1193452f8f.25.1745487545885; 
 Thu, 24 Apr 2025 02:39:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG63tzCX2Ms34GbbO2QEFPDQSrZoLfRf+d0hkK+fDxKgRt/BV/Lmcuz7/gh3ACRW9Rd/6r4QA==
X-Received: by 2002:a05:6000:1e48:b0:391:3cb7:d441 with SMTP id
 ffacd0b85a97d-3a06cf5f657mr1193436f8f.25.1745487545437; 
 Thu, 24 Apr 2025 02:39:05 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-43-178-177.web.vodafone.de.
 [109.43.178.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d54f019sm1516625f8f.96.2025.04.24.02.39.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 02:39:05 -0700 (PDT)
Message-ID: <8cb149ee-57fe-4e67-8ab9-f95244ebcb33@redhat.com>
Date: Thu, 24 Apr 2025 11:39:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: iotest 240 is failing (was: Re: [PULL 20/22] virtio-scsi: add
 iothread-vq-mapping parameter)
From: Thomas Huth <thuth@redhat.com>
To: qemu-block@nongnu.org, stefanha@redhat.com, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250311160021.349761-1-kwolf@redhat.com>
 <20250311160021.349761-21-kwolf@redhat.com>
 <a6b01ce7-e1a0-46bc-8c12-f3e439486f82@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <a6b01ce7-e1a0-46bc-8c12-f3e439486f82@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 26/03/2025 11.43, Thomas Huth wrote:
> On 11/03/2025 17.00, Kevin Wolf wrote:
>> From: Stefan Hajnoczi <stefanha@redhat.com>
>>
>> Allow virtio-scsi virtqueues to be assigned to different IOThreads. This
>> makes it possible to take advantage of host multi-queue block layer
>> scalability by assigning virtqueues that have affinity with vCPUs to
>> different IOThreads that have affinity with host CPUs. The same feature
>> was introduced for virtio-blk in the past:
>> https://developers.redhat.com/articles/2024/09/05/scaling-virtio-blk-disk- 
>> io-iothread-virtqueue-mapping
> 
>   Hi Stefan!
> 
> This patch seems to cause some troubles with iotest 240 in raw (and some 
> other) mode:
> 
> 240   fail       [11:41:33] [11:41:34]   0.8s   (last: 0.8s)  output 
> mismatch (see tests/qemu-iotests/scratch/raw-file-240/240.out.bad)
> --- tests/qemu-iotests/240.out
> +++ tests/qemu-iotests/scratch/raw-file-240/240.out.bad
> @@ -46,11 +46,11 @@
>   {"execute": "device_add", "arguments": {"bus": "scsi0.0", "drive": "hd0", 
> "driver": "scsi-hd", "id": "scsi-hd0"}}
>   {"return": {}}
>   {"execute": "device_add", "arguments": {"bus": "scsi1.0", "drive": "hd0", 
> "driver": "scsi-hd", "id": "scsi-hd1"}}
> -{"error": {"class": "GenericError", "desc": "Cannot change iothread of 
> active block backend"}}
> +{"return": {}}
>   {"execute": "device_del", "arguments": {"id": "scsi-hd0"}}
>   {"return": {}}
>   {"execute": "device_add", "arguments": {"bus": "scsi1.0", "drive": "hd0", 
> "driver": "scsi-hd", "id": "scsi-hd1"}}
> -{"return": {}}
> +{"error": {"class": "GenericError", "desc": "Duplicate device ID 'scsi-hd1'"}}
>   {"execute": "device_del", "arguments": {"id": "scsi-hd1"}}
>   {"return": {}}
>   {"execute": "blockdev-del", "arguments": {"node-name": "hd0"}}
> Failures: 240
> Failed 1 of 1 iotests
> 
> Could you please have a look?

Ping!

The problem still persists in QEMU 10.0 :-(

  Thomas


