Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6786C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 04:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgzms-0001AE-5O; Thu, 22 Aug 2024 00:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sgzmp-00019b-T6
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 00:51:04 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sgzmn-0006AD-VS
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 00:51:03 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7106cf5771bso375946b3a.2
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 21:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724302259; x=1724907059; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NbLgFPklo2dGstoTYe/nLPFCAh8zIGcUKqQKwd4bWNE=;
 b=SENJc22Lx69DBBqGdrVckWzLWBf2zBgnt0nV6/0qc3XB4t2Mm1gmBUwgSDSx6Z4jLx
 8hmhMQCg176QUcDRMaiKJ4dJOFBVg4hAB3xwDGGSuJWeDwpU9C15GtRoa9tWWjwzee8/
 /gA6naQCwJRUv0gG2ZkdZIgQmJgYL1xjRTgoxnEqQIpXmRdgR3I9FgdZNl4xEU04afeb
 FDZknu1di8UhBH/bV8vo0VbrcVOW9r2N0HAYS94/hSf2UIv/YIVKEticmVTCWzHw4sEA
 H92aWuTpCnp10/3DTVMGZnqFveoE1mVF0hw64s+H0xXWtCE32P90/ymYwbKB7g/yKC2A
 hMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724302259; x=1724907059;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NbLgFPklo2dGstoTYe/nLPFCAh8zIGcUKqQKwd4bWNE=;
 b=NIZQLi1Lm/+bjUz4gtaJEohG/uvVeuISwPEG94FmT/as11DtjzIWjs1xwGhs9XLQqE
 dZUeJu70uFZPyDOTLsXrlAoRdEqf1FJVsp2cDXf2snyyfXfKzjCYS6MAaMmKxcM+woxm
 Nw0qKDgwbs5mi4ycg1TTfDITYjYQ2jiOvUSuPT4NpeAPgnsvaqNsLwBNp6130myrGtie
 8wgU/XA13eQMUIxLJSmYRbpfrDDQxBxQalUxinJ5nPOkNfdfMG2i37VBg1TKKSLKKdDz
 PzzCZ8BYSP32FChlwA6DxwFodV3RVigz1GZB3c1qMDAyKy+Hv1ZXlvRZB0bErrY7RviH
 EzUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlIbEaRw2P8HT35Cr6HDMnFtKwfT/zYjeb/h/EDDzVfbNuZfd9qu58iaJH1NyoMvBDKt8UuFNvE1bf@nongnu.org
X-Gm-Message-State: AOJu0Yy6EHhtR+SBiuvuPDfr7y5QiYcZ3JRuI7buBfxz3Sa1U0hJ0/9E
 HKRKSJrb4bu3CWYE5KIDA0Tu4X66DHm/XlhrrzsGYY4JmUeP+G3J
X-Google-Smtp-Source: AGHT+IFkdFLZilBsTeuqHhLnoFMlCIGOrSPbp65U/+9qcRajOD+yWNce+JZyuhnGWG/PT5iFQueJLw==
X-Received: by 2002:a05:6a20:6b9e:b0:1ca:da95:d49b with SMTP id
 adf61e73a8af0-1cada95d6bfmr3910892637.2.1724302259329; 
 Wed, 21 Aug 2024 21:50:59 -0700 (PDT)
Received: from [192.168.0.22] ([210.223.46.112])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203855e1826sm4052845ad.122.2024.08.21.21.50.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 21:50:58 -0700 (PDT)
Message-ID: <c92844fd-8c4a-4ab6-b778-f8d8e86741eb@gmail.com>
Date: Thu, 22 Aug 2024 13:50:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] hw/ufs: minor bug fixes related to ufs-test
Content-Language: ko
To: yc01.jeong@samsung.com, =?UTF-8?B?6rmA7KCc7Jqx?= <jeuk20.kim@samsung.com>
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jeongyuchan0629@gmail.com" <jeongyuchan0629@gmail.com>
References: <20240821023025epcms1p4de36db95f4d3a66727f128ef6be860e4@epcms1p4>
 <CGME20240821022726epcms1p127d8cd71ca3e1354592de8a4a5c97a10@epcms1p3>
 <20240821023245epcms1p31ada9c24041d9b34f7e9938abe93189b@epcms1p3>
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <20240821023245epcms1p31ada9c24041d9b34f7e9938abe93189b@epcms1p3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


