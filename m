Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2B1CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 06:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGW7L-0005Qy-9s; Tue, 13 Oct 2026 02:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1xGW7J-0005QY-R9
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 02:36:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1xGW7I-0004J5-D9
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 02:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791873361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+MbXRN4y+7vmGLQJpO/Rh+I/D8CZdQtY3c/mYcuRJPM=;
 b=hBNJcUvyDqKEy+Ws78L/HZJasxW/4JClS2KZDNAHXMTLqvdPjK+OWjyNmDcEQRPBFDdkm9
 MqmuA0NzkXmRLVnmHRwhKf4eq0ISvHg3gxcUSOTdG0LCs1RIEgkjqNAqmdbccswec+USba
 k1Lnp0sZKgnkzGSrfnk0J7bOoP7neCM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-KiyG0pzzP0yQdpeblkS_MA-1; Tue,
 13 Oct 2026 06:35:52 +0000
X-MC-Unique: KiyG0pzzP0yQdpeblkS_MA-1
X-Mimecast-MFC-AGG-ID: KiyG0pzzP0yQdpeblkS_MA_1791873348
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F5081955D7A; Tue, 13 Oct 2026 06:35:48 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2432130001B9; Tue, 13 Oct 2026 06:35:45 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, maciej.szmigiero@oracle.com,
 peterx@redhat.com, farosas@suse.de, mark.kanda@oracle.com,
 bchaney@akamai.com, pierrick.bouvier@oss.qualcomm.com, alex@shazbot.org,
 clg@redhat.com, yi.l.liu@intel.com, eric.auger@redhat.com,
 zhenzhong.duan@intel.com, mst@redhat.com, pbonzini@redhat.com,
 armbru@redhat.com, eblake@redhat.com
Subject: Re: [PATCH 04/21] linux-headers: import liveupdate UAPI header
In-Reply-To: <20261012235727.398133-5-dongli.zhang@oracle.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20261012235727.398133-1-dongli.zhang@oracle.com>
 <20261012235727.398133-5-dongli.zhang@oracle.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Tue, 13 Oct 2026 08:35:43 +0200
Message-ID: <874ieq3y68.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

On Mon, Oct 12 2026, Dongli Zhang <dongli.zhang@oracle.com> wrote:

> Import the Linux liveupdate UAPI header for cpr-luo support.
> QEMU uses this header to issue the ioctls for session and file descriptor
> preservation and retrieval.
>
> It is from Linux kernel include/uapi/linux/liveupdate.h.
>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  linux-headers/linux/liveupdate.h | 239 +++++++++++++++++++++++++++++++
>  1 file changed, 239 insertions(+)
>  create mode 100644 linux-headers/linux/liveupdate.h

Please make this a full headers update, instead of just adding one file.


