Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12ED606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=0kaWqUDv;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=jM/oommN;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=PuraewIY;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=A9lSNoMD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTORR-0005Yg-Jz; Tue, 17 Nov 2026 14:02:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xTORM-0005Vs-HK
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:02:01 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xTORK-0003LX-27
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:02:00 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CC12C221BC;
 Tue, 17 Nov 2026 19:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794942109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+cTcbBfQVQYoz3X4MUG0pt5pb0Nok8xSug2RJ5v2izw=;
 b=0kaWqUDvmu4wy55tQOva7XtCVGAM3f7/0hc8Jeppai25dzoriQVdJbAZZ5LnfDPNBHIiuY
 EYMVr0tMDr8X676r5UGmzMKjCYADOMWy6D/ua+0H/4WVkiSDF+M3vfsMj2k2knWYOKyHC/
 ZNSm52ijBP2DWOsCAnf2xRh8EP6LLZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794942109;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+cTcbBfQVQYoz3X4MUG0pt5pb0Nok8xSug2RJ5v2izw=;
 b=jM/oommNuPLB/Fv4mHAL4yIYl5emvCihXkmk0HgpZ4iTfLaBcma/XH+TfH67XLAfZIoWKQ
 BqigUYMaZqhlw4Cg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PuraewIY;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=A9lSNoMD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794942108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+cTcbBfQVQYoz3X4MUG0pt5pb0Nok8xSug2RJ5v2izw=;
 b=PuraewIYLLv4wpMYex677QzfN7taNaVrdTtlCnQKoBRr6FGpEVcy5VlHf1dtsGv5qZi62U
 nwRy0b4CQspUewvdzBaFreqhVDn3dK1D7bfiX3Sq8EOnIF6p667LPIlfeNC53XwE80y/oc
 ZsK3HAgWoWAIBvOaV5js8tPo1vlECz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794942108;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+cTcbBfQVQYoz3X4MUG0pt5pb0Nok8xSug2RJ5v2izw=;
 b=A9lSNoMDtdHQEiOjCLPH/hdLs5DHI1dTNeckcsQUceichIiqFbiudy3EULqD/dfNVh2WNU
 yK2Yga7MH377uMDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 385461334C;
 Tue, 17 Nov 2026 19:01:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gS3YMJuk/Gp5WgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Nov 2026 19:01:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, maciej.szmigiero@oracle.com,
 peterx@redhat.com, mark.kanda@oracle.com, bchaney@akamai.com,
 pierrick.bouvier@oss.qualcomm.com, alex@shazbot.org, clg@redhat.com,
 yi.l.liu@intel.com, eric.auger@redhat.com, zhenzhong.duan@intel.com,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com
Subject: Re: [PATCH 00/21] migration/cpr: introduce cpr-luo mode to support
 KHO/LUO
In-Reply-To: <95d4d77e-7b30-463e-96a1-6add4495e451@oracle.com>
References: <20261012235727.398133-1-dongli.zhang@oracle.com>
 <95d4d77e-7b30-463e-96a1-6add4495e451@oracle.com>
Date: Tue, 17 Nov 2026 16:01:45 -0300
Message-ID: <875wxvs2na.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-13.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWELVE(0.00)[19]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MID_RHS_MATCH_FROM(0.00)[];
 REDIRECTOR_URL(0.00)[urldefense.com];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.51
X-Rspamd-Queue-Id: CC12C221BC
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Dongli Zhang <dongli.zhang@oracle.com> writes:

> I am rebasing the patchset on top of the most recent QEMU commit, especially
> "migration/cpr: support vhost-vsock devices".
>
> Meanwhile, any feedback on the proposal is appreciated.
>

Sorry for the delay, we're all swimming in slop these days. The only
feedback I have at the moment is that this feature needs tests. What's
your plan in this regard? Can this run with nested virtualization? Or
perhaps is there a way to mock the kernel interfaces and ensure QEMU
does the right thing even without them? We don't need much, but the code
definitely needs to be exercised somehow.

