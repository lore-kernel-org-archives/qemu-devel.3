Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98204E909BA
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 15:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsN1W-0005GT-4s; Tue, 17 Feb 2026 10:30:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsN1L-0005FF-57
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 10:29:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsN1G-0006KQ-CA
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 10:29:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771342184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u7L6r+WvEILVQ2Nfmd3rBsu7inRdDETDkvqoX5OGXsE=;
 b=H/Ewq8uN1ODWqzngVuuJaFO3/Liuu4clPQXg4aaMh0AWJSLWC1W1oW0YZ8o3ZsRjbsEz5c
 e0WpjRzjqzFbeOaJy7UBlHhDIpGo+unZeNSD0SI1jCLjKcn8Dsv8GQVUlSpJDJpOBfy95y
 unfzyygn8FCyd3K0vuFgZalnyhWEzII=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-1T49SIP4MvmhhzNm6rL15Q-1; Tue,
 17 Feb 2026 10:29:40 -0500
X-MC-Unique: 1T49SIP4MvmhhzNm6rL15Q-1
X-Mimecast-MFC-AGG-ID: 1T49SIP4MvmhhzNm6rL15Q_1771342179
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F07618002E6; Tue, 17 Feb 2026 15:29:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C25630001A5; Tue, 17 Feb 2026 15:29:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8827921E692D; Tue, 17 Feb 2026 16:29:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Kashyap Chamarthy
 <kchamart@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 1/1] docs/interop/firmware: Add 'uefi-vars' member
 for FirmwareMappingMemory
In-Reply-To: <CABJz62MVB1ThuQ95Y0LVSdJ25mSBrct8FyS7GFhm4PXz_yKqjg@mail.gmail.com>
 (Andrea Bolognani's message of "Tue, 17 Feb 2026 05:18:59 -0800")
References: <20260209133906.294720-1-abologna@redhat.com>
 <20260209133906.294720-2-abologna@redhat.com>
 <87seazn3ep.fsf@pond.sub.org>
 <CABJz62MVB1ThuQ95Y0LVSdJ25mSBrct8FyS7GFhm4PXz_yKqjg@mail.gmail.com>
Date: Tue, 17 Feb 2026 16:29:36 +0100
Message-ID: <87y0krgzhb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.754, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Andrea Bolognani <abologna@redhat.com> writes:

> On Tue, Feb 17, 2026 at 10:08:14AM +0100, Markus Armbruster wrote:
>> > +# @uefi-vars: Information specific to firmware builds that expect the
>> > +#             "uefi-vars" device to be used to provide access to the
>> > +#             UEFI variable store.  If the mapping contains this
>> > +#             member, the firmware descriptor should advertise the
>> > +#             @uefi interface from @FirmwareOSInterface as well as
>> > +#             the @host-uefi-vars feature from @FirmwareFeature.
>> > +#             Since 11.0
>> > +#
>>
>> (Since 11.0) and indent like this, please:
>
> Done, but note that the documentation for existing members
> FirmwareDevice::igvm and FirmwareMappingFlash::mode doesn't follow
> this convention.

... where "this convention" is about since.  You're right, and I wasn't
aware of it.  Thanks!


