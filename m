Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6167C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcL9o-0003G5-2S; Tue, 20 Feb 2024 03:07:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcL9l-0003Dq-Rz
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:07:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcL9k-0000UV-GG
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:07:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708416432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cDTEy60SoXRleDwrAWU00Ca7c/Scw+qH/gbVv2mAVbk=;
 b=VSTtuowJ7SQEtTfkuSmnjkLfHKjowLicjWf9YWz/vFZ9s1Ha7v3Gh8a4t/0dtgffhxpG3H
 LnR+BY9lUramrqL+B2VX/HfqdzogZrzrr+fQis457Ics9OBmmgufUhihZ09iIxuIrJdT2x
 Jv7WZ1mblFlcFrlCG6sAcG6khce0HJs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-m-GOe33WM4eh57CbgpRPJg-1; Tue, 20 Feb 2024 03:07:10 -0500
X-MC-Unique: m-GOe33WM4eh57CbgpRPJg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-559555e38b0so3977597a12.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:07:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708416429; x=1709021229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cDTEy60SoXRleDwrAWU00Ca7c/Scw+qH/gbVv2mAVbk=;
 b=o99tnGC4REjXG+Nf2FvtArOYdYoDy3zPexWs1GH/gXijJfw5gw8MxBo8Ta1MWB1cSV
 gH62BJll7pFYMuJWsoaacHmdqQpRhd3tF7I/+Cu7iln4ZrLWCZN/YglArO3TNucHDyTW
 YubdgzO2qQKOslhCuxeSZDDhPeL+2DGrCdFJ+SQyh08BsrKfCT0z8Wno4ywANzMQdUXj
 Ob/fV15+cF4DaZUUOL7ty1vuGIX7ZQ/UmxHc1ggPZxurCIAl3YZ+CjzLVDR48DjMfF30
 b3s0eJq+OjLifuy+x3u060UXRAbUhhm6bV10t4iTNhFElBXf8JPoZa8ujH4WlCxg4WVH
 wTog==
X-Gm-Message-State: AOJu0YyjrrLVI8uWO13FcQgDlECvIDWksbNRExE2zsaQoBhaga1rzPX3
 Svn8H/jCbEouHYlkvqBkjOgHWjCA/ZIbWy44o1Bjgsvx3D+JMdt2iytMwOFs3ri49jvDoNCB4A5
 dR8I+iy43eDRolSBQzhlkkT7rn2rdgodEVqAEuAZ7xvcdEF6l4xjPZfwnUuvlz9vUSV5Vkb16mQ
 LtrQI1gHGELAX82kdHclv142whgQBakV79rNnE
X-Received: by 2002:aa7:cd13:0:b0:564:d702:a17d with SMTP id
 b19-20020aa7cd13000000b00564d702a17dmr145590edw.30.1708416429190; 
 Tue, 20 Feb 2024 00:07:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGP8rOQMfzXxVWWob46EKejnNlkcajUWma2Rf+DU9Kt6tE0PQDz/+XBgQfmZA8W3veSwgr3Eg==
X-Received: by 2002:aa7:cd13:0:b0:564:d702:a17d with SMTP id
 b19-20020aa7cd13000000b00564d702a17dmr145573edw.30.1708416428905; 
 Tue, 20 Feb 2024 00:07:08 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 el14-20020a056402360e00b0055fba4996d9sm3400912edb.71.2024.02.20.00.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:07:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	qemu-stable@nongnu.org
Subject: [PULL 08/17] i386/cpuid: Move leaf 7 to correct group
Date: Tue, 20 Feb 2024 09:05:49 +0100
Message-ID: <20240220080558.365903-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220080558.365903-1-pbonzini@redhat.com>
References: <20240220080558.365903-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

CPUID leaf 7 was grouped together with SGX leaf 0x12 by commit
b9edbadefb9e ("i386: Propagate SGX CPUID sub-leafs to KVM") by mistake.

SGX leaf 0x12 has its specific logic to check if subleaf (starting from 2)
is valid or not by checking the bit 0:3 of corresponding EAX is 1 or
not.

Leaf 7 follows the logic that EAX of subleaf 0 enumerates the maximum
valid subleaf.

Fixes: b9edbadefb9e ("i386: Propagate SGX CPUID sub-leafs to KVM")
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <20240125024016.2521244-4-xiaoyao.li@intel.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 9758c83693e..42970ab046f 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1951,7 +1951,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
                 c = &cpuid_data.entries[cpuid_i++];
             }
             break;
-        case 0x7:
         case 0x12:
             for (j = 0; ; j++) {
                 c->function = i;
@@ -1971,6 +1970,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
                 c = &cpuid_data.entries[cpuid_i++];
             }
             break;
+        case 0x7:
         case 0x14:
         case 0x1d:
         case 0x1e: {
-- 
2.43.0