On 8/21/2024 11:32 AM, 정유찬 wrote:
>  From d0ae8e25aec4ae7d222a2ea667d5ddb61f14fe02 Mon Sep 17 00:00:00 2001
> From: Yoochan Jeong <yc01.jeong@samsung.com>
> Date: Wed, 21 Aug 2024 09:03:06 +0900
> Subject: [PATCH 1/4] hw/ufs: minor bug fixes related to ufs-test
>
> Minor bugs and errors related to ufs-test are resolved. Some
> permissions and code implementations that are not synchronized
> with the ufs spec are edited.
>
> Based on: 20240802051902epcms2p319bc095a15eaef8de4e6955f6718371d@epcms2p3
> Signed-off-by: Yoochan Jeong <yc01.jeong@samsung.com>
> ---
>   hw/ufs/ufs.c           | 26 +++++++++++++++++++++-----
>   tests/qtest/ufs-test.c | 12 +++++++++---
>   2 files changed, 30 insertions(+), 8 deletions(-)
>
> diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
> index ce2c96aeea..9472a3c14a 100644
> --- a/hw/ufs/ufs.c
> +++ b/hw/ufs/ufs.c
> @@ -971,7 +971,7 @@ static const int attr_permission[UFS_QUERY_ATTR_IDN_COUNT] = {
>           UFS_QUERY_ATTR_READ | UFS_QUERY_ATTR_WRITE,
>       [UFS_QUERY_ATTR_IDN_EE_STATUS] = UFS_QUERY_ATTR_READ,
>       [UFS_QUERY_ATTR_IDN_SECONDS_PASSED] = UFS_QUERY_ATTR_WRITE,
> -    [UFS_QUERY_ATTR_IDN_CNTX_CONF] = UFS_QUERY_ATTR_READ,
> +    [UFS_QUERY_ATTR_IDN_CNTX_CONF] = UFS_QUERY_ATTR_READ | UFS_QUERY_ATTR_WRITE,

Although the spec defines UFS_QUERY_ATTR_IDN_CNTX_CONF as configurable,
the qemu ufs does not yet implement related functionality.
So it seems reasonable to leave it as not configurable to me.


>       [UFS_QUERY_ATTR_IDN_FFU_STATUS] = UFS_QUERY_ATTR_READ,
>       [UFS_QUERY_ATTR_IDN_PSA_STATE] = UFS_QUERY_ATTR_READ | UFS_QUERY_ATTR_WRITE,
>       [UFS_QUERY_ATTR_IDN_PSA_DATA_SIZE] =
> @@ -1038,7 +1038,7 @@ static QueryRespCode ufs_exec_query_flag(UfsRequest *req, int op)
>       }
>   
>       *(((uint8_t *)&u->flags) + idn) = value;
> -    req->rsp_upiu.qr.value = cpu_to_be32(value);
> +    req->rsp_upiu.qr.value = value;

req->rsp_upiu.qr.value uses big endian. Please check the spec


