Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90316C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 14:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNBW6-0008WH-Vp; Thu, 05 Jun 2025 10:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uNBW2-0008VM-9i
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 10:24:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uNBVy-0001si-Vw
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 10:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749133456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=f855TIziVmCXvNE138r+Ybnl0nkQZNKWUJYDAoHnybs=;
 b=c4xxrA6fp4M9LURaPCZMcNslfR5L1L7caqqq8JQgBoB3Em54w4pCFlLlZI8Ptk1LfFcxw8
 GbhyTrHRh3XYvufff8BZhoPySx+zDvL6bXvbi91ytB+ruaZVx8ZVdHX0U3dXhgjkLYP1Uv
 WmapMtIBs3KsEmQVF5Qp9q9pXXHUiwQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-Xg_wvNnYNGCAPM-JESkpNw-1; Thu, 05 Jun 2025 10:24:14 -0400
X-MC-Unique: Xg_wvNnYNGCAPM-JESkpNw-1
X-Mimecast-MFC-AGG-ID: Xg_wvNnYNGCAPM-JESkpNw_1749133454
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4f55ea44dso496748f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 07:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749133453; x=1749738253;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f855TIziVmCXvNE138r+Ybnl0nkQZNKWUJYDAoHnybs=;
 b=Gh8cc6WGVxd/JMfHG9yHn69/3108WGyl9dxggexeMKYGFUUZp8CbmebfGdWJE4ofmR
 g3jOICLN1Opo6BJpq/A9eRk3rMh//RC/KFmskRiOG3xuUCtTUUiyPfpIsT2SN69qhSPb
 D7Vb1ILF/nWY/rUjOW1IJ9cJDvm6UCa3LWvua1lHEDYYkQtkfhcNSXBGHpFLa6g26/qR
 GF1ph2LfN4x0RfMktgsORnvMJJe/d4SyJlbCcXa3OlZL7RyMFgffv9OTEBNF0ymlmSwb
 psdv4RzVvMRyfPJNVxBTsAp8keaoW78IcCTQueIAlNXvVyp5Rw0amGYk1I/zmsQev9QB
 bnuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVunJKj6HMXC+w/YXUQbHdNo6fqgyikbJ66EWfmklfa83KPbN1/JI24gqnAr4pUt8LopK+qU7it7lam@nongnu.org
X-Gm-Message-State: AOJu0Yyhgy/bgFD7h5N/LZhkd056+LJOikl8a4JJq5H9ii5uc0dMjDAi
 trm1UCIvsiwN6DwAqeasuBOwqLeUgLgV8SIQ0pbPbsuAhBC5EXgjf7bp9zKYBdbYnMidqFEIuP7
 7UJXsBMUlpgnUoiTnRQOtfgpKfZ0iXjz1+/H2aopceILzJsruy1ArJk9/
X-Gm-Gg: ASbGncuGFJqNPHxc3GPUrx3euleixaWtWZBpja2A1Cd4GimJPUvelpe0JzzzPU3Ai5G
 cdkA1yjfFbwEdDTHAPp0qJVzlGOyxxnQUCz4clFKy0xomCZt8WM8dRsHQ/+6+ZLQu45JNha2GQ6
 S5wZrowBSoZmG+5tkqJPgqccxyeKnps2kpkok8rMiNajNORNyhxC678LHGHFAFhMTUY81SnT+Ph
 Q35HjaFMhmLi7HrSDcklsKYIAuJ+69NKPFTowkKKnZG3Ne7Zu15embMlOmAXsBUQ+yG8r6wyF5c
 JOquxQHzt2bjF3iAefmbJEOg/k2Iu4V6WtPbZQHJayBZGexW/Y00/PiENK2x6q4DA7usSmd4oup
 nBheR3wWEs+urGUjdPuv01pD7i81AiYgN+GM=
X-Received: by 2002:a5d:5f46:0:b0:3a4:eef9:818a with SMTP id
 ffacd0b85a97d-3a51d966588mr6199885f8f.27.1749133453590; 
 Thu, 05 Jun 2025 07:24:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSS94134ciHp/zwuKULja794auUGyxyiFQJ7l7wtD+wImZVyWeDPfp62USlkIfjJkaQypTXA==
X-Received: by 2002:a5d:5f46:0:b0:3a4:eef9:818a with SMTP id
 ffacd0b85a97d-3a51d966588mr6199855f8f.27.1749133453195; 
 Thu, 05 Jun 2025 07:24:13 -0700 (PDT)
Received: from ?IPV6:2a01:cb01:54:3894:a12c:7ed9:4ede:d4f5?
 (2a01cb0100543894a12c7ed94eded4f5.ipv6.abo.wanadoo.fr.
 [2a01:cb01:54:3894:a12c:7ed9:4ede:d4f5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5247363a9sm3566830f8f.24.2025.06.05.07.24.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 07:24:12 -0700 (PDT)
Message-ID: <2030db73-4f1e-46ed-98ea-c469e8b0ecea@redhat.com>
Date: Thu, 5 Jun 2025 16:24:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ramfb: Add property to control if load the romfile
To: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Shaoqin Huang <shahuang@redhat.com>, qemu-arm@nongnu.org,
 Eric Auger <eauger@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
References: <20250605030351.2056571-1-shahuang@redhat.com>
 <746b078e-bd06-4361-aec7-2301412abb18@linaro.org>
 <kep5frpl24d74evoyf367pqkyoj6xez2pirk7xlzcoompyzq4c@ouxab77sdm55>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <kep5frpl24d74evoyf367pqkyoj6xez2pirk7xlzcoompyzq4c@ouxab77sdm55>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/5/25 14:21, Gerd Hoffmann wrote:
>    Hi,
> 
>>> Now the ramfb will load the vgabios-ramfb.bin unconditionally, but only
>>> the x86 need the vgabios-ramfb.bin, this can cause that when use the
>>> release package on arm64 it can't find the vgabios-ramfb.bin.
> 
>> Simpler to directly pass the ROM path instead of using a boolean,
>> so board (or CLI) could pass path to non-x86 rom.
> 
> The rom is loaded into a fw_cfg file which only seabios will look at.
> So this rom logic is x86-specific.
> 
> edk2 ships an EFI driver for ramfb, that is how ramfb is used on !x86
> platforms today, and I don't expect that to change.

Should we also set the vfio-pci::ramfb-romfile property to false in
a compat property for ARM machines then ? I don't know for RISC-V and
PPC.


C.
  
> IMHO a bool is perfectly fine here, I don't think we will ever need the
> flexibility to specify some other rom here.
> > take care,
>    Gerd
> 


