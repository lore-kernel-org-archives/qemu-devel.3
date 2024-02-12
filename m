Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F376EC48297
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 16:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZYom-0003ly-Km; Mon, 12 Feb 2024 11:06:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZYok-0003lJ-Em
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 11:06:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZYoi-00008X-A4
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 11:06:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707753958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bMcS+tWRZih4fckwWJz1zUvOMYFPBwTUTkTa1xIpD0o=;
 b=B8zaVMCM1H/eG63hOHSq1xsWr7nMQZlr3QpECe6RMC2sLKlJOcng3OXx21PMRG/xqyJRm/
 WtUvnamXFRw/9WjGJEBIDja+CE7ypjMmMNhdXtCF/78d1SOwACast7sQeuxVl8X1GEHAy/
 JTUADVl4HXF2JgxCJR1P1H+NuiIoYR0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-gZ64Wcj5PuGIudb5WyT2jg-1; Mon, 12 Feb 2024 11:05:55 -0500
X-MC-Unique: gZ64Wcj5PuGIudb5WyT2jg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a3120029877so437749866b.1
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 08:05:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707753954; x=1708358754;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bMcS+tWRZih4fckwWJz1zUvOMYFPBwTUTkTa1xIpD0o=;
 b=HNZVooEJIMT32fkW3XSMCi6tdJr66ERjpbCWZDGjLdCdyy8yjqxy/CPlvqv2JML3c/
 0NHm5QLbZbkNhvMXO9xz8rUe4HjlBgN/4txL/DyxUkH/+KxEt+g5naOPaK8LN0SbIshu
 PFdf2l9PGGQ7YQr7HN+PQMyL8J0WFxah6BKkBHEtLOgOsQBvzIg0ikhSPlBlnAe8TXR+
 m/LvU0ltFlgDqh4S4GIyIIMQhKxAGt2spU5qWdNQC2HRZwRaf5R68WGp4cc7Neu5MuVz
 gvDVt1PzCBeC/IvgSm7CaxF6po1l5+FRMUUg71VyWUj6a7P/j9yPcYocsrPYWvIqgWYL
 GRpg==
X-Gm-Message-State: AOJu0YwlRWbY+uEbEfFYHFr6t3gmdlPcI63EEhJaP426I5p9kV/2q5kl
 XYi1h10HEnf7LOlvgZh3JGaDtb6UJ07+mJX0YNO3fxuyPWIqglB2qq3vnZuDLMm0XxG/rqDEzbM
 aFR7w7K3oM+ar5yPwRM19jCHy2eCYEyohHEuentm3ygsJDmpjVQM8
X-Received: by 2002:a17:907:7d9f:b0:a38:567a:6574 with SMTP id
 oz31-20020a1709077d9f00b00a38567a6574mr9938747ejc.5.1707753954219; 
 Mon, 12 Feb 2024 08:05:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJ4m8Z2IASNbJ9OUPCmeMD38RRSRvcwU5qcwgdhkYgNwT+u1eN4k2xN0vI8uPInFPzkvZ0gQ==
X-Received: by 2002:a17:907:7d9f:b0:a38:567a:6574 with SMTP id
 oz31-20020a1709077d9f00b00a38567a6574mr9938706ejc.5.1707753953928; 
 Mon, 12 Feb 2024 08:05:53 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX3nowkXcL7Nr0pSyAer8+/qPGJpJgOrN8XS++L+NWRpwFX23JHAH2dEQKmVPftMmxuT/aFiguzi7IqIOF6nEvyTW3sLxeudgbY5mKtN1CxH7cZDlcaCdtaXNNINIvjxtbZC6N87pkuTUEhszIp1qXHiu2iOapR0v36YHO2Ryc4uPpKO2Wangm5InC4kvK4Ue38UZQXIC85qSXQ3I9GzEFQXkzw5AJy1lykl5R2m6nKW3gGcNJ7uEkJIDi4zH8cwa1piNqkiYWAvSkyBRMuVEAwm/Yyj/oNh8FU5POWj2aomAa5b2McxoZ4WwqP/SMNLMd7qCeY+KDyMnDY1Uw3nMy6FEzXT0sPWqEht53qV4DsfWe0IzdBE0RjhYKwDaDErvrL8e7vahotfvN9HaqEfEvQlZfgPiYNeuStHRO+rEz+ViQPjnJHLc999jO9bjgFwWgJLuus/kIQl5+sZf4ruAqJK7qOmCnGXRdN1ElxOWB3EVJXRv7FSRDw7rFGwopxboHp6KmQqMN8y58GXJxdpHUhHlik965yBL8haA0/t32eaMYan+IEEVtxeHEsKMQB39nAqkRAGQrP/CUEJ9saegdxv+D0ovnIV+b4vaTArRACXyTZQXnC5fKph/oY2Nn2fihtaA6hcA8B/1sJXLZHwIPzPtQXknKhraCIW5mDti3Yps8=
Received: from redhat.com ([2.52.146.238]) by smtp.gmail.com with ESMTPSA id
 vi16-20020a170907d41000b00a3ce31d3ffdsm169989ejc.93.2024.02.12.08.05.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Feb 2024 08:05:53 -0800 (PST)
Date: Mon, 12 Feb 2024 11:05:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ankit Agrawal <ankita@nvidia.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "ani@anisinha.ca" <ani@anisinha.ca>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "david@redhat.com" <david@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>,
 Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
 Vikram Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>,
 Dheeraj Nigam <dnigam@nvidia.com>, Uday Dhoke <udhoke@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v6 0/2] acpi: report numa nodes for device memory using GI
Message-ID: <20240212110526-mutt-send-email-mst@kernel.org>
References: <20231225045603.7654-1-ankita@nvidia.com>
 <20240102123143.00006486@Huawei.com>
 <SA1PR12MB71990557668BDE5878845A8AB067A@SA1PR12MB7199.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR12MB71990557668BDE5878845A8AB067A@SA1PR12MB7199.namprd12.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Jan 04, 2024 at 03:05:27AM +0000, Ankit Agrawal wrote:
> 
> >>
> >> -numa node,nodeid=2 -numa node,nodeid=3 -numa node,nodeid=4 \
> >> -numa node,nodeid=5 -numa node,nodeid=6 -numa node,nodeid=7 \
> >> -numa node,nodeid=8 -numa node,nodeid=9 \
> >> -device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.0,addr=04.0,rombar=0,id=dev0 \
> >> -object acpi-generic-initiator,id=gi0,pci-dev=dev0,host-nodes=2-9 \
> >>
> >
> > I'd find it helpful to see the resulting chunk of SRAT for these examples
> > (disassembled) in this cover letter and the patches (where there are more examples).
> 
> Ack. I'll document the resulting SRAT table as well.

Still didn't happen so this is dropped for now.


