Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7F9D3E765
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 21:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8QgB-0008SD-Ue; Tue, 05 Nov 2024 16:01:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1t8QgB-0008Rx-2b
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 16:01:35 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1t8Qg9-0005Bb-Fl
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 16:01:34 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6ea7c26e195so42117367b3.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 13:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730840492; x=1731445292; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0V3nCXvKfMGVThLxqeeI6xHXpbgfrthGNbpv5LxWmok=;
 b=EkOZTPtHbV4JIVE33aICKqp+8CYKy3b7zGq27spgIrOL7Lt/ocHzMIreLVIJ6ILtPi
 UNGavXEJQJFtOLej2RpO/028POgkGPr0N3nhnRMMjhCSQbH3RMMdK6xKqCp2kQUPViZ3
 Iov/2/1duWt2TkMBJm7Un2PhC6FcoklubXe9WAjegWLFP9M0VcsmCiqDat9ahk3G+fqe
 oafnsSxOct0/8kN3oyhj5f3476nWiGteTXu7rQWkl61BMDgxdBs+hZbjzvFk+XpRD8z2
 ihitoiTW9uB/6xE12/Tec56kO9VJC3xbDRY6naEh4RaTP/iStiD7E7BepTgrTyerGrTZ
 Lo0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730840492; x=1731445292;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0V3nCXvKfMGVThLxqeeI6xHXpbgfrthGNbpv5LxWmok=;
 b=uQeTvoR5W58YhOgNxn1IN8c1Be1Vxew6DOKaSiYW14x4beGAoC7Hq6yVyciZMpGERh
 IqHxdb94d/nx4NEbZ2YJVpVR/AoBJ/FwpuDEjYeNXnslYw7CBcjo42zMSJ0398x17SKt
 OWZiZaUZvcj9qSemvRi+bNWGdtwzgRBFyF/JlQDirmgOF81lvQce+MheYqen+KU38W/W
 3w8PUDiVSZlzc9ZqzMyjvyYcUvKbfeL8TDZ2vTsJpwClYvJFddg5sm6c2gFKB/u4B1cS
 za8Dgw2IygbYT6qNRD1b1PUp6p2EhygLuGJHOI+cMkssgvLVR/JDuAJBPem1xddGw3YQ
 aPqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd4md+oAjtBYxM46/d90sJwVYu7jMLWt7c0+GX5D0ZQ8p2rj/aU1jTaHSr/JAsq9DRVPCecST7nu0w@nongnu.org
X-Gm-Message-State: AOJu0YwgcR5AifVnVRpM8o4yEGO/atkzhmCjY4//7qvJhMxqj/2ya9jQ
 MqpYoJbW/Zxw5izB/RhGFBAKlJyYucxzKwqF+gRAKCjlmgPOpnYJ
X-Google-Smtp-Source: AGHT+IFbzPKzfW1H+8vc8LwCUl2CWaB9C2O5YZzw1zu3k06C1fw++IPRi5u9ZYNFust3TOiScEaGJA==
X-Received: by 2002:a0d:c603:0:b0:6ea:7950:e75 with SMTP id
 00721157ae682-6ea79500fbamr106050917b3.24.1730840492129; 
 Tue, 05 Nov 2024 13:01:32 -0800 (PST)
Received: from fan ([50.205.20.42]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6ea94102de3sm12090487b3.52.2024.11.05.13.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 13:01:31 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 5 Nov 2024 13:01:30 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org,
 Esifiel <esifiel@gmail.com>, linuxarm@huawei.com
Subject: Re: [PATCH qemu 03/10] hw/cxl: Check input length is large enough in
 cmd_events_clear_records()
Message-ID: <ZyqHqsFQzjDaEP8w@fan>
References: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
 <20241101133917.27634-4-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101133917.27634-4-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, Nov 01, 2024 at 01:39:10PM +0000, Jonathan Cameron wrote:
> Buggy software might write a message that is too short for
> either the header, or the header + the event data that is specified
> in the header.  This may result in accesses beyond the range of the
> message allocated as a duplicate of the incoming message buffer.
> 
> Reported-by: Esifiel <esifiel@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  hw/cxl/cxl-mailbox-utils.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index e63140aefe..3cb499a24f 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -266,6 +266,12 @@ static CXLRetCode cmd_events_clear_records(const struct cxl_cmd *cmd,
>      CXLClearEventPayload *pl;
>  
>      pl = (CXLClearEventPayload *)payload_in;
> +
> +    if (len_in < sizeof(*pl) ||
> +        len_in < sizeof(*pl) + sizeof(*pl->handle) * pl->nr_recs) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
> +
>      *len_out = 0;
>      return cxl_event_clear_records(cxlds, pl);
>  }
> -- 
> 2.43.0
> 

-- 
Fan Ni

