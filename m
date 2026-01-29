Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC14CD358F6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 10:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlPcM-0001ZB-82; Thu, 29 Jan 2026 05:51:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vlPcI-0001X0-NY
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 05:51:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vlPcF-00053u-7i
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 05:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769683868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hkN3odwc4xjpc2DM0clenXqHqr+SgiBsauZIR+93fN0=;
 b=EDwGckfQsKmrFjo9LNdcyfDbyPK+X/eeeOAA9eAZI9zGi+XTrIYCYbZQsDcXBOS4ibjxTQ
 H+2yo4zRo5FuDZZQpn/vZ8HQmA5mNeizc5/Ivgh+9zL63NNU+JyHMa55qxYSW8k6XQME/U
 S6gF1vT3sAjuCoyzdQaFCTUemA8st4c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-ZioOl7pjNPibocwDzH8DWw-1; Thu, 29 Jan 2026 05:51:07 -0500
X-MC-Unique: ZioOl7pjNPibocwDzH8DWw-1
X-Mimecast-MFC-AGG-ID: ZioOl7pjNPibocwDzH8DWw_1769683866
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48079ae1001so5254265e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 02:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769683866; x=1770288666; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hkN3odwc4xjpc2DM0clenXqHqr+SgiBsauZIR+93fN0=;
 b=XTEqkajukGaYhSYg8qqen3utf2+k1zbVN4esbm7xbXxTsnOud6pOLESuR6YK5nkp/4
 amMXRR7gw27zXsQepWPGfMle9aiYLE++Hgt/AXK3hlgmP/p9B5mJeUdTAHPrBYtWMhbi
 0R6PR0DssDrn20/sV3OGfTEZvcYNsKRsRywkqCb+G6TXNHlDber9p4PK6TEu+wqXs8Qy
 qGmWlI0nINNphM1HVUg/omXBTPi+5sOymnxqUGT0YWgXTh0Mz2tnaD6MQUDsdYR8vyGn
 W+kt+uqh54MDvC3Q9+YjPz2vCPE1vMVg1j1HysWrGNqofftEErpwyoPycS1nkJfihovr
 E8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769683866; x=1770288666;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hkN3odwc4xjpc2DM0clenXqHqr+SgiBsauZIR+93fN0=;
 b=lO4cOz2zZU0gxX5YUfTP6h7ko3bJ3x5SS2lC85LHJ7N94b4CN9nxbh41gtz22oWbn3
 algljZwTdeQJZxbnRJxuCwVUg3F4I7hiqEIbyC30GaogMs8wlQK8xo7vq0CwrjJ5tFEv
 IqjR1t63bRnFE8keZadE0l0jW8y9jtqeXWyXNhUIhMHmxq7D4PYdqX1VwcRkTfHfsz21
 CgAHzo5GGklhxBn1byHy/IQ6a7pSBSu9iGwVyBFu8iqngu2jUBgZE1tmL2KAiQOtUzkz
 /cCOlERQi6G5Q/PhEi6RUTRpy9uC5bTt5N0QLsA/ZkC2bBFic5Ya4wOqxufNfNIUe3VB
 KDxQ==
X-Gm-Message-State: AOJu0YwVcDfOBzrYGHjlNKEn0uTh2/bZxsCY0fLIR5PTYg7xqjquidAu
 akl57Oks818eKCu2wQ1PO4+Pj+H/Lcknbmf0U+qiqQhtJt67CpDH+JOFh3r0KJG7/VNe3DDXaux
 VngDhPyEuFMDQBQZj9nU0jRZPMEHI5PCgWf1WSSO/u4l4tPe/YCJ/3lb8
X-Gm-Gg: AZuq6aITLCIjbSg8Lk63DiKN/52Q1gaZXQlSVmOnmXiu9JXT8uzGKRu+ZO2RWYE4umY
 Vs0+6OFceFbkhIo5tO+ALa/UrZFDW3TKBbB4uBvMCXWHP+aSAr+Z8xeP6SetRtv2ezwp+kLUB0o
 8NqaM4+iPZEG0KUvrebJyKIUtEvDAGk8fBM6k6xhX2zvjhD/A3ztqPEezxEbbzZPf1fIssT2vwT
 FjRUHIiAaTvU32UBtjUuXc1FyWdsLqJkfmynVUKPIbAQJKQ4GsFWEWesjEbs3AiDHO90bqLI6Se
 6aqtaEcdHzZYSjHZ1BTLOLBoyXMpg9kQa1mHPsDq43D/toUXoZHYVKVK9VFH6aOSxnz8mRqiEO/
 Zu1IpUPdAVQknsA==
X-Received: by 2002:a05:600c:3586:b0:477:561f:6fc8 with SMTP id
 5b1f17b1804b1-48069c2abccmr124000935e9.5.1769683865723; 
 Thu, 29 Jan 2026 02:51:05 -0800 (PST)
X-Received: by 2002:a05:600c:3586:b0:477:561f:6fc8 with SMTP id
 5b1f17b1804b1-48069c2abccmr124000625e9.5.1769683865324; 
 Thu, 29 Jan 2026 02:51:05 -0800 (PST)
Received: from leonardi-redhat ([176.206.38.57])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131ce64sm14124650f8f.26.2026.01.29.02.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 02:51:04 -0800 (PST)
Date: Thu, 29 Jan 2026 11:51:01 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Oliver Steffen <osteffen@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joerg.roedel@amd.com>
Subject: Re: [PATCH v5 1/6] hw/acpi: Make BIOS linker optional
Message-ID: <aXszoXaOgNGaHnTM@leonardi-redhat>
References: <20260127100257.1074104-1-osteffen@redhat.com>
 <20260127100257.1074104-2-osteffen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260127100257.1074104-2-osteffen@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Oliver,

On Tue, Jan 27, 2026 at 11:02:52AM +0100, Oliver Steffen wrote:
>Make the BIOS linker optional in acpi_table_end() and calculate the ACPI
>table checksum directly if no linker is provided.
>
>This makes it possible to call for example
>acpi_build_madt() from outside the ACPI table builder context.
>
>Signed-off-by: Oliver Steffen <osteffen@redhat.com>
>---
> hw/acpi/aml-build.c | 29 +++++++++++++++++++++++++++--
> 1 file changed, 27 insertions(+), 2 deletions(-)
>
>diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
>index dad4cfcc7d..6a3650076f 100644
>--- a/hw/acpi/aml-build.c
>+++ b/hw/acpi/aml-build.c
>@@ -1730,6 +1730,25 @@ void acpi_table_begin(AcpiTable *desc, GArray *array)
>     build_append_int_noprefix(array, 1, 4); /* Creator Revision */
> }
>
>+static uint8_t calculate_acpi_checksum(const gchar *data, size_t len)
>+{
>+    size_t i;
>+    uint8_t sum = 0;
>+
>+    for (i = 0; i < len; ++i) {
>+        sum += (uint8_t)data[i];
>+    }
>+
>+    return sum;
>+}
>+

In `hw/acpi/core.c` there is a `acpi_checksum` function that does 
exactly this. Can we reuse this to reduce code duplication? Currently 
that function is marked as static.

Thanks for all the work so far.

Luigi


