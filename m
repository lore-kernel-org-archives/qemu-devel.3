Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF1FC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 20:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2FM5-0002h6-HK; Tue, 08 Apr 2025 16:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.granados@kernel.org>)
 id 1u2FLf-0002G3-Rc
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 16:15:16 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.granados@kernel.org>)
 id 1u2FLX-0004yF-Ts
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 16:15:06 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 22E115C0594;
 Tue,  8 Apr 2025 20:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD4E7C4CEE5;
 Tue,  8 Apr 2025 20:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744143293;
 bh=wsX5JeCeUenZtAXorAHzLnlv/QiMaURnQ+d3eE0sd4A=;
 h=From:Subject:Date:To:Cc:From;
 b=YMogCc8zjM8aVWVrs8/t9eMRDChRwqRcVfqyaT1BP0UiDmfj/VpN6sIu1Ql3wIKXk
 vxvTUiiRoegEYWmmvMnrTOxLdlU/MyOIA0tHqSRS/sVlAyx391MtHZvl+2m7hqSQRK
 rixCYv4PAi0zoAhUvECGq7FKASzLUUP1Gt+l8TwjTm4VGZkoLnh2mqrvLaKWn+hdvz
 xC0DaxKqnJoE/zP77YRyWH7UrxeOCBw4RobIa/goXAAgHPqonr336H2Clq0E5eRZMm
 kvxIet6xoOK62p0jP+p7ZgjSTAc+5Dq7mrz9el8bpzkiBAJtHeM/3l1nFR5MQlMFHr
 bNa9cdmRGvvTQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id B4D24C36010;
 Tue,  8 Apr 2025 20:14:53 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Subject: [PATCH 0/3] scripts: Add a root dir in archve-source.sh
Date: Tue, 08 Apr 2025 22:14:45 +0200
Message-Id: <20250408-jag-sysctl-v1-0-3f4f38b751be@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALWD9WcC/23MSw7CIBSF4a00dyyGR6m1I/dhOqB4oWgDBhpi0
 7B3sWOH/0nOt0PC6DDB0OwQMbvkgq/BTg3oWXmLxD1qA6dc0pb25KksSVvS60JEp4Wcrh3VvId
 6eEc07nNg97H27NIa4nbYmf3Wv0xmhBIjdasmJfBizO2F0eNyDtHCWEr5Aql7VZSlAAAA
X-Change-ID: 20250408-jag-sysctl-36c35b960c28
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Cc: qemu-devel@nongnu.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1009;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=wsX5JeCeUenZtAXorAHzLnlv/QiMaURnQ+d3eE0sd4A=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGf1g7rt1DLW60zvHojJfCFHedC4h+6vXsG47
 +2ArW2O5vrD/4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJn9YO6AAoJELqXzVK3
 lkFPd5IL/2wml2hU6QsJcLVJNVG0qjPr2aYVKFphwndj2tG3tZBa2n/lk24D/FKZgWofIPFj7Bt
 85u256DZOeNOvicwvPi3XbnrVaV8GodEh4yhuqIcsl8fGDlTK5H3ZjNPKPO8czqiAl+Zs9QvctV
 FfSze/mAENCidfyvELIYb/bhRqjLWufLBlL0ssfwYzCCmbQZCtvc1VgyfiOUvxzNnQoWNhWMMrn
 A4qfGgZsdoKBYhkjeEPsz8aeZq110RFZ1Y6snUV5THtoz2POG3weEqofWuiTvCk34hBEj9GpAT1
 PDfRG0uQl/IpXMTiLySWE5KrBblUylOyHx6qW2+myZ8dk7czIbOwvKTHmYADIHVvXjbYLw4VpSK
 eQXxs33Es3IzfvZ/NfFtCyXTeA3+IpFJa1AUKGMd9ntvqBbgMS60rUmdvVem+x5VNq7HXgWh1SS
 isLpeJJnDr1Che+eO+r+rxZKkJHP+s/2q1lD2Z7W4+SUsy0okCP42c2u14UEa/g8aDqcV8kdBi7
 s8=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=joel.granados@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

When creating an archive source to use in a nix overlay, it is necessary
that all files are appended to the tar.gz file under a root dir. This
series adds a argument (--dir) that will create a root directory and
append all files under it.

The series does not change the default behavior where all files are
added to the tar.gz root.

Comments are greatly appreciated.

PS: Had initialy missed adding qemu-devel to CC. Appologies if you
    received this twice.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
--

---
Joel Granados (3):
      scripts: nixify archive-source.sh
      scripts: Add root dir to arguments
      scripts: Clarify doc messages in archive-source.sh

 scripts/archive-source.sh | 92 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 69 insertions(+), 23 deletions(-)
---
base-commit: ea35a5082a5fe81ce8fd184b0e163cd7b08b7ff7
change-id: 20250408-jag-sysctl-36c35b960c28

Best regards,
-- 
Joel Granados <joel.granados@kernel.org>



