Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D7BC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 13:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbXi-0006DM-U4; Tue, 01 Apr 2025 09:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tzbXa-0006Cz-CU
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:20:31 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tzbXX-0003BZ-JX
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:20:29 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5E42D211A1;
 Tue,  1 Apr 2025 13:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743513623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DXAT9yAE2uZbTnqDTf4ACHMSYt6C/DCd4zGJfpGO3NE=;
 b=Gko/3Hy3GSH6wDeV3S/w6r2l73q6D5+0T4Isyrp1bgSGJ2vDwvluCN4rzkYD4+Yy2ieopl
 kwcQLSEg8LVuHstRw7xMK3VK2DxwVdZXlLWngF3/H2Svi9D4vaS2K7Nu1nSPj53RcuZ3Yz
 X/izBj0e0FKPZHtC50z048TiSWpxRuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743513623;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DXAT9yAE2uZbTnqDTf4ACHMSYt6C/DCd4zGJfpGO3NE=;
 b=hHAaqMsMXUePTAW06s+wNeusymqp7++YBw/NS85INttBwrkKwmPy9d1oVxOutdjPInBp49
 h7Wr8qSdBmgZ2hDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743513623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DXAT9yAE2uZbTnqDTf4ACHMSYt6C/DCd4zGJfpGO3NE=;
 b=Gko/3Hy3GSH6wDeV3S/w6r2l73q6D5+0T4Isyrp1bgSGJ2vDwvluCN4rzkYD4+Yy2ieopl
 kwcQLSEg8LVuHstRw7xMK3VK2DxwVdZXlLWngF3/H2Svi9D4vaS2K7Nu1nSPj53RcuZ3Yz
 X/izBj0e0FKPZHtC50z048TiSWpxRuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743513623;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DXAT9yAE2uZbTnqDTf4ACHMSYt6C/DCd4zGJfpGO3NE=;
 b=hHAaqMsMXUePTAW06s+wNeusymqp7++YBw/NS85INttBwrkKwmPy9d1oVxOutdjPInBp49
 h7Wr8qSdBmgZ2hDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CCA5813691;
 Tue,  1 Apr 2025 13:20:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wwAbIhbo62fqTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 01 Apr 2025 13:20:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH-for-10.0] hw/vmapple: Allow running QTest framework
 on macOS
In-Reply-To: <20250401090607.36375-1-philmd@linaro.org>
References: <20250401090607.36375-1-philmd@linaro.org>
Date: Tue, 01 Apr 2025 10:20:19 -0300
Message-ID: <87msd0f27g.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-3.97 / 50.00]; BAYES_HAM(-2.67)[98.53%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> First, the VMapple machine only works with the ARM 'host' CPU
> type, which isn't accepted for QTest:
>
>   $ qemu-system-aarch64 -M vmapple -accel qtest
>   qemu-system-aarch64: The 'host' CPU type can only be used with KVM or H=
VF
>
> Second, the QTest framework expects machines to be createable
> without specifying optional arguments, however the VMapple
> machine requires few of them:
>
>   $ qemu-system-aarch64 -M vmapple -accel qtest
>   qemu-system-aarch64: No firmware specified
>
>   $ qemu-system-aarch64 -M vmapple -accel qtest -bios /dev/null
>   qemu-system-aarch64: No AUX device. Please specify one as pflash drive.
>
> Restrict some code path to QTest so we can at least run check-qtest,
> otherwise we get:

Or add vmapple as an exception in qtest_cb_for_every_machine():

    for (i =3D 0; machines[i].name !=3D NULL; i++) {
        /* Ignore machines that cannot be used for qtests */
        if (!strncmp("xenfv", machines[i].name, 5) ||
            g_str_equal("xenpv", machines[i].name) ||
            g_str_equal("xenpvh", machines[i].name) ||
            g_str_equal("nitro-enclave", machines[i].name)) {
            continue;
        }
        ...
    }

Anyway:

Acked-by: Fabiano Rosas <farosas@suse.de>

