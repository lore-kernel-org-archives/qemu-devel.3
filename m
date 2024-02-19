Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F8BC48260
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbymk-0004hO-5Y; Mon, 19 Feb 2024 03:13:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbymg-0004gR-A5
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 03:13:54 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbymb-0007iJ-Um
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 03:13:52 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6e104a8e3f7so3427630b3a.1
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 00:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708330427; x=1708935227;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GJE7WmvoKyGzf8BMUc/7C2qmU0izsvbUEFQnBJCvU4k=;
 b=D+AGpfWFFVjV2g/4385zBkRHuyrj0JNchO6XY6wY24VhcS4oWQ3OtYeWTpXGmkYG6g
 ygymRr3950+Wq7uxAzyPMrgV6nVs61xlgZnmBFzrsACsw42FsgYdew1O7Pajtj+EHqvX
 6cRVrkPfMe1KO7tKHy1BEJ8J/0Yg8rvRPylzp7tw3LECt+wx921sVl6ZCvXgWgNO2oYx
 mx5qtxiSOeZYlyP53AiV259wzKPcrFqdp/9NQksy4Od/UiTH9tGQvfPp0Pq4rOjnLEjG
 mWjGwsh2peu3iktEOm45YoQL5CC62eLpPTPVOQOvXBhopc+3g72oZ4Jrv9ls5mU723Ll
 mryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708330427; x=1708935227;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GJE7WmvoKyGzf8BMUc/7C2qmU0izsvbUEFQnBJCvU4k=;
 b=qCJD+V11qVMq+GZjFLxlI4g0tjaBsEgi4YOTxr2hA7ysmc7xoMH4QrHX30wGU2FCxE
 1zQj5j5Ima1qjsqdDwIjH71GxxjCFCqBRNlNwedIZ7mvpGBeNICS01vt7pxwGVNDolC1
 96nP+61E7TFpWiirNznDN2ouQG99qnPoepb31ITfUGJhwBGIl4CAM4QYU8XfdLKR19Z4
 dJ6CAfqnJqJZQrK4L62drmTpgiweCF/qhRejjy2o+QkkZ82RqZ9/msw0AjujF6qh5l1/
 Cn7S64Wx7tv2rGF6t1o8iLTy93Z2YnRvxDs+ib9aT/tfhc2Hx5sUHBrn20GL0UiVyYZ8
 HXxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuc6db0fePRRlrx4jb2KhvCNe1LJg2Sl3r/BQOZqczcUDDHwSW4no8ERS5NDp8SiGxhUTXNWynh+XWPbSlfH14+Nwilxo=
X-Gm-Message-State: AOJu0YwEx24L71EvVGm3yoetGyA1nXDkZ0KCZJtiprXwhqvJL9YUBP4R
 GkyuM3OOQqz6xMgJnVLVVnMqUuySyKYf0UKl/iybD0YM6fDgZun1aQb4eh+YXHY=
X-Google-Smtp-Source: AGHT+IEB/eZXg8XJIdj3L6MJKa0eA7Ygczic6w79kTmirbr2tPdtnQZ3wHedCJTFV2DHVYO6ICSxMw==
X-Received: by 2002:a05:6a21:8cc4:b0:199:7d51:a942 with SMTP id
 ta4-20020a056a218cc400b001997d51a942mr17501990pzb.50.1708330427476; 
 Mon, 19 Feb 2024 00:13:47 -0800 (PST)
Received: from [157.82.200.138] ([157.82.200.138])
 by smtp.gmail.com with ESMTPSA id
 e21-20020a17090ac21500b00298dd684b8csm4636756pjt.32.2024.02.19.00.13.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 00:13:47 -0800 (PST)
Message-ID: <93c846d1-c071-463a-87b2-45570c9ef80e@daynix.com>
Date: Mon, 19 Feb 2024 17:13:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/11] pcie_sriov: Validate NumVFs
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-stable@nongnu.org
References: <20240218-reuse-v5-0-e4fc1c19b5a9@daynix.com>
 <20240218-reuse-v5-2-e4fc1c19b5a9@daynix.com>
 <20240218123556-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240218123556-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 2024/02/19 2:36, Michael S. Tsirkin wrote:
> On Sun, Feb 18, 2024 at 01:56:07PM +0900, Akihiko Odaki wrote:
>> The guest may write NumVFs greater than TotalVFs and that can lead
>> to buffer overflow in VF implementations.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: 7c0fa8dff811 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   hw/pci/pcie_sriov.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
>> index a1fe65f5d801..da209b7f47fd 100644
>> --- a/hw/pci/pcie_sriov.c
>> +++ b/hw/pci/pcie_sriov.c
>> @@ -176,6 +176,9 @@ static void register_vfs(PCIDevice *dev)
>>   
>>       assert(sriov_cap > 0);
>>       num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
>> +    if (num_vfs > pci_get_word(dev->config + sriov_cap + PCI_SRIOV_TOTAL_VF)) {
>> +        return;
>> +    }
>>   
>>       dev->exp.sriov_pf.vf = g_new(PCIDevice *, num_vfs);
> 
> 
> This reminds me: how is this num_vfs value set on migration?

That's a good point... Actually no consideration of migration is made 
and SR-IOV is completely broken with it.

