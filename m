Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2031DC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 16:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhuAQ-0007f1-C9; Wed, 06 Mar 2024 11:30:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhuAC-0007eW-DI
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 11:30:40 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhuA9-0006HI-Dk
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 11:30:39 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-412fe981ef1so3026245e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 08:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709742636; x=1710347436; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KowFkOSPnogRGGL42CIVvgjXOmyPDd66hJPaZzgbCl4=;
 b=Yn9dhLyhOGcCf5o0wghsxeYQglak36MYCNJSRq0jO7m6Sngst/fVSvYbaSJmX8wpVv
 +/GeXJyiZMy6egGC5Rec+W66zfSAOduxyndHeaAeFcsfPxjxTojXTWH+hwjqepG5XwZB
 x4gjRhOfx+XlyfZtwYH1taIXNq+eQwSvsYnP9nF1G5JTV7xTTKsTjbqxc/dctkeVCdqX
 h63mpyxqXBItUy0JAfA+q3f8W8e1NhGpeNhScZh3ojyg5Q+iJxr4wTxELBRkF80idL3l
 xizf/zwcV955VuU3flNCARh1gErypU1oLhZq0kMls55WDy9qYMOg7HS+2ECptfTaHWvi
 CcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709742636; x=1710347436;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KowFkOSPnogRGGL42CIVvgjXOmyPDd66hJPaZzgbCl4=;
 b=dovRnHzLgGxQaHHktM4hBmF8iSAc+81b7gTjrD7+VzmtVdHvzUhOSZAWfIQN0Spr6Y
 8b+3vmRK1O5OgBW3OtpoQf74gCXQi53a0degYSXkdH+8atOIAtcUWD97h1oMTWxU6wZ6
 BbAbY9W7egDB8S2tnv80Z3UyfmZnqoRz3lRZ7ACbtuO66FMaC+oVYuBJJ/gPYsxWPuka
 hs5U2wvCtPfXzCWMJKbj6CD7kzmPSmXHMsPXqmyTFT7s5Tu6i83/R+X98bsa/w7AD6DA
 Z0obfiRgXWmXSaf5l0vA7C1k62OND81fdwSaltemGzMmXp/CZlvhq4gHt6RpsTYYVUO7
 cHMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLpZ4qj4FYi398Rb7Vi6dQS1hBFCJS8RJD/FKtwiVzjNQ1f8A0TeWD6mrZkM+FxqL8gno/043S7SFLtOBp2lBJyFhGpG4=
X-Gm-Message-State: AOJu0YzxQPAd3H1PyCT4R7oi/egyvBm98HiTdP3y6/ZrPmeRbSvloIRk
 rsGR9lW0LnAPL4hX8iG0M1HO+Y9cN9PTkHk/kNxHnWiJgwS8lLPQ6DaqvWU0tKw=
X-Google-Smtp-Source: AGHT+IHcviSlk4+y21JgOqi8479lwR2Xdz0/KRP6FrEeFC/vNFiGwpmjEb2+d41UuS69ZCk+fw1WeQ==
X-Received: by 2002:a05:600c:5119:b0:412:bca4:6a00 with SMTP id
 o25-20020a05600c511900b00412bca46a00mr5670167wms.18.1709742635764; 
 Wed, 06 Mar 2024 08:30:35 -0800 (PST)
Received: from [192.168.69.100] (vau06-h02-176-184-43-100.dsl.sta.abo.bbox.fr.
 [176.184.43.100]) by smtp.gmail.com with ESMTPSA id
 jr18-20020a05600c561200b004127057d6b9sm24049906wmb.35.2024.03.06.08.30.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 08:30:35 -0800 (PST)
Message-ID: <04da4267-8fe8-4653-90a2-f64e3be64037@linaro.org>
Date: Wed, 6 Mar 2024 17:30:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with migration/rdma
Content-Language: en-US
To: Yu Zhang <yu.zhang@ionos.com>, Het Gala <het.gala@nutanix.com>,
 qemu-devel <qemu-devel@nongnu.org>, Li Zhijian <lizhijian@fujitsu.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
Cc: Jinpu Wang <jinpu.wang@ionos.com>,
 Alexei Pastuchov <alexei.pastuchov@ionos.com>,
 Elmar Gerdes <elmar.gerdes@ionos.com>
References: <CAHEcVy7HXSwn4Ow_Kog+Q+TN6f_kMeiCHevz1qGM-fbxBPp1hQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAHEcVy7HXSwn4Ow_Kog+Q+TN6f_kMeiCHevz1qGM-fbxBPp1hQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Cc'ing RDMA migration reviewers/maintainers:

$ ./scripts/get_maintainer.pl -f migration/rdma.c
Li Zhijian <lizhijian@fujitsu.com> (reviewer:RDMA Migration)
Peter Xu <peterx@redhat.com> (maintainer:Migration)
Fabiano Rosas <farosas@suse.de> (maintainer:Migration)

On 5/3/24 22:32, Yu Zhang wrote:
> Hello Het and all,
> 
> while I was testing qemu-8.2, I saw a lot of our migration test cases failed.
> After debugging the commits of the 8.2 branch, I saw the issue and mad a diff:
> 
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 6a29e53daf..f10d56f556 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -3353,9 +3353,9 @@ static int qemu_rdma_accept(RDMAContext *rdma)
>           goto err_rdma_dest_wait;
>       }
> 
> -    isock->host = rdma->host;
> +    isock->host = g_strdup_printf("%s", rdma->host);
>       isock->port = g_strdup_printf("%d", rdma->port);
> 
> which was introduced by the commit below:
> 
> commit 3fa9642ff7d51f7fc3ba68e6ccd13a939d5bd609 (HEAD)
> Author: Het Gala <het.gala@nutanix.com>
> Date:   Mon Oct 23 15:20:45 2023 -0300
> 
>      migration: convert rdma backend to accept MigrateAddress
> 
>      RDMA based transport backend for 'migrate'/'migrate-incoming' QAPIs
>      accept new wire protocol of MigrateAddress struct.
> 
>      It is achived by parsing 'uri' string and storing migration parameters
>      required for RDMA connection into well defined InetSocketAddress struct.
>      ...
> 
> A debug line
>       isock->host = rdma->host;
>       isock->port = g_strdup_printf("%d", rdma->port);
> +fprintf(stdout, "QEMU: %s, host %s, port %s\n", __func__,
> isock->host, isock->port);
> 
> produced this error:
> QEMU: qemu_rdma_accept, host ::, port 8089
> corrupted size vs. prev_size in fastbins
> 
> on the target host, which may indicate a crash related to the memory
> allocation or a memory
> corruption of the data. With the patch, it doesn't happen any more,
> and the migration is fine.
> Could you be kind to test this and confirm the issue?
> 
> Furthermore, I'm confused by the two struct:
> 
> struct InetSocketAddressBase {
>      char *host;
>      char *port;
> };
> 
> struct InetSocketAddress {
>      /* Members inherited from InetSocketAddressBase: */
>      char *host;
>      char *port;
> 
> To my understanding, they are used to consolidate the separated data
> to a well-defined
> struct "MigrateAddress", while the struct whose member receive their
> data has a different type:
> 
> typedef struct RDMAContext {
>      char *host;
>      int port;
>      ...
> }
> 
> Is there any reason to keep "port" like this (char* instead of int) or
> can we improve it?
> Thank you so much for any of your comments!
> 
> Best regards,
> 
> Yu Zhang @ IONOS Compute Platform
> 05.03.2024
> 


