Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B74C54EFC
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 08:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wodCr-0005kr-OV; Tue, 28 Jul 2026 04:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wodCp-0005kT-QC
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:30:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wodCo-0000fE-Gq
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785227429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hZVecxBAvsRmAJZYPIWXLUeZr6a246+SZfnlQUWjsZY=;
 b=GvCGzOmcoZLfSVRsc8MgmsOchX9Vml4cJkS+K0/4CstoAlzE5JOV+WNFXCjCc4nNSyq3Jw
 1lqMmEqRbZHAhZr4VolsQmvOht39iPc2pJHJWGXa8eh7Xl5JWOLUpLYi0e9CrU8JOyGFS8
 isvFOLuHSJerFBm6Cab7EG67jJeO5NU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-UYF9XXwdNuCU-M-L_6dTXA-1; Tue,
 28 Jul 2026 04:30:25 -0400
X-MC-Unique: UYF9XXwdNuCU-M-L_6dTXA-1
X-Mimecast-MFC-AGG-ID: UYF9XXwdNuCU-M-L_6dTXA_1785227424
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 721B019560B5; Tue, 28 Jul 2026 08:30:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.49.247])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B08131800480; Tue, 28 Jul 2026 08:30:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9B4D518000A2; Tue, 28 Jul 2026 10:30:22 +0200 (CEST)
Date: Tue, 28 Jul 2026 10:30:22 +0200
From: Gerd Hoffman <kraxel@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Alex Graf <graf@amazon.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 8/9] Add functional and unit tests for the
 vm-launch-update device
Message-ID: <amhodPAYhncYWEFP@sirius.home.kraxel.org>
References: <20260714024557.204578-1-anisinha@redhat.com>
 <20260714024557.204578-9-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714024557.204578-9-anisinha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Jul 14, 2026 at 08:15:27AM +0530, Ani Sinha wrote:
> This patchset adds functional and unit tests that exercize various functions
> and behaviors of vm-launch-update device. It uses the IGVM files that were
> introduced in the previous patch for exercizing the hypervisor interface.
> 
> CC: Alex Graf <graf@amazon.com>
> CC: Gerd Hoffman <kraxel@redhat.com>
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  tests/data/igvm/hello.igvm                    | Bin 153624 -> 137112 bytes

Intentional?  Should have been in the previous patch I guess?

take care,
  Gerd


