Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E60C02196
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 17:01:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teznZ-0006Az-Vs; Mon, 03 Feb 2025 11:59:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1teznY-00069r-GS
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:59:48 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1teznW-0001Mq-ER
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:59:48 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B8E772115B
 for <qemu-devel@nongnu.org>; Mon,  3 Feb 2025 16:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738601982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fk+a0seA2v2BaWN2j7YC9dj/64HXFTV1RseFpk4/DQc=;
 b=QpGRB9TadGrcy5FfbeCRYMcKC2KSFEPyWPuQ4RHFAi2NTn8fwLz4Cf35TMYVNI+CjYTCqh
 38FSC7iNOV3sf67eTkcbIro1gvjbd8cqImkO9+IGgfazPhZvrPiB0PSqZMQZDvCPIBy9cr
 02xQQDOlezG18qDx3JD5AtD2Np5rpks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738601982;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fk+a0seA2v2BaWN2j7YC9dj/64HXFTV1RseFpk4/DQc=;
 b=6fxgegI4nuO6WPdywqohxdOfCxCwws94iEMepuCcC2nMNj3tbUVarsf6riVOmP/8zw3gwV
 XiIPlRS+rzEeukDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QpGRB9Ta;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6fxgegI4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738601982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fk+a0seA2v2BaWN2j7YC9dj/64HXFTV1RseFpk4/DQc=;
 b=QpGRB9TadGrcy5FfbeCRYMcKC2KSFEPyWPuQ4RHFAi2NTn8fwLz4Cf35TMYVNI+CjYTCqh
 38FSC7iNOV3sf67eTkcbIro1gvjbd8cqImkO9+IGgfazPhZvrPiB0PSqZMQZDvCPIBy9cr
 02xQQDOlezG18qDx3JD5AtD2Np5rpks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738601982;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fk+a0seA2v2BaWN2j7YC9dj/64HXFTV1RseFpk4/DQc=;
 b=6fxgegI4nuO6WPdywqohxdOfCxCwws94iEMepuCcC2nMNj3tbUVarsf6riVOmP/8zw3gwV
 XiIPlRS+rzEeukDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1CAB13A78
 for <qemu-devel@nongnu.org>; Mon,  3 Feb 2025 16:59:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id K9r1Jv31oGfDdgAAD6G6ig
 (envelope-from <farosas@suse.de>)
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 16:59:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] QTest patches for 2025-02-03
Date: Mon,  3 Feb 2025 13:59:32 -0300
Message-Id: <20250203165938.14320-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B8E772115B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_NONE(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[qemu-devel@nongnu.org];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 6fccaa2fba391815308a746d68f7fa197bc93586:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2025-02-02 11:09:10 -0500)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/qtest-20250203-pull-request

for you to fetch changes up to cd6406df15ed2216e70e34c45a4a82f42b55873f:

  tests/qtest/vhost-user-test: Use modern virtio for vhost-user tests (2025-02-03 12:32:54 -0300)

----------------------------------------------------------------
Qtest pull request

- fw-cfg: DMA support and new vmcoreinfo test
- accel detection via QOM for non-KVM accels
- use virtio modern for vhost-user

----------------------------------------------------------------

Ani Sinha (3):
  libqos/fw_cfg: refactor file directory iteraton to make it more
    reusable
  tests/qtest/libqos: add DMA support for writing and reading fw_cfg
    files
  tests/qtest/vmcoreinfo: add a unit test to exercize basic vmcoreinfo
    function

Philippe Mathieu-Daudé (2):
  tests/qtest: Extract qtest_qom_has_concrete_type() helper
  tests/qtest: Make qtest_has_accel() generic

Thomas Huth (1):
  tests/qtest/vhost-user-test: Use modern virtio for vhost-user tests

 MAINTAINERS                   |   2 +
 tests/qtest/libqos/fw_cfg.c   | 206 +++++++++++++++++++++++++++++-----
 tests/qtest/libqos/fw_cfg.h   |   6 +-
 tests/qtest/libqtest.c        | 110 ++++++++++--------
 tests/qtest/meson.build       |   1 +
 tests/qtest/vhost-user-test.c |   3 +-
 tests/qtest/vmcoreinfo-test.c |  90 +++++++++++++++
 7 files changed, 342 insertions(+), 76 deletions(-)
 create mode 100644 tests/qtest/vmcoreinfo-test.c

-- 
2.35.3


