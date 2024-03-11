Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E7AC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 11:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjdQ7-00030V-ED; Mon, 11 Mar 2024 07:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rjdQ6-00030B-4a
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 07:02:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rjdQ3-00085Z-Ml
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 07:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710154927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YcrmkoX3+N/0pJPLUIQHW2Xm3f2KIf85wsWvCsToQIg=;
 b=gHoglenhRlcuiVGLJQ74Qf+/4at+iCuiqxF1jPRW2llxSu/44zdPUtBUEMYC4op0t9PgLH
 MwKSuBh2MuS8uRrHeFEy4Wr8N9ongrq/7O0TfYtmEegWUdToxjE3GBWA4vArXkv03CwY1l
 Fe1TKBHblUkITUc3ampKByFMTABCuJc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-fe3LavjiNE-Y3vEJaUYEgw-1; Mon, 11 Mar 2024 07:02:06 -0400
X-MC-Unique: fe3LavjiNE-Y3vEJaUYEgw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a4455ae71fcso256340366b.3
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 04:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710154925; x=1710759725;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YcrmkoX3+N/0pJPLUIQHW2Xm3f2KIf85wsWvCsToQIg=;
 b=Jo8wdIFMsncdT08hNuo0sYi8s1+zqwqIf6tw0BxXocdY+ifDJr3qzCU7rUQZCusz7J
 qi8daMsCm+cRt6VAN+Z71mEHcGqXcC9u0fGn4kVUwm+Dxchpt7B3etxPt1QYAyaEeqG3
 KanXT3Cgxo07nYKGNTO2veYdzN9HWBKTm16WLDlPL0A00cihR1YxBfnzBlhx4/B3xRbl
 zH4vebjF9k9YhVLZFmW7aQwrByP8CCw9ziYccusvuMRtpUK80nu81FB6Fb0SAnqf4/1X
 GgfkiWxzl5D7qag5uaoEtM8A2fSYZ8DWp7sd8OZkFq16aZsZVRRmcioOah4Dv9w4bwKm
 dYJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSSYXvG1VtP7CVc+EYYWofCvxvES4MoRsdociQC3TI8bWjTrgRiiLdN4K0rvAKRcv5lXArZhma+Zbo3/k6n38a4OLHZkc=
X-Gm-Message-State: AOJu0YwwpJ1lKSSomeJl3tW3IELgPw7/UW85/EtTaNB8B4h9i3ayf9Fa
 y1N6iIQpVSQkYsRaTqHVF3uisk3sHrYo51lPgJMI4mverwZF97iazXqmMGUsqDTtosikm3wEijm
 TGYGZxZMFEILe9LMCher4/Jhf394/43BcmMTki6ciqNKgbG3pLS7F
X-Received: by 2002:a17:907:a091:b0:a45:f24a:7df8 with SMTP id
 hu17-20020a170907a09100b00a45f24a7df8mr4469879ejc.27.1710154924461; 
 Mon, 11 Mar 2024 04:02:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHajrIRhlp0YBdqH+M8yC9/w3+3UJ+pC1En80HDf8+oANf/9KvNLabpnVBy7IXqSKE/ys/S+w==
X-Received: by 2002:a17:907:a091:b0:a45:f24a:7df8 with SMTP id
 hu17-20020a170907a09100b00a45f24a7df8mr4469860ejc.27.1710154924115; 
 Mon, 11 Mar 2024 04:02:04 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-178-151.web.vodafone.de.
 [109.43.178.151]) by smtp.gmail.com with ESMTPSA id
 bo14-20020a170906d04e00b00a454438091fsm2733249ejb.70.2024.03.11.04.02.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 04:02:03 -0700 (PDT)
Message-ID: <9db53a92-42bd-4bd4-9b68-31b923f7fc9c@redhat.com>
Date: Mon, 11 Mar 2024 12:02:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 26/29] disas: introduce show_opcodes
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20240306144041.3787188-1-alex.bennee@linaro.org>
 <20240306144041.3787188-27-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240306144041.3787188-27-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 06/03/2024 15.40, Alex Bennée wrote:
> For plugins we don't expect the raw opcodes in the disassembly. We
> already deal with this by hand crafting our capstone call but for
> other diassemblers we need a flag. Introduce show_opcodes which
> defaults to off.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20240305121005.3528075-27-alex.bennee@linaro.org>
> 
> diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
> index 2324f6b1a46..b26867b6417 100644
> --- a/include/disas/dis-asm.h
> +++ b/include/disas/dis-asm.h
> @@ -396,6 +396,14 @@ typedef struct disassemble_info {
>     /* Command line options specific to the target disassembler.  */
>     char * disassembler_options;
>   
> +  /*
> +   * When true instruct the disassembler it may preface the
> +   * disassembly with the opcodes values if it wants to. This is
> +   * mainly for the benefit of the plugin interface which doesn't want
> +   * that.
> +   */
> +  bool show_opcodes;
> +
>     /* Field intended to be used by targets in any way they deem suitable.  */
>     void *target_info;
>   
> diff --git a/disas/disas.c b/disas/disas.c
> index 0d2d06c2ecc..17170d291ec 100644
> --- a/disas/disas.c
> +++ b/disas/disas.c
> @@ -299,6 +299,7 @@ void disas(FILE *out, const void *code, size_t size)
>       s.info.buffer = code;
>       s.info.buffer_vma = (uintptr_t)code;
>       s.info.buffer_length = size;
> +    s.info.show_opcodes = true;
>   
>       if (s.info.cap_arch >= 0 && cap_disas_host(&s.info, code, size)) {
>           return;

I know it's too late now for a patch review, but anyway: What about the 
other spots that set up a "CPUDebug" struct? Like monitor_disas() or 
target_disas() ? Shouldn't we initialize the new struct member there, too?

  Thomas


