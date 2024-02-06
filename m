Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578F7C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 10:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXIw2-0006xT-R4; Tue, 06 Feb 2024 05:44:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rXIw1-0006w5-3D
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 05:44:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rXIvy-0003Ei-6m
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 05:44:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707216247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YmWZzs/rQnAiToVTHfV0BRlpDmEgrJ+WRDl06zUpskQ=;
 b=Ulj+Sm42QWuJ2RpMKKoeYQ7TG0fkFB0edZlNe311c4jrnIYpxxrTbLWBpLDaFyiKA5pwPg
 zWzZyi6td6e15Q0A+Js8b9/OmYZMh+hoOUM13gAuOb0vGxAPgiOuE9Th01gnCXmHP4mCRO
 af9BCvTOs843UddVAU8IkKyPiRaJ4+8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-lmA0JYzfOjWWlP7hKPxuSA-1; Tue, 06 Feb 2024 05:44:06 -0500
X-MC-Unique: lmA0JYzfOjWWlP7hKPxuSA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFF0D84AC61;
 Tue,  6 Feb 2024 10:44:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.195.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F40B492BF0;
 Tue,  6 Feb 2024 10:44:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 09/12] tests/vm: Set UseDNS=no in the sshd configuration
Date: Tue,  6 Feb 2024 11:43:44 +0100
Message-ID: <20240206104347.238825-10-thuth@redhat.com>
In-Reply-To: <20240206104347.238825-1-thuth@redhat.com>
References: <20240206104347.238825-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

make vm-build-freebsd sometimes fails with "Connection timed out during
banner exchange". The client strace shows:

    13:59:30 write(3, "SSH-2.0-OpenSSH_9.3\r\n", 21) = 21
    13:59:30 getpid()                       = 252655
    13:59:30 poll([{fd=3, events=POLLIN}], 1, 5000) = 1 ([{fd=3, revents=POLLIN}])
    13:59:32 read(3, "S", 1)                = 1
    13:59:32 poll([{fd=3, events=POLLIN}], 1, 3625) = 1 ([{fd=3, revents=POLLIN}])
    13:59:32 read(3, "S", 1)                = 1
    13:59:32 poll([{fd=3, events=POLLIN}], 1, 3625) = 1 ([{fd=3, revents=POLLIN}])
    13:59:32 read(3, "H", 1)                = 1

There is a 2s delay during connection, and ConnectTimeout is set to 1.
Raising it makes the issue go away, but we can do better. The server
truss shows:

    888: 27.811414714 socket(PF_INET,SOCK_DGRAM|SOCK_CLOEXEC,0) = 5 (0x5)
    888: 27.811765030 connect(5,{ AF_INET 10.0.2.3:53 },16) = 0 (0x0)
    888: 27.812166941 sendto(5,"\^Z/\^A\0\0\^A\0\0\0\0\0\0\^A2"...,39,0,NULL,0) = 39 (0x27)
    888: 29.363970743 poll({ 5/POLLRDNORM },1,5000) = 1 (0x1)

So the delay is due to a DNS query. Disable DNS queries in the server
config.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20240206002344.12372-2-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/vm/basevm.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 61725b8325..c0d62c0803 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -423,6 +423,8 @@ def console_ssh_init(self, prompt, user, pw):
     def console_sshd_config(self, prompt):
         self.console_wait(prompt)
         self.console_send("echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config\n")
+        self.console_wait(prompt)
+        self.console_send("echo 'UseDNS no' >> /etc/ssh/sshd_config\n")
         for var in self.envvars:
             self.console_wait(prompt)
             self.console_send("echo 'AcceptEnv %s' >> /etc/ssh/sshd_config\n" % var)
-- 
2.43.0


