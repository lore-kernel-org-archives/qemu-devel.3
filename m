Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD61E606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AvprvY+i;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=QuT05AVN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7Fm-0007In-EI; Wed, 28 Oct 2026 13:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7FL-0006jh-2F
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7FI-0003lj-7z
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ub1/ZiB+AumWre8uUymZ4jiAhiJWfcMjivE7WqCf3fo=;
 b=AvprvY+iiV3KmM/CDeda325zVzx3lwdJ1iSlYFAuVLP/RUSZIEw/mA2FZUDNEDrFAhMt6a
 pcstaBtbQv+siYzVURS6Nfj3bnrJz3LoqsuIZT8QFNfWKcI61R8gUAWyqMH52wiZowDlpL
 Rqx+Qtx2+dy0RfmDTuNlYP+jES7LDUM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-nL61rrMvM7ecuCMOxvtobg-1; Wed, 28 Oct 2026 13:15:25 -0400
X-MC-Unique: nL61rrMvM7ecuCMOxvtobg-1
X-Mimecast-MFC-AGG-ID: nL61rrMvM7ecuCMOxvtobg_1793207724
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48dfa054f26so964949f8f.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207724; x=1793812524; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ub1/ZiB+AumWre8uUymZ4jiAhiJWfcMjivE7WqCf3fo=;
 b=QuT05AVNONmyiZVtWSA86AtLNeYPXklqlMbKbArXWMIqycxuNninid/8j7xiCJzB3R
 EVZ/FjmC/CLrJpO0bmt0xAlp0NEhJXZcCAMazPT4r/U17ZrKeOjOW2Cc6rxk8bJJ9mPK
 XXDQQ0iY/At06eyM4XDhCjVesa9XPkpbDg+EU9xnYa998wO/XbJCN95+lS9vzkPl1oGv
 bXmaKKq+AgIq7GSfGnQlQqFoGbrkQYXR0j7aT4UofERR2Icnq689iB39iJK4dN+hwqXn
 y8zJfbkt8CO9C5895UUpKtRqvg9/xXC6Ar7J69TgR9474T7+tOQ8kHHZtVAoUR7OuTKj
 +Aiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207724; x=1793812524;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ub1/ZiB+AumWre8uUymZ4jiAhiJWfcMjivE7WqCf3fo=;
 b=wrQzjt6BnG7q1vqkaPWUQjbk8/LG3GWb9opF7JtBO8UHAn8ftLYVwAHwBbMK3my/i+
 gy+BtzVphkWcd/0IySA3O5Fzl93FbYsEuKeWSq6u+D1TXqWMD6zpQjClRX/IRpzQwqjU
 8bW8FwtbnNMtARF3pCh1rQqf+35/bIBh8K18PX81f0a6a66jWj9mZlxh1KR2zdD4mFES
 U2Jxccn/5n2c0w3ZWoI4CLT5Io1Ish/adiaSksC3GDecqDVMcmQjHAo7eafndrR34Rfw
 AmG10/0EHI2Pz+2tGm9Cg4lMv7tPuJRxS+B07+ZvknEK/caVq2UKMs5xvBxtlANzhThW
 hLFg==
X-Gm-Message-State: AFq9FYKvh+z2IrzNd09be4cGOVfupmhdFhBtzeV0CcT5dTdFT7vFrxqe
 SH26dL4XgdzLfN78u/Mk4EUgrHwb1mTkV3tzpwEp32aDmHpuQNAC0hpqK+XpdlNHaJ5qU/xDzS5
 jXa79KACW+cWxxeWzW6Sal6CUtfqMeb6Gjtzef2a0bMeHVEQsYL9QNg1wPFLp4RjbS1t9uIIfH0
 sdaXjcvXh3e+5qHQBN9f7DBFs3bhz/GFsakA==
X-Gm-Gg: AYBFou0PKAhQ3YHJ1kiNtL/JIxVuAjiPC9GEKHNe4ybFhjublWQ9OZLAexqH4SRRbzt
 AAZ5R4l9a21ujz+gBIPCK1fVp4vhImyFier9RCx+N3d0Yl0E4+4YCghRKVVvWuxCZ2Kx19g/KMu
 YufMXiczDWEuSpsnmf5VHnu8+cL94L0S+L7aOQNChAh+/nP/Pa0MSvivwDjb/WbxLaXue4cMBFw
 J2yXovcxVm5Qgs3/+v5ztZKYVe+tvGwrDHwGB69l6wfc5CnzqgAjCoXadcxCzHnOcOMdWPETojk
 S0GfIfkqbR1wxbiJFw6x2i2coxtS4mdMs5rzVOmDaZEj25nTZXQsU3t5/G95jJgVPfO8Z6/KaJK
 qDNI/Vg6mg3PNqzW3JCtNqpqbELoRfzWkBy9LbKuj
