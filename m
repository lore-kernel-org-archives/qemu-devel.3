Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D90C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 10:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU0ip-00059Z-0S; Tue, 24 Jun 2025 06:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uU0ik-00058V-Gb
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 06:17:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uU0ii-0006yB-EX
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 06:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750760257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nucLOPvugbnlgOytu47h5Dy46r17NN1YANb29bn3JBg=;
 b=QfXRXR/fBZnDUakswqOQnRSuFtLR/3APNckWUMY2E0FOmAFAVl/ENyxrg/U7wLgRJMydnm
 uDYiwEyJc+FKbSWm4hjr2IJUaArTfHiCmZUaoQ1JsqEXmgZa7osQs1dgzE8I6loYT68BHa
 WlSmhDqqWhv5ApfJA3TFWN8697BDqfI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-AYDB4AGVNWKOwieHhK4vWA-1; Tue, 24 Jun 2025 06:17:35 -0400
X-MC-Unique: AYDB4AGVNWKOwieHhK4vWA-1
X-Mimecast-MFC-AGG-ID: AYDB4AGVNWKOwieHhK4vWA_1750760255
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45311704d22so33704165e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 03:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750760254; x=1751365054;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nucLOPvugbnlgOytu47h5Dy46r17NN1YANb29bn3JBg=;
 b=LXMNkuEjVE3FqNDv19K0KuIFqhfNXwNRO5kbrSiE/0hZj/uzc5VpCVXl2FwsmI7pKa
 9JGwtnX/2lKabD+s3Kp3kkbrgwyeFQ/WVs8LKWow1cuxwC6PaMAUesuPt99XJy8bwLq9
 9af10XCP9wVZpoeFtIkAm2rPTjTGWSNR6/5vxrY1w65snNz8z7BQA1vihwt7PANZmuxz
 elpFfo9UwiIPOgqC5VgOcBTlRhPOilWKWoVoQbhMSU2OjGjKOeTWZlIkf1Gu980q+4+L
 mITRN62ojg1TjlLkDCCd95HVbEZ8vSO578cC83uxyhLZSc0IYqTBxYRpeLADO56r1hyv
 ta8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSdgLSkjdPkGCGgkQpKL8oNkYVHSjHps8sS7fe4x0Odpd+rVbSqjtniGyNZm1ATvFRr/yIpIPFDYfz@nongnu.org
X-Gm-Message-State: AOJu0YxdktJYSnFlNinRBB00t4LFpWsGHvUXS1DWYnIt05Jki7T0pJZm
 Yedk94DFOa5XXd+dKH/KRB2b9CkCBfNxpegVLm8LHUsDPaW4JsbPda/RcScfw5/aQkinb1tMdM4
 n411lzfrVhu1I5cG/zjy/ApSmgDiGOnKk5PVIeE6Skd6mEVuPgXU6J/6z
X-Gm-Gg: ASbGncvNPuGPp2ZnHe+3wg2jWiLuDH7uUazNr/alU0Vc0Cms/leBaXotdrXK2du+BA3
 PkjuKyp5bb/RN/fRSraswQPHorX4Qd86Jt9h5q2I4ohD747SkadNz0MtLeD/IPHEf9SDMRMb+0S
 YmGtLPzcTK5pt6aODT5REd4drTkDmJ2EwWbKKlFbJ2bycClb97A+KKX3I07S0KCRwJrsqwo9f/s
 OVrrw1HDd7H2RT3/wvaCb/WLechrXIdMeZnD6Vmv5nTIGd7rym6ec7IFf0mJfY8nQha5tDxijBj
 b0Rdj/KCyQrwyEKZxARk9yjYz9NIk+PhJ3HGc/Z2D4iGosiLacX0w8evFNrz0Ug=
X-Received: by 2002:a05:600c:3b15:b0:450:cf46:5510 with SMTP id
 5b1f17b1804b1-453656c3641mr162217365e9.29.1750760254664; 
 Tue, 24 Jun 2025 03:17:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnhbKNI16Y5aVmiCsU8lbUHts19PTUhRWrjOk4WKe+LI04A1XsKUp0uCX/q0ccnRrpGg/l4w==
X-Received: by 2002:a05:600c:3b15:b0:450:cf46:5510 with SMTP id
 5b1f17b1804b1-453656c3641mr162217135e9.29.1750760254300; 
 Tue, 24 Jun 2025 03:17:34 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-198.pools.arcor-ip.net.
 [47.64.115.198]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e80f296bsm1554621f8f.60.2025.06.24.03.17.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 03:17:33 -0700 (PDT)
Message-ID: <c42f3c49-97f2-4168-bc31-4a9fcb07e243@redhat.com>
Date: Tue, 24 Jun 2025 12:17:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] hw/s390x: add Control-Program Identification to QOM
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>,
 qemu-s390x mailing list <qemu-s390x@nongnu.org>
Cc: Daniel Berrange <berrange@redhat.com>,
 qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
References: <20250616140107.990538-1-shalini@linux.ibm.com>
 <20250616140107.990538-3-shalini@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250616140107.990538-3-shalini@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 16/06/2025 16.01, Shalini Chellathurai Saroja wrote:
> Add Control-Program Identification (CPI) data to the QEMU Object
> Model (QOM), along with the timestamp in which the data was received
> as shown below.
> 
> virsh # qemu-monitor-command vm --pretty '{"execute":"qom-list",
> "arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi"}}'
> {
>    "return": [
>      [...]
>      {
>        "name": "system_level",
>        "type": "uint64"
>      },
>      {
>        "name": "system_name",
>        "type": "string"
>      },
>      {
>        "name": "system_type",
>        "type": "string"
>      },
>      {
>        "name": "timestamp",
>        "type": "uint64"
>      },
>      {
>        "name": "sysplex_name",
>        "type": "string"
>      }
>    ],
>    "id": "libvirt-14"
> }
> 
> Example CPI data:
> virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get",
> "arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi",
> "property":"system_type"}}'
> {
>    "return": "LINUX   ",
>    "id": "libvirt-18"
> }
> virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get",
> "arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi",
> "property":"system_name"}}'
> {
>    "return": "TESTVM  ",
>    "id": "libvirt-19"
> }
> virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get",
> "arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi",
> "property":"sysplex_name"}}'
> {
>    "return": "PLEX    ",
>    "id": "libvirt-20"
> }
> virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get",
> "arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi",
> "property":"system_level"}}'
> {
>    "return": 74872343805430528,
>    "id": "libvirt-21"
> }
> virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get",
> "arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi",
> "property":"timestamp"}}'
> {
>    "return": 1748866753433923000,
>    "id": "libvirt-22"
> }
> 
> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> ---
>   hw/s390x/sclpcpi.c                | 74 +++++++++++++++++++++++++++++++
>   include/hw/s390x/event-facility.h |  5 +++
>   2 files changed, 79 insertions(+)

Reviewed-by: Thomas Huth <thuth@redhat.com>


