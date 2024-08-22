Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C481EC531DF
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 05:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh0ZH-00052Z-Qe; Thu, 22 Aug 2024 01:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sh0Z0-00051J-Gq
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 01:40:52 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sh0Yv-0005Eo-Gj
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 01:40:47 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3db13410adfso260357b6e.2
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 22:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724305235; x=1724910035; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WBF7JycDkh5LPh3xYeS1xPEqDIa22Mgy6xyF04wQHFY=;
 b=cckZXr0asYq/oyBO2hugz85RQkncAok6+QfvI3nZ8FlUQtnYBV1Tw2/vVn/jF5zjvG
 pIpk9B1Mr9zSo8YiI/fv2vm36+7AIeKgt4c7ffatUpM+tn03t1MSINsrLR6y7cl4n8vs
 kOI5UpUiXM3r9NMt8a9r+cVnNJQh84qY49czZOFsXwlBaL2C7+J+M6FYqK8cl/BFX1N0
 292Wv9VI+JpYVVTSCtnWW4phYyFPOLzgw2OFHmH63/UxhsSGOZj/bpbOJFZRuO2MbgJ+
 lGgUFAvPqpBi8nlk6s7YaIDbuPY7DRooJWX6G9LZbgp6ukEbSitCXXvb3qffrB4zOCee
 AuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724305235; x=1724910035;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WBF7JycDkh5LPh3xYeS1xPEqDIa22Mgy6xyF04wQHFY=;
 b=OE930JJr/X7HlI41aVXeHwfYA6m9YZHAy9Wz1Vpi1PJm5wGS4ZZujxvqnFrdTGTDIz
 fjqyZw5p1snktvkD1S/w0jbiMVt9BlP6C4B6nFVe7CQef88G+souophXLWAg5Cl0WrzF
 AXIGyj2aOsEvoyKKpfXNV71O7Tfhvr2UscEW58jQ7h7Ky0UPnWF3PuhlQM8fTYrMugMf
 9Rvzdbxffz4F+xLQWLnIq3o+uvliWb2sv5iCVANXhPJI/tXFyQ8pqA52woVK9iHwla4w
 5ULmsaOO75JJM8e6BPIMRgwq+gdlqwHD3n/uP5h9Z7DzH0LDW5BhhGkRnfYwex+e1ERf
 AvAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHlAufg3BaW9qaHJ7oXSIeOGxurM4nOIAWMUkEs15Bqv0n3l3uNHfs9YZ9asGHhwlNegmozgUmVa+J@nongnu.org
X-Gm-Message-State: AOJu0YzoIdsErFOvWj8x549Vgxm0gIAIYxJMgYZDK81Ku8KTC4wqNHOo
 HoxWdpWzzSvJpbiCyyDTyy/2CmaG7+UDbxl4LkogQWsvKvYik/Oj
X-Google-Smtp-Source: AGHT+IEi0yh75aVovWTh6Oaz9KWnOjbm3rxiWKUc7fSPqnUnvB/z1CX8o6xYG5HY+Mg0pwi+W6cNDA==
X-Received: by 2002:a05:6808:e8a:b0:3da:a6b7:4803 with SMTP id
 5614622812f47-3de195176b4mr5812862b6e.2.1724305235291; 
 Wed, 21 Aug 2024 22:40:35 -0700 (PDT)
Received: from [192.168.0.22] ([210.223.46.112])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7cd9ad56c5esm534166a12.75.2024.08.21.22.40.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 22:40:34 -0700 (PDT)
Message-ID: <0c0e649a-f31a-4051-a976-97943f85b951@gmail.com>
Date: Thu, 22 Aug 2024 14:40:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] hw/ufs: ufs descriptor read test implemented
Content-Language: ko
To: yc01.jeong@samsung.com, Jeuk Kim <jeuk20.kim@samsung.com>
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jeongyuchan0629@gmail.com" <jeongyuchan0629@gmail.com>
References: <20240821023025epcms1p4de36db95f4d3a66727f128ef6be860e4@epcms1p4>
 <CGME20240821022726epcms1p127d8cd71ca3e1354592de8a4a5c97a10@epcms1p1>
 <20240822013925epcms1p112662453b1f4dcef8bc1e2f101bb6e6a@epcms1p1>
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <20240822013925epcms1p112662453b1f4dcef8bc1e2f101bb6e6a@epcms1p1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-oi1-x236.google.com
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