X-Received: by 2002:a05:6000:1449:b0:48c:67d6:a87a with SMTP id
 ffacd0b85a97d-48e5d5a4385mr6936844f8f.32.1793207723786; 
 Wed, 28 Oct 2026 10:15:23 -0700 (PDT)
X-Received: by 2002:a05:6000:1449:b0:48c:67d6:a87a with SMTP id
 ffacd0b85a97d-48e5d5a4385mr6936736f8f.32.1793207723009; 
 Wed, 28 Oct 2026 10:15:23 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e542ed998sm14883593f8f.13.2026.10.28.10.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:15:21 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:15:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 31/78] tests/functional: cover a cpr-transfer target going
 away with vhost-vsock
Message-ID: <51759e2f7c0030b7d0aa1373e3b4d6d20fa4ea24.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

A cpr-transfer target takes the vsock device over in post_load().  Make
sure the source gets it back when the target goes away afterwards.
Three cases, in the first two the target is made to fail the load by
lacking a device the source has:

  - the target exits on the failure (default exit-on-error); the source
    is stopped beforehand, so it stays paused until we 'cont' it once
    the target is gone;

  - the target stays alive (exit-on-error=false) and the source resumes
    on its own (return-path capability);

  - the target loads the state while the source is stopped, stays
    paused and is quit normally; the source is resumed instead.

In all cases a host<->guest transfer must then work on the source.

The transfer helpers get a payload size parameter, since the plain
checks don't need the 512M of the stress cases, and the target start
code is moved into a helper shared with the existing cpr-transfer test.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261012-up-vsock-vhost-v5-v16-22-36c38bd15ffc@virtuozzo.com>
---
 .../functional/x86_64/test_vhost_vsock_cpr.py | 178 ++++++++++++++----
 1 file changed, 140 insertions(+), 38 deletions(-)

diff --git a/tests/functional/x86_64/test_vhost_vsock_cpr.py b/tests/functional/x86_64/test_vhost_vsock_cpr.py
index 035307fc82..3ac0a80c5e 100755
--- a/tests/functional/x86_64/test_vhost_vsock_cpr.py
+++ b/tests/functional/x86_64/test_vhost_vsock_cpr.py
@@ -24,6 +24,7 @@
 VSOCK_PORT = 5000
 
 TRANSFER_SIZE = 512 * 1024 * 1024    # file size for host<->guest transfer
+CHECK_SIZE = 16 * 1024 * 1024        # enough to just check that vsock works
 CPR_INTERVAL = 0.2                   # interval between CPR ops
 
 VHOST_SET_OWNER = 0xAF01      # _IO(VHOST_VIRTIO, 0x01)
@@ -71,11 +72,6 @@ def setUp(self):
                                'qcow2', '-b', self.ASSET_DISKIMAGE.fetch(),
                                '-F', 'qcow2', self.disk])
 
-        self.payload = self.scratch_file('payload')
-        with open(self.payload, 'wb') as f:
-            for _ in range(TRANSFER_SIZE >> 20):
-                f.write(os.urandom(1 << 20))
-
         self.sock_dir = self.socket_dir().name
         self.cpr_count = 0
 
@@ -121,12 +117,16 @@ def attempt():
                 return None
         return self.wait_for('QMP to come up', attempt)
 
-    def wait_migration(self, qmp):
-        def completed():
+    def wait_migration(self, qmp, expect='completed'):
+        def finished():
             status = qmp.cmd('query-migrate').get('status')
-            self.assertNotEqual(status, 'failed', 'migration failed')
-            return status == 'completed'
-        self.wait_for('migration completion', completed)
+            if status in ('completed', 'failed'):
+                if expect:
+                    self.assertEqual(status, expect,
+                                     'unexpected migration result')
+                return True
+            return False
+        self.wait_for('migration completion', finished)
 
     def wait_running(self, qmp_path):
         # Make sure we're dealing with the new QEMU after CPR
@@ -139,13 +139,37 @@ def wait_running(self, qmp_path):
             except QMP_GONE:
                 pass
 
-    def boot(self):
+    def boot(self, *extra_args):
         self.guest = self.vm
