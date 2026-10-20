Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6DA606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 06:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AhA1gxYu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ3Q9-00036K-R3; Tue, 20 Oct 2026 02:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ3Q1-00035q-4v
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:33:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ3Px-0007w6-6w
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792478027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1C7YUzRIFybbbyluw4PkNehth5lFNYv2vxV96OWYJ28=;
 b=AhA1gxYuLEga7+ZdM/wUhqB30VarpoOXIXV0MEo0p32JUiF5NBaEsuP193eU08V9ja5OPA
 QqtNM0BxjJ2dMPkDOx52xsMVVm2t24OUkMDu3OyOZmKar87cQDMQxGaNh03Y/cG9GjbcEu
 JoQyBLqh1EzC7towsDQLyYfeFAQ2XGk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-rxLjowHGOVuX8_eRXdCsLQ-1; Tue,
 20 Oct 2026 06:33:44 +0000
X-MC-Unique: rxLjowHGOVuX8_eRXdCsLQ-1
X-Mimecast-MFC-AGG-ID: rxLjowHGOVuX8_eRXdCsLQ_1792478023
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E9301955BCF; Tue, 20 Oct 2026 06:33:43 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C38E741B; Tue, 20 Oct 2026 06:33:41 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 00/65] qom/qdev: associate properties with QAPI
 schema types
From: marcandre.lureau@redhat.com
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 berrange@redhat.com, michael.roth@amd.com, 
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 kkostiuk@redhat.com, alistair.francis@wdc.com, amachhiw@linux.ibm.com
In-Reply-To: <20261019141929.1594337-1-armbru@redhat.com>
References: <20261019141929.1594337-1-armbru@redhat.com>
Date: Tue, 20 Oct 2026 10:33:32 +0400
Message-Id: <179247801289.2782576.15052785737534296172.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2621;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=TF7oXo9W5LtYOFDM4L+zzsMwjCria5It8nnf/ZmmVVI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq1wtBir8JX92mjSEanNevFfCKoXW8qjWWLjo9J
 6l1qJFeyQeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatcLQQAKCRDa6OEJdZac
 5RleEACb0Plj5KepMXCmReYiJ8/JHQFCtTF2ImUXRglGZ+S8sFOs+GdGcsSh6GKpfZsEns1yKTt
 P+dotaWf4NLMLeJ5uaDvoWVIy8gGKl874hpzNWv1hSE7ZMUi+M55LgjmV442ynz2PTyZ72KEssp
 Hcu0a3nwWayAEvWbMVulOungd74x7k5zSrk18eLmpFz300Fp6SiK8KFvNEGvsA5bHhlHhv2LQbl
 05hts8BYbCYDVQ1hjh3r/cNdDovpX7e3MzjyEOrJmIwZLufFli3yqS8gP7Pq3I/41oJXpnZUmSL
 CObFGIGv2SISha+zmzgLK0X77pxLMd1KuG7+fQTImBVpmsZFdb2d2o3Mt9PA/cHA0r30/Kfe8+u
 NxAGCSp6txMLcGXyYcQ5C05FQaRtDYTx6yFR/Vozy/RGdzP0IsIFLsKY1aw089D3qOsGv4zoemI
 wL7pskKbYJ4n1mewP7PEEXcIQrjrxV/uH1Ky7PSWnKUAzRcgNsrWih6KZUfU03Qhfm9xDUy6ncR
 ndMyxpdUB1Y6vo2eoAlUCf50EnjQJST/Kf9f5NCJh/8ITEoOpSr4XWWAFxaay015OBq6lIuDwJf
 GjJqKlRihV1CCq4VgsQplBFAaE0ONjaN7uA02QRkFHo9h+0LBCFyMZqQesCUgTeoENjNWTbdIZQ
 lGvuqqhM0iuIMMw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> I rewrote some QAPI infrastructure parts of Marc-André's v5.  Me
> sending the result is easier, because it's already in my tree.
> Marc-André's cover letter follows.
> 
> This series connects QOM and qdev properties to the QAPI type system, so
> that management tools can discover the QAPI schema type of each object
> property.
> 
> Today, QOM properties carry a free-form "type" string ("bool", "uint32",
> "OnOffAuto", ..) that has no formal link to the QAPI schema exposed by
> query-qmp-schema. Management tools must maintain ad-hoc mappings or rely
> on naming conventions to figure out how to interpret property values.
> 
> This series adds:
>   - A new QAPITypeInfo struct that pairs a property with its QAPI schema
>     type name, enum lookup table, and list-element type.
> 
>   - A QAPI code generator (qapi-type-infos) that emits a QAPITypeInfo
>     instance for every schema-defined type, including the mapping
>     between internal C names and the schema name visible to clients.
> 
>   - A "qapi-type" field in the ObjectPropertyInfo and
>     ObjectPropertyValue QMP structs, populated from the QAPITypeInfo
>     when present giving clients a cross-reference into query-qmp-schema
>     output.
> 
>   - Conversion of all PropertyInfo definitions from the old
>     .type/.enum_table strings to the new .qapi_type pointer.
> 
>   - Replacement of the generic qdev_prop_array with typed per-element
>     array PropertyInfos, removing the arrayinfo/arrayfieldsize
>     indirection from struct Property.
> 
>   - Removal of the deprecated PropertyInfo.type and .enum_table fields,
>     and of the old object_property_add_enum/add_tm APIs.
> 
> Along the way, a few pre-existing type mismatches in property
> definitions are fixed, the "struct tm" RTC property is replaced with a
> proper QAPI StructTm type etc. Introducing more specific types or a
> "typedef" to QAPI could help provide better associated type informations
> than plain "str" in many cases, for example.
> 
> Changes in v6:
> - Rebase, resolve a few conflicts
> - Replace old PATCH 03-04 by new PATCH 01-06, adjust PATCH 09 [old
>   PATCH 05]
> - Fix temporary build breakage: convert PCSouthBridgeOption only when
>   it gets QAPIfied [PATCH 62], delay removal of old interface until
>   after that [PATCH 63].
> - Clean up checkpatch long line warnings, except leave the ones in
>   PATCH 38 for later

Thanks a lot for the v6. I have added minor comments to some of my own patches.
Would you like me to send a v7?

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


