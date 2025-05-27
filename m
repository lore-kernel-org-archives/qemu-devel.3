Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BC5C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 15:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJvob-0005MV-HR; Tue, 27 May 2025 11:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uJvoZ-0005M2-6e
 for qemu-devel@nongnu.org; Tue, 27 May 2025 11:02:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uJvoS-00069E-NN
 for qemu-devel@nongnu.org; Tue, 27 May 2025 11:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748358104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=31kPKLkIWCurP1DCBix1e+sy51CRR99P8dR3ljzKOcA=;
 b=fnmW+fpZYWeoOuiRDZWsheOrji31SoAjnWXSe0vVsufW/d2JlUXe6T9+hDRGntry6rB7fW
 wwyLzGTFjcymfkdaGiYujRsWeuJC0IXVa4KjFmETPACZwEj58FqieOj0VwWIPeDYf2EcIG
 zQJfJAv+9MOycVHX0tkFvvz6yYKNRTE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-hgDVm8_kP1uY8awTNFQKeQ-1; Tue,
 27 May 2025 11:01:42 -0400
X-MC-Unique: hgDVm8_kP1uY8awTNFQKeQ-1
X-Mimecast-MFC-AGG-ID: hgDVm8_kP1uY8awTNFQKeQ_1748358101
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38CE318011FD; Tue, 27 May 2025 15:01:39 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.48])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2D4D180049D; Tue, 27 May 2025 15:01:36 +0000 (UTC)
Date: Tue, 27 May 2025 10:01:33 -0500
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org, 
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 1/4] docs/about: Belatedly document tightening of QMP
 device_add checking
Message-ID: <wund3ui5c5l63pya5fmainknigqhtytny4impe5svadmcxhbh3@ytbokxjcdkvn>
References: <20250521063711.29840-1-armbru@redhat.com>
 <20250521063711.29840-2-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521063711.29840-2-armbru@redhat.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, May 21, 2025 at 08:37:08AM +0200, Markus Armbruster via Devel wrote:
> Commit 4d8b0f0a9536 (v6.2.0) deprecate incorrectly typed device_add

deprecated

> arguments.  Commit be93fd53723c (qdev-monitor: avoid QemuOpts in QMP
> device_add) fixed them for v9.2.0, but neglected to update
> documentation.  Do that now.
> 
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


