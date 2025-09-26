Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE7DCAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 13:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v28E1-0006Wz-BO; Fri, 26 Sep 2025 09:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v28Dz-0006WI-ET
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:10:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v28Du-00031x-Lw
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758892246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ju5qsI4f2mIwBOaEFaGzRPuA+18bVAwOySNET4AGR7Y=;
 b=DyPWtzkx5OYQ5XEa7WdaLgu/z66//at9LbPTBExBUsuTaXAC/mxL8MTcI0ZD9dnGfYnpY7
 GHZge/kwtmsl+kBtgXqimPgHejJ6mr7eaC2bW5BDHJqqc48XkiQWaCcbVMR/hcSwVTnjpS
 xse7YuXu44SoWqs/P15f4T3vFmdJfaU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-7-_Q_B_UN7m6TDMLOMgXHQ-1; Fri, 26 Sep 2025 09:10:44 -0400
X-MC-Unique: 7-_Q_B_UN7m6TDMLOMgXHQ-1
X-Mimecast-MFC-AGG-ID: 7-_Q_B_UN7m6TDMLOMgXHQ_1758892243
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e39567579so6600205e9.0
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 06:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758892243; x=1759497043;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ju5qsI4f2mIwBOaEFaGzRPuA+18bVAwOySNET4AGR7Y=;
 b=xRBbylWHE7OoFJVecSpxCHCCS9jP3+OjsLq/Vf1Pes8xdZmSlkVNX11aDxzfqB6VZK
 tJqyOMq57fQPMTZB3I3tGs/t6onGb2obCX2m8E8Wp5msqA/RHOfe2ALsLds7Yb380b29
 eAVrrYPWQgoQpDvM5R+31pnUZU8j/QwY40LTLC4sZHiXQ3kUMCRBpAfOuc8yevb4M+44
 aVL35uEmK+VDx7yhq2HecRdGTGXCxZNFnb6+yhitGRJC05kTxHpnxYAmi/V1S9sXsJVr
 ZtYvqPvy797bZ1aTbhgRtc6CunrzaZBLsSeVo65gcYMxP8hD2IGVCTJp2UzmdfBBDz1l
 Z/9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXC09bXRlF7Q2+fRU7wFcn8Mysi7cxaYxcUyP6qUTiQIDcSjYs888JsWU48/1Lq7kJHSkrovpoLQFY@nongnu.org
X-Gm-Message-State: AOJu0YzwivdXIYxy3kSYaljFRcBXsNeuqmDxVOlLTohAkwLDAfLIX2I3
 v+RmCbkEh5kcrtC788mTMbOVKNA6p5ae5Wjd1fXlv1pgz6a19YR6DG+QPK+A828rsssUpLSnNSs
 hp1cV1liupr7bhrrieWBw6+jIlsPg6RdsiVE4dmkYReyV/D1LgQ+Ienwq
X-Gm-Gg: ASbGncs0OIBRbHnrxbuvMW89bkyqNi4H5yeM2j0VH5oFryRuBj5roF2rjM2C4T0YDvT
 9Edw5TxI7qTsYv2J5kU6RrDGgd+Jk8xGT/YwOVgv3Po7cqybKOEpJ9jLv0jha0auglHXmAhrd5w
 hdL+9wsKbFIRKgk8m5wLdkRulK5kDQwWKzOvkBHME1R78YDvTqXJVUKbZcKjYcGwCokaD5xUzgR
 9ar3YSvHIM1LvT+iNhKaTnNX+DSQgWNvQOV73IsSi6W7Y3+0uWtGd/od1A/VmF6YgYo9EoE3iIv
 MqKyY9cTWXR3vD4oe9oG0gycDG82SGQwHzdTU104n2rDEWWtzSuP6+LzPQA2cfFl5UZp19Ym60/
 VO7fsOg==
X-Received: by 2002:a05:600c:4683:b0:45d:e28c:875a with SMTP id
 5b1f17b1804b1-46e32a16bafmr79452725e9.31.1758892243279; 
 Fri, 26 Sep 2025 06:10:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+nJ5B3CS2yFUSysgmxWtpIwN8F2PdDew9JgHs42OYukMqqHx+6WMM3fXlO1R+TP39sw0ylg==
X-Received: by 2002:a05:600c:4683:b0:45d:e28c:875a with SMTP id
 5b1f17b1804b1-46e32a16bafmr79452085e9.31.1758892242686; 
 Fri, 26 Sep 2025 06:10:42 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-212.pools.arcor-ip.net.
 [47.64.114.212]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab31bdesm115117555e9.11.2025.09.26.06.10.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 06:10:42 -0700 (PDT)
