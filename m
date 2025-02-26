Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40997C021A4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 04:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn9Vj-0007CG-HP; Tue, 25 Feb 2025 23:59:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1tn9Vi-0007Bz-DT
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 23:59:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1tn9Vg-000294-E8
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 23:59:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740545935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jCnKTy/sgEG2ePdqmPVY/AE6ciXlhI5f1Xr2uhZKTd8=;
 b=XYzWw48jXTvFlJDlRY8xRFmZLg1fmql8fGiJ/ELs6NuVw/B7Qx2x77cEOGVL/qAYDftHkh
 9SFD17DhRFBGjC21bUOKm8jAt9ycQw2Xx+G+bweAnOrvJ4otdriP8KMCOUbNqxSCa7hzT8
 anzB96BTnqgS1s6fZDhoBcZb1HlFc1E=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-s6drM0n9MpCl0XpmjY64Xw-1; Tue, 25 Feb 2025 23:58:53 -0500
X-MC-Unique: s6drM0n9MpCl0XpmjY64Xw-1
X-Mimecast-MFC-AGG-ID: s6drM0n9MpCl0XpmjY64Xw_1740545932
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2fbff6426f5so13293065a91.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 20:58:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740545932; x=1741150732;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jCnKTy/sgEG2ePdqmPVY/AE6ciXlhI5f1Xr2uhZKTd8=;
 b=bxCEh/FdKz1zC+fNCSaCGcSZ5mW/T3c+74AkQsFhFr3pj/i0I+zwpdpKQdYXypyWxO
 o6g3S5eOokQ7ovAaoZZyb0oKZmo6Id6soqASUPsfauz34fQqETxbx5JEEwgKiLEZBkw7
 jiCmGve6c7FNrPouybk350iPhAAydEEdLI6oJwjYGOTIrgQUzgtceqJIvJEuLx3vOkI9
 OS+ByRWMe5cLZBur5agAnQnStiTvXglA5PMziJAFH5X06FhRUm8AX3QjPW/s5SxLUCBO
 S6UxMVxWIZCFFkgW0v8YMcE+qo3C+3sik98eZbz9wLguCsrmZDkGaXfcurv8CA0TgQiJ
 mdZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDtMHq+ImuSDVg2UxxAn0bZPt23ldJ+VfnF2jfgfo3SXyGbIz1HDTPCpQLg+Ss/7H/Iz3Ciy2SVzS3@nongnu.org
X-Gm-Message-State: AOJu0YzJnbZGsPehY0sD+QeY+fTAvVZqNqyVUCnnjA0VqyaqbgFoh80l
 ugMpqw4IIbzaTyHfv4Pu0zsXd13jVzReSqul8QTkGywBbz7pa9owTe5NnDcHfV8zRVErBrZONAI
 YInIzeoFAodoakx+tiFMzEkRB4BrzjYE/3TBjSxTbNhkKsr6IWvhz
X-Gm-Gg: ASbGncuRBXZEMeOXzS6i+KCuDBpN8R1DxH6IccuDviOJDAS1RMHqty4k82+ueUD7DAQ
 +ncVJ9oSMxIfFqk8MwntJ31uNXC0wjxM5yEp3XZlsoCcQTTBLdZhsmAm9jiqztMUXyJx+ikO15B
 Eiwl7gMKsKJY3MyIAdrZHiFxw9fXN5dBLCdgqDAieS6f2TV5bQfNKFSwYe7TKDMt/5KH39+3H+d
 V2EakzZZFFF8SAMXwd/hFeIY/C0Fx3uyE0uwL0EL+WUOBywxa77mLZEetU4NUZ009nScoaejrTt
 2HXIyJgA1q6cuUq12A==
X-Received: by 2002:a05:6a20:6a0d:b0:1ee:e808:732c with SMTP id
 adf61e73a8af0-1f0fc1394c6mr9224764637.14.1740545932427; 
 Tue, 25 Feb 2025 20:58:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKexMxW3JXNyCIROB2TCz88X/lZMtrZP+npdPNqZxaN4RJoKZU57zAYVTfEmyQniU8WkyOcg==
X-Received: by 2002:a05:6a20:6a0d:b0:1ee:e808:732c with SMTP id
 adf61e73a8af0-1f0fc1394c6mr9224732637.14.1740545932110; 
 Tue, 25 Feb 2025 20:58:52 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.164])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7347a81edaesm2565592b3a.149.2025.02.25.20.58.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 20:58:51 -0800 (PST)
Message-ID: <dafa471d-c5bb-4f6b-8483-17741e0caab1@redhat.com>
Date: Wed, 26 Feb 2025 14:58:46 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] target/arm: Retry pushing CPER error if necessary
To: Igor Mammedov <imammedo@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <20250214041635.608012-1-gshan@redhat.com>
 <20250214041635.608012-5-gshan@redhat.com>
 <20250219185518.767a48d9@imammedo.users.ipa.redhat.com>
 <7caa54df-abe1-4833-bb59-cb83f8241962@redhat.com>
 <20250221110435.00004a3b@huawei.com>
 <20250225121939.7e0e2304@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250225121939.7e0e2304@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 2/25/25 9:19 PM, Igor Mammedov wrote:
> On Fri, 21 Feb 2025 11:04:35 +0000
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
>>
>> Ideally I'd like whatever we choose to look like what a bare metal machine
>> does - mostly because we are less likely to hit untested OS paths.
> 
> Ack for that but,
> that would need someone from hw/firmware side since error status block
> handling is done by firmware.
> 
> right now we are just making things up based on spec interpretation.
> 

It's a good point. I think it's worthwhile to understand how the RAS event
is processed and turned to CPER by firmware.

I didn't figure out how CPER is generated by edk2 after looking into tf-a (trust
firmware ARM) and edk2 for a while. I will consult to EDK2 developers to seek
their helps. However, there is a note in tf-a that briefly explaining how RAS
event is handled.

   From tf-a/plat/arm/board/fvp/aarch64/fvp_lsp_ras_sp.c:
   (git@github.com:ARM-software/arm-trusted-firmware.git)

   /*
    * Note: Typical RAS error handling flow with Firmware First Handling
    *
    * Step 1: Exception resulting from a RAS error in the normal world is routed to
    *         EL3.
    * Step 2: This exception is typically signaled as either a synchronous external
    *         abort or SError or interrupt. TF-A (EL3 firmware) delegates the
    *         control to platform specific handler built on top of the RAS helper
    *         utilities.
    * Step 3: With the help of a Logical Secure Partition, TF-A sends a direct
    *         message to dedicated S-EL0 (or S-EL1) RAS Partition managed by SPMC.
    *         TF-A also populates a shared buffer with a data structure containing
    *         enough information (such as system registers) to identify and triage
    *         the RAS error.
    * Step 4: RAS SP generates the Common Platform Error Record (CPER) and shares
    *         it with normal world firmware and/or OS kernel through a reserved
    *         buffer memory.
    * Step 5: RAS SP responds to the direct message with information necessary for
    *         TF-A to notify the OS kernel.
    * Step 6: Consequently, TF-A dispatches an SDEI event to notify the OS kernel
    *         about the CPER records for further logging.
    */

According to the note, RAS SP (Secure Partition) is the black box where the RAS
event raised by tf-a is turned to CPER. Unfortunately, I didn't find the source
code to understand the details yet.

Thanks,
Gavin


