Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FD6C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwkTe-0007cJ-0L; Wed, 19 Aug 2026 13:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwkTc-0007ab-II
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:53:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwkTb-0005Ru-3k
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787162002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cKQG/fbtJdBCAFaJpwijUotLltEPSaasJ5VmlijdSe8=;
 b=gSQURSOsAbcNDam02aFyvHreUYHUXL5V7cr+AzVoSwcXusZtRWcXcYtv8cb8vufN8NOF65
 +rgjSjCHeRAHEN799cYTdNtSyTMioWeMi3Tl6OxXD2OLHE/SH9WzOb1Dwt9XQ3BXntcnc8
 lYwdALPIVdEVSpp4GszS/fPNi3CC550=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-x6MtblR3PYKxquI-iKvsbw-1; Wed,
 19 Aug 2026 13:53:21 -0400
X-MC-Unique: x6MtblR3PYKxquI-iKvsbw-1
X-Mimecast-MFC-AGG-ID: x6MtblR3PYKxquI-iKvsbw_1787162000
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B17381956089; Wed, 19 Aug 2026 17:53:19 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8AA841800348; Wed, 19 Aug 2026 17:53:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 10/15] hw/acpi/ich9.c: convert object props in
 ICH9_LPC_DEVICE to class props
From: marcandre.lureau@redhat.com
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, 
 philmd@mailo.com, aurelien@aurel32.net, peter.maydell@linaro.org, 
 pbonzini@redhat.com, richard.henderson@linaro.org, berrange@redhat.com, 
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260819133816.3497033-11-mark.caveayland@nutanix.com>
References: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
 <20260819133816.3497033-11-mark.caveayland@nutanix.com>
Date: Wed, 19 Aug 2026 21:52:43 +0400
Message-Id: <178716196333.2018258.5241156257240924760.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=433;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=m83+WxWGnfgayOG4H+7LYSOGaol3Wxuf6MMJJY0vgHA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhe19NMwo305YrJeWI0XmeBvCKHi3WIE8V9BaZ
 h8ZwFu87wCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoXtfQAKCRDa6OEJdZac
 5SdtEACSgtPmN61vsarxqfnfGPAryKJ6GiKMxmsordZq1nkOXWz8pllw9gC4QBiB5jq15x8G3Sp
 45wCKQboO0sY4kxhp7tI7GMC2hPlUd3ry1Wx7zA3i01MrflOujSY10mqapRC2fOyxc8Jixji5Zr
 Y/8imsPEKHBq+x0DRk15i2SBM1zQiNQvnUd6DakjqZQJEWhVJrB3CACmaN3rFHAv0Y5HX4rRCF2
 PS188/5EsnpnwuD1fch2lLKFGJfzjOrYh/x6XemZ/SYepeIeJb8wZyaN9GBAw/o3ML/H9MdQ8W6
 Bx9csKe6uQsrC08V4T1/a5pJVYWuO3clHSfs2nplmK/MhBOqoae49dpkm+bVTymhaf6/F48UFkc
 XYNKucbg5UMbiJ5eZVjqc4xzdWE5etsj7VxgSEzFjE5my7+UIaHnKAcR0La4VjhAC31jYpDLIe7
 VLGMg4BH4InBp7dmCSlt0/UyKd4sCIWrGDv9/DoJyjf+t9nYmilDsapwPChJe/3ZhOlZu2abpc/
 YZBbt9RnxVJvVX0cuGfOI5AwtOgbFIJjDURLUDVR5w2RarJTyEokt/fQ5PawzCZUllay3DFx8DJ
 htqB6gxiScNDlgWVs/899DKGGZfjJMiHxjGgPRIPABEraEJZ+Xr3EMmnL0d2EBX3zWkNUyjGhn+
 BYwTBREDFxsRmEw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, 19 Aug 2026 14:35:49 +0100, Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:
> ACPI_PM_PROP_TCO_ENABLED, ACPI_PM_PROP_ACPI_PCIHP_BRIDGE and x-keep-pci-slot-hpc
> properties can be converted to use object_class_property_add_bool_ptr(). Remove
> the now unused ich9_pm_add_properties() function.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


