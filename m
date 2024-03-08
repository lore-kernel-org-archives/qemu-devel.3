Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16C3C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 16:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricn3-0004iA-7T; Fri, 08 Mar 2024 11:09:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ricn1-0004hw-2R
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 11:09:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ricmx-0007pv-4S
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 11:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709914178;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=CPxeNsvxLG5NRMHi6hbzOqSnDNMP1hFXhqS8FHQzYps=;
 b=KY6+lEjp1HsPLXbwVAmIv0854WqJnwyrRFd2wMKFBszimxd3DUEETyO4OWXx81JqHcKx7W
 a3awbdqKADgxv8AQ5JMtKibdnvdhQ7D+T5IRV77yAEZjfLEc9j6FBmRGfs65SwjE3NGMUO
 0youyVfL/pKU9VuJkS8Y9SiOK8csxtw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-A5WpggXzOWu99_wDvps81Q-1; Fri,
 08 Mar 2024 11:09:37 -0500
X-MC-Unique: A5WpggXzOWu99_wDvps81Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C163C1C00B8C;
 Fri,  8 Mar 2024 16:09:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 00428492BFD;
 Fri,  8 Mar 2024 16:09:35 +0000 (UTC)
Date: Fri, 8 Mar 2024 16:09:33 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 3/4] docs/interop/firmware.json: Use full include paths
Message-ID: <Zes4PfcvOLIE3LPD@redhat.com>
References: <20240306-qapi-firmware-json-v1-0-619f7122a249@linutronix.de>
 <20240306-qapi-firmware-json-v1-3-619f7122a249@linutronix.de>
 <87le6s21kh.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87le6s21kh.fsf@pond.sub.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Mar 08, 2024 at 04:19:42PM +0100, Markus Armbruster wrote:
> The coupling with the main QAPI schema is unfortunate.
> 
> The purpose of docs/interop/firmware.json is to serve as schema for
> firmware descriptions: a firmware description is a JSON object that
> conforms to this schema's struct Firmware.
> 
> Such a description should be installed along with each firmware binary.
> 
> QAPI tooling can be used to check conformance: parse the firmware
> description JSON object, feed it to the generated visit_type_Firmware().
> Success implies conformance.
> 
> If you find more uses for the C struct Firmware created by
> visit_type_Firmware(), more power to you.
> 
> firmware.json needs machine.json for SysEmuTarget, and block-core.json
> for BlockdevDriver.  The largest and the third-largest QAPI module just
> for two enums.  Almost a quarter Mebibyte of code.

firmware.json can use BlockdevDriver, but we could question
whether it /should/ use BlockdevDriver. Is there really a
compelling reason to support every possible block driver for
readonly firmware and tiny nvram file ? I thin kit would be
totally reasonable to define a "FirmwareFormat" enum which
only permitted 'raw' and 'qcow2'.   If someone wants to
justify why we need another format, I'm all ears...

For SysEmuTarget its a little more useful, as in theory the
firmware could be extended to any QEMU target. In practice
thus far we've only used it todescribe EFI based firmware,
which is relevant for a subset of targets. It doesn't seem
to be a huge downside to define a FirmwareTarget enum with
only the arches we've actually got a use for so far. When
someone comes along with a need for non-EFI we can extend
it, and we'll need to extend libvirt at the same time anyway

> qapi-gen.py generates more than 12kSLOC.  Without the include (and with
> the enums dumbed down to 'str' to enable that), it generates less than
> 800.
> 
> We could use Sphinx to generate a manual from firmware.json's document.
> Except that manual would be useless, because of its 11,000 lines of
> HTML, less than 800 are for firmware.json.
> 
> Options:
> 
> * Live with the mess.
> 
> * Refactor QAPI modules so firmware.json can include just the enums.
> 
>   Drawback: we spread the mess into qapi/.  Ugh.
> 
> * Copy the enums to firmware.json.
> 
>   Drawback: we risk them going stale.

IMHO copy the enum. While the risk exists, I don't think it is a
risk worth worrying about in reality. If someone points out a gap
that's important is a matter of minutes to patch it.

> * Dumb down to 'str'.
> 
>   Drawback: the conformance check no longer enforces the value of
>   FirmwareTarget member @architecture and FirmwareFlashFile member
>   @format is valid.




With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


