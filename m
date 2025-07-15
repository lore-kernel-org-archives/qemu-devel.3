Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B85EC83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubcD1-0003cd-05; Tue, 15 Jul 2025 05:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubcCy-0003aB-3h
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:44:20 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubcCw-0001rA-7p
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:44:19 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-451d54214adso35109375e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 02:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752572654; x=1753177454; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=92/KpIS4xN2lywM2qTAoo3osCu0ZvQ2pQnZRgOXDlw8=;
 b=jMBm24WDdwjN9jVHDzk9FG213kN51r30fB2zeg1n5C7eilakHOBmCWC+OYJwhQ6Qtq
 SiV7eubhnm0gWF/LWnGkkkqaevYWLHHH+KeHlg1fvILg0iVnY/OmjSs4+yQ5hx4BzEOt
 Pkp5z4zGFsBMvSyN5fEdPxBPgbyTB/8OiX4w3sqCZVxU0yXs3hB94BC47Y6uO4wL2CKl
 MXBcBcBumKbstAW7RP3uLd0ppE/ecJOq/DB9AJ4S2uixRFDbi2NkEAGZdZ0FQqDlC2SW
 J4kvG4s8z9tJQDBKNcqeJvETUVT0Qf2d+6vOaTUE2ZtG6L14b8BWkq+0exL6jEjqC7BC
 ynwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752572654; x=1753177454;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=92/KpIS4xN2lywM2qTAoo3osCu0ZvQ2pQnZRgOXDlw8=;
 b=E9dDZeFR/b4Ij/JL6YowfV6woRfC1aP1Jaxm8hmaZuTlSn86i5bTbn7E1zTv3+Hm2N
 WTPVSaLi0jZMhxKuh5w+eqWudpnBjs3XRnJ6ojh3+kheUBA6R/3JSAhdvZbFDn65vFT6
 eSsdbAyLzKqBg8Dp16ooJoYkc/FjkwiIIyVmIgRQrxEjH1BasfU8S6NCJ2OFnVoxWz1d
 VQzNVSmr6KgIrPmH9jdHBilpRf+LcgGsba+Gryj9N9+fxQuVKxcM7CBVMst0BABojj0L
 x5WkP3KnjePveXLRqyL5SEYeHR8Efh1u1PNMrZTxvei9vrYSV4M90iNMeNAPhV3t/k91
 S5iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8wPQxF3NmRnEpNFy+Cdpj82luiYpp6PVavtpuWYSVbHAHsLuIpZB3Cbr9MhmcTno5gJQxvbKA1Q/5@nongnu.org
X-Gm-Message-State: AOJu0YzeGCBmqIP4fBJdNTOWGWFLOzAK5n/krG7jepdjyxFRGeA7JKR0
 QMS56RvTBwH/Lhn4bGmvrX4DSIqtNCtBw0q98ovri2zgUk/Vp4dhOfrIyVmd93vh23M=
X-Gm-Gg: ASbGncs6IPODJ8b3Me+JJyk0N4C/xdJ2ssA00WZX6otxlMghnkJXjETgksK/yO84eiq
 tWhCWqQWBjXLEb0Y/4qfny8Cw0JZm2Tk0ntuPUDRxxPHTWax5/NM5rzc8svN1atdNiztpSTrqtl
 SdFeMCnMqmUGrB47fKwqdRhxkjk0ynJrSnQyo3/Kd700HZEfrAdTirT0JRh6p6P4f1tsmeR7rYO
 683WZtUnHHzhUWrNf98tvAzx4koXZ1eSFzNz3w0P91J2ZOcCFY0sXHDMJkdmWSTd3/tsJQi1wbi
 cjm9XkFXBod/XmVTLvoFS1Bxe4zrqthzQHcrlbjoVgqan9/1GtDFnE7Gk/8ExN1otJpkhu/GNzm
 qp/B7V0UEF5Xmm2gflN55hM42ddP8ejqWhXXSnTWej85MW9k0tEJU+5YXbQEsE+8NeakZ2+k=
X-Google-Smtp-Source: AGHT+IE0En+jx2uQ35k78uDfBwdF1pUoWb4cTSBdtbzlm5wt5WFuvhYhpoGd/c67sVWfbh64+lIrrg==
X-Received: by 2002:a05:6000:4412:b0:3a6:d145:e2cc with SMTP id
 ffacd0b85a97d-3b5f187e927mr9287855f8f.15.1752572653982; 
 Tue, 15 Jul 2025 02:44:13 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45617dc1fccsm66178745e9.5.2025.07.15.02.44.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 02:44:13 -0700 (PDT)
Message-ID: <c922aaaf-03a3-43ae-bab0-97711248e1cd@linaro.org>
Date: Tue, 15 Jul 2025 11:44:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/22] vfio/pci.h: update VFIOPCIDevice declaration
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 danielhb413@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-15-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250715093110.107317-15-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 15/7/25 11:25, Mark Cave-Ayland wrote:
> Update the VFIOPCIDevice declaration so that it is closer to our coding
> guidelines: add a blank line after the parent object.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/vfio/pci.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 495fae737d..16f092a0c6 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -132,6 +132,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI_BASE)
>   
>   struct VFIOPCIDevice {
>       PCIDevice pdev;
> +

Could be squashed with #22, anyhow:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>       VFIODevice vbasedev;
>       VFIOINTx intx;
>       unsigned int config_size;


