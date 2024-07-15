Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7820DC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 14:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTMhm-0005es-9c; Mon, 15 Jul 2024 10:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTMhk-0005Sb-KS
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 10:29:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTMhj-00059V-09
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 10:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721053766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/6Nn6Qo6sZhY1rmWRCEE3hPzHnZaGhYdt4zkwvkZoE=;
 b=O6DN5RYHCe6Zexn6r27CX1V5elRXJQGgzPl3+HRcEXriQe2+Ol6mBwz9zVkEGpr+tfHRkp
 HkE55WSm1J9vFImf9n9Y2k35FbUPqsAibfdOWEkVfdZ4/RPtPhKip4Q0JRnP9YkJN3oQZX
 IHpX1H+9TDmxf0ALWVABQvcSXbRqQDo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-TzStXb4VNIKEEJbsKqjlTw-1; Mon, 15 Jul 2024 10:29:25 -0400
X-MC-Unique: TzStXb4VNIKEEJbsKqjlTw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-426654e244dso31302975e9.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 07:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721053764; x=1721658564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j/6Nn6Qo6sZhY1rmWRCEE3hPzHnZaGhYdt4zkwvkZoE=;
 b=JDiYQ6aITFZJNmyX5clKktX+jmtg7zSJvUUchaYsdMdYIw9khz3+33gdo3EraOiIf5
 2PvJlaNK0iNpt0qJ9q+V/K6HFP2yIBdn03P8CZcltRzZuFSgvqUHSiJtJ2rfFdf5RY1u
 tbPkLn3/eg+Xy00zYyltsgOZ+LiaQ1e6iW7Y4/nb0OagdgCTa79/seXfC7Dthk3xP5Lk
 S4k9yp/E4bgApSGbdAWGnNvXjLY1UKiTtHDeSL58RUKawLQOUV+V6/AaFEjXxwIjvJtE
 1InJfsAvXHwxgr0MgLeWhDz2x8NiLZqYP2oz8oSQhXmhiEW/tBycwwGV6kv3G7hmHaFC
 Bxlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgGRYbBoOABmSFfLgUw303qUpFVRRZbcpRzcWlFAMcHVuY1wGLdN7/0zC8Bb1NnmloPnEvRDxBTp1r6UTrXJslwfhHYg8=
X-Gm-Message-State: AOJu0Yx/nvhePup93v5etC41tQnE9W6CiyKcRV/76g3/Js6JSUuGYiaw
 YfI4pwiFFVRDtlin0ubsmn6Z++/mc/iFMgkOEspfDWU8V3hIMEuJTCdDGyZKFeVlSbFgWgCoURE
 P4fsUgxVr99R3gxd9jgg5IuNq+mgXXlZQSDBTa1t1xFHZkY5dNGEy
X-Received: by 2002:a05:6000:156d:b0:367:f054:7a94 with SMTP id
 ffacd0b85a97d-367f0547c40mr11627489f8f.5.1721053763952; 
 Mon, 15 Jul 2024 07:29:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvMeozCQs/5GA5cFvsua0ih8QMtCrL44KzSqGiICd7C8KdavHo+nLParr9x4UTUBqLLmixlA==
X-Received: by 2002:a05:6000:156d:b0:367:f054:7a94 with SMTP id
 ffacd0b85a97d-367f0547c40mr11627470f8f.5.1721053763647; 
 Mon, 15 Jul 2024 07:29:23 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb91csm6643094f8f.74.2024.07.15.07.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 07:29:23 -0700 (PDT)
Date: Mon, 15 Jul 2024 16:29:22 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <linuxarm@huawei.com>,
 <linux-cxl@vger.kernel.org>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Dave
 Jiang <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>, Paolo
 Bonzini <pbonzini@redhat.com>, <eduardo@habkost.net>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v5 08/13] hw/i386/acpi: Use TYPE_PXB_BUS property
 acpi_uid for DSDT
Message-ID: <20240715162922.52c190ce@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240712110837.1439736-9-Jonathan.Cameron@huawei.com>
References: <20240712110837.1439736-1-Jonathan.Cameron@huawei.com>
 <20240712110837.1439736-9-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 12 Jul 2024 12:08:12 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Rather than relying on PCI internals, use the new acpi_property
> to obtain the ACPI _UID values.  These are still the same
> as the PCI Bus numbers so no functional change.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Tested-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
> v5: Leave the device naming as using bus_num so that we can
>     relax assumption of the UID being only 8 bits (it is but
>     we don't need to assume that)
> ---
>  hw/i386/acpi-build.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index ee92783836..2eaa4c9203 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1550,6 +1550,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          QLIST_FOREACH(bus, &bus->child, sibling) {
>              uint8_t bus_num = pci_bus_num(bus);
>              uint8_t numa_node = pci_bus_numa_node(bus);
> +            uint32_t uid;
>  
>              /* look only for expander root buses */
>              if (!pci_bus_is_root(bus)) {
> @@ -1560,6 +1561,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>                  root_bus_limit = bus_num - 1;
>              }
>  
> +            uid = object_property_get_uint(OBJECT(bus), "acpi_uid",
> +                                           &error_fatal);
>              scope = aml_scope("\\_SB");
>  
>              if (pci_bus_is_cxl(bus)) {
> @@ -1567,7 +1570,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>              } else {
>                  dev = aml_device("PC%.02X", bus_num);
>              }
> -            aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
> +            aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
>              aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
>              if (pci_bus_is_cxl(bus)) {
>                  struct Aml *aml_pkg = aml_package(2);


