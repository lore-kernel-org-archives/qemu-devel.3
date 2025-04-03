Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38CEC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 09:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Gmx-0006cm-Oj; Thu, 03 Apr 2025 05:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u0Gmu-0006cZ-NO
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 05:23:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u0Gms-0007p0-N5
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 05:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743672178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=H9p4O1rMYuUh7mtR/C12bn5JqYODPsjCuiAV9mktXxY=;
 b=VboWaF7yJ2Gaue/lsJ5VbxG6DRA3G4xqaCfFCifqoikk6P/F5V/ikGHOHVQHkeJVUfU58X
 6hhDuU9bkiFZYotIoluwJh8PUM0KhJrXFq8DGcGM0IX3MJv5hUgOXUu8owQo+HQcp4BOpl
 D1GHkmaNWY7bzB9jfhD8uXYW2R6jho4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-451IY9y7PdGcmDHtyKJS0A-1; Thu, 03 Apr 2025 05:22:55 -0400
X-MC-Unique: 451IY9y7PdGcmDHtyKJS0A-1
X-Mimecast-MFC-AGG-ID: 451IY9y7PdGcmDHtyKJS0A_1743672174
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ac737973d06so24777866b.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 02:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743672173; x=1744276973;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H9p4O1rMYuUh7mtR/C12bn5JqYODPsjCuiAV9mktXxY=;
 b=N62k4q2laq6hMs2oxyaXghvZq2oVE5+GM4eykA7a3TmdcDIHfflOZIpF8nd46mtrEU
 RSNidlHo7Oacbh0nbAv8kfO/DO3f+RG4vfZRBYStkbN8bRVC2fv4NT+1kQ9MiQ6salfG
 6dUQggmdRObD1LUwricy3zOqgh2CfekYTvxFexkYvHQ5ewxXYKC26TVx1ijRpEuLaGdQ
 vwY+98ZKN/NTItARJwgn5Bi9pE2SQQL+YxT2eXIwgGsK2aNyBRGpjty0REN2XBOlcYtP
 zk8FThJ6Y8l6TK1q2OX3yCCr1LtQhT+Cs8pWWHgnGdcgefvP/0GMPMHjXRlHijtEdEm4
 uwLA==
X-Gm-Message-State: AOJu0YwaeykKUyPSGgAloCM07I46s1qYZIyQPglJCqoBhXo3PKGOwYeK
 Bu91L1DQ4h1xn1jVNatN+9Uwe2LJemj7ELs/wvXrfVZru/aR79EaxkVjNHt9GhLlyLc/lQonYA6
 xIDppcOhFwQ0AJxsifzc70+LV/Ng3/DGGBd/zVaOf+2hbeaTujk8cQl7DdjLDmEaX/l66BUELbU
 UVihFViMhLGV1JoTuBH8/8+FL7MZOvCRxCF4ml
X-Gm-Gg: ASbGncu8dWgwlEJKFVDbwifYmNl82/TxLLMYcweV68Bv/R/5SulITBYcQnfk07/gyqs
 jN0jo9wdXzabXdwED7hBgi7+1nkdiVr9/UmpPy5jd1RC0PyhLmLlf25u+eAHHPSYl3SrrqMOZxa
 KOZQyUSgDxG5nofj+wkszl2tq2xzZsPIgS7ayWdbcbcc4N0O5lFvKRfAnLu/SAEFz5vBQY3GuJR
 UdYd6m4Ujaj1uCHv521wUM7tGrcgY0ekjeGytXUk/skSf3X4peIYGBY+XdFyXW6kuAne2YdaG5b
 vUkRX0a+vFlv2WfRjkS+
X-Received: by 2002:a17:906:dc95:b0:ac6:bf3d:bf45 with SMTP id
 a640c23a62f3a-ac7bc1ba8e2mr189716166b.36.1743672173674; 
 Thu, 03 Apr 2025 02:22:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnJO9fs83smOxxm2t1US9q+DaRb/IQTbvI5UuyaSddRSGZBwSDfJ1NowxP3kuBzsXWy/+20A==
X-Received: by 2002:a17:906:dc95:b0:ac6:bf3d:bf45 with SMTP id
 a640c23a62f3a-ac7bc1ba8e2mr189714266b.36.1743672173248; 
 Thu, 03 Apr 2025 02:22:53 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.230.224])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfe5d437sm62549466b.27.2025.04.03.02.22.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 02:22:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for 10.1 0/5] target/i386: TCG changes
Date: Thu,  3 Apr 2025 11:22:46 +0200
Message-ID: <20250403092251.54441-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Small improvements to ADC and SBB code generation, and inching towards
removal of temporaries (other than T0 and T1).

Paolo Bonzini (5):
  target/i386: special case ADC/SBB x,0 and SBB x,x
  target/i386: tcg: remove tmp0 and tmp4 from SHLD/SHRD
  target/i386: tcg: remove subf from SHLD/SHRD expansion
  target/i386: tcg: remove tmp0
  target/i386: tcg: remove some more uses of temporaries

 target/i386/tcg/translate.c | 144 ++++++++++++++++++-----------
 target/i386/tcg/emit.c.inc  | 174 +++++++++++++++++++++++++-----------
 2 files changed, 214 insertions(+), 104 deletions(-)

-- 
2.49.0