-        self.qmp_path = self.prepare_vm(self.guest, 'source')
+        self.qmp_path = self.prepare_vm(self.guest, 'source', *extra_args)
         self.guest.launch()
         self.wait_for_console_pattern('login:')
         exec_command_and_wait_for_pattern(self, 'root', 'root@localhost:~#')
 
+    def start_target(self, name, main_incoming=None):
+        """
+        Start a cpr-transfer target listening on the CPR channel.  Return
+        the VM, its QMP socket path and the channels for 'migrate'.
+        """
+        mig_sock = os.path.join(self.sock_dir, f'{name}-mig.sock')
+        cpr_sock = os.path.join(self.sock_dir, f'{name}-cpr.sock')
+        channels = [
+            {'channel-type': 'main',
+             'addr': {'transport': 'socket', 'type': 'unix',
+                      'path': mig_sock}},
+            {'channel-type': 'cpr',
+             'addr': {'transport': 'socket', 'type': 'unix',
+                      'path': cpr_sock}}]
+
+        target = self.get_vm(name=name)
+        qmp_path = self.prepare_vm(
+            target, name, '-incoming', main_incoming or f'unix:{mig_sock}',
+            '-incoming', 'cpr,addr.transport=socket,addr.type=unix,'
+                         f'addr.path={cpr_sock}')
+        target.launch()
+        self.wait_for('the CPR socket', lambda: os.path.exists(cpr_sock))
+        return target, qmp_path, channels
+
     def transfer(self, guest_cmd, host_cmd, cpr):
         """
         Run a socat transfer between the guest and the host, and keep
@@ -160,21 +184,26 @@ def transfer(self, guest_cmd, host_cmd, cpr):
         exec_command_and_wait_for_pattern(self, 'wait %1; echo RC_$?',
                                           'RC_0', vm=self.guest)
 
-    def transfer_both_ways(self, cpr):
+    def transfer_both_ways(self, cpr, size=TRANSFER_SIZE):
         """
-        Send the payload to a file on the guest's disk, get it back into
-        another file on the host, then compare.
+        Send a random payload to a file on the guest's disk, get it back
+        into another file on the host, then compare.
         """
+        payload = self.scratch_file('payload')
+        with open(payload, 'wb') as f:
+            for _ in range(size >> 20):
+                f.write(os.urandom(1 << 20))
+
         echo = self.scratch_file('echo')
         connect = f'VSOCK-CONNECT:{GUEST_CID}:{VSOCK_PORT},retry=10'
 
         self.transfer(f'socat -u VSOCK-LISTEN:{VSOCK_PORT} CREATE:/root/data',
-                      ['socat', '-u', f'FILE:{self.payload}', connect], cpr)
+                      ['socat', '-u', f'FILE:{payload}', connect], cpr)
         self.transfer(f'socat -u FILE:/root/data VSOCK-LISTEN:{VSOCK_PORT}',
                       ['socat', '-u', connect, f'CREATE:{echo}'], cpr)
 
         self.log.info('%d CPR migrations performed', self.cpr_count)
-        self.assertTrue(filecmp.cmp(self.payload, echo, shallow=False),
+        self.assertTrue(filecmp.cmp(payload, echo, shallow=False),
                         'the data came back different')
 
     def test_cpr_transfer(self):
@@ -184,29 +213,11 @@ def test_cpr_transfer(self):
         it and shutting down the source
         """
         def cpr():
-            n = self.cpr_count
-            mig_sock = os.path.join(self.sock_dir, f'mig{n}.sock')
-            cpr_sock = os.path.join(self.sock_dir, f'cpr{n}.sock')
-            target = self.get_vm(name=f'target{n}')
-            target_qmp_path = self.prepare_vm(
-                target, f'target{n}',
-                '-incoming', f'unix:{mig_sock}',
-                '-incoming', 'cpr,addr.transport=socket,addr.type=unix,'
-                             f'addr.path={cpr_sock}')
-
-            # The target listens on the CPR channel: wait for it to be there
-            target.launch()
-            self.wait_for('the CPR socket', lambda: os.path.exists(cpr_sock))
-
+            target, target_qmp_path, channels = self.start_target(
+                f'target{self.cpr_count}')
             with self.qmp_connect(self.qmp_path) as qmp:
                 qmp.cmd('migrate-set-parameters', mode='cpr-transfer')