>       return UFS_QUERY_RESULT_SUCCESS;
>   }
>   
> @@ -1148,8 +1148,11 @@ static QueryRespCode ufs_exec_query_attr(UfsRequest *req, int op)
>   {
>       UfsHc *u = req->hc;
>       uint8_t idn = req->req_upiu.qr.idn;
> +    uint8_t selector = req->req_upiu.qr.selector;
>       uint32_t value;
>       QueryRespCode ret;
> +    const uint8_t UFS_QUERY_ATTR_CNTX_CONF_SELECTOR = 15;
> +    const uint32_t UFS_QUERY_ATTR_MAXVALUE = 0x0F;
The name UFS_QUERY_ATTR_MAXVALUE does not seem appropriate. Rename it to 
mean the maximum value of the ICC.
>   
>       ret = ufs_attr_check_idn_valid(idn, op);
>       if (ret) {
> @@ -1159,10 +1162,20 @@ static QueryRespCode ufs_exec_query_attr(UfsRequest *req, int op)
>       if (op == UFS_QUERY_ATTR_READ) {
>           value = ufs_read_attr_value(u, idn);
>       } else {
> -        value = be32_to_cpu(req->req_upiu.qr.value);
> +        value = req->req_upiu.qr.value;
> +        if (idn == UFS_QUERY_ATTR_IDN_ACTIVE_ICC_LVL &&
> +            value > UFS_QUERY_ATTR_MAXVALUE) {
Move this condition check inside the ufs_write_attr_value() function
> +            return UFS_QUERY_RESULT_INVALID_VALUE;
> +        }
> +        if (idn == UFS_QUERY_ATTR_IDN_CNTX_CONF) {
Remove it. We haven't implemented the UFS_QUERY_ATTR_IDN_CNTX_CONF 
function yet.
> +            if (selector != UFS_QUERY_ATTR_CNTX_CONF_SELECTOR) {
> +                return UFS_QUERY_RESULT_INVALID_SELECTOR;
> +            } else if (value == 0x00 || value > UFS_QUERY_ATTR_MAXVALUE) {
> +                return UFS_QUERY_RESULT_INVALID_VALUE;
> +            }
> +        }
>           ufs_write_attr_value(u, idn, value);
>       }
> -
>       req->rsp_upiu.qr.value = cpu_to_be32(value);
>       return UFS_QUERY_RESULT_SUCCESS;
>   }
> @@ -1287,9 +1300,12 @@ static QueryRespCode ufs_read_desc(UfsRequest *req)
>       UfsHc *u = req->hc;
>       QueryRespCode status;
>       uint8_t idn = req->req_upiu.qr.idn;
> +    uint8_t selector = req->req_upiu.qr.selector;
>       uint16_t length = be16_to_cpu(req->req_upiu.qr.length);
>       InterconnectDescriptor desc;
> -
> +    if (selector != 0) {
> +        return UFS_QUERY_RESULT_INVALID_SELECTOR;
> +    }
>       switch (idn) {
>       case UFS_QUERY_DESC_IDN_DEVICE:
>           memcpy(&req->rsp_upiu.qr.data, &u->device_desc, sizeof(u->device_desc));
> diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
> index 82ec3f0671..d70c2ee4a3 100644
> --- a/tests/qtest/ufs-test.c
> +++ b/tests/qtest/ufs-test.c
> @@ -119,8 +119,10 @@ static void ufs_send_nop_out(QUfs *ufs, uint8_t slot,
>   
>   static void ufs_send_query(QUfs *ufs, uint8_t slot, uint8_t query_function,
>                              uint8_t query_opcode, uint8_t idn, uint8_t index,
> +                           uint8_t selector, uint32_t attr_value,

We use ufs_send_query() not only for attributes, but also descriptors 
and flags.

Please rename `attr_value` to `value`.


>                              UtpTransferReqDesc *utrd_out, UtpUpiuRsp *rsp_out)
>   {
> +    const uint16_t UFS_QUERY_DESC_MAXLENGTH = 0x62;
How did you determine that the maximum size of a descriptor is 62?
>       /* Build up utp transfer request descriptor */
>       UtpTransferReqDesc utrd = ufs_build_req_utrd(ufs->cmd_desc_addr, slot,
>                                                    UFS_UTP_NO_DATA_TRANSFER, 0);
> @@ -136,13 +138,16 @@ static void ufs_send_query(QUfs *ufs, uint8_t slot, uint8_t query_function,
>       req_upiu.header.query_func = query_function;
>       req_upiu.header.task_tag = slot;
>       /*
> -     * QEMU UFS does not currently support Write descriptor and Write attribute,
> +     * QEMU UFS does not currently support Write descriptor,

We might need to check condition here that `query_opcode != 
UFS_UPIU_QUERY_OPCODE_WRITE_DESC`, since

it is not implemented yet.

>        * so the value of data_segment_length is always 0.
>        */
>       req_upiu.header.data_segment_length = 0;
>       req_upiu.qr.opcode = query_opcode;
>       req_upiu.qr.idn = idn;
>       req_upiu.qr.index = index;
> +    req_upiu.qr.selector = selector;
> +    req_upiu.qr.value = attr_value;
> +    req_upiu.qr.length = UFS_QUERY_DESC_MAXLENGTH;
>       qtest_memwrite(ufs->dev.bus->qts, req_upiu_addr, &req_upiu,
>                      sizeof(req_upiu));
>   
> @@ -344,7 +349,7 @@ static void ufs_init(QUfs *ufs, QGuestAllocator *alloc)
>       /* Set fDeviceInit flag via query request */
>       ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
>                      UFS_UPIU_QUERY_OPCODE_SET_FLAG,
> -                   UFS_QUERY_FLAG_IDN_FDEVICEINIT, 0, &utrd, &rsp_upiu);
> +                   UFS_QUERY_FLAG_IDN_FDEVICEINIT, 0, 0, 0, &utrd, &rsp_upiu);
>       g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
>   
>       /* Wait for device to reset */
> @@ -353,7 +358,8 @@ static void ufs_init(QUfs *ufs, QGuestAllocator *alloc)
>           qtest_clock_step(ufs->dev.bus->qts, 100);
>           ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
>                          UFS_UPIU_QUERY_OPCODE_READ_FLAG,
> -                       UFS_QUERY_FLAG_IDN_FDEVICEINIT, 0, &utrd, &rsp_upiu);
> +                       UFS_QUERY_FLAG_IDN_FDEVICEINIT, 0, 0, 0, &utrd,
> +                       &rsp_upiu);
>       } while (be32_to_cpu(rsp_upiu.qr.value) != 0 &&
>                g_get_monotonic_time() < end_time);
>       g_assert_cmpuint(be32_to_cpu(rsp_upiu.qr.value), ==, 0);

