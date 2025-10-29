Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D11CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 09:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE2QU-0007AD-LK; Wed, 29 Oct 2025 05:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vE2QO-00078p-5n
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:25:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vE2QI-0005zl-T6
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761729892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8UCSyXJrD26zQ8Dv7aZywJgI1QYlu64U2QjioETlGP0=;
 b=YXoWeQWgo9QV57CKRXxXXugTFRUhgQ8lcA2dhJW+0i29ZBXXY/GZEjmk/1HyUDBa3037B8
 F/lREgSIitXtt1RptcoSenPNAQVDDdnDojOTxtV2CDQsx4JJdo/9sWgbxhkmRyCIYZq2wI
 VcNytWuBG/OFYvzg0uJrlBd7aHvSkdo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-70eQqvxzNHqDlbDmRJTn9Q-1; Wed,
 29 Oct 2025 05:24:47 -0400
X-MC-Unique: 70eQqvxzNHqDlbDmRJTn9Q-1
X-Mimecast-MFC-AGG-ID: 70eQqvxzNHqDlbDmRJTn9Q_1761729886
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF8AF1956094; Wed, 29 Oct 2025 09:24:45 +0000 (UTC)
Received: from localhost (dhcp-192-179.str.redhat.com [10.33.192.179])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0EFA19560AD; Wed, 29 Oct 2025 09:24:44 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>, Alexey
 Kardashevskiy <aik@ozlabs.ru>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH] hw/ppc/sam460ex: Update u-boot-sam460ex
In-Reply-To: <46ac8536-58e9-407e-9ec5-e0e6c67fd80a@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20251028151923.10DBB5972E5@zero.eik.bme.hu>
 <ee77b09f-7a12-4d52-b5f6-2d4b5b711448@linux.ibm.com>
 <46ac8536-58e9-407e-9ec5-e0e6c67fd80a@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Wed, 29 Oct 2025 10:24:42 +0100
Message-ID: <87jz0et605.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 29 2025, Thomas Huth <thuth@redhat.com> wrote:

> On 29/10/2025 07.31, Harsh Prateek Bora wrote:
>> + Thomas
>> 
>> Hi BALATON,
>> 
>> I am unable to fetch it with b4 am, and I do not see it appear on lore also, 
>> not sure if its due to the binary size.
>> 
>> harshpb:patches$ b4 am 20251028151923.10DBB5972E5@zero.eik.bme.hu
>> Looking up https://lore.kernel.org/ 
>> r/20251028151923.10DBB5972E5%40zero.eik.bme.hu
>> Grabbing thread from lore.kernel.org/ 
>> all/20251028151923.10DBB5972E5%40zero.eik.bme.hu/t.mbox.gz
>> Server returned an error: 404
>> harshpb:patches$
>> 
>> I guess you may need to send a PULL SUBSYSTEM req like Thomas did for slof:
>> https://lore.kernel.org/qemu-devel/20251027074404.25758-1-thuth@redhat.com/
>> 
>> Hi Thomas,
>> Is it a known thing to deal with binary updates ?
>
>   Hi,
>
> honestly, I can't remember clearly why we introduced these subsystem pull 
> requests in the past ... Maybe it was related to some problems with binary 
> patches, but I think it was rather meant as a staged approach for the case 
> where the maintainer of the firmware is not the main maintainer of the 
> architecture subsystem, so that the main maintainer gets another chance of 
> doing tests before the final pull request to the master branch.
>
> Conny, Alexey, do you remember?

Hmm... I thought subsystem pull reqs were mainly intended for the case
where there might be different maintainers, or one person handling a
subsys for that release. However, I'm not sure if I ever actually b4
am'ed a binary update (for s390, I think I usually regenerated the
binary myself, and it would get merge via a pull from whoever was
handling the main branch.)

Regardless, I think it's easiest to put a binary update into its own
separate patch?


