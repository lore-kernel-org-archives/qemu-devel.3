Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B39A606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 10:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=np3YfsHk;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DgzC+R70
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRo3f-0007qc-Uf; Fri, 13 Nov 2026 04:59:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xRo3b-0007na-Ay
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:58:55 -0500
Received: from flow-a1-smtp.messagingengine.com ([103.168.172.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xRo3X-0004K0-O9
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:58:54 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailflow.phl.internal (Postfix) with ESMTP id 36EFC13821AF
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 04:58:48 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Fri, 13 Nov 2026 04:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm2; t=1794563928; x=
 1794571128; bh=gZuzuLiTx5spPGejanq/+utxCtsw5P0isrKRFIYxxUU=; b=n
 p3YfsHkESjPzNuop/nRsIWQl8lN2JFeqMN04NGnaaWj6vldlTM75pb1iQAJfxko5
 ZtFKBxFugbGS7fPr3UDt2An39kQrCx74BmoDk2ztcSmkk5GTwqsSMHZz1kpj6osH
 GXKdXVJb7JmSdbe+5WovHTl1Ybnywo11hE6J6G7KPeOP2kpATlw8DLnJxwPGm5Hz
 V5kbeL7/uZxBIvYtbYJlDXLokAxbOU9lA5UnJv7vfFA38vBGJE7YPRXlEAod3WJp
 SmErQXLL+B7nBCu6fY2LqY1G/PK60uXjZ1BZxlSAiYp045EjY9Pl4hU0C/3oIKf2
 dZVnn4oMI+ZYZMY3ggAoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1794563928; x=1794571128; bh=gZuzuLiTx5spPGejanq/+utxCtsw
 5P0isrKRFIYxxUU=; b=DgzC+R705NW+MbZoTKuvMsBCoKGltwXwFWnk9d8I9m+z
 eMRZAjWUXeSlBPnl3urWjMTInxAiMh/UpSCMifugbVGCDmpOMbhvxcvD4mPelHQ7
 097NN5/09Q+lnuXCi6V2Ghn+JuPB+kclCP/VfNp76AWbel6r7BLom8KDvZ3IZdY3
 gm13/E9uPn8lkHxEk6JmCh+XYDN9pR1buSZ2jvHUGwoVGJVZsGnflOaBYoUwddOC
 m+On2NO08cLjXq1Dci01gLcOf77OO/NOk/YDpQb2G1hX6FpB58hOgp0Uo7/Prk8h
 4YD7ujEiGi/rrRu/Cucb/WKX8S/yhPKV2L84YylOag==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794563928; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:Zcp9UmDNsztijPrpaDfkbg7x8vyOvXXIvZ7+4DcqS4H1uMN
 eXMFCDH5AOSuuiDnkraRYRvtwcoJISj+sFNEj03l2dykr3Bac0vKpypKPiZ6kFzS
 TGvFIx2wILyBmVGykzKiKA/LHc5u25rk/KVVlnQSPbovOhDTEkz/kRJGRGOfSeMe
 23s4uS0LSxYKl8FeDSYhpJrGd5AXjnE2+URoqrhz9by7bTuCLPYY5of8fIc+OJOV
 ZKnKUybYW6RPs4iJgWI94M89jc6L7dNuHrVMheYfTaV3volk/qwKBkfMR+UK6ZkO
 keEfzR+dqCHXq4vERdoLjKyiwgcWaqWIqMMwvBg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=10;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:4DqdBs5lzgJNO9YpaBmFxvDrq4J7JqUPIZEkngRd2IQ=:niKSj8GOu1HcxevbUFJaKpol16vKgPLtUgiLJo3t3Ns=;
X-ME-Sender: <xms:V9_2ahqpR-L9StZm5hukhs5XPKqAZlSH_9P4q4lq97k5rgf6I3ZDOA>
 <xme:V9_2aul6mLlKJfGR_QSkIP0CgKiTucMGaprBnM9A07yqSkgUnu3KbqjALyxAfqF-k
 s5Ub3gG-I1ze9BsaNr_kYK5s_LozTOMonMw6Rk2x_eX-6UCUSVyQzEz>
X-ME-Received: <xmr:V9_2atMhLm-FjpD4-19FU4WgiJD1bIyGawmOCFAHe-7pD5x3nx7OGIZV47iIMAkjAK_uypSCtr0WAA2DKH3znkPK>
X-ME-Proxy-Cause: dmFkZTGAvzAfPlJlLaDThKWpt+KS6bhWm2gRrSPgrTB/ovznjRpvfPjWMVN5Y+PW3Aqa/s
 baftg4Afrozja5tXkToPsNixGQntkwdHjN+wIS3lsrDjcnM9DGuKDZ5Yw6J3H/4ElpS/10
 W8zKIWZjfB3tMkSHaH+p3UP78wgEXmaeGkkereA34/kai8TtEQyE1NEFlhgqQ4cO7NFGZ1
 l6TsE8uRWypzoZjDymuocE5d0V0zca4dDcZdjFyA1Gb+JuiVLJDgh6tuVfVrhrOHR+4FFW
 A50WCeN3WFlOGLo/KqsqkPHYWyr16BEYoS5YyAW80DL78q4hCGsd+Gt1wlIIszmo9iIDcR
 5qBN7PdAL9r1QVHb1vnL3e836RWoe3qeKc+OZAdGKlDpAHuZCgh3SFxvxT95PCVlkbsZDS
 RPWLsnX7j3YnwB9DFDiZWTgyw4u0l6OWNRDzmQB6cuCBdAkcu+gAKbTL6HMnvHPRmRVCTI
 KusYqmmJP6RIeecog09+R/BYWM5gKQjgmKrL7zOBG76DcjESPAko3uZm5V9qLUBsI+UF2z
 NsG7XUDTMitzfAyIX7bZW1pQmJAZK21Idf+Xr9uAd9k+S7CAuzIdEykxFHnUZ4WnMzYzj6
 T2BOan85o5k1bWv4OuHfIEsvnXhzgLezeB0abNEHfX+Tygn5bNXuc9jPAhNw
X-ME-Proxy: <xmx:V9_2aiP9WfCd99D3qqcif7QyduK-EFd9JhgoVOJ0ft3D8bFIFD6fqA>
 <xmx:V9_2augVRtHP-fNK3CmAhhGayFhuh5naypo8v73G77aDKesYPKVU0w>
 <xmx:V9_2avsxFQN4ZOYS-7_eWlYpfK5eqZDp2LNVuBI5SAHeiWnfkIX7Zw>
 <xmx:V9_2akSeBmA-bSoBa18WKSn0Lm9wRIdH-b5XcThvClD748UY3ogpUg>
 <xmx:WN_2aht9GqN5WP8t14sNP2O1Cad-YuXT6NnG6at-61-04Y6Fezc92x_R>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 04:58:46 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Subject: [PATCH v2 0/3] hw/nvme: misc fixes
Date: Fri, 13 Nov 2026 10:58:37 +0100
Message-Id: <20261113-nvme-for-rc-v2-0-e458fd0e12ca@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE3f9moC/22NQQ6CMBBFr0Jm7RhahaAr72FYwHQKNaElHWg0h
 LsLuHX5kvffX0A4Oha4ZwtETk5c8BvoUwbUN75jdGZj0LkulVIafRoYbYgYCZtK2Zy0IXsl2BZ
 jZOveR+1Z/1jm9sU07Ynd6J1MIX6Ou6R27385KcyxvLUXLgyZgqqHNIPMvjtTGKBe1/UL0v/8w
 roAAAA=
X-Change-ID: 20261112-nvme-for-rc-a81f0c2dcf4c
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=880; i=k.jensen@samsung.com;
 h=from:subject:message-id; bh=niKSj8GOu1HcxevbUFJaKpol16vKgPLtUgiLJo3t3Ns=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR3IyMzFFNjBEQ00wOWI3RXd0Nlg0bFpVaGRPCitoY0E4LzFaRmpMM295WTBX
 am04UW9rQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKcTl0OVJ
 BQW9KRUUzaHJ6RnRUdzNwSlZRSC9qN0xPcHFjbGdoNG00RDFHSGlRYVhYL2RublFKTXVGVzJhTQ
 pWcEhYQ2lyWnZaSEdoQnlEb0crdkE1dmNGdWhNN0V1Nmt3U0V4OFpRNUUwWGFiUm1ZNVBQcFBKa
 mhrQ3B3R1FkClRTL2hpUlBNZ1BKOWExN3dmcUZQMEV1dlBoRXY2UW8wVjVPRU1MWXRYN1lUbDVi
 anlOcEZ2Vjgyc1BjZEZMdUIKTzdkYVp0aEhBQjA4eHU0Qms1eElBdDM2UCtIUjN6VWM4dmNUNk0
 0enRXRFUxaG1Jbkh5SHpFYUF6YU5UenB4YgpWRC9NZHZLYmNncWlYODVQVThEaVB5bXBKdWJFUz
 NPQVhNV3RaMDlKUkhtcTBpMkwxdXEwV1ZnQ1NSWDZqSGRNCmovVktQTm9wdE1PWkh1bWZLTTFnR
 G4wS1BXd1NldDBObEVXQkR2VlpLRGtvWE5XZnlGSnVXS2k5Cj1BK3VoCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=103.168.172.136; envelope-from=its@irrelevant.dk;
 helo=flow-a1-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fix some bugs in the backlog.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
Changes in v2:
- added Fixes trailes and stable on cc
- Link to v1: https://lore.kernel.org/qemu-devel/20261112-nvme-for-rc-v1-0-69b3e5dcd5c8@samsung.com

To: qemu-devel@nongnu.org
To: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
To: Jesper Devantier <foss@defmacro.it>
To: qemu-block@nongnu.org

---
Klaus Jensen (3):
      hw/nvme: reject fdp.runs smaller than the lba data size
      hw/nvme: fix fdp reclaim unit accounting
      hw/nvme: fix broadcast fdp events handling

 hw/nvme/ctrl.c | 5 ++++-
 hw/nvme/ns.c   | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)
---
base-commit: f794bd0f59a3e8829bc37ce59561c7bca68b663f
change-id: 20261112-nvme-for-rc-a81f0c2dcf4c

Best regards,
--  
Klaus Jensen <k.jensen@samsung.com>


