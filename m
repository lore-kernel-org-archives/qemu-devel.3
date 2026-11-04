Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AE6606A32D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T4G1Wcqb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOafi-0002hE-P5; Wed, 04 Nov 2026 08:04:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian.langvann@gmail.com>)
 id 1xOZ3d-0000B6-OL
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 06:21:33 -0500
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stian.langvann@gmail.com>)
 id 1xOZ3b-0003fL-LM
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 06:21:33 -0500
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-93cb60c9315so11015785a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 03:21:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793791290; cv=none;
 d=google.com; s=arc-20260327;
 b=TTXN4xFFXPfo0TBLd5JLeq8RN+E9/4/UtPt/1nj00R4dOzGc2jNj65Uwnbu2O27/+3
 HO8oQIxGXX98D3+eI0bwxop/qhR+QGF9jcHZ3I2SLSamr8qFHlrTSTYdqRssoNjd1syn
 a2A2arTfs0x/iqi8oe9nfHfJPy3uw9PgyxyEee8KGwW2ucx9xM8ZXIyhrwVi6zqS7jAb
 YsgCl0UwRiQzfrkc63PFrJcY0SdO+KaPHkwO9MnypS0Nx72e6jPUQahBq5Z3b5j8/7bq
 1dfhkt98oNESau6U8yLoQy883kXVLrSfHCpFcnHwHcU6MJKQ16DUMe6XOs/b7tR1MCEe
 CEVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=trU0gLny7J9mx2GU/Jz05fcnMwOdE7ZGnjag57Wi43M=;
 fh=8U5cq/rGBjmUIFIhdLtrLtob800lbuLRXRyE9VUG/pA=;
 b=Dhxqy86tOLdZbf11TCuHfhcXlHMuGyrRU6oK2An6Z4Pxj6ij3KoylaPD1fyU4ZhXxD
 Ay5wm23avS32PFgUb/uIehnekgoocP/rr39omvQicLu97oLX/rmHbiNOs8EKheoJ9dUD
 Dd8j70fW93zh/AZC07lvcjXWM3v3ItwomP/7BMKUXJ4nOjCAjRQX/ZIaJznNA82sv2jb
 zonhb+JBYFVrQkuSR+fss5vKUEHV8cN5EctrKxYY14bIQcp4mXxRiuk7MbS5ktizaalG
 p9Wj0vL1BSh0IMQ++eNHh7tCsFweriybNMAWqdXTFTbC+xFG8y71U7JTU4gPfu7tl4mi
 ls9w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793791290; x=1794396090; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=trU0gLny7J9mx2GU/Jz05fcnMwOdE7ZGnjag57Wi43M=;
 b=T4G1WcqbVLCZ6o8Npe8mOTeAjC/w3dzPYqGZU/l2PhcSrgNMqR+ai+5bjgK3QtSk8C
 NoxU/KhwPx4QB1synHCtL2kDqd5n0leyr50FAFDTjXnwWH8pWz6XX8LNjVOO99iekYsE
 5ADDGvAn0jBkXVn5c91mGX7uvsx7/wpVq3T4VANbsvcZQUPLgO2KFpX7MUTT8c+0pE+J
 MZTipgxFXt3nZ/BaBYh1/aHrCqUANbJLC2pddctZXSE0CG2tTpqO+UM1HxDqhYcXvwb3
 h/kf+EPurqI2NHhtCjOC1wXDLJR2g911XwJu5FAZUW1E7hvInhztjwTN/bBk+Le3dBdz
 3exw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793791290; x=1794396090;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=trU0gLny7J9mx2GU/Jz05fcnMwOdE7ZGnjag57Wi43M=;
 b=wwm07B2ukdGcyiH/43SVpPLlFMBQCpz87Zy9OgF8qA50paVWzY1VJF3uGTg5EZO0rJ
 amTxeoMKQ/GmuR0BT+tzOVSaPXBDX6PsjVwbsHGB8DjcMY4w7RkfPrl1DHHAUx1kF1T2
 kap42UfRldACveyJ/1THJi2woiAAoIHH/hYzUzGY3dlUQz6R9XtO2GIidY0RdQ067Qfm
 gmDIo8Z75L2qj8CYd5jZuKvl4meyU6Shy034B75qU19nTmB/mBRqKiDEXgO9A8YtYKim
 5D5Bxm6TSFYhbicbS1Xejrr49RDYGJT9udcWZp0JbtFQ0JoXI7Ageog57JHryjVdalGK
 RXWA==
X-Gm-Message-State: APuU4Z86to2dEox4UWZyU7IRTg1GTdGRIVlUWLOf6gS9uOprik6bZ+ql
 59ZrYQOTTrmb4QgD3qO5WmqXI2DZbY/5+xINF8rPfNN+qSCIi5Pa4fONnofG+gPnS++SAI136ta
 gbYR7bU+CZkA2A4ENSEd5eQl6zA0THRRkMyQE8qI=
