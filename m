Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF630F4181F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzeGB-0002nE-M3; Mon, 09 Mar 2026 13:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vzeFg-0002Zy-Ui
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:18:54 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vzeFc-00063u-Mg
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:18:43 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-82984c077b2so2071400b3a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 10:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773076719; x=1773681519; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1SHZVk1p5DXSxoc1YpVBT7c4rDwJos0l3tnRPrksqR0=;
 b=jzDfymFSRkRfhqLcNgIVgZpoKaNUFBGByRMkoX6SSbPiEWqACabeczhyWkLCPlj0Jf
 sKoDXCllQhtx+/aL+PaclIpTboVRJj3chE3Lac4vtaepgT/YYd2ewvDz5uAtUQedeQIS
 TTf8xenzsUaGjJZbmu4SQffMC2URwyMLVakR+ZIbONocjoBY7ExBrrMpsB87FiQzacKe
 Kvh1NEOPJDuH8gHfBimyaymtjxjWcbsI9YrDd0gDZ+xC7m95cKBfpeZLphUMZcZgZwsn
 vlSYUwfP3O4ut5aB9/O/6etKyGVFCNYmh3T/aVNRo+sXhv7897zXrVCI7/3F2fBWSMlA
 qKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773076719; x=1773681519;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1SHZVk1p5DXSxoc1YpVBT7c4rDwJos0l3tnRPrksqR0=;
 b=DUI36yl8JkofwRfbWs9sjIFaGhSvAvrY/qqxJxoV0xK5AotGFTGttjkLySjHTEwmAP
 U0sHMqFtFfEV72XA5rXhxwsKNv4VHmOkrBuwOfME1h/J41oOArnY7kJE3kr7sb6tmOnh
 sdyKNNFE+3QswJ4anbFGTZJ/KWPbWWptlU1n8n7hYfUfZYUUeqINWuefdGb0EEs4Uc/n
 eAy7VIWyLtlvWx6hfhLCscwpK7qdwwzkXwCS+V1E19g19n2ox2UE9j7O2Ldq9eXONzSE
 e58S4hNMGcEM1IgiidlwcPUFP9uDQaizV3JmGo4MdwaGhobcBVldDE1C8ZQyLlpIA9rc
 EUlA==
X-Gm-Message-State: AOJu0Yw2VNf4euq+DE7MF9DZ22xXXo48OXHfCAtnVP1pATpXl04WSQcC
 RJIutIqNdV1gBjCj7uwdN2wLlBy9fd+fisT3k/z7SlBXo52P8ZZn1xjJc5Us+nO4XsI=
X-Gm-Gg: ATEYQzxYp1OFxfNsXgsi2D75dQnuSymG5oxUjto+YG6AvS3XZlF0X/yvy/vyUiX7OtY
 yC2FwNcvIvtqjz+T7zz8AMIayqJWYUuZYLrwHt+EIbzjct41B3UrYfse+4eahaaj9uYBeHR7sey
 OmKTVZKc+vaulIWj2gqZj7bWVC5ELHnmOS9QpNhzrXKUT+As15okboJjzmvlitjc3bXr53C3ts7
 Q1Swlw90B9edVq991LW6OxSdrZFrvXs8YS2B0Hfo0F6D3td0zGNu80De223rMpLKXs+WeARMlL2
 3Z3SYsR24lXkJVIZ0pTD4f0FNhcqN33uoc0mY7dgQQ9lgFgOV0TP2DcX0ubMFhMhHqvk65NgMIL
 pK8USPIGAJw961IOAxK5VcnbD33A9HJij5FCji4h4RI72QjApBJEnfAWfaCwzgkJsYinji7PEer
 Almf++TcW/fG3/sanFwKJrKou0jjIG0CXuAv0pljzIUiF98aEjp/wCwS2MSFjNw/es0Opx
