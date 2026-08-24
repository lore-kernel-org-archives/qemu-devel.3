Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A418EC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 09:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyQcC-0001fc-9p; Mon, 24 Aug 2026 05:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wyQcA-0001du-Kp
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 05:05:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wyQc9-0002tu-41
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 05:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787562306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U06dmekaGpyFC66yDeEENoQavmPtpQ/kkHKLHgN9cig=;
 b=KvchO/Ms3E+9M4vl4bcl7dNPhW3NLrwlkK/WCPVEbCIsNsOCnbnF8yhaAIZ5MabnFQ8o00
 ryjUkIIEIX3H1rBE2hv2JEhxIdgEty3LejtOj35Eun5n2wL1P93nr/l11jSTKEMb1ysUhF
 Yw1CxuGX5e9yxnKp4TDmv286TSIsOk8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-e_RA67SIM0qG1EajgxfT9w-1; Mon,
 24 Aug 2026 05:05:02 -0400
X-MC-Unique: e_RA67SIM0qG1EajgxfT9w-1
X-Mimecast-MFC-AGG-ID: e_RA67SIM0qG1EajgxfT9w_1787562301
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7C3C180AE16; Mon, 24 Aug 2026 09:05:00 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDF773000239; Mon, 24 Aug 2026 09:04:59 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, Amit Machhiwal
 <amachhiw@linux.ibm.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Chinmay Rath <rathc@linux.ibm.com>
Subject: Re: [PATCH] linux-headers: Update to include KVM_CAP_PPC_COMPAT_CAPS
In-Reply-To: <deff00ce-ece0-4cdd-b1a5-90bb5e6a0835@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260819045924.11732-1-amachhiw@linux.ibm.com>
 <deff00ce-ece0-4cdd-b1a5-90bb5e6a0835@linux.ibm.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Mon, 24 Aug 2026 11:04:57 +0200
Message-ID: <87bjarq47a.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Aug 23 2026, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:

> Hi Cornelia,
>
> Will you be picking it up sometime soon or shall I fold in with 
> respective qemu patches depending on it? Please let me know. TIA.

For headers updates, the usual process is to simply include them with
the series making use of the updates, so please just send them together
with your series.


