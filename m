Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0892C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 17:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJxgs-0004t9-KX; Tue, 27 May 2025 13:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uJxgp-0004sq-Np
 for qemu-devel@nongnu.org; Tue, 27 May 2025 13:02:11 -0400
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uJxgm-0006RT-Ac
 for qemu-devel@nongnu.org; Tue, 27 May 2025 13:02:10 -0400
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7c53b9d66fdso473650085a.3
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 10:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748365325; x=1748970125; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NSR725zoAmAGejZoxzBWoRhQeiXIOH62eyZ6vQLYQCs=;
 b=BNWg0dcpksw44RtIHkVRMWiso9OKFCYPrUcR0173E1C5tNXbB9HLPZ6r3sTnGkarD3
 KiYzXF++ZevDeTt/VtBTTPpm3ipdkKSXYUEKlbfYjCEqiumdUGGuR2ugVn369Ehpst7w
 7tYTZBD7hDX1TiQ/y+UPEgbxYZ8ITIVhjYyrRGdfkhpSGkyOyIY4FZIdhW2w7Hc79I8C
 TwYq0LjkeOxGLJ2e6h+2a9+uSx8Ss/i/sOgQvmd6d6DoVhVetUeNTWmtWeWwnn3Myu0C
 8whKEJNFYchF5MPCzBttAyuu+XBBcx2mf7o+5aJEcZJzde/OFoJ7Ki8z1N7y1j/PRe0x
 WaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748365325; x=1748970125;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NSR725zoAmAGejZoxzBWoRhQeiXIOH62eyZ6vQLYQCs=;
 b=UaFHRx6CBgfikvlEIbeCdj0Cb0uRws2rBSUWIy5TBWyJd+VwXLzKm3kzTyn3dimc+1
 FIlXXTFzfmktH+WDy0rdWRSLpO9XceE7omWA++i9iIuBCWqtpWEFygJWf43DKuURopBg
 LPne4DoWKXjsokczK+W4CAapjYMHb9R8AhAKUCjRySrPRQqof5MdMjrtoEurfo9leDVP
 QqSb633FNtjJnh+4YZTYSlnmDAiEm79TxNsfPLhMEXJL7qsZT1iMqRw3yl6v30k4fQjL
 E0GAROPTbYCPI/POjkhhJFptgXDXD6JECPqucbmLiDDn0VqYTSwGm+OgXNUvTNxGFKWL
 f4tg==
X-Gm-Message-State: AOJu0YxYHD5U3DiDdhUTpTaK1eN4avIdB5zWOzw9vxFavSwfGHjdRSV2
 NJOdqr23tzdGcprR3KntfMHbrP75ryd2/oluGO2GyqTLlqf3IL5YrqtD/Tpe6Lt/DI9qW0eEiA7
 2ykT8
X-Gm-Gg: ASbGnct0XZcTm62MuJ2hhrUyuAKjK23gm+34XcoShSTroM/qEr209R+atNtMgzg3YQb
 ygmFMA7oyJXMMdOZMk6o16ypsXMOwdhXJ1T9QfICFkVmrFCy/YmSJlcRmS25ZWetvezJljowC3Z
 7laoA7Vd8q2BNr0DOlPq6Tqz4aSefYyILCUUN9rcNcV1x7mjw/mq4e9iBaZk749ymFpRFmBsC99
 1i/D1WfTdFfJngaXAeALytmGH2b2keDoe6YpDaJMQc3fOnX5thCl3xRTwclaYJVt8DlPWLswOMq
 rTg7rInT5scOcTC9LlkeOpd8LbiT6+qXz+imVZiu2yOLdz7Lm4U6BlexOnL7/yzKgWjW3zErK8I
 =
X-Google-Smtp-Source: AGHT+IFecbQCI2fO5+VSHhBX6PHAgZARiglBQwp/kgUQMV9pXz8U8BWvIEw/iVPca10g3QoGhpcSkw==
X-Received: by 2002:a17:903:1a70:b0:234:a139:11f0 with SMTP id
 d9443c01a7336-234a13ae843mr35321395ad.7.1748364890250; 
 Tue, 27 May 2025 09:54:50 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-234a67d38e8sm11787755ad.5.2025.05.27.09.54.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 09:54:49 -0700 (PDT)
Message-ID: <7510ffa1-e84d-4d59-8733-86f913e91799@linaro.org>
Date: Tue, 27 May 2025 09:54:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/15] qapi: expand docs for SEV commands
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, thuth@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, peter.maydell@linaro.org,
 berrange@redhat.com, philmd@linaro.org