On 8/22/2024 10:39 AM, Yoochan Jeong wrote:
>  From 936ef0a907bcf16809f9980c2d37e8fcb13697d2 Mon Sep 17 00:00:00 2001
> From: Yoochan Jeong <yc01.jeong@samsung.com>
> Date: Wed, 21 Aug 2024 09:09:54 +0900
> Subject: [PATCH 4/4] hw/ufs: ufs descriptor read test implemented

Remove it.


>
> New test function "ufstest_desc_request" added, which can check one's
> virtual UFS device can properly read and its descriptor data.
> (Writing descriptors are not implemented yet.)
> The testcases attempt to read all kinds of descriptors at least once,
> except for configuration descriptors (which are not implemented yet.)
> There are some testcases that are intended to make an error caused by
> an invalid index value or an invalid selector value.
>
> Based on: 20240802051902epcms2p319bc095a15eaef8de4e6955f6718371d@epcms2p3
> Signed-off-by: Yoochan Jeong <yc01.jeong@samsung.com>
> ---
>   tests/qtest/ufs-test.c | 155 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 155 insertions(+)
>
> diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
> index a8fd2f1acc..f96061f922 100644
> --- a/tests/qtest/ufs-test.c
> +++ b/tests/qtest/ufs-test.c
> @@ -785,6 +785,160 @@ static void ufstest_attr_request(void *obj, void *data, QGuestAllocator *alloc)
>       ufs_exit(ufs, alloc);
>   }
>   
> +static void ufstest_desc_request(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QUfs *ufs = obj;
> +
> +    UtpTransferReqDesc utrd;
> +    UtpUpiuRsp rsp_upiu;
> +    ufs_init(ufs, alloc);
> +
> +    /* Write Descriptor is not supported yet */
> +
> +    /* Read Device Descriptor */
> +    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
> +                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_DEVICE,
> +                   0, 0, 0, &utrd, &rsp_upiu);
> +    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
> +    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
> +    g_assert_cmpuint(rsp_upiu.qr.opcode, ==, UFS_UPIU_QUERY_OPCODE_READ_DESC);
> +    g_assert_cmpuint(rsp_upiu.qr.idn, ==, UFS_QUERY_DESC_IDN_DEVICE);
> +    g_assert_cmpuint(rsp_upiu.qr.data[0], ==, sizeof(DeviceDescriptor));
> +    g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_DEVICE);
> +
> +    /* Read Configuration Descriptor is not supported yet*/
> +
> +    /* Read Unit Descriptor */
> +    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
> +                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_UNIT, 0,
> +                   0, 0, &utrd, &rsp_upiu);
> +    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
> +    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
> +    g_assert_cmpuint(rsp_upiu.qr.data[0], ==, sizeof(UnitDescriptor));
> +    g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_UNIT);
> +    g_assert_cmpuint(rsp_upiu.qr.data[2], ==, 0);
> +
> +    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
> +                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_UNIT, 1,
> +                   0, 0, &utrd, &rsp_upiu);
> +    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
> +    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
> +    g_assert_cmpuint(rsp_upiu.qr.data[0], ==, sizeof(UnitDescriptor));
> +    g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_UNIT);
> +    g_assert_cmpuint(rsp_upiu.qr.data[2], ==, 1);
> +
> +    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
> +                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_UNIT,
> +                   UFS_UPIU_RPMB_WLUN, 0, 0, &utrd, &rsp_upiu);
> +    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
> +    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
> +    g_assert_cmpuint(rsp_upiu.qr.data[0], ==, sizeof(RpmbUnitDescriptor));
> +    g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_UNIT);
> +    g_assert_cmpuint(rsp_upiu.qr.data[2], ==, UFS_UPIU_RPMB_WLUN);
> +
> +    /* Read Interconnect Descriptor */
> +    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
> +                   UFS_UPIU_QUERY_OPCODE_READ_DESC,
> +                   UFS_QUERY_DESC_IDN_INTERCONNECT, 0, 0, 0, &utrd, &rsp_upiu);
> +    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
> +    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
> +    g_assert_cmpuint(rsp_upiu.qr.data[0], ==, sizeof(InterconnectDescriptor));
> +    g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_INTERCONNECT);
> +    g_assert_cmpuint(rsp_upiu.qr.data[2], ==, 0x01);

Depending on the ufs version, the unipro version can vary.

Although they are currently 0x180 & 0x410, they should be 0x200 & 0x500 
in ufs v4.0

So I don't think it's a good idea to test these with fixed values. 
Please remove it.

