Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC805CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 12:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Cx0-0001sa-4s; Mon, 29 Sep 2025 08:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3Cwv-0001sC-Sp
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 08:25:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3Cwc-0008Af-2c
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 08:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759148723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=W+M5c9ydxrmi3CYb7NAhEqKIop8yDuu2vLscC2dvW+0=;
 b=MDE06x0ysj/KybLHFlftfjeISaBhX45EUbcrIyIdrwPopqrnfaHjBNUA6MC2dyz9zgJwBv
 7vMaI6l1dohO1iJkO0KAe1XuG1+sVUcZcrRX23WjbFVpgO5WT1eWIfGJEmB9Vh6Vc5X25C
 OX5dk/735DQF4dVHuxgy5M8kXtHyygk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-2guoDZ3qMNqEkUe4USEezQ-1; Mon, 29 Sep 2025 08:25:21 -0400
X-MC-Unique: 2guoDZ3qMNqEkUe4USEezQ-1
X-Mimecast-MFC-AGG-ID: 2guoDZ3qMNqEkUe4USEezQ_1759148721
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e3e177893so29355945e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 05:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759148720; x=1759753520;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W+M5c9ydxrmi3CYb7NAhEqKIop8yDuu2vLscC2dvW+0=;
 b=rGL+okB/1kHnHOIEEQWdbmCMTH62M6Bv0W3RnxnfMDTfTYO0LfCZDV692BoQx2B2aq
 Te3sY8iegVRL9nWTCGOhunfXQntWW2tVC6S569cCEBE3NT1R5PDnBsdy9Dpe3KRswqRV
 aaRIph7OpSv615YforKvSzmiy544EHkZRqiP4/wzoS4ZkeqfyLpX4TRJ1dsfIbVKNvdJ
 ucLVTpnsvHw8/mQ6MVjhg26nokNiEn+f9f/70ZLQaOOFBXi3EpeoawSBHo++6KEDbi9y
 3iso8K6Klfx+hFMEITr9B7AMDbDAcdLcD6LW9mKrw25jR0mFHCuTL1XvH4+xigUKAPyt
 ZE9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/+A+SshJf2gswFX2MVwWUL3VWWfOOYibEMTj7BvAB6OxYC7NtoRXBk2eHCIJppPM9zlLb82cysqYI@nongnu.org
X-Gm-Message-State: AOJu0YzrQwW2/Ydf8MGJI3GVxRVAVuA6XvOuX+HbKaab1O0hj4ub87Q8
 bvEfs6sN+bNLc1cdttyqJblU+TWX1CxV1vGN+u5SXSV9vOsMlpzqUgtYtsP4J4uWsfnhCLvU3Li
 qmURyN0Ri5eT8mkdhSM3kq+diOg1oQ7w4gm1BPOpdw6M2CieeG1eOOLfB
X-Gm-Gg: ASbGncs3Q3McXcj7CWasD644nkvJZWZLmduw4FFeIMTUj7wej2KUGoTuin9tIcU1OAD
 ftmXKemkkQ9aHQwjqKb6JMhN/UI2wjQTn7KUfehntMrAWKTSJz2onac21Kt9G8ajOex6E/RIKwX
 ZK5+ZGNqtwScDXNG9Di/CnKa1RpgSUUoXAo0HED1svlaCOAXNbVmYWlh62qVmYsk8zkWFmVzFoj
 XED+5pxPjlO9N9nXfH8e5mPqcZFUro/vxr+0BnYoQuQ4s2jGquviWJDg9Y21IJocsQSQkJy6ZH0
 v4YPjO90CtyFpyRY9odSXA+Q0hadWIfWgTEEthkr1zl/IsdSUP5Zi5t4cTSVkFjSXBwqPFHAxaJ
 j9hJDqA==
X-Received: by 2002:a05:600c:258:b0:46e:1fb7:a1b3 with SMTP id
 5b1f17b1804b1-46e329fb7eamr136631685e9.23.1759148720583; 
 Mon, 29 Sep 2025 05:25:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExBrP61tBlAPXOnITrUreoFMUVP+Pu+ztqEcnUnRAcD6INfbo8pCMGvQcIqOe0suyS4zDIBg==
