Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A46D0E6CC
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 08:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2ntS-0000Gf-SA; Mon, 21 Oct 2024 04:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t2ntG-0000CL-By
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 04:35:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t2ntD-0005QC-8t
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 04:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729499735;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ITMHCREG1i4rwSD3Hir9F6AnXdUrVJFNJttuvlRHknY=;
 b=PSb7/ToLfPcsdUViz/lgPAMs0drg5eeemse9OUbzzFMIv4eLvXsF5vapWGi1ExV9/ndR3L
 WelBnGajZ+WtqGkgNiWcdTZAuJpCG6dOCqdlMiRv/yJoqQ4jWwL0X0FdQkjGHCb2RMj6vg
 3mQuqN+YtBhzBB4z7VLXcC3KsLl2KbM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-1gvUk4sMPU6kYp4zqiBuzg-1; Mon,
 21 Oct 2024 04:35:29 -0400
X-MC-Unique: 1gvUk4sMPU6kYp4zqiBuzg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E93271956096; Mon, 21 Oct 2024 08:35:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.27])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16342300018D; Mon, 21 Oct 2024 08:35:25 +0000 (UTC)
Date: Mon, 21 Oct 2024 09:35:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Subject: Re: [Question] What is the =?utf-8?Q?defin?=
 =?utf-8?B?aXRpb24gb2Yg4oCccHJpdmF0ZeKAnQ==?= fields in QOM?
Message-ID: <ZxYSSp1wkifLy3tV@redhat.com>
References: <ZxPZ5oUDRcVroh7o@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxPZ5oUDRcVroh7o@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Oct 20, 2024 at 12:10:14AM +0800, Zhao Liu wrote:
> Hi maintainers and list,
> 
> In the QOM structure, the class and object structs have two members:
> parent_class and parent_obj, which are often marked as "< private >" in
> the comment.
> 
> I couldn’t find information on why to define ‘private’ and ‘public’,
> even in the earliest QOM commits and the patch emails I could find.
> 
> Does ‘private’ refer to the internal implementation code of QOM, or does
> it refer to the specific code that defines and implements this object
> and its class?
> 
> I understand the original idea of private field indicates it cannot be
> accessed directly out of the "private" scope.

I see two scenarios

 * Devices where the structs are in the include/..../<blah>.h

   The private/public comments are a message to other code in QEMU about
   which fields are OK to access directly, and which should not be accessed.


 * Devices where the structs are in the ../<blah>.c

   The private/public comments look entirely pointless, as everything
   is private to the .c file.


99% of the time it seems the "parent" / "parent_obj" fields are the only
one marked private. There are a handful of classes where other fields are
under the private comment, but not many. 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


