Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2173DCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 22:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4563-000542-DA; Wed, 01 Oct 2025 18:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan@islenet.com>) id 1v455z-00053e-0n
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 18:14:47 -0400
Received: from lin1.islenet.com ([45.33.68.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan@islenet.com>) id 1v455r-0001db-Nl
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 18:14:45 -0400
Received: from localhost (localhost [IPv6:::1])
 by lin1.islenet.com (Postfix) with ESMTP id 896C1F58EB
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 18:14:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=islenet.com; h=
 mime-version:user-agent:content-transfer-encoding:content-type
 :content-type:date:date:from:from:subject:subject:message-id
 :received:received; s=default; t=1759356869; x=1760220870; bh=Zx
 lS+d2ywAJyGzm839mP/c2wQPhT3a1RdHDCaK9EPnM=; b=SljIuHGImeixeAnSYm
 NpOj0dEMVvKwfJAkxUZWhpphuBGNSXlKZMKtP4bU1DI6ktW2IsMd32PtGrHtyIDE
 1tPrmYRFHSSn3UHJ3r4Eyx7TBJIirkFmKIUrKcDS+ppOi9e40AFvzivZgB5P+dqe
 bsAMSZAJOXuTInVEgZlrDMy+0YXa5OzUZT5sdSUL5pF2O4j6TQb3/t/7It8KGh9K
 Cd4/Xl/F+UQ0rJ93a9sEyHJBuKKs0ukoIDYPh0E/BA7vfgadEsrFeOGgOiTUQ7eu
 Gq3Em3MtBSmDrSaanzhK2pgXZ87ioaFeLJgIMTBCa37skfurtq8gli9lWoRdA1+z
 uM6g==
X-Virus-Scanned: amavis at islenet.com
Received: from lin1.islenet.com ([IPv6:::1])
 by localhost (lin1.islenet.com [IPv6:::1]) (amavis, port 10026) with LMTP
 id O8k8cz4TSCJc for <qemu-devel@nongnu.org>;
 Wed,  1 Oct 2025 18:14:29 -0400 (EDT)
Received: from venus.islenet.com (unknown [IPv6:2601:985:300:a441::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lin1.islenet.com (Postfix) with ESMTPSA id 47507F5889
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 18:14:29 -0400 (EDT)
Message-ID: <ebb4d277d49d53e55d9c0d56375df29981631c3e.camel@islenet.com>
Subject: DOS 6.22 with LIM 4.0 Expanded Memory
From: "Daniel L. Srebnick" <dan@islenet.com>
To: qemu-devel@nongnu.org
Date: Wed, 01 Oct 2025 18:14:28 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
Received-SPF: pass client-ip=45.33.68.68; envelope-from=dan@islenet.com;
 helo=lin1.islenet.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

I have a need to run an old MSDOS 6.22 image with an application that
makes use of EMS 4.0.

After some extensive testing, it seems that DOS' EMM386 driver cannot
find a 64k page frame that it can use.  I can manually designate the
block beginning at D800 as a page frame but then shortly after start
the system hangs.

I have a test program that is used to determine if the system is seeing
the EMS as expected and this fails.

If anyone is interested in taking a look at this I'll provide the XML
for the VM, a config.sys as well as the EMSTEST program which can be
used to validate a proper environment.

If this is not the right place to raise this issue please point me in
the proper direction.

Many thanks,

Dan Srebnick

