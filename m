Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7367ED2E9DE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 11:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tASvY-0004La-Ms; Mon, 11 Nov 2024 06:49:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tASvV-0004LH-3C
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 06:49:50 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tASvT-0005Vd-I0
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 06:49:48 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5cecbddb574so5831988a12.1
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 03:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731325785; x=1731930585; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wtrUghqgj9LubW5fUfLvSSEMoQ+p30u1dZnBSejMoxA=;
 b=FICQuqXZ23a03mIE7sSOHFFBDAZG9A8EAuPW0ZhlUKnPWPzaBRx/UUxa+i20xvAP4w
 HnUqcEOYu7clY2qFFoMfQD4hsDvJRyX2wH2ncQ5oKmoOoOO+Qa1GXKhM0D2gCv06XuTL
 togvnXeX/+5B5u2no9qgz+qhNYKC4gGafcpXDnLb0fjRHMtalzSYr1B2mxKNvm2BVd2H
 bKjHibcTFZ+iYh1Da+gKJuVbMOS9+7bT4f6xumcfCPNXpeXCPMkcBXuYHnSzYZPC4SmT
 p8Md0qrn5IOoNfxCDO4SNq9arIXo8+DX/3xR+6UDiJn6QGcKQOfueejWNpKeLTIcizvS
 k1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731325785; x=1731930585;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wtrUghqgj9LubW5fUfLvSSEMoQ+p30u1dZnBSejMoxA=;
 b=NnmfLvUmvFFYpo9KV31rNcXh/GdnMJE553JkS1zQq2cCv9lLdkv+0LICbdrCA9jjMb
 vpR+5nWGt+NBQS6SDnq+ZJnC75y7j4gB+2SqR3pXcPeTewykNyt8UnzykZ4AxZG1Vwlc
 /n9xF4jnpjKjoRnrJzVth4mqzLuf5nZOUHVwTlzt5snjkv81t/IpQ2ELVbxyFryoU4kK
 bDDVr8XeI3T6CKjuICWV16U5gEnYBopsMmskXaQyMo43luk3Q0uICrrGa7LUAZMpCQ7f
 a0pG8JP/zRkFDOl+Q0ZTIpfdvm8EmZ0Y0sc0MYhXvv/BQMCzI4KHjlguspCByr3UuzIy
 +ZFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7PHVhJfk/L7q+3VLfUeH5SbV1h4BhGlq2++ylb/HxA5P70OTvzUN1K3u5ADVP9VLh4+jsf6/L6SIr@nongnu.org
X-Gm-Message-State: AOJu0Yw18ThkQ4eiW19Cy8vQsJtuajLG+rJyNv5Jpeg+Fx/8xVVctseR
 MI9m+ebzkmW/ZoDBVk98qoh2W2jv0RoeDk2yetr1bhmXIGUi2B0/o46VjxeTgCU=
X-Google-Smtp-Source: AGHT+IErvGiaM+F1ZqfJ8b7DaVn1X3B4KF5CjhfOP6i6aRJoMG2vjnaj7WNVWbeNV1vTsfzNixZ/RA==
X-Received: by 2002:a17:907:3fa2:b0:a9a:7f91:8c76 with SMTP id
 a640c23a62f3a-a9eefcec58dmr1273728566b.0.1731325785407; 
 Mon, 11 Nov 2024 03:49:45 -0800 (PST)
Received: from [192.168.69.126] (cnf78-h01-176-184-27-70.dsl.sta.abo.bbox.fr.
 [176.184.27.70]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0a450besm580762266b.43.2024.11.11.03.49.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Nov 2024 03:49:44 -0800 (PST)
Message-ID: <1af1f5db-ee5c-4f51-be40-2e9a2bc756be@linaro.org>
Date: Mon, 11 Nov 2024 12:49:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/elfboot: allocate "header" in heap
To: slp@redhat.com, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20241108230314.1980-1-slp@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241108230314.1980-1-slp@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

On 8/11/24 23:03, slp@redhat.com wrote:
> From: Sergio Lopez <slp@redhat.com>
> 
> In x86_load_linux(), we were using a stack-allocated array as data for
> fw_cfg_add_bytes(). Since the latter just takes a reference to the
> pointer instead of copying the data, it can happen that the contents
> have been overridden by the time the guest attempts to access them.
> 
> Instead of using the stack-allocated array, allocate some memory from
> the heap, copy the contents of the array, and use it for fw_cfg.
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>   hw/i386/x86-common.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> index bc360a9ea4..d51ebad4d6 100644
> --- a/hw/i386/x86-common.c
> +++ b/hw/i386/x86-common.c
> @@ -697,9 +697,12 @@ void x86_load_linux(X86MachineState *x86ms,
>                   strlen(kernel_cmdline) + 1);
>               fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdline);
>   
> +            setup = g_malloc(sizeof(header));
> +            memcpy(setup, header, sizeof(header));
> +
>               fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_SIZE, sizeof(header));
>               fw_cfg_add_bytes(fw_cfg, FW_CFG_SETUP_DATA,
> -                             header, sizeof(header));
> +                             setup, sizeof(header));

Preferably using g_memdup2(header, sizeof(header)),

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   
>               /* load initrd */
>               if (initrd_filename) {


