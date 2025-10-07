Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FFACCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 11:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6649-00089P-6E; Tue, 07 Oct 2025 07:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v663x-00085l-TY
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:41:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v663q-0008QH-Va
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759837250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zOKl1RQ2EX+gjJMc3IMJ/gm6DDUCfLcxX/OKXkdbv7U=;
 b=J8w6ZQcabExoIr9wrM+z1jd+Pc1WKTBObaDWGrQtqaGLkH1bY3xbcZlwX4faciURd0md16
 bhsCPFqZ+3d7KzGGXXYm09E8IqKOSsBzorV/63gMsCH4VPaimY9OWGoT2e1BvXv6taqRrq
 GUtCVW1OdpOASD2bb/Dwgp++/k0SotE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-gEhdXGA-OGasldTk9kRURg-1; Tue, 07 Oct 2025 07:40:49 -0400
X-MC-Unique: gEhdXGA-OGasldTk9kRURg-1
X-Mimecast-MFC-AGG-ID: gEhdXGA-OGasldTk9kRURg_1759837248
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3f384f10762so3174010f8f.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 04:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759837248; x=1760442048;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zOKl1RQ2EX+gjJMc3IMJ/gm6DDUCfLcxX/OKXkdbv7U=;
 b=lko4rf6vPSix5R9VAw61Ypdb5P1FwY+vio7a/pebfjqxDfma1DiyAyrJzOUBeOugKI
 Yju5gW3J/dKO+rSye/PCKNIzK8Oxm1K6Z1J/jZ+Xs4SGzHMu2JDmwHDnYF/CQ+HEfOTS
 TT4rqKSpOuB2jaYIxzTV8FIpiZLCUoZBM5/iFTIkFSnnape3mzALGzt5P5JAglHGfHHY
 FP+2PKtPCZupFs1kOoym5Ox1UcjWamzk1JGQnOqFi9cGHD9dTYP1h+dY/Ffb8PCFhhP1
 frJy5BNcbaavQZrB8C1Vugjdt85Cxv/dQFlJ18Xaa41Zq3Ri6N0JPcdJ7oayknOmpAZw
 hW/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKqX7QeTTsFZQ+djROwNIr08Xvim+scaS0EZ9V9lPL1Ai5w2+ujw7oSr5vhlgGpS45xoe4kgJ4qZ+8@nongnu.org
X-Gm-Message-State: AOJu0YwgSXuF1p/GB47S4qh0KF8NFLWIK67lY8SaS6dOMTHoqfr5tnTp
 beRNRQXbLlrbtXABpAC5Uo4nlNtD5zqpcd0xO+DvzZcqDZ7vR4Q2/g/JKGA6m7tNIfvJE1a9BX9
 VUfbEnIj/eXQQAcfvvxxfxUPw24upQIv5jq7bpNRPF59e0zByaKpn18zh
X-Gm-Gg: ASbGncvFksNoWNSiKG1qIq4PD5I04CjsI0Qj/M3Zgg7DWTx57n2gAY+AAjwqyd6KVry
 Ty3rNYdG2Rsxl8mblrjjKsxxiqh3KxjNP0N+f8Rie9KQWA5yKbkCL2E/pCtmmioisDW8JWPfNvu
 fAwpTDKZGa8WY+8zvBFr9tatVuIbu24o3ha1LTPSZwo6ADDpFiUcnztfYg40iiv5LyCXXLJRHuG
 r34Xcvu6pVO+G10Z5oD6gTU89gfurEmRtLV2K8pKdDKqp4VQaX0pX18cXUnxYeJ4xrW2eoFphWF
 67Hye0DNDTz5jWN9753JoDQlF1rzkzscnCjfzXB1y2KYA+tcQ2Hzc4h+25I7Z1ycdaBM5G4=
X-Received: by 2002:a5d:5f50:0:b0:3ee:1586:6c71 with SMTP id
 ffacd0b85a97d-4256715ac93mr11263116f8f.27.1759837248192; 
 Tue, 07 Oct 2025 04:40:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvbhNFhV5Q1GyKEdBR9lQk4jZRt+D+FGxUw03xZfeoUPTnD/M+QxLL7ndOPKbrNhNJ7R8qFg==
X-Received: by 2002:a5d:5f50:0:b0:3ee:1586:6c71 with SMTP id
 ffacd0b85a97d-4256715ac93mr11263083f8f.27.1759837247730; 
 Tue, 07 Oct 2025 04:40:47 -0700 (PDT)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e980dsm27272249f8f.36.2025.10.07.04.40.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 04:40:47 -0700 (PDT)
Message-ID: <511cfa42-17f3-472e-958d-4be327e81cdb@redhat.com>
Date: Tue, 7 Oct 2025 13:40:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 27/28] docs/specs: Add secure IPL documentation
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-28-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250917232131.495848-28-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 18/09/2025 01.21, Zhuoying Cai wrote:
> Add documentation for secure IPL
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>   docs/specs/s390x-secure-ipl.rst | 53 +++++++++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
> 
> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
> index a19b976e25..8238fad30a 100644
> --- a/docs/specs/s390x-secure-ipl.rst
> +++ b/docs/specs/s390x-secure-ipl.rst
> @@ -1,5 +1,58 @@
>   .. SPDX-License-Identifier: GPL-2.0-or-later
>   
> +s390 Secure IPL
> +===============
> +
> +Secure IPL (a.k.a. secure boot) enables s390-ccw virtual machines to
> +leverage qcrypto libraries and z/Architecture emulations to verify the
> +integrity of signed kernels. The qcrypto libraries are used to perform
> +certificate validation and signature-verification, whereas the
> +z/Architecture emulations are used to ensure secure IPL data has not
> +been tampered with, convey data between QEMU and userspace, and set up
> +the relevant secure IPL data structures with verification results.
> +
> +To find out more about using this feature, see ``docs/system/s390x/secure-ipl.rst``.
> +
> +Note that "userspace" will refer to the s390-ccw BIOS unless stated
> +otherwise.
> +
> +Both QEMU and userspace work in tandem to perform secure IPL. The Secure
> +Loading Attributes Facility (SCLAF) is used to check the Secure Code
> +Loading Attribute Block (SCLAB) and ensure that secure IPL data has not
> +been tampered with. DIAGNOSE 'X'320' is invoked by userspace to query
> +the certificate store info and retrieve specific certificates from QEMU.
> +DIAGNOSE 'X'508' is used by userspace to leverage qcrypto libraries to
> +perform signature-verification in QEMU. Lastly, userspace generates and
> +appends an IPL Information Report Block (IIRB) at the end of the IPL
> +Parameter Block, which is used by the kernel to store signed and
> +verified entries.
> +
> +The logical steps are as follows:
> +
> +- Userspace reads data payload from disk (e.g. stage3 boot loader, kernel)
> +- Userspace checks the validity of the SCLAB
> +- Userspace invokes DIAG 508 subcode 1 and provides it the payload
> +- QEMU handles DIAG 508 request by reading the payload and retrieving the
> +  certificate store
> +- QEMU DIAG 508 utilizes qcrypto libraries to perform signature-verification on
> +  the payload, attempting with each cert in the store (until success or exhausted)

80 columns, please.

  Thanks,
   Thomas


