Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A25606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=Z35uvR55;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jwHjMViq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRRVb-0007a4-S4; Thu, 12 Nov 2026 04:54:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xRRV6-0006qm-Do
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 04:53:52 -0500
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xRRV3-0003V7-AP
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 04:53:48 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id CD96D1D00147
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 04:53:40 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 12 Nov 2026 04:53:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm2; t=1794477220; x=
 1794563620; bh=W8mrgYLDR6pXJZga5VxP9nWR6fSvvyIO9wWcaDI2Nbk=; b=Z
 35uvR55bbeqgJKnUPbg1wenlZro9b/4tBQN0s3F/Ejnh+A4e53NpLW71C3D13hUj
 1OdIhxNpa58kSQESo61csJZT+zpo7bkBN9dEMFvRRh6otnUiGq/M7cWLhDnVO/jS
 1Oyd/Vfna9h9+5ll9gsL749wOwLtDq6C+0dVRkUR8jFLnEZCVOlR+p2kP/fJHvSY
 Y4G5DNOn7Ws0dx2PMeC1bEhwPFjr0ayz5kons3UPGzImnsRffqNJf/RqkyEdI/EY
 EZFnx13TcQjbNWBSiKV9+3u0k531lGRr6ywqX7Xkexv7K2iPJkTkDt900b/UAnTt
 PE/IbNRZBn7vn3gdqMjJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1794477220; x=1794563620; bh=W8mrgYLDR6pXJZga5VxP9nWR6fSv
 vyIO9wWcaDI2Nbk=; b=jwHjMViq7RlOGc3qhri/Rcu17xHtVno2OAuvLqh27BDd
 g8vdWMfQIpRnD2Bq265WbcxvtvvV1gso4vIwkb28hL78DaN3PeE7pCXaHlFJrh2A
 xmNpcFdiOqXhiSxiM6JdcN3hBDfGsb+K8ACZTHdVHiD2ghFx2mUhhWMcvFXz8lJt
 OaqHJZOTJq4J+A3XFmNhbXTuutMlGHDn87nY1sOEEpVl4dRXdn9ZYk1HZgIfHCre
 jppSwaMBgVFGg+LHl9qO34oT1OwccOCSIH1kNjX2LVTTbMiMFwhn4Z42r6dg4xWx
 uZB+9YqvUBUxUsbxwPG39QmNDEyNqPxaI1B/NuTrbw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794477220; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:k00KSW9m+AzqOXrBcN0E+XbwmaTZIxlV0fcLGoszIJ+AlKq
 ClIOq+naqUyqYHoMRBXUr9eV3s76qdclvyArRONZbLtyl8T0jMjfwOT1ZStKqX8U
 GQSrxoKhakE+WjlyG74fU1/qmmXXuH7YqPdcx7TYL7Un8AqzKxCBPS9Ivnnim41/
 c4K34TRjB35Dx38p7I73PW4XIQ3vAIExKcWuDdu4iR9fcRObjtd+gejnyetP89Sg
 xwdFzuBgeil/A9EwYB78VZ3dhVcszDOjM+jp33LlyEixMXhZlNDyETSHJjHIBrGv
 EHCpZV9OPz2jS0zaNdHtHfECIj3arfl6AQ3Hv1Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=10;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:If781qxUvfefYcm9SVb2vPYQnJkO6xYPoTfcamSNRTs=:wBg/AWbLSHSHkVGwuJ3qYfY4aQTgqRMlLX8SEqEaP58=;
X-ME-Sender: <xms:o4z1aloiDuSQK3ZlBS8JhJBFr_QSXW2tkWgLl-_VTYxXiZb3cacWLA>
 <xme:o4z1alnEEtqjbs3GBGfO6lCz740Fooj8XxKqccLIPhewXcy8vVuDEeGoo6Zy68MEx
 e53gdbdnzRUhwiLBwhv2WWvp9Hi-TOZbvyIPVQjEUCUAAWHg40gIzKR>
