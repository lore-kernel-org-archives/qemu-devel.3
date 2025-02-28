Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D0CC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 12:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnzvC-0002JJ-4F; Fri, 28 Feb 2025 07:56:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tnzvA-0002J2-S0
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 07:56:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tnzv8-00069u-8x
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 07:56:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740747408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=67BXT0vQpu/OqHFy0jU75raiVxBbfNLhOqO75/mL0sM=;
 b=NvIiTe8TntZeVHhZQ554mS+lYzKMXs6+8zabZ6/+bYnHMmamdukzJeFNXlvoMJ4dWTMnHc
 0J1gxfHrkZq2o3eQB6OWbxiKcFAfHB3jLGjS/n43CEYwSJ+b8fuQQ8YXU7lZmioIJX6MQP
 7nB1/SflWOkLl5zI/bdFxLpgZr2My8c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-6rscr-k3MP-mA_aRzgDnVg-1; Fri,
 28 Feb 2025 07:56:46 -0500
X-MC-Unique: 6rscr-k3MP-mA_aRzgDnVg-1
X-Mimecast-MFC-AGG-ID: 6rscr-k3MP-mA_aRzgDnVg_1740747405
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02FB9180087A; Fri, 28 Feb 2025 12:56:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.2.18.23])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 114AA300019E; Fri, 28 Feb 2025 12:56:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B8C6218000A3; Fri, 28 Feb 2025 13:56:41 +0100 (CET)
Date: Fri, 28 Feb 2025 13:56:41 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 0/6] Add bios-tables-test for LoongArch64 system
Message-ID: <xtmso5q2kb22fnmnflumyjlkoxci6etigi32dl2lwdfznwplg2@zd7zlmyn2hye>
References: <20250228092729.543097-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228092729.543097-1-maobibo@loongson.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Feb 28, 2025 at 05:27:23PM +0800, Bibo Mao wrote:
> This patchset add bios-tables-test for LoongArch64 virt machine
> system. It works with UEFI bios, with uefi-test-tools LoongArch64
> support is added to build bios-tables-test.loongarch64.iso.
> 
> Also with test case bios-tables-test, LoongArch64 support is added
> and some basic ACPI tables is added here. It passes with command
> make check-qtest-loongarch64 with the result:
>  qtest-loongarch64/bios-tables-test OK 29.52s 4 subtests passed

UEFI bits look good to me.

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

take care,
  Gerd


