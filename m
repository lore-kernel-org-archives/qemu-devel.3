Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81CFC48BF6
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 02:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfsee-000439-Eh; Thu, 29 Feb 2024 21:29:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rfsec-00042Z-JB
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 21:29:42 -0500
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rfseb-0005Rr-5e
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 21:29:42 -0500
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-68f51c5f9baso8402866d6.3
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 18:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1709260180; x=1709864980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yw8iSnc3LXROkWLue6u8GAvL3L94OebgZkCfuGQmnSk=;
 b=DBy2vArY8UWVValpDPzz5bceCW6sMEE35XFTinIZRzSu2Y+91XelzMmelAbBCA1sBn
 aIVagQRF1DPO1yvvsgKIjxuOTeylyPZh8hZrZUALNQVncVTxBb2D5u/mY7wSuwgbxWvW
 0ZgUHxS4m034A+Nb+5xXUKRYmf5C0kHeciCtcR89XDbecGgL9o1cOda5MpURhZLAuFpe
 dG6Bo+O02EuaTen92fpY8yTVVRAZ7SEAiylnuobp08lZTsgRRSIkNJaONpHla4oE1kIv
 8SXOJQD0IhE95B/ntk3c74/SxFqal2XAFtdY1lngHmoXHLan3hiI5J48pG9Ag8IsYdro
 zTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709260180; x=1709864980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yw8iSnc3LXROkWLue6u8GAvL3L94OebgZkCfuGQmnSk=;
 b=h2QgGwhSut1f9+rNw/jX7Tc48wMRDypWjYW99coVbRnThNLsFyb6TZzolQYEDaT9ci
 XBN/zS7IAYjYMzJwVoItSJBiA8+kzWItaVjv9Ec6z0TxsuZeSnH/7m5LCqdkKOgly1+/
 uymwjLHboBjxWshwZ822i1yeNKg3CnC3yQ+WiLvIN6x3KWazPMo1r/tcs9CKYPFf9Jzx
 PUJ9tIIsFk0yaNBucKsCWDFPSHptBjAzeF2BEyU4JB0fNYyHCTRV/YUTaxRdWPoZNV0b
 M3+d6+xI122ZMJk7uIQmlLTIni0cAsFklL91ReJ2wlwFzjXxhHikik68NKCtG+7F5Zaz
 2N4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsMW6ytYF20ST05pzMKr4QmruPDnVQ6uF2PM3zKePGgJVnBuEsY5wskyuvxJfJMpe301FisyIMOLBwu90eX/e5hRxDEN8=
X-Gm-Message-State: AOJu0YzKYfT2FRb0GAKns5PnKt98jJ9cxrjcVpNtEKBdO6r4N7S71Rp2
 U0kUh+36lRbKUptMTol6sAEmzc1ycHx2mMIlm8UJQFOX6lN4Ig0dqEp34oCiwEw=
X-Google-Smtp-Source: AGHT+IEA4Isy3CFGW10rXyr/7totJiQ81C8HldgJQ77k15ev9qC3TRz1lBLy6l6CvGWQF+VUPemdrA==
X-Received: by 2002:a05:6214:180d:b0:690:4e5e:4351 with SMTP id
 o13-20020a056214180d00b006904e5e4351mr418876qvw.41.1709260180123; 
 Thu, 29 Feb 2024 18:29:40 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.120])
 by smtp.gmail.com with ESMTPSA id
 qo13-20020a056214590d00b0068d11cf887bsm1384107qvb.55.2024.02.29.18.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 18:29:39 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v4 7/7] Update maintainer contact for migration multifd zero
 page checking acceleration.
Date: Fri,  1 Mar 2024 02:28:29 +0000
Message-Id: <20240301022829.3390548-8-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240301022829.3390548-1-hao.xiang@bytedance.com>
References: <20240301022829.3390548-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f29;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qv1-xf29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add myself to maintain multifd zero page checking acceleration function.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 65dfdc9677..b547918e4d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3414,6 +3414,11 @@ F: tests/migration/
 F: util/userfaultfd.c
 X: migration/rdma*
 
+Migration multifd zero page checking acceleration
+M: Hao Xiang <hao.xiang@bytedance.com>
+S: Maintained
+F: migration/multifd-zero-page.c
+
 RDMA Migration
 R: Li Zhijian <lizhijian@fujitsu.com>
 R: Peter Xu <peterx@redhat.com>
-- 
2.30.2


