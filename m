Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16D6C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 21:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhyUv-00074U-0k; Wed, 06 Mar 2024 16:08:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <info@maximka.de>) id 1rhxJk-0004u9-2V
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 14:52:44 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <info@maximka.de>) id 1rhxJi-00025g-4P
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 14:52:43 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1709754757; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=I/MmsUGHTxZMVWJ79/1iEoo1GgNQnJSAk7IAQLzQOeWqQ/6lVwEaQ0fXLAbGCokQPN
 UH70iNNhvfzgWEiyV5aVxKeKE4UU7Zy0UKIZxiqG/t3tJDUi0oCVz0kZVhOA9qLOgaOV
 eIu0akJkzWpSaAb3nL62wG85y5Ec8tD2IFdHq/tncAjdlDgfmIYPFxiwoo8XHf3I+xP6
 fcR+AySY7xZYiDK6r1CoWYPXOOjwcVXK1pb1oBCeOBMgrHE1O17A5UZeQFfBZY1ie8o0
 Ev5CDbAOGM69po139s63lTsTaJL7ENTghigukTGivZ3fbQpA3MySX1hj3YkWCrOU5q7v
 5FwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1709754757;
 s=strato-dkim-0002; d=strato.com;
 h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
 bh=CgMlrG0sN6rez4LMHO61MIUdUmQSTGn8nr0uVeiuK/4=;
 b=INcWFgpGyUClIiBmB84BfB1c6kw8t88566Fc/QobTXnWT16AOxEGcglz2R5KWQuwVc
 UDY6YZD8pXjBMhXrqZnC7GI5/lrM4CP5eWYr3KlH2xtJq+NMbnLgaWyd7+J/jVCtDBAO
 5vGULPZmyQxXAZnfkfpJZxpG+oafWCPy8zQskOJxSeSoazxEuRhBNKOwbBk2PkUryg9P
 Wh/GPhLXx7UOiS5dxvXX9fXEqGDgZBLW/S1K1wgVdi3DnQHZQ0T+/zU59NHu78O/82vP
 XnyF+l4AOXwNOoaqw3cfRy1GGAy9OT/LfuWYuarEFG4B1SyHBkY/grnT++iZi7kmmv2K
 0eFg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1709754757;
 s=strato-dkim-0002; d=maximka.de;
 h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
 bh=CgMlrG0sN6rez4LMHO61MIUdUmQSTGn8nr0uVeiuK/4=;
 b=WXGjenqluvovWK2gnhdquErsikOFhiZa6+Ita6Ojy16iLdAKTPfzv3z6xyv6ffx35V
 9y6LzIvJpjxPNcMHYyfAdJRW3ha0o6Dt+RJr86EvfOAAtT73YLKFiqGlk8UjVijZsj5t
 nwiYtEnoUF8aJJD63j4bOcHJucN2s6t0oYqK4SwN9SI0Pg+UyDBLotjGAVn4DzErY/yK
 Qf87Szr/cISH64lQa54kKSjUkTILxwyqmMh6i8yoQo8xb1Ib9qeO2XqXfxySwlMy1wmL
 Q+ixLASbXAtiiTf5vD1NhmIponi+ombsdt12+/6UNVQApXnllOcU1i6mxuh9YXusFpOY
 G7ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1709754757;
 s=strato-dkim-0003; d=maximka.de;
 h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
 bh=CgMlrG0sN6rez4LMHO61MIUdUmQSTGn8nr0uVeiuK/4=;
 b=SCwoOCywQOqt+ZOHXf6e5WPsQRvgYTxGru7ghw3u8KKT5CA9R4winsy8c0m1iv7Nau
 WDiADOxixQxYlw46tRCQ==
X-RZG-AUTH: ":JWICemCleucEZGNurnXz/7xIHdyVrBVseu4t8zsQBJLrlG+xkMbI/m4uBgE3i1hBaQM7bDIKr1/ge0kZWL8z684/OOeKaw=="
Received: from ox-live-app303.back.ox.d0m.de
 by smtp-ox.front (RZmta 50.2.0 AUTH) with ESMTPSA id Y6d679026JqbiND
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1
 with 256 ECDH bits, eq. 3072 bits RSA))
 (Client did not present a certificate);
 Wed, 6 Mar 2024 20:52:37 +0100 (CET)
Date: Wed, 6 Mar 2024 20:52:37 +0100 (CET)
From: info@maximka.de
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "stefanha@gmail.com" <stefanha@gmail.com>
Message-ID: <2048170974.2556839.1709754757016@webmail.strato.de>
Subject: no target for a link in the post "How to access libvirt domains in
 KubeVirt"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev60
X-Originating-Client: open-xchange-appsuite
Received-SPF: none client-ip=81.169.146.217; envelope-from=info@maximka.de;
 helo=mo4-p00-ob.smtp.rzone.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 06 Mar 2024 16:08:19 -0500
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

Hello, thank you for the post.

The href in the link
<a href="https://kubevirt.io/user-guide/debug_virt_stack/">Virtualization Debugging</a>

should be replaced by
https://kubevirt.io/user-guide/debug_virt_stack/logging/

Best,
Alexei

