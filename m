Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD858CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 12:00:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDhLp-0001iV-1F; Mon, 05 Oct 2026 07:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xDhKy-0001VR-95
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 07:58:34 -0400
Received: from fhigh-b4-smtp.messagingengine.com ([202.12.124.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xDhKt-0002yt-6q
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 07:58:28 -0400
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 880707A00CA
 for <qemu-devel@nongnu.org>; Mon,  5 Oct 2026 07:58:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Mon, 05 Oct 2026 07:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1791201504; x=
 1791287904; bh=42GhXicXrnkHoYCttTFBJi2Ci4I0PDpk/K4m2dmDyCA=; b=H
 jBqK2zBdxcbySTmufkObR9bkcotQEmOp/lIn71PBS1FP9/pCkwnM8eiDKm6qKN+a
 kAAFZd1xcXuDv4O9zErdaqsyGnzsusmjOXHm8I/1ZIT+9atFoOUzskzVEur+L2zp
 c/0deKVVBuAbDvy5ixShM1NHIjYzVbOsVcqTCvUFBEEsjyOmJpD5Oz7FSXG6UOx8
 gY2PTQfIXJmrtsMzJ/JJiAaFj1YqdO8ZJcNEx48UdTrxej1ZSGy2UWtqr9jS6pjo
 l74Zc9LS65qA8dyTEyopGIZMd0BARrBGEDz0dsEeODBSC5znsPHt/8oVJKD3Q8/Y
 bcqVKX6XUgZzYyWWH9Wiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1791201504; x=1791287904; bh=4
 2GhXicXrnkHoYCttTFBJi2Ci4I0PDpk/K4m2dmDyCA=; b=w7bIUwYVb07Z6D6QW
 X5GDLdbUQHrXNklGh+HGcIUaOEi3N/ZlHX3Prnsc23Zr1TTeBswTQ5i+SroubTiF
 ex3fSndhsecLMXtMSxSWFgQrX7iiqzdWYPB4VIwoFrP7ZDKjWzBNdv59Gxscld++
 14koPzSl/vbzTOOh53ai5XI8OhM8qQP/F1SeQefnlkhFHnADbKh4TZHwAq5sZlqE
 4/8ut1vI/0O3vIU++pQM/C5mmIOwdPdqBI1FAKyOk7KbYmiatZkcSW0tEZJSpvFg
 Eavu5MLN+epeQkjoEXsk5vZ+IEJAYDgzQMEkLw13KmeADED0eixzYQ2e2A+xUQR0
 IrFcg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791201504; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm1:rsa-sha256:sGlzvUihX9NLPwM7OyEhDyRTA59koLi4QEkqJIOa0cAu40f
 9J+P402narZdGos0wOsCbohysa5+hsuJRZbIg964l29KWlMeoNRffkHK4TgkHlMi
 Z9UUBU5BWRhzXjv6QAMGdk0fHznBo336gKJ/JfoVrie+gVnS72zSPh1Mq+4U3f2O
 8wD8JUfompQpaYJi/ljU6X7tvG6+45CbTnDJxqQ1oMHyaOF4wA7BG86NEIBIYz6b
 NuDReUeXYNAEsl67kGhkDtCkHcX7RPk7YNu65bJXXX3hvAyp4BmdIrBt492dRVQG
 K6mQMAG2y6QSPvqMmns+nYMVHQxh7Y8xDAr17jg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:9XG28e4QGa+3pIyWZejT07N7DUD4+GlPpLNzdsyHMy8=:kEMenXJ+RDZB4hdbv5FxAwdBa35SwUMmFxCK40Mrlvk=;
X-ME-Sender: <xms:4JDDatfHl0z3GmljDCqoStkD_BliPxjdfaOE2leYMwR_BVFOPlYFLg>
 <xme:4JDDanM-F4dHFKgEsPkACBKzE1PsLnL8Uz_-a9QGnvli4bGwqZg4XVtTBca0_yHRY
 jdmvm6jYDZzEdVKUuAibZy6UsVQ52v1B6yIoSix5gF6A6FHjangt2G_>
X-ME-Received: <xmr:4JDDaos5yDWh7vre8Xuth9r4PzoAM2pcAMAuSgsWccM7_lh3X7VFCUSNOwWy9dxd6XapdZnVYMtXmwEm9s59ca-3>
X-ME-Proxy-Cause: dmFkZTEr+xmrqVGlVQGKS+bQ19SBCupADr7Hdv3MLlYOmJJ0MHpcGBVX7wqD5lzPTIvynB
 3Z7xCzf/9N09kBvoXTuT/jDvRF8pgZiXd8K7UF45X63MTAjNTmzBXogOUz2NqoJ/AIU0ui
 QVACBXTrXIFHdjQxbdPBca+AbDua3wZNoq8iqf7GWb8Rpl5PWnY1cpPh9s6B1Djg0gXYjJ
 iuexN2Z4QEn6q4Pqa7RSW1oF5+CdzLm0KydieObKFnQL5JMZ5ROLoF5dosd/2BfT/YKZmJ
 Pxl/3KtExYI0YoOpy2pHP658F+mvvlGXHM6P39dTEl5srih6JlOC+ix6hCTMWogIDu43ki
 KmcsFNzpmQtvczmB6ECzdbk531arpqO+L1ZFcSPISCOJdByBtps3RYi5SIiFLrzX4zYIvn
 SgYghV6ImtuYfd7y7jcqXhC3lKE+EFXsghQJHZfg8jyv3zRlOKF2p/bzY6BXLMNM/Wv+94
 Yfvef93crMztoYypk0jSVOPwyViAE4Bvol9/73272EYsT1ZP2/Rt33ll6jchN8EsP64ig6
 AbraEnM+xFisXEfCvDw74mwQ5pxoNanrXRMkfKxG7bE0AW61tOfMSHH2nKHn4QCC2kzZYI
 JfZJY2brB8jw6ujMCzNp86HiJroxkOMuc99Fgk8QYOWYClMsI0ETDQF/rjVQ
X-ME-Proxy: <xmx:4JDDaoBCy5KSl8zK8DV_Cld5nSrB10xypOa6-Um6r1LPo1QPqfZgsA>
 <xmx:4JDDanYlaPPc1SRn0fYdF89qAmj2wJwmPfRz0vZWn0E1HXI3YEy0zg>
 <xmx:4JDDarWsVB-n99pZFV92l8IWh_pNWwFKsSk4vzcR-029DtMl0f9dHA>
 <xmx:4JDDauNWlBhggjvyzSD9CxX1_A2dbKQgxw256cub9D4G-I06tzdXHw>
 <xmx:4JDDat2794VZhuSDiQcEqzJPTVPrQXVpqI7j25HjLuJ0eDLct6FUavAp>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 07:58:22 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel Paziyski <danielpaziyski@gmail.com>, qemu-stable@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org
Subject: [PULL 4/5] hw/nvme: fix memory leak on sr-iov capable nvme controller
 removal
Date: Mon,  5 Oct 2026 13:58:04 +0200
Message-ID: <20261005115805.99042-5-its@irrelevant.dk>
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

From: Daniel Paziyski <danielpaziyski@gmail.com>

If a nvme controller is SR-IOV capable, its list of secondary controllers
(virtual functions) is stored in the sec_ctrl_list dynamically allocated
array, located in the NvmeCtrl struct.

Free the secondary controller list after destroying the virtual functions and
freeing their controller IDs.

QEMU command line (boot with a hotunplug-aware OS, such as Linux):

    qemu-system-x86_64 -M q35 -device pcie-root-port,id=rp -monitor stdio \
    -device nvme-subsys,id=subsys0 \
    -device nvme,subsys=subsys0,serial=ctrl0,sriov_max_vfs=1,\
sriov_vq_flexible=2,sriov_vi_flexible=1,max_ioqpairs=4,msix_qsize=2,bus=rp,id=ctrl0

In the QEMU monitor:

    device_del ctrl0
    quit

ASAN splat:

==78982==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 32 byte(s) in 1 object(s) allocated from:
    #0 0x7fcbab32bea9 in calloc (/usr/lib/libasan.so.8+0x12bea9) (BuildId: 7f2845989b820f536270e19ec47df085ae89a675)
    #1 0x7fcbaa2a34b2 in g_malloc0 (/usr/lib/libglib-2.0.so.0+0x694b2) (BuildId: cb17d184459352a7985a010f1cd3acef4a4f90d8)
    #2 0x559c531fff4b in nvme_subsys_register_ctrl ../hw/nvme/subsys.c:65
    #3 0x559c531d715e in nvme_init_subsys ../hw/nvme/ctrl.c:9582
    #4 0x559c531d7a7d in nvme_realize ../hw/nvme/ctrl.c:9637
    #5 0x559c5323c0da in pci_qdev_realize ../hw/pci/pci.c:2316
    #6 0x559c54001e88 in device_set_realized ../hw/core/qdev.c:514
    #7 0x559c5402462e in property_set_bool ../qom/object.c:2484
    #8 0x559c5401dbd2 in object_property_set ../qom/object.c:1548
    #9 0x559c5402b76c in object_property_set_qobject ../qom/qom-qobject.c:28
    #10 0x559c5401e24c in object_property_set_bool ../qom/object.c:1618
    #11 0x559c53fffd77 in qdev_realize ../hw/core/qdev.c:277
    #12 0x559c53934166 in qdev_device_add_from_qdict ../system/qdev-monitor.c:740
    #13 0x559c53934272 in qdev_device_add ../system/qdev-monitor.c:758
    #14 0x559c538867c8 in device_init_func ../system/vl.c:1217
    #15 0x559c5487236a in qemu_opts_foreach ../util/qemu-option.c:1148
    #16 0x559c53891205 in qemu_create_cli_devices ../system/vl.c:2762
    #17 0x559c53891968 in qmp_x_exit_preconfig ../system/vl.c:2822
    #18 0x559c53898108 in qemu_init ../system/vl.c:3862
    #19 0x559c545efabf in main ../system/main.c:71
    #20 0x7fcba7627780  (/usr/lib/libc.so.6+0x27780) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
    #21 0x7fcba76278b8 in __libc_start_main (/usr/lib/libc.so.6+0x278b8) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
    #22 0x559c524df1f4 in _start (BuildId: 35402cb4fc46114b7a4102258726bbdec82cd9bc)

Cc: qemu-stable@nongnu.org
Fixes: c6159d0e384f ("hw/nvme: Allocate sec-ctrl-list as a dynamic array")
Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 1047961b03c5..578421c21761 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -9738,6 +9738,10 @@ static void nvme_exit(PCIDevice *pci_dev)
 
     nvme_subsys_unregister_ctrl(n->subsys, n);
 
+    if (!pci_is_vf(pci_dev) && n->params.sriov_max_vfs) {
+        g_free(n->sec_ctrl_list);
+    }
+
     g_free(n->cq);
     g_free(n->sq);
     g_free(n->aer_reqs);
-- 
2.53.0


