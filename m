Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEACC282C5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 12:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnzfi-0007OK-Be; Fri, 28 Feb 2025 07:40:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tnzfW-0007NV-7m
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 07:40:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tnzfU-00046c-0l
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 07:40:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740746438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vQ0rUJp02I8H++/BKG7HPrAZH41+2rKBDrcTBQ3hgYs=;
 b=S4Qw+I8PqRMdEQFfpLNewMjBkzm+4rECF2UKRjm3dM4rVSJqvRMfxXHCXe8NLZkxZtRoju
 KOBPLda1FDKa3HWrEfcT3RZwvIE00XSvlsZE3nMOiSBmfArGooBeSvlU8nsq5U9nG+Jc3a
 hgN1cYzAuY6LGAe9NcLJBRiMo74xyrQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-AGTt8hN8M_6yJ7zam-xgVA-1; Fri,
 28 Feb 2025 07:40:31 -0500
X-MC-Unique: AGTt8hN8M_6yJ7zam-xgVA-1
X-Mimecast-MFC-AGG-ID: AGTt8hN8M_6yJ7zam-xgVA_1740746429
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 165C7180056F; Fri, 28 Feb 2025 12:40:29 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.2.18.23])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99271180176B; Fri, 28 Feb 2025 12:40:28 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5549C18000A3; Fri, 28 Feb 2025 13:40:26 +0100 (CET)
Date: Fri, 28 Feb 2025 13:40:26 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3] hw/i386: introduce x86_firmware_reconfigure api
Message-ID: <kb5frnltrywonxdt64s3tbrf47s6d4q3u4io7dono7xwxhjj3b@2vlowkctwmrk>
References: <20250228114230.306852-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228114230.306852-1-anisinha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, Feb 28, 2025 at 05:12:30PM +0530, Ani Sinha wrote:
> Normally, there is no need to perform firmware reconfiguration once the
> virtual machine has started. Hence, currently ovmf firmware parsing happens only
> once. However, if the firmware changes betweeen boots then reconfiguration needs
> to happen again. Firmware can change if for example the guest brings its own
> firmware bundle and installs it with the help of the hypervisor[1]. Therefore,
> this change introduces a new api with which firmware configuration steps can
> be forced again.
> This is mostly refactoring work. No functional changes. CI pipeline does not
> break with this change.
> 
> 1) https://pretalx.com/kvm-forum-2024/talk/HJSKRQ/
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>


