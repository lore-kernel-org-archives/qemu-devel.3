Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780AECCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 12:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Ghp-0007r3-NJ; Mon, 13 Oct 2025 07:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8Ghm-0007qu-Sy
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 07:27:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8Ghj-0006E7-I6
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 07:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760354815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dZc+i1/wq00FsSHw4n8X05nrNOsKzzQwHS09WGIGmmo=;
 b=Elf3tu+3uYivTpmpGPALHWwE2intbQcYAwfjpm7VmcRv6RgMzpSy0E8A0UKlT+S4CspESX
 iZ92O0AbFgo0O9wlrn7VAvLYZ7a9nEuNerD96zmHmMp5YJ+Q0DhLCXfpp1AU08ChBqgk+H
 i5rW+6mqMVHwMlf4fDRZXoKEk2cAo+Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-jqzcBhnFMfi9ViGYCx_8qQ-1; Mon, 13 Oct 2025 07:26:54 -0400
X-MC-Unique: jqzcBhnFMfi9ViGYCx_8qQ-1
X-Mimecast-MFC-AGG-ID: jqzcBhnFMfi9ViGYCx_8qQ_1760354813
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b4626b2d07bso461123266b.1
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 04:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760354812; x=1760959612;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dZc+i1/wq00FsSHw4n8X05nrNOsKzzQwHS09WGIGmmo=;
 b=Lox1s+sBpSzNBRpe9OobmHGbP6BAKDPD2Fy8b73WP1xIMXN2O75NH4CsH109Wmu0zP
 +gRNW5oVkNUEev2nDM2jcLk295Hi32fq6C2rRwEp/Wm8DtFdvlv2YnW3WnnZWurbuUne
 BprCTRIc/2PwpQpypCrlno+pUg4vt4RkXcqnGy7x2HXl99FW/v+8KHHGupgD5xCfIzuf
 1QXEb6H3YbdteGCj2AMljwOyVVSul4La0WfxOLxKO+3opYnya964N3zPUlhdE0nSXjbw
 3QyRUIs5ysXK4wQ+LlzGSw0/PtGnyZizhCgCqwfrd+rUltH4Ct9FOISYPbx1gNzUV8Mk
 vGEA==
X-Gm-Message-State: AOJu0Yz82eE3/FLv2M1zZouxOQFa+cb4NTFJjEketmcpwhKGOenmayXN
 0cD4HQ0gRO+evUSKP72DeniPkhOb3ZqS8o+JkqWHQtJJ+/SY+BJRlIHC0IYH4qOMmEv+lVvADAG
 ARugFIRSfW6UdKV8SEMaDt+rm6d9UbCy11dy2SQ9XxQKRYcoiGU1AszsLozsC7dUzb7upQUt1QI
 /cEiC6NrY7tAACA7IzE1B2RrtZZHBz6qxIcN6e8zbZ
X-Gm-Gg: ASbGncuB25+IzymFW39/QQZY23rE4bx84aKb1Gse7tjg11u16eN3D+Qj/rHNvXnVBSB
 lXRYYl6/VUtWipUyocSp7JPYNGqkpe8wezlB9N9O4NTQZxz6pqW0YrqJEa8RptChaqfzltPRWlu
 yOjYkV2OBtLyhFi8EaBfLrccpljcp8R8SINZJpv7gXV0qBuLCVYtO4kN0uFa4SM0wPQQNBbbaOi
 Vq1jyHRmoJck7z8r+bl/l36nkKIUp51QvN9BNJYnjlAi94l1/k8xnbDjd6bLnofz1GJoBfirTfr
 2qgkDqgp9is2w9B8qJdEbhOLS1Z9Slv8KsnzkQOR0Z8BJh/SmAlwOxHX7zEuQRsScMCXvJGJxMp
 rpTszu+pGQSU+wvFPHlxHCjE4SdAFKUvzC2bQiQXDFiM=
X-Received: by 2002:a17:906:4fce:b0:b4f:ffbf:9aeb with SMTP id
 a640c23a62f3a-b50ac6d2768mr2244267866b.46.1760354812432; 
 Mon, 13 Oct 2025 04:26:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgIBgpo8EOuc4cdcssrL1zNFeHz8dZUfvyDotwYxuTyokh5EoZd5IeybTts0WJ6dxOO7wHgw==
X-Received: by 2002:a17:906:4fce:b0:b4f:ffbf:9aeb with SMTP id
 a640c23a62f3a-b50ac6d2768mr2244264966b.46.1760354811917; 
 Mon, 13 Oct 2025 04:26:51 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d8c12a62sm911700966b.58.2025.10.13.04.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 04:26:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Praveen K Paladugu <prapal@microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/2] monitor: generalized query for accelerator availability
Date: Mon, 13 Oct 2025 13:26:48 +0200
Message-ID: <20251013112650.935921-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The recently-introduced query-mshv command is a duplicate of query-kvm,
and neither provides a full view of which accelerators are supported
by a particular binary of QEMU and which is in use.

KVM was the first accelerator added to QEMU, predating QOM and TYPE_ACCEL,
so it got a pass.  But now, instead of adding a badly designed copy, solve
the problem completely for all accelerators with a command that provides
the whole picture:

    >> {"execute": "query-accelerators"}
    << {"return": {"enabled": "tcg", "present": ["kvm", "mshv", "qtest", "tcg", "xen"]}}

Since query-mshv was not in any released version, drop it.  Because the
code looks similar, I am not splitting this into removal of query-mshv
and addition of the new command.

Paolo

Paolo Bonzini (2):
  monitor: clarify "info accel" help message
  monitor: generalize query-mshv/"info mshv" to query-accelerators/"info
    accelerators"

 qapi/accelerator.json      | 47 +++++++++++++++++++++++++++++---------
 include/monitor/hmp.h      |  2 +-
 hw/core/machine-hmp-cmds.c | 21 +++++++++--------
 hw/core/machine-qmp-cmds.c | 20 ++++++++++++----
 hmp-commands-info.hx       | 19 +++++++++------
 5 files changed, 76 insertions(+), 33 deletions(-)

-- 
2.51.0


