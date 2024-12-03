Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438EEE74AC2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 16:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIVQQ-0007R8-F8; Tue, 03 Dec 2024 11:07:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guohongyu24@mails.ucas.ac.cn>)
 id 1tIUyq-00061M-Kf
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:38:28 -0500
Received: from smtp86.cstnet.cn ([159.226.251.86] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <guohongyu24@mails.ucas.ac.cn>)
 id 1tIUyo-0000nk-39
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:38:28 -0500
Received: from guohongyu24$mails.ucas.ac.cn ( [111.199.67.46] ) by
 ajax-webmail-APP-16 (Coremail) ; Tue, 3 Dec 2024 23:38:11 +0800 (GMT+08:00)
X-Originating-IP: [111.199.67.46]
Date: Tue, 3 Dec 2024 23:38:11 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?6YOt6bi/5a6H?= <guohongyu24@mails.ucas.ac.cn>
To: qemu-devel@nongnu.org
Cc: gaosong@loongson.cn
Subject: 0001-target-loongarch-fix-vldi-inst.patch
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240627(e6c6db66) Copyright (c) 2002-2024 www.mailtech.cn cnic.cn
Content-Type: multipart/mixed; 
 boundary="----=_Part_2215507_706442123.1733240291447"
MIME-Version: 1.0
Message-ID: <3a7d9342.9e3d1.1938d2c0078.Coremail.guohongyu24@mails.ucas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: sQCowAD3_5fkJU9njhQHAA--.31227W
X-CM-SenderInfo: xjxrx0pqj13j2u6ptx1ovo3u1dvotugofq/1tbiDAgAA2dOwHMcWg
	ABsa
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWUJw
 CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
 daVFxhVjvjDU=
Received-SPF: pass client-ip=159.226.251.86;
 envelope-from=guohongyu24@mails.ucas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, PYZOR_CHECK=1.392,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 03 Dec 2024 11:06:37 -0500
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

------=_Part_2215507_706442123.1733240291447
Content-Type: multipart/alternative; 
	boundary="----=_Part_2215509_907106438.1733240291447"

------=_Part_2215509_907106438.1733240291447
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


------=_Part_2215509_907106438.1733240291447
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit


------=_Part_2215509_907106438.1733240291447--

------=_Part_2215507_706442123.1733240291447
Content-Type: application/octet-stream; 
	name=0001-target-loongarch-fix-vldi-inst.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-target-loongarch-fix-vldi-inst.patch"

RnJvbSAyZTgyMGY0Y2UzYTU3OTBmZDFkMTk5NzQ1ZjM3MTczZjBlMzEwNjFmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBnaHkgPDIyNDc4ODM3NTZAcXEuY29tPgpEYXRlOiBUdWUsIDMg
RGVjIDIwMjQgMjM6MzA6MTMgKzA4MDAKU3ViamVjdDogW1BBVENIXSB0YXJnZXQvbG9vbmdhcmNo
OiBmaXggdmxkaSBpbnN0CgpTaWduZWQtb2ZmLWJ5OiBHdW8gSG9uZ3l1IDxndW9ob25neXUyNEBt
YWlscy51Y2FzLmFjLmNuPgotLS0KIHRhcmdldC9sb29uZ2FyY2gvdGNnL2luc25fdHJhbnMvdHJh
bnNfdmVjLmMuaW5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2xvb25nYXJjaC90Y2cvaW5zbl90cmFucy90
cmFuc192ZWMuYy5pbmMgYi90YXJnZXQvbG9vbmdhcmNoL3RjZy9pbnNuX3RyYW5zL3RyYW5zX3Zl
Yy5jLmluYwppbmRleCA5MmIxZDIyZTI4Li5kMzE3ZGZjYzFjIDEwMDY0NAotLS0gYS90YXJnZXQv
bG9vbmdhcmNoL3RjZy9pbnNuX3RyYW5zL3RyYW5zX3ZlYy5jLmluYworKysgYi90YXJnZXQvbG9v
bmdhcmNoL3RjZy9pbnNuX3RyYW5zL3RyYW5zX3ZlYy5jLmluYwpAQCAtMzQ4MCw3ICszNDgwLDcg
QEAgc3RhdGljIHVpbnQ2NF90IHZsZGlfZ2V0X3ZhbHVlKERpc2FzQ29udGV4dCAqY3R4LCB1aW50
MzJfdCBpbW0pCiAgICAgICAgIGJyZWFrOwogICAgIGNhc2UgMToKICAgICAgICAgLyogZGF0YTog
ezJ7MTYnMCwgaW1tWzc6MF0sIDgnMH19ICovCi0gICAgICAgIGRhdGEgPSAodCA8PCAyNCkgfCAo
dCA8PCA4KTsKKyAgICAgICAgZGF0YSA9ICh0IDw8IDQwKSB8ICh0IDw8IDgpOwogICAgICAgICBi
cmVhazsKICAgICBjYXNlIDI6CiAgICAgICAgIC8qIGRhdGE6IHsyezgnMCwgaW1tWzc6MF0sIDE2
JzB9fSAqLwotLSAKMi4zNC4xCgo=
------=_Part_2215507_706442123.1733240291447--


