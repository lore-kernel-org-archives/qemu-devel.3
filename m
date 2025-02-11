Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB44EC0219D
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 12:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thpVO-0002ND-Q8; Tue, 11 Feb 2025 07:36:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thpVL-0002Ja-1E
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 07:36:43 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thpVI-0001Bi-N2
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 07:36:42 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43948021a45so17718175e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 04:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739277397; x=1739882197; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YfFPeUl1Dex9j0bhhlccqnBVdmfLqQXjgVCiS1IJBLA=;
 b=IZ1iFtNBVrIDv/nCqheStqV2/T3t/5T9xKRzL/4gtOHixlUSA2qng8jbwlcgg2x6gZ
 itRVoIDGlL3RJV8QJAdC6ut41oBK5FzE9spI2zklVcr8EtIck324bzk/HSKkhnMXYzIB
 5Abazni4tSz/W8F7a/sBbZVBvXUdTeKuUQThMHRrg5crLpPijzzcXAUyi4tHsz4U1BE9
 yozA6pE13MnSMTYkZyNcX6kNlIZ9Ce4Rxo7FgyDP0jAQvvb8ockNWoHxg4VR1dX36BCB
 PpA8aHqX7t4VCMBebgbX7m1Iz+oNbfIL04bTkE06/7Y6BWNcMwFKbFh4PCOKX0/dBBvI
 y91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739277397; x=1739882197;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YfFPeUl1Dex9j0bhhlccqnBVdmfLqQXjgVCiS1IJBLA=;
 b=wBTNC2QOCt4av6JPCNgWA4FzDMZ7tTM3+VO2rkwJMr5trLxaBs9WOJ29WwZKmkKg+g
 kwvTju3hX7wmndMwuKCOy6HTQ1Y8Igbi/EGIEHWSSyv3IrcCwuYE17PK/MSD2uwCx9xM
 /ZP3CUJ7O+mAjUZt9BY5vGJJk+hqiaJk8QuhnXeR6nuf0ElsA0bjHMtEdAgmVrq2RU2Z
 4M9rl4jRQlcZbArQXrOOl59vLM9FA+YG5+koTp+6rPG3EWzDCzWwc3+/iuTHcsDAtcuD
 8krlAieb3+aRxIsk62O0hqtHpoSeEG1DaWWL/iAzMnlUwNMUvY7uXlnKTCjsmDoW3mAu
 TLcw==
X-Gm-Message-State: AOJu0YxqX5NxZ3L6o5AKeuAqB2QtyJDlrsbTHMwsrSJJMucIi9VG3SUX
 PlSmIF20sSE8RAEfDka8EuZZTp0uIOJDqihYpMSgKtN7iX/B3nZAbIAvIJs+x6w=
X-Gm-Gg: ASbGncuGQELxwOxy+QG7+n/i5+hEGqBxaNX5FsbGuJHmTbV8tMcJmCu7Ye5UpW4JKHa
 HRlI0FnBeTM7JUhrD2Ja97nThKj/eOkC3czLRlht8ihKbHBV1zmh8FC/D8p5zJ6tWXchuJqfgxv
 ggG7tugB7lgeRuEcOwAsNqXBPwPwFpxn1Xe3Ka0R+PkriFDgjIzB6Z64BoTkE/pC50VuMeSGlMR
 xtzhykkOTGeAk4gP2PP+KNCLS098XWo45oAnWJKUxf4HCqvQHvS+EP+5bp5yVkEyk9yXXTovsKE
 Y1yYHmwhoTI/4x04ZrYDD+1g9jxQHSV6pvOhg1cWTAdyYyB6fc/TQL+ru9M=
X-Google-Smtp-Source: AGHT+IFdAvYzxJyDI8regOkV2AVTvb7qFd3ZgnfM0oml24pFLYUrLBDDvBAyWfEACNFEhGwv8sy8qg==
X-Received: by 2002:a05:600c:3c87:b0:438:c18c:5ad8 with SMTP id
 5b1f17b1804b1-439249d189cmr154014655e9.31.1739277397613; 
 Tue, 11 Feb 2025 04:36:37 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439471bf782sm50157325e9.39.2025.02.11.04.36.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2025 04:36:37 -0800 (PST)
Message-ID: <a314109f-3238-4605-8fba-beaf310cd565@linaro.org>
Date: Tue, 11 Feb 2025 13:36:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab-ci.d/cirrus: Update the FreeBSD job to v14.2
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-stable@nongnu.org
References: <20250211120817.35050-1-thuth@redhat.com>
 <Z6s-0LxACyF5KWOc@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z6s-0LxACyF5KWOc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=unavailable autolearn_force=no
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

