Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC69C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 09:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tna9f-0004hc-Au; Thu, 27 Feb 2025 04:26:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tna9d-0004gR-HU
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 04:26:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tna9a-0007Vc-AB
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 04:26:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740648361;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h83qsse6OIJaOz2EAqDOfmYi9BhxIhKpc2OAfqCLMlU=;
 b=aUg4QJVXM/d06fi/pSsY5tVeFExvZyi7PDRqET5z0VwFRMZNadgcPZT9gV4P2tlbgT+r8E
 SRlajFlc6bTHlmtaDQ2KGmOkSG0k9mlRWFFGMMXZ0f6OOBcirkoYLyjUePdYB3Qa+CRB5C
 w2yduK6TwCPeseqOQDTsxo3s3ElqI3Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-oXISbqNnPim4Ifkq4vs_5g-1; Thu,
 27 Feb 2025 04:25:53 -0500
X-MC-Unique: oXISbqNnPim4Ifkq4vs_5g-1
X-Mimecast-MFC-AGG-ID: oXISbqNnPim4Ifkq4vs_5g_1740648353
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CBA8185B918; Thu, 27 Feb 2025 09:25:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.99])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB4211800371; Thu, 27 Feb 2025 09:25:38 +0000 (UTC)
Date: Thu, 27 Feb 2025 09:25:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, eduardo@habkost.net
Subject: Re: [PATCH v2 4/6] qdev: Change values of PropertyInfo member @type
 to be QAPI types
Message-ID: <Z8Avjov46b3baoJr@redhat.com>
References: <20250227085601.4140852-1-armbru@redhat.com>
 <20250227085601.4140852-5-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250227085601.4140852-5-armbru@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Feb 27, 2025 at 09:55:59AM +0100, Markus Armbruster wrote:
> PropertyInfo member @type is externally visible via QMP
> device-list-properties and qom-list-properies.
> 
> Its meaning is not documented at its definition.
> 
> It gets passed to as @type argument to object_property_add() and

                 ^^^^^  "passed as the @type argument" ?

> object_class_property_add().  This argument's documentation isn't of
> much help, either:
> 
>  * @type: the type name of the property.  This namespace is pretty loosely
>  *   defined.  Sub namespaces are constructed by using a prefix and then
>  *   to angle brackets.  For instance, the type 'virtio-net-pci' in the
>  *   'link' namespace would be 'link<virtio-net-pci>'.
> 
> The two QMP commands document it as
> 
>  # @type: the type of the property.  This will typically come in one of
>  #     four forms:
>  #
>  #     1) A primitive type such as 'u8', 'u16', 'bool', 'str', or
>  #        'double'.  These types are mapped to the appropriate JSON
>  #        type.
>  #
>  #     2) A child type in the form 'child<subtype>' where subtype is a
>  #        qdev device type name.  Child properties create the
>  #        composition tree.
>  #
>  #     3) A link type in the form 'link<subtype>' where subtype is a
>  #        qdev device type name.  Link properties form the device model
>  #        graph.
> 
> "Typically come in one of four forms" followed by three items inspires
> the level of trust that is appropriate here.

> 
> Clean up a bunch of funnies:
> 
> * qdev_prop_fdc_drive_type.type is "FdcDriveType".  Its .enum_table
>   refers to QAPI type "FloppyDriveType".  So use that.
> 
> * qdev_prop_reserved_region is "reserved_region".  Its only user is an
>   array property called "reserved-regions".  Its .set() visits str.
>   So change @type to "str".
> 
> * trng_prop_fault_event_set.type is "uint32:bits".  Its .set() visits
>   uint32, so change @type to "uint32".  If we believe mentioning it's
>   actually bits is useful, the proper place would be .description.
> 
> * ccw_loadparm.type is "ccw_loadparm".  It's users are properties
>   called "loadparm".  Its .set() visits str.  So change @type to
>   "str".
> 
> * qdev_prop_nv_gpudirect_clique.type is "uint4".  Its set() visits
>   uint8, so change @type to "uint8".  If we believe mentioning the
>   range is useful, the proper place would be .description.
> 
> * s390_pci_fid_propinfo.type is "zpci_fid".  Its .set() visits uint32.
>   So change type to that, and move the "zpci_fid" to .description.
>   This is admittedly a lousy description, but it's still an
>   improvement; for instance, output of -device zpci,help changes from
> 
>       fid=<zpci_fid>
> 
>   to
> 
>       fid=<uint32>           - zpci_fid
> 
> * Similarly for a raft of PropertyInfo in target/riscv/cpu.c.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/core/qdev-properties-system.c |  4 +--
>  hw/misc/xlnx-versal-trng.c       |  2 +-
>  hw/s390x/ccw-device.c            |  2 +-
>  hw/s390x/s390-pci-bus.c          |  3 ++-
>  hw/vfio/pci-quirks.c             |  2 +-
>  target/riscv/cpu.c               | 44 ++++++++++++++++++++++----------
>  6 files changed, 37 insertions(+), 20 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


