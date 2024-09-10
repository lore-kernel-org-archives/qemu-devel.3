Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14198EB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 13:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so1F9-0004Q0-2w; Tue, 10 Sep 2024 09:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1so1F7-0004PB-03
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 09:49:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1so1F5-0004Qp-8e
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 09:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725976154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qTs7EoPQVez3aXX8JsX51lTV8mb5LjE0tb3w8l85Occ=;
 b=MDOC61ptCqRfUSSkKSYy/bxJn9QPzvPaRXmtWiohppS1d0EZ2EnYG9ePSBTJ3N6QwgY05i
 ruFei+31PjmW5U7PgppWFfbkp3BWu/EuMSExCAtNKF6c7BzQGdlGO6KZslufia6E2VtjSi
 Q/eAu/wX+4fTSrbygIDXssyts5M+Bs0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-ESztjxKPM9CNYEqruCwyzA-1; Tue,
 10 Sep 2024 09:49:11 -0400
X-MC-Unique: ESztjxKPM9CNYEqruCwyzA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1F81195394C; Tue, 10 Sep 2024 13:49:08 +0000 (UTC)
Received: from localhost (dhcp-192-244.str.redhat.com [10.33.192.244])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E6F6B19560AD; Tue, 10 Sep 2024 13:49:06 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen
 <chenhuacai@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 kvm@vger.kernel.org, Bibo Mao <maobibo@loongson.cn>
Subject: Re: [RFC PATCH V2 1/5] include: Add macro definitions needed for
 interrupt controller kvm emulation
In-Reply-To: <2182eb694629ee3f2859e441b8076d62d3606ee2.1725969898.git.lixianglai@loongson.cn>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <cover.1725969898.git.lixianglai@loongson.cn>
 <2182eb694629ee3f2859e441b8076d62d3606ee2.1725969898.git.lixianglai@loongson.cn>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Tue, 10 Sep 2024 15:49:03 +0200
Message-ID: <87cylbvcts.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 10 2024, Xianglai Li <lixianglai@loongson.cn> wrote:

> Add macro definitions needed for interrupt controller kvm emulation.
>
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> ---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: Bibo Mao <maobibo@loongson.cn>
> Cc: Xianglai Li <lixianglai@loongson.cn>
>
>  include/hw/intc/loongarch_extioi.h    | 38 ++++++++++++++++--
>  include/hw/intc/loongarch_ipi.h       | 15 +++++++
>  include/hw/intc/loongarch_pch_pic.h   | 58 +++++++++++++++++++++++++--
>  include/hw/intc/loongson_ipi.h        |  1 -
>  include/hw/intc/loongson_ipi_common.h |  2 +
>  include/hw/loongarch/virt.h           | 15 +++++++
>  linux-headers/asm-loongarch/kvm.h     | 18 +++++++++
>  linux-headers/linux/kvm.h             |  6 +++
>  8 files changed, 146 insertions(+), 7 deletions(-)

The parts you need to split out into a separate patch are the changes
under linux-headers/ (because they get updated via a script); the
changes under include/hw/ are internal to QEMU and should go where it
makes sense (probably with the actual changes in .c files, but I didn't
check what the patch actually does.)


