Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FB6C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 12:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPgqn-0006mN-5g; Thu, 12 Jun 2025 08:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1uPgqg-0006k3-LA
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 08:16:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1uPgqX-0005DP-49
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 08:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749730547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=irqJjQAm7p9GnogHaBTXqhTKkdOtCh+7sVtjeQGEIn8=;
 b=Vi/wR/k78w+NGJCc4VrJH6p76jS2w/zUMRzeC1p621KyXdET7wkx12UGs/44Rdtuw4zQuU
 qn7WoSR7qdwLWob7etwANklRGfetChBp7rOTBM8Yy9EsM659v5yO03dF8db2dOoWJJVZL3
 xQRhyYH34t5Hsh6L39ASyeRVwfnsrv8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-HMgkTt-1MwODrQ-WjPC7vQ-1; Thu,
 12 Jun 2025 08:15:44 -0400
X-MC-Unique: HMgkTt-1MwODrQ-WjPC7vQ-1
X-Mimecast-MFC-AGG-ID: HMgkTt-1MwODrQ-WjPC7vQ_1749730543
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E5DE19560AD; Thu, 12 Jun 2025 12:15:43 +0000 (UTC)
Received: from localhost (unknown [10.42.28.15])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7F4D719560A3; Thu, 12 Jun 2025 12:15:42 +0000 (UTC)
Date: Thu, 12 Jun 2025 13:15:41 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: guestfs@lists.libguestfs.org
Cc: qemu-devel@nongnu.org
Subject: ANNOUNCE: libguestfs 1.56 & virt-v2v 2.8 releases
Message-ID: <20250612121541.GA14636@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

I'm pleased to announce the stable releases of libguestfs (1.56) and
virt-v2v (2.8).  Libguestfs is a library for reading and writing
virtual machines and disk images.  Virt-v2v is program for converting
virtual machines from foreign hypervisors to run on qemu/KVM.

These were last released over a year ago.  There are some major new
features and many fixes, especially in virt-v2v.  Thanks to the many
people who contributed to these.  Their names and the new features are
covered in the release notes below.

Please note this version of libguestfs proposes to deprecate GObject
(ie. Javascript) bindings, with their eventual removal scheduled for 1.58.

Downloads:

https://download.libguestfs.org/1.56-stable/
https://download.libguestfs.org/virt-v2v/2.8-stable/

Fedora packages are available in Fedora 41, 42 testing; and Fedora
Rawhide.  These versions will also be available in RHEL 10.1 later in
the year.

Release notes are below or online at:

https://libguestfs.org/guestfs-release-notes-1.56.1.html
https://libguestfs.org/virt-v2v-release-notes-2.8.1.html


