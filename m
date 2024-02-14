Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD489C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 14:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raGeR-0006FP-GM; Wed, 14 Feb 2024 09:54:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1raGeP-0006EL-Uy
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 09:54:18 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1raGeO-0003FS-5v
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 09:54:17 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5cddc5455aeso3887682a12.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 06:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707922453; x=1708527253;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iaJllG92Mbpr+8QyLZfb4eFbcVwYXcvmjpcnX6ZkzvM=;
 b=Be8E+JvSmuCfT8qcfjJ1SQNl6/HAiXoD7oXWeCojIzr2iLqh3+gSoAJ9+q6tFod5zJ
 KiurVcuZWWr3HsBEFPgJpIkd6KiFi76Dv5Ehdl1gUR06fBP6pbHHgP3KKkt3yyINksaC
 h2M5xn4dQ8QT3DHhhaOq/Ec9/gz740gH+53dsIFZIv+Kd08FMVES/N8ZoF3uHYT4tQLj
 RYKAU9fis2RJDzajfU8aXODrHQnQo45gBIUBqwozhFU7l0SQXFZ2fct0oBULyPlWcvi5
 JWdLgz/nq/ZG80fCnrTgVARsO+8DuEjVkARsMQKRpJbfYyjnTItU6CTkghvwyX/4b5ME
 xj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707922453; x=1708527253;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iaJllG92Mbpr+8QyLZfb4eFbcVwYXcvmjpcnX6ZkzvM=;
 b=ifDg66VuvfzmCnKDhJxO7f+RXwsK14/d+SYjH9eNW3PQwBvZIM4vMGWPeNsAG/2385
 lb6GEm57zQbSfWx+spBtSxLT4UxE2gm2afsZJ27Kbgfsjx0dyf5G0mxFl9ey0FHuXBQN
 Ac6cj8wJDJIUiiOvSxp+vA7aGpsACThYNIjts/i7LUzq9P/oK7lW8EfufCsbxFblDcIc
 ji95g+KH9NlEznfIdOcILIs5P2jctKfMQeie9isvMhomq03XWZ9mgLoMu/FSh0v6A5Vz
 Tj4+EWzZEX5tQHEB6TWx64AF4pduC0k5ssl4gPful5C/B6XMGgktxpCOCK/j/5xD78xy
 3MPg==
X-Gm-Message-State: AOJu0Yyqdk5GgLeNbfmb9rApt1E0TlZdQA+O24+E3IgRpoxzJ6HGMgx6
 OWfYwGvNGvkwfKCzu9Gmjzdo1+pnYrbQo4B0kj//8XQ0KyZlwE9MIEC20cnI2Y4=
X-Google-Smtp-Source: AGHT+IE+tCA0HL4IvokG46MyruLy/PfXbgiLidGyQO7fb/Rl+ssJwlXcfEULA4y/ElsKvLUH1WEVEg==
X-Received: by 2002:a17:90a:fb58:b0:296:efd0:c19e with SMTP id
 iq24-20020a17090afb5800b00296efd0c19emr2462871pjb.41.1707922453547; 
 Wed, 14 Feb 2024 06:54:13 -0800 (PST)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 m6-20020a17090a34c600b00298b9f662ccsm1662234pjf.1.2024.02.14.06.54.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Feb 2024 06:54:13 -0800 (PST)
Message-ID: <56e83476-f607-482e-a9f2-e473148de839@daynix.com>
Date: Wed, 14 Feb 2024 23:54:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] pcie_sriov: Validate NumVFs
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 qemu-stable <qemu-stable@nongnu.org>
References: <20240214-reuse-v4-0-89ad093a07f4@daynix.com>
 <20240214-reuse-v4-5-89ad093a07f4@daynix.com>
 <bd6328d1-6568-4ac1-9be4-293bccc722e3@tls.msk.ru>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <bd6328d1-6568-4ac1-9be4-293bccc722e3@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::530;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/02/14 17:58, Michael Tokarev wrote:
> 14.02.2024 08:13, Akihiko Odaki wrote:
>> The guest may write NumVFs greater than TotalVFs and that can lead
>> to buffer overflow in VF implementations.
> 
> This seems to be stable-worthy (Cc'd), and maybe even CVE-worthy?

Perhaps so. The scope of the bug is limited to emulated SR-IOV devices, 
and I think nobody use them except for development, but it may be still 
nice to have a CVE.

Can anyone help assign a CVE? I don't know the procedure.

Regards,
Akihiko Odaki

> 
> Thanks,
> 
> /mjt
> 
>> Fixes: 7c0fa8dff811 ("pcie: Add support for Single Root I/O 
>> Virtualization (SR/IOV)")
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   hw/pci/pcie_sriov.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
>> index a1fe65f5d801..da209b7f47fd 100644
>> --- a/hw/pci/pcie_sriov.c
>> +++ b/hw/pci/pcie_sriov.c
>> @@ -176,6 +176,9 @@ static void register_vfs(PCIDevice *dev)
>>       assert(sriov_cap > 0);
>>       num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
>> +    if (num_vfs > pci_get_word(dev->config + sriov_cap + 
>> PCI_SRIOV_TOTAL_VF)) {
>> +        return;
>> +    }
>>       dev->exp.sriov_pf.vf = g_new(PCIDevice *, num_vfs);
>>
> 

