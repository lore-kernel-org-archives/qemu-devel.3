Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650C3C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 12:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzxKI-0002HZ-OE; Wed, 02 Apr 2025 08:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierre-samuel.le-stang@ovhcloud.com>)
 id 1tzxKG-0002HQ-KI
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 08:36:12 -0400
Received: from 1.mo301.mail-out.ovh.net ([137.74.110.64])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierre-samuel.le-stang@ovhcloud.com>)
 id 1tzxKB-0004CB-T1
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 08:36:12 -0400
Received: from DAGFR10EX2.OVH.local (gw.corp.ovh.com [51.255.55.251])
 by mo301.mail-out.ovh.net (Postfix) with ESMTPS id 4ZSPVX1rLjzht
 for <qemu-devel@nongnu.org>; Wed,  2 Apr 2025 12:36:04 +0000 (UTC)
Received: from localhost (109.190.254.5) by DAGFR10EX2.OVH.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1748.10; Wed, 2 Apr
 2025 14:36:03 +0200
Date: Wed, 2 Apr 2025 14:36:01 +0200
From: Pierre-Samuel LE STANG <pierre-samuel.le-stang@ovhcloud.com>
To: <qemu-devel@nongnu.org>
Subject: smbios entry point auto on pc-i440fx
Message-ID: <20250402123601.4nfw6bxk6apphpvw@corp.ovh.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: NeoMutt/20180716-1616-ec38bf
X-Originating-IP: [109.190.254.5]
X-ClientProxiedBy: CAS2.OVH.local (172.16.1.2) To DAGFR10EX2.OVH.local
 (172.16.2.31)
X-OVH-CORPLIMIT-SKIP: true
X-Ovh-Tracer-Id: 3401343622468820351
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehieelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvuffkrhggtggufghisehttdertddtredvnecuhfhrohhmpefrihgvrhhrvgdqufgrmhhuvghlucfngfcuuffvtefpifcuoehpihgvrhhrvgdqshgrmhhuvghlrdhlvgdqshhtrghnghesohhvhhgtlhhouhgurdgtohhmqeenucggtffrrghtthgvrhhnpedvleduffeuudefieduieejgfetleegjeetjefffeekleehfeeiueevfeffvdehgfenucffohhmrghinhepghhithhlrggsrdgtohhmnecukfhppeduvdejrddtrddtrddupddutdelrdduledtrddvheegrdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehpihgvrhhrvgdqshgrmhhuvghlrdhlvgdqshhtrghnghesohhvhhgtlhhouhgurdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdpoffvtefjohhsthepmhhofedtudgmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=oPX2LSP567RpHdeYcJoJZhuMhWaXbmelSoacGsTbUUs=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1743597364; v=1; 
 b=p5h6JWqnzoSJW7OU6ycIn3MLhl3TWpXvttZt2JJTUi8kqqL2CfSDvPH+kgWcTALVYMLIfwxI
 Zd+y3N5vFV31ODR8ymjVgSlFqXp15PEwgtbw27uRWcrseMMktmC+wE1IpOzb96sjZq6IkAqfzVp
 8Wj+3LcfyzvvK6m/xlnRH2wo=
Received-SPF: pass client-ip=137.74.110.64;
 envelope-from=pierre-samuel.le-stang@ovhcloud.com;
 helo=1.mo301.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Pierre-Samuel LE STANG <pierre-samuel.le-stang@ovhcloud.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello team, 

I'm facing the issue of windows instances not beeing able of retrieving
the uuid because of smbios 3.0 (qemu 8.2 on debian openstack/libvirt).
The instances are of pc-i440fx-8.2 machine type.

If I understand well since 8.1 qemu use a 64bit format for the smbios
v3 which is not handle by windows OS.

I also found some commit about handling automatically the format by qemu
on q35 machine type to resolve this bug startting to 9.0.0 version
https://gitlab.com/qemu-project/qemu/-/issues/2008 

It seems forced to 64 bit on pc-i440fx-8.1 and above while forced to 32
under.

Is there a reason to not handle it automatically on pc-i440fx machine
type?

Is it safe to keep it to 32 for machine type pc-i440fx-8.1 and above?

Cheers!

-- 
PS Le Stang

