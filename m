Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA5F11258BE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 16:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0iXM-0004mm-5C; Thu, 12 Mar 2026 12:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kurt@garloff.de>) id 1w0iGu-0007Fs-8X
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 11:48:24 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kurt@garloff.de>) id 1w0iGr-0001mm-Mp
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 11:48:23 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1773330491; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=PqacuHQw0JhpzPJOZb9TS12PqLHP+W6Zl5Hb8I69RhscRwn6369SVGBKYGz1gIMajD
 LtvRdXF+OfY2iA9p17KCQV13KopC5/MXKfcKZFom0Sf3IGcMN4UPGVdbpuwy4DbLWP1J
 T1zMZ+UHfohvTc1RU1jZX8xH+wcRxjcX/Wy5Z1G0wREnWjx7KyDOHdUOLvVRK7rzufDa
 pTl8HaGLIJGg2Ar9kcTC2dYdAQ4bzEatj+2P5rJzadrOm4X3VqjakpK5JGXRf+oP1G1r
 DzQRYcSj2o0FePIwk1VNEM6XjFlqKeW4xVMqrqbjYkn/XJ1jBDuFqu7k6/ijHQq3bdzt
 soig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1773330491;
 s=strato-dkim-0002; d=strato.com;
 h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
 bh=U6G1cGS9XfNiWcKbFLJquPYYUxrb+2KbaNUZH1cT1Tw=;
 b=E1JPspt26AkA1spZt8uXXP0FWvbIfPAUH7cuTE3m/p3JU7Unc7kFBg9wIxoHeOMK7l
 8vnJvTgSpz72dd2lS6WEvc2RpwpCUPLGBfRgHvQ0/1DQOklHf7TapVXdqM+VIvFnEevv
 JJLVq6TG1rEadZwylF8NhmBIu3/5Dc7b8wbJrNef4RkvF0qW3wFHLznHqPJWgEZE2kga
 4ITs8nCeg1OSe9Wim1I+/AjemCEPD44gN4p2JLQeIZbViRzvZjrMYSWCF/8IRMQEnRyQ
 7EjJ3XKd/VAgaSrnFxxla++QF/Buo5sg2xmltzjw5OJj/U5CF9xV7rEVJk/j9bwoHbTk
 jAnQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1773330491;
 s=strato-dkim-0002; d=garloff.de;
 h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
 bh=U6G1cGS9XfNiWcKbFLJquPYYUxrb+2KbaNUZH1cT1Tw=;
 b=Qt9NHDl9bXYrIWBNzr/FYC8NNiFgvdm+6Er6GopY18OUjafwgSib/Qq8b8ef+Jz6ob
 4GZt6KVpm/Je4Xm1C7OBWLWqJ11o3aHg621eAOuNiHetN5HiaTJOBB6oGO/5DCb1ZaLr
 pPCVKkJqQKqutHeTGHDcdIGRklhHSYAXjPL6Z99qG0umYRk3iiM2uZnUJ3uPQlj5GeNa
 r+1XtrWtMWVwzVcxQ4l8/xWROGMzK7CinkQ4M4QsCusBw04lT9ZjFsWcuMgS7VbxAwBA
 8JqSwStz2GghEkfM8hB4wAbaom0guYyOsSJch6lGRbs0h0jXS4gvevpAVeQbZlAM9CFD
 eGRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1773330491;
 s=strato-dkim-0003; d=garloff.de;
 h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
 bh=U6G1cGS9XfNiWcKbFLJquPYYUxrb+2KbaNUZH1cT1Tw=;
 b=CiAhE50VNTlCVYaMC49SW4U/fEN7lzfHJuTYztYBSXxiN0U7W8/UQ7eI+fse+IsgX6
 gL5mirdODLB7rZRoF1Aw==
X-RZG-AUTH: ":J3kWYWCveu3U88BfwGxYwcN+YZ41GOdzUdLW+J8VEEt2hpSnX3o5gaPzqvM7iQ=="
Received: from mail.garloff.de by smtp.strato.de (RZmta 55.0.1 DYNA|AUTH)
 with ESMTPSA id L78db422CFmBeN4
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Thu, 12 Mar 2026 16:48:11 +0100 (CET)
Received: from dev2018.garloff.de (dev2018.garloff.de [192.168.155.28])
 by mail.garloff.de (Postfix) with ESMTP id 883595FA20;
 Thu, 12 Mar 2026 16:48:11 +0100 (CET)
Date: Thu, 12 Mar 2026 15:48:05 +0000
Subject: [PATCH] Don't disable PCIe atomic routing for multifunction
 devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260312-enable-multifunc-atomicroute-v1-1-b7d66ca54319@garloff.de>
X-B4-Tracking: v=1; b=H4sIADTgsmkC/x3MTQqDMBAG0KvIrDtgEijoVaSLafxsBzQp+RFBv
 Luhy7d5J2UkRaaxOylh16wxNJhHR/4r4QPWuZlsb5+9M5YR5L2Ct7oWXWrwLCVu6lOsBezFGDh
 xwzBbasUvYdHj30+v67oBRF9RlG4AAAA=