X-Gm-Gg: AYBFou19rGwEi9XiEnWk4gRdVBT+evnHISO4mo41XsqvDi1SrN5lf7hgOuPGyeORlrU
 ljlB7FmgigI/KQgqKBwKDsQC5wRPBRYyrNcizHzgpNkfruozjRFFVObiRMSxGPW2SwgoAFTv/r6
 9S+/g1cJKdn5XV/eKgrSQp3Aq21sVL5xizW0Redlqw1UOadpCktSwhrrCYbGV/C7ghLxtbrtJ/1
 GTm/dA9QfO+x+9NRCsZKHux8C4rRZt4OFUhRytQGOD7xaJHe2STc8+hDwk65NRMWARK5EKMxXPJ
 yZdSy3b5/RuUy/pqsLprpvnwnWj91pzIsKj+Y6ZiqoMkpGBx5cuBpHkOvX/GQikq9NltOovGd9v
 vMWnUrCOM5MprHVDuFW6al385GpnCa0HPyhh5MjKavPiApwbBQQYlDgvjbxpRxjPQ1Q==
X-Received: by 2002:a05:620a:72d2:20b0:945:db0d:9cc7 with SMTP id
 af79cd13be357-945db0d9e7amr91847385a.0.1793791289975; Wed, 04 Nov 2026
 03:21:29 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Stian Langvann <stian.langvann@gmail.com>
Date: Wed, 4 Nov 2026 12:21:18 +0100
X-Gm-Features: AclHuK9ObtxLA7vNOaTfxFkbqUdzAvcxE0-zGN7n2dxTJchbkLmKqCS1I_kZFHc
Message-ID: <CADm+htGRv+NLDnP-CPQmeJqZU2RkyWPoAGR1Dk8kghhFVUVOew@mail.gmail.com>
Subject: scsi-block migrate-pr: destination loses its own multipath
 registrations when the guest holds a reservation
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, fam@euphon.net
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=stian.langvann@gmail.com; helo=mail-qk1-x735.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 04 Nov 2026 08:04:55 -0500
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi, the below has been written by Opus on request from me.
After dealing with issues when trying to live migrate a VM that has a
windows failover cluster (wsfc) with active roles on it, i encountered
what seems to be a bug. I couldn't decipher it myself, so I had to make
use of Opus to help me figure it out, and to give me a work-around
Opus wrote me a pre-hook script that works as a workaround for this
bug, but it is by no means perfect, and we're missing several
milliseconds, and get a bunch of reservation conflicts before the
script can repair after a migration has happened.

The below is a suggestion by opus as a fix to this issue.

I myself have little to no experience in C, and i hope the below
can help highlight the issue i'm seeing, to confirm wether or not
it is a fixable bug or not.

I am sorry if I'm doing this mailing list wrong.

Opus:


Live migration of SCSI persistent reservations loses registrations on
the destination when the LUN is a dm-multipath device and the guest
holds a reservation. The reservation itself transfers correctly, but
every local initiator port except one ends up unregistered, and the
guest's writes dispatched down the paths of those initiators return
RESERVATION CONFLICT for as long as it runs on that host.

The fix looks like removing a guard that is already in the tree. Details
below.


The mechanism
-------------

scsi_generic_pr_state_preempt() in hw/scsi/scsi-generic.c registers the
guest's key and then self-preempts, with that same key in both the
RESERVATION KEY and SERVICE ACTION RESERVATION KEY fields.

That pair is safe for a single I_T nexus, but libmpathpersist treats the
two service actions asymmetrically. REGISTER goes through
mpath_prout_reg(), which sends it on every local initiator port.
PREEMPT goes through mpath_prout_common(), which sends it down a single
path. SPC then removes every registration holding the preempted key
except that of the issuing I_T nexus, so the PREEMPT deletes the
registrations the REGISTER created on the other initiator ports
microseconds earlier.

The destination is left registered on one initiator while device-mapper
keeps every path in the active path group, so roughly half the guest's
writes conflict.


Evidence
--------

HPE 3PAR over FC, two initiator ports per host (SCSI hosts 9 and 10),
dm-multipath with "reservation_key file" and "all_tg_pt yes",
qemu-pr-helper linked against libmpathpersist. Guest is a two-node
Windows Server failover cluster holding a shared disk with reservation
type 0x05 (Write Exclusive, Registrants Only). LUNs attached as:

  -object pr-manager-helper,id=prhelper0,path=/run/pr-helper0.sock
  -blockdev node-name=cau0,driver=raw,cache.direct=on,\
    file.driver=host_device,file.filename=/dev/mapper/<map>,\
    file.pr-manager=prhelper0