Message-ID: <5cedde08-278d-4803-b071-a7a5151f9b2f@redhat.com>
Date: Fri, 26 Sep 2025 15:10:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 19/28] pc-bios/s390-ccw: Add signature verification for
 secure IPL in audit mode
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-20-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250917232131.495848-20-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Enable secure IPL in audit mode, which performs signature verification,
> but any error does not terminate the boot process. Only warnings will be
> logged to the console instead.
> 
> Add a comp_len variable to store the length of a segment in
> zipl_load_segment. comp_len variable is necessary to store the
> calculated segment length and is used during signature verification.
> Return the length on success, or a negative return code on failure.
> 
> Secure IPL in audit mode requires at least one certificate provided in
> the key store along with necessary facilities (Secure IPL Facility,
> Certificate Store Facility and secure IPL extension support).
> 
> Note: Secure IPL in audit mode is implemented for the SCSI scheme of
> virtio-blk/virtio-scsi devices.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   docs/system/s390x/secure-ipl.rst |  36 +++
>   pc-bios/s390-ccw/Makefile        |   3 +-
>   pc-bios/s390-ccw/bootmap.c       |  39 +++-
>   pc-bios/s390-ccw/bootmap.h       |  11 +
>   pc-bios/s390-ccw/main.c          |   9 +
>   pc-bios/s390-ccw/s390-ccw.h      |  15 ++
>   pc-bios/s390-ccw/sclp.c          |  44 ++++
>   pc-bios/s390-ccw/sclp.h          |   6 +
>   pc-bios/s390-ccw/secure-ipl.c    | 371 +++++++++++++++++++++++++++++++
>   pc-bios/s390-ccw/secure-ipl.h    |  99 +++++++++
>   10 files changed, 630 insertions(+), 3 deletions(-)
>   create mode 100644 pc-bios/s390-ccw/secure-ipl.c
>   create mode 100644 pc-bios/s390-ccw/secure-ipl.h
> 
> diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
> index 92c1bb2153..701594b9de 100644
> --- a/docs/system/s390x/secure-ipl.rst
> +++ b/docs/system/s390x/secure-ipl.rst
> @@ -19,3 +19,39 @@ Note: certificate files must have a .pem extension.
>       qemu-system-s390x -machine s390-ccw-virtio, \
>                                  boot-certs.0.path=/.../qemu/certs, \
>                                  boot-certs.1.path=/another/path/cert.pem ...
> +
> +
> +IPL Modes
> +=========
> +
> +The concept of IPL Modes are introduced to differentiate between the IPL configurations.

This is not a commit description, but documentation that persists, so "are 
introduced" sounds wrong here.

Maybe rather something like:

Multiple IPL modes are available to differentiate between the various IPL 
configurations.

?

> +These modes are mutually exclusive and enabled based on the ``boot-certs`` option on the
> +QEMU command line.
> +
> +Normal Mode
> +-----------
> +
> +The absence of certificates will attempt to IPL a guest without secure IPL operations.
> +No checks are performed, and no warnings/errors are reported. This is the default mode.
> +
> +Configuration:
> +
> +.. code-block:: shell
> +
> +    qemu-system-s390x -machine s390-ccw-virtio ...
> +
> +Audit Mode
> +----------
> +
> +With *only* the presence of certificates in the store, it is assumed that secure
> +boot operations should be performed with errors reported as warnings. As such,
> +the secure IPL operations will be performed, and any errors that stem from these
> +operations will report a warning via the SCLP console.

"errors ... will report a warning" sounds weird. maybe rather: "errors ... 
will result in a warning" ?

...
> diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
> index 95943441d3..90fd530256 100644
> --- a/pc-bios/s390-ccw/bootmap.h
> +++ b/pc-bios/s390-ccw/bootmap.h
> @@ -88,9 +88,18 @@ typedef struct BootMapTable {
>       BootMapPointer entry[];
>   } __attribute__ ((packed)) BootMapTable;
>   
> +#define DER_SIGNATURE_FORMAT 1
> +
> +typedef struct SignatureInformation {
> +    uint8_t format;
> +    uint8_t reserved[3];
> +    uint32_t sig_len;
> +} __attribute__((packed)) SignatureInformation;

Everything is naturally aligned, no need to use packed here.

  Thomas