X-Change-ID: 20260312-enable-multifunc-atomicroute-ca11e3a399d2
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Kurt Garloff <kurt@garloff.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3054; i=kurt@garloff.de;
 h=from:subject:message-id; bh=zqkaK5tepcHIoEzhobkJLxjxw1S4jJpcqDMDBgfQDOc=;
 b=owEBbQKS/ZANAwAKAd5PGzor/8W/AcsmYgBpsuA7DH0SB68yRW98DF2leSZ2TiNd1Fcv9IwV5
 rY5FJYy652JAjMEAAEKAB0WIQRmafc0DTHpXsVWVJDeTxs6K//FvwUCabLgOwAKCRDeTxs6K//F
 v32tEACItpfnuUZ36IyNt0FtYc8XDU6RDeeNckEFcS0Qncj9uhRh2aLkkuPsOukd7Yz0SZp3rBM
 ioGOPtqrlFR0Q5OikB3PxYne7CUKRwS3E53a0KzDOWMa24qZPT+OieeZZzllhG9EULAvZ6oisjH
 5jtw3zcJS6SZPJH0BIrlYrZQZz3ck3JC8H2KcyQeRXFCXDNLizGtbLkC6z/rjDwNgXwODpm6sPg
 wq8brfT6Ib6qO5yhmXJR6EHnBErcrCHisCoax+dGg5VdjhqVBxy8JZX+DSIYSZi5cv3lnH5ZrmU
 oBDZJDFKuOoxC4pejZIJXE/uR5WduJqyk7GtLDcnLVLmeo8YZF81COtjuKyp5BMZyUeFSaLg8Yu
 d24d1/Nl1DwEzStLktwGRbCG4S/PDcPK9apLZJHYi3/uyHZRQUWz/2Ebj56kFFJ4qrEmt7tEp8r
 hcS4LGoPc/55eYfNNVeZek9YboeigPF00UjvZC7PIMLQ3m5twCamxQgWeXXI5Maw10G6roMepSp
 /kE5F8yLwFrtixUGLpLFHRgSLak1z7j8HBUglULh8fzAZIkI9DDLGbsHDCo4e1dsQkDmSXvi16w
 DNfWMI9WshGSLP275s41DkMwa9qOF4eQnM4Jj+AvuweC2T3U1t7Vps7AVB47WH/EpBHNRA0+NTa
 fQ4/TKWhRkTUt2g==
X-Developer-Key: i=kurt@garloff.de; a=openpgp;
 fpr=6669F7340D31E95EC5565490DE4F1B3A2BFFC5BF
Received-SPF: none client-ip=85.215.255.20; envelope-from=kurt@garloff.de;
 helo=mo4-p00-ob.smtp.rzone.de
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 12 Mar 2026 12:05:19 -0400
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
Reply-to:  Kurt Garloff <kurt@garloff.de>
From:  Kurt Garloff via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

As included in the comment: The PCIe atomics routing does not hurt,
even if some subfunctions of a PCIe device don't require it.
Graphics cards often have an audio device next to the GPU, so this
actually causes them not to have PCIe atomics support. The amdgpu
driver however needs atomics for fully supporting ROCm.
So stop excluding multifunction devices.

Tested with Radeon 7900 XTX.

Signed-off-by: Kurt Garloff <kurt@garloff.de>
---
The amdgpu driver requires them to fully work with ROCm.

The good news is that qemu already has code that detects the capability
of the PCI device and enables the routing of PCI atomics in the
pcie-bridge. This unfortunately did not work on my system, because I
have a RX7900XTX which is a multi-function PCI device with the GPU
and the audio function. I pass through both to the VM.

I could not find any reason to disable PCIe atomics routing even
if some subfunction does not require it -- it does not hurt.
So I took out the check.

With it, the amdgpu driver works nicely in the VM.

Sidenote: I had used patches to manually override the autodetection,
but prefer the automatic detection which is much simpler in both
code and usability.
---
 hw/vfio/pci.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 94c174a773..077ff3a6a8 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2112,17 +2112,19 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
     uint8_t *pos;
 
     /*
-     * PCIe Atomic Ops completer support is only added automatically for single
-     * function devices downstream of a root port supporting DEVCAP2.  Support
-     * is added during realize and, if added, removed during device exit.  The
-     * single function requirement avoids conflicting requirements should a
-     * slot be composed of multiple devices with differing capabilities.
+     * PCIe Atomic Ops completer support is added automatically for devices
+     * downstream of a root port supporting DEVCAP2.  Support is added during
+     * realize and, if added, removed during device exit.
+     * Note that we previously only did this for multifunction devices to
+     * avoid conflicts; this restriction was unnecessary as routing atomics
+     * will not harm and won't be generated by devices not requiring it anyhow.
+     * The restictions hurt many discrete graphics cards which have an audio
+     * device next to the GPU.
      */
     if (pci_bus_is_root(bus) || !parent || !parent->exp.exp_cap ||
         pcie_cap_get_type(parent) != PCI_EXP_TYPE_ROOT_PORT ||
         pcie_cap_get_version(parent) != PCI_EXP_FLAGS_VER2 ||
-        pdev->devfn ||
-        pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
+        pdev->devfn) {
         return;
     }
 

---
base-commit: 769a37d8bd0c81c39128fc292352f01bad0769f4
change-id: 20260312-enable-multifunc-atomicroute-ca11e3a399d2

Best regards,
-- 
Kurt Garloff <kurt@garloff.de>  [Koeln, Germany]


