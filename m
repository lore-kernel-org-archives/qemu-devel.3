Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304BCC4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 04:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3q83-0000fU-SZ; Mon, 06 May 2024 00:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s3pu9-0007AP-Gg
 for qemu-devel@nongnu.org; Mon, 06 May 2024 00:24:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s3pu7-00046n-DX
 for qemu-devel@nongnu.org; Mon, 06 May 2024 00:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714969482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=25OyZR437XJUiwnrMVJuMWb0yzsdMaQZhmspaZMxKJk=;
 b=VE88dLKANb5k/Y3V7i2poH/ZpseL+WOR3g1MWK1437J122xd442KTyTSmlv4OCFAVcQCHe
 mw8RXPhzuwoE+A6BgrcfuZMdpO8TuiZd6UXW3M4YLNwxIDIzqE123+woLJnQanhXaf8Yz2
 lssqX++UUetPEXyRVaO5XVsULk3vUH4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-uf_4Q9_4PNiNHzm9oA_79Q-1; Mon, 06 May 2024 00:24:41 -0400
X-MC-Unique: uf_4Q9_4PNiNHzm9oA_79Q-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-43ad0f16513so20571901cf.0
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 21:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714969481; x=1715574281;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=25OyZR437XJUiwnrMVJuMWb0yzsdMaQZhmspaZMxKJk=;
 b=D+YJhyTlrMdJVIc/ySPbwy2eNBt7kj/pS8P8Z+Qc2HEFqNj3JRwSOQlPVUQKL5FOLR
 T46neiFg6/+Bp1h981PWMbQF4IjgU3/DoiJYf+fg515ZIvW8UTBLlXYEExRLkef7tuYB
 FsSXYmwyOYeqt68OzAm2YGDCx51PAbsWyr6LjloSqu86n9NF/ZLiMPv2b7VWD+1sEoMC
 D15iglZH8c3+vkxTLTwnEnkn7qRol5dJGBu6XNZSehudykeVYuygNB8WahiKOUTn2js/
 uty1aYyzjebpwxJTBLKowno8tKuZSK1Elb7XlkDQDq3dw8AsYORZv3MB2i9MInF+UN5w
 24tA==
X-Gm-Message-State: AOJu0YwoWo9U61jdnzjUloFupyDjeM9pASg281+0tlKLB5++y2/GYMGZ
 a+i7De/85vncL/0rF/bfbOJ/pCO5lapJj6hjqdLFKVtSYhgArTmtogFK0f7AonrrooW1kjoL0NR
 WkYR2F2JdqGVEVNAY5uQCswaxUTEhMbFdnTZGmFe/mFID4q8IP6Yi
X-Received: by 2002:ac8:7d54:0:b0:43a:8248:26f with SMTP id
 h20-20020ac87d54000000b0043a8248026fmr8886297qtb.27.1714969480721; 
 Sun, 05 May 2024 21:24:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8CxiVsBCXAkYlrQmqnQ+G2UhQok2Q7wnGxc1Lod4N+W4fDlGOzJQpMcG4iiTr49BeIn/TLw==
X-Received: by 2002:ac8:7d54:0:b0:43a:8248:26f with SMTP id
 h20-20020ac87d54000000b0043a8248026fmr8886284qtb.27.1714969480223; 
 Sun, 05 May 2024 21:24:40 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-179-34.web.vodafone.de.
 [109.43.179.34]) by smtp.gmail.com with ESMTPSA id
 fe13-20020a05622a4d4d00b0043842dc662esm4708471qtb.4.2024.05.05.21.24.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 May 2024 21:24:39 -0700 (PDT)
Message-ID: <b1a4b08c-e288-4319-ac4a-7d6ca1256755@redhat.com>
Date: Mon, 6 May 2024 06:24:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] hw/loongarch: Rename LOONGARCH_MACHINE with
 VIRT_MACHINE
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240506030206.2119832-1-maobibo@loongson.cn>
 <20240506030206.2119832-2-maobibo@loongson.cn>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240506030206.2119832-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 06/05/2024 05.02, Bibo Mao wrote:
> On LoongArch system, there is only virt machine type now, name
> LOONGARCH_MACHINE is confused, rename it with VIRT_MACHINE. Machine name
> about Other real hw boards can be added in future.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
...
> @@ -1245,7 +1244,7 @@ static void loongarch_class_init(ObjectClass *oc, void *data)
>   
>   static const TypeInfo loongarch_machine_types[] = {
>       {
> -        .name           = TYPE_LOONGARCH_MACHINE,
> +        .name           = TYPE_VIRT_MACHINE,
>           .parent         = TYPE_MACHINE,
>           .instance_size  = sizeof(LoongArchMachineState),
>           .class_init     = loongarch_class_init,
> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
> index 4e14bf6060..5ea2f0370d 100644
> --- a/include/hw/loongarch/virt.h
> +++ b/include/hw/loongarch/virt.h
> @@ -73,8 +73,8 @@ struct LoongArchMachineState {
>       struct loongarch_boot_info bootinfo;
>   };
>   
> -#define TYPE_LOONGARCH_MACHINE  MACHINE_TYPE_NAME("virt")
> -OBJECT_DECLARE_SIMPLE_TYPE(LoongArchMachineState, LOONGARCH_MACHINE)
> +#define TYPE_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
> +OBJECT_DECLARE_SIMPLE_TYPE(LoongArchMachineState, VIRT_MACHINE)
>   bool loongarch_is_acpi_enabled(LoongArchMachineState *lams);
>   void loongarch_acpi_setup(LoongArchMachineState *lams);
>   #endif

  Hi,

there are currently some efforts going on to create the possibility to link 
a QEMU binary that contains all targets in one binary. Since we already have 
a TYPE_VIRT_MACHINE for other targets, I wonder whether it might be better 
to use LOONGARCH_VIRT_MACHINE than just VIRT_MACHINE here? Philippe, could 
you comment on this?

  Thomas


