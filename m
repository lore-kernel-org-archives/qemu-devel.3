Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36D7E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4oB-0007QW-R4; Tue, 07 Jan 2025 03:19:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1tV4o8-0007Pv-Fj
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:19:24 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1tV4o6-0005nW-Th
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:19:24 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21a7ed0155cso1816995ad.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736237961; x=1736842761; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bsVaQSU+SKN6xlpHRBfPGuVJQwveGYniAv/EHWcQWGc=;
 b=Bh/4pxUosaVUY2u7fzOGQsobAgifOc0agtgeLn9M0drLKaRFIZu9VZo5phhMBlz5N3
 uHvTp7AO4YSUtr0qB+4JTI5AtFgbBWpptEmJwZz4SOuDAh6O+5nCTt+WG7ef/CvzWC6B
 cWnzvs6wg87k/6sAnIp81YfG6As5dkqY/atk7SMW+aB8HySJ0i79+0jfciKeqkszVVh0
 nTua7+wr5efa2VXP6bqpdnNphXau1w5n4RFvijYO30SfAWk/J2+iANHaetY4jkhsMe1i
 8KvcpuFVHW5t7TDkbhVNoTYKkew5aItGWaNcgi3ToJXiB+t9wqrJ4EXMsLlbUI7UhE/k
 jh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237961; x=1736842761;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bsVaQSU+SKN6xlpHRBfPGuVJQwveGYniAv/EHWcQWGc=;
 b=Bn3gvm+iJnGjkw4b/wM9HesklZrX0s2WwEM1gjnUCkimaumXYbIdSpDMEVDOwTNbdm
 4A9o0kX0sl97GojVDCW09Sak2nNGoWijnsagVdRO38GBwKr/D9dtSaO+yfGuz74cxUCa
 yG8E1JbcvSK2KZbJC3fvdhONZgtfXjeZRzUtAXYXmlnts3zac5N/i973UiLNcQNaPyBq
 ZNBsiJWhyUEZ4Pvf1wGerTGdWF2Q9v5DI/FREMDHOKxwJOhPs5y69FJaqcasYnpyq1ja
 9VTNy2OxtCOkkC+DmZvd9D8Otz7KrRDmOcnuzJWtbDxO0cxkflb7YnVGOXM9cG11tI4H
 r5Nw==
X-Gm-Message-State: AOJu0Yz76gqaV/anphtrsEv7sGQpo8Oems0b9XJcL2vG8JgXySJicFHH
 M0sO+hkMUUzuxo8FynoCZF/kbWfLWt/TD1YSxDNFBz9l/DlkYbERfTIWwCRF
X-Gm-Gg: ASbGncuqgUGfeglVxCEP6dRP5VdHVroeftUYeZh6ZecnaI7TEihqfEI2ObulqceG4Kw
 lmEvFoOli96AgGO68o7CBgH7mBraE21AEK3x0uNc32IHNIG1wFMoO7uGXGlpuTLA1AixIRIB2Nn
 OGT5KgOEU6pLbuMjHGMXt6nqrQKBlt09h6JVhr9KXKP2Rd2qxHcPf4w1IZOs+zbOO5C44CG4esx
 8qgrbUZFSwZQq3jpJpHaNVDjzRIRf2sblTQjEaTYH1yGX7xQQKYG0xLfe+bqWOSrfWW6RE=
X-Google-Smtp-Source: AGHT+IHyz/2bLq6xxdE3XEgpT1xuHtGq4u/ofH3hBrvXj5GJmgwjxIxXhC5nJl6p/REawySu+DZjkg==
X-Received: by 2002:a05:6a00:3cc1:b0:725:df1a:288 with SMTP id
 d2e1a72fcca58-72abe18acb0mr84193154b3a.24.1736237960946; 
 Tue, 07 Jan 2025 00:19:20 -0800 (PST)
Received: from [192.168.0.22] ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fd610sm32669322b3a.136.2025.01.07.00.19.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 00:19:20 -0800 (PST)
Message-ID: <97d74ec1-4a13-4726-9584-09dada83c1dc@gmail.com>
Date: Tue, 7 Jan 2025 17:19:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ufs: Adjust value to match CPU's endian format
To: keosung.park@samsung.com, Jeuk Kim <jeuk20.kim@samsung.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <CGME20250107070209epcms2p8b39b26cf5a32a7b66246f2d122005f29@epcms2p8>
 <20250107070209epcms2p8b39b26cf5a32a7b66246f2d122005f29@epcms2p8>
Content-Language: ko
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <20250107070209epcms2p8b39b26cf5a32a7b66246f2d122005f29@epcms2p8>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x632.google.com
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


On 1/7/2025 4:02 PM, Keoseong Park wrote:
> In ufs_write_attr_value(), the value parameter is handled in the CPU's
> endian format but provided in big-endian format by the caller. Thus, it
> is converted accordingly.
>
> Signed-off-by: Keoseong Park <keosung.park@samsung.com>
> ---
>   hw/ufs/ufs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
> index 8d26d13791..428fe927ad 100644
> --- a/hw/ufs/ufs.c
> +++ b/hw/ufs/ufs.c
> @@ -1164,7 +1164,7 @@ static QueryRespCode ufs_exec_query_attr(UfsRequest *req, int op)
>           value = ufs_read_attr_value(u, idn);
>           ret = UFS_QUERY_RESULT_SUCCESS;
>       } else {
> -        value = req->req_upiu.qr.value;
> +        value = be32_to_cpu(req->req_upiu.qr.value);
>           ret = ufs_write_attr_value(u, idn, value);
>       }
>       req->rsp_upiu.qr.value = cpu_to_be32(value);


Thank you for fixing this bug!
I reviewed the changes and noticed that some changes to |ufs-test| are 
also needed to fully fix the problem.

Could you please include the following changes and send a v2 patch? 
Thank you.


diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 60199abbee..1f860b41c0 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -145,7 +145,7 @@ static void ufs_send_query(QUfs *ufs, uint8_t slot, 
uint8_t query_function,
      req_upiu.qr.idn = idn;
      req_upiu.qr.index = index;
      req_upiu.qr.selector = selector;
-    req_upiu.qr.value = attr_value;
+    req_upiu.qr.value = cpu_to_be32(attr_value);
      req_upiu.qr.length = UFS_QUERY_DESC_MAX_SIZE;
      qtest_memwrite(ufs->dev.bus->qts, req_upiu_addr, &req_upiu,
                     sizeof(req_upiu));


