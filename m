Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B1CC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 16:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk4CQ-0004gM-Hd; Mon, 17 Feb 2025 11:42:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1tk4CN-0004dB-0Z
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 11:42:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1tk4CL-00080b-GQ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 11:42:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739810540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XbkIoklqqdbuIOGIReku3lHEr+KYa4uqc8v7BThesjM=;
 b=SDVZTsYQMZSLijn3vMdNdqERqBsoPizqyePbsAV4bN+KoF3GKIZ+WHkkASEiFNsWw8GrH7
 ClCOINzWeYWlEqbtPK/YLS7Um6zSOaojYbR0ox6oQTPArorIRupKrA6sj7ivH9/UdpQj8A
 zXtoH6e+WaeAgiSfrcDrfK9gwABnH4k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-j4sB0fCTMsO_KX5yRpATvw-1; Mon,
 17 Feb 2025 11:42:15 -0500
X-MC-Unique: j4sB0fCTMsO_KX5yRpATvw-1
X-Mimecast-MFC-AGG-ID: j4sB0fCTMsO_KX5yRpATvw_1739810533
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4235F1800878; Mon, 17 Feb 2025 16:42:12 +0000 (UTC)
Received: from gezellig (unknown [10.44.32.23])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 100F0300018D; Mon, 17 Feb 2025 16:41:59 +0000 (UTC)
Date: Mon, 17 Feb 2025 22:11:55 +0530
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, maz@kernel.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Yi Liu <yi.l.liu@intel.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Alistair Francis <alistair@alistair23.me>,
 Tyrone Ting <kfting@nuvoton.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Joel Stanley <joel@jms.id.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Hao Wu <wuhaotsh@google.com>, sebott@redhat.com,
 Eric Auger <eric.auger@redhat.com>, Ninad Palsule <ninad@linux.ibm.com>
Subject: Re: [PATCH v2 0/3] docs: Small changes to system/arm/cpu-features
 and more
Message-ID: <Z7Nm03NCxsCGPTe6@gezellig>
References: <20250213084219.2975727-1-kchamart@redhat.com>
 <CAFEAcA9MgeaCQspu=4dCusTQVP3KOvpze55vshPJCaNS_E43yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9MgeaCQspu=4dCusTQVP3KOvpze55vshPJCaNS_E43yg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kchamart@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Feb 17, 2025 at 01:23:51PM +0000, Peter Maydell wrote:
> On Thu, 13 Feb 2025 at 08:44, Kashyap Chamarthy <kchamart@redhat.com> wrote:
> >
> > In v2:
> >
> >   - Add live-migration context to the PAuth docs (Marc Zyngier)
> >
> >   - Fix the Arm capitlalization (Peter Maydell)
> >     - Context here:
> >       (https://lists.gnu.org/archive/html/qemu-devel/2025-01/msg05137.html)
> 
> 
> > Kashyap Chamarthy (3):
> 
> Hi -- it looks like only patches 1 and 2 ever made it to
> the list. Would you mind resending, please?

It's strange, but as you pointed out on IRC: occasionally the list "eats
an email for no clear reason".

Now sent a v2, with a note at the top of the cover-letter.

> >   docs/cpu-features: Consistently use vCPU instead of VCPU
> >   docs/cpu-features: Update "PAuth" (Pointer Authentication) details
> >   docs: Fix "Arm" capitaliaztion
> 
> (nit: "capitalization")

Fixed in the re-sent v2.

-- 
/kashyap