ftrace on the destination during one live migration, filtered to PR
IN/OUT on the shared LUN. Timestamps in seconds, last column is the
first three CDB bytes:

  361165.665620  host9   lun6  5f 00 00   PR OUT, REGISTER
  361165.665666  host10  lun6  5f 00 00   PR OUT, REGISTER
  361165.693479  host9   lun6  5f 04 05   PR OUT, PREEMPT, type 0x05

The two REGISTERs are libmpathpersist fanning out across the local
initiators. The PREEMPT goes out on host9 only, and host10's
registration goes away with it:

  before       PR generation=0xc27, 2 registered reservation keys follow:
                 0x65e98960001734d
                 0x65e98960001734d

  after        PR generation=0xc2c, 1 registered reservation key follows:
                 0x65e98960001734d

The guest resumes and dmesg on the destination fills with "reservation
conflict", on the paths belonging to host10 and host9 in a roughly even
split, matching the path selector alternating between the two
initiators. Reissuing REGISTER AND IGNORE EXISTING KEY with the same key
through mpathpersist restores the second registration and the conflicts
stop immediately, with no other change.


Affected versions
-----------------

  v11.0.0                 no re-registration after PREEMPT at all
  v11.1.0                 re-registers, but only when resv_type == 0
  master (9dbf31c5be13)   same guard, now with REGISTER AND IGNORE

Every version that implements PR migration is affected whenever the
guest actually holds a reservation.


Why the existing re-registration does not cover this
----------------------------------------------------

b9a3b329d09d ("scsi: register again after PREEMPT without reservation")
added the re-registration because the Linux LIO target removes the
calling nexus' own registration when preempting without a reservation.
That is specific to resv_type == 0, so the guard made sense for it.

The multipath case is not a target quirk and does not depend on
resv_type. It is plain SPC behaviour applied to a REGISTER that
libmpathpersist multiplied across initiator ports and a PREEMPT that it
did not, so it happens on any spec-compliant target for any reservation
type. A guest that holds a reservation, which is the case PR migration
exists to serve, always takes the branch that skips the repair.

It is also independent of all_tg_pt. With "all_tg_pt yes"
libmpathpersist registers once per initiator port, so one registration
is lost on a two-HBA host; with it off it registers on every path, so
the PREEMPT destroys correspondingly more. The ATC_C masking in
scsi_handle_persistent_reserve_in_reply() does not help either, since it
governs what the guest may ask for rather than what libmpathpersist does
on the host below QEMU.

The same pattern came up on this list in February 2026 during the
<linux/pr.h> discussion, from the multipath side: "Preempt the
reservation to move it to an active path, which wipes the registrations
off all the other paths. Then reregister all the active paths again."

2d38eb7c741e ("scsi: clean up persistent reservation state after
migration") handles the mirror image of this on the source host, where
multipathd keeps re-registering a key the destination has preempted
away. The destination-side loss described here looks like the remaining
gap.


Suggested fix
-------------

Make the re-registration unconditional. REGISTER AND IGNORE EXISTING KEY
removes nothing and is idempotent, so running it when the registration
survived costs one PR OUT.

--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@
     if (!scsi_generic_pr_preempt(s, key, resv_type, errp)) {
         return false;
     }

     /*
-     * Some SCSI targets, like the Linux LIO target, remove our
-     * registration when preempting without a reservation (resv_type is 0).
-     * Try to register again but ignore the error since a RESERVATION
-     * CONFLICT is expected if our registration remained in place.
+     * Register again after PREEMPT. Two situations require it:
+     *
+     * 1. Some SCSI targets, like the Linux LIO target, remove our
+     *    registration when preempting without a reservation (resv_type
+     *    is 0).
+     *
+     * 2. On a multipath device libmpathpersist sends REGISTER on every
+     *    local initiator port but sends PREEMPT down a single path.
+     *    PREEMPT removes every registration holding the preempted key
+     *    except that of the issuing I_T nexus, so the registrations
+     *    just made on the other initiator ports are removed again. This
+     *    happens for every reservation type, not only when resv_type is
+     *    0.
+     *
+     * REGISTER AND IGNORE EXISTING KEY removes nothing, so this is safe
+     * when the registration survived. The error is ignored for that
+     * case.
      */
-    if (resv_type == 0) {
-        scsi_generic_pr_register_ignore(s, key, NULL);
-    }
+    scsi_generic_pr_register_ignore(s, key, NULL);
     return true;
 }

Fixing it inside post_load matters beyond tidiness: post_load runs
before the guest is resumed on the destination, so an unconditional
re-registration closes the hole with no exposure at all. I am currently
working around it with a hookscript that watches for the signature and
reissues REGISTER AND IGNORE EXISTING KEY, which lands 30-130 ms after
the PREEMPT across repeated migrations. That keeps the failover cluster
healthy, but the guest is running throughout that window and its writes
on the affected paths do conflict. Only QEMU can do this at a point
where no guest I/O is in flight.


Thanks,
Stian Langvann

