Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840FBC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 14:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZtnH-0005af-2i; Tue, 13 Feb 2024 09:29:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZtnF-0005Zl-8p
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 09:29:53 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZtnC-000684-UH
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 09:29:52 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5dbf7b74402so2923394a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 06:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707834589; x=1708439389;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UvCCkOmtAkWGea6c45GpPu60FEovtNyi55urZOLWW/M=;
 b=H5FguyeZNmLo3DMjqLhi3GgKiemhIi7sp2Huhi8x7l+WQ40+PfRftH3uCadXS7qTHJ
 hZQLR47yf5u3YMtxebB0Q+OSel10cRTF+mKGyww+rjBJfokhW8NnCLdTpR2T8wDnLOe4
 Qet5h57wFXry7kFQOIp9FFvbst2vdQB6h/p6ckeBr/lj62DhfnA3tiJwcggvujbGDSOf
 hg4eAFilTlna/WmkUT44RLcoKGAIG8QAOxzTS/1YcSmDdsThmWWriQ3gfKOocWMyEGnq
 uvOyjRhGOcqGhpTPDfTLDzuxSxnM9AjXXMCsVncSLYfDxJb+c/ncpAG48WuhUPvmveKT
 TEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707834589; x=1708439389;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UvCCkOmtAkWGea6c45GpPu60FEovtNyi55urZOLWW/M=;
 b=iK1qzJ+0dxuWi9tZ3auXAlqgda6pL4DIpIhYVr5TufCktmxt8uVk3Mbf7jesV/vP3d
 J0iIQ0ZOhuL2jRN3D9PDYDSKPQFMWitdh3CEEXYvB+5v88Lmrz+oog++jFxIMLgSSAKQ
 YGjcI9QpWpzYvVy7CGh1akJ5TfVL6LrQpnJ7e++9vL7nUR4S7W6hUD2leetHhFJOGwrc
 lhbcVYpN30BTkSery7y4Aly8LPuJm7Ao5Q50viGK8EQLco2qBMD8S6NGgBEDrKeDy94G
 3ufWQzBFSf+IUFGl+24JzZbnN0oJPTjhQz+ybR9/fMPk8aRwi8L00efnWlbJAtDbRUfu
 1LLA==
X-Gm-Message-State: AOJu0Yzlx0NxyZHrAg48TlUMUyDAwymD+TLXKPoQ2yV2N7+t3tLS0X+B
 Yd/PZkVPJG9L7j3h+Ravm5iH5FNP81+vFF7fkygwNtzL/id32nzMXSt7X3PJZUM=
X-Google-Smtp-Source: AGHT+IHPDwU4lmfpji5Qt+EP95MET5l3c+LRgQX8HvtFSJjkNkm5O0ATDbgruYkA12ZKFE5RZB0s3A==
X-Received: by 2002:a05:6a20:c88a:b0:19e:a6ea:683a with SMTP id
 hb10-20020a056a20c88a00b0019ea6ea683amr8633039pzb.50.1707834589309; 
 Tue, 13 Feb 2024 06:29:49 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVU/YKVOKmLR9PclkDD8DIEOXoYK9Rgt+K0XZcWNF0u6QE7mi+P3qpBKPpGeTZp4agW026fsvokVgHUR+WXlaeGA9lI39Ohi8YFfqmGqyDEWa1ofpEo0V3J+j6QnfplLiR1hPIR7cCHXr1Cfo/WnF26v7mQgKOF/wx0vd1FU/CQATcFIMtFbD4Xeq8wC6QbHRKxiaDGR4xik1KFao84nmLcUgO8kAEhHdkyb2rDXPzDDXFAsoHpR/Ry7GA8urSlfdD6tDAO5HLIj86sJSaAON3mRprEwqn8vjFtAigJEVH8lb79L+G9igsMxLGnKkkkiqUmuwMBrShrwXRqftVzpCiXxj3XeehkUfu8lrAtmsWGP2wpgfTLjzr2/Am6GJpFYPWuNvG61m8N6tRznBJTx2wZ2VJJHtCsSRkxSw==
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 qc5-20020a17090b288500b00296a686dd17sm425791pjb.56.2024.02.13.06.29.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 06:29:48 -0800 (PST)
Message-ID: <8e6a48f0-8938-4a18-a74e-25802ef54d50@daynix.com>
Date: Tue, 13 Feb 2024 23:29:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] pcie_sriov: Validate NumVFs
Content-Language: en-US
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
 qemu-block@nongnu.org
References: <20240212-reuse-v3-0-8017b689ce7f@daynix.com>
 <20240212-reuse-v3-5-8017b689ce7f@daynix.com>
 <20240213055345-mutt-send-email-mst@kernel.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240213055345-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52b.google.com
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

On 2024/02/13 19:59, Michael S. Tsirkin wrote:
> On Mon, Feb 12, 2024 at 07:20:33PM +0900, Akihiko Odaki wrote:
>> The guest may write NumVFs greater than TotalVFs and that can lead
>> to buffer overflow in VF implementations.
>>
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
> 
> Indeed:
>       The results are undefined if NumVFs is set to a value greater than TotalVFs.
> 
> However I note that hw/nvme/ctrl.c will still poke at NumVFs.
> 
> Since it's undefined, I propose a simpler hack and just force it
> to PCI_SRIOV_TOTAL_VF. This way everyone can just assume it's ok.

It is still not OK to poke at NumVFs as the guest may set a different 
number anytime though it's undefined if NumVFs is set while VFs are 
enabled. I think hw/nvme/ctrl.c should be changed to look at 
exp.sriov_pf.num_vfs, which holds the committed NumVFs value.

