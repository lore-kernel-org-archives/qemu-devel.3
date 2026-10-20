Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F593606A334
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 06:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZwgxE2dD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ3Qf-0003BX-Nn; Tue, 20 Oct 2026 02:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ3Qb-0003Ae-Ej
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:34:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ3QZ-0007yi-NS
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792478066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Q+JBVczQcpuyZ1S2bpj9MKK/WcbLNTW0W11Ub7kbfc=;
 b=ZwgxE2dDglF9PjmDrkfXR6cjyCOPKnB20ZzLNU+12FskMlOj+m2bNNqb8KG/zYrXMoFKPo
 KSA54OuYT4SZ6BA73ymHhyrhAUe4c64MVaD2dXYp57kI+tCW1Y2/ODFsGK4DGc6Wnop3KQ
 1hDOOPbUQbb0E1Jp50U55jvUC7bnzSQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-3MAro3yMM7ayZTqnulnwTA-1; Tue,
 20 Oct 2026 06:34:23 +0000
X-MC-Unique: 3MAro3yMM7ayZTqnulnwTA-1
X-Mimecast-MFC-AGG-ID: 3MAro3yMM7ayZTqnulnwTA_1792478062
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2DDCF19560B8; Tue, 20 Oct 2026 06:34:22 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 31FEC1956088; Tue, 20 Oct 2026 06:34:20 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 62/65] hw/i386: convert PCSouthBridgeOption to QAPI enum
From: marcandre.lureau@redhat.com
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 berrange@redhat.com, michael.roth@amd.com, 
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 kkostiuk@redhat.com, alistair.francis@wdc.com, amachhiw@linux.ibm.com
In-Reply-To: <20261019141929.1594337-63-armbru@redhat.com>
References: <20261019141929.1594337-1-armbru@redhat.com>
 <20261019141929.1594337-63-armbru@redhat.com>
Date: Tue, 20 Oct 2026 10:33:32 +0400
Message-Id: <179247801299.2782576.5381319044164295424.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3039;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ig5en4VVxYH4/RuHQ69fmYjPuwmlJTLiFLFZ7Ed7ons=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq1wtDxYibuqMxgHgjexKkXIoWwhiB8tXTKCAfQ
 C6Qf5O0Jc6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatcLQwAKCRDa6OEJdZac
 5d+6EACeY7DIkofTGIdE6SCSzJaajPxAfLr3csPtLeUVnL+wfbys8N+/Ms6SEU/QiDszgUIa/j9
 w8lr+OijPXafBiC/+Wy7BmgPwuUq4zFUwg/eZihWrhOBra8lsJ3pLFeky8jcT4EAbcRdoLXX2p/
 OWYifuDhg0WdArcVaqsg9WqKr81JZgk4cafx/d+fqyOZ/7aTGNlejwKMGJFzAdKmgYYP1K1fR6d
 gDb50Pt6R3Sqq5u6z21RGFnM0aLUTnUuEveRUKEOvqetSAg78JhJJLm5D0gi6BNg7LVJkJAnBG+
 HECLwBcR7hYTQUWn+A3gOMeTj/wNgws8ot06hAyiWPxk79s6sOKg2sLxMy9LWkbYVR3V8H8myEz
 J18vhuAD5pK3nxmuCLCRWVBOdyEnl1/T/GXXK66/Il1YBBRoL6NcigcRKc7a0VLyKECPX6A1SIO
 iCXarj8bCwGCK/Yhu+130oTrJXpqxcs1TvWepvrh6ACvF/QBNjUpAObn0s9vEuiY6bGE3VztiAK
 i0aYyUHoiVUMmpaw3UXxiDB5uWZ/rifSDAqCMiuxKtGzr7I+8bagcD4n5KY5dKip3d+MKAP+xso
 HZ8pr1AIcMz7POhuc1tKLw0O7C6OZtitLsZxkX5qTlzYyBq1eWUQsJdrCKxQBxhYzjVkKR4BRkj
 QyQSAYNZl1LEfTQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Move PCSouthBridgeOption from a hand-rolled C enum to a proper QAPI
> enum in qapi/machine.json.
> 
> This gives the x-south-bridge property a generated type_info with a
> valid masked_name, so it appears in query-qmp-schema introspection and
> the qapi-type field of qom-list-properties output.
> 
> The south_bridge/default_south_bridge fields change from const char *
> to PCSouthBridgeOption, with an explicit mapping table from enum value
> to QOM device type name.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Message-ID: <20261019141929.1594337-63-armbru@redhat.com>
> ---
>  qapi/machine.json    | 14 ++++++++++
>  include/hw/i386/pc.h |  4 +--
>  hw/i386/pc_piix.c    | 61 +++++++++++++-------------------------------
>  3 files changed, 34 insertions(+), 45 deletions(-)
>
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 63c4667ea372..5a94a34166d8 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -47,6 +47,7 @@
>  #include "hw/acpi/acpi.h"
>  #include "hw/vfio/types.h"
>  #include "qapi/error.h"
> +#include "qapi/qapi-type-infos-machine.h"
>  #include "qemu/error-report.h"
>  #include "system/xen.h"
>  #ifdef CONFIG_XEN
> @@ -75,6 +76,11 @@ static GlobalProperty pc_piix_compat_defaults[] = {
>  static const size_t pc_piix_compat_defaults_len =
>      G_N_ELEMENTS(pc_piix_compat_defaults);
>  
> +static const char *pc_south_bridge_type[] = {
> +    [PC_SOUTH_BRIDGE_OPTION_PIIX3] = TYPE_PIIX3_DEVICE,
> +    [PC_SOUTH_BRIDGE_OPTION_PIIX4] = TYPE_PIIX4_PCI_DEVICE,
> +};

We could have
G_STATIC_ASSERT(G_N_ELEMENTS(pc_south_bridge_type), PC_SOUTH_BRIDGE_OPTION_LAST)
or something

> +
>  /*
>   * Return the global irq number corresponding to a given device irq
>   * pin. We could also use the bus number to have a more precise mapping.
> @@ -236,7 +242,8 @@ static void pc_init1(MachineState *machine, const char *pci_type)
>  
>      gsi_state = pc_gsi_create(&x86ms->gsi, true);
>  
> -    pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
> +    pci_dev = pci_new_multifunction(-1,
> +                                    pc_south_bridge_type[pcms->south_bridge]);
>      object_property_set_bool(OBJECT(pci_dev), "has-usb",
>                               machine_usb(machine), &error_abort);
>      object_property_set_bool(OBJECT(pci_dev), "has-acpi",
> @@ -317,51 +324,18 @@ static void pc_init1(MachineState *machine, const char *pci_type)
>      }
>  }
>  
> -typedef enum PCSouthBridgeOption {
> -    PC_SOUTH_BRIDGE_OPTION_PIIX3,
> -    PC_SOUTH_BRIDGE_OPTION_PIIX4,
> -    PC_SOUTH_BRIDGE_OPTION_MAX,
> -} PCSouthBridgeOption;
> -
> -static const QEnumLookup PCSouthBridgeOption_lookup = {

The commit message should mention that enum values have been replaced:
PIIX3->ppix3, piix4-isa->piix4

Since it's a x- property, I suppose it is not a breaking change.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


