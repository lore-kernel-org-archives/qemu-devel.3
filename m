Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9756CCA470
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 05:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5dYW-00030e-9j; Mon, 06 Oct 2025 01:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1v5dYR-000307-9H; Mon, 06 Oct 2025 01:14:35 -0400
Received: from dedi548.your-server.de ([85.10.215.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1v5dYP-00030f-7J; Mon, 06 Oct 2025 01:14:35 -0400
Received: from sslproxy04.your-server.de ([78.46.152.42])
 by dedi548.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1v5dYI-0004HK-08; Mon, 06 Oct 2025 07:14:26 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy04.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1v5dYH-0003GN-0t; Mon, 06 Oct 2025 07:14:25 +0200
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 1B84B480070;
 Mon,  6 Oct 2025 07:14:25 +0200 (CEST)
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 1Ze5Pb0sXXbc; Mon,  6 Oct 2025 07:14:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id A57F248015B;
 Mon,  6 Oct 2025 07:14:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.embedded-brains.de A57F248015B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=embedded-brains.de;
 s=34EE5404-8E36-11F0-B577-2ECCAB4968F5; t=1759727664;
 bh=oO3MxNzGpSD1jswt80AueKKgDMQYKm93FKjyAjP8wuA=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=F0h1JuYXwmCymUHB7X6pnqHwQ1pbf789bKVv2kuOtSfBXgC8ue86A0llL/cv+huIj
 Rppr0yX6iLCslaPjz8/fwWbyMcIdKd5uLC3l+q17IHfQDq5um6LV4BbzBiHKgMBwwQ
 9NGTeUw3EAXGyySFRAZQwd03b1jE11iQTLNAavTn2EqAWl42Rohc+EPQAJGxUQcBKD
 Kn3R4rSeJGyNPFAki4E/bU2HtBYmMEWwE492Z1wamHs+7iVpbyvC1AsoG4sqe7Dgk0
 tZ/+c6io6LsaCWrbuDH8Tag+l2OBV7gdIMSbR7DVgvgASfKM/RBO9vA2JqGePGjgKT
 n2/drqjIuAopw==
X-Virus-Scanned: amavis at zimbra.eb.localhost
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 1OSCSeALYXlf; Mon,  6 Oct 2025 07:14:24 +0200 (CEST)
Received: from zimbra.eb.localhost (zimbra.eb.localhost [192.168.96.204])
 by mail.embedded-brains.de (Postfix) with ESMTP id 70530480070;
 Mon,  6 Oct 2025 07:14:24 +0200 (CEST)
Date: Mon, 6 Oct 2025 07:14:23 +0200 (CEST)
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-riscv <qemu-riscv@nongnu.org>, 
 Alistair Francis <alistair23@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <788527663.312.1759727663914.JavaMail.zimbra@embedded-brains.de>
In-Reply-To: <38528707-3d28-4be8-8b58-60269cb1db1b@roeck-us.net>
References: <20250319061342.26435-1-sebastian.huber@embedded-brains.de>
 <20250319061342.26435-4-sebastian.huber@embedded-brains.de>
 <38528707-3d28-4be8-8b58-60269cb1db1b@roeck-us.net>
Subject: Re: [PATCH v3 3/6] hw/riscv: Make FDT optional for MPFS
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.168.96.204]
X-Mailer: Zimbra 10.1.10_GA_4785 (ZimbraWebClient - FF140
 (Linux)/10.1.10_GA_4785)
Thread-Topic: hw/riscv: Make FDT optional for MPFS
Thread-Index: 2YHcR+4M4s5iHHMa1HiiT5HMtKsMIw==
X-DKIM-Status: pass [(embedded-brains.de) - 78.46.152.42]
X-Virus-Scanned: Clear (ClamAV 1.0.9/27780/Thu Oct  2 04:58:32 2025)
Received-SPF: pass client-ip=85.10.215.148;
 envelope-from=sebastian.huber@embedded-brains.de; helo=dedi548.your-server.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hello Guenter,

thanks for the report. Do you have a Linux image and a Qemu command line so=
 that I can test this?

--=20
embedded brains GmbH & Co. KG
Herr Sebastian HUBER
Dornierstr. 4
82178 Puchheim
Germany
email: sebastian.huber@embedded-brains.de
phone: +49-89-18 94 741 - 16
fax:   +49-89-18 94 741 - 08

Registergericht: Amtsgericht M=C3=BCnchen
Registernummer: HRB 157899
Vertretungsberechtigte Gesch=C3=A4ftsf=C3=BChrer: Peter Rasmussen, Thomas D=
=C3=B6rfler
Unsere Datenschutzerkl=C3=A4rung finden Sie hier:
https://embedded-brains.de/datenschutzerklaerung/

