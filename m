Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7925CC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ric0o-0005vI-Fg; Fri, 08 Mar 2024 10:19:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ric0n-0005uc-0l
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:19:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ric0l-0004nt-8J
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709911189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JZDnMCq+muF6Pb9qLjvISWa1J7/Q643ZeCzUrmoUL8g=;
 b=GVD2feLUloqaqCR9RwoP6+9qv0kHiUlqlgj7VzlxJGP7yuxRkNiJIBEug1EA4FJsOeaTXv
 ZhozJT1kaFivUpNXfDYcC/k+pNzAnBqvq4Xww3L0UC5ZoqGiVYj2Ri3yhSwS/NvilkupUz
 7ubdne2LHzgibp4LmByn7GhHL91jQ34=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-pe19LvgLPyuCPmB1deWqQw-1; Fri,
 08 Mar 2024 10:19:44 -0500
X-MC-Unique: pe19LvgLPyuCPmB1deWqQw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 047361C05EA7;
 Fri,  8 Mar 2024 15:19:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D62F347CB;
 Fri,  8 Mar 2024 15:19:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C3EC921E6A24; Fri,  8 Mar 2024 16:19:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Kashyap Chamarthy <kchamart@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 3/4] docs/interop/firmware.json: Use full include paths
In-Reply-To: <20240306-qapi-firmware-json-v1-3-619f7122a249@linutronix.de>
 ("Thomas =?utf-8?Q?Wei=C3=9Fschuh=22's?= message of "Wed, 06 Mar 2024
 11:31:24 +0100")
References: <20240306-qapi-firmware-json-v1-0-619f7122a249@linutronix.de>
 <20240306-qapi-firmware-json-v1-3-619f7122a249@linutronix.de>
Date: Fri, 08 Mar 2024 16:19:42 +0100
Message-ID: <87le6s21kh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> writes:

> The included files are part of the toplevel QAPI directory and need to
> be included from there.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  docs/interop/firmware.json | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
> index 54a1fc6c1041..4ac840e2b413 100644
> --- a/docs/interop/firmware.json
> +++ b/docs/interop/firmware.json
> @@ -14,8 +14,8 @@
>  # =3D Firmware
>  ##
>=20=20
> -{ 'include' : 'machine.json' }
> -{ 'include' : 'block-core.json' }
> +{ 'include' : '../../qapi/machine.json' }
> +{ 'include' : '../../qapi/block-core.json' }
>=20=20
>  ##
>  # @FirmwareOSInterface:

The coupling with the main QAPI schema is unfortunate.

The purpose of docs/interop/firmware.json is to serve as schema for
firmware descriptions: a firmware description is a JSON object that
conforms to this schema's struct Firmware.

Such a description should be installed along with each firmware binary.

QAPI tooling can be used to check conformance: parse the firmware
description JSON object, feed it to the generated visit_type_Firmware().
Success implies conformance.

If you find more uses for the C struct Firmware created by
visit_type_Firmware(), more power to you.

firmware.json needs machine.json for SysEmuTarget, and block-core.json
for BlockdevDriver.  The largest and the third-largest QAPI module just
for two enums.  Almost a quarter Mebibyte of code.

qapi-gen.py generates more than 12kSLOC.  Without the include (and with
the enums dumbed down to 'str' to enable that), it generates less than
800.

We could use Sphinx to generate a manual from firmware.json's document.
Except that manual would be useless, because of its 11,000 lines of
HTML, less than 800 are for firmware.json.

Options:

* Live with the mess.

* Refactor QAPI modules so firmware.json can include just the enums.

  Drawback: we spread the mess into qapi/.  Ugh.

* Copy the enums to firmware.json.

  Drawback: we risk them going stale.

* Dumb down to 'str'.

  Drawback: the conformance check no longer enforces the value of
  FirmwareTarget member @architecture and FirmwareFlashFile member
  @format is valid.

Thoughts?


