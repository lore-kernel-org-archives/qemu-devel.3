Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456F0C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVY5-00044A-JQ; Fri, 08 Mar 2024 03:25:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riVY4-00042x-5V
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:25:48 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riVXy-0001Bf-DL
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:25:47 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33e2774bdc7so1477426f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 00:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709886340; x=1710491140; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2UtfhWlT/vgxdO7tkYN9dNOMDxmAQmSmTg+7eTDb7Ek=;
 b=HaSg9JiNKWCtryMBje0dp4EXcO0LYWGVo89PiGASNMWnknGT0+r0qyrHGroRziSh9k
 DJRdis49Z+APZj3Gc/AD7v40MB7BJGOOQuDDdCTOUbacQRaGQ7W/ODEkTKoxHooyhH7I
 K3HhXUjTPu9JYPsnHgSvKxiwSsaQ0hig4qFANSr6+VjFdFpQYXKAfgP7sye493rNKsRa
 9kaoVynsgcIzp71CXXPi8FGCQFVMV+inqg+QnuxlC7JFUQzpCNcOLpOlVoB7HrZgXmb/
 gFsLQTUSNgxIoveN8cJLTaijh9I+u/A6aULD1DLN6YuE9suO0HicJlfvZPqO2HURBsQe
 +DWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709886340; x=1710491140;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2UtfhWlT/vgxdO7tkYN9dNOMDxmAQmSmTg+7eTDb7Ek=;
 b=Dfki/S9aMThHJ0dUREydTcU+f1GnuXutW4Tn5Gez++TR1ogxYJiMigI/oQSDG1RYNL
 3rVHSEonTlLv7APYtM7pvztxQ4sLb/+R/zGNULRMxbxH65HA8jih2aW53kZmU8aMIHRq
 senWfSAxe5DD87QC12HgsScUB7Fb9vWcAQ7q8L9QIKvZKBlphnNQcVza8ovKA50OmDmL
 pN3jDN4XnYpJdX+8blpbkh/62iGXIQCjzMjtKtTR6LUIqUw1yIBfPXV/jVKbERvx5w06
 y1hcroz/hvW2rVWsnCFcF84qu0x/qqLLBbPIag4b2/aJPTAyjyTEs9zSLOZb9adqMTXS
 B25g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVer8ao8pJ5sJ+co8HiBtb3jjwJcE15WDFQs0MvLAmpkQPCKsZVsfH4mgGC3tIMN6EQrWiTUHwXIJd0C69cYigqGyK3j8A=
X-Gm-Message-State: AOJu0YxQ+oqGqiNTtlZTxmRM8SikIAoeOjFh8VL0x+PzUXt6sUAAqDQX
 8dFC0GiAp0CPoRLqIC2WdMzNmb5/GOUyfmZx/64XP6CdfbJ3X61HBSd8sJYMJ7I=
X-Google-Smtp-Source: AGHT+IEUt7p+YhltOUiuV5RCEJH9DjJaqNBd917VEfSVFP4wi8a+tn5iN8aDB3WtRiGGiAqGmL1RaQ==
X-Received: by 2002:a05:6000:1547:b0:33e:79c5:587a with SMTP id
 7-20020a056000154700b0033e79c5587amr231519wry.36.1709886340626; 
 Fri, 08 Mar 2024 00:25:40 -0800 (PST)
Received: from [192.168.69.100] (pir44-h02-176-184-37-132.dsl.sta.abo.bbox.fr.
 [176.184.37.132]) by smtp.gmail.com with ESMTPSA id
 f15-20020adffccf000000b0033dedd63382sm22328095wrs.101.2024.03.08.00.25.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 00:25:40 -0800 (PST)
Message-ID: <2241e6fa-b40a-4fdf-909c-b3a7ef7ff5a1@linaro.org>
Date: Fri, 8 Mar 2024 09:25:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 9/9] qemu-options.hx: Document the virtio-iommu-pci
 aw-bits option
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 jean-philippe@linaro.org, imammedo@redhat.com, peter.maydell@linaro.org,
 clg@redhat.com, yanghliu@redhat.com, zhenzhong.duan@intel.com
Cc: alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com
References: <20240307134445.92296-1-eric.auger@redhat.com>
 <20240307134445.92296-10-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240307134445.92296-10-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 7/3/24 14:43, Eric Auger wrote:
> Document the new aw-bits option.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> v7 -> v8:
> - remove "it defaults"
> - removed Cedric's R-b
> 
> v4 -> v5
> - tweek the aw-bits option description according to Cédric's
>    suggestion
> ---
>   qemu-options.hx | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