> So far, the main idea is to reuse as much code as possible from cpr-exec and
> cpr-transfer.
>
> 1. Introduce the new cpr-luo mode.
> 2. Use a UUID to identify a LUO session.
> 3. Introduce APIs to create, preserve, and retrieve sessions and fds.
> 4. As LUO uses the name, id, and token instead of an fd, create an independent
> VMStateDescription rather than reuse the one for cpr-exec and cpr-transfer.
> 5. Compute the token when transforming entries from the hash table into the list.
> 6. Preserve fds on the source. Follow the approach used in cpr-exec and
> cpr-transfer.
> 7. Retrieve fds on the target. Follow the approach used in cpr-exec and
> cpr-transfer. The tricky part is where to set the cpr incoming mode.
> 8. There is no need to modify save_fd() or load_fd(), as we only need to migrate
> the corresponding name and token, not the fds.
> 9. Handle corner-case errors.
> 10. Block VFIO.
>
> Thank you very much!
>
> Dongli Zhang
>
> On Mon, Oct 12, 2026 4:55:56PM -0700, Dongli Zhang wrote:
>> This series introduces cpr-luo, a CPR migration mode that uses the Linux Live
>> Update Orchestrator (LUO) and Kexec Handover (KHO) to support KVM host kernel
>> updates through kexec. On the outgoing side, QEMU saves CPR state in a memfd and
>> preserves
>> 
>> This series introduces cpr-luo, a CPR migration mode that uses the Linux
>> Live Update Orchestrator (LUO) and Kexec Handover (KHO) to support KVM host
>> kernel updates through kexec.
>> 
>> On the outgoing side, QEMU saves CPR state in a memfd and preserves that fd
>> together with the RAMBlock backing fds in LUO. KHO carries the preserved LUO
>> state into the new kernel. The incoming QEMU retrieves the CPR state and
>> RAMBlock backing fds from LUO after kexec.
>> 
>> The regular migration stream carries device vmstate.
>> 
>> Although VFIO is currently blocked, I have an offline implementation that
>> skips cpr-luo mode in cpr_is_incoming(), skips precopy, and carefully handles
>> monitor_fd_param() although I never use it, so that VFIO is always
>> reconstructed. It works with both iommufd and legacy for mlx5_vfio_pci by
>> saving the VFIO and vendor specific state in vmstate as well.
>> 
>> The result is that guest RAM remains available across a kexec-based host
>> kernel update without copying its contents through the migration stream.
>> 
>> Here is the main idea of the patchset:
>> 
>> 1. Introduce the new cpr-luo mode.
>> 2. Use a UUID to identify a LUO session.
>> 3. Introduce APIs to create, preserve, and retrieve sessions and fds.
>> 4. As LUO uses the name, id, and token instead of an fd, create an
>> independent VMStateDescription rather than reuse the one for cpr-exec and
>> cpr-transfer.
>> 5. Compute the token when transforming entries from the hash table into the
>> list.
>> 6. Preserve fds on the source. Follow the approach used in cpr-exec and
>> cpr-transfer.
>> 7. Retrieve fds on the target. Follow the approach used in cpr-exec and
>> cpr-transfer. The tricky part is where to set the cpr incoming mode.
>> 8. There is no need to modify save_fd() or load_fd(), as we only need to
>> migrate the corresponding name and token, not the fds.
>> 9. Handle corner-case errors.
>> 10. Block VFIO.
>> 
>> I may need to rebase the current patchset on top of the patches below,
>> from which I learned quite a lot in each iteration. While working on this
>> patchset, I identified some cleanup and code issues in cpr-exec and
>> cpr-transfer. I may send fixes for them separately.
>> 
>> [PATCH v16 00/22] migration/cpr: support vhost-vsock devices
>> https://urldefense.com/v3/__https://lore.kernel.org/all/20261012-up-vsock-vhost-
>> v5-v16-0-36c38bd15ffc@virtuozzo.com/__;!!ACWV5N9M2RV99hQ!N58C4d74-
>> zpeHeXtxKWUAIRgf18-Xzk7_V7p49rzvh29deg5g2oBeAn0R5b89vJzLBPv6rkzjTo-8F0Iy16Z0oRy$ <https://urldefense.com/v3/__https://lore.kernel.org/all/20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com/__;!!ACWV5N9M2RV99hQ!N58C4d74-zpeHeXtxKWUAIRgf18-Xzk7_V7p49rzvh29deg5g2oBeAn0R5b89vJzLBPv6rkzjTo-8F0Iy16Z0oRy$>
>> 
>> Example:
>> 
>> Add "kho=on liveupdate=on" to host kernel cmdline.
>> 
>> Create QEMU instance with memfd.
>> 
>> qemu-system-x86_64 \
>> -uuid 6f1b9f5a-6b92-4a5d-ae57-7a0ddabc1234 \
>> -machine q35,dump-guest-core=off,memory-backend=ram0,aux-ram-share=on \
>> -accel kvm -cpu host \
>> -name debug-threads=on \
>> -m 8G -smp 4 \
>> -object memory-backend-memfd,id=ram0,size=8G,share=on \
>> -device virtio-blk-pci,drive=drive0,id=virtblk0,num-queues=4 \
>> -drive file=boot.qcow2,if=none,id=drive0 \
>> -netdev user,id=net0,hostfwd=tcp::5028-:22 \
>> -device virtio-net-pci,netdev=net0 \
>> -vnc :8 -monitor stdio
>> 
>> Don't terminate QEMU process after cpr-luo migration.
>> 
>> (qemu) migrate_set_parameter mode cpr-luo
>> (qemu) migrate -d file:cpr-luo.state
>> (qemu) info status
>> VM status: paused (postmigrate)
>> 
>> Use kexec to reboot the KVM host.
>> 
>> host# kexec -s -l /boot/vmlinuz-$(uname -r) --initrd=/boot/initramfs-$(uname -r).img --reuse-cmdline
>> host# sync
>> host# kexec -e
>> 
>> Resume QEMU instance after kexec reboot.
>> 
>> qemu-system-x86_64 \
>> -uuid 6f1b9f5a-6b92-4a5d-ae57-7a0ddabc1234 \
>> -machine q35,dump-guest-core=off,memory-backend=ram0,aux-ram-share=on \
>> -accel kvm -cpu host \
>> -name debug-threads=on \
>> -m 8G -smp 4 \
>> -object memory-backend-memfd,id=ram0,size=8G,share=on \
>> -device virtio-blk-pci,drive=drive0,id=virtblk0,num-queues=4 \
>> -drive file=boot.qcow2,if=none,id=drive0 \
>> -netdev user,id=net0,hostfwd=tcp::5028-:22 \
>> -device virtio-net-pci,netdev=net0 \
>> -vnc :8 -monitor stdio \
>> -incoming cpr-luo:defer
>> 
>> (qemu) migrate_incoming file:cpr-luo.state
>> (qemu) info status
>> VM status: running
>> 
>> 
>> Dongli Zhang (21):
>>   qapi/migration: add cpr-luo migration mode
>>   migration/cpr: move CprFd definition to header file
>>   scripts/update-linux-headers: Add liveupdate.h
>>   linux-headers: import liveupdate UAPI header
>>   migration/cpr-luo: require a non-null machine UUID
>>   migration/cpr-luo: add LUO session management
>>   migration/cpr-luo: add LUO fd management helpers
>>   migration/cpr-luo: track LUO fds
>>   migration/cpr-luo: add LUO fd VMStateDescription
>>   migration/cpr-luo: add tokens for LUO fds
>>   migration/cpr: move QEMUFile fd helpers to common code
>>   migration/cpr-luo: add state fd helpers
>>   migration/cpr: add more arguments for cpr_walk_fd()
>>   migration/cpr-luo: add helpers to preserve and retrieve all LUO fds
>>   migration/cpr-luo: enable cpr-luo mode for source side preservation
>>   migration/cpr-luo: enable cpr-luo mode for target side retrieval
>>   migration/cpr-luo: abort session when migration fails
>>   system/physmem: add cpr-luo blocker
>>   monitor/qmp: close LUO session when resuming source QEMU
>>   vfio: block cpr-luo migration
>>   migration: cpr-luo documentation
>> 
>>  backends/hostmem-memfd.c         |   1 +
>>  backends/hostmem-shm.c           |   1 +
>>  docs/devel/migration/CPR.rst     |  64 +++++++
>>  hw/vfio/cpr-iommufd.c            |  17 +-
>>  hw/vfio/cpr-legacy.c             |   8 +
>>  include/hw/vfio/vfio-cpr.h       |   1 +
>>  include/migration/cpr.h          |  37 +++-
>>  include/system/iommufd.h         |   1 +
>>  include/system/system.h          |   2 +
>>  linux-headers/linux/liveupdate.h | 239 +++++++++++++++++++++++++
>>  migration/cpr-exec.c             |  32 +---
>>  migration/cpr-luo-stub.c         |  78 ++++++++
>>  migration/cpr-luo.c              | 328 ++++++++++++++++++++++++++++++++++
>>  migration/cpr.c                  | 126 +++++++++++--
>>  migration/meson.build            |   6 +
>>  migration/migration.c            |  12 +-
>>  migration/options.c              |   6 +
>>  migration/ram.c                  |   1 +
>>  monitor/qmp-cmds.c               |   7 +
>>  qapi/migration.json              |  11 +-
>>  scripts/update-linux-headers.sh  |   2 +-
>>  system/globals.c                 |   5 +
>>  system/physmem.c                 |   9 +-
>>  system/vl.c                      |   9 +
>>  24 files changed, 950 insertions(+), 53 deletions(-)
>> 
>> base-commit: 3377670ee96b5a68361016680a95b9013709d4b7
>> 
>> Thank you very much!
>> 
>> Dongli Zhang
>> 
>> 

