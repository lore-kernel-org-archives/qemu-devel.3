Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4862DC48BC4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 20:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbRGQ-0003an-Tr; Sat, 17 Feb 2024 15:26:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbRGO-0003a2-TJ
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 15:26:20 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbRGN-0006Fw-Cl
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 15:26:20 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e09493eb8eso3287346b3a.1
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 12:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708201578; x=1708806378; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cA7FofOkOnyL2EvS3eskag5Zo52kKVfyrlF9Qu/N58U=;
 b=i4imeMe6pIQvYJIJIKUJU+Z2KfZ4xLSn8bq8ews8Rgz5pJFJBgS4yWzmgKIPKrILwB
 t25dlSrZawggvXA7sE/vZAr8YqE1ogiDULHuv54RIO19BVPXO4+yi1vLgTnWWQSxc+63
 BSo/8VoN67db+qAvM34iUv9yjd+wnHmu6eNLP9CncQxDsPydjg7vQPw5zkjPX8OYX+io
 A1j2Cu1G08vpHdMXdmPZoHwfp5DeLCmDiqaDPe9bMN1J69TKO4iOuSkPLguyKUT7FwTe
 8Z2sInzo+7GcLWm5577pE/Qd7efBALeoCXgXnYv+/7jar7OyKeDzsS275K5/Y/PwxYXF
 kkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708201578; x=1708806378;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cA7FofOkOnyL2EvS3eskag5Zo52kKVfyrlF9Qu/N58U=;
 b=Z1rl9pUyw5s/F7g7F72QUZVkrX3DLTLh732ODqR4nQeUMzPvWICCV2e58H83ipo1tu
 FiyasVchorcVlFXjVPFlE7ov0rvwGtST+FzIZoWsZbbgweeMuzTxBj9pD2/zr9VGIm+f
 ShFkdG/8IDDLhyRxVQq8cZpYEKB7cVtzGkFEPHjGZOwj5J8+MHfXH0O1d7lhr1LqfH3/
 byydVuHvOKoHCO21gqRFthW5vWqh7EliR9nW6NZzWYBmc1BpsySNcNaju9CbBf3Fnfvq
 m+dW6VatHus7VJrOVwMST9Hg6rs2ayV0Wrzy4sfvrnUEnj6YXIoeP7G9OShe6JAUSwx7
 gQCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPDYvqxAntMzfzHu3LXKeZwAly/E3EukF9W4pJqmjn7ZO+1lPoQp9GjyyEOWqyzL02RD0jR00Kj94WCtrs7hTxzb2WYoc=
X-Gm-Message-State: AOJu0YykYeWwFrQM/J+Y0rcI0KNRstXXAQK+Gy8Ew38M8FBQNkl/bghu
 fVFu/hz6kKn3e+J3jcBTnofGPq+L/lkC4bRxBqZ1PkNQ57naWm3w/bhcrhsbCog=
X-Google-Smtp-Source: AGHT+IHYDRxCYKpi5yUdRhmrhUrcYXWbamDlWQMfdMU240pn0WHZsGX4agKKHZCTJmEcqFhMYhYaVQ==
X-Received: by 2002:a05:6a20:6d07:b0:1a0:73e2:f31a with SMTP id
 fv7-20020a056a206d0700b001a073e2f31amr8510427pzb.19.1708201577938; 
 Sat, 17 Feb 2024 12:26:17 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 t4-20020a62d144000000b006e3b868b8b8sm738940pfl.130.2024.02.17.12.26.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 12:26:17 -0800 (PST)
Message-ID: <e283e0bb-731f-482e-a529-f4c775e794fa@linaro.org>
Date: Sat, 17 Feb 2024 10:26:13 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/11] {linux,bsd}-user: Pass pid to fork_end()
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>,
 Warner Losh <imp@bsdimp.com>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240216130817.369377-1-iii@linux.ibm.com>
 <20240216130817.369377-5-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240216130817.369377-5-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/16/24 03:05, Ilya Leoshkevich wrote:
> diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
> index c63ef45fc78..9014014d920 100644
> --- a/linux-user/user-internals.h
> +++ b/linux-user/user-internals.h
> @@ -71,7 +71,7 @@ const char *target_strerror(int err);
>   int get_osversion(void);
>   void init_qemu_uname_release(void);
>   void fork_start(void);
> -void fork_end(int child);
> +void fork_end(abi_long pid);

Use pid_t.  There's nothing guest specific about the value here.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