X-Received: by 2002:a05:6a00:3d01:b0:7b9:8142:96f4 with SMTP id
 d2e1a72fcca58-829a2e4ab99mr10999036b3a.21.1773076718578; 
 Mon, 09 Mar 2026 10:18:38 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-829aeea86b9sm11257368b3a.34.2026.03.09.10.18.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 10:18:38 -0700 (PDT)
Message-ID: <9f1b74e5-0741-487e-a549-bfa64c8e2146@linaro.org>
Date: Mon, 9 Mar 2026 10:18:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial] plugins: add missing docstrings to qemu-plugin.h
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
References: <20260309-add-missing-plugin-docs-v1-1-41dddcd177c8@epfl.ch>
 <CAFEAcA_WAnfxtCgfhX4oGa7eJhvs9aWgsU46CGGzgqNfBX28Dg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <CAFEAcA_WAnfxtCgfhX4oGa7eJhvs9aWgsU46CGGzgqNfBX28Dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/9/26 9:35 AM, Peter Maydell wrote:
> On Mon, 9 Mar 2026 at 16:22, Florian Hofhammer
> <florian.hofhammer@epfl.ch> wrote:
>>
>> This patch adds docstrings for typedefs and function declarations in
>> include/plugins/qemu-plugin.h that were previously missing. This
>> resolves inconsistencies in the docs, e.g., the description for
>> qemu_plugin_read_register() referring to qemu_plugin_register_flush_cb()
>> but code cache flush callbacks not being documented themselves.
>>
>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
> 
> I don't know this API either, so a couple of questions below
> for those who do:
> 
>> +/**
>> + * enum qemu_plugin_mem_rw - type of memory access
>> + *
>> + * @QEMU_PLUGIN_MEM_R: memory read access only
>> + * @QEMU_PLUGIN_MEM_W: memory write access only
>> + * @QEMU_PLUGIN_MEM_RW: memory read and write access
>> + */
>>   enum qemu_plugin_mem_rw {
>>       QEMU_PLUGIN_MEM_R = 1,
>>       QEMU_PLUGIN_MEM_W,
>>       QEMU_PLUGIN_MEM_RW,
>>   };
> 
> This define sets up the values such that you can use
> the _R and _W values as bit checks (i.e. _RW == _R | _W).
> Is that intentional and can code using the API rely on it,
> or must it strictly check against _R and _RW separately?
> 
>> +/**
>> + * enum qemu_plugin_mem_value_type - size of memory value
>> + *
>> + * @QEMU_PLUGIN_MEM_VALUE_U8: unsigned 8-bit value
>> + * @QEMU_PLUGIN_MEM_VALUE_U16: unsigned 16-bit value
>> + * @QEMU_PLUGIN_MEM_VALUE_U32: unsigned 32-bit value
>> + * @QEMU_PLUGIN_MEM_VALUE_U64: unsigned 64-bit value
>> + * @QEMU_PLUGIN_MEM_VALUE_U128: unsigned 128-bit value
>> + */
>>   enum qemu_plugin_mem_value_type {
>>       QEMU_PLUGIN_MEM_VALUE_U8,
>>       QEMU_PLUGIN_MEM_VALUE_U16,
>> @@ -353,7 +369,13 @@ enum qemu_plugin_mem_value_type {
>>       QEMU_PLUGIN_MEM_VALUE_U128,
>>   };
> 
> In this enum, the values are set up such that if you have
> a qemu_plugin_mem_value_type vt, then the size of the data
> is (1 << vt) (i.e., a byte is 0, a short is 1, 32 bits are 2,
> and so on up). Is that intentional and can code using the
> API rely on it, or must it strictly use the enum only as
> something to switch() on to select a length.
>

The latter, see it as something similar to Rust enums, or what theory 
calls an Algebraic data type:
https://doc.rust-lang.org/std/keyword.enum.html

> I actually ran into that last one in tests/tcg/plugins/mem.c:
> update_region_info() has a switch() on this enum which (among
> other things) sets val_size in each case, because I didn't
> know if it was guaranteed to work to set val_size = 1 << value.type.
> 
> thanks
> -- PMM


