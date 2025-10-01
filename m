Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B45CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rma-0005oq-Tb; Wed, 01 Oct 2025 04:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rmX-0005oT-Qu
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:01:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rm9-00066F-IJ
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759305679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hJgKnO4p5NCBfsiH7X9uVt6uTBPOKNgBfFsL5Wo3g90=;
 b=hXCeRi6iEN+yvvTVeGvMQzo8MH+4hDugtg4Z9WKOLD1jnEqOh/s+uGRjHDGQqtr/Pie3IL
 mtRD5tGipAj/LsWyGJi0XgyNR3Zxd1llKzfYjf9/GhS9KjpQiEs7YtnSJ96DzAqv22Gxru
 cOpmhxlIxi5Srrnq1Pc9oxm5SoMehqo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-1oofMN1gPra4PICQcmBd1A-1; Wed, 01 Oct 2025 04:01:18 -0400
X-MC-Unique: 1oofMN1gPra4PICQcmBd1A-1
X-Mimecast-MFC-AGG-ID: 1oofMN1gPra4PICQcmBd1A_1759305677
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b479e43ad46so16652566b.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 01:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759305676; x=1759910476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hJgKnO4p5NCBfsiH7X9uVt6uTBPOKNgBfFsL5Wo3g90=;
 b=dS6xcRzeTxIuAcFjn1oYKBB+LIQBgDlriqWVRXvmleg54G3NfGouL3tvPnXtc7t/8t
 EbTThtSc85sNQok0eRoWmZ3wnx7IVa2Wd48Wt0F6vKHl8ZkFG4wW78KRJ0aKJ2WCparT
 UBMtmUpkU1b5QvJSgGQ9gYSbtQe1E7eHiSQ9AmoB+Afg0niXsm8M2NVV+Yfn/rqeB97Y
 ShsmV65MLYBdrwzp6UWQrEPk52uPYQ8mqkakc/ERjXNShKfsU7A1lFGjQsEsLBrpzVkG
 NeECK1tkKgfxmI+zcOdnt4QpnB8KX9fVWaTcwsGZIDL3z+GE6UJ/0vSVDl0Lvwh8MJN9
 WV6A==
X-Gm-Message-State: AOJu0YwTPrO4yIXUT/bM56pl9OVHbNjfb2QZTwWVMvmorR4wi1E2J9h8
 OZuMC6UsWLydbQSkyqz16IIIOWcjpYysH4YcOmAsiHxgJuTlkf9gfweA82d5o6F6GZYzvAMcnN6
 0Rbr9s+fokwolIKmVzSpGywIuSS6+BBBrLEocvDEpAKT3f9PokxgHSU2n8mmAxIT/bOOXaHfuo7
 nL15WCgTgSHVccHYmTymeCEHh6sHR7vFRwnp1C0EyK
X-Gm-Gg: ASbGncslQf9eGL11EoFPXVOKRVcxgc0T/WwBtF7G8LupYs5Z5QEraiXF6RSXlsF3oUR
 MLFzgWxoim0T7xgPMh14zH1FGQLpWWx1JBq7kGUJa7PScfUZoJh13SN49RAFD+E+/oqqjf+eB3S
 EZDdXVjsHxFt07G9g8M4S/jR4SOOoDB08geDOnKHGMCHMOwYj1Kin6cbkLxfKfLCJ9KRkfK+zNA
 bxTMUqRMLlWLq4qM3ESSpw4+saN08vwbPbW8iqL5eAZeS+aD+Z2t8xRFJ/xdUkvJsHd1Pb8g/a9
 j3QhL8rFGtr93ziElHDPym0z+s2oMV3DZ0gEtItnfzpkwfl2LTjdiG4aklOeiaSRsHG7rsJAbUV
 +0V1SsMsTcV2KKg7UsFHFHnb0uvSjeQmNlOx+nFMr/E/KlOQlCdU=
X-Received: by 2002:a17:907:6091:b0:b46:11fc:c9c7 with SMTP id
 a640c23a62f3a-b46ea12603bmr300772766b.58.1759305675561; 
 Wed, 01 Oct 2025 01:01:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3DU1jbhWKpbxM8wApBLCZ1fU7nyqCaO0q4aDqdD3DU3dX7hhCOLbTYSlEPqMSQLHorjZEnw==
X-Received: by 2002:a17:907:6091:b0:b46:11fc:c9c7 with SMTP id
 a640c23a62f3a-b46ea12603bmr300763566b.58.1759305674716; 
 Wed, 01 Oct 2025 01:01:14 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3f3b7eb5ffsm560470166b.90.2025.10.01.01.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 01:01:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	armbru@redhat.com,
	marcandre.lureau@redhat.com
Subject: [PATCH 09/14] scripts/qapi: add QAPISchemaIfCond.rsgen()
Date: Wed,  1 Oct 2025 10:00:46 +0200
Message-ID: <20251001080051.1043944-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001075005.1041833-1-pbonzini@redhat.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Generate Rust #[cfg(...)] guards from QAPI 'if' conditions.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20210907121943.3498701-15-marcandre.lureau@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/qapi/common.py | 16 ++++++++++++++++
 scripts/qapi/schema.py |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index d7c8aa3365c..f16b9568bb9 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -199,6 +199,22 @@ def guardend(name: str) -> str:
                  name=c_fname(name).upper())
 
 
+def rsgen_ifcond(ifcond: Optional[Union[str, Dict[str, Any]]]) -> str:
+
+    def cfg(ifcond: Union[str, Dict[str, Any]]) -> str:
+        if isinstance(ifcond, str):
+            return ifcond
+        if isinstance(ifcond, list):
+            return ', '.join([cfg(c) for c in ifcond])
+        oper, operands = next(iter(ifcond.items()))
+        operands = cfg(operands)
+        return f'{oper}({operands})'
+
+    if not ifcond:
+        return ''
+    return '#[cfg(%s)]' % cfg(ifcond)
+
+
 def gen_ifcond(ifcond: Optional[Union[str, Dict[str, Any]]],
                cond_fmt: str, not_fmt: str,
                all_operator: str, any_operator: str) -> str:
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 8d88b40de2e..848a7401251 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -37,6 +37,7 @@
     docgen_ifcond,
     gen_endif,
     gen_if,
+    rsgen_ifcond,
 )
 from .error import QAPIError, QAPISemError, QAPISourceError
 from .expr import check_exprs
@@ -63,6 +64,9 @@ def gen_endif(self) -> str:
     def docgen(self) -> str:
         return docgen_ifcond(self.ifcond)
 
+    def rsgen(self) -> str:
+        return rsgen_ifcond(self.ifcond)
+
     def is_present(self) -> bool:
         return bool(self.ifcond)
 
-- 
2.51.0