References: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
 <20250522190542.588267-3-pierrick.bouvier@linaro.org>
 <87h616qoq2.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87h616qoq2.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qk1-x72a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/27/25 4:26 AM, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> From: Daniel P. Berrangé <berrange@redhat.com>
>>
>> This gives some more context about the behaviour of the commands in
>> unsupported guest configuration or platform scenarios.
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   qapi/misc-target.json | 43 ++++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 36 insertions(+), 7 deletions(-)
>>
>> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
>> index c5f9f6be7e1..6b857efc1cc 100644
>> --- a/qapi/misc-target.json
>> +++ b/qapi/misc-target.json
>> @@ -110,7 +110,11 @@
>>   ##
>>   # @query-sev:
>>   #
>> -# Returns information about SEV
>> +# Returns information about SEV/SEV-ES/SEV-SNP.
>> +#
>> +# If unavailable due to an incompatible configuration the
>> +# returned @enabled field will be set to 'false' and the
>> +# state of all other fields is undefined.
>>   #
>>   # Returns: @SevInfo
>>   #
>> @@ -141,7 +145,16 @@
>>   ##
>>   # @query-sev-launch-measure:
>>   #
>> -# Query the SEV guest launch information.
>> +# Query the SEV/SEV-ES guest launch information.
>> +#
>> +# This is only valid on x86 machines configured with KVM and the
>> +# 'sev-guest' confidential virtualization object. The launch
> 
> Humor me, please: separate sentences with two spaces for consistency.
> 
>> +# measurement for SEV-SNP guests is only available within
>> +# the guest.
>> +#
>> +# This will return an error if the launch measurement is
>> +# unavailable, either due to an invalid guest configuration
>> +# or if the guest has not reached the required SEV state.
>>   #
>>   # Returns: The @SevLaunchMeasureInfo for the guest
>>   #
>> @@ -185,8 +198,9 @@
>>   ##
>>   # @query-sev-capabilities:
>>   #
>> -# This command is used to get the SEV capabilities, and is supported
>> -# on AMD X86 platforms only.
>> +# This command is used to get the SEV capabilities, and is only
>> +# supported on AMD X86 platforms with KVM enabled. If SEV is not
>> +# available on the platform an error will be returned.
>>   #
>>   # Returns: SevCapability objects.
>>   #
>> @@ -205,7 +219,15 @@
>>   ##
>>   # @sev-inject-launch-secret:
>>   #
>> -# This command injects a secret blob into memory of SEV guest.
>> +# This command injects a secret blob into memory of a SEV/SEV-ES guest.
>> +#
>> +# This is only valid on x86 machines configured with KVM and the
>> +# 'sev-guest' confidential virtualization object. SEV-SNP guests
>> +# do not support launch secret injection
> 
> Missing period at the end of sentence.
> 
>> +#
>> +# This will return an error if launch secret injection is not possible,
>> +# either due to an invalid guest configuration, or if the guest has not
>> +# reached the required SEV state.
> 
> Slightly long lines.  docs/devel/qapi-code-gen.rst:
> 
>      For legibility, wrap text paragraphs so every line is at most 70
>      characters long.
> 
>>   #
>>   # @packet-header: the launch secret packet header encoded in base64
>>   #
>> @@ -236,8 +258,15 @@
>>   ##
>>   # @query-sev-attestation-report:
>>   #
>> -# This command is used to get the SEV attestation report, and is
>> -# supported on AMD X86 platforms only.
>> +# This command is used to get the SEV attestation report.
>> +#
>> +# This is only valid on x86 machines configured with KVM and the
>> +# 'sev-guest' confidential virtualization object. The attestation
>> +# report for SEV-SNP guests is only available within the guest.
>> +#
>> +# This will return an error if the attestation report is
>> +# unavailable, either due to an invalid guest configuration
>> +# or if the guest has not reached the required SEV state.
>>   #
>>   # @mnonce: a random 16 bytes value encoded in base64 (it will be
>>   #     included in report)
> 

All good for me.
The only question that crossed my mind when you asked for those changes 
previously was: "Why does QAPI has it's own style, and not simply 
following the QEMU official style?"

In the end, you choose which rules apply to this subsystem, and I have 
no strong opinion on whether it should be 70, 72 or 80 characters on the 
line, or if we prefer tabs to spaces (to make some analogy). I just 
think it's surprising to have a different coding style only here for 
arbitrary reasons.

