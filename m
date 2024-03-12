Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2AF2C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 19:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk7n8-0003VL-CY; Tue, 12 Mar 2024 15:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk7n5-0003UY-Lg
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 15:28:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk7n4-0001Qe-9u
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 15:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710271677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dpd8jeFnO50PSi1haA/KCQahhKW4QjVb1g+TiTd+m9o=;
 b=GyBlc37w27upwBd4M2hY8KYR1QA/AXtQJgpuAGljMlifhDaBRrn3XJ8LvKvE4+YxjdNaLN
 M4LX7hcEbmAXC0GZmG+i4GgENnpMfUdJwHDPU20edAnXKIXKj6dBbSZWXQd4cezm4ZTEpL
 W5aT01J3KhM9fyYNTOdRTEHrNP+o0K0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-X8ShPgUZPjSEMJQxvAlCCA-1; Tue, 12 Mar 2024 15:27:55 -0400
X-MC-Unique: X8ShPgUZPjSEMJQxvAlCCA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a45c994ba7cso14896366b.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 12:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710271673; x=1710876473;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dpd8jeFnO50PSi1haA/KCQahhKW4QjVb1g+TiTd+m9o=;
 b=qB3tT1c9Pjo3+gSQ4XP1EHK4snGPzDfybzKCev1Ii66nep76k/22At+Lna2XcSKpR3
 MLwk9zG/3klXfJR5pxD9gEfLYz83GgET9hpthjWPyB2rbVs6W6KYuHwkW+MtAJZ1uVfK
 PLmbDwM4Z0BqBZ96+jJn27PcArIo3R/ZA+miht/6uJxVgvx+WsO3n8XG7wzPGWTDpFBX
 XNDXLFZlB9SwyV9cAtExxv0jl7O1Bsv8hgL+RyOugLZS++MJeQ6WKefu86ePcplU5k0k
 XXT/9Fhek2okduF2LhRYOTQSAqg9LLatIlRAkvUdqBd8dIPL1A0SyGNkWGTUWV1FdQM2
 vUVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDsNuMMpTAiS4be/HdmOh4ls/IPzSdXnoY8YsV5Zs+vO+T+V3JQ3AYo615TglmTws6MCmG2e+oGIKNmoEWM/oB0exuYcY=
X-Gm-Message-State: AOJu0Yye7W+x0P/MMd1E9AOofA3wZeXV7nfWhh/Ia7xQkJ95/Au7pRBV
 N9r9Pd727bfdwTgLbKj6fVhev/13T34W1QwtFSDkspnOQaEZR1LChWn1q4IvCmkPsObHoeeUQrX
 HX7FF8eLSPsuPdoxbW2WtWPXa2BY35yCofJAewYmy0IDWwcGV+caV
X-Received: by 2002:a17:907:2e08:b0:a3f:1b49:c92b with SMTP id
 ig8-20020a1709072e0800b00a3f1b49c92bmr3940328ejc.48.1710271673330; 
 Tue, 12 Mar 2024 12:27:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLDEuP9sca4rgqUXXMHDacBtKCFdi8SVod1GqM78V9q6zQxy4NO79dojrJMjQxBm3Q8GoM2w==
X-Received: by 2002:a17:907:2e08:b0:a3f:1b49:c92b with SMTP id
 ig8-20020a1709072e0800b00a3f1b49c92bmr3940300ejc.48.1710271672880; 
 Tue, 12 Mar 2024 12:27:52 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 la18-20020a170907781200b00a43e8e76825sm4180658ejc.149.2024.03.12.12.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 12:27:52 -0700 (PDT)
Date: Tue, 12 Mar 2024 15:27:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH v8 07/15] pcie_sriov: Do not manually unrealize
Message-ID: <20240312152644-mutt-send-email-mst@kernel.org>
References: <20240228-reuse-v8-0-282660281e60@daynix.com>
 <20240228-reuse-v8-7-282660281e60@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240228-reuse-v8-7-282660281e60@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Feb 28, 2024 at 08:33:18PM +0900, Akihiko Odaki wrote:
> A device gets automatically unrealized when being unparented.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

I was bisecting and when I bisected to this commit I got a
build error:

../hw/pci/pcie_sriov.c: In function ‘register_vf’:
../hw/pci/pcie_sriov.c:154:9: error: implicit declaration of function ‘error_report_err’; did you mean ‘error_report’? [-Werror=implicit-function-declaration]
  154 |         error_report_err(local_err);
      |         ^~~~~~~~~~~~~~~~
      |         error_report
../hw/pci/pcie_sriov.c:154:9: error: nested extern declaration of ‘error_report_err’ [-Werror=nested-externs]
cc1: all warnings being treated as errors


could not bother checking which patch introduced this, follow up patches
fix this up.



> ---
>  hw/pci/pcie_sriov.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> index e9b23221d713..8b1fd2a89ad7 100644
> --- a/hw/pci/pcie_sriov.c
> +++ b/hw/pci/pcie_sriov.c
> @@ -17,7 +17,6 @@
>  #include "hw/qdev-properties.h"
>  #include "qemu/error-report.h"
>  #include "qemu/range.h"
> -#include "qapi/error.h"
>  #include "trace.h"
>  
>  static PCIDevice *register_vf(PCIDevice *pf, int devfn,
> @@ -204,11 +203,7 @@ static void unregister_vfs(PCIDevice *dev)
>      trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
>                                 PCI_FUNC(dev->devfn), num_vfs);
>      for (i = 0; i < num_vfs; i++) {
> -        Error *err = NULL;
>          PCIDevice *vf = dev->exp.sriov_pf.vf[i];
> -        if (!object_property_set_bool(OBJECT(vf), "realized", false, &err)) {
> -            error_reportf_err(err, "Failed to unplug: ");
> -        }
>          object_unparent(OBJECT(vf));
>          object_unref(OBJECT(vf));
>      }
> 
> -- 
> 2.43.2


