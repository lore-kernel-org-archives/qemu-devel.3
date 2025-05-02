Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDF0C3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 09:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAmIV-00013Z-Ie; Fri, 02 May 2025 05:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAmIS-00012y-SO
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:03:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAmIQ-0005PL-Sv
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746176582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/IRAGOm/TB6BHj4C+HObeEmG8st+nADkj/KyPgOtSG4=;
 b=O/1Avyb0BWcTmXiY3Lpbf9HDeXY7q4aadZdwLVTmifO3Y18WlaUeIP0y8tfm2bugJRnLoV
 EO58FNwLrgVxTSsjL0dx/VkJWgNNkJ6ysNTNRI80ayG5c3K2uOcgz1Of2KiXOd+ECqzDJ6
 WTz9Fi7RtuULf615B3CjXZFbBml3Jd4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-7hwvwOojOOqKwmew00lW3A-1; Fri, 02 May 2025 05:03:01 -0400
X-MC-Unique: 7hwvwOojOOqKwmew00lW3A-1
X-Mimecast-MFC-AGG-ID: 7hwvwOojOOqKwmew00lW3A_1746176580
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43e9b0fd00cso7421755e9.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 02:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746176579; x=1746781379;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/IRAGOm/TB6BHj4C+HObeEmG8st+nADkj/KyPgOtSG4=;
 b=iEVUsaVfoPdQI8EFSzgq+6aW1N383N+u3KWV6VPVqPT2msrPizezlAGdz/uEKPKBua
 MNe0qJ/KGwdsOsDrOB16Nv6z8WXXEsDkmZjvgKps+6CH9NS83bl4N1b5/9acXCkk1qfQ
 Q8GTKqN03+a86LKVmHB5q6x5+AJoB3p/pyKB98ZntL4+63PNwehX2P70Wz1p8wmCtoMz
 3Ezh4R7eNADEOcd9IOxVVyjCQcRxW87dxDHpn5PLDGgDdeUm0ObN0l/1yWufj8JYeA+c
 9+shnyoZxXDFnXK0lWsLpLXtCuRar4dwf8kkyZXXOIf+KfQRN/hBfKjko/7Gp11UV9/M
 Irvg==
X-Gm-Message-State: AOJu0YzXdzej7rKHvwxxczD4RiUop0FvL7rcNs18C+GE/FxEIcmuhXK3
 IL7CQqg8k75J6XL3pM+RVem0LlIejarSXf6yAc5M1sNWplSfp3MyGgHVxBzhI4iO4ENa4Pfr4fc
 MSp3xJmAKccEU3TfTDV4kaM02a+DG5ujdbV6w6MzOH9PMiJ2+23Nial+fmyuZQWaSBnkh7++RJd
 IZnAn8+CfmTCiJCdZ03JhMRCE2B9eVbSnmJxLc
X-Gm-Gg: ASbGncsbmAP0lazXZLmJRwmaHDw/550Hr6GWzsdgHIIdmRetAUri6YKrH5NIHItWyyx
 Z0JMnKJmlc6wmrkX5w050sjtwuo7Nf9L04rZZFRg32UYG6phxdi1Pnu3nsRSZ61/zjMw1h4aQau
 p5Br3fRl34aq0TZ3qs9ooaorpDwiW2EoOvq4YdOhdG8OQqBRh3lctXD4zNSbUWZUsB2vYDYIevP
 irs5og/dxtQBzt/SzdyrNa/6v3PeH4orVW0SkjaYCOoTsFS3+OGofbsPoQICZ9GnA4uMaPPyzDj
 PXNjWLdIA9OSkHc=
X-Received: by 2002:a05:600c:1d89:b0:43c:ed33:a500 with SMTP id
 5b1f17b1804b1-441b72dc63amr46267165e9.10.1746176579531; 
 Fri, 02 May 2025 02:02:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKOMiDYb7dlvxr98QkvzOLMCpyckrL8k1NYz7eXCtL0ojlv4qfY9X1R/kOEQ4FY8xqe6oGNQ==
X-Received: by 2002:a05:600c:1d89:b0:43c:ed33:a500 with SMTP id
 5b1f17b1804b1-441b72dc63amr46266805e9.10.1746176579119; 
 Fri, 02 May 2025 02:02:59 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89cc7d9sm38773755e9.7.2025.05.02.02.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 02:02:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com
Subject: [PATCH 0/2] rust: vmstate: improvements to varray handling
Date: Fri,  2 May 2025 11:02:55 +0200
Message-ID: <20250502090257.85969-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
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

Small improvements to vmstate.  The second patch is a simpler replacement
for https://lists.nongnu.org/archive/html/qemu-rust/2025-04/msg00018.html,
and is needed for HPET migration support.

I will include the remaining HPET migration code in the next pull request.
I have done some more experiments on Builder, but vmstate_fields!{} requires
the const_refs_static feature (which should not be a surprise...) and hence
Rust 1.83.0.  I will maintain the patches in my tree though.

Paolo Bonzini (2):
  rust: vmstate: support varray for vmstate_clock!
  rust: assertions: Support index field wrapped in BqlCell

 rust/qemu-api/src/assertions.rs | 25 +++++++++----------------
 rust/qemu-api/src/vmstate.rs    | 13 ++++++++++---
 2 files changed, 19 insertions(+), 19 deletions(-)

-- 
2.49.0


