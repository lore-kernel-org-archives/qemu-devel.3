Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E0B606A33B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=quante.one header.i=@quante.one header.a=rsa-sha256 header.s=cloudpit header.b=Rlg7fuO/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSzTU-0001NU-5O; Mon, 16 Nov 2026 11:22:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1xSzTR-0001HM-Gl; Mon, 16 Nov 2026 11:22:29 -0500
Received: from nx186.node02.secure-mailgate.com ([192.162.87.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1xSzTP-0000Fk-3H; Mon, 16 Nov 2026 11:22:29 -0500
Received: from web279.dogado.net ([31.47.255.59])
 by node02.secure-mailgate.com with esmtps (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <christian@quante.one>)
 id 1xSzTE-00CW9P-Fg; Mon, 16 Nov 2026 17:22:18 +0100
Received: from Zeuss.fritz.box (p57b2ffb6.dip0.t-ipconnect.de [87.178.255.182])
 (Authenticated sender: christian@quante.one)
 by web279.dogado.net (Postfix) with ESMTPSA id 271E3282943;
 Mon, 16 Nov 2026 17:22:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quante.one;
 s=cloudpit; t=1794846132;
 bh=if30rIP8+DWQolW7tyYCi65CxTJiAZzWI2CEnrgBX0w=;
 h=From:To:Cc:Subject:Date:From;
 b=Rlg7fuO/tjQyWt0DaE8F58AQHWHC6+8mpFhNJWQGbzey5p7MDi6k6ds4J9aAi89gi
 MHj2RLMGbA2pGaQ4jrEaZxY2fIopVYDqgbap1lcQgMcD1Ed1thSJlAzDSNNMOaZ+m5
 NDmpTZ9s2u/BEy6Axl96pZxuFvte4DhyjaXDa2dA=
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
From: Christian Quante <christian@quante.one>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, balaton@eik.bme.hu, mst@redhat.com, pbonzini@redhat.com,
 peterx@redhat.com, philmd@oss.qualcomm.com, kwolf@redhat.com,
 jsnow@redhat.com, hreitz@redhat.com, farosas@suse.de, lvivier@redhat.com,
 marcandre.lureau@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp,
 richard.henderson@linaro.org, mjt@tls.msk.ru, qemu-block@nongnu.org,
 qemu-stable@nongnu.org
Subject: Withdrawal of my pending patches (written with AI assistance)
Date: Mon, 16 Nov 2026 17:21:23 +0100
Message-ID: <20261116162123.8527-1-christian@quante.one>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <179484613211.652326.4506329505005404133@web279.dogado.net>
X-PPP-Vhost: quante.one
X-SecureMailgate-Domain: web279.dogado.net
X-SecureMailgate-Username: 31.47.255.59
Authentication-Results: secure-mailgate.com;
 auth=pass smtp.auth=31.47.255.59@web279.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: Combined (0.08)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuVde9jLxQVzhBUnku5ZK9/OQdH/g5Xk48G8
 fNEsIrVeZCu2SmbhJN1U9FKs8X3+Nt1HOctZ5X+40a9IXddeG3M38JQYgcgjsac3uQcQdCX4ROfH
 zJ6mVE7ewsipSVIfs4Z7R2GnCdeNxV4tA2HwQn97S5+h1uiHzk/Rfxfh461YLyu3RZI1CD15pCOE
 1vk99RO8CkBBeOWZWzhmlHwZjt9mdOtYechJ/ikE1WgRg4cS6A6B6pTstltS07kaQJ8I9sYal0h7
 43VOpKNY+4MjijihZK0EMmf3P50Ajf/tIX00Fuu2beRqilmjgQ6jA3UwYgnsj5xBssn0tIIHA3aH
 QzCq60l8YRpcxCjc2gcMa3Btw+OTpzU5Yy8oe2B0dJEHaEkqZOJGV2rGZzAbG8h1gtZeBYfLAJ36
 RwtyxBRSZ+49vRTbtL2xdv15aIRWgfI+e3bKAVGCsj3syyAgjkeElAqpympn9Qu9+qOAy3gbtVOj
 1va6YhK5+dp8kEJU4mkN7XR1uPsgRZuVzkMk1nNs1DI/AtrPIdrj+MU9VljMuQX+KaMAyJW22/qr
 FCGyTHEChKOME80+HzI05N/GY8fJ7Q+SXEnnu3wNVkc5It+/rMjHIKm3P59UJG1k9axRPrr6VJnu
 6mRJcBCvqTGSaTEp3sSCLm37s3WKeMIWIGsITuh6xVDqzA08iw5lNTCPqxu/Tf9tCBikOb/VIcWB
 1wD71iSmn+IeVr6hpcD4n6aukp6RdkmguQ+DxIA9kGOfHfjoPGbMXe9dIBGa2b5mCEmRBMBV70e4
 wgQsGYkBMhlI4dOUBZ7t2w55LqiFPyoZKyYUSDAPHXxjq2A09VZCtd9IE6xLQPqPSmgkf2rR+sR9
 StmGIR+UtjOvgqOFSF8G9GCEzF7MQ+bLY64w5gxDNqywnL645ZKq8uI66hekW7QsMPuD9lKWtlPB
 bNXQ4QgVcd39aIMn4gtHiA5BOPjHx3g7UbIr0j6m8Z3TbuDICLL8IEpevqQ1cv04nsK9aoUYSlnC
 RnsBCSf3kpMO36LqsCYmrUY4CzCvRwvqVEAQMkdN/mM3fGLIiJeUE/3oNsBizT8bwOjuTVHN5Oyb
 5a7ce8OKHV2D/nJmqQVjm9pQK+yEfs0QBCpsO/Pxd1YvdZuooMNn1nW9CPts942jgiBHZTGfQqst
 mvni4DsdvpDSN6CWTjglrSy5a/o4rJv5DhhaFkkWeY0OdXPtr0YLB5IKVhOGun7HSwsON1wh1xpD
 Se4KVeizO8dtVhKN+9/KNqonH3Ez1atO/mpOaiqLTT2I808XC7uuDEVFWbeJk0JpoH7+62XJNPhb
 3uEBdIZhTi/GRORCJZ6JOW16W/8nkd0N7tqGJSaCSm5Ip0FFcxC2w+rfWXmvhf9/PqHkE/eclnzJ
 pUyzKiE53/2pu39f8ayy4PmoIK7+Wz+M3Q4uqZcUXVuY0hSxXSzFZvplGiUheeLMuYRj18+fB8FQ
 QuOKz1mV99KWcDBjk9+YseVXoQXNnFEe+Nrzu9pPs2TEKE7lapcJLe9NquanPkET8/FK87za3FG6
 skt/DNhzVfdYAWUP9T27PHqOuCJBUwGYm28JMh2nFvlk1I+LiV5+7u4hYkLyVctr6X6bTKqEODrE
 hhDtdBZ0Y0hjgg==
X-Report-Abuse-To: spam@node04.secure-mailgate.com
X-Complaints-To: abuse@node01.secure-mailgate.com
Received-SPF: pass client-ip=192.162.87.186; envelope-from=christian@quante.one;
 helo=nx186.node02.secure-mailgate.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

I recently learned that QEMU does not accept contributions that include
AI-generated content (docs/devel/code-provenance.rst, in place since
June 2025).  I did not know this when I sent my patches.  The code,
the commit messages and my mails on this list were drafted with
Anthropic's Claude; I reviewed, corrected and tested them.

I apologize for this.  My aim was to make QEMU better at running old
operating systems and software, not to be disrespectful or to waste
your time.

I withdraw these pending submissions:

- hw/display/cirrus_vga: fix four BitBLT bugs seen with old guest
  drivers (5 patches)
  https://lore.kernel.org/qemu-devel/20261018050643.9288-1-christian@quante.one/
- hw/input/pckbd: raise the keyboard irq for 0xd2 also while disabled
  https://lore.kernel.org/qemu-devel/20261018051715.12267-1-christian@quante.one/
- system/memory: keep coalesced MMIO zones when RAM is mapped over them
  (v1 and v2)
  https://lore.kernel.org/qemu-devel/20261018051813.12379-1-christian@quante.one/
  https://lore.kernel.org/qemu-devel/20261027093223.129015-1-christian@quante.one/

Zoltan and Philippe, I am sorry that I cannot follow up on your
reviews of these patches.

The following patches were made the same way and are already merged,
some of them also in stable releases:

- hw/block/fdc: do not claim a diskette that is not there (2 patches,
  since 11.1.0)
  https://lore.kernel.org/qemu-devel/20260714164031.60551-1-christian@quante.one/
- hw/input/ps2: answer unknown mouse commands with a resend (2 patches;
  the first one also in the stable releases since 11.1.2, 11.0.5 and
  10.0.14)
  https://lore.kernel.org/qemu-devel/20260825075127.34876-1-christian@quante.one/
- tests/qtest/fdc-test: give each test case its own instance (3 patches)
  https://lore.kernel.org/qemu-devel/20260822104329.42121-1-christian@quante.one/
- hw/block/fdc: account for read and write requests
  https://lore.kernel.org/qemu-devel/20260824114216.231916-1-christian@quante.one/
- tests/qtest/fdc-test: check block accounting of non-DMA reads
  https://lore.kernel.org/qemu-devel/20261011081433.73397-1-christian@quante.one/
- ui/dbus: send a Scanout before the first Update of a new surface
  (2 patches)
  https://lore.kernel.org/qemu-devel/20261022134335.12241-1-christian@quante.one/

The same applies to my Tested-by for "target/i386: Update cc_op for
SAHF" and the issues #3959 and #3971.

Whether you keep or revert the merged patches is your decision; I will
not object to a revert.  Now that I know the policy, I will of course
respect it.

Regards,
Christian Quante