> +    g_assert_cmpuint(rsp_upiu.qr.data[3], ==, 0x80);
> +    g_assert_cmpuint(rsp_upiu.qr.data[4], ==, 0x04);
> +    g_assert_cmpuint(rsp_upiu.qr.data[5], ==, 0x10);
> +
> +    /* Read String Descriptor */
> +    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
> +                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_STRING,
> +                   0, 0, 0, &utrd, &rsp_upiu);
> +    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
> +    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
> +    g_assert_cmpuint(rsp_upiu.qr.data[0], ==, 0x12);
> +    g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_STRING);
> +
> +    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
> +                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_STRING,
> +                   1, 0, 0, &utrd, &rsp_upiu);
> +    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
> +    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
> +    g_assert_cmpuint(rsp_upiu.qr.data[0], ==, 0x22);
> +    g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_STRING);
> +
> +    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
> +                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_STRING,
> +                   4, 0, 0, &utrd, &rsp_upiu);
> +    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
> +    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
> +    g_assert_cmpuint(rsp_upiu.qr.data[0], ==, 0x0a);
> +    g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_STRING);
> +
> +    /* Read Geometry Descriptor */
> +    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
> +                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_GEOMETRY,
> +                   0, 0, 0, &utrd, &rsp_upiu);
> +    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
> +    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
> +    g_assert_cmpuint(rsp_upiu.qr.data[0], ==, sizeof(GeometryDescriptor));
> +    g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_GEOMETRY);
> +
> +    /* Read Power Descriptor */
> +    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
> +                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_POWER, 0,
> +                   0, 0, &utrd, &rsp_upiu);
> +    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
> +    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
> +    g_assert_cmpuint(rsp_upiu.qr.data[0], ==,
> +                     sizeof(PowerParametersDescriptor));
> +    g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_POWER);
> +
> +    /* Read Health Descriptor */
> +    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
> +                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_HEALTH,
> +                   0, 0, 0, &utrd, &rsp_upiu);
> +    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
> +    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
> +    g_assert_cmpuint(rsp_upiu.qr.data[0], ==, sizeof(DeviceHealthDescriptor));
> +    g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_HEALTH);
> +
> +    /* Invalid Index (Intended Failure) */
> +    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
> +                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_UNIT, 4,
> +                   0, 0, &utrd, &rsp_upiu);
> +    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==,
> +                     UFS_OCS_INVALID_CMD_TABLE_ATTR);
> +    g_assert_cmpuint(rsp_upiu.header.response, ==,
> +                     UFS_QUERY_RESULT_INVALID_INDEX);
> +
> +    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
> +                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_STRING,
> +                   5, 0, 0, &utrd, &rsp_upiu);
> +    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==,
> +                     UFS_OCS_INVALID_CMD_TABLE_ATTR);
> +    g_assert_cmpuint(rsp_upiu.header.response, ==,
> +                     UFS_QUERY_RESULT_INVALID_INDEX);
> +
> +    /* Invalid Selector (Intended Failure) */
> +    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
> +                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_DEVICE,
> +                   0, 1, 0, &utrd, &rsp_upiu);
> +    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==,
> +                     UFS_OCS_INVALID_CMD_TABLE_ATTR);
> +    g_assert_cmpuint(rsp_upiu.header.response, ==,
> +                     UFS_QUERY_RESULT_INVALID_SELECTOR);
> +
> +    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
> +                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_STRING,
> +                   0, 1, 0, &utrd, &rsp_upiu);
> +    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==,
> +                     UFS_OCS_INVALID_CMD_TABLE_ATTR);
> +    g_assert_cmpuint(rsp_upiu.header.response, ==,
> +                     UFS_QUERY_RESULT_INVALID_SELECTOR);
> +
> +    ufs_exit(ufs, alloc);
> +}
> +
>   static void drive_destroy(void *path)
>   {
>       unlink(path);
> @@ -854,6 +1008,7 @@ static void ufs_register_nodes(void)
>       qos_add_test("read-write", "ufs", ufstest_read_write, &io_test_opts);
>       qos_add_test("flag read-write", "ufs", ufstest_flag_request, &io_test_opts);
>       qos_add_test("attr read-write", "ufs", ufstest_attr_request, &io_test_opts);
> +    qos_add_test("desc read-write", "ufs", ufstest_desc_request, &io_test_opts);

Why don't we use `ufstest_query_flag_request` & 
`ufstest_query_attr_request` & `ufstest_query_desc_request`?

It looks more clear to me.

>   }
>   
>   libqos_init(ufs_register_nodes);