-                qmp.cmd('migrate', channels=[
-                    {'channel-type': 'main',
-                     'addr': {'transport': 'socket', 'type': 'unix',
-                              'path': mig_sock}},
-                    {'channel-type': 'cpr',
-                     'addr': {'transport': 'socket', 'type': 'unix',
-                              'path': cpr_sock}}])
+                qmp.cmd('migrate', channels=channels)
                 self.wait_migration(qmp)
             self.wait_running(target_qmp_path)
 
@@ -217,6 +228,97 @@ def cpr():
         self.boot()
         self.transfer_both_ways(cpr)
 
+    def test_cpr_transfer_dead_target(self):
+        """
+        A cpr-transfer target which exits on a load error after having
+        taken the vsock device over must release it on exit, so that the
+        source can be resumed afterwards.  The target lacks a device the
+        source has.  The source is stopped beforehand, so it stays paused
+        on failure until we 'cont' it.
+        """
+        self.boot('-device', 'virtio-rng-pci')
+        target, _, channels = self.start_target('target')
+
+        with self.qmp_connect(self.qmp_path) as qmp:
+            qmp.cmd('stop')
+            qmp.cmd('migrate-set-parameters', mode='cpr-transfer')
+            qmp.cmd('migrate', channels=channels)
+            self.wait_migration(qmp, expect=None)
+            self.wait_for('the target to exit',
+                          lambda: not target.is_running())
+            self.assertEqual(target.exitcode(), 1,
+                             'the target did not exit on the load error')
+            qmp.cmd('cont')
+
+        self.wait_running(self.qmp_path)
+        self.transfer_both_ways(lambda: None, size=CHECK_SIZE)
+
+    def test_cpr_transfer_target_quit(self):
+        """
+        A cpr-transfer target which has loaded the state but hasn't been
+        started yet may quit normally, and the source resume instead.
+        The target doesn't unrealize its devices on quit, so it must
+        release the vsock device on exit.
+        """
+        self.boot()
+        target, target_qmp_path, channels = self.start_target(
+            'target', main_incoming='defer')
+
+        with self.qmp_connect(self.qmp_path) as qmp:
+            qmp.cmd('stop')
+            qmp.cmd('migrate-set-parameters', mode='cpr-transfer')
+            qmp.cmd('migrate', channels=channels)
+
+            target_qmp = self.qmp_connect(target_qmp_path)
+            target_qmp.cmd('migrate-incoming', channels=channels[:1])
+            self.wait_migration(qmp)
+            self.wait_migration(target_qmp)
+            self.assertEqual(target_qmp.cmd('query-status')['status'],
+                             'paused')
+            try:
+                target_qmp.cmd('quit')
+                target_qmp.close()
+            except QMP_GONE:
+                pass
+
+            self.wait_for('the target to quit',
+                          lambda: not target.is_running())
+            self.assertEqual(target.exitcode(), 0, 'the target did not quit')
+            qmp.cmd('cont')
+
+        self.wait_running(self.qmp_path)
+        self.transfer_both_ways(lambda: None, size=CHECK_SIZE)
+
+    def test_cpr_transfer_failed_target(self):
+        """
+        A cpr-transfer target which fails to load the state after having
+        taken the vsock device over must give it back to the source.
+        The target lacks a device the source has, stays alive on failure
+        (exit-on-error=false), and the source resumes on its own
+        (return-path).  Then vsock must still work on the source.
+        """
+        self.boot('-device', 'virtio-rng-pci')
+        target, target_qmp_path, channels = self.start_target(
+            'target', main_incoming='defer')
+
+        with self.qmp_connect(self.qmp_path) as qmp:
+            qmp.cmd('migrate-set-parameters', mode='cpr-transfer')
+            qmp.cmd('migrate-set-capabilities', capabilities=[
+                {'capability': 'return-path', 'state': True}])
+            qmp.cmd('migrate', channels=channels)
+
+            # The target opens its monitor once it has read the CPR state
+            with self.qmp_connect(target_qmp_path) as target_qmp:
+                target_qmp.cmd('migrate-incoming', channels=channels[:1],
+                               **{'exit-on-error': False})
+                self.wait_migration(qmp, expect='failed')
+                self.wait_migration(target_qmp, expect='failed')
+
+        # The source resumes by itself, and vsock must work on it
+        self.wait_running(self.qmp_path)
+        self.transfer_both_ways(lambda: None, size=CHECK_SIZE)
+        target.shutdown()
+
     def test_cpr_exec(self):
         """
         Perform consecutive cpr-exec migration during vsock file transfer,
-- 
MST


