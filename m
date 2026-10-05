Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47F1CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 12:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDhML-0001uM-Gd; Mon, 05 Oct 2026 07:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xDhKl-0001Ty-FN
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 07:58:20 -0400
Received: from fhigh-b4-smtp.messagingengine.com ([202.12.124.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xDhKj-0002xU-JG
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 07:58:19 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 2DD4A7A0110
 for <qemu-devel@nongnu.org>; Mon,  5 Oct 2026 07:58:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Mon, 05 Oct 2026 07:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1791201495; x=
 1791287895; bh=gcQDFBrUxXdcMdoFL3RqEOPgTt7Zxm2UzsLq3RHz1NE=; b=u
 UuBDIRLqqhLWhhtCR+2PDIPI1P8VBrt84CCiLiBgDJPm+/GtacynJ+3T+K0xVfvY
 y46d9Xe0NcI9KHuVBtHKo+1kW8DEoigWuAoqiv5Pchn/BlUEt6+FZqK5yLRMD6rU
 hMJgQFwmCvpOn7+Z/fmwwFx40NEiB1m1W+F+/XHhI/1XN857EsMHazH2enGcLwB8
 sE3UXZdd1jQec+YtoW3+Y4HFljLFWjpy5OGgnI4JWnEuFOn9wONLOuiC4qTF19dc
 dL9KM7zUfBETZfZT/OxK8JCw47ug+/vVvjzBh64ODiZ0JW1W2VXx1B2kuoGRUu7K
 6tcMXBgGMf2f4vTR7af2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1791201495; x=1791287895; bh=g
 cQDFBrUxXdcMdoFL3RqEOPgTt7Zxm2UzsLq3RHz1NE=; b=lq6mc65gKXbya0agc
 C59asiV7rtUu/sVjtfOvGE77bXT190kLgnNQlFQ47VBwodhuCHsaMrwk9988LaY6
 WFeg2bYCZsAfeW9szJyamypzTR4m15kdtPFwk971REYuI6tVguBomxGRU95g9pQM
 /3sgdp/OCrCVqH6HdWYKxsiFHKuKGdKUjVc72j70HFguy4VNqI+1a1tLw6IYN0d7
 18A0eCXK+vVvTAznBTZgYw2L7Crmc4FnBepJH6sImkw6IwZvKofo92BdTH9+ed9T
 Ws899S3JdHbvKtpd3RBSVdfLYTZ9II78D6mnuJjz8+WuCjVeDmXA8ULbWNbmcp6i
 38YJw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791201495; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm1:rsa-sha256:zaE90iUzTzd/3KIkFFYCDDB+VAquy4yxol35GDX3/Ty2vcC
 YbQF+0QxxAgFEj3Rb5AraaWChRMwzEK7hoHQ9DULU7zZmEugu+q5Rmre1ExqyBP2
 eTLUfCq7o9uQ4x6UbwwMQniwT62XWaqQlmB7bLeoDxOWinH8L9g8m+/9V/0o3s/T
 FdBseqxvl3rcua1FSWfENNFWlMV+yCwJ46paSJeDhuLXOyy3S1NUciZ8pCS63ivQ
 BQC2mHWjTgO9I9+M5cC4i8/plGoOya1mbDkpnwip/TaGwr5C5aI1oKZ18CjksH26
 e1DpKYW+v/+tKnatzMci4OXhsYPXlhak697VE3g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:oezOKFzocMcb0fk+VI1ICsL5gnFC8AFm9en7G3Y/sZ8=:O/qVepAX+WvP1ayg3uizjTgpdLnlTkWsxL1mJBFytio=;
X-ME-Sender: <xms:1pDDaquaL6hhqqyQudUEDRYeFGWyE14CJf-e_We4Fyu9yhPDpoN1sA>
 <xme:1pDDanHYuLS449pru6B6RwlIqCfQjQ9RPTBI8fd-I7-9TjevGYlAf4KUk4sru-V4m
 jNULJrhDhCrTJg3_jNA-zbn85vMb73yZcJY8-grlxEeP9A1Dz9TQtk>
X-ME-Received: <xmr:1pDDajapvhlSyWISabTHs1aZrm7JesyjXWz1uuzPNBOkPwbqtA4Eeb4h_BGxlDA07fPmoRJz099HOMkM68bh3fAO>
X-ME-Proxy-Cause: dmFkZTGBqm9Tnuc8Q7oXt0qG4S37jB3ca+dwPggMm/4DbSi+r/PKAIimqWh4i3gxlSXgTA
 omDfi+D5JYgrvVsGPzwjCPVi9Z+xofK2t7xsWdfjUaIGAO+zs3+PFHQ+ngadEQPigikWax
 znhW7Dewf5D0XKW6dVlozMw1Sh5k7T4r2jO8ZgHqq3MErCU5RkI7xjfxtL5varo4Lwl2TK
 L84rAr7ZF0BOSrngZUsBoMXTyobCldT9LtJyyAVrm0GIB2r3B4HIme/LUCuPwBiYfuFrv6
 x0LYJjsbgEXspRRlTQxY6cI5GG4ZcNOGlUwJiefG1Ngbn72lYa+4C380guNER+d5YP6DQ6
 XXdmSmqrMmUupXrk+X8HRzI5xVItGPZrj/F2LPrqhUUNFKeOZPBSYVV2T1sLnNmAisvxsR
 lOeo9OVeTNxAeLtfsSP/TlqCYPRTrYqiZGowBntOyqa6GGct8OGTlwccrNea40TBc+33Mm
 9MnaDWvg45zRg5+n/KBB/7dNN5Tw98nqJaEDahHIBOTVzmlxAAh5xtnoPATbEL39QSvB3r
 F+7BJN5A89kY+ktgzAPDPi2wO/Ssr69k65jiDhyIYx+EZUoi9nbsjVODvSUG7xatwHhjfJ
 K06k6NtGPv+WmRFxi5zvBbbzdvrSPoA2an17oKfq0FiqpPVvxEyCGI3vK+7A
X-ME-Proxy: <xmx:1pDDavVNiadXFq5BOOZf_u6V_itTqT39xIuN7nvYa1xtXGzq0ota-w>
 <xmx:1pDDahltRXpb9zCPxvSlvArev_xEg6L8LhJwdkkA5YwJBop_eUYK8w>
 <xmx:1pDDaiB43tj5R3yhrQC27QKWawaYv28KC9Lttvp8J5rCbgHJteYk7Q>
 <xmx:1pDDaojj3ZSbquhKsoqenlRmfXbRNFqrw1bSY_s4aN693eRoHl0etw>
 <xmx:15DDarLpQHlYpjNhjWrYxZuJUxzQYIls1mKOeo4G1dbwhIui_7QwukBJ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 07:58:12 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Klaus Jensen <k.jensen@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org
Subject: [PULL 1/5] hw/nvme: initialize ns->subsys for n->namespace
Date: Mon,  5 Oct 2026 13:58:01 +0200
Message-ID: <20261005115805.99042-2-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005115805.99042-1-its@irrelevant.dk>
References: <20261005115805.99042-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.155; envelope-from=its@irrelevant.dk;
 helo=fhigh-b4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

We must properly initialize n->namespace.subsys too.

Will be important in the following patches.

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index c641226e27ad..597aeedd6a11 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -9694,6 +9694,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
         ns = &n->namespace;
         ns->params.nsid = 1;
         ns->ctrl = n;
+        ns->subsys = n->subsys;
 
         if (nvme_ns_setup(ns, errp)) {
             return;
-- 
2.53.0


