Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75620C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 19:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKNUB-0006g3-4b; Thu, 20 Jun 2024 15:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKNU8-0006fc-EA
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 15:30:16 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKNU6-0005Ap-I3
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 15:30:16 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2c1a4192d55so1041613a91.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 12:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718911811; x=1719516611; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uECcb6C4E7op/16V3Ww2E+MY6xCVVJXATLR3nWIbQME=;
 b=n9QUIiHrCPB/GqmPpZQadTvPEayvP8UnamCGVPoxFjyyduQNV5YCtN9VMgpD2Vuclu
 ixs4IvgiNq5VLu4v+ZUiup4owAlnD0tbfP9MpVasLX66yW96QoADHelwaGkKK1EYzCqY
 1R4+MqxRgrTt0Dxxi1EeoHPPjWqQATAO4dBSZRj8hDS4QpfTiepsGcJEtM/Y1WPv8pJ8
 fBMfcWe8fuiEOfbfYK/wXWKfHx4emQajO/Qsmr/xF1yA7vDPWdm99islcldxYcL4nU3S
 JG2K4oDWdsX84oEPW+R6gGx0cX2EcIpJs7b+SYOlw4AIoh8txikPj1wjx6AHH0mbXqi9
 B+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718911811; x=1719516611;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uECcb6C4E7op/16V3Ww2E+MY6xCVVJXATLR3nWIbQME=;
 b=vgXLBIS7HVHB+TCeIqDgZkC/HOMDZEPyBGR6GWI37ig7Fchx4uYWP1ADQmx+2Gt6sK
 FFxVeA33xzwMw6AhTMLd8EoJQ4R2ymMmd6TOS2FxQAcPT/9pSg1waqY9mjrK8RJ0NFvW
 6Mwq6qZ2r0QTLodVcQuYM1IB1iK4u7/cc4k4HUlh7jQ0J0poy+eFGHnA/ufy9Bye7d5l
 WRG2rJqdkeGpUrF3w9kXdzSt6kc/zSxcJjLpLpBrbSJ5iD2ts1zuP+f2yeDYMRZWWNPH
 kCIQgEXCdew21+mj0sWNThcQPzV7X8eozuNMyFvqV95tuJ+EdFjgcoeuld6HIm/6I0AA
 SSmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvTdsASf7l0LD+5OGcu2fv087869TPopdIM4r+0aYyFVYCIvtE4s5jFYTHzXOIQdRyecdwXTkQGVRTiFLC92Kcgu+91Iw=
X-Gm-Message-State: AOJu0YwodjT/awL97YKZaaeKJfhv65io62K67yTG/oUPueWSDwRQHJvc
 FoJdFH2Wg3lYH9t+Ed5Z/cPDoJFFRkscxe57i/8AyleJ2EFm9VWe93a9XOUX6FA=
X-Google-Smtp-Source: AGHT+IHj1fwqEINe+ldj/xSbZedO7Sa30ONVmgl+/7Kmxd05C0x1X/6VfH0Tu647ubmJ58RWvrfOJw==
X-Received: by 2002:a17:90a:ff11:b0:2c7:3a77:18cb with SMTP id
 98e67ed59e1d1-2c7b5c82401mr5980881a91.16.1718911811197; 
 Thu, 20 Jun 2024 12:30:11 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c738c1bb81sm3944062a91.1.2024.06.20.12.30.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 12:30:10 -0700 (PDT)
Message-ID: <f56e3f9c-7872-41ad-b49a-1c3b4f9f9e33@linaro.org>
Date: Thu, 20 Jun 2024 12:30:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/5] rust: add bindgen step as a meson dependency
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <6bf311a35e6d3bfa8b3bfd10d8f896a9e655fa30.1718827153.git.manos.pitsidianakis@linaro.org>
 <d32a653f-f741-4c59-8a6e-c2094e972009@linaro.org>
 <fe6m8.4d61etyid59f@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <fe6m8.4d61etyid59f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 6/20/24 11:36, Manos Pitsidianakis wrote:
> On Thu, 20 Jun 2024 17:01, Richard Henderson <richard.henderson@linaro.org> wrote:
>> On 6/19/24 13:13, Manos Pitsidianakis wrote:
>>> +# FIXME: These are the latest stable versions, refine to actual minimum ones.
>>> +msrv = {
>>> +  'rustc': '1.79.0',
>>> +  'cargo': '1.79.0',
>>> +  'bindgen': '0.69.4',
>>> +}
>>
>> A note for other rust newbies:
>>
>> These versions are pretty darn close to actual minima.  Ubuntu 24.04 packages rust 1.77, 
>> which does not support (but has a warning reserving syntax for)
>>
>>> +    println!("cargo::rerun-if-env-changed=MESON_BUILD_DIR");
>>
> 
> 
> rerun-if-env-changed is not new, I think, but the `cargo::` instead of `cargo:` syntax is. 
> Is this what the warning is saying?
> 
> Source 
> <https://doc.rust-lang.org/cargo/reference/build-scripts.html#outputs-of-the-build-script>:
> 
>   Note: The old invocation prefix cargo: (one colon only) is deprecated
>   and won’t get any new features. To migrate, use two-colons prefix
>   cargo::, which was added in Rust 1.77. If you were using
>   cargo:KEY=VALUE for arbitrary links manifest key-value pairs, it is
>   encouraged to switch to cargo::metadata=KEY=VALUE. Stick to cargo:
>   only if the support of Rust version older than 1.77 is required.
> 
> But this is not in any way necessary for us, we can ignore cargo's stale build detection 
> and force it from meson.

Yes indeed.  The exact error reported is

error: unsupported output in build script of `pl011 v0.1.0 
(/home/rth/qemu/src/rust/pl011)`: `cargo::rerun-if-env-changed=MESON_BUILD_DIR`
Found a `cargo::key=value` build directive which is reserved for future use.
Either change the directive to `cargo:key=value` syntax (note the single `:`) or upgrade 
your version of Rust.


r~

