Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37AE8CA1013
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 11:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuUD1-0006Si-Qb; Fri, 05 Sep 2025 07:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philipp.schock@tu-ilmenau.de>)
 id 1uuUCu-0006RM-4r
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 07:02:20 -0400
Received: from mail-router1.rz.tu-ilmenau.de ([141.24.179.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philipp.schock@tu-ilmenau.de>)
 id 1uuUCa-0004yQ-5I
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 07:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1757070098;
 h=mime-version : date : from : to : subject : message-id :
 content-type : from; bh=cVonwVo4aoapS1wGxVRhntouVw8eNKdslJIdSLRlfK0=;
 b=BrUVSierffVv2PmaJ7PCi0BZa/CYimSDPIe8zSUEcEUfFWbmDzg3OzwY1FamuFeaEszr4
 HGs2bMKzqreNGrrI9DoFfBvoI20iypRbloEJnx6okL0ae4adb8xbJlYMKffgBGTxm/szn9f
 4oQ+5+Kalx1+cnQiREKiCxo7TAbk8w1NTCi6mCLACvkvu3hhETXc0HAXClnSJ1T+tuNWutY
 KtVj6i256ZPgCN7xyaLDm7VrKlPmtlOStXNqW3UXpGz7VJ8+i4BsKlYNEmSc7Zd1AXynnzy
 OuB6tzobxBdhwZkdHGvZllgtc47kZDKF8ZMsSu6bRH5VU3D//ERu7BexYH8A==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de
 [141.24.179.32])
 by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id C40D95FDAB
 for <qemu-devel@nongnu.org>; Fri,  5 Sep 2025 13:01:38 +0200 (CEST)
Received: from webmail.tu-ilmenau.de (unknown [141.24.179.39])
 by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id B2BF25FC47
 for <qemu-devel@nongnu.org>; Fri,  5 Sep 2025 13:01:38 +0200 (CEST)
MIME-Version: 1.0
Date: Fri, 05 Sep 2025 13:01:38 +0200
From: Philipp Schock <philipp.schock@tu-ilmenau.de>
To: qemu-devel@nongnu.org
Subject: NVMe/TCP block driver multi-queuing
Message-ID: <17974825f5b1b600ccf9d5eaacb46dc5@tu-ilmenau.de>
X-Sender: philipp.schock@tu-ilmenau.de
Content-Type: multipart/alternative;
 boundary="=_a20bddfa1befbeef209543f14f278982"
Received-SPF: pass client-ip=141.24.179.34;
 envelope-from=philipp.schock@tu-ilmenau.de; helo=mail-router1.rz.tu-ilmenau.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--=_a20bddfa1befbeef209543f14f278982
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII;
 format=flowed

Hi all,

I'm currently working on an NVMe/TCP driver for the QEMU block layer. 
I'm mostly done with basic functionality and now working on the 
performance side of things. There is a lot of optimization to be done 
with regards to performance with a single NVMe i/o queue pair, but I 
want to work on introducing more queue pairs first.

Since the multi-threading capabilities of QEMU have expanded since the 
NVMe/PCI driver was implemented a few years ago, I would like to make as 
much use of them as I can. The ideal would be to have a dedicated NVMe 
i/o queue pair for every thread executing i/o, which are in turn pinned 
to host cores, inspired by SPDK's NMVe driver. Or, at least, have 
something like this be user-configurable like with virtio-blk. Is that 
even possible? If yes, could you point me to some documentation or 
example code on how to achieve this?

If you want to try the block driver, the code is at
     https://github.com/phschck/qemu
and you can use it by adding one of
     -drive driver=nvme-tcp,ip=x.x.x.x,port=x,subsysnqn=nqn.xxx...
     -drive file=nvme-tcp://x.x.x.x:x/nqn.xxx...
to your invocation. Though it might not work on every setup yet (I 
tested it on x86_64 and with SPDK's nvmf target) and booting from it 
will take a while if you have any sort of latency beyond what you'd get 
on a loopback interface (because requests are blocking and sequential 
for the moment).

/phschck
--=_a20bddfa1befbeef209543f14f278982
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3DUTF-8" /></head><body style=3D'font-size: 10pt; font-family: Verdana,Gen=
eva,sans-serif'>
<p>Hi all,</p>
<p>I'm currently working on an NVMe/TCP driver for the QEMU block layer. I'=
m mostly done with basic functionality and now working on the performance s=
ide of things. There is a lot of optimization to be done with regards to pe=
rformance with a single NVMe i/o queue pair, but I want to work on introduc=
ing more queue pairs first.</p>
<p>Since the multi-threading capabilities of QEMU have expanded since the N=
VMe/PCI driver was implemented a few years ago, I would like to make as muc=
h use of them as I can. The ideal would be to have a dedicated NVMe i/o que=
ue pair for every thread executing i/o, which are in turn pinned to host co=
res, inspired by SPDK's NMVe driver. Or, at least, have something like this=
 be user-configurable like with virtio-blk. Is that even possible? If yes, =
could you point me to some documentation or example code on how to achieve =
this?</p>
<p>If you want to try the block driver, the code is at<br />&nbsp; &nbsp; h=
ttps://github.com/phschck/qemu<br />and you can use it by adding one of<br =
/>&nbsp; &nbsp; -drive driver=3Dnvme-tcp,ip=3Dx.x.x.x,port=3Dx,subsysnqn=3D=
nqn.xxx...<br />&nbsp; &nbsp; -drive file=3Dnvme-tcp://x.x.x.x:x/nqn.xxx...=
<br />to your invocation. Though it might not work on every setup yet (I te=
sted it on x86_64 and with SPDK's nvmf target) and booting from it will tak=
e a while if you have any sort of latency beyond what you'd get on a loopba=
ck interface (because requests are blocking and sequential for the moment).=
</p>
<p>/phschck</p>

</body></html>

--=_a20bddfa1befbeef209543f14f278982--