On 11/2/25 13:13, Daniel P. Berrangé wrote:
> On Tue, Feb 11, 2025 at 01:08:17PM +0100, Thomas Huth wrote:
>> The FreeBSD job started to fail since the 14-1 image disappeared
>> from the cloud. Update the job to v14.2 to fix it.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   .gitlab-ci.d/cirrus.yml | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
>> index 16411f3d2b..75b611418e 100644
>> --- a/.gitlab-ci.d/cirrus.yml
>> +++ b/.gitlab-ci.d/cirrus.yml
>> @@ -37,7 +37,7 @@ x64-freebsd-14-build:
>>       NAME: freebsd-14
>>       CIRRUS_VM_INSTANCE_TYPE: freebsd_instance
>>       CIRRUS_VM_IMAGE_SELECTOR: image_family
>> -    CIRRUS_VM_IMAGE_NAME: freebsd-14-1
>> +    CIRRUS_VM_IMAGE_NAME: freebsd-14-2
>>       CIRRUS_VM_CPUS: 8
>>       CIRRUS_VM_RAM: 8G
>>       UPDATE_COMMAND: pkg update; pkg upgrade -y
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> This needs to be merged to master immediately, and also into stable
> branches. Any old reference to 14-1 is a guaranteed failed job since
> FreeBSD deleted old images off Google Cloud

https://cirrus-ci.org/guide/FreeBSD/ still only lists 14-1...

Anyway you are right:

$ gcloud compute images list --project freebsd-org-cloud-dev 
--no-standard-images
NAME                                     PROJECT                FAMILY 
           DEPRECATED  STATUS
freebsd-13-4-release-amd64               freebsd-org-cloud-dev 
freebsd-13-4                   READY
freebsd-13-4-stable-amd64-v20250102      freebsd-org-cloud-dev 
freebsd-13-4-snap              READY
freebsd-13-4-stable-amd64-v20250109      freebsd-org-cloud-dev 
freebsd-13-4-snap              READY
freebsd-13-4-stable-amd64-v20250116      freebsd-org-cloud-dev 
freebsd-13-4-snap              READY
freebsd-13-4-stable-amd64-v20250124      freebsd-org-cloud-dev 
freebsd-13-4-snap              READY
freebsd-13-5-beta1-amd64                 freebsd-org-cloud-dev 
freebsd-13-5                   READY
freebsd-13-5-prerelease-amd64-v20250130  freebsd-org-cloud-dev 
freebsd-13-5-snap              READY
freebsd-13-5-prerelease-amd64-v20250206  freebsd-org-cloud-dev 
freebsd-13-5-snap              READY
freebsd-14-2-release-amd64-ufs           freebsd-org-cloud-dev 
freebsd-14-2                   READY
freebsd-14-2-release-amd64-ufs-gce       freebsd-org-cloud-dev 
freebsd-14-2                   READY
freebsd-14-2-stable-amd64-ufs-20250102   freebsd-org-cloud-dev 
freebsd-14-2-snap              READY
freebsd-14-2-stable-amd64-ufs-20250109   freebsd-org-cloud-dev 
freebsd-14-2-snap              READY
freebsd-14-2-stable-amd64-ufs-20250116   freebsd-org-cloud-dev 
freebsd-14-2-snap              READY
freebsd-14-2-stable-amd64-ufs-20250124   freebsd-org-cloud-dev 
freebsd-14-2-snap              READY
freebsd-14-2-stable-amd64-ufs-20250130   freebsd-org-cloud-dev 
freebsd-14-2-snap              READY
freebsd-14-2-stable-amd64-ufs-20250206   freebsd-org-cloud-dev 
freebsd-14-2-snap              READY
freebsd-15-0-current-amd64-ufs-20250102  freebsd-org-cloud-dev 
freebsd-15-0-snap              READY
freebsd-15-0-current-amd64-ufs-20250109  freebsd-org-cloud-dev 
freebsd-15-0-snap              READY
freebsd-15-0-current-amd64-ufs-20250116  freebsd-org-cloud-dev 
freebsd-15-0-snap              READY
freebsd-15-0-current-amd64-ufs-20250124  freebsd-org-cloud-dev 
freebsd-15-0-snap              READY
freebsd-15-0-current-amd64-ufs-20250130  freebsd-org-cloud-dev 
freebsd-15-0-snap              READY
freebsd-15-0-current-amd64-ufs-20250206  freebsd-org-cloud-dev 
freebsd-15-0-snap              READY

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


