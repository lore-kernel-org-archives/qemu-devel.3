Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B01EBFD1E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 09:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCDAH-00029h-PY; Mon, 13 Apr 2026 05:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wCDAG-00029O-Aj
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 05:01:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wCDAE-00045H-So
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 05:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776070861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JC1YPP2vZqKzcQMw74L6t/RcjW5p7vtlxG6e42KNB6U=;
 b=VK9fqY1HMj2ZdcjSeLUpMoa7jb7gQemen5RD81iDbtt/1lWWyPyc6KljpKCQAeM6mX6OIs
 lkk6/X9+SGLagcwOLNV7LihOQbkdASnwy7RJTJ77NU3yXkWsaUDY3VvPuWLgBvT8rfVMS1
 uDkuKs4PVett/RJB9lVnCDSYhcKpz+I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-gFCNgCMMPcqJFBNSmLfv2g-1; Mon,
 13 Apr 2026 05:00:59 -0400
X-MC-Unique: gFCNgCMMPcqJFBNSmLfv2g-1
X-Mimecast-MFC-AGG-ID: gFCNgCMMPcqJFBNSmLfv2g_1776070858
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E77841800365; Mon, 13 Apr 2026 09:00:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.34.102])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E045180058D; Mon, 13 Apr 2026 09:00:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 721441800929; Mon, 13 Apr 2026 09:45:52 +0200 (CEST)
Date: Mon, 13 Apr 2026 09:45:52 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Luigi Leonardi <leonardi@redhat.com>, qemu-devel@nongnu.org,
 Oliver Steffen <osteffen@redhat.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH] hw/arm/virt: add serial-debug-level property for EDK2
 firmware
Message-ID: <adyZm41cp_nZHPYj@sirius.home.kraxel.org>
References: <20260311-edk2_arm_serial-v1-1-c25e237116f3@redhat.com>
 <0b4976f9-cf83-47b4-8f00-cc68c9cf47fd@linaro.org>
 <abkPy4Xzf6YT6g5Y@sirius.home.kraxel.org>
 <CAFEAcA-dTkoKs0tgF+VV0PayFbDcmH_t64P6AOT18ShwEKTW_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-dTkoKs0tgF+VV0PayFbDcmH_t64P6AOT18ShwEKTW_g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

  Hi,

> > I'd like to have something more convenient than that to turn on firmware
> > debug logging.
> >
> > On x86 we have a dedicated device for firmware logging (isa-debugcon),
> > so logging can be easily enabled on the qemu command line by adding that
> > device.
> >
> > So the idea here is to have a dt property added to serial port to
> > setup firmware logging, so we have something roughly comparable to the
> > x86 functionality ...
> 
> My rough rule of thumb for DT properties is "if it is a binding
> officially documented in the binding specs in the kernel with
> the relevant semantics, then OK"; but not ad-hoc bootloader
> specific stuff (we have turned down requests from u-boot for that
> in the past).
> 
> Would using the fw_cfg mechanism work here? That's intended for
> passing configuration info (and "how verbose should debug be"
> seems like configuration info), and we already have a command
> line interface for it:
>  -fw_cfg name=edk2/debug-level,string=1
> (or whatever).

I'd very much prefer to use device tree.  A device property is maybe
not the best choice.  There is this /chosen node though which is
already used to pass around guest configuration information (kernel
command line for example).  Maybe we can add properties there?

take care,
  Gerd


