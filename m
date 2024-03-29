Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66F4C6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 12:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqBVB-00036w-1a; Fri, 29 Mar 2024 08:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rqBV9-00036C-DV
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 08:38:31 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rqBV7-0007Tq-R1
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 08:38:31 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56829f41f81so2847027a12.2
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 05:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711715907; x=1712320707; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aLuIl1Io3Rxhi7dJtkMtdk0V36SxwD6HE6larTVUbc8=;
 b=kf2uxEm2A11yz78G2b+a1IQqMOqsp+83c3htD+mBtfFQ3Gdurc3skPipsT13Va/dEl
 ywii4sLmqJZ95eQdeaDfpIe54ZpqkEGnJFJSzno+EaJKRf2HiNXtExodS3tdK0AfVDQW
 rOG6XSmWeDax68QoiEanIPZKEpc+1traN0Kiu6de7GEBFO++ZnnH3bVxio3rvK8xAbs7
 DLhFot4opiekf6bnyrWrt+hC6HcAHJ+ZytbOcAvpqLoQ5ahaflQn+DMSbahi7+wN/kA2
 4/StMPqImrzEWmrbc42d8hSUhA17fo34Tqs0zYdsms5LW1rDTk7KyeODhFKxKiN/EGCF
 887Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711715907; x=1712320707;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aLuIl1Io3Rxhi7dJtkMtdk0V36SxwD6HE6larTVUbc8=;
 b=MhQHhlaugcTLJrWxPY2x48qTcOlnxtyVZB3s5krOt0znGy826J1akIGImPhyLA7GpR
 IUZ0dAzJ+ltz0pP6MTBRND6lYpyb3sMlUCcydPTv0mshJwA31WrkaRDn3M1ev/h85pEL
 InlUWfE5/ZGzKI+NM40qOWMh5UU5ICcsTY5SiV/K05C9e6qY1EzZ8BKhvcOzUVRqf9yF
 +a9TaU1ldWNOO6n7uZYmgkN4g+WDFHGm2LxFylHBGzdNjdxIYdEQFYeI5ZjRsU5QF879
 DNrb31+GsRxUsai40afswI05xT4iwyZQOD+gwiMz+SPza6upx8ffWNdt3CRhVhmy8WMk
 fAmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvmPZTcA/5RWpIL1CUICWfJlpecGchtb+MgZZMdcqM0YecWZHK0oJFJkywd8To8oxBqmYqhV1QJcBOn9pNu3f2wOtSUdg=
X-Gm-Message-State: AOJu0Yx0CKBNQamOp6IWU8d81jiWo9sMb9twQgK61JGlabq0U4SbWBU8
 lxAlnqMS491QT1g8fOweO+NJ8NUobXDRfsqRZa0TyoPggpReITouZCzn0W+HViM=
X-Google-Smtp-Source: AGHT+IGM7A6aec4Mw35WJsfUuA6EgT8+N1idZfOF/XSBTsdwHoR7k6/bY7pRT5KBv4Y03+1nG3OLuA==
X-Received: by 2002:a17:906:db04:b0:a4e:2b9e:5b73 with SMTP id
 xj4-20020a170906db0400b00a4e2b9e5b73mr1529623ejb.49.1711715907604; 
 Fri, 29 Mar 2024 05:38:27 -0700 (PDT)
Received: from [192.168.69.100] (uni14-h01-176-184-39-242.dsl.sta.abo.bbox.fr.
 [176.184.39.242]) by smtp.gmail.com with ESMTPSA id
 w20-20020a170906481400b00a46aab70226sm1881293ejq.180.2024.03.29.05.38.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Mar 2024 05:38:26 -0700 (PDT)
Message-ID: <b70a3345-0e68-4e2d-888a-10c0922f07dd@linaro.org>
Date: Fri, 29 Mar 2024 13:38:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spapr: nested: use bitwise NOT operator for flags check
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, npiggin@gmail.com,
 qemu-ppc@nongnu.org
Cc: mikey@neuling.org, danielhb413@gmail.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
References: <20240329043436.2857533-1-harshpb@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240329043436.2857533-1-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

On 29/3/24 05:34, Harsh Prateek Bora wrote:
> Check for flag bit in H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE need to use
> bitwise NOT operator to ensure no other flag bits are set.
> Reported by Coverity as CID 1540008, 1540009.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>   hw/ppc/spapr_nested.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



