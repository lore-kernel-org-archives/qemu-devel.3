Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4421C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 13:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdVk5-0000UU-9G; Fri, 23 Feb 2024 08:37:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wj28.lee@gmail.com>)
 id 1rdRZS-0002QH-NZ
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 04:10:18 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wj28.lee@gmail.com>)
 id 1rdRZK-0004hF-Uy
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 04:10:17 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-295c8b795e2so511786a91.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 01:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708679409; x=1709284209; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i7088AgHa1OAqA61tMttin5VX75haYu/ICj6HSRJocc=;
 b=EYkLXkSR+xG2KxbjP7gMzW46d2k31aqWzRN5JhZCXLcS97ShVIdITrGTWFSAtTZXCd
 39pyt62WpsGCSp62kgKe+B4SefYGzbusdJGoxG3hSr6sWyOh7JcmFCKoecDz0WLvrTII
 tqDffJ9+8UFCFlxF0mAp1uzPb/gsJveJcXO9LNr5yRS1PIrKK7rNp+WcfQyRwcApQlAt
 CCmDs9cR2Ps//NfzTA3J0nLP0neddj8fNN+A4unntTbv8EQY6Xa8RwymxcBdxaPLzCKR
 X4kSvRMsA9fkPQisKxnw35qeZTHjl5gz6/gaS1ktZYC0jt5LOecihXW7olWxRnU33KZT
 QTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708679409; x=1709284209;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i7088AgHa1OAqA61tMttin5VX75haYu/ICj6HSRJocc=;
 b=qmMX67C2eQwhIE6Ci92dJl84v9DzDg45IeXCfUaerDbNFgYySTrcwm7mNvIBa9dmmX
 ScZUOo7z5YLdcV4TGQ9wly8i4aDIPJ4KPN6hpquo5HytkDalio7/w2YjI59wOP+1v03y
 O1BsWVB3Kgn+VvPclhgDjpzupe/tUM5RhhIkYycaVkj+JL8SkhVhUF867Vx2uC1XVAFW
 KqLW1+uePnNaViJRC5vioCNL1M1YZusLVEmLuRuMBdyvB8teecpWkQrGlgILR4Snh/zE
 56rV4CUfn6lZPx08NWLJfpGZ2jA9kqHPWb2JBYVF0BjuyCfLjlu2LTIuz+fKhw2Hzzl6
 5Z6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2mn3NIeXBdGTDDMMt9JHiOg/GiqPeQlNDKw8CYVdcR98JWk4n1G/DbGmhdpa/uDYTJHsgg3+YH8C9jbIuygqv6kDvrlk=
X-Gm-Message-State: AOJu0YyIzLU+zZ8fVzBwj8NHKYcvsxyFSMNfbTtp/osShLJOjKP4y37I
 TMSDRi6SxYGdlg+QQL/QQd+pbVvRBgbRJinTKpbL4UopAggyaRXv
X-Google-Smtp-Source: AGHT+IHCs7N7AR1WscQ+RxKqewpNJ204dTv8cjZrnZyzFnjfD1/ZJjzCG7gLLLLxhsrAcX/bbYe2/g==
X-Received: by 2002:a17:90a:6888:b0:29a:7380:53a with SMTP id
 a8-20020a17090a688800b0029a7380053amr1246186pjd.34.1708679408952; 
 Fri, 23 Feb 2024 01:10:08 -0800 (PST)
Received: from [172.30.1.72] ([211.197.219.189])
 by smtp.gmail.com with ESMTPSA id
 se13-20020a17090b518d00b00299b31de43esm921900pjb.45.2024.02.23.01.10.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 01:10:08 -0800 (PST)
Message-ID: <698e6bc2-d38f-46e2-837c-3c6777d49139@gmail.com>
Date: Fri, 23 Feb 2024 18:10:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/10] hw/cxl/cxl-mailbox-utils: Add mailbox commands
 to support add/release dynamic capacity response
Content-Language: en-US
To: nifan.cxl@gmail.com, qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
 <20240221182020.1086096-9-nifan.cxl@gmail.com>
From: Wonjae Lee <wj28.lee@gmail.com>
In-Reply-To: <20240221182020.1086096-9-nifan.cxl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=wj28.lee@gmail.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 23 Feb 2024 08:35:47 -0500
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

On 2024-02-22 오전 3:16, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> Per CXL spec 3.1, two mailbox commands are implemented:
> Add Dynamic Capacity Response (Opcode 4802h) 8.2.9.9.9.3, and
> Release Dynamic Capacity (Opcode 4803h) 8.2.9.9.9.4.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>   hw/cxl/cxl-mailbox-utils.c  | 288 ++++++++++++++++++++++++++++++++++++
>   include/hw/cxl/cxl_device.h |   2 +
>   2 files changed, 290 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index dae7fe00ed..65ed28f700 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c

[snip]

> +/*
> + * CXL r3.1 Table 8-168: Add Dynamic Capacity Response Input Payload
> + * CXL r3.1 Table 8-170: Release Dynamic Capacity Input Payload
> + */
> +typedef struct CXLUpdateDCExtentListInPl {
> +    uint32_t num_entries_updated;
> +    uint8_t flags;
> +    uint8_t rsvd[3];
> +    /* CXL r3.1 Table 8-169: Updated Extent List */

I'm not sure why this was changed, but in r3.1 the table is simply 
renamed to "Updated Extent"

...

> +/*
> + * CXL r3.1 section 8.2.9.9.9.3: Add Dynamic Capacity Response (opcode 4802h)

It's too trivial, but it's written as "Opcode" in other comments.
: Opcode 4802h

...

> +/*
> + * CXL r3.1 section 8.2.9.9.9.4: Release Dynamic Capacity (opcode 4803h)

And here, too
: Opcode 4803h

...

> @@ -1462,6 +1744,12 @@ static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
>       [DCD_CONFIG][GET_DYN_CAP_EXT_LIST] = {
>           "DCD_GET_DYNAMIC_CAPACITY_EXTENT_LIST", cmd_dcd_get_dyn_cap_ext_list,
>           8, 0 },
> +    [DCD_CONFIG][ADD_DYN_CAP_RSP] = {
> +        "ADD_DCD_DYNAMIC_CAPACITY_RESPONSE", cmd_dcd_add_dyn_cap_rsp,
> +        ~0, IMMEDIATE_DATA_CHANGE },
> +    [DCD_CONFIG][RELEASE_DYN_CAP] = {
> +        "RELEASE_DCD_DYNAMIC_CAPACITY", cmd_dcd_release_dyn_cap,
> +        ~0, IMMEDIATE_DATA_CHANGE },

For consistency, how about setting the names of commands as follows?
: DCD_ADD_DYNAMIC_CAPACITY_RESPONSE
: DCD_RELEASE_DYNAMIC_CAPACITY

Thanks,
Wonjae