X-Received: by 2002:a05:600c:258:b0:46e:1fb7:a1b3 with SMTP id
 5b1f17b1804b1-46e329fb7eamr136631315e9.23.1759148720110; 
 Mon, 29 Sep 2025 05:25:20 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-212.pools.arcor-ip.net.
 [47.64.114.212]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e336f10f5sm87545305e9.11.2025.09.29.05.25.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 05:25:19 -0700 (PDT)
Message-ID: <ff8c93b0-5e6e-4335-9b47-c5b82ae246a0@redhat.com>
Date: Mon, 29 Sep 2025 14:25:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 20/28] s390x: Guest support for Secure-IPL Code Loading
 Attributes Facility (SCLAF)
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-21-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250917232131.495848-21-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
> The secure-IPL-code-loading-attributes facility (SCLAF)
> provides additional security during secure IPL.
> 
> Availability of SCLAF is determined by byte 136 bit 3 of the
> SCLP Read Info block.
> 
> This feature is available starting with the gen16 CPU model.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> ---
>   docs/specs/s390x-secure-ipl.rst     | 25 +++++++++++++++++++++++++
>   target/s390x/cpu_features.c         |  2 ++
>   target/s390x/cpu_features_def.h.inc |  1 +
>   target/s390x/cpu_models.c           |  3 +++
>   target/s390x/gen-features.c         |  2 ++
>   target/s390x/kvm/kvm.c              |  1 +
>   6 files changed, 34 insertions(+)
> 
> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
> index 760a066084..a19b976e25 100644
> --- a/docs/specs/s390x-secure-ipl.rst
> +++ b/docs/specs/s390x-secure-ipl.rst
> @@ -85,3 +85,28 @@ operations such as:
>   * certificate data
>   
>   The guest kernel will inspect the IIRB and build the keyring.
> +
> +
> +Secure Code Loading Attributes Facility
> +---------------------------------
> +
> +The Secure Code Loading Attributes Facility (SCLAF) enhances system security during the
> +IPL by enforcing additional verification rules.

Please wrap your text so that it fits into 80 columns.
(Not sure why checkpatch.pl is not warning here...?)

> +When SCLAF is available, its behavior depends on the IPL mode. It introduces verification
> +of both signed and unsigned components to help ensure that only authorized code is loaded
> +during the IPL process. Any errors detected by SCLAF are reported in the IIRB.
>
> +Unsigned components are restricted to load addresses at or above absolute storage address
> +``0x2000``.
> +
> +Signed components must include a Secure Code Loading Attribute Block (SCLAB), which is
> +appended at the very end of the component. The SCLAB defines security attributes for
> +handling the signed code. Specifically, it may:
> +
> +* Provide direction on how to process the rest of the component.
> +
> +* Provide further validation of information on where to load the signed binary code
> +  from the load device.
> +
> +* Specify where to start the execution of the loaded OS code.

Do you maybe want to mention any tool from s390-tools that helps with this 
task (assuming that there is one)? (or should that rather not be part of the 
specs here?)

...
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index bd2060ab93..c3e0c6ceff 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -722,6 +722,7 @@ static uint16_t full_GEN16_GA1[] = {
>       S390_FEAT_UV_FEAT_AP_INTR,
>       S390_FEAT_CERT_STORE,
>       S390_FEAT_SIPL,
> +    S390_FEAT_SCLAF,
>   };
 >
>   static uint16_t full_GEN17_GA1[] = {
> @@ -924,6 +925,7 @@ static uint16_t qemu_MAX[] = {
>       S390_FEAT_EXTENDED_LENGTH_SCCB,
>       S390_FEAT_CERT_STORE,
>       S390_FEAT_SIPL,
> +    S390_FEAT_SCLAF,
>   };

In the cover letter you wrote "All actions must be performed on a KVM guest" 
... so does this feature depend on KVM or not? If you cannot use the feature 
with TCG, I think you should not add this to the "qemu_MAX" CPU model?

  Thomas


