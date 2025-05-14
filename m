Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1114C3ABD9
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAfu-0000HR-L5; Wed, 14 May 2025 07:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFAfE-00086N-Hy
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:52:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFAfA-0006vg-Gp
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747223559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ro1U1fcUObrd80Z56tOU0j5iAX6aRgj7l9qD79xyIR0=;
 b=WuiO3mwDxWELWnF/0ge97dxFQj5Loyra7GCtuRQQQNmv1pdyYOGA//8QtnQW/1k0YVdlFP
 ySIQTON2mpYknswMyQ0vr29pTNheKCRxKXo674OpyEjls364eOqUtbEeAsMYmmjeigozFP
 CGHp4wfxg6h3onqU7zfD7Jqc4aqvh2E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-F41azCvHMECxXUEkp_iUNQ-1; Wed, 14 May 2025 07:52:37 -0400
X-MC-Unique: F41azCvHMECxXUEkp_iUNQ-1
X-Mimecast-MFC-AGG-ID: F41azCvHMECxXUEkp_iUNQ_1747223556
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a0b7c8b3e2so4338568f8f.1
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 04:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747223556; x=1747828356;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ro1U1fcUObrd80Z56tOU0j5iAX6aRgj7l9qD79xyIR0=;
 b=j9EBXq5V1bVeOy/fx5LDrYmnPnFPKypsdhez/rWGCSOeXmnq84NWa/9JjtlZk+muEi
 +VJQmhxGC4TdV+2/KkSGCIe+aQKAkkQGDxCAmze+YNbtr2CuTykOcC3p+Xl6uAlY5ANh
 g0e60Gkh0oxulhbs98i8KYGDf/SQO8VCq225SLHxed/AFSeTHBCekD5HAEXP+BiHry9o
 0Dw0spfe9HivPobnUhPoikWwNKnDb5hV5MnRoEjlCmYVTda4PNKf7UJmxp5YX38wtPJu
 eOYIghNq5NYCrWEfozL8WUPfq4wIBfIVoh54lIrucwQ5lXq2v3cbYL/AX2vjSOkMqK8Y
 SpEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmp+WCUhPOjBAygkrkdxreARDRdM5rqnVhf8Tg/yFvXFaK0CYcFYdnwTwhj8fTEip63LkgjJWs/udp@nongnu.org
X-Gm-Message-State: AOJu0YwHre88/FRUuQI+PzTfVtaDfCgVMnxiWdi/YIFUnyaV6EDUSwfd
 ET5i0PeSxxsjeatOCSh48G473g5zfmM9tiWn5vxyEP7Tx5w1JKxpy288zCoX7DMAw1NWbfzo1q2
 fD7asEQCjIN8O32UF/JOrjc4bTf++KBACC5ooK1PYAWU4jYsy7ohy
X-Gm-Gg: ASbGnctBy086Ccm0VHWhtoxQKCIoBOggq2cBl1CCY2vN0lcQ2M0Ns9EF8kMT3fwSEXO
 TiPZUHRI6kQBH1lK2CcXPnCyywsMVBx5IqLkbSGwyohlRWcLdPSqGIhWexhNltmwRWJ1GS9f4j/
 uIEjBFpRwyvobNLj+PI1zbsO9TuFzRFaWGV39fH6gROccKki+C4VTWBLmzB/RwqhFgkeCWyD1yS
 jrdyyGQcNk2sGC+YnMn75f5g+EZPMP7N459Htdx+EGvLskOBNP7qPEbZ7bjYVY68GFU11JTinfi
 qy8/9UUW6KbnKOicn2ueBLdS1bAw6xRU/tDUU1FebtTWiDEXVA==
X-Received: by 2002:a5d:588d:0:b0:3a2:38e:c0b0 with SMTP id
 ffacd0b85a97d-3a349922514mr2863559f8f.45.1747223556533; 
 Wed, 14 May 2025 04:52:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQbm/SfZMIirrf9QOlsCXGDQbx5GYkbSfQHSB/kHkrQRMAwwSQhrZB9ky0z6xCImsXAv7rVA==
X-Received: by 2002:a5d:588d:0:b0:3a2:38e:c0b0 with SMTP id
 ffacd0b85a97d-3a349922514mr2863533f8f.45.1747223556177; 
 Wed, 14 May 2025 04:52:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a2cf0esm19567906f8f.79.2025.05.14.04.52.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 04:52:35 -0700 (PDT)
Message-ID: <7e471ac0-7d8e-47a5-8249-24134261837d@redhat.com>
Date: Wed, 14 May 2025 13:52:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] scripts/checkpatch: use new hook for file
 permissions check
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20250512182447.1139105-1-berrange@redhat.com>
 <20250512182447.1139105-6-berrange@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250512182447.1139105-6-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

On 5/12/25 20:24, Daniel P. Berrangé wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> The file permissions check is the kind of check intended to be performed
> in the new start of file hook.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   scripts/checkpatch.pl | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 6a7b543ddf..4a18daa384 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1447,6 +1447,17 @@ sub process_file_list {
>   # Called at the start of processing a diff hunk for a file
>   sub process_start_of_file {
>   	my $fileinfo = shift;
> +
> +	# Check for incorrect file permissions
> +	if ($fileinfo->{action} eq "new" && ($fileinfo->{mode} & 0111)) {
> +		my $permhere = $fileinfo->{linestart} . "FILE: " .
> +			$fileinfo->{filenew} . "\n";
> +		if ($fileinfo->{filenew} =~
> +		    /(\bMakefile(?:\.objs)?|\.(c|cc|cpp|h|mak|s|S))$/) {
> +			ERROR("do not set execute permissions for source " .
> +			      "files\n" . $permhere);
> +		}
> +	}
>   }
>   
>   # Called at the end of processing a diff hunk for a file
> @@ -1718,14 +1729,6 @@ sub process {
>   
>   		$cnt_lines++ if ($realcnt != 0);
>   
> -# Check for incorrect file permissions
> -		if ($line =~ /^new (file )?mode.*[7531]\d{0,2}$/) {
> -			my $permhere = $here . "FILE: $realfile\n";
> -			if ($realfile =~ /(\bMakefile(?:\.objs)?|\.c|\.cc|\.cpp|\.h|\.mak|\.[sS])$/) {
> -				ERROR("do not set execute permissions for source files\n" . $permhere);
> -			}
> -		}
> -
>   # Only allow Python 3 interpreter
>   		if ($realline == 1 &&
>   			$line =~ /^\+#!\ *\/usr\/bin\/(?:env )?python$/) {


