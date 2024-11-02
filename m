Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E34E677FC
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 12:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7DH1-0005XA-9N; Sat, 02 Nov 2024 08:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cn_yzr@qq.com>) id 1t7Cp0-00068f-IM
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 08:01:40 -0400
Received: from out203-205-221-236.mail.qq.com ([203.205.221.236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cn_yzr@qq.com>) id 1t7Cow-00038P-Co
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 08:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1730548884; bh=lhkfVtXcEQgCnD1Ub04Qbdb/2X9foDoCjJIAdaEByHc=;
 h=From:To:Subject:Date;
 b=tJJIJhGU5lO0RJGvUueT1XyXHXI5M47xyj9xYWgoYTxl9vNqfX+JOT6Vm4Hq80mcD
 okpMv8vQ/O8rWxam/pqYQQ2qvM14uYqCBQLYRCJ3jxKuk60VSxkuwtE6gjFoDNFMSS
 i0JV7iJLfenw0Dw9tAM02hqfRqF1o9Mv3rW8tu6U=
Received: from inspiron-manjaro.localnet ([106.39.42.109])
 by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
 id D83A8CE6; Sat, 02 Nov 2024 19:54:03 +0800
X-QQ-mid: xmsmtpt1730548443tvc2xdv27
Message-ID: <tencent_74B4817FC7CE8E511A71F3FAC45008618E09@qq.com>
X-QQ-XMAILINFO: OEKczhWbxalFgFCUEmuAKKa8nBbtrk1CvYkI9e/QFit2sFJVCbpdvW0seBg7Le
 utHG8n5ZyTApNopFm8jLDiC4blZN9eR0Hm+JgZmjxeW15vPNAVgcGjSfSlFfgns/LF1Z2GvtZuGI
 OOnIImPMLfLfWJQClCrFZQGUNQozSTZ9fAWFxrxTPZPrPhQ/2nkFD8fClXsK2zkKdKa/RPYLBCms
 Y9WIBXPVcTF5UAzCCl+KEzykbDSFSL8PnPiLWIIZWBtDwsskUnwjrO899ZUwAgur3nYuAb588ULT
 kEofbb8cDV4LxVUa3v2fKT2yIR0YKPEt8CL/f9+cV/+L2SnAIPMRS7/Jw2DCgaCIQK++GBdu7s1G
 2FRbZVximpYyTd1bwiU8ScLzYpezSIU3IzisePSB/LyxnA+nMSVbMMRfjV55bsYgQCa0bAa3gug0
 Q9wFixKVQzUJYg00IjXwzR3OcN9r9r0rUv8i4/uceWm5Cm3FPQIg/lQE5VZ3sMQLRbAPVF/K8pCw
 xrXcCjICirLM6hW/jN+gL1TrrmWFb+jBXkYJRzqXJGpIw4yJFWBbxo/LuIkstv/9/ZPfy2i13Y7V
 UAGeNXZNHDAQxKvS76nX+wt6XQ7M0ACjBJLIVFMF/RhAtpvd8NeleFq95AZJLaZLSlYkhHQaK3eh
 Jm9rkDZaotZ1eANCs5vsL5iBCzaBQzeHyV79cU5Gs057/t4TkmPDEs7rZkuUTn/DDo3ZLjAN1CBn
 jfV/MGQX3I+2stxeBMwj4DpXxq9rNGCrSOCqZtcdFhbG+8kXE0qrOMztIyka6q32LM5miAKGnQ5C
 vIbwIJW1BHEmdO6j+lTPL4UTyGPRjwI/t1wsR0GNRh3ux7keln+CX/WMcvsp228iKvh2Uj6+2qSs
 jTwqYkG0eGMYe6gEPtHdEJsJhzQnzvri2btLLN3FKsH6JJyFCLIYA=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Yip Coekjan <cn_yzr@qq.com>
To: qemu-devel@nongnu.org
Subject: Inquiry About PC-Relative Code Generation in QEMU
Date: Sat, 02 Nov 2024 19:54:03 +0800
X-OQ-MSGID: <4960480.31r3eYUQgx@inspiron-manjaro>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=203.205.221.236; envelope-from=cn_yzr@qq.com;
 helo=out203-205-221-236.mail.qq.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HELO_DYNAMIC_IPADDR=1.951, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 02 Nov 2024 08:30:31 -0400
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

Dear QEMU Community,
I hope this message finds you well.
I recently started studying the QEMU TCG code, and I have noticed that QEMU 
seems to support generating PC-Relative Code (`CF_PCREL`), but this feature 
seems currently enabled only for System Emulation in version 9.1.0, while it 
is not available for User Emulation. Could you please clarify if there are 
specific functionality or performance considerations behind this decision?
Additionally, if this feature were to be enabled for User Emulation, could we 
consider the code generated by QEMU as Position-Independent Code (PIC)?
Thank you for your assistance.
Best regards,
Yip Coekjan