RELEASE NOTES FOR LIBGUESTFS 1.56
       These are the release notes for libguestfs stable release 1.56.  This
       describes the major changes since 1.54.

       Libguestfs 1.56.0 was released on 11th June 2025.

   Inspection
       Add support for Windows 2025 (thanks Ming Xie).

       Add support for TencentOS (Denise Cheng).

       Inspection of Ubuntu 22+ guests that use a split /usr configuration now
       works properly (thanks Jaroslav Spanko, Daniel Berrange).

       Inspecting guests that have duplicated root mountpoints now works.

       Inspection of SUSE Linux guests using btrfs snapshots now ignores
       snapshots that mirror content in the root filesystem (thanks Ming Xie).

       Inspection of SUSE Linux >= 15 now returns the correct osinfo short name
       (eg. "sle15") (thanks Ming Xie).

   API
       New "command_out" and "sh_out" APIs which allow you to capture output
       from guest commands that generate more output than the protocol limit
       allows.

       New "btrfs_scrub_full" API which runs a full Btrfs scrub, synchronously.
       It works more like fsck for other filesystems.

       The "fstrim" API has been modified to work around several issues in
       upstream and RHEL 9 kernels related to XFS support (Eric Sandeen, Dave
       Chinner).

       The existing "e2fsck" API has a new "FORCENO" option enabling use of the
       command line -n flag.

   Language bindings
       Previously "-L../lib/.libs" got embedded in the distributed OCaml
       bindings.  This has been fixed.

       GObject bindings have been deprecated and will be removed in
       libguestfs 1.58.

   Build changes
       json-c is now required.  This replaces Jansson which was previously used
       for parsing JSON input files.

       OCaml ≥ 4.08 is now required.

       OCaml oUnit is no longer used.

       We now assume that "__attribute__((cleanup))" always works.  This
       requires gcc or Clang.

       Fix compatibility with file(1) ≥ 5.46.

       Fix compatibility with Fedora ≥ 42 which merges /usr/sbin into /usr/bin.

       Fix compatibility with latest Rust compiler (Jacob Reger).

       lex(1), yacc(1) and libmagic (part of file(1)) have not been required by
       libguestfs for a long time, but were still checked by the ./configure
       script.  This has been fixed, they are no longer build dependencies
       (thanks Mohamed Akram).

       When using "./configure --disable-daemon" we no longer require augeas
       and hivex (thanks Mohamed Akram).

       "zfs-fuse" support has been dropped.  The project is unmaintained
       upstream (thanks Paul Bolle, Gwyn Ciesla, Timothée Ravier).

       Fix compatibility with GNU gettext 0.25.

   Internals
       The tests were modified to use a set of common functions and remove use
       of the weird $TEST_FUNCTIONS macro, similar to how we do it in nbdkit.

       Fix dhcpcd failing on systemd-resolved stub (Thomas Wouters).

       Add support for dhcpcd and sfdisk on Debian (Daniel Gomez).

       Print the kernel utsname in debug output.

       The legacy "pvs_full", "vgs_full" and "lvs_full" APIs were completely
       rewritten in OCaml.

       Some deprecated autoconf macros are no longer used.

       We no longer emit a false warning about "BLKDISCARD" when creating a
       block device.

       Some internal OCaml List and String functions that we used have been
       replaced by ones from the OCaml stdlib, reducing code maintenance.

       If qemu-img(1) commands fail during snapshot creation, make sure we
       capture and print stderr from the qemu command (Cole Robinson).

   Bugs fixed
       https://issues.redhat.com/browse/RHEL-62935
           [rhel 9.6] windows version of win2025 guest shows incorrect during
           v2v conversion

       https://issues.redhat.com/browse/RHEL-80159
           Add new APIs to allow command output > 4MB

       https://issues.redhat.com/browse/RHEL-87493
           The Ubuntu 22.04 VM from VMware fails with Inspection field ‘i_arch’
           was ‘unknown’ [rhel-9.7]

       https://issues.redhat.com/browse/RHEL-88450
           fstrim on a RHEL 7.2-created XFS filesystem does not trim as much as
           expected

       https://issues.redhat.com/browse/RHEL-88508
           Run fstrim twice to work around incorrect fstrim behaviour in RHEL 9
           kernel

       https://issues.redhat.com/browse/RHEL-90168
           virt-v2v fails with mount exited with status 32: mount: /sysroot:
           /dev/sda2 already mounted on /sysroot. [rhel-9.7]

       https://issues.redhat.com/browse/RHEL-92239
           Lost error when opening wrong format of image readonly [rhel-10.1]

       https://issues.redhat.com/browse/RHEL-93109
           RFE: Investigate & do something useful with btrfsvol:...snapshots in
           SUSE Linux guests

       https://issues.redhat.com/browse/RHEL-95791
           libguestfs generates the wrong osinfo for SLES 15 guests [rhel-9.6]

       https://github.com/libguestfs/libguestfs/issues/155
           1.54.0: gdisk/test-expand-gpt.pl fails

       https://github.com/libguestfs/libguestfs/issues/162
           New test suite failure in c-api with file-5.46

       https://github.com/libguestfs/libguestfs/issues/167
           Weblate | erroneous source strings

       https://github.com/libguestfs/libguestfs/issues/182
           sed: RE error: illegal byte sequence in build

       https://github.com/libguestfs/libguestfs/issues/183
           bash-completion fails to install on macOS

       https://github.com/libguestfs/libguestfs/issues/184
           augeas, hivex and libmagic required even when daemon is disabled

       https://github.com/libguestfs/libguestfs/issues/191
           Failing to build ocaml/examples

SEE ALSO
       guestfs-examples(1), guestfs-faq(1), guestfs-performance(1),
       guestfs-recipes(1), guestfs-testing(1), guestfs(3), guestfish(1),
       http://libguestfs.org/

AUTHORS
       Cole Robinson
       Daniel Gomez
       Denise Cheng
       Ettore Atalan
       Jacob Reger
       Krascovict Petrov
       Léane GRASSER
       Richard W.M. Jones
       Ricky Tigg
       Thomas Wouters
       Yuri Chornoivan



