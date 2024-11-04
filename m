Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D78ED1CA05
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 22:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t85WN-0007XJ-4I; Mon, 04 Nov 2024 17:26:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t85WI-0007W5-Qb
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 17:25:59 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t85WH-0004Ex-BV
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 17:25:58 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7e6cbf6cd1dso3239145a12.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 14:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730759156; x=1731363956; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8d/M6x9zR1J4HYPz/dOy4abj4FJistXEZlQxhXgtaUM=;
 b=IoVEsvUrbjwmigj4OqUqWTwp0J7Azi0a3i6Ln+i2saFzwS9M2qp9qNTFbLfvk92vkP
 GObsW3GM44ixxJAinOkzXDnYECeqZJrZMh6Av23Erm66AWtzqdpIrE5hjxgfQLgHMyPA
 zXGm0K/o4cBl8/U3i8Cojd+dgXmRADB1Ha4uCtAWIR1/8R38RhQ+eTCZr/mpE9rTpwP+
 atqxYrBXOb9fS3SBP/Qss/AmKpGUzgM8ibc43eFHbTSTacM1Zi9zsymMeQEAEPERRvXd
 67VmIRCyrGxP9YLhEWwyBOUO31zCvuBmGvVWpbsWNBF5V7CyXV9f4AbDj9wyRE/QaJv9
 /ZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730759156; x=1731363956;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8d/M6x9zR1J4HYPz/dOy4abj4FJistXEZlQxhXgtaUM=;
 b=IWtGCCXJuDzsXdJbd3AVMQLdawohKGHiTRA9b24BY9MyJ0yFhRFSn5BOo4BgD1Rkkp
 AHVbzwlZVxdYGtHC7mDjWG6hr4i1+jZvej4ulP5JmUq9R37BJc1jkHkcwZM+IkjUTl7m
 3h7XlgIx8g/PWNc5ZBJse3G2fglDNUXiz644ZEaOKgjj5dFiCqnIGL7ozco/+rPMfNGK
 B+PBmFhIJMvSftcqczDlKW3QHwTFl9okpcHQ/8Z5hcgtjT7MzS1Nqq+vVyDnwXlgRWlp
 AOzcJDVgiBF3R5a6KKTi8tdEpyzS5Z+mPibemjvMFKO7cxJ+9iwtD5drnmYUe7F49H4L
 WmFA==
X-Gm-Message-State: AOJu0Yz/RoQVcju9d4M5S7VCH2vkSpkZVn4yfEwmzyUIVWyfvVBvN0eE
 /xZGHubcTvpbbr6azTXg+6myDfFdROUoc/ogs9o/CWBitl8ovqB9jBQ72c1vw5F4QvU9/puFBai
 MY7OTlw==
X-Google-Smtp-Source: AGHT+IHNqoQqS0uc0wLbJndiNWktVD5ac2ANP6pD8NeJm0eJFR7VnwI1akyJdyyupvXnHgh+q5++JQ==
X-Received: by 2002:a17:90b:3882:b0:2da:8730:5683 with SMTP id
 98e67ed59e1d1-2e92cf549c5mr22956739a91.39.1730759155777; 
 Mon, 04 Nov 2024 14:25:55 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e92fa24ad2sm10613440a91.14.2024.11.04.14.25.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 14:25:55 -0800 (PST)
Message-ID: <35b9d77f-b68e-4ffa-a808-9f7af03a57df@linaro.org>
Date: Mon, 4 Nov 2024 14:25:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] target/i386: fix hang when using slow path for
 ptw_setl
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241025175857.2554252-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241025175857.2554252-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x533.google.com
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

Hi,

On 10/25/24 10:58, Pierrick Bouvier wrote:
> Most of the details are available in first patch. Second one is there to ensure
> we'll have a useful error message if start_exclusive is called from cpu_exec
> again.
> 
> I'm a bit puzzled that we never triggered this hang before. Is there something
> wrong with the potential slow path for ptw_setl, or is it simply very uncommon?
> 
> v2:
> - get current cpu from local variable instead of current_cpu global var.
> - change condition to check cpu is running as current_cpu will never be NULL.
> 
> Pierrick Bouvier (2):
>    target/i386: fix hang when using slow path for ptw_setl
>    cpu: ensure we don't call start_exclusive from cpu_exec
> 
>   cpu-common.c                         | 3 +++
>   target/i386/tcg/sysemu/excp_helper.c | 5 +++++
>   2 files changed, 8 insertions(+)
> 

Gentle ping. Could this series be pulled by someone for 9.2?

Thanks,
Pierrick

