Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4B6D6E2C9
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 07:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDf7d-0001xf-Vk; Wed, 20 Nov 2024 02:27:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDf7c-0001xF-Hv
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:27:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDf7b-000801-34
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:27:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732087649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3BTJbs566odTWWZcglLtcrZATiEXFnman86/RpjGHWI=;
 b=c41GnolH1SHEsLWFJnhsiRVkNiqGMZQWKxj5Frpf0Ia1DuDyqaizLxVPdtrIvm/kreiexE
 RDIMj2rUJkgP+a123tdYvTacbx+LteXnN/6SlKt4E2CnwlHw/1ODYnHmKvtPI8EgkGmw7V
 8V1yfY11e/L9JYKMl19ZbJcljw+yqYk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-rn7_e5_QNj6iuCjDH0Qf7A-1; Wed, 20 Nov 2024 02:27:27 -0500
X-MC-Unique: rn7_e5_QNj6iuCjDH0Qf7A-1
X-Mimecast-MFC-AGG-ID: rn7_e5_QNj6iuCjDH0Qf7A
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315ad4938fso13808405e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 23:27:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732087645; x=1732692445;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3BTJbs566odTWWZcglLtcrZATiEXFnman86/RpjGHWI=;
 b=myQkojRxW/Ddzshdqax+4nI7EzCsMMKUQFN+zKguHXc/LkiIu55SyUDexckkbGZId3
 8OCq/SFOLifss4+z9MqPfqftZTxmN1YRDgtG5FuOLYYxqTu7O1Y2IzhnaTgs0MIJ9H44
 4vAjKtnjBNFF32t70wgsB0FTQRI3AIeV5Tn4m+dT71Fx46LbPqDBxQG3fnzvM5iekpio
 nD3rEAW9FAFWFT/RbRGK5DULPIHMVDNPb5uBqc7NvCdGEb4vcC+aM3XUO8RQrjLGF1r/
 ikUB7YDGT6apb/AaWDDu6oqzBX9G8eNRtmDIa4CTVvnHt3ZiJlQCvrCNEvgPXqOBVsnm
 JREQ==
X-Gm-Message-State: AOJu0Yy6w2gjg+zU4XFBTGLmoMLREjXkHCUs5nDfsIKGggRLfO0DAB2E
 eBH7JoKM9eGfKS7zBYk+pj0L/4ugqw4rzKTkNXrdKfdmdc+bu0j+ssAOQdoEJF1KmAmLJRuyft/
 sDl9VUlQYtbQchE1iZLaQfVDmvkKiQfb5VdN9jSVhP8hS7V4Kr1j463Oe+QV8bH2S9wpKM+8mwo
 9TxAonYvJtdTbEd2Dy8yDl4zhZ2FQ767lYr3Zk
X-Received: by 2002:a05:600c:1912:b0:431:5522:e009 with SMTP id
 5b1f17b1804b1-433489b3d7dmr15200335e9.12.1732087645531; 
 Tue, 19 Nov 2024 23:27:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHevBFMYeACYnwc6vLVdDeR42RAyzTD4ZFBEfGmThyZg+tFZW68dRTc/tzSXG3Jt4XFIhPJTQ==
X-Received: by 2002:a05:600c:1912:b0:431:5522:e009 with SMTP id
 5b1f17b1804b1-433489b3d7dmr15200135e9.12.1732087645183; 
 Tue, 19 Nov 2024 23:27:25 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b4616636sm9071635e9.19.2024.11.19.23.27.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 23:27:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] More changes for QEMU 9.2 rc
Date: Wed, 20 Nov 2024 08:27:18 +0100
Message-ID: <20241120072723.103477-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit e6459afb1ff4d86b361b14f4a2fc43f0d2b4d679:

  Merge tag 'pull-target-arm-20241119' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-11-19 14:23:34 +0000)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to b73d7eff1eedb2399cd594bc872d5db13506d951:

  scsi: fix allocation for s390x loadparm (2024-11-20 01:29:29 +0100)

----------------------------------------------------------------
* target/i386: fix warning on macOS
* target/i386: fix coverity barfing on vmport and smp cache support
* scsi: fix off by one

----------------------------------------------------------------
Kamil Szczęk (1):
      hw/i386/pc: Remove vmport value assertion

Paolo Bonzini (1):
      scsi: fix allocation for s390x loadparm

Pierrick Bouvier (1):
      hvf: remove unused but set variable

Zhao Liu (2):
      hw/core/machine-smp: Initialize caches_bitmap before reading
      hw/core/machine-smp: Fix error message parameter

 hw/core/machine-smp.c      |  3 ++-
 hw/i386/pc.c               |  1 -
 hw/scsi/scsi-disk.c        |  2 +-
 target/i386/hvf/x86_task.c | 10 +++++-----
 4 files changed, 8 insertions(+), 8 deletions(-)
-- 
2.47.0


