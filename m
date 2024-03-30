Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE68C6FD1F
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Mar 2024 14:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqZOO-0001qc-Ss; Sat, 30 Mar 2024 10:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <dcae75fba1084823d0fc87caa13f0ba6f32155f3@kylie.crudebyte.com>)
 id 1rqZON-0001qQ-SR
 for qemu-devel@nongnu.org; Sat, 30 Mar 2024 10:09:07 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <dcae75fba1084823d0fc87caa13f0ba6f32155f3@kylie.crudebyte.com>)
 id 1rqZOM-0000Ld-Af
 for qemu-devel@nongnu.org; Sat, 30 Mar 2024 10:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=WGt1ZNrBrusq3t16iYFw0Y+qYctBiIeHDqDGAlae6KM=; b=fwUlS
 q65VDWXuQKfJJ6HNso2gzapctiV4W0+V1U86dVKnN6a6xSdeIlNfqMEsDMoCYVsX+X4l6eY4xr/ne
 jZyhoeWW8fiAdlHq9SGBhB61pnHfpolzrJXYre181t7lMyrfecus93AzKp3XCyTAqf4AE+3w8Dwmu
 cSuc023oWVz3dx7ZTIXM3aah07PKiEuZ3y+l0Anhj2Zr7dGONVix6DV4dKSS8+iw7N+sqKpZXjKiB
 1q6OlKj/czWOBRhVzEGE3cB64OPh6T/AimvH6+2Nv76CK/ilI4MENpazyaSpZFhNGUBUvWO5nThW+
 Jx2uPJK9eEW6yLP3hMwozT1a/1BWp3B5UYqa+Y2CTo907SLeNEUQR+2ibPXGpl16cNoAzZEOleCUU
 JFp6mhmKYtOLfcdhfxF/kcwT4RbTwoHmCaN5aFNy+GHgmTD0iFhYfi4PecRoAIMX7G92mqz5MrxYR
 B4pBI91gARjYp0S9FGEnNn1fGAR8Em7BW0eXKjpGMDZam99ryGFEWnzNTQQg21ToOUujo+ks7mnDr
 pKK9sBxx2l3g+cmjz4nFcroDB9dQ0JxR75YLI0CBxc58s9Y+QyS6aUgxt5zEZmVoJUJHzzSDnIQWN
 j37HStMpRvCU5nKw/h3nmYn/yPX5lfcYl0s5X4pmti+DMVM+gnfw7bhjv1GgTM=;
Message-Id: <cover.1711702001.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sat, 30 Mar 2024 14:33:03 +0100
Subject: [PULL for-9.0 0/2] 9p queue 2024-03-29
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>
Received-SPF: none client-ip=5.189.157.229;
 envelope-from=dcae75fba1084823d0fc87caa13f0ba6f32155f3@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 5012e522aca161be5c141596c66e5cc6082538a9:

  Update version for v9.0.0-rc1 release (2024-03-26 19:46:55 +0000)

are available in the Git repository at:

  https://github.com/cschoenebeck/qemu.git tags/pull-9p-20240329

for you to fetch changes up to dcae75fba1084823d0fc87caa13f0ba6f32155f3:

  qtest/virtio-9p-test.c: remove g_test_slow() gate (2024-03-28 09:54:47 +0100)

----------------------------------------------------------------
Changes for 9p tests only:

* Fix 9p tests for riscv.

* Re-enable 9p 'local' tests for running in CI pipelines.

----------------------------------------------------------------
Daniel Henrique Barboza (2):
      qtest/virtio-9p-test.c: create/remove temp dirs after each test
      qtest/virtio-9p-test.c: remove g_test_slow() gate

 tests/qtest/virtio-9p-test.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

