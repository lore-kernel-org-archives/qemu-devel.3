Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5044EE499F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 13:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soN1I-0000X4-2g; Wed, 11 Sep 2024 09:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1soN1H-0000Tk-4S
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 09:04:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1soN1F-000571-5r
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 09:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726059863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VOQ5X5Pet4QkIz43Am/IGNG5UMJbHehN0WxoN3pegpE=;
 b=FWJX8AJOG8j//KDGa6GUUoKViuucYV3bXVuI89nspr4jJqosu1Prj1jvFUkEd3eZn+5aP5
 dn0I/EaZgcmhkp81w/4Jbwi8q5iGKySF6ttljnHSfEz11VoJ/qS6fNxbok3mtG2evx+zEh
 rkf9bC+/8edAIbKzg+iFXSx1KKWZ/Oo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-f6YVEfzDMBScGq2tFF5QlQ-1; Wed,
 11 Sep 2024 09:04:20 -0400
X-MC-Unique: f6YVEfzDMBScGq2tFF5QlQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32E451955BF8; Wed, 11 Sep 2024 13:04:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCCA930001AB; Wed, 11 Sep 2024 13:04:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 624F921E6A28; Wed, 11 Sep 2024 15:04:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,  eblake@redhat.com,  marcandre.lureau@redhat.com,
 pbonzini@redhat.com,  berrange@redhat.com,  arei.gonglei@huawei.com,
 pizhenwei@bytedance.com,  jonathan.cameron@huawei.com,
 fan.ni@samsung.com,  marcel.apfelbaum@gmail.com,  jiri@resnulli.us,
 jsnow@redhat.com,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH v2 5/8] qapi/pci: Supply missing member documentation
In-Reply-To: <20240911072927-mutt-send-email-mst@kernel.org> (Michael
 S. Tsirkin's message of "Wed, 11 Sep 2024 07:29:45 -0400")
References: <20240911112545.2248881-1-armbru@redhat.com>
 <20240911112545.2248881-6-armbru@redhat.com>
 <20240911072927-mutt-send-email-mst@kernel.org>
Date: Wed, 11 Sep 2024 15:04:14 +0200
Message-ID: <87y13ymje9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Wed, Sep 11, 2024 at 01:25:42PM +0200, Markus Armbruster wrote:
>> Since we neglect to document a member of PciMemoryRegion, its
>> description in the QEMU QMP Reference manual is "Not documented".  Fix
>> that.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>
>
> can you merge this?

Gladly!