X-ME-Received: <xmr:o4z1akjR4t3DK96GdLPfHa_gjMaCBL5rlTCcPXLxOgIQM5MMycd83iWwQNs_u0iTAt2Mc_txrpzVfl5TNdX_oIs>
X-ME-Proxy-Cause: dmFkZTGxwChAa0m5BhaxQeYwQNDHddL9bk+/ZnATeH2tt+SCS4B77UHwSX8EAdS+GZ2Y61
 NB5HiVNciGj1BAV0zMn8LvucV06hPZ2W/OPy96BgbA5yHz1dKnGH4U7gConj9AkHKiutZG
 vZ/vqC+jbc30UHrVtU+tFWHL09PbwkFhKWWaTb+YCDLefhnqHtXbDtbvk/rxMc22dpNJdP
 4Sx7IaOavEy8a38m0t+DxrUHEJ2QRbCsN3oAxml7wNHtakjjZm/b8GVTG2A9ckVmxvWwha
 C0+f1hMDDEvR+scmlKYjgESOgztgnRiLViHoKCIcLQjdTxyPC1emPqcfzIEPDw9bzLqmaj
 +NWyYaJYcOAhI4gOfU0ZDc1EShT4VFYkVVaUGzpSWpYqYHjGcPFZyzZKBwaw21np8mDOqH
 HeMnRZHU2+qbjDZk/um3xLP1+dym4rHZYIqjyDNsfutBsjr0/lYMsd28DHtpnYu4KvbRWl
 S/KoJ9et2hCFBjh0ehyu6Rw8PzBoVmfhrpdR96CmgB8KWXGf6mZjLWJMBZNNzasFnkZeCQ
 v+XJUfVLTnQ2ZflrgG4JMwVSMkrpzdhRAqWxOsIqZfN6z7dmut42HhZ3tCuubUwakzA4fe
 7u4YQ91W5kHaS6woPWk84Ff8/1/KJF1nO3ognkKjDPHTJ/CFnNmljJyDK5VQ
X-ME-Proxy: <xmx:o4z1alcmvehiCmjlSh0Mjk9TE63kgkmNqziisbg6vd5g5hOXabWaCw>
 <xmx:o4z1asjsHLdAnFkcvKn4i2GYGIVdky-v2gTcK5q3Yd6N8mPkQRUaQQ>
 <xmx:o4z1alxQ4hLmG9KE-7vCG_yUUA6kpbAoweJCkf0EPlfCh7Lc1CTHzQ>
 <xmx:o4z1agP-jsoOWWT1JIdVQqP3Qy0syoocmcBDy7kQfei5b_9tNUZsng>
 <xmx:pIz1ag4zSZPWv-fVYJrKyGWnh0ELaZGJlFV6drGPP4TOPgYeVy2N1dit>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 04:53:38 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Subject: [PATCH 0/3] hw/nvme: misc fixes
Date: Thu, 12 Nov 2026 10:53:27 +0100
Message-Id: <20261112-nvme-for-rc-v1-0-69b3e5dcd5c8@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJeM9WoC/yXMQQoCMQxA0asMWRtoigziVcTFmKYzEWwl1SKU3
 t06Lt/i/wZFTKXAeWpgUrVoTgN0mIC3Ja2CGobBOz8TkcdUH4IxGxrjcqLo2AeOR4ZRPE2ifvb
 b5fp3ed/uwq/fAnr/AgKrlelvAAAA
X-Change-ID: 20261112-nvme-for-rc-a81f0c2dcf4c
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=544; i=k.jensen@samsung.com;
 h=from:subject:message-id; bh=wBg/AWbLSHSHkVGwuJ3qYfY4aQTgqRMlLX8SEqEaP58=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR3IxaktIWDRHdlB2YnhkcVEzNG1teGpUaTNwCjdDU245RFlwQU9pM1prcDU2
 K2kxQ1lrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKcTlZeWh
 BQW9KRUUzaHJ6RnRUdzNwUVlvSC8wdWVvU20yVzZTSlI0MzBTSkpGcHlnb3d4T0JwMDhHcFpLUg
 pURzNPbUI4VGRNUDVsQjl0L0JYdDdGeEpNck5kaWZzN2d6aDdoV25VN0tlY0pMZUxQYWJxSVQ4O
 ExVZjhMWXZVCk1OMEtGL1VZbGRMSkhoUkxVT3c0emNsbjJhWHBCOC9aMUVEVXpQeE4zU1dzaXBv
 elg2TmtwOVZIRE13ekxNUVIKU3hmMlNiTXZ0ZlVDajlGU2hvVWxZZEZ6dVc2U0xFK0JyWGVQb29
 VWXJXWGVvalVhVHgzTDBDSDZkdW5GRWhLeQpuMkptR09OcURZZ2ZLMkpUT3JuYUU3T2trVW4wVF
 lkbWNnSzJ2SHVxZmlhY2RoZEI1ZWxPM3p1RFFDMDM2SmYxCjhQdHdmMHRacnNBN1NKMUhQRHEyc
 2FUaThBTTA2dUdzTG5HOElER3JBQVhVWkM5Qyt6dVQwS3JBCj1FQm95Ci0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=202.12.124.147; envelope-from=its@irrelevant.dk;
 helo=fout-b4-smtp.messagingengine.com
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
Klaus Jensen (3):
      hw/nvme: reject fdp.runs smaller than the lba data size
      hw/nvme: fix fdp reclaim unit accounting
      hw/nvme: fix broadcast fdp events handling

 hw/nvme/ctrl.c | 5 ++++-
 hw/nvme/ns.c   | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)
---
base-commit: 2a2590a7efb01f1f11ab34d180273f02b94e9427
change-id: 20261112-nvme-for-rc-a81f0c2dcf4c

Best regards,
--  
Klaus Jensen <k.jensen@samsung.com>