RELEASE NOTES FOR VIRT-V2V 2.8
       These are the release notes for virt-v2v 2.8.  This describes the major
       changes since 2.6.

       Virt-v2v 2.8.0 was released on 11th June 2025.

   New features
       New virt-v2v-open(1) tool.  This can be used to open the virt-v2v source
       and run a user program on it.  For example virt-inspector(1) or
       guestfish(1) can be used to examine the source to discover what
       operating systems or files are present before conversion.

       Windows Server 2025 is supported (thanks Ming Xie).

       Two features have been added to enhance data integrity.  Firstly you can
       specify a "<checksum>" field for each input disk (when importing from
       libvirt).  Virt-v2v will verify the checksum of the actual disk matches
       the expected checksum.  Secondly virt-v2v in debug mode now computes the
       blkhash (a type of checksum) of the converted disk and prints it out,
       allowing you to compare the blkhash with the final output.

       The UEFI secureboot property is now modelled correctly, and (for outputs
       which support it) is reflected in the output metadata (thanks Daniel
       Berrange, Andrea Bolognani, Ming Xie).

       Parallel disk copies are now possible, using the --parallel=N option.
       The default behaviour is still to do serial copies.

       virt-v2v-in-place(1) has a new -O option.  This generates the same
       output as virt-v2v-inspector(1), allowing callers to combine both passes
       into one.

       Virtio-win driver selection has been made more robust.  It now selects
       the correct drivers to install in more cases, and avoids installing
       unnecessary debugging and SRIOV files.  Libosinfo is no longer used for
       this as the osinfo metadata used had grown out of date.  (Cole Robinson)

       We now check filesystem integrity (using tools like fsck(8)) before and
       after conversion, to ensure both that we fully understand the filesystem
       before conversion and that no corruption has happened during conversion.
       At the moment this is only implemented for Btrfs, ext4 and XFS.

   Features removed
       Handling of kmod-xenpv has been removed.  This only applied to RHEL 3
       and RHEL 4 guests being converted from very ancient versions of Xen
       (Cole Robinson).

       Some options that have been deprecated since 2018 and earlier were
       removed:

       --compressed
           Use -oo compressed instead.

       --no-trim
           This did nothing.

       --password-file
           Use --ip instead.

       --qemu-boot
           Use -oo qemu-boot instead.

       --vddk-*
           Use --io vddk-* instead.

       --vdsm-*
           Use --oo vdsm-* instead.

       --vmtype
           This did nothing.

       The options -o rhv-upload and -o rhv have been renamed to -o
       ovirt-upload and -o ovirt respectively, although aliases for the other
       names remain.

   Other fixes
       Update support page to cover RHEL 10 and Windows Server 2025.

       When importing from libvirt sources, trim whitespace from around the
       "<name>" element, rather than creating a guest name containing that
       whitespace.

       We no longer overwrite the EFI grub2 wrapper file
       (/boot/efi/EFI/<OS>/grub.cfg) on Fedora ≥ 34 and RHEL ≥ 9.0.

       When removing packages during conversion, use yum, apt, and similar
       tools so that dependencies are also removed (Cole Robinson).

       When some rpm commands run in the context of the guest produced more
       than 4MB of output, virt-v2v conversions would fail.  This has now been
       fixed (thanks Nijin Ashok).

       Virt-v2v is now compatible with guests that use dnf5.

       -i vmx mode now supports importing guests with SATA-emulated disks.

       Converting from a VMware snapshot is now possible, when using VDDK,
       using the io vddk-file=... options (thanks Martin Necas).

       Conversion failures when guest /etc/resolv.conf is immutable are common
       enough that we have now documented this problem in the manual (thanks
       Dan Clark).

       Debug information now contains much more readable information about
       guest mountpoints, similar to the output of virt-df(1).

       -o libvirt mode no longer generates its own osinfo short IDs.  Instead
       we use the osinfo short IDs from libguestfs inspection (Cole Robinson).

       Document how to activate Bitlocker for Windows 11 with vTPM (thanks Ming
       Xie).

   Build changes
       json-c is now required.  This replaces Jansson which was previously used
       for parsing JSON input files.

       libguestfs ≥ 1.56 is now required.

       OCaml ≥ 4.08 is now required.

       libnbd ≥ 1.14 is now required.

       nbdkit ≥ 1.28 is now required, although it is better to use more recent
       versions where possible.

       OCaml oUnit is no longer used.

       We now assume that "__attribute__((cleanup))" always works.  This
       requires gcc or Clang.

       The configure option --with-virt-v2v-nbdkit-python-plugin has been
       removed.  It was only needed for very old versions of nbdkit and Python.

       Tests should no longer break if ntfs-3g is not supported by libguestfs.

       Fix compatibility with GNU gettext 0.25.

   Internals
       The tests were modified to use a set of common functions and remove use
       of the weird $TEST_FUNCTIONS macro, similar to how we do it in nbdkit.

       The way we generate the phony virtio-win drivers (for testing) has been
       simplified.  Also there are new regression tests to ensure that virt-v2v
       installs the correct set of driver files.  (Cole Robinson).

       Phony Windows guests are now generated for several different versions of
       Windows, allowing more broad testing (Cole Robinson).

       Some deprecated autoconf macros are no longer used.

       nbdkit-cacheextents-filter(1) is no longer used, as it did not help
       performance now that we have switched to using nbdcopy(1) (thanks Martin
       Kletzander).

       With multi-disk guests, in some common cases we are now able to use a
       single nbdkit(1) instance to read or write all disks, instead of needing
       to run an nbdkit instance per disk, which can greatly reduce the number
       of external processes that virt-v2v will run.  The performance and
       results should not be different.  To take full advantage of this you
       have to use nbdkit ≥ 1.44.

       Several typos and spelling mistakes in the documentation were fixed
       (thanks Eric Blake).

       Duplicated code used to parse input (-i) and output (-o) options across
       the tools has been refactored in one place.

       Some internal OCaml List and String functions that we used have been
       replaced by ones from the OCaml stdlib, reducing code maintenance.

   Bugs fixed
       https://issues.redhat.com/browse/MTV-2256
           Document issues with upgrading Windows guests after conversion

       https://issues.redhat.com/browse/RHEL-32099
           Harden grub2-mkconfig to avoid overwriting
           /boot/efi/EFI/redhat/grub.cfg

       https://issues.redhat.com/browse/RHEL-39077
           v2v can't convert the guest if info "add_dracutmodules+="
           network-legacy " is added to network-legacy.conf [rhel-9.6]

       https://issues.redhat.com/browse/RHEL-58032
           v2v: add output file after virt-v2v-in-place conversion [rhel-9.6]

       https://issues.redhat.com/browse/RHEL-65009
           Can't find drivers from virtio-win for win2025 guests during v2v
           conversion [rhel 10.0]

       https://issues.redhat.com/browse/RHEL-65010
           Can't find drivers from virtio-win for win2025 guests during v2v
           conversion [rhel 9.6]

       https://issues.redhat.com/browse/RHEL-66197
           [MTV] migration failed with module "network-legacy" configured in
           RHEL 8 guests

       https://issues.redhat.com/browse/RHEL-67007
           [RFE] Add secureboot info in kubevirt output [rhel-9.7]

       https://issues.redhat.com/browse/RHEL-67836
           RFE: Get the uefi.secureBoot.enabled setting from VMware sources
           [rhel-9.6]

       https://issues.redhat.com/browse/RHEL-71522
           Migration Plan / vddk pod cannot remove open-vm-tools in case of
           dependencies [rhel-9.6]

       https://issues.redhat.com/browse/RHEL-77989
           CentOS 9 Migration from VMWare to Openshift Virt fails [rhel-9.6]

       https://issues.redhat.com/browse/RHEL-80080
           Converting a SUSE VM will fail if the kernel-source package is
           installed in the source VM

       https://issues.redhat.com/browse/RHEL-85508
           Improve checksumming and data consistency checks in virt-v2v,
           libnbd, nbdkit

       https://issues.redhat.com/browse/RHEL-85512
           Print blkhash of converted image in virt-v2v debugging output [9.7]

       https://issues.redhat.com/browse/RHEL-85514
           Print blkhash of converted image in virt-v2v debugging output [10.1]

       https://issues.redhat.com/browse/RHEL-86022
           There is no nbdcopy info in v2v debug log since virt-v2v version
           2.7.1-2 [rhel-9.7]

       https://issues.redhat.com/browse/RHEL-88543
           virt-v2v-inspector is failing on snapshots of running VMs [rhel-9.7]

       https://issues.redhat.com/browse/RHEL-88985
           Add possible roots to the virt-v2v-inspector output [rhel-9.7]

       https://issues.redhat.com/browse/RHEL-70840
           v2v can't convert win11-efi-secure guest with vtpm: "Activation of
           partially decrypted BITLK device is not supported" [rhel-9.6]

       https://github.com/libguestfs/virt-v2v/issues/79
           virt-v2v 2.7.4 error: libguestfs error: you must call
           guestfs_add_drive before guestfs_launch

       https://github.com/libguestfs/virt-v2v/issues/86
           Rename RHV to oVirt

SEE ALSO
       virt-v2v(1).

AUTHORS
       Authors of virt-v2v 2.8:

       Cole Robinson
       Krascovict Petrov
       Richard W.M. Jones
       Ricky Tigg
       Yuri Chornoivan



-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html


