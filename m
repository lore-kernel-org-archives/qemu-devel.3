Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459F5D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 12:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ3Os-00047G-Su; Mon, 01 Dec 2025 07:53:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=423f6341f=bchalios@amazon.es>)
 id 1vQ3Or-000422-7o
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 07:53:05 -0500
Received: from fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com
 ([18.158.153.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=423f6341f=bchalios@amazon.es>)
 id 1vQ3Oo-0003qc-0f
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 07:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
 t=1764593582; x=1796129582;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=8uekmCgfryNWdzsErgB2fO0NAb4G4PAane8olc/DdHw=;
 b=egL7QlRN/gG/uKu0FunLerX2seW8SrM3A1MH5pReT4TIWJ1+4ofb7LuP
 cBRpN+CYwbEf06MZ4J+/nWjNG1TdFQADWYsJm/b+sg7jUzrfigzE2dcjb
 XFs43otNCeFqDkzt8UCSDKUDeo1tyA3mIChLTC8xNWCE8XoAqrLDOqN/n
 JfrXeoukbBCGm9+H9BS22rEoKhbQ2TGuEx1yF2qklu74Itex8GwyAItdr
 EIqb+XhycjhfYTXJt1d2F1puIBud/PrE7T4bq4JGW63hT+cvzyIPPxWYh
 25krNirdW7KePUZDOMvrUGBgZ0ibn83I7zyumUtWYDEUlBYgpZ1phjBC3 Q==;
X-CSE-ConnectionGUID: Wn11RTKeS9aZMrdb6yaCYA==
X-CSE-MsgGUID: fVqmtLQOS3KpeS4NmxkrsA==
X-IronPort-AV: E=Sophos;i="6.20,240,1758585600"; d="scan'208,217";a="5937543"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO
 smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
 by internal-fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com
 with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 12:52:36 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:9489]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.44.247:2525]
 with esmtp (Farcaster)
 id e7955ce5-9753-4db1-a4d9-4312a06d54c7; Mon, 1 Dec 2025 12:52:36 +0000 (UTC)
X-Farcaster-Flow-ID: e7955ce5-9753-4db1-a4d9-4312a06d54c7
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 1 Dec 2025 12:52:32 +0000
Received: from [0.0.0.0] (10.13.181.70) by EX19D012EUA001.ant.amazon.com
 (10.252.50.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Mon, 1 Dec 2025
 12:52:27 +0000
Message-ID: <10e122b8-7dab-4483-9826-121924ae7bd2@amazon.es>
Date: Mon, 1 Dec 2025 13:52:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] vmclock: add support for VM generation counter
 and notifications
To: "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "dwmw2@infradead.org"
 <dwmw2@infradead.org>, "Graf (AWS), Alexander" <graf@amazon.de>,
 "mzxreary@0pointer.de" <mzxreary@0pointer.de>, <bchalios@amazon.es>
References: <20251201125023.18344-1-bchalios@amazon.es>
 <20251201125023.18344-2-bchalios@amazon.es>
Content-Language: en-US
From: Babis Chalios <bchalios@amazon.es>
In-Reply-To: <20251201125023.18344-2-bchalios@amazon.es>
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.13.181.70]
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D012EUA001.ant.amazon.com (10.252.50.122)
Received-SPF: pass client-ip=18.158.153.154;
 envelope-from=prvs=423f6341f=bchalios@amazon.es;
 helo=fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, MIME_HTML_ONLY=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

<!DOCTYPE html>
<html data-lt-installed="true">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body style="padding-bottom: 1px;">
    <br>
    <br>
    <div class="moz-cite-prefix">On 12/1/25 13:50, Chalios, Babis wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20251201125023.18344-2-bchalios@amazon.es">
      <pre wrap="" class="moz-quote-pre">Latest specification of VMClock[1] adds support for VM generation counter
and notifications. VM generation counter is similar to disruption_marker
but it only changes when the guest has been loaded from a snapshot, not
on live migration. Its purpose is to notify the guest about snapshot
events and let it perform actions such as recreating UUIDs, resetting
network connections, reseeding entropy, etc.

Moreover, the spec now describes a notification that the device can send
after updating the seq counter to a new even number.

I have already sent the Linux changes to the mailing list here:
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/lkml/20251127103159.19816-1-bchalios@amazon.es/T/#u">https://lore.kernel.org/lkml/20251127103159.19816-1-bchalios@amazon.es/T/#u</a>

[1] <a class="moz-txt-link-freetext" href="https://david.woodhou.se/VMClock.pdf">https://david.woodhou.se/VMClock.pdf</a>

Babis Chalios (4):
  acpi: fix acpi_send_gpe_event() to handle more events
  hw/acpi: add new fields in VMClock ABI
  hw/acpi: add VM generation counter field to VMClock
  hw/acpi: add ACPI notification to VMClock device

 hw/acpi/core.c                               |  8 +++++-
 hw/acpi/vmclock.c                            | 28 +++++++++++++++++++-
 include/hw/acpi/acpi_dev_interface.h         |  1 +
 include/standard-headers/linux/vmclock-abi.h | 20 ++++++++++++++
 4 files changed, 55 insertions(+), 2 deletions(-)

</pre>
    </blockquote>
    <br>
    Apologies for sending this twice, malformed git send-email command
    :(<br>
    <br>
    Cheers,<br>
    Babis
  </body>
  <lt-container></lt-container>
</html>

