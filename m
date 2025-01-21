Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36034C0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 13:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taEln-00045L-0G; Tue, 21 Jan 2025 08:58:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>) id 1taEll-000456-Vb
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 08:58:17 -0500
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>) id 1taElj-0007Oi-UP
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 08:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=N2H1/CEjYoPvf7ecB/MdIdbvoOxXgD54Fas+gcdO22U=; b=ffjRUcC+GsARW6STKNcWgV5cXV
 xT/XrCBroPBTN2p1sjtOAPzn9Hs37tr5WNVc8To97RDJTnnTpiqL+rRBqyeuVDQInTNTtP+y+QW91
 nj0KoEBCIzYoTKvzhWt15CUehCiNUwWaYFjQSg9tgL9tJ7fmlOa2S7m+QDgiEk1FDzJkaxCbxJhll
 yVfVQwuFiUEnevMy+G+of8AWIr6hECGxZwxbaCwmckQtCIQPPMQ9eI7eOLf8gZD7Gs4XbmUAAPhVU
 LgknLk0QoM+ZFJNtHPQFiosghuVSHiOzCJaYJLIh27gFl4jEtBm+JgnLb6DDY8PFNipcnj0wlQUmo
 MpLCfXhg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1taElW-0007HC-Ce; Tue, 21 Jan 2025 14:58:02 +0100
Received: from gate.service.igalia.com ([192.168.21.52])
 by mail.igalia.com with esmtp (Exim)
 id 1taElU-000K4o-7a; Tue, 21 Jan 2025 14:58:02 +0100
Received: from berto by gate.service.igalia.com with local (Exim 4.96)
 (envelope-from <berto@igalia.com>) id 1taElU-0003BN-0E;
 Tue, 21 Jan 2025 13:58:00 +0000
From: Alberto Garcia <berto@igalia.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang?=
 =?utf-8?Q?=C3=A9?= <berrange@redhat.com>
Subject: Re: hw/ipack: Is IndustryPack still useful to maintain?
In-Reply-To: <3709ba37-fa92-467a-ba3c-85355762e0e9@linaro.org>
References: <3709ba37-fa92-467a-ba3c-85355762e0e9@linaro.org>
Date: Tue, 21 Jan 2025 14:57:59 +0100
Message-ID: <w51zfjkfevs.fsf@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine2.igalia.com
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

On Mon 20 Jan 2025 09:53:32 PM +01, Philippe Mathieu-Daud=C3=A9 wrote:
> Is it still worthwhile maintaining this code? If so, can we have real
> world tests? I'm updating legacy APIs and these files use some; and I
> wonder how many community effort it is worth to invest here.

From my side I think we can remove the IPack code (that would include
the IP-Octal 232 emulation).

Berto

