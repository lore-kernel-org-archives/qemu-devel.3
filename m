Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB5BC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 11:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJsEu-00038p-II; Tue, 27 May 2025 07:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJsEs-00037H-21
 for qemu-devel@nongnu.org; Tue, 27 May 2025 07:12:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJsEn-0007QT-Cj
 for qemu-devel@nongnu.org; Tue, 27 May 2025 07:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748344370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BS8iwXGdq42MM4m6bJ9rci812PR5KS63ma34KxXPdWg=;
 b=SdFDVYq/dVpJNhw76dYrwEXzgQKuA8yNxbuiRazYFoAGs/65BWLKpbNmmKD5B07ec36Ulm
 rIKGl0icSw7o0a3YuwNqiPOjrYPp+6jFXCDq5J25ULlOHfXd8W58UMSPeYxveLT+Z0PpC4
 /O8Aad5ub7o8qtjW05u546XmuSULeIo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512--OW7vAPxMkuJikHZWmM9-g-1; Tue,
 27 May 2025 07:12:47 -0400
X-MC-Unique: -OW7vAPxMkuJikHZWmM9-g-1
X-Mimecast-MFC-AGG-ID: -OW7vAPxMkuJikHZWmM9-g_1748344366
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCD08180045C; Tue, 27 May 2025 11:12:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33375180049D; Tue, 27 May 2025 11:12:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 78DAA21E675E; Tue, 27 May 2025 13:12:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  michael.roth@amd.com,  thuth@redhat.com,
 pbonzini@redhat.com,  richard.henderson@linaro.org,
 peter.maydell@linaro.org,  berrange@redhat.com,  philmd@linaro.org
Subject: Re: [PATCH v4 13/15] qapi: use imperative style in documentation
In-Reply-To: <20250522190542.588267-14-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 22 May 2025 12:05:40 -0700")
References: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
 <20250522190542.588267-14-pierrick.bouvier@linaro.org>
Date: Tue, 27 May 2025 13:12:42 +0200
Message-ID: <87v7pmqpcl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> As requested by Markus:
>> We prefer imperative mood "Return" over "Returns".
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

There are a few more:

/home/armbru/work/qemu/qapi/block.json:86:# Returns a list of information about each persistent reservation
/home/armbru/work/qemu/qapi/control.json:94:# Returns the current version of QEMU.
/home/armbru/work/qemu/qapi/dump.json:198:# Returns the available formats for dump-guest-memory
/home/armbru/work/qemu/qapi/machine.json:933:# Returns information for all memory backends.
/home/armbru/work/qemu/qapi/machine.json:1238:# Returns the hv-balloon driver data contained in the last received
/home/armbru/work/qemu/qapi/migration.json:2330:# Returns information of migration threads
/home/armbru/work/qemu/qapi/misc.json:104:# Returns a list of information about each iothread.
/home/armbru/work/qemu/qapi/ui.json:688:# Returns a list of vnc servers.  The list can be empty.
/home/armbru/work/qemu/qapi/virtio.json:27:# Returns a list of all realized VirtIODevices

If you need to respin for some other reason, then it would be nice to
change these, too.


